Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077ECC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 18:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzKBs-0002Kh-FE; Mon, 31 Mar 2025 14:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tzKBp-0002KM-Ff
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:48:55 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tzKBm-0001lo-OE
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:48:53 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso5553943a91.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743446929; x=1744051729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5e2LFLYL4FGGRWn+21Rw9GjEyeqb79QgJMcjrKvXJ9U=;
 b=DKE7NXsFwtJCbyUDFsYPfOvZIN+wzO4kIpZHwCbc79EKygSHUu4rjGwU992YdoY4pW
 hMaGMFyXAQIWTjjFHc+NCspWtgfR8OsCZdjRuknkjQCEEqUqUDGWPVdeQ9Qtbw+YbcrV
 L2dxfAxvRCCL52FoBEhvGKzJQdZG9OOPpNIzWQ+Iw1XxBg+POvuJ007tSCNjiM24B7a/
 hNvDYfccDNHZXnp0ymSSVTHj3GSfxuEmINicbiKRCpVNtaIMbpGz5BvEAkHJktHK0STz
 JaALplnOtEjIBBCK6A5GO//zUE9p3cjw44t7ejsMP0fOpAmvFCgOJxkBaqnWcwZuOXpy
 awmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743446929; x=1744051729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5e2LFLYL4FGGRWn+21Rw9GjEyeqb79QgJMcjrKvXJ9U=;
 b=qGFJn9ZFbrunrZuuoAUvmm2GOdBcs9dthUmJQZTwHzeOfH7SojbgaYwcN2CuutQI+f
 iL6fnWU2HY50cTB8aNHcJUTF7dNDP2Pr/4M1Wjya5ZeV8HwrbJ90louRSdXO5L4vmg03
 QC8svBmiDNWmkfR0vCwtTXtwM4y0pkmooNRG9NFp9wxif2eJlDZhD1x9i7ZTEwU8TMjA
 lP+1ztsZJNwx/I5chUmIKHBNtFTiWUSaVO2J9h5ikGtAf/HZ6u4OOvi6MaPWWZTK8p+C
 Ncc/MGuYggHmV2UOZpCP+C7N28HH/+WqKOdsfXU2WsnTEKlC18CIkQOph+gCMiYjiI2K
 zLnQ==
X-Gm-Message-State: AOJu0YxEGTktQBEyX9oGUfUCGYcPCZ/G/SWFxUzHlTw+RVPCjP7DLvDG
 FGlUwsDawMXhLOcJrzA2cbpO6aBZHXUNnESvkt/VSJXe7NlWTOZBNaa9Jjne
X-Gm-Gg: ASbGnctrsir7HUV4ZrKQg7RiMDxrD8hSkWc9zyMe45jIG7FVCmqjQ4IluJzsB3MMiZj
 nuTE4hjiY5kpqJVw+P8oz/RPNliQg9eF0KMgbBPmuizjE6H9igYenCIKACACX987U6CxSL/xqjk
 K3+elw+AjWK0jnKMgtvcYF/u24j2KzQSQhEBFwfPoFpYsQD+4euFlIhYahlr0szev6avbG7lt+e
 iGRbIMMa+hWkdrMBHCzNhklS/iDr2COYnM/vZH4t8J0+51G+/QkNFZcWZLKYM0YSG1qW/V5TNC5
 WFfloV+Fyh9ZRkSuRt/2ZhCcqjB0JMrGBnVAAh7UITuxLYBXuvNV
X-Google-Smtp-Source: AGHT+IHEh/mUJ9lhjUSiwIrzQoHuUpG6w4VJy5zyLDMss6vmEdARLBUYMvcDtwMbMPdrB5+DoDfEhQ==
X-Received: by 2002:a17:90b:1f82:b0:2fe:afa7:eaf8 with SMTP id
 98e67ed59e1d1-3056087870emr439769a91.13.1743446929022; 
 Mon, 31 Mar 2025 11:48:49 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2018:65c1:99be:24ba:7ca2:678f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f1d4f4bsm9928476a91.33.2025.03.31.11.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 11:48:48 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, philmd@linaro.org,
 thuth@redhat.com, rakeshjb010@gmail.com, balaton@eik.bme.hu
Subject: [PATCH v4 1/2] hw/pci-host/gt64120: Fix endianness handling
Date: Tue,  1 Apr 2025 00:18:19 +0530
Message-ID: <20250331184820.34673-2-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331184820.34673-1-rakeshjb010@gmail.com>
References: <20250331184820.34673-1-rakeshjb010@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pj1-x102e.google.com
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
1. Host bridge(bus 0 ,device 0) must use native endianness
2. Other devices follow MByteSwap bit in GT_PCI0_CMD

Previous implementation accidentally swapped all accesses, breaking
host bridge detection (lspci -d 11ab:4620).

This patch:
- Removes gt64120_update_pci_cfgdata_mapping(), moving data_mem initialization
  to gt64120_realize()
- Adds custom read/write handlers
- Replace raw bit check with FIELD_EX32 for MByteSwap .
- Use extract32 for bus/device check (bus 0, device 0).
- Implement size-specific swaps (bswap16 for 2-byte, bswap32 for 4-byte)
  per MemoryRegionOps requirements.

Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE MemoryRegionOps")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826

Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
---
 hw/pci-host/gt64120.c | 91 +++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 34 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index d5c13a89b6..3595d8127e 100644
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
@@ -1024,6 +991,57 @@ static const MemoryRegionOps isd_mem_ops = {
     },
 };
 
+static bool is_phb_dev0(const PCIHostState *phb)
+{
+    /*Checks if the current PCI configuration access targets the host bridge(bus 0, device 0)*/
+    return extract32(phb->config_reg, 11, 5/*dev*/ + 8/*bus*/) == 0;
+}
+
+static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigned size)
+{
+    GT64120State *s = opaque;
+    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    uint32_t val;
+    bool le_mode = FIELD_EX32(s->regs[GT_PCI0_CMD], GT_PCI0_CMD, MByteSwap);
+
+    if (!(phb->config_reg & (1 << 31))) {
+        val = 0xffffffff;
+    } else {
+        val = pci_data_read(phb->bus, phb->config_reg | (addr & 3), size);
+    }
+
+    /* Only swap for non-bridge devices in big-endian mode */
+    if (!le_mode && !is_phb_dev0(phb)) {
+        val = bswap32(val);
+    }
+    return val;
+}
+
+static void gt64120_pci_data_write(void *opaque, hwaddr addr, 
+    uint64_t val, unsigned size)
+{
+    GT64120State *s = opaque;
+    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    bool le_mode = FIELD_EX32(s->regs[GT_PCI0_CMD], GT_PCI0_CMD, MByteSwap);
+
+    if (!le_mode && !is_phb_dev0(phb)) {
+        val = bswap32(val); 
+    }
+    if (phb->config_reg & (1u << 31)){
+        pci_data_write(phb->bus, phb->config_reg | (addr & 3), val, size);
+    }
+}
+
+static const MemoryRegionOps gt64120_pci_data_ops = {
+    .read = gt64120_pci_data_read,
+    .write = gt64120_pci_data_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void gt64120_reset(DeviceState *dev)
 {
     GT64120State *s = GT64120_PCI_HOST_BRIDGE(dev);
@@ -1178,7 +1196,6 @@ static void gt64120_reset(DeviceState *dev)
 
     gt64120_isd_mapping(s);
     gt64120_pci_mapping(s);
-    gt64120_update_pci_cfgdata_mapping(s);
 }
 
 static void gt64120_realize(DeviceState *dev, Error **errp)
@@ -1202,6 +1219,12 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
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
-- 
2.43.0


