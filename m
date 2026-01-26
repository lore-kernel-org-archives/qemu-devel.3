Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF431CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7B-0000I3-BU; Mon, 26 Jan 2026 05:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6Z-0007Ou-BJ; Mon, 26 Jan 2026 05:46:05 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6X-0005a7-B1; Mon, 26 Jan 2026 05:45:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYfLRbDF1WNni+BBUXJrnwk0Rdfu13npZlF9JWsTVbrMOEU5CX13OIF7Eyp3+iEYrFcD3jCX4JiGJt0EixnGYqnRdM4M8qStqGCmF36diclrsIkqZSX8we9vvBnDXSTrME43Gu0QdHqEvQoxjMfSur0ZvRDkG+PosjdzFH2jBcKSqEFc78IsjHvgAqMuvzaBlwU/F/Ysm7Y4g/hY3orYeeQaCg1OHKFFKh1WykLRmuLRWbKAHvkvgWAvWEx5+EXyLZnH2BglpxhwM5aUnMw4eXS8yWEEbs4yEPgtprsSyTMwa6pqo/JYNuS9uRoQvjhjYJ3v23mfXwJHWjhJydTc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTIwjt1gOPpcKklu4rXxoF7zGNlWrWPuD4ZGhLf5xZs=;
 b=giPkC5mEBnU+xXJK/M/fVmC94mSCzmIEaO6zMlR+/Ab8dUbJZSnlKq+Ij1eTipiTpNNoWXyOUQ72dq9KmhbnmyTOKVsdDGjKj8rM2XOKBGqWu464BAv2KqpD/voKS0gTrInQicbLcoZh4kUtgssFmfW2EDHjn2mIyIwc86gt8b3EQhLnit3DiqqC6O+F7k+lBWF1BJB3zatXaS3ZjwUHNvOi/qNwu9IPnIBjp7Qcbupt8AbInCY2DA/U/o6oy19MxikopeSce5yEm41dOvuSwaqzzU8Tuvmp3Vx1OqwViepOiavTlHAtSTKKEnsr/g5NCuJ4LMOkLccnpIJmOeieng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTIwjt1gOPpcKklu4rXxoF7zGNlWrWPuD4ZGhLf5xZs=;
 b=Znfy4EIwDvfxmmhvpFwfJQbkrQIFeAxb4jIrfZppoGHzDOPKAOBhze8oPAtgRFRKv3gr+18qwFL2vAQXhsNI0km3z+6F5b4JXfU/aghQKoLcwfz0uybcpXBjg6fz5Sxj/6B0udWlzLoyAjRRuZfeCsoq7n4r2cetFkpo3qtJSzyAEwDKaTLatJf1258/dxx2gkzoLMAOfB2prmIfeJKapyyo8ygPSH9nW1m5XtLU0Tnp4N2rZzGsPxvsKBV0leP/zuFUlbOhkSCUIZ2l8/F5Dp6OyYdLlCDiOVGVSPCvvxO9gd3NKAIaj4yFW32zbCJ5VzyC8snACNZp4d9ZAfG28w==
Received: from BY5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:1d0::39)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Mon, 26 Jan
 2026 10:44:46 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::56) by BY5PR04CA0029.outlook.office365.com
 (2603:10b6:a03:1d0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 10:44:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:34 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:30 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 02/37] backends/iommufd: Introduce
 iommufd_backend_alloc_vdev
Date: Mon, 26 Jan 2026 10:42:59 +0000
Message-ID: <20260126104342.253965-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 084394ce-c806-4bd1-2f99-08de5cc7ec42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jZ3CcZVYHiEDhF+UWrcoxr5eWZiv+2jKywyNLNLqQvml5BTRzla15r2jwKqk?=
 =?us-ascii?Q?pkX1gwCgzqRMOmFI2kayi7oCEAsRPRfe4P9U8xvclps1Hwy7E4FnG1YzJQcF?=
 =?us-ascii?Q?N8DXrvn1ZkFkEd+lg2/IFobs7tfMDKzSFx7R86Sdn0SMR58ONQ5SVI3c6HU6?=
 =?us-ascii?Q?LDZpn3uAMT8Duhev9fTMR2Cuca/fkBie4tJ7B8m37IRd0Z8fHfvdeVLqhU8U?=
 =?us-ascii?Q?Dkx52UQgdUz0GMElFrunI0oSfU9FXVsVl6gude5y9W7U3zYC6upo0LFU4eqs?=
 =?us-ascii?Q?kYJSA/jKA1ceGC5s+JQnXG5Q65gJJRZ0wai6XNyt8lCeV5V1OL4S1eRrs00k?=
 =?us-ascii?Q?aizgdH70OtU0kln07Tdr4GaT+LVMc6EwpC6efMPQkTM7sxF/fSTWkgpWgRsv?=
 =?us-ascii?Q?aUUTM1Zk7GyTSZkDlJyUMUpQ6aRIjIH3YEkK5bvpkubQwrQ1Lwv+tVebRlUv?=
 =?us-ascii?Q?g2vM08bONRaNkyRHFZOOzIpDc56e4GCFMqPqLQ6a4rSd13ErXGY5SoWVwxA9?=
 =?us-ascii?Q?tI6z7m+dX2mniDOH0fIHyVz85ZrIL96hX0CozMRF5cF5JheAYap1ex2mU2Ic?=
 =?us-ascii?Q?4KHNsZ4/+hBlFYod5dIzPgC0FBOYQQzEqr8tLfcnN3JncYbMINcG/IYBldzy?=
 =?us-ascii?Q?eTBBMNw8ZwXvUNz0zHeTs+j6uAW+drf6jzqZxWf1RAV/B440VJe0W2BjhIS+?=
 =?us-ascii?Q?s/+VNwbiJqCAWyjfV/gmvZbwrMJ02PkhLBUXsnnzREp7DoYfX0mw0pvafSIQ?=
 =?us-ascii?Q?x45RV+k0F6JIr9egZXz4v1eK5BQN8Y4csDfGm9cvIXm+q8WIPti4D1CKfe2F?=
 =?us-ascii?Q?rkWvI2OnmRwNqPVxRRT7vImC/JYqal6jDAan3r948cB0SyG/zCfEUpBFRFqt?=
 =?us-ascii?Q?+5idg7pd9Ql3NTBwPqGWpbz+8KtR5aEB2acZIfwHnxzNle8V1mFMlk2chlM8?=
 =?us-ascii?Q?Re82g8M7o5RyH43stqTMBYYc8UiykNEJxiWkcFIyxQBsvApUwHVhfBvbuMvH?=
 =?us-ascii?Q?4liDh0A2sRhrjwKaGx2tENpqYk3OHXPyb4IazWTiY1D6m+YUfxP7lUvW4KvB?=
 =?us-ascii?Q?U++vMZbY6nzyreIvY7NSS6NXnfN/pZxQB0Yuxj9dbOfPZBEcEJI8o+Ge/3qc?=
 =?us-ascii?Q?U8/dwvO/vVI19Z7vc9EnFfsbUedE38SQ13NIlRv210RWe2aL6ybZoDSaTfOD?=
 =?us-ascii?Q?cNTDrcWyhwGnoIaxb00h/hat0CLkTbUTb/u9od5IH/Rd+cLzeXx/VNtEC/Mo?=
 =?us-ascii?Q?UesTuB97FP+l8RWjsmuHdMIifbX13u0wzvIP1z86TD01380EWc3lMPjr8PXT?=
 =?us-ascii?Q?t5ccU+SkrFmb83rnbw/atXcdIS0yP3A2frVALfCYZaEH5yIkZ28zflaUgMvj?=
 =?us-ascii?Q?c7as9OxaIwj1FRcWU21tfKcQg8p2ssA1DE4WM2jV/hofCV7LfC8bsmebtX2a?=
 =?us-ascii?Q?XhDyQCBWUlqHswPkciAMXI6hl3VlSyrGG8d78a172iZrDSiJ9zHB3+mhjFiz?=
 =?us-ascii?Q?W9lTbJW0O7G/vSvwobSzfj1XlSDHKEB+EuaNXl2ZjVVBNtJkkyj0VxpZJDhm?=
 =?us-ascii?Q?3vBy0RA6+TI2etJJjn5llVAvT/uk6aLzQzS/QVgXBKancaP94DZjsk9AbjHy?=
 =?us-ascii?Q?rnn7aWHLcx+3+oj4jeLuD+o2PJaEWCDBJ8FP/Zgw32uxSo7qrByrBxEAaVRr?=
 =?us-ascii?Q?BBx+gQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:44:46.4452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084394ce-c806-4bd1-2f99-08de5cc7ec42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

Add a helper to allocate an iommufd device's virtual device (in the user
space) per a viommu instance.

While at it, introduce a struct IOMMUFDVdev for later use by vendor
IOMMU implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 27 +++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index c65dc41d71..e3a3c1480e 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -473,6 +473,33 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
     return true;
 }
 
+bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
+                                uint32_t viommu_id, uint64_t virt_id,
+                                uint32_t *out_vdev_id, Error **errp)
+{
+    int ret;
+    struct iommu_vdevice_alloc alloc_vdev = {
+        .size = sizeof(alloc_vdev),
+        .viommu_id = viommu_id,
+        .dev_id = dev_id,
+        .virt_id = virt_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VDEVICE_ALLOC, &alloc_vdev);
+
+    trace_iommufd_backend_alloc_vdev(be->fd, dev_id, viommu_id, virt_id,
+                                     alloc_vdev.out_vdevice_id, ret);
+
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VDEVICE_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_vdev_id);
+    *out_vdev_id = alloc_vdev.out_vdevice_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 1ae94c4290..14a7ecf5aa 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -22,3 +22,4 @@ iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) "
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
+iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index bc4acd1e8b..567dfb7b1d 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -48,6 +48,14 @@ typedef struct IOMMUFDViommu {
     uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
 } IOMMUFDViommu;
 
+/*
+ * Virtual device object for a physical device bind to a vIOMMU.
+ */
+typedef struct IOMMUFDVdev {
+    uint32_t vdevice_id; /* object handle for vDevice */
+    uint32_t virt_id;  /* virtual device ID */
+} IOMMUFDVdev;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -73,6 +81,10 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
                                   uint32_t *out_hwpt, Error **errp);
 
+bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
+                                uint32_t viommu_id, uint64_t virt_id,
+                                uint32_t *out_vdev_id, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


