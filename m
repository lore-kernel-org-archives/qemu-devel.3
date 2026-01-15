Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC49D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVY-0000se-FC; Thu, 15 Jan 2026 13:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV4-0000cm-Ii
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:20 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV1-0005sc-0W
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:17 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so11812015e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503312; x=1769108112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dFDbbBRCQ6aEWxiWdS+TlHvgeoAjTJihJKhODkPXEig=;
 b=tDo/pOn9LjzTBysfcSn5Nn/2Vf6xqgjk0cr9ocbmizezB6yK442cQt6pIQZXPvLHOY
 NQpCyrkJWdehzXlETpLpPqOb2CMnRaXhz+werThltktVToc2ePZOOZHMrVvjU9WpKPPF
 vz0Remufz2jTaqOVQT2FcagzjWarxtmmpo2MrZXlT4b0pspqYxWc3bQM33oUsUP4E4Ir
 5aG/PEQGpN14POonr/lEYWBH2XLiinYHsAFynKQsVcBgRYMFRG1NmdRlLGbUSWHlBtJo
 Kf+TArecXwE4YLKw/PHvxrpQiNcV+ymsd4GDCc+zzwQ4LxZZooYrC+hrVUdeAJAE6QUT
 xZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503312; x=1769108112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dFDbbBRCQ6aEWxiWdS+TlHvgeoAjTJihJKhODkPXEig=;
 b=Zb7RDZkreALnTAMJzMCavIFrAGDTHrsG0qzqjoPT6LENEi/eoZPvc4Oe+3c9bl1b95
 tzxYDxMJZKxbT56aMBsVKrGSs2bDk/Ab+WUDJoztSowu8yTL6fIOnW+lgSWbZeJdgrti
 OMWIIJXQDtf4wdpD4rgDb4CIsQlntz4w3WmvLug2yCsSc+jlywmActTJfQVfV36KcQsw
 7wraUY83qi6pg5NNoAHqCyLpRdfnPU/ebj6LcXCIdZjoPbgaQtcZqiXGhZtthoYV9sLv
 VgrtAxISP1hpc6dhHFOBe7jAnlFiDNSAcGdcydDgC8lgO3iFe/LauI6VAoiMKgURNm5X
 Zs8A==
X-Gm-Message-State: AOJu0YxhQPJcfRPld/x/TgsZE2sY/jOFMHbmg+xSNs8bJN5zc4VTQkHb
 oL7oNMSFlCznUPTTeR/bwWYboPUV+R1h5RDIa6bHU72p/XRKSFXZ0qz126NPCRiPKFZ10dQ6tNk
 LcwT/
X-Gm-Gg: AY/fxX5m9wNXAZsFB3UN+O4gHaP5Tl7NDBVFiU6lsyvt2Kiy5nKQeiqJU15B1aSGEkO
 bwjwQ31ieT8bJzWzT1SXIa0ZNsM+Sk3dWuW6GE8vOc2UcaQOemZ6YXWRfEoyYeHmgmDKRVwBFvb
 +fCJyAUxxWhsB1F3g/FHn+QTipISl2klJhtLVmRHWvRlSXL6kh/95dFbR9nf6JiEQwJAQpfwS99
 NNn0ghKKUrhPPhhB6HBRnm/4/QvoLzllM6DImj3ROkTYmEse9nq1QlKNz5UZPjIVEvi57ADMr8Y
 mt+dU0Gkv/AMYpenxm1Xv7u+VH1OniuBbo1nAT9jbVv3/sK+zxGRwqmltwxLI3lRNje3R9VSHN7
 j/TbK+kdcxdfLRSznfyTnHb7hUrJK3yI8cNpk64aVYgtMnFligNbRkOlkUBNrau0CyNK8wHSujM
 YrioqCGK4Q3cRkGEgfTJbFMse0zl2PxP6y0/ZoMTp2zsyTHCG1042G9KL9m0NULjDSYQTe9iJ0j
 mXPcjKLEJYgVO3UazghLnw9rDR1W2QQFhC1nyzkzGYVxQ==
X-Received: by 2002:a05:600c:4584:b0:47b:deb9:15fb with SMTP id
 5b1f17b1804b1-4801e350af0mr7788195e9.33.1768503312031; 
 Thu, 15 Jan 2026 10:55:12 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/25] target/arm: Allow writes to FNG1, FNG0, A2
Date: Thu, 15 Jan 2026 18:54:45 +0000
Message-ID: <20260115185508.786428-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

This just allows read/write of three feature bits. ASID is still
ignored. Any writes to TTBR0_EL0 and TTBR1_EL0, including changing
the ASID, will still cause a complete flush of the TLB.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h |  7 +++++++
 target/arm/helper.c       | 28 ++++++++++++++++++++++------
 target/arm/internals.h    |  5 +++++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c86a4e667d..a7ca410dcb 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -346,6 +346,8 @@ FIELD(ID_AA64MMFR3, SDERR, 52, 4)
 FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
+FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
 FIELD(ID_AA64DFR0, PMUVER, 8, 4)
@@ -1369,6 +1371,11 @@ static inline bool isar_feature_aa64_aie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, AIE) != 0;
 }
 
+static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a7239ff25b..1ee721ac7b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -428,6 +428,15 @@ int alle1_tlbmask(CPUARMState *env)
             ARMMMUIdxBit_Stage2_S);
 }
 
+int alle2_tlbmask(void)
+{
+    return (ARMMMUIdxBit_E20_2 |
+            ARMMMUIdxBit_E20_2_PAN |
+            ARMMMUIdxBit_E20_2_GCS |
+            ARMMMUIdxBit_E20_0 |
+            ARMMMUIdxBit_E20_0_GCS);
+}
+
 static const ARMCPRegInfo cp_reginfo[] = {
     /*
      * Define the secure and non-secure FCSE identifier CP registers
@@ -2802,12 +2811,7 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
         (arm_hcr_el2_eff(env) & HCR_E2H)) {
-        uint16_t mask = ARMMMUIdxBit_E20_2 |
-                        ARMMMUIdxBit_E20_2_PAN |
-                        ARMMMUIdxBit_E20_2_GCS |
-                        ARMMMUIdxBit_E20_0 |
-                        ARMMMUIdxBit_E20_0_GCS;
-        tlb_flush_by_mmuidx(env_cpu(env), mask);
+        tlb_flush_by_mmuidx(env_cpu(env), alle2_tlbmask());
     }
     raw_write(env, ri, value);
 }
@@ -6102,6 +6106,12 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_aie, cpu)) {
         valid_mask |= TCR2_AIE;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+        if (((raw_read(env, ri) ^ value) & TCR2_A2) != 0) {
+            tlb_flush_by_mmuidx(CPU(cpu), alle1_tlbmask(env));
+        }
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6121,6 +6131,12 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_mec, cpu)) {
         valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+        if (((raw_read(env, ri) ^ value) & TCR2_A2) != 0) {
+            tlb_flush_by_mmuidx(CPU(cpu), alle2_tlbmask());
+        }
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 440072d820..f7b641342a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1892,6 +1892,11 @@ uint64_t gt_direct_access_timer_offset(CPUARMState *env, int timeridx);
  * all EL1" scope; this covers stage 1 and stage 2.
  */
 int alle1_tlbmask(CPUARMState *env);
+/*
+ * Return mask of ARMMMUIdxBit values corresponding to an "invalidate
+ * all EL2&0" scope.
+ */
+int alle2_tlbmask(void);
 
 /* Set the float_status behaviour to match the Arm defaults */
 void arm_set_default_fp_behaviours(float_status *s);
-- 
2.47.3


