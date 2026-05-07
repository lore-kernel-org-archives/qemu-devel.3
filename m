Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672E3CD37AF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8SD-0008A6-Oo; Thu, 07 May 2026 19:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rv-0007Gw-Be
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:12 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rp-00028L-0x
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:07 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-404254ffe8aso1234607fac.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197682; x=1778802482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnvL1dEdpYA1y9JJcxfkHku7n0bLCdQETh28Vu/3wxA=;
 b=BAjL1TASmH7FLn/vIBELkWBlrPlG1FAl19rg5Qyb1yV48fFzBmJnJwyV//SWLMjj37
 OAVyr3arnkmcWHFIPMDCumcDwefdQsnEIXH86/zxxjk3fgp1fbZWXCiekFUG9By2LL8h
 28OmkAJRJkjAyVoeF4zlNl+4IkszkMNvbdhrBk5jcLcbYxNduAf2RSxvcDqEfI/8jDti
 MpxNT3o7XJL2WI4GqflbVd3dU9go4QUyPHOK6uusqt+1KZq91AB/3qPxhY2MDcaVipv3
 QlihWaVpQtr/TwIuEN4MmMq0eFMKajo5cqD29+ZvO1t8VQCmos/y/uYM5zfzbp88zTiK
 9mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197682; x=1778802482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnvL1dEdpYA1y9JJcxfkHku7n0bLCdQETh28Vu/3wxA=;
 b=UGRLDe0Mfu/flMNb73f/YefnSVMNJUZMUPV4dmurcBljaXuos93fhIFr2m1fZv07Cv
 nAeoUyOD+Dhm9kq1/C07/5N/mUXgXLiqROaZLSUkLdlQa8k4NLRyK0Zvj3+JQjERbVDW
 CeP10mJIFUNOA3WRSOwBPV9oE5Rb3kzWVT0wXuCQq9VHCEdYkt5XUJTFRIUKMXCB+fYu
 /deewPiaT4g8IdGyQJfPMoBXIb1CzGyZQcyZ+Ij6l9f7THz3g/yUvsXaFiX/WOY+Svx7
 5xl+gynRnIkgs7g1GvQGCIDM15lEVV68Az3J2RCu0thuYAan9aKzgaJq7TSLdlr4GwGp
 bkNQ==
X-Gm-Message-State: AOJu0YwT17sSUwJAZAFTpNO8GD4gesTtyGMc0ZXo0q/CKXKZqZGF0qIz
 JyxaK3Z/I5U3yg2g3yWeeI6gRV6JUDvjRD/x1MWTgC9zFoMPG0DxhJ/G7rjsVHCW5TDuh/PG8Hs
 2GrzZ
X-Gm-Gg: Acq92OF6PCP7fGAuaL8Lh0LEtFk+WhxQJ+yQyOmPPtLRFjZtdXf1wKWx6wLi2JEqhPW
 58+inPPFXHj5038h746ih4W68EWEF5Vi2CcfiG1dOvQKA3lcfwFKjhI7XwMR0fxgc4UxrPFFI1u
 T+wlx14u1VW9zvMdxL5EKt2MyigbdhFyjJBVxQ9rJwvZXaC54ZPk1sQmTccXJmfOW0rQcDXXRx/
 YxtnbKHuaukv+uWKyxOmjPqdHaZxFew08urKrtf12yCkwGumKyJAWwIp5DuUBtxb2LcOJDE11IR
 BDlmuvtkmX7Uqqeq1Uw5Wr+opZQA6fip7Odlb2CU/E/CqtR3DkJBXVMFUSUzhqvokV1F+jFCl1a
 o61ZmXegJYXjJORLeZIzkJIyynrdUXBERNi+YIMce/Qxn/OhfDA6ieiwEVCCwJwtIjN9ZHAKYro
 jZ9zCKuurXAwW02rkaffS0Qv3jwoeo69BH4exZ2acrJ/7Cltp84C8ecxti
X-Received: by 2002:a05:6870:d0c5:b0:430:17bc:5e37 with SMTP id
 586e51a60fabf-435269bfc07mr3017094fac.14.1778197682021; 
 Thu, 07 May 2026 16:48:02 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 48/60] target/arm: Enable FEAT_FP8FMA,
 FEAT_SSVE_FP8FMA for -cpu max
Date: Thu,  7 May 2026 18:44:01 -0500
Message-ID: <20260507234413.643512-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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
index 90214a355a..93cd7ee1a6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1377,6 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
@@ -1395,6 +1396,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 0dd6b554a0..a6b48f9c60 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
@@ -159,6 +160,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


