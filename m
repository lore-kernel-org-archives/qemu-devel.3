Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9159C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjHD-0003Hn-Hf; Fri, 04 Jul 2025 12:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFc-00069m-ND
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:27:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFX-0006zZ-OD
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:27:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so7213615e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646414; x=1752251214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BQPq3LL1k9Hbuv+vQcvRxaAWa2tKEi3ud/jXWeiywVU=;
 b=m9xzDbw33ipKRNaC4YlCbDqPrvT4eEmpWzIEzdVrJXlWl2iEdf3x3mR0RESzaZRhmr
 s5RiC1MkC0WKg/flbj7B95AS14YrcUoRyzkO7SQVbQW1w046d7A2uNzXK64qTHZnN+2j
 jleyD+wh0g3zhFQV3nCa7iOkoUnkUI32UFKfSR07BFwJew06XLqITKCfq8DIXDRjlPAy
 XN1pQRhOwBeJC699ao5olrk9o7Ubfq1k5beVDC/gtzUrSKWZDL37ugxz9TdSRPCbWpIb
 Ueici9OjbSgpUvM/rnzWGHgq59O6+Pwn2FNwIsUKbTIwoVPHdrCm5IsnCJ1US1gpp82q
 9VMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646414; x=1752251214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQPq3LL1k9Hbuv+vQcvRxaAWa2tKEi3ud/jXWeiywVU=;
 b=OCPnh/zJqqzXb8jsHlW/2ghKDK2VN5epDHGJ8HhNRRj+khRdos8Ysmg2Md9WFflSBs
 rtYWR9ZWvcYxPXRW1x74xG/e4fhHeLfBUQtstBT9MjvIwx11upmeS959Icu9fGHs6dJR
 f7uihmRLD6MvJgaGbw/d0dZiYAJ7roEr9oQ586TM1Foz/bHtO+jU8ZT+nn9l+sci+05u
 BIg4yU7T34vKP3w5H4KGwKqdS0NMkvYrwaaS9EsivSwBGYrP8F114N/0pTat6UkLEEhP
 /bb8PLMRFagUAVZLzwNlrSjNlIuaXu516Rep8/5xVVQjfWT+8gep2NLXNCrSk/W2rTC/
 9dew==
X-Gm-Message-State: AOJu0Yxgn9aUYsi2ukXzIGk2KzkETSXoCL62GbZgnADjqAgoa2V5EbDh
 eJL7/4oWGd5oQkJ8o0uk5rAHtEg6tU/HJdihqP5EkKhLjkKhtAnacnfRZ6/oPGMhlwo9d+DYw2h
 UuHnu
X-Gm-Gg: ASbGncuUXQe+knagleATXdcfUfQoioob1UhrxAEH00XDVB32Ydf25UDBxGT0w+bC91V
 mb6ofsY3KMVk4AvfOL7KEi0EWERgreK8WhOBoU8iFAJBBtTcSjDxRsfukR95EWUsx69NOlJ3AgY
 UiDYncKi9G3m8p2Z3mqZx5ogJ5yGP4whHBY3usNbolzrw86I/jGV3/VYDPShnR+NMWMgg8k5WlX
 rNv9tDjAHzSyTbTe2ThWSG1LUshbRtwNZhoPQnK3RjgvDaS8KcABzyWCh0lMljn8HdFUvwuDhSA
 jtk3Sfy5dq8KqtH/rVXuCJT7MHY+WvhePgW2o+NxImz3V8bJX/W/WspMDJPAcv4giIyC
X-Google-Smtp-Source: AGHT+IGisCsW8pwaQABfznBOe1FEUVGmDAE/dIzlIAvOH5kxFBwtNIwry4TQYwEnwKKSawYV5UKE4Q==
X-Received: by 2002:a05:600c:348d:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-454b3109201mr36245885e9.3.1751646414053; 
 Fri, 04 Jul 2025 09:26:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 118/119] target/arm: Enable FEAT_SME2p1 on -cpu max
Date: Fri,  4 Jul 2025 17:24:58 +0100
Message-ID: <20250704162501.249138-119-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-107-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst |  6 ++++++
 target/arm/tcg/cpu64.c        | 10 ++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 78c2fd2113c..890dc6fee21 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -129,16 +129,22 @@ the following architecture extensions:
 - FEAT_SM3 (Advanced SIMD SM3 instructions)
 - FEAT_SM4 (Advanced SIMD SM4 instructions)
 - FEAT_SME (Scalable Matrix Extension)
+- FEAT_SME2 (Scalable Matrix Extension version 2)
+- FEAT_SME2p1 (Scalable Matrix Extension version 2.1)
+- FEAT_SME_B16B16 (Non-widening BFloat16 arithmetic for SME2)
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
+- FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
+- FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
 - FEAT_SVE_BitPerm (Scalable Vector Bit Permutes instructions)
 - FEAT_SVE_PMULL128 (Scalable Vector PMULL instructions)
 - FEAT_SVE_SHA3 (Scalable Vector SHA3 instructions)
 - FEAT_SVE_SM4 (Scalable Vector SM4 instructions)
 - FEAT_SVE2 (Scalable Vector Extension version 2)
+- FEAT_SVE2p1 (Scalable Vector Extension version 2.1)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
 - FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 937f29e253d..d0df50a2f34 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1201,7 +1201,7 @@ void aarch64_max_tcg_initfn(Object *obj)
      */
     t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
     t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
-    t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     SET_IDREG(isar, ID_AA64PFR1, t);
@@ -1250,10 +1250,11 @@ void aarch64_max_tcg_initfn(Object *obj)
     FIELD_DP64_IDREG(isar, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* FEAT_SVE_B16B16 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* FEAT_SVE_SHA3 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* FEAT_SVE_SM4 */
     t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
@@ -1269,11 +1270,16 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, I8I32, 0xf);  /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F16F16, 1);   /* FEAT_SME_F16F16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, B16B16, 1);   /* FEAT_SME_B16B16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
-- 
2.43.0


