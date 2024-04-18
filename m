Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDF9C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTYv-0003IZ-9G; Thu, 18 Apr 2024 11:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYk-0003Fp-UV
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:23 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYg-0004V6-Ou
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:21 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2da0b3f7ad2so15231541fa.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713453607; x=1714058407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HR4H5Zi29P/KVcxukA597bVylKrZeVE9mrUkxAza3G0=;
 b=Uw1IcSpd38GmcAMGiHnEgiq51DsFb1zACQ64rvtGxrHxvCOLzVp0Q3Zrqs/xsUdh7V
 u+EfBQEXRZOU6Wg5ByIhDm9lPewZYy4ls35z/1ux1AGNNBu8bNV8do7euKDGE8q89cu5
 f03IMKn1WNb+YgpkZaxw7FGnIXjbCfYP5MVnLCaDAbR6XYmQAZCksurHlb1cP9AwRiL3
 IgbJ1Wf1jb+DIAjlryxkPHYUt2FoyRIxp4q+ClTVpZAQQ7mK8H8c5xOHDurFgN8dNVrR
 WJWOFy1fprfeap/PbchS3XcVlycsRvUYza1dvfwwEf/agk/Pa+6s4fbfNVbVTaMV8MGs
 hx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713453607; x=1714058407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HR4H5Zi29P/KVcxukA597bVylKrZeVE9mrUkxAza3G0=;
 b=DAWc0A9K5WMbDrQoYkUQT7TynyhRoI2fy/tJtB1EinOzaOuBrcU9fN81BBqXzVHRcv
 EX23j9Mj3UPtBZInGI+tQmv2opre7f+thLVK1bxOFrB2QDgJnn02jXT5XxIX/mvstmeb
 ynJB5b3BqfPq8/0lfi4FzXLzz66Vjm8tE069QI1UF3qXzjHo88DExTp7THXxL22k7z/G
 DJ+TShosoIQZnpF+w42MaBhg0rYrCgLFiT94AsptnkhvpyESD27CufzGl/Kmw6NWdDT+
 dnDB6aOOnG90Sxxm0DC80sx36D7xWHw56VSBh14HEaZNJEt853p6ITFwemBo+AXzhb3R
 Y1LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAxlAV+Ee2qNpJ0OdfEk84XBGj6wJxEcWz2Gu4k6czXW5K2Fdqh5M+1SrNnVAMFzEyMOKK6HRdoQU4d18rEtQblDurvII=
X-Gm-Message-State: AOJu0Yx0nqUsMPCxXbSkcf64meW15TX677cVNrbfeZO9fqksKWtWCZIi
 DvXbzBFXMsJICmLeKwgHvyX1XkBPaOaLqtKgDfPEq0PuX5kbAN9dmn8v/D7KsuqPNdyQVeE5C1+
 y
X-Google-Smtp-Source: AGHT+IHDtRX+s1IKXtGvNGAwje/Opo7YJZ+DNv0lqy9/LgRLHZ/aHNQLs1S+Cz74ZV3kq7SS4Mg1WQ==
X-Received: by 2002:a2e:9296:0:b0:2da:8fd4:fb1e with SMTP id
 d22-20020a2e9296000000b002da8fd4fb1emr1973807ljh.21.1713453606575; 
 Thu, 18 Apr 2024 08:20:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a05600c475100b004162d06768bsm6886839wmo.21.2024.04.18.08.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 08:20:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/5] target/arm: Enable FEAT_CSV2_3 for -cpu max
Date: Thu, 18 Apr 2024 16:20:01 +0100
Message-Id: <20240418152004.2106516-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418152004.2106516-1-peter.maydell@linaro.org>
References: <20240418152004.2106516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

FEAT_CSV2_3 adds a mechanism to identify if hardware cannot disclose
information about whether branch targets and branch history trained
in one hardware described context can control speculative execution
in a different hardware context.

There is no branch prediction in TCG, so we don't need to do anything
to be compliant with this.  Upadte the '-cpu max' ID registers to
advertise the feature.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 9388c7dd553..958c69f3799 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -31,6 +31,7 @@ the following architecture extensions:
 - FEAT_CSV2_1p1 (Cache speculation variant 2, version 1.1)
 - FEAT_CSV2_1p2 (Cache speculation variant 2, version 1.2)
 - FEAT_CSV2_2 (Cache speculation variant 2, version 2)
+- FEAT_CSV2_3 (Cache speculation variant 2, version 3)
 - FEAT_CSV3 (Cache speculation variant 3)
 - FEAT_DGH (Data gathering hint)
 - FEAT_DIT (Data Independent Timing instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 9f7a9f3d2cc..4445c5a212b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1159,7 +1159,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
     t = FIELD_DP64(t, ID_AA64PFR0, SEL2, 1);      /* FEAT_SEL2 */
     t = FIELD_DP64(t, ID_AA64PFR0, DIT, 1);       /* FEAT_DIT */
-    t = FIELD_DP64(t, ID_AA64PFR0, CSV2, 2);      /* FEAT_CSV2_2 */
+    t = FIELD_DP64(t, ID_AA64PFR0, CSV2, 3);      /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR0, CSV3, 1);      /* FEAT_CSV3 */
     cpu->isar.id_aa64pfr0 = t;
 
@@ -1174,7 +1174,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
     t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
-    t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_2 */
+    t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     cpu->isar.id_aa64pfr1 = t;
 
     t = cpu->isar.id_aa64mmfr0;
-- 
2.34.1


