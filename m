Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA6606A32D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hX4ETx4w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqaJ-0005B3-3h; Tue, 24 Nov 2026 08:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqaA-00056c-74
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:15 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqa8-0007O0-3q
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:13 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so2911553f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526950; x=1796131750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=clQ6ZjUmB8+bHcpHqj8LWyFKCgkw91ddZzcsW3agfrQ=;
 b=hX4ETx4wmqgarC+/iyzhe94qgQECKvno8FyAZa7Drx8xLznp6seoZwypwmYD/HY//3
 aWibk3TaLq6N5uVE9sqeRWvcWWrc6m7QF4g9W0aRb//QtaPZ7tjLZN6nyxNzIm7xFx/X
 rNsPopJBq7LKzKM7L6Blyuahl6RnqjpAtDVa/SwHGgpwOpILPGvNk9idXTRFgoqEI+VG
 ncfjC0ExVm/RHhEpvGmrOmpJh1bYe46fBHm63Fg6QsEKJUzQI9c7L4sopYkEZgJsPPR5
 aEYEQNwAyG5T01pTBQ6+TIHdFaVk9eXRwG0zNSHsD5L7CH6JKpqdO2Lk/CSiSMXyYdQ9
 H1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526950; x=1796131750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=clQ6ZjUmB8+bHcpHqj8LWyFKCgkw91ddZzcsW3agfrQ=;
 b=HyFBGKaajflx5CV58yQ1nuT9bH7LaZKk6bNG/HpQZAJnC0qjALk5Hakjvw0qtg1/Bd
 HrVH95CCIBUTxwAhr4PszjoOH/vD3stQPJsVk47T1ViqpC2teSSe/BHTs30qhz0DZsw5
 loTEW3hBOf4hDAsy3HbowCfFqg8anQEVGUETRTtS8A5CgYNIn24svc7EFn9iN+QoFAon
 7XzcRzwuS6VP7yhCvDckPcUcNETFMTZa4H1zyI7ymGMPg58s4uBVS2T060zDshMpnJ82
 YGUvnv+T2FqRqaPIBFuH3qu21KmaRSsW4Eq9nmGPBWgKPS9RkuEw9PiPyPPZmwc16urG
 5aFA==
X-Gm-Message-State: APuU4Z8CdM373my0AX2jREN/yGM+EL4mb4cFxdC10aQbFkH18LkcV8Jx
 /XWU7xbujsk8za1oiIcBCSpvrXWoWwXj3jFH/0LclU8UfZN+umcXuR8diur47vaFEX65MJAfX8W
 8jeQa
X-Gm-Gg: AZFdTZeSVUGmAENKdhwMLqUqwd3JcPIo0iMtgtyYaRUX+pTknoqhMtJCzJ1nKViyiOR
 chZ5/JboToogcBdUTenqrNj2/0je3LnWzCMS+w5ZW8+hMBxFwWsRlzFaEPTdIvEIG0/sQeDC9sO
 ZfovyF6w5CuGrnnOgsy5k2446dSdZfsU4LPjm0IgpmzUrMn75ZHf/AlZ7u22RhzK4sdln2G0CM3
 t731HtnlPAc+W0vR1FhPvR8Vw1eQxYhELbDflQJHNBHWTuYmxASBK5PAX8lzGUNsJtQhtB1fwNu
 Tlc1btpEJ/thBaUhgPs70qXtxu27n4mouRM6ibDAHac9RN+SVm1EV1nmqGcGtTFkXMr23yu91/f
 QJFQYrVdJf2xhkal3XGivPXpIn9ic6LsgtCeaQRJ1Nv3j4Q4/fKzwTbkYSKoErLaI2VCmDbutUN
 U+KL06RjbmdUgs7dkGe0WaApFJmnSx8z7pQ+9QH/7gmpmXyUAlMGovZ0q+HI7mkcd4XJyPtgUG4
 lHXShwk2MgheAudQcBNtoLCSgr7H93Gh/AYXGlAX4HQPDTmkgl3EB8y1nHMjoq49/AdXWcG2VA7
 Sn96wrQ3FYQ1FR7UXquu43HZ9l4Z/7bdoc9Xi6O39SGLEdL27+maeGKE981vH+iac0381ai0L2C
 LX0fGhO3Ct+MXoVTeXvaj9TEz9vqNoaPRqw==
X-Received: by 2002:a05:6000:248a:b0:487:b50:101c with SMTP id
 ffacd0b85a97d-4abaa97702bmr27080197f8f.5.1795526950393; 
 Tue, 24 Nov 2026 05:29:10 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm29098031f8f.31.2026.11.24.05.29.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:29:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] hw/net/rtl8139: Limit DMA transfers to plain memory
Date: Tue, 24 Nov 2026 13:28:59 +0000
Message-ID: <20261124132904.138731-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132904.138731-1-peter.maydell@linaro.org>
References: <20261124132904.138731-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
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
Message-id: 20261113165015.1150646-1-peter.maydell@linaro.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/rtl8139.c | 98 +++++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 38 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 38bc16f312f..f3d1718921a 100644
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


