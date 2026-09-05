$ErrorActionPreference = 'Stop'

$skillRoot = Split-Path -Parent $PSScriptRoot
$skillPath = Join-Path $skillRoot 'SKILL.md'
$agentPath = Join-Path $skillRoot 'agents\openai.yaml'
$readmePath = Join-Path $skillRoot 'README.md'
$productPath = Join-Path $skillRoot 'PRODUCT.md'
$goToMarketPath = Join-Path $skillRoot 'GO-TO-MARKET.md'
$workflowPath = Join-Path $skillRoot 'references\xiaohongshu-workflows.md'
$rubricPath = Join-Path $skillRoot 'references\xiaohongshu-testing-rubric.md'
$promptContractPath = Join-Path $skillRoot 'references\prompt-contract.md'
$casesPath = Join-Path $skillRoot 'xhs-test-prompts.json'

$failures = [System.Collections.Generic.List[string]]::new()

function Require-File([string]$path, [string]$label) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $failures.Add("missing file: $label")
        return $false
    }
    return $true
}

function Require-Match([string]$content, [string]$pattern, [string]$label) {
    if ($content -notmatch $pattern) {
        $failures.Add("missing contract: $label")
    }
}

function Require-NoMatch([string]$content, [string]$pattern, [string]$label) {
    if ($content -match $pattern) {
        $failures.Add("forbidden legacy value: $label")
    }
}

if (Require-File $skillPath 'SKILL.md') {
    $skill = Get-Content -LiteralPath $skillPath -Raw -Encoding UTF8
    Require-Match $skill '(?m)^name:\s+jingxu-cinematic-keyframes\s*$' 'canonical technical ID'
    Require-Match $skill '# 镜叙｜电影关键帧导演' 'canonical full display name'
    Require-Match $skill '镜叙' 'public brand name'
    Require-Match $skill 'AI 图像与视频创作者' 'AI creator target user'
    Require-Match $skill '3:4' '3:4 image-note routing'
    Require-Match $skill '9:16' '9:16 video-note routing'
    Require-Match $skill '自动选择画幅' 'content-led automatic aspect-ratio selection'
    Require-Match $skill '运动轴|人物关系|空间尺度' 'aspect-ratio decision evidence'
    Require-Match $skill '角色分组契约' 'multi-character cast partition contract'
    Require-Match $skill '首图' 'feed-cover hook behavior'
    Require-Match $skill '安全裁切' 'feed crop safety'
    Require-Match $skill 'testing-rubric\.md' 'general cinematic rubric routing'
}

if (Require-File $agentPath 'agents/openai.yaml') {
    $agent = Get-Content -LiteralPath $agentPath -Raw -Encoding UTF8
    Require-Match $agent 'display_name:\s*"镜叙｜电影关键帧导演"' 'canonical display name'
    Require-Match $agent 'short_description:.*AI 图像与视频创作者' 'AI creator UI description'
    Require-Match $agent 'default_prompt:.*\$jingxu-cinematic-keyframes.*画面构想' 'usable default invocation'
}

if (Require-File $readmePath 'README.md') {
    $readme = Get-Content -LiteralPath $readmePath -Raw -Encoding UTF8
    Require-Match $readme '当前版本：`v1\.2\.2`' 'README version 1.2.2'
    Require-Match $readme '%USERPROFILE%\\\.codex\\skills\\jingxu-cinematic-keyframes' 'canonical install folder'
    Require-Match $readme '\$jingxu-cinematic-keyframes' 'canonical README invocation'
}

if (Require-File $productPath 'PRODUCT.md') {
    $product = Get-Content -LiteralPath $productPath -Raw -Encoding UTF8
    Require-Match $product '镜叙' 'brand in product guide'
    Require-Match $product 'GO-TO-MARKET\.md' 'commercialization route from product guide'
    Require-Match $product '完整名：`镜叙｜电影关键帧导演`' 'canonical packaged display name'
    Require-Match $product '技术 ID：`jingxu-cinematic-keyframes`' 'canonical packaged technical ID'
    Require-Match $product '当前产品版本：`1\.2\.2`' 'product version 1.2.2'
}

if (Require-File $goToMarketPath 'GO-TO-MARKET.md') {
    $goToMarket = Get-Content -LiteralPath $goToMarketPath -Raw -Encoding UTF8
    Require-Match $goToMarket 'Lite' 'free or trial acquisition tier'
    Require-Match $goToMarket 'Pro' 'paid creator tier'
    Require-Match $goToMarket 'Studio' 'service tier'
    Require-Match $goToMarket '价格假设' 'pricing is framed as a hypothesis'
    Require-Match $goToMarket '激活' 'activation metric'
    Require-Match $goToMarket '不证明' 'evidence boundary for market claims'
}

Require-File $workflowPath 'references/xiaohongshu-workflows.md' | Out-Null
Require-File $rubricPath 'references/xiaohongshu-testing-rubric.md' | Out-Null
Require-File $promptContractPath 'references/prompt-contract.md' | Out-Null

if (Test-Path -LiteralPath $promptContractPath -PathType Leaf) {
    $promptContract = Get-Content -LiteralPath $promptContractPath -Raw -Encoding UTF8
    Require-Match $promptContract '总角色数' 'series-level cast count'
    Require-Match $promptContract '单帧人数' 'frame-level cast count'
    Require-Match $promptContract '世界连续性' 'world-only continuity'
    Require-Match $promptContract '身份连续性' 'identity continuity separation'
}

if (Test-Path -LiteralPath $workflowPath -PathType Leaf) {
    $workflow = Get-Content -LiteralPath $workflowPath -Raw -Encoding UTF8
    Require-Match $workflow '自动画幅决策' 'automatic aspect-ratio workflow'
    Require-Match $workflow '横向运动|横向关系' 'landscape selection criterion'
    Require-Match $workflow '纵向运动|纵向空间' 'portrait selection criterion'
    Require-Match $workflow '方形|1:1' 'square selection criterion'
    if ($workflow -match '图文首图默认\s*`3:4`') {
        $failures.Add('fixed 3:4 image-note default must be replaced by content-led selection')
    }
    if ($workflow -match '视频源帧采用\s*`9:16`时') {
        $failures.Add('fixed 9:16 source-frame assumption must become conditional')
    }
}

if (Require-File $casesPath 'xhs-test-prompts.json') {
    try {
        $suite = Get-Content -LiteralPath $casesPath -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($suite.skill -ne 'jingxu-cinematic-keyframes') { $failures.Add('test suite must use the canonical technical ID') }
        if ($suite.version -notmatch '^1\.2\.2') { $failures.Add('test suite version must be 1.2.2') }
        if ($suite.test_cases.Count -lt 8) { $failures.Add('Xiaohongshu suite requires at least 8 cases') }
        $requiredTypes = @('cover', 'video_keyframe', 'carousel_continuity', 'aspect_routing', 'diagnosis', 'should_not_trigger')
        foreach ($type in $requiredTypes) {
            if ($type -notin $suite.test_cases.type) { $failures.Add("missing test type: $type") }
        }
    }
    catch {
        $failures.Add("invalid xhs-test-prompts.json: $($_.Exception.Message)")
    }
}

$currentBrandingPaths = @(
    $skillPath,
    $agentPath,
    $readmePath,
    $productPath,
    $promptContractPath,
    (Join-Path $skillRoot 'references\testing-rubric.md'),
    $workflowPath,
    $casesPath
)
foreach ($path in $currentBrandingPaths) {
    if (Test-Path -LiteralPath $path -PathType Leaf) {
        $content = Get-Content -LiteralPath $path -Raw -Encoding UTF8
        Require-NoMatch $content 'GPT Image 2|gpt-image-2-cinematic-keyframes' $path
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Host "FAIL: $_" }
    throw "Xiaohongshu productization contract failed with $($failures.Count) issue(s)."
}

Write-Host 'PASS: Xiaohongshu productization contract satisfied.'
