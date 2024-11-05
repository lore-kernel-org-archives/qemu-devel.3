Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DA6D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbX-0004d6-FM; Tue, 05 Nov 2024 06:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbV-0004bV-DH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:09 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbL-000794-IH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:09 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539ebb5a20aso5667352e87.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805595; x=1731410395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ig5jYCKBIJw18wNceoQVbcha/Skyw92dmimUEm0U7I4=;
 b=Adys6tJZaGaEy0d/jZ6yyNvMlmxUme4Y+upNA86KvMDSvuniG4AwnDgbTtLJ9qSclk
 4GYFTKKw1nmqIGhap4f8LJEikxxYnvshx434Ln1Wa6OzDX7KLq4zIV4USDlnRKW2hs9i
 E3p2xMOzq+uhUnV8k0Wo8wioOFK1fXTsA92uqBzdnvhjKOwhT71AcPY/h0TKkz5vAVBY
 6sJgSYrJ160CdzouV945aFryzQrW1e8ZtSDd568ikaIJnJH5EuXgDePDPViwzWuPfAd8
 2bQ+zOPP8Jcm8d5TuiOjOAKJ60Wp5chHLkqPeR6F+KzwtSSA606BKE/XYZQST/fRlJJK
 n+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805595; x=1731410395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ig5jYCKBIJw18wNceoQVbcha/Skyw92dmimUEm0U7I4=;
 b=sTOkRTfRJ4rqmR4hR7WAiKeiiIdlbLD6dvkb4CrHtPaBiQ8rLMoN0vxLvcrnQ9wKJR
 u/fmR4d82QVmQOWXUilA3w+jLRxpUD1YEHLGv9wecubIX7AADC/v7P7ZbKlWSTozS2iu
 cxRbrwOEQ63LiykswEYZShf/DPDQF6xcnM0CD4EUzkpstIsLEY5AR823neYNCJxcBEIc
 /GOU7AYZrcMCfb+WrG0ucOYnrrUG2lLl4lw/1h9wGpM3VObIKvmDQAwMr/mt/KVvRFZO
 wJqQcMLU62JwsMql7a5/5sb2Vq8FFeY5iuVM+gkKYVugYoiSLdCc3rpwTNmTYRObSsVA
 JnIA==
X-Gm-Message-State: AOJu0YzBqjCxffWOkpn4B40LHmfmlZ7zRkBkY/DrklKfllKFIj0g6vKR
 dsU2Eu0ONrUS7mr5B5I8NzopFymECUv9k9bOcG7EVEptzCvm9JYwSlZSafWDKTnCZnMQe9Wa+La
 1
X-Google-Smtp-Source: AGHT+IGHKv9lPoqlRuwROu+4s1YMXLfJ9ALfOFBPZEN1JxS3OcGsmNE1xtTTKk7setNZ95I1GLa7RQ==
X-Received: by 2002:a05:6512:3403:b0:52e:7448:e137 with SMTP id
 2adb3069b0e04-53d65dd0e30mr9080197e87.6.1730805595401; 
 Tue, 05 Nov 2024 03:19:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/31] target/arm: Enable FEAT_CMOW for -cpu max
Date: Tue,  5 Nov 2024 11:19:35 +0000
Message-Id: <20241105111935.2747034-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

FEAT_CMOW introduces support for controlling cache maintenance
instructions executed in EL0/1 and is mandatory from Armv8.8.

On real hardware, the main use for this feature is to prevent processes
from invalidating or flushing cache lines for addresses they only have
read permission, which can impact the performance of other processes.

QEMU implements all cache instructions as NOPs, and, according to rule
[1], which states that generating any Permission fault when a cache
instruction is implemented as a NOP is implementation-defined, no
Permission fault is generated for any cache instruction when it lacks
read and write permissions.

QEMU does not model any cache topology, so the PoU and PoC are before
any cache, and rules [2] apply. These rules state that generating any
MMU fault for cache instructions in this topology is also
implementation-defined. Therefore, for FEAT_CMOW, we do not generate any
MMU faults either, instead, we only advertise it in the feature
register.

[1] Rule R_HGLYG of section D8.14.3, Arm ARM K.a.
[2] Rules R_MZTNR and R_DNZYL of section D8.14.3, Arm ARM K.a.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241104142606.941638-1-gustavo.romero@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/cpu-features.h     | 5 +++++
 target/arm/cpu.h              | 1 +
 target/arm/helper.c           | 5 +++++
 target/arm/tcg/cpu64.c        | 1 +
 5 files changed, 13 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 35f52a54b1c..a2a388f0919 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -26,6 +26,7 @@ the following architecture extensions:
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
+- FEAT_CMOW (Control for cache maintenance permission)
 - FEAT_CRC32 (CRC32 instructions)
 - FEAT_Crypto (Cryptographic Extension)
 - FEAT_CSV2 (Cache speculation variant 2)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 04ce2818263..e806f138b8f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -802,6 +802,11 @@ static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
 }
 
+static inline bool isar_feature_aa64_cmow(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, CMOW) != 0;
+}
+
 static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fb0f217b196..d86e641280d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1367,6 +1367,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_EnIB    (1U << 30) /* v8.3, AArch64 only */
 #define SCTLR_EnIA    (1U << 31) /* v8.3, AArch64 only */
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
+#define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
 #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8c4f86f475a..f38eb054c06 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6229,6 +6229,11 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_nmi, cpu)) {
         valid_mask |= HCRX_TALLINT | HCRX_VINMI | HCRX_VFNMI;
     }
+    /* FEAT_CMOW adds CMOW */
+
+    if (cpu_isar_feature(aa64_cmow, cpu)) {
+        valid_mask |= HCRX_CMOW;
+    }
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 01689208286..2963d7510f3 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1218,6 +1218,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
     t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
     t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* FEAT_CMOW */
     cpu->isar.id_aa64mmfr1 = t;
 
     t = cpu->isar.id_aa64mmfr2;
-- 
2.34.1


