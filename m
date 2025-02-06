Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D71C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg88G-000520-Ns; Thu, 06 Feb 2025 15:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83n-0007w8-Mz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:19 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83i-0001CV-6V
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:15 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f9c69aefdbso2652618a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872066; x=1739476866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rgyDgloSqpxlaMe84m6ZsHP0mk+qpudbxX1HADMZbA=;
 b=zbgC++h3NI9j3TpRSvZ0mZZpcpshDo4dOYfvcxeNf1XsPzv35KAee7QIIMafryefdQ
 gQZ8pG3T9OtBkOK2T1U9nLVlOyb5tcN8N1tCYJhze/Pk/dUuaU12WIr3XkogKhjYL9h2
 AUfvqGMS+ZK6werOLYWBjSnszTtLIq1DQJ1XsHe7BrGCqiJey7WomM36xopLXdb1Gg1+
 4MeIPHOGCRakUqXxnyoRkam5Gfm91D9SnD56k4MnSXbl/I2TXFkDWRnFjhNbfbZOtq7q
 3WPTch6WiP7MFDIJRHCKzhl47xCQjr+dw+ySdJtSlWP3hhmyEkBJnvQgmWtPC7fUVHc+
 TcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872066; x=1739476866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rgyDgloSqpxlaMe84m6ZsHP0mk+qpudbxX1HADMZbA=;
 b=ZzQooUQiGS1VloSBx/zczH7kpWr3hYuMjWKn/dLHUDqAeKyXVrOLI20brMGYrb2/bS
 QIuoKNdF05nQS1zyRdNWq4vSQ16xZNDCP1PQsgs5Qw4C0Un+6FUcG3Xo+1SEAJL94OpF
 zYufhqNx3EhfHf/cKZaPquqyQqL8Fs5fgNizyfqlL5pWKV1E8TmsBLtMczc4k1QXBnNf
 GHR1DSG7HzuufyYrdu5GXSn3FTQXlDL2OM/zJYnxLSQctwoDOc+a7lXPtJEkB0kBPMfe
 4n0tmVJQT2j9piz/ZVuLKcS7rYtp7khGU9kxNfuGgQZS8L2Y1+igvLLNF0Q/Xw8/SnNb
 UhoA==
X-Gm-Message-State: AOJu0YzuD/p/A4mtUYjuUWaXV3i3Dgu7hbMMAgQIRj8N8E7/N0V0It53
 1zlAIn+2CyHyfloUhzGJUGH/P7beOh9Heg/+gi0eE0ZlzwWtYwwG7PMqOctlVvtGs8DN9UNxI7J
 6
X-Gm-Gg: ASbGncvNbk7ZthsIrllvzhxr8suk9sStK5JGaWhgNp1dJDzchp/l92aW0Y3hQXoYIZQ
 Rrtd+TGrnj4c7ioQdpBtJ/kwhkKEJtntUpNgwD0G7pu535V05iGvuPJ0UJJxSYtwhNaVYTzpjW8
 lZG5IN2WoF9r2mES8Esr97BytsoevYm0uN/tP5cWfqTjzUcZ+4eZHAOCxCfcq8e4oPfzYHGW4IY
 HY/GYFvYUoHoEmsnTbEjMiosXitgZp4Uc3tBj7Fxy7AEo25Q/pLm9ePk1CgbQRythSoxXockQM3
 6+c7uN0XDwJIN1+jhIsVuUqTpdJhlO3W9YaHp/FxOWKH5/0=
X-Google-Smtp-Source: AGHT+IGcl+hUpmuB49lIdwULX+9yyFAWeUhLWi00isQbKdngUYfD+p0sHNehH3yL7lcHgtiDMoiYkQ==
X-Received: by 2002:a17:90b:3588:b0:2ee:d193:f3d5 with SMTP id
 98e67ed59e1d1-2fa23f5703fmr564701a91.7.1738872061968; 
 Thu, 06 Feb 2025 12:01:01 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:01:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 61/61] target/arm: Enable FEAT_SME2, FEAT_SME_F16F16,
 FEAT_SVE_B16B16 on -cpu max
Date: Thu,  6 Feb 2025 11:57:15 -0800
Message-ID: <20250206195715.2150758-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 7 ++++++-
 docs/system/arm/emulation.rst | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 29ab0ac79d..6fb821ad9a 100644
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
@@ -1264,11 +1264,16 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64smfr0;
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, I8I32, 0xf);  /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F16F16, 1);   /* FEAT_SME_F16F16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, B16B16, 1);   /* FEAT_SVE_B16B16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 1);   /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     cpu->isar.id_aa64smfr0 = t;
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 78c2fd2113..d063571556 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -129,11 +129,14 @@ the following architecture extensions:
 - FEAT_SM3 (Advanced SIMD SM3 instructions)
 - FEAT_SM4 (Advanced SIMD SM4 instructions)
 - FEAT_SME (Scalable Matrix Extension)
+- FEAT_SME2 (Scalable Matrix Extension version 2)
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
+- FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
+- FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2 and SME2)
 - FEAT_SVE_BitPerm (Scalable Vector Bit Permutes instructions)
 - FEAT_SVE_PMULL128 (Scalable Vector PMULL instructions)
 - FEAT_SVE_SHA3 (Scalable Vector SHA3 instructions)
-- 
2.43.0


