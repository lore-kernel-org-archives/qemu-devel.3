Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CC1CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKckt-00059o-Ta; Wed, 06 May 2026 09:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckm-0004tA-Qb
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckj-00088b-W5
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so72840235e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075847; x=1778680647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C0oXVvaWscf+akuMspWClDbckUbZlXEyfzZvyM8gMlw=;
 b=vciyK8VTnrLN64fV4nWeyOaWdi/Yb9IDskFKbHDeJLm6spYbyh1VdKcHtoTC/gpjdL
 hNWj9NYfkmKNrxVWgF0wLHro5OKFpPo4/dn3AxvZv0fQ0nW+KE6ssePfKALOesXsWGpM
 eSDmxN4PGBeVKY2CUBBgXAJaDiwt7Uyhc/Dp/xVSocPFQJ3QJstMDSZ8kPa3ezFeZ3zd
 XoB6m6m15XUysf9/cxfduNM5dxcl9DX02ch1QNNDqNyfTt2qIiy09KjfEyyZvDU9p4jC
 lIQ7KBmvmJGdk0Uam0uwsTwye02W0mfHbghKkMdmosUUt0W9JtyDEQEtZIvKNtlJDFL1
 eOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075847; x=1778680647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C0oXVvaWscf+akuMspWClDbckUbZlXEyfzZvyM8gMlw=;
 b=izhfmz6wefrK6q115qw8LC/ZpT1dNUSFirc2WV3EU1vein+6ILrMYeFBJ5AriUpU9N
 qSfy0ygqVFh0BgNrO3oWkGj0qjGipuJk6fl5j0Sl8On1zPaZwJ2aJ/0zTCselaMlcFMT
 XhiZaJhoGSvhbhPAUWyvpO9CYip0vmkVGdph8REtyr3PcCFBznTyZ6XU6s/KcTU9Pal5
 mimm37M5H3UVgJjcNhUzrVxmzL0REnzsINRzaFFmcbMJGzYm+969zGMBLqiterfDmolX
 ZZzMHcu5tjHXFpZ+TvcBanNcvwVojAB8Pg47GQ0Cq5xqfnmgA/9PpiGIS5TynqTKIy7C
 ywew==
X-Gm-Message-State: AOJu0YxJOOhYI+CmtvdHxyBXLFkXxSs9DTdIPOhSh+uE5NcMVb7aAiO9
 MoRUYiqfmiV+iOYOTyJX4rKLOROZxfgXD2qQ24kPSDfT/LpBFWu8mVBYa5pc743xtj0fpHSzMKm
 FzzSiJyA=
X-Gm-Gg: AeBDievI1OBliQzG2O0glICE2BmH6QwVp4R2/1DTHzyS8Amu3RxjvJdA75WmDWdMT4E
 BDZcWlxmPHUVQq1IusI1VB840MeFpKxCvCyI6/j1fJybSjia9Xdhfg6SUAtTLZlGml9Ku99TUXw
 GehZCaQrZlW5G/qL8iWs2sQjTonVD53YrqF/9A0fHEs6FZawHu/mdHtL8DEchJ/SaW/EUMSBDTl
 vk9R56bvRv4vKxCkoylXNyREIVej0JOmwuGaMLAjRHKwEQz3O9wFxFQ7kiD1xEGtet0VjkvAbch
 CgCSsP1mHHqO6kfpgBwlc00JlC3wbj8LddpMXtFyC3ggQ6PL0CEl+Zd9P+Wg6p09Wvv/xwsYH60
 GxCuI80QGnenTiL1YrjT/m+idaiiem+SAuS3RVO7uP9dH+c7OeJiK5FnBlS9cm++tDb0ntykZqu
 +ao/7MANZ9gVZwJkn7FduWsN+/UmEFc05czqalcRjHxOzFxkN4kCNSD19RT5XVZCLNZEOEwimDr
 z0i2Icg0Ao=
X-Received: by 2002:a05:600c:c494:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-48e51f41be6mr57362585e9.25.1778075847297; 
 Wed, 06 May 2026 06:57:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a517bsm52623075e9.4.2026.05.06.06.57.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:57:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 016/110] target/mips: Move 'mvp' field from CPUMIPSState to
 MIPSCPU
Date: Wed,  6 May 2026 15:53:48 +0200
Message-ID: <20260506135524.20617-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260317175031.3035740-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h                   |  3 ++-
 target/mips/internal.h              |  3 ++-
 hw/mips/malta.c                     |  4 ++--
 target/mips/cpu.c                   |  2 +-
 target/mips/system/machine.c        |  2 +-
 target/mips/tcg/system/cp0_helper.c | 35 ++++++++++++++++++-----------
 target/mips/tcg/translate.c         |  6 +++--
 target/mips/cpu-defs.c.inc          | 10 +++++----
 8 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 17e9f6039ec..42c5ca89154 100644
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
index 28eb28936ba..95b8b7bb9c9 100644
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
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 0cbe9956e74..845b8d339e8 100644
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
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 5f88c077dbf..789ca188b5e 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -339,7 +339,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 
         if (cs->cpu_index == 0) {
             /* VPE0 starts up enabled.  */
-            env->mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
+            cpu->mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
             env->CP0_VPEConf0 |= (1 << CP0VPEC0_MVP) | (1 << CP0VPEC0_VPA);
 
             /* TC0 starts up unhalted.  */
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 473d3ab0363..0a32665f835 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -251,7 +251,7 @@ const VMStateDescription vmstate_mips_cpu = {
                        CPUMIPSFPUContext),
 
         /* MVP */
-        VMSTATE_STRUCT_POINTER(env.mvp, MIPSCPU, vmstate_mvp,
+        VMSTATE_STRUCT_POINTER(mvp, MIPSCPU, vmstate_mvp,
                                CPUMIPSMVPContext),
 
         /* TLB */
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index b69e70d7fcf..123d5c217c1 100644
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
index 3426acd37b4..e334cf98b78 100644
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
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index d93b9d341ac..faefab04738 100644
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
-- 
2.53.0


