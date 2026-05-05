Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441ABFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJ9A-0007xl-UW; Tue, 05 May 2026 13:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ92-0007wK-Le
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ8w-0003SN-L8
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso654395e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778000468; x=1778605268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IFFZbjjLf6TvwQTkC8SZiNDdSj/jCQlN3w12zEgNIa0=;
 b=UoJXlem85GXkebSM0zGwNZla7VsAYqM0G9DfQvUp+eaFFhIFlCJBCvwnfETS62FyMd
 4ZdnZi2BFSH/XkwgvPpaemXffFfWk/jtUx1jEV3osxjt+jRqedLzfGT4ekTrUcXSYDdi
 egpCxk1cyo3tvcePSt6xIzX9ZBiTP5tA4tnAvWaKdubFI4deE31NAgIY7hLxzzj0wb0Y
 NyPCq4ZtFVW4L3jVgHe8ysziYdlDqj3DnTOfeM1KThYoOmYbMwSyt09BoXWlCJmbUAaz
 /SDbF5zWbrK60PhRlElGUJqOF8l9b5wQgI5pU4KEsrQJEc0/XUUTCT2Fg9e/pmJhEr7j
 MmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778000468; x=1778605268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFFZbjjLf6TvwQTkC8SZiNDdSj/jCQlN3w12zEgNIa0=;
 b=bC3KH+QPI5oORVhvLKbSbv3DRzn8uGhiugquUSU59cpHF+/rAqsSrgMbmaZZDydE2x
 BhCmILQJ19fkLC/pNDhtdVDZvkjfjB9dBHvyaSUBSAr2m9wAKb5GwxWbUAgfwD2hE9Vw
 mZ6qesTI8GyvA+T+0/bkt1mJZlOqL0DgPl4sg9+x61rXloKVIITftORd90aqydjAlu8/
 SABVZKjT26fwHXv48J74BYn+SgmGhbo/Ah2C/LtLWzg1r09AbL+nAMxtF7+hqujHmo5a
 YwNr9IzCUZwDNHg3AYYPtHJf2oGz6ITqSBWgunQPUgfa9iWwii7nfjDse2QAto7gM537
 zfWA==
X-Gm-Message-State: AOJu0YwsJm2xrOaCMJCejRVW+TxRRui0tHTekGqLAO6c8g/O7mWGNJ/w
 eMRcgcAFl2oikWKOVrmqwojsAicOiIKgeKLXsqHhR9L4of/IZF620PUwBGcq0C2GsGQIr92t0+n
 0EYh5XM4=
X-Gm-Gg: AeBDietuuWE2cR0Gfq12/YHYhnDA8pAoMb6uqMSGYL9wSskEAcTIWhk7z/GV8VWeiH1
 IZ+q0/QZkdvZKJhr+y0fzqiluf4GRoUZjB3W6bLkAmk4xezJvR1kiXctVtjridN9/XOlyfN7SRo
 krD0ImUyDx8197X5rhAUxqARsNvRSwMS1oP/mAvU7nz4AD3grHrh7oKI3zoOBXTCDhqs8maQ58r
 8CLfpTQp4lLIZy/RIWogB/jn+9w/ek1XMA7Hl9FwEd9UeC14HPxli/UsUtZG73a3Gz3syaydnXC
 6N5eziIQzws1Zvq4IUK1/ZzByaEPSe0/JydTEuo9GZfbKRJ+LLX/dlhxMVIqwkeQw57BvyfJpvo
 4Y7efJN+KvvFYHvTCSuzEs88rJYJvwVe4GQfKuj03QBVkhLOzeR9sN9Ut6WqnpYrCv0SdmHHop+
 F35gLO0Onnbn68A5AkRA4KeuTApHVe52WsFw==
X-Received: by 2002:a05:600c:4854:b0:489:1c0d:c9cb with SMTP id
 5b1f17b1804b1-48d1422e803mr50602665e9.5.1778000467637; 
 Tue, 05 May 2026 10:01:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960811sm6109719f8f.27.2026.05.05.10.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:01:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 024375F832;
 Tue, 05 May 2026 18:01:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 00/10] AGENTS.md and associated skills
Date: Tue,  5 May 2026 18:00:55 +0100
Message-ID: <20260505170105.228162-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Not withstanding the current contributor policy there are a number of
areas that AI agents could be helpful for. This series introduces an
AGENTS.md file which is the basic guide to the source tree and a
number of "skills". Skills are like scripts except far less clearly
defined. However I have found the issue triage skill quite useful for
off-loading the drudgery of going through stuff by hand. I've also
used the issue helper to automate the task of starting a debug session
by pulling in test cases from the tracker.

These originally where a set of skills for ECA (eca.dev) but I've
ported them across to the agent agnostic .agents directory. There are
still some cases where the ECA heritage shows through though
(specifically the code explorer skill could be better).

I'm not suggesting this is ready for up-streaming but I'm posting the
collected set for comment and I'd be interested how well these hold up
across different agentic systems.

Alex.

Alex Bennée (10):
  AGENTS.md: add basic AGENTS.md for QEMU
  .agents/skills: add qemu-code-explorer skill
  .agents/skills: add qemu-code-reviewer skill
  .agents/skills: add qemu-issue-helper skill
  .agents/skills: add qemu-build skill
  .agents/skills: add qemu-testing skill
  .agents/skills: add skill to distil mail threads
  .agents/skills: add qemu-issue-triage agent skill
  .agents/skills: add checkpatch agent skill
  MAINTAINERS: add a section for AI agents

 MAINTAINERS                                   |   6 +
 .agents/skills/checkpatch/SKILL.md            |  10 ++
 .agents/skills/distil-mail-thread/SKILL.md    |  33 +++++
 .../distil-mail-thread/scripts/parse_mail.py  |  64 +++++++++
 .agents/skills/qemu-build/SKILL.md            |  50 +++++++
 .agents/skills/qemu-code-explorer/SKILL.md    |  67 +++++++++
 .../qemu-code-explorer/evals/evals.json       |  26 ++++
 .agents/skills/qemu-code-reviewer/SKILL.md    |  74 ++++++++++
 .agents/skills/qemu-issue-helper/SKILL.md     |  47 +++++++
 .agents/skills/qemu-issue-triage/SKILL.md     |  91 ++++++++++++
 .../qemu-issue-triage/assets/labels.txt       | 133 ++++++++++++++++++
 .../skills/qemu-issue-triage/evals/evals.json |  18 +++
 .../scripts/update_labels.sh                  |  16 +++
 .agents/skills/qemu-testing/SKILL.md          |  53 +++++++
 .gitignore                                    |   1 +
 AGENTS.md                                     |  94 +++++++++++++
 16 files changed, 783 insertions(+)
 create mode 100644 .agents/skills/checkpatch/SKILL.md
 create mode 100644 .agents/skills/distil-mail-thread/SKILL.md
 create mode 100644 .agents/skills/distil-mail-thread/scripts/parse_mail.py
 create mode 100644 .agents/skills/qemu-build/SKILL.md
 create mode 100644 .agents/skills/qemu-code-explorer/SKILL.md
 create mode 100644 .agents/skills/qemu-code-explorer/evals/evals.json
 create mode 100644 .agents/skills/qemu-code-reviewer/SKILL.md
 create mode 100644 .agents/skills/qemu-issue-helper/SKILL.md
 create mode 100644 .agents/skills/qemu-issue-triage/SKILL.md
 create mode 100644 .agents/skills/qemu-issue-triage/assets/labels.txt
 create mode 100644 .agents/skills/qemu-issue-triage/evals/evals.json
 create mode 100755 .agents/skills/qemu-issue-triage/scripts/update_labels.sh
 create mode 100644 .agents/skills/qemu-testing/SKILL.md
 create mode 100644 AGENTS.md

-- 
2.47.3


