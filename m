Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACABCCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvh-0001eW-S5; Thu, 15 Oct 2026 14:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvZ-0001SY-3Q
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:41 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvW-0001VK-RR
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:40 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-5351748222cso15489311cf.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087897; x=1792692697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eMkjO5P6s6mfmGYkLd4iGMmWxOJ/NNhCDNBaZDU8zr4=;
 b=B+V6ey0jO4wufpqIxYlkmy+fwugwLf0g6hKPFGVASKQlsIPxfZP9K7A/F8J+sZ6MpX
 quK3Xc+ZKFYM2VX9emyIwGRURHwep13ZNL8S021kG4jwJn7EPnMjT8MmEU055OPnbeED
 1OfkRqorCcP4Hy8aclVSd3RYVJ3m0F4r6W4ldRazsAxqCnfNtkU7lDXK+6qF7g5QwrQ+
 HJf7yehbIm9cmolWaGUB/vpYFU0nuWp2f3XdMCxtpjLtG+Q1N/1YPOBc6fN7//D4FvY0
 mfP72U89zsjMFcPJiWfuTtesevq4AxgmQDD1cp50voCWdyPwnxCGEN1B4ZLRcXVAHh+0
 PLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087897; x=1792692697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eMkjO5P6s6mfmGYkLd4iGMmWxOJ/NNhCDNBaZDU8zr4=;
 b=AUm91lAUjWK3Z4Ld/fHhynPeXwc8dPdmltffjHn+VOKyTiOYqXjCl4WN9CnpLYSGRH
 QCNqM7I5QXNUC5aqBerAPKV7mye48NdzSdkQUBOPEvCTQtUHliKR5WBXRmvVURfBOC75
 SaHtQqyTxbx/FYnzoQ5Vej9ssks2gE7afiUDlAdO1v2tcGi+2HKdpOZ36LmDocoTbbI/
 C3kRuzgauIz2BiocQfNELeJhGATE7S41HRwOsRxjJpllBHQtzyjBt9eRY4izZxTODq7w
 vvOXJPuCbDU+N5w1clHKeiTCO1NDAwgC7d6W6P8v9TOlcs+yYaDrxWVSRvIdICP56I6Z
 esmg==
X-Gm-Message-State: AFq9FYLHbe45a8l1Hmau+9gxT+b1Le00dCCxQJYJt/39W2TDbMYI6KIc
 /O8u9/ofPolF4U4kNyovpNqZYL7akDf6x3WaUUW//47Pe4lq2J0nOa+6OljcgRKF
X-Gm-Gg: AYBFou1iADPKqwGlDEq7m1xChFaxUZ6GzubIcksa38KBjzJJ7H2aRoiPp2S4lgrU3cD
 lTr0SkVdQW1N1ZJQaVEzUs2+zD/KbtzYGZB8J+J8wdkKr0em6sdbjE88VSFW3jv0S7oBoZJwizM
 KU/OqbkbyF2Qt7dTti5jwBTVd4c6OH/ELMl06JJ2RLB/XpKWDuZVVQlSAL2Nh220nJ4XFYI3JDe
 Ky9gScGCUiM+zc58+rsriigXMTP5slbOy7koEUKUC5fEn1nPl5caHUBabJ3fvp0NORYuH1exaag
 0ALDrGUWzCInhZxfp24i0nldHch3bVueITI/RRaaz6RF7zK8rohKwypgW5DHedokrLYX3S6i1Ue
 cWlahSr6311uvO3qpNp2oFNRjT+PL+57AovksOisSq11gOI4YrRtyE2wec/HxX6iw7vWypvgTvA
 qRI51X4wzclj9lDut4Io0H1mGgcIng2Qfb9D2MLNU6P9K9wdG+/0C95nM5bUqOTmWakpnquicWa
 7VRXg4Qlkmab+ORZrRUVdG09a8GERyFLkqEBL6t0RWEdA2ClapFVp/aGk/lPvzX7w8Ksg==
X-Received: by 2002:ac8:610b:0:b0:535:c88:8f1 with SMTP id
 d75a77b69052e-5359fb28678mr289753111cf.41.1792087897409; 
 Thu, 15 Oct 2026 11:11:37 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127efe4asm32130611cf.19.2026.10.15.11.11.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:36 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v3 10/16] hw/net/bcm2838_genet: implement GENET register ops
Date: Thu, 15 Oct 2026 14:11:15 -0400
Message-ID: <20261015181122.60608-11-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181122.60608-1-marcelomanzo@gmail.com>
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x829.google.com
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
adapted to the current Property/class_init/Resettable APIs, with no
functional change to the register dispatch logic itself.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c         | 197 +++++++++++++++++++++++++++++++--
 include/hw/net/bcm2838_genet.h |   2 +
 2 files changed, 190 insertions(+), 9 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 2bc2a770b1..f3c5ca26c5 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -236,25 +236,151 @@ REG16(GENET_PHY_EXP_SEL,           0)
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
+    if (offset + size < sizeof(s->regs)) {
+        memcpy(&value, (uint8_t *)&s->regs + offset, size);
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
+    if (offset + size < sizeof(s->regs)) {
+        switch (offset) {
+        case BCM2838_GENET_INTRL0_SET:
+            s->regs.intrl0.stat |= value;
+            break;
+        case BCM2838_GENET_INTRL0_CLEAR:
+            s->regs.intrl0.stat &= ~value;
+            break;
+        case BCM2838_GENET_INTRL0_MASK_SET:
+            s->regs.intrl0.mask_status |= value;
+            break;
+        case BCM2838_GENET_INTRL0_MASK_CLEAR:
+            s->regs.intrl0.mask_status &= ~value;
+            break;
+        case BCM2838_GENET_INTRL1_SET:
+            s->regs.intrl1.stat |= value;
+            break;
+        case BCM2838_GENET_INTRL1_CLEAR:
+            s->regs.intrl1.stat &= ~value;
+            break;
+        case BCM2838_GENET_INTRL1_MASK_SET:
+            s->regs.intrl1.mask_status |= value;
+            break;
+        case BCM2838_GENET_INTRL1_MASK_CLEAR:
+            s->regs.intrl1.mask_status &= ~value;
+            break;
+        case BCM2838_GENET_UMAC_CMD:
+            /* Complete SW reset as soon as it has been requested */
+            if (FIELD_EX32(value, GENET_UMAC_CMD, SW_RESET) == 1) {
+                device_cold_reset(DEVICE(s));
+                value = FIELD_DP32(value, GENET_UMAC_CMD, SW_RESET, 0);
+            }
+            break;
+        /*
+         * TODO: before changing MAC address we'd better inform QEMU
+         * network subsystem about freeing previously used one, but
+         * qemu_macaddr_set_free function isn't accessible for us (marked
+         * as static in net/net.c), see also https://lists.nongnu.org/
+         * archive/html/qemu-devel/2022-07/msg02123.html
+         */
+        case BCM2838_GENET_UMAC_MAC0:
+            mac->a[0] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_0);
+            mac->a[1] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_1);
+            mac->a[2] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_2);
+            mac->a[3] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_3);
+            qemu_macaddr_default_if_unset(mac);
+            qemu_format_nic_info_str(ncs, mac->a);
+            trace_bcm2838_genet_mac_address(ncs->info_str);
+            break;
+        case BCM2838_GENET_UMAC_MAC1:
+            mac->a[4] = FIELD_EX32(value, GENET_UMAC_MAC_1, ADDR_4);
+            mac->a[5] = FIELD_EX32(value, GENET_UMAC_MAC_1, ADDR_5);
+            qemu_macaddr_default_if_unset(mac);
+            qemu_format_nic_info_str(ncs, mac->a);
+            trace_bcm2838_genet_mac_address(ncs->info_str);
+            break;
+        case BCM2838_GENET_RDMA_CTRL:
+            s->regs.rdma.status = (~value) & GENET_DMA_ENABLE_MASK;
+            break;
+        case BCM2838_GENET_UMAC_MDIO_CMD:
+        case BCM2838_GENET_TDMA_REGS
+            ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
+            qemu_log_mask(LOG_UNIMP,
+                "UMAC MDIO and TDMA aren't implemented yet");
+            break;
+        default:
+            break;
+        }
+
+        memcpy((uint8_t *)&s->regs + offset, &value, size);
+        if (offset == BCM2838_GENET_RDMA_CTRL &&
+            FIELD_EX32(value, GENET_DMA_CTRL, EN)) {
+            qemu_flush_queued_packets(ncs);
+        }
+        bcm2838_genet_set_irq_default(s);
+        bcm2838_genet_set_irq_prio(s);
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
 }
 
 static const MemoryRegionOps bcm2838_genet_ops = {
@@ -265,9 +391,14 @@ static const MemoryRegionOps bcm2838_genet_ops = {
     .valid = {.min_access_size = 4},
 };
 
+static NetClientInfo bcm2838_genet_client_info = {
+    .type = NET_CLIENT_DRIVER_NIC,
+    .size = sizeof(NICState)
+};
 
 static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
 {
+    NetClientState *ncs;
     BCM2838GenetState *s = BCM2838_GENET(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
@@ -275,10 +406,46 @@ static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
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
+    s->phy_aux_ctl_shd_regs.misc = 0x1E;
+
     trace_bcm2838_genet_phy_reset("done");
 }
 
@@ -288,11 +455,22 @@ static void bcm2838_genet_reset(Object *obj, ResetType type)
 
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
@@ -302,6 +480,7 @@ static void bcm2838_genet_class_init(ObjectClass *class, const void *data)
     dc->realize = bcm2838_genet_realize;
     resettable_class_set_parent_phases(rc, NULL, bcm2838_genet_reset, NULL,
                                        &unused_parent_phases);
+    device_class_set_props(dc, genet_properties);
 }
 
 static const TypeInfo bcm2838_genet_info = {
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index b9895933b6..e3dee5a78f 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -390,6 +390,8 @@ struct BCM2838GenetState {
     SysBusDevice parent_obj;
 
     /*< public >*/
+    NICState *nic;
+    NICConf nic_conf;
 
     MemoryRegion regs_mr;
     AddressSpace dma_as;
-- 
2.55.0


