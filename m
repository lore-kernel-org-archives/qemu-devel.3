Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477E5CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd8H-0005vO-2z; Fri, 21 Nov 2025 21:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcsV-0007Rs-H0
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:57:32 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcr9-0007LP-3T
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:57:27 -0500
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-64074f01a6eso4595098a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763776545; x=1764381345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27Oww4qQxdixc+Id3IXgq5AJQ19OjMu/GDoS0nr9Vqw=;
 b=bIqH7OhjKFwCntB6Adpm6Z2i8YRCsQn/W1RlSF8SHSlv+5G+YOjwHp68Z7EVo9b2q6
 aDbg8sTwVehpxzO4SDMt6Ak00/7kbyk/LdOyUkwKqfwEYbfZ8BOjftJ5R5ugFBecWggU
 QfzdMplX57+ZDCg8ubMgR0/eASirSZz0o5Gkyd0df0kv79waD1U/5DjsQnOYI9SkBWwP
 G2OEu4zOBcVaDPo1i7/EVYNwLtE8mD36eNk6Cds3tmi7yIlnCq2vV2glnogWBPSQZCNE
 m0VKAIuxRhKGdV5bOJrKbcyHblqb1YUq4rZQoY4+cJAp6XbGn8hRNrYemWsYMLLO+FUQ
 Z/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763776545; x=1764381345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=27Oww4qQxdixc+Id3IXgq5AJQ19OjMu/GDoS0nr9Vqw=;
 b=naOvUFYcvGsLbY7JZiKFma11I8ZPCx5aFgITWD/Jsr87+Gp4ch/mBEtrqYxDkDPNfy
 HzKSLVcfpzxZti7oKqm223QhhDmTbHouDCzZeHilKnSrvTO2tqvV4PVzwbJ5NLhIwkQo
 L+YrYvXak9mtEyC16Ees9fZuGSHOT0JTGzyXNT9TE9+wOPQ13JYsBi8TmXDFjCH7CwYI
 5eb0cuNhEghpSKeyA77aPVQBZPq7HSKmg2PnsNujtTNIaWh0SsGwYypS4vPrRKAXTvsQ
 tHMFKt2ps8k6k16WQMA6efoWwiYW2RbKcgGgYQxiV7KrGUJYd9NET95XVIvw6edaYPOK
 +lfw==
X-Gm-Message-State: AOJu0YxnQLZrq1sl/aRVU5gGvVC6r799RJbJt3ahzIJBrzsaJxasKP5x
 x197JHl8SuMQqt8/7b89iEo4CwJIR3J9B1Je4vRno1Myt37zAYbokV1vpH8m3XEJX4gCxyeWkz9
 CI3eLM5UXyzE5
X-Gm-Gg: ASbGncs82ACwVzCufxNgIzY8HBctIKhpH8dFRF7ZAyKf7U2A9G6DQBLwLxYQ79LDbs8
 2v1b/eygGM2Xtc05UHEn3T/N/IeQKN4d/Ub7jzGS2GftGnUaX31EILfp7JjR0xbQttsxsXU5bzv
 qbSHSjefm4gtRC5t21hDkrpVBXODHem7DJAzVGtSiFCq1CdnZysRYBFT2QuDliHPZ8ym4+sryip
 ZcvHhU5WpKqfKDY+cj56cyK3Jx0xPxTd+mP0EB24orOSatU2IVsXp7HEgVq3b0/GAD1sYwoCw1j
 /kMIOqOFav4XsIWWezPk0qHVvzfFYTUJu54oQuY51zNsAjJDREtkX2x723bXZkNs7cc4km1nvSg
 94oerBNEIr/BIwYHx+C87j5iCOAEjg5nCWufTqpKb9z4hmKtaAzHRQSM3XmzsQQnwFqsrsarmIg
 gXwlq4cGldPsbCc09NpNMp9/LcAiLNLoLcqg7U0DlG95Kk8lGM7uALG9od5B7B
X-Google-Smtp-Source: AGHT+IEPLHBqw5ofq+6kz8Qjha8zhtu5Le9chojoHOl92BeqzuOOGh31Z+6+FW5BL3Z7UYtmDPrGIg==
X-Received: by 2002:a05:6000:1787:b0:42b:3023:66a9 with SMTP id
 ffacd0b85a97d-42cc1cbd4d0mr2509791f8f.22.1763732792090; 
 Fri, 21 Nov 2025 05:46:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e581sm10502617f8f.8.2025.11.21.05.46.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:46:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 13/21] target/m68k: Use little-endian variant
 of cpu_ld/st_data*()
Date: Fri, 21 Nov 2025 14:44:55 +0100
Message-ID: <20251121134503.30914-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x544.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

We only build the M68k target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/fpu_helper.c | 12 +++---
 target/m68k/op_helper.c  | 88 ++++++++++++++++++++--------------------
 2 files changed, 50 insertions(+), 50 deletions(-)

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
index e9c20a8e032..eac45669ce7 100644
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
@@ -270,24 +270,24 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
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
+        cpu_stw_be_mmuidx_ra(env, *sp, (format << 12) + (cs->exception_index << 2),
                           MMU_KERNEL_IDX, 0);
     }
     *sp -= 4;
-    cpu_stl_mmuidx_ra(env, *sp, retaddr, MMU_KERNEL_IDX, 0);
+    cpu_stl_be_mmuidx_ra(env, *sp, retaddr, MMU_KERNEL_IDX, 0);
     *sp -= 2;
-    cpu_stw_mmuidx_ra(env, *sp, sr, MMU_KERNEL_IDX, 0);
+    cpu_stw_be_mmuidx_ra(env, *sp, sr, MMU_KERNEL_IDX, 0);
 }
 
 static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
@@ -346,49 +346,49 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
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
@@ -436,7 +436,7 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
 
     env->aregs[7] = sp;
     /* Jump to vector.  */
-    env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+    env->pc = cpu_ldl_be_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
 
     do_plugin_vcpu_interrupt_cb(cs, last_pc);
 }
@@ -784,11 +784,11 @@ void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
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
@@ -845,11 +845,11 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
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
 
@@ -951,12 +951,12 @@ static uint64_t bf_load(CPUM68KState *env, uint32_t addr, int blen,
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
@@ -970,14 +970,14 @@ static void bf_store(CPUM68KState *env, uint32_t addr, int blen,
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
2.51.0


