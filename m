Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16175F8E4A1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDaLE-0000CX-3q; Thu, 16 Apr 2026 23:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDaLC-0000CI-Af
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:58:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDaLA-0001FP-NG
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:58:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso3805095e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 20:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776398279; x=1777003079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DuGg9pUZL3Gz2qa48QcSeTXKXs/rKf7aigVuhjjWHME=;
 b=nGhfy2f0Ykpba5PvPyFSS7YBXDU9IBDJfD7kzsFycd9YgFaA9+3BhFbFjG/P2rV3uD
 7/VGWOuCb+ih6F0tMJIUWM4uMMWzoFjLpS/m6wsrVeo1UzzNKGm8ESO8OQagdiw0Et8q
 icgmZ960NbnREGLzxeLTTBADm944NcReXx6K8uz9CGaJp4IR+RbfmM6CPfbdNSrSNd64
 UOdCuvLGRctDsqrjNmjoKML9rrRlfBdNmVg1Zf2CTIy1SlIJpJjkbiUidwPSv95W5tuE
 rm3PP/0PdYRIxYkZbSltLCaK5iWzqeH8C6jUXNq+QF9MyVR5+ruofJPwdAkEpFsedBrm
 sy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776398279; x=1777003079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DuGg9pUZL3Gz2qa48QcSeTXKXs/rKf7aigVuhjjWHME=;
 b=Jdq9Wpxok2+Kv4A4aVJFrZU6ZIF/4MXhHbwaW+nAP/5HiFXzR9nRZTSqhkpDx8P//S
 elFQuTHh7CnJJMSedS0tBih/T+8FLOyrHViPKeqzsyjcHFyEl7zdiwftWRuf4jlUQ/3m
 IHsx9CQgRmEZagtreSEQbakhI3gwPxBqLzT+LC7T3T+tQczjx51L8RMDi+hsKWEkWZp7
 Bk4iH7Dc4FlGmShXtlBmzOts01wMQ+gTIU7EjK47hSJMYDCWjOejswBF9N9sXi3jV5et
 /FsCq1iNMDxikXmLMykVCOnh+BTx1g4d8BoS/e/+JQDPwexdubUbyvCo3ACJJaKyF1Cg
 tE6g==
X-Gm-Message-State: AOJu0YxdwXPWntI3/y90XffbPuCAZhUJg8pfIbU2ry18bSpD9mIy/51O
 YaPkQZfudNFdiXuxJoLqXNHhoxYc+mOdN8lDitE3pUxWVktJ+5RT4LvuydQK/zlnZSXtNd9QS16
 EJDOFBrI=
X-Gm-Gg: AeBDiesoGtfXd9kxw4RMc7DHd2VC7e0s4FCv8dPFWdXzK2UNMBvGTMHQSUDTmYi/Ebn
 uMiJTpCkxgOX0ySCL+TpD4SRTnVSNXz018k+pWZly5CTCRDw9u31N/JrkGvlxu6yhyPdIdMxu6B
 eqeisPjliR7XRPvCp0WPDWu0roja/6aCHkYwQm6GNmbC/LuqSlAqIXSayi4JrqTam075qD3UG2V
 9f9Gt3HXR1HlRxjZBHYtjfnWrLsbQlPJM1hGJBGPmNbbosvgdsOpu7/A2q+6NKQG3JTCGk766aC
 oY9f47WA9AMyDuaxfKIfEd91SsAajWE30r4uccMbyb/PnPNr3uxGxevMOYmpIzTF1dAAj523FBH
 GEmQyRi+M/ul0ZQc1QiOhmE7G3wiYupgftRkBFOc9rqGgbNMat28jEgyY0yIxizUS4LkThNcSan
 AN2mT6gn0aFv1rF3+2cJJnLhSkisEHtSn2H8mK8aYIOt22pHQviJCNgNj5dH6Nsuj3iEEiCfxqB
 Gfh0SbH9bY=
X-Received: by 2002:a05:600c:64c7:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-488fb73aa3bmr13217165e9.3.1776398278740; 
 Thu, 16 Apr 2026 20:57:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc181c6dsm11066225e9.6.2026.04.16.20.57.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 20:57:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v5 3/4] target/mips: Inline cpu_ld/st_mmuidx_ra() calls in
 LD/ST Multiple
Date: Fri, 17 Apr 2026 05:57:33 +0200
Message-ID: <20260417035734.32334-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417035734.32334-1-philmd@linaro.org>
References: <20260417035734.32334-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
---
 target/mips/tcg/ldst_helper.c             | 34 +++++++++++------------
 target/mips/tcg/micromips_translate.c.inc |  2 ++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 07a4aa99bae..b3ea4f05192 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -227,21 +227,20 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
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
 
@@ -249,20 +248,20 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
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
 
@@ -271,21 +270,20 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
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
 
@@ -293,20 +291,20 @@ void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
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


