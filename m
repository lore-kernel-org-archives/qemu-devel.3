Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1C0C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYJ-0007WE-P6; Thu, 23 May 2024 19:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYH-0007V1-9Y; Thu, 23 May 2024 19:08:49 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYF-0005jP-4B; Thu, 23 May 2024 19:08:49 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-652fd0bb5e6so2647114a12.0; 
 Thu, 23 May 2024 16:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505725; x=1717110525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJADVCWLglTFQfxilMmH9rvA7nGdqGwE/G1WVCvAaJg=;
 b=k4qiQ0tswLNXkZ9f+oUk5JABBbJxISA+LVCZq+wngRW8YaYMlyiTQgtoJl3SfSn82q
 tYE14H3oGGFRzKyi6mOC2Ak1p14SvuMkPmzsbTKZRIlR4PsRgz0qhmNpQKlxp7RONKT/
 v+Qi0orKkdrVkjkkRnV/8BVnA42vQiLkTGWrXVgUbMe97z/KcJ15U2edQuhrm0rE3Gp6
 Tc7dg8hGwEgkjAEz98FGR091MZcQWNMDOzIAzkol/IE2s06DBv3pCxwxXQ6k4mP2L5YS
 rXPwK0AOAUlOaFGtgvVnqL5GTR8VP8gELG26eSQH3gsxahxDZU3KPlAk8gwMo9tthA+N
 8nIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505725; x=1717110525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJADVCWLglTFQfxilMmH9rvA7nGdqGwE/G1WVCvAaJg=;
 b=WEJIFpaBBNo8PZKghJSiDH6XYX+qUlZJfULTHAcCsR+7THMGWqShVti676fN8xMPcq
 QcqeiQ7tSOszAF7Ovj2h0MZwfB9KYmxnUe5LglDozC97x9mZ3fD6x+7tLEvUTDLXjLVu
 8fBughb6/VzAO1ypwsLZ+KwjvKGpnPdK9Sm7KHIDUs/DAAF6vfM1Ma/RMFp4mjb4hTN/
 nzokDXyLnMMJo4vn0P9RNalOMxR0F6Ti2dA5UCcu0OzfWvcKpsnnbNyXYdA7XB3JAeDC
 MG4kx/79Jn0cQ/uCFIGh+nuYeTuMKzXAEAB4ID04AwqR6NCBZ318Kg8HIPLW7GHkBBxH
 Qi3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX636i0rcDQTBM+fsSvBhwp4SJ7Vs72e7eFSKjHxFBQNeVdOuCma4EMX22Ha0XojMuaZ+1KgjTwt+IGcvtPCt5XoyqF
X-Gm-Message-State: AOJu0YwqawBk3NBtJNaUv8N8jd5YZ1yRaI7t0z5uuBElgdvrj3xfNw4N
 WGYGJnclX4y1wgzQ3eQgaH0o8Qyz7kmoDjnbZzLscIr73qnWZ5Ntkya80g==
X-Google-Smtp-Source: AGHT+IHOJ9IdjkInFP0XNyTPpEjbH91roANGXXV9H4Gy07YAj2KAkppmjrItq1cTgbdrqWEMRXSw0Q==
X-Received: by 2002:a17:90b:30c:b0:2b3:28df:92bb with SMTP id
 98e67ed59e1d1-2bf5e16cee1mr628404a91.13.1716505725119; 
 Thu, 23 May 2024 16:08:45 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/72] target/ppc: Move multiply fixed-point insns (64-bit
 operands) to decodetree.
Date: Fri, 24 May 2024 09:06:48 +1000
Message-ID: <20240523230747.45703-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
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

Moving the following instructions to decodetree :

	mul{ld, ldo, hd, hdu}[.]	: XO-form
	madd{hd, hdu, ld}		: VA-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op'
flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
[np: 32-bit compile fix]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode                   |   9 ++
 target/ppc/translate.c                     | 101 --------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 105 +++++++++++++++++++++
 3 files changed, 114 insertions(+), 101 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 3051792a56..46199488f7 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -384,6 +384,15 @@ MODUW           011111 ..... ..... ..... 0100001011 -   @X
 DARN            011111 ..... --- .. ----- 1011110011 -  @X_tl
 NEG             011111 ..... ..... ----- . 001101000 .  @XO_ta
 
+MULLD           011111 ..... ..... ..... 0 011101001 .  @XO_tab_rc
+MULLDO          011111 ..... ..... ..... 1 011101001 .  @XO_tab_rc
+MULHD           011111 ..... ..... ..... - 001001001 .  @XO_tab_rc
+MULHDU          011111 ..... ..... ..... - 000001001 .  @XO_tab_rc
+
+MADDLD          000100 ..... ..... ..... ..... 110011   @VA
+MADDHD          000100 ..... ..... ..... ..... 110000   @VA
+MADDHDU         000100 ..... ..... ..... ..... 110001   @VA
+
 ## Fixed-Point Logical Instructions
 
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3756b0c495..c76c4c9054 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1917,62 +1917,6 @@ GEN_INT_ARITH_MODD(modud, 0x08, 0);
 GEN_INT_ARITH_MODD(modsd, 0x18, 1);
 #endif
 
-#if defined(TARGET_PPC64)
-/* mulhd  mulhd. */
-static void gen_mulhd(DisasContext *ctx)
-{
-    TCGv lo = tcg_temp_new();
-    tcg_gen_muls2_tl(lo, cpu_gpr[rD(ctx->opcode)],
-                     cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mulhdu  mulhdu. */
-static void gen_mulhdu(DisasContext *ctx)
-{
-    TCGv lo = tcg_temp_new();
-    tcg_gen_mulu2_tl(lo, cpu_gpr[rD(ctx->opcode)],
-                     cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mulld  mulld. */
-static void gen_mulld(DisasContext *ctx)
-{
-    tcg_gen_mul_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                   cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mulldo  mulldo. */
-static void gen_mulldo(DisasContext *ctx)
-{
-    TCGv_i64 t0 = tcg_temp_new_i64();
-    TCGv_i64 t1 = tcg_temp_new_i64();
-
-    tcg_gen_muls2_i64(t0, t1, cpu_gpr[rA(ctx->opcode)],
-                      cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_mov_i64(cpu_gpr[rD(ctx->opcode)], t0);
-
-    tcg_gen_sari_i64(t0, t0, 63);
-    tcg_gen_setcond_i64(TCG_COND_NE, cpu_ov, t0, t1);
-    if (is_isa300(ctx)) {
-        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
-    }
-    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
-
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-#endif
-
 /* Common subf function */
 static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
                                      TCGv arg2, bool add_ca, bool compute_ca,
@@ -5795,36 +5739,6 @@ static void gen_icbt_440(DisasContext *ctx)
      */
 }
 
-#if defined(TARGET_PPC64)
-static void gen_maddld(DisasContext *ctx)
-{
-    TCGv_i64 t1 = tcg_temp_new_i64();
-
-    tcg_gen_mul_i64(t1, cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_add_i64(cpu_gpr[rD(ctx->opcode)], t1, cpu_gpr[rC(ctx->opcode)]);
-}
-
-/* maddhd maddhdu */
-static void gen_maddhd_maddhdu(DisasContext *ctx)
-{
-    TCGv_i64 lo = tcg_temp_new_i64();
-    TCGv_i64 hi = tcg_temp_new_i64();
-    TCGv_i64 t1 = tcg_temp_new_i64();
-
-    if (Rc(ctx->opcode)) {
-        tcg_gen_mulu2_i64(lo, hi, cpu_gpr[rA(ctx->opcode)],
-                          cpu_gpr[rB(ctx->opcode)]);
-        tcg_gen_movi_i64(t1, 0);
-    } else {
-        tcg_gen_muls2_i64(lo, hi, cpu_gpr[rA(ctx->opcode)],
-                          cpu_gpr[rB(ctx->opcode)]);
-        tcg_gen_sari_i64(t1, cpu_gpr[rC(ctx->opcode)], 63);
-    }
-    tcg_gen_add2_i64(t1, cpu_gpr[rD(ctx->opcode)], lo, hi,
-                     cpu_gpr[rC(ctx->opcode)], t1);
-}
-#endif /* defined(TARGET_PPC64) */
-
 static void gen_tbegin(DisasContext *ctx)
 {
     if (unlikely(!ctx->tm_enabled)) {
@@ -6190,9 +6104,6 @@ GEN_HANDLER_E(cmpeqb, 0x1F, 0x00, 0x07, 0x00600000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(cmpb, 0x1F, 0x1C, 0x0F, 0x00000001, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(cmprb, 0x1F, 0x00, 0x06, 0x00400001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(isel, 0x1F, 0x0F, 0xFF, 0x00000001, PPC_ISEL),
-#if defined(TARGET_PPC64)
-GEN_HANDLER(mulld, 0x1F, 0x09, 0x07, 0x00000000, PPC_64B),
-#endif
 GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
@@ -6391,11 +6302,6 @@ GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
 GEN_HANDLER(mtvscr, 0x04, 0x2, 0x19, 0x03ff0000, PPC_ALTIVEC),
-#if defined(TARGET_PPC64)
-GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
-              PPC2_ISA300),
-GEN_HANDLER_E(maddld, 0x04, 0x19, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA300),
-#endif
 
 #if defined(TARGET_PPC64)
 #undef GEN_INT_ARITH_DIVD
@@ -6412,13 +6318,6 @@ GEN_HANDLER_E(divde, 0x1F, 0x09, 0x0D, 0, PPC_NONE, PPC2_DIVE_ISA206),
 GEN_HANDLER_E(divdeo, 0x1F, 0x09, 0x1D, 0, PPC_NONE, PPC2_DIVE_ISA206),
 GEN_HANDLER_E(modsd, 0x1F, 0x09, 0x18, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(modud, 0x1F, 0x09, 0x08, 0x00000001, PPC_NONE, PPC2_ISA300),
-
-#undef GEN_INT_ARITH_MUL_HELPER
-#define GEN_INT_ARITH_MUL_HELPER(name, opc3)                                  \
-GEN_HANDLER(name, 0x1F, 0x09, opc3, 0x00000000, PPC_64B)
-GEN_INT_ARITH_MUL_HELPER(mulhdu, 0x00),
-GEN_INT_ARITH_MUL_HELPER(mulhd, 0x02),
-GEN_INT_ARITH_MUL_HELPER(mulldo, 0x17),
 #endif
 
 #undef GEN_LOGICAL1
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 584cc4bfb2..077c938b30 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -533,6 +533,111 @@ static bool trans_DARN(DisasContext *ctx, arg_DARN *a)
     return true;
 }
 
+static bool trans_MULLD(DisasContext *ctx, arg_MULLD *a)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    tcg_gen_mul_tl(cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb]);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_MULLDO(DisasContext *ctx, arg_MULLD *a)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    tcg_gen_muls2_i64(t0, t1, cpu_gpr[a->ra], cpu_gpr[a->rb]);
+    tcg_gen_mov_i64(cpu_gpr[a->rt], t0);
+
+    tcg_gen_sari_i64(t0, t0, 63);
+    tcg_gen_setcond_i64(TCG_COND_NE, cpu_ov, t0, t1);
+    if (is_isa300(ctx)) {
+        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
+    }
+    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
+
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool do_mulhd(DisasContext *ctx, arg_XO_tab_rc *a,
+                     void (*helper)(TCGv, TCGv, TCGv, TCGv))
+{
+    TCGv lo = tcg_temp_new();
+    helper(lo, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb]);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+TRANS64(MULHD, do_mulhd, tcg_gen_muls2_tl);
+TRANS64(MULHDU, do_mulhd, tcg_gen_mulu2_tl);
+
+static bool trans_MADDLD(DisasContext *ctx, arg_MADDLD *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    tcg_gen_mul_i64(t1, cpu_gpr[a->vra], cpu_gpr[a->vrb]);
+    tcg_gen_add_i64(cpu_gpr[a->vrt], t1, cpu_gpr[a->rc]);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_MADDHD(DisasContext *ctx, arg_MADDHD *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    TCGv_i64 lo = tcg_temp_new_i64();
+    TCGv_i64 hi = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    tcg_gen_muls2_i64(lo, hi, cpu_gpr[a->vra], cpu_gpr[a->vrb]);
+    tcg_gen_sari_i64(t1, cpu_gpr[a->rc], 63);
+    tcg_gen_add2_i64(t1, cpu_gpr[a->vrt], lo, hi, cpu_gpr[a->rc], t1);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_MADDHDU(DisasContext *ctx, arg_MADDHDU *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    TCGv_i64 lo = tcg_temp_new_i64();
+    TCGv_i64 hi = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    tcg_gen_mulu2_i64(lo, hi, cpu_gpr[a->vra], cpu_gpr[a->vrb]);
+    tcg_gen_add2_i64(t1, cpu_gpr[a->vrt], lo, hi, cpu_gpr[a->rc],
+                     tcg_constant_i64(0));
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.43.0


