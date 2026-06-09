Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C1ACD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWuc6-0006Kh-Kl; Tue, 09 Jun 2026 07:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuc3-0006IS-2o; Tue, 09 Jun 2026 07:27:19 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuc0-0002wy-RO; Tue, 09 Jun 2026 07:27:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBDgRMyIOFubhLg4YJgeNtUCuJ8b9ReMcLp/nIy8RxLgJvJRcVQYI6mEjpq0tA9rVowWBfMq7qNERK8m8MAXGEHKuETWC3l4D7x5+4I7y7PdKk4T8JCoRW933v+gub9zs0QbRU7u3Rjy+xI52x8bW8ZC91uYPC9OVnajEW79b74qNvJNvtEWqk5L/K7MRFjnTTf2MSwAA07UtperH/mdYo/gwOooXvZlWQvh4p0Ejutp5kXOomfRoirH0p9CduEPqYiZ0PP4zjPELV7lNp6gjCCK/AShGd+F+Wk7fsQqnQVZ+w3OjUHyO0HG7NeLm/6yf/BgYs2v7UCm4aQY28eU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNvF+T9ACFARBnHQn4jVRWIzhE2PW5UQBNk2K8XW2ZA=;
 b=okxh/mGHWYvCnfy0q03TdK5QO67+sLPpTr5ksEL5BGkmlG4fUSEdawyF0clNbEUyLCzZXJriSVYibTnFu2jWkFeq7OH9CxqCHXfQT2YnQHqjrkpgQLhi8fBqhT8wBd5+3ivupNrAem44wBv7VufqLSgjC4ije1auodVEB0pc8UlgB0e1+D67Hd+EAacJwX93VwXU/6RSoYfoKm2SrfB6ccGkgTMJLhJ3AiXKBNGbBnRr/jH/g5h9mWwSheVlfnAncgByH7R17is6uwGDPhY+dk/hKJQGPu9JhW+uLbfRgANlogwumwd93YgVSWo0qdijwlrVr7x3LMMz1O9esHkKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNvF+T9ACFARBnHQn4jVRWIzhE2PW5UQBNk2K8XW2ZA=;
 b=tDQW8NwVhFyqIp+0tuGPqZeXrHLXwe6oeDcCdA10iWKZ7grqjgKhXrppgLoPUzXhbOJ2oH1ihkptr4yBanddH2he5kG1/DOfgziuXx5Ax53Tp6nT672fzBHvCVSTBe/G/14SclLSGVFPNoOkGf8aUNITU4gWBO0uUIEramW4n+GNIzw7wfN0/Anzi26j4GH+rIN0Yxnl17C3mO6YJVok2mcCgYiazcP4vQow9bul0lMPtW4L7LJkBHKOjPUoTasZ/MTcZW+YyC1EJGL46koXYp7ONy5Y9rFcIIosDn2ODxjQlXf9/T6IxNcp6NXSHROg8ny/Iynyfr3Gix3w3JV/Dw==
Received: from SJ0PR03CA0272.namprd03.prod.outlook.com (2603:10b6:a03:39e::7)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:27:09 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::69) by SJ0PR03CA0272.outlook.office365.com
 (2603:10b6:a03:39e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:46 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:38 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 01/31] backends/iommufd: Update
 iommufd_backend_get_device_info
Date: Tue, 9 Jun 2026 12:25:22 +0100
Message-ID: <20260609112552.378999-2-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: be75a49f-ef54-4fb8-ec0f-08dec61a0a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: cDX5/vjYU5bpEwA7jYiwh/TbgSnNFIPWAh19J7mSS6ETa/T/q+wekuIaESvbkXdUUKkXVaB4LDfmCppoeBmiN4YCpi203A2JOnwZ0ossKe0TSjNN3bkcAiXB6s83tXVHwRQc3eSpzElxFop5HRSSRVPBIEdVFGUsyekssO7OHbRd9iZpkRcNo9gvDYn0ZbJjSnLmiidnIz1PPGSG4hBV6it+Q55eYs4nLxtIfKbyoTLhgFdmQN2ZlF8g8C9ezcoK53pm4xevq2MErtYB08G6lvaEDWGHjEtOYZDaGe9F+H0ohb7UaiT+xRp4rGdfOwruKwYIcDwZU0VzrJ4gp4m7yFQ8Gy3ziwZ47Prmz7Z2k7Ghr5DJSHPZJgIP69+7Oh0BB94xtVDOV1HPV1OBoooDcxNr4Hl+Lia7mcasoHxWOB2ORTYveCzES5FGbqzzv2E2sqbeiN5ZnwRt9oS+zuDEzhJg+wek1lM81LBcEsbJnI6N8rn63JVXX47i4XCEI0MfN4U0jG8AZghaiqgaD7EGVppOgq6scThok6dHSuzVxDI3D4uPQVv6J0CCovJyTmwwEJVNKcOm328h3gRUnatklj06K5byBsesdAe8TM4zq12mcDjAsUvB3rPsFsVb584rpy5cY4Zz4vS/lfrMMybO4vVeWNFxX2WL9FFBSb8eHlpmA3tA2YHyZu4J5LCSSkBANVrsDngS4PqSbIcqzBb4xvf8z9gHFO4dMXt9/Lg1ykg=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +wgH+L5WsxTGlurwa9Q4HIiy/M+3ArccbbHg5Nxf51rpnfv1mqTLD8MkKkfBgYdvPnUEkD4G0jwlI9qFgdQQNtPC7udxE/rxpdZ/RhBILnD4272/SELLXKodijxEnPkoaQN7hHh0T450WDAQzMjuPgI/OnT9Ze49vtlEQ/H+aaHX9Zl/S5GACFU6l+LqAj22KgbUdkrDAhCu2rfNO6SRyc4VWmT09qtJc3kRLigfSjw7wT+C2mrTfxI7xFtjiA5lu0e6CWh0R2HdDXw0GaapOcx5RJxceGwUn758l4gYLpqaQaD1GMyE5sFMI3RSPUbhajGYn/a5zdRrijjO9pCgfw7JYinchLKXWEgnE4cTdvQtUfWTHcuzkgPpktk579V+n43frMA02Ug1vMNhH4NhDV2S8KHrVd9uDhCrWsn5eAhDbSqlcUeAUEwjlpaUSg3C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:07.9861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be75a49f-ef54-4fb8-ec0f-08dec61a0a8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
Received-SPF: permerror client-ip=2a01:111:f403:c001::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

The updated IOMMUFD uAPI introduces the ability for userspace to request
a specific hardware info data type via IOMMU_GET_HW_INFO. Update
iommufd_backend_get_device_info() to set IOMMU_HW_INFO_FLAG_INPUT_TYPE
when a non-zero type is supplied, and adjust all callers to pass a type
value explicitly initialised to zero (IOMMU_HW_INFO_TYPE_DEFAULT) when
no specific type is requested.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c    | 7 +++++++
 hw/arm/smmuv3-accel.c | 2 +-
 hw/vfio/iommufd.c     | 4 ++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 410b044370..8c3a981392 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -390,16 +390,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
     return true;
 }
 
+/*
+ * @type can carry a desired HW info type defined in the uapi headers. If caller
+ * doesn't have one, indicating it wants the default type, then @type should be
+ * zeroed (i.e. IOMMU_HW_INFO_TYPE_DEFAULT).
+ */
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, uint8_t *max_pasid_log2,
                                      Error **errp)
 {
     struct iommu_hw_info info = {
+        .flags = (*type) ? IOMMU_HW_INFO_FLAG_INPUT_TYPE : 0,
         .size = sizeof(info),
         .dev_id = devid,
         .data_len = len,
         .data_uptr = (uintptr_t)data,
+        .in_data_type = *type,
     };
 
     if (ioctl(be->fd, IOMMU_GET_HW_INFO, &info)) {
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 06dadf9cc7..163d3e7279 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -176,7 +176,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
                            Error **errp)
 {
     struct iommu_hw_info_arm_smmuv3 info;
-    uint32_t data_type;
+    uint32_t data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(hiodi->iommufd, hiodi->devid,
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index df148a49a7..495a59cc2e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -353,7 +353,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
     bool viommu_nesting, viommu_nesting_dirty;
-    uint32_t type, flags = 0;
+    uint32_t type = IOMMU_HW_INFO_TYPE_DEFAULT, flags = 0;
     uint64_t hw_caps;
     VendorCaps caps;
     VFIOIOASHwpt *hwpt;
@@ -948,7 +948,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     HostIOMMUDeviceIOMMUFD *hiodi;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
-    enum iommu_hw_info_type type;
+    uint32_t type = IOMMU_HW_INFO_TYPE_DEFAULT;
     uint8_t max_pasid_log2;
     uint64_t hw_caps;
 
-- 
2.43.0


