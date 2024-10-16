Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5B5D2F7C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 21:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1BVN-000293-Eg; Wed, 16 Oct 2024 17:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t1BVL-00028J-LI; Wed, 16 Oct 2024 17:24:27 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t1BVJ-00013U-WB; Wed, 16 Oct 2024 17:24:27 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso30576566b.3; 
 Wed, 16 Oct 2024 14:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729113864; x=1729718664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3D1Ytcxm8HdYzUOAcr5hC/ohLTIwUIkdZ77sZiIviA=;
 b=DE48Xfwa+3rDm2Rcqy8ZJ9R036mZBf+V+ObGXG2XIzkMBeGIFXV4797nPOzofUAQwz
 gTIjzsMK4PF+1nqCum8D/hSmUMa3xLDKK1Ph1zCYFb9IFttb+Nt/KuqtkzpU3+1T5/An
 eGFbcBsWJOhVWaWj4fKlo0nCLMLZNbho0vre+E8wiPx5ygh91juNasxHvYi7Kan/WhcE
 4PJFP5oUhO4UXsDgmQAvDtsTOkKHIvtnd2kV2gb7zyUc/ROyK7oJQGo+CBIh0uParW86
 iOE3dHtgwZpf8H/J/5S8HUOn+PSYJkVenm4bIaGtlMUpmEzzwSdVy+gPqBdEvbOmunA3
 bImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729113864; x=1729718664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s3D1Ytcxm8HdYzUOAcr5hC/ohLTIwUIkdZ77sZiIviA=;
 b=PkePhFFsbQ87RsqkSxWsxSEGNzYfKS8URp03wgCp08lK0N3h5eyUk7cRc9LuSPdpCC
 uD0CoVQ0b736mJnyDHUmSsinakGlg3G/G72STawlYJ03MErcBkO/o5fYeYU0UMDUZzHd
 L+ZO865tQWR12M9yY9OLL4mVFB58DJNq3YG3R1K436fmy3liHR695O5lSsJgrFzubWk3
 DYm9aT3v+AjvIlfMyAJ4spMIJY/2FcM+3kGPhC7KCgk9Aa/6y8tVbpZZ18vN9RoNW9Pe
 u7bOeVI43LqYDjDnMFXRc5WosH2Oy2irqIqkxGsNWzXCxVM2HKt5He3dMehdTkitzfNR
 8Qnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAmCGOGtiXlYgVv1EoCkwTY6zpt1Nd2+fUW5S8eTbWgnaLUR+OQlDldrcRnDaN6CgQJsvlBwzMNA==@nongnu.org
X-Gm-Message-State: AOJu0YyIS28VK8nB56LPW8zzN9vMD1SYJf+n6bAQ/8yxV8Jy8QL1cfDg
 ktdHyLX8s0aUgGtWiNe/B7/YBmnYSfdyXmIoeFB1JrB/+VjkqfmFtei3Fw==
X-Google-Smtp-Source: AGHT+IGKd6OCOFOXu70RnPZ5BIRXoEUXsWNL/Z0Cu4hqm77oN25SshSthKtc+bRYb921VB0JzPTuBg==
X-Received: by 2002:a17:907:e25f:b0:a99:529d:81ae with SMTP id
 a640c23a62f3a-a9a34e4c8e8mr398739366b.55.1729113863610; 
 Wed, 16 Oct 2024 14:24:23 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-025-143.77.191.pool.telefonica.de.
 [77.191.25.143]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a29750a9asm218005766b.88.2024.10.16.14.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 14:24:22 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 4/5] hw/net/lan9118_phy: Reuse MII constants
Date: Wed, 16 Oct 2024 23:24:06 +0200
Message-ID: <20241016212407.139390-5-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016212407.139390-1-shentey@gmail.com>
References: <20241016212407.139390-1-shentey@gmail.com>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 06e19c22c9..dafea5a875 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/net/lan9118_phy.h"
+#include "hw/net/mii.h"
 #include "hw/irq.h"
 #include "hw/resettable.h"
 #include "migration/vmstate.h"
@@ -40,11 +41,11 @@ void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
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
@@ -57,9 +58,18 @@ static void lan9118_phy_reset(Object *obj, ResetType type)
 
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
@@ -70,26 +80,26 @@ uint32_t lan9118_phy_read(Lan9118PhyState *s, int reg)
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
@@ -124,19 +134,24 @@ void lan9118_phy_write(Lan9118PhyState *s, int reg, uint32_t val)
     trace_lan9118_phy_write(val, reg);
 
     switch (reg) {
-    case 0: /* Basic Control */
-        if (val & 0x8000) {
+    case MII_BMCR:
+        if (val & MII_BMCR_RESET) {
             lan9118_phy_reset(OBJECT(s), RESET_TYPE_SOFT);
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
2.47.0


