Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD490C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKt-0007XI-4T; Sat, 15 Aug 2026 15:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKo-0007RN-I3
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:26 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKm-0008O9-7v
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2d5335cf904so11077715ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823183; x=1787427983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GLaEYJbl0Dyipkg33zPZjuDb8MXzzFbtXmin3nDjnhY=;
 b=Ymv02PVN+jBz3209kGbbdURPXGVme/RSuDRqEmiWKk+OPvuiESmRKH1U3d4LpOWezs
 Lhh13M1N1WvcGdV/EPDY3viLhWw573UtYbYHWzOUVKq8HTS7oeBwfyGqmMqtl6wiV78h
 vNLhVsCgwXAomLpHRQz+xcDYDjspVQIFCJj1qvcbY+jARjDlSSm9vGu7RO01XkTBA722
 0S4yx1RuHOb3/AhIcsKrD4fpNfJjqogmABQZWhNPAqJPwvyMM72tf+r0FxEw2lb/C5zO
 mCS1As8svvxFXwdlNRv4xXSRDCY+BAoZfvWaSclVWTg1MxUJEtRu+aV3SEbt+q2e7jPF
 THIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823183; x=1787427983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GLaEYJbl0Dyipkg33zPZjuDb8MXzzFbtXmin3nDjnhY=;
 b=h04HAdL8ISC9NC5EtVS6/uMauaImXne8aVyy3ePnHFiJevt3jT42GstcJoC6clgsxn
 2JsfDnILPwh13F9XLhUrdUKfkFnJvdkEgsW/aFFUC8nIBt/MYns0YwXcmPtXfDI2NKrm
 ly1Kfppqmbbd6Bb41Ann0+vR3mfitb3fa+a46tTSK4rCqZVGExhbZqT1NJ1XJ5WuvsUL
 +g89Fbcc682ZmPLwT3lw0jkqtUD39wQYGO2G4kx/ZY/8MWkruY7xg4+BJZvtLp3p5Wbx
 xVl9p2miQJZZghzNiZAYLvTMoRLbo7OSpGBePuKk99gTTDKjDmaoRLpSE567gytrwi0V
 yM3g==
X-Gm-Message-State: AOJu0YwGlskg+tsKRGvu65WQ2cqzikln0VCpqIJst5LZa0NsPMTcTEYx
 RCY6g/aHHRMdW1TdA0qy5eRdu4WjBJIOksoXQISfRdGmqh8Cy6aMyTfDpTwAoJkDwuHnKqCcs7V
 dNtLf
X-Gm-Gg: AR+sD10Bi24bzB27MNIHG650RA+TksRX83nRVSmTAsUKOazf7p8GW6amE7WPBau2C+8
 LOBfZ/SK7wCDa/z8ggQdFwi4DaFCLpuS06oZk7VWi1SitM2ZjJa3NJELOegNabwJ45V3VBd5lAZ
 i8K3AbXhKK25m+0G1/RWt/nUU5yjP0NlSIwbWoTGoRe5EbFxDJRVVUojyjZDjrWqR7ue/jL/lHv
 Ex08xX5r1AHDo52PTPtlmeLtnPOCLxYuD80u6OQ+v+BUL9a4VbZ67lwKHyRPvog13pVXJ4PSZtd
 +cewXybiTYmbjJ0yioJ89YD3vMnzL1+JY7o37mIRsksQRa38HFCzF+9JT5UQcwS3QxIchbuPHzx
 2wNoFEC8kAqCjZvZHwy6AruTAquEi7EUQ6zljGiOWX5i/y1Ip3ctYk7psJh/nWWo+alAk+0UH7H
 x8ZdLa10hhkRJg6xCg52rAW97JWtL4oqMJ94gyTcdEFxERdexqCWYzU79jwAD0QZgs5yHxLay1A
 zTp5ggA56S7i0AVDol2H3fXgisRtj8=
X-Received: by 2002:a17:902:c942:b0:2ca:ecfa:1308 with SMTP id
 d9443c01a7336-2d3b0cf5f6dmr144716845ad.20.1786823182914; 
 Sat, 15 Aug 2026 12:46:22 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 21/23] target/riscv: Drop v0 argument from gen_helper_ldst_us
Date: Sat, 15 Aug 2026 12:45:46 -0700
Message-ID: <20260815194549.1377505-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Since we're also passing env, v0 is always env->vreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                       | 44 ++++++++++-----------
 target/riscv/tcg/vector_helper.c            | 36 +++++++++--------
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 25 ++++--------
 3 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 542b7c264f..ffd759aef3 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -162,24 +162,24 @@ DEF_HELPER_FLAGS_3(hyp_hsv_d, TCG_CALL_NO_WG, void, env, tl, tl)
 
 /* Vector functions */
 DEF_HELPER_4(vsetvl, tl, env, tl, tl, tl)
-DEF_HELPER_5(vle8_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle16_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle32_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle64_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle8_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle16_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle32_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle64_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse8_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse16_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse32_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse64_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse8_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse16_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse32_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vse64_v_mask, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlm_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vsm_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_4(vle8_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle16_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle32_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle64_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle8_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle16_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle32_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle64_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse8_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse16_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse32_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse64_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse8_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse16_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse32_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vse64_v_mask, void, ptr, tl, env, i32)
+DEF_HELPER_4(vlm_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vsm_v, void, ptr, tl, env, i32)
 DEF_HELPER_6(vlse8_v, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vlse16_v, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vlse32_v, void, ptr, ptr, tl, tl, env, i32)
@@ -220,10 +220,10 @@ DEF_HELPER_6(vsxei64_8_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_16_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_5(vle8ff_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle16ff_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle32ff_v, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vle64ff_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_4(vle8ff_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle16ff_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle32ff_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vle64ff_v, void, ptr, tl, env, i32)
 
 DEF_HELPER_4(vl1re8_v, void, ptr, tl, env, i32)
 DEF_HELPER_4(vl1re16_v, void, ptr, tl, env, i32)
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 2a24e15a31..2548ad9c2c 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -292,11 +292,12 @@ static void vext_ldst_nf_tlb(CPURISCVState *env, void *vd, target_ulong addr,
  * stride: access vector element from strided memory
  */
 static void
-vext_ldst_stride(void *vd, void *v0, target_ulong base, target_ulong stride,
+vext_ldst_stride(void *vd, target_ulong base, target_ulong stride,
                  CPURISCVState *env, uint32_t desc, uint32_t vm,
                  vext_ldst_elem_fn_tlb *ldst_elem, uint32_t log2_esz,
                  uintptr_t ra)
 {
+    void *v0 = env->vreg;
     uint32_t nf = vext_nf(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
@@ -326,7 +327,7 @@ void HELPER(NAME)(void *vd, void * v0, target_ulong base,               \
                   uint32_t desc)                                        \
 {                                                                       \
     uint32_t vm = vext_vm(desc);                                        \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, vm, LOAD_FN,      \
+    vext_ldst_stride(vd, base, stride, env, desc, vm, LOAD_FN,          \
                      ctzl(sizeof(ETYPE)), GETPC());                     \
 }
 
@@ -341,7 +342,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
                   uint32_t desc)                                        \
 {                                                                       \
     uint32_t vm = vext_vm(desc);                                        \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, vm, STORE_FN,     \
+    vext_ldst_stride(vd, base, stride, env, desc, vm, STORE_FN,         \
                      ctzl(sizeof(ETYPE)), GETPC());                     \
 }
 
@@ -523,14 +524,14 @@ vext_ldst_us_desc(void *vd, target_ulong base, CPURISCVState *env,
  */
 
 #define GEN_VEXT_LD_US(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)          \
-QEMU_FLATTEN void HELPER(NAME##_mask)(void *vd, void *v0,               \
-    target_ulong base, CPURISCVState *env, uint32_t desc)               \
+QEMU_FLATTEN void HELPER(NAME##_mask)(void *vd, target_ulong base,      \
+                                      CPURISCVState *env, uint32_t desc) \
 {                                                                       \
     uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));             \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, false,            \
+    vext_ldst_stride(vd, base, stride, env, desc, false,                \
                      LOAD_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());        \
 }                                                                       \
-QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base,             \
                                CPURISCVState *env, uint32_t desc)       \
 {                                                                       \
     vext_ldst_us_desc(vd, base, env, desc, LOAD_FN_TLB, LOAD_FN_HOST,   \
@@ -543,15 +544,15 @@ GEN_VEXT_LD_US(vle32_v, int32_t, lde_w_tlb, lde_w_host)
 GEN_VEXT_LD_US(vle64_v, int64_t, lde_d_tlb, lde_d_host)
 
 #define GEN_VEXT_ST_US(NAME, ETYPE, STORE_FN_TLB, STORE_FN_HOST)        \
-QEMU_FLATTEN void HELPER(NAME##_mask)(void *vd, void *v0,               \
-    target_ulong base, CPURISCVState *env, uint32_t desc)               \
+QEMU_FLATTEN void HELPER(NAME##_mask)(void *vd, target_ulong base,      \
+                                      CPURISCVState *env, uint32_t desc) \
 {                                                                       \
     uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));             \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, false,            \
+    vext_ldst_stride(vd, base, stride, env, desc, false,                \
                      STORE_FN_TLB, ctzl(sizeof(ETYPE)), GETPC());       \
 }                                                                       \
-QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
-                  CPURISCVState *env, uint32_t desc)                    \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base,             \
+                               CPURISCVState *env, uint32_t desc)       \
 {                                                                       \
     vext_ldst_us_desc(vd, base, env, desc, STORE_FN_TLB, STORE_FN_HOST, \
                       ctzl(sizeof(ETYPE)), env->vl, GETPC(), false);    \
@@ -565,7 +566,7 @@ GEN_VEXT_ST_US(vse64_v, int64_t, ste_d_tlb, ste_d_host)
 /*
  * unit stride mask load and store, EEW = 1
  */
-QEMU_FLATTEN void HELPER(vlm_v)(void *vd, void *v0, target_ulong base,
+QEMU_FLATTEN void HELPER(vlm_v)(void *vd, target_ulong base,
                                 CPURISCVState *env, uint32_t desc)
 {
     /* evl = ceil(vl/8) */
@@ -574,7 +575,7 @@ QEMU_FLATTEN void HELPER(vlm_v)(void *vd, void *v0, target_ulong base,
                       0, evl, GETPC(), true);
 }
 
-QEMU_FLATTEN void HELPER(vsm_v)(void *vd, void *v0, target_ulong base,
+QEMU_FLATTEN void HELPER(vsm_v)(void *vd, target_ulong base,
                                 CPURISCVState *env, uint32_t desc)
 {
     /* evl = ceil(vl/8) */
@@ -692,10 +693,11 @@ GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d_tlb)
  * unit-stride fault-only-fisrt load instructions
  */
 static void
-vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
+vext_ldff(void *vd, target_ulong base, CPURISCVState *env,
           uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
           vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz, uintptr_t ra)
 {
+    void *v0 = env->vreg;
     uint32_t i = env->vstart, vl = env->vl;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
@@ -925,10 +927,10 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
 }
 
 #define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)           \
-QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
+QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base,             \
                                CPURISCVState *env, uint32_t desc)       \
 {                                                                       \
-    vext_ldff(vd, v0, base, env, desc, LOAD_FN_TLB,                     \
+    vext_ldff(vd, base, env, desc, LOAD_FN_TLB,                         \
               LOAD_FN_HOST, ctzl(sizeof(ETYPE)), GETPC());              \
 }
 
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 3916236762..3d32564660 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -690,8 +690,7 @@ static uint8_t vext_get_emul(DisasContext *s, uint8_t eew)
 /*
  *** unit stride load and store
  */
-typedef void gen_helper_ldst_us(TCGv_ptr, TCGv_ptr, TCGv,
-                                TCGv_env, TCGv_i32);
+typedef void gen_helper_ldst_us(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
 
 static uint32_t vdata_add_memopidx(DisasContext *s, uint32_t data)
 {
@@ -705,14 +704,10 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
                           gen_helper_ldst_us *fn, DisasContext *s,
                           bool is_store)
 {
-    TCGv_ptr dest, mask;
-    TCGv base;
+    TCGv_ptr dest = tcg_temp_new_ptr();
+    TCGv base = get_gpr(s, rs1, EXT_NONE);
     TCGv_i32 desc;
 
-    dest = tcg_temp_new_ptr();
-    mask = tcg_temp_new_ptr();
-    base = get_gpr(s, rs1, EXT_NONE);
-
     /*
      * As simd_desc supports at most 2048 bytes, and in this implementation,
      * the max vector group length is 4096 bytes. So split it into two parts.
@@ -725,7 +720,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
                                       s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
-    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
     /*
      * According to the specification
@@ -745,7 +739,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
 
     mark_vs_dirty(s);
 
-    fn(dest, mask, base, tcg_env, desc);
+    fn(dest, base, tcg_env, desc);
 
     if (!is_store && s->ztso) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
@@ -1133,22 +1127,17 @@ GEN_VEXT_TRANS(vsxei64_v, MO_64, rnfvm, st_index_op, st_index_check)
 static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
                        gen_helper_ldst_us *fn, DisasContext *s)
 {
-    TCGv_ptr dest, mask;
-    TCGv base;
+    TCGv_ptr dest = tcg_temp_new_ptr();
+    TCGv base = get_gpr(s, rs1, EXT_NONE);
     TCGv_i32 desc;
 
-    dest = tcg_temp_new_ptr();
-    mask = tcg_temp_new_ptr();
-    base = get_gpr(s, rs1, EXT_NONE);
-
     data = vdata_add_memopidx(s, data);
     desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
                                       s->cfg_ptr->vlenb, data));
 
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
-    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, base, tcg_env, desc);
+    fn(dest, base, tcg_env, desc);
 
     finalize_rvv_inst(s);
 
-- 
2.43.0


