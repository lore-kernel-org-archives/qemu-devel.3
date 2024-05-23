Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D138C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYJ-0007Vh-0k; Thu, 23 May 2024 19:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYE-0007TA-4C; Thu, 23 May 2024 19:08:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYB-0005iv-TI; Thu, 23 May 2024 19:08:45 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f8e819a540so345925b3a.0; 
 Thu, 23 May 2024 16:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505722; x=1717110522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkY8lQqpUNnOLCkMNlutX0B0CL92UQRjmLD6ABd+lCg=;
 b=e6jM42J9N8Z6CpH3GrlvQG1XaTvRthsF573ujKl3jCjnPpJxGyvXT47sO9XJvvPbnG
 cjIj4ymO+WF7Zsfg6x7V9jKv4xLgLykMEiXL7sj1M+fsInC4Vgk/t7RsLU+NFZcWh3IQ
 Wm+zBcdQAxw4LrjY3tLliPF/NyQ41qSsH5QOJpf6kcdRhCiG2ES40r0+nkdejHXWz9W9
 SCv6j3cvbaVizb4UwriWoUjxgm5DOO8Jn/bXZkRjvCITzSqGo8gb+U0ET/RCkWQyzu2/
 I+EUUAUbYkj1ugs47q7mxtXUvC6BUSmuhJF7Z9Ro13xGFza2PcUhPp8SKBz4ZmpvEnIs
 lhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505722; x=1717110522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pkY8lQqpUNnOLCkMNlutX0B0CL92UQRjmLD6ABd+lCg=;
 b=gU67w1MjFqXAotSE2/v9H4OEMjJ5n5+QjkdYtTX+pvVYIsUk1PiuCCcV2tp+woANzU
 q3eYYQ0IriD2GEaYBBjk8qKJ+YfM+xu7i9/g057EAlI8EOBpsu6j+IM4DMFlsiGyNgKP
 +Xk0HhMMyv1VIuyyIff1j58bd4ol3maSuSO/lASSq1uSin/+kmfmXJwGnyV29I564o2v
 4IuDXktp9NB3S67vJIEl3yBAl+yl7Vjfruodp6kXTHTZ5AXq4GoDv7YQbOvoAZNFJtqs
 3JOZfLrNrpWWHOJ9bUr1MQesElAdkKRszSALgPmBjpMJ5UeJvLKuB6+3QnsRkxB/CzD4
 R/zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtMDkAcIaqVBp4Qt1Z2NvzHBAdY/71K/pQGuMRMIwXemym8pwgR8/ABO5z+N0nxasTD+YZGF5qfdIRkCpEmJkhpEVZ
X-Gm-Message-State: AOJu0YyhGI3qhHHNmX6EUXppkTHhGgtXktskkHsjGVZXp5Dgr95qIC/t
 3DaKkyp0Ck5VHPV95OnPdOaBipLPK+ywjzCs4S+gMISmc1F4aOHNRK6Ozg==
X-Google-Smtp-Source: AGHT+IEXv0R+AYHq1ORpaLGP3ILqguQeASjukrDzws8jcYt9lA/MOSB9m/avmdFTF8jBBTyJZP/gTQ==
X-Received: by 2002:a05:6a21:6da3:b0:1b0:180b:218a with SMTP id
 adf61e73a8af0-1b212ccf871mr1070970637.13.1716505721936; 
 Thu, 23 May 2024 16:08:41 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/72] target/ppc: Move neg, darn, mod{sw, uw} to decodetree.
Date: Fri, 24 May 2024 09:06:47 +1000
Message-ID: <20240523230747.45703-15-npiggin@gmail.com>
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

Moving the below instructions to decodetree specification :

	neg[o][.]       	: XO-form
	mod{sw, uw}, darn	: X-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
[np: 32-bit compile fix]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h                        |  4 +-
 target/ppc/insn32.decode                   |  8 ++++
 target/ppc/int_helper.c                    |  4 +-
 target/ppc/translate.c                     | 56 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 48 +++++++++++++++++++
 5 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6f5c0c20eb..5a97429f1e 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -71,8 +71,8 @@ DEF_HELPER_FLAGS_2(cmpeqb, TCG_CALL_NO_RWG_SE, i32, tl, tl)
 DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(bpermd, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_3(srad, tl, env, tl, tl)
-DEF_HELPER_FLAGS_0(darn32, TCG_CALL_NO_RWG, tl)
-DEF_HELPER_FLAGS_0(darn64, TCG_CALL_NO_RWG, tl)
+DEF_HELPER_FLAGS_0(DARN32, TCG_CALL_NO_RWG, tl)
+DEF_HELPER_FLAGS_0(DARN64, TCG_CALL_NO_RWG, tl)
 #endif
 
 DEF_HELPER_FLAGS_1(cntlsw32, TCG_CALL_NO_RWG_SE, i32, i32)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index c5291504dd..3051792a56 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -196,6 +196,9 @@
 &X_a            ra
 @X_a            ...... ra:3 .. ..... ..... .......... .         &X_a
 
+&X_tl           rt l
+@X_tl           ...... rt:5 ... l:2 ..... .......... .          &X_tl
+
 &XO             rt ra rb oe:bool rc:bool
 @XO             ...... rt:5 ra:5 rb:5 oe:1 ......... rc:1       &XO
 
@@ -376,6 +379,11 @@ DIVWU           011111 ..... ..... ..... . 111001011 .  @XO
 DIVWE           011111 ..... ..... ..... . 110101011 .  @XO
 DIVWEU          011111 ..... ..... ..... . 110001011 .  @XO
 
+MODSW           011111 ..... ..... ..... 1100001011 -   @X
+MODUW           011111 ..... ..... ..... 0100001011 -   @X
+DARN            011111 ..... --- .. ----- 1011110011 -  @X_tl
+NEG             011111 ..... ..... ----- . 001101000 .  @XO_ta
+
 ## Fixed-Point Logical Instructions
 
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index dc1f72ff38..bc25d5b062 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -171,7 +171,7 @@ uint32_t helper_cmpeqb(target_ulong ra, target_ulong rb)
 /*
  * Return a random number.
  */
-uint64_t helper_darn32(void)
+uint64_t helper_DARN32(void)
 {
     Error *err = NULL;
     uint32_t ret;
@@ -186,7 +186,7 @@ uint64_t helper_darn32(void)
     return ret;
 }
 
-uint64_t helper_darn64(void)
+uint64_t helper_DARN64(void)
 {
     Error *err = NULL;
     uint64_t ret;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 59248ae3fb..3756b0c495 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1877,17 +1877,6 @@ static inline void gen_op_arith_modw(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
 }
 
-#define GEN_INT_ARITH_MODW(name, opc3, sign)                                \
-static void glue(gen_, name)(DisasContext *ctx)                             \
-{                                                                           \
-    gen_op_arith_modw(ctx, cpu_gpr[rD(ctx->opcode)],                        \
-                      cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],   \
-                      sign);                                                \
-}
-
-GEN_INT_ARITH_MODW(moduw, 0x08, 0);
-GEN_INT_ARITH_MODW(modsw, 0x18, 1);
-
 #if defined(TARGET_PPC64)
 static inline void gen_op_arith_modd(DisasContext *ctx, TCGv ret, TCGv arg1,
                                      TCGv arg2, int sign)
@@ -2054,27 +2043,6 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
 }
 
-/* neg neg. nego nego. */
-static inline void gen_op_arith_neg(DisasContext *ctx, bool compute_ov)
-{
-    TCGv zero = tcg_constant_tl(0);
-    gen_op_arith_subf(ctx, cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                      zero, 0, 0, compute_ov, Rc(ctx->opcode));
-}
-
-static void gen_neg(DisasContext *ctx)
-{
-    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode))) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
-    }
-}
-
-static void gen_nego(DisasContext *ctx)
-{
-    gen_op_arith_neg(ctx, 1);
-}
-
 /***                            Integer logical                            ***/
 #define GEN_LOGICAL2(name, tcg_op, opc, type)                                 \
 static void glue(gen_, name)(DisasContext *ctx)                               \
@@ -2400,24 +2368,6 @@ static void gen_cnttzd(DisasContext *ctx)
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
     }
 }
-
-/* darn */
-static void gen_darn(DisasContext *ctx)
-{
-    int l = L(ctx->opcode);
-
-    if (l > 2) {
-        tcg_gen_movi_i64(cpu_gpr[rD(ctx->opcode)], -1);
-    } else {
-        translator_io_start(&ctx->base);
-        if (l == 0) {
-            gen_helper_darn32(cpu_gpr[rD(ctx->opcode)]);
-        } else {
-            /* Return 64-bit random for both CRN and RRN */
-            gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
-        }
-    }
-}
 #endif
 
 /***                             Integer rotate                            ***/
@@ -6243,8 +6193,6 @@ GEN_HANDLER(isel, 0x1F, 0x0F, 0xFF, 0x00000001, PPC_ISEL),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(mulld, 0x1F, 0x09, 0x07, 0x00000000, PPC_64B),
 #endif
-GEN_HANDLER(neg, 0x1F, 0x08, 0x03, 0x0000F800, PPC_INTEGER),
-GEN_HANDLER(nego, 0x1F, 0x08, 0x13, 0x0000F800, PPC_INTEGER),
 GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
@@ -6265,7 +6213,6 @@ GEN_HANDLER_E(prtyw, 0x1F, 0x1A, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER(popcntd, 0x1F, 0x1A, 0x0F, 0x0000F801, PPC_POPCNTWD),
 GEN_HANDLER(cntlzd, 0x1F, 0x1A, 0x01, 0x00000000, PPC_64B),
 GEN_HANDLER_E(cnttzd, 0x1F, 0x1A, 0x11, 0x00000000, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(darn, 0x1F, 0x13, 0x17, 0x001CF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(prtyd, 0x1F, 0x1A, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(bpermd, 0x1F, 0x1C, 0x07, 0x00000001, PPC_NONE, PPC2_PERM_ISA206),
 #endif
@@ -6450,9 +6397,6 @@ GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
 GEN_HANDLER_E(maddld, 0x04, 0x19, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA300),
 #endif
 
-GEN_HANDLER_E(modsw, 0x1F, 0x0B, 0x18, 0x00000001, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(moduw, 0x1F, 0x0B, 0x08, 0x00000001, PPC_NONE, PPC2_ISA300),
-
 #if defined(TARGET_PPC64)
 #undef GEN_INT_ARITH_DIVD
 #define GEN_INT_ARITH_DIVD(name, opc3, sign, compute_ov)                      \
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 3265c77aa6..584cc4bfb2 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -485,6 +485,54 @@ TRANS(DIVWU, do_divw, 0);
 TRANS(DIVWE, do_divwe, gen_helper_DIVWE);
 TRANS(DIVWEU, do_divwe, gen_helper_DIVWEU);
 
+static bool do_modw(DisasContext *ctx, arg_X *a, bool sign)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    gen_op_arith_modw(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
+                      sign);
+    return true;
+}
+
+TRANS(MODUW, do_modw, false);
+TRANS(MODSW, do_modw, true);
+
+static bool trans_NEG(DisasContext *ctx, arg_NEG *a)
+{
+    if (a->oe) {
+        TCGv zero = tcg_constant_tl(0);
+        gen_op_arith_subf(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], zero,
+                          false, false, true, a->rc);
+    } else {
+        tcg_gen_neg_tl(cpu_gpr[a->rt], cpu_gpr[a->ra]);
+        if (unlikely(a->rc)) {
+            gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+        }
+    }
+    return true;
+}
+
+static bool trans_DARN(DisasContext *ctx, arg_DARN *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    if (a->l > 2) {
+        tcg_gen_movi_i64(cpu_gpr[a->rt], -1);
+    } else {
+        translator_io_start(&ctx->base);
+        if (a->l == 0) {
+            gen_helper_DARN32(cpu_gpr[a->rt]);
+        } else {
+            /* Return 64-bit random for both CRN and RRN */
+            gen_helper_DARN64(cpu_gpr[a->rt]);
+        }
+    }
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


