Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83124C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mqD-0000Wa-FS; Sun, 05 May 2024 21:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mpf-0007g1-7z
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:07:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mpX-0003Mj-6I
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:07:54 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f28bb6d747so788439b3a.3
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957666; x=1715562466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDPbDzWlIPS2SJO0ZTILJo7s4nlgeNC96DIsYPohOU0=;
 b=oQVOzBKmAzw5WNBzwNl4p2oUaMK5OgSkXihEMNEiITFv0LV3B2jEA8rTjQmig6iE3S
 7FIwbc2qybr3+ne1EXg36DC3OwrQK52fEKMkBQlA9f9wguEXGs/6PU7WtOwFSStQrps5
 GfTcFZGOKI9uN0mjVTt7opd2Rg7RjNzUIlmYYteWgAyesiRwQX43n17261X58sm4yD+D
 U4tzVe3APji8msjaJZVwC9nMwIu6/BSG10ZyzUu+GYhqywrxAqfdRr4UxGbr0C9xQZ7A
 VBeREzaZr4G6TtaRgSwUdZ43U6thSDHqkSdnqX3OcyYFdGC5aaWrP4uXYP7q0fjQPW6d
 NK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957666; x=1715562466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JDPbDzWlIPS2SJO0ZTILJo7s4nlgeNC96DIsYPohOU0=;
 b=eP8i2yPhxkg8w8arPdc443RtSE5XNKhfzrpN1V12P3eewB/gusv/mMm/3YWyVadHkB
 2mIHOLmM1LKBZfRineyIOytoTb4ChH4e1ZVdqGHMX+5DQpLy0QgYrpeZpF9by/YXm/lc
 VInlZ0D3JZc5E6pQ26Y7qdMgwfzx/4iqzYOX9ImcLHYenDTvqzGFABMdj4BVB1jrjJvr
 wmxrz5HmCis1yGj9zt3NDTgpwLcCK06Yf6fxHviA/WXD37+3RUEmLFVGjc1kxvjgiz/V
 oWBIOF8uzakD7wqxBdHiXumVwMbd+ZiWl4nuxIhRk0cMe2M3DWuDuNZ4Wgf9B7p73hV0
 hfmw==
X-Gm-Message-State: AOJu0YyVdSPyhZ614fskf5DgoVelBgIalmoPiWBJCsJIx5vD6IJIJy6g
 BT/TIYae0rQLcywZ1kgy+hi/CRrSFaOmN4+gq++6db3OB1hICzkHtZExcmt3sYuXhhz1iKb4SRU
 W
X-Google-Smtp-Source: AGHT+IGTVv1NBIdzJY5cuBP1Fqql+Ipy0SdCMbfkP1ik1uansf7NHTcFdl/124ByXt13bS+uq0n8gQ==
X-Received: by 2002:a05:6a20:c888:b0:1ad:85c1:2d21 with SMTP id
 hb8-20020a056a20c88800b001ad85c12d21mr10229256pzb.8.1714957665657; 
 Sun, 05 May 2024 18:07:45 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kp4-20020a056a00464400b006e580678dfbsm6577287pfb.193.2024.05.05.18.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:07:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 48/57] target/arm: Convert SHSUB, UHSUB to gvec
Date: Sun,  5 May 2024 18:03:54 -0700
Message-Id: <20240506010403.6204-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
index e59deec2d9..b82de576d2 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1998,3 +1998,147 @@ void gen_gvec_uhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
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
index c70c3cec2a..0e28a5abbd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10961,6 +10961,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
@@ -11038,16 +11045,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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


