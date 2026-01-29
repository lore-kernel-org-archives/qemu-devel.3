Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B302FD6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUb9-0001hP-4i; Thu, 29 Jan 2026 11:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUay-0001IK-9W
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:12 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUav-00076W-Vp
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:11 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso771925f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769703008; x=1770307808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uaq9ElfQysU2NonbTWFmHpCaaanArhtXeyoJNinjHBs=;
 b=be1dosV6Oeh4g40egzR50Q1ROl6lIx6ZM7/qcz9hJPV0DbonwjYm/BEf0nH6q0Ffxq
 gJtgKlQmCvbxNpabLpol7vifcb27o6Q4DimXkwmcnoLOz2815aB1o81NbMo5vx0woLRX
 BGP0NRFWbqwhiGaXkhXMaV5XBGdzC1WkHc9VsWmpwdzcCS1lODmthf9q363RwBKYpHnp
 Rl9dEwWKggrDgLJ33YeZXPqpGeBHQmE8OuqE56COuUUZJWsg1qcCRCyQfhBK+HkVZfHJ
 fvM7yuw+Uic7hT/BDMaOwvrf/6ZT9PvDvL+TGtRdStkAIeDrJxguLHBB8QbkleXDqBfR
 Wthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769703008; x=1770307808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Uaq9ElfQysU2NonbTWFmHpCaaanArhtXeyoJNinjHBs=;
 b=wG7EPl8ZmYexBoI4DLmd3sg0fKMgPKASvpcH5wgWDf5V3HpOsmDCb8GqWy4HB1QN8B
 soxkjCn3cYwCgV30FMTDKkkC384djHI0ucAPQ00ftj/3clQ7oBkUwBCUv7R0gHkf8ZCh
 Vg9Dj6g/T6MnAQqJtDA7a9WAaXFDlPw23zETdZxqsKnTT+q7sAAYxndfHsLzVcNnGwdF
 Z13NeA4lcVB+eQbs+6o5/r+E/HolPpUXtUmGKYGvqI88kumn5pClinl7Hg8kpEIaGe7P
 Am2KveT0CX4VajvE7/dceyExIcEA9o2nXnTO9+nfO8r2J4bR/24EIsxOKa2ddHg7hDUm
 +Y1Q==
X-Gm-Message-State: AOJu0YzhZDmUamxWHXlWBmHZsbcopnbY3KdrRfIomGvw3CZykCP+pbUa
 uG16nGmN+jnC03kGVsjHl9t9q8i6q7JZVu372YUpfIAkjcdJ/0R4UPOWDlYlTm2cvolkdUIgfkp
 gOwxESCU=
X-Gm-Gg: AZuq6aL50Rw7f0ApArhGiwvMX19iDaWTOQDZNgGTcEooTpe7LDzo7tugiCtckvQBnm+
 YeaYHOjXa7DOrcmeTak3Zp+qc8+lFmodCjpvOLyyAIvaa5LsthAnZJYSrw66okPVdbSI1FJSr4q
 nlD8qfEd15wXLWsE4BnOVM8/rcyrhjykAUkU/6ymurDaThZ3RQTii/pFsVuPTZVK/8LNJEoJTnc
 iL/YK50a58XAJQ0gqzN5HMudkN0OiAfhOYqsE7TEHyPCXPGXQ/pTP1zm+2/MuRo+eirFivaFX2h
 DhjV14TuSkV9FVcsss3THcwySd3BsVVMHPyxWHlVefZrQDRLavRVi8o0O/t7FDRl43uRbtMGEmT
 W8ek0fDEq7t71V1qS7NXmt4gdTEU9xvg1HtxnXZyq3cJbQIxRqRPyZq/j3N019deXVHf8cB/Qo4
 VPAQv9DK21NDIoTMByw5Cz3dCtJO7z8d2ySQitoUEo
X-Received: by 2002:a05:6000:401e:b0:430:96bd:411b with SMTP id
 ffacd0b85a97d-435f3ad5929mr137100f8f.58.1769703008344; 
 Thu, 29 Jan 2026 08:10:08 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.10.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:10:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/43] arm: add {get,set}_dczid_bs helpers
Date: Thu, 29 Jan 2026 16:09:16 +0000
Message-ID: <20260129160917.1415092-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Cornelia Huck <cohuck@redhat.com>

Most accesses to cpu->dcz_blocksize really care about
DCZID_EL0.BS (i.e. the part of the register that does not change at
different EL.) Wean them off directly dealing with cpu->dcz_blocksize
so that we can switch to handling DCZID_EL0 differently in a followup
patch.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Message-id: 20260105154119.59853-2-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c               |  2 +-
 target/arm/cpu.h               | 10 ++++++++++
 target/arm/cpu64.c             |  4 ++--
 target/arm/helper.c            |  1 +
 target/arm/tcg/cpu64.c         | 22 +++++++++++-----------
 target/arm/tcg/helper-a64.c    |  2 +-
 target/arm/tcg/mte_helper.c    |  4 ++--
 target/arm/tcg/translate-a64.c |  2 +-
 8 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6e1cbf3d61..586202071d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2175,7 +2175,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
 
     if (tcg_enabled()) {
-        int dcz_blocklen = 4 << cpu->dcz_blocksize;
+        int dcz_blocklen = 4 << get_dczid_bs(cpu);
 
         /*
          * We only support DCZ blocklen that fits on one page.
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1eaf5a3fdd..019f4e6147 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1179,6 +1179,16 @@ struct ARMCPUClass {
     ResettablePhases parent_phases;
 };
 
+static inline uint8_t get_dczid_bs(ARMCPU *cpu)
+{
+    return cpu->dcz_blocksize;
+}
+
+static inline void set_dczid_bs(ARMCPU *cpu, uint8_t bs)
+{
+    cpu->dcz_blocksize = bs;
+}
+
 /* Callback functions for the generic timer's timers. */
 void arm_gt_ptimer_cb(void *opaque);
 void arm_gt_vtimer_cb(void *opaque);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index bf30381370..4dfc03973e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -689,7 +689,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
     /* 2048KB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
-    cpu->dcz_blocksize = 4; /* 64 bytes */
+    set_dczid_bs(cpu, 4); /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
@@ -751,7 +751,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 1, 64, 32 * KiB, 2);
     /* 1024KB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
-    cpu->dcz_blocksize = 4; /* 64 bytes */
+    set_dczid_bs(cpu, 4); /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index dce648b482..4acaee407d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3318,6 +3318,7 @@ static uint64_t aa64_dczid_read(CPUARMState *env, const ARMCPRegInfo *ri)
     if (aa64_zva_access(env, NULL, false) == CP_ACCESS_OK) {
         dzp_bit = 0;
     }
+
     return cpu->dcz_blocksize | dzp_bit;
 }
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 611838171b..fa80e48d2b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -72,7 +72,7 @@ static void aarch64_a35_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR0, 0x00101122);
     SET_IDREG(isar, ID_AA64MMFR1, 0);
     SET_IDREG(isar, CLIDR, 0x0a200023);
-    cpu->dcz_blocksize = 4;
+    set_dczid_bs(cpu, 4);
 
     /* From B2.4 AArch64 Virtual Memory control registers */
     cpu->reset_sctlr = 0x00c50838;
@@ -219,7 +219,7 @@ static void aarch64_a55_initfn(Object *obj)
     /* Ordered by B2.4 AArch64 registers by functional group */
     SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0x84448004; /* L1Ip = VIPT */
-    cpu->dcz_blocksize = 4; /* 64 bytes */
+    set_dczid_bs(cpu, 4); /* 64 bytes */
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
@@ -325,7 +325,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
     /* 1MB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
-    cpu->dcz_blocksize = 4; /* 64 bytes */
+    set_dczid_bs(cpu, 4); /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
@@ -352,7 +352,7 @@ static void aarch64_a76_initfn(Object *obj)
     /* Ordered by B2.4 AArch64 registers by functional group */
     SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0x8444C004;
-    cpu->dcz_blocksize = 4;
+    set_dczid_bs(cpu, 4);
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
@@ -424,7 +424,7 @@ static void aarch64_a78ae_initfn(Object *obj)
     /* Ordered by 3.2.4 AArch64 registers by functional group */
     SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0x9444c004;
-    cpu->dcz_blocksize = 4;
+    set_dczid_bs(cpu, 4);
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0010100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000001200031ull);
@@ -517,7 +517,7 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 2);
     /* 8MB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 256, 8 * MiB, 7);
-    cpu->dcz_blocksize = 6; /* 256 bytes */
+    set_dczid_bs(cpu, 6); /* 256 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
@@ -673,7 +673,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     /* Ordered by B2.4 AArch64 registers by functional group */
     SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0x8444c004;
-    cpu->dcz_blocksize = 4;
+    set_dczid_bs(cpu, 4);
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
@@ -749,7 +749,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     /* Ordered by 3.2.4 AArch64 registers by functional group */
     SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0xb444c004; /* With DIC and IDC set */
-    cpu->dcz_blocksize = 4;
+    set_dczid_bs(cpu, 4);
     SET_IDREG(isar, ID_AA64AFR0, 0x00000000);
     SET_IDREG(isar, ID_AA64AFR1, 0x00000000);
     SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull);
@@ -1011,7 +1011,7 @@ static void aarch64_a710_initfn(Object *obj)
     SET_IDREG(isar, CLIDR, 0x0000001482000023ull);
     cpu->gm_blocksize      = 4;
     cpu->ctr               = 0x000000049444c004ull;
-    cpu->dcz_blocksize     = 4;
+    set_dczid_bs(cpu, 4);
     /* TODO FEAT_MPAM: mpamidr_el1 = 0x0000_0001_0006_003f */
 
     /* Section B.5.2: PMCR_EL0 */
@@ -1113,7 +1113,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     SET_IDREG(isar, CLIDR, 0x0000001482000023ull);
     cpu->gm_blocksize      = 4;
     cpu->ctr               = 0x00000004b444c004ull;
-    cpu->dcz_blocksize     = 4;
+    set_dczid_bs(cpu, 4);
     /* TODO FEAT_MPAM: mpamidr_el1 = 0x0000_0001_001e_01ff */
 
     /* Section B.7.2: PMCR_EL0 */
@@ -1381,7 +1381,7 @@ void aarch64_max_tcg_initfn(Object *obj)
      * blocksize since we don't have to follow what the hardware does.
      */
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
-    cpu->dcz_blocksize = 7; /*  512 bytes */
+    set_dczid_bs(cpu, 7); /*  512 bytes */
 #endif
     cpu->gm_blocksize = 6;  /*  256 bytes */
 
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ba1d775d81..e4d2c2e392 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -792,7 +792,7 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
      * (which matches the usual QEMU behaviour of not implementing either
      * alignment faults or any memory attribute handling).
      */
-    int blocklen = 4 << env_archcpu(env)->dcz_blocksize;
+    int blocklen = 4 << get_dczid_bs(env_archcpu(env));
     uint64_t vaddr = vaddr_in & ~(blocklen - 1);
     int mmu_idx = arm_env_mmu_index(env);
     void *mem;
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index bb48fe359b..08b8e7176a 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -545,7 +545,7 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
      * i.e. 32 bytes, which is an unreasonably small dcz anyway,
      * to make sure that we can access one complete tag byte here.
      */
-    log2_dcz_bytes = env_archcpu(env)->dcz_blocksize + 2;
+    log2_dcz_bytes = get_dczid_bs(env_archcpu(env)) + 2;
     log2_tag_bytes = log2_dcz_bytes - (LOG2_TAG_GRANULE + 1);
     dcz_bytes = (intptr_t)1 << log2_dcz_bytes;
     tag_bytes = (intptr_t)1 << log2_tag_bytes;
@@ -945,7 +945,7 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
      * i.e. 32 bytes, which is an unreasonably small dcz anyway, to make
      * sure that we can access one complete tag byte here.
      */
-    log2_dcz_bytes = env_archcpu(env)->dcz_blocksize + 2;
+    log2_dcz_bytes = get_dczid_bs(env_archcpu(env)) + 2;
     log2_tag_bytes = log2_dcz_bytes - (LOG2_TAG_GRANULE + 1);
     dcz_bytes = (intptr_t)1 << log2_dcz_bytes;
     tag_bytes = (intptr_t)1 << log2_tag_bytes;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index cde22a5cca..7a8cd99e00 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10712,7 +10712,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
     dc->features = env->features;
-    dc->dcz_blocksize = arm_cpu->dcz_blocksize;
+    dc->dcz_blocksize = get_dczid_bs(arm_cpu);
     dc->gm_blocksize = arm_cpu->gm_blocksize;
 
 #ifdef CONFIG_USER_ONLY
-- 
2.43.0


