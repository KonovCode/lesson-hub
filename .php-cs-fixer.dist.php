<?php

$finder = (new PhpCsFixer\Finder())
    ->in(__DIR__)
    ->exclude('var')
    ->exclude('vendor')
    ->exclude('docker')
    ->exclude('public/bundles')
    ->notPath('src/Kernel.php');

return (new PhpCsFixer\Config())
    ->setRules([
        '@Symfony' => true,
        '@Symfony:risky' => true,
        '@PSR12' => true,
        'array_syntax' => ['syntax' => 'short'],
        'ordered_imports' => [
            'sort_algorithm' => 'alpha',
            'imports_order' => ['class', 'function', 'const'],
        ],
        'declare_strict_types' => true,
        'native_function_invocation' => [
            'include' => ['@compiler_optimized'],
            'scope' => 'namespaced',
            'strict' => true,
        ],
        'no_unused_imports' => true,
        'single_line_throw' => false,
        'phpdoc_align' => ['align' => 'left'],
        'phpdoc_separation' => false,
        'phpdoc_to_comment' => false,
        'concat_space' => ['spacing' => 'one'],
        'yoda_style' => false,
        'increment_style' => ['style' => 'post'],
        'class_attributes_separation' => [
            'elements' => [
                'method' => 'one',
                'property' => 'one',
            ],
        ],
    ])
    ->setRiskyAllowed(true)
    ->setFinder($finder);
