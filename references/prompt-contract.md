# GPT Image 2 电影关键帧提示词契约

## 目标

最终提示词应让模型看到一段具体、可信、尚未完成的事件，并明确画面为何具有这种构图、光线、材质与运动。字段是决策检查表，不要求向用户展示 JSON。

## 十一个必解决的决策

1. **`story_beat`**：当前镜头在故事中的作用；正在发生而尚未完成的动作。
2. **`subject_invariant`**：人数、身份差异、脸型、可见年龄、体型、发型、服装层次、道具和视线目标。
3. **`environment`**：地点、时代、时间、天气、空间用途与使用痕迹。
4. **`composition`**：画幅、景别、机位、主体位置、前中后景、遮挡和镜头运动留白。
5. **`information_hierarchy`**：第一眼清晰主体、第二眼支持层、无需继续解释但承担任务的安静场；分别规定清晰度、对比度和细节密度。
6. **`lighting`**：光源、方向、软硬、色温、实景灯、空气介质与黑位可读性；强欠曝或过曝还要说明允许消失和必须保留的信息。
7. **`color_material`**：主辅色、肤色策略、材质、磨损、湿度与表面状态。
8. **`motion_affordance`**：下一秒会动的两到三个层级，以及方向和幅度。
9. **`continuity_lock`**：下一镜或编辑中必须复述的身份、服装、道具、场景、光线和色彩事实。
10. **`avoid`**：当前场景最可能发生的模型错误；只保留有证据的风险。
11. **`output_variant`**：横版、竖版、近景、环境建立镜头或其他镜头功能。

## 默认值

| 缺失信息 | 默认处理 |
|---|---|
| 画幅 | 先服从明确发布硬规格；否则按运动轴、主体横纵分布、空间尺度和派生裁切需求自动选择 `1:1`、竖幅、平衡横幅或宽幅，并写出一句理由 |
| 时代 | 当代；不要擅自添加复古物件 |
| 主体数量 | 使用完成事件所需的最少人数，并明确 `exactly N` |
| 文本 | 非叙事必需的票据、招牌、书页和标签改为无字、背面或移出焦点 |
| 摄影风格 | 叙事电影静帧或观察式纪实；不引用作品与作者 |
| 运动层 | 一个主体动作 + 一个环境小运动；必要时再加一个镜头可运动空间 |
| 版本数量 | 一个主版本；只有镜头功能或画幅不同才增加变体 |

## 正面定义优先

否定词不能替代物件设计。把易触发联想的词换成可见替代物：

| 风险写法 | 正面定义 |
|---|---|
| `medical satchel, no logos` | `a plain weathered indigo-and-khaki woven medicine pouch with a blank flap, no emblem or writing` |
| `plain work jacket, no logos` | `a plain slate work jacket with uninterrupted solid-color blank sleeves and chest pockets, no patches, badges, embroidery or writing`; series/edits must repeat this blank-surface fact in `continuity_lock` |
| `ticket, unreadable text` | 删除票据，或写 `a blank folded paper turned fully away from camera` |
| `young woman, age 30` | 写皮肤、皱纹、发色、体态和疲态的可见范围 |
| `dynamic leap` | 写起跳支撑、运动方向、腾空阶段、目标接触点与重心 |
| `vintage memory` | 写轻微倾斜、迟到构图、局部裁切、柔软解析、轻微过曝或偶发失焦 |

## 生产提示词顺序

按下面顺序输出；没有必要的字段可以并入相邻段落，但不能省略相关决策：

```text
Use case: [photorealistic-natural / historical-scene / stylized but physically grounded]
Asset type: [cinematic still or image-to-video keyframe, aspect ratio]
Primary request: [story beat and unfinished action]
Scene/backdrop: [environment and lived-in evidence]
Subject(s): [count, visible identity and continuity facts, eyeline]
Style/medium: [observable image character, not named imitation]
Composition/framing: [shot scale, camera position, depth layers, movement space]
Information hierarchy: [one primary readable subject, one supporting layer, one quiet field; assign different detail and contrast]
Lighting/mood: [motivated sources, direction, softness, temperature, emotional effect]
Color palette: [dominant/supporting colors and skin-tone protection]
Materials/textures: [tactile evidence]
Motion affordance visible in the still: [2-3 layers, direction and amplitude]
Continuity lock: [include for series or edits]
Constraints: [counts, physics, positive replacements, scene-specific avoid items]
```

摄影机、镜头和胶片术语只用于传达视角、景深、颗粒、色散或高光特征，不能承诺物理上精确模拟某台机器。

## 信息层级与曝光检查

提示词完成后，用下面四问做一次删减：

1. 第一眼主体是否能仅凭轮廓、位置或明暗被识别？
2. 支持层是否只补充关系，而不是与主体争夺同等细节和对比？
3. 安静场是否承担尺度、等待、压力、视线方向或下一拍留白中的至少一项？
4. 如果使用强剪影、深黑、白场、雾或反射，是否写清物理来源、影响范围、允许丢失的信息与仍需保留的轮廓？

任何一问无法回答，就删掉一个装饰光效、第二色彩焦点、无任务道具或平均铺满的背景纹理。

## 高速动作补充槽位

高速动作必须补齐：

- **起点**：谁或什么接触哪个支撑面。
- **方向**：主体在画面坐标中的运动方向。
- **阶段**：起跳、完全腾空、即将接触或已经落地，只选一个。
- **落点**：下一接触点及允许接触的肢体/部件。
- **受力**：重心、身体朝向、衣料或毛发滞后方向。
- **刚性层**：建筑、车辆、钢桩等不能随主体弯曲或漂移的物体。

高速动作若要交给图生视频，还要补齐“构图留桩”契约：

- **留画锚点**：当前支撑与目标落点从起始帧到真实接触都持续可见；不能只写运动方向而让落点中途出画。
- **镜头护栏**：指定固定焦段、固定景别与允许的摇移/横移幅度；跟拍不得推近、变焦或裁掉支撑关系。
- **时间窗**：定义接触时限，并在接触后安排一段稳定保持时间，让落地、承重和重心恢复可被验证。

## 连续镜头契约

第一镜建立一份简短的 `continuity_lock`。后续每镜逐字复述下列事实，再写唯一计划变化：

```text
Preserve: same character identity and visible age; same hairstyle; same layered wardrobe and wear; same prop shape, material and color; same room geometry; same key-light direction and color structure.
Change only: [shot scale / camera position / one next action beat].
```

如果使用上一张图做编辑，应明确引用该图；不要只依赖文字重生成来验证身份连续性。

## 多角色组图契约

多人神话、群像或角色图鉴先把“完整覆盖”和“单帧可读”拆开：

- **总角色数**：列出全组必须出现的角色清单，完片后逐一核对，不用背景人影补数。
- **单帧人数**：为每镜写 `exactly N people`；移动端电影组图通常先尝试每帧 `1-3` 人，再按关系密度决定是否增加。
- **角色分组**：每帧只安排一个可读关系或共同动作；为每人指定一个结构清楚、互不重复的身份道具。
- **连续性类型**：相邻画面若换了一组人物，只引用世界连续性（天气、地貌、光向、色彩、材质和摄影机语言），并明确不复用上一帧人物；同一人物跨镜才引用身份连续性（脸、体型、服装和道具）。
- **统计验收**：分别记录“全组去重角色数”和“逐帧实际人数”，避免复制、漏人、角色串帧或法器错配。

参考图提示可写：`Use the previous image only as a world, weather, lighting, palette and camera reference. Do not reuse or resemble either previous person.`

## 一个完整示例

输入：`洪水后的旧图书馆，一位退休管理员晒泡水的书页，清晨，真实又诗意，横屏。`

输出：

```text
Use case: photorealistic-natural
Asset type: cinematic image-to-video poetic keyframe, 16:9 landscape
Primary request: at dawn after a flood, one retired Chinese county librarian carefully clips a single water-damaged blank page to cotton lines stretched across the reading room; the quiet unfinished labor carries the emotion
Scene/backdrop: an old small-town library with ankle-deep clear floodwater, swollen wooden tables, a visible flood line on peeling plaster, shelves receding into dimness, and one open side door revealing pale mist
Subject: exactly one elderly Chinese man in a faded blue work jacket and rolled trousers, seen in three-quarter profile; silver at the temples, weathered but not frail face, calm concentration, both hands coherently holding one page and one clip, looking at the page rather than camera
Style/medium: photorealistic narrative film still, restrained poetic realism, subtle natural grain and gentle highlight bloom; physically real, never fantasy concept art
Composition/framing: wide eye-level frame from behind a soft foreground shelf edge; man on the left third, page lines forming layered diagonals through the middle, open door on the far right; clear depth and space for a slow lateral camera move
Information hierarchy: the librarian, his hands, the page and clip are the primary readable unit; the nearest two or three page lines form a softer supporting layer; the dim shelf wall and misty doorway remain a low-detail quiet field carrying distance and recovery
Lighting/mood: cool diffuse dawn light from the door and high windows, one weak warm desk lamp deep in frame, humid air revealing soft beams, readable shadows; quiet grief and patient recovery
Color palette: washed paper white, faded indigo, water grey, damp wood brown, one restrained amber practical; natural protected skin tone
Materials/textures: curled fibrous wet paper, cotton line, oxidized clips, peeling plaster, swollen wood grain, shallow reflective water, realistic skin and cloth
Motion affordance visible in the still: only the nearest two or three pages can sway gently; one droplet falls to create a small ripple; pale mist drifts through the door; all other pages and shelves remain stable
Constraints: coherent hands and clip; pages blank or turned away; no readable text, logos or watermark; no floating books, glowing pages, decorative particles, perfect symmetry, plastic skin, duplicated page patterns or glossy advertising polish
```
