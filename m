Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19BECD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcI6-0006in-7S; Tue, 02 Jun 2026 23:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcI4-0006gt-1x
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:12 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcI1-0003eu-Sp
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:11 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c858d69bde9so1664600a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457348; x=1781062148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g50CT4whMkEWMsWeDnJtJ5B0M4G//T1UV0U4fMA0Fto=;
 b=BjbWmsv4EzrtlXM8XymWYbwL9xRhxLRb9+6+o4do+rLlyb2v+32J4qBRT4o520V9hY
 G5NfGB7EPjlhgMHBhrYzm+tex9db0O/49so5vQSvALOHkrQCoNIFHRC0Slq6iR9w1KNq
 /a/TeeFQ+BQ4R3x06t+y9SHM5kBSDLh/2ebaMrxdqcRyeBDT1yGKKdBFVAXnh3toiKAw
 GwMcoXluAMiWm4gdkLlgcjVNWi2EV6aSfD0cc96BhXnDcbNyEBliT0r6MNajoeIvqh0u
 YJ8q7Y668yCmMgFiPT3CLXxNmyY3TU1jyxtWt6q5BkwNUHGLzxXrtdui3OlveZlVgBmV
 vy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457348; x=1781062148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g50CT4whMkEWMsWeDnJtJ5B0M4G//T1UV0U4fMA0Fto=;
 b=jy2upG20z2iQV+J+e6PQiJxdUjD2wndrFY5ZYAR4nLT8nzv/1rf4MTcEnPv1mXFi0m
 +LSF4lLCM/yeBHCK+SOVs9jzn/A4175WyNgP6kXr65QNFp7Q/lBXM5j2iDy/ZihS1H/i
 O02mZ5KKHQ34fIGNCYsSPZHLjNK7fUgB02bSYH5nyy0M/7paHdpEncLLuhCgk0CSbvn+
 O6JYqkMxWXyhSJ3ahoGcQAdbOyrMarHIeAe+T1RlUfPkRl/SocTBSsfQWjbaYgKYjyl6
 ut+0AkxlVrL0dfqbZiznZkSh1QMoc4QobNNwcEr9sfdZsOAq+vSqayPUf8V4p25nCm0p
 2xqg==
X-Gm-Message-State: AOJu0YzqqIFh0/xD/cvzJPMLp+BU1oUUzvgeN/z//M0QqZkoJ4rI+v8K
 260UBRG4QpevYIzXXCihTfe6OfolCyJ7ji3zr85BXc7tiSQmnbYAeapvfEv/ajr0hsDzqqlZuRw
 RgoXUaQs=
X-Gm-Gg: Acq92OG1AdKt07T7l/Nx23QcuAcSHbnbyT7zWhbSwNNvbEUv3CD7FUVhDZm/nvh+3Il
 P3Fg0YR9Hn/lAySYIgKJbE6sKtMujyOT3ilaNlpp0APSLeuXUTLuxFL/wVdoHXsMTe8rM53K2ys
 yd3U0T7gRS1K0pFoXTYBRy7GbXUWOEhisXpTLBc2pb04fG0s3MVgyiKmmbKppUAUTRQM+SWMKNQ
 X+Rm3BwmaLUzwDtzdSM3T8fvsggRlvDSvC7dFg9iBZeVlaGc+XCdYgbpKWuaQb8dpPhBroAHL2z
 VgOy3hTpzwLeHvg0Y7ySxPpveRH6aauw+LeplIQj3yam8RZYQdJNrY54kQu32ivZbeidM05XkEv
 mhiqwCDdEYWjG7mKZpIhBpPgxabVMigYFOLGfWrM1//hrdHb/BqBLHOZ+rkCKt/WnaK8m8rrt+P
 +pXGq6ei53AJiuhsqYzLf+KH5HndyF2DvjodNXQcM=
X-Received: by 2002:a05:6a00:1d9a:b0:82a:780f:a187 with SMTP id
 d2e1a72fcca58-84284f34361mr1538200b3a.36.1780457348196; 
 Tue, 02 Jun 2026 20:29:08 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 17/45] target/arm: Implement FCVTN (16- to 8-bit fp) for SVE
Date: Tue,  2 Jun 2026 20:28:26 -0700
Message-ID: <20260603032855.106930-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 23 +++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  2 ++
 target/arm/tcg/sve.decode        |  1 +
 4 files changed, 27 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 023a49e12f..e67fb191c2 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -16,5 +16,6 @@ DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 0b86ed9eb9..8295725b83 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -414,6 +414,29 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
 
+void HELPER(sve2_fcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, true);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint16_t *n0 = vn;
+    uint16_t *n1 = vn + sizeof(ARMVectorReg);
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        float16 e0 = n0[H2(i)];
+        float16 e1 = n1[H2(i)];
+        d[H1(2 * i + 0)] = fcvt_f16_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(2 * i + 1)] = fcvt_f16_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
+
 void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
                              CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index eccb5b191c..df2b89cad6 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4100,6 +4100,8 @@ TRANS_FEAT_STREAMING_IF(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
 TRANS_FEAT_STREAMING_IF(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
                         do_f8cvt, a, gen_helper_sve2_bfcvt, true, true)
 
+TRANS_FEAT(FCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_fcvtn_bh, false, false)
 TRANS_FEAT(BFCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
            a, gen_helper_sve2_bfcvtn_bh, false, false)
 
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index b6ef8ed8de..806953bc35 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1101,6 +1101,7 @@ BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
 BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
 BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
 
+FCVTN           01100101 00 001 010 001100 ....0 .....          @rd_rnx2 esz=1
 BFCVTN          01100101 00 001 010 001110 ....0 .....          @rd_rnx2 esz=1
 
 ### SVE FP Compare with Zero Group
-- 
2.43.0


