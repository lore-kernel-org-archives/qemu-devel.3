Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA06C3065B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNznR-0004uN-MA; Sun, 30 Jun 2024 15:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznO-0004qD-Id
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:06 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznJ-0007XH-Jd
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:06 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c21ef72be3so1296293eaf.2
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774059; x=1720378859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psgLRimYc7hhYHP+Xsf4Ia/WwSlMX4jHMC7bGhjvWQ4=;
 b=s8W0zGd5e3AqOe33TG8kxG+gWhSbY0EfVXtiuaa1ifNZ7rPcoHWcSkO6tuxjy8hGWB
 B96Vemsp4sCQtJlgZKFRScrqtJoWmNqzPXn73UysK1UIA/kuY7T8wj+5CPPRaY2772Ob
 RXgUiLlzzgZZXoujMPh8su7dUIVWuBeiWCC+U50MYAYyPnx4CA0Nk3J6JTbjEOjCrYZ3
 kvWLm92garvSr7jE35SBK+h+XzMsioVcj6tkvEKh40VRqahtcXyRgUKHH05jWtuLcoKZ
 j6zd00by+/iA49ZYDZKDEtICSq8bg+68nRmfPxywZgiUl+9QXAx3XDzP4suYzKsmtIrI
 uGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774059; x=1720378859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psgLRimYc7hhYHP+Xsf4Ia/WwSlMX4jHMC7bGhjvWQ4=;
 b=FsCI2jpn5wNgzEY4yHpBgM5xjrtNLcqwtouH7bMHRVd/rlIhaKmDgVIR0rnupmR/5q
 Y+ajVbIoSXm0L7m1zybQOuWFz+NRALDJtiqX0v5xXY1wztvJm1uISvZqSfBwbnUcKiev
 zPYUShx5f1Pb1It+dGxMS2FZS9Eb03RxFLXjd3bbBl0lzWPxewyDw08OvsWBDyD7/eDp
 IAtt+2mjwU7VXms/5DjhuIKdql7VZ1BnFMph4EW4kpSP0rkrr2YlfWo3qfvZQDzEJGi0
 rYX2wyCbYBvaExMJRvUUh10C5Rlox7a/zLckMkRQngVBBkIAiEAwIZFhYLfj8+jyqqX8
 1Kcg==
X-Gm-Message-State: AOJu0YycXYpXLMTh155+zIb/EGh+2Ui29W3MjoY9Sg2QQR7JTxeUyADF
 Y7p/0HlANpT5qg2ZJOBWxQENxZtB/1edvO6wwTRRLNhHR5p5qaGPeaKgG/b1rjwo62mRtegJ7vF
 A
X-Google-Smtp-Source: AGHT+IH4dgpzgllKHMLgp4z0Nw27eBMZnLXBtnArC+sq0P24gu3dvDxgCcrOX8QnvBGGG2N5iPVVUA==
X-Received: by 2002:a05:6358:783:b0:1a5:f95:328f with SMTP id
 e5c5f4694b2df-1a6acc6ed86mr334101555d.13.1719774059140; 
 Sun, 30 Jun 2024 12:00:59 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:00:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 07/14] tests/tcg/aarch64: Add -fno-integrated-as for sme
Date: Sun, 30 Jun 2024 12:00:43 -0700
Message-Id: <20240630190050.160642-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

The only use of SME is inline assembly.  Both gcc and clang only
support SME with very recent releases; by deferring detection to
the assembler we get better test coverage.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/Makefile.target | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index e6d5e008a8..8817ac262f 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -20,6 +20,7 @@ run-fcvt: fcvt
 
 config-cc.mak: Makefile
 	$(quiet-@)( \
+	    fnia=`$(call cc-test,-fno-integrated-as) && echo -fno-integrated-as`; \
 	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
 	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
 	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
@@ -27,7 +28,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
 -include config-cc.mak
 
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
-- 
2.34.1


