Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F574C3064D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNznO-0004pv-FN; Sun, 30 Jun 2024 15:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznL-0004nC-AO
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:04 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznG-0007VE-48
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:02 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5c229aa4d35so1457027eaf.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774057; x=1720378857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbhfrqUnaAYuOyL/QoAAk+86rkpOm/3bNkjsHwjy29Q=;
 b=N2aqNkmQlgiZ2qYpzl9M8X7fllq1Ux1k6kzEMXr5oLKUT/WNn8GYRkXhVK/lsVWygJ
 EP3oxcv4FqMPQ+VOLC85u0IoQVRh+WsWu0To2VR2soj/RETwRIXSEz5C0qvSoa8SLuw8
 EOSMuBOYHM0cvWB+ohGS8OW92b1rI9DCipcmmtEfVnGTDhlGaoHG1xJTrqasShLOuXpx
 QyxObHz5yUzUeoZNOXr1/Oy+1idc7ZF8w3yLUVTbqmO6NFOUwN1jaYQiJ1g9jPJivBFd
 P9y+ZXyIe+JRvEHSHLRw1IG+H5elEENA6GOloymCTQzpKNaE2u9AbCCZ6F4lJVqfIQl6
 370Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774057; x=1720378857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbhfrqUnaAYuOyL/QoAAk+86rkpOm/3bNkjsHwjy29Q=;
 b=rGr1DX70YAr15vqVKLMV0+OjZgYStR/1f7dqzP7WIKrGw3kpaFzScMzv8tSytcIYQf
 prc4MfGDcimNQlrVVLGh6urwsdkremrEpLr8HBdQcPd4LDUkghBHxgmA4POutTT7eaYt
 RsbrXizccE3D38zeSWSlzbjtxAv/l32+nWuTLJ6auSE/KgSgrNetPrHnRW2TuwUVzU5V
 vtYUiCfp8i0w0lnpNBMNyQtbQOiMH2zUUHt3N7UF/ewWEQsX6BM3YrxLRfeANnsSovBH
 XtRwz3TD/UR6wVr3jZP5lbQwsMu6oS7nx5TJro6ZokOJO+F7d77QB4cDPmDwUA+6BQMH
 KRPA==
X-Gm-Message-State: AOJu0YxMQ9rswpCfEdh9G1PKouan5sxkKTY4MlgFSusVH0TBn/VV5i9U
 OS9P1DnXrTZfsTGBE/UvYMGu63rp4gmn5a26/I7N0qyReT82bya8JCYC+oL5vvVrsIKlO2+kXnT
 G
X-Google-Smtp-Source: AGHT+IF/KfTch98iHq3m2GtDdHSQ7Z8qhj99T8tk/rTUl+c6WObdSSkfmSky4F7iKU+hB/2F1lDgGQ==
X-Received: by 2002:a05:6358:249b:b0:1a5:4b74:2214 with SMTP id
 e5c5f4694b2df-1a6acc6e5e7mr403361255d.3.1719774056399; 
 Sun, 30 Jun 2024 12:00:56 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:00:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com, alex.bennee@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 04/14] tests/tcg/aarch64: Explicitly specify register width
Date: Sun, 30 Jun 2024 12:00:40 -0700
Message-Id: <20240630190050.160642-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

clang version 18.1.6 assumes a register is 64-bit by default and
complains if a 32-bit value is given. Explicitly specify register width
when passing a 32-bit value.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240627-tcg-v2-3-1690a813348e@daynix.com>
---
 tests/tcg/aarch64/bti-1.c | 6 +++---
 tests/tcg/aarch64/bti-3.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/aarch64/bti-1.c b/tests/tcg/aarch64/bti-1.c
index 99a879af23..1fada8108d 100644
--- a/tests/tcg/aarch64/bti-1.c
+++ b/tests/tcg/aarch64/bti-1.c
@@ -17,15 +17,15 @@ static void skip2_sigill(int sig, siginfo_t *info, ucontext_t *uc)
 #define BTI_JC    "hint #38"
 
 #define BTYPE_1(DEST) \
-    asm("mov %0,#1; adr x16, 1f; br x16; 1: " DEST "; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; br x16; 1: " DEST "; mov %w0,#0" \
         : "=r"(skipped) : : "x16")
 
 #define BTYPE_2(DEST) \
-    asm("mov %0,#1; adr x16, 1f; blr x16; 1: " DEST "; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; blr x16; 1: " DEST "; mov %w0,#0" \
         : "=r"(skipped) : : "x16", "x30")
 
 #define BTYPE_3(DEST) \
-    asm("mov %0,#1; adr x15, 1f; br x15; 1: " DEST "; mov %0,#0" \
+    asm("mov %w0,#1; adr x15, 1f; br x15; 1: " DEST "; mov %w0,#0" \
         : "=r"(skipped) : : "x15")
 
 #define TEST(WHICH, DEST, EXPECT) \
diff --git a/tests/tcg/aarch64/bti-3.c b/tests/tcg/aarch64/bti-3.c
index 8c534c09d7..6a3bd037bc 100644
--- a/tests/tcg/aarch64/bti-3.c
+++ b/tests/tcg/aarch64/bti-3.c
@@ -11,15 +11,15 @@ static void skip2_sigill(int sig, siginfo_t *info, ucontext_t *uc)
 }
 
 #define BTYPE_1() \
-    asm("mov %0,#1; adr x16, 1f; br x16; 1: hint #25; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; br x16; 1: hint #25; mov %w0,#0" \
         : "=r"(skipped) : : "x16", "x30")
 
 #define BTYPE_2() \
-    asm("mov %0,#1; adr x16, 1f; blr x16; 1: hint #25; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; blr x16; 1: hint #25; mov %w0,#0" \
         : "=r"(skipped) : : "x16", "x30")
 
 #define BTYPE_3() \
-    asm("mov %0,#1; adr x15, 1f; br x15; 1: hint #25; mov %0,#0" \
+    asm("mov %w0,#1; adr x15, 1f; br x15; 1: hint #25; mov %w0,#0" \
         : "=r"(skipped) : : "x15", "x30")
 
 #define TEST(WHICH, EXPECT) \
-- 
2.34.1


