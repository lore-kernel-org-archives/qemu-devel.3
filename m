Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70F7CD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC78-0001kM-Kl; Thu, 05 Sep 2024 09:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6w-00012c-8U
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0001jj-7O
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42bbbff40bbso5920565e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541270; x=1726146070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UEqv69UXTmYHkRInh7zHHsDNkedM/XSTNS7ye2GCeVk=;
 b=EBVZnsKRPkCq5VFsj5tLv8RHf6SFoFyn7ehDt+M+E1+yueN5t/Mrv0LRxuyJk1/xQ4
 bMEAGdkQNLgoZq4A07aQZLGzzpeaS8YNJ6jfBiTnnOGqRAJvw2mxB0UeM/TB1J/SyzQ6
 +RnBblT5EvbCLqgzaWiIN0B5ZAkDYZNGLsjk/nBL37E5XIiSbrnAdYm5oryqPIvcf3p7
 4cUfKEMiI+SUUd61Gy5aJD9LQgzDjlQpdSpRUwBzWw4FBK24eaw/be1nvUzPkuRhebPj
 rssOGyMCvUNMe2XaK/ymFCYA8A/QaehCciH2QBuna5P87wiqn55KsL+royaesz+CUyQE
 CE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541270; x=1726146070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEqv69UXTmYHkRInh7zHHsDNkedM/XSTNS7ye2GCeVk=;
 b=VXl6n7epB8AeBuj5AZq6biseO9Q3IbE+be+LimoGRfdH884ai5hAVyMTE/kako2YTd
 D5tzvn95ywGsuFfx1YFrjpfaHQOg4jskmTayHTsjQ1m56POvY1wyezLgA+xYuyLeOV5A
 UgzxysHLNDVMYx4E8qsKOePzlFXPWuTAzMRsJGsOJ9B65foU67NOdZ6pumJSye7y/4Tq
 rQO5yyCqwy7OSL66BlNmK295FSAjFw2I92FhyMnT9Mn9zGEyKe/iCp/Mbs22wEjwCN6O
 gM0X4+kZI/Qo5aWckjBmFK2TdUZc09RcyKKUI7a97AQTrXofinkTTNngvxAGx8WXOCG3
 SJQQ==
X-Gm-Message-State: AOJu0Yx/sder7HTmIFRmyX8gtAPy/cxFSs2hzVYVeEQoGBgqR+MuoJuJ
 dywaRmKYB+BOqELFd4dn2cke795O6oCzaRXc+AKfnO/9lQfcIbq4R12JIicXCgh8JuI/O9IQCIH
 k
X-Google-Smtp-Source: AGHT+IHG4NdSBMAvDgbXkSjwvGPRl1s2tE4Rmx+M/pLlqByDpSrG93liVhZ7Cfe9UD04zZNPZ5u9KQ==
X-Received: by 2002:a05:600c:997:b0:42b:ac3f:f5c with SMTP id
 5b1f17b1804b1-42bbb436de5mr132747045e9.26.1725541269181; 
 Thu, 05 Sep 2024 06:01:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/25] target/arm: Enable FEAT_EBF16 in the "max" CPU
Date: Thu,  5 Sep 2024 14:00:43 +0100
Message-Id: <20240905130100.298768-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that we've implemented the required behaviour for FEAT_EBF16, we
can enable it for the "max" CPU type, list it in our documentation,
and delete a TODO comment about it being missing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst  | 1 +
 target/arm/tcg/cpu64.c         | 4 ++--
 target/arm/tcg/translate-sme.c | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3ab6e726679..35f52a54b1c 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -45,6 +45,7 @@ the following architecture extensions:
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
+- FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
 - FEAT_ECV (Enhanced Counter Virtualization)
 - FEAT_EL0 (Support for execution at EL0)
 - FEAT_EL1 (Support for execution at EL1)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index fe232eb3069..79258a7c928 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1160,7 +1160,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);  /* FEAT_FRINTTS */
     t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);       /* FEAT_SB */
     t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);  /* FEAT_SPECRES */
-    t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 1);     /* FEAT_BF16 */
+    t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 2);     /* FEAT_BF16, FEAT_EBF16 */
     t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* FEAT_DGH */
     t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
     cpu->isar.id_aa64isar1 = t;
@@ -1244,7 +1244,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
-    t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 1);  /* FEAT_BF16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* FEAT_SVE_SHA3 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* FEAT_SVE_SM4 */
     t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 3ceb32e8bd9..01ece570164 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -362,7 +362,6 @@ TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
            MO_64, FPST_FPCR, gen_helper_sme_fmopa_d)
 
-/* TODO: FEAT_EBF16 */
 TRANS_FEAT(BFMOPA, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa)
 
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
-- 
2.34.1


