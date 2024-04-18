Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D904C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTYo-0003HM-71; Thu, 18 Apr 2024 11:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYk-0003Fo-TF
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYg-0004XL-Qo
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:21 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-346b96f1483so597190f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713453608; x=1714058408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LjzFedX8f7dPOTCE2RgQfLW6VZSYCvlcrFVxlukFK5w=;
 b=h/c9CpRD8tVhvI+wzfQwbDVAq2aX8pu8nnHQp4OKp9vOF456TckJPuzkfk4l93oQzu
 j4iPN/vWFL8sQuwDxI8ggmMGW1enE2lRxxO3jBNZrc4d6bfxwvmnYXOCpRdsG98NG2TL
 AX9Fr378wRVF6sBG9oY8YNJgvgZFAuYBLajBZ9L1deD+VT37jFYF3IaF9FmdYxMQh8uk
 3DPQYEKDCzU1gPvJi70R3guCvENMCKPvY5+rwlZn/mSb2iEa5X+1UG0rzuFOzald3zgD
 vt+gzRhLn3PS9GKEorez1RlgnUC1V4VBeuioSAfEXYGW1bEx9yoAFTz7Tf7Jhm/kfYlQ
 o0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713453608; x=1714058408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjzFedX8f7dPOTCE2RgQfLW6VZSYCvlcrFVxlukFK5w=;
 b=MhKTigXyDW5fybpzuSQii2QvCzGuMEJeksIXncWQ6F7nrZRiMmJvnn0Kz2YInEAU84
 0CuysQFERumN9ob1q0rJ/bV5lhbU96sBRyapasGkpOpiN3eSAokRPXsLQwdCBOCutJHN
 CYmLPQKLQ8/cZ0vx8HJmX7FkJzr6bcin6ZJ3QdGwsJFWAJyarVXYjWFaFkLQAa0BOHP7
 utbfBXW+QbEwsXxv5+6FWEcc/dMVZk+2QA6XiP6HPfiq3cN2NeaQS09JkRnS6Z5DpEMz
 nUKS1dk7J9q5UO6HKtTiv72hqIuyJdB/OJt5hjaP1AQXoAEiDdj0CrENjwyUMMMis/Jj
 bNCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTWf6sKQeMVRvHI1N9ihGPxPbeYu/URP/V5JSOWPWuVmPIP/lB5A9QcE50XEASEkAnsoiuuoXIHHU37j8f8ZL31omFRTU=
X-Gm-Message-State: AOJu0YwgSK0Pr8Ay2ER2qF2sA1zVtow913fSUvPbPeTh6/FtDAXkXND4
 jeQSj+S6g6Sqq74p3ojoUucN7bKSqeROvJIsxGRDmppkeSKxz0hYeRjGNY7DMOc=
X-Google-Smtp-Source: AGHT+IGLlh3H1wSS698OPf8AjA3BZ0333CRKF86zqQiqJWwum82AyWEx4ucY1c3aFsnN+lsajDLR7w==
X-Received: by 2002:a5d:595e:0:b0:343:d7fe:96f8 with SMTP id
 e30-20020a5d595e000000b00343d7fe96f8mr2154243wri.19.1713453608118; 
 Thu, 18 Apr 2024 08:20:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a05600c475100b004162d06768bsm6886839wmo.21.2024.04.18.08.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 08:20:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/arm: Enable FEAT_Spec_FPACC for -cpu max
Date: Thu, 18 Apr 2024 16:20:04 +0100
Message-Id: <20240418152004.2106516-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418152004.2106516-1-peter.maydell@linaro.org>
References: <20240418152004.2106516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

FEAT_Spec_FPACC is a feature describing speculative behaviour in the
event of a PAC authontication failure when FEAT_FPACCOMBINE is
implemented.  FEAT_Spec_FPACC means that the speculative use of
pointers processed by a PAC Authentication is not materially
different in terms of the impact on cached microarchitectural state
(caches, TLBs, etc) between passing and failing of the PAC
Authentication.

QEMU doesn't do speculative execution, so we can advertise
this feature.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index de39110692b..fc616e48d30 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -60,6 +60,7 @@ the following architecture extensions:
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
+- FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index da15182595b..c3369f40824 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1216,6 +1216,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
     cpu->isar.id_aa64mmfr2 = t;
 
+    t = cpu->isar.id_aa64mmfr3;
+    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    cpu->isar.id_aa64mmfr3 = t;
+
     t = cpu->isar.id_aa64zfr0;
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
-- 
2.34.1


