Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CCFCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudD-0007OX-BK; Tue, 09 Jun 2026 07:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuc9-0006Ls-Ar; Tue, 09 Jun 2026 07:27:28 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuc7-0002xX-3z; Tue, 09 Jun 2026 07:27:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QatPTHDJX9oAf3oxy3inbrBLYHarufKEHxUmqF1a11kxszm4qi/aHXn7S1FSHRGxHpdUJpFWSWdenzb1xUpIcZ0HOqyb5iFPxWozvo3onlDWc33YIgpqzvETYVeJcI7SMdBHikceri2Ns8+1jeTtXbuEMxALyZWkylZrYeodJgtkIsxh0M5BE18945Tul/XQzCtlL1+zJQWRTJ9yuhfAFah/wG8Sm3c+C9pwVp6FU3L5UOeacs4Fp36uR7jc3qdHRvJGVg2J+VBn+IAwWqb+dVKImfiPHO4e9EYZNgsD6ug6xwVfDgHj+PQ0cjqBcfXbiYrnRqlFVWZnikge0zqZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujg1un6yKBOQ1Q/ECxKp02+hcFgZYJxacTpiFnVUrTs=;
 b=dXF3T6cww1cvKZZ2zdvRYFezjPxstVX1aiZa8cnCnnK1o0ZXUFjXW7S4fxshfqDM/9t5wo4SJAzENRJkAK448g+KzLiR1gBa2dFGJmSl49dIHwvkLmFBamntzXjgvHMURJb1HY1AhuNR0HF+8u0l3YbwyX/GR0YqNDP7aS381JQ/G+bpToZVIXHWU8YHQA5Vxv8h9SI1fus1ukefVtCEpyU8VbMbisYZstSmaspZZUow43cNSLDrvEDKfq0/crz2CigB/V5OwtFaEvRqhRSne0Wj0qf+WlbNW8vwZ+pKqq3/WlG76c7JEBUWxGWr4lMt8XpvaeHj77UqDgJCjS7bBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujg1un6yKBOQ1Q/ECxKp02+hcFgZYJxacTpiFnVUrTs=;
 b=Dv758T+1OC59uV4RAR5n7v4x6aTU67X7h4pglowHFmzVE4kIlUcuZjElFCXaDd8LjVibN7Fni+JsrwSoFpBRH2MWcqXELp1zIYxCxgaRpIAhXcCz1/tUcIUqZ+Dtd1vBYSojG+OulUoTzAKM4fLvB6eb8ipqGUNuAR4HpDmyaLlLYO36uG29xiKnk1HCCZTrzuKaIZDMejiGKSJ6FW3aQLSWBRFrT8HddAJWBJz86ieNNtRWDGztkG6eC/G/5ptSgFQ4ftaeSwjqHAxVJgF6XCwQnqyzpoOAgO61cJBdAjhnh7TU/Ke5WSnfFDR9eO84kGpd3hbSMiz0qlAR2KfGPQ==
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:27:13 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::69) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:53 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:46 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 03/31] backends/iommufd: Introduce
 iommufd_backend_alloc_hw_queue
Date: Tue, 9 Jun 2026 12:25:24 +0100
Message-ID: <20260609112552.378999-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e544efa-e132-4535-d912-08dec61a0d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: b1Y3LwD5cfhCCi6QgRT9m55/UE19R8PVAeovzNvhYc53Dm67UboMW0iPEK15Bo9VZllXoc4qepMFxKtxzT2NMr3BEp758QBlYV4UPRyuiGzHfZCoUphGlll3kWR5NB6Qk5qPxs6MSQGvcbtfinaoNJaeVyjQUiCMbhkN3/HtVkRhmNim2Pwq1yQUSoMkWpv8ghj6gE2lmVGKMcYgnwHUpy+Ifclmd4ESYFW34As1xBicI9tYDWEAmshU77OlPgP70lo1fbtoPiLX2Ga9NwCD3mN9cGxeSwR6KemHJmOWvFEJiQRi+iANxQzx7ueTXOXC8wLnMarMJ5DDFnUSLqlqu6Q9q/lWwlzJ5sLcO+IEn7/sLUIuC4hNM0Ur2bISo/rt/iEgCJNtaKBNldrkT+RItis3sl7jiMsay6zbdmHulqhsx2xotQz3o/9ndv72VRHTbLg/FrZ/dXu5rmEJj7jVZzkRc8AVz6yRQE661eaoogLDXLJyVV5jAnGnRLPeV8aIlchlmlLON8HuTriqzUy5H2bAFf54rdYa/hSBMo3/Wh7zqwo7CkoOh1u8hOtBhOq39UJjVx7F5NO/A+jZ9j4C+2u5vT7hpHZLRU52qup20aQhvE1GO3ac/g+QywNkAqs9uY8dTp6ELhSUjdDPlxGCcq/HGB0Va+C4gJrrSXzrqE46dMUzveQrsuNXLDHFAJSmzH/BvZ5oR1V/GLnpYyT4BCPqcJo6VbXNvsGk4t7IexI=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i4P8z2cQEx0x+jayHTu0l1YaBe7lqYE+eDOVs5VXxX5XtGWR+geDW7judLc1VqfaPB3G8tP+asTbI4y8yBoMongsI2Yodj2qQBxRxmU2Au3Lq/k25Qfr+AxbhmOxGHE4vumT2fOFzHFS/tgQMEgNcEFMBCkbgxFPYeYIb7wq+yH4ksJZOFIkoYSSIV4XzTqNh1obzD+Tpv8fmEmOrqBdkttUzyfzMBcRYyD5w5a5u9drX+SvYHQCNJiWjjX2/r026Z0D7OMke/WTf6I2Pm2Ql7LCx7ENCS5wU0D1e27mjMFbKCRHWmzql9zf/rPH+TCWXgu1ydh92+yo2cOd8JE7Lre44Flpi8v0jE5LBTQtobk7B1TrWnC5LU3mYfV8C5/KMztZgI+0uJmdiznHOHmr1beMTCQ0I9TarQlppJqVX06bBuiNu46iA9poy5SnWSIA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:12.5383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e544efa-e132-4535-d912-08dec61a0d3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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


