Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C4CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPleA-0007E2-Iw; Wed, 20 May 2026 14:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcL-0004JF-3T
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:06 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcB-00026N-1R
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:00 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c82de129a40so2314979a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301552; x=1779906352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEP0D04kzXulzdeR9PgqunzWXDqko6qaWzHweVZbae4=;
 b=Da6KCqlIdW/vpgHRBePJXc/c72OorK6qFxBI3vtmaXC6lReK4S3rBZ72bqviFJM3aH
 88sfzj17tNKY82mJMksHeVurxPT/lWr4DkxrMeIIWD3sldyFY2n50i4It88OVE8ftoF0
 RzVwaRFbobrFCMZM2bmyA9Va4JAy5OWvHSGXxGSMZc2dgSoPcy05OQrKJVHMMSSHGXxk
 QqYRi3Zwhiwgp/dvXf+SKKAu4mpW7/4KIutkhjoKVyEyxPZ0sc4BpqZoxMNOexUKuNrv
 kMIfF154IgQSY1fWB6eTwqF5b0vjlkdnn4Qm06DBzAjCcYqqm3zCX0UDwmuEimer3Fsp
 QEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301552; x=1779906352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HEP0D04kzXulzdeR9PgqunzWXDqko6qaWzHweVZbae4=;
 b=AvUMgVg1kT2AaYR3YuMWMzA+lliKizxZm43+o9fGlXvVzVu2uuiRah/gWPGZS//aIf
 XtW0rxtDa6jLOBFtFvm7H+AC5/uw2cqfHCLt9VGvRYUXNWxxIbW1TpmjJHB4s6Xoa+6p
 M3hxqno6qXmlF57jdPtEkBGVlNpWuHbLnNxJ71zT7uDn4LCqUNavIsGlX55fyy+nEp9y
 ZRtNMoSPRw+3iNyXB9l4l/5/XadNwbd/n3ASKw7dIshuiQtzLM0Kttu640XpULWx7t7+
 2Ar5PzQvTatAC7Wb9pLvch5jEArNj5SCsbON3wq5yJY6uOsBwv556zxPTyvyVAk4QO9a
 taOA==
X-Gm-Message-State: AOJu0Yz7Vm8RJMj4N21GY+bhRY60BERBjdzDJeBPkhREUf3aMd40ur2K
 zy9nWdQChxVy91tkpR+FSkKHTeVx2qWcGDkr2f8Y6AOWw0LxyvVXbpLVbXcfMSGkX2uu0J3xAVA
 nKz4UpCo=
X-Gm-Gg: Acq92OEXxF8xB+sUzBIeBqDPzsaTSpAuGIX3F97BFF3SayDbnWk814w1DFu8OdfX+OT
 g5bdwC36hXLsgevfjrhX/+iFH8sLwu3uFLlP2S9DwpNoRHR0xtcZtO167ae70/rq3Du4JlKPNO0
 t84oYJuU7IebQ5POlobrEcM1LIZ0j9dQsMfHpux3WqifRWGDGUwPBbdnmq62BY88+1+KxNJVP8I
 NpEeETd8B2848TmsufFhAo4eV7+Rbfa8jvmbth6Z3haedX7YJaFJeRjsktiCHZKeUoxpkzzBlIP
 bzKDZdrgx6LNjYZFVTRxbLqObL/kNYaIAo0MKd5fup1IpDkLumZkakYMusP55JwaxK6lYNFH/vl
 zBe8+EeWXMsQzxNJaPxEdm4wi2XuGjQvDPNzZc32iPmUdajXlqiEf90/h8i55oTZDriO4+ZLz9a
 2TOd0AIwHPS+t8tqr5rJ/Z7t691RZd5GisXttBzvc=
X-Received: by 2002:a05:6a20:3d1d:b0:3b1:6649:e524 with SMTP id
 adf61e73a8af0-3b22ebdbb2fmr29041730637.33.1779301552395; 
 Wed, 20 May 2026 11:25:52 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 51/64] target/arm: Implement FDOT (FP8 to FP32) for AdvSIMD
Date: Wed, 20 May 2026 11:22:00 -0700
Message-ID: <20260520182213.872945-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
 target/arm/tcg/fp8_helper.c      | 39 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 30 ++++++++++++++++++++++++
 target/arm/tcg/a64.decode        |  4 ++++
 5 files changed, 81 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c0b646415c..fbce0386ef 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1600,6 +1600,11 @@ static inline bool isar_feature_aa64_f8fma(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8FMA);
 }
 
+static inline bool isar_feature_aa64_f8dp4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8DP4);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 802a3b430e..ee6f2e9236 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -29,3 +29,6 @@ DEF_HELPER_FLAGS_5(gvec_fmla_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmla_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fdot_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index a6e989f6b3..c9659eac35 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -729,3 +729,42 @@ void HELPER(gvec_fmla_idx_sb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fdot_sb)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float32 *d = vd;
+
+    for (size_t i = 0; i < nelem; i++) {
+        d[i] = f8dotadd_s(n[i], m[i], 4, d[i], &ctx);
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fdot_idx_sb)(void *vd, void *vn, void *vm,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t idx = simd_data(desc);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float32 *d = vd;
+    size_t i = 0;
+
+    do {
+        uint32_t e1 = m[i + H4(idx)];
+        do {
+            d[i] = f8dotadd_s(n[i], e1, 4, d[i], &ctx);
+        } while (++i % 4 != 0);
+    } while (i < nelem);
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 946c16d439..8ea63e94fe 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7403,6 +7403,36 @@ TRANS_FEAT(FMLAL_hb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
 TRANS_FEAT(FMLALL_sb_v, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
 TRANS_FEAT(FMLALL_sb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
 
+static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
+                     gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, a->q ? 16 : 8, vec_full_reg_size(s),
+                           0, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
+
+static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
+                         gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, a->q ? 16 : 8, vec_full_reg_size(s),
+                           a->idx, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(FDOT_sb_vi, aa64_f8dp4, do_f8dot_idx, a, gen_helper_gvec_fdot_idx_sb)
+
 static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                                gen_helper_gvec_3 * const fns[2])
 {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ef6d7dfeaa..d78a3d5486 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1213,6 +1213,8 @@ FMLAL_hb_v      0 idxn:1 00 1110 110 rm:5 11111 1 rn:5 rd:5 \
 FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
                 &rxx idxm=0 idxn=%fmlall_idxn
 
+FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1337,6 +1339,8 @@ FMLAL_hb_vi     0 idxn:1 00 1111 11 ... rm:3 0000 . 0 rn:5 rd:5 \
 FMLALL_sb_vi    0 . 10 1111 0 . ... rm:3 1000 . 0 rn:5 rd:5 \
                 &rxx idxm=%hlm4 idxn=%fmlall_idxn
 
+FDOT_sb_vi      0.00 1111 00 . ..... 0000 . 0 ..... .....   @qrrx_s
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
-- 
2.43.0


