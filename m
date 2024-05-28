Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AC5C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3UD-0004EG-Tc; Tue, 28 May 2024 16:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Te-00034e-OI
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:24 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TP-0003iT-US
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:22 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-66629f45359so1092961a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928265; x=1717533065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kUhsxY+d50490nvKfwaXk+e73kKVPjSt5PKx9BEIp+I=;
 b=GsBvptRLkbWCffSXPCeZFXDqFGMdrxywsvFOKSftZtpL4DBiPzIWzhuW0zmsiGbcVk
 Wb8Lgu8R1jAqwwhkd3xT0EkCSOa1fR9C7vWWH4bqfS3EG368iEyo6fyGcQr2NFh2rAVN
 VI8ZOLKfZP94maoOn5CiKiffBU0xNsalTh5xcTemnk4Vc4aNiYrlBxQjtYY9/hBkqc5+
 U/0WngEB5DcsZnGKZDy1xLxuVxVp+EsdAfPk27yHkLDywB0pX3QZ7Ks3mLwLc+q9VlhG
 EsuAjOpxMaQK+V8MV27HkMs+FWPU0FnMEmx1zemPjIoye5fKpXSmPbrSc6zWW7+T2hdf
 bTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928265; x=1717533065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kUhsxY+d50490nvKfwaXk+e73kKVPjSt5PKx9BEIp+I=;
 b=Jnskoe1/11kn+jQtxzo4hCXZtSYa7wHgmvckX8Z+y3M/w3TM4Y1qk43ZEo+/VqYeLx
 d8oE2ooueGgd2+gECXxNPEUYyjrE10SFt9cVIoiBuBAMpHDiG3yauzBvo2BN58AeB1Xs
 QsdsdLh8ymg1JOOEUtS7vAExbf/2IqOqjvOnAn2hHbHU/67RXErSxhLEGHa6VG3NQF2R
 gWDlSEEfSJWyBDkf2oBQbAiIQE8P6T8jM28ULKbgzOyFEiEjOonwkeLE3ge3opft3dI+
 zZNaMQw8yNeQum84JhOKCYirIfoUQkKFtqFKG12smIqPTVkTkSz9RUqFI2aojhKe+VYu
 bREQ==
X-Gm-Message-State: AOJu0Ywn/Jmr7rYxRgrwi1+EeG8R/BWG78rdsRwvUam4e6ewhkPAT/O7
 4AhLricWDb0z4qY+RBHT1yV+d3MMp0c1CCENxfqyXMnrJdTUEKf2jIvLu0URy+IGpcqbNr6b3SO
 T
X-Google-Smtp-Source: AGHT+IETYOZPu2ji0q11+Y9f1Sx6hd8zimMQ6U+tvTtYhxeqdt/WXYt0V7vTgnwBwQ8x+9eviGW2Gw==
X-Received: by 2002:a05:6a21:7881:b0:1af:d19b:a76 with SMTP id
 adf61e73a8af0-1b212d5a083mr15498017637.12.1716928265241; 
 Tue, 28 May 2024 13:31:05 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 22/33] target/arm: Convert SHSUB, UHSUB to gvec
Date: Tue, 28 May 2024 13:30:33 -0700
Message-Id: <20240528203044.612851-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |   6 --
 target/arm/tcg/translate.h      |   4 +
 target/arm/tcg/gengvec.c        | 144 ++++++++++++++++++++++++++++++++
 target/arm/tcg/neon_helper.c    |  27 ------
 target/arm/tcg/translate-a64.c  |  17 ++--
 target/arm/tcg/translate-neon.c |   4 +-
 6 files changed, 157 insertions(+), 45 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b26bfcb079..b95f24ed0a 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -274,12 +274,6 @@ DEF_HELPER_2(neon_rhadd_s16, i32, i32, i32)
 DEF_HELPER_2(neon_rhadd_u16, i32, i32, i32)
 DEF_HELPER_2(neon_rhadd_s32, s32, s32, s32)
 DEF_HELPER_2(neon_rhadd_u32, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_s8, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_u8, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_s16, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_u16, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_s32, s32, s32, s32)
-DEF_HELPER_2(neon_hsub_u32, i32, i32, i32)
 
 DEF_HELPER_2(neon_pmin_u8, i32, i32, i32)
 DEF_HELPER_2(neon_pmin_s8, i32, i32, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index dd99d76bf2..315e0afd04 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -476,6 +476,10 @@ void gen_gvec_shadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_uhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_shsub(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_uhsub(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index c0627a787b..c46365c3a6 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2005,3 +2005,147 @@ void gen_gvec_uhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_debug_assert(vece <= MO_32);
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
 }
+
+static void gen_shsub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andc_i64(t, b, a);
+    tcg_gen_vec_sar8i_i64(a, a, 1);
+    tcg_gen_vec_sar8i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_sub8_i64(d, a, b);
+    tcg_gen_vec_sub8_i64(d, d, t);
+}
+
+static void gen_shsub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andc_i64(t, b, a);
+    tcg_gen_vec_sar16i_i64(a, a, 1);
+    tcg_gen_vec_sar16i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_sub16_i64(d, a, b);
+    tcg_gen_vec_sub16_i64(d, d, t);
+}
+
+static void gen_shsub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_andc_i32(t, b, a);
+    tcg_gen_sari_i32(a, a, 1);
+    tcg_gen_sari_i32(b, b, 1);
+    tcg_gen_andi_i32(t, t, 1);
+    tcg_gen_sub_i32(d, a, b);
+    tcg_gen_sub_i32(d, d, t);
+}
+
+static void gen_shsub_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_andc_vec(vece, t, b, a);
+    tcg_gen_sari_vec(vece, a, a, 1);
+    tcg_gen_sari_vec(vece, b, b, 1);
+    tcg_gen_and_vec(vece, t, t, tcg_constant_vec_matching(d, vece, 1));
+    tcg_gen_sub_vec(vece, d, a, b);
+    tcg_gen_sub_vec(vece, d, d, t);
+}
+
+void gen_gvec_shsub(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen3 g[4] = {
+        { .fni8 = gen_shsub8_i64,
+          .fniv = gen_shsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_shsub16_i64,
+          .fniv = gen_shsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_shsub_i32,
+          .fniv = gen_shsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
+}
+
+static void gen_uhsub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andc_i64(t, b, a);
+    tcg_gen_vec_shr8i_i64(a, a, 1);
+    tcg_gen_vec_shr8i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_sub8_i64(d, a, b);
+    tcg_gen_vec_sub8_i64(d, d, t);
+}
+
+static void gen_uhsub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andc_i64(t, b, a);
+    tcg_gen_vec_shr16i_i64(a, a, 1);
+    tcg_gen_vec_shr16i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_sub16_i64(d, a, b);
+    tcg_gen_vec_sub16_i64(d, d, t);
+}
+
+static void gen_uhsub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_andc_i32(t, b, a);
+    tcg_gen_shri_i32(a, a, 1);
+    tcg_gen_shri_i32(b, b, 1);
+    tcg_gen_andi_i32(t, t, 1);
+    tcg_gen_sub_i32(d, a, b);
+    tcg_gen_sub_i32(d, d, t);
+}
+
+static void gen_uhsub_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_andc_vec(vece, t, b, a);
+    tcg_gen_shri_vec(vece, a, a, 1);
+    tcg_gen_shri_vec(vece, b, b, 1);
+    tcg_gen_and_vec(vece, t, t, tcg_constant_vec_matching(d, vece, 1));
+    tcg_gen_sub_vec(vece, d, a, b);
+    tcg_gen_sub_vec(vece, d, d, t);
+}
+
+void gen_gvec_uhsub(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen3 g[4] = {
+        { .fni8 = gen_uhsub8_i64,
+          .fniv = gen_uhsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_uhsub16_i64,
+          .fniv = gen_uhsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_uhsub_i32,
+          .fniv = gen_uhsub_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
+}
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index defd28a6f7..d1641a5252 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -206,33 +206,6 @@ uint32_t HELPER(neon_rhadd_u32)(uint32_t src1, uint32_t src2)
     return dest;
 }
 
-#define NEON_FN(dest, src1, src2) dest = (src1 - src2) >> 1
-NEON_VOP(hsub_s8, neon_s8, 4)
-NEON_VOP(hsub_u8, neon_u8, 4)
-NEON_VOP(hsub_s16, neon_s16, 2)
-NEON_VOP(hsub_u16, neon_u16, 2)
-#undef NEON_FN
-
-int32_t HELPER(neon_hsub_s32)(int32_t src1, int32_t src2)
-{
-    int32_t dest;
-
-    dest = (src1 >> 1) - (src2 >> 1);
-    if ((~src1) & src2 & 1)
-        dest--;
-    return dest;
-}
-
-uint32_t HELPER(neon_hsub_u32)(uint32_t src1, uint32_t src2)
-{
-    uint32_t dest;
-
-    dest = (src1 >> 1) - (src2 >> 1);
-    if ((~src1) & src2 & 1)
-        dest--;
-    return dest;
-}
-
 #define NEON_FN(dest, src1, src2) dest = (src1 < src2) ? src1 : src2
 NEON_POP(pmin_s8, neon_s8, 4)
 NEON_POP(pmin_u8, neon_u8, 4)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 00c04425c1..63f7a59f94 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10967,6 +10967,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
+    case 0x04: /* SHSUB, UHSUB */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uhsub, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_shsub, size);
+        }
+        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11044,16 +11051,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0x4: /* SHSUB, UHSUB */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_hsub_s8, gen_helper_neon_hsub_u8 },
-                    { gen_helper_neon_hsub_s16, gen_helper_neon_hsub_u16 },
-                    { gen_helper_neon_hsub_s32, gen_helper_neon_hsub_u32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             default:
                 g_assert_not_reached();
             }
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 29e5c4a0a3..d59d5804c5 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -843,6 +843,8 @@ DO_3SAME_NO_SZ_3(VPMAX_U, gen_gvec_umaxp)
 DO_3SAME_NO_SZ_3(VPMIN_U, gen_gvec_uminp)
 DO_3SAME_NO_SZ_3(VHADD_S, gen_gvec_shadd)
 DO_3SAME_NO_SZ_3(VHADD_U, gen_gvec_uhadd)
+DO_3SAME_NO_SZ_3(VHSUB_S, gen_gvec_shsub)
+DO_3SAME_NO_SZ_3(VHSUB_U, gen_gvec_uhsub)
 
 #define DO_3SAME_CMP(INSN, COND)                                        \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
@@ -953,8 +955,6 @@ DO_SHA2(SHA256SU1, gen_helper_crypto_sha256su1)
         FUNC(d, tcg_env, n, m);                                         \
     }
 
-DO_3SAME_32(VHSUB_S, hsub_s)
-DO_3SAME_32(VHSUB_U, hsub_u)
 DO_3SAME_32(VRHADD_S, rhadd_s)
 DO_3SAME_32(VRHADD_U, rhadd_u)
 
-- 
2.34.1


