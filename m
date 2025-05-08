Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1C5C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2W3-0005pK-11; Thu, 08 May 2025 10:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vz-0005ni-Rv
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:23 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vr-0005QN-GH
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:23 -0400
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F395125400A8;
 Thu,  8 May 2025 10:46:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 08 May 2025 10:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1746715573;
 x=1746801973; bh=DZOUabvADxhAvfqz5F3PTZ9/qBCHXzYkx9MOkT9bxn8=; b=
 AimtI2UnPyOVviPyZ3pnj5Hv3/U4WvKy9vDdUmb17I+a+tQFbctMA9CoGpJ6PeSl
 ukS2fUIQeol4Ya+fJOUVPaP61AbxNGHgfmrgFKrbDwZ1mRL3cy4YD5NGJDqvtHVX
 B2Y597xC6aVtv7k0o4pw6D/eq55WU501hujSGBDYh3iWhnfJw9C97V5xunigalq8
 cZX0zlh8Vd+5vUBy/g68Z6c+DMxyC8WERX2kN6xJam6Je3Dclm7D6wINivvgok1Z
 CLandA6tvPmb5dskcMZCeckAffYr6QRiO+ub+hoOXZsJrrXqFuhptkCkyPRk+PkB
 I1+FwNGbS7q3JHX3uyM3qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746715573; x=
 1746801973; bh=DZOUabvADxhAvfqz5F3PTZ9/qBCHXzYkx9MOkT9bxn8=; b=L
 sywPZisQ2HD3pYPsLGx3YUgDuWrMiSfYlFbsCjiX8DUU9zkzraeRMvDEjUGzSg/O
 yEtupWvbEIOmXg3lFhSVQZ3lI4qJX+iyHJ/UQeAMFpJ7ju2wUjiMzf81VO939M49
 3SGDLMX+6GWqeBtJ8QrxoDQcrmZ9VCDuVnX2EYPsIESkMf27px5uJTglwwHT4Q8F
 RL67zpiaBJnbsyZHqenvJ0AKI3mOoA4vdjnagrL7gYZvhY/EDTPpQhVieWkcu8BN
 cNy2tLPOs2QN8BNYEB1HN30ksRf1Nq3TFiruYTUlcsuNtJw/X4VeYk3OZn4YzPNF
 C+u5GBrRqCoqy9a8Mgjvw==
X-ME-Sender: <xms:tcMcaMdkph3Bs6x8YjaWsohlmOaPpGOZU8bC23Gz4-hvdJuDxm9drw>
 <xme:tcMcaOPOzd-xcYIV7Vry0idY-VfPr18FHJHsl_-qG2bQkPpcWUH03dckGWGZqnt5t
 tFl3a5GZTRcdIWWiok>
X-ME-Received: <xmr:tcMcaNhgJb2hXR2tfgzMmMrGksie1GzZkLZGCyOdHpLejpWGVnrOCySULxk5CDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledttdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
 tdejnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeel
 ffekgedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopegthhgvnhhhuhgr
 tggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhu
 rdhorhhg
X-ME-Proxy: <xmx:tcMcaB-47_kDQK35SdebszKlaYHx8W9DCENJtuti9eLcmRRoZ2724g>
 <xmx:tcMcaIsDVaXRT3zQ1ByrLI6m4EMwQ8WtUXqJrI6eHQ3Uqe8Q72qABQ>
 <xmx:tcMcaIEAbBWyy0pT3NSi-jW81o_aBe7POqoOnm_RL1g1fiYwzCXduw>
 <xmx:tcMcaHOu-e47QjeeARkHWTMe1H9V-rTqoU4mbzlnjFf6iLG6QYJDMQ>
 <xmx:tcMcaHByU4Y7DfAsuPPvM7SWEBw9HQ2HraQRE2sYF8tjLBTOYIM2aXgK>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 10:46:12 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 08 May 2025 15:46:08 +0100
Subject: [PATCH 3/5] hw/pci-host/bonito: Implement DMA address translation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-bonito-v1-3-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
In-Reply-To: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7543;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ngtykuSyzS2J1HNApNq2hNshEJFLO1ao2z1+13uTv0U=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhgyZwxuOVm7wOV+ab/Zc5qxqUcSctnmbzE+XOLr5au388
 OP/1DaVjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIvBcM/4vY/u5N+vqco8bI
 3NM2tOoP0x7xCRGCCvICcyuu2ey6y8PIMPdHCVfLqdKphVP9P21eYdybuDli047Gr1p76/4seii
 4jwkA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

PCIBase (Host Bridge config space BARs) and PCIBaseCfg registers
in Bonito controls PCI DMA address translation.

For any incoming DMA requests, it will be matched against PCiBase{0, 1}
together with PciBaseCfg.MASK{0,1}. If it hits any of both, higher bits
of address will be replaced by PciBaseCfg.TRANSx.

Emulating this behavior by PCI IOMMU DMA address space with dynamic
remapping on register writes.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/pci-host/bonito.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index f509f22df90ff7ed31ff5387a0acc239c22fd5f6..1c0d502a1e2dfa3c9803ca219cf505e08bf94a75 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -144,6 +144,17 @@ FIELD(PCIMAP, LO2, 12, 6)
 FIELD(PCIMAP, 2, 18, 1)
 
 #define BONITO_PCIMEMBASECFG    (0x14 >> 2)      /* 0x114 */
+REG32(PCIMEMBASECFG, 0x114)
+FIELD(PCIMEMBASECFG, MASK0, 0, 5)
+FIELD(PCIMEMBASECFG, TRANS0, 5, 5)
+FIELD(PCIMEMBASECFG, CACHED0, 10, 1)
+FIELD(PCIMEMBASECFG, IO0, 11, 1)
+FIELD(PCIMEMBASECFG, MASK1, 12, 5)
+FIELD(PCIMEMBASECFG, TRANS1, 17, 5)
+FIELD(PCIMEMBASECFG, CACHED1, 22, 1)
+FIELD(PCIMEMBASECFG, IO1, 23, 1)
+
+
 #define BONITO_PCIMAP_CFG       (0x18 >> 2)      /* 0x118 */
 
 /* 5. ICU & GPIO regs */
@@ -258,9 +269,12 @@ struct BonitoState {
     PCIHostState parent_obj;
     qemu_irq *pic;
     PCIBonitoState *pci_dev;
+    MemoryRegion dma_mr;
     MemoryRegion pci_mem;
+    AddressSpace dma_as;
     MemoryRegion *pcimem_lo_alias;
     MemoryRegion *pcimem_hi_alias;
+    MemoryRegion *dma_alias;
 };
 
 #define TYPE_PCI_BONITO "Bonito"
@@ -314,6 +328,57 @@ static void bonito_update_pcimap(PCIBonitoState *s)
                                    FIELD_EX32(pcimap, PCIMAP, 2) << 31);
 }
 
+static void pcibasecfg_decode(uint32_t mask, uint32_t trans, bool io,
+                                     uint32_t *base, uint32_t *size)
+{
+    uint32_t val;
+
+    mask = (mask << 23 | 0xF0000000);
+    val = ctz32(mask);
+    *size = 1 << val;
+    *base = (trans & ~(*size - 1)) | io << 28;
+}
+
+static void bonito_update_pcibase(PCIBonitoState *s)
+{
+    uint32_t pcibasecfg = s->regs[BONITO_PCIMEMBASECFG];
+    uint32_t size, base;
+    uint32_t pcibase, wmask;
+
+    pcibasecfg_decode(FIELD_EX32(pcibasecfg, PCIMEMBASECFG, MASK0),
+                      FIELD_EX32(pcibasecfg, PCIMEMBASECFG, TRANS0),
+                      FIELD_EX32(pcibasecfg, PCIMEMBASECFG, IO0),
+                      &base, &size);
+
+    wmask = ~(size - 1);
+    /* Mask will also influence PCIBase register writable range */
+    pci_set_long(s->dev.wmask + PCI_BASE_ADDRESS_0, wmask);
+    /* Clear RO bits in PCIBase */
+    pcibase = pci_get_long(s->dev.config + PCI_BASE_ADDRESS_0);
+    pcibase &= wmask;
+    pci_set_long(s->dev.config + PCI_BASE_ADDRESS_0, pcibase);
+    /* Adjust DMA spaces */
+    memory_region_set_size(&s->pcihost->dma_alias[0], size);
+    memory_region_set_alias_offset(&s->pcihost->dma_alias[0], base);
+    memory_region_set_address(&s->pcihost->dma_alias[0], pcibase);
+
+    /* Ditto for PCIMEMBASECFG1 */
+    pcibasecfg_decode(FIELD_EX32(pcibasecfg, PCIMEMBASECFG, MASK1),
+                      FIELD_EX32(pcibasecfg, PCIMEMBASECFG, TRANS1),
+                      FIELD_EX32(pcibasecfg, PCIMEMBASECFG, IO1),
+                      &base, &size);
+
+    wmask = ~(size - 1);
+    pci_set_long(s->dev.wmask + PCI_BASE_ADDRESS_1, wmask);
+    pcibase = pci_get_long(s->dev.config + PCI_BASE_ADDRESS_1);
+    pcibase &= wmask;
+    pci_set_long(s->dev.config + PCI_BASE_ADDRESS_1, pcibase);
+
+    memory_region_set_size(&s->pcihost->dma_alias[1], size);
+    memory_region_set_alias_offset(&s->pcihost->dma_alias[1], base);
+    memory_region_set_address(&s->pcihost->dma_alias[1], pcibase);
+}
+
 static void bonito_writel(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size)
 {
@@ -624,12 +689,35 @@ static const MemoryRegionOps bonito_spciconf_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void bonito_pci_write_config(PCIDevice *dev, uint32_t address,
+                                    uint32_t val, int len)
+{
+    pci_default_write_config(dev, address, val, len);
+
+    if (ranges_overlap(address, len, PCI_BASE_ADDRESS_0, 12)) {
+        /* Bonito Host Bridge BARs are defined as DMA windows (pciBase) */
+        bonito_update_pcibase(PCI_BONITO(dev));
+    }
+}
+
 static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
 {
     /* Fuloong 2E PCI INTX are connected to Bonito GPIN[3:0] */
     return ICU_PIN_GPINx(irq_num);
 }
 
+static AddressSpace *bonito_pcihost_set_iommu(PCIBus *bus, void *opaque,
+                                              int devfn)
+{
+    BonitoState *bs = opaque;
+
+    return &bs->dma_as;
+}
+
+static const PCIIOMMUOps bonito_iommu_ops = {
+    .get_address_space = bonito_pcihost_set_iommu,
+};
+
 static void bonito_reset_hold(Object *obj, ResetType type)
 {
     PCIBonitoState *s = PCI_BONITO(obj);
@@ -653,6 +741,11 @@ static void bonito_reset_hold(Object *obj, ResetType type)
     s->regs[BONITO_DQCFG] = 0x8;
     s->regs[BONITO_MEMSIZE] = 0x10000000;
     s->regs[BONITO_PCIMAP] = 0x6140;
+    bonito_update_pcimap(s);
+
+    pci_set_long(s->dev.config + PCI_BASE_ADDRESS_0, 0x80000000);
+    pci_set_long(s->dev.config + PCI_BASE_ADDRESS_1, 0x0);
+    bonito_update_pcibase(s);
 }
 
 static const VMStateDescription vmstate_bonito = {
@@ -700,6 +793,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
     PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
     BonitoState *bs = s->pcihost;
     MemoryRegion *pcimem_hi_alias = g_new(MemoryRegion, 1);
+    MemoryRegion *dma_alias = g_new(MemoryRegion, 2);
 
     /*
      * Bonito North Bridge, built on FPGA,
@@ -764,6 +858,24 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
                                 (hwaddr)BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE,
                                 2 * GiB);
 
+    /* 32bit DMA */
+    memory_region_init(&bs->dma_mr, OBJECT(s), "dma.pciBase", 4 * GiB);
+
+    /* pciBase0, mapped to system RAM */
+    memory_region_init_alias(&dma_alias[0], NULL, "pciBase0.mem.alias",
+                             host_mem, 0x80000000, 256 * MiB);
+    memory_region_add_subregion_overlap(&bs->dma_mr, 0, &dma_alias[0], 2);
+
+    /* pciBase1, mapped to system RAM */
+    memory_region_init_alias(&dma_alias[1], NULL, "pciBase1.mem.alias",
+                            host_mem, 0, 256 * MiB);
+    memory_region_add_subregion_overlap(&bs->dma_mr, 0, &dma_alias[1], 1);
+
+    bs->dma_alias = dma_alias;
+
+    address_space_init(&bs->dma_as, &bs->dma_mr, "pciBase.dma");
+    pci_setup_iommu(phb->bus, &bonito_iommu_ops, bs);
+
     /* set the default value of north bridge pci config */
     pci_set_word(dev->config + PCI_COMMAND, 0x0000);
     pci_set_word(dev->config + PCI_STATUS, 0x0000);
@@ -806,6 +918,7 @@ static void bonito_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    k->config_write = bonito_pci_write_config;
     rc->phases.hold = bonito_reset_hold;
     k->realize = bonito_pci_realize;
     k->vendor_id = 0xdf53;

-- 
Git-154)


