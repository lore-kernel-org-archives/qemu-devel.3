Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F12C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2W0-0005o0-IR; Thu, 08 May 2025 10:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vy-0005lG-Er
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:22 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vt-0005QV-QF
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:21 -0400
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 46F6A1140176;
 Thu,  8 May 2025 10:46:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 08 May 2025 10:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1746715575;
 x=1746801975; bh=TaXu1bG+06hX2vAyoBCyuPqk/ukZbO6vFsvNHHvKIN8=; b=
 ELzUUENUVWH5HOMc0adtBuoeMkks+zjugrpMBGbNZwhCZLdeBS2wmJxBDgRErWz2
 rZhyK/bhts/o+1bYtKbDRkUFv4TPeiLMMbFzt6jMvfDwNC29+rIVAIdty3jUM1pX
 35GzPJndEJ5W5lleEFShZh0s5b9lUEkvwzfPh1w5OiS2IEMqi31SnWn58MgRgNvB
 WhhwIU0wqkLOONd9N5V6w/jZ1BRSvBxEL4LvTwz4dDvxepUsy83RojCmfJZQJhjz
 mLEkYTvvNcMU6ZN2ssr2sRC1zlklqCCbAVwjZaa7ueQxQUPZylTq18LQCXsmmaH0
 FoLSLSq3D3KnB+/qDUw8aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746715575; x=
 1746801975; bh=TaXu1bG+06hX2vAyoBCyuPqk/ukZbO6vFsvNHHvKIN8=; b=c
 f17rRJd2S3zYrGQ8pRKjt9JfnLuvbhYtpYST3v5tPs4wo6XTliGuZUhCMMzPE36K
 nBcrbNjm7h1O/qBvgobyTY/bk+bMwnPAG4dFrExKzJyhmMXCWZmyIzvgbRJZgSAj
 FSx1CsYQnZhMhq+n5FhI+xVVSa7vTs0JZozMPDsqji2KiNwEvZm8/NAwCII4lPHT
 kuhc8H/4JsGdmldRuQ+PlY03VL3M018Yvh1rKLMHv1MmD2m6poIm/ODoCKTGuisq
 5ZVnigJLlGezeATtb5V4vGXBtslrW4Ys4YuobUEMk8Lud029+aqAWSK1Cbg3JjaP
 8UI4VijrGCOZLTlYH9Dyw==
X-ME-Sender: <xms:tsMcaF9EZiymlNRVbF58nQw0J2ZbLtEbu_o9YPFtZjCQkpUjkl4IrA>
 <xme:tsMcaJuSgnrdH5epx-0bTzCrjil_0gYs0DRM4cTL4QhkYOgVW3414tCBSWx5u7FHN
 sbUtk5EOYJ2yVwC2_s>
X-ME-Received: <xmr:tsMcaDAGlAFzUHb1wHs5P8nsXIYy6UDbCPWoK2XWsL_ahuTvg8SDQXu1LvZ5XFk>
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
X-ME-Proxy: <xmx:t8McaJcuuUKJPX2OCV645b3yMgtL0hxoyXjvZ0ZMuhliRkT3NZF2EA>
 <xmx:t8McaKNELOrYcQp1gqXOqqw-yTr9x5PgGOCbXYc8bxM2AvNpCox9BQ>
 <xmx:t8McaLlHrpvZ2Zx3x-XPZPyDG9sAuVegak2kece5y_XLGqJrt1AxDA>
 <xmx:t8McaEtRztxiKxU45L983ijAwld-ez8Cr-b9ay5h7ZvzKelSosgJEw>
 <xmx:t8McaEj5cAPObOjQEmaQIlvyQ_Q607ei4tXrr5nHzAA0pWw4oWyt6kms>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 10:46:14 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 08 May 2025 15:46:09 +0100
Subject: [PATCH 4/5] hw/pci-host/bonito: Rework PCI config space accessor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-bonito-v1-4-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
In-Reply-To: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11253;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=65vC/62edi9rgjhBKrmHewbn7zd/yoEd2e3HSauVNN4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhgyZwxvsHhydEPxyZtMUo3Br+3Uu510q5ifcOXEq0/fpO
 +PrjnPmdJSyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBErugz/C/1+NV+VdD/16GG
 FfFS99bf9WqqEQ603+y5zlnB+IDQn6mMDAseTul5fWfPh4979p5e9mbOaTfB0LioNwd4HI89cnl
 4bwEXAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b7-smtp.messagingengine.com
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

The original PCI config space accessor failed to issue master abort
interrupt as necessary, it also didn't handle type 1 access and
using south bridge concept which doesn't exist in Bonito.

Rework the whole mechanism accorading to the manual, also remove
inaccurate comments.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/pci-host/bonito.c     | 202 ++++++++++++++++++-----------------------------
 hw/pci-host/trace-events |   3 -
 2 files changed, 75 insertions(+), 130 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 1c0d502a1e2dfa3c9803ca219cf505e08bf94a75..49b4be26393a08eda4f99c8e2ef8a0c455c57bc0 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -14,30 +14,6 @@
  * fuloong 2e mini pc has a bonito north bridge.
  */
 
-/*
- * what is the meaning of devfn in qemu and IDSEL in bonito northbridge?
- *
- * devfn   pci_slot<<3  + funno
- * one pci bus can have 32 devices and each device can have 8 functions.
- *
- * In bonito north bridge, pci slot = IDSEL bit - 12.
- * For example, PCI_IDSEL_VIA686B = 17,
- * pci slot = 17-12=5
- *
- * so
- * VT686B_FUN0's devfn = (5<<3)+0
- * VT686B_FUN1's devfn = (5<<3)+1
- *
- * qemu also uses pci address for north bridge to access pci config register.
- * bus_no   [23:16]
- * dev_no   [15:11]
- * fun_no   [10:8]
- * reg_no   [7:2]
- *
- * so function bonito_sbridge_pciaddr for the translation from
- * north bridge address to pci address.
- */
-
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -106,11 +82,6 @@
 #define BONITO_INTERNAL_REG_BASE  (BONITO_REGBASE + BONITO_REG_BASE)
 #define BONITO_INTERNAL_REG_SIZE  (0x70)
 
-#define BONITO_SPCICONFIG_BASE  (BONITO_PCICFG_BASE)
-#define BONITO_SPCICONFIG_SIZE  (BONITO_PCICFG_SIZE)
-
-
-
 /* 1. Bonito h/w Configuration */
 /* Power on register */
 
@@ -156,6 +127,9 @@ FIELD(PCIMEMBASECFG, IO1, 23, 1)
 
 
 #define BONITO_PCIMAP_CFG       (0x18 >> 2)      /* 0x118 */
+REG32(PCIMAP_CFG,    0x118)
+FIELD(PCIMAP_CFG, AD16UP, 0, 16)
+FIELD(PCIMAP_CFG, TYPE1, 16, 1)
 
 /* 5. ICU & GPIO regs */
 /* GPIO Regs - r/w */
@@ -214,23 +188,14 @@ FIELD(PCIMEMBASECFG, IO1, 23, 1)
 
 #define BONITO_REGS             (0x70 >> 2)
 
-/* PCI config for south bridge. type 0 */
-#define BONITO_PCICONF_IDSEL_MASK      0xfffff800     /* [31:11] */
-#define BONITO_PCICONF_IDSEL_OFFSET    11
-#define BONITO_PCICONF_FUN_MASK        0x700    /* [10:8] */
-#define BONITO_PCICONF_FUN_OFFSET      8
-#define BONITO_PCICONF_REG_MASK_DS     (~3)         /* Per datasheet */
-#define BONITO_PCICONF_REG_MASK_HW     0xff         /* As seen running PMON */
-#define BONITO_PCICONF_REG_OFFSET      0
-
+/* PCI Access Cycle Fields */
+FIELD(TYPE0_CYCLE, FUNC, 8, 3)
+FIELD(TYPE0_CYCLE, IDSEL, 11, 21)
 
-/* idsel BIT = pci slot number +12 */
-#define PCI_SLOT_BASE              12
-#define PCI_IDSEL_VIA686B_BIT      (17)
-#define PCI_IDSEL_VIA686B          (1 << PCI_IDSEL_VIA686B_BIT)
-
-#define PCI_ADDR(busno , devno , funno , regno)  \
-    ((PCI_BUILD_BDF(busno, PCI_DEVFN(devno , funno)) << 8) + (regno))
+FIELD(TYPE1_CYCLE, FUNC, 8, 3)
+FIELD(TYPE1_CYCLE, DEV, 11, 5)
+FIELD(TYPE1_CYCLE, BUS, 16, 8)
+FIELD(TYPE1_CYCLE, IDSEL, 24, 8)
 
 typedef struct BonitoState BonitoState;
 
@@ -580,108 +545,91 @@ static const MemoryRegionOps bonito_cop_ops = {
     },
 };
 
-static uint32_t bonito_sbridge_pciaddr(void *opaque, hwaddr addr)
+static PCIDevice *bonito_pcihost_cfg_decode(PCIBonitoState *s, hwaddr addr)
 {
-    PCIBonitoState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
-    uint32_t cfgaddr;
-    uint32_t idsel;
-    uint32_t devno;
-    uint32_t funno;
-    uint32_t regno;
-    uint32_t pciaddr;
-
-    /* support type0 pci config */
-    if ((s->regs[BONITO_PCIMAP_CFG] & 0x10000) != 0x0) {
-        return 0xffffffff;
+    uint32_t pcimap_cfg = s->regs[BONITO_PCIMAP_CFG];
+    uint32_t cycle, dev, func, bus;
+
+    cycle = addr | FIELD_EX32(pcimap_cfg, PCIMAP_CFG, AD16UP) << 16;
+
+    if (FIELD_EX32(pcimap_cfg, PCIMAP_CFG, TYPE1)) {
+        dev = FIELD_EX32(cycle, TYPE1_CYCLE, DEV);
+        func = FIELD_EX32(cycle, TYPE1_CYCLE, FUNC);
+        bus = FIELD_EX32(cycle, TYPE1_CYCLE, BUS);
+    } else {
+        uint32_t idsel = FIELD_EX32(cycle, TYPE0_CYCLE, IDSEL);
+        if (idsel == 0) {
+            return NULL;
+        }
+        dev = ctz32(idsel);
+        func = FIELD_EX32(cycle, TYPE0_CYCLE, FUNC);
+        bus = 0;
     }
 
-    cfgaddr = addr & 0xffff;
-    cfgaddr |= (s->regs[BONITO_PCIMAP_CFG] & 0xffff) << 16;
+    return pci_find_device(phb->bus, bus, PCI_DEVFN(dev, func));
+}
 
-    idsel = (cfgaddr & BONITO_PCICONF_IDSEL_MASK) >>
-             BONITO_PCICONF_IDSEL_OFFSET;
-    devno = ctz32(idsel);
-    funno = (cfgaddr & BONITO_PCICONF_FUN_MASK) >> BONITO_PCICONF_FUN_OFFSET;
-    regno = (cfgaddr & BONITO_PCICONF_REG_MASK_HW) >> BONITO_PCICONF_REG_OFFSET;
+static void bonito_pcihost_signal_mabort(PCIBonitoState *s)
+{
+    PCIDevice *d = &s->dev;
+    uint16_t status = pci_get_word(d->config + PCI_STATUS);
 
-    if (idsel == 0) {
-        error_report("error in bonito pci config address 0x" HWADDR_FMT_plx
-                     ",pcimap_cfg=0x%x", addr, s->regs[BONITO_PCIMAP_CFG]);
-        exit(1);
-    }
-    pciaddr = PCI_ADDR(pci_bus_num(phb->bus), devno, funno, regno);
-    DPRINTF("cfgaddr %x pciaddr %x busno %x devno %d funno %d regno %d\n",
-        cfgaddr, pciaddr, pci_bus_num(phb->bus), devno, funno, regno);
+    status |= PCI_STATUS_REC_MASTER_ABORT;
+    pci_set_word(d->config + PCI_STATUS, status);
 
-    return pciaddr;
+    /* Generate a pulse, it's a edge triggered IRQ */
+    bonito_set_irq(s->pcihost, ICU_PIN_MASTERERR, 1);
+    bonito_set_irq(s->pcihost, ICU_PIN_MASTERERR, 0);
 }
 
-static void bonito_spciconf_write(void *opaque, hwaddr addr, uint64_t val,
-                                  unsigned size)
+static MemTxResult bonito_pcihost_cfg_read(void *opaque, hwaddr addr,
+                                           uint64_t *data, unsigned len,
+                                           MemTxAttrs attrs)
 {
     PCIBonitoState *s = opaque;
-    PCIDevice *d = PCI_DEVICE(s);
-    PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
-    uint32_t pciaddr;
-    uint16_t status;
-
-    DPRINTF("bonito_spciconf_write "HWADDR_FMT_plx" size %d val %lx\n",
-            addr, size, val);
-
-    pciaddr = bonito_sbridge_pciaddr(s, addr);
-
-    if (pciaddr == 0xffffffff) {
-        return;
-    }
-    if (addr & ~BONITO_PCICONF_REG_MASK_DS) {
-        trace_bonito_spciconf_small_access(addr, size);
+    PCIDevice *dev;
+
+    dev = bonito_pcihost_cfg_decode(s, addr);
+    if (!dev) {
+        bonito_pcihost_signal_mabort(s);
+        /*
+         * Vanilla bonito will actually triiger a bus error on master abort,
+         * Godson variant won't. We need to return all 1s.
+         */
+        *data = UINT64_MAX;
+        return MEMTX_OK;
     }
 
-    /* set the pci address in s->config_reg */
-    phb->config_reg = (pciaddr) | (1u << 31);
-    pci_data_write(phb->bus, phb->config_reg, val, size);
+    addr &= PCI_CONFIG_SPACE_SIZE - 1;
+    *data = pci_host_config_read_common(dev, addr, pci_config_size(dev), len);
 
-    /* clear PCI_STATUS_REC_MASTER_ABORT and PCI_STATUS_REC_TARGET_ABORT */
-    status = pci_get_word(d->config + PCI_STATUS);
-    status &= ~(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT);
-    pci_set_word(d->config + PCI_STATUS, status);
+    return MEMTX_OK;
 }
 
-static uint64_t bonito_spciconf_read(void *opaque, hwaddr addr, unsigned size)
+static MemTxResult bonito_pcihost_cfg_write(void *opaque, hwaddr addr,
+                                            uint64_t data, unsigned len,
+                                            MemTxAttrs attrs)
 {
     PCIBonitoState *s = opaque;
-    PCIDevice *d = PCI_DEVICE(s);
-    PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
-    uint32_t pciaddr;
-    uint16_t status;
-
-    DPRINTF("bonito_spciconf_read "HWADDR_FMT_plx" size %d\n", addr, size);
+    PCIDevice *dev;
 
-    pciaddr = bonito_sbridge_pciaddr(s, addr);
-
-    if (pciaddr == 0xffffffff) {
-        return MAKE_64BIT_MASK(0, size * 8);
-    }
-    if (addr & ~BONITO_PCICONF_REG_MASK_DS) {
-        trace_bonito_spciconf_small_access(addr, size);
+    dev = bonito_pcihost_cfg_decode(s, addr);
+    if (!dev) {
+        bonito_pcihost_signal_mabort(s);
+        return MEMTX_OK;
     }
 
-    /* set the pci address in s->config_reg */
-    phb->config_reg = (pciaddr) | (1u << 31);
-
-    /* clear PCI_STATUS_REC_MASTER_ABORT and PCI_STATUS_REC_TARGET_ABORT */
-    status = pci_get_word(d->config + PCI_STATUS);
-    status &= ~(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT);
-    pci_set_word(d->config + PCI_STATUS, status);
+    addr &= PCI_CONFIG_SPACE_SIZE - 1;
+    pci_host_config_write_common(dev, addr, pci_config_size(dev), data, len);
 
-    return pci_data_read(phb->bus, phb->config_reg, size);
+    return MEMTX_OK;
 }
 
-/* south bridge PCI configure space. 0x1fe8 0000 - 0x1fef ffff */
-static const MemoryRegionOps bonito_spciconf_ops = {
-    .read = bonito_spciconf_read,
-    .write = bonito_spciconf_write,
+/* PCI Configure Space access region. 0x1fe8 0000 - 0x1fef ffff */
+static const MemoryRegionOps bonito_pcihost_cfg_ops = {
+    .read_with_attrs = bonito_pcihost_cfg_read,
+    .write_with_attrs = bonito_pcihost_cfg_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
@@ -812,10 +760,10 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
     memory_region_add_subregion(host_mem, BONITO_PCICONFIG_BASE,
                                 &phb->conf_mem);
 
-    /* set the south bridge pci configure  mapping */
-    memory_region_init_io(&phb->data_mem, OBJECT(s), &bonito_spciconf_ops, s,
-                          "south-bridge-pci-config", BONITO_SPCICONFIG_SIZE);
-    memory_region_add_subregion(host_mem, BONITO_SPCICONFIG_BASE,
+    /* set the pci config space accessor mapping */
+    memory_region_init_io(&phb->data_mem, OBJECT(s), &bonito_pcihost_cfg_ops, s,
+                          "pci-host-config-access", BONITO_PCICFG_SIZE);
+    memory_region_add_subregion(host_mem, BONITO_PCICFG_BASE,
                                 &phb->data_mem);
 
     create_unimplemented_device("bonito", BONITO_REG_BASE, BONITO_REG_SIZE);
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 0a816b9aa129bb0c37d207e2612e09ac4762d51a..bd9bdeadfd3678e303a412688d689cc01d06f709 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -1,8 +1,5 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
-# bonito.c
-bonito_spciconf_small_access(uint64_t addr, unsigned size) "PCI config address is smaller then 32-bit, addr: 0x%"PRIx64", size: %u"
-
 # grackle.c
 grackle_set_irq(int irq_num, int level) "set_irq num %d level %d"
 

-- 
Git-154)


