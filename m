Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DCB1091926
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Kg6-0001iA-IK; Thu, 19 Mar 2026 17:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w3Kfp-0001WH-7F
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:12:57 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w3Kfl-0003gS-SR
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:12:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EF0DE443AA;
 Thu, 19 Mar 2026 21:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D91FC2BC9E;
 Thu, 19 Mar 2026 21:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773954769;
 bh=Vvk+jEfVJ1Vtap+Q21savVllzRiVAewSpX4QYABm6gg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rB4ioo9DOSTlf4xfROsr9s7uSCvc8R01701O6qPsJ2jAT0DGivqqx46SZoiSg35eo
 Hrys71dgQ7C30p9VVlWAQq7rH1gPhAHwZk/mAga72WObszuEgCS6XZ/2WEilI+V8ER
 jmr/cA5JQlC7CPGzA+itKKmeCLnQs1uTbJL/JvBmXWE8d3hmnIATVgOtsqwdUQ8ys4
 GZUD+wEXIg70wCzpgDblzIXIv0be5HvBVqRAohfcgu1HN6q3G9zCFao2iIcxejgW65
 T5nyKvkxv+pk8s41G6Z4jhlbFY+yLJcTRBMKEv3rqbdohxbFNJ9ihd/f5xr1iReM1c
 isfB12W0gquJA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 4/6] hw/pci-host/astro: Use proper region names
Date: Thu, 19 Mar 2026 22:12:37 +0100
Message-ID: <20260319211239.7902-5-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319211239.7902-1-deller@kernel.org>
References: <20260319211239.7902-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

All 64-bit hppa machines have at least 4 Elroy PCI busses in the system.
Make sure to use proper names in the qemu device tree, e.g. "elroy0" or
"elroy2-pci-mmio", to be able to distinguish between the various chips.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/astro.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 626aa9ce22..6cc0b35070 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -430,10 +430,11 @@ static void elroy_pcihost_realize(DeviceState *dev, Error **errp)
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Object *obj = OBJECT(s);
+    g_autofree char *elroy_mmio_name = NULL;
 
     /* Elroy config access from CPU.  */
     memory_region_init_io(&s->this_mem, obj, &elroy_chip_ops,
-                          s, "elroy", 0x2000);
+                          s, dev->id, 0x2000);
 
     /* Elroy PCI config. */
     memory_region_init_io(&phb->conf_mem, obj,
@@ -448,7 +449,8 @@ static void elroy_pcihost_realize(DeviceState *dev, Error **errp)
                                 &phb->data_mem);
 
     /* Elroy PCI bus memory.  */
-    memory_region_init(&s->pci_mmio, obj, "pci-mmio", UINT64_MAX);
+    elroy_mmio_name = g_strdup_printf("%s-pci-mmio", dev->id);
+    memory_region_init(&s->pci_mmio, obj, elroy_mmio_name, UINT64_MAX);
     memory_region_init_io(&s->pci_io, obj, &unassigned_io_ops, obj,
                             "pci-isa-mmio",
                             ((uint32_t) IOS_DIST_BASE_SIZE) / ROPES_PER_IOC);
-- 
2.53.0


