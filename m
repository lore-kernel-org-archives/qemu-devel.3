Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42790FED9F6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YZO-0006pW-Fy; Tue, 17 Mar 2026 13:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2YYx-00064x-HY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:50:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2YYu-0007RG-QH
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:50:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso51323935e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773769835; x=1774374635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ly9PsI9iLh01ps0beGN9MgESHnp5XRSdzpqYXfxsVrg=;
 b=FNxvygaBKnXuCauYkw/CQtht9pF2/3RIKBolkLWCpyatari0oNfYfL1Rxsp2yG74lW
 YPe8NKxniKj9qLjfYYjZgvTpK2bYueeRWD6TzUwumBPxMvbnhYiZWxr6JTf8majcbB6Y
 aBOpSUwVxnTbnuN0b7Cb5Lm56ev8t3TMw93DOqUXHSos60bpUwGCV96Yv+BQsTbaURBo
 sSIEi1l2JuufV9v2HcYuAcJA+VzqnrQkoGYxypZREolYEyvWNDxWqkZmye7lyeDizVk/
 ySIYohMLFKtP3R3m74eqR3z8SMUkgGGvPSluPZK8h/2fBinvPRx5DfF1LH2I845zYzJ8
 FJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769835; x=1774374635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ly9PsI9iLh01ps0beGN9MgESHnp5XRSdzpqYXfxsVrg=;
 b=HmbfjkjdT9Y0FzqaSxI/zGjdgUmML4SrbuBA1Slw/bLYQn7m9ofRti8WicA1S0EKQo
 7QL9YwRDQmgtOpOl6RY+XaQAudR5W0u8iJ8MpwSeLP0p/OpySZWIJG729k0hflEJteqx
 xG51V8AhW6M7DefjAdsAsougtdlM9QGEN7szGQDNyY9JIIvsABkiReitp/Iyi0M5dRk3
 QQykuQ670T4R67EdEN4Uq+APgT6qSSGBma1uK1BWtFTRRMnm4IRyP4A1iedcXbI004az
 WNIg1uj6uCvzXLnpCMJ/oQ4lsvwuRSWKhN8jWrdOHWobhpPAgMEJ6F9S0nRGGPL2kTbQ
 98tg==
X-Gm-Message-State: AOJu0YzA0NU/kkkZceDNH7ufl7m2Js3q6BMrgxCNXIOik1UBanzCTJXu
 sRGm9T5m/csr3xyvz1SOghmSs33uAvxywtM2zW1iCg0/H0ebetJXIUENbw83O/eAdW2IQPjjgHK
 dNZ0E
X-Gm-Gg: ATEYQzzDi9a+p4N2obslojhGwuZFWNCGYvx+SKKZQE5jGbJykvsrJ1QGfCLI4EbyyoB
 HpwZUzq8RmJcqrM2Gf9Sgt+THJvKBXZViCGmb3rkPgwy/SyyklukL5ifrvsspJjzNtJvN3mfzuY
 N+qkrYWV+/u1U8B0Dv4W6gdnDiEYpI2Yf5FVfrsQp0qje7QPF/dYGKe9JrLpZFDdaer0XV19vbV
 kYbOB8Go06cx8cLUsBppASYTtqNinueAsWkzXJkwKnzmZy6YB24tnZEYM55y8KNxZbEJ4dk6Ucf
 kbdnL7m7xEM/2AzvQS/8NY1oytJMJblJpZp60fibJVuWzBTHgCy7oO+zBaDTeSW0GAjfTE/y+/Y
 ezVVB4pZoH4TZ/ghQjPak5ixCh9wZ930JqFTwNTvUgz2HS5qYw3bZf4zvlcAuBwjceMqIMGLu+I
 3t1TNR4rA/etXjsu8p9tVzYW4amxXBpgf3mn2K29EhRv3c12+Y2O3/BBsAoTWZhe2q93q79Q6Ul
 MYXj10kGHSzcJ7WXmyaeN5sE+iprz8=
X-Received: by 2002:a05:600c:591a:b0:485:3f58:da1 with SMTP id
 5b1f17b1804b1-486f4451159mr5563245e9.9.1773769835080; 
 Tue, 17 Mar 2026 10:50:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c7220dsm118786995e9.30.2026.03.17.10.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 10:50:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 1/3] target/mips: Move 'mvp' field from CPUMIPSState to MIPSCPU
Date: Tue, 17 Mar 2026 17:50:28 +0000
Message-ID: <20260317175031.3035740-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317175031.3035740-1-peter.maydell@linaro.org>
References: <20260317175031.3035740-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The 'mvp' field in the CPUMIPSState is a pointer to memory allocated
in mvp_init().  This is in theory fine, but in practice it clashes
with the current linux-user implementation of cpu_copy(), which
assumes it can do a shallow memcpy() copy of the CPU env struct in
order to clone the CPU when creating a new thread.

Almost all of the MIPS env struct is actually memcpy() copyable;
one of the exceptions is the mvp pointer. We don't need this
to be in the env struct; move it to the CPU object struct instead.

At the moment the memcpy() of the env->mvp pointer doesn't have any
obvious ill-effects, because we never free the memory and it
doesn't contain anything that varies at runtime for user-mode.
So thread 2 ends up pointing at thread 1's mvp struct, but it
still works OK. However, we would like to free the mvp memory to
avoid a leak when a user-mode thread exits, and unless we avoid
the shallow copy this will end up with a double-free when both
thread 1 and thread 2 free the same mvp struct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/mips/malta.c                     |  4 ++--
 target/mips/cpu-defs.c.inc          | 10 +++++----
 target/mips/cpu.c                   |  2 +-
 target/mips/cpu.h                   |  3 ++-
 target/mips/internal.h              |  3 ++-
 target/mips/system/machine.c        |  2 +-
 target/mips/tcg/system/cp0_helper.c | 35 ++++++++++++++++++-----------
 target/mips/tcg/translate.c         |  6 +++--
 8 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 812ff64d83..dfd537f44a 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -968,10 +968,10 @@ static void malta_mips_config(MIPSCPU *cpu)
     CPUState *cs = CPU(cpu);
 
     if (ase_mt_available(env)) {
-        env->mvp->CP0_MVPConf0 = deposit32(env->mvp->CP0_MVPConf0,
+        cpu->mvp->CP0_MVPConf0 = deposit32(cpu->mvp->CP0_MVPConf0,
                                            CP0MVPC0_PTC, 8,
                                            smp_cpus * cs->nr_threads - 1);
-        env->mvp->CP0_MVPConf0 = deposit32(env->mvp->CP0_MVPConf0,
+        cpu->mvp->CP0_MVPConf0 = deposit32(cpu->mvp->CP0_MVPConf0,
                                            CP0MVPC0_PVPE, 4, smp_cpus - 1);
     }
 }
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index d93b9d341a..faefab0473 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -1034,7 +1034,9 @@ static void fpu_init (CPUMIPSState *env, const mips_def_t *def)
 
 static void mvp_init(CPUMIPSState *env)
 {
-    env->mvp = g_malloc0(sizeof(CPUMIPSMVPContext));
+    MIPSCPU *cpu = env_archcpu(env);
+
+    cpu->mvp = g_malloc0(sizeof(CPUMIPSMVPContext));
 
     if (!ase_mt_available(env)) {
         return;
@@ -1044,7 +1046,7 @@ static void mvp_init(CPUMIPSState *env)
        programmable cache partitioning implemented, number of allocatable
        and shareable TLB entries, MVP has allocatable TCs, 2 VPEs
        implemented, 5 TCs implemented. */
-    env->mvp->CP0_MVPConf0 = (1U << CP0MVPC0_M) | (1 << CP0MVPC0_TLBS) |
+    cpu->mvp->CP0_MVPConf0 = (1U << CP0MVPC0_M) | (1 << CP0MVPC0_TLBS) |
                              (0 << CP0MVPC0_GS) | (1 << CP0MVPC0_PCP) |
 // TODO: actually do 2 VPEs.
 //                             (1 << CP0MVPC0_TCA) | (0x1 << CP0MVPC0_PVPE) |
@@ -1053,12 +1055,12 @@ static void mvp_init(CPUMIPSState *env)
                              (0x00 << CP0MVPC0_PTC);
 #if !defined(CONFIG_USER_ONLY)
     /* Usermode has no TLB support */
-    env->mvp->CP0_MVPConf0 |= (env->tlb->nb_tlb << CP0MVPC0_PTLBE);
+    cpu->mvp->CP0_MVPConf0 |= (env->tlb->nb_tlb << CP0MVPC0_PTLBE);
 #endif
 
     /* Allocatable CP1 have media extensions, allocatable CP1 have FP support,
        no UDI implemented, no CP2 implemented, 1 CP1 implemented. */
-    env->mvp->CP0_MVPConf1 = (1U << CP0MVPC1_CIM) | (1 << CP0MVPC1_CIF) |
+    cpu->mvp->CP0_MVPConf1 = (1U << CP0MVPC1_CIM) | (1 << CP0MVPC1_CIF) |
                              (0x0 << CP0MVPC1_PCX) | (0x0 << CP0MVPC1_PCP2) |
                              (0x1 << CP0MVPC1_PCP1);
 }
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 5f88c077db..789ca188b5 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -339,7 +339,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 
         if (cs->cpu_index == 0) {
             /* VPE0 starts up enabled.  */
-            env->mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
+            cpu->mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
             env->CP0_VPEConf0 |= (1 << CP0VPEC0_MVP) | (1 << CP0VPEC0_VPA);
 
             /* TC0 starts up unhalted.  */
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ed662135cb..8de3178b6d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1174,7 +1174,6 @@ typedef struct CPUArchState {
     struct {} end_reset_fields;
 
     /* Fields from here on are preserved across CPU reset. */
-    CPUMIPSMVPContext *mvp;
 #if !defined(CONFIG_USER_ONLY)
     CPUMIPSTLBContext *tlb;
     qemu_irq irq[8];
@@ -1209,6 +1208,8 @@ struct ArchCPU {
     Clock *clock;
     Clock *count_div; /* Divider for CP0_Count clock */
 
+    CPUMIPSMVPContext *mvp;
+
     /* Properties */
     bool is_big_endian;
 };
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 28eb28936b..95b8b7bb9c 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -246,10 +246,11 @@ static inline void restore_pamask(CPUMIPSState *env)
 
 static inline int mips_vpe_active(CPUMIPSState *env)
 {
+    MIPSCPU *cpu = env_archcpu(env);
     int active = 1;
 
     /* Check that the VPE is enabled.  */
-    if (!(env->mvp->CP0_MVPControl & (1 << CP0MVPCo_EVP))) {
+    if (!(cpu->mvp->CP0_MVPControl & (1 << CP0MVPCo_EVP))) {
         active = 0;
     }
     /* Check that the VPE is activated.  */
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 8af11fd896..67f6f414d9 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -233,7 +233,7 @@ const VMStateDescription vmstate_mips_cpu = {
                        CPUMIPSFPUContext),
 
         /* MVP */
-        VMSTATE_STRUCT_POINTER(env.mvp, MIPSCPU, vmstate_mvp,
+        VMSTATE_STRUCT_POINTER(mvp, MIPSCPU, vmstate_mvp,
                                CPUMIPSMVPContext),
 
         /* TLB */
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index b69e70d7fc..123d5c217c 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -229,17 +229,20 @@ uint32_t cpu_mips_get_random(CPUMIPSState *env)
 /* CP0 helpers */
 target_ulong helper_mfc0_mvpcontrol(CPUMIPSState *env)
 {
-    return env->mvp->CP0_MVPControl;
+    MIPSCPU *cpu = env_archcpu(env);
+    return cpu->mvp->CP0_MVPControl;
 }
 
 target_ulong helper_mfc0_mvpconf0(CPUMIPSState *env)
 {
-    return env->mvp->CP0_MVPConf0;
+    MIPSCPU *cpu = env_archcpu(env);
+    return cpu->mvp->CP0_MVPConf0;
 }
 
 target_ulong helper_mfc0_mvpconf1(CPUMIPSState *env)
 {
-    return env->mvp->CP0_MVPConf1;
+    MIPSCPU *cpu = env_archcpu(env);
+    return cpu->mvp->CP0_MVPConf1;
 }
 
 target_ulong helper_mfc0_random(CPUMIPSState *env)
@@ -514,6 +517,7 @@ void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_mvpcontrol(CPUMIPSState *env, target_ulong arg1)
 {
+    MIPSCPU *cpu = env_archcpu(env);
     uint32_t mask = 0;
     uint32_t newval;
 
@@ -521,14 +525,14 @@ void helper_mtc0_mvpcontrol(CPUMIPSState *env, target_ulong arg1)
         mask |= (1 << CP0MVPCo_CPA) | (1 << CP0MVPCo_VPC) |
                 (1 << CP0MVPCo_EVP);
     }
-    if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)) {
+    if (cpu->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)) {
         mask |= (1 << CP0MVPCo_STLB);
     }
-    newval = (env->mvp->CP0_MVPControl & ~mask) | (arg1 & mask);
+    newval = (cpu->mvp->CP0_MVPControl & ~mask) | (arg1 & mask);
 
     /* TODO: Enable/disable shared TLB, enable/disable VPEs. */
 
-    env->mvp->CP0_MVPControl = newval;
+    cpu->mvp->CP0_MVPControl = newval;
 }
 
 void helper_mtc0_vpecontrol(CPUMIPSState *env, target_ulong arg1)
@@ -616,10 +620,11 @@ void helper_mttc0_vpeconf0(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_vpeconf1(CPUMIPSState *env, target_ulong arg1)
 {
+    MIPSCPU *cpu = env_archcpu(env);
     uint32_t mask = 0;
     uint32_t newval;
 
-    if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC))
+    if (cpu->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC))
         mask |= (0xff << CP0VPEC1_NCX) | (0xff << CP0VPEC1_NCP2) |
                 (0xff << CP0VPEC1_NCP1);
     newval = (env->CP0_VPEConf1 & ~mask) | (arg1 & mask);
@@ -689,10 +694,11 @@ void helper_mttc0_tcstatus(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_tcbind(CPUMIPSState *env, target_ulong arg1)
 {
+    MIPSCPU *cpu = env_archcpu(env);
     uint32_t mask = (1 << CP0TCBd_TBE);
     uint32_t newval;
 
-    if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)) {
+    if (cpu->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)) {
         mask |= (1 << CP0TCBd_CurVPE);
     }
     newval = (env->active_tc.CP0_TCBind & ~mask) | (arg1 & mask);
@@ -705,8 +711,9 @@ void helper_mttc0_tcbind(CPUMIPSState *env, target_ulong arg1)
     uint32_t mask = (1 << CP0TCBd_TBE);
     uint32_t newval;
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
+    MIPSCPU *other_cpu = env_archcpu(other);
 
-    if (other->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)) {
+    if (other_cpu->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)) {
         mask |= (1 << CP0TCBd_CurVPE);
     }
     if (other_tc == other->current_tc) {
@@ -1560,14 +1567,15 @@ target_ulong helper_emt(void)
 target_ulong helper_dvpe(CPUMIPSState *env)
 {
     CPUState *other_cs = first_cpu;
-    target_ulong prev = env->mvp->CP0_MVPControl;
+    MIPSCPU *cpu = env_archcpu(env);
+    target_ulong prev = cpu->mvp->CP0_MVPControl;
 
     if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
         CPU_FOREACH(other_cs) {
             MIPSCPU *other_cpu = MIPS_CPU(other_cs);
             /* Turn off all VPEs except the one executing the dvpe.  */
             if (&other_cpu->env != env) {
-                other_cpu->env.mvp->CP0_MVPControl &= ~(1 << CP0MVPCo_EVP);
+                other_cpu->mvp->CP0_MVPControl &= ~(1 << CP0MVPCo_EVP);
                 mips_vpe_sleep(other_cpu);
             }
         }
@@ -1578,7 +1586,8 @@ target_ulong helper_dvpe(CPUMIPSState *env)
 target_ulong helper_evpe(CPUMIPSState *env)
 {
     CPUState *other_cs = first_cpu;
-    target_ulong prev = env->mvp->CP0_MVPControl;
+    MIPSCPU *cpu = env_archcpu(env);
+    target_ulong prev = cpu->mvp->CP0_MVPControl;
 
     if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
         CPU_FOREACH(other_cs) {
@@ -1588,7 +1597,7 @@ target_ulong helper_evpe(CPUMIPSState *env)
                 /* If the VPE is WFI, don't disturb its sleep.  */
                 && !mips_vpe_is_wfi(other_cpu)) {
                 /* Enable the VPE.  */
-                other_cpu->env.mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
+                other_cpu->mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
                 mips_vpe_wake(other_cpu); /* And wake it up.  */
             }
         }
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 54849e9ff1..6991f0a521 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -8085,6 +8085,7 @@ cp0_unimplemented:
 static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
                      int u, int sel, int h)
 {
+    MIPSCPU *cpu = env_archcpu(env);
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     TCGv t0 = tcg_temp_new();
 
@@ -8093,7 +8094,7 @@ static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
          (env->active_tc.CP0_TCBind & (0xf << CP0TCBd_CurVPE)))) {
         tcg_gen_movi_tl(t0, -1);
     } else if ((env->CP0_VPEControl & (0xff << CP0VPECo_TargTC)) >
-               (env->mvp->CP0_MVPConf0 & (0xff << CP0MVPC0_PTC))) {
+               (cpu->mvp->CP0_MVPConf0 & (0xff << CP0MVPC0_PTC))) {
         tcg_gen_movi_tl(t0, -1);
     } else if (u == 0) {
         switch (rt) {
@@ -8309,6 +8310,7 @@ die:
 static void gen_mttr(CPUMIPSState *env, DisasContext *ctx, int rd, int rt,
                      int u, int sel, int h)
 {
+    MIPSCPU *cpu = env_archcpu(env);
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     TCGv t0 = tcg_temp_new();
 
@@ -8319,7 +8321,7 @@ static void gen_mttr(CPUMIPSState *env, DisasContext *ctx, int rd, int rt,
         /* NOP */
         ;
     } else if ((env->CP0_VPEControl & (0xff << CP0VPECo_TargTC)) >
-             (env->mvp->CP0_MVPConf0 & (0xff << CP0MVPC0_PTC))) {
+             (cpu->mvp->CP0_MVPConf0 & (0xff << CP0MVPC0_PTC))) {
         /* NOP */
         ;
     } else if (u == 0) {
-- 
2.43.0


