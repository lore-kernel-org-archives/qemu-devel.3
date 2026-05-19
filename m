Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE94CD5BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHqq-0007nG-2l; Tue, 19 May 2026 06:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqo-0007ik-Cm; Tue, 19 May 2026 06:39:02 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqm-0006QA-Jm; Tue, 19 May 2026 06:39:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVLJKGVn23ImcksluxsvLrTpHlZSnk3Bwq4CkmpEiXxTH9RAPv594i5q9qQvaDbWhLvXRfjJ1wyvoWPmrqD0lIl/MycySG6dsaHNqeGj/OTRcVUvbIvYYX/GCoJsMG/tGVZUDjEd8Wh3WAKBAPmDMBQvR75vLwQyUhsmDe0r3ECDLicwmWMXQ+/13TYjqIj1MLHWsISiNZSxVJ+8IzPdVWzrSlXhTC2aRdc/dsh7pD1aZCnAo+g2qF7M53JAzRZV36pwFUOKt0WZLF58BbL5XOKTXbkCH911/8SpLSv5Msi9h11V8rwER+GrvJk4dq0iBj/NFIhXm1KzG+7eTp+knQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgTNy3hszip6UP8F32rndIUFqSreKJiMal1aSrvLFBQ=;
 b=a9Z9+GSMdYss9dBhtxbZVo4zu7/boR++WDkZmW51r1n+2HXwF2zkmMMxhfAiiCy/j6JhxhMrkbnS9uUPfB26s8yNsFw+wxe94KsZXVW0FWLqbe/oW1zR9+Rx4hyQyalfSd5DXD64oNFQxGC7C6M2E9tJg2SMP/bjCHKkal8evx8UVThLFyAz/DaOBfc8XgTwA2axD53efkjwy4D8Dm2bPgOcGdcdKMqEzmzJO1rOUn5IUCX/dqH7YWwcAZld9g5mFjXke/Upc9Pd8wbt3CKV04KhYKH2oMNGELtukpPGGWoO64uwIX75Fp9H/TZ62h85u5Z1+Yt/54LB9F11hpR9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgTNy3hszip6UP8F32rndIUFqSreKJiMal1aSrvLFBQ=;
 b=P+CYus4lwoMpLO5kko0nzNl10B7vyEqyg8F4GgGEU73GmyL75DNVsmCXcCtL/52SBH6oKBi0Svw3zTN+755VIQuKjHJhIPCc5sf0QS4zoOEWVxtQ/Ay2LKNW4S5dRFowJ0jM5qqYr1PnmtbT7Y4sN9y5Z9BNkdrUsS+upgwDYS7kfCyKPUtqaMXf4ymum+IkwF8g0TPPaplLNaMGtf0OnDFlP+MmGW/ec4MNfN2XbSAYuhjRVeQCLnAcVlfHz0at0V67Imo7tnSqJQyC1tgBkS65hZd0pBOzOCTNzGl7o0GaNdPSpWkGsk6Qf+gHEf5mH0hMThklHRNtGqTgUTu0/Q==
Received: from DS7PR05CA0080.namprd05.prod.outlook.com (2603:10b6:8:57::18) by
 SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 10:38:39 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::25) by DS7PR05CA0080.outlook.office365.com
 (2603:10b6:8:57::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Tue, 19
 May 2026 10:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:38:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:18 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:15 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 01/32] backends/iommufd: Update
 iommufd_backend_get_device_info
Date: Tue, 19 May 2026 11:36:39 +0100
Message-ID: <20260519103727.899332-2-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: f4911ff0-c761-4987-e0ba-08deb592c9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YYraPJt4lv8CynqWHv9ANqj4bMpzYsAkJpsPHI2Ixtx2IMD3BIu3YrwGj2udvX/r5/awgZfOqdZCI5Gb96gbEp7ouf3Dcnch9DazTWYZljjKMulF9WZHWKHtGwf69O6vWwhieVi4Akb+VxzcsuTIX4+50CAoyH/OIkHvfUkkPoiqMi+7r/gmOWhHa7UPLX/icx7E4JbffWr0gbsjz8+uAEEZKyAoTCTfxNuc1hG2IiwhHGQF+kO1BOhemdoZ4w3t1WgtUGbnswR1X6ZeboFHPMA+qEJIyAS0mCA0KASDLOd7dT/jPm/aD8yMRdyU0NEk7Rj38x36c9M9DKgQQd4rttBH/kN4vrCldAaqvQPF8wKRDdjWsQYCFExpiJdbnewqR5RNhCyQHQLee/lhV2C4NS8kIX8qcs0CwlL68N8WkVA7wcCHVingYP2gQis2askQMMLvf9UXLFbucjgccabeLz0ic7dveVXVgAxa/QJb1FD1eEybPkPBubJNAKvTbJBUW/FPqpFxkhJ2UX/VHMHvY1ORuD9OIUzALoNzzZVyH1TTSj67pw2Iy9YRHB7Qv9HAwh9L9H7pameY1ACeCpasoykhGOO9MyQrSd8q1VZDVta/rR880OgNE6RbTXJjwiwh1B53ylXKIH/L65gR+a7agAJHgb5jRDP2XoY+u/9cu4J5sDRxzdW1CXMqr1Ep5PN8j5ZWoM2EuYA6x4zLcfhQvQUMDRRKUaGPn0mCsBLZchA=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DBiwEJRffNEd52eSE4wTZ3Wk56rBJDUASfu27I94k/Qv9K0Cl47Mza6JTlMPQsv3zfewq+UESM4Xzb9C7q+WNm8epUTeRC8SKvJGdA6+A8qK722wl9wIbHfm+BTDDol26er1z3oCNH+AotFgx9mJNYWBEgLKn2k+ZS7C+zvGaXznx04UvswhTULy6D7vVYG2+R22wytnvnbMOylk4VzrTU7rTjp32Tdv9tn+hqLzhw0wsXdz+syUelDuG3H4H7tQiY+RDeC8Az2Zwf/jycGZiysaHOSs5pXsPRs5kL01oHo1NrIop7qfQLsrfCDKSjHrj26cqEewqfPIT9JWLFQZTOW66/LIU0Y+P864aNSYyXwwOdOQgRHMpCzFd1FABMD71LWJec6vyGu2E0BqYqbB5ZnLj12XLJERJ5OMJYJe4DHxVOLsETE8ovlkbakIIKwY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:38:38.7863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4911ff0-c761-4987-e0ba-08deb592c9d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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
index 05257f74ed..eb13c0b91c 100644
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


