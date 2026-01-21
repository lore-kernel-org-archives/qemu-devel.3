Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BACC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicUM-0002L2-I9; Wed, 21 Jan 2026 12:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTM-0008Lc-0w; Wed, 21 Jan 2026 12:58:28 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTK-0002Ci-Cg; Wed, 21 Jan 2026 12:58:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPbK4k/DthiCWIQE44HgrafamGjwOdYzELmxc1dLyaxnLaGPMEK3wJ3KL0W8tX3zliAzogOFOW9J7z3GaFg/XPB/F8uIRMsJ2kLRn4Y7sCejGh2NB7oTVOtVZ/O1jwWZE8YeJKtFEyjBwIhUTiKNOMVajO0EkPaTWq179rkU0i61ioPnzyJEBGSGFrlNgQtxPktKYB4O5wa8xsexiupNU3U3izKcZSk381ec1OePSQe/YwR+KstgyLLS6ROkyz5mdX/7B986UB5ChFKedPir8AmLdtIn8Ynv55i9qmMXvzeBiOWl1mWaGHMLfg63YlEPCrbcIO0lWp1SayuVZONuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5BU+DOUQmpX64C1uCWW7bOgE7Mi6tAx5KeioyOARu8=;
 b=b1vKfjcScayoZ3m8xFh4nGo0uN1/D4hgQgE5Sps9WHmk4SehoLsXVXgJWAf3P7CRBzDlsO7iNltNZk2efROshjuD6lj6w63jChTK+L/ykubkLx53Rf1UQcYH6KV0V1Kovcr+5Mny5SQ9Sv/fSKHxWGH+liODtycld20jbBsmziNtXZeNr5JKY6Tjr6RpiiZiIqdQBzcJ3Z/U+iqESsUuF6OX1AH1dyuCgdZEUHH5oNLekhrEElwSDSOgl6XCwRa4Z9u9IDievxcGWxIH1URjWoJZOZoCpCnWcp0l2RlkFMyDk0jCYuZIpkg/kwEFgpZJIHeyVHOW7i5G7Pk8MzWb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5BU+DOUQmpX64C1uCWW7bOgE7Mi6tAx5KeioyOARu8=;
 b=ttcwyo2qUkzBeLkjAv1BTT4ActNfLWVRrfnyyaTADCCfA306I+G62sUb/4EuXxUmK8skorSyIqcLDJR/nlkByYEoSGNTmrmdS/+op52v3nztjy0e8td1VyG43A20F6Cv3HQHMsSUDAI+TLB5rqoy7RmFbTr4Nj7eUlGdp5eprEMvy6++LtubLEDU6zEX15Zd3Yfrc9lxiTO3K/U0/xsxexj9KG1aqmE+TDJGZVdSSWqzkAJhZxzYh7TQOo1wnajbsH5lBudlhHSJIxuaeqKzOzEzRJbg1GeRkdy9sePIfyhXbUljuIt2Jrdr7JMhxmgd3vqur1GuhBQYVLICovTU3A==
Received: from BN9PR03CA0388.namprd03.prod.outlook.com (2603:10b6:408:f7::33)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:58:17 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::77) by BN9PR03CA0388.outlook.office365.com
 (2603:10b6:408:f7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:58:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:54 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:49 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 32/37] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
Date: Wed, 21 Jan 2026 17:52:37 +0000
Message-ID: <20260121175248.87649-33-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b74c6e6-ed72-430b-6b2d-08de5916a7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ciswcDFpOVNLQlIrcVpST3BEYjBaay9FZmozTGJTajF4enN2N3oxQm44NEZx?=
 =?utf-8?B?QWRUdGVHS29MbzcyTXJ5YUpKZm0veEh3dzVVcDZRdUdTNGRvNDlIbk5yRnFw?=
 =?utf-8?B?R21vYWxqaVJrS2FURlhncVBiMW1semovcEZNS3Iwdk1ZSUJiaXR4aU9yZUlY?=
 =?utf-8?B?OEF4bUFvL2tZbnpnM0NTN2o3VTN3VFdrcDBLQ0dGa2l3MStaYjljczYrVFpS?=
 =?utf-8?B?ZXptL29ibitSRjFOTXJhVDY4UDBEUkVRSkozdlBSaWc1aUxNM1o2SzlOL3lQ?=
 =?utf-8?B?QXloS3NiOVpzajQwajFjYXA3K2E0T1JrelJYa2RtMUxPTnlpbGVJVGhvU2pq?=
 =?utf-8?B?eHFuWGtsS1UzWHozTUo3RzRsU3ZZUThteXgxMjVVbnlIT1J4bWt6UkxOQWtE?=
 =?utf-8?B?Wk41cktMTWhVRDJSVjN5TFZ5VjZ0MEVhdmZtQUxubnZ2MkY4a0daT09SdW10?=
 =?utf-8?B?RW9ISXcrMy92U2JpVXlycUI4QXV0SVRSaVJORmM1c1BEcjRCN2NBTWtOOGNp?=
 =?utf-8?B?ejF6akxDYk1DZGd2aUoyK0pUUFFYeDlHNFVvNG1LTGFNbU9RRjNnMCtaZzFl?=
 =?utf-8?B?TnhnUGNzaXZQTDZMTEE4eW9pdDR2NUZTYWo4ZkNneFlRczhqUGFjMkp3SlVO?=
 =?utf-8?B?ZzlyUWM4bmRTdFhJUnJBYStTWlRqeTluZHpjUXBGN1R3YWFxcUw1Rm9rVG42?=
 =?utf-8?B?VVAramRJc0grRUpzS1I5SllNeWNmMTZxWUo4ejRhSmFJeTBxSmliWStpcDNs?=
 =?utf-8?B?TFZlRGI4M0NVemVpdS8yY3N4Q2dHSDFuZ21nMkJCdDZxcDRqWnJzZXUvMmpJ?=
 =?utf-8?B?eEpnbTh4cWM5djFIMzVxN2ZtOVV4SUdpZ1pXdVZpZzZTSEtVbHhESm1tV05y?=
 =?utf-8?B?V1d6eDFmZlkwYTZNOEZHSzZaVzZNdUh6TFpCVGR5V1JQV1RlcHBncE1mTnFJ?=
 =?utf-8?B?S3NPWkc4VW5xQk5NdXNKbXVWTlFEMWRRMTlLV2NtZXBRQWVsbWJBUVlGVHpN?=
 =?utf-8?B?QlJYbDRhdmJXS2JsQ2FlSTNzekZlVmtDbU9VNHgyaHUyMG9aU1UwNWYrUVJh?=
 =?utf-8?B?Y3ZIa3A1cEtWZ3pLSjR1ZWZRSVQ0Q1p0a3JHcUZkaG15OUFNWDJ2ayt1V3ox?=
 =?utf-8?B?cUsxYTJ0aG9yL1Rkby9ENkNZcXRsRktDLzVpQWNkbjBucm03SWlDb0VxVElO?=
 =?utf-8?B?dVdQQWF0bzFwc2Q5eGNnVGVkWWtpTzFtV09mQXYwbXFTYTN5RG5PR3FBdWdo?=
 =?utf-8?B?Nzk1ZjZ4L0JTeDNkUVNzd1c3VCt2YktNaGJKTUtzY0JnM1FuSnVKMFlMKzM2?=
 =?utf-8?B?Nm9waEkra2dPR1QzREd4V3RNQzVqNThURGUzTVdEdXNtWGt0NDBQalZ5Mjho?=
 =?utf-8?B?eWF5Z1JNc1ZCVWg0NUZvWGl4bWVwMXNxUnI4OG9sUzNBcitzUGN2UTRKWGdw?=
 =?utf-8?B?aG9JL0dmYzZ2K1dIenFSdlJmUEkydkVoVjI5cmpVVHlUcjFBY3d1bGN4Smpr?=
 =?utf-8?B?ZXVMVzlmUHpUNG5TQm9tMkVFQ2hPV1l1c0hGWnZrOHFzang3eHV4R0hBT1k5?=
 =?utf-8?B?QXF3NitKdDY5aGk0RWRBZmtxeG1TYUdvOGFHWXJ4dTh1ZGJwQnVKSGVXQjZs?=
 =?utf-8?B?c1B1aDhySXorR3pNcUxnTkd3dnM2TmFnRGZUUGh2WHVTekdHSkpCQktrUkJw?=
 =?utf-8?B?K1pOMFNTR0FGTGIxWXZiTS9sRC8yRlJVZTM1cDgrS3MrWlM1VmoyZ1J6S2Jp?=
 =?utf-8?B?VXA3MFVIaHVDTFBpemN6ZmlPTE1QL0RRS3gxbVFUUEVGaVlndFhWenZLNlB1?=
 =?utf-8?B?dlpSMGdSOGZQalZUNGFTTWl3S1I4dWE3d3pFdVhtYzRLMERkRVRVUERPTE93?=
 =?utf-8?B?a3V2d2hUcXd6Mlg1ZThUNFM4b3JGOEVseEtLTEFzb2cvWHVsNmZoZXVMZ3Ar?=
 =?utf-8?B?VWhjMGk4Q2xSMjZFRE1XVnhCUWFSV3JOYmV3KzVWRGZUdE9PcWZFb20zYjBF?=
 =?utf-8?B?NUtKMlM4YkExZk5OS0x2ckVHbk5PR241aVRiKzRrUFk1NFpMYzN5ekI4WTdG?=
 =?utf-8?B?TlV3dHoxRUFqUXF6TGU3bE5Bd2M3OGVJUzlNa2wzVFIzQWx6OWNHUEZvT3l6?=
 =?utf-8?B?SDdjRHV0TXlXTlZhUnhjVC9KeFIyVEpFZkpRcUxOOXJHd0h0SCtiUXk3eVhU?=
 =?utf-8?B?dXNsRmZjY1dtUk1Cejl6OW1CeVJpL0RlcFFRVERGd2hialV6b1NIMUZIQlNx?=
 =?utf-8?B?Zmcya0h1V1p1WFVMOWVzUUVQdXlnPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:58:17.1981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b74c6e6-ed72-430b-6b2d-08de5916a7df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Retrieve PASID width from iommufd_backend_get_device_info() and store it
in HostIOMMUDeviceCaps for later use.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c                 | 6 +++++-
 hw/arm/smmuv3-accel.c              | 3 ++-
 hw/vfio/iommufd.c                  | 6 ++++--
 include/system/host_iommu_device.h | 3 +++
 include/system/iommufd.h           | 3 ++-
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index e3a3c1480e..9b63d74083 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -389,7 +389,8 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
 
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
-                                     uint64_t *caps, Error **errp)
+                                     uint64_t *caps, uint8_t *max_pasid_log2,
+                                     Error **errp)
 {
     struct iommu_hw_info info = {
         .size = sizeof(info),
@@ -408,6 +409,9 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     g_assert(caps);
     *caps = info.out_capabilities;
 
+    if (max_pasid_log2) {
+        *max_pasid_log2 = info.out_max_pasid_log2;
+    }
     return true;
 }
 
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index ea420afeb7..342944da23 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -121,7 +121,8 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
-                                         &info, sizeof(info), &caps, errp)) {
+                                         &info, sizeof(info), &caps, NULL,
+                                         errp)) {
         return false;
     }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 2947e1b80f..131612eb83 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -398,7 +398,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
                                          &type, &caps, sizeof(caps), &hw_caps,
-                                         errp)) {
+                                         NULL, errp)) {
         return false;
     }
 
@@ -939,19 +939,21 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
     enum iommu_hw_info_type type;
+    uint8_t max_pasid_log2;
     uint64_t hw_caps;
 
     hiod->agent = opaque;
 
     if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type,
                                          vendor_caps, sizeof(*vendor_caps),
-                                         &hw_caps, errp)) {
+                                         &hw_caps, &max_pasid_log2, errp)) {
         return false;
     }
 
     hiod->name = g_strdup(vdev->name);
     caps->type = type;
     caps->hw_caps = hw_caps;
+    caps->max_pasid_log2 = max_pasid_log2;
 
     idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
     idev->iommufd = vdev->iommufd;
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index ab849a4a82..bfb2b60478 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -30,6 +30,8 @@ typedef union VendorCaps {
  * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
  *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
  *
+ * @max_pasid_log2: width of PASIDs supported by host IOMMU device
+ *
  * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
  *               IOMMUFD this represents a user-space buffer filled by kernel
  *               with host IOMMU @type specific hardware information data)
@@ -37,6 +39,7 @@ typedef union VendorCaps {
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint64_t hw_caps;
+    uint8_t max_pasid_log2;
     VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
 #endif
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 567dfb7b1d..80d72469a9 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -71,7 +71,8 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, uint64_t size);
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
-                                     uint64_t *caps, Error **errp);
+                                     uint64_t *caps, uint8_t *max_pasid_log2,
+                                     Error **errp);
 bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t pt_id, uint32_t flags,
                                 uint32_t data_type, uint32_t data_len,
-- 
2.43.0


