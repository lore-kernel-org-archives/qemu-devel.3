Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7843CC25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEO-0006ZU-Rk; Fri, 24 May 2024 19:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEH-0006U8-0w
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:41 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEC-0005lI-Gf
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:40 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f332511457so13028625ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592894; x=1717197694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IskcEk0O5C7PUgJwWoGQw6Vk3d4pXb5ryEHh+lqmaGQ=;
 b=vhif52a+/LnHM4Oom8MnJUkD919BX4PyTINgnuIBvUB2CvVUh303T3FbKTs9DS0sUE
 cQKWYeEJWiMxEOieVHgGcsMhiIkPolEIpjRfIKLVJ5/Oqh31ggyBYJymIao2Qrvsxf03
 7deDvFz+MWwk7fnlI5jlBb2w2UMk9IKabl3Zo9qGLzRLbHELjOeAg/6M/Eo2fWDynlJ2
 T5iAm1K6r2fGoZkgNnOOgzBPEFKAXxBPVQQCvZkVgLXYpdB1jXsWwyZIecz8d8RfMPD6
 8EACszProypdoSdEYx4QQ1BtxYRF0G5b97Y61P0oFZDL0mKXNyRBhWSFalDytJwkwZqU
 Q7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592894; x=1717197694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IskcEk0O5C7PUgJwWoGQw6Vk3d4pXb5ryEHh+lqmaGQ=;
 b=PuDkD1WFllJuEyIcs+5ddC039pHyTI2QLl26gO5gZnLq7F893cbh+0U2S2tq4QuRn+
 w/RvdizgwAbRRFM3x0n1CkGCnJdlk4vc/EFCUgChbV31VDiqLxkXy2J4DF0ID1cmuIGz
 T0l7l2mR311fbwI9MmRBL3Q8SFeG/JO6pSHVrJKnp6yQPtomkOtxHl/BxULYH/WIcW/L
 4YjuznuBqlUayGA5hpOYKEAVgociNNO5L/50cD/SDZIUAjgfXXfNSmM9+kZtGfUIz95G
 UQpV63NXZCzcW/84AfxHzZQKCIlw9BvuIsp5CuZ+iv7dyGyqmoq+9uXbIF3WPvVsTSuM
 sCDQ==
X-Gm-Message-State: AOJu0Yzh/haFyLiN5MpJJ7zZUNTFAk9WRtGYWH0NhIaUh6jTw1HNFMHG
 eu+13O65UNHdA2cObQ4+UvtSQHA5N18euH021ya0meeHwD2LSj/EblLP2i7/OaCwgjcmhWY2pCG
 t
X-Google-Smtp-Source: AGHT+IHTTSzlm17eCmqw19X1rZ6uwAoVBjqxxU1QfDDuJYVkZum0G9RmEbQn2qnVOVM2lNnaIgTopw==
X-Received: by 2002:a17:902:ecc7:b0:1f3:266e:cd2d with SMTP id
 d9443c01a7336-1f448933c64mr44519305ad.30.1716592894096; 
 Fri, 24 May 2024 16:21:34 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 13/67] target/arm: Convert Cryptographic 2-register SHA512
 to decodetree
Date: Fri, 24 May 2024 16:20:27 -0700
Message-Id: <20240524232121.284515-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  5 ++++
 target/arm/tcg/translate-a64.c | 50 ++--------------------------------
 2 files changed, 8 insertions(+), 47 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c342c27608..5a46205751 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -631,3 +631,8 @@ RAX1            1100 1110 011 ..... 100011 ..... .....  @rrr_q1e3
 SM3PARTW1       1100 1110 011 ..... 110000 ..... .....  @rrr_q1e0
 SM3PARTW2       1100 1110 011 ..... 110001 ..... .....  @rrr_q1e0
 SM4EKEY         1100 1110 011 ..... 110010 ..... .....  @rrr_q1e0
+
+### Cryptographic two-register SHA512
+
+SHA512SU0       1100 1110 110 00000 100000 ..... .....  @rr_q1e0
+SM4E            1100 1110 110 00000 100001 ..... .....  @r2r_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 77b24cd52e..eed0abe912 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4629,6 +4629,9 @@ TRANS_FEAT(SM3PARTW1, aa64_sm3, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm3part
 TRANS_FEAT(SM3PARTW2, aa64_sm3, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm3partw2)
 TRANS_FEAT(SM4EKEY, aa64_sm4, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm4ekey)
 
+TRANS_FEAT(SHA512SU0, aa64_sha512, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha512su0)
+TRANS_FEAT(SM4E, aa64_sm4, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm4e)
+
 
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
@@ -13530,52 +13533,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto two-reg SHA512
- *  31                                     12  11  10  9    5 4    0
- * +-----------------------------------------+--------+------+------+
- * | 1 1 0 0 1 1 1 0 1 1 0 0 0 0 0 0 1 0 0 0 | opcode |  Rn  |  Rd  |
- * +-----------------------------------------+--------+------+------+
- */
-static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
-{
-    int opcode = extract32(insn, 10, 2);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    bool feature;
-
-    switch (opcode) {
-    case 0: /* SHA512SU0 */
-        feature = dc_isar_feature(aa64_sha512, s);
-        break;
-    case 1: /* SM4E */
-        feature = dc_isar_feature(aa64_sm4, s);
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
-
-    switch (opcode) {
-    case 0: /* SHA512SU0 */
-        gen_gvec_op2_ool(s, true, rd, rn, 0, gen_helper_crypto_sha512su0);
-        break;
-    case 1: /* SM4E */
-        gen_gvec_op3_ool(s, true, rd, rd, rn, 0, gen_helper_crypto_sm4e);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* Crypto four-register
  *  31               23 22 21 20  16 15  14  10 9    5 4    0
  * +-------------------+-----+------+---+------+------+------+
@@ -13750,7 +13707,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0xce000000, 0xff808000, disas_crypto_four_reg },
     { 0xce800000, 0xffe00000, disas_crypto_xar },
     { 0xce408000, 0xffe0c000, disas_crypto_three_reg_imm2 },
-- 
2.34.1


