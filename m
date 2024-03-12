Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9385CC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5UB-0005ak-T9; Tue, 12 Mar 2024 13:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Tt-00057h-2c; Tue, 12 Mar 2024 13:00:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Tq-00082d-Pp; Tue, 12 Mar 2024 13:00:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e649a2548cso4018487b3a.3; 
 Tue, 12 Mar 2024 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262797; x=1710867597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pO6mZ3ihoSGafLIwgUzLPkb62fib8teyllOyNvYifLE=;
 b=bvc1m2D4WdjIoL/20Evt7ThLdzGkL30gpxYJ4ApDrIrhe1zMeI99AojtAxlOr2YQyo
 Xzo1EskcCunBboT6hN3wJPR4rISYGVntv6DtS5O7qvIYKTw5TIR2SehRwm9EJ4P0RJZY
 DMcxYFuRgU50ZEQAY9ZTlq4rndylz1ITERtyeok1nREUA9l1ShOdqk9l1Bmy2Pf+z1gO
 VO9mzBxVY5XHhkjxlgJRfYhWsF+yTbe7VK9KzE2zl7oMYQ96Y9qUx2pynlURzefaanzK
 JO7a/oMzyQvOC2v4cFhymCwQNlOk6t45ZK/QwUf1ZEih9cMxziviiaQmISfhCMFpk+SR
 5yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262797; x=1710867597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pO6mZ3ihoSGafLIwgUzLPkb62fib8teyllOyNvYifLE=;
 b=Duwp5eq4t21e62rjEgIWRO/MmFhuVTobiLZLm4RYzEYpq8zLYqNI+afJfkFz3PAcm0
 r2JejW9nmiYWLajIASSUsWzj9JSIxzlgx50ObrW85I+PVRjuXTSQYaEzx05mfgSDkH+u
 8tagDgUV6Wp5wQg7sHhtm/7ZDFzF73Wj1XoQCUMCFxcWG7E/KLzKvoqssVADPzvfxD52
 /ed4Xp0DiMsGQ8gEIpdTFSrgyxld8+EYbZqbAIA6woa6VaJDhEnSUoGP5ie7dDyiXBEa
 fc37iN1riU0OeYIBlcXWMXUy8OUxSGabV1bCzzlOatuZ0podZgpR7revOvIQMB0yYKbC
 E6UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfxhssQ/Qt0hYKdp/5F9CTGI9qi8kRCrW8qK6LFg+7dwbQ49hlYSlgt4snQ8W3tS6qPQgJWb9WIEefxb4gx+4RwKxs
X-Gm-Message-State: AOJu0Yy8K4q2/Fq36n2eQ88kO64NmJx4kJ5vkxOiii5/qGk05xC28IqR
 F2jVFxSPr7t1Rz/vHpFQ8qCO5k4iJCHf9cedNEmL3ctfVXKapFl4yfVJ/28aWSc=
X-Google-Smtp-Source: AGHT+IFzZRgrK9aGoPxJ3SBkzeXUGTujfaQQ+8BzFpPdfUMEg6/XC604okA1h/YkY5ZdvjqmW0mAig==
X-Received: by 2002:a05:6a20:7faa:b0:1a3:1327:a3e with SMTP id
 d42-20020a056a207faa00b001a313270a3emr967765pzj.44.1710262796710; 
 Tue, 12 Mar 2024 09:59:56 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/38] target/ppc: Move add and subf type fixed-point
 arithmetic instructions to decodetree
Date: Wed, 13 Mar 2024 02:58:26 +1000
Message-ID: <20240312165851.2240242-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

This patch moves the below instructions to decodetree specification:

        {add, subf}[c,e,me,ze][o][.]       : XO-form
        addic[.], subfic                   : D-form
        addex                              : Z23-form

This patch introduces XO form instructions into decode tree
specification, for which all the four variations([o][.]) have been
handled with a single pattern. The changes were verified by validating
that the tcg ops generated by those instructions remain the same, which
were captured with the '-d in_asm,op' flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode                   |  26 ++++
 target/ppc/translate.c                     | 136 ---------------------
 target/ppc/translate/fixedpoint-impl.c.inc |  70 +++++++++++
 3 files changed, 96 insertions(+), 136 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 4fcf3af8d0..eada59f59f 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -187,6 +187,12 @@
 &X_a            ra
 @X_a            ...... ra:3 .. ..... ..... .......... .         &X_a
 
+&XO             rt ra rb oe:bool rc:bool
+@XO             ...... rt:5 ra:5 rb:5 oe:1 ......... rc:1       &XO
+
+&XO_ta          rt ra oe:bool rc:bool
+@XO_ta          ...... rt:5 ra:5 ..... oe:1 ......... rc:1      &XO_ta
+
 %xx_xt          0:1 21:5
 %xx_xb          1:1 11:5
 %xx_xa          2:1 16:5
@@ -322,10 +328,30 @@ CMPLI           001010 ... - . ..... ................   @D_bfu
 
 ### Fixed-Point Arithmetic Instructions
 
+ADD             011111 ..... ..... ..... . 100001010 .  @XO
+ADDC            011111 ..... ..... ..... . 000001010 .  @XO
+ADDE            011111 ..... ..... ..... . 010001010 .  @XO
+
+# ADDEX is Z23-form, with CY=0; all other values for CY are reserved.
+# This works out the same as X-form.
+ADDEX           011111 ..... ..... ..... 00 10101010 -  @X
+
 ADDI            001110 ..... ..... ................     @D
 ADDIS           001111 ..... ..... ................     @D
+ADDIC           001100 ..... ..... ................     @D
+ADDIC_          001101 ..... ..... ................     @D
 
 ADDPCIS         010011 ..... ..... .......... 00010 .   @DX
+ADDME           011111 ..... ..... ----- . 011101010 .  @XO_ta
+ADDZE           011111 ..... ..... ----- . 011001010 .  @XO_ta
+
+SUBF            011111 ..... ..... ..... . 000101000 .  @XO
+SUBFIC          001000 ..... ..... ................     @D
+SUBFC           011111 ..... ..... ..... . 000001000 .  @XO
+SUBFE           011111 ..... ..... ..... . 010001000 .  @XO
+
+SUBFME          011111 ..... ..... ----- . 011101000 .  @XO_ta
+SUBFZE          011111 ..... ..... ----- . 011001000 .  @XO_ta
 
 ## Fixed-Point Logical Instructions
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 28fc7791af..4f6f7dcd89 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1735,61 +1735,6 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_mov_tl(ret, t0);
     }
 }
-/* Add functions with two operands */
-#define GEN_INT_ARITH_ADD(name, opc3, ca, add_ca, compute_ca, compute_ov)     \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)],                           \
-                     cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],      \
-                     ca, glue(ca, 32),                                        \
-                     add_ca, compute_ca, compute_ov, Rc(ctx->opcode));        \
-}
-/* Add functions with one operand and one immediate */
-#define GEN_INT_ARITH_ADD_CONST(name, opc3, const_val, ca,                    \
-                                add_ca, compute_ca, compute_ov)               \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    TCGv t0 = tcg_constant_tl(const_val);                                     \
-    gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)],                           \
-                     cpu_gpr[rA(ctx->opcode)], t0,                            \
-                     ca, glue(ca, 32),                                        \
-                     add_ca, compute_ca, compute_ov, Rc(ctx->opcode));        \
-}
-
-/* add  add.  addo  addo. */
-GEN_INT_ARITH_ADD(add, 0x08, cpu_ca, 0, 0, 0)
-GEN_INT_ARITH_ADD(addo, 0x18, cpu_ca, 0, 0, 1)
-/* addc  addc.  addco  addco. */
-GEN_INT_ARITH_ADD(addc, 0x00, cpu_ca, 0, 1, 0)
-GEN_INT_ARITH_ADD(addco, 0x10, cpu_ca, 0, 1, 1)
-/* adde  adde.  addeo  addeo. */
-GEN_INT_ARITH_ADD(adde, 0x04, cpu_ca, 1, 1, 0)
-GEN_INT_ARITH_ADD(addeo, 0x14, cpu_ca, 1, 1, 1)
-/* addme  addme.  addmeo  addmeo.  */
-GEN_INT_ARITH_ADD_CONST(addme, 0x07, -1LL, cpu_ca, 1, 1, 0)
-GEN_INT_ARITH_ADD_CONST(addmeo, 0x17, -1LL, cpu_ca, 1, 1, 1)
-/* addex */
-GEN_INT_ARITH_ADD(addex, 0x05, cpu_ov, 1, 1, 0);
-/* addze  addze.  addzeo  addzeo.*/
-GEN_INT_ARITH_ADD_CONST(addze, 0x06, 0, cpu_ca, 1, 1, 0)
-GEN_INT_ARITH_ADD_CONST(addzeo, 0x16, 0, cpu_ca, 1, 1, 1)
-/* addic  addic.*/
-static inline void gen_op_addic(DisasContext *ctx, bool compute_rc0)
-{
-    TCGv c = tcg_constant_tl(SIMM(ctx->opcode));
-    gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                     c, cpu_ca, cpu_ca32, 0, 1, 0, compute_rc0);
-}
-
-static void gen_addic(DisasContext *ctx)
-{
-    gen_op_addic(ctx, 0);
-}
-
-static void gen_addic_(DisasContext *ctx)
-{
-    gen_op_addic(ctx, 1);
-}
 
 static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
                                      TCGv arg2, int sign, int compute_ov)
@@ -2210,47 +2155,6 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_mov_tl(ret, t0);
     }
 }
-/* Sub functions with Two operands functions */
-#define GEN_INT_ARITH_SUBF(name, opc3, add_ca, compute_ca, compute_ov)        \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    gen_op_arith_subf(ctx, cpu_gpr[rD(ctx->opcode)],                          \
-                      cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],     \
-                      add_ca, compute_ca, compute_ov, Rc(ctx->opcode));       \
-}
-/* Sub functions with one operand and one immediate */
-#define GEN_INT_ARITH_SUBF_CONST(name, opc3, const_val,                       \
-                                add_ca, compute_ca, compute_ov)               \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    TCGv t0 = tcg_constant_tl(const_val);                                     \
-    gen_op_arith_subf(ctx, cpu_gpr[rD(ctx->opcode)],                          \
-                      cpu_gpr[rA(ctx->opcode)], t0,                           \
-                      add_ca, compute_ca, compute_ov, Rc(ctx->opcode));       \
-}
-/* subf  subf.  subfo  subfo. */
-GEN_INT_ARITH_SUBF(subf, 0x01, 0, 0, 0)
-GEN_INT_ARITH_SUBF(subfo, 0x11, 0, 0, 1)
-/* subfc  subfc.  subfco  subfco. */
-GEN_INT_ARITH_SUBF(subfc, 0x00, 0, 1, 0)
-GEN_INT_ARITH_SUBF(subfco, 0x10, 0, 1, 1)
-/* subfe  subfe.  subfeo  subfo. */
-GEN_INT_ARITH_SUBF(subfe, 0x04, 1, 1, 0)
-GEN_INT_ARITH_SUBF(subfeo, 0x14, 1, 1, 1)
-/* subfme  subfme.  subfmeo  subfmeo.  */
-GEN_INT_ARITH_SUBF_CONST(subfme, 0x07, -1LL, 1, 1, 0)
-GEN_INT_ARITH_SUBF_CONST(subfmeo, 0x17, -1LL, 1, 1, 1)
-/* subfze  subfze.  subfzeo  subfzeo.*/
-GEN_INT_ARITH_SUBF_CONST(subfze, 0x06, 0, 1, 1, 0)
-GEN_INT_ARITH_SUBF_CONST(subfzeo, 0x16, 0, 1, 1, 1)
-
-/* subfic */
-static void gen_subfic(DisasContext *ctx)
-{
-    TCGv c = tcg_constant_tl(SIMM(ctx->opcode));
-    gen_op_arith_subf(ctx, cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                      c, 0, 1, 0, 0);
-}
 
 /* neg neg. nego nego. */
 static inline void gen_op_arith_neg(DisasContext *ctx, bool compute_ov)
@@ -6524,8 +6428,6 @@ GEN_HANDLER_E(cmpeqb, 0x1F, 0x00, 0x07, 0x00600000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(cmpb, 0x1F, 0x1C, 0x0F, 0x00000001, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(cmprb, 0x1F, 0x00, 0x06, 0x00400001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(isel, 0x1F, 0x0F, 0xFF, 0x00000001, PPC_ISEL),
-GEN_HANDLER(addic, 0x0C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER2(addic_, "addic.", 0x0D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(mulhw, 0x1F, 0x0B, 0x02, 0x00000400, PPC_INTEGER),
 GEN_HANDLER(mulhwu, 0x1F, 0x0B, 0x00, 0x00000400, PPC_INTEGER),
 GEN_HANDLER(mullw, 0x1F, 0x0B, 0x07, 0x00000000, PPC_INTEGER),
@@ -6536,7 +6438,6 @@ GEN_HANDLER(mulld, 0x1F, 0x09, 0x07, 0x00000000, PPC_64B),
 #endif
 GEN_HANDLER(neg, 0x1F, 0x08, 0x03, 0x0000F800, PPC_INTEGER),
 GEN_HANDLER(nego, 0x1F, 0x08, 0x13, 0x0000F800, PPC_INTEGER),
-GEN_HANDLER(subfic, 0x08, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
@@ -6747,25 +6648,6 @@ GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
 GEN_HANDLER_E(maddld, 0x04, 0x19, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA300),
 #endif
 
-#undef GEN_INT_ARITH_ADD
-#undef GEN_INT_ARITH_ADD_CONST
-#define GEN_INT_ARITH_ADD(name, opc3, add_ca, compute_ca, compute_ov)         \
-GEN_HANDLER(name, 0x1F, 0x0A, opc3, 0x00000000, PPC_INTEGER),
-#define GEN_INT_ARITH_ADD_CONST(name, opc3, const_val,                        \
-                                add_ca, compute_ca, compute_ov)               \
-GEN_HANDLER(name, 0x1F, 0x0A, opc3, 0x0000F800, PPC_INTEGER),
-GEN_INT_ARITH_ADD(add, 0x08, 0, 0, 0)
-GEN_INT_ARITH_ADD(addo, 0x18, 0, 0, 1)
-GEN_INT_ARITH_ADD(addc, 0x00, 0, 1, 0)
-GEN_INT_ARITH_ADD(addco, 0x10, 0, 1, 1)
-GEN_INT_ARITH_ADD(adde, 0x04, 1, 1, 0)
-GEN_INT_ARITH_ADD(addeo, 0x14, 1, 1, 1)
-GEN_INT_ARITH_ADD_CONST(addme, 0x07, -1LL, 1, 1, 0)
-GEN_INT_ARITH_ADD_CONST(addmeo, 0x17, -1LL, 1, 1, 1)
-GEN_HANDLER_E(addex, 0x1F, 0x0A, 0x05, 0x00000000, PPC_NONE, PPC2_ISA300),
-GEN_INT_ARITH_ADD_CONST(addze, 0x06, 0, 1, 1, 0)
-GEN_INT_ARITH_ADD_CONST(addzeo, 0x16, 0, 1, 1, 1)
-
 #undef GEN_INT_ARITH_DIVW
 #define GEN_INT_ARITH_DIVW(name, opc3, sign, compute_ov)                      \
 GEN_HANDLER(name, 0x1F, 0x0B, opc3, 0x00000000, PPC_INTEGER)
@@ -6804,24 +6686,6 @@ GEN_INT_ARITH_MUL_HELPER(mulhd, 0x02),
 GEN_INT_ARITH_MUL_HELPER(mulldo, 0x17),
 #endif
 
-#undef GEN_INT_ARITH_SUBF
-#undef GEN_INT_ARITH_SUBF_CONST
-#define GEN_INT_ARITH_SUBF(name, opc3, add_ca, compute_ca, compute_ov)        \
-GEN_HANDLER(name, 0x1F, 0x08, opc3, 0x00000000, PPC_INTEGER),
-#define GEN_INT_ARITH_SUBF_CONST(name, opc3, const_val,                       \
-                                add_ca, compute_ca, compute_ov)               \
-GEN_HANDLER(name, 0x1F, 0x08, opc3, 0x0000F800, PPC_INTEGER),
-GEN_INT_ARITH_SUBF(subf, 0x01, 0, 0, 0)
-GEN_INT_ARITH_SUBF(subfo, 0x11, 0, 0, 1)
-GEN_INT_ARITH_SUBF(subfc, 0x00, 0, 1, 0)
-GEN_INT_ARITH_SUBF(subfco, 0x10, 0, 1, 1)
-GEN_INT_ARITH_SUBF(subfe, 0x04, 1, 1, 0)
-GEN_INT_ARITH_SUBF(subfeo, 0x14, 1, 1, 1)
-GEN_INT_ARITH_SUBF_CONST(subfme, 0x07, -1LL, 1, 1, 0)
-GEN_INT_ARITH_SUBF_CONST(subfmeo, 0x17, -1LL, 1, 1, 1)
-GEN_INT_ARITH_SUBF_CONST(subfze, 0x06, 0, 1, 1, 0)
-GEN_INT_ARITH_SUBF_CONST(subfzeo, 0x16, 0, 1, 1, 1)
-
 #undef GEN_LOGICAL1
 #undef GEN_LOGICAL2
 #define GEN_LOGICAL2(name, tcg_op, opc, type)                                 \
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 51c6fa7330..0c66465d96 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -325,6 +325,76 @@ static bool trans_ADDPCIS(DisasContext *ctx, arg_DX *a)
     return true;
 }
 
+static bool trans_ADDEX(DisasContext *ctx, arg_X *a)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    gen_op_arith_add(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
+                     cpu_ov, cpu_ov32, true, true, false, false);
+    return true;
+}
+
+static bool do_add_D(DisasContext *ctx, arg_D *a, bool add_ca, bool compute_ca,
+                     bool compute_ov, bool compute_rc0)
+{
+    gen_op_arith_add(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra],
+                     tcg_constant_tl(a->si), cpu_ca, cpu_ca32,
+                     add_ca, compute_ca, compute_ov, compute_rc0);
+    return true;
+}
+
+static bool do_add_XO(DisasContext *ctx, arg_XO *a, bool add_ca,
+                      bool compute_ca)
+{
+    gen_op_arith_add(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
+                     cpu_ca, cpu_ca32, add_ca, compute_ca, a->oe, a->rc);
+    return true;
+}
+
+static bool do_add_const_XO(DisasContext *ctx, arg_XO_ta *a, TCGv const_val,
+                            bool add_ca, bool compute_ca)
+{
+    gen_op_arith_add(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], const_val,
+                     cpu_ca, cpu_ca32, add_ca, compute_ca, a->oe, a->rc);
+    return true;
+}
+
+TRANS(ADD, do_add_XO, false, false);
+TRANS(ADDC, do_add_XO, false, true);
+TRANS(ADDE, do_add_XO, true, true);
+TRANS(ADDME, do_add_const_XO, tcg_constant_tl(-1LL), true, true);
+TRANS(ADDZE, do_add_const_XO, tcg_constant_tl(0), true, true);
+TRANS(ADDIC, do_add_D, false, true, false, false);
+TRANS(ADDIC_, do_add_D, false, true, false, true);
+
+static bool trans_SUBFIC(DisasContext *ctx, arg_D *a)
+{
+    gen_op_arith_subf(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra],
+                      tcg_constant_tl(a->si), false, true, false, false);
+    return true;
+}
+
+static bool do_subf_XO(DisasContext *ctx, arg_XO *a, bool add_ca,
+                       bool compute_ca)
+{
+    gen_op_arith_subf(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
+                      add_ca, compute_ca, a->oe, a->rc);
+    return true;
+}
+
+static bool do_subf_const_XO(DisasContext *ctx, arg_XO_ta *a, TCGv const_val,
+                             bool add_ca, bool compute_ca)
+{
+    gen_op_arith_subf(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], const_val,
+                      add_ca, compute_ca, a->oe, a->rc);
+    return true;
+}
+
+TRANS(SUBF, do_subf_XO, false, false)
+TRANS(SUBFC, do_subf_XO, false, true)
+TRANS(SUBFE, do_subf_XO, true, true)
+TRANS(SUBFME, do_subf_const_XO, tcg_constant_tl(-1LL), true, true)
+TRANS(SUBFZE, do_subf_const_XO, tcg_constant_tl(0), true, true)
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.42.0


