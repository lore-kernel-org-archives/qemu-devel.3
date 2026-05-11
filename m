Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BC4CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMU44-0000rk-Lt; Mon, 11 May 2026 13:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU42-0000qv-VX
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:07 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU40-0007es-Bt
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:06 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso26355525e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778519102; x=1779123902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sIMC8/X2P830H+MHWUJIx5/ofWemp3lJzqWkAm9VKIU=;
 b=e15TgVXw8UuhwPL9G8Ts0cCUwfxkQiPTuqztKYhhlNB4KgU77GanO6cf3b5owESmY0
 mbJCaSsAVxMVVoePN6UY6fiK/6Okp/IfOkVcsFjUjV87yrmXt7akfQVhsvHA7LYrq7rD
 VeFkophdVpLYCbj3pK2DSzrVf7iv3KGO/ApIlLktBV9EFyvSF4C5LtVLAJkOKHlqQR82
 EVToDLG0BX/q5eKvd+MXBhFrzH1gKqlaHE5wt/fRUSCaAeyl4GiAYG+RwHtN3kizmF/2
 rwGvXuqOEuZx3t9alcEXGOzKb6Qa7SHmE0yucqCg+8DIjZxbZHmIduVqVUSjg4rohBEb
 PXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778519102; x=1779123902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIMC8/X2P830H+MHWUJIx5/ofWemp3lJzqWkAm9VKIU=;
 b=YdFoJn+JnD8AfUUk+Fv5pGGc/hUhxnEt63euWkysyMuKlR11ZGCWe3QOCio4O2DIyU
 OxNQanQ+89GQ/GeS65YuGNh48wQKG+t6sHNDnVSxLW9Yi32YdZZUB4D+tPU7ABq95wt6
 d/5XeOmimNokYIZpIT0f/DrgdxNJZLDMJsZ3OHXZhhNmFIKP+TWZHb/hzavfR0/hrXxY
 W5eyjjukF5opXzwEhgeuKW8t1i4Aqg2Nkz0z/EHgO8AWUJI7Gf2akCn1vPvs9LBe2uiY
 u0Zzsiuy8r3fFuPJXiL4zHRlwLpxNYpH6fAJVMWMlmZX5Q1SSlS7uiYVWwVnuBzYMxRt
 mXsA==
X-Gm-Message-State: AOJu0YzWnbE972YsPQvr7+5/s2Vjy9NViLIzzSaTCC3/VHehBbdSJyYA
 gV7SMoQHvIuvW1lRmm2VRVgmyB+HrOyRQa0b5JJHtFbUmOf7um6KiPCrHFpNGq4z080=
X-Gm-Gg: Acq92OGKo54Fwwr0yLFV1F5FNDc6yZGNa64VFcv3bNkGD0Qo1Gf6/SkaT47WocWEsXn
 D3aCsWpMDZt33UwSNNL/epoCXPBMhQlT7iNaQRmTFHqHN3yQ7D6rUJBShYg/m4XoFvp9Og549KJ
 NkP/2d/3GpU5UqCfmEs9+tCuJqmwIU558bWPTOQ//u8hYZO6brlR3dVedFNoF6UJZbgIpKwe7tp
 +mgT+SObGUfzebUE6NltWXsrg4Sy0m5jPZlbdc9I8xDGLaqJHdNiJ4BR/ci04MC1++MrPpyplvT
 AuFj4oien+RdKZigjs6h4PQS9fKdPMbA7Hu+vojSopa4+ScX7KZFlmNA/Y0dI9kyGXF7ruBkI4b
 8YbgTL7afvVezAr14ZVuiwxaB1R0mLLelTZBDmPlWvKXjnl0nz6HNYlacBhNUf6Of7OD+OLqiJY
 sFtTfIG2AbnMFwKFOVL9ll8Q1D5ILswO9zqQ==
X-Received: by 2002:a05:600c:8012:b0:48e:5fb8:f80f with SMTP id
 5b1f17b1804b1-48e5fb8fac9mr311212165e9.24.1778519102227; 
 Mon, 11 May 2026 10:05:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e5516sm304217495e9.7.2026.05.11.10.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:05:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7F2265F7C1;
 Mon, 11 May 2026 18:05:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v2 00/10] AGENTS.md and associated skills
Date: Mon, 11 May 2026 18:04:49 +0100
Message-ID: <20260511170500.124211-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Not withstanding the current contributor policy there are a number of
areas that AI agents could be helpful for. This series introduces an
AGENTS.md file which is the basic guide to the source tree and a
number of "skills". Skills are like scripts except far less clearly
defined. However I have found the issue triage skill quite useful for
off-loading the drudgery of going through stuff by hand. I've also
used the issue helper to automate the task of starting a debug session
by pulling in test cases from the tracker.

These originally where a set of skills for ECA (eca.dev) but I've
ported them across to the agent agnostic .agents directory. All the
references to ECA should now be removed. I have some personal tweaks
in my ~/.config/eca that make agent specific suggestions.

I'm not suggesting this is ready for up-streaming (or indeed should
even go upstream) but I'm posting the collected set for comment and
I'd be interested how well these hold up across different agentic
systems.

v2
  - re-organised all the skills, now prefixed qemu-FOO
  - update AGENTS.md as we add each skill
  - moved a bunch of stuff from agents to skills
  - added a new script/expand_macro.py
  - see bellow --- in each patch for details

The expand_macro is an attempt to make the code explorer more efficient
and stop it getting confused by our heavy macro use. However the skill
generally isn't performing as well as I'd like. I suspect a semcode
MCP server (https://github.com/facebookexperimental/semcode) would be
a better way to get agents to efficiently navigate the code base.

The issue triage skill has so far proved to be the most useful and has
seen a fair bit of tweaking since the last version.

Alex.

Alex Bennée (10):
  AGENTS.md: add basic AGENTS.md for QEMU
  scripts/expand-macro.py: helper script exploding macros
  .agents/skills: add qemu-code-explorer skill
  .agents/skills: add qemu-build skill
  .agents/skills: add qemu-testing skill
  .agents/skills: add qemu-code-reviewer skill
  .agents/skills: add qemu-mail-thread skill
  .agents/skills: add qemu-issue-helper skill
  .agents/skills: add qemu-issue-triage agent skill
  MAINTAINERS: add a section for AI agents

 MAINTAINERS                                   |   6 +
 .agents/skills/qemu-build/SKILL.md            |  50 ++++
 .agents/skills/qemu-code-explorer/SKILL.md    | 119 ++++++++
 .../qemu-code-explorer/evals/evals.json       |  26 ++
 .agents/skills/qemu-code-reviewer/SKILL.md    |  93 ++++++
 .agents/skills/qemu-issue-helper/SKILL.md     |  47 +++
 .agents/skills/qemu-issue-triage/SKILL.md     | 112 ++++++++
 .../qemu-issue-triage/assets/labels.txt       | 133 +++++++++
 .../skills/qemu-issue-triage/evals/evals.json |  18 ++
 .../scripts/update_labels.sh                  |  16 ++
 .agents/skills/qemu-mail-thread/SKILL.md      |  34 +++
 .../scripts/qemu_mail_parser.py               |  98 +++++++
 .agents/skills/qemu-testing/SKILL.md          |  56 ++++
 .gitignore                                    |   1 +
 AGENTS.md                                     |  85 ++++++
 scripts/expand-macro.py                       | 272 ++++++++++++++++++
 16 files changed, 1166 insertions(+)
 create mode 100644 .agents/skills/qemu-build/SKILL.md
 create mode 100644 .agents/skills/qemu-code-explorer/SKILL.md
 create mode 100644 .agents/skills/qemu-code-explorer/evals/evals.json
 create mode 100644 .agents/skills/qemu-code-reviewer/SKILL.md
 create mode 100644 .agents/skills/qemu-issue-helper/SKILL.md
 create mode 100644 .agents/skills/qemu-issue-triage/SKILL.md
 create mode 100644 .agents/skills/qemu-issue-triage/assets/labels.txt
 create mode 100644 .agents/skills/qemu-issue-triage/evals/evals.json
 create mode 100755 .agents/skills/qemu-issue-triage/scripts/update_labels.sh
 create mode 100644 .agents/skills/qemu-mail-thread/SKILL.md
 create mode 100644 .agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py
 create mode 100644 .agents/skills/qemu-testing/SKILL.md
 create mode 100644 AGENTS.md
 create mode 100755 scripts/expand-macro.py

-- 
2.47.3


