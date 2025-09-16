Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD881CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5V-0003qq-Hb; Tue, 16 Sep 2025 14:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4c-00037n-O1
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4Z-0001cE-V4
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45dcff2f313so36463695e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045994; x=1758650794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1mgWq+XLJB78p1c1ZffyK1tRiq8+FbVO+cvOUHxJI0A=;
 b=g6E6Hs2L2sz3aXYoapdgO6irdKa8S+TLloMP4/+Tm9ohxUG+AnQwrqGzgtbJCDuNTn
 hR2TNNII5QFZ0A4EY0RRKNhljV4vQOnfQJPYDcjiM4KXZjqrDy+8nelSKARYFfm4T7Qi
 AZdeKBrOxzwCq4zQigjAKCI41M5yt3Fsb+vrXwzqrzVnv2gSQXTrhV0NCbdj7lXzp4qm
 7t2/O7vnip0EC4iCnCKWUY4fHb1CcamzbK76qNFnfEaf5+ACqzN7bjgQ2/YFmhjKMCSS
 +M91DMT4c4hmqpir0wbLU0QHwoI6vxoX0sfxZVpVPBJ7TB255X13X5Xbal05uyD5XsHH
 ZjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045994; x=1758650794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mgWq+XLJB78p1c1ZffyK1tRiq8+FbVO+cvOUHxJI0A=;
 b=XJZ0qWewOaL85Qf/k4uEgiHrvNrO4AQCPXhWAZzWvsrHyiToya8svt8z+Pa4FpvNeF
 ZwP3RY+GSygs/mpMKsxUd9Jz+H5u/N1iYlCDq0Z8awVXDxffAuugMUke2RdkzZB/W32f
 iyWJKTy9mcvDSLaYYbVaYt0wSXhzeKv/M8oyvZwJsfsnABbkI4FhOjnCYKNhSC2NNMsP
 BgJDyHguui4HOqc24Ye1rsKQw2r1G+VU1VQhcq/ATT2B8esXM5QGls3acYr/GBOdIRnK
 LgKNoQAIOKmD49N9e1emazbd3UPVHFxh3j1XAgF5K9rzcHdnKXTgUm5Frkqx0VhtGEXZ
 CPWA==
X-Gm-Message-State: AOJu0YyqPJqSg4n6rQF2tZc3o0QVWwwnWPutvfbXTM/Zrwd5zTl4Bmgn
 Por3LohTbbaVfOGEsuMewGi1yIQdT3TH64EK7k1es7sNP68uT9DTvqB7uonOmMAKIzZUonk3x72
 bP2Vr
X-Gm-Gg: ASbGncvHu49blPCQM234/njsHRAab7RR2wjM0+hvEW/qNnaadcEbbcYRCyqE+mqlg9e
 N4Zj8dsecdl046q7e57jJEZ8E2z0InSE9IRSdloDieuMqoWNddxKxiRKng02Rb/xYRFLC5oBvAn
 qF2QkzBQ7eCV5pb44mFncK+OKyaxsLKDGl8P3M6AIvS+Ay8c4I9TPj3/vOX0MCwn+CMUd7Ga/M4
 lDtD+PgAUlxWUdJ7j4Thn7lw+O34b2a9Kue3EszqRC44zcvLvTUKeXhbAUctPQJklQr8994++Fx
 3+JuejFrXA7tuS7z0/t2HXeS+IPwj/ybE+IKbBQ6eJNVpWPJDOwP6UaCch8xFJC0je7D4Pn0j2e
 d47HFeYAK4eInhgf41ya7cY3opZTo
X-Google-Smtp-Source: AGHT+IG+2a7Mn7vaI0A/l4I1viiqGG+69vkh5BaStzwV3frau6XAXLY/GHzLS4yFfBCIttICoTO11g==
X-Received: by 2002:a05:600c:19c9:b0:45d:d291:5dc1 with SMTP id
 5b1f17b1804b1-45f211da6aamr149292015e9.15.1758045994156; 
 Tue, 16 Sep 2025 11:06:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/36] target/arm: Drop ARM_FEATURE_IWMMXT handling
Date: Tue, 16 Sep 2025 19:05:53 +0100
Message-ID: <20250916180611.1481266-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

We have now removed all the CPU types which had the Intel XScale
extensions indicated via ARM_FEATURE_IWMMXT, so this feature bit
is never set. Remove all the code that can only be reached when
using this flag.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250828140422.3271703-6-peter.maydell@linaro.org
---
 bsd-user/arm/target_arch_elf.h |  1 -
 target/arm/cpu.h               | 19 ----------
 linux-user/arm/elfload.c       |  1 -
 linux-user/arm/signal.c        | 67 ----------------------------------
 target/arm/cpu.c               |  8 ----
 target/arm/machine.c           | 21 -----------
 6 files changed, 117 deletions(-)

diff --git a/bsd-user/arm/target_arch_elf.h b/bsd-user/arm/target_arch_elf.h
index b1c0fd2b320..b54bf5fbc69 100644
--- a/bsd-user/arm/target_arch_elf.h
+++ b/bsd-user/arm/target_arch_elf.h
@@ -86,7 +86,6 @@ static uint32_t get_elf_hwcap(void)
     /* probe for the extra features */
     /* EDSP is in v5TE and above */
     GET_FEATURE(ARM_FEATURE_V5, ARM_HWCAP_ARM_EDSP);
-    GET_FEATURE(ARM_FEATURE_IWMMXT, ARM_HWCAP_ARM_IWMMXT);
     GET_FEATURE(ARM_FEATURE_THUMB2EE, ARM_HWCAP_ARM_THUMBEE);
     GET_FEATURE(ARM_FEATURE_NEON, ARM_HWCAP_ARM_NEON);
     GET_FEATURE(ARM_FEATURE_V6K, ARM_HWCAP_ARM_TLS);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 92fcb96671e..6644043f4c2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -697,14 +697,6 @@ typedef struct CPUArchState {
      */
     uint64_t exclusive_high;
 
-    /* iwMMXt coprocessor state.  */
-    struct {
-        uint64_t regs[16];
-        uint64_t val;
-
-        uint32_t cregs[16];
-    } iwmmxt;
-
     struct {
         ARMPACKey apia;
         ARMPACKey apib;
@@ -1863,16 +1855,6 @@ enum arm_cpu_mode {
 /* QEMU-internal value meaning "FPSCR, but we care only about NZCV" */
 #define QEMU_VFP_FPSCR_NZCV 0xffff
 
-/* iwMMXt coprocessor control registers.  */
-#define ARM_IWMMXT_wCID  0
-#define ARM_IWMMXT_wCon  1
-#define ARM_IWMMXT_wCSSF 2
-#define ARM_IWMMXT_wCASF 3
-#define ARM_IWMMXT_wCGR0 8
-#define ARM_IWMMXT_wCGR1 9
-#define ARM_IWMMXT_wCGR2 10
-#define ARM_IWMMXT_wCGR3 11
-
 /* V7M CCR bits */
 FIELD(V7M_CCR, NONBASETHRDENA, 0, 1)
 FIELD(V7M_CCR, USERSETMPEND, 1, 1)
@@ -2442,7 +2424,6 @@ QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
  */
 enum arm_features {
     ARM_FEATURE_AUXCR,  /* ARM1026 Auxiliary control register.  */
-    ARM_FEATURE_IWMMXT, /* Intel iwMMXt extension.  */
     ARM_FEATURE_V6,
     ARM_FEATURE_V6K,
     ARM_FEATURE_V7,
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index 308ed23fcbd..b1a4db44660 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -76,7 +76,6 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 
     /* EDSP is in v5TE and above, but all our v5 CPUs are v5TE */
     GET_FEATURE(ARM_FEATURE_V5, ARM_HWCAP_ARM_EDSP);
-    GET_FEATURE(ARM_FEATURE_IWMMXT, ARM_HWCAP_ARM_IWMMXT);
     GET_FEATURE(ARM_FEATURE_THUMB2EE, ARM_HWCAP_ARM_THUMBEE);
     GET_FEATURE(ARM_FEATURE_NEON, ARM_HWCAP_ARM_NEON);
     GET_FEATURE(ARM_FEATURE_V6K, ARM_HWCAP_ARM_TLS);
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index 8db1c4b2338..3b387cd6d78 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -76,21 +76,7 @@ struct target_vfp_sigframe {
     struct target_user_vfp_exc ufp_exc;
 } __attribute__((__aligned__(8)));
 
-struct target_iwmmxt_sigframe {
-    abi_ulong magic;
-    abi_ulong size;
-    uint64_t regs[16];
-    /* Note that not all the coprocessor control registers are stored here */
-    uint32_t wcssf;
-    uint32_t wcasf;
-    uint32_t wcgr0;
-    uint32_t wcgr1;
-    uint32_t wcgr2;
-    uint32_t wcgr3;
-} __attribute__((__aligned__(8)));
-
 #define TARGET_VFP_MAGIC 0x56465001
-#define TARGET_IWMMXT_MAGIC 0x12ef842a
 
 struct sigframe
 {
@@ -267,25 +253,6 @@ static abi_ulong *setup_sigframe_vfp(abi_ulong *regspace, CPUARMState *env)
     return (abi_ulong*)(vfpframe+1);
 }
 
-static abi_ulong *setup_sigframe_iwmmxt(abi_ulong *regspace, CPUARMState *env)
-{
-    int i;
-    struct target_iwmmxt_sigframe *iwmmxtframe;
-    iwmmxtframe = (struct target_iwmmxt_sigframe *)regspace;
-    __put_user(TARGET_IWMMXT_MAGIC, &iwmmxtframe->magic);
-    __put_user(sizeof(*iwmmxtframe), &iwmmxtframe->size);
-    for (i = 0; i < 16; i++) {
-        __put_user(env->iwmmxt.regs[i], &iwmmxtframe->regs[i]);
-    }
-    __put_user(env->vfp.xregs[ARM_IWMMXT_wCSSF], &iwmmxtframe->wcssf);
-    __put_user(env->vfp.xregs[ARM_IWMMXT_wCASF], &iwmmxtframe->wcssf);
-    __put_user(env->vfp.xregs[ARM_IWMMXT_wCGR0], &iwmmxtframe->wcgr0);
-    __put_user(env->vfp.xregs[ARM_IWMMXT_wCGR1], &iwmmxtframe->wcgr1);
-    __put_user(env->vfp.xregs[ARM_IWMMXT_wCGR2], &iwmmxtframe->wcgr2);
-    __put_user(env->vfp.xregs[ARM_IWMMXT_wCGR3], &iwmmxtframe->wcgr3);
-    return (abi_ulong*)(iwmmxtframe+1);
-}
-
 static void setup_sigframe(struct target_ucontext *uc,
                            target_sigset_t *set, CPUARMState *env)
 {
@@ -306,9 +273,6 @@ static void setup_sigframe(struct target_ucontext *uc,
     if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
         regspace = setup_sigframe_vfp(regspace, env);
     }
-    if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
-        regspace = setup_sigframe_iwmmxt(regspace, env);
-    }
 
     /* Write terminating magic word */
     __put_user(0, regspace);
@@ -435,31 +399,6 @@ static abi_ulong *restore_sigframe_vfp(CPUARMState *env, abi_ulong *regspace)
     return (abi_ulong*)(vfpframe + 1);
 }
 
-static abi_ulong *restore_sigframe_iwmmxt(CPUARMState *env,
-                                          abi_ulong *regspace)
-{
-    int i;
-    abi_ulong magic, sz;
-    struct target_iwmmxt_sigframe *iwmmxtframe;
-    iwmmxtframe = (struct target_iwmmxt_sigframe *)regspace;
-
-    __get_user(magic, &iwmmxtframe->magic);
-    __get_user(sz, &iwmmxtframe->size);
-    if (magic != TARGET_IWMMXT_MAGIC || sz != sizeof(*iwmmxtframe)) {
-        return 0;
-    }
-    for (i = 0; i < 16; i++) {
-        __get_user(env->iwmmxt.regs[i], &iwmmxtframe->regs[i]);
-    }
-    __get_user(env->vfp.xregs[ARM_IWMMXT_wCSSF], &iwmmxtframe->wcssf);
-    __get_user(env->vfp.xregs[ARM_IWMMXT_wCASF], &iwmmxtframe->wcssf);
-    __get_user(env->vfp.xregs[ARM_IWMMXT_wCGR0], &iwmmxtframe->wcgr0);
-    __get_user(env->vfp.xregs[ARM_IWMMXT_wCGR1], &iwmmxtframe->wcgr1);
-    __get_user(env->vfp.xregs[ARM_IWMMXT_wCGR2], &iwmmxtframe->wcgr2);
-    __get_user(env->vfp.xregs[ARM_IWMMXT_wCGR3], &iwmmxtframe->wcgr3);
-    return (abi_ulong*)(iwmmxtframe + 1);
-}
-
 static int do_sigframe_return(CPUARMState *env,
                               target_ulong context_addr,
                               struct target_ucontext *uc)
@@ -482,12 +421,6 @@ static int do_sigframe_return(CPUARMState *env,
             return 1;
         }
     }
-    if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
-        regspace = restore_sigframe_iwmmxt(env, regspace);
-        if (!regspace) {
-            return 1;
-        }
-    }
 
     target_restore_altstack(&uc->tuc_stack, env);
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9781055bdc1..02e2a31a863 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -247,10 +247,6 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
 
     cpu->power_state = cs->start_powered_off ? PSCI_OFF : PSCI_ON;
 
-    if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
-        env->iwmmxt.cregs[ARM_IWMMXT_wCID] = 0x69051000 | 'Q';
-    }
-
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
         /* 64 bit CPUs always start in 64 bit mode */
         env->aarch64 = true;
@@ -2610,14 +2606,10 @@ static const Property arm_cpu_properties[] = {
 static const gchar *arm_gdb_arch_name(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
 
     if (arm_gdbstub_is_aarch64(cpu)) {
         return "aarch64";
     }
-    if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
-        return "iwmmxt";
-    }
     return "arm";
 }
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6986915bee8..6666a0c50c4 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -221,26 +221,6 @@ static const VMStateDescription vmstate_vfp = {
     }
 };
 
-static bool iwmmxt_needed(void *opaque)
-{
-    ARMCPU *cpu = opaque;
-    CPUARMState *env = &cpu->env;
-
-    return arm_feature(env, ARM_FEATURE_IWMMXT);
-}
-
-static const VMStateDescription vmstate_iwmmxt = {
-    .name = "cpu/iwmmxt",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = iwmmxt_needed,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT64_ARRAY(env.iwmmxt.regs, ARMCPU, 16),
-        VMSTATE_UINT32_ARRAY(env.iwmmxt.cregs, ARMCPU, 16),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 /* The expression ARM_MAX_VQ - 2 is 0 for pure AArch32 build,
  * and ARMPredicateReg is actively empty.  This triggers errors
  * in the expansion of the VMSTATE macros.
@@ -1102,7 +1082,6 @@ const VMStateDescription vmstate_arm_cpu = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_vfp,
-        &vmstate_iwmmxt,
         &vmstate_m,
         &vmstate_thumb2ee,
         /* pmsav7_rnr must come before pmsav7 so that we have the
-- 
2.43.0


