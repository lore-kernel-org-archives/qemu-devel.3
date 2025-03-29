Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F536C28B20
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 00:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyKQC-0003NW-KE; Fri, 28 Mar 2025 20:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyKQ5-0003MW-JD
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 20:51:29 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyKQ3-00022o-9e
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 20:51:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-224341bbc1dso54195395ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 17:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743209483; x=1743814283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b6dRV/gmP6XKztMr0DilB2F3dYs3TGhJCLHvAGSaEsk=;
 b=Xo9BMUhxDyrtwsaZzMBdNYFhsfTJ0PNmxrvxMZ8MM0yVh5GdBBedacDMCSycP7nGI+
 em3EGZQNL2x4srW971z3JU8m+YyU9LHPKfKPekrQ/AY6b8OXFMDZy0i/sxqIfD3xSnQ1
 UqNWSTsWyw9VMfdA6XyqYp4WMExklGWVzmSLCMKDphB6zo0JNAKnBL43ibcuSCyhWWo9
 4uoTvsNplTnAZ6kAyxo/TQggwUskTH6+keWXh574ZYy0TuogEstjAvWyuImwkbHxFT46
 uVC6lvxqOvaET+GiID2hQF8MHMET7M5PhzZHFgmQqRN45y97S7kV3R0tx5fMvkl2kC7I
 Z+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743209483; x=1743814283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b6dRV/gmP6XKztMr0DilB2F3dYs3TGhJCLHvAGSaEsk=;
 b=ZnAhpgmAJKS8w2SiKD0yCk/pnOgdBE/MyX3TpB/i6P3K2YZPtcoVz/pGf6ksCrd4jR
 YBEcotJW6ZyEXsiIZ6ELaGvmHdB8vZTqEphFkgqKGOQE6tlBAa7zY7XddeNV1vcd+jkW
 H9g6D9+2xJFbWtoTU7S3HD2dTWrj9/EfJusMbbsy60kT+wSdJzHntBTWoA2BgD3TqIzC
 16RQXN5LIbGd9y7qJSW4UCc2BxI3t+Zo+sQW+CCyhrmR8LgntIWzb57kzFvR3SU9sirk
 jWWeN1nl3tNfFaDUL0/1eZTfmRA7ukiAPcWqmXCOv5TxvnBfgBQw1gm+Uwy0oUk8UqrP
 VP8w==
X-Gm-Message-State: AOJu0YzTSawyb7vNXrhaBQaQIBPG+PnPFGkxUHHaVkw6e/AnXUUIm3MN
 66SaVi4hK3zi3WTuBlVstdpQtIjtVPlfNEB73C5hellb7/a+RsNkdds7rbv34qY=
X-Gm-Gg: ASbGncuoni2TD0i8LLFzCk3hfU6ZRck2EAFXsXWs7lZK8kh5op0ZP1s5N3stShvLshZ
 XhGrHaXrm65DqnkI+uYncCqoebCRq0q06U8K5y11zUe5DVzZzB98OlU4tmGjko5Mq3rBiZUlt/L
 FveGRiSkpGGrPBrkCVQRqvrGd4EPnQQiHlAZNtVUhhuGdnlwk0zFzZJVOMvPXVrueURryKrV+1R
 H5/Bca5ihxv0z0npHs6FM7jN0uLhR7srKHzXrDk7+ziEBQdMUs7o1SRzjte6qOaiYtBpsL96vex
 XUXQ5dauWUVk689zdNV+vouSMR6pPOg33nYx7H1plWXl8w==
X-Google-Smtp-Source: AGHT+IFZ952FEj5oVWl5oUd6K6Pi0e0MP7aVmg9FTwkU+2lIMKh4eYu41f/I3wFp8ZIFZO6yqTboFA==
X-Received: by 2002:a17:903:2446:b0:223:525b:2a7 with SMTP id
 d9443c01a7336-2292f95f084mr16429885ad.15.1743209483111; 
 Fri, 28 Mar 2025 17:51:23 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:26:6ed:f7a3:9166:cf5c:f0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73971090aeesm2453825b3a.124.2025.03.28.17.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 17:51:22 -0700 (PDT)
From: rakeshj <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	thuth@redhat.com
Cc: balaton@eik.bme.hu,
	marcandre.lureau@redhat.com,
	rakeshjb010@gmail.com
Subject: [PATCH v2] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
Date: Sat, 29 Mar 2025 06:19:40 +0530
Message-ID: <20250329004941.372000-1-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The GT-64120 PCI controller requires special handling where:
1. Host bridge (device 0) must use native endianness
2. Other devices follow MByteSwap bit in GT_PCI0_CMD

Previous implementation accidentally swapped all accesses, breaking
host bridge detection (lspci -d 11ab:4620).

This patch:
- Adds custom read/write handlers to preserve native big-endian for the host
  bridge (phb->config_reg & 0x00fff800 == 0).
- Swaps non-bridge devices when MByteSwap = 0, using size-appropriate swaps
  (bswap16 for 2-byte, bswap32 for 4-byte) to convert PCI's little-endian data
  to match the MIPS guest's big-endian expectation; no swap occurs for the host
  bridge or when MByteSwap = 1 (little-endian mode).
- Removes gt64120_update_pci_cfgdata_mapping(), moving data_mem initialization
  to gt64120_realize()
- Removes unused pci_host_data_be_ops and a misleading comment in dino.h.

Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE MemoryRegionOps")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
---
 hw/pci-host/gt64120.c      | 83 ++++++++++++++++++++++----------------
 hw/pci/pci_host.c          |  6 ---
 include/hw/pci-host/dino.h |  5 +--
 include/hw/pci/pci_host.h  |  1 -
 4 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index d5c13a89b6..4e45d0aa53 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -320,38 +320,6 @@ static void gt64120_isd_mapping(GT64120State *s)
     memory_region_transaction_commit();
 }
 
-static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
-{
-    /* Indexed on MByteSwap bit, see Table 158: PCI_0 Command, Offset: 0xc00 */
-    static const MemoryRegionOps *pci_host_data_ops[] = {
-        &pci_host_data_be_ops, &pci_host_data_le_ops
-    };
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-
-    memory_region_transaction_begin();
-
-    /*
-     * The setting of the MByteSwap bit and MWordSwap bit in the PCI Internal
-     * Command Register determines how data transactions from the CPU to/from
-     * PCI are handled along with the setting of the Endianness bit in the CPU
-     * Configuration Register. See:
-     * - Table 16: 32-bit PCI Transaction Endianness
-     * - Table 158: PCI_0 Command, Offset: 0xc00
-     */
-
-    if (memory_region_is_mapped(&phb->data_mem)) {
-        memory_region_del_subregion(&s->ISD_mem, &phb->data_mem);
-        object_unparent(OBJECT(&phb->data_mem));
-    }
-    memory_region_init_io(&phb->data_mem, OBJECT(phb),
-                          pci_host_data_ops[s->regs[GT_PCI0_CMD] & 1],
-                          s, "pci-conf-data", 4);
-    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << 2,
-                                        &phb->data_mem, 1);
-
-    memory_region_transaction_commit();
-}
-
 static void gt64120_pci_mapping(GT64120State *s)
 {
     memory_region_transaction_begin();
@@ -645,7 +613,6 @@ static void gt64120_writel(void *opaque, hwaddr addr,
     case GT_PCI0_CMD:
     case GT_PCI1_CMD:
         s->regs[saddr] = val & 0x0401fc0f;
-        gt64120_update_pci_cfgdata_mapping(s);
         break;
     case GT_PCI0_TOR:
     case GT_PCI0_BS_SCS10:
@@ -1024,6 +991,49 @@ static const MemoryRegionOps isd_mem_ops = {
     },
 };
 
+static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigned size)
+{
+    GT64120State *s = opaque;
+    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    uint32_t val = pci_data_read(phb->bus, phb->config_reg, size);
+    
+    /* Only swap for non-bridge devices in big-endian mode */
+    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
+        if (size == 2) {
+            val = bswap16(val);
+        } else if (size == 4) {
+            val = bswap32(val); 
+        }
+    }
+    return val;
+}
+
+static void gt64120_pci_data_write(void *opaque, hwaddr addr, 
+    uint64_t val, unsigned size)
+{
+    GT64120State *s = opaque;
+    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
+        if (size == 2) {
+            val = bswap16(val);
+        } else if (size == 4) {
+            val = bswap32(val);
+        }
+    }
+    if (phb->config_reg & (1u << 31))
+        pci_data_write(phb->bus, phb->config_reg | (addr & 3), val, size);
+}
+
+static const MemoryRegionOps gt64120_pci_data_ops = {
+    .read = gt64120_pci_data_read,
+    .write = gt64120_pci_data_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
 static void gt64120_reset(DeviceState *dev)
 {
     GT64120State *s = GT64120_PCI_HOST_BRIDGE(dev);
@@ -1178,7 +1188,6 @@ static void gt64120_reset(DeviceState *dev)
 
     gt64120_isd_mapping(s);
     gt64120_pci_mapping(s);
-    gt64120_update_pci_cfgdata_mapping(s);
 }
 
 static void gt64120_realize(DeviceState *dev, Error **errp)
@@ -1202,6 +1211,12 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGADDR << 2,
                                         &phb->conf_mem, 1);
 
+    memory_region_init_io(&phb->data_mem, OBJECT(phb),
+                          &gt64120_pci_data_ops,
+                          s, "pci-conf-data", 4);
+    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << 2,
+                                        &phb->data_mem, 1);
+
 
     /*
      * The whole address space decoded by the GT-64120A doesn't generate
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 80f91f409f..56f7f28a1a 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-const MemoryRegionOps pci_host_data_be_ops = {
-    .read = pci_host_data_read,
-    .write = pci_host_data_write,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 static bool pci_host_needed(void *opaque)
 {
     PCIHostState *s = opaque;
diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
index fd7975c798..df509dbc18 100644
--- a/include/hw/pci-host/dino.h
+++ b/include/hw/pci-host/dino.h
@@ -109,10 +109,7 @@ static const uint32_t reg800_keep_bits[DINO800_REGS] = {
 struct DinoState {
     PCIHostState parent_obj;
 
-    /*
-     * PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
-     * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
-     */
+
     uint32_t config_reg_dino; /* keep original copy, including 2 lowest bits */
 
     uint32_t iar0;
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index e52d8ec2cd..954dd446fa 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned len);
 extern const MemoryRegionOps pci_host_conf_le_ops;
 extern const MemoryRegionOps pci_host_conf_be_ops;
 extern const MemoryRegionOps pci_host_data_le_ops;
-extern const MemoryRegionOps pci_host_data_be_ops;
 
 #endif /* PCI_HOST_H */
-- 
2.43.0


