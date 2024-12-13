Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E92E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xn-0007rj-FY; Fri, 13 Dec 2024 12:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XT-0007EF-4q
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:22 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XQ-0001bl-D7
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:18 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so1082502f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111194; x=1734715994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3dd4VoDW1FyBGxT270NBBei9W/ZPxIE9A7qqZiiNJek=;
 b=RokJS0vf/1oyn+4xai87+Y0diqp1fl2HzcKTn0A09dp19Stmz5bHo8DY9wsqJMiZkZ
 5xRgrjkbCS8Mf4eysb0P35mM+zBjNYqU4oDyW+tq2Bfk2zmMwxLL2JbSO1ox6nBdcoX6
 l91UQxvqZjbf/UKgIuZJT9eaXuuPR3sc0e1CABz3izqPAXEEmomzfwBR3upnOficSwHn
 yO10PAlXVFNODpYap9+q9sl8gaacJMVtEiUy0zOw+4R5YPQfQhMyI2P3uehIgAclf1FI
 W2xA4dOP6LzjOi6ttTkwaxoiqOUTgBE/1z/1UUAfkIWoeOnIbh69yUVd8J3e65Rd1Lyq
 7QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111194; x=1734715994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dd4VoDW1FyBGxT270NBBei9W/ZPxIE9A7qqZiiNJek=;
 b=azhbOlUioXMfcY/bCcLRMddy9zTMgOY1dNoZr8BzyX9sHOnm9/M8m8b36TXN8+4m14
 M8ppWjyaAuagVM1qDrODEzVCkNuEZEgcCiI4OGmRlDcY19opt+Ux1i2OFeZRYu7cEVZ+
 K/f/YhJYEk5/89fJl6Dn/w+sB1HAZADh63dP6V1oEdBrNdf0fssdhL4jPmfsCLcuukMN
 INUGxXO+UKxASgQcN3gam18e8fqK7ne8gKWJ0zs8HsYoWCi8rGUtEn15BMb865vpqc0U
 hIaJar0uqf1XHJmnqebRa7hcsjTpvMXpWoOfqAPOJZ4VlKmdaM/E9QBvpqZtLqD1hc1M
 jQOA==
X-Gm-Message-State: AOJu0Yxfar/yBisd3RBOjwCo25ANXwe2ZHNmUCKtNXSfOnVT4sHaFRkV
 oRHYQO0FOEGLssgNJ2gH4vxFb2M+S1tBZBbMYR5ZbwWC8BOyOmvptAsDDWya9SGx31S8vEbhGPf
 /
X-Gm-Gg: ASbGnctijwPrvXAuKCACIVR2t/XxsPnO0A68ecCyvWPyrqYF67D4BQvp+aprX6sDcyQ
 v+9Of/oP5jILi01DyBEaZ5qY+tvv9jASA91mBn/yfR8wG3VOm6L9B4jNqS+35FMw4wTEhtGHRyK
 fGEiZEafEmt9WEZ3YIYxa2A5DL5sw/iufG0ie5hqUx4W2HKx+O8F7FUQ4eCLc1RwEpfMMBh8992
 Asca+xqq9PwnWwEf4hDfgdI48WvzAEWFcO6CFtkYiCyr+G8eeJ4DM6x8T+4dQ==
X-Google-Smtp-Source: AGHT+IGBOR1riRRbrK8iq5Y3ijF3jIagN5r1Lcg0mIwNRjv4ltpJsDvAqG595I5iMCKfTcXmqGkibg==
X-Received: by 2002:a05:6000:1ac8:b0:386:3e48:f732 with SMTP id
 ffacd0b85a97d-38880acd52fmr2664394f8f.16.1734111193613; 
 Fri, 13 Dec 2024 09:33:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/85] target/arm: Introduce gen_gvec_cnt, gen_gvec_rbit
Date: Fri, 13 Dec 2024 17:31:43 +0000
Message-Id: <20241213173229.3308926-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Add gvec interfaces for CNT and RBIT operations.
Use ctpop8 for CNT and revbit+bswap for RBIT.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-40-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  4 ++--
 target/arm/tcg/translate.h      |  4 ++++
 target/arm/tcg/gengvec.c        | 16 ++++++++++++++++
 target/arm/tcg/neon_helper.c    | 21 ---------------------
 target/arm/tcg/translate-a64.c  | 32 +++++++++-----------------------
 target/arm/tcg/translate-neon.c | 16 ++++++++--------
 target/arm/tcg/vec_helper.c     | 24 ++++++++++++++++++++++++
 7 files changed, 63 insertions(+), 54 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0a697e752bc..167e331a83e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -363,8 +363,8 @@ DEF_HELPER_1(neon_clz_u16, i32, i32)
 DEF_HELPER_1(neon_cls_s8, i32, i32)
 DEF_HELPER_1(neon_cls_s16, i32, i32)
 DEF_HELPER_1(neon_cls_s32, i32, i32)
-DEF_HELPER_1(neon_cnt_u8, i32, i32)
-DEF_HELPER_FLAGS_1(neon_rbit_u8, TCG_CALL_NO_RWG_SE, i32, i32)
+DEF_HELPER_FLAGS_3(gvec_cnt_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_rbit_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_3(neon_qdmulh_s16, i32, env, i32, i32)
 DEF_HELPER_3(neon_qrdmulh_s16, i32, env, i32, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 5c6c24f0575..cb8e1b2586a 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -582,6 +582,10 @@ void gen_gvec_cls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                   uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_clz(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                   uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_cnt(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_rbit(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t opr_sz, uint32_t max_sz);
 
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 834b2961c06..85a0b504960 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2393,3 +2393,19 @@ void gen_gvec_clz(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     assert(vece <= MO_32);
     tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
 }
+
+void gen_gvec_cnt(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz)
+{
+    assert(vece == MO_8);
+    tcg_gen_gvec_2_ool(rd_ofs, rn_ofs, opr_sz, max_sz, 0,
+                       gen_helper_gvec_cnt_b);
+}
+
+void gen_gvec_rbit(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz)
+{
+    assert(vece == MO_8);
+    tcg_gen_gvec_2_ool(rd_ofs, rn_ofs, opr_sz, max_sz, 0,
+                       gen_helper_gvec_rbit_b);
+}
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 93b2076c64f..4e501925dec 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -525,27 +525,6 @@ uint32_t HELPER(neon_cls_s32)(uint32_t x)
     return count - 1;
 }
 
-/* Bit count.  */
-uint32_t HELPER(neon_cnt_u8)(uint32_t x)
-{
-    x = (x & 0x55555555) + ((x >>  1) & 0x55555555);
-    x = (x & 0x33333333) + ((x >>  2) & 0x33333333);
-    x = (x & 0x0f0f0f0f) + ((x >>  4) & 0x0f0f0f0f);
-    return x;
-}
-
-/* Reverse bits in each 8 bit word */
-uint32_t HELPER(neon_rbit_u8)(uint32_t x)
-{
-    x =  ((x & 0xf0f0f0f0) >> 4)
-       | ((x & 0x0f0f0f0f) << 4);
-    x =  ((x & 0x88888888) >> 3)
-       | ((x & 0x44444444) >> 1)
-       | ((x & 0x22222222) << 1)
-       | ((x & 0x11111111) << 3);
-    return x;
-}
-
 #define NEON_QDMULH16(dest, src1, src2, round) do { \
     uint32_t tmp = (int32_t)(int16_t) src1 * (int16_t) src2; \
     if ((tmp ^ (tmp << 1)) & SIGNBIT) { \
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ecb45789986..3e0c061b3c0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10324,12 +10324,15 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x5:
-        if (u && size == 0) { /* NOT */
+    case 0x5: /* CNT, NOT, RBIT */
+        if (!u) {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cnt, 0);
+        } else if (size) {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_rbit, 0);
+        } else {
             gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_not, 0);
-            return;
         }
-        break;
+        return;
     case 0x8: /* CMGT, CMGE */
         if (u) {
             gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cge0, size);
@@ -10374,13 +10377,14 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     } else {
         int pass;
 
+        assert(size == 2);
         for (pass = 0; pass < (is_q ? 4 : 2); pass++) {
             TCGv_i32 tcg_op = tcg_temp_new_i32();
             TCGv_i32 tcg_res = tcg_temp_new_i32();
 
             read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
 
-            if (size == 2) {
+            {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
                 case 0x2f: /* FABS */
@@ -10434,25 +10438,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 case 0x7: /* SQABS, SQNEG */
                     g_assert_not_reached();
                 }
-            } else {
-                /* Use helpers for 8 and 16 bit elements */
-                switch (opcode) {
-                case 0x5: /* CNT, RBIT */
-                    /* For these two insns size is part of the opcode specifier
-                     * (handled earlier); they always operate on byte elements.
-                     */
-                    if (u) {
-                        gen_helper_neon_rbit_u8(tcg_res, tcg_op);
-                    } else {
-                        gen_helper_neon_cnt_u8(tcg_res, tcg_op);
-                    }
-                    break;
-                default:
-                case 0x7: /* SQABS, SQNEG */
-                    g_assert_not_reached();
-                }
             }
-
             write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
         }
     }
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 1c89a532722..50d0bf77531 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3131,6 +3131,14 @@ static bool trans_VMVN(DisasContext *s, arg_2misc *a)
     return do_2misc_vec(s, a, tcg_gen_gvec_not);
 }
 
+static bool trans_VCNT(DisasContext *s, arg_2misc *a)
+{
+    if (a->size != 0) {
+        return false;
+    }
+    return do_2misc_vec(s, a, gen_gvec_cnt);
+}
+
 #define WRAP_2M_3_OOL_FN(WRAPNAME, FUNC, DATA)                          \
     static void WRAPNAME(unsigned vece, uint32_t rd_ofs,                \
                          uint32_t rm_ofs, uint32_t oprsz,               \
@@ -3229,14 +3237,6 @@ static bool trans_VREV16(DisasContext *s, arg_2misc *a)
     return do_2misc(s, a, gen_rev16);
 }
 
-static bool trans_VCNT(DisasContext *s, arg_2misc *a)
-{
-    if (a->size != 0) {
-        return false;
-    }
-    return do_2misc(s, a, gen_helper_neon_cnt_u8);
-}
-
 static void gen_VABS_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                        uint32_t oprsz, uint32_t maxsz)
 {
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index ad6f26545ac..91a9130641f 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3066,3 +3066,27 @@ DO_CLAMP(gvec_uclamp_b, uint8_t)
 DO_CLAMP(gvec_uclamp_h, uint16_t)
 DO_CLAMP(gvec_uclamp_s, uint32_t)
 DO_CLAMP(gvec_uclamp_d, uint64_t)
+
+/* Bit count in each 8-bit word. */
+void HELPER(gvec_cnt_b)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint8_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = ctpop8(n[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+/* Reverse bits in each 8 bit word */
+void HELPER(gvec_rbit_b)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = revbit64(bswap64(n[i]));
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.34.1


