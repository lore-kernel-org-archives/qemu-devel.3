Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962E5C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 22:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x991S-0004NR-Hl; Tue, 22 Sep 2026 18:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x991I-0004Lp-Dt
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 18:31:24 -0400
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x991D-0004M7-Vw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 18:31:23 -0400
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aa1d00daaaso588483a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1790116278; x=1790721078;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tbU8InenrY+vBLNAXnwqAyG5rr4t+l40O8dqkFNIZK0=;
 b=oFvDl9iHiW15D1ExRmxv75po+0+saWu7NXeUE67d0VPuk+UKkdWa9Okk7SxtBqnSi7
 9oPMOxFwh4qeHDQz4DbCc73PCQ5uAGaKWNESWId6emeATyoK3m8BgxyJylk3U7Osmz3P
 qXduhr4963+d5Udgh86k6NgjjE+yT4tdVw0L1fmpRF/BIS4olOfpurXMrDsjLKEBmxVS
 hnq56ber4r6FYR6OYSBBhwXDl9kXi/YvNYkC/7VZEYltiqk0G1JNR41hffrAi99qf2Eg
 dVpDxi8qzcBeyAfoij9idd8I3gp4sVjaiqr1Cm5aegk+Y9oBASi3ab4MyWcdkRAYZ463
 7SrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790116278; x=1790721078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tbU8InenrY+vBLNAXnwqAyG5rr4t+l40O8dqkFNIZK0=;
 b=JkOj/GDKa/o6m7rWeiDN6rz/AsN3Lvwq99CJ596h/uROTHodUSoXDT+7pxeel7XC8d
 rnCG/f05p+ZKXSwHH3kK+NTivR5GVr+Wqhb269e0Jz1xQ5IT6/lh/3GedlfCunchYMnB
 nYxMhfgXiEaHRDW0loXNGDJjjgHAhWSTcJAcYw/8uuhXfPRBli/BXhVLzcngm+JIv/rZ
 w+4Z0oSFQ5xsLZKc1KKGrD77A/DEHZOYg7sFXJWGMl5OW58f4tvoOlSsfZ5uDz3D+24w
 iGCsuZaPK0p7zfHku5mue8Ci7P0vP92MRuwZO0+saypXWWdEcbB+AZhIFknmbrE1z1LW
 MkhQ==
X-Gm-Message-State: AFuF++l8R/LIqtgwpPQuBO+90JO/GdMu8rXXfppOIZnLvycaZ8riTHrw
 dOZjawHiEY40fTFGx6CLUsp6baHhjlyBjbN106A1IpUAcHawPmfrviWOKBkwbrOWYDUMgnKag2m
 DDDeZPUs=
X-Gm-Gg: AYBFou1TblsIhJgjxCeWgnF+MTj6Iw0lF2CtT4FKSsjUD9i0xTrPbke24MU/KB8gMKw
 owErzABH6J/EhofqbkAx01S4iN8J9/sSFyucZfGxGf9CDW1NWP/xccDGNU9MRR0UFe3Jxrrv5YW
 kYRN5xjg22EeTpr54J9cGrsK1xzD9yl3WF0up+htLDLRRK2qbXTdptoW6sqEuQqEb2YpBE7Rdcy
 9bjfz2L9Z5VO388dbmMB379fCQ2vXb3Z9GIUWFXvLntmNIrOBLZY61HrUI4N+eU8tYnkB4t9ijh
 eQ7NkXhd6Hypm6LqtIqBGvIuMbjS/62pQJZQlSsJ4m8ivZdEtN0ETM1XfNZ4Ox2+lcOLobgeAf2
 sBXwQsK3rQPB0tHq+bc2mFWs1LKbgjaJRYiAUyyajK9Jtjnsp8FzClBH5VozRT5Lk1Cz0JHfHQp
 S2Jd/5pXO5f8jPFlVOu7+Tcf//27jR6gXBECCfiZFTh1SBlmBuDdgiu18VjP6lVWSln4EIHSrZU
 umwb3pghTGHLQFmg7bEMIW+UuCnZyRiSdi8wdKyr6qUIRpsLfE9zoXn7fPokBibmdrqPCNFMCx2
X-Received: by 2002:a05:6402:5110:b0:6aa:8d22:a8c3 with SMTP id
 4fb4d7f45d1cf-6aab3a795b6mr678237a12.0.1790116278164; 
 Tue, 22 Sep 2026 15:31:18 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab3883151sm411663a12.14.2026.09.22.15.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 15:31:17 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 jasowangio@gmail.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com
Subject: [PATCH v2 2/6] hw/net: Add Cnuas virtual network adapter
Date: Tue, 22 Sep 2026 22:30:41 +0000
Message-ID: <20260922223045.190062-3-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922223045.190062-1-weqaar.janjua@packetfive.com>
References: <20260922223045.190062-1-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:33::f;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-ed2-x0f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add guest DMA and packet transport while retaining the existing MIT license.

Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
---
 MAINTAINERS               |   6 +
 docs/specs/cnuas-vnic.rst |  78 ++++++
 docs/specs/index.rst      |   1 +
 hw/net/Kconfig            |   5 +
 hw/net/cnuas_vnic.c       | 508 ++++++++++++++++++++++++++++++++++++++
 hw/net/meson.build        |   1 +
 6 files changed, 599 insertions(+)
 create mode 100644 docs/specs/cnuas-vnic.rst
 create mode 100644 hw/net/cnuas_vnic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6be9c5725b..5f9e8db723 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2772,6 +2772,12 @@ F: net/eth.c
 F: hw/net/net_rx_pkt*
 F: hw/net/net_tx_pkt*
 
+Cnuas virtual devices
+M: Weqaar Janjua <weqaar.janjua@packetfive.com>
+S: Maintained
+F: docs/specs/cnuas-vnic.rst
+F: hw/net/cnuas_vnic.c
+
 VMware
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
diff --git a/docs/specs/cnuas-vnic.rst b/docs/specs/cnuas-vnic.rst
new file mode 100644
index 0000000000..a8424ad700
--- /dev/null
+++ b/docs/specs/cnuas-vnic.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=============================
+Cnuas virtual network adapter
+=============================
+
+``cnuas-vnic`` is a PCIe network device for Cnuas RDMA and Ethernet emulation.
+Its wire side is an ``AF_UNIX`` ``SOCK_SEQPACKET`` socket,
+allowing multiple guests to connect to a separate virtual switch process.
+The socket transport currently requires a Linux host.
+
+The device intentionally uses a single transmit operation and one receive
+slot instead of descriptor rings. This keeps the programming model small
+while retaining guest DMA, interrupts, link state, and frame transport.
+
+PCI interface
+-------------
+
+===================== ==============================
+Vendor ID             1b36
+Device ID             0015
+Revision              1
+Class                 0280, other network controller
+===================== ==============================
+
+BAR 0 is a 4 KiB MMIO region. The device supports one MSI vector and INTx.
+
+Properties
+----------
+
+``socket_path``
+  Path of the switch's ``SOCK_SEQPACKET`` socket. Without this property, or
+  when the connection fails, the device still enumerates with its link down.
+
+``mac``
+  MAC address exposed through ``MAC_LO`` and ``MAC_HI``. If omitted, QEMU
+  derives a locally administered address from the PCI function number.
+
+``x-speed``, ``x-width``
+  PCIe link speed and width reported through PCIe configuration space.
+
+Register map
+------------
+
+All registers require 32-bit little-endian accesses.
+
+======  ===========  ===============================================
+Offset  Name         Meaning
+======  ===========  ===============================================
+0x00    TX_ADDR_LO   Guest physical transmit address, low 32 bits
+0x04    TX_ADDR_HI   Guest physical transmit address, high 32 bits
+0x08    TX_LEN       Frame length from 1 through 9216 bytes
+0x0c    TX_DOORBELL  Write to transmit
+0x10    RX_ADDR_LO   Guest physical receive address, low 32 bits
+0x14    RX_ADDR_HI   Guest physical receive address, high 32 bits
+0x18    RX_LEN       Length of the received frame, read only
+0x1c    RX_STATUS    Bit 0 marks a frame ready; write zero to release
+0x20    IRQ_STATUS   Interrupt status; write one bits to clear
+0x24    IRQ_MASK     Interrupt enable mask
+0x28    LINK_STATUS  Bit 0 marks the socket link up, read only
+0x2c    MAC_LO       MAC bytes 0 through 3, read only
+0x30    MAC_HI       MAC bytes 4 and 5, read only
+======  ===========  ===============================================
+
+Interrupt bits are bit 0 for receive completion, bit 1 for transmit
+completion, and bit 2 for a link-state change.
+
+Transport
+---------
+
+Writing ``TX_DOORBELL`` reads ``TX_LEN`` bytes from guest memory and sends
+one socket message. Receive messages are copied to the address in
+``RX_ADDR_LO`` and ``RX_ADDR_HI``. The device stops reading its socket while
+``RX_STATUS`` is set, preventing a later frame from overwriting the active
+receive slot.
+
+The socket transports complete Ethernet frames without an additional QEMU
+header. ``SOCK_SEQPACKET`` preserves frame boundaries.
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 44e108db02..0fd5da2aa8 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -26,6 +26,7 @@ guest hardware that is specific to QEMU.
    fw_cfg
    fsi
    vmw_pvscsi-spec
+   cnuas-vnic
    edu
    ivshmem-spec
    pvpanic
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index b56a173eed..0721efc8b1 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -49,6 +49,11 @@ config IGB_PCI_EXPRESS
     default y if PCI_DEVICES || PCIE_DEVICES
     depends on PCI_EXPRESS && MSI_NONBROKEN
 
+config CNUAS_VNIC
+    bool
+    default y if PCI_DEVICES || PCIE_DEVICES
+    depends on LINUX && PCI_EXPRESS && MSI_NONBROKEN
+
 config RTL8139_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/net/cnuas_vnic.c b/hw/net/cnuas_vnic.c
new file mode 100644
index 0000000000..506d917e39
--- /dev/null
+++ b/hw/net/cnuas_vnic.c
@@ -0,0 +1,508 @@
+/*
+ * Cnuas virtual RDMA network adapter
+ *
+ * Copyright (c) 2026 PacketFive
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pcie.h"
+#include "migration/vmstate.h"
+#include "net/net.h"
+#include "qapi/error.h"
+#include "qom/object.h"
+
+#include <fcntl.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#define TYPE_CNUAS_VNIC "cnuas-vnic"
+OBJECT_DECLARE_SIMPLE_TYPE(CnuasVnicState, CNUAS_VNIC)
+
+#define CNUAS_VNIC_MAX_FRAME 9216
+#define CNUAS_VNIC_MMIO_SIZE 4096
+
+#define CNUAS_VNIC_REG_TX_ADDR_LO   0x00
+#define CNUAS_VNIC_REG_TX_ADDR_HI   0x04
+#define CNUAS_VNIC_REG_TX_LEN       0x08
+#define CNUAS_VNIC_REG_TX_DOORBELL  0x0c
+#define CNUAS_VNIC_REG_RX_ADDR_LO   0x10
+#define CNUAS_VNIC_REG_RX_ADDR_HI   0x14
+#define CNUAS_VNIC_REG_RX_LEN       0x18
+#define CNUAS_VNIC_REG_RX_STATUS    0x1c
+#define CNUAS_VNIC_REG_IRQ_STATUS   0x20
+#define CNUAS_VNIC_REG_IRQ_MASK     0x24
+#define CNUAS_VNIC_REG_LINK_STATUS  0x28
+#define CNUAS_VNIC_REG_MAC_LO       0x2c
+#define CNUAS_VNIC_REG_MAC_HI       0x30
+
+#define CNUAS_VNIC_IRQ_RX_COMPLETE  BIT(0)
+#define CNUAS_VNIC_IRQ_TX_COMPLETE  BIT(1)
+#define CNUAS_VNIC_IRQ_LINK_CHANGE  BIT(2)
+
+#define CNUAS_VNIC_LINK_UP          BIT(0)
+#define CNUAS_VNIC_RX_READY         BIT(0)
+
+struct CnuasVnicState {
+    PCIDevice parent_obj;
+    MemoryRegion mmio;
+
+    char *socket_path;
+    int socket_fd;
+
+    MACAddr conf_mac;
+    uint8_t mac[6];
+
+    PCIExpLinkSpeed pcie_speed;
+    PCIExpLinkWidth pcie_width;
+
+    uint32_t tx_addr_lo;
+    uint32_t tx_addr_hi;
+    uint32_t tx_len;
+    uint32_t rx_addr_lo;
+    uint32_t rx_addr_hi;
+    uint32_t rx_len;
+    uint32_t rx_status;
+    uint32_t irq_status;
+    uint32_t irq_mask;
+    uint32_t link_status;
+};
+
+static void cnuas_vnic_update_irq(CnuasVnicState *s)
+{
+    bool pending = s->irq_status & s->irq_mask;
+
+    if (msi_enabled(&s->parent_obj)) {
+        if (pending) {
+            msi_notify(&s->parent_obj, 0);
+        }
+    } else {
+        pci_set_irq(&s->parent_obj, pending);
+    }
+}
+
+static void cnuas_vnic_set_link(CnuasVnicState *s, bool up)
+{
+    uint32_t new_status = up ? CNUAS_VNIC_LINK_UP : 0;
+
+    if (s->link_status == new_status) {
+        return;
+    }
+
+    s->link_status = new_status;
+    s->irq_status |= CNUAS_VNIC_IRQ_LINK_CHANGE;
+    cnuas_vnic_update_irq(s);
+}
+
+static void cnuas_vnic_disconnect(CnuasVnicState *s)
+{
+    if (s->socket_fd >= 0) {
+        qemu_set_fd_handler(s->socket_fd, NULL, NULL, NULL);
+        close(s->socket_fd);
+        s->socket_fd = -1;
+    }
+    cnuas_vnic_set_link(s, false);
+}
+
+static void cnuas_vnic_transmit(CnuasVnicState *s)
+{
+    uint8_t frame[CNUAS_VNIC_MAX_FRAME];
+    uint64_t address;
+    ssize_t sent;
+
+    if (!s->tx_len || s->tx_len > sizeof(frame)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cnuas-vnic: invalid TX length %u\n", s->tx_len);
+        return;
+    }
+
+    address = ((uint64_t)s->tx_addr_hi << 32) | s->tx_addr_lo;
+    if (pci_dma_read(&s->parent_obj, address, frame, s->tx_len) != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cnuas-vnic: DMA read failed at 0x%" PRIx64 "\n",
+                      address);
+        return;
+    }
+
+    if (s->socket_fd >= 0 && s->link_status == CNUAS_VNIC_LINK_UP) {
+        sent = send(s->socket_fd, frame, s->tx_len, MSG_NOSIGNAL);
+        if (sent < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "cnuas-vnic: TX failed: %s\n", strerror(errno));
+            if (errno != EAGAIN && errno != EWOULDBLOCK) {
+                cnuas_vnic_disconnect(s);
+            }
+        } else if (sent != s->tx_len) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "cnuas-vnic: short TX (%zd of %u bytes)\n",
+                          sent, s->tx_len);
+        }
+    }
+
+    s->irq_status |= CNUAS_VNIC_IRQ_TX_COMPLETE;
+    cnuas_vnic_update_irq(s);
+}
+
+static bool cnuas_vnic_receive(CnuasVnicState *s)
+{
+    uint8_t frame[CNUAS_VNIC_MAX_FRAME];
+    uint64_t address;
+    ssize_t length;
+
+    if (s->socket_fd < 0 || s->rx_status == CNUAS_VNIC_RX_READY) {
+        return false;
+    }
+
+    length = recv(s->socket_fd, frame, sizeof(frame), MSG_DONTWAIT);
+    if (length == 0) {
+        cnuas_vnic_disconnect(s);
+        return false;
+    }
+    if (length < 0) {
+        if (errno != EAGAIN && errno != EWOULDBLOCK && errno != EINTR) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "cnuas-vnic: RX failed: %s\n", strerror(errno));
+            cnuas_vnic_disconnect(s);
+        }
+        return false;
+    }
+
+    address = ((uint64_t)s->rx_addr_hi << 32) | s->rx_addr_lo;
+    if (!address) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cnuas-vnic: dropped RX frame without a guest buffer\n");
+        return true;
+    }
+
+    if (pci_dma_write(&s->parent_obj, address, frame, length) != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cnuas-vnic: DMA write failed at 0x%" PRIx64 "\n",
+                      address);
+        return true;
+    }
+
+    s->rx_len = length;
+    s->rx_status = CNUAS_VNIC_RX_READY;
+    s->irq_status |= CNUAS_VNIC_IRQ_RX_COMPLETE;
+    cnuas_vnic_update_irq(s);
+
+    /*
+     * The model has one receive slot. Stop monitoring the level-triggered
+     * socket until the guest releases that slot to avoid a busy loop.
+     */
+    qemu_set_fd_handler(s->socket_fd, NULL, NULL, NULL);
+    return true;
+}
+
+static void cnuas_vnic_receive_ready(void *opaque)
+{
+    cnuas_vnic_receive(opaque);
+}
+
+static uint64_t cnuas_vnic_mmio_read(void *opaque, hwaddr addr,
+                                     unsigned size)
+{
+    CnuasVnicState *s = opaque;
+
+    switch (addr) {
+    case CNUAS_VNIC_REG_TX_ADDR_LO:
+        return s->tx_addr_lo;
+    case CNUAS_VNIC_REG_TX_ADDR_HI:
+        return s->tx_addr_hi;
+    case CNUAS_VNIC_REG_TX_LEN:
+        return s->tx_len;
+    case CNUAS_VNIC_REG_RX_ADDR_LO:
+        return s->rx_addr_lo;
+    case CNUAS_VNIC_REG_RX_ADDR_HI:
+        return s->rx_addr_hi;
+    case CNUAS_VNIC_REG_RX_LEN:
+        return s->rx_len;
+    case CNUAS_VNIC_REG_RX_STATUS:
+        return s->rx_status;
+    case CNUAS_VNIC_REG_IRQ_STATUS:
+        return s->irq_status;
+    case CNUAS_VNIC_REG_IRQ_MASK:
+        return s->irq_mask;
+    case CNUAS_VNIC_REG_LINK_STATUS:
+        return s->link_status;
+    case CNUAS_VNIC_REG_MAC_LO:
+        return s->mac[0] | s->mac[1] << 8 | s->mac[2] << 16 |
+               s->mac[3] << 24;
+    case CNUAS_VNIC_REG_MAC_HI:
+        return s->mac[4] | s->mac[5] << 8;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cnuas-vnic: read from unknown register 0x%"
+                      HWADDR_PRIx "\n", addr);
+        return 0;
+    }
+}
+
+static void cnuas_vnic_mmio_write(void *opaque, hwaddr addr,
+                                  uint64_t value, unsigned size)
+{
+    CnuasVnicState *s = opaque;
+
+    switch (addr) {
+    case CNUAS_VNIC_REG_TX_ADDR_LO:
+        s->tx_addr_lo = value;
+        break;
+    case CNUAS_VNIC_REG_TX_ADDR_HI:
+        s->tx_addr_hi = value;
+        break;
+    case CNUAS_VNIC_REG_TX_LEN:
+        s->tx_len = value;
+        break;
+    case CNUAS_VNIC_REG_TX_DOORBELL:
+        cnuas_vnic_transmit(s);
+        break;
+    case CNUAS_VNIC_REG_RX_ADDR_LO:
+        s->rx_addr_lo = value;
+        break;
+    case CNUAS_VNIC_REG_RX_ADDR_HI:
+        s->rx_addr_hi = value;
+        break;
+    case CNUAS_VNIC_REG_RX_STATUS:
+        if (!value && s->rx_status == CNUAS_VNIC_RX_READY) {
+            s->rx_status = 0;
+            s->rx_len = 0;
+            if (s->socket_fd >= 0) {
+                qemu_set_fd_handler(s->socket_fd,
+                                    cnuas_vnic_receive_ready, NULL, s);
+                cnuas_vnic_receive(s);
+            }
+        }
+        break;
+    case CNUAS_VNIC_REG_IRQ_STATUS:
+        s->irq_status &= ~value;
+        cnuas_vnic_update_irq(s);
+        break;
+    case CNUAS_VNIC_REG_IRQ_MASK:
+        s->irq_mask = value;
+        cnuas_vnic_update_irq(s);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cnuas-vnic: write to unknown register 0x%"
+                      HWADDR_PRIx "\n", addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps cnuas_vnic_mmio_ops = {
+    .read = cnuas_vnic_mmio_read,
+    .write = cnuas_vnic_mmio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void cnuas_vnic_connect(CnuasVnicState *s)
+{
+    struct sockaddr_un address = { .sun_family = AF_UNIX };
+    int flags;
+    int fd;
+    int buffer_size = 8 * MiB;
+
+    if (!s->socket_path || !s->socket_path[0]) {
+        return;
+    }
+    if (strlen(s->socket_path) >= sizeof(address.sun_path)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cnuas-vnic: socket path is too long\n");
+        return;
+    }
+
+    fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
+    if (fd < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cnuas-vnic: socket creation failed: %s\n",
+                      strerror(errno));
+        return;
+    }
+
+    g_strlcpy(address.sun_path, s->socket_path, sizeof(address.sun_path));
+    if (connect(fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
+        qemu_log_mask(LOG_UNIMP,
+                      "cnuas-vnic: cannot connect to %s: %s\n",
+                      s->socket_path, strerror(errno));
+        close(fd);
+        return;
+    }
+
+    flags = fcntl(fd, F_GETFL);
+    if (flags < 0 || fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cnuas-vnic: cannot make socket nonblocking: %s\n",
+                      strerror(errno));
+        close(fd);
+        return;
+    }
+
+    setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &buffer_size, sizeof(buffer_size));
+    setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &buffer_size, sizeof(buffer_size));
+
+    s->socket_fd = fd;
+    cnuas_vnic_set_link(s, true);
+    qemu_set_fd_handler(fd, cnuas_vnic_receive_ready, NULL, s);
+}
+
+static void cnuas_vnic_reset_hold(Object *obj, ResetType type)
+{
+    CnuasVnicState *s = CNUAS_VNIC(obj);
+
+    s->tx_addr_lo = 0;
+    s->tx_addr_hi = 0;
+    s->tx_len = 0;
+    s->rx_addr_lo = 0;
+    s->rx_addr_hi = 0;
+    s->rx_len = 0;
+    s->rx_status = 0;
+    s->irq_status = 0;
+    s->irq_mask = 0;
+    pci_set_irq(&s->parent_obj, 0);
+
+    if (s->socket_fd >= 0) {
+        qemu_set_fd_handler(s->socket_fd, cnuas_vnic_receive_ready, NULL, s);
+    }
+}
+
+static int cnuas_vnic_post_load(void *opaque, int version_id)
+{
+    CnuasVnicState *s = opaque;
+
+    if (s->socket_fd >= 0) {
+        qemu_set_fd_handler(s->socket_fd,
+                            s->rx_status ? NULL : cnuas_vnic_receive_ready,
+                            NULL, s);
+    }
+    cnuas_vnic_update_irq(s);
+    return 0;
+}
+
+static const VMStateDescription vmstate_cnuas_vnic = {
+    .name = TYPE_CNUAS_VNIC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = cnuas_vnic_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, CnuasVnicState),
+        VMSTATE_UINT32(tx_addr_lo, CnuasVnicState),
+        VMSTATE_UINT32(tx_addr_hi, CnuasVnicState),
+        VMSTATE_UINT32(tx_len, CnuasVnicState),
+        VMSTATE_UINT32(rx_addr_lo, CnuasVnicState),
+        VMSTATE_UINT32(rx_addr_hi, CnuasVnicState),
+        VMSTATE_UINT32(rx_len, CnuasVnicState),
+        VMSTATE_UINT32(rx_status, CnuasVnicState),
+        VMSTATE_UINT32(irq_status, CnuasVnicState),
+        VMSTATE_UINT32(irq_mask, CnuasVnicState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void cnuas_vnic_realize(PCIDevice *pdev, Error **errp)
+{
+    CnuasVnicState *s = CNUAS_VNIC(pdev);
+    static const uint8_t zero_mac[6];
+
+    pci_config_set_interrupt_pin(pdev->config, 1);
+    if (msi_init(pdev, 0, 1, true, false, errp)) {
+        return;
+    }
+
+    if (pcie_endpoint_cap_init(pdev, 0x80) < 0) {
+        error_setg(errp, "cnuas-vnic: cannot initialize PCIe capability");
+        msi_uninit(pdev);
+        return;
+    }
+    pcie_cap_fill_link_ep_usp(pdev, s->pcie_width, s->pcie_speed, false);
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &cnuas_vnic_mmio_ops, s,
+                          "cnuas-vnic-mmio", CNUAS_VNIC_MMIO_SIZE);
+    pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio);
+
+    if (!memcmp(s->conf_mac.a, zero_mac, sizeof(zero_mac))) {
+        s->mac[0] = 0x02;
+        s->mac[1] = 0x48;
+        s->mac[2] = 0x43;
+        s->mac[3] = 0x41;
+        s->mac[4] = 0x49;
+        s->mac[5] = pdev->devfn;
+    } else {
+        memcpy(s->mac, s->conf_mac.a, sizeof(s->mac));
+    }
+
+    s->socket_fd = -1;
+    cnuas_vnic_connect(s);
+}
+
+static void cnuas_vnic_exit(PCIDevice *pdev)
+{
+    CnuasVnicState *s = CNUAS_VNIC(pdev);
+
+    cnuas_vnic_disconnect(s);
+    pcie_cap_exit(pdev);
+    msi_uninit(pdev);
+}
+
+static const Property cnuas_vnic_properties[] = {
+    DEFINE_PROP_STRING("socket_path", CnuasVnicState, socket_path),
+    DEFINE_PROP_MACADDR("mac", CnuasVnicState, conf_mac),
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", CnuasVnicState, pcie_speed,
+                                PCIE_LINK_SPEED_32),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CnuasVnicState, pcie_width,
+                                PCIE_LINK_WIDTH_16),
+};
+
+static void cnuas_vnic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    pc->realize = cnuas_vnic_realize;
+    pc->exit = cnuas_vnic_exit;
+    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
+    pc->device_id = PCI_DEVICE_ID_REDHAT_CNUASNIC;
+    pc->class_id = PCI_CLASS_NETWORK_OTHER;
+    pc->revision = 1;
+
+    rc->phases.hold = cnuas_vnic_reset_hold;
+    dc->desc = "Cnuas virtual RDMA network adapter";
+    dc->vmsd = &vmstate_cnuas_vnic;
+    device_class_set_props(dc, cnuas_vnic_properties);
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+}
+
+static const TypeInfo cnuas_vnic_info = {
+    .name = TYPE_CNUAS_VNIC,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(CnuasVnicState),
+    .class_init = cnuas_vnic_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { },
+    },
+};
+
+static void cnuas_vnic_register_types(void)
+{
+    type_register_static(&cnuas_vnic_info);
+}
+
+type_init(cnuas_vnic_register_types)
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 63b0e96245..1b942bd415 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -12,6 +12,7 @@ system_ss.add(when: 'CONFIG_E1000E_PCI_EXPRESS', if_true: files('net_tx_pkt.c',
 system_ss.add(when: 'CONFIG_E1000E_PCI_EXPRESS', if_true: files('e1000e.c', 'e1000e_core.c', 'e1000x_common.c'))
 system_ss.add(when: 'CONFIG_IGB_PCI_EXPRESS', if_true: files('net_tx_pkt.c', 'net_rx_pkt.c'))
 system_ss.add(when: 'CONFIG_IGB_PCI_EXPRESS', if_true: files('igb.c', 'igbvf.c', 'igb_core.c'))
+system_ss.add(when: 'CONFIG_CNUAS_VNIC', if_true: files('cnuas_vnic.c'))
 system_ss.add(when: 'CONFIG_RTL8139_PCI', if_true: files('rtl8139.c'))
 system_ss.add(when: 'CONFIG_TULIP', if_true: files('tulip.c'))
 system_ss.add(when: 'CONFIG_VMXNET3_PCI', if_true: files('net_tx_pkt.c', 'net_rx_pkt.c'))
-- 
2.43.0


