Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A06C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpds-0002LW-6l; Thu, 27 Jun 2024 09:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpdp-0002J3-DO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpdm-0007py-6A
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1faad409ca7so4349265ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719496701; x=1720101501;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tmHLAd4iwYsP/x6+8JTBgWg+UXfKosXtWEII2F/7Uyk=;
 b=HkazcU3LoSurnnBG5f+arNn5SW9rNbM4LT1qx0ibDrAxMekdQE2RueAaVxt8tw7X76
 J9c2euN8tvxaV19SAUFMoYnzKyj2td/WqGOH8g8Q7nr7uz9f10pwmf6CGbLoQhUyJtYA
 HpTwjHqyIxVXnQikGR8h0Dk4NEhVbmIYvZAEeC23GJ+G42pUcKoFv2pTnHwk9o8SAQdl
 EL8OiedkLlvMHf5yP1MGiUVR2A/LcLnX9v7seLsVroYNsgYDQVeZqCzqOgxhfySKlDJL
 TQ4a8fOWb9CPtzWofYUUspRISR0jMZWarqbge9pe2jW4K/TtXli4RukYzEK/AorlcDpg
 ZdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719496701; x=1720101501;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmHLAd4iwYsP/x6+8JTBgWg+UXfKosXtWEII2F/7Uyk=;
 b=f0WuSU6hHhIB5VOe/TEXPBVHqLq4URz09iWJdE678vuu7L56jgaPOVp1anRoD/k4Pe
 rPpdRNLScUCjMTaPeaKX5vnxwLyxspfXDcGBIuG9iLLofDxp2VwXedPXBNNPXdkonozq
 aexBVT0xJiq1q3skzZk3BdiYP1oxai4q2LWmvoz1TQyQX7EB+jOB8EneeXpcHOgk6dPb
 eMB0YmqVZyC0AtCyfpxsiwPUokAl2ofIuREUwBPZHvufOFWfsrcIik0q8ynyBCg3jdBC
 KbeqX2hD5sj0DyYIuHdvMf1cvZd/3g+W5HxzKZmnGHzQl7F5OcQ5J8j7URop2kD3qukF
 8pZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfT565JOJecdYjl7JXpKXvMD7OAEKVf+HasjiCeRptyyrgCjj07RDAZPoox9F2OKQvZe4pZcjwtAu/19wGUX9nmJ82/b0=
X-Gm-Message-State: AOJu0YwQ8a8KAypg5qyJJoXV++74AoWKwP7+8Vd6/3b8yChnec4v1Rup
 /bAagjEEttZARY0O3WJoPTYSHw2+Y+SPNYRSHUeNnzU7CEfCmy85iU3+Y0Kb2Ww=
X-Google-Smtp-Source: AGHT+IGeURGVHdKCNIAuCEg1i4vW6FoDiAihGtDvnSSRW1/TKoF3Fw3lq6S6cNqJp7BXjwkGaQ6Rtw==
X-Received: by 2002:a17:903:1110:b0:1fa:918e:ec2 with SMTP id
 d9443c01a7336-1fa918e10f4mr64242515ad.57.1719496700795; 
 Thu, 27 Jun 2024 06:58:20 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac997f0dsm13461055ad.219.2024.06.27.06.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:58:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:58:03 +0900
Subject: [PATCH v2 2/6] tests/tcg/aarch64: Fix test architecture specification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-tcg-v2-2-1690a813348e@daynix.com>
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
In-Reply-To: <20240627-tcg-v2-0-1690a813348e@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

sme-smopa-2.c requires sme-i16i64 but the compiler option used not to
specify it. Instead, the extension was specified with the inline
assembly, resulting in mixing assembly code targeting sme-i1664 and C
code that does not target sme-i1664.

clang version 18.1.6 does not support such mixing so properly specify
the extension with the compiler option instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/aarch64/sme-smopa-2.c   |  2 +-
 tests/tcg/aarch64/Makefile.target | 11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/aarch64/sme-smopa-2.c b/tests/tcg/aarch64/sme-smopa-2.c
index c9f48c3bfca2..2c9707065992 100644
--- a/tests/tcg/aarch64/sme-smopa-2.c
+++ b/tests/tcg/aarch64/sme-smopa-2.c
@@ -14,7 +14,7 @@ int main()
     long svl;
 
     /* Validate that we have a wide enough vector for 4 elements. */
-    asm(".arch armv8-r+sme-i64\n\trdsvl %0, #1" : "=r"(svl));
+    asm("rdsvl %0, #1" : "=r"(svl));
     if (svl < 32) {
         return 0;
     }
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 70d728ae9af7..ad99e0e3b198 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -27,7 +27,8 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME); \
+	    $(call cc-option,-march=armv9-a+sme-i16i64,     CROSS_AS_HAS_ARMV9_SME_I1664)) 3> config-cc.mak
 -include config-cc.mak
 
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
@@ -68,7 +69,13 @@ endif
 
 # SME Tests
 ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
+AARCH64_TESTS += sme-outprod1 sme-smopa-1
+endif
+
+# SME I16I64 Tests
+ifneq ($(CROSS_AS_HAS_ARMV9_SME_I1664),)
+AARCH64_TESTS += sme-smopa-2
+sme-smopa-2: CFLAGS += -march=armv9-a+sme-i16i64
 endif
 
 # System Registers Tests

-- 
2.45.2


