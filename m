Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDCCC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 20:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txtbZ-0000y7-8S; Thu, 27 Mar 2025 16:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1txpHr-00049j-BP
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:36:55 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1txpHp-00069k-8H
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:36:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2239c066347so28677135ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743089810; x=1743694610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jY2pZXqmdN91zoyHJQ9Q6dIwOWQgQsjp2Sjz6EpDJy0=;
 b=kXD085HcOFKZtX7OfA9CJsMHFkJ+R0YBndTqcIg2B3PNyndb2y+4s25oSlsB7g1Vk5
 mqOcnZoIJPUX/7wR0D1jqvL9Cter0DYhuCl5DIHzK5Us9pAXeA6A1eS7bP4liQ+j0H4K
 TwqrJOHDSLwWw2Egev9iDP1lSrz5nDallAfOMynWDvZUPnoYSW+TbX8JyByAzkXPYQcd
 XBwmXBnjkuI59LUFeUNiN4WWABW9cT73eHxlCHTGO/QcQrujdZ/d100QCkRc9KoxTrrJ
 EBA0lk0gxFGRyQupa/+D/x0o/g55YJ42X+PrnHkmpsMGNQETcl+lTze8zYNipAc6BN+N
 /2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743089810; x=1743694610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jY2pZXqmdN91zoyHJQ9Q6dIwOWQgQsjp2Sjz6EpDJy0=;
 b=pAK93UK9EU3xrDk2kvoXP9LgpWaKDEEq3dCrZ3p7LdEJyl2w7dNWKI/NdLjOxAFFxf
 Rr/SAFhSldW0ILn1X0F6ceaxObkdItAKDitZpJihMwJpC2Fh3kpFCq3MrRH01tnlSErW
 P5jlwlswQt6cAOekCMhfWJKi6PJ4U1ZtSVwSnd7OYKkgqnIaBWYHL3vdbwB+SarFzX38
 jun6RGARd1HOZroxvMrTipQQdtthDbvZH7tmNSL+kuQRd5gEtYgm6EgW7a5Q+thFPCOu
 7WVkhW48GcfpTfTgPeVLoooZtpnFd4BKwSGOZ/+b0u1OMvfOasVDG1T/S92SefrC9Uwq
 9ZEA==
X-Gm-Message-State: AOJu0YzBihTDmVqDJQ44ozn9ufXVKpFPt/Zzuwxjm4xZNKbQL6YJ1zLF
 WPHHkcV+3qgsjruTVlWWzQPfWtSx1M2FmGGJEwFCihB4PFi4g+MYvtZ0pSKcG8Q=
X-Gm-Gg: ASbGncsb3m1Hhb3w3KRDYmcwr2z2TW6Qwd896E2zT30AihZnYe9Uw/D8wzGyMx4A1rP
 PWussgsmnzv8bvOhup1tpHbFtI8C4Lz8tGikx6vQoPJAL8nOGBvxXPbQlnS/sbVweOEhV37G0A6
 gXtUD7LCOqr8KLdGLRNVdOC1KCZzzuyT01TrwAE3/CbBLn9JNof56yw7S1teh8lIw1uHjXXTQNq
 HRSO8ymWT0Y7jLy+DYBftkEThlWWrURw5TSkGAbtpQqwu3Yh2Uh/Aghx6aIpE4237cQyi4izT/o
 fnh/N8fy+dQ30l7p67H1aW2Ed+nz9mUG6pdebzkCegz2Fkrf
X-Google-Smtp-Source: AGHT+IED+OonyK/RYmGbXPRqetHcui6wMkxvsUMt7nY7AM0C097dGeC6giILVW3xhjlfnIwG+oI8kw==
X-Received: by 2002:a05:6a20:160f:b0:1fd:f8dc:83f6 with SMTP id
 adf61e73a8af0-1fea2fa6363mr8146433637.40.1743089810380; 
 Thu, 27 Mar 2025 08:36:50 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:26:6ed:a652:7103:3a70:1af9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611c7cfsm14431624b3a.110.2025.03.27.08.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 08:36:49 -0700 (PDT)
From: rakeshj <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, philmd@linaro.org, thuth@redhat.com,
 rakeshj <rakeshjb010@gmail.com>
Subject: [PATCH] hw/pci-host/gt64120.c: Fix PCI host bridge endianness handling
Date: Thu, 27 Mar 2025 21:06:27 +0530
Message-ID: <20250327153627.307040-1-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Mar 2025 16:13:31 -0400
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
host bridge detection (lspci -d 11ab:4620). This fix:

- Adds device filtering via (phb->config_reg & 0x00FFF800)
- Preserves native endianness for host bridge
- Maintains swapping for other devices in big-endian mode

Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE MemoryRegionOps")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
Signed-off-by: rakeshj <rakeshjb010@gmail.com>
---
 hw/pci-host/gt64120.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index d5c13a89b6..098f8e5988 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -320,11 +320,46 @@ static void gt64120_isd_mapping(GT64120State *s)
     memory_region_transaction_commit();
 }
 
+static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigned size)
+{
+    GT64120State *s = opaque;
+    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    uint32_t val = pci_data_read(phb->bus, phb->config_reg, size);
+    
+    /* Only swap for non-bridge devices in big-endian mode */
+    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
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
+    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
+        val = bswap32(val);
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
 static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
 {
     /* Indexed on MByteSwap bit, see Table 158: PCI_0 Command, Offset: 0xc00 */
     static const MemoryRegionOps *pci_host_data_ops[] = {
-        &pci_host_data_be_ops, &pci_host_data_le_ops
+        &gt64120_pci_data_ops, &pci_host_data_le_ops
     };
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
 
-- 
2.43.0


