Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D72EC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2W0-0005o3-Ln; Thu, 08 May 2025 10:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vw-0005hz-Cs
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:20 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vr-0005QJ-F5
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:19 -0400
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id AB112114014A;
 Thu,  8 May 2025 10:46:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Thu, 08 May 2025 10:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1746715572;
 x=1746801972; bh=LrN3gmXYmKom5uq/gLIEzJNE6+dmkPbGG30eg5DTNPQ=; b=
 Lc8gx2XapruFCvgZ2bWHbYeje8VGwg1UtqRLPZABUDZ8NkGuE8GpxXBBIFdWrYZz
 pW8u43+Q9FNKCkZv1sAa5j1gBkMWf2gmNoXkkqHmGM/LJ/ZlCBazUFHle8ftnr7R
 AjAU0kgNC+oAyo17fZ4PnOtSYweEjye6MDzFSnWzmFxu9VvOKibwRfH6WLEykjgX
 Ka6Sgpxs+a+clR1ZK2Y0cSeY8Pz9aKIZgz8dADH/v0bUjweCVYHHiSfTxRWd3zjl
 XQHWuPNkKP1xJhBi04MH5pbTT7vTztf8U63qJVkGC6WzTEqOd9CYa1JJvOnPj4bV
 fbkn68QUhql7wkuG9ZlI7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746715572; x=
 1746801972; bh=LrN3gmXYmKom5uq/gLIEzJNE6+dmkPbGG30eg5DTNPQ=; b=O
 FRG+I5LCfho3Z+w9yLDPIWYDv3HTyE4HH6x9thtD28Q/5i0tt5Gmi8FY4cpUBrrf
 J7p88bgrt0dN6+ye5zR1xtZzYTVIG14WJYH7SXNs95DWSQesmhCtLTSoFjjx5xbN
 YgkCsCYv0oLQgLb2JMTAqldme9iujw4gJk6vUMfqLgKYJwDVQq78E6T3telZi3Gi
 yncCd9X3OThGFp+FuDbEYVoznj6H4uvWDIRuk8m6NVGhym0J6AAsEow1Vp2NUkvy
 X+aj4wWdlAK7tyPuelLia/iM52ys1Z5jFjB7NpMdjbi6YTW7G0Sc9Y2ESwOZnA9E
 rUTSrjeR2Ng7Vci7SJ6eg==
X-ME-Sender: <xms:tMMcaJXiOQXT9RDuwBxBq9_WTUBdHhTd7UyPkm9d_-bwR-_7CWjkuA>
 <xme:tMMcaJlziZpB8iziHgfxD8RL0QTzsTP01ttMerSOWh23ZB1iFd78-7DjINqMfK7i8
 fNkRZj_Jjqs649cP5Y>
X-ME-Received: <xmr:tMMcaFYGzoA_pjpf86vPUwI7n91JPMFvbTC3bzWLVtyQdn0WOVtEFhJ39Ll-7TU>
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
X-ME-Proxy: <xmx:tMMcaMVilaG9cDibJwkxo_JUN9ZlS_3oqhEvYaqn-OiSmy61fEMRbw>
 <xmx:tMMcaDnQNyNHVcesZxvAE1F61mpCo7ep5sXdy4tDnS2T4plSYNkEQA>
 <xmx:tMMcaJd6SQcKWJNEq10PFrjTbF03x3ZpP9BATTsfKoEGjzKZpAT5sA>
 <xmx:tMMcaNFtPobvk_Sdw31n8lnkJzRMcD0GesqPd4TMrJsYaQz0okXqaw>
 <xmx:tMMcaJtB6MXrsq4NYLB5_WHEvjrOOqO4vwDOmklPN-0voly2VIRv2Y2M>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 10:46:11 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 08 May 2025 15:46:07 +0100
Subject: [PATCH 2/5] hw/pci-host/bonito: Implement PCIMAP register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-bonito-v1-2-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
In-Reply-To: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4423;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=d3Jyvw98PjFQSZwkry9Pqp89oO5oNyMnEApjSkVUy+4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhgyZwxt4NrMJLFy7dO/7KXM8A6dd9zr5Ye5TT/6MbylH2
 /xP6iYKdJSyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBEzJcx/Pf6s1Xh7pblhSxn
 T/59JnZnyqEFHirhk8Mf8r946XLCMjOK4Q+Hw5zLQRfmWM5feOX8oaMvfr5+kPct/M1d5yvRRc6
 t39s4AQ==
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

PCIMAP controls how PCILO and PCIHi regions map into
PCI memory space.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/pci-host/bonito.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index a599a1db4c068325b8c1aa8fb4a45f6b299b581b..f509f22df90ff7ed31ff5387a0acc239c22fd5f6 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -137,6 +137,12 @@ FIELD(BONGENCFG, PCIQUEUE,      12, 1)
 
 /* 4. PCI address map control */
 #define BONITO_PCIMAP           (0x10 >> 2)      /* 0x110 */
+REG32(PCIMAP,        0x110)
+FIELD(PCIMAP, LO0, 0, 6)
+FIELD(PCIMAP, LO1, 6, 6)
+FIELD(PCIMAP, LO2, 12, 6)
+FIELD(PCIMAP, 2, 18, 1)
+
 #define BONITO_PCIMEMBASECFG    (0x14 >> 2)      /* 0x114 */
 #define BONITO_PCIMAP_CFG       (0x18 >> 2)      /* 0x118 */
 
@@ -245,7 +251,6 @@ struct PCIBonitoState {
     MemoryRegion iomem_cop;
     MemoryRegion bonito_pciio;
     MemoryRegion bonito_localio;
-
 };
 typedef struct PCIBonitoState PCIBonitoState;
 
@@ -254,6 +259,8 @@ struct BonitoState {
     qemu_irq *pic;
     PCIBonitoState *pci_dev;
     MemoryRegion pci_mem;
+    MemoryRegion *pcimem_lo_alias;
+    MemoryRegion *pcimem_hi_alias;
 };
 
 #define TYPE_PCI_BONITO "Bonito"
@@ -293,6 +300,20 @@ static void bonito_set_irq(void *opaque, int irq, int level)
     bonito_update_irq(s);
 }
 
+static void bonito_update_pcimap(PCIBonitoState *s)
+{
+    uint32_t pcimap = s->regs[BONITO_PCIMAP];
+
+    memory_region_set_alias_offset(&s->pcihost->pcimem_lo_alias[0],
+                                   FIELD_EX32(pcimap, PCIMAP, LO0) << 26);
+    memory_region_set_alias_offset(&s->pcihost->pcimem_lo_alias[1],
+                                   FIELD_EX32(pcimap, PCIMAP, LO1) << 26);
+    memory_region_set_alias_offset(&s->pcihost->pcimem_lo_alias[2],
+                                   FIELD_EX32(pcimap, PCIMAP, LO2) << 26);
+    memory_region_set_alias_offset(s->pcihost->pcimem_hi_alias,
+                                   FIELD_EX32(pcimap, PCIMAP, 2) << 31);
+}
+
 static void bonito_writel(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size)
 {
@@ -308,7 +329,6 @@ static void bonito_writel(void *opaque, hwaddr addr,
     case BONITO_BONPONCFG:
     case BONITO_IODEVCFG:
     case BONITO_SDCFG:
-    case BONITO_PCIMAP:
     case BONITO_PCIMEMBASECFG:
     case BONITO_PCIMAP_CFG:
     case BONITO_GPIODATA:
@@ -330,6 +350,10 @@ static void bonito_writel(void *opaque, hwaddr addr,
     case BONITO_MEMSIZE:
         s->regs[saddr] = val;
         break;
+    case BONITO_PCIMAP:
+        s->regs[BONITO_PCIMAP] = val;
+        bonito_update_pcimap(s);
+        break;
     case BONITO_BONGENCFG:
         if (!(s->regs[saddr] & 0x04) && (val & 0x04)) {
             reset = 1; /* bit 2 jump from 0 to 1 cause reset */
@@ -664,6 +688,8 @@ static void bonito_host_realize(DeviceState *dev, Error **errp)
         g_free(name);
     }
 
+    bs->pcimem_lo_alias = pcimem_lo_alias;
+
     create_unimplemented_device("pci.io", BONITO_PCIIO_BASE, 1 * MiB);
 }
 
@@ -673,7 +699,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
     MemoryRegion *host_mem = get_system_memory();
     PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
     BonitoState *bs = s->pcihost;
-    MemoryRegion *pcimem_alias = g_new(MemoryRegion, 1);
+    MemoryRegion *pcimem_hi_alias = g_new(MemoryRegion, 1);
 
     /*
      * Bonito North Bridge, built on FPGA,
@@ -730,9 +756,10 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
     create_unimplemented_device("IOCS[3]", BONITO_DEV_BASE + 3 * 256 * KiB,
                                 256 * KiB);
 
-    memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
+    memory_region_init_alias(pcimem_hi_alias, NULL, "pci.memhi.alias",
                              &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
-    memory_region_add_subregion(host_mem, BONITO_PCIHI_BASE, pcimem_alias);
+    memory_region_add_subregion(host_mem, BONITO_PCIHI_BASE, pcimem_hi_alias);
+    bs->pcimem_hi_alias = pcimem_hi_alias;
     create_unimplemented_device("PCI_2",
                                 (hwaddr)BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE,
                                 2 * GiB);

-- 
Git-154)


