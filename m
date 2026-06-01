Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E15CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18F-0004Wr-1h; Mon, 01 Jun 2026 07:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18D-0004Wa-RH; Mon, 01 Jun 2026 07:48:33 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18C-0004rD-7y; Mon, 01 Jun 2026 07:48:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPCebWjpr8tNbtBe4+UoGro0M+m/WQwKF3EC93fCY9MsEqVHN4erFR78Sh0oyuDT3As/rLQ59emOcDtZIzyB1050JYcEONOl9Gd8KOi+pPbUKWmuGp7LhhtjNhY/w5DK418Oe7hzTOgb1xEhGgtSCDJY67QxR2Ng9zJFoVRd9KlA2gNU1uGCsdlAXEqOMZ53Q1FJ/omEvIMEt1AHt+KB6xGZcn4SNMIhchX6Qr0URmfyubvXeT6/rtSGzCh292y/ApwbtJ4BteyXswCWR4ftAU9nttQfj9zelEmMJdPH/o+JuE4pOLUZjV+n71+uDcYEpI9wLRyRpBQtIXJN9wCUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uayp8/2xIDziKqIY63vmrqb1h45tpB77/C7GEy1wyoM=;
 b=BYneV7cWkdL5vQ/H4KakIB34r7JVE1raQWyJbTdy/r0srWVoIG1nU39UgxH1nLNcb2A3J/g+JLXSU2NrBcDCCCeYwpLmM6crEndUe41BUnEe+BbzHrx2ml6n/SGlUWCn8ebrE7ecTV//wfIsorpsae/AUbv8qH2s6T39gqJNzgFvPxDfkcybNc2AhfNzkqE3cPPVQmXY9RbPPdd/gwns9Gzt/2U9Jpta/SvaSxpdFzq4RDs9kfpgeeriq4yB0nQR558q5f7bzJm/CD2s9F9Vcfwvlb4dYa0iPFtVYJuEcTljEwCJ5fPhEU3sV9+zm2VuByyG7xDw5dl2Or0+fIdMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uayp8/2xIDziKqIY63vmrqb1h45tpB77/C7GEy1wyoM=;
 b=lZ/+epUFLSiZVU/dDz3iFMsw88Edq7vSwgNwUiwErpXjCwt35OQFaYeqpbttf48UrUQkiLSD+DeC7i6zow0GzQ0O4KTB+KCuvkR2lIDqDEZ55FQ0tQ1rX6UV9IHHjRMgc5tgpHbdfkjhtQ7dQPta0Ajv/wqi3Snhs2/zsVR5EME09jVwvoHCt4OZBoCEz2DL2OzdYcfylMF870y4NtKuDI80M9nwxQO6jjD0Rj9Ay8AsBYp+pP0r6JdQRsZHa76bwau/ktpZp8Yx/ytoNTckg74IC/aL8JEIUEuQHNmaIb7OdjRKvfyAt5NSemsrHiQpOkk6XG0opi+Lyy68cMGw+Q==
Received: from BN0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:408:e5::32)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:48:26 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::3b) by BN0PR02CA0057.outlook.office365.com
 (2603:10b6:408:e5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:48:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:07 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:03 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 03/31] backends/iommufd: Introduce
 iommufd_backend_alloc_hw_queue
Date: Mon, 1 Jun 2026 12:41:53 +0100
Message-ID: <20260601114221.457995-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 298d3502-ba87-4c2d-bd8e-08debfd3b0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: N4XwlvasJ+AluiX3VBHV68RmrgAwlDY3r2Xidq7DAOoSKOdUwHiZdV/gBrrpxkGGZwWxj6QY/qL/Uyh1Y3iwMiMHlR0b/FVYd8r4acuJI81a0n2wL4vHvvQy5v10J28TUrwMeyB+CJvPw7eAOFIMMelKXHn/UvriAHCGqZCJ6vuxCecR2iTdAnEH9vc89czoDA/Mcb8CmWap7pvfRHEuT37m8wyTuFZSGxwZE/Chg0YSwky+1P0Xf1gGL+1G4wwz2DkwINxZ7zZwxj1g2J0O1o0xIjcJSWehk4oTL0JR5G+5P5q5HQr6RlXmepIqTLW0esnP7sc9GkyEdSxd53wSofhEJVlGsn0RdliBKzqTdMPlKn0YsRn6BOUpk3qdwLMmG4Lu7XFhTLap4Zx/63s7eF53f6fuCbARv2cvRCtRxVYHgUQsJNf7byuGmyFjNcIW7+Gq3nUEj+P0a9BTwWsCW4QZTYpSxfgP4xM5UYcmN0CJcfEG35JO9ms1QL8HVUCkZUz+R2R/9Pet7GwLcn8uXlx4vXXY/085Uz5/+Rhm3jFd5JmJ5lKvO4+Ohe5ucr4fvC4K7DITARqfQ30DAKrsRk1WyG4qv0ZV1Zg+81U5gtXp/MsdRQcup7QTZEPk5sXZJSM73krbWDhzPaJrycZX/itTv6EVytUAUs8LTw/I8Gm/xaHv4qXExI4VU5SGUxPU6QHl8/m2YU1WTzJoW3l2ttJW9IV6QhzOpzqkC+uZl6M=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kZotnNweOPx11a9Tvru0WbCcAFzrRX36jU0m9ALUEKk10+UccZR2bZZfYxtM9c0CLTYMWOqMH0PzREZ+mYN0+palSQXHPf5X5BqvGldle4x/DQXN4KCoFq3h6lIFOTBGTIDjrMG4vLidrZWToAfakGZc4A+LXEEx0tRqgDOqezYyVt3MAYDsuFfq5Tn2oHGNPxa/9EcfU6f7J1I7khEdtoxXH0XHU5hj/Swv6AlgKpHITXDJTLWWpK3ogyGsCZD+avsHqfa6XHcqC89aiazjOp+NoU/+sINeNp2RAinWclfzXkcGHxQ9c/2c9PrumSg/w65dyxvXGj2f5HV/NjI68kQfYKm1ZiU6oC61ligo48Aav2y0sDM9vJ03BYPkpwBD3MT2bJRdyWkTcRp66bpdhJfmONVqIixMKt7Mx/3O2C14DvJWO22PyZcUw05cgVec
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:48:25.6883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298d3502-ba87-4c2d-bd8e-08debfd3b0d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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


