Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC2CC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYD-0007Rw-2W; Thu, 23 May 2024 19:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHY6-0007NK-TI; Thu, 23 May 2024 19:08:39 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHY2-0005i1-M7; Thu, 23 May 2024 19:08:38 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f8eba8f25eso276492b3a.3; 
 Thu, 23 May 2024 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505712; x=1717110512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BH9YWkRxhEEGsqmoRtfdIuuCD8+vTnkhBYOiiETUc8=;
 b=dUDFxe9GtAZcHt+rOnGDNkQXqaDeLMu4V1l7jgxKDOQ2MMJdRj1pKik2ZSHBOo6QFy
 lWx7FfJPZq7K5uVU0A4efQSwJ9uEa54wiRMlMFb+mneBuE0lX7MMc9exo2ArVtGYkHgz
 YIVHXDQhXCxNe0LD3OK8YBSKrcAKJNq6z9yHIqlxOfRSX2kpvtS2BO4rgRCykqduKqj9
 H/oJzSp/FaR9v+eBsdtGXYrznssi+oB6JLUrmNzxW+xrHdFR4r9k3gfwJpO8N79Xq+iY
 ia2DB6d1hsfj/yEUs+ilIFbofnwjX5ln/mJPo3tqy4YUwjnW2qvXKjjU6PR7XdZ0QijU
 wn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505712; x=1717110512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BH9YWkRxhEEGsqmoRtfdIuuCD8+vTnkhBYOiiETUc8=;
 b=tYl7pEe009rtMCYQmGZEKn0MM9xzuH4gMxgWXzMRJM4CGUQT+pLL7DcoscxgvVBrVa
 CQq/ncYeA7Rf1X8qUwtDcPQHYm5jxpctnFATZwb8NzsnJQVA+t9X2nq6IYCma0TsVSK2
 dhPwAi3bJzrrF7sazz9rwlJC4RG+5IQ95yTyDpF8edwtF3nxbMIZHsTR47CpUuFDmnZ3
 mHZmEBImHwPNqUnpNGxGfco7mNJ0sH4LrTEzMSJ/DJBGgU8ZfoO2+YPC4DGce/z1VMU7
 efpY95oisVGNgm1lwVGdD+j3WREmZM+xxqA6ESUfKFtj7HF032mCUCuSq1RpZCIEoaN5
 rVbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0VYrtZXDs0SW/3pFmqDpJRIqzmkJSf4lar4ocNRJukVp8NAKf2ooYo87EynEDKG1k9TbBh/zk95AsIVHu3ESCixPW
X-Gm-Message-State: AOJu0Yx1PQ/UjGWKR1nO5Ls2Qs9Ji0Qy4LAHPIhm41FRWvC6qOv6Ve9I
 qG+stU0iriw8076rX7sn8mmvUEkr4zZhMJ93zyix/jxEfq9EQpGjTf+stw==
X-Google-Smtp-Source: AGHT+IEEf7BivAllKeUpCSt+I6gyuiZZ6V764hD5VQxs2hkm8jPgeUphwUd6VeCn9dg/zECwa4jttg==
X-Received: by 2002:a05:6a21:3417:b0:1af:fcbf:df28 with SMTP id
 adf61e73a8af0-1b212f0e9cfmr1000608637.41.1716505712313; 
 Thu, 23 May 2024 16:08:32 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/72] target/ppc: Move mul{li, lw, lwo, hw,
 hwu} instructions to decodetree.
Date: Fri, 24 May 2024 09:06:44 +1000
Message-ID: <20240523230747.45703-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

Moving the following instructions to decodetree specification :
	mulli                   	: D-form
	mul{lw, lwo, hw, hwu}[.]	: XO-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.
Also cleaned up code for mullw[o][.] as per review comments while
keeping the logic of the tcg ops generated semantically same.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode                   |  9 +++
 target/ppc/translate.c                     | 89 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 66 ++++++++++++++++
 3 files changed, 75 insertions(+), 89 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index e9d6595168..bb0f1dbd75 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -202,6 +202,9 @@
 &XO_ta          rt ra oe:bool rc:bool
 @XO_ta          ...... rt:5 ra:5 ..... oe:1 ......... rc:1      &XO_ta
 
+&XO_tab_rc      rt ra rb rc:bool
+@XO_tab_rc      ...... rt:5 ra:5 rb:5 . ......... rc:1          &XO_tab_rc
+
 %xx_xt          0:1 21:5
 %xx_xb          1:1 11:5
 %xx_xa          2:1 16:5
@@ -362,6 +365,12 @@ SUBFE           011111 ..... ..... ..... . 010001000 .  @XO
 SUBFME          011111 ..... ..... ----- . 011101000 .  @XO_ta
 SUBFZE          011111 ..... ..... ----- . 011001000 .  @XO_ta
 
+MULLI           000111 ..... ..... ................     @D
+MULLW           011111 ..... ..... ..... 0 011101011 .  @XO_tab_rc
+MULLWO          011111 ..... ..... ..... 1 011101011 .  @XO_tab_rc
+MULHW           011111 ..... ..... ..... - 001001011 .  @XO_tab_rc
+MULHWU          011111 ..... ..... ..... - 000001011 .  @XO_tab_rc
+
 ## Fixed-Point Logical Instructions
 
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a70c5ed951..cb10e33ceb 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1947,90 +1947,6 @@ GEN_INT_ARITH_MODD(modud, 0x08, 0);
 GEN_INT_ARITH_MODD(modsd, 0x18, 1);
 #endif
 
-/* mulhw  mulhw. */
-static void gen_mulhw(DisasContext *ctx)
-{
-    TCGv_i32 t0 = tcg_temp_new_i32();
-    TCGv_i32 t1 = tcg_temp_new_i32();
-
-    tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_muls2_i32(t0, t1, t0, t1);
-    tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t1);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mulhwu  mulhwu.  */
-static void gen_mulhwu(DisasContext *ctx)
-{
-    TCGv_i32 t0 = tcg_temp_new_i32();
-    TCGv_i32 t1 = tcg_temp_new_i32();
-
-    tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_mulu2_i32(t0, t1, t0, t1);
-    tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t1);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mullw  mullw. */
-static void gen_mullw(DisasContext *ctx)
-{
-#if defined(TARGET_PPC64)
-    TCGv_i64 t0, t1;
-    t0 = tcg_temp_new_i64();
-    t1 = tcg_temp_new_i64();
-    tcg_gen_ext32s_tl(t0, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_ext32s_tl(t1, cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_mul_i64(cpu_gpr[rD(ctx->opcode)], t0, t1);
-#else
-    tcg_gen_mul_i32(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                    cpu_gpr[rB(ctx->opcode)]);
-#endif
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mullwo  mullwo. */
-static void gen_mullwo(DisasContext *ctx)
-{
-    TCGv_i32 t0 = tcg_temp_new_i32();
-    TCGv_i32 t1 = tcg_temp_new_i32();
-
-    tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);
-    tcg_gen_muls2_i32(t0, t1, t0, t1);
-#if defined(TARGET_PPC64)
-    tcg_gen_concat_i32_i64(cpu_gpr[rD(ctx->opcode)], t0, t1);
-#else
-    tcg_gen_mov_i32(cpu_gpr[rD(ctx->opcode)], t0);
-#endif
-
-    tcg_gen_sari_i32(t0, t0, 31);
-    tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t1);
-    tcg_gen_extu_i32_tl(cpu_ov, t0);
-    if (is_isa300(ctx)) {
-        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
-    }
-    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
-
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-/* mulli */
-static void gen_mulli(DisasContext *ctx)
-{
-    tcg_gen_muli_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                    SIMM(ctx->opcode));
-}
-
 #if defined(TARGET_PPC64)
 /* mulhd  mulhd. */
 static void gen_mulhd(DisasContext *ctx)
@@ -6343,11 +6259,6 @@ GEN_HANDLER_E(cmpeqb, 0x1F, 0x00, 0x07, 0x00600000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(cmpb, 0x1F, 0x1C, 0x0F, 0x00000001, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(cmprb, 0x1F, 0x00, 0x06, 0x00400001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(isel, 0x1F, 0x0F, 0xFF, 0x00000001, PPC_ISEL),
-GEN_HANDLER(mulhw, 0x1F, 0x0B, 0x02, 0x00000400, PPC_INTEGER),
-GEN_HANDLER(mulhwu, 0x1F, 0x0B, 0x00, 0x00000400, PPC_INTEGER),
-GEN_HANDLER(mullw, 0x1F, 0x0B, 0x07, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(mullwo, 0x1F, 0x0B, 0x17, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(mulli, 0x07, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(mulld, 0x1F, 0x09, 0x07, 0x00000000, PPC_64B),
 #endif
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 0c66465d96..1a2ad58929 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -395,6 +395,72 @@ TRANS(SUBFE, do_subf_XO, true, true)
 TRANS(SUBFME, do_subf_const_XO, tcg_constant_tl(-1LL), true, true)
 TRANS(SUBFZE, do_subf_const_XO, tcg_constant_tl(0), true, true)
 
+static bool trans_MULLI(DisasContext *ctx, arg_MULLI *a)
+{
+    tcg_gen_muli_tl(cpu_gpr[a->rt], cpu_gpr[a->ra], a->si);
+    return true;
+}
+
+static bool trans_MULLW(DisasContext *ctx, arg_MULLW *a)
+{
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+    tcg_gen_ext32s_tl(t0, cpu_gpr[a->ra]);
+    tcg_gen_ext32s_tl(t1, cpu_gpr[a->rb]);
+    tcg_gen_mul_tl(cpu_gpr[a->rt], t0, t1);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+static bool trans_MULLWO(DisasContext *ctx, arg_MULLWO *a)
+{
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+#if defined(TARGET_PPC64)
+    tcg_gen_ext32s_i64(t0, cpu_gpr[a->ra]);
+    tcg_gen_ext32s_i64(t1, cpu_gpr[a->rb]);
+    tcg_gen_mul_i64(cpu_gpr[a->rt], t0, t1);
+    tcg_gen_sextract_i64(t0, cpu_gpr[a->rt], 31, 1);
+    tcg_gen_sari_i64(t1, cpu_gpr[a->rt], 32);
+#else
+    tcg_gen_muls2_i32(cpu_gpr[a->rt], t1, cpu_gpr[a->ra], cpu_gpr[a->rb]);
+    tcg_gen_sari_i32(t0, cpu_gpr[a->rt], 31);
+#endif
+    tcg_gen_setcond_tl(TCG_COND_NE, cpu_ov, t0, t1);
+    if (is_isa300(ctx)) {
+        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
+    }
+    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
+
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+static bool do_mulhw(DisasContext *ctx, arg_XO_tab_rc *a,
+                     void (*helper)(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1,
+                                    TCGv_i32 arg2))
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    tcg_gen_trunc_tl_i32(t0, cpu_gpr[a->ra]);
+    tcg_gen_trunc_tl_i32(t1, cpu_gpr[a->rb]);
+    helper(t0, t1, t0, t1);
+    tcg_gen_extu_i32_tl(cpu_gpr[a->rt], t1);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+TRANS(MULHW, do_mulhw, tcg_gen_muls2_i32)
+TRANS(MULHWU, do_mulhw, tcg_gen_mulu2_i32)
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.43.0


