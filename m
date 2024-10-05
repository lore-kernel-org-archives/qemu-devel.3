Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37E0CFB440
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxBqq-0002jR-8S; Sat, 05 Oct 2024 16:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxBqm-0002hO-6z; Sat, 05 Oct 2024 16:58:04 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxBqk-0006mY-06; Sat, 05 Oct 2024 16:58:03 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a994cd82a3bso3603966b.2; 
 Sat, 05 Oct 2024 13:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728161879; x=1728766679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyfkmVf9PFMF7Wgly8deK8FjC7MxQdlVNkrSFT8U13Q=;
 b=iD1H/d2Vdgwa07eRH19vWwRe+/0fv6LLrL6lZ9DUwoiVT3xGoknE900J6YQXsp9TZV
 lJzL59Y0SuqKi0HfczBleOh5flzVCUUqPyNKe42JkbUqLJn56iN27pRs2OvA+G0H12F2
 z5+5S1CuG7KMZPhR2BoKOJ7Yf/5ZGUavKQFHSo/QVZ5pRGE8RUrRa81oU5V+TSHTeLWU
 1aWv9DqhwJAfn2dCXxQPMcAm1I7ywDVimClm+PhDzOTM88PTqtdKmxUz/I6wpnDY0H72
 tgbUtqJMKa/TpiAnVWB7soXa67bSfSEFJxMzx6A9EDsEGQC0jlLfy5uRPO6CHssyRGLe
 cpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728161879; x=1728766679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uyfkmVf9PFMF7Wgly8deK8FjC7MxQdlVNkrSFT8U13Q=;
 b=Wx1RmHKjR+6MbOr1CAFwPD0+210A8tzvPZHDU5Ce8VKJJJyK03bDbgzj4WEp7S8nhA
 khq3YsxkF8ONHtxwP730V6d4kGDLgW/CPaNSXro6kEvSQ1rBGbBU9Es0VOu1uDyy5qqX
 zibkem3KrcyDpdx6pzB/1Ss5s9Io0ckhRvkxJ8iO9sMclIh72+lbOSJIIHJi3CzmhpJi
 sQeC+dK+lRoORBwIvhKyMNM05aH68jo4gsiX9IrHvRiwwS2p5wHw+XU4T13XfbCYjodL
 NIXfrFg9nOiLnbp/COnrAvYh4G5t7WZfFnC+4TkDd7HsjstAYQLbcHfkXQRjMsPWw/Rj
 rmMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Q3j+4b/K3/goEyqCzzf39jy+FNY+JtcBgxcDVHX8pBl2q9m3VjlpzNUHNZyJJQ3GviYkU3Mb3w==@nongnu.org
X-Gm-Message-State: AOJu0YznvBV308D1FMptqrnBH5Jzv1zpgiJcLKwnrrRauoRpciX0H42u
 mT42En/6C8wRKZUHi4RehQvrffKm07XkJG8fGvY34hsICcZgmceURJ7U7w==
X-Google-Smtp-Source: AGHT+IFm/P0GyhA6dWEQ0Nw9b9d1tdWyDillNVbLHYPWVlRkTIOhyHnxplFBdwtToso109tUMoEgqg==
X-Received: by 2002:a17:906:4785:b0:a8a:7501:de39 with SMTP id
 a640c23a62f3a-a991bce5b96mr729064166b.9.1728161878927; 
 Sat, 05 Oct 2024 13:57:58 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a993f40d542sm105804966b.157.2024.10.05.13.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:57:58 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/4] hw/net/lan9118_phy: Reuse in imx_fec and consolidate
 implementations
Date: Sat,  5 Oct 2024 22:57:46 +0200
Message-ID: <20241005205748.29203-3-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005205748.29203-1-shentey@gmail.com>
References: <20241005205748.29203-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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

imx_fec models the same PHY as lan9118_phy. The code is almost the same with
imx_fec having more logging and tracing. Merge these improvements into
lan9118_phy and reuse in imx_fec to fix the code duplication.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/net/imx_fec.h |   7 +-
 hw/net/imx_fec.c         | 141 ++++-----------------------------------
 hw/net/lan9118_phy.c     |  80 ++++++++++++++++------
 hw/net/Kconfig           |   1 +
 hw/net/trace-events      |  10 +--
 5 files changed, 81 insertions(+), 158 deletions(-)

diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 2d13290c78..5f1d30f56b 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -31,6 +31,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXFECState, IMX_FEC)
 #define TYPE_IMX_ENET "imx.enet"
 
 #include "hw/sysbus.h"
+#include "hw/net/lan9118_phy.h"
 #include "net/net.h"
 
 #define ENET_EIR               1
@@ -264,11 +265,7 @@ struct IMXFECState {
     uint32_t tx_descriptor[ENET_TX_RING_NUM];
     uint32_t tx_ring_num;
 
-    uint32_t phy_status;
-    uint32_t phy_control;
-    uint32_t phy_advertise;
-    uint32_t phy_int;
-    uint32_t phy_int_mask;
+    Lan9118PhyState mii;
     uint32_t phy_num;
     bool phy_connected;
     struct IMXFECState *phy_consumer;
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 6294d29202..e981116640 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -209,11 +209,11 @@ static const VMStateDescription vmstate_imx_eth = {
         VMSTATE_UINT32_ARRAY(regs, IMXFECState, ENET_MAX),
         VMSTATE_UINT32(rx_descriptor, IMXFECState),
         VMSTATE_UINT32(tx_descriptor[0], IMXFECState),
-        VMSTATE_UINT32(phy_status, IMXFECState),
-        VMSTATE_UINT32(phy_control, IMXFECState),
-        VMSTATE_UINT32(phy_advertise, IMXFECState),
-        VMSTATE_UINT32(phy_int, IMXFECState),
-        VMSTATE_UINT32(phy_int_mask, IMXFECState),
+        VMSTATE_UINT32(mii.status, IMXFECState),
+        VMSTATE_UINT32(mii.control, IMXFECState),
+        VMSTATE_UINT32(mii.advertise, IMXFECState),
+        VMSTATE_UINT32(mii.ints, IMXFECState),
+        VMSTATE_UINT32(mii.int_mask, IMXFECState),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -222,14 +222,6 @@ static const VMStateDescription vmstate_imx_eth = {
     },
 };
 
-#define PHY_INT_ENERGYON            (1 << 7)
-#define PHY_INT_AUTONEG_COMPLETE    (1 << 6)
-#define PHY_INT_FAULT               (1 << 5)
-#define PHY_INT_DOWN                (1 << 4)
-#define PHY_INT_AUTONEG_LP          (1 << 3)
-#define PHY_INT_PARFAULT            (1 << 2)
-#define PHY_INT_AUTONEG_PAGE        (1 << 1)
-
 static void imx_eth_update(IMXFECState *s);
 
 /*
@@ -238,47 +230,19 @@ static void imx_eth_update(IMXFECState *s);
  * For now we don't handle any GPIO/interrupt line, so the OS will
  * have to poll for the PHY status.
  */
-static void imx_phy_update_irq(IMXFECState *s)
-{
-    imx_eth_update(s);
-}
-
-static void imx_phy_update_link(IMXFECState *s)
+static void imx_phy_update_irq(void *opaque, int n, int level)
 {
-    /* Autonegotiation status mirrors link status.  */
-    if (qemu_get_queue(s->nic)->link_down) {
-        trace_imx_phy_update_link("down");
-        s->phy_status &= ~0x0024;
-        s->phy_int |= PHY_INT_DOWN;
-    } else {
-        trace_imx_phy_update_link("up");
-        s->phy_status |= 0x0024;
-        s->phy_int |= PHY_INT_ENERGYON;
-        s->phy_int |= PHY_INT_AUTONEG_COMPLETE;
-    }
-    imx_phy_update_irq(s);
+    imx_eth_update(opaque);
 }
 
 static void imx_eth_set_link(NetClientState *nc)
 {
-    imx_phy_update_link(IMX_FEC(qemu_get_nic_opaque(nc)));
-}
-
-static void imx_phy_reset(IMXFECState *s)
-{
-    trace_imx_phy_reset();
-
-    s->phy_status = 0x7809;
-    s->phy_control = 0x3000;
-    s->phy_advertise = 0x01e1;
-    s->phy_int_mask = 0;
-    s->phy_int = 0;
-    imx_phy_update_link(s);
+    lan9118_phy_update_link(&IMX_FEC(qemu_get_nic_opaque(nc))->mii,
+                            nc->link_down);
 }
 
 static uint32_t imx_phy_read(IMXFECState *s, int reg)
 {
-    uint32_t val;
     uint32_t phy = reg / 32;
 
     if (!s->phy_connected) {
@@ -296,54 +260,7 @@ static uint32_t imx_phy_read(IMXFECState *s, int reg)
 
     reg %= 32;
 
-    switch (reg) {
-    case 0:     /* Basic Control */
-        val = s->phy_control;
-        break;
-    case 1:     /* Basic Status */
-        val = s->phy_status;
-        break;
-    case 2:     /* ID1 */
-        val = 0x0007;
-        break;
-    case 3:     /* ID2 */
-        val = 0xc0d1;
-        break;
-    case 4:     /* Auto-neg advertisement */
-        val = s->phy_advertise;
-        break;
-    case 5:     /* Auto-neg Link Partner Ability */
-        val = 0x0f71;
-        break;
-    case 6:     /* Auto-neg Expansion */
-        val = 1;
-        break;
-    case 29:    /* Interrupt source.  */
-        val = s->phy_int;
-        s->phy_int = 0;
-        imx_phy_update_irq(s);
-        break;
-    case 30:    /* Interrupt mask */
-        val = s->phy_int_mask;
-        break;
-    case 17:
-    case 18:
-    case 27:
-    case 31:
-        qemu_log_mask(LOG_UNIMP, "[%s.phy]%s: reg %d not implemented\n",
-                      TYPE_IMX_FEC, __func__, reg);
-        val = 0;
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR, "[%s.phy]%s: Bad address at offset %d\n",
-                      TYPE_IMX_FEC, __func__, reg);
-        val = 0;
-        break;
-    }
-
-    trace_imx_phy_read(val, phy, reg);
-
-    return val;
+    return lan9118_phy_read(&s->mii, reg);
 }
 
 static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
@@ -365,39 +282,7 @@ static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
 
     reg %= 32;
 
-    trace_imx_phy_write(val, phy, reg);
-
-    switch (reg) {
-    case 0:     /* Basic Control */
-        if (val & 0x8000) {
-            imx_phy_reset(s);
-        } else {
-            s->phy_control = val & 0x7980;
-            /* Complete autonegotiation immediately.  */
-            if (val & 0x1000) {
-                s->phy_status |= 0x0020;
-            }
-        }
-        break;
-    case 4:     /* Auto-neg advertisement */
-        s->phy_advertise = (val & 0x2d7f) | 0x80;
-        break;
-    case 30:    /* Interrupt mask */
-        s->phy_int_mask = val & 0xff;
-        imx_phy_update_irq(s);
-        break;
-    case 17:
-    case 18:
-    case 27:
-    case 31:
-        qemu_log_mask(LOG_UNIMP, "[%s.phy)%s: reg %d not implemented\n",
-                      TYPE_IMX_FEC, __func__, reg);
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR, "[%s.phy]%s: Bad address at offset %d\n",
-                      TYPE_IMX_FEC, __func__, reg);
-        break;
-    }
+    lan9118_phy_write(&s->mii, reg, val);
 }
 
 static void imx_fec_read_bd(IMXFECBufDesc *bd, dma_addr_t addr)
@@ -684,7 +569,7 @@ static void imx_eth_reset(DeviceState *d)
     memset(s->tx_descriptor, 0, sizeof(s->tx_descriptor));
 
     /* We also reset the PHY */
-    imx_phy_reset(s);
+    lan9118_phy_reset(&s->mii);
 }
 
 static uint32_t imx_default_read(IMXFECState *s, uint32_t index)
@@ -1336,6 +1221,8 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
                           dev->id, &dev->mem_reentrancy_guard, s);
 
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+
+    qemu_init_irq(&s->mii.irq, imx_phy_update_irq, s, 0);
 }
 
 static Property imx_eth_properties[] = {
diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index ced9afce28..1ab4bbc900 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2009 CodeSourcery, LLC.
  * Written by Paul Brook
  *
+ * Copyright (c) 2013 Jean-Christophe Dubois. <jcd@tribudubois.net>
+ *
  * This code is licensed under the GNU GPL v2
  *
  * Contributions after 2012-01-13 are licensed under the terms of the
@@ -14,6 +16,7 @@
 #include "hw/net/lan9118_phy.h"
 #include "hw/irq.h"
 #include "qemu/log.h"
+#include "trace.h"
 
 #define PHY_INT_ENERGYON            (1 << 7)
 #define PHY_INT_AUTONEG_COMPLETE    (1 << 6)
@@ -34,9 +37,11 @@ void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
 
     /* Autonegotiation status mirrors link status. */
     if (link_down) {
+        trace_lan9118_phy_update_link("down");
         s->status &= ~0x0024;
         s->ints |= PHY_INT_DOWN;
     } else {
+        trace_lan9118_phy_update_link("up");
         s->status |= 0x0024;
         s->ints |= PHY_INT_ENERGYON;
         s->ints |= PHY_INT_AUTONEG_COMPLETE;
@@ -46,6 +51,8 @@ void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
 
 void lan9118_phy_reset(Lan9118PhyState *s)
 {
+    trace_lan9118_phy_reset();
+
     s->status = 0x7809;
     s->control = 0x3000;
     s->advertise = 0x01e1;
@@ -60,58 +67,87 @@ uint32_t lan9118_phy_read(Lan9118PhyState *s, int reg)
 
     switch (reg) {
     case 0: /* Basic Control */
-        return s->control;
+        val = s->control;
+        break;
     case 1: /* Basic Status */
-        return s->status;
+        val = s->status;
+        break;
     case 2: /* ID1 */
-        return 0x0007;
+        val = 0x0007;
+        break;
     case 3: /* ID2 */
-        return 0xc0d1;
+        val = 0xc0d1;
+        break;
     case 4: /* Auto-neg advertisement */
-        return s->advertise;
+        val = s->advertise;
+        break;
     case 5: /* Auto-neg Link Partner Ability */
-        return 0x0f71;
+        val = 0x0f71;
+        break;
     case 6: /* Auto-neg Expansion */
-        return 1;
-        /* TODO 17, 18, 27, 29, 30, 31 */
+        val = 1;
+        break;
     case 29: /* Interrupt source. */
         val = s->ints;
         s->ints = 0;
         lan9118_phy_update_irq(s);
-        return val;
+        break;
     case 30: /* Interrupt mask */
-        return s->int_mask;
+        val = s->int_mask;
+        break;
+    case 17:
+    case 18:
+    case 27:
+    case 31:
+        qemu_log_mask(LOG_UNIMP, "%s: reg %d not implemented\n",
+                      __func__, reg);
+        val = 0;
+        break;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "lan9118_phy_read: PHY read reg %d\n", reg);
-        return 0;
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset %d\n",
+                      __func__, reg);
+        val = 0;
+        break;
     }
+
+    trace_lan9118_phy_read(val, reg);
+
+    return val;
 }
 
 void lan9118_phy_write(Lan9118PhyState *s, int reg, uint32_t val)
 {
+    trace_lan9118_phy_write(val, reg);
+
     switch (reg) {
     case 0: /* Basic Control */
         if (val & 0x8000) {
             lan9118_phy_reset(s);
-            break;
-        }
-        s->control = val & 0x7980;
-        /* Complete autonegotiation immediately. */
-        if (val & 0x1000) {
-            s->status |= 0x0020;
+        } else {
+            s->control = val & 0x7980;
+            /* Complete autonegotiation immediately. */
+            if (val & 0x1000) {
+                s->status |= 0x0020;
+            }
         }
         break;
     case 4: /* Auto-neg advertisement */
         s->advertise = (val & 0x2d7f) | 0x80;
         break;
-        /* TODO 17, 18, 27, 31 */
     case 30: /* Interrupt mask */
         s->int_mask = val & 0xff;
         lan9118_phy_update_irq(s);
         break;
+    case 17:
+    case 18:
+    case 27:
+    case 31:
+        qemu_log_mask(LOG_UNIMP, "%s: reg %d not implemented\n",
+                      __func__, reg);
+        break;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "lan9118_phy_write: PHY write reg %d = 0x%04x\n", reg, val);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset %d\n",
+                      __func__, reg);
+        break;
     }
 }
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 6b2ff2f937..7f80218d10 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -93,6 +93,7 @@ config ALLWINNER_SUN8I_EMAC
 
 config IMX_FEC
     bool
+    select LAN9118_PHY
 
 config CADENCE
     bool
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 4c6687923e..b8e0076833 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -10,6 +10,12 @@ allwinner_sun8i_emac_set_link(bool active) "Set link: active=%u"
 allwinner_sun8i_emac_read(uint64_t offset, uint64_t val) "MMIO read: offset=0x%" PRIx64 " value=0x%" PRIx64
 allwinner_sun8i_emac_write(uint64_t offset, uint64_t val) "MMIO write: offset=0x%" PRIx64 " value=0x%" PRIx64
 
+# lan9118_phy.c
+lan9118_phy_read(uint32_t val, int reg) "[0x%02x] -> 0x%04" PRIx32
+lan9118_phy_write(uint32_t val, int reg) "[0x%02x] <- 0x%04" PRIx32
+lan9118_phy_update_link(const char *s) "%s"
+lan9118_phy_reset(void) ""
+
 # lance.c
 lance_mem_readw(uint64_t addr, uint32_t ret) "addr=0x%"PRIx64"val=0x%04x"
 lance_mem_writew(uint64_t addr, uint32_t val) "addr=0x%"PRIx64"val=0x%04x"
@@ -426,12 +432,8 @@ i82596_set_multicast(uint16_t count) "Added %d multicast entries"
 i82596_channel_attention(void *s) "%p: Received CHANNEL ATTENTION"
 
 # imx_fec.c
-imx_phy_read(uint32_t val, int phy, int reg) "0x%04"PRIx32" <= phy[%d].reg[%d]"
 imx_phy_read_num(int phy, int configured) "read request from unconfigured phy %d (configured %d)"
-imx_phy_write(uint32_t val, int phy, int reg) "0x%04"PRIx32" => phy[%d].reg[%d]"
 imx_phy_write_num(int phy, int configured) "write request to unconfigured phy %d (configured %d)"
-imx_phy_update_link(const char *s) "%s"
-imx_phy_reset(void) ""
 imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x"
 imx_enet_read_bd(uint64_t addr, int flags, int len, int data, int options, int status) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x option 0x%04x status 0x%04x"
 imx_eth_tx_bd_busy(void) "tx_bd ran out of descriptors to transmit"
-- 
2.46.2


