Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0499EC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEU-0006e5-NI; Fri, 24 May 2024 19:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEI-0006VG-15
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeED-0005lz-1y
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f44b59f8daso10094375ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592896; x=1717197696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JGBAb3suYnGkPI0Zq7FnXw4L8WJQd0Zh1edTR6Hth4=;
 b=cMMmwrt9t2T4hAuGTd3VLIlRnpdZMnIzG9H7EOvj1YNq8NhKB4Vh1Sd6qieQQVW2qB
 yui1rwByV2lWAzm9XuaD26wFnOKsn22Y3Uy8kRavt2g2EvjMRJ2NKPab/LIelXLnRSif
 0qxWA+7EIs6bD+233yDTy6ryo0OFXrPL4JxFRHyqnL9YILlWPIe50ofIz6hqyI7oJnRb
 Q/cYWnH33MjcwB91/v2GMcRMlNmm/dlxxYjthm1ZwBewQ6WFdW4Dp0/8eMY2sZC7/4m/
 OQxLcRlw0jNQ0LBGQNvhaxiiP9bczUvWL6u+7k1nYyiP6H2tIuNWGpblEutz6RVgN7Iw
 2kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592896; x=1717197696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6JGBAb3suYnGkPI0Zq7FnXw4L8WJQd0Zh1edTR6Hth4=;
 b=HtBjZbE5zxo4JT/GLQ2cc51flHwzWJ+RSUbT1pSsvmOg+wsMU6Yf9PCqAEDOU/aD1f
 rx1e5WGsO15OtqBIHsoFRGsckrBMnp4v/BtKTIXNxjzwEh/suaqj7D2Btfa8MbS8YuMo
 QOnGro90XkMrY236MYfLfSijAvS2wiw9bQiKu0HqbZMV1zmggDoM6b9CFpSS5LmqcCne
 Z11C4Xzf7BBT9jbqZnhYgoUpqXoRaztGifJpbFTCSqzb2+Xk7msKAAvLQNm9Ayq4cZ/z
 +4QvQaPiArucg8aRuInrEMWViK/qt5ywyGJzmLh8OT0K13FfC/9XkJGYoj9skJlKKbW9
 CS3A==
X-Gm-Message-State: AOJu0YynxODGMOhTVHyXCcyJLWu74ibFlnatCBT9WZpNSsElg1gnYMiF
 0YgauaUVYx09TM1NYMl7CLjqE6KgPNr+c+W8fWmKWR+qtGs7AGU85f4ANuuH1nZvoK9fwCpcNyN
 0
X-Google-Smtp-Source: AGHT+IHxJLX09YDB2XAZ/mPwLgN23+U4YMx5d9NATfHk4mpOht4vIpcwJpmAUhBZyqzjBEnoJtM2fQ==
X-Received: by 2002:a17:903:41ce:b0:1e2:4c85:82ea with SMTP id
 d9443c01a7336-1f4486f23c2mr46433985ad.24.1716592895744; 
 Fri, 24 May 2024 16:21:35 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 15/67] target/arm: Convert Cryptographic 3-register,
 imm2 to decodetree
Date: Fri, 24 May 2024 16:20:29 -0700
Message-Id: <20240524232121.284515-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/arm/tcg/a64.decode      | 10 ++++++++
 target/arm/tcg/translate-a64.c | 43 ++++++++++------------------------
 2 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ef6902e86a..1292312a7f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -644,3 +644,13 @@ SM4E            1100 1110 110 00000 100001 ..... .....  @r2r_q1e0
 EOR3            1100 1110 000 ..... 0 ..... ..... ..... @rrrr_q1e3
 BCAX            1100 1110 001 ..... 0 ..... ..... ..... @rrrr_q1e3
 SM3SS1          1100 1110 010 ..... 0 ..... ..... ..... @rrrr_q1e3
+
+### Cryptographic three-register, imm2
+
+&crypto3i       rd rn rm imm
+@crypto3i       ........ ... rm:5 .. imm:2 .. rn:5 rd:5 &crypto3i
+
+SM3TT1A         11001110 010 ..... 10 .. 00 ..... ..... @crypto3i
+SM3TT1B         11001110 010 ..... 10 .. 01 ..... ..... @crypto3i
+SM3TT2A         11001110 010 ..... 10 .. 10 ..... ..... @crypto3i
+SM3TT2B         11001110 010 ..... 10 .. 11 ..... ..... @crypto3i
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2951e7eb59..cf3a7dfa99 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4676,6 +4676,18 @@ static bool trans_SM3SS1(DisasContext *s, arg_SM3SS1 *a)
     return true;
 }
 
+static bool do_crypto3i(DisasContext *s, arg_crypto3i *a, gen_helper_gvec_3 *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_op3_ool(s, true, a->rd, a->rn, a->rm, a->imm, fn);
+    }
+    return true;
+}
+TRANS_FEAT(SM3TT1A, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt1a)
+TRANS_FEAT(SM3TT1B, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt1b)
+TRANS_FEAT(SM3TT2A, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt2a)
+TRANS_FEAT(SM3TT2B, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt2b)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13604,36 +13616,6 @@ static void disas_crypto_xar(DisasContext *s, uint32_t insn)
                  vec_full_reg_size(s));
 }
 
-/* Crypto three-reg imm2
- *  31                   21 20  16 15  14 13 12  11  10  9    5 4    0
- * +-----------------------+------+-----+------+--------+------+------+
- * | 1 1 0 0 1 1 1 0 0 1 0 |  Rm  | 1 0 | imm2 | opcode |  Rn  |  Rd  |
- * +-----------------------+------+-----+------+--------+------+------+
- */
-static void disas_crypto_three_reg_imm2(DisasContext *s, uint32_t insn)
-{
-    static gen_helper_gvec_3 * const fns[4] = {
-        gen_helper_crypto_sm3tt1a, gen_helper_crypto_sm3tt1b,
-        gen_helper_crypto_sm3tt2a, gen_helper_crypto_sm3tt2b,
-    };
-    int opcode = extract32(insn, 10, 2);
-    int imm2 = extract32(insn, 12, 2);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    if (!dc_isar_feature(aa64_sm3, s)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    gen_gvec_op3_ool(s, true, rd, rn, rm, imm2, fns[opcode]);
-}
-
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -13663,7 +13645,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0xce800000, 0xffe00000, disas_crypto_xar },
-    { 0xce408000, 0xffe0c000, disas_crypto_three_reg_imm2 },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x5e400400, 0xdf60c400, disas_simd_scalar_three_reg_same_fp16 },
-- 
2.34.1


