Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C0DCD37AD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8Oj-0000iO-2v; Thu, 07 May 2026 19:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Og-0000bs-BD
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:50 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Oe-0001CA-4f
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:49 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dccda31d3eso414480a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197487; x=1778802287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sP+K2tbCgSUftpd/Tdb2XmRTjIgbfy+soYsG6OjQAfs=;
 b=EdVxTv/C3OrK4E6dM5bECsCA2/sNw+HSums3xrat+0o3nK7Fqojz2KjigEZjlBn/u3
 PBXLmlBzPTgFJ4MeBxEMpIUxHQZ8CLkbe03C75A+NHIXq7YY11pktgFaI+wcfpUQd9eH
 3vX/OULFYGU11ELtjrQqh9BAA8ge1nwEZWvffscP2OywVbCHryD1qJvCYMmCCZSeWi3/
 2BobMrAPaxxoXWg43iav99YYYsz6yaEZHDfFiehrkJZotY2HerSUnPUoQahQOPP5N78A
 FPFLLfLp1P5aU44/e9Q9dPFd6/sYylyVbeKXcKE7Ayh+MX+CRzG/IJjZ2Qj12nu1yHTN
 0yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197487; x=1778802287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sP+K2tbCgSUftpd/Tdb2XmRTjIgbfy+soYsG6OjQAfs=;
 b=I7BMFsiv1uou0qb+U52c4xCO4X0fyFNggAf2q8x0/0cZ3qdF5RXkBzzkxkr4WfwANI
 H+z6c+l0ongQIVMWJkUkiOFDCTIkwD9SdUnW4xdBV+i8nrhniKJ5MVE+ULn0+PFufGy6
 f7BFXI8X0Lilsy/7Q1cMyi2tMuWI/ivDk1vsvrlNWFfENHrrL1zKtQViUqBjvI7HV8Gt
 aaxVk/RxF3Q2+FHCuZ2Z/Soc6SbFYhtP6LEAiAaoyHD+KuPp830oiZ2NM6T6cLo2pNE5
 xNpYjpCqdOmXAjJqWt0v1gHii+tfn4DJUMdqR975ROilwRAx0CM0Ul4HyJjXzokKg9Fr
 J/Mg==
X-Gm-Message-State: AOJu0YwwwL5w5H4eIunzG94Ug6lLjtqZaql/TLqEFNbA90lFnzwEZYid
 r4hWhnoDgs017wadcOaZHeb0JzDBz4QMYJgEtMv/HIn8Cs0BHO0IdNkzR0Gvlb4i9EbqXJfOBYD
 XKDvt
X-Gm-Gg: AeBDiesJLNjT7H3mYkKEQb1F0+VHEGHp62yowHNlx8ar+nsSSw3GC3MO5Rm/WLKnGdb
 +r7iarjJsweSwJ6lDxEVZuTHHvrjI31obw+OCNsoNACpcp0LL+Fl3mz0uMPR7A0y5KMAPlm7+2n
 faBPX+L6HwltH+3luXdD13KFSyjSGWcPCBT5kxZK2tlCsUiKSluisfZL6Q5f2IoDK1VliebFmNX
 dJROBeOLtMnjXQVJOlX/YnOEZTCwPpjQ2Hhl0VbECXAjWlh3V+genfihOrYvY3f3c3hyAthjJkK
 dKgBavUH2NSURcyH62nu2qbaoprSsZ5h+lZlNcrvO1xVa0hJ3fMQEN5y9s0J3oizSngbCgGckkZ
 iaKB33gfP3CQrxDILQ3sDgw6WlPj1Oi9ddtiRH8+/V2y/lVhlKmK0nSMbvxL218PdsDaMzlgACp
 kg/AB1/nVAen44X2MiHruVrRbaIn5sdqzfVVj2nlLkB0PykMNxFjul8MoA
X-Received: by 2002:a05:6830:6005:b0:7dc:c4ae:a689 with SMTP id
 46e09a7af769-7e1deebc5b6mr5797723a34.2.1778197486980; 
 Thu, 07 May 2026 16:44:46 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 33/60] target/arm: Implement FCVTNB, FCVTNT for SVE
Date: Thu,  7 May 2026 18:43:46 -0500
Message-ID: <20260507234413.643512-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 47 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  4 +++
 target/arm/tcg/sve.decode        |  2 ++
 4 files changed, 55 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index e67fb191c2..5863a6dbb8 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -19,3 +19,5 @@ DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtnb_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtnt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 6588768ba1..55b09c689c 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -457,3 +457,50 @@ void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
     fp8_finish(env, &ctx);
     clear_tail(vd, ctx.high ? 16 : 8, simd_maxsz(desc));
 }
+
+void HELPER(sve2_fcvtnb_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint16_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        float32 e0 = n0[H4(i)];
+        float32 e1 = n1[H4(i)];
+        /* Zero-extend uint8_t to clear the odd lanes. */
+        d[H2(2 * i + 0)] = fcvt_f32_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H2(2 * i + 1)] = fcvt_f32_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_finish(env, &ctx);
+}
+
+void HELPER(sve2_fcvtnt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        float32 e0 = n0[H4(i)];
+        float32 e1 = n1[H4(i)];
+        d[H1(4 * i + 1)] = fcvt_f32_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 3)] = fcvt_f32_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c7fcf27183..13f7ab01af 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4103,6 +4103,10 @@ TRANS_FEAT(FCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
            a, gen_helper_sve2_fcvtn_bh, false, false)
 TRANS_FEAT(BFCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
            a, gen_helper_sve2_bfcvtn_bh, false, false)
+TRANS_FEAT(FCVTNB, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_fcvtnb_bs, false, false)
+TRANS_FEAT(FCVTNT, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_fcvtnt_bs, false, false)
 
 /*
  *** SVE Floating Point Compare with Zero Group
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 806953bc35..72755b27af 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1103,6 +1103,8 @@ BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
 
 FCVTN           01100101 00 001 010 001100 ....0 .....          @rd_rnx2 esz=1
 BFCVTN          01100101 00 001 010 001110 ....0 .....          @rd_rnx2 esz=1
+FCVTNB          01100101 00 001 010 001101 ....0 .....          @rd_rnx2 esz=2
+FCVTNT          01100101 00 001 010 001111 ....0 .....          @rd_rnx2 esz=2
 
 ### SVE FP Compare with Zero Group
 
-- 
2.43.0


