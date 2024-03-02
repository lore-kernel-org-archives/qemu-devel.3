Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47255C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHja-0002RT-3X; Sat, 02 Mar 2024 00:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjX-0002R1-Qc
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:27 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjU-0007VO-DX
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:27 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-299e4b352cdso1970116a91.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356583; x=1709961383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owNJfP2XTjmUJ5ytXkwhG0KGsyIjTx1KJwB9+pwbDas=;
 b=xMPJMuhyrR0/+zWU7DE8o03pl7vZyPMfBPyXz4/LHVNP/NnHT3ma4ymEoXbL765868
 xQw1C3WyIZIUCxWccutfRHoY+iRHM2Q8EGx2wgdO/Qb6oaaLyOod61ORWFwp9btOaq32
 IS7BfyEnZq1Ggh/qvvGdAfc/7KWudif7mdz6wZ90Nz98s/JwFC4CAomG7Zt/G1AHZR1l
 ny1V5DLjWnFGXRz3QYTZ0WnknGMwk5kFVeY3lYqrr7W2qkODpdJuj/+TEtedNEY4VDIM
 7Cx5hdmVMaUSEuVbN7N7ZgWOjMIliRB37KBHYO6ii41XNas12AoEos2nDsrRAyvSjL2l
 TJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356583; x=1709961383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=owNJfP2XTjmUJ5ytXkwhG0KGsyIjTx1KJwB9+pwbDas=;
 b=SZaxrqy7tzpVTMZUHhBGOnnfpN3baI8xtlO8gaD5fvvjeomptT1XdikC/FLpNA8AiE
 U7t39/GhnCGmucHl+ReV9AjV5DQ6ylYGg3/yx4uSw3IASS/N2IvYJo1MMp3cJXdZs+a3
 Ou9coVCHZ5KJ2oxb4+GCnWFBqJJChIbAQSWKj27ZD9tyEv9jgeuAQ+vj94Z6bAhTWwn7
 58TMINivdNcsaNW61zZqhr2uR9I72hDPhev3YKu2sSiGcfbDoQWMQta0JQcpkV1kskFf
 eU2yh6y99ICuVHfmmbcYctqejyvkiVik7dCZNCsHBYohuXK/hd3V1+09t6iZb/uK1447
 7bGg==
X-Gm-Message-State: AOJu0YwFc/e/0KrCmbXmrgAF5tDr1sctY8Nfib1qf4B5UsMjE2buJ5ND
 zE/eilmZa18F4Q5G9hi6iDM/vghApy0gQMgrWYEpMQWZnvyPI+0PZUxGaWE+6M1syd31ZsPlhRJ
 B
X-Google-Smtp-Source: AGHT+IH2bKdfLFpjnfR5ukity7XtTQvuoq0qAlak42g43Q2VpC5/DJYE/T4EYihc3CroLOYO7uEHOg==
X-Received: by 2002:a17:90a:aa95:b0:29a:8ac0:9fd2 with SMTP id
 l21-20020a17090aaa9500b0029a8ac09fd2mr3067603pjq.49.1709356582847; 
 Fri, 01 Mar 2024 21:16:22 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 10/41] target/sparc: Remove cpu_fpr[]
Date: Fri,  1 Mar 2024 19:15:30 -1000
Message-Id: <20240302051601.53649-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use explicit loads and stores to env instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 158 +++++++++++++++++++++------------------
 1 file changed, 84 insertions(+), 74 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ddceb25b08..981d9d9101 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -124,8 +124,7 @@ static TCGv cpu_gsr;
 #define cpu_xcc_C ({ qemu_build_not_reached(); NULL; })
 #endif
 
-/* Floating point registers */
-static TCGv_i64 cpu_fpr[TARGET_DPREGS];
+/* Floating point comparison registers */
 static TCGv_i32 cpu_fcc[TARGET_FCCREGS];
 
 #define env_field_offsetof(X)     offsetof(CPUSPARCState, X)
@@ -218,50 +217,72 @@ static void gen_update_fprs_dirty(DisasContext *dc, int rd)
 }
 
 /* floating point registers moves */
+
+static int gen_offset_fpr_F(unsigned int reg)
+{
+    int ret;
+
+    tcg_debug_assert(reg < 32);
+    ret= offsetof(CPUSPARCState, fpr[reg / 2]);
+    if (reg & 1) {
+        ret += offsetof(CPU_DoubleU, l.lower);
+    } else {
+        ret += offsetof(CPU_DoubleU, l.upper);
+    }
+    return ret;
+}
+
 static TCGv_i32 gen_load_fpr_F(DisasContext *dc, unsigned int src)
 {
     TCGv_i32 ret = tcg_temp_new_i32();
-    if (src & 1) {
-        tcg_gen_extrl_i64_i32(ret, cpu_fpr[src / 2]);
-    } else {
-        tcg_gen_extrh_i64_i32(ret, cpu_fpr[src / 2]);
-    }
+    tcg_gen_ld_i32(ret, tcg_env, gen_offset_fpr_F(src));
     return ret;
 }
 
 static void gen_store_fpr_F(DisasContext *dc, unsigned int dst, TCGv_i32 v)
 {
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_extu_i32_i64(t, v);
-    tcg_gen_deposit_i64(cpu_fpr[dst / 2], cpu_fpr[dst / 2], t,
-                        (dst & 1 ? 0 : 32), 32);
+    tcg_gen_st_i32(v, tcg_env, gen_offset_fpr_F(dst));
     gen_update_fprs_dirty(dc, dst);
 }
 
+static int gen_offset_fpr_D(unsigned int reg)
+{
+    tcg_debug_assert(reg < 64);
+    tcg_debug_assert(reg % 2 == 0);
+    return offsetof(CPUSPARCState, fpr[reg / 2]);
+}
+
 static TCGv_i64 gen_load_fpr_D(DisasContext *dc, unsigned int src)
 {
-    return cpu_fpr[src / 2];
+    TCGv_i64 ret = tcg_temp_new_i64();
+    tcg_gen_ld_i64(ret, tcg_env, gen_offset_fpr_D(src));
+    return ret;
 }
 
 static void gen_store_fpr_D(DisasContext *dc, unsigned int dst, TCGv_i64 v)
 {
-    tcg_gen_mov_i64(cpu_fpr[dst / 2], v);
+    tcg_gen_st_i64(v, tcg_env, gen_offset_fpr_D(dst));
     gen_update_fprs_dirty(dc, dst);
 }
 
 static TCGv_i128 gen_load_fpr_Q(DisasContext *dc, unsigned int src)
 {
     TCGv_i128 ret = tcg_temp_new_i128();
+    TCGv_i64 h = gen_load_fpr_D(dc, src);
+    TCGv_i64 l = gen_load_fpr_D(dc, src + 2);
 
-    tcg_gen_concat_i64_i128(ret, cpu_fpr[src / 2 + 1], cpu_fpr[src / 2]);
+    tcg_gen_concat_i64_i128(ret, l, h);
     return ret;
 }
 
 static void gen_store_fpr_Q(DisasContext *dc, unsigned int dst, TCGv_i128 v)
 {
-    tcg_gen_extr_i128_i64(cpu_fpr[dst / 2 + 1], cpu_fpr[dst / 2], v);
-    gen_update_fprs_dirty(dc, dst);
+    TCGv_i64 h = tcg_temp_new_i64();
+    TCGv_i64 l = tcg_temp_new_i64();
+
+    tcg_gen_extr_i128_i64(l, h, v);
+    gen_store_fpr_D(dc, dst, h);
+    gen_store_fpr_D(dc, dst + 2, l);
 }
 
 /* moves */
@@ -1595,7 +1616,7 @@ static void gen_ldf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
     MemOp memop = da->memop;
     MemOp size = memop & MO_SIZE;
     TCGv_i32 d32;
-    TCGv_i64 d64;
+    TCGv_i64 d64, l64;
     TCGv addr_tmp;
 
     /* TODO: Use 128-bit load/store below. */
@@ -1617,16 +1638,20 @@ static void gen_ldf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
             break;
 
         case MO_64:
-            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2], addr, da->mem_idx, memop);
+            d64 = tcg_temp_new_i64();
+            tcg_gen_qemu_ld_i64(d64, addr, da->mem_idx, memop);
+            gen_store_fpr_D(dc, rd, d64);
             break;
 
         case MO_128:
             d64 = tcg_temp_new_i64();
+            l64 = tcg_temp_new_i64();
             tcg_gen_qemu_ld_i64(d64, addr, da->mem_idx, memop);
             addr_tmp = tcg_temp_new();
             tcg_gen_addi_tl(addr_tmp, addr, 8);
-            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2 + 1], addr_tmp, da->mem_idx, memop);
-            tcg_gen_mov_i64(cpu_fpr[rd / 2], d64);
+            tcg_gen_qemu_ld_i64(l64, addr_tmp, da->mem_idx, memop);
+            gen_store_fpr_D(dc, rd, d64);
+            gen_store_fpr_D(dc, rd + 2, l64);
             break;
         default:
             g_assert_not_reached();
@@ -1638,9 +1663,11 @@ static void gen_ldf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
         if (orig_size == MO_64 && (rd & 7) == 0) {
             /* The first operation checks required alignment.  */
             addr_tmp = tcg_temp_new();
+            d64 = tcg_temp_new_i64();
             for (int i = 0; ; ++i) {
-                tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2 + i], addr, da->mem_idx,
+                tcg_gen_qemu_ld_i64(d64, addr, da->mem_idx,
                                     memop | (i == 0 ? MO_ALIGN_64 : 0));
+                gen_store_fpr_D(dc, rd + 2 * i, d64);
                 if (i == 7) {
                     break;
                 }
@@ -1655,8 +1682,9 @@ static void gen_ldf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
     case GET_ASI_SHORT:
         /* Valid for lddfa only.  */
         if (orig_size == MO_64) {
-            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2], addr, da->mem_idx,
-                                memop | MO_ALIGN);
+            d64 = tcg_temp_new_i64();
+            tcg_gen_qemu_ld_i64(d64, addr, da->mem_idx, memop | MO_ALIGN);
+            gen_store_fpr_D(dc, rd, d64);
         } else {
             gen_exception(dc, TT_ILL_INSN);
         }
@@ -1681,17 +1709,19 @@ static void gen_ldf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
                 gen_store_fpr_F(dc, rd, d32);
                 break;
             case MO_64:
-                gen_helper_ld_asi(cpu_fpr[rd / 2], tcg_env, addr,
-                                  r_asi, r_mop);
+                d64 = tcg_temp_new_i64();
+                gen_helper_ld_asi(d64, tcg_env, addr, r_asi, r_mop);
+                gen_store_fpr_D(dc, rd, d64);
                 break;
             case MO_128:
                 d64 = tcg_temp_new_i64();
+                l64 = tcg_temp_new_i64();
                 gen_helper_ld_asi(d64, tcg_env, addr, r_asi, r_mop);
                 addr_tmp = tcg_temp_new();
                 tcg_gen_addi_tl(addr_tmp, addr, 8);
-                gen_helper_ld_asi(cpu_fpr[rd / 2 + 1], tcg_env, addr_tmp,
-                                  r_asi, r_mop);
-                tcg_gen_mov_i64(cpu_fpr[rd / 2], d64);
+                gen_helper_ld_asi(l64, tcg_env, addr_tmp, r_asi, r_mop);
+                gen_store_fpr_D(dc, rd, d64);
+                gen_store_fpr_D(dc, rd + 2, l64);
                 break;
             default:
                 g_assert_not_reached();
@@ -1707,6 +1737,7 @@ static void gen_stf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
     MemOp memop = da->memop;
     MemOp size = memop & MO_SIZE;
     TCGv_i32 d32;
+    TCGv_i64 d64;
     TCGv addr_tmp;
 
     /* TODO: Use 128-bit load/store below. */
@@ -1726,8 +1757,8 @@ static void gen_stf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
             tcg_gen_qemu_st_i32(d32, addr, da->mem_idx, memop | MO_ALIGN);
             break;
         case MO_64:
-            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da->mem_idx,
-                                memop | MO_ALIGN_4);
+            d64 = gen_load_fpr_D(dc, rd);
+            tcg_gen_qemu_st_i64(d64, addr, da->mem_idx, memop | MO_ALIGN_4);
             break;
         case MO_128:
             /* Only 4-byte alignment required.  However, it is legal for the
@@ -1735,11 +1766,12 @@ static void gen_stf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
                required to fix it up.  Requiring 16-byte alignment here avoids
                having to probe the second page before performing the first
                write.  */
-            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da->mem_idx,
-                                memop | MO_ALIGN_16);
+            d64 = gen_load_fpr_D(dc, rd);
+            tcg_gen_qemu_st_i64(d64, addr, da->mem_idx, memop | MO_ALIGN_16);
             addr_tmp = tcg_temp_new();
             tcg_gen_addi_tl(addr_tmp, addr, 8);
-            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2 + 1], addr_tmp, da->mem_idx, memop);
+            d64 = gen_load_fpr_D(dc, rd + 2);
+            tcg_gen_qemu_st_i64(d64, addr_tmp, da->mem_idx, memop);
             break;
         default:
             g_assert_not_reached();
@@ -1752,7 +1784,8 @@ static void gen_stf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
             /* The first operation checks required alignment.  */
             addr_tmp = tcg_temp_new();
             for (int i = 0; ; ++i) {
-                tcg_gen_qemu_st_i64(cpu_fpr[rd / 2 + i], addr, da->mem_idx,
+                d64 = gen_load_fpr_D(dc, rd + 2 * i);
+                tcg_gen_qemu_st_i64(d64, addr, da->mem_idx,
                                     memop | (i == 0 ? MO_ALIGN_64 : 0));
                 if (i == 7) {
                     break;
@@ -1768,8 +1801,8 @@ static void gen_stf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
     case GET_ASI_SHORT:
         /* Valid for stdfa only.  */
         if (orig_size == MO_64) {
-            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da->mem_idx,
-                                memop | MO_ALIGN);
+            d64 = gen_load_fpr_D(dc, rd);
+            tcg_gen_qemu_st_i64(d64, addr, da->mem_idx, memop | MO_ALIGN);
         } else {
             gen_exception(dc, TT_ILL_INSN);
         }
@@ -1994,13 +2027,17 @@ static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
 #ifdef TARGET_SPARC64
     TCGv c2 = tcg_constant_tl(cmp->c2);
+    TCGv_i64 h = tcg_temp_new_i64();
+    TCGv_i64 l = tcg_temp_new_i64();
 
-    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[rd / 2], cmp->c1, c2,
-                        cpu_fpr[rs / 2], cpu_fpr[rd / 2]);
-    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[rd / 2 + 1], cmp->c1, c2,
-                        cpu_fpr[rs / 2 + 1], cpu_fpr[rd / 2 + 1]);
-
-    gen_update_fprs_dirty(dc, rd);
+    tcg_gen_movcond_i64(cmp->cond, h, cmp->c1, c2,
+                        gen_load_fpr_D(dc, rs),
+                        gen_load_fpr_D(dc, rd));
+    tcg_gen_movcond_i64(cmp->cond, l, cmp->c1, c2,
+                        gen_load_fpr_D(dc, rs + 2),
+                        gen_load_fpr_D(dc, rd + 2));
+    gen_store_fpr_D(dc, rd, h);
+    gen_store_fpr_D(dc, rd + 2, l);
 #else
     qemu_build_not_reached();
 #endif
@@ -4192,39 +4229,24 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
 TRANS(STFSR, ALL, do_stfsr, a, MO_TEUL)
 TRANS(STXFSR, 64, do_stfsr, a, MO_TEUQ)
 
-static bool do_fc(DisasContext *dc, int rd, bool c)
+static bool do_fc(DisasContext *dc, int rd, int32_t c)
 {
-    uint64_t mask;
-
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
-
-    if (rd & 1) {
-        mask = MAKE_64BIT_MASK(0, 32);
-    } else {
-        mask = MAKE_64BIT_MASK(32, 32);
-    }
-    if (c) {
-        tcg_gen_ori_i64(cpu_fpr[rd / 2], cpu_fpr[rd / 2], mask);
-    } else {
-        tcg_gen_andi_i64(cpu_fpr[rd / 2], cpu_fpr[rd / 2], ~mask);
-    }
-    gen_update_fprs_dirty(dc, rd);
+    gen_store_fpr_F(dc, rd, tcg_constant_i32(c));
     return advance_pc(dc);
 }
 
 TRANS(FZEROs, VIS1, do_fc, a->rd, 0)
-TRANS(FONEs, VIS1, do_fc, a->rd, 1)
+TRANS(FONEs, VIS1, do_fc, a->rd, -1)
 
 static bool do_dc(DisasContext *dc, int rd, int64_t c)
 {
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
-
-    tcg_gen_movi_i64(cpu_fpr[rd / 2], c);
-    gen_update_fprs_dirty(dc, rd);
+    gen_store_fpr_D(dc, rd, tcg_constant_i64(c));
     return advance_pc(dc);
 }
 
@@ -5128,12 +5150,6 @@ void sparc_tcg_init(void)
         "l0", "l1", "l2", "l3", "l4", "l5", "l6", "l7",
         "i0", "i1", "i2", "i3", "i4", "i5", "i6", "i7",
     };
-    static const char fregnames[32][4] = {
-        "f0", "f2", "f4", "f6", "f8", "f10", "f12", "f14",
-        "f16", "f18", "f20", "f22", "f24", "f26", "f28", "f30",
-        "f32", "f34", "f36", "f38", "f40", "f42", "f44", "f46",
-        "f48", "f50", "f52", "f54", "f56", "f58", "f60", "f62",
-    };
 
     static const struct { TCGv_i32 *ptr; int off; const char *name; } r32[] = {
 #ifdef TARGET_SPARC64
@@ -5190,12 +5206,6 @@ void sparc_tcg_init(void)
                                          (i - 8) * sizeof(target_ulong),
                                          gregnames[i]);
     }
-
-    for (i = 0; i < TARGET_DPREGS; i++) {
-        cpu_fpr[i] = tcg_global_mem_new_i64(tcg_env,
-                                            offsetof(CPUSPARCState, fpr[i]),
-                                            fregnames[i]);
-    }
 }
 
 void sparc_restore_state_to_opc(CPUState *cs,
-- 
2.34.1


