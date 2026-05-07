Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8951CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8SA-00082O-N1; Thu, 07 May 2026 19:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8S1-0007UH-4U
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:18 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rw-00029j-2D
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:16 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40ee9b945d5so972867fac.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197686; x=1778802486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7UFvrvkCqUMwpHlUer4hPaF8EHvqpWBM4GhbF2/XME=;
 b=swIlN2DXCgPRpA/3YLkwuDaqM8EpsgJfUSycn6KQaiRmTBB4bVObFl+R1b8C28/2om
 cuJtCGBHDQxVd2a7ZX/i/j30jqzqzjWRmeCOtau/f4KGCpCmh8aMc8Fve2RwaTkCsbHC
 HbqCOeZMh+Vq/KuoIhhj5LjX5QJl8Xfu5ktCpYOOdv3k/Ngru572wFDN3NXoq+UKzeYv
 ugeBu0PNxdRgKlVqZFcX8NXk1P5zUo+R2dCryUYOSiYI0IByAH9M2KyPx/MyUFKfulNI
 A4gHyl3Au8UuiX5GbaJrA9PTLIN7b3lwi7/96+m8yCpfHvJcWI3dICIVa0oL62G9pwr6
 c/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197686; x=1778802486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V7UFvrvkCqUMwpHlUer4hPaF8EHvqpWBM4GhbF2/XME=;
 b=mjjajy+u6fZ5n7X5+URO5QnmuQlo4khIhqZVZqCb/Ahc+o5BX2tDBSJEC8q+225feN
 u+kpTuqpPoI3zV2V0398vH2lKo43MjpbeL4QzZ3ytmWRs16igEVuJbiLBzCDiUddFdFm
 RveRX2FukvdAEzMAk1FRhcglR3ldr4TbD5b2BQLvy23AvHyHCJ+Ec/Ic8AQtdtWc+xWo
 q7i9MKhXyBKzEHUVQaPldXi7Tq/5hn/V+FBNDVxUo+HXxrNvdC9Ag8HW96tMEQGWfBf4
 BSDT2yb49STNMuFo08tQJje7+YKE/JLh5iBIen1yXhieX9tp2uDoPrEHmLNLSUOe/yau
 rXdQ==
X-Gm-Message-State: AOJu0YzhrdwIB5WkWmaX1g7PBo3PJwBX/VXUA/nNK025Jfp+0JtC4Cro
 iwGuICAKYC4vLdwhPkXzhvAUMK6M6P8+flAPVoYTCFuXAFIdlOwP/hCRrWiQm1e/AcBL9AO+XF3
 FyI8Z
X-Gm-Gg: Acq92OGNaPHUMbPz5chNaVj40s5zczriqonKpyFWdbe99m4gm2UrkUm2cNfUA0hC7LL
 jZGxwoqRXxzLYufZixNouRccotdmH//IJ5W7GFHgqasYwalQIP8OPowQ18SWCLeRgpk8+tl/paY
 FfPAi1UUaNUZOFS3vX2Ego2WlWg9o0IDI7WoCT7SZvWe0g7kNm7lJCl1fbL6PIkvm62zXKAe18o
 9L6RlxcJY4x+vEtuPbQTZFXGYbIlVOQItolBeaIXZWgp9RqZTI1toIp0QyVdrVKVdugRmIL55XU
 L9II+3u8Nrw5hO6ov+/yPzdQDEwYfurVCIv1v7qarBnZUCJiJt/MT8AkKIzDElqWCM+LhkBWx9/
 bAldws8kXapyXmre/LXwRFfX7s3jJh9wBDKLTCOakFDgzfyBo5ijYt38aOtZ5JAHRL+jFsGolku
 3GdewvOPr0X6i7zAziYWnW3bvNE0EwizJEtiohYYXoki681KiV5uukbs+V
X-Received: by 2002:a05:6870:7204:b0:42c:42c:8e19 with SMTP id
 586e51a60fabf-434f6f904b8mr6768568fac.23.1778197686362; 
 Thu, 07 May 2026 16:48:06 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 52/60] target/arm: Implement FDOT (FP8 to FP16) for AdvSIMD
Date: Thu,  7 May 2026 18:44:05 -0500
Message-ID: <20260507234413.643512-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-fp8-defs.h |  3 +++
 target/arm/tcg/fp8_helper.c      | 41 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  2 ++
 target/arm/tcg/a64.decode        |  2 ++
 5 files changed, 53 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 908dfe0edd..ae98d126ae 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1604,6 +1604,11 @@ static inline bool isar_feature_aa64_f8dp4(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8DP4);
 }
 
+static inline bool isar_feature_aa64_f8dp2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8DP2);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index ee6f2e9236..5995d77577 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -32,3 +32,6 @@ DEF_HELPER_FLAGS_5(gvec_fmla_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fdot_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 48a2e29a31..d169e8327f 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -772,3 +772,44 @@ void HELPER(gvec_fdot_idx_sb)(void *vd, void *vn, void *vm,
     fp8_mul_finish(env, &ctx);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fdot_hb)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    uint16_t *n = vn;
+    uint16_t *m = vm;
+    float16 *d = vd;
+
+    for (size_t i = 0; i < nelem; i++) {
+        d[i] = f8dotadd_h(n[i], m[i], 2, d[i], &ctx);
+    }
+
+    fp8_mul_finish(env, &ctx);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fdot_idx_hb)(void *vd, void *vn, void *vm,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    size_t idx = simd_data(desc);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    uint16_t *n = vn;
+    uint16_t *m = vm;
+    float16 *d = vd;
+    size_t i = 0;
+
+    do {
+        uint16_t e1 = m[i + H2(idx)];
+        do {
+            d[i] = f8dotadd_h(n[i], e1, 2, d[i], &ctx);
+        } while (++i % 8 != 0);
+    } while (i < nelem);
+
+    fp8_mul_finish(env, &ctx);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8ea63e94fe..c5ea6b27a9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7417,6 +7417,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 }
 
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
+TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
@@ -7432,6 +7433,7 @@ static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
 }
 
 TRANS_FEAT(FDOT_sb_vi, aa64_f8dp4, do_f8dot_idx, a, gen_helper_gvec_fdot_idx_sb)
+TRANS_FEAT(FDOT_hb_vi, aa64_f8dp2, do_f8dot_idx, a, gen_helper_gvec_fdot_idx_hb)
 
 static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                                gen_helper_gvec_3 * const fns[2])
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d78a3d5486..d1254355b6 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1214,6 +1214,7 @@ FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
                 &rxx idxm=0 idxn=%fmlall_idxn
 
 FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
+FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
@@ -1340,6 +1341,7 @@ FMLALL_sb_vi    0 . 10 1111 0 . ... rm:3 1000 . 0 rn:5 rd:5 \
                 &rxx idxm=%hlm4 idxn=%fmlall_idxn
 
 FDOT_sb_vi      0.00 1111 00 . ..... 0000 . 0 ..... .....   @qrrx_s
+FDOT_hb_vi      0.00 1111 01 .. .... 0000 . 0 ..... .....   @qrrx_h
 
 # Floating-point conditional select
 
-- 
2.43.0


