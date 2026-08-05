Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19875C56201
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrh34-0008BG-GB; Wed, 05 Aug 2026 15:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrh32-0008AH-KJ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:13:04 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrh30-0005av-UA
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:13:04 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-45837e52d8aso495496fac.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 12:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785957182; x=1786561982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cSWHrmCcIoLctcWRNjW/E1tItpOgQeoCmZgvnENNjRY=;
 b=K74EL5SQ3n0IHQxYoJQlWkPA5QkZHKfpy79cKx8I3XYTIvHKGy6NepiORDpp7n2uGn
 kHhAbrxhhdEN9DV5Q9/ToMZhvf7AaCKWBYV3QVozksT9+FgNGiw0kpncgDxQie8VHkNc
 jOSESHqBlSFVwesm6Y52M9MuGPrGchkEBYpnNFPzVPI5YsYGFt42m2kUs9cr4IhUPMhZ
 l6HZ3EgC0D1UFuVktAP4rwq+1QQHXDJ5trI/6DW0EqFzBjyC4+w5jy5NKyb68+awpH9n
 qtEqeAobEWhUByNAc6fFaWxqPdc5oSktFTcZggI0TsUnB4yMO+ir7Xlv91ee+KQwE3go
 vSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785957182; x=1786561982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cSWHrmCcIoLctcWRNjW/E1tItpOgQeoCmZgvnENNjRY=;
 b=JHNtcWz9EuCRbRON1WjQ/CQhZb1yPd66gN6ANPfFMLcKGM6qROIVbTNtP4viphy+CQ
 3mXVyr8ttceUuIVeYayGAKyTUbydCok+GIMMMGKCQVWdM4PwfXXfPPD0x1arQNme7yKu
 4bgcWY1lMTVimRPjaJRJtoDCOLbuqwZRsHlVCHSw6rDq+ZOMjE0Eu+wWVzpv0NxWZxyR
 Wj0GUJrIbQBnDnrii9uIy7x9jthLHaorEQyzvD3IUib+GCFvZVmMnaghxJUmLlB+kM0E
 0zIRThhUN0zpJLPP32OpceV1oLpLbyHGFJXmePyPNRXEpIiu/VyMuiS0r/BmE1+fsQgS
 du8Q==
X-Gm-Message-State: AOJu0YyY+33WpAPcMPhU9pgZm+mxSr44YEkWG1Ht8yCUKrYZAYLpqwyl
 y5llglUWOJz4P5B0hGGN8xlpoO8wf46pYhL7b36A8Ryx6aH54vcsC1kwPTrGsKDD
X-Gm-Gg: AR+sD12Icp6Ur4BRy4QltH/TRz5RdeDXdim0soTYlUxlicjj9k4Lr4QivF5onyHvmdz
 9uf61fg6oSIlj16fR3dAtR6g4M0ijjvjOfOlzyiIwomvUonLXC1Kna209I+iLhK/fUkLzTyg4I1
 Ykk1wTIW0eRjnik0A7Q3g8pHTDCDIsOwPsOPtzHYpxriht+fxRkbZkHM8V24CEAi66pGnCE1BSf
 xk3cfWiO4KORlAavcAfnTs4QfEuRHTBegsMxJGXy16tDOyepI03j5uRa9v5+sK8aL3nfVjvRX4z
 Zhg71H3II9kmyQq5UUX165aOgh2BgpXr5Tq24lgvG9oAhdEhUk+zJvCgN2aWzkOGeB9CBIIXyxg
 WMHC0AbXhjb4yECX+nXLLFcTzUu0UcFFcUi4Cqd9swzPKKLbmF15VDG67/+7Gp/zUDSLBYV2AKG
 X/7tD5+PV3vn+H8TvGlJz7ovxJCtLVU7ZwgGOd0f0UIHauRMBJMNwz/HP577LYR+FXaAh11VJNl
 gF1sQCVdzLD/5o=
X-Received: by 2002:a05:6870:d40d:b0:456:55f3:b8b with SMTP id
 586e51a60fabf-4599ec98ec6mr4665684fac.5.1785957181797; 
 Wed, 05 Aug 2026 12:13:01 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.98.248])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4599dd615ecsm3494867fac.0.2026.08.05.12.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:13:01 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH 4/4] hw/arm/mps2-tz.c: add AN547 AHB PPC EXP1 DMA ports
Date: Wed,  5 Aug 2026 14:12:57 -0500
Message-ID: <20260805191257.11303-5-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805191257.11303-1-simonxhy0404@gmail.com>
References: <20260805191257.11303-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Page 42 of the AN547 TRM defines the AHB PPC EXP1 ports with DMA 1-3

AN547 TRM: https://developer.arm.com/documentation/dai0547/latest/

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
 hw/arm/mps2-tz.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 81e64a91de..d6d178642b 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1113,6 +1113,14 @@ static void mps2tz_common_init(MachineState *machine)
                 { /* port 7 USER AHB interface 3 */ },
                 { "eth-usb", make_eth_usb, NULL, 0x41400000, 0x200000, { 49 } },
             },
+        }, {
+            .name = "ahb_ppcexp1",
+            .ports = {
+                { /* port 0 reserved */ },
+                { "dma1", make_dma, &mms->dma[1], 0x41201000, 0x1000, { 62, 60, 61 } },
+                { "dma2", make_dma, &mms->dma[2], 0x41202000, 0x1000, { 65, 63, 64 } },
+                { "dma3", make_dma, &mms->dma[3], 0x41203000, 0x1000, { 68, 66, 67 } },
+            },
         },
     };
 
-- 
2.53.0


