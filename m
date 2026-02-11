Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B27EB597B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 08:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq5h6-0006SH-VP; Wed, 11 Feb 2026 03:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5h1-0006PH-F9; Wed, 11 Feb 2026 03:35:27 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5gy-0002ku-Iy; Wed, 11 Feb 2026 03:35:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbFsJvt5i+IjerxbAtWEQadAUmGpFsewC/HxMJggYNIcnvQYAfQAPRwYwVeFbSvKZINsXn6/8nfDO13xKy/enmHJ8VYrJ5+ds1KWiQGNseRBSXhZMsYVetg+jigUenCt4IsFOgA989Nln7JVX2vropJ2QncAnf4ulxsYz8+RBrlamZHkgrZVlSdfYLIsDvGO6HCGCya4b303y85f99JJsEh2CUVj0TWIi0aBF0uOCx1nKEAA6ZLB4JcuKfRBNnqe7XwlOltQBecq/2oHt5XiQ/a7YiNhKJuxxAS7URw25yK0ctbnKeKeJtdZqmVpCZLypMHJf30wV35gmY5OiwGgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxWp6a3HwZnmqXb+bhBKlmUo1MCnEn8NhVYJwJHgVh8=;
 b=SkWpzqbstoSOjnO3+p210z+5E+C79DI+nbHKl/PyYJINcDcZFDtR8fVFy+0Ny7DzbPfHuo5Ovnl1Rr0fkBAoKHg7P59E/R5r/9XJzJhPJzGwMHQMpn48nHHxReXnfXr8uPSUuHGF9QtnICWm9sVntTHU+mDwW6HBwVeoniLD83j2xH+8cRoKTg5ypBUuT30K+nY16JHHXImpCDHgaV8Q/MTDb0vbfQ60Mhj14Hwo0XVm9GZT8vrPupcfaS1/aV9c/mWS++irgJCJlTHQCmjhNpP7doudwoVKoWexJlProVoFZ7MM6DwxL0eH+Kj08XrpzQ9AaO+d6THYlIaqc0giyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxWp6a3HwZnmqXb+bhBKlmUo1MCnEn8NhVYJwJHgVh8=;
 b=l/3cwc+DQrKIHFSKnMEppGG3qRX64cjR+yn4ZsLVC0uPxXcEg2zWlhOjKlWD+F50fPfDJcpv1D1jHaDHLdN9HbWUkjJSWjKlO1JmcmNhOD8I+D8xvKtCq0VxaPQYUkMyxefx1KWlVrRxmh5kEe3sUajMrac4rDp03Q+87E5OUuow4qlRbhvSMXccadjUPPd9Z4oe8+VRs82px0osMunYqwSagJAKJQz5Ov36oAcyl/VgO7uTgaqztTRxTJJP/b3/tkHjy6l2FqII+Sdu5AA8igFSa8RxvZDMr+ndnq61jNKLhnwmCPOSE4sORApHFJutdd1JkZS28+REo5YgRYQxXg==
Received: from SA1P222CA0073.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::23)
 by PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 08:35:17 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::40) by SA1P222CA0073.outlook.office365.com
 (2603:10b6:806:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 08:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 08:35:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:35:05 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:35:02 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 1/5] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Date: Wed, 11 Feb 2026 08:34:11 +0000
Message-ID: <20260211083415.133534-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211083415.133534-1-skolothumtho@nvidia.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|PH7PR12MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d258a8-fe2f-4b92-364b-08de69487bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tNnH3gW6g66ffaOptfFa3wBaVHfaDoOgfbjX4ckMVbCUtmV4ClOPDOYm87od?=
 =?us-ascii?Q?fWN8A9Pwwjx+FVUzgETQ9K8esX2qBP9cqgJ1Yym+VTm+fFfrteb4z11AbyOm?=
 =?us-ascii?Q?VX4TqSmW/OYNXRM1uNkF6p3eUjHFyYbiS/2Kz06LERff9JzaC/8HTc8mftrE?=
 =?us-ascii?Q?+vRjbCxD7FFvufcSmLjNSvI66Gq8cVWDDf8ZR4XE2dO4+n+VhqFTtnPMUPAi?=
 =?us-ascii?Q?xQyfKnDf+SJS2msQzrFaCWhTmu/LNQkCY0wvonwmj2Lt9UP6M3tp9kDjLmAw?=
 =?us-ascii?Q?8Wjoc4EkKeZX8drSzRKXM/idIfqESbbN3pE7SeTkDze2PvZsZ7FPVVZF7sUE?=
 =?us-ascii?Q?cndY9u82xJuH9XVZaq4A5kTWC0F6Q5nOxUx4AOx0htJfJ4m8U4IRLBqKKYNg?=
 =?us-ascii?Q?9mHMLKEFwvvDq3vu0AtFLs6UB88d3K2NEWJzFDWn7floZ/IK4qYGrSn/HZFO?=
 =?us-ascii?Q?zAQeqVN4Sau0mivOqB2EQHpIYaqNCv2k+dp1uxJKi6+RbGMArXE014jWY98j?=
 =?us-ascii?Q?n/06i3L07uVuWPeaj3rs0eF0BQiN39ERH3HLG9eNgwNwkuT8+w+df+YQsE4L?=
 =?us-ascii?Q?8xakVoBsDIdfN1bKnWDh2ZeMF9UaJ0LaVmeUSrNKCF9T/gIZgO2FjfzTnR0J?=
 =?us-ascii?Q?5sCZR0UyCyEYHxqYoT9QnEO/vApvRqiYyQ6dRIS5RstO5Ze48wQZ1zAWVKcZ?=
 =?us-ascii?Q?sF1cML4fpKPYvZZpal7SaF+VGe2gMi2icVHicx4oMk1dTSkQRW75DufsURAR?=
 =?us-ascii?Q?lMW1krijpxyOmStNSHKTMJBpqP5oBlq9RIhHl2UJzkCl2eUpQCES3mgrI4iU?=
 =?us-ascii?Q?y+b7Ix45IcSzy/LaxkIGLzwylveQHpAkEvfOF8QUUllLaRt+LN15ioIpi/sM?=
 =?us-ascii?Q?oTO8/0Lctd6Fc2Yyu7Xkb1fz8Ic6Ye5kgNIH6K+EX+FtI6PtXmBjOcuBQHdp?=
 =?us-ascii?Q?Fo4j/p9PPKD+r2XkWWNfF4NhuU/eFlRWAggIMi2KTD8NyfL/Sp6llNmxWuTB?=
 =?us-ascii?Q?rYRckhVXOAILu+7WousIXjVyi4H8UJf9URL8GgWvgLKzaYM2VLP3pluwYZ6z?=
 =?us-ascii?Q?v3H9LAlP7wKjUT7mz8jG7DFZVTrs/+HLpa4oJLHV4pDFuRklX9w2f8CndeM2?=
 =?us-ascii?Q?mSoVHbA0U0hKHqkcxm2QliKRZLDc/m5HzQNK6aAg1ylt+/o6m1NWSStzg7Ib?=
 =?us-ascii?Q?GAH5Lhu6eSeldDGyCaYpBLyXBSzqkIdGbPYXDS6iH7vGT7cssSrez59grpRm?=
 =?us-ascii?Q?fIZeKt0CRAP1JTli6I7pZ96eyHSQTU7hUW9/U2EzEwBMf30uQDdbCNwbuCfj?=
 =?us-ascii?Q?iCxc/T9zvlSfjrz+bP1M25TC1ImcK0UJ+drMauF2N0FGy3715JoLppNPL2sR?=
 =?us-ascii?Q?jILaZK4ou0azwRpnMyDCBZSd86xtLffR+RaIJsQCOx5U0UkiVApbBLEOuZwF?=
 =?us-ascii?Q?eSh/aB1ycIxYqIee5kfCBG/8UX6kVsOd0G1kNxKQjuQfWJfwZSnndhWIOk/n?=
 =?us-ascii?Q?yKDIHgpmZ9/tqJMc2LRrWXYC+KUrQA87O0DLnT4dDIiqHkH/ns4kwxaq8pnE?=
 =?us-ascii?Q?BXuDUvQPHstkicXYd4Jgr3OzLizaPkkk2KJv41RN3KAUUizPjMq3N4IVt1XK?=
 =?us-ascii?Q?B261xhyBIHMf5xA03o6teS2jUej7+qQI20exr3UFdOdd6aeToK4XbPKvKIDX?=
 =?us-ascii?Q?lf/aUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N4pvqb3GYlaCd+giNm3vzCmBjPYVAFE5Gtgbj2VF52oCh7odnrSmLaOfkkOqOYbez0mJhCWCi/508lmAjPOXI3tKb8mRl6DAyqf5Nz8gChPPtGsIpnfubl/8Ex+DL+Bon4XB0sotfbupCeoIkdVDixrhbY7Fkt/3jDh2zPoXXashHfxgJMtUHUoKli0LqxWrJlqEF5CRVe4ZMfGitgBvokMdQHxSoI6NA60AED9NidVEK/4lXpOR7RZgTRGK5pZdvW2KzsImhsQVMcNrriCZ0V3EAEjakaIv2qz3oumU7jH0YmHBOkVX9gycVSDgHO080gzDrx8Fiiz1pfZMZO08gQeWFYUf3tr82g1DRM1I0fL6w0El9iEiWJRREBrzw1Il94MFtVnpjt6uNMYEWaCLELk8kFCsDxk8AVBE765H7RuhcYZZWd+ah+MsjCjxcozl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:35:16.8416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d258a8-fe2f-4b92-364b-08de69487bd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9173
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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


