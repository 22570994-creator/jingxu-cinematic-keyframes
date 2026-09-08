---
name: jingxu-cinematic-keyframes
description: Use when creating cinematic still images, covers, coherent image series, or diagnosing and repairing generated cinematic images.
---

# 镜叙｜电影关键帧导演

把画面想法落实为叙事清晰、空间可信的电影静帧。范围仅限静帧、连续组图和图片诊断修复。

## 按需读取

- 新建静帧或编写提示词：读 [提示词契约](references/prompt-contract.md)。
- 同角色组图或同世界不同人物：再读 [组图连续性](references/continuity.md)；单张不加载。
- 选择审美方向：读 [审美模式](references/aesthetic-patterns.md)。
- “更高级、更电影感”、画面过满或像广告：读 [信息层级](references/perceptual-hierarchy.md)。
- 评估现有图或要求修改：读 [诊断与修复](references/diagnosis-and-repair.md)。
- 实际图片验收：读 [验收量表](references/testing-rubric.md)。
- 用户指定其他模型或要求转译：读 [模型适配](references/model-adapters.md)。
- 需要完整写法示例时才读 [静帧示例](examples/cinematic-still.md)。

不要一次性加载所有参考文件。

## 执行

1. 区分写提示词、生成、诊断、编辑；仅诊断不生成，仅提示词不调用生成工具。
2. 提取一个事件或人物关系，明确人数、必要场景事实和必须保留项。低风险缺省作最小假设；只有关键身份、时代等缺失会改变结果时才提问。
3. 优先服从用户画幅；否则按人物关系和空间尺度选择并简述理由，不机械套竖图。单张不强加组图锁、动作层或额外版本。
4. 按对应参考生成一个可用结果。默认中文解释、英文生产提示词；用户指定语言时服从用户。
5. 请求生成或编辑时使用可用图像工具并遵守其权限和费用规则。看不到结果就不宣称验收通过；失败时按诊断参考区分局部编辑与结构重建。

## 默认交付

用最短必要内容给出画面决策、一个完整提示词和关键检查点。组图逐帧列明差异；诊断给出可见证据、最高影响问题与修复建议。不要附加用户未请求的发布包装或批量变体。

具体规则以各参考文件为唯一主定义，入口不重复展开。
