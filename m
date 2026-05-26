Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300D0CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyYe-0002jx-D4; Tue, 26 May 2026 16:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyYO-0001tp-6E
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:39:09 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyYL-0007tQ-EP
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:39:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so37139505e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827944; x=1780432744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0AHGAisTjM3ITx5hjPgrk7zEVV/Rjt8pbSifNV3yhk=;
 b=uCrLYnhr3DldtL/n3BWasy1HrgEXR5meLsehxYJQIVXxOUv0SOwe+vUxB8oHGAQk9j
 t0v0Al/cv9woSDTzHTEmVPxTEPs3hbDw/l13p/dVpC/a9aZBVSk+T/x/qyKxKceCk6bS
 NMnK+zYGXl2FnGOVjMB/0QY5I8FtP17UjwnpMMc4yyJV1K+TPej69oozY8tz698FVHWd
 zem5BXTu7gy2jNdzaiSKTo35wZZDBuB1fPGS/xIvIZHxvVKmUFe/SJO90+Y2ZuAPT076
 PAXPizag72R4LR3g9Vj8ATH51YR39Rf97DdeMRmmaT4Pwzx2xhpHW4MkoTb1XBU7Cpa+
 AALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827944; x=1780432744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m0AHGAisTjM3ITx5hjPgrk7zEVV/Rjt8pbSifNV3yhk=;
 b=J8xvaUBP7JDLG7VWvdgBsWRz5RE4NAHuEQc27BzS4xXrBYx4GxvAVE57qrw+IzZjaH
 da6fP2warSiGdkrNt0cUUMOLyprGKtd9N9+pLJ/R61uvwJ461p5/a2gGVtny3Q/PSOXG
 0LMjQJuejElyyJqdgkUoBNYl4ROo48ZQDFfaPQZ2S9ugFBCZO+0Kv6CYTi/b7Titvoru
 YdPQe9fcORZ5d9hzEv8ZdjLE+7k83j+TAdiWBJ9QlGhP3VUrAhRup4cvB1Sjl62fPbbR
 gSDnRaof9ADFffr6Kr8JYWg6xxYSve4QVuxqbUynnFQ9McZwHGKykTdp+0CjhDgHy0vM
 8j0w==
X-Gm-Message-State: AOJu0YxSm7iZK2dZ/w89a4jPECO4765Eezme3eVoKjCkpJ80lUmEtrxy
 DCx76+SNMhrX90vDydOdBWNIEFeQlWvebfvCb9GQlcZazRPDLWPyc/3IKN3ajW16bNVJPbAW3wv
 3KSSH8rA9Ew==
X-Gm-Gg: Acq92OGMnT8aEXUou9hHfSaUTL1Uy3jjhvDjetOWbRAAC+/cKz8TG/QYPxPwoazlYPQ
 9qf/D6eBWbL8bTNe/Pb/6J6LK2A3nfI0xFN9UAPr3PE7apWTg0okKtnQNtgyPWNm2OXmUf+WRDk
 cNNyg/ZD5JWKU1wfAwNQTx0AgAcUF3ml5USQvfTYRO6+hjXB4bXEyVoPfpsI1jzt+TGp2+cdPA4
 vGCBbz7oV6PplwawiWR2Nme/Jvx5UfF+dzAqEf0ewr+p9YTbZovb5T708P2yE42FiCMPleirW3G
 Ikq5UQEx4uQIimZ0nkcpRn+PMchsiwcRYloClsHFAa6PcmUPbICc9SqKfGhB0tMXkAYbKRGEWEG
 FC1jfHlo4fM9rWnKpOFu3PEANU7AKbrpCXRul+pfi7AdeMIz4ghEOHSHo5xa54qPwvJbFOfvzYe
 xMRCcqc+s+skUhWcpSNzQElNJ/iloE4rbhUd5g68YjBXKCiPTL354u46k=
X-Received: by 2002:a05:600c:3b02:b0:48a:5821:5ff2 with SMTP id
 5b1f17b1804b1-490425aa70fmr344586435e9.8.1779827943780; 
 Tue, 26 May 2026 13:39:03 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b82sm370186785e9.9.2026.05.26.13.39.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:39:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 14/17] target/arm: Re-use common aarch64_aa32_a57_init()
 helper
Date: Tue, 26 May 2026 22:37:19 +0200
Message-ID: <20260526203722.79463-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Make aarch64_aa32_a57_init() common by exposing its prototype
and defining it in cpu-max.c. Call it in arm_max_initfn()
restricted to AArch32.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  1 +
 target/arm/cpu-max.c   | 74 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c     | 71 ----------------------------------------
 target/arm/tcg/cpu32.c | 48 ++-------------------------
 4 files changed, 77 insertions(+), 117 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5a2263799c7..27414e7481f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1773,6 +1773,7 @@ void aarch64_max_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
+void aarch64_aa32_a57_init(Object *obj, bool aa32_only);
 
 /* Return true if the gdbstub is presenting an AArch64 CPU */
 static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 9fd48ce46e2..6fc54ebe74e 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -7,7 +7,81 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "system/kvm.h"
 #include "target/arm/internals.h"
+#include "target/arm/cpregs.h"
+
+void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+    const bool aarch64_enabled = !aa32_only;
+
+    cpu->dtb_compatible = "arm,cortex-a57";
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
+    if (aarch64_enabled) {
+        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    }
+    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+    if (kvm_enabled()) {
+        cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
+    }
+    cpu->midr = 0x411fd070;
+    cpu->revidr = 0x00000000;
+    cpu->reset_fpsid = 0x41034070;
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x12111111;
+    cpu->isar.mvfr2 = 0x00000043;
+    cpu->ctr = 0x8444c004;
+    cpu->reset_sctlr = 0x00c50838;
+    SET_IDREG(isar, ID_PFR0, 0x00000131);
+    SET_IDREG(isar, ID_PFR1, 0x00011011);
+    SET_IDREG(isar, ID_DFR0, 0x03010066);
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
+    SET_IDREG(isar, ID_MMFR0, 0x10101105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02102211);
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00011142);
+    SET_IDREG(isar, ID_ISAR5, 0x00011121);
+    SET_IDREG(isar, ID_ISAR6, 0);
+    if (aarch64_enabled) {
+        SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
+        SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
+        SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
+        SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
+    }
+    cpu->isar.dbgdidr = 0x3516d000;
+    cpu->isar.dbgdevid = 0x01110f13;
+    cpu->isar.dbgdevid1 = 0x2;
+    cpu->isar.reset_pmcr_el0 = 0x41013000;
+    SET_IDREG(isar, CLIDR, 0x0a200023);
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    /* 48KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
+    /* 2048KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
+    if (aarch64_enabled) {
+        set_dczid_bs(cpu, 4); /* 64 bytes */
+        cpu->gic_num_lrs = 4;
+        cpu->gic_vpribits = 5;
+        cpu->gic_vprebits = 5;
+        cpu->gic_pribits = 5;
+    }
+    define_cortex_a72_a57_a53_cp_reginfo(cpu);
+}
 
 /* Share AArch32 -cpu max features with AArch64. */
 void aa32_max_features(ARMCPU *cpu)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 7dce17fdb20..499d154dace 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -686,77 +686,6 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
     SET_IDREG(&cpu->isar, ID_AA64MMFR0, t);
 }
 
-static void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-    ARMISARegisters *isar = &cpu->isar;
-    const bool aarch64_enabled = !aa32_only;
-
-    cpu->dtb_compatible = "arm,cortex-a57";
-    set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
-    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
-    if (aarch64_enabled) {
-        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
-    }
-    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
-    set_feature(&cpu->env, ARM_FEATURE_EL2);
-    set_feature(&cpu->env, ARM_FEATURE_EL3);
-    set_feature(&cpu->env, ARM_FEATURE_PMU);
-    if (kvm_enabled()) {
-        cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
-    }
-    cpu->midr = 0x411fd070;
-    cpu->revidr = 0x00000000;
-    cpu->reset_fpsid = 0x41034070;
-    cpu->isar.mvfr0 = 0x10110222;
-    cpu->isar.mvfr1 = 0x12111111;
-    cpu->isar.mvfr2 = 0x00000043;
-    cpu->ctr = 0x8444c004;
-    cpu->reset_sctlr = 0x00c50838;
-    SET_IDREG(isar, ID_PFR0, 0x00000131);
-    SET_IDREG(isar, ID_PFR1, 0x00011011);
-    SET_IDREG(isar, ID_DFR0, 0x03010066);
-    SET_IDREG(isar, ID_AFR0, 0x00000000);
-    SET_IDREG(isar, ID_MMFR0, 0x10101105);
-    SET_IDREG(isar, ID_MMFR1, 0x40000000);
-    SET_IDREG(isar, ID_MMFR2, 0x01260000);
-    SET_IDREG(isar, ID_MMFR3, 0x02102211);
-    SET_IDREG(isar, ID_ISAR0, 0x02101110);
-    SET_IDREG(isar, ID_ISAR1, 0x13112111);
-    SET_IDREG(isar, ID_ISAR2, 0x21232042);
-    SET_IDREG(isar, ID_ISAR3, 0x01112131);
-    SET_IDREG(isar, ID_ISAR4, 0x00011142);
-    SET_IDREG(isar, ID_ISAR5, 0x00011121);
-    SET_IDREG(isar, ID_ISAR6, 0);
-    if (aarch64_enabled) {
-        SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
-        SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
-        SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
-        SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
-    }
-    cpu->isar.dbgdidr = 0x3516d000;
-    cpu->isar.dbgdevid = 0x01110f13;
-    cpu->isar.dbgdevid1 = 0x2;
-    cpu->isar.reset_pmcr_el0 = 0x41013000;
-    SET_IDREG(isar, CLIDR, 0x0a200023);
-    /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
-    /* 48KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
-    /* 2048KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
-    if (aarch64_enabled) {
-        set_dczid_bs(cpu, 4); /* 64 bytes */
-        cpu->gic_num_lrs = 4;
-        cpu->gic_vpribits = 5;
-        cpu->gic_vprebits = 5;
-        cpu->gic_pribits = 5;
-    }
-    define_cortex_a72_a57_a53_cp_reginfo(cpu);
-}
-
 static void aarch64_a57_initfn(Object *obj)
 {
     aarch64_aa32_a57_init(obj, false);
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 2e8afc28602..a2f730451fb 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -720,53 +720,9 @@ static void sa1110_initfn(Object *obj)
 static void arm_max_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    ARMISARegisters *isar = &cpu->isar;
 
-    /* aarch64_a57_initfn, advertising none of the aarch64 features */
-    cpu->dtb_compatible = "arm,cortex-a57";
-    set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
-    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
-    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
-    set_feature(&cpu->env, ARM_FEATURE_EL2);
-    set_feature(&cpu->env, ARM_FEATURE_EL3);
-    set_feature(&cpu->env, ARM_FEATURE_PMU);
-    cpu->midr = 0x411fd070;
-    cpu->revidr = 0x00000000;
-    cpu->reset_fpsid = 0x41034070;
-    cpu->isar.mvfr0 = 0x10110222;
-    cpu->isar.mvfr1 = 0x12111111;
-    cpu->isar.mvfr2 = 0x00000043;
-    cpu->ctr = 0x8444c004;
-    cpu->reset_sctlr = 0x00c50838;
-    SET_IDREG(isar, ID_PFR0, 0x00000131);
-    SET_IDREG(isar, ID_PFR1, 0x00011011);
-    SET_IDREG(isar, ID_DFR0, 0x03010066);
-    SET_IDREG(isar, ID_AFR0, 0x00000000);
-    SET_IDREG(isar, ID_MMFR0, 0x10101105);
-    SET_IDREG(isar, ID_MMFR1, 0x40000000);
-    SET_IDREG(isar, ID_MMFR2, 0x01260000);
-    SET_IDREG(isar, ID_MMFR3, 0x02102211);
-    SET_IDREG(isar, ID_ISAR0, 0x02101110);
-    SET_IDREG(isar, ID_ISAR1, 0x13112111);
-    SET_IDREG(isar, ID_ISAR2, 0x21232042);
-    SET_IDREG(isar, ID_ISAR3, 0x01112131);
-    SET_IDREG(isar, ID_ISAR4, 0x00011142);
-    SET_IDREG(isar, ID_ISAR5, 0x00011121);
-    SET_IDREG(isar, ID_ISAR6, 0);
-    cpu->isar.dbgdidr = 0x3516d000;
-    cpu->isar.dbgdevid = 0x01110f13;
-    cpu->isar.dbgdevid1 = 0x2;
-    cpu->isar.reset_pmcr_el0 = 0x41013000;
-    SET_IDREG(isar, CLIDR, 0x0a200023);
-    /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
-    /* 48KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
-    /* 2048KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
-    define_cortex_a72_a57_a53_cp_reginfo(cpu);
+    /* Cortex-A57 advertising none of the aarch64 features */
+    aarch64_aa32_a57_init(obj, true);
 
     aa32_max_features(cpu);
 
-- 
2.53.0


