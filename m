Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19CBC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXi8G-00029O-Vd; Fri, 04 Jul 2025 11:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi8E-000273-3b
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:18 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi8B-0004el-T4
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:17 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6fb1be9ba89so10456026d6.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751642115; x=1752246915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoLfxluEkOnqZWGvoYUYEDIuHb2S6wPjEZT0a5AA8Vs=;
 b=NUh6Yrr/wkU+J4IdYilovqUcnzFH39aa7NBzZ8P4S1n7CfhWCOGVYNYCtLrcCNYVuN
 wu7GcIQZkUGG3IBKHGIKbWaq2ek6vCjjP2KI67G0rnzUr7K/a7+rLUGltLd0A70mCaiP
 OdXbaAX9qunjjTJM0ltLtmYkKT+ILQa8XRZelJ0BCmiPFKsSM1vOk+yQ1J8Gpo7BrmPp
 L7erZVXzFQYUbeWOydJf7IcQI0wF4K2+RuA1jRLL+NYY/lYY4wWtc5eRJu3N5SMQ7FxA
 sMHDuROaXlT2BBRy3MmZYRb5Z5e4OI1t89qNx5N1THGisV217QZUMPRSpZG0DMSp4Gqh
 GkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751642115; x=1752246915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EoLfxluEkOnqZWGvoYUYEDIuHb2S6wPjEZT0a5AA8Vs=;
 b=TRvtG8yngQBVGGJQ8KLQP3uTKCZd/J1Es5w8bHvfjtxL9qq95u64lAWZTelKklphNh
 sPFcbRPJohUA9YV82iIDCAzZHw1xGlgxS6pGbrI1DPwMupVFMf1v4xKAJ9g5O/P/BzKZ
 m7odFQZxW9C6ZGFwYuMU/zUqDQqBtpKODWFaLhSS1huoaqhmnauLFqHYDV437pZZnk1o
 xpulUQlQuj7Wvum9szHqTvP5hn6+R1XtW+pf5oWh8+ffFvvBFWcTKmIqA79VorrlTJFR
 9Whn9k4lpaCQqRteIWTc876zFV4BVJCvM91rLQMMlVPKSW+rEKXkKvqcoknzTH7/kGBJ
 seQg==
X-Gm-Message-State: AOJu0Ywp98l4RFVebcPQGtvtfniIcgBGjPronvAxPgYs13759VWPeRRZ
 uBpqNXi/55TK+x8N0e/ATV6jaM99kxjj6D5fZ6oV6Ikbmj1o2JaXQ87HNgq+1uPDxJ4=
X-Gm-Gg: ASbGncuGNzrpObfRLB8jMPDpmphbKoUXu2vO5eKV8tXIoB0hMXQLAX8fbtyxe2hcofW
 rxLjeV7Tm8HTEhTTxjOtS6CiZaMeTDiAt2y3WYoCEyBZc0gcLVZ7sTwPdVma2MwGyhdPbFQeaI1
 u8bRtFMSi6jCedZIhxykX1ZCq7N9uC7yjnkyb2eqdOArVjwmOBrVbK/13F4axUJ2Jj0SF3imNEP
 tOTlPZGGHoFowOee/ppASDBbnMemsjxxDwC6TpaUqDTRQXH2qZr+8shQBU+CPffTCEK4TrbNk0f
 gouH+xkKZ54Vg2nWCZs4y0K1V+9SsM0AocHhO/AgPW/3F4N+F572Khn2jpDbAkiRE8c6wR8jTpg
 oHQ==
X-Google-Smtp-Source: AGHT+IGBKNTZQF8m01ia30/qAaj3rTGj3sv76gjBLyjix3w0Rk2Wqy1FdnzE/7UzPybfwIeFKAWw/g==
X-Received: by 2002:a05:6214:3f92:b0:700:c717:493b with SMTP id
 6a1803df08f44-702c8bc0f08mr36682916d6.25.1751642114783; 
 Fri, 04 Jul 2025 08:15:14 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d6039fsm13658666d6.111.2025.07.04.08.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:15:14 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org,
	alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [WIP-for-10.1 v2 5/5] target/arm: Advertise FEAT_MEC in cpu max
Date: Fri,  4 Jul 2025 15:14:31 +0000
Message-Id: <20250704151431.1033520-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704151431.1033520-1-gustavo.romero@linaro.org>
References: <20250704151431.1033520-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf35.google.com
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

Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
first step to fully support FEAT_MEC.

The FEAT_MEC is an extension to FEAT_RME that implements multiple
Memory Encryption Contexts (MEC) so the memory in a realm can be
encrypted and accessing it from the wrong encryption context is not
possible. An encryption context allow the selection of a memory
encryption engine.

At this point, no real memory encryption or obfuscation is supported,
but software stacks that rely on FEAT_MEC to run should work properly,
except if they use the new cache management instructions, which will
be implement in a subsequent commit.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/cpu-features.h     | 5 +++++
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 7 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 611d7385d8..14f17febe2 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -89,6 +89,7 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MEC (Memory Encryption Contexts)
 - FEAT_MixedEnd (Mixed-endian support)
 - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e6a731472f..009618fd9c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -603,6 +603,11 @@ static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
 }
 
+static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr3, ID_AA64MMFR3, MEC);
+}
+
 static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 5f77d320ea..1a127f6cf7 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1243,6 +1243,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = cpu->isar.id_aa64mmfr3;
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
     cpu->isar.id_aa64mmfr3 = t;
 
     t = cpu->isar.id_aa64zfr0;
-- 
2.34.1


