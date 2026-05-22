Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049D1CD5BB8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXzG-0001w1-9R; Fri, 22 May 2026 18:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXyA-0007qF-26
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:55 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXy5-0008PQ-K4
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:48 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-366139223e4so4763850a91.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487423; x=1780092223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqG9QR1YTbyKLsJizMJiiAQG+EPddkb96cwu+xbAG+E=;
 b=gUMUi4gHEE4AkprISIWCASHIEr9CKZSgDqowGl1H22XPQOb7qizJmLlf+9lYyOhu3X
 kJqXZtbH7aDxCzrndIl5nOZIK1ESeZqGgJU1apNVM0i7NjGBA/QVR3UqNWFaroIA1sLF
 aLHCW7CBqEP1JQa1qth1jBDt9WyvZmZmAGJklEPJoq0x3v7F01YmjYjAdw17B/txwmSB
 KHgA5TGYk6iA9xhz/PGG5svTlOa+Q/yXx1p1TAwZVl2qmy/wE8r69QsqLwuGL0wK1flo
 MUsvKXAjHJYZN3lSknmFKV28NGMTiGD7JWguJ1PvhnJmMjp0YFsyF2s474jTyIp/Nj6c
 hjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487423; x=1780092223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pqG9QR1YTbyKLsJizMJiiAQG+EPddkb96cwu+xbAG+E=;
 b=PeDCemNROl4ZEw2te9ezgDntWuisJmY/1ivQi/TejbsdqF4z96uCD8nNrYkWebw52O
 qWmFDI/MZS8lON7CEl0TfX96CiMop8ONLS17gzLNUYcdCcTJXDp6ux9FUhUEVP9fFz3Y
 /mAVCJXXpaid/p7jFIAfeI9prUgdJC0w+myzeFxv7A/IZix0tplPNCr9sqtEPkbxJ2BR
 wSTzT/N+pXIkEoq2OeGKvrn2cmiO4eMA5C64LGwbfkVLUXptlJ/CyZ86WjTvzHgEYalP
 O3ljnMmDbZO31KlBbR8sffMX0doSFgxyX7E0Po5HV0hTgRujTkcolGEfRNKS/8Mqep4q
 KyoA==
X-Gm-Message-State: AOJu0YyQmNxyvuul1NoU+3hJ6hMyrTekWnWmrvdh7/ap77dtslgyjyJG
 51uiH8pTTERylTtHyeXsy6AAp3AscD4yPkKX0s15+aXf8PDYW4gRTIEveRpuTVq9abcPYj0DarQ
 i2Ec1
X-Gm-Gg: Acq92OFIJLEHhItKtwuV/BnwWnjQsn3Ae0WHY4MyWnDFtYsNF589efN4JQFnXVhKxpE
 ZEavDAKpv8LHmf9v0joqLoaD2M14KZZnLGaMkPspZpjbf/X1zPnFiPc9kYoQPWbLo3vA7PACs68
 sIEq2BlW32/5kS83X211kbeJrZQ5tfC1FaXNH0REzl5n6SQHSv9IGXIPVBV0bEXKoXeAuWehouk
 dkVdQRXZlcWevsBaPy+WRpOp+rjH02XfZCLF+KSVEf9hqtnW6Ag0WaMVw1HNmyXzeX3NQHJan48
 eL7ToFbFpMkfLZDxk4DSAxVn96oKGlXqV3S4T/E7I+s2F6SRVviOEzikLFo/QF5GgsSelWtFRka
 W/J3dXoYw5rNKVcp8iSyf5zAfgGo6xzhBVI/n/aIdYTlr8Rk5gVAD7kT+IHNkxIs3ZifV/FUPL9
 Nobm98Al0cdBArSpHRceawvAA41gdj
X-Received: by 2002:a17:90b:4b52:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-36a67508574mr5128771a91.16.1779487422559; 
 Fri, 22 May 2026 15:03:42 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 36/64] target/arm: Implement FCVTN (16- to 8-bit fp) for SVE
Date: Fri, 22 May 2026 15:02:38 -0700
Message-ID: <20260522220306.235200-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
index 103b9523a3..da46976cc6 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4099,6 +4099,8 @@ TRANS_FEAT_STREAMING_SME2(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
 TRANS_FEAT_STREAMING_SME2(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
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


