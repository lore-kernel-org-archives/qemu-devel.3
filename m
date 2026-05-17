Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC668CD4F49
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPSy-0001cH-Kx; Sat, 16 May 2026 20:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSD-00077N-Ih
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:10 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS7-0006qb-Jy
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:58 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c80227b1f6cso341341a12.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978033; x=1779582833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfvM4tnhG/6BVEOEoQSi0TAhQsUGcLPgZYrpPCn+HNY=;
 b=I6SRxWouj1qVDUhi884po4nT6XBONZze0strDFJvCtvDeyHq7Q3NrCxxq6+tWhthkw
 KvQOy2NaXCWYnJvDh/O2mbIRwW7mhhmpkOw1j9VmufOC0/rVU8QJUN4+UlS5UmLlBkcW
 VN75RwvuxIB919yPNvX1/DidP1K80Ctnv7dBKNKQA18aAo9PXMDgULD1/uFhCKxiIXYt
 VQZ7xPvk7Vam1/RijlyqZAjYWauxJnGKPlKZYmiP1ndHOfKU+GLB3wUK1KsBuww2BmkL
 eWIwKmC93ObjlRMFWXSHFQcWRJQ1Ygn28Toch4Dq3W8EB07m51a0rRfHpRRsGSIfEtkB
 jGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978033; x=1779582833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WfvM4tnhG/6BVEOEoQSi0TAhQsUGcLPgZYrpPCn+HNY=;
 b=szD8a7zeBTN5HeGT3Xcl6kbPmyTvAgMsWFHL7a4dRXfA4U7xNHDqPmsDwPDEl4eCTU
 GL4X6aGgLKPb2tXRtB6/Js3+BnS2iSFsHJ0/9DFBVh8XDi2kYPo95UxUsgcsRxg4hFY8
 akIv15ME5Za8GRjPdVFSGuLk+JroXy1u2SONT6hcw3IMnWX9LAOO6tXU2Vw3/IYN9eAB
 TcrbYUpTlmBF9pNiMmnBE177JEqn+EaJDAwQZE1edzY8WhYSpUHLrpVixhkxa3nNmNBm
 heT+JKsIPTrqZbCpB8azAkUgHISMAsTO4ucW0FMTzRPYEKNNkeMEN9T7TkmG+WFSWTRk
 4nMw==
X-Gm-Message-State: AOJu0YzskBwDDeTF3oLllzLk24BhquHLCxa2WsmZIyPn4RWpnU1sTCag
 VnT4dI2Diki/oCEM0eEI/KhNSuNlUmN5T5FUJrfNQL9VdhoS5tc9QoyuS/3+0IXireHOfXCDtuY
 mFroS
X-Gm-Gg: Acq92OF1sHR9XFRP3URwUKhNVroUvt22rYiotIql9LS7wNLeprxMC/PNszf75hdFnAW
 tMejO0IyimV+D73wON4J/TTghaWorrXVKGfoxCPTYa+i68J2BlqOO+ghHF834U6WiAtGFOMhJJg
 EmGhBdd0P0zjUYzbJ0/qq/BRyDXftoxWi2KM21be98t0ny7witWojy0JX0bAGVqo3ursaJufcdL
 h1SDhlvzWCUpEmSpY4YQuDls/Do9itksIyGVwTor3aU6RNn6RI5W2alcfquO80ncJsWBPTHkX+d
 huq/3uaEKkwDqa33UsZ80ykNKJKi2s0eLhMWAvNCOXrpF0UBVW/q/9jpJ3GiaSQrXTQSrZYbfDE
 VPw+CXEoy16FH705R3MzGxa5R//4IjK7WqCFw6mgGoCSlGtUtHp1SQTDHVpqzP7Jkklhe1GT3TN
 56qZ14Qw9qhWjuebqNG81RQMh2CPVz
X-Received: by 2002:a05:6a20:e293:b0:39f:441:493c with SMTP id
 adf61e73a8af0-3b22ebed7f6mr10704778637.30.1778978032846; 
 Sat, 16 May 2026 17:33:52 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 52/63] target/arm: Enable FEAT_FP8DOT4,
 FEAT_SSVE_FP8DOT4 for -cpu max
Date: Sat, 16 May 2026 17:29:51 -0700
Message-ID: <20260517003002.321430-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 93cd7ee1a6..6dec7e045d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1377,6 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
@@ -1396,6 +1397,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index a6b48f9c60..bee4e36dc6 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8DOT4 (FP8 4-way dot product to single-precision instructions)
 - FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
@@ -160,6 +161,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
-- 
2.43.0


