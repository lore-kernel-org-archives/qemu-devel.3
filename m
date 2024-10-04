Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A37CF8857
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 20:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swot6-0007kG-HT; Fri, 04 Oct 2024 16:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swot0-0007j0-03
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:26:50 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swosw-0007rQ-Gx
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:26:49 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5389fbb28f3so2580322e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728073604; x=1728678404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoDHGFnGaGJwq3TS2KGzN1Vzu1zC77gN5n+3+uh4pfA=;
 b=UGSlMeSPs4Tn2XWNpFdpisahX2G+1QYRCtpxv0GSnRPtmfa6qomgJyALgMoKojP8zp
 Xmock4F+ER8vZWIx0Y7K09t14keZJBNKTARAP05n5EL3mu6usMUavjKiSj6aGVG+gIet
 uT+Z4Na08oAzfwKJgARxH9ye1BCEyIqAOFjSYe4Ec+aVzEOm7GR/SNZzQBD10oFX2yv+
 0Pg9aVP93r+Ii9FAkRkqgUuBB1Fx0UaUJO7uIKHhoT0b+2Ihux6KZSPH17LnQ7DtH//8
 LeD+xRQvNkHD/e0Qdh4e+Ji7McraVEfTDD9VrVmW6ioFWjQcIGveXikx6XreEihmrAbZ
 V7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728073604; x=1728678404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EoDHGFnGaGJwq3TS2KGzN1Vzu1zC77gN5n+3+uh4pfA=;
 b=OVu2ReoxhyPgV4RbZzEVm21cmtOitt5t2kFRCxgAKe7cgpZF/VM4mOQUAsRNFn+Re7
 g40Z6jdO0OjwmRcNTjUz9rkJxoT57jYp9kPjeQgfFiilQw2hGk55hMewMcoF3R1LCGHF
 PWPCwFlV60u4jkjwWgqHS61wboVILc1THLzbWTSAa/ziZXD4MG2lkiYyd7sgOmGvY/Ep
 mdb8fUHf3Qf5Rx8F0mT5RTnelNQTMPCwzJEfZ1C0hrtYMnafKUCmuBSHSk7pczKCSFAn
 n3pNYzj90v0CxFoMoh828ZCcUarVVM1kknhMLBacohFtpBi+ZsUEwHPkMrdABLD+VPCv
 blZg==
X-Gm-Message-State: AOJu0YxPriPcDUHSWtg8A/sD2PQ+Ez1CGLVn58PI/xoPiuA0U1hJs22D
 ieNW6MPoNBEBPw0KuAL3/l4FFCzTjL7RRwAtOQo8/jY4upZ+sUdLGI1bxFwuKTP8vDOPj9d8ura
 XXL3FLA==
X-Google-Smtp-Source: AGHT+IG74cscbD9MCbSx+4bu2x+87LfrnEAuYfJ88YZTz6ec+zrPA2wXgtd+3iSbQIIH2p55SjELog==
X-Received: by 2002:a05:6512:3c8a:b0:539:896e:46ce with SMTP id
 2adb3069b0e04-539ac17ebdcmr1274930e87.28.1728073604008; 
 Fri, 04 Oct 2024 13:26:44 -0700 (PDT)
Received: from localhost.localdomain ([91.209.212.135])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff28077sm50154e87.255.2024.10.04.13.26.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 13:26:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] target/mips: Use tcg_constant_tl() instead of
 tcg_gen_movi_tl()
Date: Fri,  4 Oct 2024 17:26:19 -0300
Message-ID: <20241004202621.4321-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004202621.4321-1-philmd@linaro.org>
References: <20241004202621.4321-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Directly use tcg_constant_tl() for constant integer, this
save a call to tcg_gen_movi_tl(), often saving a temp register.

Most of the places found using the following Coccinelle spatch script:

  @@
  identifier tmp;
  constant val;
  @@
  *    TCGv tmp = tcg_temp_new();
       ...
  *    tcg_gen_movi_tl(tmp, val);

  @@
  identifier tmp;
  int val;
  @@
  *    TCGv tmp = tcg_temp_new();
       ...
  *    tcg_gen_movi_i64(tmp, val);

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20240930091101.40591-1-philmd@linaro.org>
---
 target/mips/tcg/translate.c               |  56 ++++-------
 target/mips/tcg/micromips_translate.c.inc |  12 +--
 target/mips/tcg/mips16e_translate.c.inc   |  15 +--
 target/mips/tcg/nanomips_translate.c.inc  | 114 ++++++++--------------
 4 files changed, 68 insertions(+), 129 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 591e1351216..9f3579a0012 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2253,8 +2253,7 @@ static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
     /* compare the address against that of the preceding LL */
     gen_base_offset_addr(ctx, addr, base, offset);
     tcg_gen_brcond_tl(TCG_COND_EQ, addr, cpu_lladdr, l1);
-    tcg_gen_movi_tl(t0, 0);
-    gen_store_gpr(t0, rt);
+    gen_store_gpr(tcg_constant_tl(0), rt);
     tcg_gen_br(done);
 
     gen_set_label(l1);
@@ -3060,8 +3059,7 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
             tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         }
@@ -3077,30 +3075,27 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_rem_tl(cpu_gpr[rd], t0, t1);
             tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         }
         break;
     case R6_OPC_DIVU:
         {
-            TCGv t2 = tcg_constant_tl(0);
-            TCGv t3 = tcg_constant_tl(1);
             tcg_gen_ext32u_tl(t0, t0);
             tcg_gen_ext32u_tl(t1, t1);
-            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1,
+                               tcg_constant_tl(0), tcg_constant_tl(1), t1);
             tcg_gen_divu_tl(cpu_gpr[rd], t0, t1);
             tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         }
         break;
     case R6_OPC_MODU:
         {
-            TCGv t2 = tcg_constant_tl(0);
-            TCGv t3 = tcg_constant_tl(1);
             tcg_gen_ext32u_tl(t0, t0);
             tcg_gen_ext32u_tl(t1, t1);
-            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1,
+                               tcg_constant_tl(0), tcg_constant_tl(1), t1);
             tcg_gen_remu_tl(cpu_gpr[rd], t0, t1);
             tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         }
@@ -3155,8 +3150,7 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
         }
         break;
@@ -3169,24 +3163,21 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_rem_tl(cpu_gpr[rd], t0, t1);
         }
         break;
     case R6_OPC_DDIVU:
         {
-            TCGv t2 = tcg_constant_tl(0);
-            TCGv t3 = tcg_constant_tl(1);
-            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1,
+                               tcg_constant_tl(0), tcg_constant_tl(1), t1);
             tcg_gen_divu_i64(cpu_gpr[rd], t0, t1);
         }
         break;
     case R6_OPC_DMODU:
         {
-            TCGv t2 = tcg_constant_tl(0);
-            TCGv t3 = tcg_constant_tl(1);
-            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1,
+                               tcg_constant_tl(0), tcg_constant_tl(1), t1);
             tcg_gen_remu_i64(cpu_gpr[rd], t0, t1);
         }
         break;
@@ -3239,8 +3230,7 @@ static void gen_div1_tx79(DisasContext *ctx, uint32_t opc, int rs, int rt)
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_div_tl(cpu_LO[1], t0, t1);
             tcg_gen_rem_tl(cpu_HI[1], t0, t1);
             tcg_gen_ext32s_tl(cpu_LO[1], cpu_LO[1]);
@@ -3295,8 +3285,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_div_tl(cpu_LO[acc], t0, t1);
             tcg_gen_rem_tl(cpu_HI[acc], t0, t1);
             tcg_gen_ext32s_tl(cpu_LO[acc], cpu_LO[acc]);
@@ -3348,17 +3337,15 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_div_tl(cpu_LO[acc], t0, t1);
             tcg_gen_rem_tl(cpu_HI[acc], t0, t1);
         }
         break;
     case OPC_DDIVU:
         {
-            TCGv t2 = tcg_constant_tl(0);
-            TCGv t3 = tcg_constant_tl(1);
-            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1,
+                               tcg_constant_tl(0), tcg_constant_tl(1), t1);
             tcg_gen_divu_i64(cpu_LO[acc], t0, t1);
             tcg_gen_remu_i64(cpu_HI[acc], t0, t1);
         }
@@ -11428,17 +11415,12 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
 void gen_addiupc(DisasContext *ctx, int rx, int imm,
                  int is_64_bit, int extended)
 {
-    TCGv t0;
-
     if (extended && (ctx->hflags & MIPS_HFLAG_BMASK)) {
         gen_reserved_instruction(ctx);
         return;
     }
 
-    t0 = tcg_temp_new();
-
-    tcg_gen_movi_tl(t0, pc_relative_pc(ctx));
-    tcg_gen_addi_tl(cpu_gpr[rx], t0, imm);
+    tcg_gen_addi_tl(cpu_gpr[rx], tcg_constant_tl(pc_relative_pc(ctx)), imm);
     if (!is_64_bit) {
         tcg_gen_ext32s_tl(cpu_gpr[rx], cpu_gpr[rx]);
     }
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 171508f7deb..d044592f83e 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -980,8 +980,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd);
-        tcg_gen_movi_tl(t1, 4);
-        gen_op_addr_add(ctx, t0, t0, t1);
+        gen_op_addr_add(ctx, t0, t0, tcg_constant_tl(4));
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd + 1);
@@ -990,8 +989,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
-        tcg_gen_movi_tl(t1, 4);
-        gen_op_addr_add(ctx, t0, t0, t1);
+        gen_op_addr_add(ctx, t0, t0, tcg_constant_tl(4));
         gen_load_gpr(t1, rd + 1);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
@@ -1005,8 +1003,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd);
-        tcg_gen_movi_tl(t1, 8);
-        gen_op_addr_add(ctx, t0, t0, t1);
+        gen_op_addr_add(ctx, t0, t0, tcg_constant_tl(8));
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd + 1);
@@ -1015,8 +1012,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        tcg_gen_movi_tl(t1, 8);
-        gen_op_addr_add(ctx, t0, t0, t1);
+        gen_op_addr_add(ctx, t0, t0, tcg_constant_tl(8));
         gen_load_gpr(t1, rd + 1);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 28684b08fe3..e770372b4c2 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -130,10 +130,8 @@ static int xlat(int r)
 static void decr_and_store(DisasContext *ctx, unsigned regidx, TCGv t0)
 {
     TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
 
-    tcg_gen_movi_tl(t2, -4);
-    gen_op_addr_add(ctx, t0, t0, t2);
+    gen_op_addr_add(ctx, t0, t0, tcg_constant_tl(-4));
     gen_load_gpr(t1, regidx);
     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                        ctx->default_tcg_memop_mask);
@@ -146,7 +144,6 @@ static void gen_mips16_save(DisasContext *ctx,
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
     int args, astatic;
 
     switch (aregs) {
@@ -286,8 +283,7 @@ static void gen_mips16_save(DisasContext *ctx,
         }
     }
 
-    tcg_gen_movi_tl(t2, -framesize);
-    gen_op_addr_add(ctx, cpu_gpr[29], cpu_gpr[29], t2);
+    gen_op_addr_add(ctx, cpu_gpr[29], cpu_gpr[29], tcg_constant_tl(-framesize));
 }
 
 static void decr_and_load(DisasContext *ctx, unsigned regidx, TCGv t0)
@@ -307,10 +303,8 @@ static void gen_mips16_restore(DisasContext *ctx,
 {
     int astatic;
     TCGv t0 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
 
-    tcg_gen_movi_tl(t2, framesize);
-    gen_op_addr_add(ctx, t0, cpu_gpr[29], t2);
+    gen_op_addr_add(ctx, t0, cpu_gpr[29], tcg_constant_tl(-framesize));
 
     if (do_ra) {
         decr_and_load(ctx, 31, t0);
@@ -390,8 +384,7 @@ static void gen_mips16_restore(DisasContext *ctx,
         }
     }
 
-    tcg_gen_movi_tl(t2, framesize);
-    gen_op_addr_add(ctx, cpu_gpr[29], cpu_gpr[29], t2);
+    gen_op_addr_add(ctx, cpu_gpr[29], cpu_gpr[29], tcg_constant_tl(-framesize));
 }
 
 #if defined(TARGET_MIPS64)
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index c37ea7273d2..a64e9fef017 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -1052,8 +1052,7 @@ static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
         tcg_gen_movi_tl(cpu_gpr[reg1], 0);
     }
     gen_set_label(lab_done);
-    tcg_gen_movi_tl(lladdr, -1);
-    tcg_gen_st_tl(lladdr, tcg_env, offsetof(CPUMIPSState, lladdr));
+    tcg_gen_st_tl(tcg_constant_tl(-1), tcg_env, offsetof(CPUMIPSState, lladdr));
 }
 
 static void gen_adjust_sp(DisasContext *ctx, int u)
@@ -1543,7 +1542,6 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
 {
     int16_t imm;
     TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
     TCGv v0_t = tcg_temp_new();
 
     gen_load_gpr(v0_t, v1);
@@ -1570,12 +1568,10 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
         check_dsp(ctx);
         switch (extract32(ctx->opcode, 12, 2)) {
         case NM_MTHLIP:
-            tcg_gen_movi_tl(t0, v2 >> 3);
-            gen_helper_mthlip(t0, v0_t, tcg_env);
+            gen_helper_mthlip(tcg_constant_tl(v2 >> 3), v0_t, tcg_env);
             break;
         case NM_SHILOV:
-            tcg_gen_movi_tl(t0, v2 >> 3);
-            gen_helper_shilo(t0, v0_t, tcg_env);
+            gen_helper_shilo(tcg_constant_tl(v2 >> 3), v0_t, tcg_env);
             break;
         default:
             gen_reserved_instruction(ctx);
@@ -1587,39 +1583,34 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
         imm = extract32(ctx->opcode, 14, 7);
         switch (extract32(ctx->opcode, 12, 2)) {
         case NM_RDDSP:
-            tcg_gen_movi_tl(t0, imm);
-            gen_helper_rddsp(t0, t0, tcg_env);
+            gen_helper_rddsp(t0, tcg_constant_tl(imm), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_WRDSP:
             gen_load_gpr(t0, ret);
-            tcg_gen_movi_tl(t1, imm);
-            gen_helper_wrdsp(t0, t1, tcg_env);
+            gen_helper_wrdsp(t0, tcg_constant_tl(imm), tcg_env);
             break;
         case NM_EXTP:
-            tcg_gen_movi_tl(t0, v2 >> 3);
-            tcg_gen_movi_tl(t1, v1);
-            gen_helper_extp(t0, t0, t1, tcg_env);
+            gen_helper_extp(t0, tcg_constant_tl(v2 >> 3),
+                            tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_EXTPDP:
-            tcg_gen_movi_tl(t0, v2 >> 3);
-            tcg_gen_movi_tl(t1, v1);
-            gen_helper_extpdp(t0, t0, t1, tcg_env);
+            gen_helper_extpdp(t0, tcg_constant_tl(v2 >> 3),
+                              tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         }
         break;
     case NM_POOL32AXF_1_4:
         check_dsp(ctx);
-        tcg_gen_movi_tl(t0, v2 >> 2);
         switch (extract32(ctx->opcode, 12, 1)) {
         case NM_SHLL_QB:
-            gen_helper_shll_qb(t0, t0, v0_t, tcg_env);
+            gen_helper_shll_qb(t0, tcg_constant_tl(v2 >> 2), v0_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_SHRL_QB:
-            gen_helper_shrl_qb(t0, t0, v0_t);
+            gen_helper_shrl_qb(t0, tcg_constant_tl(v2 >> 2), v0_t);
             gen_store_gpr(t0, ret);
             break;
         }
@@ -1630,23 +1621,25 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
         break;
     case NM_POOL32AXF_1_7:
         check_dsp(ctx);
-        tcg_gen_movi_tl(t0, v2 >> 3);
-        tcg_gen_movi_tl(t1, v1);
         switch (extract32(ctx->opcode, 12, 2)) {
         case NM_EXTR_W:
-            gen_helper_extr_w(t0, t0, t1, tcg_env);
+            gen_helper_extr_w(t0, tcg_constant_tl(v2 >> 3),
+                              tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_EXTR_R_W:
-            gen_helper_extr_r_w(t0, t0, t1, tcg_env);
+            gen_helper_extr_r_w(t0, tcg_constant_tl(v2 >> 3),
+                                tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_EXTR_RS_W:
-            gen_helper_extr_rs_w(t0, t0, t1, tcg_env);
+            gen_helper_extr_rs_w(t0, tcg_constant_tl(v2 >> 3),
+                                 tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_EXTR_S_H:
-            gen_helper_extr_s_h(t0, t0, t1, tcg_env);
+            gen_helper_extr_s_h(t0, tcg_constant_tl(v2 >> 3),
+                                tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         }
@@ -1848,8 +1841,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
         case NM_EXTRV_W:
             check_dsp(ctx);
             gen_load_gpr(v1_t, rs);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extr_w(t0, t0, v1_t, tcg_env);
+            gen_helper_extr_w(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         }
@@ -1903,8 +1895,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             break;
         case NM_EXTRV_R_W:
             check_dsp(ctx);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extr_r_w(t0, t0, v1_t, tcg_env);
+            gen_helper_extr_r_w(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         default:
@@ -1923,8 +1914,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             break;
         case NM_EXTPV:
             check_dsp(ctx);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extp(t0, t0, v1_t, tcg_env);
+            gen_helper_extp(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_MSUB:
@@ -1947,8 +1937,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             break;
         case NM_EXTRV_RS_W:
             check_dsp(ctx);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extr_rs_w(t0, t0, v1_t, tcg_env);
+            gen_helper_extr_rs_w(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         }
@@ -1964,8 +1953,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             break;
         case NM_EXTPDPV:
             check_dsp(ctx);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extpdp(t0, t0, v1_t, tcg_env);
+            gen_helper_extpdp(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_MSUBU:
@@ -1990,8 +1978,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             break;
         case NM_EXTRV_S_H:
             check_dsp(ctx);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extr_s_h(t0, t0, v1_t, tcg_env);
+            gen_helper_extr_s_h(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         }
@@ -2149,24 +2136,22 @@ static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
     switch (opc) {
     case NM_SHRA_R_QB:
         check_dsp_r2(ctx);
-        tcg_gen_movi_tl(t0, rd >> 2);
         switch (extract32(ctx->opcode, 12, 1)) {
         case 0:
             /* NM_SHRA_QB */
-            gen_helper_shra_qb(t0, t0, rs_t);
+            gen_helper_shra_qb(t0, tcg_constant_tl(rd >> 2), rs_t);
             gen_store_gpr(t0, rt);
             break;
         case 1:
             /* NM_SHRA_R_QB */
-            gen_helper_shra_r_qb(t0, t0, rs_t);
+            gen_helper_shra_r_qb(t0, tcg_constant_tl(rd >> 2), rs_t);
             gen_store_gpr(t0, rt);
             break;
         }
         break;
     case NM_SHRL_PH:
         check_dsp_r2(ctx);
-        tcg_gen_movi_tl(t0, rd >> 1);
-        gen_helper_shrl_ph(t0, t0, rs_t);
+        gen_helper_shrl_ph(t0, tcg_constant_tl(rd >> 1), rs_t);
         gen_store_gpr(t0, rt);
         break;
     case NM_REPL_QB:
@@ -2180,8 +2165,7 @@ static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
                      (uint32_t)imm << 8  |
                      (uint32_t)imm;
             result = (int32_t)result;
-            tcg_gen_movi_tl(t0, result);
-            gen_store_gpr(t0, rt);
+            gen_store_gpr(tcg_constant_tl(result), rt);
         }
         break;
     default:
@@ -2302,10 +2286,9 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
 {
     TCGCond cond = TCG_COND_ALWAYS;
     TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
+    TCGv timm = tcg_constant_tl(imm);
 
     gen_load_gpr(t0, rt);
-    tcg_gen_movi_tl(t1, imm);
     ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
 
     /* Load needed operands and calculate btarget */
@@ -2334,7 +2317,7 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
         } else {
             tcg_gen_shri_tl(t0, t0, imm);
             tcg_gen_andi_tl(t0, t0, 1);
-            tcg_gen_movi_tl(t1, 0);
+            timm = tcg_constant_tl(0);
             if (opc == NM_BBEQZC) {
                 cond = TCG_COND_EQ;
             } else {
@@ -2389,7 +2372,7 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
         /* Conditional compact branch */
         TCGLabel *fs = gen_new_label();
 
-        tcg_gen_brcond_tl(tcg_invert_cond(cond), t0, t1, fs);
+        tcg_gen_brcond_tl(tcg_invert_cond(cond), t0, timm, fs);
 
         gen_goto_tb(ctx, 1, ctx->btarget);
         gen_set_label(fs);
@@ -2403,7 +2386,6 @@ static void gen_compute_nanomips_pbalrsc_branch(DisasContext *ctx, int rs,
                                                 int rt)
 {
     TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
 
     /* load rs */
     gen_load_gpr(t0, rs);
@@ -2415,8 +2397,7 @@ static void gen_compute_nanomips_pbalrsc_branch(DisasContext *ctx, int rs,
 
     /* calculate btarget */
     tcg_gen_shli_tl(t0, t0, 1);
-    tcg_gen_movi_tl(t1, ctx->base.pc_next + 4);
-    gen_op_addr_add(ctx, btarget, t1, t0);
+    gen_op_addr_add(ctx, btarget, tcg_constant_tl(ctx->base.pc_next + 4), t0);
 
     /* branch completion */
     clear_branch_hflags(ctx);
@@ -2469,11 +2450,9 @@ static void gen_compute_compact_branch_nm(DisasContext *ctx, uint32_t opc,
         } else {
             /* OPC_JIC, OPC_JIALC */
             TCGv tbase = tcg_temp_new();
-            TCGv toffset = tcg_temp_new();
 
             gen_load_gpr(tbase, rt);
-            tcg_gen_movi_tl(toffset, offset);
-            gen_op_addr_add(ctx, btarget, tbase, toffset);
+            gen_op_addr_add(ctx, btarget, tbase, tcg_constant_tl(offset));
         }
         break;
     default:
@@ -3445,13 +3424,10 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
     case NM_SHILO:
         check_dsp(ctx);
         {
-            TCGv tv0 = tcg_temp_new();
-            TCGv tv1 = tcg_temp_new();
             int16_t imm = extract32(ctx->opcode, 16, 7);
 
-            tcg_gen_movi_tl(tv0, rd >> 3);
-            tcg_gen_movi_tl(tv1, imm);
-            gen_helper_shilo(tv0, tv1, tcg_env);
+            gen_helper_shilo(tcg_constant_tl(rd >> 3),
+                             tcg_constant_tl(imm), tcg_env);
         }
         break;
     case NM_MULEQ_S_W_PHL:
@@ -3506,8 +3482,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         break;
     case NM_SHRA_R_W:
         check_dsp(ctx);
-        tcg_gen_movi_tl(t0, rd);
-        gen_helper_shra_r_w(v1_t, t0, v1_t);
+        gen_helper_shra_r_w(v1_t, tcg_constant_tl(rd), v1_t);
         gen_store_gpr(v1_t, rt);
         break;
     case NM_SHRA_R_PH:
@@ -3547,8 +3522,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         break;
     case NM_SHLL_S_W:
         check_dsp(ctx);
-        tcg_gen_movi_tl(t0, rd);
-        gen_helper_shll_s_w(v1_t, t0, v1_t, tcg_env);
+        gen_helper_shll_s_w(v1_t, tcg_constant_tl(rd), v1_t, tcg_env);
         gen_store_gpr(v1_t, rt);
         break;
     case NM_REPL_PH:
@@ -3729,31 +3703,25 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             case NM_LWPC48:
                 check_nms(ctx);
                 if (rt != 0) {
-                    TCGv t0;
-                    t0 = tcg_temp_new();
-
                     target_long addr = addr_add(ctx, ctx->base.pc_next + 6,
                                                 addr_off);
 
-                    tcg_gen_movi_tl(t0, addr);
-                    tcg_gen_qemu_ld_tl(cpu_gpr[rt], t0, ctx->mem_idx,
+                    tcg_gen_qemu_ld_tl(cpu_gpr[rt], tcg_constant_tl(addr), ctx->mem_idx,
                                        mo_endian(ctx) | MO_SL | ctx->default_tcg_memop_mask);
                 }
                 break;
             case NM_SWPC48:
                 check_nms(ctx);
                 {
-                    TCGv t0, t1;
-                    t0 = tcg_temp_new();
+                    TCGv t1;
                     t1 = tcg_temp_new();
 
                     target_long addr = addr_add(ctx, ctx->base.pc_next + 6,
                                                 addr_off);
 
-                    tcg_gen_movi_tl(t0, addr);
                     gen_load_gpr(t1, rt);
 
-                    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
+                    tcg_gen_qemu_st_tl(t1, tcg_constant_tl(addr), ctx->mem_idx,
                                        mo_endian(ctx) | MO_UL | ctx->default_tcg_memop_mask);
                 }
                 break;
-- 
2.45.2


