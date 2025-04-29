Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B606EC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9oNb-0004z0-9D; Tue, 29 Apr 2025 13:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u9oNZ-0004yq-TX
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:04:21 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u9oNX-0004mu-Nq
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:04:21 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30a0c05e2c6so3307786a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745946258; x=1746551058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHOzoiOvMJTPcLEU21SXSfjLIk8JQdL0T8FpW0cETEU=;
 b=MtsWzI16WLy/uVvZQsdJMlENLqK3CCA+88k8qjOtdG0wam+6upY2SgQxsgYk/ctskV
 El34sqj6g+P+hV8ni2WhRcL2RtW0ez/14/U0fwUfKz0cd8kYgniN5KHqt7QWrzf3G+ZU
 a8kUDKVuVbY85Fx/y14eNVK077Y/OIfGvaYzuPVDcuvxPHxpsyOJLDUOL4KZxa7z41ic
 ubAGEnRPBr5nhisZdHyvz0bHSDsbrQgmzYWGSnAlVE28/mGCuP0rWjDml9moePH83q/Z
 YR8GFquKfwFGagGB9CLoU14Ax9ZLhwhjAVTXtijsNWCjHnGR5p6TAG7hzgsuS/tTFez2
 i2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745946258; x=1746551058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHOzoiOvMJTPcLEU21SXSfjLIk8JQdL0T8FpW0cETEU=;
 b=tgyY6Z37weildcLQXK8zF99HuUhnwFytRPv1id6IwueWCsXk6z0PndKHv/0rilTVCz
 wIh3wY/pFznmJULGa5nacKOXU9zBe0KITkNqTtPhXQsqlAIlFoIKXM5t3dnyXM2lmD8h
 d9Iuh35Er5zdJalBCe3ACMOPTo6dJaH7vvvUYgDNd2FiZjyQSkf/AU1Jaq5DUgjyu/ww
 6m9dl08MsYKoPStRpApvbILT/I6wx5/WxYW8VDjSScU7PZIfGv5e25WmCVXuY8+a1jIX
 Au7ROvuIbIoIoxdSJYvOtSwGmoKmw3h5ZnaprB67f3ogStwuVlz/rf3kB17i4afsy8WG
 9nkA==
X-Gm-Message-State: AOJu0YzSt+k5RRCWyNsLzHL7ajq0uCxnr/EgeqqnXcp8m1vctbtt4f0b
 WsooazTDtMwNvXAL677qb0jR+KcDytAN+WEBlpLhImCDIs6Ki63FMusQrA==
X-Gm-Gg: ASbGncukl1q9jIyrEzpHrfTUQ/M32Q17y8mRNKLSaYiDMnq/HIVWsP4kcWYjAYN+k0q
 bHnaGEdOmlC3Iun3ES8sU7T3CX79S9Aw0nH7DrrfucNlzUF0htbjIL0Wp5rTzkNDVSFHwUT/e5a
 /VsiBeBckPDhLbI7UfV/KXgZMVh6fWd67RzGl1qXoNvdNLYYLQKbfAVar1qSRF1BHQie+wBS3pT
 m8jThKebfIav3SXajhkMhwvtVS+FPuezg+4Hk1p8EXAZ60jRsqvv1GhuBwBPid5jI/SWt19vlbc
 h4aTjoEfLPso0Q3asYEQpRYiijR3h4RvcBuIbk2r741MJczk
X-Google-Smtp-Source: AGHT+IEIR5+5XVOiaeuwIK02vDzccqI6B00yqJ6ut7nE1tIUW9CFoQf++Ux52P7Jzww6mxTMBbYeKw==
X-Received: by 2002:a17:90b:2fcb:b0:30a:2162:c76a with SMTP id
 98e67ed59e1d1-30a23e265a4mr5200453a91.25.1745946257807; 
 Tue, 29 Apr 2025 10:04:17 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2012:c135:ab3b:a163:4eeb:c538])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef03bb26sm12678043a91.6.2025.04.29.10.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 10:04:17 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, thuth@redhat.com,
 balaton@eik.bme.hu, rakeshjb010@gmail.com
Subject: [PATCH v5 1/2] hw/pci-host/gt64120: Fix endianness handling
Date: Tue, 29 Apr 2025 22:33:53 +0530
Message-ID: <20250429170354.150581-2-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429170354.150581-1-rakeshjb010@gmail.com>
References: <20250429170354.150581-1-rakeshjb010@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pj1-x1030.google.com
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
---
 hw/pci-host/gt64120.c | 82 +++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 56a6ef93b7..ecb203a3d0 100644
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
+    uint64_t val = pci_host_data_le_ops.read(opaque, addr, size);
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
2.43.0


