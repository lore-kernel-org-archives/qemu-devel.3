Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13788E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLisj-0006RY-9r; Thu, 12 Dec 2024 08:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tLisb-0006Qu-DD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:05:26 -0500
Received: from mail-bn8nam04on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2408::61f]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tLisY-0008EW-7f
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:05:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nyx5cge2RpN+OX0swu79tzomTwb+HvvobYkhVr0/udXa62oovTlx3ZdX2XDGqKm1vvcNwzXfvglXfMjqDVENiSkHJxEFMoLq8G8JFzzpRMrATmThgp6cDCvEvVqUuWXb6/nH6vhA3AAE/yJSVrL3DrbYdb3JVrZEV6iCuhX65RnVOk471394Meh53AxU7Rg2YyD6FRpgXFh7yawwC87ugCjJ/OAyOmiqQM0ScIoqy6x64bZqHiKcVOkuDIZe/68Xd2pj1VSs2E/HoVX7wiKa0gxpT8rxiBCPxAl9mQx1N/P2BE+igzxcD7Z+hIYwoUB3R35EqYXNnqzzron7t8aTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGqrk1Sukf4NTb/239dUOeXzAV6L8tflabEhhCoYv9w=;
 b=pajasoArL/z2u0VTX2KhjlXXmqA+yRDANOfd1OPvr8XIQFFHaVOwqlasqY51KOYJ0Hdo+CVc7uTyHju4ndMv6bn9CchgI/hNhMs2sc21ojvw4B1GH5zn+spnmlYtzey4QTWlRnrMxjq48t9cE+wgFubnB45q4fAiJfTLk2IDJ+120rc+d5KQvYTkE0bwHRk8sbs5VF4YZiFDlacIxwHucZR0+qMC3ew4fHLBAPCW8fpwsiGte0YICI/kf4FNvQUkmMDWJSlhX2vo8wbC3AAFWt9L0ELrsT86NRSvV9hq+TbN5NBIygAWfpSkPrr4V6uNnrLo6TnSDhL3Hj22LuDigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGqrk1Sukf4NTb/239dUOeXzAV6L8tflabEhhCoYv9w=;
 b=LAxrEm41CnENXfY0s6emZ7zFEsyb6/lzV0fJdPucZWr5SPmH1I3C80vy5tQoE7EfJ+TpxrSfaNp++anXshlYFOfd4RKlPW65cwSF7S+oQ6PsC1urHvX6QNjZ1GsxO8bN5IhKuk8YXD60QoiiM3mAWvtJ3uog5QZue43ueTwT5E/F9oa56icHlyuZEjrPedRL2WU9XrBslA/L7AfQ9I5fSiMxLcsHF5DEYjqw9nc01aPY5cpPEODR50P3tC2TSzKtES6uvlmIcIpWy8L+UBZQ+UDnG8avzC2s7k40dFWMKzbYXQUlhS4XffjXlh1iJMfSYo1SM35665DHQIujpuLn1A==
Received: from CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Thu, 12 Dec
 2024 13:05:08 +0000
Received: from DS7PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:3b5::28)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 12 Dec
 2024 13:04:59 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::c8) by DS7PR03CA0053.outlook.office365.com
 (2603:10b6:5:3b5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 13:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 13:04:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 05:04:48 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 05:04:47 -0800
Received: from inno-linux.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 05:04:47 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
 <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>, <fan.ni@samsung.com>,
 <alex.williamson@redhat.com>, <alucerop@amd.com>, <clg@redhat.com>,
 <acurrid@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: [PATCH 3/3] hw/cxl: introduce CXL type-2 device emulation
Date: Thu, 12 Dec 2024 05:04:22 -0800
Message-ID: <20241212130422.69380-4-zhiw@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212130422.69380-1-zhiw@nvidia.com>
References: <20241212130422.69380-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CY8PR12MB8216:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7e97e3-cafa-4063-da14-08dd1aad94a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A2NvsTN+HalxCFVosInhyMKvMAFb2QEQBUho8OC5EVq70A0ELCP6gmynxeus?=
 =?us-ascii?Q?gXLtBDFvn/o/BAWE7xTEjB2FO5ByZowRLryRl9FOb0pcP//65lU8/4YuuZ2P?=
 =?us-ascii?Q?wqYVSZC4VNYyZObQSmisnh8tCuj2S0LD4ac2SlGw3YXDq6SFu72snoVfdPv0?=
 =?us-ascii?Q?/ojvrvRqnXOVfmfoFYdnmV8vlVwktbJ8H9qM7DYsgUKEt3VrrjZP0LvngUhO?=
 =?us-ascii?Q?DmMq0DehGdz5mOsqDlht03O/FoGPMaoBqi62sN2yLK1Jgk2TfkJ4ByG+0tfS?=
 =?us-ascii?Q?9pTNOyI0xJe1s3CrNthQMZ7aW9YvOxgvlPKQSK/MAdVoFxq25VidG7zWXAox?=
 =?us-ascii?Q?2NsMZILkTvDl8WsvFRd1DJs7UauwZEwTCbNclZgLLt1dyKEP79qAJUTfv978?=
 =?us-ascii?Q?2CHHt+Bx2cA4I5c9pBa6DbpMT+rIOnlYUimuYgFyCf71z8GN+s3PQPQx+ai1?=
 =?us-ascii?Q?J9e7CIFOpS7e/GWl5oUpChH6lyX8TpiQ6SJTawpCRZkn0D0g+QX5fViW1M88?=
 =?us-ascii?Q?fkIUNLywYED4K0cRtpoqUR/b45TlLluUmNPLr1gCnmh35dbGN6m0duffbbHw?=
 =?us-ascii?Q?MSJTOM52F1y6dZcvhejxGWIkqQniDbluxaofQ80t9G1EVFdxxdroKd+FmV2r?=
 =?us-ascii?Q?a+ZE0dgzw4lYcjhMhKwLAmnzhbal7HyqNpw2Ae7fJswOquNnCBsG+N6X41kn?=
 =?us-ascii?Q?6xQgLw3kF/dMT8jm5FZFo30jpSSQ/ZMfCSidk40OZ3EjRrABMmtdC1cgIpF4?=
 =?us-ascii?Q?ucwlBzqtoOLhQlG/H0lxpmb3F3KB57P6CBtwixWTFj3+iRfAMhRsCIr8faAh?=
 =?us-ascii?Q?4tGd47mDm25fpGj2nDluEKexH/69MFJofGd7xHdr6pgbdrnHm8vCYhEkfcW6?=
 =?us-ascii?Q?f2/oyMHRsTfPYV8H0HxEOi5UpHROWK/szORSQA+YhNSHrQlchGqhFhzyAbxI?=
 =?us-ascii?Q?vuhJ0HJPYDZofQdB2DxXh8eASaSdHXHqJqLjYPsoa+TnsJ6vJmeJ+8YTey6t?=
 =?us-ascii?Q?qCIVS+1Non1Z1Pgeb+uTbuVk1UJIJwD1PKeO1qGT3J0aj80XVJTYHGiLovCj?=
 =?us-ascii?Q?4/hXdHog8/P/pKjTxaAfxqAbzF44RCiGWv5UjV8WYuiAd7jvd7X5+heIc/kK?=
 =?us-ascii?Q?UiZi1UNOK2fYnkg7DOF1oGqaSHP6uAGbyIvTKiMw/IPOgC2LW6q2BsZwhhpt?=
 =?us-ascii?Q?zFuWMUBsunU+cm3tEuZiiA4q0tFiZmdVQxespfsB4lFpk34jYM6mUpZclJW2?=
 =?us-ascii?Q?rhiok56W7b4MHDSFPNRofRROp9SQs4tKotNogcdr0xz8ZMCwmYxvBOO7QvOj?=
 =?us-ascii?Q?+JQx3PBoc+pqZQlyusZYBFbWM+YS/Hm0aEuYQ+meHOiNoBpcJZlVHB04oKbN?=
 =?us-ascii?Q?IS+MHJLbxhbjlcb38WDgqCVqOU30vqV82qKmU+PwuaLfSK2nsyCTpECpunI1?=
 =?us-ascii?Q?s86jYAMKxLiMgTjwP6kOrZDlZYMRJ4+O?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:04:58.0149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7e97e3-cafa-4063-da14-08dd1aad94a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
Received-SPF: softfail client-ip=2a01:111:f403:2408::61f;
 envelope-from=zhiw@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

From: Zhi Wang <zhiwang@kernel.org>

Introduce a CXL type-2 device emulation that provides a minimum base for
testing kernel CXL core type-2 support and CXL type-2 virtualization. It
is also a good base for introducing the more emulated features.

Currently, it only supports:

- Emulating component registers with HDM decoders.
- Volatile memory backend and emualtion of region access.

The emulation is aimed to not tightly coupled with the current CXL type-3
emulation since many advanced CXL type-3 emulation features are not
implemented in a CXL type-2 device.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zhi Wang <zhiwang@kernel.org>
---
 MAINTAINERS                    |   1 +
 docs/system/devices/cxl.rst    |  11 ++
 hw/cxl/cxl-component-utils.c   |   2 +
 hw/cxl/cxl-host.c              |  19 +-
 hw/mem/Kconfig                 |   5 +
 hw/mem/cxl_accel.c             | 319 +++++++++++++++++++++++++++++++++
 hw/mem/meson.build             |   1 +
 include/hw/cxl/cxl_component.h |   1 +
 include/hw/cxl/cxl_device.h    |  25 +++
 include/hw/pci/pci_ids.h       |   1 +
 10 files changed, 382 insertions(+), 3 deletions(-)
 create mode 100644 hw/mem/cxl_accel.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aaf0505a21..72a6a505eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2914,6 +2914,7 @@ R: Fan Ni <fan.ni@samsung.com>
 S: Supported
 F: hw/cxl/
 F: hw/mem/cxl_type3.c
+F: hw/mem/cxl_accel.c
 F: include/hw/cxl/
 F: qapi/cxl.json
 
diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 882b036f5e..13cc2417f2 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -332,6 +332,17 @@ The same volatile setup may optionally include an LSA region::
   -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,lsa=cxl-lsa0,id=cxl-vmem0 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
 
+A very simple setup with just one directly attached CXL Type 2 Volatile Memory
+Accelerator device::
+
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
+  ...
+  -object memory-backend-ram,id=vmem0,share=on,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-accel,bus=root_port13,volatile-memdev=vmem0,id=cxl-accel0 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
+
 A setup suitable for 4 way interleave. Only one fixed window provided, to enable 2 way
 interleave across 2 CXL host bridges.  Each host bridge has 2 CXL Root Ports, with
 the CXL Type3 device directly attached (no switches).::
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 355103d165..717ef117ac 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -262,6 +262,7 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
         write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
         if (type == CXL2_DEVICE ||
             type == CXL2_TYPE3_DEVICE ||
+            type == CXL3_TYPE2_DEVICE ||
             type == CXL2_LOGICAL_DEVICE) {
             write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
                 0xf0000000;
@@ -293,6 +294,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     case CXL2_UPSTREAM_PORT:
     case CXL2_TYPE3_DEVICE:
     case CXL2_LOGICAL_DEVICE:
+    case CXL3_TYPE2_DEVICE:
         /* + HDM */
         caps = 3;
         break;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e9f2543c43..e603a3f2fc 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -201,7 +201,8 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
         return NULL;
     }
 
-    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
+    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3) ||
+        object_dynamic_cast(OBJECT(d), TYPE_CXL_ACCEL)) {
         return d;
     }
 
@@ -256,7 +257,13 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
-    return cxl_type3_read(d, addr + fw->base, data, size, attrs);
+    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
+        return cxl_type3_read(d, addr + fw->base, data, size, attrs);
+    } else if (object_dynamic_cast(OBJECT(d), TYPE_CXL_ACCEL)) {
+        return cxl_accel_read(d, addr + fw->base, data, size, attrs);
+    }
+
+    return MEMTX_ERROR;
 }
 
 static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
@@ -272,7 +279,13 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
         return MEMTX_OK;
     }
 
-    return cxl_type3_write(d, addr + fw->base, data, size, attrs);
+    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
+        return cxl_type3_write(d, addr + fw->base, data, size, attrs);
+    } else if (object_dynamic_cast(OBJECT(d), TYPE_CXL_ACCEL)) {
+        return cxl_accel_write(d, addr + fw->base, data, size, attrs);
+    }
+
+    return MEMTX_ERROR;
 }
 
 const MemoryRegionOps cfmws_ops = {
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 73c5ae8ad9..1f7d08c17d 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -16,3 +16,8 @@ config CXL_MEM_DEVICE
     bool
     default y if CXL
     select MEM_DEVICE
+
+config CXL_ACCEL_DEVICE
+    bool
+    default y if CXL
+    select MEM_DEVICE
diff --git a/hw/mem/cxl_accel.c b/hw/mem/cxl_accel.c
new file mode 100644
index 0000000000..770072126d
--- /dev/null
+++ b/hw/mem/cxl_accel.c
@@ -0,0 +1,319 @@
+/*
+ * CXL accel (type-2) device
+ *
+ * Copyright(C) 2024 NVIDIA Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-v2-only
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "hw/mem/memory-device.h"
+#include "hw/mem/pc-dimm.h"
+#include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/range.h"
+#include "sysemu/hostmem.h"
+#include "sysemu/numa.h"
+#include "hw/cxl/cxl.h"
+#include "hw/pci/msix.h"
+
+static void update_dvsecs(CXLAccelDev *acceld)
+{
+    CXLComponentState *cxl_cstate = &acceld->cxl_cstate;
+    uint8_t *dvsec;
+    uint32_t range1_size_hi = 0, range1_size_lo = 0,
+             range1_base_hi = 0, range1_base_lo = 0;
+
+    if (acceld->hostvmem) {
+        range1_size_hi = acceld->hostvmem->size >> 32;
+        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                         (acceld->hostvmem->size & 0xF0000000);
+    }
+
+    dvsec = (uint8_t *)&(CXLDVSECDevice){
+        .cap = 0x1e,
+        .ctrl = 0x2,
+        .status2 = 0x2,
+        .range1_size_hi = range1_size_hi,
+        .range1_size_lo = range1_size_lo,
+        .range1_base_hi = range1_base_hi,
+        .range1_base_lo = range1_base_lo,
+    };
+    cxl_component_update_dvsec(cxl_cstate, PCIE_CXL_DEVICE_DVSEC_LENGTH,
+                               PCIE_CXL_DEVICE_DVSEC, dvsec);
+
+    dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
+        .rsvd         = 0,
+        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+        .reg0_base_hi = 0,
+    };
+    cxl_component_update_dvsec(cxl_cstate, REG_LOC_DVSEC_LENGTH,
+                               REG_LOC_DVSEC, dvsec);
+
+    dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
+        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
+        .ctrl                    = 0x02, /* IO always enabled */
+        .status                  = 0x26, /* same as capabilities */
+        .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
+    };
+    cxl_component_update_dvsec(cxl_cstate, PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
+                               PCIE_FLEXBUS_PORT_DVSEC, dvsec);
+}
+
+static void build_dvsecs(CXLAccelDev *acceld)
+{
+    CXLComponentState *cxl_cstate = &acceld->cxl_cstate;
+
+    cxl_component_create_dvsec(cxl_cstate, CXL3_TYPE2_DEVICE,
+                               PCIE_CXL_DEVICE_DVSEC_LENGTH,
+                               PCIE_CXL_DEVICE_DVSEC,
+                               PCIE_CXL31_DEVICE_DVSEC_REVID, NULL);
+
+    cxl_component_create_dvsec(cxl_cstate, CXL3_TYPE2_DEVICE,
+                               REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
+                               REG_LOC_DVSEC_REVID, NULL);
+
+    cxl_component_create_dvsec(cxl_cstate, CXL3_TYPE2_DEVICE,
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
+                               PCIE_FLEXBUS_PORT_DVSEC,
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, NULL);
+    update_dvsecs(acceld);
+}
+
+static bool cxl_accel_dpa(CXLAccelDev *acceld, hwaddr host_addr, uint64_t *dpa)
+{
+    return cxl_host_addr_to_dpa(&acceld->cxl_cstate, host_addr, dpa);
+}
+
+static int cxl_accel_hpa_to_as_and_dpa(CXLAccelDev *acceld,
+                                       hwaddr host_addr,
+                                       unsigned int size,
+                                       AddressSpace **as,
+                                       uint64_t *dpa_offset)
+{
+    MemoryRegion *vmr = NULL;
+    uint64_t vmr_size = 0;
+
+    if (!acceld->hostvmem) {
+        return -ENODEV;
+    }
+
+    vmr = host_memory_backend_get_memory(acceld->hostvmem);
+    if (!vmr) {
+        return -ENODEV;
+    }
+
+    vmr_size = memory_region_size(vmr);
+
+    if (!cxl_accel_dpa(acceld, host_addr, dpa_offset)) {
+        return -EINVAL;
+    }
+
+    if (*dpa_offset >= vmr_size) {
+        return -EINVAL;
+    }
+
+    *as = &acceld->hostvmem_as;
+    return 0;
+}
+
+MemTxResult cxl_accel_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
+                           unsigned size, MemTxAttrs attrs)
+{
+    CXLAccelDev *acceld = CXL_ACCEL(d);
+    uint64_t dpa_offset = 0;
+    AddressSpace *as = NULL;
+    int res;
+
+    res = cxl_accel_hpa_to_as_and_dpa(acceld, host_addr, size,
+                                      &as, &dpa_offset);
+    if (res) {
+        return MEMTX_ERROR;
+    }
+
+    return address_space_read(as, dpa_offset, attrs, data, size);
+}
+
+MemTxResult cxl_accel_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
+                            unsigned size, MemTxAttrs attrs)
+{
+    CXLAccelDev *acceld = CXL_ACCEL(d);
+    uint64_t dpa_offset = 0;
+    AddressSpace *as = NULL;
+    int res;
+
+    res = cxl_accel_hpa_to_as_and_dpa(acceld, host_addr, size,
+                                      &as, &dpa_offset);
+    if (res) {
+        return MEMTX_ERROR;
+    }
+
+    return address_space_write(as, dpa_offset, attrs, &data, size);
+}
+
+static void clean_memory(PCIDevice *pci_dev)
+{
+    CXLAccelDev *acceld = CXL_ACCEL(pci_dev);
+
+    if (acceld->hostvmem) {
+        address_space_destroy(&acceld->hostvmem_as);
+    }
+}
+
+static bool setup_memory(PCIDevice *pci_dev, Error **errp)
+{
+    CXLAccelDev *acceld = CXL_ACCEL(pci_dev);
+
+    if (acceld->hostvmem) {
+        MemoryRegion *vmr;
+        char *v_name;
+
+        vmr = host_memory_backend_get_memory(acceld->hostvmem);
+        if (!vmr) {
+            error_setg(errp, "volatile memdev must have backing device");
+            return false;
+        }
+        if (host_memory_backend_is_mapped(acceld->hostvmem)) {
+            error_setg(errp, "memory backend %s can't be used multiple times.",
+               object_get_canonical_path_component(OBJECT(acceld->hostvmem)));
+            return false;
+        }
+        memory_region_set_nonvolatile(vmr, false);
+        memory_region_set_enabled(vmr, true);
+        host_memory_backend_set_mapped(acceld->hostvmem, true);
+        v_name = g_strdup("cxl-accel-dpa-vmem-space");
+        address_space_init(&acceld->hostvmem_as, vmr, v_name);
+        g_free(v_name);
+    }
+    return true;
+}
+
+static void setup_cxl_regs(PCIDevice *pci_dev)
+{
+    CXLAccelDev *acceld = CXL_ACCEL(pci_dev);
+    CXLComponentState *cxl_cstate = &acceld->cxl_cstate;
+    ComponentRegisters *regs = &cxl_cstate->crb;
+    MemoryRegion *mr = &regs->component_registers;
+
+    cxl_cstate->dvsec_offset = 0x100;
+    cxl_cstate->pdev = pci_dev;
+
+    build_dvsecs(acceld);
+
+    cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
+                                      TYPE_CXL_ACCEL);
+
+    pci_register_bar(
+        pci_dev, CXL_COMPONENT_REG_BAR_IDX,
+        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64, mr);
+}
+
+#define MSIX_NUM 6
+
+static int setup_msix(PCIDevice *pci_dev)
+{
+    int i, rc;
+
+    /* MSI(-X) Initialization */
+    rc = msix_init_exclusive_bar(pci_dev, MSIX_NUM, 4, NULL);
+    if (rc) {
+        return rc;
+    }
+
+    for (i = 0; i < MSIX_NUM; i++) {
+        msix_vector_use(pci_dev, i);
+    }
+    return 0;
+}
+
+static void cxl_accel_realize(PCIDevice *pci_dev, Error **errp)
+{
+    ERRP_GUARD();
+    int rc;
+    uint8_t *pci_conf = pci_dev->config;
+
+    if (!setup_memory(pci_dev, errp)) {
+        return;
+    }
+
+    pci_config_set_prog_interface(pci_conf, 0x10);
+    pcie_endpoint_cap_init(pci_dev, 0x80);
+
+    setup_cxl_regs(pci_dev);
+
+    /* MSI(-X) Initialization */
+    rc = setup_msix(pci_dev);
+    if (rc) {
+        clean_memory(pci_dev);
+        return;
+    }
+}
+
+static void cxl_accel_exit(PCIDevice *pci_dev)
+{
+    clean_memory(pci_dev);
+}
+
+static void cxl_accel_reset(DeviceState *dev)
+{
+    CXLAccelDev *acceld = CXL_ACCEL(dev);
+    CXLComponentState *cxl_cstate = &acceld->cxl_cstate;
+    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
+    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
+
+    update_dvsecs(acceld);
+    cxl_component_register_init_common(reg_state, write_msk, CXL3_TYPE2_DEVICE);
+}
+
+static Property cxl_accel_props[] = {
+    DEFINE_PROP_LINK("volatile-memdev", CXLAccelDev, hostvmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void cxl_accel_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+
+    pc->realize = cxl_accel_realize;
+    pc->exit = cxl_accel_exit;
+
+    pc->class_id = PCI_CLASS_CXL_QEMU_ACCEL;
+    pc->vendor_id = PCI_VENDOR_ID_INTEL;
+    pc->device_id = 0xd94;
+    pc->revision = 1;
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->desc = "CXL Accelerator Device (Type 2)";
+    device_class_set_legacy_reset(dc, cxl_accel_reset);
+    device_class_set_props(dc, cxl_accel_props);
+}
+
+static const TypeInfo cxl_accel_dev_info = {
+    .name = TYPE_CXL_ACCEL,
+    .parent = TYPE_PCI_DEVICE,
+    .class_size = sizeof(struct CXLAccelClass),
+    .class_init = cxl_accel_class_init,
+    .instance_size = sizeof(CXLAccelDev),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CXL_DEVICE },
+        { INTERFACE_PCIE_DEVICE },
+        {}
+    },
+};
+
+static void cxl_accel_dev_registers(void)
+{
+    type_register_static(&cxl_accel_dev_info);
+}
+
+type_init(cxl_accel_dev_registers);
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 1c1c6da24b..36a395dbb6 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -4,6 +4,7 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
 mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
 mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
+mem_ss.add(when: 'CONFIG_CXL_ACCEL_DEVICE', if_true: files('cxl_accel.c'))
 system_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_false: files('cxl_type3_stubs.c'))
 
 system_ss.add(when: 'CONFIG_MEM_DEVICE', if_false: files('memory-device-stubs.c'))
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 30fe4bfa24..0e78db26b8 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -29,6 +29,7 @@ enum reg_type {
     CXL2_UPSTREAM_PORT,
     CXL2_DOWNSTREAM_PORT,
     CXL3_SWITCH_MAILBOX_CCI,
+    CXL3_TYPE2_DEVICE,
 };
 
 /*
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 561b375dc8..ac26b264da 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -630,6 +630,26 @@ struct CSWMBCCIDev {
     CXLCCI *cci;
 };
 
+struct CXLAccelDev {
+    /* Private */
+    PCIDevice parent_obj;
+
+    /* Properties */
+    HostMemoryBackend *hostvmem;
+
+    /* State */
+    AddressSpace hostvmem_as;
+    CXLComponentState cxl_cstate;
+};
+
+struct CXLAccelClass {
+    /* Private */
+    PCIDeviceClass parent_class;
+};
+
+#define TYPE_CXL_ACCEL "cxl-accel"
+OBJECT_DECLARE_TYPE(CXLAccelDev, CXLAccelClass, CXL_ACCEL)
+
 #define TYPE_CXL_SWITCH_MAILBOX_CCI "cxl-switch-mailbox-cci"
 OBJECT_DECLARE_TYPE(CSWMBCCIDev, CSWMBCCIClass, CXL_SWITCH_MAILBOX_CCI)
 
@@ -638,6 +658,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs);
 
+MemTxResult cxl_accel_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
+                           unsigned size, MemTxAttrs attrs);
+MemTxResult cxl_accel_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
+                            unsigned size, MemTxAttrs attrs);
+
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
 void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index f1a53fea8d..08bc469316 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -55,6 +55,7 @@
 #define PCI_CLASS_MEMORY_RAM             0x0500
 #define PCI_CLASS_MEMORY_FLASH           0x0501
 #define PCI_CLASS_MEMORY_CXL             0x0502
+#define PCI_CLASS_CXL_QEMU_ACCEL         0x0503
 #define PCI_CLASS_MEMORY_OTHER           0x0580
 
 #define PCI_BASE_CLASS_BRIDGE            0x06
-- 
2.43.5


