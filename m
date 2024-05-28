Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D18C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUr-0001cQ-U4; Tue, 28 May 2024 10:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUq-0001bj-P4
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUm-00074H-PU
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-420180b58c5so6690615e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905287; x=1717510087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xlqr8OCRH9VlaXuwhAgRGhxeV6jrq6Fx27rZAA3V29g=;
 b=VtUJiIuKaQN1TTp0BjAQYsVDeeQj/+UdU31Qnysy7gYAp0XiAporrnzl2ieDGIeyoL
 0hJdSm12A5kcxtPXG2Q1ZLNnYJqjk2lLVQ1HapZDF5Nc6M4TWAxN1TwBV8VBvEncvJvt
 pna9qh/pt75QwblMyYvbzcUMWlGI1Z9sBL+fHdjR9lLnYKBviXlX7XQrLNpMZ+LQykE9
 S82NcdtNC0IotmQjkJ9WRd8R+0zgGB6e5CwktKgCoUROAxj18m9W2y/WiTdhrUudp4ul
 H+qLZ6Xpszfl7vz+dnuYNgkExr9rD4Q3xlZOdLn8M98jFDE7pci2YDITkOCmOMdS7hH1
 oypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905287; x=1717510087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlqr8OCRH9VlaXuwhAgRGhxeV6jrq6Fx27rZAA3V29g=;
 b=Nahsvyhmc7QVz+szarJCqyUuhkXNGUa8sbAMoRaQAXXzJ5kwODPpeLmk58t5BrrLne
 m9XbBgYlnPPtXMUnv/mMzcZ5Ob9msgSKLDAAqHrB+QnwV2FT34IaZqXdTj82a0JkBE9D
 lKmLccgE9odTEKguWJ/J0TqFP8/7hB3G7paVUv6GV2gZVC3DkpaZ9c5PKnl2vrc/f3fn
 ++AD6TapKgRtrsGBfDCW/zQ+skXJmkVrYUBONd/kau0+3iGe55V3tGpCGeAQxP/kLFlD
 fbo7PE9TrOlGsntkrjJ7lerdw4NWfCvD8W1Xtg8wZyz34zudmuXD16Ap/sPcNMEHIHfg
 WNqQ==
X-Gm-Message-State: AOJu0Yyw9kOSkzeVwJNeCDsW8WIkY+aVCZFDFN8gXE2qE4vIp/Xd/sbx
 YnDVdSiJK2tRpJVmirls8ZJ64a/qi9gRnZhw/eKblq3jS3Pguij3BGHTrJKDXYK01t6ogY994Is
 p
X-Google-Smtp-Source: AGHT+IFmsDI5jTOKRjrBTGkcw8ZeFPmw34ao+y+8KYhTizcFxvNUYjCtJxeWMM8JdBkys+eTG1Bhsg==
X-Received: by 2002:a05:600c:1d21:b0:41f:e56c:ef81 with SMTP id
 5b1f17b1804b1-421089b1b4dmr109249355e9.1.1716905287219; 
 Tue, 28 May 2024 07:08:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/42] target/arm: Convert Cryptographic 2-register SHA512 to
 decodetree
Date: Tue, 28 May 2024 15:07:30 +0100
Message-Id: <20240528140753.3620597-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240524232121.284515-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  5 ++++
 target/arm/tcg/translate-a64.c | 50 ++--------------------------------
 2 files changed, 8 insertions(+), 47 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c342c276089..5a46205751c 100644
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
index 77b24cd52ed..eed0abe9121 100644
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


