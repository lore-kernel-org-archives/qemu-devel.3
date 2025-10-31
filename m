Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E872BCCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmkN-0002iQ-Vr; Fri, 31 Oct 2025 06:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkM-0002hx-I1; Fri, 31 Oct 2025 06:52:42 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkE-0002sx-5C; Fri, 31 Oct 2025 06:52:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYA/tLg20SgnSfRWIGtPVDk9kxTkMSG3+2IxB5oPezgJpdJVsgP2H+SGmKWPwTyEQrfjaEioT8ePOR6AIX3hjr2RLbA58u/MEPkr8kgc/V9cyqaoGKRKwey/a3RsxdcVqCcB/G0TfuOk0w2/64kSZeibHnRBXshhjfE8zZdb5uPGTNw24AGL1BF0r6O9AKZXeljvCzMKefbzaKPHhLghS9mZpZanaJ2+3LgaRxhUHgVECqEASumvtY/JlDEHET54OvU7qhbXx+FhX2Slaj96TxKnilZmjNfTvZrYJWjScm/QJonn5vbYt5zqPTMkft3p8Fnq4zzeYLQkE0JR0hURDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia5kC+o0xmi7ZGMm1OaeSl7CQLzO+HThMtd8rA6ehqk=;
 b=jby2yglzDQhlxc5+b99k1kvSuWDNuulWtLaKRsatskRqvVHAX75aIDkLnhrcdSvuSKonNCxVM6v/hHWm8jIOJwpohCcSU8DrRTr30YoGgmcydA3D061uhQ+Lg7Jngo3Wj6PgP1ucFHB+WEaF3Wttrj1jVCJWpLIrlNsMOs43yMChEln1omzCitcRaoEQ2BGlSoxKu0rex7yokdC0yk6bN+19rELUm5pouvima0PvyjBiY3NS/CfdAHuy6vSxbvZX97HSH/pybnm7XngFJKf3inYm26JcrBeIlad0AjrI+EdDue+W/+2pCbAbdZKsh3E/MFC/fU10I1GkAfAsPHh77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia5kC+o0xmi7ZGMm1OaeSl7CQLzO+HThMtd8rA6ehqk=;
 b=O2BMHEITUusPB+guoafvMKg/arpmJrxwAtYyOzRtX7LFUoXOgHRKzU3ED9VkaEvG5lSjcIuvmat7AnyBNG5Ym+A5wjtBfS38tV9g9sHw4lMzh2Erit9/XETG/Na9xiy8PwabToQqxOnQaph/85Ht+2WfO6ufGaflp8QSKQSRHlKMyExiwHzRH5zDZ5XP6zAmGn8mzaxkQpzF/aQf+HSKm+rT6ezWO9Qa2O+jQQNgGkbXcbn9j1sPMrSRfYnK0ocFEGcANYKyUWXufFO4oQxk3Ns+5/akcYitaPuDGiy7FV1m3qzr1ktGYlnlPtO3AwLgwtdZtIfzA6+EOLeEDBZKDw==
Received: from BYAPR02CA0040.namprd02.prod.outlook.com (2603:10b6:a03:54::17)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 10:52:23 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::a2) by BYAPR02CA0040.outlook.office365.com
 (2603:10b6:a03:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:52:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:52:15 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:52:11 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 01/32] backends/iommufd: Introduce
 iommufd_backend_alloc_viommu
Date: Fri, 31 Oct 2025 10:49:34 +0000
Message-ID: <20251031105005.24618-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: cafcb829-2916-4d88-e6c2-08de186b925a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rz4Nsk346wHETVoSBSs4+0b8OnErNuwY7Ap5IX2QPOgSuc/C80eOKSt5Xqcc?=
 =?us-ascii?Q?2Gz5bnO68Lz3tppvDJ/XoNl8w98SYOKDd/TI89qRMXvJEtCrslpCtTTCSUMu?=
 =?us-ascii?Q?Src+gcolPoorO4rcmpZxiukHs8q7LFqMIf5V+s2jJON6RSkjzs4LC+hnunbF?=
 =?us-ascii?Q?byQd0NZpdINpTWiP3vsDuC+21zS5EpDvEOedgky98vILbNLs+l5ev/aeSTns?=
 =?us-ascii?Q?/wyj4x8vk3BeE9hEBuQCd76PF0HO0iG6AZtu+Kc45uYTkwN8pWvdC1UofEKp?=
 =?us-ascii?Q?rCQEgdJS48i3JPMooOVlVVgTi8VmESktpPomDV3/S94RYwYdERq1TeBwoVbw?=
 =?us-ascii?Q?drUrwM0K9QB1cu9owv7mFTlgJ9UM/OSMbbAbNrpA3UIBCHk0JLxlk75K05Rb?=
 =?us-ascii?Q?xfK6vnTvRGaXWVKX2n2LbCOZAg7gFd9420uNjzu2uCaSJ2MkDnYs+BnxVTXQ?=
 =?us-ascii?Q?hIV++VT6RCmRs8B/1EoXoWawS3ATa2+9p214Bl2Jqt+OP0twiNarw2fwRNB3?=
 =?us-ascii?Q?XONa6EZpcSkzRLNKomPeLMHCnK4JOODg7hkhyTiFqZW4d2nIFuHEcLMm6Wo6?=
 =?us-ascii?Q?vJasPloStMaUs2nnSkB9u2NKBKH2Up7T89KToqCHDaMaBWUuW0wcBRqsQIcD?=
 =?us-ascii?Q?0Jd33m8pdzAc9fiSorhxUwEQJ51M6ra5u7+8NVVWWhcFuI0nWt42BTVDc7PA?=
 =?us-ascii?Q?D9nK0qwGJ7kFShUkxkm0vFssL8vkEfbJHAQaTsTZh3bZe5s3Ns+jl/GtxK0F?=
 =?us-ascii?Q?SLRMezEVk4CdZaYNGSFQxI5AElN4f2HkHXBzdbqB94zj2FrzSD3tdGIYAmpp?=
 =?us-ascii?Q?4yCMBAcVBMrEWx7lW1uD1/5ZXGltu4fgTYNLOs0OqMprsoO2Z2SOp0pJBob4?=
 =?us-ascii?Q?Uv5aZDz+2r7NAJh3n8MvcnBKs5RfCMa18S+I1QygEOvbnbw+cya3QbXnV/hV?=
 =?us-ascii?Q?NJWiTfsnvtjtBBDAXurecCSvzzw3dwI0+Jxtd1gQXiYTKFLMG9iSiAp990Bf?=
 =?us-ascii?Q?Cp/m7+fY83lsVuwBNrarQkfie2EcbQgJAEWVXGTqxF3a6u65YNPco8WZtjSM?=
 =?us-ascii?Q?ZKBSa4mz8yvwriVZ91Tz27OVyUa3T8yPw02yvWar/RODLFbUc98/81BQ8IX5?=
 =?us-ascii?Q?nRAypZDKy50AzCS+a6hP5NBXF5FP3NCGmkx41dOEInJXtoqobbsdhDt7PVin?=
 =?us-ascii?Q?XVIHl5nnWByRTMBnY00i+NcHGzV6dqjW9/lcLQ/nQ3t2N4AZE01CQXaic5Mz?=
 =?us-ascii?Q?3Y1clF+YUw+gHF83c+kXIetTNg5T/ttCxVnlUNiEgX6quAJ1FYCLyvMvRZ1F?=
 =?us-ascii?Q?QNc0/jOmsWzLqGw7GzBImydcnCWBI10r252yIQeNGeoNC/7R19yWLPypG/qZ?=
 =?us-ascii?Q?iA7Qtl7H5eM2BmyAo5JWZ59zD2PRNNyEuxyZ4sjCV+JpGUOvUHOTfkf4yssX?=
 =?us-ascii?Q?3TTqy8WVKMfRcBIbjzIpX7Dcv1o88lJtnMvcYmuUPCalvLuA9xAKMbZGU6mF?=
 =?us-ascii?Q?Uh9yLa/jHbnBF26bC4m4kGAnOzWoVjFW2aRtCdeYmwOIIfJoh5qniW6jT5zD?=
 =?us-ascii?Q?N4PMjtAyVEqmz+ObdeU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:52:22.8105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cafcb829-2916-4d88-e6c2-08de186b925a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add a helper to allocate a viommu object.

Also introduce a struct IOMMUFDViommu that can be used later by vendor
IOMMU implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 26 ++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 14 ++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index fdfb7c9d67..3d4a4ae736 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -446,6 +446,32 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
     return !ret;
 }
 
+bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
+                                  uint32_t viommu_type, uint32_t hwpt_id,
+                                  uint32_t *out_viommu_id, Error **errp)
+{
+    int ret;
+    struct iommu_viommu_alloc alloc_viommu = {
+        .size = sizeof(alloc_viommu),
+        .type = viommu_type,
+        .dev_id = dev_id,
+        .hwpt_id = hwpt_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
+
+    trace_iommufd_backend_alloc_viommu(be->fd, dev_id, viommu_type, hwpt_id,
+                                       alloc_viommu.out_viommu_id, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_viommu_id);
+    *out_viommu_id = alloc_viommu.out_viommu_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 56132d3fd2..01c2d9bde9 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,3 +21,4 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
+iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index a659f36a20..11b8413c3f 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -38,6 +38,16 @@ struct IOMMUFDBackend {
     /*< public >*/
 };
 
+/*
+ * Virtual IOMMU object that represents physical IOMMU's virtualization
+ * support
+ */
+typedef struct IOMMUFDViommu {
+    IOMMUFDBackend *iommufd;
+    uint32_t s2_hwpt_id; /* ID of stage 2 HWPT */
+    uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
+} IOMMUFDViommu;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -59,6 +69,10 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t data_type, uint32_t data_len,
                                 void *data_ptr, uint32_t *out_hwpt,
                                 Error **errp);
+bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
+                                  uint32_t viommu_type, uint32_t hwpt_id,
+                                  uint32_t *out_hwpt, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


