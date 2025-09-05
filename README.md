# 🍌 Nanobanana - Gemini API 代理 & 多模态 Web UI

[English](./README.en.md)

# 注意 目前免费的 nanobanana 已经从openrouter 下架了！，没有免费了，只能部署付费的！！！！
一个功能强大的双用途服务：既是一个**兼容 Google Gemini API 的 OpenRouter 代理服务器**，又提供了一个直观的 **Web 用户界面**，让您可以轻松地与多模态模型进行交互，实现文生图、图生文等功能。

---

### 🎥 快速演示

[![抖音介绍视频](https://img.shields.io/badge/观看抖音视频-点击跳转-161823?style=for-the-badge&logo=douyin)](https://www.douyin.com/video/7545761080266460456)

点击上方徽章，观看项目功能的实际操作演示。

---

## ✨ 核心功能

### 🚀 API 代理 (为开发者)

*   **Gemini API 兼容**: 提供与 Google AI JS SDK (`@google/generative-ai`) 完全兼容的 API 端点。您可以将现有的 Gemini 客户端代码无缝对接到本服务，通过 OpenRouter 使用该模型。
*   **流式与非流式**: 完整实现了 `:streamGenerateContent` (流式) 和 `:generateContent` (非流式) 两个核心端点。
*   **智能上下文提取**: 自动从 Gemini 的完整对话历史 (`contents`) 中提取最近的、相关的上下文发送给模型，优化请求效率。
*   **统一认证**: 支持通过 `Authorization: Bearer <API_KEY>` 或 `x-goog-api-key` header 传递 OpenRouter API Key。

### 🎨 Web UI (为用户)

*   **多图上传**: 支持拖拽或点击上传一张或多张图片，并实时显示缩略图。
*   **直观交互**: 结合上传的图片和文本提示词，与 AI 进行对话或创作。
*   **智能 API Key 处理**:
    *   如果在部署时设置了环境变量 `OPENROUTER_API_KEY`，前端将自动隐藏输入框，提供清爽的用户体验。
    *   如果未设置环境变量，则会显示输入框，方便用户临时输入。
*   **即时结果展示**: 在界面右侧直接显示模型生成的文本或图片结果。

---

## 🚀 部署到 Deno Deploy

**手动步骤:**

1.  **Fork 本项目**: 将此项目 Fork 到您自己的 GitHub 仓库。
2.  **登录 Deno Deploy**: 使用您的 GitHub 账号登录 [Deno Deploy](https://dash.deno.com/projects)。
3.  **创建新项目**:
    *   点击 "New Project"。
    *   选择您刚刚 Fork 的 GitHub 仓库。
    *   选择 `main` 分支和 `main.ts` 作为入口文件。
4.  **(可选，但推荐) 添加环境变量**:
    *   在项目的 "Settings" -> "Environment Variables" 中，添加一个名为 `OPENROUTER_API_KEY` 的变量。
    *   值为您自己的 OpenRouter API 密钥。这样做可以免去在前端重复输入密钥的麻烦。
5.  **部署**: 点击 "Link" 或 "Deploy" 按钮，Deno Deploy 将会自动部署您的应用。

---

## 🛠️ 如何使用

### 方式一：使用 Web 界面

1.  打开您部署后的 `*.deno.dev` URL。
2.  如果部署时**没有**设置环境变量，请在 "设置" 区域的输入框中填入您的 OpenRouter API Key。
3.  上传一张或多张图片。
4.  在文本框中输入您的提示词（例如：“让这只猫看起来像个宇航员”）。
5.  点击 "生成" 按钮，在右侧查看结果。

### 方式二：作为 API 代理 (开发者)

将您现有的 Gemini 客户端代码中的 API 基地址指向您部署的 Deno Deploy URL 即可。

**cURL 示例**:
假设您的部署 URL 是 `https://nanobanana.deno.dev`。

```bash
curl -X POST https://nanobanana.deno.dev/v1beta/models/gemini-pro:generateContent \
-H "Content-Type: application/json" \
-H "Authorization: Bearer YOUR_OPENROUTER_API_KEY" \
-d '{
  "contents": [
    {
      "role": "user",
      "parts": [
        { "text": "这张图里有什么？" },
        {
          "inlineData": {
            "mimeType": "image/jpeg",
            "data": "YOUR_BASE64_ENCODED_IMAGE"
          }
        }
      ]
    }
  ]
}'
```

---

## 📡 API 端点

| 端点                                               | 方法   | 用途                               | 备注                                         |
| -------------------------------------------------- | ------ | ---------------------------------- | -------------------------------------------- |
| `/v1beta/models/gemini-pro:streamGenerateContent`  | `POST` | 流式生成内容 (兼容 Gemini SDK)     | 响应为 Server-Sent Events (SSE) 数据流。     |
| `/v1beta/models/gemini-pro:generateContent`        | `POST` | 非流式生成内容 (兼容 Gemini SDK)   | 响应为标准 JSON 对象。                       |
| `/generate`                                        | `POST` | 为 Nanobanana Web UI 提供后端服务。 | 内部使用。                                   |
| `/api/key-status`                                  | `GET`  | 检查环境变量中是否设置了 API Key。 | 供 Web UI 判断是否显示输入框。               |

---

## 💻 技术栈

-   **前端**: HTML, CSS, JavaScript (原生，无框架)
-   **后端**: Deno, Deno Standard Library
-   **AI 模型**: 通过 [OpenRouter](https://openrouter.ai/) 代理, 默认为 `google/gemini-2.5-flash-image-preview`

---

## 📜 许可证

本项目采用 [MIT License](LICENSE) 开源。
