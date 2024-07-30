Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98562C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 15:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpF5-0001L6-1V; Tue, 30 Jul 2024 11:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpF2-0001Hn-SR
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:58:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpF0-0007bI-RV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:58:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so16884165e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722355101; x=1722959901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sh3bt0t5Dape32FkCCN2FKClc/tbQN4spe+p/+e4Yr4=;
 b=WDWPXHYI9SY14UMkhUIuwDpzU9wexqItzEebgBbIkhOG+/7y5MqrRJvw61XG2Cetsp
 Ld7uMNA1PMU5e13qyNTPg1RVaXeFrtOgtd15aUblC2Xyj3bEzWWbQmditcDAJ/tDdThu
 rOcGV1h8dT38cdIxnb8JjD6FjjGfBub1Df9zCZofYK1zu+46KuXcPezSbew0GVOinCJe
 iE5aFc7aH9/egBc+19FYuRGQfZYJFwk3FXJeesgXYY8yCn3dgnjtF14gquRpZO/yhb/q
 3yTIUa1f6lhbE9HV1ymso45IV7IJvz1nZpDEzcuwpbxVXXDpUw/m1OGsS2R0bfXynrM2
 chng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722355101; x=1722959901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sh3bt0t5Dape32FkCCN2FKClc/tbQN4spe+p/+e4Yr4=;
 b=mE7EbMY6XUIkB6LAiBsrUF8aoSMJDDMq2heVB2ZReCUoiAzy+bjN6PvtNMxvw/P+Az
 j0Ssj6DEPoMGCEBAf5i1FY2DDafBo5QOdbrckk95iSN8+QJUsdSbNU45w3T1g/aCjqfA
 Tf2hUm+EmRUdLONnkHfVpSYVGDMWlrsPemHKqOgUdnIg9V7yxIhGuG7hnunTql1doxi9
 6g4clevYq+PsFwMg+5x/B7pqjihryaNbBjgXH4R+Gp1E7en6FSuCa7AjjAbVVAVzn1Cc
 LDZugluwvrBTsQrsV2ta1x+xkrz7kQeQOOmhIzMh2uBadI/oLlyFEq2PISSm/S6A3v6V
 QPyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCYyWIfB8IHLlS/RKTbV4dR10stlZpah6HQIVbUl7ix0F7Jr1qqaft/gtXwpfGJTODHL3olBVbqMvzhqALn/ohHRcplpo=
X-Gm-Message-State: AOJu0Yw6bCjrifgBDzsHy8nvEXSy+XRc2CnK8x4Q0Hcqurtnw5Hvye0s
 FRvu2yrB7mMyNgj7nMLeT/J0DEENmtpd43mzDF/xbAsapwXcE77ApBFkbrbnOpA=
X-Google-Smtp-Source: AGHT+IEvHicMLmKy2xGJW5yJW6sq4AXCrqUspqkLPs/JOmhRJ3WJMBuqJ85A+4HJ/Fq3rBenfjpOqA==
X-Received: by 2002:a05:600c:1c0a:b0:426:60d7:d299 with SMTP id
 5b1f17b1804b1-42811d83c0bmr72907415e9.7.1722355101024; 
 Tue, 30 Jul 2024 08:58:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42805730e68sm222304515e9.9.2024.07.30.08.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 08:58:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Handle denormals correctly for FMOPA (widening)
Date: Tue, 30 Jul 2024 16:58:19 +0100
Message-Id: <20240730155819.2958924-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The FMOPA (widening) SME instruction takes pairs of half-precision
floating point values, widens them to single-precision, does a
two-way dot product and accumulates the results into a
single-precision destination.  We don't quite correctly handle the
FPCR bits FZ and FZ16 which control flushing of denormal inputs and
outputs.  This is because at the moment we pass a single float_status
value to the helper function, which then uses that configuration for
all the fp operations it does.  However, because the inputs to this
operation are float16 and the outputs are float32 we need to use the
fp_status_f16 for the float16 input widening but the normal fp_status
for everything else.  Otherwise we will apply the flushing control
FPCR.FZ16 to the 32-bit output rather than the FPCR.FZ control, and
incorrectly flush a denormal output to zero when we should not (or
vice-versa).

Pass the CPU env to the sme_fmopa_h helper instead of an fp_status
pointer, and have the helper pass an extra fp_status into the
f16_dotadd() function so that we can use the right status for the
right parts of this operation.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
NB that there's only one user of do_outprod_env() right now,
but we're going to want it also for implementing FEAT_EBF16,
because that will mean that the sma_bfmopa helper also wants to
be passed an env pointer.
---
 target/arm/tcg/helper-sme.h    |  2 +-
 target/arm/tcg/sme_helper.c    | 42 +++++++++++++++++++++++-----------
 target/arm/tcg/translate-sme.c | 25 ++++++++++++++++++--
 3 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 27eef49a11e..659867a1faf 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -121,7 +121,7 @@ DEF_HELPER_FLAGS_5(sme_addha_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme_addva_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_7(sme_fmopa_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, env, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 50bb088d048..2af2b957cb6 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -992,12 +992,23 @@ static inline uint32_t f16mop_adj_pair(uint32_t pair, uint32_t pg, uint32_t neg)
 }
 
 static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
-                          float_status *s_std, float_status *s_odd)
+                          float_status *s_f16, float_status *s_std,
+                          float_status *s_odd)
 {
-    float64 e1r = float16_to_float64(e1 & 0xffff, true, s_std);
-    float64 e1c = float16_to_float64(e1 >> 16, true, s_std);
-    float64 e2r = float16_to_float64(e2 & 0xffff, true, s_std);
-    float64 e2c = float16_to_float64(e2 >> 16, true, s_std);
+    /*
+     * We need three different float_status for different parts of this
+     * operation:
+     *  - the input conversion of the float16 values must use the
+     *    f16-specific float_status, so that the FPCR.FZ16 control is applied
+     *  - operations on float32 including the final accumulation must use
+     *    the normal float_status, so that FPCR.FZ is applied
+     *  - we have pre-set-up copy of s_std which is set to round-to-odd,
+     *    for the multiply (see below)
+     */
+    float64 e1r = float16_to_float64(e1 & 0xffff, true, s_f16);
+    float64 e1c = float16_to_float64(e1 >> 16, true, s_f16);
+    float64 e2r = float16_to_float64(e2 & 0xffff, true, s_f16);
+    float64 e2c = float16_to_float64(e2 >> 16, true, s_f16);
     float64 t64;
     float32 t32;
 
@@ -1018,21 +1029,25 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
     return float32_add(sum, t32, s_std);
 }
 
-void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, void *vst, uint32_t desc)
+void HELPER(sme_fmopa_h)(CPUARMState *env,
+                         void *vza, void *vzn, void *vzm, void *vpn,
+                         void *vpm, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) * 0x80008000u;
     uint16_t *pn = vpn, *pm = vpm;
-    float_status fpst_odd, fpst_std;
+    float_status fpst_odd, fpst_std, fpst_f16;
 
     /*
-     * Make a copy of float_status because this operation does not
-     * update the cumulative fp exception status.  It also produces
-     * default nans.  Make a second copy with round-to-odd -- see above.
+     * Make copies of fp_status and fp_status_f16, because this operation
+     * does not update the cumulative fp exception status.  It also
+     * produces default NaNs. We also need a second copy of fp_status with
+     * round-to-odd -- see above.
      */
-    fpst_std = *(float_status *)vst;
+    fpst_f16 = env->vfp.fp_status_f16;
+    fpst_std = env->vfp.fp_status;
     set_default_nan_mode(true, &fpst_std);
+    set_default_nan_mode(true, &fpst_f16);
     fpst_odd = fpst_std;
     set_float_rounding_mode(float_round_to_odd, &fpst_odd);
 
@@ -1052,7 +1067,8 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
                         uint32_t m = *(uint32_t *)(vzm + H1_4(col));
 
                         m = f16mop_adj_pair(m, pcol, 0);
-                        *a = f16_dotadd(*a, n, m, &fpst_std, &fpst_odd);
+                        *a = f16_dotadd(*a, n, m,
+                                        &fpst_f16, &fpst_std, &fpst_odd);
                     }
                     col += 4;
                     pcol >>= 4;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 185a8a917b0..8e9332f1898 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -326,8 +326,29 @@ static bool do_outprod_fpst(DisasContext *s, arg_op *a, MemOp esz,
     return true;
 }
 
-TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_fpst, a,
-           MO_32, FPST_FPCR_F16, gen_helper_sme_fmopa_h)
+static bool do_outprod_env(DisasContext *s, arg_op *a, MemOp esz,
+                           gen_helper_gvec_5_ptr *fn)
+{
+    int svl = streaming_vec_reg_size(s);
+    uint32_t desc = simd_desc(svl, svl, a->sub);
+    TCGv_ptr za, zn, zm, pn, pm;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    za = get_tile(s, esz, a->zad);
+    zn = vec_full_reg_ptr(s, a->zn);
+    zm = vec_full_reg_ptr(s, a->zm);
+    pn = pred_full_reg_ptr(s, a->pn);
+    pm = pred_full_reg_ptr(s, a->pm);
+
+    fn(tcg_env, za, zn, zm, pn, pm, tcg_constant_i32(desc));
+    return true;
+}
+
+TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_env, a,
+           MO_32, gen_helper_sme_fmopa_h)
 TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
            MO_32, FPST_FPCR, gen_helper_sme_fmopa_s)
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
-- 
2.34.1


