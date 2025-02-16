Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658BAC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmM-0005VC-R3; Sun, 16 Feb 2025 18:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmI-0005Tz-RM
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:22 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmF-0005CB-KE
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:21 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso5787779a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747416; x=1740352216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpCPAvaqKEiWCYMASLveKqapvfa0th668vwpJ0ZkvhM=;
 b=qniqOlKpB4z5dCyjaAfjVbT+KTxfh6Rki7mdQkyTOaftTjFAOvZWVBeKzJLq/PP3cE
 pPQSvWM7OB5bM0Izy3w/ECw4G0GJCKfcuyM+wXDw6vQerFnFvdce1WPai9xjoWklLp7p
 m99W14kvbHncF+UZG6/xKvTDXNROYCcoAPw5junIs6FYkwB8vbxEF2fkIJ0T4hAlABPB
 F6wxSewqZSlPuOzOPVxovORnWDam86e51NXbZUSCk4WuH7Z8H20hks1aKfcCO7ND2QIE
 wOwyNvloDMmGz0arqtpJffmPY7STGSYodGzWMlgPUoQSbo8AZfLaiDz271PQ2r0CbBy1
 eKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747416; x=1740352216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QpCPAvaqKEiWCYMASLveKqapvfa0th668vwpJ0ZkvhM=;
 b=jLt0BmGaKE5tFFHcaNkRG+pzf9H2JANESRrY35wDp2TWRjqrjo+wyMtiBKixwKVEJr
 Jyo1Vb219GLI1l2DCsGqvzKW0WmooTJhdKPDhevvzRpcVji1VpQVF2VER+uwTFv0my0C
 31z1ey6o+hkBjhRsaIiGAkmaLdme32F3joAnEpFNHpDhiSv/ccBuTv94Z1YnXGfun0UV
 C7d7lGhwtvkj5/EHY5CAMyPJ82/97GpG0zVmUR6HRjBaiWVVfTKjKaxicRQg1mDD3iOo
 i45PXD8Hs1UPxFWzKL6OYaogF+7yQ8KZkJSMh0gmXTHN8kz0tOq2ymOfa6FfPgKVDLzd
 rzww==
X-Gm-Message-State: AOJu0Yy39B1JQ8b7iEdMPKpbOvdLjSke0OeZp0EVAorVXQNRyTWTFNjQ
 j3GcCA+ArouO1sSW6sPSVBgWms0/CfX4Ne/TIDG0fb6ovFxar38Senn7Ojmgm9ierz5B2Hd8L5c
 Q
X-Gm-Gg: ASbGncu4Nj10eh1yB3NYUxLUt0ss3u2fwogsONCFPHUCGAanaR/7QyeUZ58UJ73BaVg
 jGn7pwKHaxWCs9bsywFb/FEYx8zLkUxskAGm6orzWIkZXbzHlcLvDFSJtqbvbq9BrgOTMKm58Mk
 Nins6GeuJy2nyIMTuw6Hfbx464Eudpp1lJRuT82SVg97fZHEVFmLPyN1e/USes7goVo2UIwN2DN
 khaTfX0HrIz40lSvFreW/7KBysv4aICNbk11t0pCn9O1nGxK6HmlIcn4gK6rHfao7oGY5ip3tF2
 QpPoU3L4/6q0BxWG2/p+Cde0MUdurBFr6iuUdA3J94CW+v0=
X-Google-Smtp-Source: AGHT+IHBV8PLmdTwwMnfZEXO0M88zdK3oun7gnBxSioqKGnzKQa6XoCHjzdkKg6EL5mIOOSB04TfkQ==
X-Received: by 2002:a17:90b:1dca:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-2fc0f924386mr23364858a91.3.1739747416094; 
 Sun, 16 Feb 2025 15:10:16 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 003/162] tcg: Merge INDEX_op_mov_{i32,i64}
Date: Sun, 16 Feb 2025 15:07:32 -0800
Message-ID: <20250216231012.2808572-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Begin to rely on TCGOp.type to discriminate operations,
rather than two different opcodes.  Convert mov first.
Introduce TCG_OPF_INT in order to keep opcode dumps the same.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  4 ++--
 include/tcg/tcg.h                |  2 ++
 tcg/optimize.c                   |  7 +++----
 tcg/tcg-op.c                     |  4 ++--
 tcg/tcg.c                        | 32 ++++++++++++++++++--------------
 tcg/tci.c                        |  5 ++---
 docs/devel/tcg-ops.rst           |  4 ++--
 tcg/aarch64/tcg-target.c.inc     |  2 --
 tcg/arm/tcg-target.c.inc         |  1 -
 tcg/i386/tcg-target.c.inc        |  2 --
 tcg/loongarch64/tcg-target.c.inc |  2 --
 tcg/mips/tcg-target.c.inc        |  2 --
 tcg/ppc/tcg-target.c.inc         |  2 --
 tcg/riscv/tcg-target.c.inc       |  2 --
 tcg/s390x/tcg-target.c.inc       |  2 --
 tcg/sparc64/tcg-target.c.inc     |  2 --
 tcg/tci/tcg-target.c.inc         | 15 +--------------
 17 files changed, 32 insertions(+), 58 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c26cffaa3f..766fd00d99 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -37,7 +37,8 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 
 DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 
-DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
+DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
+
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
 DEF(movcond_i32, 1, 4, 1, 0)
@@ -98,7 +99,6 @@ DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
 
-DEF(mov_i64, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, 0)
 DEF(negsetcond_i64, 1, 2, 1, 0)
 DEF(movcond_i64, 1, 4, 1, 0)
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 84d99508b6..c6b50b5226 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -741,6 +741,8 @@ enum {
     /* Instruction has side effects: it cannot be removed if its outputs
        are not used, and might trigger exceptions.  */
     TCG_OPF_SIDE_EFFECTS = 0x08,
+    /* Instruction operands may be I32 or I64 */
+    TCG_OPF_INT          = 0x10,
     /* Instruction is optional and not implemented by the host, or insn
        is generic and should not be implemented by the host.  */
     TCG_OPF_NOT_PRESENT  = 0x20,
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 250bc7de2b..a36283cd35 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -363,10 +363,8 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        new_op = INDEX_op_mov_i32;
-        break;
     case TCG_TYPE_I64:
-        new_op = INDEX_op_mov_i64;
+        new_op = INDEX_op_mov;
         break;
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
@@ -2921,7 +2919,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_mb:
             done = fold_mb(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(mov):
+        case INDEX_op_mov:
+        case INDEX_op_mov_vec:
             done = fold_mov(&ctx, op);
             break;
         CASE_OP_32_64(movcond):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 48793ed439..108dc61e9a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -351,7 +351,7 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
 void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (ret != arg) {
-        tcg_gen_op2_i32(INDEX_op_mov_i32, ret, arg);
+        tcg_gen_op2_i32(INDEX_op_mov, ret, arg);
     }
 }
 
@@ -1411,7 +1411,7 @@ void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
         return;
     }
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op2_i64(INDEX_op_mov_i64, ret, arg);
+        tcg_gen_op2_i64(INDEX_op_mov, ret, arg);
     } else {
         TCGTemp *ts = tcgv_i64_temp(arg);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dd150febb2..99f6371fd8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2187,7 +2187,9 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
-    case INDEX_op_mov_i32:
+    case INDEX_op_mov:
+        return has_type;
+
     case INDEX_op_setcond_i32:
     case INDEX_op_brcond_i32:
     case INDEX_op_movcond_i32:
@@ -2269,7 +2271,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
 
-    case INDEX_op_mov_i64:
     case INDEX_op_setcond_i64:
     case INDEX_op_brcond_i64:
     case INDEX_op_movcond_i64:
@@ -2840,18 +2841,23 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                 col += ne_fprintf(f, ",%s", t);
             }
         } else {
-            col += ne_fprintf(f, " %s ", def->name);
+            if (def->flags & TCG_OPF_INT) {
+                col += ne_fprintf(f, " %s_i%d ",
+                                  def->name,
+                                  8 * tcg_type_size(TCGOP_TYPE(op)));
+            } else if (def->flags & TCG_OPF_VECTOR) {
+                col += ne_fprintf(f, "%s v%d,e%d,",
+                                  def->name,
+                                  8 * tcg_type_size(TCGOP_TYPE(op)),
+                                  8 << TCGOP_VECE(op));
+            } else {
+                col += ne_fprintf(f, " %s ", def->name);
+            }
 
             nb_oargs = def->nb_oargs;
             nb_iargs = def->nb_iargs;
             nb_cargs = def->nb_cargs;
 
-            if (def->flags & TCG_OPF_VECTOR) {
-                col += ne_fprintf(f, "v%d,e%d,",
-                                  8 * tcg_type_size(TCGOP_TYPE(op)),
-                                  8 << TCGOP_VECE(op));
-            }
-
             k = 0;
             for (i = 0; i < nb_oargs; i++) {
                 const char *sep =  k ? "," : "";
@@ -4144,8 +4150,7 @@ liveness_pass_1(TCGContext *s)
 
             /* Incorporate constraints for this operand.  */
             switch (opc) {
-            case INDEX_op_mov_i32:
-            case INDEX_op_mov_i64:
+            case INDEX_op_mov:
                 /* Note that these are TCG_OPF_NOT_PRESENT and do not
                    have proper constraints.  That said, special case
                    moves to propagate preferences backward.  */
@@ -4303,7 +4308,7 @@ liveness_pass_2(TCGContext *s)
         }
 
         /* Outputs become available.  */
-        if (opc == INDEX_op_mov_i32 || opc == INDEX_op_mov_i64) {
+        if (opc == INDEX_op_mov) {
             arg_ts = arg_temp(op->args[0]);
             dir_ts = arg_ts->state_ptr;
             if (dir_ts) {
@@ -6429,8 +6434,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         TCGOpcode opc = op->opc;
 
         switch (opc) {
-        case INDEX_op_mov_i32:
-        case INDEX_op_mov_i64:
+        case INDEX_op_mov:
         case INDEX_op_mov_vec:
             tcg_reg_alloc_mov(s, op);
             break;
diff --git a/tcg/tci.c b/tcg/tci.c
index 531cd83aae..78183ea47d 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -463,7 +463,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = regs[tmp32 ? r3 : r4];
             break;
 #endif
-        CASE_32_64(mov)
+        case INDEX_op_mov:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = regs[r1];
             break;
@@ -1063,8 +1063,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), s2);
         break;
 
-    case INDEX_op_mov_i32:
-    case INDEX_op_mov_i64:
+    case INDEX_op_mov:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 3db7b81637..e6ccc78fa1 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -391,10 +391,10 @@ Misc
 
 .. list-table::
 
-   * - mov_i32/i64 *t0*, *t1*
+   * - mov *t0*, *t1*
 
      - | *t0* = *t1*
-       | Move *t1* to *t0* (both operands must have the same type).
+       | Move *t1* to *t0*.
 
    * - bswap16_i32/i64 *t0*, *t1*, *flags*
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index b8b26c1c93..466042a577 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2488,8 +2488,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_mb(s, a0);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index edbcf47367..0a959578d2 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2115,7 +2115,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, args[0]);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 02024018cb..75c8665d74 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3011,8 +3011,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c15314e1c8..a0f050ff9c 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1690,8 +1690,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, false);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f77159bdc7..4d52e0bde0 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2101,8 +2101,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index e10c1c5162..11dcfe66f3 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3468,8 +3468,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, args[0]);
         break;
 
-    case INDEX_op_mov_i32:   /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index d525df4e1d..6f9d87df48 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2380,8 +2380,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 8421320928..30fa26e884 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2776,8 +2776,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 787e0d896c..cb5e8d554d 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1512,8 +1512,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_arithi(s, a0, a1, a2, SHIFT_SRA);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 6f8f1dd8ae..9a5d3c2875 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -483,18 +483,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
-    switch (type) {
-    case TCG_TYPE_I32:
-        tcg_out_op_rr(s, INDEX_op_mov_i32, ret, arg);
-        break;
-#if TCG_TARGET_REG_BITS == 64
-    case TCG_TYPE_I64:
-        tcg_out_op_rr(s, INDEX_op_mov_i64, ret, arg);
-        break;
-#endif
-    default:
-        g_assert_not_reached();
-    }
+    tcg_out_op_rr(s, INDEX_op_mov, ret, arg);
     return true;
 }
 
@@ -799,8 +788,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_v(s, opc);
         break;
 
-    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-- 
2.43.0


