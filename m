Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465B606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I3Vgnq3D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiDa-0008HM-MH; Tue, 27 Oct 2026 10:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCg-0007KI-DU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:31:13 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCc-0005BH-RF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:31:06 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-93f1ca4132bso355895385a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111460; x=1793716260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KaDYX6fUoSuXHMfCkZJ0H7oVrcBnnvAX6Tuwwu+vU8Q=;
 b=I3Vgnq3Dil5D4WX+zObWIiwPy6GsVwXJWcI22mEjDDGO2JYpIdKlh6d+UB1x5v8yyO
 2Gv0vKppZaYfjpYW5l53/srpVJKRSNFfvpCgvO7l//G6Y+ezK87myD7eUUvGOOhbIaZy
 FT5158P4lGwt/whLL7OBngXCKkVE/q4kygPz+PjgG/+dabCROAqWXN5RUQtoLjitQz+M
 guFqZVKR19yrbmtJdkU3k0CjjGZecTRRG9hg7XYaz+hmvrurrkd/pqrk/eTVVq6c1t8J
 H5ODdMMBFR+bB5Y/u4bJFZ5KgXkRVC0W/iS9lzR3pAagj1ZrtxxqnD9Jq/0uMWGbE3y5
 IJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111460; x=1793716260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KaDYX6fUoSuXHMfCkZJ0H7oVrcBnnvAX6Tuwwu+vU8Q=;
 b=dk4GUXukEiaTzsEss+y/lTY+2Td/juT8OCAdjyAJt3SdqSpTHlOsUWKL5gfdzBZAOV
 qvyDpIxm9WyiqtLsFhMgiRBja8VwLWshtm367U39V8AZ/xLCXXlQmFdwIM3sU4Z6semh
 qMqBVL4JaUNUz+pHbjhQB4YqEgkJ2MHcAnM0o9HUzQZAO+4AeCnXiQS3hDT1B5qmSVhh
 cg/HS7CoGYuCpbM5SH+cjUGZ4lJH51OoeQS3zAi8hM40OyfuF+kNTKIm3FWQtfRMH3Bl
 MIX7AHVYJXtYM9HEww27fE2zK8ool5C9xEh9BVRfmAzfSIoYPKrwL7MtKymEumGo2Wox
 nWvg==
X-Gm-Message-State: AFq9FYK7lgsrzSizBz0mLPoWR6DtFPMpAp28nzrpayiWKFzBw+OxFldY
 oRb9Oj1NOFKFMjbadyimwdOn4YD05lnL018FIqlUVEZ4rL17AmV9OoLXvys3lfbG
X-Gm-Gg: AYBFou1Iq1pQBw4CkFH4z+Ygc2eaFUoj9GhVfSr6XvR0HEWwnJ955iGXL7UhERFN67D
 RHmiRafedUDvhzO76xS8/3W5rV2JCW4+M9Nr0z8vwrkFmDafs5w+i6EIHGUtCMs/QOhe0yopPVC
 9HKVUbu+o3b26NTwFCAP6jLv+uEQddPs0GtoZBBUF1sItNPN5WVQpJMuNOTvXo2MPzQjgGuM3Ep
 14AbjOizSls3HgClinGlgyNDTKBkZgkaAb2Nu4RzbecRg6vqIEPDMFM8kJfmVwhctiG8WS4iAJK
 tPuKkcO3G0C+bbC0L9zkYUETR4ju9NnTG6x6QM06j5K8GjRN2Zy0h3js11zt4iCAvltBZzWuMAP
 Ki/66vts9qG6kAW1m8qHVezuBL6S6m0pII5XwzF4esriwFQqJBqesfIa+VmYOj5WJhJb5Fp031E
 jLBn8iTvLB0YFGmg6qnk3jNcCYrVb89SD7WeV8U+bWHJBRJuvvogV98VDalAGJtnifHHaAugs00
 VGej7tLDhSLmaMAO1AJdPycQ/1pi0xG06osFldifwSmENFhe/gY8HqDzE8cagQQCnJxzJ+CgzDm
 4kCrWl85nCDoUzdMsb1SjvkwwogSxx0PYHc69L5OW1lzJUhdVJk=
X-Received: by 2002:a05:620a:27d6:b0:93f:57a3:71ab with SMTP id
 af79cd13be357-940ef93d248mr1394526885a.32.1793111460300; 
 Tue, 27 Oct 2026 07:31:00 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:9872:3600:589:5f3a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0a78c06sm986400885a.35.2026.10.27.07.30.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 07:30:59 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v6 13/17] hw/net/bcm2838_genet: implement GENET RX path
Date: Tue, 27 Oct 2026 10:30:32 -0400
Message-ID: <20261027143036.44973-14-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027143036.44973-1-marcelomanzo@gmail.com>
References: <20261027143036.44973-1-marcelomanzo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x735.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 - Refresh the link state once a BMCR autonegotiation restart has been
   handled by the MDIO code (moved here from the MDIO patch, where the
   function it calls does not exist yet).
 - Validate the guest-programmed descriptor indexes against the size
   of the descriptor array, and limit the DMA write to the size of our
   packet buffer, so that a guest-controlled register can't make us
   access memory outside them.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/bcm2838_genet.c         | 289 +++++++++++++++++++++++++++++++++
 include/hw/net/bcm2838_genet.h |   1 +
 2 files changed, 290 insertions(+)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 2e6461d6ba..840a1bc72b 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -20,6 +20,8 @@
 #include "hw/net/bcm2838_genet.h"
 #include "trace.h"
 
+static void bcm2838_genet_phy_update_link(BCM2838GenetState *s);
+
 /* GENET layouts */
 REG32(GENET_SYS_REV_CTRL,              0)
 FIELD(GENET_SYS_REV_CTRL, GPHY_REV,    0, 16)
@@ -402,6 +404,9 @@ static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
                     }
                 }
                 *phy_reg = phy_reg_data;
+                if (phy_reg_id == BCM2838_GENET_PHY_BMCR && anrestart == 1) {
+                    bcm2838_genet_phy_update_link(s);
+                }
             }
         }
     }
@@ -585,6 +590,24 @@ static void bcm2838_genet_tdma_prod_index_write(BCM2838GenetState *s,
     }
 }
 
+static bool bcm2838_genet_rdma_ring_active(BCM2838GenetState *s,
+                                           unsigned int ring_index)
+{
+    uint32_t ring_mask = 1 << ring_index;
+
+    bool dma_en = FIELD_EX32(s->regs.rdma.ctrl, GENET_DMA_CTRL, EN);
+    bool ring_en = FIELD_EX32(s->regs.rdma.ring_cfg, GENET_DMA_RING_CFG, EN)
+                   & ring_mask;
+    bool ring_buf_en = FIELD_EX32(s->regs.rdma.ctrl,
+                                  GENET_DMA_CTRL, RING_BUF_EN) & ring_mask;
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
@@ -765,9 +788,273 @@ static const MemoryRegionOps bcm2838_genet_ops = {
     .valid = {.min_access_size = 4, .max_access_size = 4},
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
+    const size_t desc_word_size =
+        sizeof(BCM2838GenetRdmaDesc) / sizeof(uint32_t);
+
+    ssize_t len = 0;
+    BCM2838GenetRegsRdma *rdma = &s->regs.rdma;
+    BCM2838GenetRdmaRing *ring = &rdma->rings[ring_idx];
+    hwaddr write_index =
+        bcm2838_genet_make_u64(ring->write_ptr_hi, ring->write_ptr)
+        / desc_word_size;
+    BCM2838GenetRdmaDesc *desc;
+
+    const hwaddr start_index =
+        bcm2838_genet_make_u64(ring->start_addr_hi, ring->start_addr)
+        / desc_word_size;
+    const hwaddr end_index =
+        bcm2838_genet_make_u64(ring->end_addr_hi, ring->end_addr)
+        / desc_word_size;
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
+            bcm2838_genet_make_u64(desc->address_hi, desc->address_lo);
+        MemTxResult mem_tx_result = MEMTX_OK;
+        const size_t frame_off = sizeof(BCM2838GenetXmitStatus) + 2;
+        uint8_t *frame_buf = dma_buf + frame_off;
+
+        bool crc_fwd = FIELD_EX32(s->regs.umac.cmd, GENET_UMAC_CMD, CRC_FWD);
+        size_t buflength;
+        uint32_t prod_index;
+
+        if (l > ring->ring_buf_size) {
+            l = ring->ring_buf_size;
+        }
+        /* Never copy more than fits in rx_packet after the status block */
+        if (l > sizeof(s->rx_packet) - frame_off) {
+            l = sizeof(s->rx_packet) - frame_off;
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
+         * We don't implement the hardware's partial RX checksum: report 0 and
+         * rely on the guest verifying checksums in software.
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
+        if (++write_index > end_index) {
+            write_index = start_index;
+        }
+        if (write_index >= BCM2838_GENET_DMA_DESC_CNT) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid RX descriptor index %" PRIu64
+                          " (exceeds %u)\n", __func__, (uint64_t)write_index,
+                          BCM2838_GENET_DMA_DESC_CNT - 1);
+            break;
+        }
+        desc = &rdma->descs[write_index];
+        ring->write_ptr = write_index * desc_word_size;
+        ring->write_ptr_hi = ((hwaddr)write_index * desc_word_size) >> 32;
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
+    bool qemu_link_down = qemu_get_queue(s->nic)->link_down;
+
+    bool lstatus = FIELD_EX32(s->phy_regs.bmsr, GENET_PHY_BMSR, LSTATUS);
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
     .size = sizeof(NICState),
+    .receive = bcm2838_genet_receive,
+    .link_status_changed = bcm2838_genet_set_link,
 };
 
 static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
@@ -821,6 +1108,8 @@ static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
     s->phy_aux_ctl_shd_regs.regs[BCM2838_GENET_PHY_AUX_CTL_MISC] = 0x1E;
 
     trace_bcm2838_genet_phy_reset("done");
+
+    bcm2838_genet_phy_update_link(s);
 }
 
 static void bcm2838_genet_reset(Object *obj, ResetType type)
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index f6a3cb7eef..87a59941ec 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -419,6 +419,7 @@ struct BCM2838GenetState {
     qemu_irq irq_prio;
 
     uint8_t tx_packet[MAX_FRAME_SIZE];
+    uint8_t rx_packet[MAX_FRAME_SIZE];
 };
 
 /*
-- 
2.55.0


