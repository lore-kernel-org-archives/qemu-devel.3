Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440DEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOG8-0006o5-Tq; Thu, 02 Jul 2026 16:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFz-0006jS-5u
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:35 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFu-0000Xz-Dg
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:34 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-845b6d9bf39so1080225b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025009; x=1783629809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dvj9xcrn5vA+by5DDCx5rt0ZpkSrj83ns6o76NPPdes=;
 b=QHpK4PdhdJtAdXtDzsLMRv4ih1Kl6zLef0BzAj+8H2YEJ8MIMfcl2Ef11Tum1yLTSy
 NTJLZJfmCVLEjBznUbeaH2J+Fr2bKYyCTkj/vQRGVpFCk6LIsIu47FIvhhKj9Zkxp6QN
 SV24MD5I6Ol6VbrZBnO/t+0g2rh6rMIUcgLUPdtEOgjHYeTiAeQp9qjdGjt0O2e6Ze2w
 yjiEsDKFSed6YDFrJyvWVejcjBs4BD6l8P/kN7m8DvOyVWY65/6RA0Jb4ux2nK/pRLc2
 Y/KkrmDiNCNkQjJwiE/5s7ibCfd8AafBn05qR6Mn+n7s/5eGIGdDaplexkxxO00p5C9s
 Fp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025009; x=1783629809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dvj9xcrn5vA+by5DDCx5rt0ZpkSrj83ns6o76NPPdes=;
 b=UZoy289zdM+weLRSN7z6/Ra5EU3PEzuwssmeHK0Xd3bjIEq//u49M+5aRu1je60T96
 JrSedi5qYmGG+wO5qYWf5KAaEXPl0bLm9xgk4Dm+if63pgMI/K/ggCooFPjig2Zk7fl0
 VY28M5pFoZroY5vJjKeLWU/ChojRfduxYrr9X07oog5KzCo1JuCa6ez2y6VzGjs74oIK
 AO2AbH32oqcqMM5IDSrGBkzApRbBd4ZbnToZJIe7zjdjD853+e6XMCgyD1DqzJ5gKT5m
 KqAZUvPYOhOexq1SzR+2mNQHkkQNXwlm2Jk2d9LQs0B/S/kCyM3Ak0uQnGs7vBQWCXeX
 zczg==
X-Gm-Message-State: AOJu0YwMBrYoXKSS+idSUSr941a9kEnoKOwVSvK/4fTuYDdy3B96OrHr
 mVTUMycsGTR6FU6ePVU49gE8TKWG+/kyTwb0aTHmkhjAlLyi0svxidoW2qK7CB47ZLmvDfukfL6
 FbwD5
X-Gm-Gg: AfdE7cm91xYt1R8fofL2gd8RcfNIrlFlP97hr0dJ9K9wAlNuaiLX3mA1MIFpvicAAju
 Tln+VFYiPnpplL/hQhLMY0qSt+ljNy0/t4iwMGTMJ0rxTErRbWTb8Musv9ZOZONMsqjPn6V/e/w
 l1BhyGBVfFltQE01juSQbKfBh4TWItaqYQhDMWPEsDoR4y8TYWEkiNj6Riw241g4bC8FuMLZ/AH
 nV8BherJ5KAvxpRq5PFWu4FcKnCeu63+nihdNcPEjehtzmzp2kSrp7lTMXKQ6rjx4Ciqw3RA5OC
 rJud71jo6sekEUn46C1ZpaOjIncrMIqepeuStPeAhu2Wy9UuBPcE0cC+4azyz19JVqBLWI81UO9
 dvGP3aYia/jsFF0kEN6T8BroaFZ9JdAvaMJ7V415EuoqkBRMS3bAjPXnnD+8TpzUP2FGsTRHDdJ
 QGtwfSEBU9NZb2jIhdHT2I3345f7yr9f28h6QU68YOzD3yonVG/g==
X-Received: by 2002:a05:6a00:2343:b0:847:8d6d:bc33 with SMTP id
 d2e1a72fcca58-847e192ca8emr1280943b3a.35.1783025008904; 
 Thu, 02 Jul 2026 13:43:28 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 15/15] target/arm: Enable FEAT_SME_MOP4 for -cpu max
Date: Thu,  2 Jul 2026 13:43:14 -0700
Message-ID: <20260702204314.79224-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 42aeb29306..5c5fd17d68 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -174,6 +174,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
     GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
     GET_FEATURE_ID(aa64_ssve_aes, ARM_HWCAP_A64_SME_AES);
+    GET_FEATURE_ID(aa64_sme_mop4, ARM_HWCAP_A64_SME_SMOP4);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ae3952a1ed..cfff494e91 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1383,6 +1383,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* FEAT_SME_MOP4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 191d1a8c93..a095e293cc 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -174,6 +174,7 @@ the following architecture extensions:
 - FEAT_SME_F8F32 (SME2 ZA-targeting FP8 multiply-accumulate, dot product, and outer product to single-precision instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SME_MOP4 (Quarter-tile outer product instructions)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
-- 
2.43.0


