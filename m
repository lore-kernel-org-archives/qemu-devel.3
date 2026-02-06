Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860D9EE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voN9x-0000Tl-2H; Fri, 06 Feb 2026 09:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9Z-0000Qf-FJ; Fri, 06 Feb 2026 09:49:51 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9X-00070i-Um; Fri, 06 Feb 2026 09:49:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xr2s1w+mjIrianYwYXys88wh1basUffexWP7AMibshBrOZCOWIy2YB/StGGS7WV7VLSHnUKIOJc4IVlkJ01MOmTwIR4sgihNqCTUdiTwDdIsCSz60qnVVB8b9O8yCHW7lJ0Duzu8yb+iXp+T/UeHokMuAhLJwwMTbOBfZ8QPJoUAR9CU6yLTsS1ZE41d8v6cjNH5cMpQr5twMPHpfuqBy7jY89wG04uWFN5AKyv1U3dtOIgX06PXkdSn/0i3Ep6sn2MR4yXcFTchFe9QNkXBGL92Dzd3NqDwoXux1pnnLU4ZIRpgQ7dtzy22FrB+lpmImjKycf487fzcjKZndIvRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfw+DzfCv+E6/h3FsvNva/9NpJ11Q4oOq1BGeaI/tVU=;
 b=yJsEl+9Jpq8AQZe27cPwNxaRFhYKjXp3UG5IBYvTlpEQcKyx7t6FI3ZRw/SetjC/cM15niqMrGZXQ5to1qzkDN0eof65JtZ5mzKBRYbzUUzaWx6L4pOCPPEQeaesINjP98WbVtmwKaK6xTVVlySGTjfzLioH31DVU1hFfyAWh9x0QkyvYao0/XMoqpz+imrCCnu60bMTW9437W9X8/S2SQhS9bFsstybb3FdLtf0LXnHoN1SNQti2NlUaH4muQPbH2hI3xYYdrmtHNvOWYkqaJzCBNCxYv5F5z6vi671dEFvVHMk2EB/qW8d0p0e3GyRTDLeWf9z7L01vTlLVzJ4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfw+DzfCv+E6/h3FsvNva/9NpJ11Q4oOq1BGeaI/tVU=;
 b=AP6ZTvSVYF8yJ3123kH1RJ9i8uTMIgzClGJJdPLEYhgwu+FV67Mn9x+nVgt1fGSCCDJ99M+yYnjKTe9Gy8SLsBVb/RVO5eSvOvKe9+/zUMVizqAuwxMEJ5cLvyziMpKaXBcID6D3cU+lqPosem5cY/qJSkRgqgOqRoGKEdpsvkT7VGemZJahztAjXwo0o7folmwwtjr9BqsJb0vHr9AH29K3CKcSXrjqtXijmRjI8tjDkCfHK9FwX/cX2aLRIE3VVzTb2NVbTi37ox/gci1PzhK2aqdvmASNArBiGnYpw2vP3oVqeY9Il7/j39mkEd3HmBd43/AKFxBk4u82iiTUiw==
Received: from BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:49:40 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::3c) by BY3PR04CA0020.outlook.office365.com
 (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:49:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:16 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:12 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 03/24] backends/iommufd: Introduce
 iommufd_backend_alloc_hw_queue
Date: Fri, 6 Feb 2026 14:48:02 +0000
Message-ID: <20260206144823.80655-4-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 5454c741-97c9-476a-e2b7-08de658ef4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jo8KoWUPi9SNGHmYcqgqWPWFaT5QEFRXA6CiOARM2QvarG7pOmdOG9DdV0LI?=
 =?us-ascii?Q?2m4T1RbeVLlw2G67bxfGetdlysFGqnEelxeq1jBCxk0vfSb+34lff2XKknEN?=
 =?us-ascii?Q?LR7Ptxy8TquVpKW4AKxDAS2DPhfYcLsGCF88aYhDzCemdj0Q0fIni1VD82MK?=
 =?us-ascii?Q?Zhs9Kpk66AftyTBXjSrNl3ciFoCyPuRGJpr5xB8mYK6kwpYU2XwjBPTOvddp?=
 =?us-ascii?Q?1RwCZ9eNkQWmWkRMbGh3Th74kg/xwgHpmJU0vplwXbQNLoshoRi7SGqHZeI6?=
 =?us-ascii?Q?wVMzegli9248KmGyGlbrft/kVAxqApbCy7HbymTNozadt11wowA2uThFEk+N?=
 =?us-ascii?Q?9vDvmsD8ZEfdWL+0qsOEbwity0/ow3k44/EwE4EC00/cNKScLiZvkT6C2+dz?=
 =?us-ascii?Q?E6dSAsnOygTzDjyycSG2bBkJ30vCDchQIQxLFpy3XxgKlqaEmsAhNaxm/hU/?=
 =?us-ascii?Q?T4zVXoCP67eTDv23EGwqNEZceQfp4VboExk6cHgFB0Mj3ZlwezcFfCr1Xvok?=
 =?us-ascii?Q?sHpLnQtR9syxlkaXfAqO1n2eR9iUiVdOTxp8BWV77cOKMOBxxH7cSmGEBhFw?=
 =?us-ascii?Q?pYBHmA39e2ZEv+Fq3MAIH0X8uH9+gvXlF2gfH0ur0PiL4Z7/7KzmkmptTiDb?=
 =?us-ascii?Q?iln7RRpPLD5rrSSg4HqTX0a5QduM8xW1+Idj098PbSB5ZoN6FWh/wjlzlYtq?=
 =?us-ascii?Q?tjEGvfMlgKXiVdwbx5VcKN6BVhBC1EmxybH4sXLmXEcy0w4HAzJErxgflc1T?=
 =?us-ascii?Q?CHugsogj2NTPvGdWiBc0dO4t4hDoHIlUSSA7TpXkaVuQVtolBbhAowFJfj7r?=
 =?us-ascii?Q?v7P3hQEN4v08EusDLiTmR+wEpeUMHsvCjWYpg2FBH8j/cPt/aSkLGSOefaGe?=
 =?us-ascii?Q?qqeKgelXy8+eGeZPBhGW6NwEffRUbBYMmiaMqglxpyNUK6iSmbVqWGSkRKe+?=
 =?us-ascii?Q?dRIr0C9NQjMrWjLDyVU3BjP+SVXGs+GjAvQzjArfAqei2TSc+m19/yjNS4gk?=
 =?us-ascii?Q?/Nr8CE/GGI5JINqNJGN6Fl2Px0FvJ1QIkbPhKfxZTGKmenVmp+wA4nlvxUNy?=
 =?us-ascii?Q?OWcfQZR0XSrBDdDy0GNjgB4qdA/X4TXF8dFBXvbqGeJ+gpLksjoexHaF9iG2?=
 =?us-ascii?Q?qaeb6ji9wrsjjlvnJDbIysZf32nhrt4CKmgIzUu6sWC4Z0JEaDPz7ZMXNnCs?=
 =?us-ascii?Q?F6FJvE1IteCaL3k4D0jngovCM4Vr2NIqfJ893TgcrfVih1vButaX/m/jwn6O?=
 =?us-ascii?Q?HIbnq/ii0fbExU3APtA2ii7WBQCuSEY85wg1M0L4mHWn19xPIRf21ucoJVaG?=
 =?us-ascii?Q?fCniCgBeWjJUbGsZKLD/M42+BF03YYns1j8bo+lOSVAqbjto07wWVhFc/85J?=
 =?us-ascii?Q?9aVOCqqiC4GQZdMo1uHUs/6Up54oSwWgytksobHfTK9oUxZaP+F2hCGmOG6e?=
 =?us-ascii?Q?kxxyeqkD8hZJRzFKHaCq4cpAybSAnIhe/RP65m1qJHgRL2pXE8Boae+2xdK3?=
 =?us-ascii?Q?6gqkZ1Z2dsfJ2onE/avCJLxiK+QmnsfXw8+PgG8sljQyxWLRSg7erXCpB3UN?=
 =?us-ascii?Q?QsWr94ULJcqL/mcJNk+lZhJYRGrbZ8tUipW256Bkxg6tDPtMOtwVXGONa/6o?=
 =?us-ascii?Q?fKmN3FNwczTacKD4ZtfpDc022LuiSTHBpTd2u91esYaXgVNjDD2AIi5POr9G?=
 =?us-ascii?Q?Fvp5aQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kDf73p4KfHrNWv+u7HCnkcSBfNxAkNx4Rgj4hWlQQoIAQ4JQqs4Rdlhs1F9d9G9N8NXpwqYX5oHybOiTnClYAVUcsuInzHbiIJ3fT/BI+mjxHMz0vxO2JPa0vsnWGSC//QMBh53GC1Nhm4bWof1T3PsaVznNEwyDzrpJXRxiOJhQyzToUW5nCf0yDBfHOD0QAfxkB4pQw7UbMuWjEWHt5JTPCLcVSGCYD5r4xGrt/I0a7UgETw2sWXtT7GnGqTSLuiMJjgNLeNY+irP/dzPo/PlLqg3JP1btkMUn6gpxkUgvNqARNR5yWxpuDUgbHDfSSB4Ym2fHqZvri04S3ZF16NtIbYRiPTOaoN9qf2Hp++g9uK3vIylQkfZaW38DwS2Cums9ymULfjk2QLVv2wRdp2C/0LZCyoU5pvm/xmwB8w67ynD8GuYShnxYcz7t36q2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:49:40.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5454c741-97c9-476a-e2b7-08de658ef4fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

Add a helper to allocate an iommufd backed HW queue for a vIOMMU.

While at it, define a struct IOMMUFDHWqueue for use by vendor
implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 32 ++++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 12 ++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 8ab26eb786..c6b79da0d4 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -546,6 +546,38 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
+                                    enum iommu_hw_queue_type queue_type,
+                                    uint32_t index, uint64_t addr,
+                                    uint64_t length, uint32_t *out_hw_queue_id,
+                                    Error **errp)
+{
+    int ret;
+    struct iommu_hw_queue_alloc alloc_hw_queue = {
+        .size = sizeof(alloc_hw_queue),
+        .flags = 0,
+        .viommu_id = viommu_id,
+        .type = queue_type,
+        .index = index,
+        .nesting_parent_iova = addr,
+        .length = length,
+    };
+
+    ret = ioctl(be->fd, IOMMU_HW_QUEUE_ALLOC, &alloc_hw_queue);
+
+    trace_iommufd_backend_alloc_hw_queue(be->fd, viommu_id, queue_type,
+                                         index, addr, length,
+                                         alloc_hw_queue.out_hw_queue_id, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_HW_QUEUE_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_hw_queue_id);
+    *out_hw_queue_id = alloc_hw_queue.out_hw_queue_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 332888a576..3e70338750 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -24,6 +24,7 @@ iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, u
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t data_len, uint64_t data_ptr, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u data_len=%u data_ptr=0x%"PRIx64" viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
+iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t queue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t queue_id, int ret) " iommufd=%d viommu_id=%u queue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" queue_id=%u (%d)"
 
 # igvm-cfg.c
 igvm_reset_enter(int type) "type=%u"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 5ef23ad9e1..f72ad545f8 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -63,6 +63,12 @@ typedef struct IOMMUFDVeventq {
     uint32_t veventq_fd;
 } IOMMUFDVeventq;
 
+/* HW queue object for a vIOMMU-specific HW-accelerated queue */
+typedef struct IOMMUFDHWqueue {
+    IOMMUFDViommu *viommu;
+    uint32_t hw_queue_id;
+} IOMMUFDHWqueue;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -99,6 +105,12 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
                                    uint32_t *out_veventq_id,
                                    uint32_t *out_veventq_fd, Error **errp);
 
+bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
+                                    enum iommu_hw_queue_type queue_type,
+                                    uint32_t index, uint64_t addr,
+                                    uint64_t length, uint32_t *out_hw_queue_id,
+                                    Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


