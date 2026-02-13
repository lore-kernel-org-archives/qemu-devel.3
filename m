Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD891EDF151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqds-00085h-F3; Fri, 13 Feb 2026 05:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqdm-00084W-I0; Fri, 13 Feb 2026 05:43:14 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqdk-0006RC-Nh; Fri, 13 Feb 2026 05:43:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jn5c44bh8JAaXYWzCgNkx6amcnL6ysxMm1X2yCbnAShZLKXgqAEvDpgIOJrJ7Eqg3eUpzaQ2ZGgj3HVmWQScpbiuXPTQysEa7NUTMuzEPcgwQ5l0w0si2i6gAk6WD22BidoDypK1xkyNWW0kQ5EmAS2/QEmBVqD3VOZt7lrlSvUMlNPzJCF7GR6BnZWePYTXqUAOVGhDZftJZn2qdeGo3wM/efnvhQxBGRrVRXKMUhdTAzN6d3Ar0gHCRS4NSeiWz3CxCIy9Gafw2Qff4mavc/Wr+lhVBl15l3e7KOtQoIH7quWhlcwX+wWwF0FKKKldVVgEnSLW6wBiJnUVhAho9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxWp6a3HwZnmqXb+bhBKlmUo1MCnEn8NhVYJwJHgVh8=;
 b=Jw5y6YyhUqgYeoGGruaWhxNeZzZCBuTLQlflavB3EA2tAJogDkHGvweQkRuw/9oHQiRr9w2GqiWCXlEX9UYX6tfJ8LoEFD59OfXQa03p2CwnOUKiuZ+PTOVCgGj5PY9xTTyrQoKxq3cQ5FPmCJICvLoBSCZLKreWOsrctjlcFVkdmCQvmnnoinsVXAplcD9m18mtad4YpwMdgHrCu3yYe493q+qqRQ0loNfl6F9iJyLGWZRWoRAyNJcsaUWLjMfpd37cer/2gh3HtrSegerqYPSN6PZ/vH+UMbiF7AiffR4trs9kfoz58no+obyd7ao9EwX/ZUERFZNOCFEFK2ezSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxWp6a3HwZnmqXb+bhBKlmUo1MCnEn8NhVYJwJHgVh8=;
 b=r3aswSSBfvwyRzfH+sKVyHcI1aAlPWmLwn/+dQ2vP/yz4+WY1BN1MSiZOgPtxL0tXEh6pKY7D/Xfj2RyyHbbqTAt+X5QmIO1Vzxj+Dv5YF6R8doFe5OOSlLy11caekGFOydFuzpQxeu7/QiKKqhBwg+Jty40d5lI4IluAy5mHSjqiAc1pMBEEuxvuQizfYa2vK6q+qUNYt7Yll7AqEhs4UQuTSIeBNJ/Ljm6CnxKc9CWJeHayuXuDxv1zUxYGalqQNKqJIVzrKiFV+eM8oo+IeXlbReHumXyGND2AzFIZPxqkEziAGXjwUtx6SfPBmhZNlGkRQty1+PBe4y/YVHCzA==
Received: from BL1P223CA0043.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::9)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:43:07 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::e6) by BL1P223CA0043.outlook.office365.com
 (2603:10b6:208:5b6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.13 via Frontend Transport; Fri,
 13 Feb 2026 10:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 10:43:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:42:53 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:42:49 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 1/5] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Date: Fri, 13 Feb 2026 10:39:38 +0000
Message-ID: <20260213103942.142823-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213103942.142823-1-skolothumtho@nvidia.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2ea19e-b50c-48c1-1ebd-08de6aecac36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PWGbDTB6EgZjL/ALqn0TRxsLsa8MW7nwWkavW68HTSgRv3xZR2u8FdeYTnQ0?=
 =?us-ascii?Q?5hm+FJG7R2yqSCjrFWGpc1ZolUNQoKOnQbmzFwoPf7owknSW8vwdGrY+zGyf?=
 =?us-ascii?Q?bDkEhmHnP0jX0TPNsGWuXSaisL0rho1OXy2coOgQxd019orrZl7uU0uIWfKR?=
 =?us-ascii?Q?tb/TxzFvwSQ4nZe/tEMlLGwMnne2czl+Fb6zMF7Y0DRhhLdfl/HKcKAmGmDl?=
 =?us-ascii?Q?0lo32sJKCsnh2fvKhGpNcT6msEdtEkD6wV6bnHLKyunvIEkVizUXxUm8Qhoo?=
 =?us-ascii?Q?OK6IP75RX0pFGUp0wjbsU5VpUhJo+WUvEOXpJR+iv+bJRA33MNgyyHneTR6r?=
 =?us-ascii?Q?4myv1TrdMbsleuKnQyRT9zfbd0DCkspAUl1XdkVJu/I8bzPrQtT2RaVE85kc?=
 =?us-ascii?Q?utNh1/I+L6A6LM6pcaorOBxlorkmiIBCOmMapDCVkbD6JchXNGL+vVPAgfHP?=
 =?us-ascii?Q?Qhc5MEUTMFCZnJgyQhyYPH4IrfD+Ck6/AeZmFxGHVN5RCT3ulHaqcHF0wzd4?=
 =?us-ascii?Q?GK4Z8c1RZ0NlUlC5SUYcbm9gJtiUEOUXHZLwAVnfK8mVP+79yPGTlYMgj6p3?=
 =?us-ascii?Q?ioWSDn65jrzv09da1ed/1+dCscixxcXCbZBbDxMME4Z0Uh0QozdcWM4NoNKT?=
 =?us-ascii?Q?8cd7qtMwvgv2AgkfR/FMBKipDWFWTXXVCd3EUqyndVlhGpbz+DSOTzNgOHLy?=
 =?us-ascii?Q?XJ/xeSLEcx+Nh8Od7XKBG9IL39tPM1hKAVyoGKio4XVOX4e17kIBG0Pqodw7?=
 =?us-ascii?Q?PO0f0sZfwQ8O6q7mhrC1DUMxPMyWbyF4skTJrkQnXwSe+sEp5o7E3MwQNfKU?=
 =?us-ascii?Q?k3sMZhnGJAyhP+thhJ2BIIINTlQhw1nMuI6ilQEQSsBOCHQr45N++UZQN09L?=
 =?us-ascii?Q?X5S4+ydLmsr3oreWD7eYHkid6LPK9RaxglB6akQtGfEzuvdb9sxwctBqrVdv?=
 =?us-ascii?Q?NjwzXaJwwyyC9eHY378NFkkLmYM2WpAUcNYBllWaiVZegEOwSpPBUpWjmY6F?=
 =?us-ascii?Q?W5ZmdZMY9ct61zBFZxxIYtZjGLlOQUd2aatHVsavCn7WZ9R8Rq2iVlbZlM2k?=
 =?us-ascii?Q?s22PBTaM3JCkNNRP/1tqnC6RO2lVRPN6odSfAOa6nTPg73emOB0q93IxH2E6?=
 =?us-ascii?Q?/B7ZCfNWvs8fjeGHa98OvbAYHVrnHTqzYL4aaI3uOlOJx9zNoLfCj7RNkyEY?=
 =?us-ascii?Q?jgiya1UIAZxK1im2zEWxpFu3DcbS7kjfPdJVcuKZ8y6ue0kzjRpoyobPEj6P?=
 =?us-ascii?Q?7FaSgrjfAvdIHv3Khx5yOMknCb3Nv0PCyL2iwY/VPAgHWcdhexR+pOogV25h?=
 =?us-ascii?Q?eXhhXhQjhwKeNKZjzqDM6ZHrkv+jzrykB0dZjkiZIArKWz6VG7ibGDPrudH9?=
 =?us-ascii?Q?QpUv7lksjsyf1u+vAgejPUbr/WSabTJ3zSH4p7SYbpZb60+AfyB6GZzt5igT?=
 =?us-ascii?Q?zWtLk4w76RKTyziKAXiV/3KeJXrwgCB6WsM6niX61lFx5Tq1lll8ue2P5JkA?=
 =?us-ascii?Q?O3gsI7QS0OsyZPXBKGI3CxQQlIU8Y+AreDrl7QFeRjmzVmulsh8P81PF8NiE?=
 =?us-ascii?Q?8Vz6cJTL52mkjEI7EGDk6I6G5XA/dJ50J7G7Nl4cs4Cn7079rtjXs8JJdlaJ?=
 =?us-ascii?Q?p8Z0TvyqL8LnYArh1XiXf3UvC8LyhnxMH+HJnliMb/mv/Xn7CwWqwrkI5Nmq?=
 =?us-ascii?Q?Mg2sAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uk9wTfd/mXazaQshEd/nm4xYKlrPvT2vlbEpMQg1I8qlrKTFY9TDmPVPsla+2mfSbx0OYFaAWyElagN3Rpp/NUdCztLLloepLwCym8GmucQuhh02rUwAcL8PzWa0LmrrY3tv68trkDQkQvvQOaAsPI61V9lxaOMNuYxLSZ4XYWKk+pIst9o7FdKwTpy7z1fVWArSOjrVKlGtGPPDHR9WMKSR8wHXDJCRCQTFl2FEa52/655+CYPwqmC3ekSo0PV/773ZNKZfss1nmk5Hyc6v3RvoxrGIYEXMtE9EGdfwuxhW8PMqPvdzPu90L0I6Szzly4/9vTS+aHgo842dfDQLjCMWp3SDbS343Zq0EFpeuPzy9rMDqMmV4OKcp9vQsZX4C96kbYvT1j9kI7jrfaDpA61Kn+5MlY+uy6cvheV4HkkAObMBNVMkcTNIsWUokzht
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:43:06.5031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2ea19e-b50c-48c1-1ebd-08de6aecac36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add a new helper for IOMMU_VEVENTQ_ALLOC ioctl to allocate a virtual event
queue (vEVENTQ) for a vIOMMU object.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 12 ++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 13822df82f..acfab907c0 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -504,6 +504,37 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
     return true;
 }
 
+bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
+                                   uint32_t type, uint32_t depth,
+                                   uint32_t *out_veventq_id,
+                                   uint32_t *out_veventq_fd, Error **errp)
+{
+    int ret;
+    struct iommu_veventq_alloc alloc_veventq = {
+        .size = sizeof(alloc_veventq),
+        .flags = 0,
+        .type = type,
+        .veventq_depth = depth,
+        .viommu_id = viommu_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VEVENTQ_ALLOC, &alloc_veventq);
+
+    trace_iommufd_viommu_alloc_eventq(be->fd, viommu_id, type,
+                                      alloc_veventq.out_veventq_id,
+                                      alloc_veventq.out_veventq_fd, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VEVENTQ_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_veventq_id);
+    g_assert(out_veventq_fd);
+    *out_veventq_id = alloc_veventq.out_veventq_id;
+    *out_veventq_fd = alloc_veventq.out_veventq_fd;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 8dc64a20d3..b9365113e7 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -23,6 +23,7 @@ iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, u
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
+iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 
 # igvm-cfg.c
 igvm_reset_enter(int type) "type=%u"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 80d72469a9..e4ca16da70 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -56,6 +56,13 @@ typedef struct IOMMUFDVdev {
     uint32_t virt_id;  /* virtual device ID */
 } IOMMUFDVdev;
 
+/* Virtual event queue interface for a vIOMMU */
+typedef struct IOMMUFDVeventq {
+    IOMMUFDViommu *viommu;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+} IOMMUFDVeventq;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -86,6 +93,11 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t viommu_id, uint64_t virt_id,
                                 uint32_t *out_vdev_id, Error **errp);
 
+bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
+                                   uint32_t type, uint32_t depth,
+                                   uint32_t *out_veventq_id,
+                                   uint32_t *out_veventq_fd, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


