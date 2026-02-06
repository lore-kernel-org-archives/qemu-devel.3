Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96529EE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNA7-0000dh-5k; Fri, 06 Feb 2026 09:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9U-0000Pb-Jt; Fri, 06 Feb 2026 09:49:45 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9Q-0006xL-Qt; Fri, 06 Feb 2026 09:49:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSNL7rL+/wFJD8aZAsqhl/iRv3VOzIQFBbKvGgFtND/P+Oe/bQhBSU0otoAAaFcGD+ptIDN02oShHH3tqFKUIegXCCUECtQY9TGUuVTD4TKoRhxmzaqUlvjgdsr2GY/+ywOqDZcw+FZHE3lpH5N7E6iEfiEyVg/h7ZNlbpVV3PKVacXMGkf33D+94fMsHJrPX8S6m8MT2mYqIpMn3UyUwDacnP9Ks70rcrh+mjONtGkpIS390CvGKHsdNcaIx4NHIVyUlY61RnMpDVY89xwQ8WrDByxpsXK1AOSheI3BMoIFfoDfEiwEzHXAUytDB280dmzolZFNoF9CAoXg6C6feQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kafwm286BQaxjQefzQFPtvsDciWGr0u7UMNRy4KkTlc=;
 b=ozy9gUqlQ6Fwqx3hFVwMx4Zd+B3CrKyeGXMU6Wv2S5u3jz3QSJ2slaMRz9MxLA+RNOVWVsfrn1dV4tDkUeTdoUk1u/W/birWGzPMaCLmIT2t6WTwuzo+5NW3mWJ63ke3tRa20SirKWmdttaAxCQ9eTYLubqcKy5NSuPhzG8h8uJghsKI+fpOw9TQPvqOJCA9fEODdcw6q9nsAQ95wwISOl0uOGHmrvXsSmG1EGXw2uePxPw20w4XaNmssP9LQy/jHJjyT5vcKbVHKWOjU4Tvra6xqMNhhXT9gnBIbs5QA5rQiIPqcFl9wZJpd2rYVodOMnj/nFS3pdVlKaiuU0p6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kafwm286BQaxjQefzQFPtvsDciWGr0u7UMNRy4KkTlc=;
 b=G7QjswvHuYAkBcUlGRMiIeVar3dOkRW1erIr2GSk+QCWEuYzLUfOFUAIyB+NWNmGCfvzds2wKMyYScOj2RiXhHDBlYTGY03szgG/wy3fi7LMjcMXgDBK3eCPMqNkLtQQA9pLVFMmo0xcbA4M7PHpS7EXH8yH7vRlurPw+Ite81jrhve2fZz0NYMj6mInSz+lvQ76tHsy70zdV6ujjKmUdX0Ru0r7JZ2U7L/SfwZCfnmkSUfY7DqvpHMr1inPm9KpyTd0AtsX8KMgpxz8UqNwgJGOfSiXg1L/gUgY9VE9pzN6cdSQlivQu34lXfMTJ9TsmylG3dXz74s6GDHsTTNEVg==
Received: from BLAPR03CA0038.namprd03.prod.outlook.com (2603:10b6:208:32d::13)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:49:27 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::82) by BLAPR03CA0038.outlook.office365.com
 (2603:10b6:208:32d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:49:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:08 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:04 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 01/24] backends/iommufd: Update
 iommufd_backend_get_device_info
Date: Fri, 6 Feb 2026 14:48:00 +0000
Message-ID: <20260206144823.80655-2-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a24d80-8205-4a1a-98a9-08de658eed1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1jE0y4K8BgySB1weVVOgGueILEqpozOuo1jrj5jJFBxRLEY6dolhZ3Q2/1DL?=
 =?us-ascii?Q?kBe/lxcJqFWylW8Jt+J498VJ1LebfsHMXTHhszm3ei9WZYcCYtVpGSBhNv59?=
 =?us-ascii?Q?zOUafEUDPeYyTDV5YMBk7Ql6RglOzJRyI7b5zWYHC8aIZ38NwRH70hkLGaor?=
 =?us-ascii?Q?vmN7V1t33KufqfJCJAOZpZLmjK14Ls4HRZcUrJDl5eVUqaHzgeWISO9gNe64?=
 =?us-ascii?Q?0yQgZfrlHvX6aNaz9YYwBIoCLWAwVvInObbNJgh1lqfDdoDUDClO4v9jQDje?=
 =?us-ascii?Q?Sq8xeUCQMC9hnggRTTmFr+/8vBTA2ojQ/M51oQYSfXYAfKTTwe8jqfG1Pl05?=
 =?us-ascii?Q?U/GUmLkqU0jyRGiJJcKP/PGwohFRrbVkF2UEGw2h3LJocOUUD4dovFOfI6x5?=
 =?us-ascii?Q?is1nK1ImyrU53JjHPWxBSJzJoN5FCou1dVhbrycSrqtU0lsIS++PK+vr0kO0?=
 =?us-ascii?Q?a/FVuGSor3/QQrNYsIC2vcD3Kg4Mn5S/+MLTsN7F1ZVFrdUG81YrIhxnHHeS?=
 =?us-ascii?Q?V0I7sOSUYEAl6Vmgd/CzQpWp+CFu0tkt2TBIzJArnYDlmzVFsyc2yF1ZZr70?=
 =?us-ascii?Q?tfBDPEJbSf1mGIaaL0hau3eZHghOlSHLOdoP8wdJzlGzd0kESgLHb1bJkMdq?=
 =?us-ascii?Q?LSgB+FsZHtwYHueZZvqzYGknnB27CLfqyA21vCcNsO6Pz8v23+Nk0CFNwjc8?=
 =?us-ascii?Q?LLc5txiXxHL+ThUc4POISd2JfCiTS3x64Eg2y10tmgAiJmdRFSOz70XNUyoM?=
 =?us-ascii?Q?96iNpBdHsr4+fTCvd/bTQbNd52z4i9iRST+auKC9uBaOnUfgT08PZN5tJcjb?=
 =?us-ascii?Q?ScPDpN7Sh+uiF2eWXCmd5w5llEJpB0kdhQYnM9+gTJivswb70X/vnfA0Q+QZ?=
 =?us-ascii?Q?XRcaCt/W/41b8NuHvhTK02iP/BWN+JYfdqmEYTGHaxLcpzjWvaUv1J/SjJbM?=
 =?us-ascii?Q?bRClsUZKFggpa5w0w8DO/PmdJ7aQTZWrL/xC95nhsnz/w6bgRNSJUO16kmeZ?=
 =?us-ascii?Q?pDAI/S9w9B7nLtU1DP9hJY+Ic99/dEYqGmssNBwUvXjqhAVj13Vnr84Qj83n?=
 =?us-ascii?Q?2PbXcG90H3U3oQrq2YAKxNzapZSsXmyQlY7bCzMvOE3ctUyDaIXS01U6dX5z?=
 =?us-ascii?Q?VJYW1MDbDADvuOYwEYAX/iHx+9FHouzlP6iK4QNT2bSA/NHYpw8PrXHaVK3D?=
 =?us-ascii?Q?Pksu2dxoYaIj78z6QH4qKixTGrdAVRK+VxKCuvqhY6AtlA5abt1+SyZtpjsq?=
 =?us-ascii?Q?rgSSPNsEJlDlkxc8+ut0Lz/k0B/2qwpsoERkK1Osb/+AAH6Vr4cHhrzuTNcK?=
 =?us-ascii?Q?gb46HuTWg4Vu07fWLTxWAccUDMH/yn1LeOoLuyDecEZjX7y3sPGa9z2fQtvC?=
 =?us-ascii?Q?qKsrpH9Y4aN/UAle7kqVMVsxI0Q73GTf4pRu7uXz+yTwGHU3LuYZIEw3yndP?=
 =?us-ascii?Q?EPjkwmeeSFbteVVV7+43UXusjGBD+zt7xt6C4Vl6q8XQqogCrxRG7bgx51Im?=
 =?us-ascii?Q?A7suuBMvVn8iR5Y52BhH9/oCGEpy80yRCXaQWdcxZzWnBJBwmxSsL4g9Mt0+?=
 =?us-ascii?Q?jQ7OS/P0v71hXkd9gDQXgO7+U5NZgb4I/sgo0BJF5FEnlLnMnIuabW53Ow+U?=
 =?us-ascii?Q?ymEVpMPp9cbJkO504Qn52eUstVWyZiYxDwQnEPBw1okbhsPKMY7OBFufLZhI?=
 =?us-ascii?Q?d/cw4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U8p0ZOoIfe4Lb/VAooUgWjT+cQ2ClZjnmcYKsxIXNqZyWjLU5S2o7q/6zXN/+kWXx+VXLZOaKCYUrcTxgXwsjDSSHyUam3AAY1JZ0PHqxwdm2tojC/j5Z+Dxg4RwgU2ZQ4QEposk7MKeZEZGo2R94OxLaqB5fvKGn/8EpyCNBnWAAxhUbMFUOFlafykdt8DvC0iBvS3ZB7hHKwBZio5wLtMxYNXOWvr7ivbPjc9sQQbbuuKEGtNBGiEpQpn2XDxv+7WOA7B0ew/FmK2FMN+aY/pFsFHLC10338fBSkc9/UDopKs1HKMDLlm/9m/IVmcLNXaT2rWJ/2A16hxlkFS1WLzvE/UcgnwzdRbM+Xqqw4pgTwMd0UV4mreymqVdL1synEOrg+g0D+wWMjRWxVddWElfV8XvsIB47+nfvWcGDhJugdKecFh3kmJUZ5NkOPRu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:49:26.8962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a24d80-8205-4a1a-98a9-08de658eed1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

The updated IOMMUFD uAPI introduces the ability for userspace to request
a specific hardware info data type via IOMMU_GET_HW_INFO. Update
iommufd_backend_get_device_info() to set IOMMU_HW_INFO_FLAG_INPUT_TYPE
when a non-zero type is supplied, and adjust all callers to pass a type
value explicitly initialised to zero (IOMMU_HW_INFO_TYPE_DEFAULT) when
no specific type is requested.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c    | 7 +++++++
 hw/arm/smmuv3-accel.c | 2 +-
 hw/vfio/iommufd.c     | 4 ++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index acfab907c0..5daefe505e 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -387,16 +387,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
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
index beffb8aa94..14ea4eac37 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -127,7 +127,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                            Error **errp)
 {
     struct iommu_hw_info_arm_smmuv3 info;
-    uint32_t data_type;
+    uint32_t data_type = 0;
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 131612eb83..d0f124300d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -349,7 +349,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
-    uint32_t type, flags = 0;
+    uint32_t type = 0, flags = 0;
     uint64_t hw_caps;
     VendorCaps caps;
     VFIOIOASHwpt *hwpt;
@@ -938,7 +938,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     HostIOMMUDeviceIOMMUFD *idev;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
-    enum iommu_hw_info_type type;
+    enum iommu_hw_info_type type = 0;
     uint8_t max_pasid_log2;
     uint64_t hw_caps;
 
-- 
2.43.0


