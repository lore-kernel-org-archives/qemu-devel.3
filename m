Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D23C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnQmq-00022n-HP; Fri, 24 Jul 2026 21:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTQ-00071P-N8
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:40 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTO-0000rU-VF
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:40 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5bfaa014978so320717e0c.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784940158; x=1785544958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5QfvYo5UsCuRurXk863Eme2dB9OKCaPHtZCuOSVqbkQ=;
 b=QYdWYdWMYPLxaHb+sLnvwVTeo92+QBQa5389acBYcd5T2KQWJp+9K4LfKrceqBg3mZ
 WJm0A4sY9tDvKbsHtd/TwwG5rbeJRw2D7c0FOEZdxb14DoXX7580NbM8sDCVm/lzFWdh
 IMGheC+hITos3ku1K6P5s/oBhmCMqsYDupaFNxY6BB0LRgWnrv7kVO0RRAUr/yhv7Gkl
 P8/sp99gb+Dg65WaY6kNPmOOMpIGHEmfg7VCkQRAcTZ4IYZTD7UNp1rrkxbzpd7CFukz
 P2061YKwO2rRIlhWakwQRAhEI043iOQear0IRng0XBRITyw2R1ERnCNDnj0ZgXMRJtrd
 nVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784940158; x=1785544958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5QfvYo5UsCuRurXk863Eme2dB9OKCaPHtZCuOSVqbkQ=;
 b=bHu3EOkPi5KSN+bJxRWrU0Pcv+veYoRZe/BygUaS12fMfen/fip+0noOpRxOJ7UY8f
 yz6Z1Iaz3OmI1WGXZz3i3ghOt7iGTOvIbwlx6DF3yHRtveZn6TQwQgya6QAwxDevMCZa
 j+7GGAQkAjpijwDOYZMzkkWlDORgoXGtFlsO1vjFfNWptNy9LOXqyW16htVaIjXZQlN6
 nWSXl/W2qgVNjAuPOV5lq2p5ySfv1a1bm3cWcsXanJjyxPqHGBtQxcK0GfMkpKDtDX69
 GwAhCTRl6GfOVjawDCpalPeaXfpSXGrLZhduyNyhA43s9Phz72VxXiRdSdad+KwS0zdr
 Z7Nw==
X-Gm-Message-State: AOJu0YysqA+7JyKjiWwwaRr2x7c4qVE/+6D7U6PVTNlA1AZocunrZOaV
 jqNJdCnpfqTS+fk9w89zQQnnqFVfIHaHiLiptTkMzLSI8vlAsXa4Dowt5U4eCA9d
X-Gm-Gg: AR+sD10DbPSupfZV/mtVMIvLRC7rwvTzbKWIn8bEAKujICL5Kox3Wb9W5XTnZ5zjIXV
 SHy6TrNkHfIZ9bEB3IIFKS4nb6F+2nelnEKQr2HNfUnm0abVeGfzil+xOR1e9VMi1rZATcEi1d6
 todZHePSuqNhTPtcdixHjGViXqqU4dHSaGybdVpwOPfbhpPc1/UcYK1i8OGgJVdPZf1WoD7NuPM
 5fe4AGurxa51NvMaxACu2XeVj6vT6deAr0PQFbjDJX8TKExA4tpS6DoWxKapYnRR+Fx1i/njYMg
 86fA+dsydtMLcz+vGv60MxCUAaS/GNxHj39e2cERTpx89wJovO00F5p8tagc0a6L12hWsuYh3ch
 DwhC0lG+ws/JLKOdEWHcYu9Bo5hzb0s+/qPhETHB0FRNMVrRCSb69qei6EUrL0HKp6eC92tWKze
 kjlrGegoTfR1sv7L/639SBvrbfHuOm9y3T
X-Received: by 2002:a05:6102:6441:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-750400a8bdamr601594137.20.1784940157831; 
 Fri, 24 Jul 2026 17:42:37 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774f12690sm930591241.12.2026.07.24.17.42.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 17:42:37 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 15/19] hw/net/bcm2838_genet: fix PHY autonegotiation-restart
 deadlock
Date: Fri, 24 Jul 2026 20:42:14 -0400
Message-ID: <20260725004219.66222-16-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725004219.66222-1-marcelomanzo@gmail.com>
References: <20260725004219.66222-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:02:41 -0400
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

The guest PHY driver requests an autonegotiation restart by setting
BMCR.ANRESTART, then polls BMCR waiting for the hardware to clear
that bit as an acknowledgment. bcm2838_genet_mdio_cmd() called
FIELD_DP16() to clear ANRESTART in phy_reg_data but discarded its
return value -- FIELD_DP16() does not modify its argument in place,
it returns a new value -- so the bit was never actually cleared in
the register the guest reads back. The guest driver then spun
forever waiting for an acknowledgment that would never come,
appearing to hang the whole boot.

Assign the FIELD_DP16() result back to phy_reg_data, and also call
bcm2838_genet_phy_update_link() once the restart is handled so link
status actually gets refreshed, matching the surrounding code's own
comment ("Initiate auto-negotiation once it has been restarted").

Found by booting a real guest against this series and tracing the
MDIO command register with targeted debug prints: the guest was
observed polling BMCR indefinitely, always reading back the
ANRESTART bit still set. Confirmed fixed across repeated boots: link
comes up and autonegotiation completes every time.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 59393d89..e34c1810 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -20,6 +20,8 @@
 #include "hw/net/bcm2838_genet.h"
 #include "trace.h"
 
+static void bcm2838_genet_phy_update_link(BCM2838GenetState *s);
+
 /* GENET layouts */
 REG32(GENET_SYS_REV_CTRL,              0)
 FIELD(GENET_SYS_REV_CTRL, GPHY_REV,    0, 16)
@@ -390,10 +392,15 @@ static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
                 if (phy_reg_id == BCM2838_GENET_PHY_BMCR) {
                     /* Initiate auto-negotiation once it has been restarted */
                     if (anrestart == 1) {
-                        FIELD_DP16(phy_reg_data, GENET_PHY_BMCR, ANRESTART, 0);
+                        phy_reg_data = FIELD_DP16(phy_reg_data,
+                                                  GENET_PHY_BMCR,
+                                                  ANRESTART, 0);
                     }
                 }
                 *phy_reg = phy_reg_data;
+                if (phy_reg_id == BCM2838_GENET_PHY_BMCR && anrestart == 1) {
+                    bcm2838_genet_phy_update_link(s);
+                }
             }
         }
     }
-- 
2.47.1


