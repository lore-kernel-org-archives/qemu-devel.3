Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5200EC3DA45
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 00:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQyNH-0006zf-TF; Mon, 08 Jul 2024 20:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyN8-0006GZ-93
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:06:18 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyN5-0001ul-As
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:06:17 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3818c2d364cso20494575ab.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 17:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720483574; x=1721088374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwsPWzq4fQTFKfaBL9scNXQ8qaJTvw6XrZRRWc2thLU=;
 b=WxIX3qdI90Cperc8Ui2j/3UyRthLBUkvepIwPbnUdyNnB/EAEVG9ac8hpsgGjanCH2
 RsuT7X3dALFbLChLUIdGKWlCy8T3i7ado92tjTkJ0pCl386Er0HrwmanuOa7oR2LXW6b
 VlM7qLRArD/ZgkN6mVmN+aaQ6VqIBQ7aNF0evmbKqIWaFWKiuT7TmvAHMAQByTG5SRO2
 Z70O7iECji8J7D9TtkD6dPqdqzDN13ZJDd/9i4dFkGlYt5QpDOu/nDqTPyRAgMcrCkZ7
 zcRL4s4EQ69f5pJTYzdsQw0e0B8SLJCKAbS7TbND9ffvUX/S9fZJTEfgnzy5jb76/eOt
 yJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720483574; x=1721088374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwsPWzq4fQTFKfaBL9scNXQ8qaJTvw6XrZRRWc2thLU=;
 b=PiI+X5uPEzS9SDllsOBxUfIQ8yMIW/Ol49Yxg9x8iyFfGTNPXbnks4rSmEQ/G27/3S
 0qdgj7fXp9s0CQmJwe0Rry5ijU+4fa3DXpUr8R0pgW2eissl5p2NaDr4tOmYG7ZmKPTF
 OXbno69vMMwLFSBHn/XdxIyaNqWHZiuYvQ2/OxHunkpzqivyL51cHxiIU2gR06AQggFy
 ZYeTqEcJEMgnnw+SmZAafEle+4Mn4hUonIzcYZcFbZhEt8qkZsgj6BLtU//s6kc8x02n
 sLa7T+/lXWoAI29CkpzdFespt0hN2zFrioZeL4VEdAn/dBCvmrliU3ZRAcfA8n/WVQM/
 WuSQ==
X-Gm-Message-State: AOJu0Yz8uoPbRpzww2WmZ+ysC/cXjpom+Gj4Y8rKNs3F/yeVITCbhCJp
 tiguMWBDqnqkoyerK7/u/E0HnrVNjunfQIc1oN6aARXvvxXiMLkvqaTtYElpBDDSSJjSSZqrYQx
 uhEA=
X-Google-Smtp-Source: AGHT+IFmsDsDuB7TgxmMzySRJjovWGB9PbMOHKSAgqFrklaJZDPQMrxeV3onw03+iZAPhVk5oFcszg==
X-Received: by 2002:a05:6e02:148f:b0:375:9c7e:d04 with SMTP id
 e9e14a558f8ab-38a57215a42mr13877505ab.10.1720483574133; 
 Mon, 08 Jul 2024 17:06:14 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d682b3fefsm316617a12.76.2024.07.08.17.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 17:06:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/6] target/arm: Convert SADDL, SSUBL, SABDL, SABAL,
 and unsigned to decodetree
Date: Mon,  8 Jul 2024 17:06:06 -0700
Message-ID: <20240709000610.382391-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709000610.382391-1-richard.henderson@linaro.org>
References: <20240709000610.382391-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x135.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 150 +++++++++++++++++----------------
 target/arm/tcg/a64.decode      |   9 ++
 2 files changed, 87 insertions(+), 72 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8f0781e1f7..95a37c71bc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5779,6 +5779,65 @@ TRANS(UMLSL_vi, do_3op_widening,
       a->esz, a->q, a->rd, a->rn, a->rm, a->idx,
       gen_mulsub_i64, true)
 
+static void gen_sabd_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(t1, n, m);
+    tcg_gen_sub_i64(t2, m, n);
+    tcg_gen_movcond_i64(TCG_COND_GE, d, n, m, t1, t2);
+}
+
+static void gen_uabd_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(t1, n, m);
+    tcg_gen_sub_i64(t2, m, n);
+    tcg_gen_movcond_i64(TCG_COND_GEU, d, n, m, t1, t2);
+}
+
+static void gen_saba_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    gen_sabd_i64(t, n, m);
+    tcg_gen_add_i64(d, d, t);
+}
+
+static void gen_uaba_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    gen_uabd_i64(t, n, m);
+    tcg_gen_add_i64(d, d, t);
+}
+
+TRANS(SADDL_v, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, -1,
+      tcg_gen_add_i64, false)
+TRANS(UADDL_v, do_3op_widening,
+      a->esz, a->q, a->rd, a->rn, a->rm, -1,
+      tcg_gen_add_i64, false)
+TRANS(SSUBL_v, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, -1,
+      tcg_gen_sub_i64, false)
+TRANS(USUBL_v, do_3op_widening,
+      a->esz, a->q, a->rd, a->rn, a->rm, -1,
+      tcg_gen_sub_i64, false)
+TRANS(SABDL_v, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, -1,
+      gen_sabd_i64, false)
+TRANS(UABDL_v, do_3op_widening,
+      a->esz, a->q, a->rd, a->rn, a->rm, -1,
+      gen_uabd_i64, false)
+TRANS(SABAL_v, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, -1,
+      gen_saba_i64, true)
+TRANS(UABAL_v, do_3op_widening,
+      a->esz, a->q, a->rd, a->rn, a->rm, -1,
+      gen_uaba_i64, true)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -10780,25 +10839,6 @@ static void handle_3rd_widening(DisasContext *s, int is_q, int is_u, int size,
             }
 
             switch (opcode) {
-            case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
-                tcg_gen_add_i64(tcg_passres, tcg_op1, tcg_op2);
-                break;
-            case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
-                tcg_gen_sub_i64(tcg_passres, tcg_op1, tcg_op2);
-                break;
-            case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
-            case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
-            {
-                TCGv_i64 tcg_tmp1 = tcg_temp_new_i64();
-                TCGv_i64 tcg_tmp2 = tcg_temp_new_i64();
-
-                tcg_gen_sub_i64(tcg_tmp1, tcg_op1, tcg_op2);
-                tcg_gen_sub_i64(tcg_tmp2, tcg_op2, tcg_op1);
-                tcg_gen_movcond_i64(is_u ? TCG_COND_GEU : TCG_COND_GE,
-                                    tcg_passres,
-                                    tcg_op1, tcg_op2, tcg_tmp1, tcg_tmp2);
-                break;
-            }
             case 9: /* SQDMLAL, SQDMLAL2 */
             case 11: /* SQDMLSL, SQDMLSL2 */
             case 13: /* SQDMULL, SQDMULL2 */
@@ -10810,20 +10850,20 @@ static void handle_3rd_widening(DisasContext *s, int is_q, int is_u, int size,
             case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
             case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
             case 12: /* UMULL, UMULL2, SMULL, SMULL2 */
+            case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
+            case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
+            case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
+            case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
                 g_assert_not_reached();
             }
 
-            if (opcode == 9 || opcode == 11) {
+            if (accop != 0) {
                 /* saturating accumulate ops */
                 if (accop < 0) {
                     tcg_gen_neg_i64(tcg_passres, tcg_passres);
                 }
                 gen_helper_neon_addl_saturate_s64(tcg_res[pass], tcg_env,
                                                   tcg_res[pass], tcg_passres);
-            } else if (accop > 0) {
-                tcg_gen_add_i64(tcg_res[pass], tcg_res[pass], tcg_passres);
-            } else if (accop < 0) {
-                tcg_gen_sub_i64(tcg_res[pass], tcg_res[pass], tcg_passres);
             }
         }
     } else {
@@ -10844,38 +10884,6 @@ static void handle_3rd_widening(DisasContext *s, int is_q, int is_u, int size,
             }
 
             switch (opcode) {
-            case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
-            case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
-            {
-                TCGv_i64 tcg_op2_64 = tcg_temp_new_i64();
-                static NeonGenWidenFn * const widenfns[2][2] = {
-                    { gen_helper_neon_widen_s8, gen_helper_neon_widen_u8 },
-                    { gen_helper_neon_widen_s16, gen_helper_neon_widen_u16 },
-                };
-                NeonGenWidenFn *widenfn = widenfns[size][is_u];
-
-                widenfn(tcg_op2_64, tcg_op2);
-                widenfn(tcg_passres, tcg_op1);
-                gen_neon_addl(size, (opcode == 2), tcg_passres,
-                              tcg_passres, tcg_op2_64);
-                break;
-            }
-            case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
-            case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
-                if (size == 0) {
-                    if (is_u) {
-                        gen_helper_neon_abdl_u16(tcg_passres, tcg_op1, tcg_op2);
-                    } else {
-                        gen_helper_neon_abdl_s16(tcg_passres, tcg_op1, tcg_op2);
-                    }
-                } else {
-                    if (is_u) {
-                        gen_helper_neon_abdl_u32(tcg_passres, tcg_op1, tcg_op2);
-                    } else {
-                        gen_helper_neon_abdl_s32(tcg_passres, tcg_op1, tcg_op2);
-                    }
-                }
-                break;
             case 9: /* SQDMLAL, SQDMLAL2 */
             case 11: /* SQDMLSL, SQDMLSL2 */
             case 13: /* SQDMULL, SQDMULL2 */
@@ -10888,22 +10896,21 @@ static void handle_3rd_widening(DisasContext *s, int is_q, int is_u, int size,
             case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
             case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
             case 12: /* UMULL, UMULL2, SMULL, SMULL2 */
+            case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
+            case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
+            case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
+            case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
                 g_assert_not_reached();
             }
 
             if (accop != 0) {
-                if (opcode == 9 || opcode == 11) {
-                    /* saturating accumulate ops */
-                    if (accop < 0) {
-                        gen_helper_neon_negl_u32(tcg_passres, tcg_passres);
-                    }
-                    gen_helper_neon_addl_saturate_s32(tcg_res[pass], tcg_env,
-                                                      tcg_res[pass],
-                                                      tcg_passres);
-                } else {
-                    gen_neon_addl(size, (accop < 0), tcg_res[pass],
-                                  tcg_res[pass], tcg_passres);
+                /* saturating accumulate ops */
+                if (accop < 0) {
+                    gen_helper_neon_negl_u32(tcg_passres, tcg_passres);
                 }
+                gen_helper_neon_addl_saturate_s32(tcg_res[pass], tcg_env,
+                                                  tcg_res[pass],
+                                                  tcg_passres);
             }
         }
     }
@@ -11075,11 +11082,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        /* fall through */
-    case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
-    case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
-    case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
-    case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
         /* 64 x 64 -> 128 */
         if (size == 3) {
             unallocated_encoding(s);
@@ -11092,6 +11094,10 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
         handle_3rd_widening(s, is_q, is_u, size, opcode, rd, rn, rm);
         break;
     default:
+    case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
+    case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
+    case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
+    case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
     case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
     case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
     case 12: /* SMULL, SMULL2, UMULL, UMULL2 */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 513d112787..e626ee067f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -969,6 +969,15 @@ UMLAL_v         0.10 1110 ..1 ..... 10000 0 ..... ..... @qrrr_e
 SMLSL_v         0.00 1110 ..1 ..... 10100 0 ..... ..... @qrrr_e
 UMLSL_v         0.10 1110 ..1 ..... 10100 0 ..... ..... @qrrr_e
 
+SADDL_v         0.00 1110 ..1 ..... 00000 0 ..... ..... @qrrr_e
+UADDL_v         0.10 1110 ..1 ..... 00000 0 ..... ..... @qrrr_e
+SSUBL_v         0.00 1110 ..1 ..... 00100 0 ..... ..... @qrrr_e
+USUBL_v         0.10 1110 ..1 ..... 00100 0 ..... ..... @qrrr_e
+SABAL_v         0.00 1110 ..1 ..... 01010 0 ..... ..... @qrrr_e
+UABAL_v         0.10 1110 ..1 ..... 01010 0 ..... ..... @qrrr_e
+SABDL_v         0.00 1110 ..1 ..... 01110 0 ..... ..... @qrrr_e
+UABDL_v         0.10 1110 ..1 ..... 01110 0 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


