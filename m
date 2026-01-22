Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E529FC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visgd-0002Wv-Uj; Thu, 22 Jan 2026 06:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1visgX-0002Vd-AY
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:17:10 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1visgV-0001TL-9O
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:17:09 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo9266415e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769080624; x=1769685424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YRU5kxf+QmsbjrTkU501/mrO4Dp0XXAoxukmzKqWE7Y=;
 b=my4aNYC75vj0/7DX4+euYNVfE8H422g8Wl2PmxgWCApzb93wunlM1AEkV/PRt+eZ5S
 Bu33xZVEa6O9C1duneUpo9Ieze/YH0Xl4ojrzCM8P50A7ijHzdnn3lrZjGWgEkccpEU/
 EssaTV1HD0+9HKSiKWwJ5v8Y79KEqruXob7m04wyEYbIgxQu28yBnOJlMoCpU1tSVN5I
 g5mo1vkzb6xy57UGWSDUs2c9lduHDyXSkVsVvxN1abrUd5Bn/BC/dsy2ivBGzGqSNAIc
 m1Xg1kqfPHLKs59hmL5dPri28qaWr5CmyD7SLfKtAu8GOZF+opY6aJUgaSUTrriX6dqW
 kfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769080624; x=1769685424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YRU5kxf+QmsbjrTkU501/mrO4Dp0XXAoxukmzKqWE7Y=;
 b=BEACgxZOKmp6K4ybUtqI9rGz6IVB0+iO8FDFGg9+Z2vMAn6wxKDpttXmJ24j3rwDwv
 UHrABKuuN5Ov5cQ44eOJ3oidz95/LeNeCrDOKRJD55YGIaZWYALIM4LqjYAkmsJdA0sa
 k8WF/KDzb2YmrwHFGUxT5OA9CiuhzI67atWHVkRyQcv9p3WJNC9IkV2pM1Qu/ROcK6dU
 OxbP8pypsHm02PYGFT3L9rFK3vglZ4nMEBcmUUNBnMKtD2V6qncDachCDTEuVvnyhAU8
 9Q7xUmyggSCZGdZX07QJ4bRNzs19MYBnN4CdD7T9hAuzzCxKtoCxiL9dJvxSNCOFtyct
 F6lg==
X-Gm-Message-State: AOJu0Yz7YYhTPWmFB4NwcSUhn7Fuktwz2Kb9Z2e4QK3M/puk0vQfKIuO
 M1vMxeU2K7ljMQLllT8ZhZn3559VWhWmXHt/HiEzL75XfLa7I0Sy7JJVApcV3hAyMcZ6pp77VV5
 4GsexUy4=
X-Gm-Gg: AZuq6aKhleWhf3lA9RqrKcCa2JwxzUrJ1u0YN4z1MMSYaCjDqBEwvCOdmAFABIIKWim
 LH1Bl/cY5ayK4z+1XVDSVJSDUsItpkglrl96MlXEg9NEPhtH15HOUrL50FInfM5ijVEE2BOKPRs
 diD2MJqXy7D2+Zecp0R6AmMvHpw5IwcnmjECG060JZf8rtA4ZKdBYWwdYHG8mCOnjfBJMdjQZmC
 CVEn8aHipXfaNYnw6ar+Zer0GloCyGHNl1Z3A3+w9HElHykIjioLUJjEZ1AReqNtz9BSo03JeQ6
 tL27fPKMbIxIARNjqKtuZP+pOJV5Bxs1n20kkksXlaxnnFGM+cBfeJHM9qqNj75nLsG7eR1a107
 onDGh0bENV8IRc1McidYEedAj8vli5LpVmaMluY4CN7aMmPKS+nd7kIupWGUuFITecjbevzrg8d
 5+zTl3e8isNRFXwLV0fsbdDoze/eqZOiHA0JOvWUUfGFwCgFLs9HhVrz0GGTHx
X-Received: by 2002:a05:600c:4447:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-4801ea2a21fmr287627175e9.0.1769080623373; 
 Thu, 22 Jan 2026 03:17:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43595609c8asm16582233f8f.34.2026.01.22.03.17.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 03:17:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/37] target/m68k: Use big-endian variant of
 cpu_ld/st_data*()
Date: Thu, 22 Jan 2026 12:16:36 +0100
Message-ID: <20260122111639.32346-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122111639.32346-1-philmd@linaro.org>
References: <20260122111639.32346-1-philmd@linaro.org>
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

We only build the M68k target using big endianness order,
therefore the cpu_ld/st_data*() definitions expand to the
big endian declarations. Use the explicit big-endian variants.

Mechanical change running:

  $ tgt=m68k; \
    end=be; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Then adapting indentation in do_stack_frame() to pass checkpatch.pl.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251126202200.23100-8-philmd@linaro.org>
---
 target/m68k/fpu_helper.c | 12 +++---
 target/m68k/op_helper.c  | 91 ++++++++++++++++++++--------------------
 2 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 56012863c85..f49f841d489 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -510,8 +510,8 @@ static int cpu_ld_floatx80_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
     uint32_t high;
     uint64_t low;
 
-    high = cpu_ldl_data_ra(env, addr, ra);
-    low = cpu_ldq_data_ra(env, addr + 4, ra);
+    high = cpu_ldl_be_data_ra(env, addr, ra);
+    low = cpu_ldq_be_data_ra(env, addr + 4, ra);
 
     fp->l.upper = high >> 16;
     fp->l.lower = low;
@@ -522,8 +522,8 @@ static int cpu_ld_floatx80_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
 static int cpu_st_floatx80_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
                                uintptr_t ra)
 {
-    cpu_stl_data_ra(env, addr, fp->l.upper << 16, ra);
-    cpu_stq_data_ra(env, addr + 4, fp->l.lower, ra);
+    cpu_stl_be_data_ra(env, addr, fp->l.upper << 16, ra);
+    cpu_stq_be_data_ra(env, addr + 4, fp->l.lower, ra);
 
     return 12;
 }
@@ -533,7 +533,7 @@ static int cpu_ld_float64_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
 {
     uint64_t val;
 
-    val = cpu_ldq_data_ra(env, addr, ra);
+    val = cpu_ldq_be_data_ra(env, addr, ra);
     fp->d = float64_to_floatx80(*(float64 *)&val, &env->fp_status);
 
     return 8;
@@ -545,7 +545,7 @@ static int cpu_st_float64_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,
     float64 val;
 
     val = floatx80_to_float64(fp->d, &env->fp_status);
-    cpu_stq_data_ra(env, addr, *(uint64_t *)&val, ra);
+    cpu_stq_be_data_ra(env, addr, *(uint64_t *)&val, ra);
 
     return 8;
 }
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index f7df83c850c..8148a8852e7 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -32,8 +32,8 @@ static void cf_rte(CPUM68KState *env)
     uint32_t fmt;
 
     sp = env->aregs[7];
-    fmt = cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
-    env->pc = cpu_ldl_mmuidx_ra(env, sp + 4, MMU_KERNEL_IDX, 0);
+    fmt = cpu_ldl_be_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
+    env->pc = cpu_ldl_be_mmuidx_ra(env, sp + 4, MMU_KERNEL_IDX, 0);
     sp |= (fmt >> 28) & 3;
     env->aregs[7] = sp + 8;
 
@@ -48,13 +48,13 @@ static void m68k_rte(CPUM68KState *env)
 
     sp = env->aregs[7];
 throwaway:
-    sr = cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
+    sr = cpu_lduw_be_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
     sp += 2;
-    env->pc = cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
+    env->pc = cpu_ldl_be_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
     sp += 4;
     if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
         /*  all except 68000 */
-        fmt = cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
+        fmt = cpu_lduw_be_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
         sp += 2;
         switch (fmt >> 12) {
         case 0:
@@ -250,12 +250,12 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
     /* ??? This could cause MMU faults.  */
     sp &= ~3;
     sp -= 4;
-    cpu_stl_mmuidx_ra(env, sp, retaddr, MMU_KERNEL_IDX, 0);
+    cpu_stl_be_mmuidx_ra(env, sp, retaddr, MMU_KERNEL_IDX, 0);
     sp -= 4;
-    cpu_stl_mmuidx_ra(env, sp, fmt, MMU_KERNEL_IDX, 0);
+    cpu_stl_be_mmuidx_ra(env, sp, fmt, MMU_KERNEL_IDX, 0);
     env->aregs[7] = sp;
     /* Jump to vector.  */
-    env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+    env->pc = cpu_ldl_be_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
 
     do_plugin_vcpu_interrupt_cb(cs, retaddr);
 }
@@ -270,24 +270,25 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
         switch (format) {
         case 4:
             *sp -= 4;
-            cpu_stl_mmuidx_ra(env, *sp, env->pc, MMU_KERNEL_IDX, 0);
+            cpu_stl_be_mmuidx_ra(env, *sp, env->pc, MMU_KERNEL_IDX, 0);
             *sp -= 4;
-            cpu_stl_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
+            cpu_stl_be_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
             break;
         case 3:
         case 2:
             *sp -= 4;
-            cpu_stl_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
+            cpu_stl_be_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
             break;
         }
         *sp -= 2;
-        cpu_stw_mmuidx_ra(env, *sp, (format << 12) + (cs->exception_index << 2),
-                          MMU_KERNEL_IDX, 0);
+        cpu_stw_be_mmuidx_ra(env, *sp,
+                             (format << 12) + (cs->exception_index << 2),
+                             MMU_KERNEL_IDX, 0);
     }
     *sp -= 4;
-    cpu_stl_mmuidx_ra(env, *sp, retaddr, MMU_KERNEL_IDX, 0);
+    cpu_stl_be_mmuidx_ra(env, *sp, retaddr, MMU_KERNEL_IDX, 0);
     *sp -= 2;
-    cpu_stw_mmuidx_ra(env, *sp, sr, MMU_KERNEL_IDX, 0);
+    cpu_stw_be_mmuidx_ra(env, *sp, sr, MMU_KERNEL_IDX, 0);
 }
 
 static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
@@ -346,49 +347,49 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
         env->mmu.fault = true;
         /* push data 3 */
         sp -= 4;
-        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* push data 2 */
         sp -= 4;
-        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* push data 1 */
         sp -= 4;
-        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 1 / push data 0 */
         sp -= 4;
-        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 1 address */
         sp -= 4;
-        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 2 data */
         sp -= 4;
-        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 2 address */
         sp -= 4;
-        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 3 data */
         sp -= 4;
-        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 3 address */
         sp -= 4;
-        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
         /* fault address */
         sp -= 4;
-        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
         /* write back 1 status */
         sp -= 2;
-        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 2 status */
         sp -= 2;
-        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 3 status */
         sp -= 2;
-        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* special status word */
         sp -= 2;
-        cpu_stw_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
+        cpu_stw_be_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
         /* effective address */
         sp -= 4;
-        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
 
         do_stack_frame(env, &sp, 7, oldsr, 0, env->pc);
         env->mmu.fault = false;
@@ -436,7 +437,7 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
 
     env->aregs[7] = sp;
     /* Jump to vector.  */
-    env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+    env->pc = cpu_ldl_be_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
 
     do_plugin_vcpu_interrupt_cb(cs, last_pc);
 }
@@ -784,11 +785,11 @@ void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
     int16_t l1, l2;
     uintptr_t ra = GETPC();
 
-    l1 = cpu_lduw_data_ra(env, a1, ra);
-    l2 = cpu_lduw_data_ra(env, a2, ra);
+    l1 = cpu_lduw_be_data_ra(env, a1, ra);
+    l2 = cpu_lduw_be_data_ra(env, a2, ra);
     if (l1 == c1 && l2 == c2) {
-        cpu_stw_data_ra(env, a1, u1, ra);
-        cpu_stw_data_ra(env, a2, u2, ra);
+        cpu_stw_be_data_ra(env, a1, u1, ra);
+        cpu_stw_be_data_ra(env, a2, u2, ra);
     }
 
     if (c1 != l1) {
@@ -840,11 +841,11 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
         }
     } else {
         /* We're executing in a serial context -- no need to be atomic.  */
-        l1 = cpu_ldl_data_ra(env, a1, ra);
-        l2 = cpu_ldl_data_ra(env, a2, ra);
+        l1 = cpu_ldl_be_data_ra(env, a1, ra);
+        l2 = cpu_ldl_be_data_ra(env, a2, ra);
         if (l1 == c1 && l2 == c2) {
-            cpu_stl_data_ra(env, a1, u1, ra);
-            cpu_stl_data_ra(env, a2, u2, ra);
+            cpu_stl_be_data_ra(env, a1, u1, ra);
+            cpu_stl_be_data_ra(env, a2, u2, ra);
         }
     }
 
@@ -946,12 +947,12 @@ static uint64_t bf_load(CPUM68KState *env, uint32_t addr, int blen,
     case 0:
         return cpu_ldub_data_ra(env, addr, ra);
     case 1:
-        return cpu_lduw_data_ra(env, addr, ra);
+        return cpu_lduw_be_data_ra(env, addr, ra);
     case 2:
     case 3:
-        return cpu_ldl_data_ra(env, addr, ra);
+        return cpu_ldl_be_data_ra(env, addr, ra);
     case 4:
-        return cpu_ldq_data_ra(env, addr, ra);
+        return cpu_ldq_be_data_ra(env, addr, ra);
     default:
         g_assert_not_reached();
     }
@@ -965,14 +966,14 @@ static void bf_store(CPUM68KState *env, uint32_t addr, int blen,
         cpu_stb_data_ra(env, addr, data, ra);
         break;
     case 1:
-        cpu_stw_data_ra(env, addr, data, ra);
+        cpu_stw_be_data_ra(env, addr, data, ra);
         break;
     case 2:
     case 3:
-        cpu_stl_data_ra(env, addr, data, ra);
+        cpu_stl_be_data_ra(env, addr, data, ra);
         break;
     case 4:
-        cpu_stq_data_ra(env, addr, data, ra);
+        cpu_stq_be_data_ra(env, addr, data, ra);
         break;
     default:
         g_assert_not_reached();
-- 
2.52.0


