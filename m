Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9AFC83F10
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjH1-0001dA-9w; Fri, 04 Jul 2025 12:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFH-0003SJ-It
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:39 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFF-0006tC-3y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so9581825e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646395; x=1752251195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fFvYgl+jsQ2wlOhRulGRD2xZlEGTh9lrWYra0HOGUD4=;
 b=yja9CU+QpEZbFc3nnkygXP2MJRB75ilbVQq8Xhx3wQ62S7tRsDlxx/Ph49e+PVtb7d
 QSiq33Pc97yJXZ/Fa7XnrUkKRgpaFi8oIfLxRV2gLbdSpJR3zdKRGlI0zJ1cKkgWiMRD
 8c24Ia8lybyCPcEt7jl7KL1bWRn+gzVV2KNLN1aiqt3pTAQslE9Ed6gsdqTtPF9yriEm
 huF+hOw+igRcM0IFgt+tBh4wNboXwaA0oyyn0MvSEb721AQ/zABy1mREvSJQmywQnGmk
 +i0+G7R/flMCZWxHJMle+ea3GKKMiU1IjpDpHdZ0cI4shBUSugaRIOgN7rMG/0EGCt+A
 aBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646395; x=1752251195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFvYgl+jsQ2wlOhRulGRD2xZlEGTh9lrWYra0HOGUD4=;
 b=mW+IBO6AltAPHVMfUmRadgesiXCSOtv0Xn5IHG/sedK21ksygXsT3g89pRBfhOD0oj
 hPDx9KOQsE4aPqp5TzFAyyZKQEC4fPm/IwE+LkA5NmLLoZndozFy5ulvFyKZdf/Mn+MF
 Ro6q5eNK1t8v1WUUrGNe7m5rkHmFdHu8SUCn9UEwMtkX6mTmYuAkHfa38sQg7uj3vblQ
 bxc7wd73tpAmc834BiAU0fjqxv4H7NU0+ap2Wp7JWwRnuTCsRM/tXKGOP8Zsd0bFmf0u
 AakYJnIF/Oqj0tc48ovTrIaoNmT8mIRWqQJHdHGgq7TNHSwumWD3l3xUHxsn46xKpx82
 SvHg==
X-Gm-Message-State: AOJu0Yy1NaC4f7hGT9Ssdok8V67JFGzFlpZCF0wJNmv9IoNJV3bwqeSB
 r6gmcDi7mweftHw4Uu8xrZLUoASR2x/73H75lJo3ntYd2D/s+2EXE/vN4MAyX3kGeobYfqBSlGL
 fWlre
X-Gm-Gg: ASbGncv9HI18Lj3kRC21j/9tZ7N4uR4F2cwe8bxqcRAJZCoiNUioRm3XJgKIHk+fMTM
 xBsRl4XBiCjfKvsG8IGN4aUMeiBbrW2ErTW+5sgVD97NeVfSQcrNFhYwhVV8WibJ5wRX7mKPGbs
 eDKYqhfGjnCBh8Yj6kNh/QU/DlB6owYY3O8TTgkFjRTKpvDEB75wOf8Gle4W9og7AWGU2sfXn3I
 MfWK6FQEPQm9jrPLprjjR3SupchRVC2bscWPnr01QmhpNlaVACYs+lJVsHOndg3SyB9391EZ0PK
 bRcB9X9XTwEkwC4i3hXSIYnWNfGYq3QHLyPCjGSr68rWwxsoyPkDujg9PXwN+3mp76kJ
X-Google-Smtp-Source: AGHT+IFmTfasv48CAu49Vgr7ITxdFnGKuATuphpEE7yyh7jO342FUi8u+YdouX3FBDFgyyMyBB3Bmg==
X-Received: by 2002:a05:600c:4ed0:b0:453:9bf:6f7c with SMTP id
 5b1f17b1804b1-454b4e76919mr32168805e9.9.1751646395257; 
 Fri, 04 Jul 2025 09:26:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 097/119] target/arm: Implement FADDQV, F{MIN,
 MAX}{NM}QV for SVE2p1
Date: Fri,  4 Jul 2025 17:24:37 +0100
Message-ID: <20250704162501.249138-98-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-86-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 49 ++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  8 ++++
 target/arm/tcg/sve_helper.c    | 70 +++++++++++++++++++++-------------
 target/arm/tcg/translate-sve.c | 48 +++++++++++++++++++++++
 4 files changed, 148 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 9758613b2d8..906da384dc4 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1077,6 +1077,55 @@ DEF_HELPER_FLAGS_4(sve_ah_fminv_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_4(sve_ah_fminv_d, TCG_CALL_NO_RWG,
                    i64, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(sve2p1_faddqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_faddqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_faddqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fmaxnmqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxnmqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxnmqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fminnmqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminnmqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminnmqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fmaxqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fminqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_ah_fmaxqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fmaxqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fmaxqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_ah_fminqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fminqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fminqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sve_fadda_h, TCG_CALL_NO_RWG,
                    i64, i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fadda_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index ff740f7b40b..10cac2de22f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1036,6 +1036,14 @@ FMINNMV         01100101 .. 000 101 001 ... ..... .....         @rd_pg_rn
 FMAXV           01100101 .. 000 110 001 ... ..... .....         @rd_pg_rn
 FMINV           01100101 .. 000 111 001 ... ..... .....         @rd_pg_rn
 
+### SVE FP recursive reduction (quadwords)
+
+FADDQV          01100100 .. 010 000 101 ... ..... .....         @rd_pg_rn
+FMAXNMQV        01100100 .. 010 100 101 ... ..... .....         @rd_pg_rn
+FMINNMQV        01100100 .. 010 101 101 ... ..... .....         @rd_pg_rn
+FMAXQV          01100100 .. 010 110 101 ... ..... .....         @rd_pg_rn
+FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
+
 ## SVE Floating Point Unary Operations - Unpredicated Group
 
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index f47e719fbe1..6512df54e60 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4361,19 +4361,20 @@ uint32_t HELPER(sve_whilecg)(void *vd, uint32_t count, uint32_t pred_desc)
  * The recursion is bounded to depth 7 (128 fp16 elements), so there's
  * little to gain with a more complex non-recursive form.
  */
-#define DO_REDUCE(NAME, TYPE, H, FUNC, IDENT)                         \
-static TYPE NAME##_reduce(TYPE *data, float_status *status, uintptr_t n) \
+#define DO_REDUCE(NAME, SUF, TYPE, H, FUNC, IDENT)                      \
+static TYPE FUNC##_reduce(TYPE *data, float_status *status, uintptr_t n) \
 {                                                                     \
     if (n == 1) {                                                     \
         return *data;                                                 \
     } else {                                                          \
         uintptr_t half = n / 2;                                       \
-        TYPE lo = NAME##_reduce(data, status, half);                  \
-        TYPE hi = NAME##_reduce(data + half, status, half);           \
+        TYPE lo = FUNC##_reduce(data, status, half);                  \
+        TYPE hi = FUNC##_reduce(data + half, status, half);           \
         return FUNC(lo, hi, status);                                  \
     }                                                                 \
 }                                                                     \
-uint64_t HELPER(NAME)(void *vn, void *vg, float_status *s, uint32_t desc) \
+uint64_t helper_sve_##NAME##v_##SUF(void *vn, void *vg,               \
+                                    float_status *s, uint32_t desc)   \
 {                                                                     \
     uintptr_t i, oprsz = simd_oprsz(desc), maxsz = simd_data(desc);   \
     TYPE data[sizeof(ARMVectorReg) / sizeof(TYPE)];                   \
@@ -4388,39 +4389,54 @@ uint64_t HELPER(NAME)(void *vn, void *vg, float_status *s, uint32_t desc) \
     for (; i < maxsz; i += sizeof(TYPE)) {                            \
         *(TYPE *)((void *)data + i) = IDENT;                          \
     }                                                                 \
-    return NAME##_reduce(data, s, maxsz / sizeof(TYPE));              \
+    return FUNC##_reduce(data, s, maxsz / sizeof(TYPE));              \
+}                                                                     \
+void helper_sve2p1_##NAME##qv_##SUF(void *vd, void *vn, void *vg,     \
+                                    float_status *status, uint32_t desc) \
+{                                                                     \
+    unsigned oprsz = simd_oprsz(desc), segments = oprsz / 16;         \
+    for (unsigned e = 0; e < 16; e += sizeof(TYPE)) {                 \
+        TYPE data[ARM_MAX_VQ];                                        \
+        for (unsigned s = 0; s < segments; s++) {                     \
+            uint16_t pg = *(uint16_t *)(vg + H1_2(s * 2));            \
+            TYPE nn = *(TYPE *)(vn + H(s * 16 + H(e)));               \
+            data[s] = (pg >> e) & 1 ? nn : IDENT;                     \
+        }                                                             \
+        *(TYPE *)(vd + H(e)) = FUNC##_reduce(data, status, segments); \
+    }                                                                 \
+    clear_tail(vd, 16, simd_maxsz(desc));                             \
 }
 
-DO_REDUCE(sve_faddv_h, float16, H1_2, float16_add, float16_zero)
-DO_REDUCE(sve_faddv_s, float32, H1_4, float32_add, float32_zero)
-DO_REDUCE(sve_faddv_d, float64, H1_8, float64_add, float64_zero)
+DO_REDUCE(fadd,h, float16, H1_2, float16_add, float16_zero)
+DO_REDUCE(fadd,s, float32, H1_4, float32_add, float32_zero)
+DO_REDUCE(fadd,d, float64, H1_8, float64_add, float64_zero)
 
 /* Identity is floatN_default_nan, without the function call.  */
-DO_REDUCE(sve_fminnmv_h, float16, H1_2, float16_minnum, 0x7E00)
-DO_REDUCE(sve_fminnmv_s, float32, H1_4, float32_minnum, 0x7FC00000)
-DO_REDUCE(sve_fminnmv_d, float64, H1_8, float64_minnum, 0x7FF8000000000000ULL)
+DO_REDUCE(fminnm,h, float16, H1_2, float16_minnum, 0x7E00)
+DO_REDUCE(fminnm,s, float32, H1_4, float32_minnum, 0x7FC00000)
+DO_REDUCE(fminnm,d, float64, H1_8, float64_minnum, 0x7FF8000000000000ULL)
 
-DO_REDUCE(sve_fmaxnmv_h, float16, H1_2, float16_maxnum, 0x7E00)
-DO_REDUCE(sve_fmaxnmv_s, float32, H1_4, float32_maxnum, 0x7FC00000)
-DO_REDUCE(sve_fmaxnmv_d, float64, H1_8, float64_maxnum, 0x7FF8000000000000ULL)
+DO_REDUCE(fmaxnm,h, float16, H1_2, float16_maxnum, 0x7E00)
+DO_REDUCE(fmaxnm,s, float32, H1_4, float32_maxnum, 0x7FC00000)
+DO_REDUCE(fmaxnm,d, float64, H1_8, float64_maxnum, 0x7FF8000000000000ULL)
 
-DO_REDUCE(sve_fminv_h, float16, H1_2, float16_min, float16_infinity)
-DO_REDUCE(sve_fminv_s, float32, H1_4, float32_min, float32_infinity)
-DO_REDUCE(sve_fminv_d, float64, H1_8, float64_min, float64_infinity)
+DO_REDUCE(fmin,h, float16, H1_2, float16_min, float16_infinity)
+DO_REDUCE(fmin,s, float32, H1_4, float32_min, float32_infinity)
+DO_REDUCE(fmin,d, float64, H1_8, float64_min, float64_infinity)
 
-DO_REDUCE(sve_fmaxv_h, float16, H1_2, float16_max, float16_chs(float16_infinity))
-DO_REDUCE(sve_fmaxv_s, float32, H1_4, float32_max, float32_chs(float32_infinity))
-DO_REDUCE(sve_fmaxv_d, float64, H1_8, float64_max, float64_chs(float64_infinity))
+DO_REDUCE(fmax,h, float16, H1_2, float16_max, float16_chs(float16_infinity))
+DO_REDUCE(fmax,s, float32, H1_4, float32_max, float32_chs(float32_infinity))
+DO_REDUCE(fmax,d, float64, H1_8, float64_max, float64_chs(float64_infinity))
 
-DO_REDUCE(sve_ah_fminv_h, float16, H1_2, helper_vfp_ah_minh, float16_infinity)
-DO_REDUCE(sve_ah_fminv_s, float32, H1_4, helper_vfp_ah_mins, float32_infinity)
-DO_REDUCE(sve_ah_fminv_d, float64, H1_8, helper_vfp_ah_mind, float64_infinity)
+DO_REDUCE(ah_fmin,h, float16, H1_2, helper_vfp_ah_minh, float16_infinity)
+DO_REDUCE(ah_fmin,s, float32, H1_4, helper_vfp_ah_mins, float32_infinity)
+DO_REDUCE(ah_fmin,d, float64, H1_8, helper_vfp_ah_mind, float64_infinity)
 
-DO_REDUCE(sve_ah_fmaxv_h, float16, H1_2, helper_vfp_ah_maxh,
+DO_REDUCE(ah_fmax,h, float16, H1_2, helper_vfp_ah_maxh,
           float16_chs(float16_infinity))
-DO_REDUCE(sve_ah_fmaxv_s, float32, H1_4, helper_vfp_ah_maxs,
+DO_REDUCE(ah_fmax,s, float32, H1_4, helper_vfp_ah_maxs,
           float32_chs(float32_infinity))
-DO_REDUCE(sve_ah_fmaxv_d, float64, H1_8, helper_vfp_ah_maxd,
+DO_REDUCE(ah_fmax,d, float64, H1_8, helper_vfp_ah_maxd,
           float64_chs(float64_infinity))
 
 #undef DO_REDUCE
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2114b2ecca1..05c0fc948a7 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3743,6 +3743,54 @@ DO_VPZ_AH(FMAXV, fmaxv)
 
 #undef DO_VPZ
 
+static gen_helper_gvec_3_ptr * const faddqv_fns[4] = {
+    NULL,                       gen_helper_sve2p1_faddqv_h,
+    gen_helper_sve2p1_faddqv_s, gen_helper_sve2p1_faddqv_d,
+};
+TRANS_FEAT(FADDQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           faddqv_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fmaxnmqv_fns[4] = {
+    NULL,                         gen_helper_sve2p1_fmaxnmqv_h,
+    gen_helper_sve2p1_fmaxnmqv_s, gen_helper_sve2p1_fmaxnmqv_d,
+};
+TRANS_FEAT(FMAXNMQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           fmaxnmqv_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fminnmqv_fns[4] = {
+    NULL,                         gen_helper_sve2p1_fminnmqv_h,
+    gen_helper_sve2p1_fminnmqv_s, gen_helper_sve2p1_fminnmqv_d,
+};
+TRANS_FEAT(FMINNMQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           fminnmqv_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fmaxqv_fns[4] = {
+    NULL,                       gen_helper_sve2p1_fmaxqv_h,
+    gen_helper_sve2p1_fmaxqv_s, gen_helper_sve2p1_fmaxqv_d,
+};
+static gen_helper_gvec_3_ptr * const fmaxqv_ah_fns[4] = {
+    NULL,                          gen_helper_sve2p1_ah_fmaxqv_h,
+    gen_helper_sve2p1_ah_fmaxqv_s, gen_helper_sve2p1_ah_fmaxqv_d,
+};
+TRANS_FEAT(FMAXQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           (s->fpcr_ah ? fmaxqv_fns : fmaxqv_ah_fns)[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fminqv_fns[4] = {
+    NULL,                       gen_helper_sve2p1_fminqv_h,
+    gen_helper_sve2p1_fminqv_s, gen_helper_sve2p1_fminqv_d,
+};
+static gen_helper_gvec_3_ptr * const fminqv_ah_fns[4] = {
+    NULL,                          gen_helper_sve2p1_ah_fminqv_h,
+    gen_helper_sve2p1_ah_fminqv_s, gen_helper_sve2p1_ah_fminqv_d,
+};
+TRANS_FEAT(FMINQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           (s->fpcr_ah ? fminqv_fns : fminqv_ah_fns)[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
 /*
  *** SVE Floating Point Unary Operations - Unpredicated Group
  */
-- 
2.43.0


