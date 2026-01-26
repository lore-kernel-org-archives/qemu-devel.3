Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC03CF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKBI-0003Qz-R2; Mon, 26 Jan 2026 05:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKAm-0002BS-AC; Mon, 26 Jan 2026 05:50:20 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKAk-00069S-O2; Mon, 26 Jan 2026 05:50:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkW8bKFWBghYnICL8rXgUw17Xp/JOK5YufNdW/goARqNT80/jmuNwqKkoXabiOwCAckOwlh5XQFfvNsIkTmtjtLzGx5OpcgBwEOn25l1Q39OMBr2EwNQSsflpYlKp2j6TmlL/JUvTwiWSAOvQ9CIur5x4zPQz0nghmVrmJDvPLuv8DRNIndCaFJpZ7ijE5mKyiA0L4QyepVN1UtLA70DGhiFgw2uefcdvs+zVzvNbg2gBvLYbcEW7UegKdx0UwNIPgnLt+qzPoMT+0c/RxTUKd7ZJ7hdonhmJWs4c1BqxlKlbOfjX/m2YaCxxG5U/Vff52X7fJowVZiNCHHuOROSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmM4cORkcprDrP5Ena+1uLLf1dDIBdMqxcuRP8CvyG8=;
 b=t5v8Z4kjqSVy43YAqohX1rMVN7HRGewcuHbJFeGQMUs5+dddu7qmkWCDtP3TDHJZsJySFJ9/ya9v9AhG3xv0jMstoygHMGRy5mDLiS1ke8oI95cgwAnSEhyA+uAgPz8uFXWoOKe+9QRU5ShWQhPyvPr/oAyk14R5IEGVxRK9BvFtATIZ52viTeumLvkj8juM1BBaGPi52pxrQP/VpN+ZR9XK8H4EU2TWOeQviOS7trF/fePxjDKGB5exXcRuVSe9NihFatTC9z23S1kz0YZrxootE/LLf5bZh7Wtwx8oY+7psMafM7VoxRZLSARSWAVQpr38P9x8kbaHsPWsavU1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmM4cORkcprDrP5Ena+1uLLf1dDIBdMqxcuRP8CvyG8=;
 b=XhZIQKGFpKwhPDApMU4yq6b6fCKXGrhsH+4F+8uaBr062qn/gllc++rMLrh+OaJDWFoyyJ4cC3y24+ay1iMSHxTZ/4RRfS8n6Tw5F1s+k3Afz8KJj0ARlRH7F7MXvMquUBLtVbpIUNmuS3phgOp+BTp9khUO4tpjW0n/JaaiIjZcnPwUvrB3m4hgmrtLOuPR0vb2t7kbUGLZVcd0eyEntuVmNl0clSc0sk5ybR9jWVq7y+qi2jZi8kUc43Hgy45J3eEeOax7D2HCZCb8cpGiMOAJd4wSdu6loiqiWl0yAupOKy0WLQYw4edkwsMXrFM/mkIXasH6GoXmfABZnWVdcw==
Received: from SA9PR03CA0009.namprd03.prod.outlook.com (2603:10b6:806:20::14)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:50:12 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::3a) by SA9PR03CA0009.outlook.office365.com
 (2603:10b6:806:20::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 10:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:50:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:49:57 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:49:53 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 33/37] backends/iommufd: Add get_pasid_info() callback
Date: Mon, 26 Jan 2026 10:43:30 +0000
Message-ID: <20260126104342.253965-34-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 7637926a-caae-42c8-d6ac-08de5cc8aeae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9tiz40ixHSmukEUw3t3FO92lmDKjHLVDEI1g6QBRLFmrl/SEeSW7vdC1AQcx?=
 =?us-ascii?Q?o8RGAeCdxabzQ75RlHsvlRduMXgGEbx8BUqhTJAGghXTvc+GvD8s4VCcUA5C?=
 =?us-ascii?Q?NUDhzGDk18HE+mmADWElxZBd3TEWUNCJb4akmftd+jbXkNRJsc/AZUmP49dc?=
 =?us-ascii?Q?MQ0jgtEkuUeZxz/oQBILguxEsxauG4tEYiHqhcucdNOyKLGRcRUOZS+PSN40?=
 =?us-ascii?Q?kYKiFB+J5Dww6z5YWXtAQ+1U7xXcyKS93NQoZFkehyp2/Qi35bB0iHinm+wH?=
 =?us-ascii?Q?TnbFvCeR6oFRgx4402spH87oMXuGkgIDXhNniPyG4DfvK3PsBMiHTO4hNG9o?=
 =?us-ascii?Q?diBDV6mBVk7v8pIDKVlH42YbDA6fz3WJk2N3aM5aCxbWN9atLopjhc8d1OOM?=
 =?us-ascii?Q?RqwIFNNug1MvN/5eJFrmjsHACUBQFR7Vk6A/BeC9RlIzQX2qhEZiXeObaajr?=
 =?us-ascii?Q?s4EI1IoEzLxgMNdzSWjwBN3P1v5Xhun/tWGG0FmYadMBHaoWkM2z3xti6ie6?=
 =?us-ascii?Q?2BzzSp067qNcg/rvd9s7h0KSvPZDfBH5/DeCFchk9XfQmQEUwqseFieNyI14?=
 =?us-ascii?Q?qzc5Vjrp9zdffKkVx1O2NukvWGRgPGx5lZgzDAv81U7IY0Hp0aPhTD2y6Emf?=
 =?us-ascii?Q?UxCJqm1i4qhh8md4kybOs3X5qMeAc81GmPAsfJUlHM1DffCOoA8jrQMQj4Y9?=
 =?us-ascii?Q?XgdnmBaCNYO04q6xeWDbu0liT3Y7Y0QyF7okLtCF9Dsp8qbwtAm2YfigJiJH?=
 =?us-ascii?Q?/A0mc8ucGBZIH3vxnrZCYqcbFxtT381NMo/u0cwNEkD8lIIyhxATQsDApF2C?=
 =?us-ascii?Q?eYG6YuEQmpFRel0aF3y9xZ+EDfShTwuvstYLO/6CZqBcAxiqW4eV8hitooeI?=
 =?us-ascii?Q?EdZOC52qkKd79GfHhiXqj48YalT8GcbGHhHgkkSVdwUPclYUg6c+kVvD5NGT?=
 =?us-ascii?Q?atJhHuDfalfMvvqr0Bs/rHRBl/m6SyJsNG9OwuaBNUNdcwJA1sxnsWj1msWC?=
 =?us-ascii?Q?YHPlLN7FRx+o9FASBd6yTJgYsk+Dn6sze4blj/hzGn6YW/+44ABG+vuQbiUn?=
 =?us-ascii?Q?GVAA6BR5qjmwlGhAq4PngOFzcnD1foyoGj4ZSdJu/5t/Zec37mdPKZYK3x3h?=
 =?us-ascii?Q?j0djOQ67kgS4VAuY57lU4zpD8ckTWm7lwXaHcH3Nlw8vX7XcdQB3N9vJTY7J?=
 =?us-ascii?Q?Y3l4LeyuWfHZdd5mtHQprfIT++04Oub3ickho7RrJDWaAEksxEikt6urIuih?=
 =?us-ascii?Q?DPI+0wR9EQtdiyFY4bw8jGCkOSpvHSkccBllxbTvZGPTyn26utmrdIy+KntZ?=
 =?us-ascii?Q?MVFj8ICDEQjX6lDrLKwbu0e3rhx2oBMDnu0nwQbREUisWShjZLuxPSS8X7ly?=
 =?us-ascii?Q?UNSGnd2Xzy5Lhitd8lOFcHEFiGcvdsxgQAgnM4nEK6wC2u43is3jbP5NybFh?=
 =?us-ascii?Q?k3DRN9Ek+2rF09nzd3aRUHI2WinK07iaRf2im8bkRaIZtVkQYnk6utosA3hP?=
 =?us-ascii?Q?9pK1smC4tIThW6I9St+C+bCViVxrh1PDDUal3KIF/Kndhg8gltyGe1LYFFfs?=
 =?us-ascii?Q?Y1Ox/FU4FZhmdP9mNI5mTuWEmnt3hJR47J1xn90ylDZwtbgPXiH1NBsaZadF?=
 =?us-ascii?Q?AA2CYsW3Z8YP6aZ59Ivt3a0Nh27zrx7lMuOTfHM6Vh/PWRhUHDTwcozoDtNV?=
 =?us-ascii?Q?3haH+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:50:12.5680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7637926a-caae-42c8-d6ac-08de5cc8aeae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

The get_pasid_info callback retrieves PASID capability information
when the HostIOMMUDevice backend supports it. Currently, only the
Linux IOMMUFD backend provides this information.

This will be used by a subsequent patch to synthesize a PASID
capability for vfio-pci devices behind a vIOMMU that supports PASID.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c                 | 17 +++++++++++++++++
 include/system/host_iommu_device.h | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 9b63d74083..13822df82f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -539,11 +539,28 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     }
 }
 
+static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
+                                        PasidInfo *pasid_info)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    if (!caps->max_pasid_log2) {
+        return false;
+    }
+
+    g_assert(pasid_info);
+    pasid_info->exec_perm = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC);
+    pasid_info->priv_mod = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV);
+    pasid_info->max_pasid_log2 = caps->max_pasid_log2;
+    return true;
+}
+
 static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 {
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hioc->get_cap = hiod_iommufd_get_cap;
+    hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
 };
 
 static const TypeInfo types[] = {
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index bfb2b60478..f000301583 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -59,6 +59,12 @@ struct HostIOMMUDevice {
 #endif
 };
 
+typedef struct PasidInfo {
+    bool exec_perm;
+    bool priv_mod;
+    uint8_t max_pasid_log2;
+} PasidInfo;
+
 /**
  * struct HostIOMMUDeviceClass - The base class for all host IOMMU devices.
  *
@@ -116,6 +122,17 @@ struct HostIOMMUDeviceClass {
      * @hiod: handle to the host IOMMU device
      */
     uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
+    /**
+     * @get_pasid_info: Return the PASID information associated with the
+     * @hiod Host IOMMU device.
+     *
+     * @hiod: handle to the host IOMMU device
+     *
+     * @pasid_info: If success, returns the PASID related information.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
 };
 
 /*
-- 
2.43.0


