#!/bin/bash
set -euo pipefail
cd '/Users/henryking/Desktop/AI/Skills/MySkills/weibo-downloader'
python3 /Users/henryking/Desktop/AI/Skills/MySkills/weibo-downloader/weibo_favorites_4skill.py --image-size large --download-video --max-download 100 --skip-existing --headless --url https://weibo.com/u/page/fav/6498940335 --output-dir /Users/henryking/Desktop/AI/Skills/MySkills/weibo-downloader/output/ >> /Users/henryking/.hermes/weibo_downloader_837.log 2>&1
