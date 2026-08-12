Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A560AC5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFp5-0003xu-6N; Wed, 12 Aug 2026 16:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFov-0003gR-NC
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:45:05 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFor-0002Hr-BD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:45:03 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so1776023b3a.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786567498; x=1787172298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HVz7XyXfarYFj87pn3VREzFlHn04zawcDPXc8eqMiA8=;
 b=zqlcOURVmNixgzYTwj8i2YZn4y+/pnbFJqHZd2lhuRw+LR+HQxwlV66HH1ii5bgDp5
 J1w1JfCAyJLgTcXOmxtO4iH9R8hFIkYdyW0fpghvgHHjWS/ptXrIh7q2uCb9Ukg4Pd1f
 KjKdHIEDl3FJXRU6o/Q7bwszKVK1UW86KU1IabGxk1eiGuvaBFzluXduNJuy3ZZUwNut
 rbDKGWXl+bO0uUjz36MHVncdooWnWbrdQLiZLx6XKIl+UmqtQ6exvZppc2bxk9Pgpd5B
 bqdePL4kvUB9akv/NUe+HKD8SZo/UBTbOvsJRL1zI0nlhWC1CYCFp1flbqtBQf+c7FJX
 OlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786567498; x=1787172298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HVz7XyXfarYFj87pn3VREzFlHn04zawcDPXc8eqMiA8=;
 b=hvwDAVyRJimqKaKRUvnrnAM4YD1ha5iVr0J5QDqwDeKBvAv2B6vnLZl2N8oTm2xHmJ
 0bT7ZnFJbYhHYBA+x4N6R6l4Wt/nJ3jhkdiUiVqmifvOiFfYLMF2uwonRcuyrC8+BfDz
 EPJEvUeCZbkTN1Z5vgvZxdmW0+bDd9H2oePGlLhvo6CTyD7dR5XV4muL6jpUCQacPKkq
 fItry3oKm7E++B6fo2xSCM6OFEN0It4VQRxBW4W13w86Pr79t+l1H4YfT6yAcmWe5TsZ
 3quPvaPC2mK0xGTul5m2eOy+rQFhIZroF7pqnxxiJJH1Zpmqw5oJgfkPvHURL9A6IThe
 YpFg==
X-Gm-Message-State: AOJu0YyWjR5RrW4Es6/PR6hsaVBqsM54tsvDUdqvgMeuBWTuCQ5WHXty
 vhTg7vGK7keRxBvez4OmulBQ7NpQ+3JjBAEV5x6uyEX7CqRP1LEt5MagCknx5Ea4DD6YklymehI
 IYPV2
X-Gm-Gg: AR+sD12L0UqZCaN3h2FErfG8WtL82fjYWaUNCRos38kzweaHt3jB5kAmGaQUpeLTl/J
 a4PADUTfgmdb5O4LoJDksefiqQoyPffsf3O1Iy2ozRA9Nk1TWeYMOrU+fPR2OIBkWrLmoJLNH86
 RGQsLvtf46KYkBwVRLKNd9SWN189uQn0T2OxqIrMdeemcF0jW+CHotFzKQOLyV9+8wGAmeBEZyR
 OPO2un/ZVFRSTvE1ZJa+iQnHPFlxmQpQJIxFZK8Kb5sL+eYMLkFocXLnJH8HTXmGHhuiV9dTjsc
 TJikOni9i4CsdAiMizKakaT+/ALEa4GZCf9zhmg5ff6+LDCxdj76x4jwJkFfo0ZCLTY//Gyg9bS
 YORz2/OJo1zjbSfplFh3UzlmWZDhgWtErXSEl9om1Us21GfVPtBjHbtvxxFHyx4oPFe/eG2HyLm
 IA0/z9URhk1M1rJ5lzo/PRqIvvOI+MIojhnN6rxNda9IkJBuRcMRjo+5XQJEFP6wN16sacACByF
 Xmx57axrqAZe9Le0r1/tXVoxkJkzPk=
X-Received: by 2002:aa7:914c:0:b0:848:425a:4e31 with SMTP id
 d2e1a72fcca58-84fc751bdbcmr586910b3a.24.1786567498100; 
 Wed, 12 Aug 2026 13:44:58 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc4787325sm125308b3a.23.2026.08.12.13.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 13:44:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 10/10] target/arm: Separate cpu types max-v8 and max-v9
Date: Wed, 12 Aug 2026 13:44:35 -0700
Message-ID: <20260812204435.295067-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812204435.295067-1-richard.henderson@linaro.org>
References: <20260812204435.295067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Do not include v9-only features in "max-v8".
Do not include the prohibited v8 features in "max-v9".
In tcg mode, define "max" as "max-v9".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h        |   2 +-
 target/arm/cpu-max.c          |   2 +-
 target/arm/tcg/cpu64.c        | 162 ++++++++++++++++++++++------------
 target/arm/tcg/stubs32.c      |   2 +-
 docs/system/arm/emulation.rst |  11 ++-
 5 files changed, 120 insertions(+), 59 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f6b4e173a5..95b201dac3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1809,7 +1809,7 @@ void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
 void aarch64_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
 void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
 void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp);
-void aarch64_max_tcg_initfn(Object *obj);
+void aarch64_max_v9_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 8d968336a8..415142acfc 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -109,7 +109,7 @@ static void cpu_max_initfn(Object *obj)
         if (!aarch64_enabled) {
             aarch32_max_tcg_init(cpu);
         } else {
-            aarch64_max_tcg_initfn(obj);
+            aarch64_max_v9_tcg_initfn(obj);
         }
         return;
     }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a5cad987d9..d54d9b8399 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1156,11 +1156,10 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
 }
 
 /*
- * -cpu max: a CPU with as many features enabled as our emulation supports.
- * The version of '-cpu max' for qemu-system-arm is defined in cpu32.c;
- * this only needs to handle 64 bits.
+ * -cpu max-v8: an ARMv8 CPU with as many features enabled as
+ * our emulation supports.
  */
-void aarch64_max_tcg_initfn(Object *obj)
+static void aarch64_max_v8_tcg_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     ARMISARegisters *isar = &cpu->isar;
@@ -1234,7 +1233,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* v8.0: FEAT_SHA1 */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* v8.1: FEAT_SHA512 */
     t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* v8.0: FEAT_CRC32 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 3);   /* v9.3: FEAT_LSE128 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 2);   /* v8.0: FEAT_LSE */
     t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* v8.0: FEAT_RDM */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* v8.1: FEAT_SHA3 */
     t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);      /* v8.1: FEAT_SM3 */
@@ -1267,16 +1266,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* v8.7: FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* v8.7: FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* v8.6: FEAT_WFxT */
-    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* v9.3: FEAT_CMPBR */
-    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* v9.2: FEAT_LUT */
+    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* v8.7: FEAT_CSSC */
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* v8.8: FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
-    t = GET_IDREG(isar, ID_AA64ISAR3);
-    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* v9.2: FEAT_FAMINMAX */
-    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* v9.5: FEAT_FPRCVT */
-    SET_IDREG(isar, ID_AA64ISAR3, t);
-
     t = GET_IDREG(isar, ID_AA64PFR0);
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* v8.2: FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* v8.2: FEAT_FP16 */
@@ -1298,17 +1291,14 @@ void aarch64_max_tcg_initfn(Object *obj)
      */
     t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* v8.5: FEAT_MTE3 */
     t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* v8.3: FEAT_DoubleFault */
-    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* v9.2: FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, RNDR_TRAP, 1); /* v8.4: FEAT_RNG_TRAP */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* v8.0: FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* v8.7: FEAT_NMI */
-    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* v9.3: FEAT_GCS */
     /* v8.7: FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
     t = FIELD_DP64(t, ID_AA64PFR1, MTEX, 1);
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64PFR2);
-    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
     t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* v8.7: FEAT_MTE_TAGGED_FAR */
     t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 1); /* v8.7: FEAT_MTE_STORE_ONLY */
     t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 1);   /* v8.7: FEAT_MTE_PERM */
@@ -1358,25 +1348,14 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64MMFR3);
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);     /* v8.0: FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);   /* v8.0: FEAT_SCTLR2 */
-    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);      /* v9.2: FEAT_MEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* v8.2: FEAT_FPACC_SPEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* v8.8: FEAT_S1PIE */
     t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* v8.8: FEAT_S2PIE */
     t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* v8.8: FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
-    t = GET_IDREG(isar, ID_AA64MMFR4);
-    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* v9.4: FEAT_ASID2 */
-    SET_IDREG(isar, ID_AA64MMFR4, t);
-
     t = GET_IDREG(isar, ID_AA64ZFR0);
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* v9.2: FEAT_SVE2p1 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* v8.2: FEAT_EBF16 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* v9.2: FEAT_SVE_B16B16 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* v9.0: FEAT_SVE_SHA3 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* v9.0: FEAT_SVE_SM4 */
     t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* v8.1: FEAT_I8MM */
     t = FIELD_DP64(t, ID_AA64ZFR0, F32MM, 1);     /* v8.2: FEAT_F32MM */
     t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);     /* v8.2: FEAT_F64MM */
@@ -1388,6 +1367,106 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* v8.5: FEAT_HPMN0 */
     SET_IDREG(isar, ID_AA64DFR0, t);
 
+    /* Replicate the same data to the 32-bit id registers.  */
+    aa32_max_features(cpu);
+
+#ifdef CONFIG_USER_ONLY
+    /*
+     * For usermode -cpu max we can use a larger and more efficient DCZ
+     * blocksize since we don't have to follow what the hardware does.
+     */
+    cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
+    set_dczid_bs(cpu, 7); /*  512 bytes */
+#endif
+
+    /* v8.2: FEAT_SVE */
+    cpu->sve_vq.supported = MAKE_64BIT_MASK(0, ARM_MAX_VQ);
+    aarch64_add_sve_properties(OBJECT(cpu));
+    object_property_add(OBJECT(cpu), "sve-max-vq", "uint32",
+                        cpu_max_get_sve_max_vq, cpu_max_set_sve_max_vq,
+                        NULL, NULL);
+
+    /* v8.2: FEAT_PAuth2 */
+    aarch64_add_pauth_properties(OBJECT(cpu));
+
+    /* v8.4: FEAT_MTE2 */
+    cpu->gm_blocksize = 6;  /*  256 bytes */
+
+    /* v8.6: FEAT_LPA2 */
+    qdev_property_add_static(DEVICE(cpu), &arm_cpu_lpa2_property);
+}
+
+/*
+ * -cpu max-v9: an ARMv9 CPU with as many features enabled as
+ * our emulation supports.
+ */
+void aarch64_max_v9_tcg_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+    uint64_t t;
+
+    /* Armv9.0 is based on a minimum of Armv8.5. */
+    aarch64_max_v8_tcg_initfn(obj);
+
+    /*
+     * Armv9.0 does not support AArch32 except at EL0,
+     * therefore indicate EL1 through EL3 are AArch64-only.
+     */
+    t = GET_IDREG(isar, ID_AA64PFR0);
+    t = FIELD_DP64(t, ID_AA64PFR0, EL1, 1);
+    t = FIELD_DP64(t, ID_AA64PFR0, EL2, 1);
+    t = FIELD_DP64(t, ID_AA64PFR0, EL3, 1);
+    SET_IDREG(isar, ID_AA64PFR0, t);
+
+    /* v9.0 prohibits FEAT_DoubleLock. */
+    FIELD_DP64_IDREG(isar, ID_AA64DFR0, DOUBLELOCK, -1);
+    FIELD_DP64_IDREG(isar, ID_AA64PFR0, RAS, 1);
+    isar->dbgdevid = FIELD_DP32(isar->dbgdevid, DBGDEVID, DOUBLELOCK, 0);
+
+    /*
+     * Below, note the revision from which the feature is OPTIONAL.
+     */
+    t = GET_IDREG(isar, ID_AA64ISAR0);
+    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 3);   /* v9.3: FEAT_LSE128 */
+    SET_IDREG(isar, ID_AA64ISAR0, t);
+
+    t = GET_IDREG(isar, ID_AA64ISAR2);
+    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* v9.3: FEAT_CMPBR */
+    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* v9.2: FEAT_LUT */
+    SET_IDREG(isar, ID_AA64ISAR2, t);
+
+    t = GET_IDREG(isar, ID_AA64ISAR3);
+    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* v9.2: FEAT_FAMINMAX */
+    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* v9.5: FEAT_FPRCVT */
+    SET_IDREG(isar, ID_AA64ISAR3, t);
+
+    t = GET_IDREG(isar, ID_AA64PFR1);
+    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* v9.2: FEAT_SME2 */
+    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* v9.3: FEAT_GCS */
+    SET_IDREG(isar, ID_AA64PFR1, t);
+
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
+    t = GET_IDREG(isar, ID_AA64MMFR3);
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);      /* v9.2: FEAT_MEC */
+    SET_IDREG(isar, ID_AA64MMFR3, t);
+
+    t = GET_IDREG(isar, ID_AA64MMFR4);
+    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* v9.4: FEAT_ASID2 */
+    SET_IDREG(isar, ID_AA64MMFR4, t);
+
+    t = GET_IDREG(isar, ID_AA64ZFR0);
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* v9.2: FEAT_SVE2p1 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
+    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* v9.2: FEAT_SVE_B16B16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* v9.0: FEAT_SVE_SHA3 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* v9.0: FEAT_SVE_SM4 */
+    SET_IDREG(isar, ID_AA64ZFR0, t);
+
     t = GET_IDREG(isar, ID_AA64SMFR0);
     t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* v9.4: FEAT_SME_MOP4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, STMOP, 1);    /* v9.4: FEAT_SME_TMOP */
@@ -1424,43 +1503,16 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* v9.2: FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
 
-    /* Replicate the same data to the 32-bit id registers.  */
-    aa32_max_features(cpu);
-
-#ifdef CONFIG_USER_ONLY
-    /*
-     * For usermode -cpu max we can use a larger and more efficient DCZ
-     * blocksize since we don't have to follow what the hardware does.
-     */
-    cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
-    set_dczid_bs(cpu, 7); /*  512 bytes */
-#endif
-
-    /* v8.4: FEAT_MTE2 */
-    cpu->gm_blocksize = 6;  /*  256 bytes */
-
-    /* v8.2: FEAT_SVE */
-    cpu->sve_vq.supported = MAKE_64BIT_MASK(0, ARM_MAX_VQ);
-    aarch64_add_sve_properties(obj);
-    object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
-                        cpu_max_set_sve_max_vq, NULL, NULL);
-
     /* v9.2: FEAT_SME */
     cpu->sme_vq.supported = SVE_VQ_POW2_MAP;
     aarch64_add_sme_properties(obj);
 
-    /* v8.2: FEAT_PAuth2 */
-    aarch64_add_pauth_properties(obj);
-
     /* v9.1: FEAT_RME */
     object_property_add_bool(obj, "x-rme", cpu_arm_get_rme, cpu_arm_set_rme);
 
     /* v9.4: FEAT_RME_GPC2 */
     object_property_add(obj, "x-l0gptsz", "uint32", cpu_max_get_l0gptsz,
                         cpu_max_set_l0gptsz, NULL, NULL);
-
-    /* v8.6: FEAT_LPA2 */
-    qdev_property_add_static(DEVICE(obj), &arm_cpu_lpa2_property);
 }
 
 static const ARMCPUInfo aarch64_cpus[] = {
@@ -1478,8 +1530,8 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
     { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
     { .name = "neoverse-n2",        .initfn = aarch64_neoverse_n2_initfn },
-    { .name = "max-v8",             .initfn = aarch64_max_tcg_initfn },
-    { .name = "max-v9",             .initfn = aarch64_max_tcg_initfn },
+    { .name = "max-v8",             .initfn = aarch64_max_v8_tcg_initfn },
+    { .name = "max-v9",             .initfn = aarch64_max_v9_tcg_initfn },
 };
 
 static void aarch64_cpu_register_types(void)
diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
index 78f819ef6f..939cea7189 100644
--- a/target/arm/tcg/stubs32.c
+++ b/target/arm/tcg/stubs32.c
@@ -28,7 +28,7 @@ void aarch64_host_initfn(Object *obj)
     g_assert_not_reached();
 }
 
-void aarch64_max_tcg_initfn(Object *obj)
+void aarch64_max_v9_tcg_initfn(Object *obj)
 {
     g_assert_not_reached();
 }
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index cc42db9e0b..0a1a5bec93 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -230,7 +230,16 @@ to the `Arm Architecture Reference Manual for A-profile architecture
 When a specific named CPU is being emulated, only those features which
 are present in hardware for that CPU are emulated. (If a feature is
 not in the list above then it is not supported, even if the real
-hardware should have it.) The ``max`` CPU enables all features.
+hardware should have it.)
+
+The ``max-v8`` CPU enables all of the listed Armv8-A architecture
+extensions but none of the Armv9-A architecture extensions.
+
+The ``max-v9`` CPU enables all of the listed extensions except for
+those that are prohibited by the Armv9-A architecture: FEAT_AA32EL1,
+FEAT_AA32EL2, FEAT_AA32EL3, and FEAT_DoubleLock.
+
+The ``max`` CPU is an alias for ``max-v9`` under TCG emulation.
 
 R-profile CPU architecture support
 ==================================
-- 
2.43.0


