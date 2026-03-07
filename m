Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03930F55124
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 23:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz13c-0005Qj-WE; Sat, 07 Mar 2026 18:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vz13c-0005QI-5W
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:27:40 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vz13a-0004vv-Ky
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:27:39 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 29C5B596D94;
 Sun, 08 Mar 2026 00:27:37 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id mLxD5DGYXUFa; Sun,  8 Mar 2026 00:27:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 23F84596D9D; Sun, 08 Mar 2026 00:27:35 +0100 (CET)
Message-ID: <28eeaf3ce8139b2e219f0353797f07bb62d4c58e.1772924827.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1772924827.git.balaton@eik.bme.hu>
References: <cover.1772924827.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 5/6] hw/pci-host/articia: Add variable for common type cast
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sun, 08 Mar 2026 00:27:35 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We need the device casted to OBJECT often enough in realize to store
it in a local variable that also makes function calls more readable.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/articia.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index 203e0646df..d7676a166f 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -174,24 +174,24 @@ static void articia_realize(DeviceState *dev, Error **errp)
 {
     ArticiaState *s = ARTICIA(dev);
     PCIHostState *h = PCI_HOST_BRIDGE(dev);
+    Object *o = OBJECT(dev);
     MemoryRegion *mr;
     PCIDevice *pdev;
 
     bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
-    memory_region_init_io(&s->gpio_reg, OBJECT(s), &articia_gpio_ops, s,
+    memory_region_init_io(&s->gpio_reg, o, &articia_gpio_ops, s,
                           TYPE_ARTICIA, 4);
 
-    memory_region_init(&s->mem, OBJECT(dev), "pci-mem", UINT64_MAX);
-    memory_region_init(&s->io, OBJECT(dev), "pci-io", 0xc00000);
-    memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
+    memory_region_init(&s->mem, o, "pci-mem", UINT64_MAX);
+    memory_region_init(&s->io, o, "pci-io", 0xc00000);
+    memory_region_init_io(&s->reg, o, &articia_reg_ops, s,
                           TYPE_ARTICIA, 0x1000000);
     memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
 
-    mr = memory_region_new_alias(OBJECT(dev), "pci-mem-low", &s->mem, 0,
-                                 PCI_LOW_SIZE);
+    mr = memory_region_new_alias(o, "pci-mem-low", &s->mem, 0, PCI_LOW_SIZE);
     memory_region_add_subregion(get_system_memory(), PCI_LOW_ADDR, mr);
-    mr = memory_region_new_alias(OBJECT(dev), "pci-mem-high", &s->mem,
-                                 PCI_HIGH_ADDR, PCI_HIGH_SIZE);
+    mr = memory_region_new_alias(o, "pci-mem-high", &s->mem, PCI_HIGH_ADDR,
+                                 PCI_HIGH_SIZE);
     memory_region_add_subregion(get_system_memory(), PCI_HIGH_ADDR, mr);
 
     /* devfn_min is 8 that matches first PCI slot in AmigaOne */
-- 
2.41.3


