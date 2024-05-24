Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CC3C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEP-0006aM-DD; Fri, 24 May 2024 19:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeED-0006TI-Ku
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:37 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEA-0005kj-0D
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:37 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f6bddf57f6so4713318b3a.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592892; x=1717197692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcRsCeVGiNXWcprFDHSCi1p6P6rszl6J+vWs0nqYknA=;
 b=kg2n/zpNNPiCaSuAMfo5s7t0w5TrnS/s4qkyVLMSemI8XaA3dPyp5/ZO66AWybFh5Y
 keHMsOswnRvVpFtVMI6nIvJDrJ83LTKVWoOMd41pMYJPhdkM0iPGFld1CMFKLQMWL2CH
 FPDaW0sty3rul1+zgBfV8YrxXd5jMcNYbAXWgywUXweqN/T+dXDT2yB1n/G96vwVvC5L
 5mgIDiZD4m5Uvgny/IcdmsBSkGrIJir38OrKX9GGKmFzNYt6VEWBngKfS9ew7t76P0gC
 dBYHnBAHEB5N95Ye+Vo1H7unVKkfxbtwVd69sZJebiJ6JG2Yj6BsBdmS0THdtfjQCWhu
 LZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592892; x=1717197692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CcRsCeVGiNXWcprFDHSCi1p6P6rszl6J+vWs0nqYknA=;
 b=RUtkp2qYx0q53bYMc7kqVisXDteh5JRjgPykYrooDLE4ovbQdZtsSVCBq0PPAa6tpc
 ufReJHJWy7NX/X5P9qZQRW5RaYqNWygtisX5VncL5qlzN4+zdX12ZMs0AsnvvedtQJ+N
 E1Yi0N5ux2d3Y/35cniigge+OqduREJQEHuc+3gfJ0JigcWr3+/nEogPLvEC1bBdkt5N
 p/Nk7IEoiiIenAqkQvaAy8YbusMKdoznBxIaVn4RYkJHNVEEIl/ZlmZZT5N02bVU9LQ9
 2ulaix5jN/Qm92Fn+r2Ks4GZbLqyq5DmNFNJfjeWwHvHAVbnaacYD+kTd7uV1+ej/rR7
 P1pg==
X-Gm-Message-State: AOJu0YwEG5Mir0IhZBi4G1jOX0pNAvPPUgRsQViUOEOwkN3cTRfJCYh9
 o69/08ApLdfAYpxJSxo4MPkEOkpAhPghkvO5Va9JgdrqJHnHWByKzogF/FPO+7Ht4yBmGz9n1kj
 Z
X-Google-Smtp-Source: AGHT+IFwsekvquJJ+omHXcdT4MSknIwsOM1k95dcsIZCDoSnIN3cF8Ixth9yawKy2gnqFGkBfAFLSw==
X-Received: by 2002:a17:902:d4c1:b0:1f4:643d:c9b0 with SMTP id
 d9443c01a7336-1f4643dcb78mr10351195ad.20.1716592892554; 
 Fri, 24 May 2024 16:21:32 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 11/67] target/arm: Convert Cryptographic 2-register SHA to
 decodetree
Date: Fri, 24 May 2024 16:20:25 -0700
Message-Id: <20240524232121.284515-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  6 ++++
 target/arm/tcg/translate-a64.c | 54 +++-------------------------------
 2 files changed, 10 insertions(+), 50 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7590659ee6..350afabc77 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -614,3 +614,9 @@ SHA1SU0         0101 1110 000 ..... 001100 ..... .....  @rrr_q1e0
 SHA256H         0101 1110 000 ..... 010000 ..... .....  @rrr_q1e0
 SHA256H2        0101 1110 000 ..... 010100 ..... .....  @rrr_q1e0
 SHA256SU1       0101 1110 000 ..... 011000 ..... .....  @rrr_q1e0
+
+### Cryptographic two-register SHA
+
+SHA1H           0101 1110 0010 1000 0000 10 ..... ..... @rr_q1e0
+SHA1SU1         0101 1110 0010 1000 0001 10 ..... ..... @rr_q1e0
+SHA256SU0       0101 1110 0010 1000 0010 10 ..... ..... @rr_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5bef39d4e7..1d20bf0c35 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4606,6 +4606,10 @@ TRANS_FEAT(SHA256H, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256
 TRANS_FEAT(SHA256H2, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256h2)
 TRANS_FEAT(SHA256SU1, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256su1)
 
+TRANS_FEAT(SHA1H, aa64_sha1, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha1h)
+TRANS_FEAT(SHA1SU1, aa64_sha1, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha1su1)
+TRANS_FEAT(SHA256SU0, aa64_sha256, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha256su0)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13506,55 +13510,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto two-reg SHA
- *  31             24 23  22 21       17 16    12 11 10 9    5 4    0
- * +-----------------+------+-----------+--------+-----+------+------+
- * | 0 1 0 1 1 1 1 0 | size | 1 0 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
- * +-----------------+------+-----------+--------+-----+------+------+
- */
-static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
-{
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    gen_helper_gvec_2 *genfn;
-    bool feature;
-
-    if (size != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0: /* SHA1H */
-        feature = dc_isar_feature(aa64_sha1, s);
-        genfn = gen_helper_crypto_sha1h;
-        break;
-    case 1: /* SHA1SU1 */
-        feature = dc_isar_feature(aa64_sha1, s);
-        genfn = gen_helper_crypto_sha1su1;
-        break;
-    case 2: /* SHA256SU0 */
-        feature = dc_isar_feature(aa64_sha256, s);
-        genfn = gen_helper_crypto_sha256su0;
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
-    gen_gvec_op2_ool(s, true, rd, rn, 0, genfn);
-}
-
 /* Crypto three-reg SHA512
  *  31                   21 20  16 15  14  13 12  11  10  9    5 4    0
  * +-----------------------+------+---+---+-----+--------+------+------+
@@ -13849,7 +13804,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0xce000000, 0xff808000, disas_crypto_four_reg },
-- 
2.34.1


