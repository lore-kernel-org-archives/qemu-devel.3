Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CD6C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qON-0004Ap-CE; Tue, 30 Apr 2024 12:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1qOI-0004AU-FZ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:31:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1qOE-0001Kc-AX
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:31:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41b79450f8cso37659905e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714494690; x=1715099490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L313QGdUkUij1Ij9Kei8hd/sGtPgYjhHnMvIudLwbAY=;
 b=GtHTxjiUQS1Eznp+5F9757SRo4qfRUG+ghgsTqXbpgUUtsE5gMSsBpoe/MDQwvWvXN
 trQnwb/bp8XTaGCMNJQ9RFeho8kIedTl1DM4od20X4dyoTGpeSL8QhYsRNVuIKMXJKXk
 gcLMeBwzy4GoFQNBAV+Ww/S9AzMOqQeVewQIPkDbd6Yr2SofsKGmyoRmE1LLmNxLqp7L
 g18mCJet78Ohgb0ur4+bWOHg/T9MhrtJqfapbt9PmKWzHBC1gRf3fSpVMSr6jvyHjpOu
 Ioz3ULYqbuqjcqYn/rentk9Hi+bovpHcRyC+fjyeOSMxFUBIxd+K1mCKLpR/sCS6JAy8
 lW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714494690; x=1715099490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L313QGdUkUij1Ij9Kei8hd/sGtPgYjhHnMvIudLwbAY=;
 b=XmwGquWRWNVvIr5+Ck6gyT9DKr2OoXkmpiUcr2O73uPFu3CUwxgQnDGIHzAvAR/6Ws
 cMtDyPE8k1Y6gt9UIjZq2HAahjesUbXDdDGGrnQ6yeoisAAjAL8okW9WNhJZP7jBKcqo
 t5cncAIYAwAyTor1nZ/sAvcliJGtGmMKl6xEOz/4cHoXyywMs+1jCxYBC5a9mOfnWyqU
 4UryAO5O4Ospe+IYE3WqueZgnS9mfqEupF9rRC1DNiHfimX/X3+Gv/BjBkfpSc21CwAp
 EWCC3LXmmnRUCUrBxAE+hqBoF1seKw5ahE/IKpipuIid5Qm836Nw05tWxydCIVgsuD7/
 7GEQ==
X-Gm-Message-State: AOJu0Yy0evNRL8NgdFXpz0K2yz5ivQy5qDVvbj1ytsGL27JB6mK5CxRH
 625YTrNCKihk8+lY0DqaMhkUhmW2ZPitnkhvhBnsofJTQ2vdIpyWRe2Pv7I3Ga5hulMOw0RmhtF
 v
X-Google-Smtp-Source: AGHT+IGUZ1uWYSMsPpWPWMqXrslPUHS+sIvNwDMqn8t/iuhZ23kBNBDI/xu/J8sccF4saZiGxmTcvA==
X-Received: by 2002:a05:600c:450a:b0:418:ee30:3f92 with SMTP id
 t10-20020a05600c450a00b00418ee303f92mr21133wmo.25.1714494689696; 
 Tue, 30 Apr 2024 09:31:29 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 i13-20020a05600c354d00b0041c097e20f9sm10675544wmq.25.2024.04.30.09.31.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 09:31:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Cercueil <paul@crapouillou.net>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/4] target/sh4: Fix ADDV/SUBV opcodes
Date: Tue, 30 Apr 2024 18:31:21 +0200
Message-ID: <20240430163125.77430-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pass 'build-legacy' CI job which runs check-tcg-sh4.

Since v3:
- Fixed copy/paste mistake (Paul)
- Tests print values on failure
- Added rth R-b tags

Since v2:
- Add tests (Paul)
- Rename TCGv variables as in manual

Philippe Mathieu-Daudé (4):
  target/sh4: Fix ADDV opcode
  target/sh4: Fix SUBV opcode
  target/sh4: Rename TCGv variables as manual for ADDV opcode
  target/sh4: Rename TCGv variables as manual for SUBV opcode

 target/sh4/translate.c        | 32 ++++++++++++++++++++------------
 tests/tcg/sh4/test-addv.c     | 27 +++++++++++++++++++++++++++
 tests/tcg/sh4/test-subv.c     | 30 ++++++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  6 ++++++
 4 files changed, 83 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/sh4/test-addv.c
 create mode 100644 tests/tcg/sh4/test-subv.c

-- 
2.41.0


