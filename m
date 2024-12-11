Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5B9E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRi-000068-8H; Wed, 11 Dec 2024 11:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRg-0008Vz-Fn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:16 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRe-0007ad-DS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:16 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862b364538so534419f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934013; x=1734538813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0WGriA4LS3QsH5lw3Ak1RT7ziiVmWhZi2ZbsQKrrgFY=;
 b=xd2sH6bJ8TAa5nj4+/CdNKN7h2wptfxPrUWmngd9i9TN061XYPu333ajdTqcyvOcf7
 GgnKMxFk7EbdXVyjz84WG6GfMsEtcQZiKAdIy1p+6PzlnhpRE/sElifSHdMBE9gqPPBE
 1lviUcgq4aGkpZUF87T1hAKNp2SBzr78QEAHHPnDWsf0Nn++yLCkxxNPiX2CYVUP6BWX
 2JJkshoXkK1iMwsbAYuSZWoFps4hgkJ//9mP/hnoSxOa0NWKQVJHTAqwXQ+yuBNcWyEz
 ejNfLShMtI0gvDmU5S3AvP/UYF8guGPt3pfkQ069FO26G99VYzvA4NG8qJf6YTFWKAQK
 sRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934013; x=1734538813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WGriA4LS3QsH5lw3Ak1RT7ziiVmWhZi2ZbsQKrrgFY=;
 b=squyPkNjGHsVN5zT+VgS0GXWJvlJeGPpDhIzqnrtJuN8VKRQcILrSTR4zNuCIEDDNv
 HAytNzP22prSbcL7OH9sPtXUfOldbLmLjVwaWLZgK8g9xnb4VlR7YSiPV69aQtZzI9gy
 t6bMNYi1PSRBVsnr87bb61Drg86AHWr5a0WQKvVslnLe0uiRqLcQXaVtMwbo83CWTx83
 4whS43tlAlRtbOPG2l9/RgOcbglf4/0wlThyP08QjTUWNdHxT3S3P+do7AdzY1B6cPQJ
 aAo7Ydys7b7ZRjceVj2SkEpB2TlDb1YGmjy05X0vH2+N7JPSHau2Bh6U8h5HDP/4p0HX
 szeA==
X-Gm-Message-State: AOJu0YwERl96RlhAEV2sOotHLcWlZbbvov4O8BvIULnsjztM14SaDN1Q
 G0GboK/DtT3/JLCVjk4DhBz8fcVlfOvfk1SY7cw9maoSP5K4vsIh0LHrVGIB8bZNsUuZQBZek8N
 Q
X-Gm-Gg: ASbGncvvjiTlzJPuvYhtx+sh9VARjmwWcZVhb0wjbhXwlC+65gVGY+aAZI1DsWM4wEB
 zYw1xeXhWKzRsNF4m7Pk1Wdz2FCGrozCn4Q1QNW0aDqLyaUnjFo+bYLvKt+xmxBbuL1qQGs5D8x
 gOsshacStlgaN5YbDMZ4FO6qgHc0169Y/7Ia0KdKcBi5Goof+kzuzkqItP2D4MXqmKtPTe9VLyn
 ge0UrtIxrlO05mJAWkR/uAIpt8Eva2GY8nxWUeqAsfoUVqtEYLe9c1LHnIS
X-Google-Smtp-Source: AGHT+IExs0Ecp2q/kTobX6qkcX2TSXmu1V2m36Myf0N+kL3eW4OxJ/lknQF8UdQqkwg2z3p7Na8+BA==
X-Received: by 2002:a05:6000:1f85:b0:386:3672:73e4 with SMTP id
 ffacd0b85a97d-3864df05fc5mr2365077f8f.26.1733934012634; 
 Wed, 11 Dec 2024 08:20:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/72] hw/net/lan9118_phy: Reuse MII constants
Date: Wed, 11 Dec 2024 16:18:56 +0000
Message-Id: <20241211162004.2795499-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Prefer named constants over magic values for better readability.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20241102125724.532843-5-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/mii.h |  6 +++++
 hw/net/lan9118_phy.c | 63 ++++++++++++++++++++++++++++----------------
 2 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/include/hw/net/mii.h b/include/hw/net/mii.h
index f7feddac9bd..55bf7c92a1c 100644
--- a/include/hw/net/mii.h
+++ b/include/hw/net/mii.h
@@ -71,6 +71,7 @@
 #define MII_BMSR_JABBER     (1 << 1)  /* Jabber detected */
 #define MII_BMSR_EXTCAP     (1 << 0)  /* Ext-reg capability */
 
+#define MII_ANAR_RFAULT     (1 << 13) /* Say we can detect faults */
 #define MII_ANAR_PAUSE_ASYM (1 << 11) /* Try for asymmetric pause */
 #define MII_ANAR_PAUSE      (1 << 10) /* Try for pause */
 #define MII_ANAR_TXFD       (1 << 8)
@@ -78,6 +79,7 @@
 #define MII_ANAR_10FD       (1 << 6)
 #define MII_ANAR_10         (1 << 5)
 #define MII_ANAR_CSMACD     (1 << 0)
+#define MII_ANAR_SELECT     (0x001f)  /* Selector bits */
 
 #define MII_ANLPAR_ACK      (1 << 14)
 #define MII_ANLPAR_PAUSEASY (1 << 11) /* can pause asymmetrically */
@@ -112,6 +114,10 @@
 #define RTL8201CP_PHYID1    0x0000
 #define RTL8201CP_PHYID2    0x8201
 
+/* SMSC LAN9118 */
+#define SMSCLAN9118_PHYID1  0x0007
+#define SMSCLAN9118_PHYID2  0xc0d1
+
 /* RealTek 8211E */
 #define RTL8211E_PHYID1     0x001c
 #define RTL8211E_PHYID2     0xc915
diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index d8fc9ddd3ac..874dae4155a 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/net/lan9118_phy.h"
+#include "hw/net/mii.h"
 #include "hw/irq.h"
 #include "hw/resettable.h"
 #include "migration/vmstate.h"
@@ -38,26 +39,28 @@ uint16_t lan9118_phy_read(Lan9118PhyState *s, int reg)
     uint16_t val;
 
     switch (reg) {
-    case 0: /* Basic Control */
+    case MII_BMCR:
         val = s->control;
         break;
-    case 1: /* Basic Status */
+    case MII_BMSR:
         val = s->status;
         break;
-    case 2: /* ID1 */
-        val = 0x0007;
+    case MII_PHYID1:
+        val = SMSCLAN9118_PHYID1;
         break;
-    case 3: /* ID2 */
-        val = 0xc0d1;
+    case MII_PHYID2:
+        val = SMSCLAN9118_PHYID2;
         break;
-    case 4: /* Auto-neg advertisement */
+    case MII_ANAR:
         val = s->advertise;
         break;
-    case 5: /* Auto-neg Link Partner Ability */
-        val = 0x0fe1;
+    case MII_ANLPAR:
+        val = MII_ANLPAR_PAUSEASY | MII_ANLPAR_PAUSE | MII_ANLPAR_T4 |
+              MII_ANLPAR_TXFD | MII_ANLPAR_TX | MII_ANLPAR_10FD |
+              MII_ANLPAR_10 | MII_ANLPAR_CSMACD;
         break;
-    case 6: /* Auto-neg Expansion */
-        val = 1;
+    case MII_ANER:
+        val = MII_ANER_NWAY;
         break;
     case 29: /* Interrupt source. */
         val = s->ints;
@@ -92,19 +95,24 @@ void lan9118_phy_write(Lan9118PhyState *s, int reg, uint16_t val)
     trace_lan9118_phy_write(val, reg);
 
     switch (reg) {
-    case 0: /* Basic Control */
-        if (val & 0x8000) {
+    case MII_BMCR:
+        if (val & MII_BMCR_RESET) {
             lan9118_phy_reset(s);
         } else {
-            s->control = val & 0x7980;
+            s->control = val & (MII_BMCR_LOOPBACK | MII_BMCR_SPEED100 |
+                                MII_BMCR_AUTOEN | MII_BMCR_PDOWN | MII_BMCR_FD |
+                                MII_BMCR_CTST);
             /* Complete autonegotiation immediately. */
-            if (val & 0x1000) {
-                s->status |= 0x0020;
+            if (val & MII_BMCR_AUTOEN) {
+                s->status |= MII_BMSR_AN_COMP;
             }
         }
         break;
-    case 4: /* Auto-neg advertisement */
-        s->advertise = (val & 0x2d7f) | 0x80;
+    case MII_ANAR:
+        s->advertise = (val & (MII_ANAR_RFAULT | MII_ANAR_PAUSE_ASYM |
+                               MII_ANAR_PAUSE | MII_ANAR_10FD | MII_ANAR_10 |
+                               MII_ANAR_SELECT))
+                     | MII_ANAR_TX;
         break;
     case 30: /* Interrupt mask */
         s->int_mask = val & 0xff;
@@ -131,11 +139,11 @@ void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
     /* Autonegotiation status mirrors link status. */
     if (link_down) {
         trace_lan9118_phy_update_link("down");
-        s->status &= ~0x0024;
+        s->status &= ~(MII_BMSR_AN_COMP | MII_BMSR_LINK_ST);
         s->ints |= PHY_INT_DOWN;
     } else {
         trace_lan9118_phy_update_link("up");
-        s->status |= 0x0024;
+        s->status |= MII_BMSR_AN_COMP | MII_BMSR_LINK_ST;
         s->ints |= PHY_INT_ENERGYON;
         s->ints |= PHY_INT_AUTONEG_COMPLETE;
     }
@@ -146,9 +154,18 @@ void lan9118_phy_reset(Lan9118PhyState *s)
 {
     trace_lan9118_phy_reset();
 
-    s->control = 0x3000;
-    s->status = 0x7809;
-    s->advertise = 0x01e1;
+    s->control = MII_BMCR_AUTOEN | MII_BMCR_SPEED100;
+    s->status = MII_BMSR_100TX_FD
+                | MII_BMSR_100TX_HD
+                | MII_BMSR_10T_FD
+                | MII_BMSR_10T_HD
+                | MII_BMSR_AUTONEG
+                | MII_BMSR_EXTCAP;
+    s->advertise = MII_ANAR_TXFD
+                   | MII_ANAR_TX
+                   | MII_ANAR_10FD
+                   | MII_ANAR_10
+                   | MII_ANAR_CSMACD;
     s->int_mask = 0;
     s->ints = 0;
     lan9118_phy_update_link(s, s->link_down);
-- 
2.34.1


