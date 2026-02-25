Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988ABF4BB9F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvClN-0007vz-29; Wed, 25 Feb 2026 06:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvClM-0007ve-55
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:09:04 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvClK-0003gh-0q
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:09:03 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2aaecf9c325so5241965ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 03:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772017740; x=1772622540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjuwdpdQeEsHuCFiNGe8ard4PSb9WYSbM0q1xrkNAdU=;
 b=YfruUqahVQE3VwFtMCIA9bvpFgIDplXOn1FuVJtIX0S+xzt4RKFUYXYiTtX0ut5GKX
 NHZ+182usBOR3JZbp46ad0HaJhLVoG5SgU1OPjAx+XQuIVltnBcX92wiC92IbQMFh25x
 ZvJhWKFBpLYNYdD2PGr6rhqLtx7ZYYQy6OLVr0lHs/8Rw27NfJqXIXhINo4IQ+xPnD/9
 mdLyUA6rh6WiyWOdNRDQLZQVrzmqoIkiFVmR90VH/aEQsDxakvyceooN2dAgJHn9pNai
 iVYOX3msfPMPqPmDa0ViBAPw1S4547rJHyEOpgaKs3v2UsLnruh19PxVkorMXR86KylY
 xIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772017740; x=1772622540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qjuwdpdQeEsHuCFiNGe8ard4PSb9WYSbM0q1xrkNAdU=;
 b=U1IQlgrcz1pFT5SVSYntPD5zY/Hyeb1fmJDWQc69OTRY/ZFks0VGClYdPGPxj3ba/Z
 OHFgRYoQ/Ut9dNDSF/ZKeALL+KLsPsYOrPEZYhHz2DdoeiQKUGQ21IbLGJ+XfbpFYfx5
 z19ip7UHZurPimRzEu67a1gKyPXUKJdvZgrXzHS2j7pznLNy6coqQD1MK9lscD15Gk6D
 lnLISZfSboxJFBro9waq06Td/4WrEHJwAK5mkcKjHYU3RKeCu/x3ds4ZGuoH++Iz5b2n
 adYV21/A2nTL3EQx6wuNhOBEY1/exJ9QqZXTU6g7jDdkQ/jGKrHUIAgmZMsdEEqbfro7
 J/uw==
X-Gm-Message-State: AOJu0YzIy7SoFrssqZgaKrPmff4Hl2RSm/SWrOeeHrvTWcp0ielwirM0
 oxr1tYaUbq5nMNSRrdai3pTdAOqIo/YEynksUyjW5KfUE0qJT4hrHN05ncRlouH1ufyPZ1dxtTr
 sjSDXH495/ZMtqr+em6ASgzsa0Ayxe46CG2THXG/Ybp6j7K1f/96Ow//lJ7xn9MVuv4JGWKkh4s
 kEOKstQmQP/Jdc06/XWv3fGhF2Acn1xWi1IcLRU9F7BdHq
X-Gm-Gg: ATEYQzzkKDsOYkjzQDjdVewfP6QLXN2tjsZ4z3EaWGTOpVy1MAsr05MY4iFx2IUVPV5
 vFXYvcaFg95T6W4uly/nBOfeRCPkdk8smTxDObsBYmaZEgx9lJsZg74XcZJU5cSA4E2BfDii0sU
 9JXBbq4QkFG5cln8iJ+JC19ZvntWU/y28wJjDAcjPBZjvTXEUFuChQbbQ2TDAmyKGPH1/pFZefN
 u+5GEOao/LVErNe92yaqnY8paK5HvrW/aStiLcjvuWTOB5W4/XPu22MySVvGyAWCQeBDZ4jTz6b
 T60Z+a2cUT7OurJ0kCcNtgfllXzIMFrQnZc585hPIic5OrgimYHTcdvEKfssBcNZMjmaFqe73Tj
 67q7qJQXieKr0eiwZ3K5CEN0RvDeWnVmVQn/lvKFTDvmcDrO5EqcMPK+0mIWz/adSELjej7N+33
 8FaQy82N//HHJM3g8m+a1Ihd5W26w4E/PeYcZtmvchtlKFionkGTP+sMDEJiIDM5FEEG+orbCMB
 S6+t/X7bFIErC/vfYYB3KiyauDLlkJtlDAqEA==
X-Received: by 2002:a17:903:2350:b0:2aa:e238:e20c with SMTP id
 d9443c01a7336-2adbdcd8822mr34166335ad.19.1772017739483; 
 Wed, 25 Feb 2026 03:08:59 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74e35133sm140452665ad.9.2026.02.25.03.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 03:08:59 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Max Chou <max.chou@sifive.com>
Subject: [PATCH 2/3] fpu: Fix unexpected exception flags when converting
 infinity to OCP E4M3
Date: Wed, 25 Feb 2026 19:08:01 +0800
Message-ID: <20260225110802.1217946-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225110802.1217946-1-max.chou@sifive.com>
References: <20260225110802.1217946-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x635.google.com
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

Infinity is a special case distinct from numeric overflow:
- Numeric overflow: finite value exceeds format's max normal
  -> overflow|inexact
- Infinity conversion: input is already infinite
  -> no flags

This commit fixes the unexpect exception flags by relocating the float
exception flag update flow to be outside the uncanon_e4m3_overflow.
And raising the overflow|inexact for numeric overflow in uncanon_normal.

Fixes: 27e989f99c ("fpu: Add conversion routines for OCP FP8 E4M3")
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index a738758aee..3c323c0cec 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -277,7 +277,6 @@ static void partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
                                           const FloatFmt *fmt, bool saturate)
 {
     assert(N == 64);
-    float_raise(float_flag_overflow | float_flag_inexact, s);
     if (saturate) {
         p->exp = fmt->exp_max;
         p->frac_hi = E4M3_NORMAL_FRAC_MAX;
@@ -388,6 +387,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
                 if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
                     partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
                     exp = p->exp;
+                    flags |= (float_flag_overflow | float_flag_inexact);
                 }
                 break;
 
-- 
2.52.0


