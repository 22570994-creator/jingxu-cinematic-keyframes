# 静帧提示词契约

## 六项决策

1. **事件与主体**：谁在做什么或处于何种关系；准确人数、可见身份特征、关键物件。安静观察也成立，不强制安排动作。
2. **场景事实**：地点、必要时代信息、前后空间关系。只补影响画面的事实。
3. **构图与层级**：景别、观察位置、主体位置；第一眼信息、支持信息、安静区域。画幅服从用户要求或空间关系，不靠裁切牺牲主体。
4. **光线与材质**：光从哪里来、作用在哪；选择少量与场景有关的触感和使用痕迹。
5. **保持与避免**：用户不可变项，以及当前画面确有风险的避错项。
6. **输出规格**：画幅、提示词语言；有准确文字或指定模型时才补充对应约束。

不要求固定字段逐项展示；可自然合并，删掉对当前画面无贡献的形容词。

## 正面定义优先

- 年龄除数字外补可见面部、手部或姿态特征，不把刻板印象当身份。
- 道具写清形状、材质、用途和接触关系，而不是堆“不要”。
- 若有符号污染风险，把衣袖、胸袋等表面写为素色连续布面、无贴片；纸张可背面朝向观众。并非每个场景都需要这些限制。
- 有准确文字时保留排版空间，按工具能力安排独立文字编辑，并逐字核对。
- 将风格参考拆为可观察的构图、色彩、照明、材质，不依靠创作者名字代替描述。
- 不把低饱和、雾、胶片颗粒、浅景深或黑边本身当作叙事质量证据。极端曝光需要说明光源、允许丢失的细节及必须保留的轮廓。

## 可复制骨架

```text
[Scene and one readable event or relationship].
Exactly [N] people: [visible features, placement, gesture and relevant props].
[Framing, viewpoint and spatial relationships]; [first-read subject, supporting detail, quiet area].
[Motivated light source and its effect]; [relevant material and wear].
Preserve [user-required facts]. Avoid [specific likely failures].
Aspect ratio: [ratio].
```

人数不适用时删掉人物句；不把骨架空字段原样交付。生成工具参数与自然语言提示词分开，不虚构参数支持。
