Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA480E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLisj-0006RZ-Da; Thu, 12 Dec 2024 08:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tLisY-0006PY-7a
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:05:19 -0500
Received: from mail-bn8nam11on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2414::604]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tLisU-0008EO-Ae
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:05:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0/tSO+ggzMFvyQjTd9zbyIisn5IGHsrimJ+HKZYFM7xbAtbabZUVxwRA4LeKh89q0jiLGrZtl5lre5Vw7HJvgIjQAHU/yuSBS74e7rqOp/jdkKgNmGi1taHVqbFkCaHCKkRgOg78Ha8FNJT2vuLmQjmWLOe0i8MwRH5ypFfPXd+pJ1cX7igoNATa1BUe6oRpdoFUCLW7zpJzsLjew5laOPh/FSH4FZDCMhHLX8KD3GZyzt8kG4VpbtZrpyvFCJa5p+bN6Y5FM0ilpeg+tXLmvMgfCkXyuNBQYtymLqqVI8xU9/MJGhdf6BVPvaH4R3y43rxPbu9W4dU20eEVCXmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STZfEiH4WFNwnBlwzkTvqPYXkQ3OPMAks5qMOS11CCY=;
 b=oIEYhXxKsLIziM53RfbmE6mj/CzGBbb2ZVk9AGmXoCZzuLUoAsmh10I0YP6Qb8Gc5qptm3mvxCG3bdzHk5EddcWDVOm6w62pud0A01xqwkQ6IancWrUVhOPP8obqZWtOQt6vZ2KfZFZbNvfuXuDfpMCYEcLgjIC64QAAbqaoojmO5w6uw9JKHyOLsDRO8QhhNdPtGJGaxJAMG23+y/s5r7GC7a6FlHIJrwchr96TU1tqEi/wbIpgIvDYuMo38RdI6IGHDLU0uiwGxC3SbXV2WPWUjgVKWwkG22l7wu7L2IR+tTyo3mQj2hlPnUMv2UqdcF4A9qIWj2jX0TEqKoxisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STZfEiH4WFNwnBlwzkTvqPYXkQ3OPMAks5qMOS11CCY=;
 b=nnI3YGNljoNQ/8eHFw/hual2jDnneQKMHUwXSQ4eKDbzGaznvZ8oI4lPVi8BpF6Sc0J04RkmQUZbH1jeB6WJ7dR7H/WZZqrAlouj+eQOo5/tWRDt5uJOmqLyF2jnwWKJ0cV8tjlhhGF11E0pbl69jmyjV8nD4GlIznCWCNEMNv8t6HKEnpRkRdX3XFoq88YpXxq6b2gBawYXBuaJp8C8DHvjvGgVZybh2YDUgu6e0r7yT6vK/npYdG3HdzAvKnaz9fKd+zvPzV6DwYON7CnJYlapktcvgPDF3ccuw0y8gRzQFmFneV4o2By+NdYDSl/jt6t8zWuH5hsARpYDpmHpIQ==
Received: from IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 13:05:05 +0000
Received: from CH5P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::11)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 13:05:02 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::42) by CH5P222CA0023.outlook.office365.com
 (2603:10b6:610:1ee::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 13:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 13:04:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 05:04:47 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 05:04:46 -0800
Received: from inno-linux.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 05:04:46 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
 <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>, <fan.ni@samsung.com>,
 <alex.williamson@redhat.com>, <alucerop@amd.com>, <clg@redhat.com>,
 <acurrid@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: [PATCH 2/3] hw/cxl: introduce cxl_component_update_dvsec()
Date: Thu, 12 Dec 2024 05:04:21 -0800
Message-ID: <20241212130422.69380-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212130422.69380-1-zhiw@nvidia.com>
References: <20241212130422.69380-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|IA0PR12MB9009:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f645ac-12c0-4fa0-5b01-08dd1aad9534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rH8HzlOjo/+/A8ZBOqgJVAkoDQb/tzRiWBuDzs65ob7UMnGu8YHJ7bAV/1pa?=
 =?us-ascii?Q?qJaZr2HlzMsJ7UHlo7l/Lg3C8sBvjnOeydEtUCsTCjnWbnHWd8g5lj5F9N7G?=
 =?us-ascii?Q?3d2clwc0dB2OryhTiFJL1XdiWC82+06qjJPBs4OU2mHda3kuZ+hDsLU9wpNO?=
 =?us-ascii?Q?II5eso0yo+RYr7zbtq3PWsX3XWXvK4NAfJOHo98waqeXzyVjcnD50xxyVMqa?=
 =?us-ascii?Q?a2bRsg6Uj32SgUFjAxwcBS8C+ScHsLdka+Se9vKObya0EjD4ybv2vZeK6gZW?=
 =?us-ascii?Q?EquYMnqThvJaezV88zWTyUGSNJd03SNqs0DSNGw7wvNXC6M9eJwQ+dL2x4mR?=
 =?us-ascii?Q?a2FJuZnoIooADIjDmq/oQjKP84/hWdsOLCbx0mjpxIrq6DjYii5ejgHspGhG?=
 =?us-ascii?Q?kvqblQ/j9roX62XVBvNQNcM47MRmQpQNGDmB2yrUE3WS5wkeje5Y4VUJsZTj?=
 =?us-ascii?Q?i/GgzqhIeY8zZKTmDRnK/PkVwmX3ZKIUbwGpyTTJaXptIfljRG5HevY4oWYB?=
 =?us-ascii?Q?zeLEsM2sN0iGUAe4y8DvGu6sPgH2BxbjT4wQ6DzuT0o80iWkHjsP4HNSe/Xf?=
 =?us-ascii?Q?c04Xgtk42U6mVnloQ4/0tDwYMJjlKAb5Tmtu5Nb9jLc5TTFTiZmdAjQ6r5xf?=
 =?us-ascii?Q?M2fYV9bt23pq1t9c2t1i6FEdMDnwZXAqY1tOQoWugfSTCKBWcRvMYI9zOdkn?=
 =?us-ascii?Q?4GC1XN0HDaLz00QgL6DBj7tZIszn8Wd6BVAM8N9x71rv3EpKUyd/S83ycy5v?=
 =?us-ascii?Q?iKfOJ4aNpKP2g8q52uWDGKKoxSuf1aHF5q/fYPi5ss533w1rt6pgqeGkDBnr?=
 =?us-ascii?Q?CZ5C8CLKuUEXHlfL19G8eJBTJHn2qYfbSw5m0LUY6bkjwccUhIReg1vQR9wh?=
 =?us-ascii?Q?Ct2ub3P2XQbzpRBwDiPRl1bINwYWlD1gZpOyI8wX0O+agj64TBhsLA+MgjP/?=
 =?us-ascii?Q?UlIY+YiXM7c2AjqfsYOJryLDY/jQVf73e/ojPHXdw6GFXWTDKL5mStUGIDG9?=
 =?us-ascii?Q?qZR473f0J06igZyT/3k/76MpBNFascp/+EZEo6pBMJH5w5WVPd7/zJqgfqCm?=
 =?us-ascii?Q?MCHHB+Y2whYTxNG5iWCrakklX+venSdurttvLcQ0jBJIVnq1JunkJYp/FSG+?=
 =?us-ascii?Q?aeLjm980hVJWodohx0Fnb5Ih3QF5wx7cMSBQK5Ff4dCIfec0XZaACAEwBZVH?=
 =?us-ascii?Q?7msJm6fvj6eKyJsaNLTA8Daga47fw+/ub6wUggeCTkE3rsUfBzzUI8H/9JXa?=
 =?us-ascii?Q?zduzXb2Q/th30zC5ClsD+PcpNzHBHqCS01/R/wC9OSipwcr6a3L8UboOiHiZ?=
 =?us-ascii?Q?Fk8O6Jujuro+sbVAmhP35vladtOeeahcGv2cSqUMgds0iHwaemoCBieNtVEH?=
 =?us-ascii?Q?Xsb5WYsXAi5peedvCECqSoFqbsej9O16ZmaE6WQlWdSzPAegluVrjF84cuMF?=
 =?us-ascii?Q?ye4RumatK7z17HUxk5/HQPp0xatdp7I8?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:04:58.9816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f645ac-12c0-4fa0-5b01-08dd1aad9534
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123
Received-SPF: softfail client-ip=2a01:111:f403:2414::604;
 envelope-from=zhiw@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are many DVSEC registers in the PCI configuration space that are
configurable. E.g. DVS control. They are configured and initalized in
cxl_component_create_dvsec(). When the virtual machine reboots, the
reset callback in the emulation of the emulated CXL device resets the
device states back to default states.

So far, there is no decent approach to reset the values of CXL DVSEC
registers in the PCI configuation space one for all. Without reseting
the values of CXL DVSEC registers, the CXL type-2 driver failing to
claim the endpoint:

- DVS_CONTROL.MEM_ENABLE is left to be 1 across the system reboot.
- Type-2 driver loads.
- In the endpoint probe, the kernel CXL core sees the
  DVS_CONTROL.MEM_ENABLE is set.
- The kernel CXL core wrongly thinks the HDM decoder is pre-configured
  by BIOS/UEFI.
- The kernel CXL core uses the garbage in the HDM decoder registers and
  fails:

[   74.586911] cxl_accel_vfio_pci 0000:0d:00.0: Range register decodes
outside platform defined CXL ranges.
[   74.588585] cxl_mem mem0: endpoint2 failed probe
[   74.589478] cxl_accel_vfio_pci 0000:0d:00.0: Fail to acquire CXL
endpoint
[   74.591944] pcieport 0000:0c:00.0: unlocked secondary bus reset via:
pciehp_reset_slot+0xa8/0x150

Introduce cxl_component_update_dvsec() for the emulation of CXL devices
to reset the CXL DVSEC registers in the PCI configuration space.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 hw/cxl/cxl-component-utils.c   | 36 ++++++++++++++++++++++++++++------
 include/hw/cxl/cxl_component.h |  3 +++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index aa5fb20d25..355103d165 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -365,9 +365,13 @@ void cxl_component_register_init_common(uint32_t *reg_state,
  * Helper to creates a DVSEC header for a CXL entity. The caller is responsible
  * for tracking the valid offset.
  *
- * This function will build the DVSEC header on behalf of the caller and then
- * copy in the remaining data for the vendor specific bits.
- * It will also set up appropriate write masks.
+ * This function will build the DVSEC header on behalf of the caller. It will
+ * also set up appropriate write masks.
+ *
+ * If required, it will copy in the remaining data for the vendor specific bits.
+ * Or the caller can also fill the remaining data later after the DVSEC header
+ * is built via cxl_component_update_dvsec().
+ *
  */
 void cxl_component_create_dvsec(CXLComponentState *cxl,
                                 enum reg_type cxl_dev_type, uint16_t length,
@@ -387,9 +391,12 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     pci_set_long(pdev->config + offset + PCIE_DVSEC_HEADER1_OFFSET,
                  (length << 20) | (rev << 16) | CXL_VENDOR_ID);
     pci_set_word(pdev->config + offset + PCIE_DVSEC_ID_OFFSET, type);
-    memcpy(pdev->config + offset + sizeof(DVSECHeader),
-           body + sizeof(DVSECHeader),
-           length - sizeof(DVSECHeader));
+
+    if (body) {
+        memcpy(pdev->config + offset + sizeof(DVSECHeader),
+                body + sizeof(DVSECHeader),
+                length - sizeof(DVSECHeader));
+    }
 
     /* Configure write masks */
     switch (type) {
@@ -481,6 +488,23 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     cxl->dvsec_offset += length;
 }
 
+void cxl_component_update_dvsec(CXLComponentState *cxl, uint16_t length,
+                                uint16_t type, uint8_t *body)
+{
+    PCIDevice *pdev = cxl->pdev;
+    struct Range *r;
+
+    assert(type < CXL20_MAX_DVSEC);
+
+    r = &cxl->dvsecs[type];
+
+    assert(range_size(r) == length);
+
+    memcpy(pdev->config + r->lob + sizeof(DVSECHeader),
+           body + sizeof(DVSECHeader),
+           length - sizeof(DVSECHeader));
+}
+
 /* CXL r3.1 Section 8.2.4.20.7 CXL HDM Decoder n Control Register */
 uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
 {
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index abb2e874b2..30fe4bfa24 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -261,6 +261,9 @@ void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
                                 enum reg_type cxl_dev_type, uint16_t length,
                                 uint16_t type, uint8_t rev, uint8_t *body);
 
+void cxl_component_update_dvsec(CXLComponentState *cxl, uint16_t length,
+                                uint16_t type, uint8_t *body);
+
 int cxl_decoder_count_enc(int count);
 int cxl_decoder_count_dec(int enc_cnt);
 
-- 
2.43.5


