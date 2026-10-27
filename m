Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3A606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=upRfeq99
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiDN-0007tR-Lu; Tue, 27 Oct 2026 10:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCd-0007Jt-37
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:31:07 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCY-0005AB-NG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:31:02 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-93f30660e69so280884985a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111456; x=1793716256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v+pEM49vucUniZ91hu4P6nZaiJK3vE6rW+Hn/Y4ZOJg=;
 b=upRfeq99yGPhmb+I2QCmzt8LtMpzstSSYnaCXjC17t5Q844er9sy+Kvdx98ccNPXyO
 GNMSdQjCMXZomfnm/0JlMeUA0N9At9lIc/y3gUKeCyTbkKXdb3jLJTdG2tzFULzsodjP
 7NI+kCLa9VHvS3+0LvF6bTeie/PtXSGOgCJ4G8Gyc3aUxwbRBFFkZO6gCjvNh/IXAD2q
 n7IXw9LTBH/HaJhj/xv2Aqva6I0gB05EInEYlzyBHzSyDtqoaRb8h/4Gl6m15JMhj0oS
 XC0MCFxrAT5YRoCMAAVsKnqFpYu+TdhGU6nGvlJxVZlxf7EAQTWq7BvnKt4y33hlDpCQ
 4K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111456; x=1793716256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v+pEM49vucUniZ91hu4P6nZaiJK3vE6rW+Hn/Y4ZOJg=;
 b=e79C1JX/o+AdadVX2RiYXDMvJMUrPhKiethXinvVXuw8La9x7AWvPt+q5wnPYz3RA7
 DUVMDCQu2fwsj885LXrEyikCfo5H6i3I5Fo/gy7Yxb5y+d0cQC8cE4Pd8Euw/JQBR7EI
 gQvTYLfD8x9Qap2+9PHYmik47Lyst7BAcJPqh4ESIBR+kqNBcyOfAsHG9Q4Mha2VB647
 bZqol2jJklakKuOhsPNGWwv/slk/LqA1unFeuRigwFRG1mHC66VS29sxrc8gnvW8AG1K
 1v0hEHSws/NDte7wQqVWtHJ121TO+Qig9ssE2H+YK57EAFFdm+VT94+uhlyu0WRWl6qh
 AqvQ==
X-Gm-Message-State: AFq9FYL7bGFKJ0wbP3AaohALfzeD7StbVKY2wf00jGGhnGUwP2TW+l0b
 pGoVJJE0wEAsWJnjWpIdeqs8oMel+IlmNZBec5J63zczWXQ01RyAtM4j8czUGv1c
X-Gm-Gg: AYBFou0kTupqkxTLsaWWoGlyHopWIxuMgjPXpCrfpD8kmJKDvJeOHHbT3e0ppbcue79
 YQ3327j3MoKQ9EP/IzvWZeiSa7ddiCvQzJJd/duXGpTIfKc3ychCXK2eefoHkN6B/GmknHjuYO2
 dt9YCIE3QXh+A3gadFwOJ7FFx8hpQ/DDolDtIpG55Vfttrjbvo0yAGWFRQDECoz5TgVpRG+ERIn
 QKdkx3OzZ42rFpGQDBFVa+SMYuzoai4QQHy0by8cITyKNruCUnyzC6VpEqlTMEuluOSLDpOUr4w
 yfdGR9aCwKx2JxIVwIbFFWMNz5kgfNF4E72n3cZlt4yagGKtJ/oMS2YMKx1tBKeKfqFvKiEZPUA
 4virI9hiJLS07xPtO0EVBMg2vaKcfykbNIc9vzG8XhKKlrQuzBTCED7rOlCET69UhVnblajs6dW
 mMRA0YqUyh3jgIKJLkVjBOB506lLyl0iuL+iNcXRL7AqNTXbZ3xZgMXHtzQDZrd57+uF3rTXm4T
 ef3FsiNWGszhB+J9Ef3y+3FOZqdfqSx16aXpBS6hcxSQPJf+BS00ho00EMb/bwuVTLpq1qanJAv
 w2caFy8q28zrJG+4uqSALMtWHyEPZSjuHj2vpWTLvNt9VGsp/0g8ZLdWRcpn5c+5uWCMZJa/
X-Received: by 2002:a05:620a:4689:b0:93f:2e08:6420 with SMTP id
 af79cd13be357-940ef930089mr1550433385a.38.1793111456336; 
 Tue, 27 Oct 2026 07:30:56 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:9872:3600:589:5f3a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0a78c06sm986400885a.35.2026.10.27.07.30.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 07:30:55 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v6 10/17] hw/net/bcm2838_genet: implement GENET register ops
Date: Tue, 27 Oct 2026 10:30:29 -0400
Message-ID: <20261027143036.44973-11-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027143036.44973-1-marcelomanzo@gmail.com>
References: <20261027143036.44973-1-marcelomanzo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72e.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
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
---
 hw/net/bcm2838_genet.c         | 196 +++++++++++++++++++++++++++++++--
 include/hw/net/bcm2838_genet.h |  19 +++-
 2 files changed, 204 insertions(+), 11 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 091cd38954..1d443e06c1 100644
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
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index e0add41aab..ee240213aa 100644
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
-- 
2.55.0


