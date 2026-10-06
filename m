Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23285CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAq-0005Tv-M4; Wed, 07 Oct 2026 04:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIUY-0004Vw-BX
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:39:05 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIUT-0000bk-97
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:38:52 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c2e5e090746so121200766b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791344318; x=1791949118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pWczp/OkfHNMKp8cpsFTwKDih/BeJgnENvn2ywZv19Y=;
 b=CW9rtK3SD2Kyk26kwcpbQYwATUKZnPh9n8R0LVsQF8ePO/WF9AclCFDPc1sh5JUXFB
 fscb952gCD+zXG2pzQ/vQX3hqBohYTbDf7s3QUyCzQ4qSy3bDxpfIt7z11QizG+lQ3wh
 4zz5Ere1ljdVcgsP2l5njNU1jCGv8Yiy6yfrSU+3tOMeq4/JoI4cq/1nWlhgsFHk25qc
 jFhtnETtnMcQi6BMkvVTQkL4g47zP8dvyXWhy7N9MxCqsElXjXb37NRpC0w87DPuSZx9
 cCtfd3u6jFnCZ0Ooqp6C7doOXnloIcP0kMKc87EZEQdRrn0bU2fbWV8mlOtgH7yejSh+
 U9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791344318; x=1791949118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pWczp/OkfHNMKp8cpsFTwKDih/BeJgnENvn2ywZv19Y=;
 b=OHskn4dwEHevi0mHIpeDxDWT2oSfsxtX65HisyCxAhc7F3q3XVf6VI6+GWLtzioaHI
 HV2lz3DTw6Jo7VqLGj5lNWzYim9+YUAukCYWyA3bjKTXdj733mQCJ3NzSDTu0Ja+vqCt
 pM12XR8A3zUx0Nt9NVpUFoW+VzO2aFlBA9+uNHQpe8R4aZVQrIDbtsiN8r/8WyMTVYoR
 UaIU8iVI3Yw6BwpzUXWW4q1DGZfid9uyluC/6yfdP0RIF7pLMEF9EGZ0n/WsqbNe3n2Y
 iSmthP0xZEXLSwJq4JUzQuryP/0nkMwVoF52KLwG8DE7yK+VHPuDXMPRNTSB/C3bQWRc
 IAgg==
X-Gm-Message-State: AFq9FYIVmu9XgcyBhQmFqnd9y12Po6bSGzNJP3Vvb7bM2aq/lP92r3c7
 oW4rzT3+QF/kmNostzvF4hUaup5O6wP2WHquqip0B3EV0MUkZ2t8DOtGNV9xQQ==
X-Gm-Gg: AYBFou1MJ4N88Ev4ju5o5zbBsUYDACydyBYFVq28rMA7eN4xPxQRN/wwvPCSAcISGJV
 uMo/Mc8BtN4h7S+1O9appRVVmSdzM8SFsKZwPppg6cZraBst9VElBHXMCH0NdGdBOlfzQ5HKHF8
 HivMXEXt69FbWcaYsCdw3XBkyRWiXdGlmXbLF/FEkyuPSov8gJw6KYNvXiK5ZaZa3mYrQsLURUe
 SJ5GYNict6nf/Fft4GYMWv0x91g2EkWpzOJ42W/wb9jESgVHlgazF9NBCMLereDS/CcxBKGRjSh
 KZxp4FvAOksKmQySQ9vgyF8a2aF6a1IKTA/a6T+64v25yHIqYKnz38QJ6OMAbytdtdqjbbMIu49
 1ALqkXca3gml6nuMSb0sJAw7C2Pr9zMN9An34GSgfzEjJTWKL/tYloIPwTiPEtR9asR3e5ZVSkT
 flC018GZaN060sND2vFWz6nWjMAoN1iknXPQSnBZuLhGVS37f5kDLuw7WT0keQxCNBSux4fUN44
 PsLKOg7LXWh2+7M3PSj6e6NroyRg4Rw+XLOATsWGOOUMmzE
X-Received: by 2002:a05:600c:6986:b0:4a1:6811:8d with SMTP id
 5b1f17b1804b1-4a17b526bd6mr10659365e9.11.1791275722516; 
 Tue, 06 Oct 2026 01:35:22 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:22 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 02/31] hw/watchdog/wdt_imx2: Fix handling of write one once
 WCR bits
Date: Tue,  6 Oct 2026 10:34:14 +0200
Message-ID: <20261006083445.30362-3-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In locked state, the WDE and WDT bits of the WCR register are one and
need to be preserved when written. At the moment, the logic is reversed
such that all but the locked bits are preserved in locked state. Fix
that.

Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
cc: qemu-stable
Reported-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/watchdog/wdt_imx2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 3283990bbf..d897ff6e52 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -161,13 +161,13 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
         s->wcr_locked = true;
         if (s->wcr_wde_locked) {
             value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wcr & ~IMX2_WDT_WCR_WDE);
+            value |= (s->wcr & IMX2_WDT_WCR_WDE);
         } else if (value & IMX2_WDT_WCR_WDE) {
             s->wcr_wde_locked = true;
         }
         if (s->wcr_wdt_locked) {
             value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wcr & ~IMX2_WDT_WCR_WDT);
+            value |= (s->wcr & IMX2_WDT_WCR_WDT);
         } else if (value & IMX2_WDT_WCR_WDT) {
             s->wcr_wdt_locked = true;
         }
-- 
2.56.0


