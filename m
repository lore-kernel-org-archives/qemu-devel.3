Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6930CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcnv-00056u-O3; Wed, 06 May 2026 10:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnc-0004ni-Ev
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcna-0000Xs-HA
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-448528f4e69so3879387f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076024; x=1778680824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j73ul5aEd9R7sSndl2WuEnX7dofgQLl6AbC/gXzl4y8=;
 b=PZbBhOPb4AaiCXGuyBFgXR3MBDlZOcC4tt0tH6jdd2i6s20LK1EAl3NlehtDXwgRE4
 p2AwdGLa9NYE9QqOGQ9K7pkphWtopgTT+gSe9xeIFUr9yQYX3EN8YFx6oitHmN3PfZDu
 2AxuT1gvc2J2LhQkyAurmY9QbdpvLjbPh5yjkhF8W7KbzSy9qQMtK38b306/0hYxXV+C
 Pnqbc93wNQUyQOFY7JC4hNM6wn6dvwQKtj5b1PvZYwZZ8X8gGilxkJ+vwPmAxgtPsYVf
 sYrFSVNRC7vbqm4gHop28rzVhjd6m+HHCiJFTUzKgJJIVo0PLLVMG0kuDURWqdoE7w2g
 GKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076024; x=1778680824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j73ul5aEd9R7sSndl2WuEnX7dofgQLl6AbC/gXzl4y8=;
 b=Oo8jB99v4pBaXPvZzBHG1R4YCuwL0Ur4JOTBkdB11go3gupIZDlBPbF2t7zmO7UuET
 OApcV8/FsoUJK7RU2DiSkdjR2fZXunpOgkO3lnRz2mT0ppTzvTIXFG1aQQAJcTZl0EiC
 aTV5hoxIWX6SarGpiITyROjpj0SVpOdIoddBSmpZAe5tImnNG1430SY8EQEv8HPnNKzo
 d5Q3eiIA+KUkB72wdyAb2QawcokD8g6g2L040htuh/Kf1uboRa+0kp7COqEufakZho3O
 WtW1x7LnGtr9eSCR2CUKo6BfE2DFjJdCWKGkD3XXY66ymUPDY+LtaaVY6lq+oV46DjTF
 sjbA==
X-Gm-Message-State: AOJu0Yws0zQy98MYm6Csyf2XHGUAoEGLtk9rwWQpSXzD5qnVeAF4yIl1
 cwIjuCdTWcnnCe68NXGZYbvFwafLu0mNGHvfFKfJhrD6Du51KIKUEvPThGsn5RB2l9eYY9Tf3AO
 +Zic6bPk=
X-Gm-Gg: AeBDieuTRlalIeCjuaoPEsTEZRAT3jGXpKM5/3beCNCh1s3fEHfQl55Ly5P+DESfJB/
 tz5M9lF54Xh7TRm+OQonk2zPkNiOOqPV/LGoiNvA6oFefYE3OHMQBaww6kUNWfEJgyT1vRnUfpv
 811hodRma7rBm1oNIdTnYapwCbfv4wfwZ43+xtK7S7VciVOzxiRDgMa2UXJwIbKjmGqUziGJbk2
 ugtkrurQV9dT0G26XLC3uWO7VzVeV8Cib7NOIOBl4638uunMS6S7T8tyyNqz4e7fe0Arb3SPzPW
 LW1Nnk9+rHdV+oob/XwpeoVyUtgkP6/Lrxhj907QSeNuYmOGNT00BufAkflDD84Pc9Y1JdNCCrM
 JHCFjO+5myZztd4V+67STaJjopgGZQEpmA0ieqzJL1IZke0zE58gaLxStfBsQI3movGSRXcbS71
 KFsQaWO+puwG0x4iTtgAN2nazB8pSkgMoXCk9yrcZq98usqWh3aT9hzNk3iX0Q0UUqewM118JmQ
 RnWXQg=
X-Received: by 2002:a05:600c:6095:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48e51f48352mr61827585e9.25.1778076023404; 
 Wed, 06 May 2026 07:00:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53907a00sm45742865e9.12.2026.05.06.07.00.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:00:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 039/110] target/mips: Inline cpu_ld/st_mmuidx_ra() calls in
 LD/ST Multiple
Date: Wed,  6 May 2026 15:54:11 +0200
Message-ID: <20260506135524.20617-40-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

In preparation of removing the cpu_ld*_mmuidx_ra() and
cpu_st*_mmuidx_ra() calls, inline them. Expand MO_TE to
mo_endian_env(env) in gen_ldst_multiple().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260417035734.32334-4-philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c             | 34 +++++++++++------------
 target/mips/tcg/micromips_translate.c.inc |  2 ++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 0def1f296ae..537f3e87bc0 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -215,21 +215,20 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
-    unsigned mem_idx = get_mmuidx(oi);
     unsigned base_reglist = reglist & 0xf;
     bool do_r31 = reglist & 0x10;
+    target_ulong *gpr = env->active_tc.gpr;
+    uintptr_t ra = GETPC();
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
         for (unsigned i = 0; i < base_reglist; i++) {
-            env->active_tc.gpr[multiple_regs[i]] =
-                (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
+            gpr[multiple_regs[i]] = (target_long)cpu_ldl_mmu(env, addr, oi, ra);
             addr += 4;
         }
     }
 
     if (do_r31) {
-        env->active_tc.gpr[31] =
-            (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
+        gpr[31] = (target_long)cpu_ldl_mmu(env, addr, oi, ra);
     }
 }
 
@@ -237,20 +236,20 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
-    unsigned mem_idx = get_mmuidx(oi);
     unsigned base_reglist = reglist & 0xf;
     bool do_r31 = reglist & 0x10;
+    target_ulong *gpr = env->active_tc.gpr;
+    uintptr_t ra = GETPC();
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
         for (unsigned i = 0; i < base_reglist; i++) {
-            cpu_stl_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
-                              mem_idx, GETPC());
+            cpu_stl_mmu(env, addr, gpr[multiple_regs[i]], oi, ra);
             addr += 4;
         }
     }
 
     if (do_r31) {
-        cpu_stl_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
+        cpu_stl_mmu(env, addr, gpr[31], oi, ra);
     }
 }
 
@@ -259,21 +258,20 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
-    unsigned mem_idx = get_mmuidx(oi);
     unsigned base_reglist = reglist & 0xf;
     bool do_r31 = reglist & 0x10;
+    target_ulong *gpr = env->active_tc.gpr;
+    uintptr_t ra = GETPC();
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
         for (unsigned i = 0; i < base_reglist; i++) {
-            env->active_tc.gpr[multiple_regs[i]] =
-                cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
+            gpr[multiple_regs[i]] = cpu_ldq_mmu(env, addr, oi, ra);
             addr += 8;
         }
     }
 
     if (do_r31) {
-        env->active_tc.gpr[31] =
-            cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
+        gpr[31] = cpu_ldq_mmu(env, addr, oi, ra);
     }
 }
 
@@ -281,20 +279,20 @@ void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
-    unsigned mem_idx = get_mmuidx(oi);
     unsigned base_reglist = reglist & 0xf;
     bool do_r31 = reglist & 0x10;
+    target_ulong *gpr = env->active_tc.gpr;
+    uintptr_t ra = GETPC();
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
         for (unsigned i = 0; i < base_reglist; i++) {
-            cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
-                              mem_idx, GETPC());
+            cpu_stq_mmu(env, addr, gpr[multiple_regs[i]], oi, ra);
             addr += 8;
         }
     }
 
     if (do_r31) {
-        cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
+        cpu_stq_mmu(env, addr, gpr[31], oi, ra);
     }
 }
 
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 4dca11b84b4..fb107eb91fe 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -701,6 +701,8 @@ static void gen_ldst_multiple(DisasContext *ctx, uint32_t opc, int reglist,
         return;
     }
 
+    mop |= mo_endian(ctx);
+
     t0 = tcg_temp_new();
 
     gen_base_offset_addr(ctx, t0, base, offset);
-- 
2.53.0


