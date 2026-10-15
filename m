Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726BECCA46B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvi-0001f1-Ce; Thu, 15 Oct 2026 14:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPve-0001Xi-7s
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:47 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvb-0001WV-2s
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:45 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-53394bffe0fso3043091cf.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087902; x=1792692702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P/o56MTWuugNz/tLtnPcZc7Z3S25IuYYK+xikR/wHBQ=;
 b=MiRCvjPbAak+ZjEHIw4vMTFFStE4p8tatC+bxZFuNbboHW6QvF66M3Y7xGkgKlKW2m
 HdgUzOUI4OBAOFTvTjRVfPmwHmNzndXjf8ft7aEXtrIYhOzNqpUIqQUp11WmVkvS+NrQ
 xisZ9aSZlx/uea7WfUs4W8+mHCcN79bjDzM6MK45OAjDhOFeDXYRp2pmjIXFLXxZC1WI
 5g92WxyTKMiaLrdqZ30KAeIXLISlzQsI9BSM0aBsjA2A8jW/S89TLZpQlKmKE+cZqmDw
 eJuBp1JcGUCPO2MMEDEVdIX/Fufx9Ys68S1YnHFvImrwalFg4MXh7pAm8oogNu8oirnp
 PB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087902; x=1792692702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P/o56MTWuugNz/tLtnPcZc7Z3S25IuYYK+xikR/wHBQ=;
 b=VJNc+JGAGcq2OmaTO+2J6iQpdijbR6upPbG3PBowQJb0Us11XVsfMkgGdVGkhdIpzp
 SFXcHN9dJkD8VM+8JUlJt85AWfGdkBBehbZWR4XWW+8ODzgQytf1omqEsCmuKkauQxQF
 0yYvSQ5tDtnXO+pOwTTQHbN/U2aEStJSEVTI7PfW+fYGBn1kCcdwCxpfecj1zBS9tQAj
 1RE82gqR3tsGoCv/7gtjNaHwi9LG5gyUbcxgGyQDRCux0XEucS7IYlukRd+C/54z2tbt
 rRVTrsJPFm4L4mVXga35hnMg4H6bgzd82c6Qcx4YTBAvCQYsBUXzc5xnbPs8SKNGClm0
 ygvw==
X-Gm-Message-State: AFq9FYKKnzk8deEAyDmhO+WCQtoc8qKyspkWDXCtDsIotHczvbaYGiVZ
 WG+WI7R+6MJXYT51j5pLaNeSL5ajuvHPADdVzIXLEQLEZmcoLQ1yDFUj6C5cKkfn
X-Gm-Gg: AYBFou3BxtUBm4XiFUCd4odUhvz74cxc62x+KkTr9nCEHGGs9CHv8bECTtNAcLKfGBj
 ftf8boK6qg48Wa1YcfR5AXxKZ/ss8Yy3Z6Rdw36pHU3lkcFvQ4BKHF9qVG+ZidI0eB19jKD3QIM
 540uANjyCg0rOGQV7ffuXE/5Ji34MaFXY7IcoB+SRAQX9gWXN6zmiN1nGfJc5dEu4kqBj6UzUq5
 nVcspjg+IVwg0tKl+Fbmy43e/T/I7nYeY2GIzOYCSaO5f/5419C1WNpHK/O4Vl1pj/m30dAwfzC
 fNYNvqf96QLVKEmBjusnddk8zcu5J2NIHW+1d2GpOU3D6UxeMlOaAtuX77kUypQiRgiMk1sGVSd
 vBl9wUK3FyZYJPHOIIIeYAmwLJ3wNVIHRZ7mmIhGBXinFt6g6kmPWAuYVWTUfjBzbzyT7vqumCs
 S+tc9KVHORTPT0xIjZAud+Aat+i2P6Lj2MJpgpnHll2I248FM/EIH3Y+8aIphJZ12mg+m3AOLuz
 qBFGWIoSVp9qMSiS37K+OF01I8hScSS7MaiIotWJdLHcTHtdbvnRUohb9Lf6OU+sQwJag==
X-Received: by 2002:ac8:5f07:0:b0:535:70b3:fa09 with SMTP id
 d75a77b69052e-53627304b9bmr14419171cf.37.1792087901757; 
 Thu, 15 Oct 2026 11:11:41 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127efe4asm32130611cf.19.2026.10.15.11.11.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:41 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v3 13/16] hw/net/bcm2838_genet: implement GENET RX path
Date: Thu, 15 Oct 2026 14:11:18 -0400
Message-ID: <20261015181122.60608-14-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181122.60608-1-marcelomanzo@gmail.com>
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Sergey Kambalin <serg.oker@gmail.com>

Implement the receive DMA ring handling: qemu_can_receive()/
receive() callbacks for the NIC's netdev peer, copying incoming
frame data into descriptor buffers on the active RX ring,
classifying broadcast/multicast, and raising the RXDMA_MBDONE
interrupt as descriptors complete.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

While carrying this forward, make these changes to the original code:

 - Report no hardware-computed RX checksum (rx_csum = 0). The original
   stored the IPv4 header checksum in host byte order, but the guest's
   CHECKSUM_COMPLETE path expects a running checksum over the L4
   payload, which made the guest reject otherwise-valid inbound
   packets ("hw csum failure" in bcmgenet_rx_poll()) and broke
   DHCP/connectivity intermittently. With 0 the guest verifies
   checksums in software instead.
 - Fill in the per-packet status block with stl_le_p() rather than by
   casting the packet buffer to a C struct, which is undefined
   behaviour for a misaligned buffer and wrong on big-endian hosts.
 - Validate the guest-programmed descriptor indexes against the size
   of the descriptor array, and limit the DMA write to the size of our
   packet buffer, so that a guest-controlled register can't make us
   access memory outside them.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c         | 288 ++++++++++++++++++++++++++++++++-
 include/hw/net/bcm2838_genet.h |   1 +
 2 files changed, 288 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 7eba0edbb6..a0e8dd4751 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -527,6 +527,25 @@ static bool bcm2838_genet_tdma_ring_active(BCM2838GenetState *s,
     return active;
 }
 
+static bool bcm2838_genet_rdma_ring_active(BCM2838GenetState *s,
+                                           unsigned int ring_index)
+{
+    uint32_t ring_mask = 1 << ring_index;
+
+    bool dma_en = FIELD_EX32(s->regs.rdma.ctrl, GENET_DMA_CTRL, EN) != 0;
+    bool ring_en = (FIELD_EX32(s->regs.rdma.ring_cfg, GENET_DMA_RING_CFG, EN)
+                    & ring_mask) != 0;
+    bool ring_buf_en = (FIELD_EX32(s->regs.rdma.ctrl,
+                                   GENET_DMA_CTRL, RING_BUF_EN)
+                        & ring_mask) != 0;
+    bool active = dma_en && ring_en && ring_buf_en;
+
+    trace_bcm2838_genet_rx_dma_ring_active(ring_index,
+                                           active ? "active" : "halted");
+
+    return active;
+}
+
 static void bcm2838_genet_tdma(BCM2838GenetState *s, hwaddr offset,
                                uint64_t value)
 {
@@ -742,9 +761,274 @@ static const MemoryRegionOps bcm2838_genet_ops = {
     .valid = {.min_access_size = 4},
 };
 
+static int32_t bcm2838_genet_filter(BCM2838GenetState *s, const void *buf,
+                                    size_t size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "Packet filtration with HFB isn't implemented yet");
+    return -1;
+}
+
+static int32_t bcm2838_genet_filter2ring(BCM2838GenetState *s,
+                                         uint32_t filter_idx)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "Packet filtration with HFB isn't implemented yet");
+    return -1;
+}
+
+static bool is_packet_broadcast(const uint8_t *buf, size_t size)
+{
+    static const uint8_t bcst_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+
+    if (size < sizeof(bcst_addr)) {
+        return false;
+    }
+
+    return !memcmp(buf, bcst_addr, sizeof(bcst_addr));
+}
+
+static bool is_packet_multicast(const uint8_t *buf, size_t size)
+{
+    return !!(buf[0] & 0x01);
+}
+
+static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
+                                  const void *buf, size_t size)
+{
+    const size_t DESC_WORD_SIZE =
+        sizeof(BCM2838GenetRdmaDesc) / sizeof(uint32_t);
+
+    ssize_t len = 0;
+    BCM2838GenetRegsRdma *rdma = &s->regs.rdma;
+    BCM2838GenetRdmaRing *ring = &rdma->rings[ring_idx];
+    hwaddr write_index =
+        (ring->write_ptr + ((hwaddr)ring->write_ptr_hi << 32)) / DESC_WORD_SIZE;
+    BCM2838GenetRdmaDesc *desc;
+
+    const hwaddr START_INDEX =
+        (ring->start_addr + ((hwaddr)ring->start_addr_hi << 32))
+            / DESC_WORD_SIZE;
+    const hwaddr END_INDEX =
+        (ring->end_addr + ((hwaddr)ring->end_addr_hi << 32)) / DESC_WORD_SIZE;
+
+    if (!bcm2838_genet_rdma_ring_active(s, ring_idx)) {
+        return -1;
+    }
+
+    if (write_index >= BCM2838_GENET_DMA_DESC_CNT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid RX descriptor index %" PRIu64
+                      " (exceeds %u)\n", __func__, (uint64_t)write_index,
+                      BCM2838_GENET_DMA_DESC_CNT - 1);
+        return -1;
+    }
+    desc = &rdma->descs[write_index];
+
+    desc->length_status = FIELD_DP32(desc->length_status,
+                                     GENET_RDMA_LENGTH_STATUS, SOP, 1);
+
+    while (len < size) {
+        size_t l = size - len;
+        size_t buf_size = MIN(ring->ring_buf_size & 0xffff,
+                              sizeof(s->rx_packet));
+        uint8_t *dma_buf = s->rx_packet;
+        hwaddr dma_buf_addr =
+            desc->address_lo + ((hwaddr)desc->address_hi << 32);
+        MemTxResult mem_tx_result = MEMTX_OK;
+        uint8_t *frame_buf = dma_buf + sizeof(BCM2838GenetXmitStatus) + 2;
+
+        bool crc_fwd = FIELD_EX32(s->regs.umac.cmd, GENET_UMAC_CMD, CRC_FWD);
+        size_t buflength;
+        uint32_t prod_index;
+
+        if (l > ring->ring_buf_size) {
+            l = ring->ring_buf_size;
+        }
+
+        memcpy(frame_buf, buf + len, l);
+
+        len += l;
+
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         EOP, !!(len >= size));
+
+        buflength = l + sizeof(BCM2838GenetXmitStatus) + 2;
+        if (crc_fwd) {
+            buflength += 4;
+        }
+
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         BUFLENGTH, buflength);
+
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         BROADCAST,
+                                         !!is_packet_broadcast(frame_buf, l));
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         MULTICAST,
+                                         !!is_packet_multicast(frame_buf, l));
+
+        /*
+         * Report no hardware-computed checksum. The IP header's own
+         * checksum was previously (incorrectly) stored here, but the
+         * guest's CHECKSUM_COMPLETE path expects a running checksum over
+         * the L4 payload, not the L3 header checksum -- and it was stored
+         * in host byte order besides. That mismatch was causing the guest
+         * to reject otherwise-valid inbound packets ("hw csum failure" in
+         * dmesg, tied to bcmgenet_rx_poll), breaking DHCP/connectivity
+         * intermittently. Leaving this at 0 makes the guest fall back to
+         * verifying checksums itself in software, which succeeds since the
+         * packet data itself is intact.
+         */
+        stl_le_p(dma_buf + offsetof(BCM2838GenetXmitStatus, rx_csum), 0);
+        stl_le_p(dma_buf + offsetof(BCM2838GenetXmitStatus, length_status),
+                 desc->length_status);
+
+        mem_tx_result = address_space_write(&s->dma_as, dma_buf_addr,
+                                            MEMTXATTRS_UNSPECIFIED,
+                                            dma_buf, buf_size);
+        if (mem_tx_result != MEMTX_OK) {
+            desc->length_status = FIELD_DP32(desc->length_status,
+                                             GENET_RDMA_LENGTH_STATUS,
+                                             RXERR, 1);
+        }
+
+        if (FIELD_EX32(desc->length_status,
+                       GENET_RDMA_LENGTH_STATUS, RXERR) != 0) {
+            break;
+        }
+
+        prod_index = FIELD_EX32(ring->prod_index, GENET_DMA_PROD_INDEX, INDEX);
+        ring->prod_index = FIELD_DP32(ring->prod_index,
+                                      GENET_DMA_PROD_INDEX,
+                                      INDEX, ++prod_index);
+        if (++write_index > END_INDEX) {
+            write_index = START_INDEX;
+        }
+        if (write_index >= BCM2838_GENET_DMA_DESC_CNT) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid RX descriptor index %" PRIu64
+                          " (exceeds %u)\n", __func__, (uint64_t)write_index,
+                          BCM2838_GENET_DMA_DESC_CNT - 1);
+            break;
+        }
+        desc = &rdma->descs[write_index];
+        ring->write_ptr = write_index * DESC_WORD_SIZE;
+        ring->write_ptr_hi = ((hwaddr)write_index * DESC_WORD_SIZE) >> 32;
+    }
+
+    if (ring_idx == BCM2838_GENET_DMA_RING_DEFAULT) {
+        s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                         GENET_INTRL_0, RXDMA_MBDONE, 1);
+    } else {
+        uint32_t rx_intrs =
+            FIELD_EX32(s->regs.intrl1.stat, GENET_INTRL_1, RX_INTRS);
+        rx_intrs |= 1 << ring_idx;
+
+        s->regs.intrl1.stat = FIELD_DP32(s->regs.intrl1.stat,
+                                         GENET_INTRL_1, RX_INTRS, rx_intrs);
+    }
+
+    return len;
+}
+
+static ssize_t bcm2838_genet_receive(NetClientState *nc, const uint8_t *buf,
+                                     size_t size)
+{
+    BCM2838GenetState *s = (BCM2838GenetState *)qemu_get_nic_opaque(nc);
+    ssize_t bytes_received = -1;
+    int32_t filter_index = -1;
+    int32_t ring_index = -1;
+
+    if (FIELD_EX32(s->regs.rdma.ctrl, GENET_DMA_CTRL, EN) != 0) {
+        filter_index = bcm2838_genet_filter(s, buf, size);
+
+        if (filter_index >= 0) {
+            ring_index = bcm2838_genet_filter2ring(s, filter_index);
+        } else {
+            ring_index = BCM2838_GENET_DMA_RING_CNT - 1;
+            if (!bcm2838_genet_rdma_ring_active(s, ring_index)) {
+                for (ring_index = 0;
+                     ring_index < BCM2838_GENET_DMA_RING_CNT - 1;
+                     ring_index++) {
+                    if (bcm2838_genet_rdma_ring_active(s, ring_index)) {
+                        break;
+                    }
+                }
+            }
+        }
+
+        if (size <= MAX_PACKET_SIZE) {
+            bytes_received = bcm2838_genet_rdma(s, ring_index, buf, size);
+        }
+    }
+
+    bcm2838_genet_set_irq_default(s);
+    bcm2838_genet_set_irq_prio(s);
+
+    return bytes_received;
+}
+
+static void bcm2838_genet_phy_update_link(BCM2838GenetState *s)
+{
+    bool qemu_link_down = qemu_get_queue(s->nic)->link_down != 0;
+
+    bool lstatus = FIELD_EX32(s->phy_regs.bmsr, GENET_PHY_BMSR, LSTATUS) != 0;
+
+    if (qemu_link_down && lstatus) {
+        trace_bcm2838_genet_phy_update_link("down");
+
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, ANEGCOMPLETE, 0);
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, LSTATUS, 0);
+        s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                         GENET_INTRL_0, LINK_DOWN, 1);
+    } else if (!qemu_link_down && !lstatus) {
+        trace_bcm2838_genet_phy_update_link("up");
+
+        /*
+         * Complete auto-negotiation (fixed link partner's abilities for now:
+         * 1Gbps with flow control)
+         */
+        s->phy_regs.stat1000 = FIELD_DP32(s->phy_regs.stat1000,
+                                          GENET_PHY_STAT_1000, HALF, 1);
+        s->phy_regs.stat1000 = FIELD_DP32(s->phy_regs.stat1000,
+                                          GENET_PHY_STAT_1000, FULL, 1);
+
+        s->phy_regs.lpa = FIELD_DP32(s->phy_regs.lpa,
+                                     GENET_PHY_LPA, PAUSE_CAP, 1);
+        s->phy_regs.lpa = FIELD_DP32(s->phy_regs.lpa,
+                                     GENET_PHY_LPA, PAUSE_ASYM, 1);
+        s->phy_regs.lpa = FIELD_DP32(s->phy_regs.lpa, GENET_PHY_LPA, LPACK, 1);
+
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, ANEGCOMPLETE, 1);
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, LSTATUS, 1);
+
+        s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                         GENET_INTRL_0, LINK_UP, 1);
+    }
+
+    bcm2838_genet_set_irq_default(s);
+}
+static void bcm2838_genet_set_link(NetClientState *nc)
+{
+    BCM2838GenetState *s = qemu_get_nic_opaque(nc);
+
+    bcm2838_genet_phy_update_link(s);
+}
+
 static NetClientInfo bcm2838_genet_client_info = {
     .type = NET_CLIENT_DRIVER_NIC,
-    .size = sizeof(NICState)
+    .size = sizeof(NICState),
+    .receive = bcm2838_genet_receive,
+    .link_status_changed = bcm2838_genet_set_link,
 };
 
 static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
@@ -798,6 +1082,8 @@ static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
     s->phy_aux_ctl_shd_regs.misc = 0x1E;
 
     trace_bcm2838_genet_phy_reset("done");
+
+    bcm2838_genet_phy_update_link(s);
 }
 
 static void bcm2838_genet_reset(Object *obj, ResetType type)
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index bad582fe0d..960042f6f4 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -422,6 +422,7 @@ struct BCM2838GenetState {
     qemu_irq irq_prio;
 
     uint8_t tx_packet[MAX_FRAME_SIZE];
+    uint8_t rx_packet[MAX_FRAME_SIZE];
 };
 
 #endif /* BCM2838_GENET_H */
-- 
2.55.0


