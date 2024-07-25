Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DAEC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Lp-0007wL-PX; Thu, 25 Jul 2024 19:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LW-0006F3-Rw; Thu, 25 Jul 2024 19:58:12 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LT-0001Vb-Ok; Thu, 25 Jul 2024 19:58:06 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so283976a12.2; 
 Thu, 25 Jul 2024 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951882; x=1722556682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksbtOr2fFR9ZvnrgX2otizuG+rARTiSjYmU8A5zEVWc=;
 b=aMrVr+Szg2TI5V4Yjt95pTVbPaqzAEyxUfLEEcnY8qWZknflfYoqkPcOd5Pe4vx8gz
 i+JBV8C5qcI1POcPIrheksFj6Ck8THjzdyIYp7GbLe6NVH9XjFaIelp2KG5LrLIiTswU
 ONknL/LeBLFxZH16cy0VypLvU4LNR1+aqt6EZLMheHsdanb93roP/zGaJYjjYksHInTk
 w8kxDrd9cVpIjmun4GV6bb2FaqkKWbQUwg8twWt+OdSxzJEIxw+ymmBBfHX+Db/e+upc
 L5uVf0A6R85tVVhDokK9IDla/r+LFmAUgfxCQFczpbyG5AvAiq2FvLiDoMbHYDlMEFpo
 uURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951882; x=1722556682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ksbtOr2fFR9ZvnrgX2otizuG+rARTiSjYmU8A5zEVWc=;
 b=iEHthHrZWVngneTXCuEbbw8acBoygmqEeMb0gX6/b+4S+uwHuFMy4ImOBlzcLLOm+k
 c+rI7ptyTTJLRVWxOMjTv3Kruhcl7BQYRT88Om4yJjx13pShX5mG7CdJ5RRc6Vwm394c
 IztOMw5CmbiSTzHJ08OXY2VIBoNC6e9sbrSUBGFmaT5VqML1GKXFuNhbBd2bWIq5s6ru
 L1adanCFLX5cSuWqW/cSnUUNjYqhqfJfgv/RIrfNh9wdedv9j3i3F9wtjXHhe6j82bUS
 LVasHaiWeJuBXhp1VFTP8TNwfTrWUoFfu4xtND/cvRfQmxm3xQo4jLBhgJfaAGGIsyau
 c2DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2hnpF3RsQyWnjR1xuonPYfMMGJy4qYuxfdFproydtHsiuZ8lUXD0Go4NIYRUFpTZnDuA8IjToL2t0uxYvmidnvo78
X-Gm-Message-State: AOJu0Yz7rAO9VnGw91LobbfMlKn61tUVc0IoRQViNh2MVOyVTp3e0MIF
 DHlbOqI/Jb1yoN/RCVT/cYlDrmNcpxJpDNbrW2j9DwhfmixtM60EjkMYlA==
X-Google-Smtp-Source: AGHT+IE7oMaBNE8FXpTmKLzVq15gqR0VhQXNK/wQujz/xmVrq4BKTtWcKAa55mRRkWmMM0VnUjVzPg==
X-Received: by 2002:a17:90b:4ec5:b0:2c8:647:1600 with SMTP id
 98e67ed59e1d1-2cf2e9ab28emr3652635a91.9.1721951881523; 
 Thu, 25 Jul 2024 16:58:01 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 60/96] target/ppc: Move VSX vector storage access insns to
 decodetree.
Date: Fri, 26 Jul 2024 09:53:33 +1000
Message-ID: <20240725235410.451624-61-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Moving the following instructions to decodetree specification:

  lxv{b16, d2, h8, w4, ds, ws}x   : X-form
  stxv{b16, d2, h8, w4}x          : X-form

The changes were verified by validating that the tcg-ops generated for those
instructions remain the same, which were captured using the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode            |  10 ++
 target/ppc/translate/vsx-impl.c.inc | 199 ++++++++++++----------------
 target/ppc/translate/vsx-ops.c.inc  |  12 --
 3 files changed, 97 insertions(+), 124 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index e87b034159..77869cfb33 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1006,9 +1006,19 @@ STXSIHX         011111 ..... ..... ..... 1110101101 .   @X_TSX
 STXSIWX         011111 ..... ..... ..... 0010001100 .   @X_TSX
 STXSSPX         011111 ..... ..... ..... 1010001100 .   @X_TSX
 
+LXVB16X         011111 ..... ..... ..... 1101101100 .   @X_TSX
+LXVD2X          011111 ..... ..... ..... 1101001100 .   @X_TSX
+LXVH8X          011111 ..... ..... ..... 1100101100 .   @X_TSX
+LXVW4X          011111 ..... ..... ..... 1100001100 .   @X_TSX
+LXVDSX          011111 ..... ..... ..... 0101001100 .   @X_TSX
+LXVWSX          011111 ..... ..... ..... 0101101100 .   @X_TSX
 LXVL            011111 ..... ..... ..... 0100001101 .   @X_TSX
 LXVLL           011111 ..... ..... ..... 0100101101 .   @X_TSX
 
+STXVB16X        011111 ..... ..... ..... 1111101100 .   @X_TSX
+STXVD2X         011111 ..... ..... ..... 1111001100 .   @X_TSX
+STXVH8X         011111 ..... ..... ..... 1110101100 .   @X_TSX
+STXVW4X         011111 ..... ..... ..... 1110001100 .   @X_TSX
 STXVL           011111 ..... ..... ..... 0110001101 .   @X_TSX
 STXVLL          011111 ..... ..... ..... 0110101101 .   @X_TSX
 
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 46bab49215..e0fb4bad92 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -46,41 +46,37 @@ TRANS_FLAGS2(ISA300, LXSIHZX, do_lxs, gen_qemu_ld16u_i64);
 TRANS_FLAGS2(VSX207, LXSIWZX, do_lxs, gen_qemu_ld32u_i64);
 TRANS_FLAGS2(VSX207, LXSSPX, do_lxs, gen_qemu_ld32fs);
 
-static void gen_lxvd2x(DisasContext *ctx)
+static bool trans_LXVD2X(DisasContext *ctx, arg_LXVD2X *a)
 {
     TCGv EA;
     TCGv_i64 t0;
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, VSX);
+
     t0 = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     gen_qemu_ld64_i64(ctx, t0, EA);
-    set_cpu_vsr(xT(ctx->opcode), t0, true);
+    set_cpu_vsr(a->rt, t0, true);
     tcg_gen_addi_tl(EA, EA, 8);
     gen_qemu_ld64_i64(ctx, t0, EA);
-    set_cpu_vsr(xT(ctx->opcode), t0, false);
+    set_cpu_vsr(a->rt, t0, false);
+    return true;
 }
 
-static void gen_lxvw4x(DisasContext *ctx)
+static bool trans_LXVW4X(DisasContext *ctx, arg_LXVW4X *a)
 {
     TCGv EA;
-    TCGv_i64 xth;
-    TCGv_i64 xtl;
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
+    TCGv_i64 xth, xtl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, VSX);
+
     xth = tcg_temp_new_i64();
     xtl = tcg_temp_new_i64();
-
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     if (ctx->le_mode) {
         TCGv_i64 t0 = tcg_temp_new_i64();
         TCGv_i64 t1 = tcg_temp_new_i64();
@@ -97,55 +93,45 @@ static void gen_lxvw4x(DisasContext *ctx)
         tcg_gen_addi_tl(EA, EA, 8);
         tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEUQ);
     }
-    set_cpu_vsr(xT(ctx->opcode), xth, true);
-    set_cpu_vsr(xT(ctx->opcode), xtl, false);
+    set_cpu_vsr(a->rt, xth, true);
+    set_cpu_vsr(a->rt, xtl, false);
+    return true;
 }
 
-static void gen_lxvwsx(DisasContext *ctx)
+static bool trans_LXVWSX(DisasContext *ctx, arg_LXVWSX *a)
 {
     TCGv EA;
     TCGv_i32 data;
 
-    if (xT(ctx->opcode) < 32) {
-        if (unlikely(!ctx->vsx_enabled)) {
-            gen_exception(ctx, POWERPC_EXCP_VSXU);
-            return;
-        }
+    if (a->rt < 32) {
+        REQUIRE_VSX(ctx);
     } else {
-        if (unlikely(!ctx->altivec_enabled)) {
-            gen_exception(ctx, POWERPC_EXCP_VPU);
-            return;
-        }
+        REQUIRE_VECTOR(ctx);
     }
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-
-    gen_addr_reg_index(ctx, EA);
-
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     data = tcg_temp_new_i32();
     tcg_gen_qemu_ld_i32(data, EA, ctx->mem_idx, DEF_MEMOP(MO_UL));
-    tcg_gen_gvec_dup_i32(MO_UL, vsr_full_offset(xT(ctx->opcode)), 16, 16, data);
+    tcg_gen_gvec_dup_i32(MO_UL, vsr_full_offset(a->rt), 16, 16, data);
+    return true;
 }
 
-static void gen_lxvdsx(DisasContext *ctx)
+static bool trans_LXVDSX(DisasContext *ctx, arg_LXVDSX *a)
 {
     TCGv EA;
     TCGv_i64 data;
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, VSX);
 
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-
-    gen_addr_reg_index(ctx, EA);
-
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     data = tcg_temp_new_i64();
     tcg_gen_qemu_ld_i64(data, EA, ctx->mem_idx, DEF_MEMOP(MO_UQ));
-    tcg_gen_gvec_dup_i64(MO_UQ, vsr_full_offset(xT(ctx->opcode)), 16, 16, data);
+    tcg_gen_gvec_dup_i64(MO_UQ, vsr_full_offset(a->rt), 16, 16, data);
+    return true;
 }
 
 static void gen_bswap16x8(TCGv_i64 outh, TCGv_i64 outl,
@@ -184,52 +170,47 @@ static void gen_bswap32x4(TCGv_i64 outh, TCGv_i64 outl,
     tcg_gen_deposit_i64(outl, outl, lo, 32, 32);
 }
 
-static void gen_lxvh8x(DisasContext *ctx)
+static bool trans_LXVH8X(DisasContext *ctx, arg_LXVH8X *a)
 {
     TCGv EA;
-    TCGv_i64 xth;
-    TCGv_i64 xtl;
+    TCGv_i64 xth, xtl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
     xth = tcg_temp_new_i64();
     xtl = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
-
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_qemu_ld_i64(xth, EA, ctx->mem_idx, MO_BEUQ);
     tcg_gen_addi_tl(EA, EA, 8);
     tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEUQ);
     if (ctx->le_mode) {
         gen_bswap16x8(xth, xtl, xth, xtl);
     }
-    set_cpu_vsr(xT(ctx->opcode), xth, true);
-    set_cpu_vsr(xT(ctx->opcode), xtl, false);
+    set_cpu_vsr(a->rt, xth, true);
+    set_cpu_vsr(a->rt, xtl, false);
+    return true;
 }
 
-static void gen_lxvb16x(DisasContext *ctx)
+static bool trans_LXVB16X(DisasContext *ctx, arg_LXVB16X *a)
 {
     TCGv EA;
-    TCGv_i64 xth;
-    TCGv_i64 xtl;
+    TCGv_i64 xth, xtl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
     xth = tcg_temp_new_i64();
     xtl = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_qemu_ld_i64(xth, EA, ctx->mem_idx, MO_BEUQ);
     tcg_gen_addi_tl(EA, EA, 8);
     tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEUQ);
-    set_cpu_vsr(xT(ctx->opcode), xth, true);
-    set_cpu_vsr(xT(ctx->opcode), xtl, false);
+    set_cpu_vsr(a->rt, xth, true);
+    set_cpu_vsr(a->rt, xtl, false);
+    return true;
 }
 
 #if defined(TARGET_PPC64)
@@ -319,42 +300,39 @@ TRANS_FLAGS2(ISA300, STXSIHX, do_stxs, gen_qemu_st16_i64);
 TRANS_FLAGS2(VSX207, STXSIWX, do_stxs, gen_qemu_st32_i64);
 TRANS_FLAGS2(VSX207, STXSSPX, do_stxs, gen_qemu_st32fs);
 
-static void gen_stxvd2x(DisasContext *ctx)
+static bool trans_STXVD2X(DisasContext *ctx, arg_STXVD2X *a)
 {
     TCGv EA;
     TCGv_i64 t0;
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, VSX);
+
     t0 = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
-    get_cpu_vsr(t0, xS(ctx->opcode), true);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    get_cpu_vsr(t0, a->rt, true);
     gen_qemu_st64_i64(ctx, t0, EA);
     tcg_gen_addi_tl(EA, EA, 8);
-    get_cpu_vsr(t0, xS(ctx->opcode), false);
+    get_cpu_vsr(t0, a->rt, false);
     gen_qemu_st64_i64(ctx, t0, EA);
+    return true;
 }
 
-static void gen_stxvw4x(DisasContext *ctx)
+static bool trans_STXVW4X(DisasContext *ctx, arg_STXVW4X *a)
 {
     TCGv EA;
-    TCGv_i64 xsh;
-    TCGv_i64 xsl;
+    TCGv_i64 xsh, xsl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, VSX);
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
     xsh = tcg_temp_new_i64();
     xsl = tcg_temp_new_i64();
-    get_cpu_vsr(xsh, xS(ctx->opcode), true);
-    get_cpu_vsr(xsl, xS(ctx->opcode), false);
+    get_cpu_vsr(xsh, a->rt, true);
+    get_cpu_vsr(xsl, a->rt, false);
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     if (ctx->le_mode) {
         TCGv_i64 t0 = tcg_temp_new_i64();
         TCGv_i64 t1 = tcg_temp_new_i64();
@@ -371,25 +349,23 @@ static void gen_stxvw4x(DisasContext *ctx)
         tcg_gen_addi_tl(EA, EA, 8);
         tcg_gen_qemu_st_i64(xsl, EA, ctx->mem_idx, MO_BEUQ);
     }
+    return true;
 }
 
-static void gen_stxvh8x(DisasContext *ctx)
+static bool trans_STXVH8X(DisasContext *ctx, arg_STXVH8X *a)
 {
     TCGv EA;
-    TCGv_i64 xsh;
-    TCGv_i64 xsl;
+    TCGv_i64 xsh, xsl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
     xsh = tcg_temp_new_i64();
     xsl = tcg_temp_new_i64();
-    get_cpu_vsr(xsh, xS(ctx->opcode), true);
-    get_cpu_vsr(xsl, xS(ctx->opcode), false);
+    get_cpu_vsr(xsh, a->rt, true);
+    get_cpu_vsr(xsl, a->rt, false);
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     if (ctx->le_mode) {
         TCGv_i64 outh = tcg_temp_new_i64();
         TCGv_i64 outl = tcg_temp_new_i64();
@@ -403,28 +379,27 @@ static void gen_stxvh8x(DisasContext *ctx)
         tcg_gen_addi_tl(EA, EA, 8);
         tcg_gen_qemu_st_i64(xsl, EA, ctx->mem_idx, MO_BEUQ);
     }
+    return true;
 }
 
-static void gen_stxvb16x(DisasContext *ctx)
+static bool trans_STXVB16X(DisasContext *ctx, arg_STXVB16X *a)
 {
     TCGv EA;
-    TCGv_i64 xsh;
-    TCGv_i64 xsl;
+    TCGv_i64 xsh, xsl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
     xsh = tcg_temp_new_i64();
     xsl = tcg_temp_new_i64();
-    get_cpu_vsr(xsh, xS(ctx->opcode), true);
-    get_cpu_vsr(xsl, xS(ctx->opcode), false);
+    get_cpu_vsr(xsh, a->rt, true);
+    get_cpu_vsr(xsl, a->rt, false);
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_qemu_st_i64(xsh, EA, ctx->mem_idx, MO_BEUQ);
     tcg_gen_addi_tl(EA, EA, 8);
     tcg_gen_qemu_st_i64(xsl, EA, ctx->mem_idx, MO_BEUQ);
+    return true;
 }
 
 static void gen_mfvsrwz(DisasContext *ctx)
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index 7f4326c974..91cde088bc 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -1,15 +1,3 @@
-GEN_HANDLER_E(lxvd2x, 0x1F, 0x0C, 0x1A, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(lxvwsx, 0x1F, 0x0C, 0x0B, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(lxvdsx, 0x1F, 0x0C, 0x0A, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(lxvw4x, 0x1F, 0x0C, 0x18, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(lxvh8x, 0x1F, 0x0C, 0x19, 0, PPC_NONE,  PPC2_ISA300),
-GEN_HANDLER_E(lxvb16x, 0x1F, 0x0C, 0x1B, 0, PPC_NONE, PPC2_ISA300),
-
-GEN_HANDLER_E(stxvd2x, 0x1F, 0xC, 0x1E, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(stxvw4x, 0x1F, 0xC, 0x1C, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(stxvh8x, 0x1F, 0x0C, 0x1D, 0, PPC_NONE,  PPC2_ISA300),
-GEN_HANDLER_E(stxvb16x, 0x1F, 0x0C, 0x1F, 0, PPC_NONE, PPC2_ISA300),
-
 GEN_HANDLER_E(mfvsrwz, 0x1F, 0x13, 0x03, 0x0000F800, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(mtvsrwa, 0x1F, 0x13, 0x06, 0x0000F800, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(mtvsrwz, 0x1F, 0x13, 0x07, 0x0000F800, PPC_NONE, PPC2_VSX207),
-- 
2.45.2


