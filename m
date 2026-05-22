Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A936FCD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXzF-0001tQ-Vy; Fri, 22 May 2026 18:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxt-0007ks-0J
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:36 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxo-0008GH-JL
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:30 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-367cbac9cb1so7414875a91.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487405; x=1780092205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJncXQdI40tUDui4jfOpY7wY6z/VL6EnB2oOLxS1dCg=;
 b=utauFvTRgfE4pRQ006qkNGv5DZy4g1jmA7QIcDnFAj2K1/tBukU6pzP+Bhac1FhrcY
 jFnO1mdOEX/3YUxcZaUpzz2QHdn/WkUfCV+72dT+ETVDe2ngbW+BVVEP3DVPM51nd3EV
 QL7V1uaFYG650xGp5/PNYWJmucp+q7ub30ZUkbIDzgk63EIcit0kkVWywY0RrNSlH1O/
 jAo0QAnkDdVl0pFYmUz9KC8mTAj2FZPlRzXU48dWMD5ICRhFljJ3dI/BJhIvTy3bYbqJ
 O9Qpful0X+d8yz2YPKl+Uu8exokOiH2tue1jDdlzmcWbMOjTIY5Ml2U/OwTRxgjqyuhw
 PlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487405; x=1780092205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CJncXQdI40tUDui4jfOpY7wY6z/VL6EnB2oOLxS1dCg=;
 b=d1gg3DBRVqaON1aWwJuCt+fpQRw81f7idLR51SVTISgQPWCIHTsmmhf3GK/H5xUoG6
 bCFuG2KysOEjsPZKqcT/SAcRBb6nHoLff1s9JIbobGcuTSJI0pP1Y9ckgQoh4R2snlN6
 ULw19LlWDKPiwuXvz7Wx0aAPFgqpbNliiW1nZ3e28pLC/IWb1MDRmODxpHDuzma8MBhV
 hjm5He2473h/OEEjuxlwleVPWmKct9ZxjiprHruwx+hBV2CwI0wUab2xQB5WiCxlAjpZ
 g69m58MdV7EGroVDTrZmrGUMYDjDyG0SLr7HjBDwpgaTn7WbKq5IE2Cs8F/I0cdlh9yw
 tJuw==
X-Gm-Message-State: AOJu0Yxt28+74L1qHQ2KGpoB3JPfVf9cQcxx/t02MCiXG6mRno9yhgjC
 JryQFV2e1TiwN7yx7dLYfn1J3LlqR29c/JSTJnKL7J9cD0WDoL2ReAmyXYhrdxfFlCiopIv1mgo
 1JkcX
X-Gm-Gg: Acq92OElAPS1V+Krw9aTyw+mQh91+CLNzdBpyfSYNYG/v2oUm6M3ALwN9XT0mB9lnpf
 jvejbsgPhc/cJTpb4eVNAW1ddkCwcQnUEs0wENxbWp3HEwgy2Nc3JjItJbYNO+HAWwYwtvrKRDl
 677JK5BE8OSutN/mtfpxYm+3955Dl+YuATZibNJeEcHgE29+9LGc6nDVRediqTvq0mtlyUfNHQC
 Hnfwveb/OgwybZIVtzN3N/qGvikXK+IucZeoaxtdU6BtikXwM4m+YlSA8WfbYYSD6neb7eYfFkd
 mLXOIuPqK68cWOIRWFL5YKekOLjdsB95qK87DVEIfraJmrE07eOEH+LXTxlo6JS0vl1mKvUROps
 3yc+lOkDTFaLfTXUki+8rZz/lFBAhVzUUKOaqJ4r64NpQU2pA01nFXry+gYsIctkB2W5cqWHD3Q
 0xwv2iDEfxPKdCQ2ktxO9FcMa2PfWe
X-Received: by 2002:a17:90b:48c1:b0:35f:c729:de9b with SMTP id
 98e67ed59e1d1-36a677f44b2mr5682455a91.20.1779487405383; 
 Fri, 22 May 2026 15:03:25 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 17/64] target/arm: Enable FEAT_FPMR for -cpu max
Date: Fri, 22 May 2026 15:02:19 -0700
Message-ID: <20260522220306.235200-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index c5ffe21368..ceeeee5315 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -219,6 +219,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_cssc, ARM_HWCAP2_A64_CSSC);
     GET_FEATURE_ID(aa64_lse128, ARM_HWCAP2_A64_LSE128);
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
+    GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ff0c2b1c47..a377f67b9c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1297,6 +1297,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index da5f7efce2..e44b3016be 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -77,6 +77,7 @@ the following architecture extensions:
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
+- FEAT_FPMR (Floating-point Mode Register)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
-- 
2.43.0


