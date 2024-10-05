Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BB4CFB43F
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxBqq-0002jT-AN; Sat, 05 Oct 2024 16:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxBqm-0002hQ-Ed; Sat, 05 Oct 2024 16:58:04 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxBqk-0006mf-1q; Sat, 05 Oct 2024 16:58:04 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a99422929b2so66958066b.0; 
 Sat, 05 Oct 2024 13:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728161880; x=1728766680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJn4B+jQc95ao6ZyIj/u4htIgx2sxZoS2pamWWEl5zk=;
 b=JORishKw9WXYRbByHwrvfHRGKoglnrR95kd0CEolMRVWCdAwKNTSp3UaVj+pNlgwt8
 E8ZeAT8sgH2FMudGiIpugw8n/mFgXfptdfL/N01QxRhxPvi+7vfnjtnZ+cEfLld3Q5tB
 5bjIcepGqbw/S4TyiD2PPoUJfn6xZ1iRInM0MG0KaXL5uELiwwwJriohocg/Yau9rrVk
 QonoBcGf6tQZv98YhIAk2RJlx1ozfOQwQcQ1nt07cXkeBMtGQdCpZwp0df10RZeYO82J
 IuRI0kuphrhNVDrbbfdCuNn33sel/CUuzHIJeQALnHQ0apEYPXk8/tugH8nJ51pLG7pM
 YfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728161880; x=1728766680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJn4B+jQc95ao6ZyIj/u4htIgx2sxZoS2pamWWEl5zk=;
 b=nz1PMaePeYnfzvpa8HyHdfivZFC+ImHhp083Q6LcGl5tN6qgfm0yEmT+NcVKG5Grec
 0RL5CfBs8s9MLMzBjcZxS7LP2cPL5gxBx25vwgnWp8Ml0gnSHt1Y/o5KhtYmp+JOoxtt
 1Ov78ZZ4t98Xat6gb9HMPKB4iIkcnuIkMtbLfipx3NcMfRq6f83DiZplFnbJo1SWMk2O
 sp0Vjl+CLo7Wc6Zfv3AQCdAzjeV0RxTntWbb2HWFL/9M3KJZUXIqw3eGpfFwMosyRQl0
 WkbstO5DlH+0XuW4V/6KHFhnDFg+5uGHDP6J6JAOx8q+PBn1q4GFZ7+/y2l2dmzTqPag
 xrVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaHa6mbWvgWDPlyDqP70ZV1b+PFQLxc/GcJZrad755PDRhyw0UKEC5Q7Ef9IUb4xGcH3jRg/w8Ig==@nongnu.org
X-Gm-Message-State: AOJu0Yz5PI35PORBs/8jOXZKXYc1cd5C6gZ7uFDR+E75ERfwPqM/313u
 em0XTVViHoU9uB0ZrvsLP1opfGPWfy/EvAzmKN+fxDWMrw+suRiLmklLrw==
X-Google-Smtp-Source: AGHT+IGx8CFXZHk902OI0NPeVXeXRZCIhAWvrYM5r0CGCFSvSjeXhYl0f8k3Gp2MPg2DQhiOQYquJw==
X-Received: by 2002:a17:906:ee87:b0:a8d:250a:52a8 with SMTP id
 a640c23a62f3a-a991bce6124mr861012766b.3.1728161879788; 
 Sat, 05 Oct 2024 13:57:59 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a993f40d542sm105804966b.157.2024.10.05.13.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:57:59 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 3/4] hw/net/lan9118_phy: Reuse MII constants
Date: Sat,  5 Oct 2024 22:57:47 +0200
Message-ID: <20241005205748.29203-4-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005205748.29203-1-shentey@gmail.com>
References: <20241005205748.29203-1-shentey@gmail.com>
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

Prefer named constants over magic values for better readability.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/net/mii.h |  6 +++++
 hw/net/lan9118_phy.c | 59 +++++++++++++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/include/hw/net/mii.h b/include/hw/net/mii.h
index f7feddac9b..55bf7c92a1 100644
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
index 1ab4bbc900..1c2f30c81a 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/net/lan9118_phy.h"
+#include "hw/net/mii.h"
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -38,11 +39,11 @@ void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
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
@@ -53,9 +54,18 @@ void lan9118_phy_reset(Lan9118PhyState *s)
 {
     trace_lan9118_phy_reset();
 
-    s->status = 0x7809;
-    s->control = 0x3000;
-    s->advertise = 0x01e1;
+    s->status = MII_BMSR_100TX_FD
+                | MII_BMSR_100TX_HD
+                | MII_BMSR_10T_FD
+                | MII_BMSR_10T_HD
+                | MII_BMSR_AUTONEG
+                | MII_BMSR_EXTCAP;
+    s->control = MII_BMCR_AUTOEN | MII_BMCR_SPEED100;
+    s->advertise = MII_ANAR_TXFD
+                   | MII_ANAR_TX
+                   | MII_ANAR_10FD
+                   | MII_ANAR_10
+                   | MII_ANAR_CSMACD;
     s->int_mask = 0;
     s->ints = 0;
     lan9118_phy_update_link(s, s->link_down);
@@ -66,26 +76,26 @@ uint32_t lan9118_phy_read(Lan9118PhyState *s, int reg)
     uint32_t val;
 
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
+    case MII_ANLPAR:
         val = 0x0f71;
         break;
-    case 6: /* Auto-neg Expansion */
-        val = 1;
+    case MII_ANER:
+        val = MII_ANER_NWAY;
         break;
     case 29: /* Interrupt source. */
         val = s->ints;
@@ -120,19 +130,24 @@ void lan9118_phy_write(Lan9118PhyState *s, int reg, uint32_t val)
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
-- 
2.46.2


