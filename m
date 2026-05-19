Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3EECD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHqh-0007Tr-0s; Tue, 19 May 2026 06:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqf-0007Te-0k; Tue, 19 May 2026 06:38:53 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqd-0006PM-9F; Tue, 19 May 2026 06:38:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFc3ZCUBmf5mUNUyPuyNxXrye+evBqv53UPphHmBYmwttalmnsIY6Sgc+j3zxutPRledpE326YKhShOnIvF4tybcgHnf8KGBTb07sTMya0AWIIdmFv0rTjAr6UWjBTZLqd+rI+4tAazCjYWZ657WbdPfOKgLRFQI/J2pkARj0Ovi6JaJ4Re4KJ0+n1ETLCa+cQYDXyjtVybv4yKW/PEt41+DIoAiXIf5FCY+snOgp0dgENWc5kxwNms0yGaM87NLX8FwkY5CWxmg0aFZmiyqbBNGqbDydvBZXzA1pUY4lBvttELZbrANWVyQv4Mu3NsHsRyQGEq7CCHW8Cta67vNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uayp8/2xIDziKqIY63vmrqb1h45tpB77/C7GEy1wyoM=;
 b=Ugn0mNW5KQJBzodf+155nlAgKcP0DeXm3CIJi90vROdtV/TVRL/bVI1kuIhYO5LVuHGJSarf3BS8hwIJefxdUxo+vBwt6f/uWImWNDlCs8VGtTzsNswsPNYztep7sKA3qvALyji6pdZRKEysi/YlFuc8A3fPXrtucW/GOSjeiUtSbw1kFpTSST9U857MxAmt2hrI/SfAKPLSw2DxM4w73CPaMqPlE4TR0ww56eSIw79lDJvjKb+xBjqxIcdiLM6oJppHOxj0XC7h2UDSm8cqCtRNf61G6tpBNOIr+NRXBCAosoLpshlLbTMkRNZ6jNLterhmqJWWetZs3jqCNakExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uayp8/2xIDziKqIY63vmrqb1h45tpB77/C7GEy1wyoM=;
 b=OtZjpe+6mivdPrwXEgeeJbPrVRlw/fvH/+bJfOjMh0aAHRbwHVTQqcR3pwTLbtwIbOc/WwUWltypqG8pJXY3bO8NAvL62vqu2X+mbYG8G34gJ0ZZVy2/6a7rK6eG8HxO4wE6zkX0tDK8r6elYVjUazNLRtugiaxogXqcmUwqUnKH8IF+VADasu0hckptsf5i2LaHlhCxT2e8Ccn9cXt8ZWEJCwBH3u03wPJH9l9Y+jnUwMoNyCxeSghRD0wfMeo0F02RnbsQ2kJLDDvX9YLOdXU9G3csDQzxqwtfGeM/JV2vIDMYFa/8vXB8KmFh3mNCqF+RVJgo2fClpV16IFH83A==
Received: from BL1PR13CA0226.namprd13.prod.outlook.com (2603:10b6:208:2bf::21)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 10:38:44 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::6c) by BL1PR13CA0226.outlook.office365.com
 (2603:10b6:208:2bf::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:38:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:26 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:23 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 03/32] backends/iommufd: Introduce
 iommufd_backend_alloc_hw_queue
Date: Tue, 19 May 2026 11:36:41 +0100
Message-ID: <20260519103727.899332-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8153e7-ed52-46dd-76af-08deb592cc7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Dy8XXmNYcNuLISZ0I6cKBBa6cYw9Ps60PJAdv0tjTLNyyvzUI0NU/RqeNXOieqJK0dmlMtHihdzZiDHMT5JzFWDI0UCJ+reefrzv9qRW0KJLmkZsAkwM139wkXlfJs6IGXl1e0p4yilJ1Up9r0PwIHgEChITrJXMvSLOCC2FKZC6GMX43VIzcu1F1dSX7nFJHu8RVkV417Em73Ncpnop2Ia9988v5Dd97ynYojx5Km5GXCSg1XmUqUt3a/7lLURqsXKKePxBs62EWLFYs4TH1edhjLDw6MHQgv8HN7d5G8sitiAXoYb5nA0JCUu3ZJ3zqGqCIEub+PPObYJceXmThA0fhY4Aa6fvLtUXIgOEfsnnZly0AUH3LsG0UXGqVI99cpOZJSJwqtf/ogllendSrWt0IuXyK/rse5csF2lSgMzcSwrNHu2dUj2gM7pIax36Z0+arHzjSO6zNjywbZvvzq6kuKUVoWk8ItJMP62GDmLQvMUqFS938Cdvn2jfmgkNN1HUQS6EnAU36dWQIrDe+FbY4hN3DD1knSpStzal2I6HuJnu9qbg2zuAcwDzInbBdRIwWH2uni2jP5DhxSw9LSvQYQrhpP1UDpFHD4I68WgR5K+FrdcJfmNyAP2HBQBr9G9qlvHxSdSTkRxE84PbCh9H5SoBlyROp8fiGduNfFf5YPsI7mpfP1DvbHBe5IPeOnIXHHMYTzQYIrTkLKsX2xObqaRUYmSvk499jZ7CEmw=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d8NHsJg6mxoW34lgCE0EjJ7oAKzdk6nt2Rj7CPVY1BZhri7T4Ybhzan+Ip+lnu2LEyhl/fdKJ9uuMrWJRPHLQkAVYmUp7cSkRwMZ8fB7rmkOAYi27xtr01768hKaDCNbM2768onXUmtNL2nyGdVT/fHaqOTPD4Y5z0IhWGWz/9ZrGCcBRXK5hEeH/3YP7jG7vEk6aNQMQCs871SNLi+y1W9EfnOil312yXKFwRIZh3vmYuH6dqBbT6CJsQaOwLow8D08X3wpAx6+IiIO1diz93+QAIzql+6zuPshdGbfYsHU3IxepnoGN/u+4M/jqsFmcwxQMsP1IQvxsUjWd1CnF5VtX7JfSgwLmA4VnEhDEGQVzccOePfJVCcfkrGPSBiUHsz+S6HgeK+4VY1r56509lChvvd4VX6b/ceL716RasaKTzKu6XpEhX3fc+cPCE9M
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:38:43.2062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8153e7-ed52-46dd-76af-08deb592cc7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
 include/system/iommufd.h | 11 +++++++++++
 backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 43 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 1b0266f660..c6f2e87a7e 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -65,6 +65,12 @@ typedef struct IOMMUFDVeventq {
     bool event_start; /* True after first valid event; cleared on overflow */
 } IOMMUFDVeventq;
 
+/* HW queue object for a vIOMMU-specific HW-accelerated queue */
+typedef struct IOMMUFDHWqueue {
+    IOMMUFDViommu *viommu;
+    uint32_t hw_queue_id;
+} IOMMUFDHWqueue;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -101,6 +107,11 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
                                    uint32_t *out_veventq_id,
                                    uint32_t *out_veventq_fd, Error **errp);
 
+bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
+                                    uint32_t queue_type, uint32_t index,
+                                    uint64_t addr, uint64_t length,
+                                    uint32_t *out_hw_queue_id, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index c745dbd2b1..8eaaf456e8 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -549,6 +549,37 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
+                                    uint32_t queue_type, uint32_t index,
+                                    uint64_t addr, uint64_t length,
+                                    uint32_t *out_hw_queue_id, Error **errp)
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
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 3ba0c3503c..c5c1d95aad 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -24,6 +24,7 @@ iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, u
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint64_t data_ptr, uint32_t data_len, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u data_ptr=0x%"PRIx64" data_len=0x%x viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
+iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t queue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t queue_id, int ret) " iommufd=%d viommu_id=%u queue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" queue_id=%u (%d)"
 
 # igvm-cfg.c
 igvm_reset_enter(int type) "type=%u"
-- 
2.43.0


