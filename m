Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961D9FC590E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 08:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvX0R-0004sl-BC; Thu, 26 Feb 2026 03:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0M-0004rQ-Np; Thu, 26 Feb 2026 03:45:55 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvX0K-0004yi-Jc; Thu, 26 Feb 2026 03:45:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjQTWSyHPRDn3zLxC3K9ZKTkVRi+G3hHANiFLCqPuJFJxAHKyKZaPBbQgDws/YBYLLzsR/8D8JCmIt2Z6zCrDHXAIkkQD4xxWe644OhVzDgSV/2Bx2IZcDRsIBCDqbAbky1KaT5KCNCRL8Y0S7gdQM/X35rrazXattqSlXG39DMBIj7Rnn+viNikLT+5tCOWPJ/frzEReYRcF7wBXDLXFjmvFjLlG/6sB7o8sbN1x3Z40gYe5EC6RMKR90eoM2jebQS8jocMxfsEWI41RVInKSXofe7iJTt5vtY8PzkhxrkKSxs1Dqvq1MINeTELtRKTbSlZkhPQgPvYHo+LzExfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Brsd0HF5ygXOdIq34LPZDiEjUKSOIZK7t4l8AzdgqnI=;
 b=M8KVH/vmFgAjt0HRL+vuBR/77YyO/fyc/AF5O689Nboz+kmjnKm8e+WqDVn27AeastPECYIjeybLLQb8X6XqP8v2J3JsF7QIQTnTKT3TjC0eQcF2h1/m2r6MwB7S/ETbgdau2FBkquLDbPr6Ye68oOZqs9IAvjGVWGgOMDvH95pNpIZAWKMB58mZbjkFweoyjyt1d4quRYmizSQ2wFlAJCPxzkcGrpu7Bs5Mw025+ynYCzUOiB1oPegCoSdH4nZieFy4P6Bs3eofR++RN5JEhuyI0IZ2I4YVn3eGcGtTY80yVHigaTfWoYXyPEdp0v4FXA+5N1PwVNrcHcTUiptVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Brsd0HF5ygXOdIq34LPZDiEjUKSOIZK7t4l8AzdgqnI=;
 b=aWslJPsmC7fzEBD5aNe4ZU5tlbiVBr9mGVUcwdBZrsUjFsICnam+28UNyEvMrCO+DM4HDZJb5556p/zjzFUVq8PlLo8Y70vrte1u7cFijby527bhMZ51jqVgqIN2u2PcrmF605580IX+CSe202krAFHzKAJBGcYk9/5xtBKKdNTHpzTrFAV23Jg3t1Bb+Y6aWdAFXIoRazn6rYIpw6LNsIqQ8yMt/UCxDrXWdC7fsN4s+lS8RRZ0ZMffc8tvQsIpkz+63qS6whtQiLEavMD6q/eJQpRzvDwqBh76VLVUIBhEUDZ2PcTmdd6i8STvMmBB18HBW3VZBls1s0PJqKRnOw==
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 08:45:45 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::c9) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 08:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 08:45:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:23 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 00:45:20 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <philmd@linaro.org>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 1/5] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Date: Thu, 26 Feb 2026 08:44:52 +0000
Message-ID: <20260226084456.112142-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226084456.112142-1-skolothumtho@nvidia.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 743b764e-6150-48dc-acf9-08de75136e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: t+F6joi/9PbTyMic5ydEjBD2c0sYG2nP9zOXUGseTUX0qMKTgIwNjWzv8l/maAv92iSrKIgvJxUvEuA+D9hR4sWQtSh3NdOPSDxQv8twmqjVBtz6Ncl8bgDam2quynYzYmBaVxdqExVIVGV05BM7ohKGSoifkRl2/deP01oj+iWkVT+J48wRIIhuwo/iADpJ/Ec6Jke5cBzencEc41Tu4hAVjxY9W612d0QtNetCT7p6flUVNRdKo3UBbLnR/4wWbDw6JsVXrYAgzoQ3fRcRHXWtz1gxQPQ9W7692KhklZbut40+JzhHbBduZ2/yFGYjdxgO5JKxL9M1wmCVOjFXZ8X01kLhKzDDtqxYGGBIaDz+78/6RcF/pYps76QbL3SMi9BDsxiOhF3NBzrNLZngmt4nuHz9TmcPg9hqQnYn3qYfZVIcj21ZH6dGdTzwBoZNNObz8kT1oAeSaSd00dvhDSc0Vc416DVdDdoNf8IIGoWl8SyghTCI9Rb1rBeF0IToMZ51FpqmLMpiKSw/m4AwDpG2K5no8pLDEJfI0RFNEMAya1qEwG9mRDCIUeXLZ6NCtZ+QpAT+bOU7HgFJYqriB/wMCEtuJtTKSi0Sj4zUxfHc+HMhhGGYM0hS0BkMJIZIUqa+PXHsfrSXS/Cf3lZoGRXiWN1HBnoSQMKvE/PQgIrXzY/QWHcW8DtAPUQxDerGJIbV/8UHKLqKasMg8EVLBuCMXOfOU2v3D7Fe91zQyE+QcJ9wPtPseM6mp541xE8SvJcSfzxHlFp2IoEM0UDgaK4NVsG9DSINFuTcYbYqgURU57UGmr6JnVLcNs6YHwP0R/NFVQuTOjGWX8IW8ubxNQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IrZW0Mit7C6IROniy8XkebFiWW5ElQdsDIecS99cG0nAnt1c/Ew7sSXvd8hs03x7BaMtkJ1uWwseqCiUZ6YIwSqw6weNbDOZN+K7qPicJtM876lZP8ouTW0Towdwp9FW0Gi5iJQCUQbzkUuUF22Nydj28/k+WS2r5/gfbC86C3nlieIb+nAzZyMITfC7WhYhCFhT+bSjSqqs87qcZ9pnlCXzQRjQW4QMoyWBPktcoND0BnWe/pmdVQ/EPDBIS5Dv5EpNynoeNoy+es/7Z0mX62QCNv4FctGJVV3S4UzUX+VIDz/Va5wmOLVQMaS1cimSVKaO0q5TLhJiHhO+9BqqE+d9Npt7kG876g5aqrEciNXd6i7y+fBuvi3tLPDKm7UYvgEscwJbTUwmHXLsTFSi/93Bys3ArW0XN/vWn+ddMdAOH8+MVgU37opg3EYi4+wm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:45:45.0782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743b764e-6150-48dc-acf9-08de75136e8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/iommufd.h | 14 ++++++++++++++
 backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 46 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 80d72469a9..7062944fe6 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -56,6 +56,15 @@ typedef struct IOMMUFDVdev {
     uint32_t virt_id;  /* virtual device ID */
 } IOMMUFDVdev;
 
+/* Virtual event queue interface for a vIOMMU */
+typedef struct IOMMUFDVeventq {
+    IOMMUFDViommu *viommu;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+    uint32_t last_event_seq; /* Sequence number of last processed event */
+    bool event_start; /* True after first valid event; cleared on overflow */
+} IOMMUFDVeventq;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -86,6 +95,11 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
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
-- 
2.43.0


