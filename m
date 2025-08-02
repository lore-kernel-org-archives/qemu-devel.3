Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348B3C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLI9-0000Sz-IN; Sat, 02 Aug 2025 19:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLI1-0000Ng-05
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:23 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLHy-00012S-42
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:19 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6196ca9a2edso833272eaf.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175917; x=1754780717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wsD/T5ArHHArFjhWxQoJY0mtVxQQIZjsJkSHvkETv7Y=;
 b=uSplK13dPF4YKM7SpGSdKpl4e5sSFTACdNeMmP4SAXourWMZ8hOs1+tRtqSubVj1Ey
 7FiPikhLIxqWZ8hPN2qZZb2sX71FLbUm6kgwTPQ4KDSNbZBkZyBQ0eHKVwjpN1Pp53x6
 nh05xmvxnTYdTQOMqMrShXfx7wDGZrWgGZiVEbGErHAVMpmw4mXhwCp9wzN/WqBRNk3e
 djRwbB954dSElQhdwNbeTJcgwSjnjKGts4to8uqBo1dEtO7pbxJdFGnO9pAANevtZ/y0
 1miFv4KE0NwQn5Q16JnOPGDdJF1LJqjZP8v7p9ChI4rKzUNyKktTl9m51Rl4tKBvkQ5h
 X9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175917; x=1754780717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wsD/T5ArHHArFjhWxQoJY0mtVxQQIZjsJkSHvkETv7Y=;
 b=v4iVH9a5X2gW63ujumMCVYVSRkUblh76UA4mDWkBBM/C9fT89gHT/ouf4SRCLEtQnE
 eCl2gzPnH80z9EnAZAlKdIFQNwkzXcc63geVAOOFbierogDagZpq4IJXm9z8ly6RAPvd
 ZVZ8azWuWjx3M6FgM+WugZ6hUpJomBcl/bI9+OyfpJup8j5NsIHF2tNJDzATq/YwSEKc
 j4Csmh7FZ+EOX+1sPhglloXKjZr0nqXg3nCt9Rq4h0Sh4l677pZNesFrHFe6nHNFjmwA
 5BcwAe11/BVc92BjSbX0gFm/iogLOBN2uVhc0HIep+C9OeefcRJDEwTrF+pPVR9LFAxo
 t0Fw==
X-Gm-Message-State: AOJu0YyH7piT88KpIRZKd6rrqVok4dLbCORlGUIIO3fOdGqTja39A0ZY
 /tQNff8sYF9pVi62bbbZSqpdVEBTXUNLT3WX3PbEA1UDq3AwtPSSZk4dPAPnbyXaEbAIZgsf3Uv
 vuiU8sfI=
X-Gm-Gg: ASbGncv+BUSSL04iWRquB5+dTDhlkHedeNKtefHxwWniyB2nxLcx9yTTw9DYm1yJKyu
 d4dOJ6wjHNBfJ1IXV1DYNOT9j75u9t7LNAp1EtpD+yWCPiXbyi7NIBjXLSSPnByGsKuWiwThwXm
 zMGP3AfCe9faY6F2zWtxF+HNVqkuIlPuD3YOEMNx3lkwlq5d0RhMpqH4RyP+ONEHwO+JANetIF6
 y6+OcD5eteCapfoO+7pRQ7oJr5NiVNxLebcAHZ5zJXI+E5zKKUAE8tzsw4z9nydWUgI2kqdeL+v
 N6V/RwtSsLxFWHvCg+D8GKuhMFiMObuG7swv6KIWew1w9gIyl6CEhKtKPjJeq7EadHLs300LBRe
 moqEP1tQq4/l3laxNP0qIKnuM4Mr5qOy2lMGXLCDhZ6ueKz9rqKMx
X-Google-Smtp-Source: AGHT+IFuaTnfxtq9reBfsxiSvrEsJfe7omUhLWHDAl4k0FhuX64kfJ267mbIvKLizEuiFSbGQICuUw==
X-Received: by 2002:a05:6820:290a:b0:613:bd07:4e26 with SMTP id
 006d021491bc7-6198f234510mr3215284eaf.4.1754175916684; 
 Sat, 02 Aug 2025 16:05:16 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/95] semihosting: Initialize heap once per process
Date: Sun,  3 Aug 2025 09:03:26 +1000
Message-ID: <20250802230459.412251-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

While semihosting isn't really thread aware, the current
implementation allocates space for the heap per-thread.

Remove the heap_base and heap_limit fields from TaskState.
Replace with static variables within do_common_semihosting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h             |  5 -----
 linux-user/aarch64/cpu_loop.c |  7 -------
 linux-user/arm/cpu_loop.c     | 32 +++++++++++++++-----------------
 linux-user/m68k/cpu_loop.c    |  8 --------
 linux-user/riscv/cpu_loop.c   |  4 ----
 semihosting/arm-compat-semi.c | 22 +++++++++-------------
 6 files changed, 24 insertions(+), 54 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index b6621536b3..4d6fad28c6 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -121,11 +121,6 @@ struct TaskState {
     abi_ulong child_tidptr;
 #ifdef TARGET_M68K
     abi_ulong tp_value;
-#endif
-#if defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_RISCV)
-    /* Extra fields for semihosted binaries.  */
-    abi_ulong heap_base;
-    abi_ulong heap_limit;
 #endif
     int used; /* non zero if used */
     struct image_info *info;
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index b65999a75b..030a630c93 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -140,9 +140,6 @@ void cpu_loop(CPUARMState *env)
 void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
-    TaskState *ts = get_task_state(cs);
-    struct image_info *info = ts->info;
     int i;
 
     if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
@@ -167,8 +164,4 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         qemu_guest_getrandom_nofail(&env->keys, sizeof(env->keys));
     }
-
-    ts->heap_base = info->brk;
-    /* This will be filled in on the first SYS_HEAPINFO call.  */
-    ts->heap_limit = 0;
 }
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index e40d6beafa..e2b4099aa4 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -482,9 +482,6 @@ void cpu_loop(CPUARMState *env)
 
 void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
-    CPUState *cpu = env_cpu(env);
-    TaskState *ts = get_task_state(cpu);
-    struct image_info *info = ts->info;
     int i;
 
     cpsr_write(env, regs->uregs[16], CPSR_USER | CPSR_EXEC,
@@ -492,19 +489,20 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
     for(i = 0; i < 16; i++) {
         env->regs[i] = regs->uregs[i];
     }
-#if TARGET_BIG_ENDIAN
-    /* Enable BE8.  */
-    if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
-        && (info->elf_flags & EF_ARM_BE8)) {
-        env->uncached_cpsr |= CPSR_E;
-        env->cp15.sctlr_el[1] |= SCTLR_E0E;
-    } else {
-        env->cp15.sctlr_el[1] |= SCTLR_B;
-    }
-    arm_rebuild_hflags(env);
-#endif
 
-    ts->heap_base = info->brk;
-    /* This will be filled in on the first SYS_HEAPINFO call.  */
-    ts->heap_limit = 0;
+    if (TARGET_BIG_ENDIAN) {
+        CPUState *cpu = env_cpu(env);
+        TaskState *ts = get_task_state(cpu);
+        struct image_info *info = ts->info;
+
+        /* Enable BE8.  */
+        if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
+            && (info->elf_flags & EF_ARM_BE8)) {
+            env->uncached_cpsr |= CPSR_E;
+            env->cp15.sctlr_el[1] |= SCTLR_E0E;
+        } else {
+            env->cp15.sctlr_el[1] |= SCTLR_B;
+        }
+        arm_rebuild_hflags(env);
+    }
 }
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 3aaaf02ca4..23693f3358 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -94,10 +94,6 @@ void cpu_loop(CPUM68KState *env)
 
 void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
-    CPUState *cpu = env_cpu(env);
-    TaskState *ts = get_task_state(cpu);
-    struct image_info *info = ts->info;
-
     env->pc = regs->pc;
     env->dregs[0] = regs->d0;
     env->dregs[1] = regs->d1;
@@ -116,8 +112,4 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
     env->aregs[6] = regs->a6;
     env->aregs[7] = regs->usp;
     env->sr = regs->sr;
-
-    ts->heap_base = info->brk;
-    /* This will be filled in on the first SYS_HEAPINFO call.  */
-    ts->heap_limit = 0;
 }
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 541de765ff..2dd30c7b28 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -108,8 +108,4 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
         error_report("Incompatible ELF: RVE cpu requires RVE ABI binary");
         exit(EXIT_FAILURE);
     }
-
-    ts->heap_base = info->brk;
-    /* This will be filled in on the first SYS_HEAPINFO call.  */
-    ts->heap_limit = 0;
 }
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index bc04b02eba..bcd13cd6df 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -666,7 +666,7 @@ void do_common_semihosting(CPUState *cs)
             int i;
 #ifdef CONFIG_USER_ONLY
             TaskState *ts = get_task_state(cs);
-            target_ulong limit;
+            static abi_ulong heapbase, heaplimit;
 #else
             LayoutInfo info = common_semi_find_bases(cs);
 #endif
@@ -678,24 +678,20 @@ void do_common_semihosting(CPUState *cs)
              * Some C libraries assume the heap immediately follows .bss, so
              * allocate it using sbrk.
              */
-            if (!ts->heap_limit) {
-                abi_ulong ret;
-
-                ts->heap_base = do_brk(0);
-                limit = ts->heap_base + COMMON_SEMI_HEAP_SIZE;
+            if (!heaplimit) {
+                heapbase = do_brk(0);
                 /* Try a big heap, and reduce the size if that fails.  */
-                for (;;) {
-                    ret = do_brk(limit);
+                for (abi_ulong size = COMMON_SEMI_HEAP_SIZE; ; size >>= 1) {
+                    abi_ulong limit = heapbase + size;
+                    abi_ulong ret = do_brk(limit);
                     if (ret >= limit) {
+                        heaplimit = limit;
                         break;
                     }
-                    limit = (ts->heap_base >> 1) + (limit >> 1);
                 }
-                ts->heap_limit = limit;
             }
-
-            retvals[0] = ts->heap_base;
-            retvals[1] = ts->heap_limit;
+            retvals[0] = heapbase;
+            retvals[1] = heaplimit;
             /*
              * Note that semihosting is *not* thread aware.
              * Always return the stack base of the main thread.
-- 
2.43.0


