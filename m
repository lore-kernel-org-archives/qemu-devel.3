Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A655CC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNzo1-0005Ms-Jb; Sun, 30 Jun 2024 15:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznR-0004tl-8z
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:09 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznL-0007Y7-K6
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70aaab1cb72so979421b3a.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774062; x=1720378862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGOc0p/wwE/PuqcJ9S9lIVymEvPJ2X+gCQchQONAjmE=;
 b=jLD29yoSQztoXt7ksbZ6HGrAUjSjeE9jRKjMI8OEJN8dTDLigjwiNzXk4BMUmAjRme
 IxrD0vRTtM+uNK9Y9kzv8BXPNbPeh4VxLG7rp91W3gsmPEDFsYLNVzhdagGd3W/xsK33
 I+sd4lky/wWdx4j1EwiXdyQHor2cgG2aXpxofbcxBliO1IX86aA71PeVSmsTqbU9wmZU
 gFc5ww7AqNRvE2lUm6D3clgoMCtyOhXOG6qZZ5n7tXmnQtqltMJXzFQwuMwOEiNXw+EY
 1lxRKeCqbLyOzUhTHxuysQYo4SNy9hEdOaRNZjEr1eWtT5TmM5nBZBtm9bMWDvDG0O/I
 lqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774062; x=1720378862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGOc0p/wwE/PuqcJ9S9lIVymEvPJ2X+gCQchQONAjmE=;
 b=Le4u3Xndhw9biLkH20L37zw5kN684zI6Npo0TCBCbzZhrcFVy5AEqC5H7ztUOpBZ+C
 1eijzf6fq1VVWakH/q6zGCW3g2Rvk4ZruoKH0XikqFUWB/NeTxROHiPtlk3k7ppCabUq
 qNTOyggaEt3g5r3BMoc/8Wb6NgBDHxh1RJZ5ST4WIOxTrm1wMuhT/EeCOMjqgsC0KyIQ
 bLubAyNG03/QobXOCvhWIk4ObZJ7qetLAiyt0g6hwMcOWt5ldaRMk7xpqVU+dKCn6z8p
 goBZDnPw+aUtTfojTJmECuzE4zZCZXvl3cYvgYGgQkney9jnLQF9Dp+gdMoboDIn/Cv6
 dmkw==
X-Gm-Message-State: AOJu0YxOXlE+3Vbp9JID/dij6uvqopMNBRpybQuarwVEhw/eMcXk6f+S
 gaq35W3HthZU0MFjBGqlQDUEIW5U/oxE1V0+04d6drw1XyeQmd5vfpGzS01QX+ZppUvzCf6Cfgs
 D
X-Google-Smtp-Source: AGHT+IGOwn/Wjlvb0Lp7hBSnoPc6xk/p/n49YaGfx8MZBEyqvZ8aRawi6YB7EhFLpclWGQRn3NTs6Q==
X-Received: by 2002:a05:6a20:da97:b0:1be:f8e0:abac with SMTP id
 adf61e73a8af0-1bef8e0adb8mr6733442637.45.1719774061910; 
 Sun, 30 Jun 2024 12:01:01 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:01:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 10/14] tests/tcg/arm: Use -fno-integrated-as for
 test-arm-iwmmxt
Date: Sun, 30 Jun 2024 12:00:46 -0700
Message-Id: <20240630190050.160642-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Clang does not support IWMXT instructions.
Fall back to the external assembler.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/arm/Makefile.target | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 0a1965fce7..95f891bf8c 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -8,6 +8,11 @@ ARM_SRC=$(SRC_PATH)/tests/tcg/arm
 # Set search path for all sources
 VPATH 		+= $(ARM_SRC)
 
+config-cc.mak: Makefile
+	$(quiet-@)( \
+	    $(call cc-option,-fno-integrated-as, CROSS_CC_HAS_FNIA)) 3> config-cc.mak
+-include config-cc.mak
+
 float_madds: CFLAGS+=-mfpu=neon-vfpv4
 
 # Basic Hello World
@@ -17,7 +22,8 @@ hello-arm: LDFLAGS+=-nostdlib
 
 # IWMXT floating point extensions
 ARM_TESTS += test-arm-iwmmxt
-test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16
+# Clang assembler does not support IWMXT, so use the external assembler.
+test-arm-iwmmxt: CFLAGS += -marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16 $(CROSS_CC_HAS_FNIA)
 test-arm-iwmmxt: test-arm-iwmmxt.S
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
 
-- 
2.34.1


