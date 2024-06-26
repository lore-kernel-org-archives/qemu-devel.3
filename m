Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19774C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQnr-0002Ff-T3; Wed, 26 Jun 2024 07:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQni-00028X-0e
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:26:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQnf-0001pp-I8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:26:57 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70671ecd334so3046649b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719401214; x=1720006014;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P3Z5c5XeGMUuuVJGSPsEWcXMD8Mrt3Anv/zdnQlInfg=;
 b=Pk1Now066r47QdplLolmDR4r1MKS26h7T0J+8+vTU7cbP3rrZK4TEHKB+x0w9aKCfm
 rDJTnkBpYZ+OMHR5Wi61Sp8rlbE4jwigq/cZCMQjPJ8YsTMbJXxRmr/YiR/dfTStv7xh
 vEebJujvcXWyqHJXQ+Eoq2jCRgxxufZTcsfsDQ8eAxPLvV1gTxhH118rJerr9agsz1PO
 gAUq2OhTK1CzL+hYOQAqt7pES8RNqHQSldP5SNlz1jN21osiZxQy33RAzGa98VTP9wog
 gVQz7nsBgktoG3a6F6MpLEktDSRb5qnXG4Lne5IlI8Qtq27ROH3+SnFmoWWmAGoLL/B5
 5QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719401214; x=1720006014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3Z5c5XeGMUuuVJGSPsEWcXMD8Mrt3Anv/zdnQlInfg=;
 b=Vi8e/wtMZkMxQqXLExBuPGzf+TpzuYLFjMV5bIzH6ViMujmpG0unHY6t32kfi4TVAG
 eimO2pbOj5pt3mRjioE1eqsnC/sRqiyVNfraoLJZlppMmYiai7T6dSf8yFpy3s95xu8v
 9jXJ4MDBciZIiM0xTGSq2tMmI9etimMsNWFSCEf/ASofjahJUUDwuhXNcfhPrTAKWvjB
 wppc7nru4dchXiThluLjIDvUbb+7lRCezhsyWQGU+ER22YMzNq7I5kZFKRqEifvXSyXZ
 Lp5xNKbziLhQbTUqV888hu+No959I0nRrLNV8zoSxfsLQW4lmv/jZcNVLCkQcjOdRUzY
 o8Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtEUiUKvvK4iTnFz1NU5f9WCzmq4/7fao6/pq5iXT5sXpM4dH3jq24SfvbZ8yT5vbGPielcdXBglxqPTCl3vGt9ABdBOk=
X-Gm-Message-State: AOJu0YyXx6sTszEfDLUVTuPEP542b3Fde7TpNx5wNQUaxv43SvNFA/y8
 OanTF/FdNPfV6yc/1+Qt5if+jP7mzfvaooGTVj8bGgJXaRMD94r3uZkR6lC4bkE=
X-Google-Smtp-Source: AGHT+IFuXUsCTwmu5vZL28z5/7VuxcoYGSSplRFT7eDZgaf5momonqzb97/J6GwFRpB2OzP98KIyFw==
X-Received: by 2002:a05:6a20:5a81:b0:1bd:2894:a0ca with SMTP id
 adf61e73a8af0-1bd2894a15dmr2952323637.41.1719401214176; 
 Wed, 26 Jun 2024 04:26:54 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f9ebab6fffsm97803975ad.243.2024.06.26.04.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:26:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:26:24 +0900
Subject: [PATCH 3/6] tests/tcg/aarch64: Explicitly specify register width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-tcg-v1-3-0bad656307d8@daynix.com>
References: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
In-Reply-To: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

clang version 18.1.6 assumes a register is 64-bit by default and
complains if a 32-bit value is given. Explicitly specify register width
when passing a 32-bit value.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/aarch64/bti-1.c | 6 +++---
 tests/tcg/aarch64/bti-3.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/aarch64/bti-1.c b/tests/tcg/aarch64/bti-1.c
index 99a879af23d4..1fada8108d22 100644
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
index 8c534c09d784..6a3bd037bcd6 100644
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
2.45.2


