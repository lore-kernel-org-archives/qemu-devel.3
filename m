Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3761C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRv-0001y7-BM; Wed, 21 Jan 2026 12:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRn-00018l-Gy; Wed, 21 Jan 2026 12:56:52 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRl-0001T9-96; Wed, 21 Jan 2026 12:56:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tInt+H9wkaV5gR9hR8r+ZsVprMSjQWCQXYbKfRrrFV/K7ZbMhDK3BM3uGlZrcxNpgqYB3ei7lpZZf1OcHnJ9nqkqOY2qw/RrLGildbIVPSSTe93ZEAZbRKjS3v/TcEPcViwriOcLzJ4LarT+qbkuF+rBTPgZPXMovM3kX8LUAxXM8fa42x+0hrBQqN37PmDipFO1z9/L9es39lQtkf6Y8v/5600ah0r9hB//LTGzCEryGaWVKJQtkgpFYBurfSovGYLHs2XXDQBQnBui0U/avhP/N3Ct/YaQg3lNGHk6FTEFPwHV+BJr3puR0gPunqZei+DwOeS9AiN4eq+pxOpOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhsEHnKE4qYLS5Uz/f9Ukllw3Gi8G60LhBInlsybxbs=;
 b=IdTHLn8k/ngJ/Rmj3QbOsYSAfuwuxoJwPcX9gmWm0acX+VlhJ0ouQHfpjwmyDNU67LP9CJLZnIkNTBBELgn4sSbIxpnSH8lblnbcw+kMYSmp5yopkkJfXHdDzD4P5GukFjPpUAUKVNhwG9hZyASMRQBjiuiEmdZeC2jjFNpThIjkHJbsXC5lXlqW6mHMeekzGVrqO+zgD4aXg59YeacIncdMSiXaxQvrw8L+AvtMJ66P4pFbBppmKlmPGt77QOUD1vzRVUXjTIqtMVVWv8RL5bKFggl591K5InWE0BIZDiAFcA57esNeO+QLbZ2wsVOoJNTj2DHCFAMWFWnfnhzqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhsEHnKE4qYLS5Uz/f9Ukllw3Gi8G60LhBInlsybxbs=;
 b=VT65wcbu5taf+Q9hYe1jKxHZkhrWjN+gjq5BdCZ0nMAan3La3kttmqBrxxxVmGMVb/hjWwhxh9qRuapJNYoRZ+z9LQberIz24g1MnG4UX2CLFFAFifpmNOeT4tL/MkeDxz2esG0eUJQsrbI3xgu9fFeYATogG6QwCiJka3J+IIDB0T8YLw8vUkUriQr0EcgYfDeTooczB30nrIHwAtGUylTUnW7z7Kas16+M4mo3HMj2h/LUBuzZQpOu7Igwxtt8vkaIHM2eWOV3T3eZOl7xJYpsEMoh5C7e5pw27bmKiKwhmjSHkiTbvDtW2AgqFoZJkdQMK+I33SjCrBg2B6595w==
Received: from BN1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:408:e2::11)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:56:37 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::e) by BN1PR13CA0006.outlook.office365.com
 (2603:10b6:408:e2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 17:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:11 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:06 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 14/37] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Date: Wed, 21 Jan 2026 17:52:19 +0000
Message-ID: <20260121175248.87649-15-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7b93ee-cecc-4d01-2ef2-08de59166bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2d2ZE85MTVCbS93Ukc2MnoyRWNYdVpiTmpxMXcxd1hHbHFIejZvZ1dDemJw?=
 =?utf-8?B?UEM4VU8wS0l2SnRjY3F5TmJYYkVWUkwrNzJFUTZEN0c0OC9XQjNNUy9vNXZD?=
 =?utf-8?B?TnpnM1BwMC85SVkrMkN1V3lmRmFOeG1IZk1sWnZIUUd5NEV1OXYzMjY5VzBo?=
 =?utf-8?B?K0ZDN0RHb0VFSENqSm5kUE8zbmEvRDRPU0hQbGdGa0E0YXIvOXZaNFk0ZmlL?=
 =?utf-8?B?RHNha0lXQlZmQURiZDU0ek9uUjVIZ3FlR2pBR0ZXREd4ajY5Y3FySVVueVhn?=
 =?utf-8?B?Ti9TK2E2Z0NOZEhXZVZrRFNob2E4NHh1Vk5VMWxyLzIyazVsOFJUaXpNRS9V?=
 =?utf-8?B?Y2Q5RWJXTmlpS2ovTEVhbS9PVVdZT2J5TVNONlpVMHIvOEZZNzN4OXpaaVdw?=
 =?utf-8?B?d0tESXBkTnFJTlA0Qkp0bENSRGhWVjZRbjZ6RkZGVEkzNEtRSWNVRHprbzFv?=
 =?utf-8?B?ZUFQVUd5WXI1Y1krVzVONXZPb0VRSDNHd1B1S01GZzcwbHQrZUdTZElsR212?=
 =?utf-8?B?c09lendlc2RBc1JIU3V1RnppS2RZNGZ4eXcwb1ovOUMxSmNyd1BwSjJ1TnZO?=
 =?utf-8?B?Q2cwdkZuMCsydmd4UVp2VUtycTRUOHg0SnJtYkxMRi85c2RIelQrRzU3cG0x?=
 =?utf-8?B?NFhqNW10TFMydDliV0NSUjRvcklvRmlQY3kzT2pWZ3c4dm42NzRORTNiTkFr?=
 =?utf-8?B?UkovUDJwcCtLdFBNMEFFU2NEcUtZd1FVSERjSHFjdHJvdHY1aFU2dklFWkl5?=
 =?utf-8?B?b1BtOUQ0VDdTcVJQOUxoZFdaNmd3YXpzeTM3MTNhenRkTzR2QUVZZFlkUVV0?=
 =?utf-8?B?SHlNOTQzbmNiYmtSRmRkUmY3OGVuRnNMdzlVSlZlV2l0czN6NkhNTzdqdmtG?=
 =?utf-8?B?ekhyU1Y4N3lNU014dkJXM3pGc3hqQlFLemdYTFNnaHZxdHdzeEFBVUdDdER4?=
 =?utf-8?B?djlxajc3T1VEZTlkNG1NUjlFamV6K2V6eXZKdFpTV1pUOHZCR0dGOFA3SFpr?=
 =?utf-8?B?bDkxV2t3dnIxZVdpcnh0VjBFaEFlM3RjTjB2eUNEb0pqRDRPenJrdDcxOXIy?=
 =?utf-8?B?SFd3dmxSVzlHc3M1S0Q3dVJGSzFMTmtNVzNuUk9XTys5alJFd25URm8wVjYx?=
 =?utf-8?B?T2F6THJyVjNNUmZ1ZUxvQ0RDNGZ0NzBaUnhvQ3VYWU9CUWI0czVncGdNNS9Z?=
 =?utf-8?B?K1NVZVlrN0o1Zjl3WHp1MVc2Qlgwc0hGU2NvN3p1RW9qYU1qaG91eUtsaEF0?=
 =?utf-8?B?L1JNdTFlSlBCUjBnMzB1WktCWlR4ZklhRWF5eEZqbmorQ00yU2FibEUrU1Vs?=
 =?utf-8?B?dWUzYlNFdGxlanVYY1hBVVB2cEFRdDAwZDZIcmMzaVBORFU3ZC9ScnAwZEcr?=
 =?utf-8?B?RkdGdlZ3VEdaRHdzUHRYb29aZ1ptUHV3Vm9aZU9KUnZUQlZrT3JoT1BSZUNj?=
 =?utf-8?B?WElWVE1kcndDZkFwUUhTU2FXWDN2cmNEZmM2UGtlVUhKWFg5bkpvRjBPWlpu?=
 =?utf-8?B?WDJkZFNGb0lqSU44U3RkMEI0OFI4bUNTd3lyTm1RaDZIQVo5YUN3VWdtR1Zn?=
 =?utf-8?B?Rit3UUZOa1VBSEZIVDZPOGxWNUNCeEFoQ2xFWDN3RjVsQXVwckpPKzVpZjAv?=
 =?utf-8?B?NFEvUFQwVEk2elo1YXlSRllOTkgvTU5saTZQSmJmU29vMk9HdFBES0hZakZs?=
 =?utf-8?B?NWY4dm9kdVFYRG4rSFhqZ0pBellYWjZtNVF1eTdLNDIvUmlxVitQNkJ0cU9h?=
 =?utf-8?B?UmxxYXdVWnltNm0yb1ozY1ExbktNMzErajY1YU16SmxtNTgrM3RuMUlxTFc4?=
 =?utf-8?B?cmRndUI0R044NHB5Y1dkL1FVbXJhWXNYbjg5VGJ0ejNVQ2ViRmpldUt4Qm5x?=
 =?utf-8?B?RC95cnhndlhoUU5pck5xSnVWVEEvdVQrRm5zNElIOWhuSVRjR2lmNmZMbWtD?=
 =?utf-8?B?ZE5JZ3NQeGZiaGZkc1RCNFNOaDZFSGhKY2NrNk40K1FtNnYzU0I4ZzVNSXZy?=
 =?utf-8?B?N205TzJZYjdjbDRtZm1SeGNiWnlLZ0U3OW1NZXBpV2diNUIvVHBPNFNjek9G?=
 =?utf-8?B?QzMwdmpYbll6WTNDTGdyMDB6VHNCMDgvd09WeWJOQk9idmpyY2dLMmJNaFcw?=
 =?utf-8?B?dVpqWGZWL1EyWmR3YU5scVlFdnVwVVpkZU1nV1k1aStRbFNyWEVsaVVpbk80?=
 =?utf-8?B?T0l5R3NEMTFMYS9SUHlycnV2MFQ3RVd3YnJsemVQK1ZscHJmcEFuRDlXL2Z2?=
 =?utf-8?B?cm5iV0lOTlRxMFdzbTRabCtiZ2JBPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:36.4625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7b93ee-cecc-4d01-2ef2-08de59166bce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

A device placed behind a vSMMU instance must have corresponding vSTEs
(bypass, abort, or translate) installed. The bypass and abort proxy nested
HWPTs are pre-allocated.

For translat HWPT, a vDEVICE object is allocated and associated with the
vIOMMU for each guest device. This allows the host kernel to establish a
virtual SID to physical SID mapping, which is required for handling
invalidations and event reporting.

An translate HWPT is allocated based on the guest STE configuration and
attached to the device when the guest issues SMMU_CMD_CFGI_STE or
SMMU_CMD_CFGI_STE_RANGE, provided the STE enables S1 translation.

If the guest STE is invalid or S1 translation is disabled, the device is
attached to one of the pre-allocated ABORT or BYPASS HWPTs instead.

While at it, export smmu_find_ste() for use here.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c          | 197 +++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h          |  22 ++++
 hw/arm/smmuv3-internal.h       |   1 +
 hw/arm/smmuv3.c                |  11 +-
 hw/arm/trace-events            |   2 +
 include/hw/arm/smmuv3-common.h |  18 +++
 6 files changed, 249 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9c2b917a11..877b7e0e17 100644
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
+                                    accel->viommu->viommu_id, sid,
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
+                                    accel->viommu->viommu_id, flags,
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
+    if (!accel || !accel->viommu) {
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
+     * attach/alloc fails, since the Guest–Host SID mapping stays
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
+    if (!accel || !accel->viommu) {
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
+        iommufd_backend_free_id(accel->viommu->iommufd, vdev->vdevice_id);
+        g_free(vdev);
+        accel_dev->vdev = NULL;
+    }
+
     accel_dev->idev = NULL;
     accel_dev->s_accel = NULL;
     QLIST_REMOVE(accel_dev, next);
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index efb631db4f..4e20b646dc 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -27,19 +27,41 @@ typedef struct SMMUv3AccelState {
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
index 687ee6aaca..a6464425ec 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -353,6 +353,7 @@ typedef struct SMMUEventInfo {
     } while (0)
 
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
 
 static inline int oas2bits(int oas_field)
 {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ade2b43ab8..7e29284267 100644
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
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 153310248d..415b7ccde5 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -99,10 +99,28 @@ REG32(STE_7, 28)
 #define STE_CFG_S2_ENABLED(config) (config & 0x2)
 #define STE_CFG_ABORT(config)      (!(config & 0x4))
 #define STE_CFG_BYPASS(config)     (config == 0x4)
+#define STE_CFG_S1_TRANSLATE(config)  (config == 0x5)
 
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
 /* Update STE fields */
 #define STE_SET_VALID(ste, v)                                                 \
     ((ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, VALID, (v)))
-- 
2.43.0


