Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B500C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjED-0008T3-Fy; Fri, 04 Jul 2025 12:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEA-0008R8-Cq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE8-0006AG-Je
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so792737f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646327; x=1752251127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uBPfSzPUmkkrO04BBwpb4eXji0vKcpAvRC0TSrBdTcQ=;
 b=AsHMkpegPFoUWpeEGYfohPSoKWq0xQ0MbcyafFXsLUoP9SAuFOJ0V9W/GR2+b5ZVTK
 dNjyAusK/vZRzH9LKoHmQfijFPm11BdK6GlIuBhtqkvQJaSWgHDgfJtdT9ty32VKVQLR
 MXHl1DQA3aN6jNFOvTd59QeYI20lx5nnK8WeUZKK9ivRiChFKeRljdBzYSAizlJ5SkVK
 xRlQuhD+bxU3qUe4ahr/d4xRfPLzRXZI5oDRhC0P+0vQwQH85rf+xnu6C3nUrzjo/Hwc
 sjCiiDAzgwj6ZQ5GV8hDAN3kQ1tNGEznfOYNxwKltxM+8qaXWLlXqApmvVrIF8sraSP0
 kEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646327; x=1752251127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uBPfSzPUmkkrO04BBwpb4eXji0vKcpAvRC0TSrBdTcQ=;
 b=vl/PVILk6YCvrc3eW7pqgOJKUwkqPiUYVNT5pFOz7BFaGg9SQAHcvo7Hx5RYUUpAe1
 5e5NXfiB9JkdM7C8Afgz6+RO31Epzo3Lae5y17lsjWFbF/bw46W/HpA+zhFpia7/0P3x
 6VxDIFFyAdfZtNS5gTWs0Siq1Z132PoEK7EF2ePX3oAFE+R+9EY8a02YU96E/lhcvtZ+
 PyuxLuLBQPg0CetNETibOrQACoLOBq6EENVGySBew0uzRx6G24pJx5njWDgPnS2i2wQ3
 ajIagHZGl+1Ln932sFU1ngCTn1p7CuP2SUqOiZqDg79LrnwlL+8iNk7ViV5O4iNS1mxu
 kKjQ==
X-Gm-Message-State: AOJu0Ywaj/NMvftC0xKAcHCXHR9EQSfOeT85r/Zp/0QVGTNFEQac6rku
 DjWhbHPNIIexEZhhB3izn7oZ89/+Ov+oXsre+z9Yw+ggxBoV9DhIWq4m9iQ7aPcU5IKb4uh0Ccq
 bAJMP
X-Gm-Gg: ASbGncs92F/dA0DjDGw/RTkP4hxmLATIsqI7pXpkpkRN2e6hYOkB3d+P8SJslgrnWYs
 VibEH0nEAvrGBgKD8AhumG6SC+pxK/8tydY6VA7nY4rhnQTKIjY3HJaJgpadF57BWY8S/NgOBEq
 Ul/TXLFUZKnMCptE1vnyIxI5jQ9GPqgGJnwUsz5gop4w7LzQmFZHeENRmcqNdcnibpusNjhuLO7
 Wd0ixal3QDFryD9oDBncZoZIEK0bl5rBspWYcOLBRucEPleRJZ6Ibk8U3XAF6ftpeoDJWXmOhQh
 xS4SqdMb85wcTJqiJM38FW7ZkeE+RjTGSFsGHKzsQ3DRWKpqSKz3FwIUaaTC7MA8zqNxH7WWwq+
 apkw=
X-Google-Smtp-Source: AGHT+IHJZlXRDN7l0q84CvNQBvnYV5LiwjZk+keWqwTpXBcfH30bFvqlnDKoMRxV3YGuNAjZJ2Tatw==
X-Received: by 2002:a5d:5d10:0:b0:3a3:7117:1bba with SMTP id
 ffacd0b85a97d-3b495cc44b3mr3358814f8f.24.1751646327063; 
 Fri, 04 Jul 2025 09:25:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 026/119] target/arm: Add isar feature tests for SME2p1, SVE2p1
Date: Fri,  4 Jul 2025 17:23:26 +0100
Message-ID: <20250704162501.249138-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
Message-id: 20250704142112.1018902-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 63 +++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h          |  1 +
 2 files changed, 64 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5d8adfb73b6..5876162428a 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -604,6 +604,11 @@ static inline bool isar_feature_aa64_rpres(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, RPRES);
 }
 
+static inline bool isar_feature_aa64_lut(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, LUT);
+}
+
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
@@ -932,6 +937,11 @@ static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SVEVER) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2p1(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SVEVER) >=2;
+}
+
 static inline bool isar_feature_aa64_sve2_aes(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) != 0;
@@ -977,6 +987,21 @@ static inline bool isar_feature_aa64_sve_f64mm(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, F64MM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16);
+}
+
+static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
+}
+
+static inline bool isar_feature_aa64_sme_f16f16(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F16F16);
+}
+
 static inline bool isar_feature_aa64_sme_f64f64(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F64F64);
@@ -992,6 +1017,44 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, FA64);
 }
 
+static inline bool isar_feature_aa64_sme2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) != 0;
+}
+
+static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) >= 2;
+}
+
+/*
+ * Combinations of feature tests, for ease of use with TRANS_FEAT.
+ */
+static inline bool isar_feature_aa64_sme_or_sve2p1(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme(id) || isar_feature_aa64_sve2p1(id);
+}
+
+static inline bool isar_feature_aa64_sme2_or_sve2p1(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) || isar_feature_aa64_sve2p1(id);
+}
+
+static inline bool isar_feature_aa64_sme2p1_or_sve2p1(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2p1(id) || isar_feature_aa64_sve2p1(id);
+}
+
+static inline bool isar_feature_aa64_sme2_i16i64(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_i16i64(id);
+}
+
+static inline bool isar_feature_aa64_sme2_f64f64(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_f64f64(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7db97e80386..c6041a93578 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2211,6 +2211,7 @@ FIELD(ID_AA64ISAR2, SYSINSTR_128, 36, 4)
 FIELD(ID_AA64ISAR2, PRFMSLC, 40, 4)
 FIELD(ID_AA64ISAR2, RPRFM, 48, 4)
 FIELD(ID_AA64ISAR2, CSSC, 52, 4)
+FIELD(ID_AA64ISAR2, LUT, 56, 4)
 FIELD(ID_AA64ISAR2, ATS1A, 60, 4)
 
 FIELD(ID_AA64PFR0, EL0, 0, 4)
-- 
2.43.0


