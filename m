Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848B9C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 07:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXyIl-00050A-RN; Wed, 15 Jan 2025 02:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tXyIj-0004zk-NS
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:58:57 -0500
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tXyIh-0001xK-Kp
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1736927935; x=1768463935;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lpwYw4rhKX5QeUJFCossekls6Yls+ATGeuuy5RM94I8=;
 b=O9tXJ2e2226CZkGj3GBnNwpAPKY4awH4CsZhziexJSEhYAIdkfyepRNQ
 d/vVTsVjjkCCe6Lzr7Fg0Hqd/lqjcJbmfO0S1yoZ8B9bn4Vud8/nMxa7S
 xrw3LLo8bXHWizMDKej4JOxa0Fh8JAU+BXh7haoPZWKbrHLBRuSE4HaHX
 yWDv4Fu1TLCZlgCxXcFli9cj0QylUStvg4wQWeFaIzMzpeiDZE+BkgnUr
 QcsVe+aONOzTIQwAiX8xtghufusH5dzscvD7O+KP2mThobRRr28v1QJ1b
 TDO8G+lOQrKUMGyJA91IpPcnz80sMY5EMEcWdWFW+e3x+1AEIHpkbNBp+ A==;
X-CSE-ConnectionGUID: i1AtQM9uTAq287CRdE86RA==
X-CSE-MsgGUID: GNFVmZEURyKsOY6V6LwlNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="165488952"
X-IronPort-AV: E=Sophos;i="6.12,316,1728918000"; d="scan'208";a="165488952"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 16:58:51 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 11C16E614F
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 16:58:50 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D96CDD4BE7
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 16:58:49 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 64E9520071A37
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 16:58:49 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id DEE321A000B;
 Wed, 15 Jan 2025 15:58:48 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] hw/cxl: Introduce CXL_T3_MSIX_VECTOR enumeration
Date: Wed, 15 Jan 2025 15:58:46 +0800
Message-Id: <20250115075846.167552-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28924.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28924.005
X-TMASE-Result: 10--13.185600-10.000000
X-TMASE-MatchedRID: NwgUWlK30I/dmXSnvAT20vRHjoBdjUoloYPqi9eoDbdcgT+8hMpG1QzK
 NF0GZctod8mnSvYsqD6J8PvO10f8PuW5YZxMb7aKuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVUilv
 Ab18i4hN3oM05MdTMEGvnqojXCXkr8VrGl7UnPOp85pjA/x1xfhZSD+Gbjz3IDe+i4lPM57bWxC
 hD7woC+S7oYRhG8H002gxepR+LaTCJ+w2BcN2shnV7tdtvoibaLlgNF7KCQ7I5D+TQhrkTqDOfz
 kv2QMkMVi3LNj1OnrVGX1XcWsC8PwHBiEj907KSRU4X3Mu13Iyu2GmdldmiUGvU4xtKjiBCo8WM
 kQWv6iVJeFvFlVDkf46HM5rqDwqtO5kTX1CHgcp8f5lXgobwMZYGtNs8AM5tmBHgIoi1N8vv6ab
 GsdNQLw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.252;
 envelope-from=lizhijian@fujitsu.com; helo=esa7.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce the `CXL_T3_MSIX_VECTOR` enumeration to specify MSIX vector
assignments specific to the Type 3 (T3) CXL device.

The primary goal of this change is to encapsulate the MSIX vector uses
that are unique to the T3 device within an enumeration, improving code
readability and maintenance by avoiding magic numbers. This organizational
change allows for more explicit references to each vector’s role, thereby
reducing the potential for misconfiguration.

It also modified `mailbox_reg_init_common` to accept the `msi_n` parameter,
reflecting the new MSIX vector setup.

This pertains to the T3 device privately; other endpoints should refrain from
using it, despite its public accessibility to all of them.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3: new patch to introduce a T3 specific enumeration # Jonathan
---
 hw/cxl/cxl-device-utils.c   | 12 +++++-------
 hw/cxl/switch-mailbox-cci.c |  4 +++-
 hw/mem/cxl_type3.c          | 12 ++++++------
 include/hw/cxl/cxl_device.h | 12 ++++++++++--
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 035d034f6dd8..52ad1e4c3f7a 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -352,10 +352,8 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
     }
 }
 
-static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
+static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate, int msi_n)
 {
-    const uint8_t msi_n = 9;
-
     /* 2048 payload size */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
@@ -382,7 +380,7 @@ static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->memdev_status = memdev_status_reg;
 }
 
-void cxl_device_register_init_t3(CXLType3Dev *ct3d)
+void cxl_device_register_init_t3(CXLType3Dev *ct3d, int msi_n)
 {
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     uint64_t *cap_h = cxl_dstate->caps_reg_state64;
@@ -398,7 +396,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
     device_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MAILBOX, 2, CXL_DEV_MAILBOX_VERSION);
-    mailbox_reg_init_common(cxl_dstate);
+    mailbox_reg_init_common(cxl_dstate, msi_n);
 
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000,
         CXL_MEM_DEV_STATUS_VERSION);
@@ -408,7 +406,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
                               CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 }
 
-void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw, int msi_n)
 {
     CXLDeviceState *cxl_dstate = &sw->cxl_dstate;
     uint64_t *cap_h = cxl_dstate->caps_reg_state64;
@@ -423,7 +421,7 @@ void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
     device_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
-    mailbox_reg_init_common(cxl_dstate);
+    mailbox_reg_init_common(cxl_dstate, msi_n);
 
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
     memdev_reg_init_common(cxl_dstate);
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 65cdac6cc139..762d8815880d 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -17,10 +17,12 @@
 #include "hw/qdev-properties.h"
 #include "hw/cxl/cxl.h"
 
+#define CXL_SWCCI_MSIX_MBOX CXL_T3_MSIX_MBOX
+
 static void cswmbcci_reset(DeviceState *dev)
 {
     CSWMBCCIDev *cswmb = CXL_SWITCH_MAILBOX_CCI(dev);
-    cxl_device_register_init_swcci(cswmb);
+    cxl_device_register_init_swcci(cswmb, CXL_SWCCI_MSIX_MBOX);
 }
 
 static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0ae1704a345c..f64af19ed6ae 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -843,7 +843,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 10;
     int i, rc;
     uint16_t count;
 
@@ -884,16 +883,17 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                      &ct3d->cxl_dstate.device_registers);
 
     /* MSI(-X) Initialization */
-    rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
+    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
     if (rc) {
         goto err_address_space_free;
     }
-    for (i = 0; i < msix_num; i++) {
+    for (i = 0; i < CXL_T3_MSIX_VECTOR_NR; i++) {
         msix_vector_use(pci_dev, i);
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
+                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
@@ -908,7 +908,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     if (rc) {
         goto err_release_cdat;
     }
-    cxl_event_init(&ct3d->cxl_dstate, 2);
+    cxl_event_init(&ct3d->cxl_dstate, CXL_T3_MSIX_EVENT_START);
 
     /* Set default value for patrol scrub attributes */
     ct3d->patrol_scrub_attrs.scrub_cycle_cap =
@@ -1202,7 +1202,7 @@ static void ct3d_reset(DeviceState *dev)
 
     pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
-    cxl_device_register_init_t3(ct3d);
+    cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
      * Bring up an endpoint to target with MCTP over VDM.
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 561b375dc86d..e765edd22772 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -133,6 +133,14 @@ typedef enum {
     CXL_MBOX_MAX = 0x20
 } CXLRetCode;
 
+/* type3 device private */
+enum CXL_T3_MSIX_VECTOR {
+    CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS = 0,
+    CXL_T3_MSIX_EVENT_START = 2,
+    CXL_T3_MSIX_MBOX = CXL_T3_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
+    CXL_T3_MSIX_VECTOR_NR
+};
+
 typedef struct CXLCCI CXLCCI;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
@@ -264,8 +272,8 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev,
 typedef struct CXLType3Dev CXLType3Dev;
 typedef struct CSWMBCCIDev CSWMBCCIDev;
 /* Set up default values for the register block */
-void cxl_device_register_init_t3(CXLType3Dev *ct3d);
-void cxl_device_register_init_swcci(CSWMBCCIDev *sw);
+void cxl_device_register_init_t3(CXLType3Dev *ct3d, int msi_n);
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw, int msi_n);
 
 /*
  * CXL r3.1 Section 8.2.8.1: CXL Device Capabilities Array Register
-- 
2.47.0


