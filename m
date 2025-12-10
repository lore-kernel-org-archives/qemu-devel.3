Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B75D3C54A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPH-0007Nq-Jm; Wed, 10 Dec 2025 08:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPB-0007Km-G3; Wed, 10 Dec 2025 08:38:59 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKP9-0001Js-RG; Wed, 10 Dec 2025 08:38:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJy/6t8QrkWgvSoMYWEHVsfkv3noZKp6XUio8kc5+rNz4VsLxXVpSFE23q72UwBRF5A5ac7RDOfHvE1g3S2nDBjwPvNrIxX8tptfAWzRyJMaueYbPvpRqD7OnDhZ+onUopAxNAbCi9I3A+6iu2Rjb8mMqFW1SY4/vrmvgqBX1xvK7M6AH6FuHmbMBFe94nxBb6b4A+MaWNyO88NiUPQVrj9POkNg87BZmapsp1n+ikCMeJieeaO9JBuwvTCK4FOLm0tfRLjXGqoBeIme2uyWoHb+/qPe0MS7DRMPrkYPr5xZQK0W/rovVQ/elrLnaL0B/wdOoi6/c2ne16RUnILJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP6KVyOG7h2wN1mKaMAfFP2+zxNFMJRI9I3onlmNOYg=;
 b=w2Vj2qSgpzKNljHEMXSk/8exMO8vgyRCEM4dF6V5e2gBMZt6+lTh1zUoi1bvjZxj3m6isdd0n2TxpWOdpvQpBMUMwQwLk4o7ghJITGJo3g1ZPOYSE2DOTxxRU/5/Zgv0dveBedtIL9UgB6Ly6Bz/3RtkcF6Eaz8V5vfZu4kF/L+NntlyNCokLw42ElP208yVRpstZVyRA7wWK4dpX4GDRCrdRMwwD8ICYYVTYo/xsmaVE5NIF+IhnkOAWF65yLCilwkv100peehpLh6cbGmF5VEtQAA0L7Tka0Ch5yZ0bqLpc+PNu1Jl0J+wJXsWAPSKq/9gNy8UkR88iZxOJCQ79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP6KVyOG7h2wN1mKaMAfFP2+zxNFMJRI9I3onlmNOYg=;
 b=kUYlbRmBKQ+nXpqi/iWetNmKTjg71ELV5rKgHWXPe5ijRluYozq2Ce75EDFRPONygLYeXaUx9NiUYPN7dthcmHATTZSNN01oGYNfSGrkrJnQgWLycvU03Xi8BYl1Fn1e9gdG44UgyvxqA8Ad6wXzlG7h3gG0y6DO0Oh2sYI5E+g/h/6Mu3dozDX0Arc4EPgn9z370pAoZ3jI6sc6iqIGsz+mAZQcX/NGcc9wp4IFOhrElz75iBvwYLd1ylUOvd3UmpQCfwdJ+1aAiIM15W/68i7tk9rxMDIGTV8QDMvEzkX+MWcb6DG6JNKnmxCctxUz/bN7/eGoZ5S+Fovp7aofQA==
Received: from SJ2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:a03:505::23)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.6; Wed, 10 Dec 2025 13:38:47 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::23) by SJ2PR07CA0021.outlook.office365.com
 (2603:10b6:a03:505::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 13:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 13:38:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:29 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:26 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 04/16] backends/iommufd: Introduce
 iommufd_backend_viommu_mmap
Date: Wed, 10 Dec 2025 13:37:25 +0000
Message-ID: <20251210133737.78257-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 626baca0-9ece-4d61-720d-08de37f17193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rwFCHtTLw6tJcohI56vKASR6Ylx65TuE1Og9m1wI858LZ/Gnfi7QP7oAHUfF?=
 =?us-ascii?Q?66YJV7N9TyB5u66MR8V/mRAxLrt7Lclogacw2JQqKfn6Hbexa9hgG2B16+IS?=
 =?us-ascii?Q?K/ZbdqGwhsUNdj5r0/TgTano982/L/CTB3AuVHnt9+K2oh9Ug66kTnmYvUTM?=
 =?us-ascii?Q?slRqBsnSzS0OFnr3wF6A0hndz1ekEvbdp3RA4T7vzu6l/kL+SgkdthafkwCN?=
 =?us-ascii?Q?gTmCHVqH0VIBjHNXywFtugJADx73hfHw+XqRd12aOaeUUbaBHcaRVPtv8E8M?=
 =?us-ascii?Q?Z64YbhH+KmyGcI5MEtW6BXavxC330MoLwtAJNkOG1ZdtbK2YN7mRutq2TQV6?=
 =?us-ascii?Q?jaDxDoQejRi1kvHV1+SeboUFir2EZ3rsq9wb92sZFoZcdFsGXswBt2O/zbQN?=
 =?us-ascii?Q?QefstzNbWEh95O+KnFvhb7mvUr4UHEGmr1voYCi82uuS8wQU6oiZ0LGxyZVW?=
 =?us-ascii?Q?HYAUsjl+s3Mh7NyPDjHa+W8r/TVVum7mpbqzNkK7oPrqmLdQ4u0B5OEfMfC1?=
 =?us-ascii?Q?6YlRjOns3SA/ZZ0IFbGd6AsRxncHmzirH3bdHI1yRL41WHyrybP8XggPQGyF?=
 =?us-ascii?Q?L0iHOwxxIIts1rOb6WlERA+495FkJBfdLten7po48LCc9OqWmO5m/1e/sMlC?=
 =?us-ascii?Q?CEor+/EPIK74smRC90/uG5qJfIEtWUAft5oTtp9N2vhbcY0oEY6dEJBDEZqC?=
 =?us-ascii?Q?G6Nnh7o0WCEbTrrMSS85gvqKffEHZpntB59pCS0bYeH6kQ5D7+jMMncPMGD5?=
 =?us-ascii?Q?hVNG1McD7MJFKG8Q+vH0ctc9XXH/PKwEVvAUL6Jl0GD61Vgzce25zJKuZAH/?=
 =?us-ascii?Q?frqZCmX73zhIHHrWEnyXCFM4lbgsDfRod4UEIX5q3qU9V5NtcbaBrzYLuAiv?=
 =?us-ascii?Q?Gs38Hgsn2GUCFuA/Z+FH1cyqcsGcdZYVrgvGutBaY+3hQtlr+DTEDF+F/YGJ?=
 =?us-ascii?Q?1QxBUz1G3eNVbgDW0jp6Xjlp/lkO2gKrjrNWK2LM6HxClJtZOB9cY6Qkn6jT?=
 =?us-ascii?Q?MtFb7ciAb8nxkRI+vJdJs6St94Y/1B3ER0WRDFp10vNfETTvutlbg8UNwdUf?=
 =?us-ascii?Q?ghSqiXtQZqB9aYauf/QgMVeUSPzBa5iN3ypgn+mZjkknGvax8djbDJQGOx8p?=
 =?us-ascii?Q?eNlDphjlcLF2D06uxbcpC749UtM4CyvsdsfQf0mqKxoMgrHS9Ka/9wO6n+nX?=
 =?us-ascii?Q?OmZIgassMvr7D856lhPgdOL+HfRtcWFdJELW7M27GjpKMn8jE2cV6Vd88yem?=
 =?us-ascii?Q?tQtvqlXjcdddzRbmCIa/al3wxw2G+UNcPQA6jkaX0f/ofrZe3xUjRk0pCT02?=
 =?us-ascii?Q?l5EUFmexGKvEBVQt/6e4tgSQ1VLF+u/87KK0Rd7wYbpwmuCuXzOgY1z5+lMe?=
 =?us-ascii?Q?bsG9ZhL3Y5Z32acAaEMLxolGdNO9elzHGIsdK0fLuKsOjn/6Yuxsd9QTvKQy?=
 =?us-ascii?Q?G9dS35jaLck+a0GtHZNkQrn/DML0xuXJJdFiCb3jTR0WpqCx9GFs2MHAi6ul?=
 =?us-ascii?Q?eC7AjmMjzoxLCpON/3qVjI/y/cEsTMRoSRXOwf1BfDlULEq5oiQXpa3x/g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:38:46.4390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 626baca0-9ece-4d61-720d-08de37f17193
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
Received-SPF: softfail client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

Add a backend helper to mmap hardware MMIO regions exposed via iommufd for
a vIOMMU instance. This allows user space to access HW-accelerated MMIO
pages provided by the vIOMMU.

The caller is responsible for unmapping the returned region.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 24 ++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h |  4 ++++
 3 files changed, 29 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index a644763239..015e5249d6 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -575,6 +575,30 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
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
+    if (*out_ptr == MAP_FAILED) {
+        error_setg_errno(errp, errno, "failed to mmap (size=0x%" PRIx64
+                         " offset=0x%" PRIx64 ") for viommu (id=%d)",
+                         size, offset, viommu_id);
+        return false;
+    }
+
+    trace_iommufd_backend_viommu_mmap(be->fd, viommu_id, size, offset);
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index a22ad30e55..046f453caa 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -25,3 +25,4 @@ iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t vqueue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t vqueue_id, int ret) " iommufd=%d viommu_id=%u vqueue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" vqueue_id=%u (%d)"
+iommufd_backend_viommu_mmap(int iommufd, uint32_t viommu_id, uint64_t size, uint64_t offset) " iommufd=%d viommu_id=%u size=0x%"PRIx64" offset=0x%"PRIx64
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 9b8602a558..e3905c9a40 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -110,6 +110,10 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
                                     uint64_t addr, uint64_t length,
                                     uint32_t *out_hw_queue_id, Error **errp);
 
+bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
+                                 uint64_t size, off_t offset, void **out_ptr,
+                                 Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


