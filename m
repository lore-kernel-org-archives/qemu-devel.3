Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07FCEE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voN9x-0000Tk-2E; Fri, 06 Feb 2026 09:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9a-0000Qr-8m; Fri, 06 Feb 2026 09:49:53 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9Y-00070d-Pn; Fri, 06 Feb 2026 09:49:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIQX+8XkWONggyrHW2ACiZcOkTcKCZDgCjhbZaZ4P1a+/Os7X/2DIGPn519BPgBpQjVGdr1WUhl6jMFsZXYUs9fK5508ag6ojxEwSD27QuutXeIac1FdoYYsa/EgJ0yZhlHtGn1KDvY9mxoUG1njed1RNubsMH6e5unTyjIOdMpjR8AQ2O3QhDe5aHVm0hl6KfQKZPvH453dn5Potkf7cYSN8XWcjTFBQejAEFOHxGS0w3mvl61RJMnY8kzLRXO78Mj21knzxpQqoK1iCWcfCGDgwC5MeyG+3TGm+D3o2sNV2cKjlm06KD3RxsAKTUxxxO2wtZvXrjx/U0/VU8LkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr9r9e21nXzho6aqT4oX8tsDw+XyoC9UcwDf3AmaJ6s=;
 b=t5KRaGtQCC3FtYA2A01zuvB7Bln45ZKZYZ5yFHfWO1KoNp6zZL62k028xNirWw+Mf69TWT9O4R8wezq5BS2AIdkKheWUjNPfVkJpnjXagjH6NVxJnFIeALzyTZUYxsv4/2qcDhdqqkN2bKN5sRGbj8xI7Wi3kZ+ZyMcgIk0QwhBiQ9c8bh/x6e9e58tpOeJfbezOdSkYVrB2mOkIrPiMIEgRBWiaWQZWUSeq1tRhb+bTcmtNS5wV3vsQkQIfnJhH+RbaLwbWJxOQkAZQ2K29gYmuXSPIbiHW5fFHGKM1RnpH6J1g85iDtmcYUKzV5aFHwbxfpmjVZkr4e3yN/2lWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr9r9e21nXzho6aqT4oX8tsDw+XyoC9UcwDf3AmaJ6s=;
 b=SVsYtpytVPAelPr3Ok/l+4UdgzRWz6WOu/wdO9auPZD/2utYnE+gderqYIQ/SAF4d2vcqklYf4GDA3CYEBjHVCMEVXt/fMoLjcaoiPg2RZ4ETOP3mAqQq+F8nqjvWVuFLa6NXnXManlrmP9oXINW3dTObsJuSkQ8wTMDKp2c9L1EAuGbGXtmmymwjZlMnTscV/L1GFzVPmW/CTdjQEbPHNIabfJz7vrm2AzotCH80ftP3TEY2w0OHWFWQWtfn8XAQr8VpBr2v5+obDlNu0xIKXS+rQ9nM1BldZ6Qor/t86WNZYXqOSqfAxzOvcxpJzvxchy4lu4eRoAr56a2m8XL5Q==
Received: from BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::20)
 by BL4PR12MB9507.namprd12.prod.outlook.com (2603:10b6:208:58d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:49:41 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::86) by BL1P222CA0015.outlook.office365.com
 (2603:10b6:208:2c7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:49:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:20 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:17 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 04/24] backends/iommufd: Introduce
 iommufd_backend_viommu_mmap
Date: Fri, 6 Feb 2026 14:48:03 +0000
Message-ID: <20260206144823.80655-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|BL4PR12MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 00782ee6-b92a-4ad7-162d-08de658ef59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TzIqLlILGo7UgF8VxhUOIkzA0+RDdfLUup0GkvIhzUvw0aAXhifSnI1h6Paw?=
 =?us-ascii?Q?kAB04Z4JIrjIUwhMpKvzbLy3upzLIGlPPLsyopwfct+6FwZmo/SNCksyD2iL?=
 =?us-ascii?Q?5n1S7vJE05xyrEQFq1hfy2LTxVwPF3v7DlzBtJhKNIXrBHo5FmLNWCbb/GAQ?=
 =?us-ascii?Q?08pnOo/J5l7IuqQ2b+14pOVZv4c2+3hj+4J3iCkCC5okCSJzevgvXnbJTr6Z?=
 =?us-ascii?Q?A2/1sjRREjewKfc1wUxpjkAn0ar9mlzCtnUKbLrqjZgyXSRNLO1sKYPuUm7Y?=
 =?us-ascii?Q?CV1Z5vkWQAjsQ+s5TIa6duV825FGjSL7oGrtbVf13rKyzeSIyHaheOp8isHS?=
 =?us-ascii?Q?CkCEWqHqBcm4PvvoW7tpr40PL9aOKNeYun5FRtACTPw+NIyikUm4sx8B9U8H?=
 =?us-ascii?Q?CdByVsbboi5V70XV2cEzDV5xdc1DGEL/bBL6heBvi9Gx9nfI+4fhH5kWnTfx?=
 =?us-ascii?Q?5I6ki6rpknf2+LFK0lD6JmZjEAhXIbb8sMWVjocEJ8OzjotdsNzjfYaYhIdZ?=
 =?us-ascii?Q?5tb7FpF0peanVobqL+EO23Hrl8zYRhdr2vlpLquqHs/thBt5VSH14MXTw8I8?=
 =?us-ascii?Q?9o+D9GvKxXkZfLbRQrxO5MbFQ62+jKVzVB0+g4CBQOPGZZN3ieFXAXj8ZbTl?=
 =?us-ascii?Q?AA6TemIcV+hoMiPitnSIIIGFyNs1ht3U50h9MLdnX6t+KMOtGlLve0byhyO6?=
 =?us-ascii?Q?v31oFo7Tj/E1uD3bI4FxuThXtJRfcL4pR3J+MyomVq0kXPbsjKuDCe8ZmjC2?=
 =?us-ascii?Q?NqviBL8ZkXfYfipJbnRGZA9avA2mNIwMA8kHY3w5diAwAK9S64CzZASz4NJe?=
 =?us-ascii?Q?tLwjBhapNffl4aXgl47Q8icYzqVKV1yQL5uAXh75q3noKtJpFwGajlsepv3u?=
 =?us-ascii?Q?RdcvcjoxUfyH8Cja3ZHePE/mQuDoQoY8lWnS5EJkYkJZCKds2rKcaLfUxUhz?=
 =?us-ascii?Q?1oGFdFrBVb1S/NyD5inddhki/HnD5VuoYazX/bABlk+vDohdrrkw1rceUTWZ?=
 =?us-ascii?Q?jl7s242vFqGpR7gHMNeMMJGePDFszM24TrAr0lMbxK8/B0EJZYgQEArRI3XM?=
 =?us-ascii?Q?ebcauuBm5REIhH5Ge+SDWDhin8lr3LEuueinsXn9dUcJAQaM1ipz+lyj9pqw?=
 =?us-ascii?Q?cjN+YUr2KiBlL5fKGqbo4ghXXruZXQE4lN3cK6wP2miq1xTS55k9ComflbAk?=
 =?us-ascii?Q?0wBcYuKt1X2NVaonpAYh0oYm/Gu9Gnfl659bK5FijCQCetfd2rfNaF0jFSmN?=
 =?us-ascii?Q?c84EmnmjkZr5/9HJvzIRikLYrPX00X7UqcoFEvTxVrPWnB8LMVGN4hT2BzN3?=
 =?us-ascii?Q?TA01cLR8/gHPiMx/6OmcAIXM1+2P7pkyCNSZRe2ZAfzfXmBIvG8kpoMPVtFo?=
 =?us-ascii?Q?IRfuy0+/+PqxfLRg6+1yp8pDrqzzeQ295AYYYWFYa7SE8zcN/qqJtXweLti1?=
 =?us-ascii?Q?a/HMDWQYBGOsvk+ifPhsc/R9jxqlsy4eAsFPI2WOoKKPoTMdY7HZYHgsA6II?=
 =?us-ascii?Q?zc/tBUjZOQ4MWktdqVfDOUSSw8x2VsB+DNcTERjZcGuacSOGRawaBA1ZPLZn?=
 =?us-ascii?Q?MRWmOHe9OZFBc3Oh4UdTjJtaA0dmL3eSw3LlObRMrY7brjt/kSjzNaqVhoE2?=
 =?us-ascii?Q?mCuGVYnp2Z09HQC2aHYqu1zpUKdH5aNQEYFMwaCRjcKK?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 25ahyrK0zeWJmeLBNZIu+3XiauPBYigJAbvQcXufsnL5SYCDziKRXGaTN83MEbYwZjFhpCo5eAvPxRUyh0aLOufJ1YxlU7LNaJRJPawhMF5S/BFJSfz2op03szExEgHweRY6eMTKtJnMwZgj9UcDGqZjb9hX0imqGfyaO91DiXdviuMdupqWo0tkC9BevcBynBtJnqrAS/e8RjfyqsuAma/nMaHjQupNX/QA2bZwui12BxjiUNRIRh/yZA+o3IB6ldVHlQRWi7OeSLGHnbudwYIPj1v1f+34w/qYgVqTawLwm66d1cGQr96dV7C1OXHZnwNcKkIzdTAbHa+kFwuZ8T4ptJf5Xw90KTyyEvp4hbSuBFkCwIfLTRiWxbCdS1P7DI5AlQRLO3nBnjze/UWrTaAtJiLQZD++KWd43qrWRE2elfTujZDEan/TsxwMSWrm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:49:41.1656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00782ee6-b92a-4ad7-162d-08de658ef59c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9507
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Add a backend helper to mmap hardware MMIO regions exposed via iommufd for
a vIOMMU instance. This allows user space to access HW-accelerated MMIO
pages provided by the vIOMMU.

The caller is responsible for unmapping the returned region.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 22 ++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index c6b79da0d4..9e30501d38 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -578,6 +578,28 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+/*
+ * Helper to mmap HW MMIO regions exposed via iommufd for a vIOMMU instance.
+ * The caller is responsible for unmapping the mapped region.
+ */
+bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
+                                 uint64_t size, off_t offset, void **out_ptr,
+                                 Error **errp)
+{
+    g_assert(viommu_id);
+    g_assert(out_ptr);
+
+    *out_ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, be->fd,
+                   offset);
+    trace_iommufd_backend_viommu_mmap(be->fd, viommu_id, size, offset);
+    if (*out_ptr == MAP_FAILED) {
+        error_setg_errno(errp, errno, "IOMMUFD vIOMMU mmap failed");
+        return false;
+    }
+
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 3e70338750..f824a8d197 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -25,6 +25,7 @@ iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t queue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t queue_id, int ret) " iommufd=%d viommu_id=%u queue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" queue_id=%u (%d)"
+iommufd_backend_viommu_mmap(int iommufd, uint32_t viommu_id, uint64_t size, uint64_t offset) " iommufd=%d viommu_id=%u size=0x%"PRIx64" offset=0x%"PRIx64
 
 # igvm-cfg.c
 igvm_reset_enter(int type) "type=%u"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index f72ad545f8..87ddc39041 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -111,6 +111,10 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
                                     uint64_t length, uint32_t *out_hw_queue_id,
                                     Error **errp);
 
+bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
+                                 uint64_t size, off_t offset, void **out_ptr,
+                                 Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


