# 组图连续性

仅在多张图需要关联时使用。先区分：

- **身份连续**：同一人物反复出现；保留参考图中的脸、可见年龄、发型、服装层次和关键道具。
- **世界连续**：同场景或同系列的新人物；只继承时代、空间、光向、色彩和材质，不继承上一张脸或个人道具。

## 最小契约

记录全组独立角色总数、每帧准确人数、每人识别锚点及允许出现的帧；避免把“六个不同人物分三张”误解成每张六人或重复两人。
锁定共同画幅、空间布局、时间和主光方向。逐帧写明有意改变的内容；不要把计划内变化列为不变量。

```text
Shared world: [location, era, spatial layout, light direction, palette].
Cast map: [unique identities and their frame assignments].
Frame [N]: exactly [count] people, [identities], [event and composition].
Reference scope: [identity + world / world only].
Keep [relevant anchors]. Change [planned frame differences].
```

若工具支持参考图，明确每张参考的用途。世界参考需注明不复用原人物身份；身份参考需标明对应人物。无参考图只能约束文字锚点，不保证脸部一致。

验收逐帧人数、跨帧身份和全组覆盖分别检查。不能因色调相近就宣称人物连续性通过。
