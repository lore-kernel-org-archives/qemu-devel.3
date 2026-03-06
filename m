Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4D0FCB605
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfk-0005B3-50; Fri, 06 Mar 2026 10:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWf8-0004bZ-FH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWf6-0002kW-Lr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:22 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4837584120eso71823035e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809219; x=1773414019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TJieb313+a3lfTsCm/cKrK1VqqA8uHhdobgQKwhazhM=;
 b=YQ4aM1k9GRfgnvKZEl6ZLSn1iXudbOYy1Nz1/mjyzXM8ShYVlBvz62p/I7uVIBVs6j
 iXVi1KHcDOBrecuBCC0FvGORDj3dTC1vvrmo09aP6JSJ9elCIYl415rtOFsZ5fhbwdoz
 vJgyBrxskucsRRGFRL4tWLYbK36xcJpzeNW/H0yQuxo509S4YgsWZnqWejzMZMFmVFy1
 MZETDBkdise4N5UP+R6LQrmQGS+9CK1EFqKsUFEPJgasYoc30ND0AmIwQ/tQLYQJpCGb
 2SitE6zoqqIOajNiNhyDHezhgLqBLShUV3Zn34lHAPH1REqUG3aAlFSSjvP/V3pkNPFC
 7Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809219; x=1773414019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TJieb313+a3lfTsCm/cKrK1VqqA8uHhdobgQKwhazhM=;
 b=bgZ1iDqrYvXG2ZS+SvsgVwlxrf+1L+IWTmQKCeiH4xvKiMkI/F0bXTUcm2g6ga9q8v
 eL1TUDnFES5gm3KEGCE6ucCvbJIAHPkKu9Qd7IBVgXHBCJeXvKMHsj+KNLnH35QmCbvi
 NTh+4kFQYiIoHPZG/I9R6yvznpM/0bhgj/IBJ4Xy7ZeTH7pY5Zx4kagwFQWS8PRo1/Tf
 lyCt5kokYKw2vO057jmfJOx93mygUNhodmv4qH1w2J/WpcKGhxB6RGU2hp42wK6s3S63
 6svY0Qwq0ZwPJgu6323I93meX9JcQRnZ4Id4jHjs0K/RskTFsnfnTE51BHlTCsOt+yAO
 UdCQ==
X-Gm-Message-State: AOJu0Yxr+1rUt/uJN7F+Nf6dR2fliBccjirtV3ltG8FAzZILuqF5/iuU
 cDiUfGC1Igm4xRmME+DV3sdSNmfqRKegTAh1iOVhTlpQUwrNyygwGvKkxS0CpZu2SeLDJLeYbXO
 H+Bjw
X-Gm-Gg: ATEYQzzdl70Y5ZC+9lieVHITA/AZXLiDlAQLkkf1mK0OqzK2R8OgOTMyLrn5Z0l5GxD
 Sp5haKVGbMUfTZfZ9bR52E0xYBxKFTMXVEy/rYUEAxNv2Q/TsWKDzCAzQGbgqBT4GQFU239Wl6H
 8r2NcFtJM7V1870XU4tp+jzUdfazpe7TQTFWevXfeRP2HFuq1RucAa6G0X2wPqjO2JKW78vfDFK
 leGRucdxHkZ5crjHbT6zWtpUJ02T9Zlq3+IbAYWaNs+MCGYEBQua6Mv+fTUspO7pOGqiAPEVrdl
 Mc3JuR9uzCMkbCXJDknOQbloVcGOuE/ctgWjmRvAtuV9UVW2IXKo7B+XHjw8Hc2my0n8CBE09IB
 OQAczLC1f0vGfO9YhFAhtw3R33GX/Yr47kz5p8CNiDcA5qwQqlejK1j2J6Ldx8kojIh6pf5WxmV
 Bgo9nNUAgQDljOn0CE1WaVG6//FhW2tVBAGs30uh1y1EddbFlsVGX4FK6Ks5KQWc0BxAjEEtlhe
 JcO90aPkJeB1dfpBId9rG7oJlXkGXo=
X-Received: by 2002:a05:600c:1e88:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-485269182b5mr45637345e9.6.1772809218549; 
 Fri, 06 Mar 2026 07:00:18 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/49] hvf/arm: expose FEAT_SME2 to guest if available
Date: Fri,  6 Mar 2026 14:59:24 +0000
Message-ID: <20260306145939.2162189-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Starting from M4 cores and MacOS 15.2 SDK, HVF can virtualise FEAT_SME2.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20260306-sme2-hvf-v7-2-e72eeda41ed3@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 21b16dfe42..5fc8f6bbbd 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -315,6 +315,7 @@ typedef struct ARMHostCPUFeatures {
     uint64_t features;
     uint64_t midr;
     uint32_t reset_sctlr;
+    uint32_t sme_vq_supported;
     const char *dtb_compatible;
 } ARMHostCPUFeatures;
 
@@ -1106,6 +1107,24 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg,
                                             &host_isar.idregs[regs[i].index]);
     }
+
+    if (__builtin_available(macOS 15.2, *)) {
+        static const struct sme_isar_regs {
+            hv_feature_reg_t reg;
+            ARMIDRegisterIdx index;
+        } sme_regs[] = {
+            { HV_FEATURE_REG_ID_AA64SMFR0_EL1, ID_AA64SMFR0_EL1_IDX },
+            { HV_FEATURE_REG_ID_AA64ZFR0_EL1, ID_AA64ZFR0_EL1_IDX },
+        };
+
+        if (hvf_arm_sme2_supported()) {
+            for (i = 0; i < ARRAY_SIZE(sme_regs); i++) {
+                r |= hv_vcpu_config_get_feature_reg(config, sme_regs[i].reg,
+                                                    &host_isar.idregs[sme_regs[i].index]);
+            }
+        }
+    }
+
     os_release(config);
 
     /*
@@ -1121,19 +1140,6 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
-    /*
-     * Disable SME, which is not properly handled by QEMU hvf yet.
-     * To allow this through we would need to:
-     * - make sure that the SME state is correctly handled in the
-     *   get_registers/put_registers functions
-     * - get the SME-specific CPU properties to work with accelerators
-     *   other than TCG
-     * - fix any assumptions we made that SME implies SVE (since
-     *   on the M4 there is SME but not SVE)
-     */
-    SET_IDREG(&host_isar, ID_AA64PFR1,
-              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
-
     ahcf->isar = host_isar;
 
     /*
@@ -1148,6 +1154,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      */
     ahcf->reset_sctlr |= 0x00800000;
 
+    ahcf->sme_vq_supported = hvf_arm_sme2_supported() ? hvf_arm_sme2_get_svl() : 0;
+
     /* Make sure we don't advertise AArch32 support for EL0/EL1 */
     if ((GET_IDREG(&host_isar, ID_AA64PFR0) & 0xff) != 0x11) {
         return false;
@@ -1199,6 +1207,7 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
     cpu->env.features = arm_host_cpu_features.features;
     cpu->midr = arm_host_cpu_features.midr;
     cpu->reset_sctlr = arm_host_cpu_features.reset_sctlr;
+    cpu->sme_vq.supported = arm_host_cpu_features.sme_vq_supported;
 }
 
 void hvf_arch_vcpu_destroy(CPUState *cpu)
@@ -1343,6 +1352,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
+    aarch64_add_sme_properties(OBJECT(cpu));
     return 0;
 }
 
-- 
2.43.0


