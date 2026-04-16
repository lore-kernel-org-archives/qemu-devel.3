Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A436DF8D77C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDTuW-0003f7-Fo; Thu, 16 Apr 2026 17:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDTu9-0003D4-B0
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:05:45 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDTu2-0002c7-8f
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:05:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so5300260f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776373531; x=1776978331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MD26nLjJpw1YpqaIAYx+Rr+tkzTp5lNUVRFHhNtT6wI=;
 b=wF1f1p85ajP0o2X2CGv4spC76GG6iWJJN6V7pcSq/LWLu2CVe0l1Eh8zxKHcSUJxI5
 66oDY8F/wQ5XFcqj5nP3KW7d+7OidveOxoyEeo1yFCGNQ6iEX+N7vNEsopPlMX9i+t5m
 I0nN9GufAEne5XJF9MQjy3cl0AWh1dNZfOVGbtD73hSKUazQkc5goV+mgtZD+T9B9uDo
 QKW0seTbl69d7YgG4THFojDvBLih1IVpAFrG+B0pU/gVHaOnghAlk3RzbT6CQtUu/5iO
 HjXIUVlVfb+3XYwPscQ3bw3OWAc+JmBzbeqgxjDIzL8Ue3ZHonPORqitMNiUOGV/60gh
 O7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373531; x=1776978331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MD26nLjJpw1YpqaIAYx+Rr+tkzTp5lNUVRFHhNtT6wI=;
 b=O187ZpH0hE2Quokpq1KGaNwoL74j+kfU9mqR2txapGOIXfk5OCJkmfwTUFIFruv3mn
 pMxG/fAt+TcJ8U0vaB++pV0I7LdVsGVNeH28F6W7VBZfOGfsqt9J1cHNsMXk2tUpODJ+
 lzQtbLnijpM0+gvGp+bdlGNU7dkrq39O8ykKwCA8I/EUQGL5IvIL704L8HRQgVZfLAuh
 saILzEyIkkzr5jQxZcBqOI92oa4JgotTSQqwNKHDFGIGR40oQXd1nb/tIlydPZtS1n4E
 /S7ofp/ltS3Kb1c3iV7Bp2RoId+7xN0ePuPxLKahLpUZDhwDmcYrasrEoLhYE1GWYs1i
 NwlA==
X-Gm-Message-State: AOJu0YzSrgEYB9bk/O+uHM3bRPy/PzRNYdx2HYXeiXQ2L5S4bCU+2wBH
 euR3WslZ9vq1HHWgajupr8fQcv9yY51gcjPZYuuQafgghtWXthtaFtTpifabIcuVv5kWVgxQNEK
 Qf7EAT/I=
X-Gm-Gg: AeBDieuERHAoNGZCfvRlz7gA5Y9G7en79Vk2OBurx10fE39gwv9X7So810UeM6JE7TS
 cAjZlkj4a3ckAOS4z5chHltey8uV/f/O9CoxZnkgArmErn/5Bsee9Q0N3apEG/8Ordi3Zg4CP7P
 tQis3XjqBGt3mTjcbas42RYxPCBAdN+NmXRJBOT32puPuAsh9pyb2JGjhRs1ATqoXIgkugP/rkt
 SnDbs6vQWVHhXiG/GlY8lN9xYMS+XlEJ+PPN1VzxOaJHxq2pYVJMltZN8pBQD2ACHAb4bRL8tQo
 YJAxl6oge7/mRtk5NlRkpnM4JY4nYSssz9QXjs0vs3KLFuB2ozT1c338HuM58CuWvhjtom19d1b
 nfDGUXILG+Bs4XCaLe8iSDasNeKVv04+QwU2ASWmz1hvPR23SX09IXwsRzEdOqUq8rs2/UeH5XN
 CtHsjVpQb4y6AXTp20IH9FezEYW55ktePS1iNZI0QuweyCIKF2dGIa2UUEueRo8UMW2hVGcCWoh
 2yqa4bk3VQ=
X-Received: by 2002:a05:6000:25c7:b0:43c:f0c0:c571 with SMTP id
 ffacd0b85a97d-43fe3e12b2bmr122423f8f.47.1776373531367; 
 Thu, 16 Apr 2026 14:05:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5ea9sm17001852f8f.21.2026.04.16.14.05.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 14:05:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 3/4] target/mips: Inline cpu_ld/st_mmuidx_ra() calls in
 LD/ST Multiple
Date: Thu, 16 Apr 2026 23:05:07 +0200
Message-ID: <20260416210508.30686-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416210508.30686-1-philmd@linaro.org>
References: <20260416210508.30686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
---
 target/mips/tcg/ldst_helper.c             | 40 +++++++++++------------
 target/mips/tcg/micromips_translate.c.inc |  2 ++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index fdc192e9c14..81c0631a119 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -227,21 +227,20 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
-    unsigned mem_idx = get_mmuidx(oi);
     size_t base_reglist = reglist & 0xf;
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
 
@@ -249,20 +248,20 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
-    unsigned mem_idx = get_mmuidx(oi);
     size_t base_reglist = reglist & 0xf;
-    bool do_r31 = !!(reglist & 0x10);
+    bool do_r31 = reglist & 0x10;
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
 
@@ -271,21 +270,20 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
-    unsigned mem_idx = get_mmuidx(oi);
     size_t base_reglist = reglist & 0xf;
-    bool do_r31 = !!(reglist & 0x10);
+    bool do_r31 = reglist & 0x10;
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
 
@@ -293,20 +291,20 @@ void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
-    unsigned mem_idx = get_mmuidx(oi);
     size_t base_reglist = reglist & 0xf;
-    bool do_r31 = !!(reglist & 0x10);
+    bool do_r31 = reglist & 0x10;
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


