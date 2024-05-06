Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AA5C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmO-0007jk-99; Sun, 05 May 2024 21:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmK-0007hD-Cm
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:28 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm8-0002S5-20
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:27 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so1308913a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957454; x=1715562254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uH2zdPUKBWhcLzQWUpsSrSJy0Ktek24dhzOGDdWBF0=;
 b=JlVkMtLfcsoTizwRDEYolQabnrgt7WxStD+7R7mcCfLymPO+bBzmSNDD4WEIp5CD5h
 SSRE/YFhZsAr/dI6imFOxQNTcXv8Br3mXFPo013TmB0YGTs4HEq0P7x0MMCVwhBtMuLl
 LZ4BnuhkPCZNJLDZm9tMUUSbOh6BNF9BvAtAz6mWC2Klv6/0cXRl+ILjCMnYivbv+qvW
 C3PTmz7VxmG0YH+kAFeigcZwpAfViIBgWe0hKvfmsROf2OUlAcYfeSumPTBntxnghq6u
 gKoiAcwh41CrCqmtpzesPSXMvCyMF4KPKO1Pz4tvfaAzOcQ667SXAF91/xIOGXvIER4n
 hXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957454; x=1715562254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uH2zdPUKBWhcLzQWUpsSrSJy0Ktek24dhzOGDdWBF0=;
 b=bLmbE3FF+pGG35nk+WaoJJt+tI74HM0h4/ovphIbwdM3R9MTWfqHAwFi+MACekDfhs
 bR+nRArNTUZ2dctSCHIHWmIDoLD3tMJXjwIDtT81W2nhNrhTQb4AwexAb75gWPZJD+DC
 yloSKlSIKuWE208Tl7EvWrqB0BCImZYtiVX2org95c1y96pZE9m23jqwHo5+XFtR07rD
 u9dDnBMqaasT0oXLBu0tf7P5RkNHXxcxBn/TpoddzVd6J4rNKdMymn1pXSrI/p1XX7QR
 Zj1AZk7XkZUUK3cMxyt79lAe7sUChbtNiZERJQgaIcVPS1g9Ohl1bVG5Fyoci2bVFIOr
 df6A==
X-Gm-Message-State: AOJu0YxqHqIhSsWmWwaOdB03f5vcjSm2Rlp0zvNPI+2TUt0gMFb23J2E
 dPV2fe08wr7764icZxPWRtKFOCRxHIJ1wUqVln3GHpXpcb0mTUjAh3J0SxpbIa9vuaB9+myKWcQ
 J
X-Google-Smtp-Source: AGHT+IEDEDfl6JxvdQ5gwVvoOgmFUtJKmkbb9eFFs3XQTbZ9O8lHzPrveADcoWRdijD6NvLWBq0m0w==
X-Received: by 2002:a17:90b:124c:b0:2b2:9c3a:8cfc with SMTP id
 gx12-20020a17090b124c00b002b29c3a8cfcmr9010815pjb.11.1714957454405; 
 Sun, 05 May 2024 18:04:14 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/57] target/arm: Convert XAR to decodetree
Date: Sun,  5 May 2024 18:03:16 -0700
Message-Id: <20240506010403.6204-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 43 +++++++++++-----------------------
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1292312a7f..7f354af25d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -654,3 +654,7 @@ SM3TT1A         11001110 010 ..... 10 .. 00 ..... ..... @crypto3i
 SM3TT1B         11001110 010 ..... 10 .. 01 ..... ..... @crypto3i
 SM3TT2A         11001110 010 ..... 10 .. 10 ..... ..... @crypto3i
 SM3TT2B         11001110 010 ..... 10 .. 11 ..... ..... @crypto3i
+
+### Cryptographic XAR
+
+XAR             1100 1110 100 rm:5 imm:6 rn:5 rd:5
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 219a666cbb..5e99b6494e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4689,6 +4689,20 @@ TRANS_FEAT(SM3TT1B, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt1b)
 TRANS_FEAT(SM3TT2A, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt2a)
 TRANS_FEAT(SM3TT2B, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt2b)
 
+static bool trans_XAR(DisasContext *s, arg_XAR *a)
+{
+    if (!dc_isar_feature(aa64_sha3, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_xar(MO_64, vec_full_reg_offset(s, a->rd),
+                     vec_full_reg_offset(s, a->rn),
+                     vec_full_reg_offset(s, a->rm), a->imm, 16,
+                     vec_full_reg_size(s));
+    }
+    return true;
+}
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13582,34 +13596,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto XAR
- *  31                   21 20  16 15    10 9    5 4    0
- * +-----------------------+------+--------+------+------+
- * | 1 1 0 0 1 1 1 0 1 0 0 |  Rm  |  imm6  |  Rn  |  Rd  |
- * +-----------------------+------+--------+------+------+
- */
-static void disas_crypto_xar(DisasContext *s, uint32_t insn)
-{
-    int rm = extract32(insn, 16, 5);
-    int imm6 = extract32(insn, 10, 6);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    if (!dc_isar_feature(aa64_sha3, s)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    gen_gvec_xar(MO_64, vec_full_reg_offset(s, rd),
-                 vec_full_reg_offset(s, rn),
-                 vec_full_reg_offset(s, rm), imm6, 16,
-                 vec_full_reg_size(s));
-}
-
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -13638,7 +13624,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0xce800000, 0xffe00000, disas_crypto_xar },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x5e400400, 0xdf60c400, disas_simd_scalar_three_reg_same_fp16 },
-- 
2.34.1


