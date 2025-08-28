Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544EEC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urauj-0004Sm-2Q; Thu, 28 Aug 2025 07:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauM-0003hO-Sa
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauK-00066U-UX
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so5403325e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380907; x=1756985707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+iibDeZh9Q26h4uiIWhGZyfyeeD8dI+3eoknboruTG8=;
 b=eUZ4Oixo6oDLCqWSPmFgC1YvrjS2hgzD6EwMs7vziDuRZaDp9Tsavh32LATWFFQb2c
 5j/wPNghLkdacszuN27gJTqw5rLheQnZ2WaHmse6WJJXPJC/TKiKP4G2BnLkHG4B/bdC
 rtHZM+r24CHzeCv4/1Bg4YrOBI18YULdy9xv7s+Mhxlld3Wqow/CfpVrURX7OQQ6o97J
 acV30r2j3EwqLJuIMcxqar0pLqkv8GaCLMJCdrrIVRbdZHa0Upv5MFp2XqtiXsKkMRxn
 +7so59No/EYy34sdcy1fvxUO+TYcjR15D1OFpn0JhNc5jtYpMHRV0Z5tX7U0M1YVYFek
 yLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380907; x=1756985707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+iibDeZh9Q26h4uiIWhGZyfyeeD8dI+3eoknboruTG8=;
 b=Lr7Znoj7DRIYu+8kkHyQN/l5r+32X8A6yMV7/WFmFop4OZCKl6nAwoxLAhZ9Fa7X8S
 LsBOejp8uymgF2RK/GwOh0hRY2+GR4gGDyN8fEgdXYlFKM0zVHMJA2z3P264EHh+RpSf
 RKyb1X9nzqYlmisIwNDrH6k6qw2z+iQHJeu63QSJCHigrAAmNOiYw0NQI2iM04EtRJuY
 lQJYXzHEk6Qj2aFX67gPoGl7Wcx7xd8brc96wJJkuPB5BnQa9KNC7/7Oj5b1eho0TOKK
 qNNBU8LNUz3PgFQ7PxHDqBLANW3Hoqtd6ksofDiBcAaHnv8ZcyVAhBusqxts1ToOBHO7
 qgQw==
X-Gm-Message-State: AOJu0Yyj4TrH9ZOXx5A3aXcELJCkIzRvuDwJg7PNmqhDB/BESSjSaS06
 a0NgYYgpgk28aHOorb9Jg+ycXydxsiakGXJpKFb4e/lksefbXNerlDwJy98xestcCKgL1m/SHDG
 jvMsH
X-Gm-Gg: ASbGncv1DlaP8SCmzNLdoCcwMM0ZtAOO5FbA9TK9gDmggEjUR6V6OHoAJkBw8Ohx63l
 CTWbYwANZN9OkxVBrHyt4HeDxY281EOG98rO5djOzhkQS+GTmm+0wWVWO+Kr9t5CThPuS/BtsXl
 nlNU3Fd611DD+15TDZev9gxvzSSJHr6lInfeBIjl/pF0kDAM1exPTJ94JwOh8dmYNrVuxIqvyI+
 Wg/r6ywI3pU8P+TeKuYd11wSrkgdikzanhY25XwkLX+nSflSGI1rS9k9Gd4g6QI1TMEEJ1GWkHR
 4b/RBVrE09Qeco56WBRaBpI+jYyzScwe19iQSnxocmB56uaF3jVhLpv/4hWTULw29+prmpBS7MR
 YXmSlxSeYiS+O0FZtZl2Q7EH67pKk
X-Google-Smtp-Source: AGHT+IFtlg2qqPip0bUM+8An8mFv53/fw63gMNjBi80oUK+1V4poFQx4/JLLYDg/vI1meZCoByeQow==
X-Received: by 2002:a05:600c:1c0f:b0:45b:6365:7957 with SMTP id
 5b1f17b1804b1-45b68bc7a0bmr74390865e9.33.1756380906995; 
 Thu, 28 Aug 2025 04:35:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.35.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:35:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/32] target/arm: Enable FEAT_LSE128 for -cpu max
Date: Thu, 28 Aug 2025 12:34:28 +0100
Message-ID: <20250828113430.3214314-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250815122653.701782-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b12f013b4fc..4e8aca8b5d5 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -89,6 +89,7 @@ the following architecture extensions:
 - FEAT_LRCPC2 (Load-acquire RCpc instructions v2)
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
+- FEAT_LSE128 (128-bit Atomics)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MixedEnd (Mixed-endian support)
 - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 0bec43d8c38..ec81363c920 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -213,6 +213,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_sme_f16f16, ARM_HWCAP2_A64_SME_F16F16);
     GET_FEATURE_ID(aa64_sve_b16b16, ARM_HWCAP2_A64_SVE_B16B16);
     GET_FEATURE_ID(aa64_cssc, ARM_HWCAP2_A64_CSSC);
+    GET_FEATURE_ID(aa64_lse128, ARM_HWCAP2_A64_LSE128);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index eaf8846a6a5..b8b1981e702 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1145,7 +1145,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* FEAT_SHA512 */
     t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* FEAT_CRC32 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 2);   /* FEAT_LSE */
+    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 3);   /* FEAT_LSE, FEAT_LSE128 */
     t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* FEAT_RDM */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* FEAT_SHA3 */
     t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);      /* FEAT_SM3 */
-- 
2.43.0


