Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCC3FD875E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2TwZ-0008Vz-E7; Tue, 17 Mar 2026 08:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaochengbo@bosc.ac.cn>)
 id 1w2OoW-0006Jb-5B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 03:26:05 -0400
Received: from out28-104.mail.aliyun.com ([115.124.28.104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaochengbo@bosc.ac.cn>)
 id 1w2OoS-0000VS-GY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 03:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bosc.ac.cn; s=default;
 t=1773732344; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=wLDx54oX8AdPdsk2w8wdaF7gJEBR6zW5VkimWIZBHoE=;
 b=GiQZ/1iRSghKzSJhAC6OFcI2DWsxq8THiqjzI9Omfp2M81MtSmZ1bnvvYiHg0gwc/Nalw6la3lDY6zrN5RfOSUiA6eJc+r+trwQCHLqQsxotmEAZ/HtA6Lkp6sXhFzX67LxlK1rW7evd/xb9dCtQ+2EY59BMmGcvKgoJ073QqxHZsreCwR8magPFoDbuxGuepP1WIFZ/fl/pWTgirxJkvlpAsIllGtx1n1eCXm6Wd7oQrZDtoCHrwIDe3pIsZ/pji2WhZoXT2Wrt812C7mrNh8YNxbWqAg+NCbbqblbGnq6AX5oMkhPQE677RvMK/l/0iMhQ5FRCQBSEGZ5EMShbSA==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.4360214|-1;
 BR=01201311R151S58rulernew998_84748_2000303; CH=blue; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.210207-0.0056863-0.784107;
 FP=2893993826966988424|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam011083013073;
 MF=gaochengbo@bosc.ac.cn; NM=1; PH=DS; RN=4; RT=4; SR=0;
 TI=SMTPD_---.gu0eKXA_1773732022; 
Received: from open07..(mailfrom:gaochengbo@bosc.ac.cn
 fp:SMTPD_---.gu0eKXA_1773732022 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 17 Mar 2026 15:20:36 +0800
From: gaochengbo <gaochengbo@bosc.ac.cn>
To: paulburton@kernel.org,
	arikalo@gmail.com
Cc: qemu-devel@nongnu.org,
	gaochengbo <gaochengbo@bosc.ac.cn>
Subject: [PATCH v1] hw/pci-host/xilinx-pcie: Set explicit bus name for Root
 Port
Date: Tue, 17 Mar 2026 15:20:18 +0800
Message-ID: <20260317072018.2586572-1-gaochengbo@bosc.ac.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.104;
 envelope-from=gaochengbo@bosc.ac.cn; helo=out28-104.mail.aliyun.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:54:34 -0400
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

Assign the name "xdma-pcie" to the PCI bridge bus in xilinx_pcie_root_realize().
This makes it easier to identify the Xilinx PCIe host bridge in QEMU monitor
commands (e.g., 'info qtree', 'info mtree') and debugging logs, distinguishing
it from generic pci-bridge instances.

Signed-off-by: Chengbo Gao <gaochengbo@bosc.ac.cn>
---
 hw/pci-host/xilinx-pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 40f625b61d..2949c5385e 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -271,7 +271,9 @@ static void xilinx_pcie_root_realize(PCIDevice *pci_dev, Error **errp)
 {
     BusState *bus = qdev_get_parent_bus(DEVICE(pci_dev));
     XilinxPCIEHost *s = XILINX_PCIE_HOST(bus->parent);
+    PCIBridge *br = PCI_BRIDGE(pci_dev);
 
+    br->bus_name  = "xdma-pcie";
     pci_set_word(pci_dev->config + PCI_COMMAND,
                  PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
     pci_set_word(pci_dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
-- 
2.43.0


