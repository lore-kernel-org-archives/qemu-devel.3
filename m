Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FE1C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2Vz-0005m9-2o; Thu, 08 May 2025 10:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vw-0005iN-KP
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:20 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vr-0005QB-EM
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:20 -0400
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 56BC925401DB;
 Thu,  8 May 2025 10:46:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 08 May 2025 10:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1746715571;
 x=1746801971; bh=kU6gecXX5DRugQ2PgGYDQbiPnTBtDMKQykc5j4YwIAg=; b=
 eoVhIBFhoKpo3rQqPIUTXrUEWWyiesebYATAKTXrcBtnO6MQV0OicGWRD6iwQZXy
 oFdDa2WQmak2jnaukjSKnMaKg+sEumk7o5eo/fXzNHYYncaLUHjpjpWtRuIzh6Ee
 dUHcYxkvU+AKZT4YVDYC6WSb2mCrUA3F2nXmQ3Y/9nmDEFp6kGDw6AXaaotB7pQu
 dT1n9clwjyytZh/z6jNaz1hdgZ4AzjikCm21QtAk5ayF4vDXvXxAtl29H/pj6b0s
 FhnTft5KrKU/GxqG2+2MhPTh8oIbn9qQjw93e86z2Qju0c/nU1GntzCinGCUtYJy
 vY577ZV+HB1zP5slfhbJLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746715571; x=
 1746801971; bh=kU6gecXX5DRugQ2PgGYDQbiPnTBtDMKQykc5j4YwIAg=; b=U
 czeOc4olybOGCH1y9vIz91P2W36Oh1jUvH3Z+zOI/Qp+Uv7xWvqONmdykSZeLPsV
 WDnl2MGEnB0ZYkV4HZFzRMVQiA/wS3lY+doDgB/2rHNfiShkjljZDbBAFTm/vhOM
 8R/5dbSmlaHuDNEcmNamW+3/7CNSidqi6AV3/HDzaAmHWZ1vp/Y4Jvs9sX4umZWn
 mjSLua+RboDJARWke8BVJOdyqbqyvsjL9B9e8GVt5I5PYOiuba/4/1FB2FZB7Vam
 6lpmh+aQED72w5OILueZYob3bmZlHzRoia8qN9Y+lQNVcr9prdlS37xjgSJG6+dc
 f1hl/qMpNdSuPGXFsBAtw==
X-ME-Sender: <xms:ssMcaEornfbQ6qUrjEaWtshdSFNKFHPTcLDvHJSwZXZ2Y77YRSgaVQ>
 <xme:ssMcaKoG_pFNGzM9t3QI46PC-IK9jg-fv740d-h3FcsQDYAttxvJPWIDbtl9RiZfd
 Tny6xfAzZ30Si3WBTs>
X-ME-Received: <xmr:ssMcaJPqPetE0JFx3gOrVhBQFVrghPRt9IH5wTZTwCp1xsTUBQVCjtfu8R7g_aM>
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
X-ME-Proxy: <xmx:s8McaL5ehMh-3ncW1lIpuZC06TbAECSSPt6JWRPTXZUv4QpGW6n7Gw>
 <xmx:s8McaD7P5qQNl0UJLp4n56k0gsd9xP951aTNQqDlnNpiFNqYDx8KUQ>
 <xmx:s8McaLiNhuYbwYYjBZLuyOa8eWRDZzac9Wl9KYmfvvcyQZTQv0jM3Q>
 <xmx:s8McaN4427KOVsVDvngHtEacnPFxfoUg_YMKHF8DZdMfA1eSo-lK7g>
 <xmx:s8McaFvx9q80N8GO25IlkjUmppWylGET91IisFgBond7xipbEQifJYNu>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 10:46:10 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 08 May 2025 15:46:06 +0100
Subject: [PATCH 1/5] hw/pci-host/bonito: Implement ICU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-bonito-v1-1-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
In-Reply-To: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5531;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=hlmXXtlM9zjCVW9fwHMlYV534Q+3X+HrgL2Itg0lMhM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhgyZwxtYWk9oNgRenH/HqPYi25bMXxWS5XcUQgKW2Rorc
 py9K7+3o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZy8QLD/2yhLT2Vb/NMX3Wu
 XNS+w026VmHrlD71XbXM2ZmNTzXbFzL8ZJy9J0t6lk9FULOSwvV7Sf+Od76ccV4nRi7xwo8WVTc
 5LgA=
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

Implement interrupt controller on Bonito north bridge, as well
as PCI INTx mapping as per Fuloong 2E's hardware connection.

pci_bonito_set_irq is renamed to bonito_set_irq to reflect that
it also sets other IRQs on chip.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/pci-host/bonito.c | 96 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 40 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 7d6251a78d7e2e26803dd72968ca2ea7adcfe0e5..a599a1db4c068325b8c1aa8fb4a45f6b299b581b 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -157,6 +157,22 @@ FIELD(BONGENCFG, PCIQUEUE,      12, 1)
 #define BONITO_INTEN            (0x38 >> 2)      /* 0x138 */
 #define BONITO_INTISR           (0x3c >> 2)      /* 0x13c */
 
+/* ICU Pins */
+#define ICU_PIN_MBOXx(x)        (0 + (x))
+#define ICU_PIN_DMARDY          4
+#define ICU_PIN_DMAEMPTY        5
+#define ICU_PIN_COPYRDY         6
+#define ICU_PIN_COPYEMPTY       7
+#define ICU_PIN_COPYERR         8
+#define ICU_PIN_PCIIRQ          9
+#define ICU_PIN_MASTERERR       10
+#define ICU_PIN_SYSTEMERR       11
+#define ICU_PIN_DRAMPERR        12
+#define ICU_PIN_RETRYERR        13
+#define ICU_PIN_INTTIMER        14
+#define ICU_PIN_GPIOx(x)        (16 + (x))
+#define ICU_PIN_GPINx(x)        (25 + (x))
+
 /* PCI mail boxes */
 #define BONITO_PCIMAIL0_OFFSET    0x40
 #define BONITO_PCIMAIL1_OFFSET    0x44
@@ -206,6 +222,7 @@ struct PCIBonitoState {
 
     BonitoState *pcihost;
     uint32_t regs[BONITO_REGS];
+    uint32_t icu_pin_state;
 
     struct bonldma {
         uint32_t ldmactrl;
@@ -242,6 +259,40 @@ struct BonitoState {
 #define TYPE_PCI_BONITO "Bonito"
 OBJECT_DECLARE_SIMPLE_TYPE(PCIBonitoState, PCI_BONITO)
 
+static void bonito_update_irq(PCIBonitoState *s)
+{
+    BonitoState *bs = s->pcihost;
+    uint32_t inten = s->regs[BONITO_INTEN];
+    uint32_t intisr = s->regs[BONITO_INTISR];
+    uint32_t intpol = s->regs[BONITO_INTPOL];
+    uint32_t intedge = s->regs[BONITO_INTEDGE];
+    uint32_t pin_state = s->icu_pin_state;
+    uint32_t level, edge;
+
+    pin_state = (pin_state & ~intpol) | (~pin_state & intpol);
+
+    level = pin_state & ~intedge;
+    edge = (pin_state & ~intisr) & intedge;
+
+    intisr = (intisr & intedge) | level;
+    intisr |= edge;
+    intisr &= inten;
+
+    s->regs[BONITO_INTISR] = intisr;
+
+    qemu_set_irq(*bs->pic, !!intisr);
+}
+
+static void bonito_set_irq(void *opaque, int irq, int level)
+{
+    BonitoState *bs = opaque;
+    PCIBonitoState *s = bs->pci_dev;
+
+    s->icu_pin_state = deposit32(s->icu_pin_state, irq, 1, !!level);
+
+    bonito_update_irq(s);
+}
+
 static void bonito_writel(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size)
 {
@@ -289,12 +340,12 @@ static void bonito_writel(void *opaque, hwaddr addr,
         }
         break;
     case BONITO_INTENSET:
-        s->regs[BONITO_INTENSET] = val;
         s->regs[BONITO_INTEN] |= val;
+        bonito_update_irq(s);
         break;
     case BONITO_INTENCLR:
-        s->regs[BONITO_INTENCLR] = val;
         s->regs[BONITO_INTEN] &= ~val;
+        bonito_update_irq(s);
         break;
     case BONITO_INTEN:
     case BONITO_INTISR:
@@ -549,45 +600,10 @@ static const MemoryRegionOps bonito_spciconf_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-#define BONITO_IRQ_BASE 32
-
-static void pci_bonito_set_irq(void *opaque, int irq_num, int level)
-{
-    BonitoState *s = opaque;
-    qemu_irq *pic = s->pic;
-    PCIBonitoState *bonito_state = s->pci_dev;
-    int internal_irq = irq_num - BONITO_IRQ_BASE;
-
-    if (bonito_state->regs[BONITO_INTEDGE] & (1 << internal_irq)) {
-        qemu_irq_pulse(*pic);
-    } else {   /* level triggered */
-        if (bonito_state->regs[BONITO_INTPOL] & (1 << internal_irq)) {
-            qemu_irq_raise(*pic);
-        } else {
-            qemu_irq_lower(*pic);
-        }
-    }
-}
-
-/* map the original irq (0~3) to bonito irq (16~47, but 16~31 are unused) */
 static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
 {
-    int slot;
-
-    slot = PCI_SLOT(pci_dev->devfn);
-
-    switch (slot) {
-    case 5:   /* FULOONG2E_VIA_SLOT, SouthBridge, IDE, USB, ACPI, AC97, MC97 */
-        return irq_num % 4 + BONITO_IRQ_BASE;
-    case 6:   /* FULOONG2E_ATI_SLOT, VGA */
-        return 4 + BONITO_IRQ_BASE;
-    case 7:   /* FULOONG2E_RTL_SLOT, RTL8139 */
-        return 5 + BONITO_IRQ_BASE;
-    case 8 ... 12: /* PCI slot 1 to 4 */
-        return (slot - 8 + irq_num) + 6 + BONITO_IRQ_BASE;
-    default:  /* Unknown device, don't do any translation */
-        return irq_num;
-    }
+    /* Fuloong 2E PCI INTX are connected to Bonito GPIN[3:0] */
+    return ICU_PIN_GPINx(irq_num);
 }
 
 static void bonito_reset_hold(Object *obj, ResetType type)
@@ -633,7 +649,7 @@ static void bonito_host_realize(DeviceState *dev, Error **errp)
 
     memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCIHI_SIZE);
     phb->bus = pci_register_root_bus(dev, "pci",
-                                     pci_bonito_set_irq, pci_bonito_map_irq,
+                                     bonito_set_irq, pci_bonito_map_irq,
                                      dev, &bs->pci_mem, get_system_io(),
                                      PCI_DEVFN(5, 0), 32, TYPE_PCI_BUS);
 

-- 
Git-154)


