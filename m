Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25613C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 08:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNTsu-0006we-7a; Sat, 29 Jun 2024 04:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTss-0006vx-Nj
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:38 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTsq-0008Fl-Te
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:38 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c21f1bb810so700812eaf.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719651395; x=1720256195;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uV36Gt3F0NFarV2rkaJX1rYzyXO0vgzu3txrDL4RZ9o=;
 b=JjszEdY9bV0X9ugQZsnEWM2SkPBPui8twycy1COMZ2POXNXYkX5ko5hq87++PXRtkB
 IHDgi88kTeQSaPLc+bWMxFtYFOGuM6M3jpGuPxkziux30GMgKtMgM9O0twzUbe8zfJHI
 M0pxqbnmhjU0Dz5EFstmXKOScVT6ZwTIOZ/kglIxeQpR5sG9RGKvOQKKUGEfMFqaHmyp
 cGeb/slB2gbYFQk6dPXLd1FJY7HRKEv0PCZ44HvIQp6E0a/hQrjet/kxZVAtwz00BE41
 3/ujXVbIfgVrd0jXkPL12HhYtwVcpg1Ms1fS3rOoDITsRHCKjDZCh5MG67CEoxHtYwOB
 pxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719651395; x=1720256195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uV36Gt3F0NFarV2rkaJX1rYzyXO0vgzu3txrDL4RZ9o=;
 b=H6TaeF+Q2sQF9SJVblBWHEDfDKm8fP6QuUDcsT80oQkR/Qatz/+K8HNe7nEUnFtOXX
 /S8A7UO+bswfNhZMOuIDfEOygeAmt/Q1uAFjE7I53dqlj58PRLNtdty+2eFivzm42HR0
 AaYVPTW+e/eUFVtI/JG8hHbY361MZhNsi34b/VqP4z0sweeQUD9ZaTqsuVDvb76YppFL
 muEXwiHnaCa3EY0hg6R0hNCxqtxkQzeZa55gOS9vfsNM/WbPMYQAgS8tvoUGHMPNAlbd
 M6yrgxhiAQuWsOItY04pC6f57sM8mroRuj7pQY/+C/HFjUmzDBqK6+8r3d4Zh1utEqLr
 WU9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoEE++h/8vhM3wpGsM7CZ6pCEOy2/qWUWOVd5CoI2aLk+42fjrRmPI4yXM32a9D8FVoJ6nG8kK65IY/zSL/TEkdwPJ8ss=
X-Gm-Message-State: AOJu0YyWWIAxthgq7xwahwqtU7BNJF0MjvvVOkLiMldIQF88gy5rXzbi
 +w54n64hR0T7M1oD2a1mai42qZJ/EvkKvNkqZPLJOzpRPdGp2ptOoEAYDt5JhzApPiqv42PNBC0
 CGe4=
X-Google-Smtp-Source: AGHT+IHp6po7/G9WybAOHrGE72hCCzpTgJQt4bM9E0JvKIFkPN+wRZh/Wsv6OaWcEj/cQJBQc/YfUg==
X-Received: by 2002:a05:6358:2809:b0:19f:436b:f6b9 with SMTP id
 e5c5f4694b2df-1a6acef67cfmr47311755d.32.1719651395347; 
 Sat, 29 Jun 2024 01:56:35 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c91d3ea47asm2889625a91.53.2024.06.29.01.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 01:56:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 17:56:27 +0900
Subject: [PATCH v3 1/7] tests/tcg/aarch64: Use -fno-integrated-as
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-tcg-v3-1-fa57918bdf09@daynix.com>
References: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
In-Reply-To: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

clang version 18.1.6 does not respect -Wa,-march=armv9-a+sme without
-fno-integrated-as. Use it when available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/aarch64/Makefile.target | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 70d728ae9af7..05f98c80c88d 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -20,6 +20,9 @@ run-fcvt: fcvt
 
 config-cc.mak: Makefile
 	$(quiet-@)( \
+		if $(call cc-test, -fno-integrated-as); then fno_integrated_as=-fno-integrated-as; else \
+		fno_integrated_as=; fi; \
+		$(call cc-option,-fno-integrated-as,            CROSS_CC_HAS_FNO_INTEGRATED_AS); \
 	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
 	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
 	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
@@ -27,7 +30,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fno_integrated_as, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
 -include config-cc.mak
 
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
@@ -69,6 +72,9 @@ endif
 # SME Tests
 ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
 AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
+ifneq ($(CROSS_CC_HAS_FNO_INTEGRATED_AS),)
+sme-%: CFLAGS += -fno-integrated-as
+endif
 endif
 
 # System Registers Tests

-- 
2.45.2


