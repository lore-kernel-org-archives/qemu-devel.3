Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ED1C3DA45
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 00:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQyNF-0006fV-4I; Mon, 08 Jul 2024 20:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyNB-0006Ss-33
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:06:21 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyN7-0001v7-DE
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:06:20 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c6775ea6a3so907976eaf.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720483576; x=1721088376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnsES1JfSgMlgLee5StaRe03QD6RN3WNcvucQ9eZvvk=;
 b=qXsfQWvrmatAwwXS7rJav96Yw48pgII9sAWoegugEYzq+SgiWJjcJrE/QAEwys4NPj
 V5AVpY6jEADZLpqW3EG9lJndpiixZEjo1A8lEGM9sMs4KGqtmi9L5nv+Z/ozAxIU0K5E
 JCrsYB1LZ0yhcxRQ4FvArPkh105Sx6MmsyEJhV8ApwLibi1qbjL37W2U7PR5Seiw+1On
 47RVnQ7gZ6f6FcODVx+xIi/SoPeUT+A82mASNVbWxd1hTokR6pAEGZTnRB9539NoH+qO
 juq2Cclxhx8rNA7NeYiShm6+6tVWawZH7rVTu5HCrvUHQ8/vYlriUwncxZF2Bq9gx/79
 Wb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720483576; x=1721088376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnsES1JfSgMlgLee5StaRe03QD6RN3WNcvucQ9eZvvk=;
 b=dcuElAKJUlTk6v1ERh3i62sDjn8Hwt0dubtAfin48+3CEhOKJ20MU35uOefH6HwwZ0
 DMz5t+1216Iv3Nr5b5cekP3+gAQTeFtRf7eiyCaFMiudRMTxmTHQrxRBenL1SNtYHGMi
 Hawu4idFEnIWuvkPl+3qPRM5YqmAbIVgEyHuc+21oouBn/cRMqTjDrwxg6hLb6B2ePSP
 UA1kSTzIKnZFRe00/sRU1I+oD/ZXWGVZAMMXvb2qhMhektFfIwlJI8uA1wxGEjMIEQpQ
 3I3RxQFKiz+xukhZkjFUGF4pOP0kTYjylff8E8hxyavMAcF19hua2cobQXMVJOdVstGO
 NvJQ==
X-Gm-Message-State: AOJu0YyQ197mepYaWCPwqevzU60GlyHEZrxx4vSCIknpyLryN1jfKkBo
 5HfjgEZy0o/gjpLPh5Pn1oorSOoR7T+idCdkOMcLmfk5n42EwHNq2gRJ0WhCz+CI7RIimjYr19c
 YEhY=
X-Google-Smtp-Source: AGHT+IFCuXdMhOtqN8zHNz3o+6ZGNtZBputByi+mjkui51hbyFuldF08AnGON8rYh99F+R5S35Jchg==
X-Received: by 2002:a05:6359:7403:b0:1a6:b005:2acb with SMTP id
 e5c5f4694b2df-1aaddfbd057mr87745255d.0.1720483576018; 
 Mon, 08 Jul 2024 17:06:16 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d682b3fefsm316617a12.76.2024.07.08.17.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 17:06:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 4/6] target/arm: Convert SADDW, SSUBW, UADDW,
 USUBW to decodetree
Date: Mon,  8 Jul 2024 17:06:08 -0700
Message-ID: <20240709000610.382391-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709000610.382391-1-richard.henderson@linaro.org>
References: <20240709000610.382391-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 86 +++++++++++++++++-----------------
 target/arm/tcg/a64.decode      |  5 ++
 2 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 07b9cdd78f..264d2eeb27 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5908,6 +5908,47 @@ TRANS(SQDMLSL_vi, do_3op_widening,
       a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, a->idx,
       a->esz == MO_16 ? gen_sqdmlsl_h : gen_sqdmlsl_s, true)
 
+static bool do_addsub_wide(DisasContext *s, arg_qrrr_e *a,
+                           MemOp sign, bool sub)
+{
+    TCGv_i64 tcg_op0, tcg_op1;
+    MemOp esz = a->esz;
+    int half = 8 >> esz;
+    bool top = a->q;
+    int top_swap = top ? 0 : half - 1;
+    int top_half = top ? half : 0;
+
+    /* There are no 64x64->128 bit operations. */
+    if (esz >= MO_64) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+    tcg_op0 = tcg_temp_new_i64();
+    tcg_op1 = tcg_temp_new_i64();
+
+    for (int elt_fwd = 0; elt_fwd < half; ++elt_fwd) {
+        int elt = elt_fwd ^ top_swap;
+
+        read_vec_element(s, tcg_op1, a->rm, elt + top_half, esz | sign);
+        read_vec_element(s, tcg_op0, a->rn, elt, esz + 1);
+        if (sub) {
+            tcg_gen_sub_i64(tcg_op0, tcg_op0, tcg_op1);
+        } else {
+            tcg_gen_add_i64(tcg_op0, tcg_op0, tcg_op1);
+        }
+        write_vec_element(s, tcg_op0, a->rd, elt, esz + 1);
+    }
+    clear_vec_high(s, 1, a->rd);
+    return true;
+}
+
+TRANS(SADDW, do_addsub_wide, a, MO_SIGN, false)
+TRANS(UADDW, do_addsub_wide, a, 0, false)
+TRANS(SSUBW, do_addsub_wide, a, MO_SIGN, true)
+TRANS(USUBW, do_addsub_wide, a, 0, true)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -10790,37 +10831,6 @@ static void gen_neon_addl(int size, bool is_sub, TCGv_i64 tcg_res,
     genfn(tcg_res, tcg_op1, tcg_op2);
 }
 
-static void handle_3rd_wide(DisasContext *s, int is_q, int is_u, int size,
-                            int opcode, int rd, int rn, int rm)
-{
-    TCGv_i64 tcg_res[2];
-    int part = is_q ? 2 : 0;
-    int pass;
-
-    for (pass = 0; pass < 2; pass++) {
-        TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-        TCGv_i32 tcg_op2 = tcg_temp_new_i32();
-        TCGv_i64 tcg_op2_wide = tcg_temp_new_i64();
-        static NeonGenWidenFn * const widenfns[3][2] = {
-            { gen_helper_neon_widen_s8, gen_helper_neon_widen_u8 },
-            { gen_helper_neon_widen_s16, gen_helper_neon_widen_u16 },
-            { tcg_gen_ext_i32_i64, tcg_gen_extu_i32_i64 },
-        };
-        NeonGenWidenFn *widenfn = widenfns[size][is_u];
-
-        read_vec_element(s, tcg_op1, rn, pass, MO_64);
-        read_vec_element_i32(s, tcg_op2, rm, part + pass, MO_32);
-        widenfn(tcg_op2_wide, tcg_op2);
-        tcg_res[pass] = tcg_temp_new_i64();
-        gen_neon_addl(size, (opcode == 3),
-                      tcg_res[pass], tcg_op1, tcg_op2_wide);
-    }
-
-    for (pass = 0; pass < 2; pass++) {
-        write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
-    }
-}
-
 static void do_narrow_round_high_u32(TCGv_i32 res, TCGv_i64 in)
 {
     tcg_gen_addi_i64(in, in, 1U << 31);
@@ -10889,18 +10899,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     int rd = extract32(insn, 0, 5);
 
     switch (opcode) {
-    case 1: /* SADDW, SADDW2, UADDW, UADDW2 */
-    case 3: /* SSUBW, SSUBW2, USUBW, USUBW2 */
-        /* 64 x 128 -> 128 */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_3rd_wide(s, is_q, is_u, size, opcode, rd, rn, rm);
-        break;
     case 4: /* ADDHN, ADDHN2, RADDHN, RADDHN2 */
     case 6: /* SUBHN, SUBHN2, RSUBHN, RSUBHN2 */
         /* 128 x 128 -> 64 */
@@ -10948,7 +10946,9 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
         return;
     default:
     case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
+    case 1: /* SADDW, SADDW2, UADDW, UADDW2 */
     case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
+    case 3: /* SSUBW, SSUBW2, USUBW, USUBW2 */
     case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
     case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
     case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index cf69e7e1be..32e2f3a0d5 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -993,6 +993,11 @@ SQDMLAL_v       0.00 1110 101 ..... 10010 0 ..... ..... @qrrr_s
 SQDMLSL_v       0.00 1110 011 ..... 10110 0 ..... ..... @qrrr_h
 SQDMLSL_v       0.00 1110 101 ..... 10110 0 ..... ..... @qrrr_s
 
+SADDW           0.00 1110 ..1 ..... 00010 0 ..... ..... @qrrr_e
+UADDW           0.10 1110 ..1 ..... 00010 0 ..... ..... @qrrr_e
+SSUBW           0.00 1110 ..1 ..... 00110 0 ..... ..... @qrrr_e
+USUBW           0.10 1110 ..1 ..... 00110 0 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


