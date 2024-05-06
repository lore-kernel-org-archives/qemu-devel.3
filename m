Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0537CC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmS-0007mZ-5B; Sun, 05 May 2024 21:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmL-0007hb-1b
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:29 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm4-0002QZ-Ip
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:28 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5b215ed1e42so267040eaf.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957449; x=1715562249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9CxkB7OmKVcC11PelQ9lGCa2mpU21ZRCbJ8VfO6k5pc=;
 b=pjdEA0q2+XgWp5QBBHDyE9311Q6lXmbTvZgKTiV1roPLA2BLu5t7g3skJnLcc/UyYU
 s/3iY8mLI7gwnKOsolplwW9yTZyIBR/tscztBjpxqzQCts13rcDC/p4rAdrU+xcEXU15
 VAmZH3B+nT0FnHDhhsCm2M1Sgvtp+NhLIHNHL/DDhpBpjfcra0w7Jdu7qzJMfrXLDN1d
 dTvDuqET1WtA1OgJWtbuPmpfw7t/5bhZR1ogS9G/5CsgtR28BwQgUB3XMNVYTJg39drG
 VKpOJdnOgvKinr+5CUbN4ABlMn5ppBbggllyW/HXj/T5+13iYnjwtODB5u6fB81NI1Zh
 rJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957449; x=1715562249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9CxkB7OmKVcC11PelQ9lGCa2mpU21ZRCbJ8VfO6k5pc=;
 b=SxRpYDjy48AjOSZyRTzpHoRKMo676v3U+AkNpGUADnm1cUtCZbweB0B7JcZD4R9u1E
 uYM7pa6gKmXedNMsFlOLpuRVnJrDa6O5759r5kdniRQuGh4OCgUAQ+d+2jx7DrvF7s7l
 DylG5TWLu6qdKBbyVMZvmRK3fxIRxTXddJCyowPKHfeopqrWeOy7kDJ2WV6iQjx7WQO2
 mpUmnz4k5FXIG/q4SDYrEHwtYkDwYnVYOmB/5EXFRCELTHUk1dEEZr1koOlCo8hfztQV
 kj8EBYhLDA/y/MGVeo/gTSPxAQ6XSLJgQVNqioDKx0Nl2T6QqipDTGwjYxq/pu3M3Sfa
 6r/A==
X-Gm-Message-State: AOJu0Ywy9W6gi7yP9BPhU4QdQCQmzT8jJnjkf3gEg/TT/en0mV9dE511
 wzOYNGP3GeSbS9/bJq4XGiD73uiI6K5+nF4Bhje6C8iD/tZdOwpY9I8jcnWxQKFkpyeULLjOmEX
 o
X-Google-Smtp-Source: AGHT+IHNF3mSgwer3QGKybImzmu+LzL7H3lMXKaIaUSrKuFdtkz2a3blq9Pcw9AkD6jp35DKDbjDOg==
X-Received: by 2002:a05:6359:5f86:b0:18f:81e1:a1c4 with SMTP id
 lh6-20020a0563595f8600b0018f81e1a1c4mr11275914rwc.5.1714957449310; 
 Sun, 05 May 2024 18:04:09 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/57] target/arm: Convert Cryptographic 3-register SHA to
 decodetree
Date: Sun,  5 May 2024 18:03:10 -0700
Message-Id: <20240506010403.6204-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/a64.decode      | 11 +++++
 target/arm/tcg/translate-a64.c | 78 +++++-----------------------------
 2 files changed, 21 insertions(+), 68 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1de09903dc..7590659ee6 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -30,6 +30,7 @@
 
 @rr_q1e0        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=0
 @r2r_q1e0       ........ ........ ...... rm:5 rd:5      &qrrr_e rn=%rd q=1 esz=0
+@rrr_q1e0       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=0
 
 ### Data Processing - Immediate
 
@@ -603,3 +604,13 @@ AESE            01001110 00 10100 00100 10 ..... .....  @r2r_q1e0
 AESD            01001110 00 10100 00101 10 ..... .....  @r2r_q1e0
 AESMC           01001110 00 10100 00110 10 ..... .....  @rr_q1e0
 AESIMC          01001110 00 10100 00111 10 ..... .....  @rr_q1e0
+
+### Cryptographic three-register SHA
+
+SHA1C           0101 1110 000 ..... 000000 ..... .....  @rrr_q1e0
+SHA1P           0101 1110 000 ..... 000100 ..... .....  @rrr_q1e0
+SHA1M           0101 1110 000 ..... 001000 ..... .....  @rrr_q1e0
+SHA1SU0         0101 1110 000 ..... 001100 ..... .....  @rrr_q1e0
+SHA256H         0101 1110 000 ..... 010000 ..... .....  @rrr_q1e0
+SHA256H2        0101 1110 000 ..... 010100 ..... .....  @rrr_q1e0
+SHA256SU1       0101 1110 000 ..... 011000 ..... .....  @rrr_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1ba6a30176..b31e70b5d3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4590,7 +4590,7 @@ static bool trans_EXTR(DisasContext *s, arg_extract *a)
 }
 
 /*
- * Cryptographic AES
+ * Cryptographic AES, SHA
  */
 
 TRANS_FEAT(AESE, aa64_aes, do_gvec_op3_ool, a, 0, gen_helper_crypto_aese)
@@ -4598,6 +4598,15 @@ TRANS_FEAT(AESD, aa64_aes, do_gvec_op3_ool, a, 0, gen_helper_crypto_aesd)
 TRANS_FEAT(AESMC, aa64_aes, do_gvec_op2_ool, a, 0, gen_helper_crypto_aesmc)
 TRANS_FEAT(AESIMC, aa64_aes, do_gvec_op2_ool, a, 0, gen_helper_crypto_aesimc)
 
+TRANS_FEAT(SHA1C, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1c)
+TRANS_FEAT(SHA1P, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1p)
+TRANS_FEAT(SHA1M, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1m)
+TRANS_FEAT(SHA1SU0, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1su0)
+
+TRANS_FEAT(SHA256H, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256h)
+TRANS_FEAT(SHA256H2, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256h2)
+TRANS_FEAT(SHA256SU1, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256su1)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13491,72 +13500,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto three-reg SHA
- *  31             24 23  22  21 20  16  15 14    12 11 10 9    5 4    0
- * +-----------------+------+---+------+---+--------+-----+------+------+
- * | 0 1 0 1 1 1 1 0 | size | 0 |  Rm  | 0 | opcode | 0 0 |  Rn  |  Rd  |
- * +-----------------+------+---+------+---+--------+-----+------+------+
- */
-static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
-{
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 3);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    gen_helper_gvec_3 *genfn;
-    bool feature;
-
-    if (size != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0: /* SHA1C */
-        genfn = gen_helper_crypto_sha1c;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 1: /* SHA1P */
-        genfn = gen_helper_crypto_sha1p;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 2: /* SHA1M */
-        genfn = gen_helper_crypto_sha1m;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 3: /* SHA1SU0 */
-        genfn = gen_helper_crypto_sha1su0;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 4: /* SHA256H */
-        genfn = gen_helper_crypto_sha256h;
-        feature = dc_isar_feature(aa64_sha256, s);
-        break;
-    case 5: /* SHA256H2 */
-        genfn = gen_helper_crypto_sha256h2;
-        feature = dc_isar_feature(aa64_sha256, s);
-        break;
-    case 6: /* SHA256SU1 */
-        genfn = gen_helper_crypto_sha256su1;
-        feature = dc_isar_feature(aa64_sha256, s);
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!feature) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-    gen_gvec_op3_ool(s, true, rd, rn, rm, 0, genfn);
-}
-
 /* Crypto two-reg SHA
  *  31             24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----------------+------+-----------+--------+-----+------+------+
@@ -13900,7 +13843,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
-- 
2.34.1


