Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DE6CD6E40
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmj-0000uu-VF; Tue, 26 May 2026 10:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmh-0000ir-1Q
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmf-0001NH-Gn
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so43283655e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805768; x=1780410568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RWd86sD9FLzj9rOo7wnk6NltKwMUrhT51V/lU6MpZik=;
 b=R9Lcl8xf1LcU8DctDSy9o+mcLuk4nppjRxDEzQ4fAneKjC3MBNOVPc/tokLAyVac0f
 kSxJn0+h2gGdkEZU6ldRz/lEK4gkfUwceAyEMljoZqAAbkwEZ/xjQzz6nYLEPuQg3Tza
 apXdcP60hvcaGc5Zft6j8IF7Altu1aBWo4NFxxCWaBqQy4V97C1BB3KoQ/Vi90TuHP8b
 GEJaWy002BfExw7G5Yg3d8fXLgqdg+rao82E4AwXmRFHLaMOIRLlktkRu8coqTQmlpIQ
 jPjQQmNkxa8sXbGhkkNnI43WzuvG7knhqwFafII9pZb9/1SIo3PsZ85n7a21E2ODSBj9
 SXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805768; x=1780410568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RWd86sD9FLzj9rOo7wnk6NltKwMUrhT51V/lU6MpZik=;
 b=T+Fk7DKnKIgazUhmI23sxM01ZmGWBkHFF5JSInZ0pV8EDEO/7coUTyb9EBDlWFfJLP
 F4ctmtAothL2mTaD9GtkmphtdNLWDDjQAeLBjw7Qqn1G0PtYaTXWZ69oL8p1qexsogUS
 eQZ/HhUKclwBx8VoNh9tYMH4QshHyvPYhoLJGBMphM8Tu0bCYxMmCF3MjGCeMi3l40ei
 zeXDIHQiNwZYebVW93NW6vOmSX0rnHqlmy1pbkvZKOkSDan/481GE6jlEddeljVSnFq6
 v+qURbsVpN9LuHgDT+AxA/LV1S1xRFPeAlwYb4yzXgvIGnokNS6K9zOOT1VHGv+zAoSW
 XG9g==
X-Gm-Message-State: AOJu0Yz0AxKHK4MdAz1+dxZ83jV3E0PmaeKGkI4QYWwgbnYSBIzApJtD
 RiRXj3eBLFByYAQfZ1y+Z2c/G4XS99perRoMMQzZj3e77n69wxP3kBYJLM0OMO8FOIIkva/+pua
 Q41cl
X-Gm-Gg: Acq92OHW95q4ef7wcaqmQ/SPiKyhTjGjwNw1NIqrNDU/dp9XIxf9Fs15ttZVNgD9ZZw
 ntCzD9iW/v4Z5zzm6zKISmOrTYp9wxRuUn8i/18029Z9SloeurClUEI+yJOvwayZZ1PoCoMtMiL
 Xf7gd/bys5JQPYy5QtIMFkqemXbKQS9u+jzsogSjsJN/DZpqpaK6Fm4S4P0etJg8Ct5QWiZ9lpK
 XNquH/wN/z6qfJ8rJzMYafhgFOu47+K3hRuiqky+0zsfMZCS/F1VOnAI1/XiyP+BmL2ZzHdjRoh
 w+EKMXTtoRsEuAiIlNyoo5jEbxuTHn6JFDuLHP6roc48AgnmdhCBp+wLoMXXQo9QP7p9QANkmj/
 rUQkP1cesjtulLbYI6jD3M8+LfXTLSdKww9GKSxrR7IjYh69bVDlu81H0aLBtlGJXowTjOF6M2u
 K9mW0cvuRay+k5vzLZ3EjiYGkkpSaGj18xBQeg4bG/tzTp1PUehQkM1sfyP3zE6CetW0tR1UB1R
 UXSw/L9rnTdz0L+OjjWCJuUWkbvp10=
X-Received: by 2002:a05:600c:4ecc:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-490426d06c0mr320318875e9.18.1779805767871; 
 Tue, 26 May 2026 07:29:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/54] target/arm: Enable FEAT_FAMINMAX for -cpu max
Date: Tue, 26 May 2026 15:28:32 +0100
Message-ID: <20260526142850.2326589-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 8cd7fe7b00..da5f7efce2 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -68,6 +68,7 @@ the following architecture extensions:
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
+- FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 3af5a37776..c5ffe21368 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -218,6 +218,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_sve_b16b16, ARM_HWCAP2_A64_SVE_B16B16);
     GET_FEATURE_ID(aa64_cssc, ARM_HWCAP2_A64_CSSC);
     GET_FEATURE_ID(aa64_lse128, ARM_HWCAP2_A64_LSE128);
+    GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 649d854a65..ff0c2b1c47 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1266,6 +1266,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
+    t = GET_IDREG(isar, ID_AA64ISAR3);
+    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
+    SET_IDREG(isar, ID_AA64ISAR3, t);
+
     t = GET_IDREG(isar, ID_AA64PFR0);
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
-- 
2.43.0


