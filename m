Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94B7CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPRZ-0001QK-R9; Wed, 27 Aug 2025 19:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRX-0001NT-Cn
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:39 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRV-00047I-9A
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso393931b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336835; x=1756941635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xu3146lFwQ0p53EI3uEWAj9ZnciIjcfnpwnHwze1+c=;
 b=FgpA0AEo05g4tgTeLnFa/9DTo/ZS0N6Ytd2Gvfme0NNQkBG1de5bjMMiZKi3gMssmr
 F9sqP5+/CijiAdznWErFALdS0qujydzRat6up9ObGeSwR3/MLmJN1rVI5qEb7VoF9CZZ
 NXVjaXqbv71iVXxtDG3wVRYZs9Wq5l7pYgTIUhFS/qNMTHqvVXD4s9L6Z5wr9oolZiF5
 WNQwTRhCP5K/BPy3U7ocLbqKA8JYTYYHfe/EmurNlItZcCL537mT3qEiVKqC6rDnfvDy
 R3EFdMWnsK/PCsyhGMaf5hYGr/Q3QC0KTDrttlu9b0EZDjpt1TeJwpt8yic7/MHq31Vy
 5AXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336835; x=1756941635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9xu3146lFwQ0p53EI3uEWAj9ZnciIjcfnpwnHwze1+c=;
 b=DRU8JQ/5u7JdFr4w3XGy+Mz2W6Zrvi5dO3Fke+aD91wVmeiaZ88E/qvaAF6ZfIITDE
 bQdx7Dyg1a+4jIQdsIG6nf+aZv1kDCd1eEx8DVzMFPdI+ZQM/4lChAH1/6AEWBZXk3Bq
 Z+QPcPSLVwSn2IHRdH9L+MHs5sGJTebIPnH3r6SSXv6jkgDfHsA435uHHuoJP/E/FE/k
 Kbs154Eqp1zLJoKuITBU9bPeq/az7O/1B1kbe3lxPITseu2LHGYfKovZHJYEZSbQLYxm
 +N0EnaezPkLZasb5KN1tvhGv9uVOzhdlyYTu0RqIxeTpB9fO/guHjjluW9N/B4S0CmbU
 MmsQ==
X-Gm-Message-State: AOJu0YyecTacd0XRqpD7fQ/tv3OS25qThN1uGnkPzJ+McKe58eBRPR/J
 Tc8AB3cqyQKozOcevFv9/5eZERUV4VgeYXUVT5e2EvwkjYBLf4XXio7OQAeDaTYuYgnRfZj71Vo
 oFN5zo6s=
X-Gm-Gg: ASbGncu+a+k5EGHl3dWyVpyX1+VrknGyiNEHH3K4Fd12zqId/YwkT0tu1fbe8aeF0Sj
 pAlnDu6h4zGSW3QCXJjjOvxmfzUzni9Co3q1DwCWf5t8w9yy7gRnJR6cdomVA4OrXl3EgC3dWlW
 cVDAoX9Gwlh1TflnA4zlbBeEO8qL0VahEkjKFIs4AVgUOgtnwictqtaCnqbQ0r+dgrSfotF93V3
 o3eLRIVLO2XCIRR1mssqVsicDbrHvuKeszEVQDlt4ZzL5NecQiKMMTtgglDV3KuJudSu7SMOJ72
 6gfu611P34rI8GbMDJj1AeaBhgp3UJQKZlOowvTSPFP4YOPkvhC2PWjz4+q5PWxkska4aOLiwIi
 2pyADut8SAUlL8Vv6UgIEqD4gN2hqJ90Ez/WY
X-Google-Smtp-Source: AGHT+IGEirVGwQFT5uLWXjQsUvSpGCUKwz6rjHBoX0jnjjB2w0tCl2bnpxxNoaD3cJiwlpNS+Rkx6Q==
X-Received: by 2002:a05:6a00:2e18:b0:771:fc20:45e7 with SMTP id
 d2e1a72fcca58-771fc204c98mr10742157b3a.17.1756336835435; 
 Wed, 27 Aug 2025 16:20:35 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:20:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/46] semihosting: Initialize heap once per process
Date: Thu, 28 Aug 2025 09:19:39 +1000
Message-ID: <20250827232023.50398-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h             |  5 -----
 linux-user/aarch64/cpu_loop.c |  7 -------
 linux-user/arm/cpu_loop.c     | 25 +++++++++++--------------
 linux-user/m68k/cpu_loop.c    |  8 --------
 linux-user/riscv/cpu_loop.c   |  4 ----
 semihosting/arm-compat-semi.c | 22 +++++++++-------------
 6 files changed, 20 insertions(+), 51 deletions(-)

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
index e40d6beafa..9d54422736 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -492,19 +492,16 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
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


