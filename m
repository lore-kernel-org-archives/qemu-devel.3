Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A841E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRg-00004t-UV; Wed, 11 Dec 2024 11:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRe-0008Tv-U6
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:14 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRc-0007Zi-AO
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:14 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so5143720f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934010; x=1734538810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wZ9Ks1ZvuwkBmBypHf4VRn8ygrg0mYJ8EjWruN3aUCY=;
 b=J97hiwd5c4IwL3Do0AKpIdESJSnuIOzIm2gLiMNzt3nzLHXSBAr4sws7GL8Cz71Imk
 0yYjvqiNebCD+x/NrN5kFU+AtT1TLkemzKD/b6eUNofVfgBH0hSB5lX5GP8B/Xdc4vPC
 f/qLD1fuHpdpllmlqYpOxTrcffmX06g78tTEuNg9OSsBGpscB5SUM7ZfB6MGqkCHqXRV
 n/aXD379Fn62PDtVNht1YKXuVF4RIod3YxfKcQzQ4mWEh/6ANTWvgGn4V1VyPbD19wWB
 W0Ttz0sVUt6IMfPi9rQB7xxcIbkjw5QCkmkahtmIniKc4cPovTnYLVl2kVwtM9YZKvpg
 PwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934010; x=1734538810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZ9Ks1ZvuwkBmBypHf4VRn8ygrg0mYJ8EjWruN3aUCY=;
 b=rTcxrtLkSkpSfvwJ/EoOtz6Vr2jlOxzgrr5eA2jc3EIba/yxQzmzHhrg9/7Aekmcz7
 XJgtLhYCCjdnpgDPw2J8wczU5ZGQQt37lYasiq7NdEB5ZnEOwsSL2TZ+A5+q+Hb+5lWC
 vRXrxmrOs6hE7vL6SXY8X6i/KKIaW5eu0NSQgjtHKJw1IEZ3cAvobxDwG0zfgTbuMZ66
 mb7bb+StRTnqJG95pBww8TnqKWv0HodKlIaF5VuFBWJzHg2Hej+6EHqVzgpdZ357MwBT
 GFGI2xhnTZcROHOHQ1bE2cs7kMmiwIKI/fg9wvpXeKMKXAyHvLMZYBKO0weUJrTKZPOn
 ziqQ==
X-Gm-Message-State: AOJu0YwbVQok2ScqCYbbbXfRghnDURG/sGPMxFEjJaHePUNdFGDr1KPO
 3EUKccwwBgM7Xv4Z1eaAYw1djffn0dfrofm5mM5VaGd+w+7R1nVjpzwTbJB4myFO8xA2WXW3kVi
 U
X-Gm-Gg: ASbGncuMIibDuIIuYpF1SaYhn3SzWk9KBI3N9aHzx3Ed6+kYVJ1i6aqhMjVGYgjdqY9
 B2N9Bh6cz79sf1pgD627z6Zkt/N5oM1FQQHAEfJWCXrJdgBOvOdL4EGQS8cb2K3j0YPSyOAhEBs
 wHSXeZrpKEMTEvAcZyCLvfYhP+bm9QZvVZLC0BwuZkJzf/U/9wYBvJsqVLV71pXU1xAPJKaoYEC
 MWIGlVmy4eVYyDgJooS9wI/4MGV+DcD3juq4YYB5L8o0+rUx07WmgylYu/z
X-Google-Smtp-Source: AGHT+IGqt9/zdVpulGS7pnK6Od1KbeZEFLOpPta+dIlFBZdgmn2b1LhodkAWw80Wd4nlXREx+NEvaw==
X-Received: by 2002:a05:6000:a05:b0:385:fc8c:24b6 with SMTP id
 ffacd0b85a97d-387876973b2mr213414f8f.27.1733934009648; 
 Wed, 11 Dec 2024 08:20:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/72] hw/net/lan9118: Extract lan9118_phy
Date: Wed, 11 Dec 2024 16:18:53 +0000
Message-Id: <20241211162004.2795499-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

A very similar implementation of the same device exists in imx_fec. Prepare for
a common implementation by extracting a device model into its own files.

Some migration state has been moved into the new device model which breaks
migration compatibility for the following machines:
* smdkc210
* realview-*
* vexpress-*
* kzm
* mps2-*

While breaking migration ABI, fix the size of the MII registers to be 16 bit,
as defined by IEEE 802.3u.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241102125724.532843-2-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/lan9118_phy.h |  37 ++++++++
 hw/net/lan9118.c             | 137 +++++-----------------------
 hw/net/lan9118_phy.c         | 169 +++++++++++++++++++++++++++++++++++
 hw/net/Kconfig               |   4 +
 hw/net/meson.build           |   1 +
 5 files changed, 233 insertions(+), 115 deletions(-)
 create mode 100644 include/hw/net/lan9118_phy.h
 create mode 100644 hw/net/lan9118_phy.c

diff --git a/include/hw/net/lan9118_phy.h b/include/hw/net/lan9118_phy.h
new file mode 100644
index 00000000000..af12fc33d5f
--- /dev/null
+++ b/include/hw/net/lan9118_phy.h
@@ -0,0 +1,37 @@
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
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+#define TYPE_LAN9118_PHY "lan9118-phy"
+OBJECT_DECLARE_SIMPLE_TYPE(Lan9118PhyState, LAN9118_PHY)
+
+typedef struct Lan9118PhyState {
+    SysBusDevice parent_obj;
+
+    uint16_t status;
+    uint16_t control;
+    uint16_t advertise;
+    uint16_t ints;
+    uint16_t int_mask;
+    qemu_irq irq;
+    bool link_down;
+} Lan9118PhyState;
+
+void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down);
+void lan9118_phy_reset(Lan9118PhyState *s);
+uint16_t lan9118_phy_read(Lan9118PhyState *s, int reg);
+void lan9118_phy_write(Lan9118PhyState *s, int reg, uint16_t val);
+
+#endif
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index db28a0ef306..99e87b7178c 100644
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
@@ -228,11 +221,8 @@ struct lan9118_state {
     uint32_t mac_mii_data;
     uint32_t mac_flow;
 
-    uint32_t phy_status;
-    uint32_t phy_control;
-    uint32_t phy_advertise;
-    uint32_t phy_int;
-    uint32_t phy_int_mask;
+    Lan9118PhyState mii;
+    IRQState mii_irq;
 
     int32_t eeprom_writable;
     uint8_t eeprom[128];
@@ -274,8 +264,8 @@ struct lan9118_state {
 
 static const VMStateDescription vmstate_lan9118 = {
     .name = "lan9118",
-    .version_id = 2,
-    .minimum_version_id = 1,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, lan9118_state),
         VMSTATE_UINT32(irq_cfg, lan9118_state),
@@ -301,11 +291,6 @@ static const VMStateDescription vmstate_lan9118 = {
         VMSTATE_UINT32(mac_mii_acc, lan9118_state),
         VMSTATE_UINT32(mac_mii_data, lan9118_state),
         VMSTATE_UINT32(mac_flow, lan9118_state),
-        VMSTATE_UINT32(phy_status, lan9118_state),
-        VMSTATE_UINT32(phy_control, lan9118_state),
-        VMSTATE_UINT32(phy_advertise, lan9118_state),
-        VMSTATE_UINT32(phy_int, lan9118_state),
-        VMSTATE_UINT32(phy_int_mask, lan9118_state),
         VMSTATE_INT32(eeprom_writable, lan9118_state),
         VMSTATE_UINT8_ARRAY(eeprom, lan9118_state, 128),
         VMSTATE_INT32(tx_fifo_size, lan9118_state),
@@ -385,9 +370,11 @@ static void lan9118_reload_eeprom(lan9118_state *s)
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
@@ -395,33 +382,10 @@ static void phy_update_irq(lan9118_state *s)
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
@@ -478,8 +442,6 @@ static void lan9118_reset(DeviceState *d)
     s->read_word_n = 0;
     s->write_word_n = 0;
 
-    phy_reset(s);
-
     s->eeprom_writable = 0;
     lan9118_reload_eeprom(s);
 }
@@ -678,7 +640,7 @@ static void do_tx_packet(lan9118_state *s)
     uint32_t status;
 
     /* FIXME: Honor TX disable, and allow queueing of packets.  */
-    if (s->phy_control & 0x4000)  {
+    if (s->mii.control & 0x4000) {
         /* This assumes the receive routine doesn't touch the VLANClient.  */
         qemu_receive_packet(qemu_get_queue(s->nic), s->txp->data, s->txp->len);
     } else {
@@ -834,68 +796,6 @@ static void tx_fifo_push(lan9118_state *s, uint32_t val)
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
@@ -929,9 +829,9 @@ static void do_mac_write(lan9118_state *s, int reg, uint32_t val)
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
@@ -1126,7 +1026,7 @@ static void lan9118_writel(void *opaque, hwaddr offset,
         break;
     case CSR_PMT_CTRL:
         if (val & 0x400) {
-            phy_reset(s);
+            lan9118_phy_reset(&s->mii);
         }
         s->pmt_ctrl &= ~0x34e;
         s->pmt_ctrl |= (val & 0x34e);
@@ -1373,6 +1273,13 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
     const MemoryRegionOps *mem_ops =
             s->mode_16bit ? &lan9118_16bit_mem_ops : &lan9118_mem_ops;
 
+    qemu_init_irq(&s->mii_irq, lan9118_update_irq, s, 0);
+    object_initialize_child(OBJECT(s), "mii", &s->mii, TYPE_LAN9118_PHY);
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->mii), errp)) {
+        return;
+    }
+    qdev_connect_gpio_out(DEVICE(&s->mii), 0, &s->mii_irq);
+
     memory_region_init_io(&s->mmio, OBJECT(dev), mem_ops, s,
                           "lan9118-mmio", 0x100);
     sysbus_init_mmio(sbd, &s->mmio);
diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
new file mode 100644
index 00000000000..b22c3c28556
--- /dev/null
+++ b/hw/net/lan9118_phy.c
@@ -0,0 +1,169 @@
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
+#include "hw/resettable.h"
+#include "migration/vmstate.h"
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
+    qemu_set_irq(s->irq, !!(s->ints & s->int_mask));
+}
+
+uint16_t lan9118_phy_read(Lan9118PhyState *s, int reg)
+{
+    uint16_t val;
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
+void lan9118_phy_write(Lan9118PhyState *s, int reg, uint16_t val)
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
+    s->control = 0x3000;
+    s->status = 0x7809;
+    s->advertise = 0x01e1;
+    s->int_mask = 0;
+    s->ints = 0;
+    lan9118_phy_update_link(s, s->link_down);
+}
+
+static void lan9118_phy_reset_hold(Object *obj, ResetType type)
+{
+    Lan9118PhyState *s = LAN9118_PHY(obj);
+
+    lan9118_phy_reset(s);
+}
+
+static void lan9118_phy_init(Object *obj)
+{
+    Lan9118PhyState *s = LAN9118_PHY(obj);
+
+    qdev_init_gpio_out(DEVICE(s), &s->irq, 1);
+}
+
+static const VMStateDescription vmstate_lan9118_phy = {
+    .name = "lan9118-phy",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(control, Lan9118PhyState),
+        VMSTATE_UINT16(status, Lan9118PhyState),
+        VMSTATE_UINT16(advertise, Lan9118PhyState),
+        VMSTATE_UINT16(ints, Lan9118PhyState),
+        VMSTATE_UINT16(int_mask, Lan9118PhyState),
+        VMSTATE_BOOL(link_down, Lan9118PhyState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void lan9118_phy_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    rc->phases.hold = lan9118_phy_reset_hold;
+    dc->vmsd = &vmstate_lan9118_phy;
+}
+
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_LAN9118_PHY,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(Lan9118PhyState),
+        .instance_init = lan9118_phy_init,
+        .class_init    = lan9118_phy_class_init,
+    }
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 7fcc0d7faa2..6b2ff2f937a 100644
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
index 00a9e9dd515..3bb5d749a83 100644
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
2.34.1


