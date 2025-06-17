Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6818C7114A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 04:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRNcf-0003ak-Ob; Tue, 17 Jun 2025 00:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1uRNcc-0003aP-Rq
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:08:30 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1uRNcX-0003Q9-9Z
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:08:30 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDX37f26VBov0Y4Aw--.410S2;
 Tue, 17 Jun 2025 12:07:18 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAHmiPr6VBo5wZWAA--.5570S4;
 Tue, 17 Jun 2025 12:07:15 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 wangyuquan <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v3 1/2] hw/pxb-cxl: Rename the pxb cxl host bridge
Date: Tue, 17 Jun 2025 12:06:48 +0800
Message-Id: <20250617040649.81303-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
References: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAHmiPr6VBo5wZWAA--.5570S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQADAWhPIu4E8QAZsE
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF1UWr4ktw45Xw45WrW7Jwb_yoW8uryUpF
 yFg3W5tr1DJFWjkw4fCa4kXFyUC3Z7GrWrZFs7Gwn2kF1xWFyYqrsFka4IvF1UJFW0kFyj
 va1jvFW8uw4fAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This renames some descriptions and definitions of pxb cxl host
bridge, since the original names can be confusing.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 hw/pci-bridge/pci_expander_bridge.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 3a29dfefc2..bd637786d0 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -201,7 +201,7 @@ static void pxb_cxl_realize(DeviceState *dev, Error **errp)
 }
 
 /*
- * Host bridge realization has no means of knowning state associated
+ * PXB Host bridge realization has no means of knowning state associated
  * with a particular machine. As such, it is nececssary to delay
  * final setup of the host bridge register space until later in the
  * machine bring up.
@@ -240,7 +240,7 @@ static void pxb_cxl_host_class_init(ObjectClass *class, const void *data)
  * This is a device to handle the MMIO for a CXL host bridge. It does nothing
  * else.
  */
-static const TypeInfo cxl_host_info = {
+static const TypeInfo pxb_cxl_host_info = {
     .name          = TYPE_PXB_CXL_HOST,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(CXLHost),
@@ -522,7 +522,7 @@ static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
      * vendor, device, class, etc. ids are intentionally left out.
      */
 
-    dc->desc = "CXL Host Bridge";
+    dc->desc = "PXB CXL Host Bridge";
     device_class_set_props(dc, pxb_cxl_dev_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 
@@ -549,7 +549,7 @@ static void pxb_register_types(void)
     type_register_static(&pxb_pcie_bus_info);
     type_register_static(&pxb_cxl_bus_info);
     type_register_static(&pxb_host_info);
-    type_register_static(&cxl_host_info);
+    type_register_static(&pxb_cxl_host_info);
     type_register_static(&pxb_dev_info);
     type_register_static(&pxb_pcie_dev_info);
     type_register_static(&pxb_cxl_dev_info);
-- 
2.34.1


