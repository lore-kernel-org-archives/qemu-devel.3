Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243B3C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT865-0008UV-Ik; Sat, 21 Jun 2025 19:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85i-00061a-Fs
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:48 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85g-0006dm-N6
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-748ece799bdso2004155b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550263; x=1751155063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FgYGKO1mW9qx6eZh3ncNiRkSWSekpPfz5Aqf+QGYTWw=;
 b=f01cuAenDa+B8WnJUn+l3ijGitK65iewZ10iNtnIN8YB9GLYRVXOKFUvfEsAZMU4kO
 Wt9PFJDiSKCWHhve69diBuUMNdx5DGtus0inhLJI/aBzu0L/7ZU7haxNShDH17yoVMbn
 ESdKWwN2O1Ao1eeLdIQDW4k9j5QuI+xFlKZJf2undw8YMvffYO0Kq+zuWwOq40QQvuXY
 POWUNtsRnwlLXIRr6AU2qfBfZTeqxtRJhyQUr1qZAQJeTr2R4Q9VrJom2l+YR41PgQ7a
 I289bQi+JRe4d7LTZasPyRhUL71VQC+HR/P/kYGzblgBRmS4cOfp0PcvUJNIZH3zVKU9
 7yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550263; x=1751155063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgYGKO1mW9qx6eZh3ncNiRkSWSekpPfz5Aqf+QGYTWw=;
 b=hxtgvUX/IfqAfCu+xtjtoxlRbXTV2xSa00N1OHfFNzp1pqdxNqsCNCYaOZNLJ7LSXn
 yEZsT87t4WcjK/CrN24Vn70iraBrhnC9jeQ+zsi6FlQUz0GQbzNl3/d8s6xSEtyaE4js
 hH8bRpSdZ57pd0QhPKRjAahz90IUDdKtY5m4CpCQ26XXWcBzw/geUxRXC86fXZsxUX9c
 /wrrIM+NDz1QM5IAhkPdody8GyWcwUa22gODR9EYl9jCBNYPjaTYqUt30LV8wGqDEm+e
 kv5K+Z99DHagy3iaJ1Kx9f4n1pjbwBL6S8ESsh0W53cyqpKG2u8BT/i23KRcf3U5/RRR
 ETzw==
X-Gm-Message-State: AOJu0Yx7Uuz/qmvizjTdiJPisO8maI8FVutZA6v2VHKjKgThL2L5UKcd
 8px7/uEXX8YKebRKmZ/AflShVlrPT0I6OuRyYykoSreYI8RFHJv3zuab8SGAKXfXahl406sOjxj
 kP7+IzFk=
X-Gm-Gg: ASbGnctE3hmyjdWQebpbovpRPDERoiGOXRklxPMD0yk64cbt8FgtfLaj3UcZdKIvv+w
 eQtmWSABDb5o0ePuV6Dd7vBaB2Ry7exEldAI3f6jf/N6rL4DEXonLu1Nj6dBD9JVKgOh0iqFr8d
 GHORTpJlXi9uR6Bla+v9yWhgNHsTz+eg/F0yKESJZOST0ewBjFUm5HvOTlBABh3jQL7LjsGd9S4
 Kxr6AORUE/xrxh4MGzkW566aKDwP6HxhJFllydiMN+T+amfdyXn0EPtBnbk3euSQmdLoFig4QFN
 zLoqmE6egSq60sDn3xTjgcm2a2ZTbfFpo6wvJr1c++8HTcHc2wpR4K1b1Xri/S+s+vW6FcVpET8
 nlEL8g3Jwu5ohvLfLVU9L
X-Google-Smtp-Source: AGHT+IFlVzK3brTjb0MBTIi9PIr9PnmZ+vPeFGzXmztZaPyUccuVbdEQedBb8ZgDJ2Jzkl04noDYhQ==
X-Received: by 2002:a05:6a20:729b:b0:21d:a9d:ba3b with SMTP id
 adf61e73a8af0-22026fe7577mr12229435637.39.1750550263238; 
 Sat, 21 Jun 2025 16:57:43 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 100/101] target/arm: Enable FEAT_SME2p1 on -cpu max
Date: Sat, 21 Jun 2025 16:50:36 -0700
Message-ID: <20250621235037.74091-101-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 10 ++++++++--
 docs/system/arm/emulation.rst |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 5d8ed2794d..f73729926b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1194,7 +1194,7 @@ void aarch64_max_tcg_initfn(Object *obj)
      */
     t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
     t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
-    t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     cpu->isar.id_aa64pfr1 = t;
@@ -1245,10 +1245,11 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->isar.id_aa64mmfr3 = t;
 
     t = cpu->isar.id_aa64zfr0;
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* FEAT_SVE_B16B16 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* FEAT_SVE_SHA3 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* FEAT_SVE_SM4 */
     t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
@@ -1264,11 +1265,16 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64smfr0;
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
     cpu->isar.id_aa64smfr0 = t;
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 78c2fd2113..890dc6fee2 100644
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
-- 
2.43.0


