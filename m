Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D21C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEe-0000oP-7r; Fri, 04 Jul 2025 12:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEV-0000hD-Ko
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjET-0006J0-IC
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so1116346f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646348; x=1752251148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B9mrPBMw+JJK4Uc5nryN4Cu1/BvhOB7WDrBUB4+qxNI=;
 b=yMxk7pRx8rQhCqyWwpMtzdYX29mx52knARsdUdD3JN+dxyPJIwN4QqrkCk6FL988GC
 FywCCOvlApX5zJQXa48FT6D0UzOaU0fIN2M7/P2rnQNAnH0sV8L9G6sKVuP/Hquxicuq
 wxwQ6G4hTsrk/7T7XuHmubgGuAraXXRrZaOJZ/MP6lyY+yQ/otZ9QYgexXXJvWGNCRF+
 PRd3T2mP51EaGbYxtZGwIyjCUraen5ARSH+gVb5q+iC0APldLnAF4xFFy7lazwtM0OeU
 g95+Ogf644+rduSpoitSgn2Tl55magnG/59xnUzWdSyEdy4iXs/jdsoSGmo+9UeipJS3
 i2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646348; x=1752251148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9mrPBMw+JJK4Uc5nryN4Cu1/BvhOB7WDrBUB4+qxNI=;
 b=DCSRyt5+njglUJADoTuIplRhTl5kkBBDJBnRUC/qRN9MCvJWq0wu69WZ5lDtV5Wzu9
 S6PoRqwz6/a8BOGzcyYCusbLJyooIOLtloXXNLuBDSrizSmSRztstnrH1Q4f1FTlUlmd
 SJGjh28U+Zpn7ljuLUb19Z6p3TMv59AjNbfC4AAHjClF4G+c2Q9+ngVn3ou1YnNXNTyW
 2YNzWhTF2I5f4VwNQopuooj1o1td8kOD7HVv0YU+vcF1ltneE64JoMm53yTE18UOGV8b
 8+lk+qKUw6+dWDmlZzRuiCe8qW0tgI/DI1ynafYhB491d3jr9Z3asCep4BwV9SjUQ231
 eOcw==
X-Gm-Message-State: AOJu0YyW+OYTxaOyGEhZvnIDg7w/UtrCkOmYAkzjcekqZBO2RGQcnWgW
 fH9vWyh+Hov50QygfbSHEPRUyDPXQ7g+CnICuErhldL9Gc93tqxA1bcRU1fYe30qz1BQHENG0Mr
 N4SDB
X-Gm-Gg: ASbGncstjubf4Ffj4KWJsvDBCGuT+yBqTaaYWeGXJPkBxuWaioSGLxNfFxw89IPiv0O
 pdHJ8tbIuC2T4fVxd5HfKYOLdxh5x7ElCPUHWGVKLAf4dn74GUbIGmKyGmxFyZ9TWycDaKHkSFE
 wBQC12DlE4547oKo8cwtt747wvf4K3bzH9fYtAUqhyrhr53wtoUoasbUYiHV/rQuC/Z0EZ9oMxM
 pWhyjaflQSyZUAK21GsTa/E7uePR0YtsygU7PYvtGkeg+gi+5nyy0XdRqNjYATx73D8jSAJJsRc
 jWujtuEZZWctJXW8EvZREPS0VjDbal290pOeSOepDRgfF69iYYyMwK11tkfcDinw6gLH
X-Google-Smtp-Source: AGHT+IEtBKh9Ru5GzIiFbb3+cR2IRcSYYXf2jQpy9yJveqQu0J73mqAqB7aP5HFkfTgREuENnaDA6w==
X-Received: by 2002:a05:6000:2dca:b0:3a4:f038:af74 with SMTP id
 ffacd0b85a97d-3b497036257mr2852431f8f.51.1751646347992; 
 Fri, 04 Jul 2025 09:25:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 049/119] target/arm: Implement SME2 FDOT
Date: Fri,  4 Jul 2025 17:23:49 +0100
Message-ID: <20250704162501.249138-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
Message-id: 20250704142112.1018902-38-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  5 ++++
 target/arm/tcg/sme.decode      | 14 +++++++++++
 target/arm/tcg/sve.decode      |  7 ++++--
 target/arm/tcg/sme_helper.c    | 44 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 18 ++++++++++++++
 target/arm/tcg/translate-sve.c |  5 ++++
 6 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index cdd7058aed0..ec93ff57ff3 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -173,3 +173,8 @@ DEF_HELPER_FLAGS_5(gvec_fmaxnum_b16, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fminnum_b16, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_6(sme2_fdot_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(sme2_fdot_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9850c19d90b..a2b93519c48 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -285,6 +285,9 @@ BFMLSL_n1       11000001 001 0 .... 0 .. 011 ..... 11 ...   @azz_nx1_o3x2 n=1
 BFMLSL_n1       11000001 001 0 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=2
 BFMLSL_n1       11000001 001 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
 
+FDOT_n1         11000001 001 0 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=2
+FDOT_n1         11000001 001 1 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -322,6 +325,9 @@ BFMLAL_nn       11000001 101 ...01 0 .. 010 ...00 100 ..    @azz_4x4_o2x2
 BFMLSL_nn       11000001 101 ....0 0 .. 010 ....0 110 ..    @azz_2x2_o2x2
 BFMLSL_nn       11000001 101 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
 
+FDOT_nn         11000001 101 ....0 0 .. 100 ....0 00 ...    @azz_2x2_o3
+FDOT_nn         11000001 101 ...01 0 .. 100 ...00 00 ...    @azz_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -351,3 +357,11 @@ BFMLAL_nx       11000001 1001 .... 1 .. 1 .. ...00 10 ...   @azx_4x1_o2x2
 BFMLSL_nx       11000001 1000 .... . .. 1 .. ..... 11 ...   @azx_1x1_o3x2
 BFMLSL_nx       11000001 1001 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_o2x2
 BFMLSL_nx       11000001 1001 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
+
+@azx_2x1_i2_o3  ........ .... zm:4 . .. . idx:2 .... ... off:3 \
+                &azx_n n=2 rv=%mova_rv zn=%zn_ax2
+@azx_4x1_i2_o3  ........ .... zm:4 . .. . idx:2 .... ... off:3 \
+                &azx_n n=2 rv=%mova_rv zn=%zn_ax4
+
+FDOT_nx         11000001 0101 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_i2_o3
+FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 3a99eb72998..5970ed9ac49 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1662,7 +1662,8 @@ FMLSLT_zzzw     01100100 10 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 BFMLALB_zzzw    01100100 11 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
-### SVE2 floating-point bfloat16 dot-product
+### SVE2 floating-point dot-product
+FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point multiply-add long (indexed)
@@ -1673,7 +1674,9 @@ FMLSLT_zzxw     01100100 10 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 BFMLALB_zzxw    01100100 11 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
 BFMLALT_zzxw    01100100 11 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
 
-### SVE2 floating-point bfloat16 dot-product (indexed)
+### SVE2 floating-point dot-product (indexed)
+
+FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 BFDOT_zzxz      01100100 01 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 
 ### SVE broadcast predicate element
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 8ce50653b4d..60322be3d0b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1152,6 +1152,50 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
     }
 }
 
+void HELPER(sme2_fdot_h)(void *vd, void *vn, void *vm, void *va,
+                         CPUARMState *env, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_maxsz(desc);
+    bool za = extract32(desc, SIMD_DATA_SHIFT, 1);
+    float_status *fpst_std = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
+    float_status *fpst_f16 = &env->vfp.fp_status[za ? FPST_ZA_F16 : FPST_A64_F16];
+    float_status fpst_odd = *fpst_std;
+    float32 *d = vd, *a = va;
+    uint32_t *n = vn, *m = vm;
+
+    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
+
+    for (i = 0; i < oprsz / sizeof(float32); ++i) {
+        d[H4(i)] = f16_dotadd(a[H4(i)], n[H4(i)], m[H4(i)],
+                              fpst_f16, fpst_std, &fpst_odd);
+    }
+}
+
+void HELPER(sme2_fdot_idx_h)(void *vd, void *vn, void *vm, void *va,
+                             CPUARMState *env, uint32_t desc)
+{
+    intptr_t i, j, oprsz = simd_maxsz(desc);
+    intptr_t elements = oprsz / sizeof(float32);
+    intptr_t eltspersegment = MIN(4, elements);
+    int idx = extract32(desc, SIMD_DATA_SHIFT, 2);
+    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    float_status *fpst_std = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
+    float_status *fpst_f16 = &env->vfp.fp_status[za ? FPST_ZA_F16 : FPST_A64_F16];
+    float_status fpst_odd = *fpst_std;
+    float32 *d = vd, *a = va;
+    uint32_t *n = vn, *m = (uint32_t *)vm + H4(idx);
+
+    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
+
+    for (i = 0; i < elements; i += eltspersegment) {
+        uint32_t mm = m[i];
+        for (j = 0; j < eltspersegment; ++j) {
+            d[H4(i + j)] = f16_dotadd(a[H4(i + j)], n[H4(i + j)], mm,
+                                      fpst_f16, fpst_std, &fpst_odd);
+        }
+    }
+}
+
 void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm,
                         void *vpn, void *vpm, CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 9ec02d960d5..761584c90b1 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -903,3 +903,21 @@ static bool do_bfmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
 
 TRANS_FEAT(BFMLAL_nx, aa64_sme2, do_bfmlal_nx, a, false)
 TRANS_FEAT(BFMLSL_nx, aa64_sme2, do_bfmlal_nx, a, true)
+
+static bool do_fdot(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, 1, 0,
+                         multi, FPST_ENV, gen_helper_sme2_fdot_h);
+}
+
+TRANS_FEAT(FDOT_n1, aa64_sme2, do_fdot, a, false)
+TRANS_FEAT(FDOT_nn, aa64_sme2, do_fdot, a, true)
+
+static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                         a->idx | (1 << 2), 0, false, FPST_ENV,
+                         gen_helper_sme2_fdot_idx_h);
+}
+
+TRANS_FEAT(FDOT_nx, aa64_sme2, do_fdot_nx, a)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index b85bd885f9d..4acd22f55e8 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7229,6 +7229,11 @@ TRANS_FEAT_NONSTREAMING(USMMLA, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
 TRANS_FEAT_NONSTREAMING(UMMLA, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
                         gen_helper_gvec_ummla_b, a, 0)
 
+TRANS_FEAT(FDOT_zzzz, aa64_sme2_or_sve2p1, gen_gvec_env_arg_zzzz,
+           gen_helper_sme2_fdot_h, a, 0)
+TRANS_FEAT(FDOT_zzxz, aa64_sme2_or_sve2p1, gen_gvec_env_arg_zzxz,
+           gen_helper_sme2_fdot_idx_h, a)
+
 TRANS_FEAT(BFDOT_zzzz, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
            gen_helper_gvec_bfdot, a, 0)
 TRANS_FEAT(BFDOT_zzxz, aa64_sve_bf16, gen_gvec_env_arg_zzxz,
-- 
2.43.0


