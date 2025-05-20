Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3679C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKn4-0006nG-Ut; Tue, 20 May 2025 07:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKn2-0006hz-2n
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKmz-000301-SO
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0Xcm5bA00Me362rRmynF1HaRtvSKHHPxRY26ytB2T0=;
 b=Z8Dnin8hA6LvZrDUUBwU8QTlkb+I4up7HPTVlBShMd31tuhSyQeG9Wneuu62Veur+hfep/
 keOTTqOffrkgt/f8p7aPo7DBOisEX2j1MYdeBwhYAJ5hlCGCNddkpbJocRz9xwkXBUy6dB
 peTgyk9wtJclsgo/87xpfJen3KUVxDg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-DeXnH3GRNC6SqTTrFigFVA-1; Tue, 20 May 2025 07:05:39 -0400
X-MC-Unique: DeXnH3GRNC6SqTTrFigFVA-1
X-Mimecast-MFC-AGG-ID: DeXnH3GRNC6SqTTrFigFVA_1747739139
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acbbb00099eso467801466b.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739138; x=1748343938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0Xcm5bA00Me362rRmynF1HaRtvSKHHPxRY26ytB2T0=;
 b=O75uiBTxy/W5PidiSTP4Xs0IXtxjKMQP0uI5RScOsUe7G6LcVxl9cOuahl07z2/isf
 oOEtvrg3FSBjty2drF9Dp35fTFXk00mHFaLPZ93NCAX5hP/65Xxn/cm6uO5o/ZKt8OKD
 0a3Zet+BzLi/2kjS+FMBSaC6I5t6Sf5hS1Neu23WFx/ZX7n5d49wur/EXtcFyrfR/031
 bhqxM0vE21eLbiRKNBDVuAcR2b5vQxQvjIENxgYOI17p05TOewZGZ2fxXzGyKflKjKty
 Xb5Wtegsjsqwos2YCTU5m75q+zn8QidH6S7SeCsMvPmZP3V0TA1XSkmDI9fm0VoP7O+f
 Uwzg==
X-Gm-Message-State: AOJu0YylzsZMDg6X/rUy/0lcN3JIBs4qqDYB1Aelsq35N0jCH5XA1NKv
 ewKj9TMtXyv6hK/SaAHa6h71wrHC2orEXns4j9/A+vpfwV5hbRqEyVId7mAqWLxbozCk6rsmK4n
 MZNItGlQ7XWN/nb3wgbI2U2odo5gz8lxERvCo0xhOrjASxcWdNq42ZzUPI9zXcBXgkw2Eq68/bp
 oXPLZ47rCZXVTMOpGhpG7JDRg9Clcg0XbE+s/kIpWs
X-Gm-Gg: ASbGncsVlc9gZfaM0haWOFhDJxLrQSHOzzKvdVyioDP+EOmFwz+da6cdbIGlqblF+P7
 aon/YcEh2SI/sA42jHxiEqHoxnwMIEHAT6JVZjdz0JdFK8jGW175EryUY5XHVJAsMgfmWaJFjvy
 +fFGcRjCEXO+6m261FQmZTvAj8YjeJDbjVHZM7jf4qcSBWsf2SDGfUQqj2X2p2DLgeTAP4nf3Sx
 s3zRgfQ7OLNXX5x2JHyOgSy33nzVIPWk2faoGO1wJzeGXxn0jdBgEmzKuNUIcUrZh961qLnYbn1
 IB85EgNR/X+Weg==
X-Received: by 2002:a17:907:94d0:b0:ad2:2949:bdfc with SMTP id
 a640c23a62f3a-ad536b7ca51mr1548033466b.3.1747739137716; 
 Tue, 20 May 2025 04:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUw2cXljvCSutROYFW3Mdqws4CmPEUGC/f872J0I+xkvn4QpQTlEgMWW50kLldGYlDmSMGiQ==
X-Received: by 2002:a17:907:94d0:b0:ad2:2949:bdfc with SMTP id
 a640c23a62f3a-ad536b7ca51mr1548030466b.3.1747739137256; 
 Tue, 20 May 2025 04:05:37 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4967c9sm712361966b.129.2025.05.20.04.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Rakesh Jeyasingh <rakeshjb010@gmail.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PULL 03/35] hw/pci-host/gt64120: Fix endianness handling
Date: Tue, 20 May 2025 13:04:58 +0200
Message-ID: <20250520110530.366202-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Rakesh Jeyasingh <rakeshjb010@gmail.com>

The GT-64120 PCI controller requires special handling where:
1. Host bridge(bus 0 ,device 0) must never be byte-swapped
2. Other devices follow MByteSwap bit in GT_PCI0_CMD

The previous implementation incorrectly  swapped all accesses, breaking
host bridge detection (lspci -d 11ab:4620).

Changes made:
1. Removed gt64120_update_pci_cfgdata_mapping() and moved data_mem initialization
  to gt64120_realize() for cleaner setup
2. Implemented custom read/write handlers that:
   - Preserve host bridge accesses (extract32(config_reg,11,13)==0)
   - apply swapping only for non-bridge devices in big-endian mode

Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE MemoryRegionOps")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826

Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20250429170354.150581-2-rakeshjb010@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/gt64120.c | 82 +++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 56a6ef93b7a..b12a25696c4 100644
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
@@ -1024,6 +991,48 @@ static const MemoryRegionOps isd_mem_ops = {
     },
 };
 
+static bool bswap(const GT64120State *s) 
+{
+    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    /*check for bus == 0 && device == 0, Bits 11:15 = Device , Bits 16:23 = Bus*/
+    bool is_phb_dev0 = extract32(phb->config_reg, 11, 13) == 0;
+    bool le_mode = FIELD_EX32(s->regs[GT_PCI0_CMD], GT_PCI0_CMD, MByteSwap);
+    /* Only swap for non-bridge devices in big-endian mode */
+    return !le_mode && !is_phb_dev0;
+}
+
+static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigned size)
+{
+    GT64120State *s = opaque;
+    uint32_t val = pci_host_data_le_ops.read(opaque, addr, size);
+
+    if (bswap(s)) {
+        val = bswap32(val);
+    }
+    return val;
+}
+
+static void gt64120_pci_data_write(void *opaque, hwaddr addr, 
+    uint64_t val, unsigned size)
+{
+    GT64120State *s = opaque;
+
+    if (bswap(s)) {
+        val = bswap32(val); 
+    }
+    pci_host_data_le_ops.write(opaque, addr, val, size);  
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
@@ -1178,7 +1187,6 @@ static void gt64120_reset(DeviceState *dev)
 
     gt64120_isd_mapping(s);
     gt64120_pci_mapping(s);
-    gt64120_update_pci_cfgdata_mapping(s);
 }
 
 static void gt64120_realize(DeviceState *dev, Error **errp)
@@ -1202,6 +1210,12 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
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
2.49.0


