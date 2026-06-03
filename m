Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94111CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcIY-0007I7-QP; Tue, 02 Jun 2026 23:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcIK-0006wZ-R2
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:28 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcII-0003mM-46
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:28 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8423f626a65so1313911b3a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457363; x=1781062163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EjZound3dcsP9QXbzFXKBLvB4E5pBYThLEA5yZHeMLg=;
 b=OUeRtRfsHgmDokANLtigXRgEeAHAfKJmuwLZ1NVuAWmA11jqsUgow3axanKP8PC2RR
 RnizFsKwlCCW+lj2/+58jaQaFjfkT+F3jyEMMib/HIBEb4qM6qCa3gnk2QkNtd7EWG3c
 QpXxE2f8tyYcWOzJFZoz/hnBA9aiVO5mdKUqnixNhCSfnZ1s1ioThQfpvcJitawPDn5r
 8hsmcM3RgJfp/XYhKfu+DVRN976bflF6ADHyqKX0blNerlnGvTJ7X83x688hQd4yCdh6
 tphDZkdOyRmd7qt8E6DZd5OgkgN/KOvNOh7M1+HEFm7vLdXStIScSnqjZEx6aeFzsliz
 qcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457363; x=1781062163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EjZound3dcsP9QXbzFXKBLvB4E5pBYThLEA5yZHeMLg=;
 b=b0G7BW6HdfV/7S1UbfJ89PVmn4eztUU+fmJcqLkc21mVwiat4F7Wu51MO8vxMxI799
 sQaAO7AXQf7y6NmAR9dEd9cak9Uvb/gRuhuNtDECjsoZP+j8zCbXyP0MCSD477XuZ29u
 OiYDZ8Elbu/m+OEokHFei652cR0TQ88lZYih3/CAIccTHeJcrysPg4yz4EiaG86CQMZU
 CWPJL5qw7GlXxe5dJ812nf7wvdQPskMke+/q3QppZgjF+iQj7qLoO/4Rv87lr1nSy/ws
 pd61JeX4nk728UGjPCpBB0oyI0c7AIhlq2YKYGo/82WNezQf0ZFhXnAMVco8qHdLY77o
 kcMw==
X-Gm-Message-State: AOJu0Yx5v4MecKo5VdnVueiL6IequOvVHIBnRmQxm0JinjqWP5Dw1PSZ
 iTGKN5zkr9/sToaUUW6R5OPbZXkrITfKdYs+Yc6pA6DGvQleHixCvDSOm4lzpW89BZhTbiz5QeF
 DwNF85Nc=
X-Gm-Gg: Acq92OFLXSwaY9O3sfLdoESw3A6O+TtnfwLmAx7TOx8uq48wHroa2ZMZ0Q0dU9N49+s
 DHhWaLZjqgYwTGC+PIU6psRRWpBXo97lusFhmcvA3dUNpBuh+8zvnjLgMWMsax2yWOG0YfcLLnE
 4WEFAgUDTX6Ubh4Sx2N9rtq2kGOVRTNHxPTAD/hSWaiiK5qWohosqVR6FHRzDex9EBPtkzzC9og
 ep4y4SC2ecqaBmwiK5D8iMvx5qnOOcXppCpZxeQBkk6qGASXlFUJdELs5l1Svi49ke1DxQ3oa5Q
 0E3BpppZOhRMUiBrxs+HJeXB2gkxpzqVyGjtvsw5vU0dKkbPNcpBh9MeL0LXs4TVZVidVlEq3XK
 lquIijal2hWj2yfl4E6JgJUaqbowdnkgYdGVq4KKI5Rq6oWa9Qfu71X6FbtdrM9L6LOy0vnYCdi
 1xnSl25KM/MbLiIPU9fifs2QvL067IP6awRkZhHLMg/NRuXEvM5Q==
X-Received: by 2002:a05:6a00:4b14:b0:842:2f3d:dff2 with SMTP id
 d2e1a72fcca58-84284fc0529mr1556941b3a.34.1780457363256; 
 Tue, 02 Jun 2026 20:29:23 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 37/45] target/arm: Implement FDOT (FP8 to FP16) for AdvSIMD
Date: Tue,  2 Jun 2026 20:28:46 -0700
Message-ID: <20260603032855.106930-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-fp8-defs.h |  3 +++
 target/arm/tcg/fp8_helper.c      | 39 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  2 ++
 target/arm/tcg/a64.decode        |  2 ++
 5 files changed, 51 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index fbf4decd74..f6184b80de 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1620,6 +1620,11 @@ static inline bool isar_feature_aa64_f8dp4(const ARMISARegisters *id)
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
index d1d5b22cbf..a25e0a1d92 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -767,3 +767,42 @@ void HELPER(gvec_fdot_idx_sb)(void *vd, void *vn, void *vm,
 
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
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 960de1aa86..83d90cfcf4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7500,6 +7500,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 }
 
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
+TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
@@ -7515,6 +7516,7 @@ static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
 }
 
 TRANS_FEAT(FDOT_sb_vi, aa64_f8dp4, do_f8dot_idx, a, gen_helper_gvec_fdot_idx_sb)
+TRANS_FEAT(FDOT_hb_vi, aa64_f8dp2, do_f8dot_idx, a, gen_helper_gvec_fdot_idx_hb)
 
 static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                                gen_helper_gvec_3 * const fns[2])
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 08c493c11e..a3e404e7fe 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1225,6 +1225,7 @@ FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
                 &rxx idxm=0 idxn=%fmlall_idxn
 
 FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
+FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
@@ -1351,6 +1352,7 @@ FMLALL_sb_vi    0 . 10 1111 0 . ... rm:3 1000 . 0 rn:5 rd:5 \
                 &rxx idxm=%hlm4 idxn=%fmlall_idxn
 
 FDOT_sb_vi      0.00 1111 00 . ..... 0000 . 0 ..... .....   @qrrx_s
+FDOT_hb_vi      0.00 1111 01 .. .... 0000 . 0 ..... .....   @qrrx_h
 
 # Floating-point conditional select
 
-- 
2.43.0


