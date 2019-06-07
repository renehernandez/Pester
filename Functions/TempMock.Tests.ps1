Describe 'RemoveParameterValidation' {
    BeforeAll {
        $testCases = @(
            @{ Name = 'parameter ReferenceObject is null'; Block = { Test-Validation -ReferenceObject $null } }
            @{ Name = 'parameter ReferenceObject is an empty array'; Block = { Test-Validation -ReferenceObject @() } }
            @{ Name = 'parameter ReferenceObject is empty string'; Block = { Test-Validation -ReferenceObject '' } }
            @{ Name = 'receiving $null from pipeline'; Block = { $null | Test-Validation } }
            @{ Name = 'receiving empty array from pipeline'; Block = { @(@()) | Test-Validation } }
            @{ Name = 'receiving empty string from pipeline'; Block = { '' | Test-Validation } }
        )
    }

    Context 'ValidateNotNullOrEmpty' {
        Context 'Mandatory parameter' {
            BeforeAll {
                function Test-Validation {
                    param(
                        [Parameter(Mandatory, ValueFromPipeline)]
                        [ValidateNotNullOrEmpty()]
                        [object[]]
                        $ReferenceObject
                    )
                    $Count
                }
            }

            It 'does not throw when <Name>' -TestCases $testCases {
                param($Block)
                Mock Test-Validation -RemoveParameterValidation ReferenceObject { }

                $Block | Should -Not -Throw
            }
        }

        Context 'Non-Mandatory parameter' {
            BeforeAll {
                function Test-Validation {
                    param(
                        [Parameter(ValueFromPipeline)]
                        [ValidateNotNullOrEmpty()]
                        [object[]]
                        $ReferenceObject
                    )
                    $Count
                }
            }

            It 'does not throw when <Name>' -TestCases $testCases {
                param($Block)
                Mock Test-Validation -RemoveParameterValidation ReferenceObject { }

                $Block | Should -Not -Throw
            }
        }
    }

    Context 'ValidateNotNull' {
        Context 'Mandatory parameter' {
            BeforeAll {
                function Test-Validation {
                    param(
                        [Parameter(Mandatory, ValueFromPipeline)]
                        [ValidateNotNull()]
                        [object[]]
                        $ReferenceObject
                    )
                    $Count
                }
            }

            It 'does not throw when <Name>' -TestCases $testCases {
                param($Block)
                Mock Test-Validation -RemoveParameterValidation ReferenceObject { }

                $Block | Should -Not -Throw
            }
        }
    }
}
