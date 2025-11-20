Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C68CF885A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4ef-0007Dv-R3; Thu, 20 Nov 2025 08:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eU-0006m8-OG; Thu, 20 Nov 2025 08:24:49 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eS-0002L3-DD; Thu, 20 Nov 2025 08:24:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMtwKsDn0EmrTW0d8sWcGBW6xTuW6dMWSTLqpZWMtVfp5obhmq/BlZqVjL0pcFb86+2W+Vq75rkXbTdAIcVQm8BzoXx34BEruntyapDGC4mf+d3nE26hJ36YG4cwUb9eXPnqPtuoI4iKMcDR/gm/S6ZXjsO1KoLLeRSwnTmo/ak01tLClZnrYgp0q2WT0UFDagHmkAD5dr0Yl0TFqtGgvQOK9Lrjo8duWurD7sMUnsnaBytgBRTEbsGLWCxeSVHYFIcBkRniuoMyUdAFL3LqiErLpLF8IFA+dNjPDEn2kpZ8Vw7mF+YCzOP3LBmsXfWjsB+NbDaGHWB5S+Nw+y71+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ju6C6EofWUpSrOFk//od3wB4QmEYe0BnwBKvgAZ1Uc=;
 b=fJ3LGeNFFxEnX8iDjkp1HBzNQGuL92zgXg7NU4dc4KMpVQkfVTs+BnalhsGbiN0EFmK8OF3CH1JucAwEDQ3gPhAsZstSvbLjvV7Q/hWncIiUwxvY2TYxlvlMuddGLxTTGdeGgf+8Rd2Illi78S8RBGwnVEpt92I4bhe49MbAMWhNaFmKCnn1SVsx7Jfs3ufn/lIoua2Ac2QPtTg8NEKpCINc+Y911WEvoBsEYU0xAjb1rvNfngTVR9SfuHrbo2pOSnRUKSujGiEw5dQphqq5LXXecyzgQASbUIgjFmguL1VhsACsSDAKql2ej9PdjHb/7LysxK3bmP5ugtepCcutVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ju6C6EofWUpSrOFk//od3wB4QmEYe0BnwBKvgAZ1Uc=;
 b=XrEEHqoXwKuSexWkRCdogG73zirzmzk5KdLIQxwcG1vF779IP/moZe9Eu2t/CV+mjwRX8bbhqi+UT/Wavm+g8X/DH2gpKeeQWOHW9xhGqraGJ2Bgb6zii49CoSsDpHQnmhLSm6b7We2MvauXtPgZsQCtQg1Ffrr4B23YBQtEonT3qpzcP+y+Z6PKLf1aCzmJQzPS7aBxhKoZ32jWNo4FTKRSH9ZBmxVjDJpGfEfm1wwFNP9TuJS4/B746clZbwuG8WSa/ZWoA/p+778BWsC11Gxu/IMv3bwWbBO1c0hTtuz3S+9xLJvaVFLqHH70Gw+kuTovopYgYAvlj5Yg7owDBQ==
Received: from SJ0PR13CA0227.namprd13.prod.outlook.com (2603:10b6:a03:2c1::22)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:24:35 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::42) by SJ0PR13CA0227.outlook.office365.com
 (2603:10b6:a03:2c1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:17 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:14 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 14/33] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Date: Thu, 20 Nov 2025 13:21:54 +0000
Message-ID: <20251120132213.56581-15-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ed9122-39fd-4cf9-237c-08de28382594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZPZbYNaXpVKccumdymirruCdLJlJ0ilymArQCXsJn7StriBBFICAomtaTmIs?=
 =?us-ascii?Q?GUbjJYNil+G1FzA/Cz9Y82Q7EOcinn1i4ZlIqg3Yil3MKYQbUJi4Gh/+461y?=
 =?us-ascii?Q?RDbLkrwsldh61w2WcBj7UiJGGtYCYch7xvgAIrHkNA27FOeDhyyiNRieuzwO?=
 =?us-ascii?Q?UgedYu/IXTvcXSj32AduHog65kOFqBOWiVPAv8EA0M5NxI+HtE4yhEmtlA71?=
 =?us-ascii?Q?vqz1fGSxfjYftAII5Adq/TGx0S42+5nwuxU8I/LA0H4Xw/E1IKTmcA1NBaIf?=
 =?us-ascii?Q?rN12KnG9mNtrogiJTZcedTe3Jxu1NJnVPMV6PS+nMVZ5fyBoxb4UmdxRggMt?=
 =?us-ascii?Q?wjbPE/hirUaPknRLBNVDdDkFsec0NFV1k0KCTgMyN63wWg/peWz3FfDmXRGz?=
 =?us-ascii?Q?EXEmoPEhLZloiZtx2CPuf+5fa2sa/HEtI1Tg0f3NwkLc9tgJsVI1nFL4ACXe?=
 =?us-ascii?Q?+sqqq6+msdPLd2RCEax6J+VhwHAuZovh4P2YQB91S4SSyxmEmDgS+IULd3kv?=
 =?us-ascii?Q?R43MbMCf7/kiqx54UwwPaJ0XGSukXZmvKFLCR5hRzwRdvMuY9WfbiFd05fJe?=
 =?us-ascii?Q?O1o6o93zXmM1F9pDKODBwkWqCCR6Hnr1//kwD0z6pL/GYb5qyos4uFY32IZ/?=
 =?us-ascii?Q?2uMmLHq6dGPtxfo2Lgp5HzK0l4kjlFLA/jDedmISSL/pPsNlQidawdZXe1Kd?=
 =?us-ascii?Q?7vCjSeHXBIuMMMUhLuLyYlG+ojQqI9MkaC3WFbViqa62ZemsTYsa81G3BxDk?=
 =?us-ascii?Q?nW0uKobovuiQ05SvWgqoL+jKC9rD4mhKkAgErr+ieRwcLYP7Uq8Z74CEQHh5?=
 =?us-ascii?Q?O9TUAscyUCDL21PUOoQmtR+8xzYetmUeFl3U0k7ulqo1GY6IH3vOf2fl69ox?=
 =?us-ascii?Q?L6l6YeLlLzoymwwbCWzDd8SHNCWXyYc964xDV+OI4E8NPYdDgzNWKV1znDGt?=
 =?us-ascii?Q?PEsevaM9qkuOAwt7blSuQfw+CeCyOWYgsH6POoKpBjczurlMiYOp1S4OzxY/?=
 =?us-ascii?Q?iwhO8EXiAtakwyf/vAjTOeqqeWQK/3UYt9OgGQb0X4sLHFxLyh5DxXQ22O6y?=
 =?us-ascii?Q?3/RFE+N0j8kBpmzXbIPQugHlQlpYUmLeV3nv5KgInUWxeuuzVoycKCTzVQee?=
 =?us-ascii?Q?qNdMAr6ruXHiTpxmFl5lb37U8v3HFnezwdHKYBkT2KG5PJEX5qvnLH6J74+0?=
 =?us-ascii?Q?/nhSRM4PQJ4YzXoHl+oC/pJGVnIBjrECcbK13hgcdkDBAgAuxu0eEr1uqObH?=
 =?us-ascii?Q?U09UyPnQQx+Bx50x6ZmTUKjn5MAouuoqRnsvdFy6ydXCU4ns4SvNCRLsqLH/?=
 =?us-ascii?Q?EDeTtEiuVmrlMWe4mapxZZVirvw6Ly8teH74Ts41LweMoVCwfd3Y6uWT4H6H?=
 =?us-ascii?Q?DBzzOQri7lU0I0pYBa0ZSbNzdAHXgjREFzdUbv97CUifGynuNGRfwZ1ebMjl?=
 =?us-ascii?Q?5yB8crQEaIg/sSBCffafoz22Df20e+N2MnQETLpQYcK3sJDWGoz3uwonS5PL?=
 =?us-ascii?Q?Ael++wSJSX+kFMb3iMJBtc94EShJCER5xm/1OPrPmPC0XdUxfL6O6fr5OMr0?=
 =?us-ascii?Q?00mRILWS/RSLjP9RZcY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:34.5967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ed9122-39fd-4cf9-237c-08de28382594
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

A device placed behind a vSMMU instance must have corresponding vSTEs
(bypass, abort, or translate) installed. The bypass and abort proxy nested
HWPTs are pre-allocated.

For translate HWPT, a vDEVICE object is allocated and associated with the
vIOMMU for each guest device. This allows the host kernel to establish a
virtual SID to physical SID mapping, which is required for handling
invalidations and event reporting.

The translate HWPT is allocated based on the guest STE configuration and
attached to the device when the guest issues SMMU_CMD_CFGI_STE or
SMMU_CMD_CFGI_STE_RANGE, provided the STE enables S1 translation.

If the guest STE is invalid or S1 translation is disabled, the device is
attached to one of the pre-allocated ABORT or BYPASS HWPTs instead.

While at it, export smmu_find_ste() for use here.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 197 +++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h    |  22 +++++
 hw/arm/smmuv3-internal.h |  20 ++++
 hw/arm/smmuv3.c          |  11 ++-
 hw/arm/trace-events      |   2 +
 5 files changed, 250 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 4dd56a8e65..2e42d2d484 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -51,6 +51,188 @@ static uint32_t smmuv3_accel_gbpa_hwpt(SMMUv3State *s, SMMUv3AccelState *accel)
            accel->abort_hwpt_id : accel->bypass_hwpt_id;
 }
 
+static bool
+smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
+{
+    SMMUv3AccelState *accel = accel_dev->s_accel;
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    IOMMUFDVdev *vdev = accel_dev->vdev;
+    uint32_t vdevice_id;
+
+    if (!idev || vdev) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_vdev(idev->iommufd, idev->devid,
+                                    accel->viommu.viommu_id, sid,
+                                    &vdevice_id, errp)) {
+            return false;
+    }
+
+    vdev = g_new(IOMMUFDVdev, 1);
+    vdev->vdevice_id = vdevice_id;
+    vdev->virt_id = sid;
+    accel_dev->vdev = vdev;
+    return true;
+}
+
+static SMMUS1Hwpt *
+smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
+                                 Error **errp)
+{
+    uint64_t ste_0 = (uint64_t)ste->word[0] | (uint64_t)ste->word[1] << 32;
+    uint64_t ste_1 = (uint64_t)ste->word[2] | (uint64_t)ste->word[3] << 32;
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    SMMUv3AccelState *accel = accel_dev->s_accel;
+    struct iommu_hwpt_arm_smmuv3 nested_data = {
+        .ste = {
+            cpu_to_le64(ste_0 & STE0_MASK),
+            cpu_to_le64(ste_1 & STE1_MASK),
+        },
+    };
+    uint32_t hwpt_id = 0, flags = 0;
+    SMMUS1Hwpt *s1_hwpt;
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    accel->viommu.viommu_id, flags,
+                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(nested_data), &nested_data,
+                                    &hwpt_id, errp)) {
+            return NULL;
+    }
+
+    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
+    s1_hwpt->hwpt_id = hwpt_id;
+    trace_smmuv3_accel_translate_ste(accel_dev->vdev->virt_id, hwpt_id,
+                                     nested_data.ste[1], nested_data.ste[0]);
+    return s1_hwpt;
+}
+
+bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                              Error **errp)
+{
+    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
+                           .inval_ste_allowed = true};
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    HostIOMMUDeviceIOMMUFD *idev;
+    uint32_t config, hwpt_id = 0;
+    SMMUS1Hwpt *s1_hwpt = NULL;
+    const char *type;
+    STE ste;
+
+    if (!accel) {
+        return true;
+    }
+
+    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    if (!accel_dev->s_accel) {
+        return true;
+    }
+
+    idev = accel_dev->idev;
+    if (!smmuv3_accel_alloc_vdev(accel_dev, sid, errp)) {
+        return false;
+    }
+
+    if (smmu_find_ste(sdev->smmu, sid, &ste, &event)) {
+        /* No STE found, nothing to install */
+        return true;
+    }
+
+    /*
+     * Install the STE based on SMMU enabled/config:
+     * - attach a pre-allocated HWPT for abort/bypass
+     * - or a new HWPT for translate STE
+     *
+     * Note: The vdev remains associated with accel_dev even if HWPT
+     * attach/alloc fails, since the Guest-Host SID mapping stays
+     * valid as long as the device is behind the accelerated SMMUv3.
+     */
+    if (!smmu_enabled(s)) {
+        hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
+    } else {
+        config = STE_CONFIG(&ste);
+
+        if (!STE_VALID(&ste) || STE_CFG_ABORT(config)) {
+            hwpt_id = accel->abort_hwpt_id;
+        } else if (STE_CFG_BYPASS(config)) {
+            hwpt_id = accel->bypass_hwpt_id;
+        } else if (STE_CFG_S1_TRANSLATE(config)) {
+            s1_hwpt = smmuv3_accel_dev_alloc_translate(accel_dev, &ste, errp);
+            if (!s1_hwpt) {
+                return false;
+            }
+            hwpt_id = s1_hwpt->hwpt_id;
+       }
+    }
+
+    if (!hwpt_id) {
+        error_setg(errp, "Invalid STE config for sid 0x%x",
+                   smmu_get_sid(&accel_dev->sdev));
+        return false;
+    }
+
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+        if (s1_hwpt) {
+            iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
+            g_free(s1_hwpt);
+        }
+        return false;
+    }
+
+    /* Free the previous s1_hwpt */
+    if (accel_dev->s1_hwpt) {
+        iommufd_backend_free_id(idev->iommufd, accel_dev->s1_hwpt->hwpt_id);
+        g_free(accel_dev->s1_hwpt);
+    }
+
+    accel_dev->s1_hwpt = s1_hwpt;
+    if (hwpt_id == accel->abort_hwpt_id) {
+        type = "abort";
+    } else if (hwpt_id == accel->bypass_hwpt_id) {
+        type = "bypass";
+    } else {
+        type = "translate";
+    }
+
+    trace_smmuv3_accel_install_ste(sid, type, hwpt_id);
+    return true;
+}
+
+bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                    Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    Error *local_err = NULL;
+    bool all_ok = true;
+
+    if (!accel) {
+        return true;
+    }
+
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        uint32_t sid = smmu_get_sid(&accel_dev->sdev);
+
+        if (sid >= range->start && sid <= range->end) {
+            if (!smmuv3_accel_install_ste(s, &accel_dev->sdev,
+                                          sid, &local_err)) {
+                error_append_hint(&local_err, "Device 0x%x: Failed to install "
+                                  "STE\n", sid);
+                error_report_err(local_err);
+                local_err = NULL;
+                all_ok = false;
+            }
+        }
+    }
+
+    if (!all_ok) {
+        error_setg(errp, "Failed to install all STEs properly");
+    }
+    return all_ok;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -161,6 +343,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     HostIOMMUDeviceIOMMUFD *idev;
     SMMUv3AccelDevice *accel_dev;
     SMMUv3AccelState *accel;
+    IOMMUFDVdev *vdev;
     SMMUDevice *sdev;
 
     if (!sbus) {
@@ -181,6 +364,20 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
                      "0x%x", idev->devid);
     }
 
+    if (accel_dev->s1_hwpt) {
+        iommufd_backend_free_id(accel_dev->idev->iommufd,
+                                accel_dev->s1_hwpt->hwpt_id);
+        g_free(accel_dev->s1_hwpt);
+        accel_dev->s1_hwpt = NULL;
+    }
+
+    vdev = accel_dev->vdev;
+    if (vdev) {
+        iommufd_backend_free_id(accel->viommu.iommufd, vdev->vdevice_id);
+        g_free(vdev);
+        accel_dev->vdev = NULL;
+    }
+
     accel_dev->idev = NULL;
     accel_dev->s_accel = NULL;
     QLIST_REMOVE(accel_dev, next);
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index c72605caab..ae896cfa8b 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -25,19 +25,41 @@ typedef struct SMMUv3AccelState {
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
 } SMMUv3AccelState;
 
+typedef struct SMMUS1Hwpt {
+    uint32_t hwpt_id;
+} SMMUS1Hwpt;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice sdev;
     HostIOMMUDeviceIOMMUFD *idev;
+    SMMUS1Hwpt *s1_hwpt;
+    IOMMUFDVdev *vdev;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
     SMMUv3AccelState *s_accel;
 } SMMUv3AccelDevice;
 
 #ifdef CONFIG_ARM_SMMUV3_ACCEL
 void smmuv3_accel_init(SMMUv3State *s);
+bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                              Error **errp);
+bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                    Error **errp);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
 }
+static inline bool
+smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                         Error **errp)
+{
+    return true;
+}
+static inline bool
+smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                               Error **errp)
+{
+    return true;
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 81212a58f1..a76e4e2484 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -547,6 +547,8 @@ typedef struct CD {
     uint32_t word[16];
 } CD;
 
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
+
 /* STE fields */
 
 #define STE_VALID(x)   extract32((x)->word[0], 0, 1)
@@ -556,6 +558,7 @@ typedef struct CD {
 #define STE_CFG_S2_ENABLED(config) (config & 0x2)
 #define STE_CFG_ABORT(config)      (!(config & 0x4))
 #define STE_CFG_BYPASS(config)     (config == 0x4)
+#define STE_CFG_S1_TRANSLATE(config)  (config == 0x5)
 
 #define STE_S1FMT(x)       extract32((x)->word[0], 4 , 2)
 #define STE_S1CDMAX(x)     extract32((x)->word[1], 27, 5)
@@ -586,6 +589,23 @@ typedef struct CD {
 #define SMMU_STE_VALID      (1ULL << 0)
 #define SMMU_STE_CFG_BYPASS (1ULL << 3)
 
+#define STE0_V       MAKE_64BIT_MASK(0, 1)
+#define STE0_CONFIG  MAKE_64BIT_MASK(1, 3)
+#define STE0_S1FMT   MAKE_64BIT_MASK(4, 2)
+#define STE0_CTXPTR  MAKE_64BIT_MASK(6, 50)
+#define STE0_S1CDMAX MAKE_64BIT_MASK(59, 5)
+#define STE0_MASK    (STE0_S1CDMAX | STE0_CTXPTR | STE0_S1FMT | STE0_CONFIG | \
+                      STE0_V)
+
+#define STE1_S1DSS    MAKE_64BIT_MASK(0, 2)
+#define STE1_S1CIR    MAKE_64BIT_MASK(2, 2)
+#define STE1_S1COR    MAKE_64BIT_MASK(4, 2)
+#define STE1_S1CSH    MAKE_64BIT_MASK(6, 2)
+#define STE1_S1STALLD MAKE_64BIT_MASK(27, 1)
+#define STE1_EATS     MAKE_64BIT_MASK(28, 2)
+#define STE1_MASK     (STE1_EATS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
+                       STE1_S1CIR | STE1_S1DSS)
+
 static inline int oas2bits(int oas_field)
 {
     switch (oas_field) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 374ae08baa..bfb41b8866 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -630,8 +630,7 @@ bad_ste:
  * Supports linear and 2-level stream table
  * Return 0 on success, -EINVAL otherwise
  */
-static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
-                         SMMUEventInfo *event)
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
 {
     dma_addr_t addr, strtab_base;
     uint32_t log2size;
@@ -1341,6 +1340,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             }
 
             trace_smmuv3_cmdq_cfgi_ste(sid);
+            if (!smmuv3_accel_install_ste(s, sdev, sid, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             smmuv3_flush_config(sdev);
 
             break;
@@ -1361,6 +1364,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             sid_range.end = sid_range.start + mask;
 
             trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
+            if (!smmuv3_accel_install_ste_range(s, &sid_range, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             smmu_configs_inv_sid_range(bs, sid_range);
             break;
         }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 2aaa0c40c7..8135c0c734 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -69,6 +69,8 @@ smmu_reset_exit(void) ""
 #smmuv3-accel.c
 smmuv3_accel_set_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
 smmuv3_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
+smmuv3_accel_translate_ste(uint32_t vsid, uint32_t hwpt_id, uint64_t ste_1, uint64_t ste_0) "vSID=0x%x hwpt_id=0x%x ste=%"PRIx64":%"PRIx64
+smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vSID=0x%x ste type=%s hwpt_id=0x%x"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


