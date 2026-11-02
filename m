Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10739606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JdfcSPD2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCk-00034M-Bk; Mon, 02 Nov 2026 08:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCj-000347-HQ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:05 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCh-0002FD-0n
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:05 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so27309075e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626561; x=1794231361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Po3dnscUj8AfNHfuT7/o+lmP3AvNvS3B7xJtCxn8ozk=;
 b=JdfcSPD2azEDb/WLN+YAWxIyd6yEU/8Vhe3m9RbHcluP698bXJxquaIn9dGD21fwpi
 /swtDG23WpQ6Yufs7ZpNf4GTx/oBxEirteY3xKTaRXqNiyM5fPWR4fMzMPb3fCC8eZ7k
 j28xhD04W2yPvBZJBbnw5q69z9jWtSq8DnGwmZRmNWwBTNBX6EyNm6NHPOqL7fXJ3cyc
 03X9nbpL2VI3LGYjQpxSexlemsy1RK3G7/tWIJv5qK4SVyOVnbs9SuSTNyPRn+IgcGEu
 z9N28vNYi9ndnIfRxdl2JP7gzPHcZMGIvPSiQMMUsMMZk8Y2rcGNl0Nd8egdGyvdzbGy
 sYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626561; x=1794231361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Po3dnscUj8AfNHfuT7/o+lmP3AvNvS3B7xJtCxn8ozk=;
 b=icVvLo4SdL52sXEv3XcjpVNnPo1tgWt8rkdTAYxwW5dlA8uYA1zTH4je3Z9pSphAaP
 vaZDPENcYX8GvCYso8wUIJk99CzJw8bIR8fHFRFX5juO4hpKhOgILWbaO28aUWuKQmi8
 lVc4qeF5sWmEobJj+p8mLsBisgqQ5m2LT+3T5kf3s6JObuZTmRPwkECv32U6OltJF5JW
 viFoAJP+MxjBkv+Q0wBAbnDojh5VQL7NO9D5rEQRobT8uAHB9hW7dZOpebRGVhQ51VdL
 Lo1oEv8bfYSdkIHJQKUnyPFCUc0d93ESqX2LvSIYhs5MS85EB+C+X+PwA07hVz9X8q4n
 poAg==
X-Gm-Message-State: AFq9FYKZkDtWhxqE1S9Z4EL5kFnZrNPKkOVLKmqrLi19hT664n0N1o9B
 eyL40e2IYPU2EDMLbcUeLsZy9mEqms+yjyS3LiR5Ku7Ltz6EBdQuZCy9eTFqyWTBQW//GEIZehF
 w8uLxM1Y=
X-Gm-Gg: AYBFou3Ep8ZbbS6YZ2VZ7mF2/6m9Z6pxQkeUbWV2bQk3FgRgFe05LjsuRHA7bWT1ZFb
 VkQETI3ofC1VB1Gf6Eq+/nQxZu9Qdyxzo7ncM8vOcBA1JpcjsnW1M78sCtoFnae8eaFLL68F4Mm
 tZ3k4Mb3lnMlA3xItBYYqbWBAZUmcc4wBF2VDDpIrai4Cr8Exn1wrfXKHExbne18fvMAq4jEIbS
 Rt63wPK2277mIP4xhvPrnw4msDFqk0I7AmUr8D0tThGyIz9FvEGswdn5ERK3k+svY4ZIlq0PD38
 ubi01t8JZzWbrDU9iVBWTBWGbBIwg6aty7C29+MuRVD3RGFUbXr6IrN6pVrOyk1PlHfH+o9GO+G
 fTIM+CHQ8m1Cci5slquEXoWgMlwnhDyxousOXKzDTzzzoRrNpGij0mIgc9fsHFnwnWOuq4GzStJ
 DkY4Eaf/grMZtY7Jm4nwK1XwTuyqpwYyxdZSO2TpeIMfxpUrI7hVcfwk1v7K+P1amhA/0PSz9RF
 DsQkA06OO75BcvntjcZFu6T1Un5pZ7ctrE05hjDR6qVu4W8Wjts8xtU+dUr8dGmUnNWrEmd/vdO
 uGzlRAWbKWkH4PI5TWqWr+wiJXeaaymk1jExjjIRZpM4Us18kLlO0OuzJKwCaO3NNhW2i3FAkHF
 bBT3b8jMYlRYIY20nol5Duw3oh31ihgYaHW9DHQqnOfVZlgTGqONRkmk=
X-Received: by 2002:a05:600c:1907:b0:4a2:1a:a116 with SMTP id
 5b1f17b1804b1-4ac16fa15edmr233146925e9.0.1793626561434; 
 Mon, 02 Nov 2026 05:36:01 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/47] hw/net/bcm2838_genet: implement GENET register ops
Date: Mon,  2 Nov 2026 13:35:10 +0000
Message-ID: <20261102133547.1375701-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Sergey Kambalin <serg.oker@gmail.com>

Replace the stub MMIO read/write handlers with real dispatch over
the register offsets from the previous patches: SYS revision
control, INTRL0/1 status/mask registers, UMAC command/MAC-address/
MDIO-command registers, and TDMA/RDMA ring configuration, wired up
to the NIC's realize()/reset() and qdev NIC properties
(DEFINE_NIC_PROPERTIES) so the device gets a MAC address and peer
netdev from the command line.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo:
adapted to the current Property/class_init/Resettable APIs.

While carrying this forward, make these changes to the original code:

 - Access registers as a host-order uint32_t at their byte offset
   instead of memcpy()ing an arbitrary number of bytes in and out of
   the register block, which gives the wrong result on big-endian hosts
   for anything that is not a uint32_t. The HFB filter array becomes a
   uint32_t array too, so that every register in the block is one.
 - Do not call qemu_macaddr_default_if_unset() when the guest
   programs a MAC address: it is for realize() to pick a default when
   the user gave none. Only update the NIC info string.
 - Accept an access that ends exactly at the end of the register block.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-11-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/bcm2838_genet.h |  19 +++-
 hw/net/bcm2838_genet.c         | 196 +++++++++++++++++++++++++++++++--
 2 files changed, 204 insertions(+), 11 deletions(-)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index e0add41aab7..ee240213aa9 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -293,8 +293,7 @@ typedef struct {
 } BCM2838GenetRegsTdma;
 
 typedef struct {
-    uint8_t flt[BCM2838_GENET_HFB_FILTER_CNT * BCM2838_GENET_HFB_FILTER_SIZE
-        * sizeof(uint32_t)];
+    uint32_t flt[BCM2838_GENET_HFB_FILTER_CNT * BCM2838_GENET_HFB_FILTER_SIZE];
     uint32_t reserved_0x6000[1792];
     uint32_t ctrl;
     uint32_t flt_enable[2];
@@ -388,6 +387,8 @@ struct BCM2838GenetState {
     SysBusDevice parent_obj;
 
     /*< public >*/
+    NICState *nic;
+    NICConf nic_conf;
 
     MemoryRegion regs_mr;
     AddressSpace dma_as;
@@ -402,4 +403,18 @@ struct BCM2838GenetState {
     qemu_irq irq_prio;
 };
 
+/*
+ * Every field of BCM2838GenetRegs is a uint32_t and the MMIO ops only allow
+ * naturally aligned 4-byte accesses, so a register can be accessed as a
+ * host-order uint32_t at its byte offset; the memory API takes care of the
+ * guest/host byte order difference.
+ */
+static inline uint32_t *bcm2838_genet_reg(BCM2838GenetState *s, hwaddr offset)
+{
+    QEMU_BUILD_BUG_ON(sizeof(BCM2838GenetRegs) % sizeof(uint32_t) != 0);
+    assert(offset % sizeof(uint32_t) == 0);
+
+    return (uint32_t *)((uint8_t *)&s->regs + offset);
+}
+
 #endif /* BCM2838_GENET_H */
diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 091cd389546..1d443e06c12 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -236,25 +236,150 @@ REG16(GENET_PHY_EXP_SEL,           0)
 FIELD(GENET_PHY_EXP_SEL, REG_ID,   0, 8)
 FIELD(GENET_PHY_EXP_SEL, BLOCK_ID, 8, 8)
 
+static void bcm2838_genet_set_qemu_mac(BCM2838GenetState *s)
+{
+    const MACAddr *addr = &s->nic_conf.macaddr;
+
+    s->regs.umac.mac0 = FIELD_DP32(s->regs.umac.mac0, GENET_UMAC_MAC_0,
+                                   ADDR_0, addr->a[0]);
+    s->regs.umac.mac0 = FIELD_DP32(s->regs.umac.mac0, GENET_UMAC_MAC_0,
+                                   ADDR_1, addr->a[1]);
+    s->regs.umac.mac0 = FIELD_DP32(s->regs.umac.mac0, GENET_UMAC_MAC_0,
+                                   ADDR_2, addr->a[2]);
+    s->regs.umac.mac0 = FIELD_DP32(s->regs.umac.mac0, GENET_UMAC_MAC_0,
+                                   ADDR_3, addr->a[3]);
+    s->regs.umac.mac1 = FIELD_DP32(s->regs.umac.mac1, GENET_UMAC_MAC_1,
+                                   ADDR_4, addr->a[4]);
+    s->regs.umac.mac1 = FIELD_DP32(s->regs.umac.mac1, GENET_UMAC_MAC_1,
+                                   ADDR_5, addr->a[5]);
+}
+
+static void bcm2838_genet_set_irq_default(BCM2838GenetState *s)
+{
+    uint32_t intrl_0_status = s->regs.intrl0.stat;
+    uint32_t intrl_0_mask = s->regs.intrl0.mask_status;
+    int level = (intrl_0_status & ~intrl_0_mask) == 0 ? 0 : 1;
+
+    qemu_set_irq(s->irq_default, level);
+}
+
+static void bcm2838_genet_set_irq_prio(BCM2838GenetState *s)
+{
+    uint32_t intrl_1_status = s->regs.intrl1.stat;
+    uint32_t intrl_1_mask = s->regs.intrl1.mask_status;
+    int level = (intrl_1_status & ~intrl_1_mask) == 0 ? 0 : 1;
+
+    qemu_set_irq(s->irq_prio, level);
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
+    BCM2838GenetState *s = opaque;
 
-    qemu_log_mask(
-        LOG_GUEST_ERROR,
-        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
-        __func__, size, offset);
+    if (offset + size <= sizeof(s->regs)) {
+        value = *bcm2838_genet_reg(s, offset);
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
 
     trace_bcm2838_genet_read(size, offset, value);
     return value;
 }
 
 static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
-                                unsigned size) {
-    qemu_log_mask(
-        LOG_GUEST_ERROR,
-        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
-        __func__, size, offset);
+                                unsigned size)
+{
+    BCM2838GenetState *s = opaque;
+    MACAddr *mac = &s->nic_conf.macaddr;
+    NetClientState *ncs = qemu_get_queue(s->nic);
+
+    trace_bcm2838_genet_write(size, offset, value);
+
+    if (offset + size > sizeof(s->regs)) {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+        return;
+    }
+
+    switch (offset) {
+    case BCM2838_GENET_INTRL0_SET:
+        s->regs.intrl0.stat |= value;
+        break;
+    case BCM2838_GENET_INTRL0_CLEAR:
+        s->regs.intrl0.stat &= ~value;
+        break;
+    case BCM2838_GENET_INTRL0_MASK_SET:
+        s->regs.intrl0.mask_status |= value;
+        break;
+    case BCM2838_GENET_INTRL0_MASK_CLEAR:
+        s->regs.intrl0.mask_status &= ~value;
+        break;
+    case BCM2838_GENET_INTRL1_SET:
+        s->regs.intrl1.stat |= value;
+        break;
+    case BCM2838_GENET_INTRL1_CLEAR:
+        s->regs.intrl1.stat &= ~value;
+        break;
+    case BCM2838_GENET_INTRL1_MASK_SET:
+        s->regs.intrl1.mask_status |= value;
+        break;
+    case BCM2838_GENET_INTRL1_MASK_CLEAR:
+        s->regs.intrl1.mask_status &= ~value;
+        break;
+    case BCM2838_GENET_UMAC_CMD:
+        /* Complete SW reset as soon as it has been requested */
+        if (FIELD_EX32(value, GENET_UMAC_CMD, SW_RESET) == 1) {
+            device_cold_reset(DEVICE(s));
+            value = FIELD_DP32(value, GENET_UMAC_CMD, SW_RESET, 0);
+        }
+        break;
+    /*
+     * TODO: before changing MAC address we'd better inform QEMU
+     * network subsystem about freeing previously used one, but
+     * qemu_macaddr_set_free function isn't accessible for us (marked
+     * as static in net/net.c), see also https://lists.nongnu.org/
+     * archive/html/qemu-devel/2022-07/msg02123.html
+     */
+    case BCM2838_GENET_UMAC_MAC0:
+        mac->a[0] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_0);
+        mac->a[1] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_1);
+        mac->a[2] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_2);
+        mac->a[3] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_3);
+        qemu_format_nic_info_str(ncs, mac->a);
+        trace_bcm2838_genet_mac_address(ncs->info_str);
+        break;
+    case BCM2838_GENET_UMAC_MAC1:
+        mac->a[4] = FIELD_EX32(value, GENET_UMAC_MAC_1, ADDR_4);
+        mac->a[5] = FIELD_EX32(value, GENET_UMAC_MAC_1, ADDR_5);
+        qemu_format_nic_info_str(ncs, mac->a);
+        trace_bcm2838_genet_mac_address(ncs->info_str);
+        break;
+    case BCM2838_GENET_RDMA_CTRL:
+        s->regs.rdma.status = (~value) & GENET_DMA_ENABLE_MASK;
+        break;
+    case BCM2838_GENET_UMAC_MDIO_CMD:
+    case BCM2838_GENET_TDMA_REGS
+        ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
+        qemu_log_mask(LOG_UNIMP,
+            "UMAC MDIO and TDMA aren't implemented yet");
+        break;
+    default:
+        break;
+    }
+
+    *bcm2838_genet_reg(s, offset) = value;
+    if (offset == BCM2838_GENET_RDMA_CTRL &&
+        FIELD_EX32(value, GENET_DMA_CTRL, EN)) {
+        qemu_flush_queued_packets(ncs);
+    }
+    bcm2838_genet_set_irq_default(s);
+    bcm2838_genet_set_irq_prio(s);
 }
 
 static const MemoryRegionOps bcm2838_genet_ops = {
@@ -265,9 +390,14 @@ static const MemoryRegionOps bcm2838_genet_ops = {
     .valid = {.min_access_size = 4, .max_access_size = 4},
 };
 
+static NetClientInfo bcm2838_genet_client_info = {
+    .type = NET_CLIENT_DRIVER_NIC,
+    .size = sizeof(NICState),
+};
 
 static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
 {
+    NetClientState *ncs;
     BCM2838GenetState *s = BCM2838_GENET(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
@@ -275,10 +405,46 @@ static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->regs_mr, OBJECT(s), &bcm2838_genet_ops, s,
                           "bcm2838_genet_regs", sizeof(s->regs));
     sysbus_init_mmio(sbd, &s->regs_mr);
+
+    /* QEMU-managed NIC (host network back-end connection) */
+    qemu_macaddr_default_if_unset(&s->nic_conf.macaddr);
+    s->nic = qemu_new_nic(&bcm2838_genet_client_info, &s->nic_conf,
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
+    bcm2838_genet_set_qemu_mac(s);
+    ncs = qemu_get_queue(s->nic);
+    qemu_format_nic_info_str(ncs, s->nic_conf.macaddr.a);
+    trace_bcm2838_genet_mac_address(ncs->info_str);
+
+    /* Interrupts */
+    sysbus_init_irq(sbd, &s->irq_default);
+    sysbus_init_irq(sbd, &s->irq_prio);
+
+    /* DMA space */
+    address_space_init(&s->dma_as, get_system_memory(), "bcm2838_genet_dma");
 }
 
 static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
 {
+    memset(&s->phy_regs, 0x00, sizeof(s->phy_regs));
+    memset(&s->phy_shd_regs, 0x00, sizeof(s->phy_shd_regs));
+    memset(&s->phy_aux_ctl_shd_regs, 0x00, sizeof(s->phy_aux_ctl_shd_regs));
+
+    /* All values below were taken from real HW trace and logs */
+    s->phy_regs.bmcr = 0x1140;
+    s->phy_regs.bmsr = 0x7949;
+    s->phy_regs.sid1 = 0x600D;
+    s->phy_regs.sid2 = 0x84A2;
+    s->phy_regs.advertise = 0x01E1;
+    s->phy_regs.ctrl1000 = 0x0200;
+    s->phy_regs.estatus = 0x3000;
+
+    s->phy_shd_regs.clk_ctl = 0x0200;
+    s->phy_shd_regs.scr3 = 0x001F;
+    s->phy_shd_regs.apd = 0x0001;
+
+    s->phy_aux_ctl_shd_regs.regs[BCM2838_GENET_PHY_AUX_CTL_MISC] = 0x1E;
+
     trace_bcm2838_genet_phy_reset("done");
 }
 
@@ -288,11 +454,22 @@ static void bcm2838_genet_reset(Object *obj, ResetType type)
 
     memset(&s->regs, 0x00, sizeof(s->regs));
 
+    s->regs.sys.rev_ctrl = FIELD_DP32(s->regs.sys.rev_ctrl, GENET_SYS_REV_CTRL,
+                                      MAJOR_REV, BCM2838_GENET_REV_MAJOR);
+    s->regs.sys.rev_ctrl = FIELD_DP32(s->regs.sys.rev_ctrl, GENET_SYS_REV_CTRL,
+                                      MINOR_REV, BCM2838_GENET_REV_MINOR);
+    s->regs.rdma.status = GENET_DMA_ENABLE_MASK;
+    s->regs.tdma.status = GENET_DMA_ENABLE_MASK;
+
     trace_bcm2838_genet_reset("done");
 
     bcm2838_genet_phy_reset(s);
 }
 
+static const Property genet_properties[] = {
+    DEFINE_NIC_PROPERTIES(BCM2838GenetState, nic_conf),
+};
+
 static void bcm2838_genet_class_init(ObjectClass *class, const void *data)
 {
     static ResettablePhases unused_parent_phases;
@@ -302,6 +479,7 @@ static void bcm2838_genet_class_init(ObjectClass *class, const void *data)
     dc->realize = bcm2838_genet_realize;
     resettable_class_set_parent_phases(rc, NULL, bcm2838_genet_reset, NULL,
                                        &unused_parent_phases);
+    device_class_set_props(dc, genet_properties);
 }
 
 static const TypeInfo bcm2838_genet_info = {
-- 
2.43.0


