Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D9FC71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT85p-0006Kf-9z; Sat, 21 Jun 2025 19:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85Z-0004ze-3G
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:38 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85W-0006b0-Dh
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso3859493b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550253; x=1751155053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5yeVoQTmh9AWE7UakLvO8n0NpwRYLXewldR7T5A9uH8=;
 b=Os8Ec32ZTdlvGRESDKg22bgOAzV3BLuYiHWOtV/+CVGP8CRuwDobtFULYhuihBQAbX
 tQwBr/yu7IFocMZbWMElM5QYaPkYm4t/VAX/O9FvJLDysY03+P8jA2Np3CeTuybJvRc5
 mv3+5ESAmnZBsF2LXgPERpm+ZqozaPRsFmDOt2Yk/Vfx3ciYbkQrpxHURwQy4gIC1rzW
 CCC3b3OLcccyzYaA4M/z9Qm6zq5rpan797rTQdl9uzcXjFI99DruI0iFcUUxEtnacsBR
 HK6hpkngnSUBQmXnnXE504rsQO9eNNL5Zntj/wa6BitGWLqrT5J6DmrEUxGnxepHMRxy
 BXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550253; x=1751155053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yeVoQTmh9AWE7UakLvO8n0NpwRYLXewldR7T5A9uH8=;
 b=GCmANDlrnaUepjg84iaIIIH4anX85yNoUw5PgZGnx9TJOK4x6RHN3LWysgb4q5Qnw5
 CH+7soBXzq2g1P82ehnSPOEkWFO1vfCeeH3KbiDfxGAzExDFVxcS110zpPFFs2IKcNUN
 KACOTaIKdYPUX8AriWJxYc7+8tQimCNBrGQN2ZrKzj4viwcqOOAv/UnUPU46R7qRJzqC
 UgJODL9hfCLzFCcioQrsBKqq4cVyYvaDgRbYPLE6XVAEkuNFb5P/IKoCG/ug7Rym396W
 nqLbUFzC9ctVnx0vqMebJDyEg0klGm1eQpl1ajEDkqGnI9v974yjZPgdd8DkHM8Fsjud
 w/HA==
X-Gm-Message-State: AOJu0Yx1lzXUTiadlVO3sglEHAsxu0FzWBE/1abJ4GnLAA8aYG8bs1Al
 64Zspq3QZ5s2nXyHCDG+99nfr6uOFUI7AZdCJFBrKwzq28vul4+CPkNYf8XZvd271LY4iw0gxx9
 7o53WxP8=
X-Gm-Gg: ASbGncs7gCZ6lRVN2BRaGb5ccc0b2/UArqhjZhOp42kOoi0QMIKY5LlAx0VBsR35DFl
 MVC/Sj9FPurUcJpgqQB4Aoa8soaB02rKDwd92j1okir9KcwezWcGDz9z2+Rhm3ddcV/DDcKHCru
 w+aFTa3sRSFL9+9fbHUD5Oqcl6kic9OFlzeDcBGtbh4vGAcC63bHPqrrSP3ysuthjSvEqcv+MCW
 d2XdPkDLFO4KwPZt4no4+sphTR+TCQYLr/iAM8RDchm902dDCc+8W4VIzcQgUxINLH1QhrsWmCo
 E3r/BbieiKwvooDidpGbWpI0xpy4bZfoxauve9IwK/G6Pl1lXdFxHux6pdHYsjbxCwI25VG9kaJ
 3G2zQUOonpV+uQLVMtvFO
X-Google-Smtp-Source: AGHT+IFRPrv3mTqNIcHUHfwkKi+1feYjernsqR4X6e1K/XWDxxckAwk8GX4ZOOwILc6z3LKE5J4sEg==
X-Received: by 2002:a05:6a20:914d:b0:1f5:889c:3cbd with SMTP id
 adf61e73a8af0-22026f00cefmr13718546637.35.1750550252916; 
 Sat, 21 Jun 2025 16:57:32 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 084/101] target/arm: Implement BFMLSLB{L, T} for SME2/SVE2p1
Date: Sat, 21 Jun 2025 16:50:20 -0700
Message-ID: <20250621235037.74091-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/arm/tcg/helper.h        |  8 +++++
 target/arm/tcg/translate-sve.c | 30 ++++++++++++++++++
 target/arm/tcg/vec_helper.c    | 56 ++++++++++++++++++++++++++--------
 target/arm/tcg/sve.decode      |  7 +++++
 4 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index f1e6c7cf3f..7e49ecc8b5 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -1106,8 +1106,16 @@ DEF_HELPER_FLAGS_6(gvec_bfmmla, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(gvec_bfmlal, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmlsl, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_ah_bfmlsl, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_bfmlal_idx, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmlsl_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_ah_bfmlsl_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_sclamp_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 414c3ff759..f3ac0f6300 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7375,6 +7375,36 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
 TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
 TRANS_FEAT(BFMLALT_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, true)
 
+static bool do_BFMLSL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
+{
+    if (s->fpcr_ah) {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_ah_bfmlsl,
+                                  a->rd, a->rn, a->rm, a->ra, sel, FPST_AH);
+    } else {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlsl,
+                                  a->rd, a->rn, a->rm, a->ra, sel, FPST_A64);
+    }
+}
+
+TRANS_FEAT(BFMLSLB_zzzw, aa64_sme2_or_sve2p1, do_BFMLSL_zzzw, a, false)
+TRANS_FEAT(BFMLSLT_zzzw, aa64_sme2_or_sve2p1, do_BFMLSL_zzzw, a, true)
+
+static bool do_BFMLSL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
+{
+    if (s->fpcr_ah) {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_ah_bfmlsl_idx,
+                                  a->rd, a->rn, a->rm, a->ra,
+                                  (a->index << 1) | sel, FPST_AH);
+    } else {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlsl_idx,
+                                  a->rd, a->rn, a->rm, a->ra,
+                                  (a->index << 1) | sel, FPST_A64);
+    }
+}
+
+TRANS_FEAT(BFMLSLB_zzxw, aa64_sme2_or_sve2p1, do_BFMLSL_zzxw, a, false)
+TRANS_FEAT(BFMLSLT_zzxw, aa64_sme2_or_sve2p1, do_BFMLSL_zzxw, a, true)
+
 static bool trans_PSEL(DisasContext *s, arg_psel *a)
 {
     int vl = vec_full_reg_size(s);
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index e41386861e..53785b9f1c 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3272,44 +3272,76 @@ void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_bfmlal)(void *vd, void *vn, void *vm, void *va,
-                         float_status *stat, uint32_t desc)
+static void do_bfmlal(float32 *d, bfloat16 *n, bfloat16 *m, float32 *a,
+                      float_status *stat, uint32_t desc, int negx, int negf)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
     intptr_t sel = simd_data(desc);
-    float32 *d = vd, *a = va;
-    bfloat16 *n = vn, *m = vm;
 
     for (i = 0; i < opr_sz / 4; ++i) {
-        float32 nn = n[H2(i * 2 + sel)] << 16;
+        float32 nn = (negx ^ n[H2(i * 2 + sel)]) << 16;
         float32 mm = m[H2(i * 2 + sel)] << 16;
-        d[H4(i)] = float32_muladd(nn, mm, a[H4(i)], 0, stat);
+        d[H4(i)] = float32_muladd(nn, mm, a[H4(i)], negf, stat);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_bfmlal_idx)(void *vd, void *vn, void *vm,
-                             void *va, float_status *stat, uint32_t desc)
+void HELPER(gvec_bfmlal)(void *vd, void *vn, void *vm, void *va,
+                         float_status *stat, uint32_t desc)
+{
+    do_bfmlal(vd, vn, vm, va, stat, desc, 0, 0);
+}
+
+void HELPER(gvec_bfmlsl)(void *vd, void *vn, void *vm, void *va,
+                         float_status *stat, uint32_t desc)
+{
+    do_bfmlal(vd, vn, vm, va, stat, desc, 0x8000, 0);
+}
+
+void HELPER(gvec_ah_bfmlsl)(void *vd, void *vn, void *vm, void *va,
+                            float_status *stat, uint32_t desc)
+{
+    do_bfmlal(vd, vn, vm, va, stat, desc, 0, float_muladd_negate_product);
+}
+
+static void do_bfmlal_idx(float32 *d, bfloat16 *n, bfloat16 *m, float32 *a,
+                          float_status *stat, uint32_t desc, int negx, int negf)
 {
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 1, 3);
     intptr_t elements = opr_sz / 4;
     intptr_t eltspersegment = MIN(16 / 4, elements);
-    float32 *d = vd, *a = va;
-    bfloat16 *n = vn, *m = vm;
 
     for (i = 0; i < elements; i += eltspersegment) {
         float32 m_idx = m[H2(2 * i + index)] << 16;
 
         for (j = i; j < i + eltspersegment; j++) {
-            float32 n_j = n[H2(2 * j + sel)] << 16;
-            d[H4(j)] = float32_muladd(n_j, m_idx, a[H4(j)], 0, stat);
+            float32 n_j = (negx ^ n[H2(2 * j + sel)]) << 16;
+            d[H4(j)] = float32_muladd(n_j, m_idx, a[H4(j)], negf, stat);
         }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(gvec_bfmlal_idx)(void *vd, void *vn, void *vm, void *va,
+                             float_status *stat, uint32_t desc)
+{
+    do_bfmlal_idx(vd, vn, vm, va, stat, desc, 0, 0);
+}
+
+void HELPER(gvec_bfmlsl_idx)(void *vd, void *vn, void *vm, void *va,
+                             float_status *stat, uint32_t desc)
+{
+    do_bfmlal_idx(vd, vn, vm, va, stat, desc, 0x8000, 0);
+}
+
+void HELPER(gvec_ah_bfmlsl_idx)(void *vd, void *vn, void *vm, void *va,
+                                float_status *stat, uint32_t desc)
+{
+    do_bfmlal_idx(vd, vn, vm, va, stat, desc, 0, float_muladd_negate_product);
+}
+
 #define DO_CLAMP(NAME, TYPE) \
 void HELPER(NAME)(void *d, void *n, void *m, void *a, uint32_t desc)    \
 {                                                                       \
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 11ce8bcc6f..0eb4fd9667 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1720,6 +1720,7 @@ FCVTLT_sd       01100100 11 0010 11 101 ... ..... .....  @rd_pg_rn_e0
 FLOGB           01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
 
 ### SVE2 floating-point multiply-add long (vectors)
+
 FMLALB_zzzw     01100100 10 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_e0
 FMLALT_zzzw     01100100 10 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_e0
 FMLSLB_zzzw     01100100 10 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_e0
@@ -1727,6 +1728,8 @@ FMLSLT_zzzw     01100100 10 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_e0
 
 BFMLALB_zzzw    01100100 11 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_e0
 BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_e0
+BFMLSLB_zzzw    01100100 11 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_e0
+BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_e0
 
 ### SVE2 floating-point dot-product
 
@@ -1734,12 +1737,16 @@ FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_e0
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_e0
 
 ### SVE2 floating-point multiply-add long (indexed)
+
 FMLALB_zzxw     01100100 10 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
 FMLALT_zzxw     01100100 10 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
 FMLSLB_zzxw     01100100 10 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
 FMLSLT_zzxw     01100100 10 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
+
 BFMLALB_zzxw    01100100 11 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
 BFMLALT_zzxw    01100100 11 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
+BFMLSLB_zzxw    01100100 11 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
+BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 
 ### SVE2 floating-point dot-product (indexed)
 
-- 
2.43.0


