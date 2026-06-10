Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DBACD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYJ-0002EN-W5; Wed, 10 Jun 2026 12:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYH-00024B-FI
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYF-0005yb-UQ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490af320e2aso76642725e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107990; x=1781712790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r8wjXZ/QtpVzCx8ETVlJ4ncbyArSk6MsrV2vSYfscQI=;
 b=HBWcPZI0ZlCWjD8odjXXbC06n2VB0M229d9+Hs3DlLmYK8iGwT4QCqxZSP57/KEQVe
 7seM+dPltTQ0EEQP/u0HhEpvwv8YXQZlbP164vp1oKNzBOA8FTGQuYeL3i3AHinzqLa5
 iMq3bAhs2rV9jo+Dqw2aVx/EkzomhhdHT0meOPF5IBvMvTJuZYeYEDqSR6uCFItHZAld
 NS5OFkZEUMmwdXVJyWMUxyDZlx24ZgPle86eZMO/EZQzL1BqZI2npudoSCqqh2phBD+L
 2OF+oy4Af2BXf1BoQnToiHEt8bT5YWIVdPV8YNcPpOQCMhxOUU7n/A6Owylgi1h04sjU
 uvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107990; x=1781712790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r8wjXZ/QtpVzCx8ETVlJ4ncbyArSk6MsrV2vSYfscQI=;
 b=Xc0AjFW1xnA9u7HzwqsiO4c/gP7zQRcYSXZGu/lppEmG2Q9ESBnaq1MQns0OhD7339
 A0qiy1w+UPoqMQYOYJuShTdoMBOCbAb/t46UYwD4pP4TLDhvgVO3jRBF/LTcrCXDrwou
 Aj7LN3xlw1Rq9rTfGATe5sX/8VfGHHfWUW9ot0ZXyWhAThZrmjnsyj1x4W5jD4i5+cGB
 SA7r6pCXSNjuiycSNBGBCrw7e7olrIHIzTmxOsn/VFx9isGs0FpeKUVrean7p/Y3b3ii
 JwILGbFi/eAp6CTRNt84Kqkmmkwao2pcEnlNSiuPdHGhbRAXbDjK3xGa8Y01Mm5kVZkt
 uBwA==
X-Gm-Message-State: AOJu0Yx4m60x2M5LJyJJpJrfYNUNFopyDjWcZ+qZAAaF+LU121QrAZyJ
 BHPDVySnUo3juvQJYCswAurOUu2bTLRObDABGt5l7jgK/7mrHnm1lFn5SF7bjoIF7a/Ovk7HhuO
 xqact
X-Gm-Gg: Acq92OEEqGqwVmOIAYUa5ANJzEMJRvW3U44YcOA5bvGB3PwBjbsh4bF9gcgq5I63Uwl
 cy9cfoBNw+104Wb1ipmc4b8MB4DRwKTxrH4bO9jKSESfx86yb6DoleJf+MkPYgBfUiWQfwZdZ4a
 Uc29wTnWMTAjd1UuSIFXJ5uUnSm1nsEiqnWtafUgO2lYu0tm5mi0x9CF70iPAqoBotVFD7F7LQu
 FDMqRbCY2FS78cXN2keluTP2/HJIQzi/91boYCJzuhrtGHJ/8lJIuhP+TZQHM4mYTPoALkF3VCf
 H5L/mlyFUai2hnRRJpjNJ4PkMfdCBG2bUAuRqRXtePobicojFFatXuzwh+9/aRVkPQYhIjZYAH1
 I+ewmpW+rWLqyFD0fOBW9Uvn6us8LoCIgSungbF3rdzGPT9VFFUQVEPkQE+4/RQTkUWLR+MPspG
 1O5gq+Ac5G+asIRlaRFDjm+ESONbcPedmKj6F75Xatl7A+Zh96J56/2nAbbmQBOKnnLnN7zk0Ix
 nSNtmDC72+Z8M1KZ6IbKYrMaBITX+rMr3dHEaRdc84=
X-Received: by 2002:a05:600c:1549:b0:490:c7dd:7cc2 with SMTP id
 5b1f17b1804b1-490c7dd7defmr331549205e9.24.1781107990467; 
 Wed, 10 Jun 2026 09:13:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/71] target/arm: Enable FEAT_LUT for -cpu max
Date: Wed, 10 Jun 2026 17:11:40 +0100
Message-ID: <20260610161202.2235298-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index df82b7f44b..1328cce15c 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -102,6 +102,7 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LSE128 (128-bit Atomics)
+- FEAT_LUT (Lookup table instructions with 2-bit and 4-bit indices)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MEC (Memory Encryption Contexts)
 
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 228b593316..5ed7a7badb 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -221,6 +221,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_lse128, ARM_HWCAP2_A64_LSE128);
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
+    GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index c7b1dd2e90..234368ba7a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1263,6 +1263,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* FEAT_CSSC, FEAT_CMPBR */
+    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* FEAT_LUT */
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
-- 
2.43.0


