Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864D3C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYU-0007hO-Sg; Thu, 23 May 2024 19:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYM-0007XX-Vq; Thu, 23 May 2024 19:08:56 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYJ-0005jj-Tu; Thu, 23 May 2024 19:08:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f304533064so18676585ad.0; 
 Thu, 23 May 2024 16:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505729; x=1717110529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPN0weGf887U1NvttLkWViXxVWteY1YET5KRhBHTB6w=;
 b=BgV/z3t4jYHAlOaQEsABfz5gf3+6VPYX3XFP/62lJ2aP1Up8tqBMhXONUb4KqF40/X
 NzqxdXvedJczlhdZMZXYIwoxkJrxKoZwsTtdgFDBs2P9r63hnMTGhCgf1siNgUVhN/k4
 imxYOhFpDRCWz8PcRaTklGWeFTC2SUvsJ+rTJCQThYxaTbPsfv02xJS2xT+gM86bvhOn
 3UKjGRCqfgbfxiquLGLjC4YejQFIOG8sttcUhmhLfkom/68yME2JKzxiu+eWDkswr3wx
 Y8KW1EkPFsbGBr5YpL6Ks4nPz1m2rixs9pGoBOVK3Q8NYFh42LwVKYRiJLjH1OeXedPj
 zsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505729; x=1717110529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cPN0weGf887U1NvttLkWViXxVWteY1YET5KRhBHTB6w=;
 b=uUgBP6EFxiSwqbC4fDl/U7UzcK1SKvjJzMFdXk3NUnbBsdQF8e1ggApXgtSN3s4EoV
 a421vVgA2gLV7x4ZtlAz1ZIMP5udfiEnBoBJpsqt6r4NlJj1AklNlmr7OMcK/7/9gBJc
 bH3bctQ0aU2hrXw5hpg+J7AtpTHLlLrlunvRn3QDKBWmo70AsNrrx5/9ow0ov6rnW+BK
 dHriBpuWjby+mcbSv7gBNEfM4CwnAPMkL7sOSm+3Utt06hbPkcBdQh4MQX37qtpK+T+r
 9iIs89+E5hyvgiV5bzNuyuTP6iNJPcNl6wr97i0AF4d6UqRxZ1VZqlZMZdSIejlbLQ6k
 +Ceg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgZSIFoLIRD2gXkhmwrJj08vPoAiv/9nX4kSCCoswAHL1x+hw9vDcXLisYqvADy3xn88NjttKkDh3/ucLjpucmz66g
X-Gm-Message-State: AOJu0YylBgNUBbbrevBWgFJoYk/Y03CcaeTDcdMYmz3MBx02Tku+JnRq
 SK74JiSRwd1zAG+AyW5XOusBlGM7aNwd6GBCTfzpoaYNT5woCSyTzNUr6w==
X-Google-Smtp-Source: AGHT+IGny5N7StmLgGdHHTIjmWbSP/5afHm5WZ/D+IHi1jG82k4ryaBj/gtr4votc7s0LGsSrWVGmA==
X-Received: by 2002:a17:902:ea0d:b0:1f3:137a:37ad with SMTP id
 d9443c01a7336-1f339f5199dmr49724705ad.26.1716505728587; 
 Thu, 23 May 2024 16:08:48 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/72] target/ppc: Move div/mod fixed-point insns (64 bits
 operands) to decodetree.
Date: Fri, 24 May 2024 09:06:49 +1000
Message-ID: <20240523230747.45703-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

	divd[u, e, eu][o][.]	: XO-form
	mod{sd, ud}		: X-form

With this patch, all the fixed-point arithmetic instructions have been
moved to decodetree.
The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured using the '-d in_asm,op' flag.
Also, remaned do_divwe method in fixedpoint-impl.c.inc to do_dive because it is
now used to divide doubleword operands as well, and not just words.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
[np: 32-bit compile fix]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h                        |  4 +-
 target/ppc/insn32.decode                   |  8 +++
 target/ppc/int_helper.c                    |  4 +-
 target/ppc/translate.c                     | 63 ++--------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 58 ++++++++++++++++++--
 5 files changed, 70 insertions(+), 67 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5a97429f1e..b5a76f1365 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -52,8 +52,8 @@ DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
 
 #if defined(TARGET_PPC64)
-DEF_HELPER_4(divdeu, i64, env, i64, i64, i32)
-DEF_HELPER_4(divde, i64, env, i64, i64, i32)
+DEF_HELPER_4(DIVDEU, i64, env, i64, i64, i32)
+DEF_HELPER_4(DIVDE, i64, env, i64, i64, i32)
 #endif
 DEF_HELPER_4(DIVWEU, tl, env, tl, tl, i32)
 DEF_HELPER_4(DIVWE, tl, env, tl, tl, i32)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 46199488f7..c7cb6e7f37 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -393,6 +393,14 @@ MADDLD          000100 ..... ..... ..... ..... 110011   @VA
 MADDHD          000100 ..... ..... ..... ..... 110000   @VA
 MADDHDU         000100 ..... ..... ..... ..... 110001   @VA
 
+DIVD            011111 ..... ..... ..... . 111101001 .  @XO
+DIVDU           011111 ..... ..... ..... . 111001001 .  @XO
+DIVDE           011111 ..... ..... ..... . 110101001 .  @XO
+DIVDEU          011111 ..... ..... ..... . 110001001 .  @XO
+
+MODSD           011111 ..... ..... ..... 1100001001 -   @X
+MODUD           011111 ..... ..... ..... 0100001001 -   @X
+
 ## Fixed-Point Logical Instructions
 
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index bc25d5b062..585c2b65d3 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -101,7 +101,7 @@ target_ulong helper_DIVWE(CPUPPCState *env, target_ulong ra, target_ulong rb,
 
 #if defined(TARGET_PPC64)
 
-uint64_t helper_divdeu(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
+uint64_t helper_DIVDEU(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
 {
     uint64_t rt = 0;
     int overflow = 0;
@@ -120,7 +120,7 @@ uint64_t helper_divdeu(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
     return rt;
 }
 
-uint64_t helper_divde(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
+uint64_t helper_DIVDE(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
 {
     uint64_t rt = 0;
     int64_t ra = (int64_t)rau;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c76c4c9054..ba7c1fdf43 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1777,21 +1777,11 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret,
         gen_set_Rc0(ctx, ret);
     }
 }
-/* div[wd]eu[o][.] */
-#define GEN_DIVE(name, hlpr, compute_ov)                                      \
-static void gen_##name(DisasContext *ctx)                                     \
-{                                                                             \
-    TCGv_i32 t0 = tcg_constant_i32(compute_ov);                               \
-    gen_helper_##hlpr(cpu_gpr[rD(ctx->opcode)], tcg_env,                      \
-                     cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)], t0); \
-    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);                           \
-    }                                                                         \
-}
 
 #if defined(TARGET_PPC64)
-static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
-                                     TCGv arg2, int sign, int compute_ov)
+static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret,
+                                     TCGv arg1, TCGv arg2, bool sign,
+                                     bool compute_ov, bool compute_rc0)
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
@@ -1827,25 +1817,6 @@ static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
         gen_set_Rc0(ctx, ret);
     }
 }
-
-#define GEN_INT_ARITH_DIVD(name, opc3, sign, compute_ov)                      \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    gen_op_arith_divd(ctx, cpu_gpr[rD(ctx->opcode)],                          \
-                      cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],     \
-                      sign, compute_ov);                                      \
-}
-/* divdu  divdu.  divduo  divduo.   */
-GEN_INT_ARITH_DIVD(divdu, 0x0E, 0, 0);
-GEN_INT_ARITH_DIVD(divduo, 0x1E, 0, 1);
-/* divd  divd.  divdo  divdo.   */
-GEN_INT_ARITH_DIVD(divd, 0x0F, 1, 0);
-GEN_INT_ARITH_DIVD(divdo, 0x1F, 1, 1);
-
-GEN_DIVE(divdeu, divdeu, 0);
-GEN_DIVE(divdeuo, divdeu, 1);
-GEN_DIVE(divde, divde, 0);
-GEN_DIVE(divdeo, divde, 1);
 #endif
 
 static inline void gen_op_arith_modw(DisasContext *ctx, TCGv ret, TCGv arg1,
@@ -1904,17 +1875,6 @@ static inline void gen_op_arith_modd(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_remu_i64(ret, t0, t1);
     }
 }
-
-#define GEN_INT_ARITH_MODD(name, opc3, sign)                            \
-static void glue(gen_, name)(DisasContext *ctx)                           \
-{                                                                         \
-  gen_op_arith_modd(ctx, cpu_gpr[rD(ctx->opcode)],                        \
-                    cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],   \
-                    sign);                                                \
-}
-
-GEN_INT_ARITH_MODD(modud, 0x08, 0);
-GEN_INT_ARITH_MODD(modsd, 0x18, 1);
 #endif
 
 /* Common subf function */
@@ -6303,23 +6263,6 @@ GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
 GEN_HANDLER(mtvscr, 0x04, 0x2, 0x19, 0x03ff0000, PPC_ALTIVEC),
 
-#if defined(TARGET_PPC64)
-#undef GEN_INT_ARITH_DIVD
-#define GEN_INT_ARITH_DIVD(name, opc3, sign, compute_ov)                      \
-GEN_HANDLER(name, 0x1F, 0x09, opc3, 0x00000000, PPC_64B)
-GEN_INT_ARITH_DIVD(divdu, 0x0E, 0, 0),
-GEN_INT_ARITH_DIVD(divduo, 0x1E, 0, 1),
-GEN_INT_ARITH_DIVD(divd, 0x0F, 1, 0),
-GEN_INT_ARITH_DIVD(divdo, 0x1F, 1, 1),
-
-GEN_HANDLER_E(divdeu, 0x1F, 0x09, 0x0C, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divdeuo, 0x1F, 0x09, 0x1C, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divde, 0x1F, 0x09, 0x0D, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divdeo, 0x1F, 0x09, 0x1D, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(modsd, 0x1F, 0x09, 0x18, 0x00000001, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(modud, 0x1F, 0x09, 0x08, 0x00000001, PPC_NONE, PPC2_ISA300),
-#endif
-
 #undef GEN_LOGICAL1
 #undef GEN_LOGICAL2
 #define GEN_LOGICAL2(name, tcg_op, opc, type)                                 \
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 077c938b30..2ada7473ea 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -468,7 +468,7 @@ static bool do_divw(DisasContext *ctx, arg_XO *a, int sign)
     return true;
 }
 
-static bool do_divwe(DisasContext *ctx, arg_XO *a,
+static bool do_dive(DisasContext *ctx, arg_XO *a,
                      void (*helper)(TCGv, TCGv_ptr, TCGv, TCGv, TCGv_i32))
 {
     REQUIRE_INSNS_FLAGS2(ctx, DIVE_ISA206);
@@ -482,8 +482,8 @@ static bool do_divwe(DisasContext *ctx, arg_XO *a,
 
 TRANS(DIVW, do_divw, 1);
 TRANS(DIVWU, do_divw, 0);
-TRANS(DIVWE, do_divwe, gen_helper_DIVWE);
-TRANS(DIVWEU, do_divwe, gen_helper_DIVWEU);
+TRANS(DIVWE, do_dive, gen_helper_DIVWE);
+TRANS(DIVWEU, do_dive, gen_helper_DIVWEU);
 
 static bool do_modw(DisasContext *ctx, arg_X *a, bool sign)
 {
@@ -638,6 +638,58 @@ static bool trans_MADDHDU(DisasContext *ctx, arg_MADDHDU *a)
     return true;
 }
 
+static bool do_divd(DisasContext *ctx, arg_XO *a, bool sign)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    gen_op_arith_divd(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
+                      sign, a->oe, a->rc);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool do_modd(DisasContext *ctx, arg_X *a, bool sign)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    gen_op_arith_modd(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
+                      sign);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+TRANS64(DIVD, do_divd, true);
+TRANS64(DIVDU, do_divd, false);
+
+static bool trans_DIVDE(DisasContext *ctx, arg_DIVDE *a)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    return do_dive(ctx, a, gen_helper_DIVDE);
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+static bool trans_DIVDEU(DisasContext *ctx, arg_DIVDEU *a)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    return do_dive(ctx, a, gen_helper_DIVDEU);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+TRANS64(MODSD, do_modd, true);
+TRANS64(MODUD, do_modd, false);
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.43.0


