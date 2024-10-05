Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9006DCFB43C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxBqn-0002hd-1K; Sat, 05 Oct 2024 16:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxBql-0002gy-2M; Sat, 05 Oct 2024 16:58:03 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxBqi-0006mU-RX; Sat, 05 Oct 2024 16:58:02 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c88370ad7bso3786518a12.3; 
 Sat, 05 Oct 2024 13:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728161879; x=1728766679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4jZyfDB5xAbslAmL6lASgpLFndjHqtrXokN3llEzgE=;
 b=KL7D3ON1SmLWqkTsMcJVyzC8Csz4DEV1Ys3lFHv60C5tU9kS3UWZ5RIsHdEcCr7BdE
 jytLGj0WO10Aze9soiwnbaSdg1yE7jrNXks50Pm7eJoLZqm41QOsw36fxoIsVOF24P1i
 YMLn6qaKHT9tcRWbIMiOzRxtrVrc+9iSmrJxWDbYgqHV9Km5xtK3lZLq4lX8F7xZsUeF
 pu809ZiE0zemgwtHY4w/7NSM4YyS9hdb9IOdf92yqN58FiBtQ6UsZ8CCkGQfe1JZpDWh
 /uHS87R7wI8giAa1R+cnorBliIoaGXnx2lPOU8CJkBQGF8X4BGgBTxhgwC1KGNj6163c
 IVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728161879; x=1728766679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4jZyfDB5xAbslAmL6lASgpLFndjHqtrXokN3llEzgE=;
 b=YrcgEpVezUfZsLjn0ARsqXJjBoEyIMGRWEz2r1NdozmksHU6aWhA99cr1b8sHbcC4Z
 BphF3A5IjYSGajtgF1+IYsVECwIARRtQt58q2+vKPI2+CSMoBL95y074IWHZYzvHgY7r
 9VQhCGfqSIDULt0P06gVUSTawGQtIMtl/57QrjAYQkOTyuzeU9I5K1fw/2sYHfB7fC6g
 X+L5RpD2wz+LKgIddNlczAvnNE7Lfuw8N9tyOTEKpZKXHe8mxK4saNmksK5l2W+Kjy9F
 AZ7SeExK29rDO21Xk0egsiOS7513Wo+l8qr94qZrjlgL6CW64i2hCYHA981M7QTYC4cZ
 7UFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIx1DDhvnx9V+o6ssy7a6g5wmk92qWbc/d5v/S77bXar9RGx9YjKW1Y4tcxsMmeFQFuAUIu+4g5w==@nongnu.org
X-Gm-Message-State: AOJu0YzHZAtm+FgXv1C8RlQ3JBjvEhpX/ftQ6X+VL0xgd7Xb1+6tz223
 g/zaJtAYHgU1wTjanwTImFo40Jrtfv1eGcjOerUNFRABAId3ZfKgE1HDVA==
X-Google-Smtp-Source: AGHT+IGtqr5cqvROCglxiqZqVY8CC7grtWyzmhUqLw1urJ8/Lzw+6a1lnZuoocfouYoUMsNBWnVMqg==
X-Received: by 2002:a17:906:dc92:b0:a90:344a:7db6 with SMTP id
 a640c23a62f3a-a991c01175bmr691897066b.62.1728161878152; 
 Sat, 05 Oct 2024 13:57:58 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a993f40d542sm105804966b.157.2024.10.05.13.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:57:57 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/4] hw/net/lan9118: Extract lan9118_phy
Date: Sat,  5 Oct 2024 22:57:45 +0200
Message-ID: <20241005205748.29203-2-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005205748.29203-1-shentey@gmail.com>
References: <20241005205748.29203-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
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

A very similar implementation of the same device exists in imx_fec. Prepare for
a common implementation by extracting the code into its own files.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/net/lan9118_phy.h |  31 ++++++++
 hw/net/lan9118.c             | 133 ++++++-----------------------------
 hw/net/lan9118_phy.c         | 117 ++++++++++++++++++++++++++++++
 hw/net/Kconfig               |   4 ++
 hw/net/meson.build           |   1 +
 5 files changed, 174 insertions(+), 112 deletions(-)
 create mode 100644 include/hw/net/lan9118_phy.h
 create mode 100644 hw/net/lan9118_phy.c

diff --git a/include/hw/net/lan9118_phy.h b/include/hw/net/lan9118_phy.h
new file mode 100644
index 0000000000..50e3559b12
--- /dev/null
+++ b/include/hw/net/lan9118_phy.h
@@ -0,0 +1,31 @@
+/*
+ * SMSC LAN9118 PHY emulation
+ *
+ * Copyright (c) 2009 CodeSourcery, LLC.
+ * Written by Paul Brook
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_NET_LAN9118_PHY_H
+#define HW_NET_LAN9118_PHY_H
+
+#include "hw/irq.h"
+
+typedef struct Lan9118PhyState {
+    uint32_t status;
+    uint32_t control;
+    uint32_t advertise;
+    uint32_t ints;
+    uint32_t int_mask;
+    IRQState irq;
+    bool link_down;
+} Lan9118PhyState;
+
+void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down);
+void lan9118_phy_reset(Lan9118PhyState *s);
+uint32_t lan9118_phy_read(Lan9118PhyState *s, int reg);
+void lan9118_phy_write(Lan9118PhyState *s, int reg, uint32_t val);
+
+#endif
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index db28a0ef30..07702e8b4d 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -16,6 +16,7 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "hw/irq.h"
+#include "hw/net/lan9118_phy.h"
 #include "hw/net/lan9118.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
@@ -139,14 +140,6 @@ do { printf("lan9118: " fmt , ## __VA_ARGS__); } while (0)
 #define MAC_CR_RXEN     0x00000004
 #define MAC_CR_RESERVED 0x7f404213
 
-#define PHY_INT_ENERGYON            0x80
-#define PHY_INT_AUTONEG_COMPLETE    0x40
-#define PHY_INT_FAULT               0x20
-#define PHY_INT_DOWN                0x10
-#define PHY_INT_AUTONEG_LP          0x08
-#define PHY_INT_PARFAULT            0x04
-#define PHY_INT_AUTONEG_PAGE        0x02
-
 #define GPT_TIMER_EN    0x20000000
 
 /*
@@ -228,11 +221,7 @@ struct lan9118_state {
     uint32_t mac_mii_data;
     uint32_t mac_flow;
 
-    uint32_t phy_status;
-    uint32_t phy_control;
-    uint32_t phy_advertise;
-    uint32_t phy_int;
-    uint32_t phy_int_mask;
+    Lan9118PhyState mii;
 
     int32_t eeprom_writable;
     uint8_t eeprom[128];
@@ -301,11 +290,11 @@ static const VMStateDescription vmstate_lan9118 = {
         VMSTATE_UINT32(mac_mii_acc, lan9118_state),
         VMSTATE_UINT32(mac_mii_data, lan9118_state),
         VMSTATE_UINT32(mac_flow, lan9118_state),
-        VMSTATE_UINT32(phy_status, lan9118_state),
-        VMSTATE_UINT32(phy_control, lan9118_state),
-        VMSTATE_UINT32(phy_advertise, lan9118_state),
-        VMSTATE_UINT32(phy_int, lan9118_state),
-        VMSTATE_UINT32(phy_int_mask, lan9118_state),
+        VMSTATE_UINT32(mii.status, lan9118_state),
+        VMSTATE_UINT32(mii.control, lan9118_state),
+        VMSTATE_UINT32(mii.advertise, lan9118_state),
+        VMSTATE_UINT32(mii.ints, lan9118_state),
+        VMSTATE_UINT32(mii.int_mask, lan9118_state),
         VMSTATE_INT32(eeprom_writable, lan9118_state),
         VMSTATE_UINT8_ARRAY(eeprom, lan9118_state, 128),
         VMSTATE_INT32(tx_fifo_size, lan9118_state),
@@ -385,9 +374,11 @@ static void lan9118_reload_eeprom(lan9118_state *s)
     lan9118_mac_changed(s);
 }
 
-static void phy_update_irq(lan9118_state *s)
+static void lan9118_update_irq(void *opaque, int n, int level)
 {
-    if (s->phy_int & s->phy_int_mask) {
+    lan9118_state *s = opaque;
+
+    if (level) {
         s->int_sts |= PHY_INT;
     } else {
         s->int_sts &= ~PHY_INT;
@@ -395,33 +386,10 @@ static void phy_update_irq(lan9118_state *s)
     lan9118_update(s);
 }
 
-static void phy_update_link(lan9118_state *s)
-{
-    /* Autonegotiation status mirrors link status.  */
-    if (qemu_get_queue(s->nic)->link_down) {
-        s->phy_status &= ~0x0024;
-        s->phy_int |= PHY_INT_DOWN;
-    } else {
-        s->phy_status |= 0x0024;
-        s->phy_int |= PHY_INT_ENERGYON;
-        s->phy_int |= PHY_INT_AUTONEG_COMPLETE;
-    }
-    phy_update_irq(s);
-}
-
 static void lan9118_set_link(NetClientState *nc)
 {
-    phy_update_link(qemu_get_nic_opaque(nc));
-}
-
-static void phy_reset(lan9118_state *s)
-{
-    s->phy_status = 0x7809;
-    s->phy_control = 0x3000;
-    s->phy_advertise = 0x01e1;
-    s->phy_int_mask = 0;
-    s->phy_int = 0;
-    phy_update_link(s);
+    lan9118_phy_update_link(&LAN9118(qemu_get_nic_opaque(nc))->mii,
+                            nc->link_down);
 }
 
 static void lan9118_reset(DeviceState *d)
@@ -478,7 +446,7 @@ static void lan9118_reset(DeviceState *d)
     s->read_word_n = 0;
     s->write_word_n = 0;
 
-    phy_reset(s);
+    lan9118_phy_reset(&s->mii);
 
     s->eeprom_writable = 0;
     lan9118_reload_eeprom(s);
@@ -678,7 +646,7 @@ static void do_tx_packet(lan9118_state *s)
     uint32_t status;
 
     /* FIXME: Honor TX disable, and allow queueing of packets.  */
-    if (s->phy_control & 0x4000)  {
+    if (s->mii.control & 0x4000)  {
         /* This assumes the receive routine doesn't touch the VLANClient.  */
         qemu_receive_packet(qemu_get_queue(s->nic), s->txp->data, s->txp->len);
     } else {
@@ -834,68 +802,6 @@ static void tx_fifo_push(lan9118_state *s, uint32_t val)
     }
 }
 
-static uint32_t do_phy_read(lan9118_state *s, int reg)
-{
-    uint32_t val;
-
-    switch (reg) {
-    case 0: /* Basic Control */
-        return s->phy_control;
-    case 1: /* Basic Status */
-        return s->phy_status;
-    case 2: /* ID1 */
-        return 0x0007;
-    case 3: /* ID2 */
-        return 0xc0d1;
-    case 4: /* Auto-neg advertisement */
-        return s->phy_advertise;
-    case 5: /* Auto-neg Link Partner Ability */
-        return 0x0f71;
-    case 6: /* Auto-neg Expansion */
-        return 1;
-        /* TODO 17, 18, 27, 29, 30, 31 */
-    case 29: /* Interrupt source.  */
-        val = s->phy_int;
-        s->phy_int = 0;
-        phy_update_irq(s);
-        return val;
-    case 30: /* Interrupt mask */
-        return s->phy_int_mask;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "do_phy_read: PHY read reg %d\n", reg);
-        return 0;
-    }
-}
-
-static void do_phy_write(lan9118_state *s, int reg, uint32_t val)
-{
-    switch (reg) {
-    case 0: /* Basic Control */
-        if (val & 0x8000) {
-            phy_reset(s);
-            break;
-        }
-        s->phy_control = val & 0x7980;
-        /* Complete autonegotiation immediately.  */
-        if (val & 0x1000) {
-            s->phy_status |= 0x0020;
-        }
-        break;
-    case 4: /* Auto-neg advertisement */
-        s->phy_advertise = (val & 0x2d7f) | 0x80;
-        break;
-        /* TODO 17, 18, 27, 31 */
-    case 30: /* Interrupt mask */
-        s->phy_int_mask = val & 0xff;
-        phy_update_irq(s);
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "do_phy_write: PHY write reg %d = 0x%04x\n", reg, val);
-    }
-}
-
 static void do_mac_write(lan9118_state *s, int reg, uint32_t val)
 {
     switch (reg) {
@@ -929,9 +835,9 @@ static void do_mac_write(lan9118_state *s, int reg, uint32_t val)
         if (val & 2) {
             DPRINTF("PHY write %d = 0x%04x\n",
                     (val >> 6) & 0x1f, s->mac_mii_data);
-            do_phy_write(s, (val >> 6) & 0x1f, s->mac_mii_data);
+            lan9118_phy_write(&s->mii, (val >> 6) & 0x1f, s->mac_mii_data);
         } else {
-            s->mac_mii_data = do_phy_read(s, (val >> 6) & 0x1f);
+            s->mac_mii_data = lan9118_phy_read(&s->mii, (val >> 6) & 0x1f);
             DPRINTF("PHY read %d = 0x%04x\n",
                     (val >> 6) & 0x1f, s->mac_mii_data);
         }
@@ -1126,7 +1032,7 @@ static void lan9118_writel(void *opaque, hwaddr offset,
         break;
     case CSR_PMT_CTRL:
         if (val & 0x400) {
-            phy_reset(s);
+            lan9118_phy_reset(&s->mii);
         }
         s->pmt_ctrl &= ~0x34e;
         s->pmt_ctrl |= (val & 0x34e);
@@ -1383,6 +1289,9 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
                           object_get_typename(OBJECT(dev)), dev->id,
                           &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+
+    qemu_init_irq(&s->mii.irq, lan9118_update_irq, s, 0);
+
     s->eeprom[0] = 0xa5;
     for (i = 0; i < 6; i++) {
         s->eeprom[i + 1] = s->conf.macaddr.a[i];
diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
new file mode 100644
index 0000000000..ced9afce28
--- /dev/null
+++ b/hw/net/lan9118_phy.c
@@ -0,0 +1,117 @@
+/*
+ * SMSC LAN9118 PHY emulation
+ *
+ * Copyright (c) 2009 CodeSourcery, LLC.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the GNU GPL v2
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/net/lan9118_phy.h"
+#include "hw/irq.h"
+#include "qemu/log.h"
+
+#define PHY_INT_ENERGYON            (1 << 7)
+#define PHY_INT_AUTONEG_COMPLETE    (1 << 6)
+#define PHY_INT_FAULT               (1 << 5)
+#define PHY_INT_DOWN                (1 << 4)
+#define PHY_INT_AUTONEG_LP          (1 << 3)
+#define PHY_INT_PARFAULT            (1 << 2)
+#define PHY_INT_AUTONEG_PAGE        (1 << 1)
+
+static void lan9118_phy_update_irq(Lan9118PhyState *s)
+{
+    qemu_set_irq(&s->irq, !!(s->ints & s->int_mask));
+}
+
+void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
+{
+    s->link_down = link_down;
+
+    /* Autonegotiation status mirrors link status. */
+    if (link_down) {
+        s->status &= ~0x0024;
+        s->ints |= PHY_INT_DOWN;
+    } else {
+        s->status |= 0x0024;
+        s->ints |= PHY_INT_ENERGYON;
+        s->ints |= PHY_INT_AUTONEG_COMPLETE;
+    }
+    lan9118_phy_update_irq(s);
+}
+
+void lan9118_phy_reset(Lan9118PhyState *s)
+{
+    s->status = 0x7809;
+    s->control = 0x3000;
+    s->advertise = 0x01e1;
+    s->int_mask = 0;
+    s->ints = 0;
+    lan9118_phy_update_link(s, s->link_down);
+}
+
+uint32_t lan9118_phy_read(Lan9118PhyState *s, int reg)
+{
+    uint32_t val;
+
+    switch (reg) {
+    case 0: /* Basic Control */
+        return s->control;
+    case 1: /* Basic Status */
+        return s->status;
+    case 2: /* ID1 */
+        return 0x0007;
+    case 3: /* ID2 */
+        return 0xc0d1;
+    case 4: /* Auto-neg advertisement */
+        return s->advertise;
+    case 5: /* Auto-neg Link Partner Ability */
+        return 0x0f71;
+    case 6: /* Auto-neg Expansion */
+        return 1;
+        /* TODO 17, 18, 27, 29, 30, 31 */
+    case 29: /* Interrupt source. */
+        val = s->ints;
+        s->ints = 0;
+        lan9118_phy_update_irq(s);
+        return val;
+    case 30: /* Interrupt mask */
+        return s->int_mask;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "lan9118_phy_read: PHY read reg %d\n", reg);
+        return 0;
+    }
+}
+
+void lan9118_phy_write(Lan9118PhyState *s, int reg, uint32_t val)
+{
+    switch (reg) {
+    case 0: /* Basic Control */
+        if (val & 0x8000) {
+            lan9118_phy_reset(s);
+            break;
+        }
+        s->control = val & 0x7980;
+        /* Complete autonegotiation immediately. */
+        if (val & 0x1000) {
+            s->status |= 0x0020;
+        }
+        break;
+    case 4: /* Auto-neg advertisement */
+        s->advertise = (val & 0x2d7f) | 0x80;
+        break;
+        /* TODO 17, 18, 27, 31 */
+    case 30: /* Interrupt mask */
+        s->int_mask = val & 0xff;
+        lan9118_phy_update_irq(s);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "lan9118_phy_write: PHY write reg %d = 0x%04x\n", reg, val);
+    }
+}
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 7fcc0d7faa..6b2ff2f937 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -62,8 +62,12 @@ config VMXNET3_PCI
 config SMC91C111
     bool
 
+config LAN9118_PHY
+    bool
+
 config LAN9118
     bool
+    select LAN9118_PHY
     select PTIMER
 
 config NE2000_ISA
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 00a9e9dd51..3bb5d749a8 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -19,6 +19,7 @@ system_ss.add(when: 'CONFIG_VMXNET3_PCI', if_true: files('vmxnet3.c'))
 
 system_ss.add(when: 'CONFIG_SMC91C111', if_true: files('smc91c111.c'))
 system_ss.add(when: 'CONFIG_LAN9118', if_true: files('lan9118.c'))
+system_ss.add(when: 'CONFIG_LAN9118_PHY', if_true: files('lan9118_phy.c'))
 system_ss.add(when: 'CONFIG_NE2000_ISA', if_true: files('ne2000-isa.c'))
 system_ss.add(when: 'CONFIG_OPENCORES_ETH', if_true: files('opencores_eth.c'))
 system_ss.add(when: 'CONFIG_XGMAC', if_true: files('xgmac.c'))
-- 
2.46.2


