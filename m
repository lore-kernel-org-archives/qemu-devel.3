Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4782BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 03:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1cYZ-00005b-II; Wed, 24 Sep 2025 23:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1cYY-0008WG-1g
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 23:22:06 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1cYR-00088E-A5
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 23:22:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so538002f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 20:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758770514; x=1759375314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tnyi33IajyywLiwqk0hFaeDi2TC1JFPW7M4x0i1cEBo=;
 b=HpmPvyzm2dtn6AQWFN/0K99bdczyjATZSFQkNwyxO2KSzhanDysVaTDuFDMNRB9fFa
 l09xslzeiKrEaZlaxEBOHhb5qkKOPnKA8ajk4Ef4jZFaQzHl5YN7ZaIP4d8ogDGOIka/
 Hu1LkTRQt7QmSfdC7NROYwYknzW/IN7H5AQuky+49/gCydZVpB7U1DjqOEPehoijA19M
 t2RG33V0CxUb8oQKwH3uiibgnwCKSGYLfmV1tHQSPnRntDz6ROtMnBVdUsc0GMRHdLOj
 9omKBrbBoXAeEnqPYy8lSWQvJIBTW+uOLiDKc3bFZeosULkJL85ItSVGS0uXtLbCVQo4
 2QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758770514; x=1759375314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tnyi33IajyywLiwqk0hFaeDi2TC1JFPW7M4x0i1cEBo=;
 b=IeWbOH9bW2rpOCwVxmts6Z7Gu7trUEegtHWv0kUIfb0xRtSRUM0K58jECfXL1w6HVm
 BlVm/lpki4qkPl35qSZWf9Gl3nCcSGp7eZH6G1TACNepaAFXKKaR3XB/uMFuX6j+jADZ
 j9pMLuyHSRbIDCTNxZqbUEigNJbkti8htJRaSLA4uTTxq5G/93A0+afyonfjzdQmw5XD
 /AKvDss9jgh1Y3JmMcfTaNkitbb9tdI9xhMggd+06kQEecpYbvvhqf5s3wg9ejADIVza
 4Y3CGygjoML2elqrRbT7cI6z5ZQXV5Ty5QL8i8yLjVD3LNtrOKsfPDVEfS541bb7IrOl
 P+7g==
X-Gm-Message-State: AOJu0YzD20M8zWZaLKuEOaSVwX4tuVwhr9BDscqfO1uxw7Q7LEsVc1b4
 4NAGdGrqWc30Yvf4Vf/NVYtbAqPJN7mpVv6moF2bkk2AdNPId6PInA+gviLcUG8z9aRjRFcgUI3
 l/YqOUGLWCA==
X-Gm-Gg: ASbGncsgk+Jx5wMSMgyhyhoZfZkRTPVRmEL3dJ6fa7mRTY156CJxy5uoDwzjmHyjTs7
 enRDEb11utfqXxsn5i1bfdx+ON4EAeaPHE0VCaKDxUDglb7NzM1bsF4lOU1M78gwijAg/l8gyHP
 8mEaFW1c98OR5InDX/8hdjT+tGESra+6exriznWxFiiKFEAGxgXjXmOxEVB14ZS/Z33FyRr5Bao
 EG/a5ws3nJ0sZR7KB/VuEMNNZ96QK5DP5Eb+TCSdtBTRi5VeOEgLKkFR6rmhO1K68xcDVy7OtbR
 akdDrq/ByhW3Dlh/H8AtCdwDfFOvICOWuhnoEjHJtOiOD6paa5xxbjhI5HZm6j61hKv9rdJ2Xnz
 YBSrlYnSOfRDaVvRc81tJnP/s7IadgZ/PXhsRBMNfp1f9lv/O/lAdqG2pwFQVBX2DpmXwrIfD
X-Google-Smtp-Source: AGHT+IG1qt9WN+89+sBmkYf0GKiCUK+sf3TrtT14E/eBdQnYlFnFut1WoaFROlUm9pDjnFeWRuL5Iw==
X-Received: by 2002:a05:6000:25c3:b0:3b7:8da6:1bb4 with SMTP id
 ffacd0b85a97d-40e4accc86fmr1646939f8f.58.1758770513688; 
 Wed, 24 Sep 2025 20:21:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fac4a5e41sm1066296f8f.0.2025.09.24.20.21.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 20:21:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/arm: Replace magic GIC values by proper definitions
Date: Thu, 25 Sep 2025 05:21:51 +0200
Message-ID: <20250925032151.73250-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Prefer the FIELD_DP64() macro and self-describing GIC
definitions over magic values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c44294711f8..da8aa7b9d08 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5184,7 +5184,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t pfr1 = GET_IDREG(&cpu->isar, ID_PFR1);
 
     if (env->gicv3state) {
-        pfr1 |= 1 << 28;
+        pfr1 = FIELD_DP64(pfr1, ID_PFR1, GIC, 1);
     }
     return pfr1;
 }
@@ -5195,7 +5195,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t pfr0 = GET_IDREG(&cpu->isar, ID_AA64PFR0);
 
     if (env->gicv3state) {
-        pfr0 |= 1 << 24;
+        pfr0 = FIELD_DP64(pfr0, ID_AA64PFR0, GIC, 1);
     }
     return pfr0;
 }
-- 
2.51.0


