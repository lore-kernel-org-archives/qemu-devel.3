Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA91D3B98E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvRu-0000hY-G1; Tue, 26 Nov 2024 08:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQe-0008NL-G3
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:34 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQa-0003eI-PZ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:31 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ffc76368c6so31287071fa.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732626986; x=1733231786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaQXErJo7YtbBSN/89WKLiUD33Zff+wbQUKG0qIgN9E=;
 b=mk1p34YgWJXEDz3h6ZLbPO8GWm9n66rluLf47yDM7etFVmY8wEk9rfWk7nKHNBpWCz
 98q9ghb21aJhAT1pVasaVTHNJaxJeeKRvhdoaaKBok8xKE3iLddYGIB6up0eNauyC7fl
 22KkdcD/9LdTKXh+UhuILy8cLZ8MQLCp0hCXrYdDw88tl6y2zG2r8+dCT9CvqRZJnLaL
 rdyeFegV5e2SkZW41RD0Oc6dS0hXwBrVkh6NmiTaES4tRsvNEovJ93pYEixgdkux6lv2
 aR9SA4iiNVHZGY5ggnYGQg5L0emVQ1q0t4dxyu+7xKqm9Mx/cg8nfKd5+On8oQyVWZUu
 ZPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626986; x=1733231786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YaQXErJo7YtbBSN/89WKLiUD33Zff+wbQUKG0qIgN9E=;
 b=brS89nzsFFoxr7TpvXpvkb4QWuCy2n0WIKGXm+DRlfMU7d0qJq3DqQfUdkDnjd2muu
 Ok+IQ4WnzZFtFT14B8plvMntSpagwT0EGFO83M76QFZHMyLm3j/W8vegzA39uqL9r+Nc
 JMpBYOU2g4N9F/J0YpeklAwvO/nDyQx4AzevMTnLwq2B8Z5uMKT2RmPBgdKj0a3zXiZo
 z5rQs9pZ+BTG7dl3ZnXy61HCh4iu2QbCmuGRy4up8L0fPf5FHkBFBbNOLw3D2RJHfZGw
 rFHOKCrAjobBFjfmmIqyRDa4uvFZQhFCWZ5P55+DWP7XNl9lr5QNcvyEOdpHLty1RPWL
 PjDA==
X-Gm-Message-State: AOJu0YxtG1cHasd2Z87OPrL/rg361COm6wcga8YOBjvCRkEaZhrUaAk8
 ycjssvhG0cvXX6HIuGrXRygqnLfQoWAVpC7CLOSzJW2MZxqCwuzOyrlMZMqPErIm4r1yZke/kGh
 g
X-Gm-Gg: ASbGnctspb34XKmZfx4VCALBiCnpCquiaGcTeIyEtmKvH00XmFMzjkH8x/AfTcgXquY
 tHDMrTKN3A5f4jHWkEAAJ5MioRX4KPX0YR4QCmGEo9/lhBW1RsMC3vOyxoyXWz7p5PmPPL9/L9y
 ngrF8GAAdyWh9088U42k+CHKPkJ/ief+9ZVuljoFAZdRivGorIcl7hk7Vs908aKA6nbNwj+1EPI
 fjqm5voSBdz+R1uuzsL5DJ3hjKuDWqNFL4Y/BGGG+qBCHeBpUWDbP4rlx0CiHqhcmRc6qZN
X-Google-Smtp-Source: AGHT+IHej8zKhkRlzaS1zlpPBgy1NIZBa9RprgWCL1WMpMAtTqNerJn6e7PbGHmBhmX2OUtA4DYubQ==
X-Received: by 2002:a05:651c:1546:b0:2fa:c0b5:ac8c with SMTP id
 38308e7fff4ca-2ffa7124ff6mr116324351fa.21.1732626985606; 
 Tue, 26 Nov 2024 05:16:25 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434921ceea7sm113970555e9.25.2024.11.26.05.16.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:16:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 06/13] target/mips: Rename gen_op_addr_add?() ->
 gen_op_addr_add?_tl()
Date: Tue, 26 Nov 2024 14:15:38 +0100
Message-ID: <20241126131546.66145-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

MIPS gen_op_addr_add() and gen_op_addr_addi() take a target-specific
TCGv argument. Rename them respectively as gen_op_addr_add_tl() and
gen_op_addr_addi_tl() like other TCG core helpers.

Mechanical change done using sed tool.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h               |  4 ++--
 target/mips/tcg/translate.c               | 28 +++++++++++------------
 target/mips/tcg/micromips_translate.c.inc |  8 +++----
 target/mips/tcg/mips16e_translate.c.inc   | 10 ++++----
 target/mips/tcg/nanomips_translate.c.inc  | 14 ++++++------
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 94dd30216f5..9517e18eef9 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -175,8 +175,8 @@ void gen_addiupc(DisasContext *ctx, int rx, int imm,
 /*
  * Address Computation and Large Constant Instructions
  */
-void gen_op_addr_add(DisasContext *ctx, TCGv ret, TCGv arg0, TCGv arg1);
-void gen_op_addr_addi(DisasContext *ctx, TCGv ret, TCGv base, target_long ofs);
+void gen_op_addr_add_tl(DisasContext *ctx, TCGv ret, TCGv arg0, TCGv arg1);
+void gen_op_addr_addi_tl(DisasContext *ctx, TCGv ret, TCGv base, target_long ofs);
 bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa);
 bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa);
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 667b20bccb8..ad688b9b23d 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1415,7 +1415,7 @@ int get_fp_bit(int cc)
 }
 
 /* Addresses computation */
-void gen_op_addr_add(DisasContext *ctx, TCGv ret, TCGv arg0, TCGv arg1)
+void gen_op_addr_add_tl(DisasContext *ctx, TCGv ret, TCGv arg0, TCGv arg1)
 {
     tcg_gen_add_tl(ret, arg0, arg1);
 
@@ -1426,7 +1426,7 @@ void gen_op_addr_add(DisasContext *ctx, TCGv ret, TCGv arg0, TCGv arg1)
 #endif
 }
 
-void gen_op_addr_addi(DisasContext *ctx, TCGv ret, TCGv base, target_long ofs)
+void gen_op_addr_addi_tl(DisasContext *ctx, TCGv ret, TCGv base, target_long ofs)
 {
     tcg_gen_addi_tl(ret, base, ofs);
 
@@ -1952,7 +1952,7 @@ void gen_base_offset_addr_tl(DisasContext *ctx, TCGv addr, int base, int offset)
         gen_load_gpr_tl(addr, base);
     } else {
         tcg_gen_movi_tl(addr, offset);
-        gen_op_addr_add(ctx, addr, cpu_gpr[base], addr);
+        gen_op_addr_add_tl(ctx, addr, cpu_gpr[base], addr);
     }
 }
 
@@ -2075,14 +2075,14 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_LDPC:
         t1 = tcg_constant_tl(pc_relative_pc(ctx));
-        gen_op_addr_add(ctx, t0, t0, t1);
+        gen_op_addr_add_tl(ctx, t0, t0, t1);
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_UQ);
         gen_store_gpr_tl(t0, rt);
         break;
 #endif
     case OPC_LWPC:
         t1 = tcg_constant_tl(pc_relative_pc(ctx));
-        gen_op_addr_add(ctx, t0, t0, t1);
+        gen_op_addr_add_tl(ctx, t0, t0, t1);
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_SL);
         gen_store_gpr_tl(t0, rt);
         break;
@@ -4135,7 +4135,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
     t0 = tcg_temp_new();
 
     gen_base_offset_addr_tl(ctx, t0, rs, offset);
-    gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
+    gen_op_addr_add_tl(ctx, t0, cpu_gpr[rd], t0);
 
     switch (opc) {
     case OPC_GSLBX:
@@ -4150,7 +4150,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
     case OPC_GSLWX:
         gen_base_offset_addr_tl(ctx, t0, rs, offset);
         if (rd) {
-            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
+            gen_op_addr_add_tl(ctx, t0, cpu_gpr[rd], t0);
         }
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
@@ -4160,7 +4160,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
     case OPC_GSLDX:
         gen_base_offset_addr_tl(ctx, t0, rs, offset);
         if (rd) {
-            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
+            gen_op_addr_add_tl(ctx, t0, cpu_gpr[rd], t0);
         }
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
@@ -4170,7 +4170,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
     case OPC_GSLWXC1:
         gen_base_offset_addr_tl(ctx, t0, rs, offset);
         if (rd) {
-            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
+            gen_op_addr_add_tl(ctx, t0, cpu_gpr[rd], t0);
         }
         fp0 = tcg_temp_new_i32();
         tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
@@ -4181,7 +4181,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
     case OPC_GSLDXC1:
         gen_base_offset_addr_tl(ctx, t0, rs, offset);
         if (rd) {
-            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
+            gen_op_addr_add_tl(ctx, t0, cpu_gpr[rd], t0);
         }
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
@@ -10550,7 +10550,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
     } else if (index == 0) {
         gen_load_gpr_tl(t0, base);
     } else {
-        gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[index]);
+        gen_op_addr_add_tl(ctx, t0, cpu_gpr[base], cpu_gpr[index]);
     }
     /*
      * Don't do NOP if destination is zero: we must perform the actual
@@ -11050,7 +11050,7 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
             TCGv tbase = tcg_temp_new();
 
             gen_load_gpr_tl(tbase, rt);
-            gen_op_addr_addi(ctx, btarget, tbase, offset);
+            gen_op_addr_addi_tl(ctx, btarget, tbase, offset);
         }
         break;
     default:
@@ -11253,7 +11253,7 @@ void gen_ldxs(DisasContext *ctx, int base, int index, int rd)
     if (index != 0) {
         gen_load_gpr_tl(t1, index);
         tcg_gen_shli_tl(t1, t1, 2);
-        gen_op_addr_add(ctx, t0, t1, t0);
+        gen_op_addr_add_tl(ctx, t0, t1, t0);
     }
 
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL);
@@ -11338,7 +11338,7 @@ static void gen_mips_lx(DisasContext *ctx, uint32_t opc,
     } else if (offset == 0) {
         gen_load_gpr_tl(t0, base);
     } else {
-        gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[offset]);
+        gen_op_addr_add_tl(ctx, t0, cpu_gpr[base], cpu_gpr[offset]);
     }
 
     switch (opc) {
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 69289bc13bb..fb7e6c8ddd9 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -980,7 +980,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr_tl(t1, rd);
-        gen_op_addr_addi(ctx, t0, t0, 4);
+        gen_op_addr_addi_tl(ctx, t0, t0, 4);
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr_tl(t1, rd + 1);
@@ -989,7 +989,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         gen_load_gpr_tl(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
-        gen_op_addr_addi(ctx, t0, t0, 4);
+        gen_op_addr_addi_tl(ctx, t0, t0, 4);
         gen_load_gpr_tl(t1, rd + 1);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
@@ -1003,7 +1003,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr_tl(t1, rd);
-        gen_op_addr_addi(ctx, t0, t0, 8);
+        gen_op_addr_addi_tl(ctx, t0, t0, 8);
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr_tl(t1, rd + 1);
@@ -1012,7 +1012,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         gen_load_gpr_tl(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        gen_op_addr_addi(ctx, t0, t0, 8);
+        gen_op_addr_addi_tl(ctx, t0, t0, 8);
         gen_load_gpr_tl(t1, rd + 1);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 754a5f7be4c..7af83e77280 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -131,7 +131,7 @@ static void decr_and_store(DisasContext *ctx, unsigned regidx, TCGv t0)
 {
     TCGv t1 = tcg_temp_new();
 
-    gen_op_addr_addi(ctx, t0, t0, -4);
+    gen_op_addr_addi_tl(ctx, t0, t0, -4);
     gen_load_gpr_tl(t1, regidx);
     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                        ctx->default_tcg_memop_mask);
@@ -283,7 +283,7 @@ static void gen_mips16_save(DisasContext *ctx,
         }
     }
 
-    gen_op_addr_addi(ctx, cpu_gpr[29], cpu_gpr[29], -framesize);
+    gen_op_addr_addi_tl(ctx, cpu_gpr[29], cpu_gpr[29], -framesize);
 }
 
 static void decr_and_load(DisasContext *ctx, unsigned regidx, TCGv t0)
@@ -292,7 +292,7 @@ static void decr_and_load(DisasContext *ctx, unsigned regidx, TCGv t0)
     TCGv t2 = tcg_temp_new();
 
     tcg_gen_movi_tl(t2, -4);
-    gen_op_addr_add(ctx, t0, t0, t2);
+    gen_op_addr_add_tl(ctx, t0, t0, t2);
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL |
                        ctx->default_tcg_memop_mask);
     gen_store_gpr_tl(t1, regidx);
@@ -306,7 +306,7 @@ static void gen_mips16_restore(DisasContext *ctx,
     int astatic;
     TCGv t0 = tcg_temp_new();
 
-    gen_op_addr_addi(ctx, t0, cpu_gpr[29], -framesize);
+    gen_op_addr_addi_tl(ctx, t0, cpu_gpr[29], -framesize);
 
     if (do_ra) {
         decr_and_load(ctx, 31, t0);
@@ -386,7 +386,7 @@ static void gen_mips16_restore(DisasContext *ctx,
         }
     }
 
-    gen_op_addr_addi(ctx, cpu_gpr[29], cpu_gpr[29], -framesize);
+    gen_op_addr_addi_tl(ctx, cpu_gpr[29], cpu_gpr[29], -framesize);
 }
 
 #if defined(TARGET_MIPS64)
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 950a4c23e70..2ad936c66d4 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -1058,7 +1058,7 @@ static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
 
 static void gen_adjust_sp(DisasContext *ctx, int u)
 {
-    gen_op_addr_addi(ctx, cpu_gpr[29], cpu_gpr[29], u);
+    gen_op_addr_addi_tl(ctx, cpu_gpr[29], cpu_gpr[29], u);
 }
 
 static void gen_save(DisasContext *ctx, uint8_t rt, uint8_t count,
@@ -2398,7 +2398,7 @@ static void gen_compute_nanomips_pbalrsc_branch(DisasContext *ctx, int rs,
 
     /* calculate btarget */
     tcg_gen_shli_tl(t0, t0, 1);
-    gen_op_addr_add(ctx, btarget, tcg_constant_tl(ctx->base.pc_next + 4), t0);
+    gen_op_addr_add_tl(ctx, btarget, tcg_constant_tl(ctx->base.pc_next + 4), t0);
 
     /* branch completion */
     clear_branch_hflags(ctx);
@@ -2453,7 +2453,7 @@ static void gen_compute_compact_branch_nm(DisasContext *ctx, uint32_t opc,
             TCGv tbase = tcg_temp_new();
 
             gen_load_gpr_tl(tbase, rt);
-            gen_op_addr_addi(ctx, btarget, tbase, offset);
+            gen_op_addr_addi_tl(ctx, btarget, tbase, offset);
         }
         break;
     default:
@@ -2617,7 +2617,7 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
             return;
         }
     }
-    gen_op_addr_add(ctx, t0, t0, t1);
+    gen_op_addr_add_tl(ctx, t0, t0, t1);
 
     switch (extract32(ctx->opcode, 7, 4)) {
     case NM_LBX:
@@ -3654,7 +3654,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         case NM_ADDIUGP_W:
             if (rt != 0) {
                 offset = extract32(ctx->opcode, 0, 21);
-                gen_op_addr_addi(ctx, cpu_gpr[rt], cpu_gpr[28], offset);
+                gen_op_addr_addi_tl(ctx, cpu_gpr[rt], cpu_gpr[28], offset);
             }
             break;
         case NM_LWGP:
@@ -3689,7 +3689,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             case NM_ADDIUGP48:
                 check_nms(ctx);
                 if (rt != 0) {
-                    gen_op_addr_addi(ctx, cpu_gpr[rt], cpu_gpr[28], addr_off);
+                    gen_op_addr_addi_tl(ctx, cpu_gpr[rt], cpu_gpr[28], addr_off);
                 }
                 break;
             case NM_ADDIUPC48:
@@ -3921,7 +3921,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 break;
             case NM_ADDIUGP_B:
                 if (rt != 0) {
-                    gen_op_addr_addi(ctx, cpu_gpr[rt], cpu_gpr[28], u);
+                    gen_op_addr_addi_tl(ctx, cpu_gpr[rt], cpu_gpr[28], u);
                 }
                 break;
             case NM_P_GP_LH:
-- 
2.45.2


