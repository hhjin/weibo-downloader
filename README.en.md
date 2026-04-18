**[English](README.en.md) | [中文](README.md)**
---------

Use Playwright to automatically download Weibo favorites, personal or other bloggers' Weibo content, saved in Markdown format.

---

## Features

- Support downloading Weibo favorites, personal weibo, other users' weibo
- Images (supports 9-grid layout, multiple sizes: 360px, 480px, 690px, 2000px, original large)
- Videos (optional download, highest quality by default)
- Long articles (optional download)
- Weibo's new markdown-formatted long articles
- **Markdown Bidirectional Links** - Add "Previous" and "Next" navigation links in saved Markdown files for easy browsing

Please use this skill correctly for Weibo favorites, personal data backup, or following bloggers' content backup. Do not use for large-scale commercial data collection.

## Prerequisites

1. **Python Environment**: Requires Python 3.8+
2. **Install Dependencies**:
   ```bash
   pip install playwright
   playwright install chromium
   ```

## Run via Agent Skill

- Auto install Skill (recommended)
  npx skills add https://www.modelscope.cn/skills/hhjinhh/weibo-data-backup
- Manual install Skill
  Clone the project to local, copy weibo-data-backup directory to agent skills directory, such as .opencode/skills or .claude/skills/

## Run Script Manually

### First Use (download 10 records, 360px images, no video, quick preview)

1. Run the script, it will automatically open the browser
2. Complete Weibo login within 60 seconds and navigate to the page to download (favorites page/personal profile/other profile)
3. Wait for automatic download to start

```bash
python weibo_favorites_4skill.py
```

Note: Without output-dir parameter, it defaults to output directory under the python script directory.

### Daily Use (recommended config, recommended for users' daily use, headless mode, download 600 records including HD images, videos, long articles, skip existing records)

After first use, subsequent runs don't need to login to Weibo, it reads login status from cookies.json file generated during first run.

```bash
python weibo_favorites_4skill.py \
  --image-size large \
  --download-video \
  --download-article \
  --max-download 600 \
  --skip-existing \
  --headless
```

### Specify Output Directory

```bash
python weibo_favorites_4skill.py \
  --output-dir "/path/to/custom/output" \
  --max-download 100
```

## Parameter Description

| Parameter | Description | Default |
| -------------------  | ------------------------------ | --------------------------------------- |
| `--url` | Target Weibo user profile or favorites page URL | https://weibo.com |
| `--max-download` | Maximum download quantity | 10 |
| `--skip-existing` | Skip existing records | False |
| `--image-size` | Image size: 360/480/690/2000/large | 360 |
| `--download-video` | Download videos locally | Flag parameter, no value needed, without this parameter only keep video links |
| `--download-article` | Download long articles locally | Flag parameter, no value needed, without this parameter only keep article links |
| `--batch-size` | Batch size for each download | 20 |
| `--headless` | Headless mode (no browser window) | Flag parameter, no value needed, without this parameter browser window is displayed |
| `--user-data-dir` | Browser user data directory | Without this parameter defaults to using cookies.json |
| `--output-dir` | Custom output directory | Output directory under python script directory |

## Output Directory Structure

```
output/
├── pictures/          ## Image directory
│   └── {record_id}/   ## Images for each weibo
├── videos/            ## Video directory
├── articles/          ## Long article directory
│   └── pictures/      ## Images in articles
└── {author}_{date}_{id}.md  ## Weibo content Markdown file
```

### Markdown File Format Example

```markdown
## Author Name  Publish Time: 

Previous: [Previous Weibo Description](author_name_2024-01-15_xxxx.md) | Next: [Next Weibo Description](author_name_2024-01-15_yyyy.md)

## Content

Weibo content...

## Images

![Image1](pictures/record_id/group1_1.jpg)
![Image2](pictures/record_id/group1_2.jpg)

## Videos

[Video File](videos/record_id.mp4)

  
```

## Troubleshooting

### Login Issues

- Check network connection
- Try deleting cookies.json or browser_data directory and re-login
- Ensure no VPN or proxy causing access issues

### Download Failures

- Check disk space
- Check directory permissions
- Try reducing `--max-download` quantity

### Browser Launch Failures

- Ensure `playwright install chromium` has been run
- Check if system supports Chromium running

### Content Expansion Issues

- The program automatically clicks "expand" button to get full content
- If content is still truncated, it may be due to Weibo platform limitations