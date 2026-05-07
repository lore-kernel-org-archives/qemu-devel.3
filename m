Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572A1CD37A7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8Ol-0000jg-2H; Thu, 07 May 2026 19:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Of-0000Xk-6G
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:49 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Od-0001Bl-5R
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:48 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7de44ed7a11so1211423a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197486; x=1778802286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frMLyLCvl39yyHGRVg1BfkvNzPqVXTkDy/pQM/rMJ6k=;
 b=t/rdhqnNXPIdqGJxNSYL7PueW0yvnui2Y672iTgiTdgEXzDEAB12QLmrj5KYoTPshE
 iQdYTzbhU4/NYQmgJHJvNwggDX9aSFBdbfvIS3eWBH/nBHUuPS9zPBtNVGODXs2rZ/SY
 cahL7Hh3GRP1j5EkNi8flhCYLrz7/mzY+u3YgwivpPxGQHk8EEqZK03l64zwGUlIHgCI
 8Ut/h8fXGl9xvLARveOcNSi1bPec68AAL8dJppGcNCesqd0BZxPOPgKR06dCf5aoXi/L
 xM4fEuwifRCav3ClFtZ8fqJU0cy1NUoBIr91k6iyUGt8yXSrM8/ltTJm3cOkFGgXmAXE
 EtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197486; x=1778802286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=frMLyLCvl39yyHGRVg1BfkvNzPqVXTkDy/pQM/rMJ6k=;
 b=Pz0jHNK9/qvZpq3UyH3TBMYsvoUZSb4Ud0g5gbH9wNExhgXnQi/0H+tqzr12RsVQ/N
 kc+d0+qQ3kH6cu8NSd98Uw33F9F768pZAyYDJH8zWcyO32SncB780CZmMv35pqZupkF3
 ukosKxuaWTwWd6BX+e+H99/a17RmzHCW2rBCopB0EbU/M+N82niaMEoQFQqvNhMNvcpT
 H7nvcYZTQYMuE4tUThAa/chaCa++PAJsgkUAmvdIedlId2ZEd/SfSqXPu0OsiOV9s9Xx
 EI1LIS3JcnkjPp04qg1BiL1bueiAbbyezJwbei4VYACUWYcuFJIMO2p/UvSx9lHwnal8
 MnJw==
X-Gm-Message-State: AOJu0YwMdpR8VVegElKjdjnhpP/Bb45CSHhNh0R543FzAAfwohJAvnfK
 kjNp14NVdLN5L2TV1H5QCY5LxKOODP8NjzneuAMD4eT+sxhyI3hVZxUTf0RHi6EwefzDinYVTwH
 KUG3v
X-Gm-Gg: AeBDiev/00u58HjpuyPZLeBGYBgxMGwheXfbEdT3O6iji4so0+ELG9HLQqGODGmbv2b
 XjNkKcgRIX63X9d7MHTkydRmH0ASTQcx1BAlKO7k3tkQE0C9OUyu0P1jOgL5EunVPeYaNDBqyBk
 0g7O6n0Nn9cQAvnHX3/BpARvkF4vZPB2uLaZUcQn2cEnz2sbbITMTXqR7XXRc0Q5NzOftOwkQ1l
 BSHrqSfL1gsdrZEcyYB0foNMHAet6Mc7sGpPJOgwDzTtqALNysZ5LJDdmmd1zUFIyiiStQ3NV3V
 UHzUmp+KBISAfUU/HRdh8RIG1+9UIYZZSgStJE36frXD9f/XyYpWbolvHZ0Qb1XOrebrAvQ7MIu
 uxPUt6Q+kr9RdAtAv+6h9DV+L7q4vzpFVY9nFrYASRgB+gkCnzCzqq0t7SmqDxzMLHskpAVTRvq
 tpJckbx1oKzMYcNCUrlJS62tbArJJEiEM7JTiF5kbhRkfIS376omgapB9W
X-Received: by 2002:a05:6830:43a9:b0:7dc:cb67:cb67 with SMTP id
 46e09a7af769-7e36615c337mr487975a34.5.1778197486009; 
 Thu, 07 May 2026 16:44:46 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 32/60] target/arm: Implement FCVTN (16- to 8-bit fp) for SVE
Date: Thu,  7 May 2026 18:43:45 -0500
Message-ID: <20260507234413.643512-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
index 2252d2c526..6588768ba1 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -409,6 +409,29 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
 
+void HELPER(sve2_fcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
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
+    fp8_finish(env, &ctx);
+}
+
 void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
                              CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7276d9c44a..c7fcf27183 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4099,6 +4099,8 @@ TRANS_FEAT(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
 TRANS_FEAT(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
            gen_helper_sve2_bfcvt, true, true)
 
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


