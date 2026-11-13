Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723E606BCBD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wHCE7c9F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRuU2-0006eO-RQ; Fri, 13 Nov 2026 11:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRuTn-00067t-00
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:50:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRuTk-0004kE-9M
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:50:22 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso16412715e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794588618; x=1795193418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kvfpWaXEFgUZuKbCtCzfYIL8xCyV1emptC/2RsaZkUg=;
 b=wHCE7c9FQJ6clQZ7Eof5HHwvPI843wq+9nCmOV5RL1b9X0jwaxMeRiG7+LKy+Zfb1a
 fmmZHtk19E8tgxgelSFm+FU3KA/39PC2xoK6sj3JllYG2b/L5cdHDSOgPgbDMrXfOjWe
 jMkLOHncm4SjER7cmNrMnjn7SYjBLDXxsGfLx7Hn2i4xL3Elyac4clokV+4nJM1DTxyF
 WE2BD25LQRSjAARUlzc33/0e4LrM9yU8JGa6NIeGLcZiDvd0XwVvWK0ddLq8dYaMAlor
 N63/MNGjwl0N7jU+iJhJAt0Y6z4DA+SaU6Y10Rh1nx3S5PZkxYyihmxDXnfcvBtmQJUC
 cUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794588618; x=1795193418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kvfpWaXEFgUZuKbCtCzfYIL8xCyV1emptC/2RsaZkUg=;
 b=o8Ake6rfJiyWZkHcjtAgcWaVL3phLgUnugl26KydwXyOIuwS7MbUx0Mllmp+K1TmYn
 SFjh0J6XZHl84pDDLrkBDqIBjIcg0nb3Ufg13sjKBfR7T31nN5QzR16+OFw4CeJ39q99
 m22WrjfaGAoCEp0fTqxZZg/UPY1sRIu/LWqGseRKeVQ+GTEI8gdBq1RYpix2DJ6v/sSx
 Gt9e+9VtTW31BsBAIbwK/yHOtld0XMomsfcce+UyXLuIMFW9dGPOINMl79ESu3KzZmfX
 do8tfdTC71TgwJe2DVn1aZcRN8opr0NVqeQ2PLashjmN/6YQ39CvnWZ9zSA9dsmW4KfR
 GQsA==
X-Gm-Message-State: APuU4Z8Kfmr4jKKc3O3oOIFi9hNzJNo/POs+lZP6wE4yS8OilQIQFdK2
 Ea17UuBOP/ogqg9D53Bf9j1eFXSgbD09todxF2xKAXlHZCVxdG9PTy45GT4wa0Pm2D380n6THjG
 WSU+2V2g=
X-Gm-Gg: AYBFou36ecVX5O2whjUO2GxZn68X9sBFJ2gpopjnaPEZR5GQhSYrvSKHbswM+GB6vYS
 Zm1OSjxlWoUX1eCG9Vhq2GnJcWDLb+2eB99erPdOypPxDZ2ZiHIJ3xP1X8s8CD0sGLXVY+tYv6r
 NlOJUAvOReZFCGaQ5QUvMBJDfxEUocDOZgWHqIgMYbQzMycQx13YkuPu4swDXKPxoXOUGs2e2td
 kBCMGAtrBksLi84wsB7i7MTqI6crpHNHkj5/Lz4GaoMAJS0wAFGzTKOtNckASh3t1d1baeeDh9N
 ryYvvM1RnV4ud4CZaAkBydEhlZHzgWSUmT8ZMPdIXjFvQykCKWzRGzavVYiykiLwRQxQDmV/+XZ
 nCiXuJeKcqwQqpIEwcMYMrSwHvmSSgyYKf4eNzq0UMq31VL4ivZo7D6UrZXGxHo32Of9MnHw+NB
 iADSdwwMrO1NOPAWE7pfIYcVBVKM+qj289wS6yXE/i36/DeBi7jfXIvAne+XOgE2HKLzTT7I2sR
 kwuDstA0hjeHeB7E5jnPWwsi+3oxrjttmZZeF3ZYeZwVKbWnJMk6xE0XydbAfoB+YXgf2QQRFBi
 yAef9XAp4aQAcSygQOB3iqMgLUjULbHrPYBV0tnmm1/nn2JuK1Vhd1JLgXARBhMhSJoM2CR0m8y
 kbN7pF3L4SUSURRZow+3fCQNJfWqRYvyn/A==
X-Received: by 2002:a05:600c:34d6:b0:4bb:5c92:ce22 with SMTP id
 5b1f17b1804b1-4bb5c92d047mr27316655e9.8.1794588617478; 
 Fri, 13 Nov 2026 08:50:17 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55acdfebsm67576025e9.7.2026.11.13.08.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:50:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/net/rtl8139: Limit DMA transfers to plain memory
Date: Fri, 13 Nov 2026 16:50:15 +0000
Message-ID: <20261113165015.1150646-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There's no reason for the RTL8139 to be doing a DMA transfer to
something that isn't memory, and allowing it can cause weird
re-entrancy problems, such as a DMA to the PCI hot-unplug register
causing the device to be deleted while it's halfway through doing
something.

Replace the calls to pci_dma_read() and pci_dma_write() with
local functions that are identical except that they pass
a MemTxAttrs that forbids non-memory accesses.

This is the same approach we took to a similar problem with
the hcd-xhci USB controller in commit 89e653b7736 (but differs
from what we did for lsi53c895a in commit 4862d2c95104d).

The known trigger for this bug requires that you turned off
ACPI hotplug on the QEMU commandline with
  -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off
so most configurations won't run into it.

Cc: qemu-stable@nongnu.org
Fixes: 3ada003aee2004d24f2 ("rtl8139: Use PCI DMA stub functions")
Fixes: CVE-2026-128868
Reported-by: VictorCHEN <ahchen-yz@outlook.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm also wondering whether there's an approach to this class of
bugs that would avoid us having to modify specific devices to
insist on DMA-to-memory. It seems a bit dubious that writing to
the PCI hot-unplug register can cause us to unrealize the plugged
device even if lots of other things are still holding a reference
to it. Or else we need to be more specific that you can still
validly (in the sense of "doesn't break things") do things on or
as part of an unrealized-but-not-yet-freed device, and move
things like pci_config_free() from unrealize to deinit.

 hw/net/rtl8139.c | 98 +++++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 38 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 16479284eea..6644c1b62c5 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -513,6 +513,28 @@ struct RTL8139State {
     int rtl8139_mmio_io_addr_dummy;
 };
 
+/*
+ * There's no reason for the RTL8139 to do DMA to something that
+ * isn't memory, and it can cause weird re-entrancy problems if e.g.
+ * a DMA write targets the PCI hot-unplug register for the device.
+ * Set memory=1 in the memory attributes to avoid that kind of thing.
+ */
+static MemTxResult rtl8139_dma_write(PCIDevice *dev, dma_addr_t addr,
+                                     const void *buf, dma_addr_t len)
+{
+    const MemTxAttrs attrs = { .memory = true };
+    return pci_dma_rw(dev, addr, (void *)buf, len,
+                      DMA_DIRECTION_FROM_DEVICE, attrs);
+}
+
+static inline MemTxResult rtl8139_dma_read(PCIDevice *dev, dma_addr_t addr,
+                                           void *buf, dma_addr_t len)
+{
+    const MemTxAttrs attrs = { .memory = true };
+    return pci_dma_rw(dev, addr, buf, len,
+                      DMA_DIRECTION_TO_DEVICE, attrs);
+}
+
 /* Writes tally counters to memory via DMA */
 static void RTL8139TallyCounters_dma_write(RTL8139State *s, dma_addr_t tc_addr);
 
@@ -756,15 +778,15 @@ static void rtl8139_write_buffer(RTL8139State *s, const void *buf, int size)
 
             if (size > wrapped)
             {
-                pci_dma_write(d, s->RxBuf + s->RxBufAddr,
-                              buf, size-wrapped);
+                rtl8139_dma_write(d, s->RxBuf + s->RxBufAddr,
+                                  buf, size - wrapped);
             }
 
             /* reset buffer pointer */
             s->RxBufAddr = 0;
 
-            pci_dma_write(d, s->RxBuf + s->RxBufAddr,
-                          buf + (size-wrapped), wrapped);
+            rtl8139_dma_write(d, s->RxBuf + s->RxBufAddr,
+                              buf + (size - wrapped), wrapped);
 
             s->RxBufAddr = wrapped;
 
@@ -773,7 +795,7 @@ static void rtl8139_write_buffer(RTL8139State *s, const void *buf, int size)
     }
 
     /* non-wrapping path or overwrapping enabled */
-    pci_dma_write(d, s->RxBuf + s->RxBufAddr, buf, size);
+    rtl8139_dma_write(d, s->RxBuf + s->RxBufAddr, buf, size);
 
     s->RxBufAddr += size;
 }
@@ -971,13 +993,13 @@ static ssize_t rtl8139_receive(NetClientState *nc,
 
         uint32_t val, rxdw0,rxdw1,rxbufLO,rxbufHI;
 
-        pci_dma_read(d, cplus_rx_ring_desc, &val, 4);
+        rtl8139_dma_read(d, cplus_rx_ring_desc, &val, 4);
         rxdw0 = le32_to_cpu(val);
-        pci_dma_read(d, cplus_rx_ring_desc+4, &val, 4);
+        rtl8139_dma_read(d, cplus_rx_ring_desc + 4, &val, 4);
         rxdw1 = le32_to_cpu(val);
-        pci_dma_read(d, cplus_rx_ring_desc+8, &val, 4);
+        rtl8139_dma_read(d, cplus_rx_ring_desc + 8, &val, 4);
         rxbufLO = le32_to_cpu(val);
-        pci_dma_read(d, cplus_rx_ring_desc+12, &val, 4);
+        rtl8139_dma_read(d, cplus_rx_ring_desc + 12, &val, 4);
         rxbufHI = le32_to_cpu(val);
 
         DPRINTF("+++ C+ mode RX descriptor %d %08x %08x %08x %08x\n",
@@ -1040,12 +1062,12 @@ static ssize_t rtl8139_receive(NetClientState *nc,
 
         /* receive/copy to target memory */
         if (dot1q_buf) {
-            pci_dma_write(d, rx_addr, buf, 2 * ETH_ALEN);
-            pci_dma_write(d, rx_addr + 2 * ETH_ALEN,
-                          buf + 2 * ETH_ALEN + VLAN_HLEN,
-                          size - 2 * ETH_ALEN);
+            rtl8139_dma_write(d, rx_addr, buf, 2 * ETH_ALEN);
+            rtl8139_dma_write(d, rx_addr + 2 * ETH_ALEN,
+                              buf + 2 * ETH_ALEN + VLAN_HLEN,
+                              size - 2 * ETH_ALEN);
         } else {
-            pci_dma_write(d, rx_addr, buf, size);
+            rtl8139_dma_write(d, rx_addr, buf, size);
         }
 
         if (s->CpCmd & CPlusRxChkSum)
@@ -1055,7 +1077,7 @@ static ssize_t rtl8139_receive(NetClientState *nc,
 
         /* write checksum */
         val = cpu_to_le32(crc32(0, buf, size_));
-        pci_dma_write(d, rx_addr+size, (uint8_t *)&val, 4);
+        rtl8139_dma_write(d, rx_addr + size, (uint8_t *)&val, 4);
 
 /* first segment of received packet flag */
 #define CP_RX_STATUS_FS (1<<29)
@@ -1101,9 +1123,9 @@ static ssize_t rtl8139_receive(NetClientState *nc,
 
         /* update ring data */
         val = cpu_to_le32(rxdw0);
-        pci_dma_write(d, cplus_rx_ring_desc, (uint8_t *)&val, 4);
+        rtl8139_dma_write(d, cplus_rx_ring_desc, (uint8_t *)&val, 4);
         val = cpu_to_le32(rxdw1);
-        pci_dma_write(d, cplus_rx_ring_desc+4, (uint8_t *)&val, 4);
+        rtl8139_dma_write(d, cplus_rx_ring_desc + 4, (uint8_t *)&val, 4);
 
         /* update tally counter */
         ++s->tally_counters.RxOk;
@@ -1291,43 +1313,43 @@ static void RTL8139TallyCounters_dma_write(RTL8139State *s, dma_addr_t tc_addr)
     uint64_t val64;
 
     val64 = cpu_to_le64(tally_counters->TxOk);
-    pci_dma_write(d, tc_addr + 0,     (uint8_t *)&val64, 8);
+    rtl8139_dma_write(d, tc_addr + 0,     (uint8_t *)&val64, 8);
 
     val64 = cpu_to_le64(tally_counters->RxOk);
-    pci_dma_write(d, tc_addr + 8,     (uint8_t *)&val64, 8);
+    rtl8139_dma_write(d, tc_addr + 8,     (uint8_t *)&val64, 8);
 
     val64 = cpu_to_le64(tally_counters->TxERR);
-    pci_dma_write(d, tc_addr + 16,    (uint8_t *)&val64, 8);
+    rtl8139_dma_write(d, tc_addr + 16,    (uint8_t *)&val64, 8);
 
     val32 = cpu_to_le32(tally_counters->RxERR);
-    pci_dma_write(d, tc_addr + 24,    (uint8_t *)&val32, 4);
+    rtl8139_dma_write(d, tc_addr + 24,    (uint8_t *)&val32, 4);
 
     val16 = cpu_to_le16(tally_counters->MissPkt);
-    pci_dma_write(d, tc_addr + 28,    (uint8_t *)&val16, 2);
+    rtl8139_dma_write(d, tc_addr + 28,    (uint8_t *)&val16, 2);
 
     val16 = cpu_to_le16(tally_counters->FAE);
-    pci_dma_write(d, tc_addr + 30,    (uint8_t *)&val16, 2);
+    rtl8139_dma_write(d, tc_addr + 30,    (uint8_t *)&val16, 2);
 
     val32 = cpu_to_le32(tally_counters->Tx1Col);
-    pci_dma_write(d, tc_addr + 32,    (uint8_t *)&val32, 4);
+    rtl8139_dma_write(d, tc_addr + 32,    (uint8_t *)&val32, 4);
 
     val32 = cpu_to_le32(tally_counters->TxMCol);
-    pci_dma_write(d, tc_addr + 36,    (uint8_t *)&val32, 4);
+    rtl8139_dma_write(d, tc_addr + 36,    (uint8_t *)&val32, 4);
 
     val64 = cpu_to_le64(tally_counters->RxOkPhy);
-    pci_dma_write(d, tc_addr + 40,    (uint8_t *)&val64, 8);
+    rtl8139_dma_write(d, tc_addr + 40,    (uint8_t *)&val64, 8);
 
     val64 = cpu_to_le64(tally_counters->RxOkBrd);
-    pci_dma_write(d, tc_addr + 48,    (uint8_t *)&val64, 8);
+    rtl8139_dma_write(d, tc_addr + 48,    (uint8_t *)&val64, 8);
 
     val32 = cpu_to_le32(tally_counters->RxOkMul);
-    pci_dma_write(d, tc_addr + 56,    (uint8_t *)&val32, 4);
+    rtl8139_dma_write(d, tc_addr + 56,    (uint8_t *)&val32, 4);
 
     val16 = cpu_to_le16(tally_counters->TxAbt);
-    pci_dma_write(d, tc_addr + 60,    (uint8_t *)&val16, 2);
+    rtl8139_dma_write(d, tc_addr + 60,    (uint8_t *)&val16, 2);
 
     val16 = cpu_to_le16(tally_counters->TxUndrn);
-    pci_dma_write(d, tc_addr + 62,    (uint8_t *)&val16, 2);
+    rtl8139_dma_write(d, tc_addr + 62,    (uint8_t *)&val16, 2);
 }
 
 static void rtl8139_ChipCmd_write(RTL8139State *s, uint32_t val)
@@ -1810,7 +1832,7 @@ static int rtl8139_transmit_one(RTL8139State *s, int descriptor)
     DPRINTF("+++ transmit reading %d bytes from host memory at 0x%08x\n",
         txsize, s->TxAddr[descriptor]);
 
-    pci_dma_read(d, s->TxAddr[descriptor], txbuffer, txsize);
+    rtl8139_dma_read(d, s->TxAddr[descriptor], txbuffer, txsize);
 
     /* Mark descriptor as transferred */
     s->TxStatus[descriptor] |= TxHostOwns;
@@ -1886,13 +1908,13 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
 
     uint32_t val, txdw0,txdw1,txbufLO,txbufHI;
 
-    pci_dma_read(d, cplus_tx_ring_desc,    (uint8_t *)&val, 4);
+    rtl8139_dma_read(d, cplus_tx_ring_desc, (uint8_t *)&val, 4);
     txdw0 = le32_to_cpu(val);
-    pci_dma_read(d, cplus_tx_ring_desc+4,  (uint8_t *)&val, 4);
+    rtl8139_dma_read(d, cplus_tx_ring_desc + 4, (uint8_t *)&val, 4);
     txdw1 = le32_to_cpu(val);
-    pci_dma_read(d, cplus_tx_ring_desc+8,  (uint8_t *)&val, 4);
+    rtl8139_dma_read(d, cplus_tx_ring_desc + 8, (uint8_t *)&val, 4);
     txbufLO = le32_to_cpu(val);
-    pci_dma_read(d, cplus_tx_ring_desc+12, (uint8_t *)&val, 4);
+    rtl8139_dma_read(d, cplus_tx_ring_desc + 12, (uint8_t *)&val, 4);
     txbufHI = le32_to_cpu(val);
 
     DPRINTF("+++ C+ mode TX descriptor %d %08x %08x %08x %08x\n", descriptor,
@@ -1986,8 +2008,8 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
             DMA_ADDR_FMT" to offset %d\n", txsize, tx_addr,
             s->cplus_txbuffer_offset);
 
-    pci_dma_read(d, tx_addr,
-                 s->cplus_txbuffer + s->cplus_txbuffer_offset, txsize);
+    rtl8139_dma_read(d, tx_addr,
+                     s->cplus_txbuffer + s->cplus_txbuffer_offset, txsize);
     s->cplus_txbuffer_offset += txsize;
 
     /* seek to next Rx descriptor */
@@ -2017,7 +2039,7 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
 
     /* update ring data */
     val = cpu_to_le32(tx_status);
-    pci_dma_write(d, cplus_tx_ring_desc, (uint8_t *)&val, 4);
+    rtl8139_dma_write(d, cplus_tx_ring_desc, (uint8_t *)&val, 4);
 
     /* Now decide if descriptor being processed is holding the last segment of packet */
     if (txdw0 & CP_TX_LS)
-- 
2.43.0


