Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493D9C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYd-0008GH-IT; Thu, 23 May 2024 19:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYV-0007mK-Ry; Thu, 23 May 2024 19:09:04 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYR-0005k6-29; Thu, 23 May 2024 19:09:02 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2bf59b781d6so324707a91.0; 
 Thu, 23 May 2024 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505736; x=1717110536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7fZq26l6pjkQ7IRyCpAZUv1ZJG9ZbGqdimGa0p3/Zk=;
 b=GQEE/7TARL4XKKSkwsvO5WaIIM50LrisgOmhhA36S1fFQRXViZcVvRC8D+FIHxWOlU
 0brwUC26z2frHciKL+wF37F7nhOqrh/N6sNrqooCs6Xjcbox8y2YaA8Q365DsbZB1m+N
 5IvjENxsBnTAvGMc+4gRaooLOa3/fKEZwp42PMCov7vXPDtlFN/knBxP8w2mLb1tjM/C
 6tGmKDYlXMpDKA1zQsU9vFDLZuD8ABuaUXemAou6Ibw3Gg/7Sco53eU7XKCaJq/cOyGz
 oG95YFTXxN4V1nYLWkmN26btpLRNrpkEFZ1eB9faEzqSeB8nIBDv3bCWxVgIVweLUxB5
 FZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505736; x=1717110536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7fZq26l6pjkQ7IRyCpAZUv1ZJG9ZbGqdimGa0p3/Zk=;
 b=xC9U0o+1QF43NcM+mdhuMumUSHyh1GPV+sSthgDvHWpu8Uz/7rxjiRls/bMwvs7YkO
 S8Xy4SbFp5CIrOIjLK/CEhJf1y4NSGy9IyfzUByOkZnLLIpUAq+BMIXB4oH5ZciGg5Kq
 ZIu5lrTurUPZcD9bd8SFvkCaPwzvrD4mSy9iR3fASY/no7+l5cZHUBV0DHV2BNPDjRbN
 8v7cAvannQtshkuAbaENEwK91jcZXIOF9cLJNDZrBDjSpeKytX3z3+G1md94sQkreQm2
 Hhg2tNwfRDaxkUXpTDehVUPxaQqP76S/mdQv9dCoA2JNU9z3mYny97OWR+omcWnGMFrk
 iAhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4102cNZbM+N9exsVP2dfBcEPC4y3bO2Or0SduA+Q6AlXcxQinYu3odaMwPZDrp/CaPaQy0Sd7ogo88Qf2a52bJdnp
X-Gm-Message-State: AOJu0YwtyC9DjdIurPmsNwf03XkoQh7sy+KHimgSZvGwZEWaVLBwIRcy
 /jG2roKIbMib2LsUSV482QTWKawV7DzlMCgkrdwvGlTP71LDMOjQ0JfcYQ==
X-Google-Smtp-Source: AGHT+IGvMCmbpifOAK0XlOAdVIUamw/TuU7x5fS/4yUlU9we72Rgx1rYmkBXScul3E2hSXdj/Rfv2g==
X-Received: by 2002:a17:90a:ba91:b0:2bf:5bb0:1625 with SMTP id
 98e67ed59e1d1-2bf5ee16fc3mr664063a91.34.1716505735424; 
 Thu, 23 May 2024 16:08:55 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/72] target/ppc: Move logical fixed-point instructions to
 decodetree.
Date: Fri, 24 May 2024 09:06:51 +1000
Message-ID: <20240523230747.45703-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
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

Moving the below instructions to decodetree specification :

	andi[s]., {ori, xori}[s]			: D-form

	{and, andc, nand, or, orc, nor, xor, eqv}[.],
	exts{b, h, w}[.],  cnt{l, t}z{w, d}[.],
	popcnt{b, w, d},  prty{w, d}, cmp, bpermd	: X-form

With this patch, all the fixed-point logical instructions have been
moved to decodetree.
The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
[np: 32-bit compile fix]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h                        |   8 +-
 target/ppc/insn32.decode                   |  38 +++
 target/ppc/int_helper.c                    |  10 +-
 target/ppc/translate.c                     | 359 ---------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 300 +++++++++++++++++
 5 files changed, 347 insertions(+), 368 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index b8af2cf878..4267917615 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -58,8 +58,8 @@ DEF_HELPER_4(DIVDE, i64, env, i64, i64, i32)
 DEF_HELPER_4(DIVWEU, tl, env, tl, tl, i32)
 DEF_HELPER_4(DIVWE, tl, env, tl, tl, i32)
 
-DEF_HELPER_FLAGS_1(popcntb, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_2(cmpb, TCG_CALL_NO_RWG_SE, tl, tl, tl)
+DEF_HELPER_FLAGS_1(POPCNTB, TCG_CALL_NO_RWG_SE, tl, tl)
+DEF_HELPER_FLAGS_2(CMPB, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 DEF_HELPER_3(sraw, tl, env, tl, tl)
 DEF_HELPER_FLAGS_2(CFUGED, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(PDEPD, TCG_CALL_NO_RWG_SE, i64, i64, i64)
@@ -68,8 +68,8 @@ DEF_HELPER_FLAGS_1(CDTBCD, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(CBCDTD, TCG_CALL_NO_RWG_SE, tl, tl)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_2(CMPEQB, TCG_CALL_NO_RWG_SE, i32, tl, tl)
-DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_2(bpermd, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_1(POPCNTW, TCG_CALL_NO_RWG_SE, tl, tl)
+DEF_HELPER_FLAGS_2(BPERMD, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_3(srad, tl, env, tl, tl)
 DEF_HELPER_FLAGS_0(DARN32, TCG_CALL_NO_RWG, tl)
 DEF_HELPER_FLAGS_0(DARN64, TCG_CALL_NO_RWG, tl)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index cb1e4bd307..dc62bc90aa 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -35,6 +35,9 @@
 &D              rt ra si:int64_t
 @D              ...... rt:5 ra:5 si:s16                         &D
 
+&D_ui           rt ra ui:uint64_t
+@D_ui           ...... rt:5 ra:5 ui:16                         &D_ui
+
 &D_bf           bf l:bool ra imm
 @D_bfs          ...... bf:3 . l:1 ra:5 imm:s16                  &D_bf
 @D_bfu          ...... bf:3 . l:1 ra:5 imm:16                   &D_bf
@@ -102,6 +105,9 @@
 &X_sa           rs ra
 @X_sa           ...... rs:5 ra:5 ..... .......... .             &X_sa
 
+&X_sa_rc        rs ra rc
+@X_sa_rc        ...... rs:5 ra:5 ..... .......... rc:1          &X_sa_rc
+
 %x_frtp         22:4 !function=times_2
 %x_frap         17:4 !function=times_2
 %x_frbp         12:4 !function=times_2
@@ -419,6 +425,38 @@ MODUD           011111 ..... ..... ..... 0100001001 -   @X
 
 ## Fixed-Point Logical Instructions
 
+ANDI_           011100 ..... ..... ................     @D_ui
+ANDIS_          011101 ..... ..... ................     @D_ui
+ORI             011000 ..... ..... ................     @D_ui
+ORIS            011001 ..... ..... ................     @D_ui
+XORI            011010 ..... ..... ................     @D_ui
+XORIS           011011 ..... ..... ................     @D_ui
+
+AND             011111 ..... ..... ..... 0000011100 .   @X_rc
+ANDC            011111 ..... ..... ..... 0000111100 .   @X_rc
+NAND            011111 ..... ..... ..... 0111011100 .   @X_rc
+OR              011111 ..... ..... ..... 0110111100 .   @X_rc
+ORC             011111 ..... ..... ..... 0110011100 .   @X_rc
+NOR             011111 ..... ..... ..... 0001111100 .   @X_rc
+XOR             011111 ..... ..... ..... 0100111100 .   @X_rc
+EQV             011111 ..... ..... ..... 0100011100 .   @X_rc
+CMPB            011111 ..... ..... ..... 0111111100 .   @X_rc
+
+EXTSB           011111 ..... ..... ----- 1110111010 .   @X_sa_rc
+EXTSH           011111 ..... ..... ----- 1110011010 .   @X_sa_rc
+EXTSW           011111 ..... ..... ----- 1111011010 .   @X_sa_rc
+CNTLZW          011111 ..... ..... ----- 0000011010 .   @X_sa_rc
+CNTTZW          011111 ..... ..... ----- 1000011010 .   @X_sa_rc
+CNTLZD          011111 ..... ..... ----- 0000111010 .   @X_sa_rc
+CNTTZD          011111 ..... ..... ----- 1000111010 .   @X_sa_rc
+POPCNTB         011111 ..... ..... ----- 0001111010 .   @X_sa_rc
+
+POPCNTW         011111 ..... ..... ----- 0101111010 -   @X_sa
+POPCNTD         011111 ..... ..... ----- 0111111010 -   @X_sa
+PRTYW           011111 ..... ..... ----- 0010011010 -   @X_sa
+PRTYD           011111 ..... ..... ----- 0010111010 -   @X_sa
+
+BPERMD          011111 ..... ..... ..... 0011111100 -   @X
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
 CNTLZDM         011111 ..... ..... ..... 0000111011 -   @X
 CNTTZDM         011111 ..... ..... ..... 1000111011 -   @X
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index d12dcc28e1..2c6b633d65 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -201,7 +201,7 @@ uint64_t helper_DARN64(void)
     return ret;
 }
 
-uint64_t helper_bpermd(uint64_t rs, uint64_t rb)
+uint64_t helper_BPERMD(uint64_t rs, uint64_t rb)
 {
     int i;
     uint64_t ra = 0;
@@ -219,7 +219,7 @@ uint64_t helper_bpermd(uint64_t rs, uint64_t rb)
 
 #endif
 
-target_ulong helper_cmpb(target_ulong rs, target_ulong rb)
+target_ulong helper_CMPB(target_ulong rs, target_ulong rb)
 {
     target_ulong mask = 0xff;
     target_ulong ra = 0;
@@ -288,7 +288,7 @@ target_ulong helper_srad(CPUPPCState *env, target_ulong value,
 #endif
 
 #if defined(TARGET_PPC64)
-target_ulong helper_popcntb(target_ulong val)
+target_ulong helper_POPCNTB(target_ulong val)
 {
     /* Note that we don't fold past bytes */
     val = (val & 0x5555555555555555ULL) + ((val >>  1) &
@@ -300,7 +300,7 @@ target_ulong helper_popcntb(target_ulong val)
     return val;
 }
 
-target_ulong helper_popcntw(target_ulong val)
+target_ulong helper_POPCNTW(target_ulong val)
 {
     /* Note that we don't fold past words.  */
     val = (val & 0x5555555555555555ULL) + ((val >>  1) &
@@ -316,7 +316,7 @@ target_ulong helper_popcntw(target_ulong val)
     return val;
 }
 #else
-target_ulong helper_popcntb(target_ulong val)
+target_ulong helper_POPCNTB(target_ulong val)
 {
     /* Note that we don't fold past bytes */
     val = (val & 0x55555555) + ((val >>  1) & 0x55555555);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e1ccb82f10..2cfa7d37ee 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1563,13 +1563,6 @@ static inline void gen_set_Rc0(DisasContext *ctx, TCGv reg)
     }
 }
 
-/* cmpb: PowerPC 2.05 specification */
-static void gen_cmpb(DisasContext *ctx)
-{
-    gen_helper_cmpb(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],
-                    cpu_gpr[rB(ctx->opcode)]);
-}
-
 /***                           Integer arithmetic                          ***/
 
 static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
@@ -1888,82 +1881,6 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
 }
 
 /***                            Integer logical                            ***/
-#define GEN_LOGICAL2(name, tcg_op, opc, type)                                 \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    tcg_op(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],                \
-       cpu_gpr[rB(ctx->opcode)]);                                             \
-    if (unlikely(Rc(ctx->opcode) != 0))                                       \
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);                           \
-}
-
-#define GEN_LOGICAL1(name, tcg_op, opc, type)                                 \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    tcg_op(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);               \
-    if (unlikely(Rc(ctx->opcode) != 0))                                       \
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);                           \
-}
-
-/* and & and. */
-GEN_LOGICAL2(and, tcg_gen_and_tl, 0x00, PPC_INTEGER);
-/* andc & andc. */
-GEN_LOGICAL2(andc, tcg_gen_andc_tl, 0x01, PPC_INTEGER);
-
-/* andi. */
-static void gen_andi_(DisasContext *ctx)
-{
-    tcg_gen_andi_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],
-                    UIMM(ctx->opcode));
-    gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-}
-
-/* andis. */
-static void gen_andis_(DisasContext *ctx)
-{
-    tcg_gen_andi_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],
-                    UIMM(ctx->opcode) << 16);
-    gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-}
-
-/* cntlzw */
-static void gen_cntlzw(DisasContext *ctx)
-{
-    TCGv_i32 t = tcg_temp_new_i32();
-
-    tcg_gen_trunc_tl_i32(t, cpu_gpr[rS(ctx->opcode)]);
-    tcg_gen_clzi_i32(t, t, 32);
-    tcg_gen_extu_i32_tl(cpu_gpr[rA(ctx->opcode)], t);
-
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
-
-/* cnttzw */
-static void gen_cnttzw(DisasContext *ctx)
-{
-    TCGv_i32 t = tcg_temp_new_i32();
-
-    tcg_gen_trunc_tl_i32(t, cpu_gpr[rS(ctx->opcode)]);
-    tcg_gen_ctzi_i32(t, t, 32);
-    tcg_gen_extu_i32_tl(cpu_gpr[rA(ctx->opcode)], t);
-
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
-
-/* eqv & eqv. */
-GEN_LOGICAL2(eqv, tcg_gen_eqv_tl, 0x08, PPC_INTEGER);
-/* extsb & extsb. */
-GEN_LOGICAL1(extsb, tcg_gen_ext8s_tl, 0x1D, PPC_INTEGER);
-/* extsh & extsh. */
-GEN_LOGICAL1(extsh, tcg_gen_ext16s_tl, 0x1C, PPC_INTEGER);
-/* nand & nand. */
-GEN_LOGICAL2(nand, tcg_gen_nand_tl, 0x0E, PPC_INTEGER);
-/* nor & nor. */
-GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER);
 
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 static void gen_pause(DisasContext *ctx)
@@ -1977,243 +1894,6 @@ static void gen_pause(DisasContext *ctx)
 }
 #endif /* defined(TARGET_PPC64) */
 
-/* or & or. */
-static void gen_or(DisasContext *ctx)
-{
-    int rs, ra, rb;
-
-    rs = rS(ctx->opcode);
-    ra = rA(ctx->opcode);
-    rb = rB(ctx->opcode);
-    /* Optimisation for mr. ri case */
-    if (rs != ra || rs != rb) {
-        if (rs != rb) {
-            tcg_gen_or_tl(cpu_gpr[ra], cpu_gpr[rs], cpu_gpr[rb]);
-        } else {
-            tcg_gen_mov_tl(cpu_gpr[ra], cpu_gpr[rs]);
-        }
-        if (unlikely(Rc(ctx->opcode) != 0)) {
-            gen_set_Rc0(ctx, cpu_gpr[ra]);
-        }
-    } else if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rs]);
-#if defined(TARGET_PPC64)
-    } else if (rs != 0) { /* 0 is nop */
-        int prio = 0;
-
-        switch (rs) {
-        case 1:
-            /* Set process priority to low */
-            prio = 2;
-            break;
-        case 6:
-            /* Set process priority to medium-low */
-            prio = 3;
-            break;
-        case 2:
-            /* Set process priority to normal */
-            prio = 4;
-            break;
-#if !defined(CONFIG_USER_ONLY)
-        case 31:
-            if (!ctx->pr) {
-                /* Set process priority to very low */
-                prio = 1;
-            }
-            break;
-        case 5:
-            if (!ctx->pr) {
-                /* Set process priority to medium-hight */
-                prio = 5;
-            }
-            break;
-        case 3:
-            if (!ctx->pr) {
-                /* Set process priority to high */
-                prio = 6;
-            }
-            break;
-        case 7:
-            if (ctx->hv && !ctx->pr) {
-                /* Set process priority to very high */
-                prio = 7;
-            }
-            break;
-#endif
-        default:
-            break;
-        }
-        if (prio) {
-            TCGv t0 = tcg_temp_new();
-            gen_load_spr(t0, SPR_PPR);
-            tcg_gen_andi_tl(t0, t0, ~0x001C000000000000ULL);
-            tcg_gen_ori_tl(t0, t0, ((uint64_t)prio) << 50);
-            gen_store_spr(SPR_PPR, t0);
-        }
-#if !defined(CONFIG_USER_ONLY)
-        /*
-         * Pause out of TCG otherwise spin loops with smt_low eat too
-         * much CPU and the kernel hangs.  This applies to all
-         * encodings other than no-op, e.g., miso(rs=26), yield(27),
-         * mdoio(29), mdoom(30), and all currently undefined.
-         */
-        gen_pause(ctx);
-#endif
-#endif
-    }
-}
-/* orc & orc. */
-GEN_LOGICAL2(orc, tcg_gen_orc_tl, 0x0C, PPC_INTEGER);
-
-/* xor & xor. */
-static void gen_xor(DisasContext *ctx)
-{
-    /* Optimisation for "set to zero" case */
-    if (rS(ctx->opcode) != rB(ctx->opcode)) {
-        tcg_gen_xor_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],
-                       cpu_gpr[rB(ctx->opcode)]);
-    } else {
-        tcg_gen_movi_tl(cpu_gpr[rA(ctx->opcode)], 0);
-    }
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
-
-/* ori */
-static void gen_ori(DisasContext *ctx)
-{
-    target_ulong uimm = UIMM(ctx->opcode);
-
-    if (rS(ctx->opcode) == rA(ctx->opcode) && uimm == 0) {
-        return;
-    }
-    tcg_gen_ori_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], uimm);
-}
-
-/* oris */
-static void gen_oris(DisasContext *ctx)
-{
-    target_ulong uimm = UIMM(ctx->opcode);
-
-    if (rS(ctx->opcode) == rA(ctx->opcode) && uimm == 0) {
-        /* NOP */
-        return;
-    }
-    tcg_gen_ori_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],
-                   uimm << 16);
-}
-
-/* xori */
-static void gen_xori(DisasContext *ctx)
-{
-    target_ulong uimm = UIMM(ctx->opcode);
-
-    if (rS(ctx->opcode) == rA(ctx->opcode) && uimm == 0) {
-        /* NOP */
-        return;
-    }
-    tcg_gen_xori_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], uimm);
-}
-
-/* xoris */
-static void gen_xoris(DisasContext *ctx)
-{
-    target_ulong uimm = UIMM(ctx->opcode);
-
-    if (rS(ctx->opcode) == rA(ctx->opcode) && uimm == 0) {
-        /* NOP */
-        return;
-    }
-    tcg_gen_xori_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],
-                    uimm << 16);
-}
-
-/* popcntb : PowerPC 2.03 specification */
-static void gen_popcntb(DisasContext *ctx)
-{
-    gen_helper_popcntb(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
-}
-
-static void gen_popcntw(DisasContext *ctx)
-{
-#if defined(TARGET_PPC64)
-    gen_helper_popcntw(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
-#else
-    tcg_gen_ctpop_i32(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
-#endif
-}
-
-#if defined(TARGET_PPC64)
-/* popcntd: PowerPC 2.06 specification */
-static void gen_popcntd(DisasContext *ctx)
-{
-    tcg_gen_ctpop_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
-}
-#endif
-
-/* prtyw: PowerPC 2.05 specification */
-static void gen_prtyw(DisasContext *ctx)
-{
-    TCGv ra = cpu_gpr[rA(ctx->opcode)];
-    TCGv rs = cpu_gpr[rS(ctx->opcode)];
-    TCGv t0 = tcg_temp_new();
-    tcg_gen_shri_tl(t0, rs, 16);
-    tcg_gen_xor_tl(ra, rs, t0);
-    tcg_gen_shri_tl(t0, ra, 8);
-    tcg_gen_xor_tl(ra, ra, t0);
-    tcg_gen_andi_tl(ra, ra, (target_ulong)0x100000001ULL);
-}
-
-#if defined(TARGET_PPC64)
-/* prtyd: PowerPC 2.05 specification */
-static void gen_prtyd(DisasContext *ctx)
-{
-    TCGv ra = cpu_gpr[rA(ctx->opcode)];
-    TCGv rs = cpu_gpr[rS(ctx->opcode)];
-    TCGv t0 = tcg_temp_new();
-    tcg_gen_shri_tl(t0, rs, 32);
-    tcg_gen_xor_tl(ra, rs, t0);
-    tcg_gen_shri_tl(t0, ra, 16);
-    tcg_gen_xor_tl(ra, ra, t0);
-    tcg_gen_shri_tl(t0, ra, 8);
-    tcg_gen_xor_tl(ra, ra, t0);
-    tcg_gen_andi_tl(ra, ra, 1);
-}
-#endif
-
-#if defined(TARGET_PPC64)
-/* bpermd */
-static void gen_bpermd(DisasContext *ctx)
-{
-    gen_helper_bpermd(cpu_gpr[rA(ctx->opcode)],
-                      cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
-}
-#endif
-
-#if defined(TARGET_PPC64)
-/* extsw & extsw. */
-GEN_LOGICAL1(extsw, tcg_gen_ext32s_tl, 0x1E, PPC_64B);
-
-/* cntlzd */
-static void gen_cntlzd(DisasContext *ctx)
-{
-    tcg_gen_clzi_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], 64);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
-
-/* cnttzd */
-static void gen_cnttzd(DisasContext *ctx)
-{
-    tcg_gen_ctzi_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], 64);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
-#endif
-
 /***                             Integer rotate                            ***/
 
 /* rlwimi & rlwimi. */
@@ -5942,30 +5622,9 @@ GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
 GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
 #endif
 GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
-GEN_HANDLER_E(cmpb, 0x1F, 0x1C, 0x0F, 0x00000001, PPC_NONE, PPC2_ISA205),
-GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
-GEN_HANDLER_E(cnttzw, 0x1F, 0x1A, 0x10, 0x00000000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(copy, 0x1F, 0x06, 0x18, 0x03C00001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER(or, 0x1F, 0x1C, 0x0D, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(xor, 0x1F, 0x1C, 0x09, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(ori, 0x18, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(oris, 0x19, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(xori, 0x1A, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(xoris, 0x1B, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(popcntb, 0x1F, 0x1A, 0x03, 0x0000F801, PPC_POPCNTB),
-GEN_HANDLER(popcntw, 0x1F, 0x1A, 0x0b, 0x0000F801, PPC_POPCNTWD),
-GEN_HANDLER_E(prtyw, 0x1F, 0x1A, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA205),
-#if defined(TARGET_PPC64)
-GEN_HANDLER(popcntd, 0x1F, 0x1A, 0x0F, 0x0000F801, PPC_POPCNTWD),
-GEN_HANDLER(cntlzd, 0x1F, 0x1A, 0x01, 0x00000000, PPC_64B),
-GEN_HANDLER_E(cnttzd, 0x1F, 0x1A, 0x11, 0x00000000, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(prtyd, 0x1F, 0x1A, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA205),
-GEN_HANDLER_E(bpermd, 0x1F, 0x1C, 0x07, 0x00000001, PPC_NONE, PPC2_PERM_ISA206),
-#endif
 GEN_HANDLER(rlwimi, 0x14, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(rlwinm, 0x15, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
@@ -6136,24 +5795,6 @@ GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
 GEN_HANDLER(mtvscr, 0x04, 0x2, 0x19, 0x03ff0000, PPC_ALTIVEC),
 
-#undef GEN_LOGICAL1
-#undef GEN_LOGICAL2
-#define GEN_LOGICAL2(name, tcg_op, opc, type)                                 \
-GEN_HANDLER(name, 0x1F, 0x1C, opc, 0x00000000, type)
-#define GEN_LOGICAL1(name, tcg_op, opc, type)                                 \
-GEN_HANDLER(name, 0x1F, 0x1A, opc, 0x00000000, type)
-GEN_LOGICAL2(and, tcg_gen_and_tl, 0x00, PPC_INTEGER),
-GEN_LOGICAL2(andc, tcg_gen_andc_tl, 0x01, PPC_INTEGER),
-GEN_LOGICAL2(eqv, tcg_gen_eqv_tl, 0x08, PPC_INTEGER),
-GEN_LOGICAL1(extsb, tcg_gen_ext8s_tl, 0x1D, PPC_INTEGER),
-GEN_LOGICAL1(extsh, tcg_gen_ext16s_tl, 0x1C, PPC_INTEGER),
-GEN_LOGICAL2(nand, tcg_gen_nand_tl, 0x0E, PPC_INTEGER),
-GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER),
-GEN_LOGICAL2(orc, tcg_gen_orc_tl, 0x0C, PPC_INTEGER),
-#if defined(TARGET_PPC64)
-GEN_LOGICAL1(extsw, tcg_gen_ext32s_tl, 0x1E, PPC_64B),
-#endif
-
 #if defined(TARGET_PPC64)
 #undef GEN_PPC64_R2
 #undef GEN_PPC64_R4
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 872fed664d..fa0191e866 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -856,6 +856,285 @@ TRANS(SETBCR, do_set_bool_cond, false, true)
 TRANS(SETNBC, do_set_bool_cond, true, false)
 TRANS(SETNBCR, do_set_bool_cond, true, true)
 
+/*
+ * Fixed-Point Logical Instructions
+ */
+
+static bool do_addi_(DisasContext *ctx, arg_D_ui *a, bool shift)
+{
+    tcg_gen_andi_tl(cpu_gpr[a->ra], cpu_gpr[a->rt], shift ? a->ui << 16 : a->ui);
+    gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    return true;
+}
+
+static bool do_ori(DisasContext *ctx, arg_D_ui *a, bool shift)
+{
+    if (a->rt == a->ra && a->ui == 0) {
+        /* NOP */
+        return true;
+    }
+    tcg_gen_ori_tl(cpu_gpr[a->ra], cpu_gpr[a->rt], shift ? a->ui << 16 : a->ui);
+    return true;
+}
+
+static bool do_xori(DisasContext *ctx, arg_D_ui *a, bool shift)
+{
+    if (a->rt == a->ra && a->ui == 0) {
+        /* NOP */
+        return true;
+    }
+    tcg_gen_xori_tl(cpu_gpr[a->ra], cpu_gpr[a->rt], shift ? a->ui << 16 : a->ui);
+    return true;
+}
+
+static bool do_logical1(DisasContext *ctx, arg_X_sa_rc *a,
+                        void (*helper)(TCGv, TCGv))
+{
+    helper(cpu_gpr[a->ra], cpu_gpr[a->rs]);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
+
+static bool do_logical2(DisasContext *ctx, arg_X_rc *a,
+                        void (*helper)(TCGv, TCGv, TCGv))
+{
+    helper(cpu_gpr[a->ra], cpu_gpr[a->rt], cpu_gpr[a->rb]);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
+
+static bool trans_OR(DisasContext *ctx, arg_OR *a)
+{
+    /* Optimisation for mr. ri case */
+    if (a->rt != a->ra || a->rt != a->rb) {
+        if (a->rt != a->rb) {
+            tcg_gen_or_tl(cpu_gpr[a->ra], cpu_gpr[a->rt], cpu_gpr[a->rb]);
+        } else {
+            tcg_gen_mov_tl(cpu_gpr[a->ra], cpu_gpr[a->rt]);
+        }
+        if (unlikely(a->rc)) {
+            gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+        }
+    } else if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+#if defined(TARGET_PPC64)
+    } else if (a->rt != 0) { /* 0 is nop */
+        int prio = 0;
+
+        switch (a->rt) {
+        case 1:
+            /* Set process priority to low */
+            prio = 2;
+            break;
+        case 6:
+            /* Set process priority to medium-low */
+            prio = 3;
+            break;
+        case 2:
+            /* Set process priority to normal */
+            prio = 4;
+            break;
+#if !defined(CONFIG_USER_ONLY)
+        case 31:
+            if (!ctx->pr) {
+                /* Set process priority to very low */
+                prio = 1;
+            }
+            break;
+        case 5:
+            if (!ctx->pr) {
+                /* Set process priority to medium-hight */
+                prio = 5;
+            }
+            break;
+        case 3:
+            if (!ctx->pr) {
+                /* Set process priority to high */
+                prio = 6;
+            }
+            break;
+        case 7:
+            if (ctx->hv && !ctx->pr) {
+                /* Set process priority to very high */
+                prio = 7;
+            }
+            break;
+#endif
+        default:
+            break;
+        }
+        if (prio) {
+            TCGv t0 = tcg_temp_new();
+            gen_load_spr(t0, SPR_PPR);
+            tcg_gen_andi_tl(t0, t0, ~0x001C000000000000ULL);
+            tcg_gen_ori_tl(t0, t0, ((uint64_t)prio) << 50);
+            gen_store_spr(SPR_PPR, t0);
+        }
+#if !defined(CONFIG_USER_ONLY)
+        /*
+         * Pause out of TCG otherwise spin loops with smt_low eat too
+         * much CPU and the kernel hangs.  This applies to all
+         * encodings other than no-op, e.g., miso(rs=26), yield(27),
+         * mdoio(29), mdoom(30), and all currently undefined.
+         */
+        gen_pause(ctx);
+#endif
+#endif
+    }
+
+    return true;
+}
+
+static bool trans_XOR(DisasContext *ctx, arg_XOR *a)
+{
+    /* Optimisation for "set to zero" case */
+    if (a->rt != a->rb) {
+        tcg_gen_xor_tl(cpu_gpr[a->ra], cpu_gpr[a->rt], cpu_gpr[a->rb]);
+    } else {
+        tcg_gen_movi_tl(cpu_gpr[a->ra], 0);
+    }
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
+
+static bool trans_CMPB(DisasContext *ctx, arg_CMPB *a)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    gen_helper_CMPB(cpu_gpr[a->ra], cpu_gpr[a->rt], cpu_gpr[a->rb]);
+    return true;
+}
+
+static bool do_cntzw(DisasContext *ctx, arg_X_sa_rc *a,
+                    void (*helper)(TCGv_i32, TCGv_i32, uint32_t))
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_trunc_tl_i32(t, cpu_gpr[a->rs]);
+    helper(t, t, 32);
+    tcg_gen_extu_i32_tl(cpu_gpr[a->ra], t);
+
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
+
+#if defined(TARGET_PPC64)
+static bool do_cntzd(DisasContext *ctx, arg_X_sa_rc *a,
+                    void (*helper)(TCGv_i64, TCGv_i64, uint64_t))
+{
+    helper(cpu_gpr[a->ra], cpu_gpr[a->rs], 64);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
+#endif
+
+static bool trans_CNTLZD(DisasContext *ctx, arg_CNTLZD *a)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    do_cntzd(ctx, a, tcg_gen_clzi_i64);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_CNTTZD(DisasContext *ctx, arg_CNTTZD *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    do_cntzd(ctx, a, tcg_gen_ctzi_i64);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_POPCNTB(DisasContext *ctx, arg_POPCNTB *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, POPCNTB);
+    gen_helper_POPCNTB(cpu_gpr[a->ra], cpu_gpr[a->rs]);
+    return true;
+}
+
+static bool trans_POPCNTW(DisasContext *ctx, arg_POPCNTW *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, POPCNTWD);
+#if defined(TARGET_PPC64)
+    gen_helper_POPCNTW(cpu_gpr[a->ra], cpu_gpr[a->rs]);
+#else
+    tcg_gen_ctpop_i32(cpu_gpr[a->ra], cpu_gpr[a->rs]);
+#endif
+    return true;
+}
+
+static bool trans_POPCNTD(DisasContext *ctx, arg_POPCNTD *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS(ctx, POPCNTWD);
+#if defined(TARGET_PPC64)
+    tcg_gen_ctpop_i64(cpu_gpr[a->ra], cpu_gpr[a->rs]);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_PRTYW(DisasContext *ctx, arg_PRTYW *a)
+{
+    TCGv ra = cpu_gpr[a->ra];
+    TCGv rs = cpu_gpr[a->rs];
+    TCGv t0 = tcg_temp_new();
+
+    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    tcg_gen_shri_tl(t0, rs, 16);
+    tcg_gen_xor_tl(ra, rs, t0);
+    tcg_gen_shri_tl(t0, ra, 8);
+    tcg_gen_xor_tl(ra, ra, t0);
+    tcg_gen_andi_tl(ra, ra, (target_ulong)0x100000001ULL);
+    return true;
+}
+
+static bool trans_PRTYD(DisasContext *ctx, arg_PRTYD *a)
+{
+    TCGv ra = cpu_gpr[a->ra];
+    TCGv rs = cpu_gpr[a->rs];
+    TCGv t0 = tcg_temp_new();
+
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    tcg_gen_shri_tl(t0, rs, 32);
+    tcg_gen_xor_tl(ra, rs, t0);
+    tcg_gen_shri_tl(t0, ra, 16);
+    tcg_gen_xor_tl(ra, ra, t0);
+    tcg_gen_shri_tl(t0, ra, 8);
+    tcg_gen_xor_tl(ra, ra, t0);
+    tcg_gen_andi_tl(ra, ra, 1);
+    return true;
+}
+
+static bool trans_BPERMD(DisasContext *ctx, arg_BPERMD *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, PERM_ISA206);
+#if defined(TARGET_PPC64)
+    gen_helper_BPERMD(cpu_gpr[a->ra], cpu_gpr[a->rt], cpu_gpr[a->rb]);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
 static bool trans_CFUGED(DisasContext *ctx, arg_X *a)
 {
     REQUIRE_64BIT(ctx);
@@ -944,6 +1223,27 @@ static bool trans_PEXTD(DisasContext *ctx, arg_X *a)
     return true;
 }
 
+TRANS(ANDI_, do_addi_, false);
+TRANS(ANDIS_, do_addi_, true);
+TRANS(ORI, do_ori, false);
+TRANS(ORIS, do_ori, true);
+TRANS(XORI, do_xori, false);
+TRANS(XORIS, do_xori, true);
+
+TRANS(AND, do_logical2, tcg_gen_and_tl);
+TRANS(ANDC, do_logical2, tcg_gen_andc_tl);
+TRANS(NAND, do_logical2, tcg_gen_nand_tl);
+TRANS(ORC, do_logical2, tcg_gen_orc_tl);
+TRANS(NOR, do_logical2, tcg_gen_nor_tl);
+TRANS(EQV, do_logical2, tcg_gen_eqv_tl);
+TRANS(EXTSB, do_logical1, tcg_gen_ext8s_tl);
+TRANS(EXTSH, do_logical1, tcg_gen_ext16s_tl);
+
+TRANS(CNTLZW, do_cntzw, tcg_gen_clzi_i32);
+TRANS_FLAGS2(ISA300, CNTTZW, do_cntzw, tcg_gen_ctzi_i32);
+
+TRANS64(EXTSW, do_logical1, tcg_gen_ext32s_tl);
+
 static bool trans_ADDG6S(DisasContext *ctx, arg_X *a)
 {
     const target_ulong carry_bits = (target_ulong)-1 / 0xf;
-- 
2.43.0


