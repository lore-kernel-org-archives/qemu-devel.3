Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9D2CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMU4I-00016k-JM; Mon, 11 May 2026 13:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU47-0000u8-AC
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU45-0007og-5J
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso48260255e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778519108; x=1779123908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOuLebqYagfKQ3ugJXt5I4VOyuHgi+yZanX6asea8to=;
 b=g9n/5nLBCmRbJ1MEDQQwee3YID/Jw+Gzj2enlSZCfZp/SH0pUbyZvOy+0uwCVvu1+A
 f1aUW7uXivuO2KgOlGyIk7hDZkAOCHGqgMdB11HWQSfMgZhgPJyeBnDPDrWRAAtKP8FK
 oST/TXwrUmbAUJPFDYMeTnmUUOtN4p+a1xX34DQOEJNzBbdyB9nMQeDeZWgQy+2VsV97
 iw6eJSwJaV0/itUaS9P9Jj0KQ2oWpDoXnsBFiHWhaej8m+WUjhk3RACc25gSQGkEKw/E
 u+mjJ25pVfdxy5eofmLVhRUnVw0r+b8y7fNsdFMV9lFKmKMvAtDYoQLDkUyCozNWLaMI
 lEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778519108; x=1779123908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HOuLebqYagfKQ3ugJXt5I4VOyuHgi+yZanX6asea8to=;
 b=nyHJnJ5MP7dZyB4INndC+jrSpqRFLMlyGROBpJwAD1RCS3HaDue+O8x0HfIz/NQV2v
 VtVAPRq62ouCIX4UajK4I5QKF2K2lFI5eVuhYSHxlmxJdOSxtAjyNhM2d+MoZA5H0Qbn
 VL24FBJ3i9pL+UUwEg/cqf7JIu2TrsboJh/AwzHzTLNDh0fFOJ/kIr0w92d8cFP6yFgN
 NmYE/LF2OCtuCAs7XciYR4E4cxapEkmfHrE2lURohVsTWhpcaPARVwqIoHtMwlYbdaJY
 epFrBXDTkXKgWW2boHHUySBrRJFGjBWfeBttQKmmvJJLwzq3GEIvLYFRGlZZNw79VCLi
 qJBg==
X-Gm-Message-State: AOJu0YzjE2mjiTn+gFEAuUYaBinHqu0XFkQUMp9OQlY93+6FiVT0S+m+
 3DV6m6T2AMtmuB5JvzJGotYkQIT8wm7zbFnXSF5U0IIC2uUx+yr5yqNoBFQh7kd/LmA=
X-Gm-Gg: Acq92OHuNe1iI/8oLn2Hi6qW5HtiWUyhMe/l0mUCloT3nR4XYyXXi4V8krvgMfgvLbP
 y+OuPi/LIpeEZMnycChaLOdFgUh9B2Hp2qVaY704BDa0xGmCCKszc+c8iqp8fclVi9IFzLA9YQc
 LPFy4C25jq69YbVHY7D5Af+jzAZhf5CPd35vYAtC6pjE/lysdMO6obbr/zVuT8vPTLsVEfQLIsJ
 gOeMEOZg1XYBwVo52iZrHmqvr6SuA3PqNaObRzyn+xTAjS90WpnTj8+mQz49y23SahOOAN5wAtb
 IOsz2PoRcygvNsTZr0BUZDuANTuguKozY/inhLpswKd3QNS9ybU6Hs48xVLGmVOf/Hap/hIUzOh
 z444albbHK3BXDVQj63eUhgC1zoArWQHWjgQ7Qej5kh7YTuhkrpf6sHfS8u9UNGVmfi6c34qCNT
 o2MGYZnMSRvp7pOiOe4xAuxBQriBHM/FLxvg==
X-Received: by 2002:a05:600c:8b08:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-48e51f32ca9mr429227115e9.18.1778519107532; 
 Mon, 11 May 2026 10:05:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6fff9ab8sm206112905e9.2.2026.05.11.10.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:05:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4DCA760F2B;
 Mon, 11 May 2026 18:05:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v2 08/10] .agents/skills: add qemu-issue-helper skill
Date: Mon, 11 May 2026 18:04:57 +0100
Message-ID: <20260511170500.124211-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511170500.124211-1-alex.bennee@linaro.org>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

This provides basic instructions for fetching issue details and
summarising details about the issue for other agents.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .agents/skills/qemu-issue-helper/SKILL.md | 47 +++++++++++++++++++++++
 AGENTS.md                                 |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 .agents/skills/qemu-issue-helper/SKILL.md

diff --git a/.agents/skills/qemu-issue-helper/SKILL.md b/.agents/skills/qemu-issue-helper/SKILL.md
new file mode 100644
index 00000000000..725097bac36
--- /dev/null
+++ b/.agents/skills/qemu-issue-helper/SKILL.md
@@ -0,0 +1,47 @@
+---
+name: qemu-issue-helper
+description: Summarize QEMU issue analysis for main agent. Helps sub-agents report findings including build config, CLI, tests, and GitLab issue data. Trigger when analyzing QEMU bugs or issues reported on GitLab.
+license: GPL-2.0-or-later
+---
+
+# QEMU Issue Helper
+
+Assist sub-agent in summarizing issue analysis for main agent.
+
+## Fetching Issue Data
+
+Use `glab` to retrieve issue details from GitLab. QEMU primary repo: `qemu-project/qemu`.
+
+### Commands
+- **View issue**: `glab issue view <ID_OR_URL> -R qemu-project/qemu`
+- **View comments**: `glab issue view <ID_OR_URL> -R qemu-project/qemu --comments`
+- **Search issues**: `glab issue list -R qemu-project/qemu --search "<KEYWORDS>"`
+
+## Report Format
+
+Sub-agent MUST provide a summary of the GitLab issue discussion and findings in this format:
+
+### 1. Issue Context
+- **Source**: GitLab URL/ID.
+- **Title**: Short issue description.
+- **Reporter**: User who found it.
+- **Relevant Commits**: List any commits mentioned in the issue that are related to the bug or previous attempts to fix it.
+
+### 2. Build & Reproduction (from issue)
+- **Reported Environment**: Host OS, CPU, QEMU version.
+- **Build Configuration**: Required `configure` flags mentioned in the issue.
+- **Reproduction CLI**: Exact QEMU command used to reproduce.
+
+### 3. Proposed Fixes & Series
+- **Proposed Fixes**: Flag any specific code snippets or logic fixes suggested in the comments.
+- **Patch Series**: Note if any patch series or Merge Requests have been linked.
+
+### 4. Discussion Summary
+- **Current Consensus**: What is the community's current understanding of the bug?
+- **Key Constraints**: Note any blockers, requirements, or specific feedback from maintainers.
+- **Next Steps**: What is needed to move the issue forward?
+
+## Rules
+- **No Independent Analysis**: Do not perform your own root cause analysis. Summarize ONLY what is present in the issue tracker.
+- **Terse**: Use brief technical English.
+- **Links**: Provide direct links to relevant comments or patches if available.
diff --git a/AGENTS.md b/AGENTS.md
index d99d3078378..ca292460403 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -29,6 +29,7 @@ You should use the following specialized skills for common tasks:
 - `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
 - `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
 - `qemu-mail-thread`: For analyzing and parsing mailing list threads.
+- `qemu-issue-helper`: For fetching and summarising issue details from the bug tracker.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


