Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD20D25036
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1ai-0003ph-VH; Sun, 11 Jan 2026 14:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1aJ-0002sJ-Gw; Sun, 11 Jan 2026 14:58:49 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1aH-0004Da-Vt; Sun, 11 Jan 2026 14:58:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncaaRUsEg+l+yKVPBiXhv83XbGmd51i0m0KhXaUDhBThNxYnoMJ+OQVQ0Ba7lyu1jRaUacJneUZuKmG4WgyTNHSkjxsgio9p79u5vFvmoJ9z9kmOh/iSeoA94w+S4byONzJAF55nY4In0yjcL6G5S2qZMJWjGfhn6f6hoQZQWXLWS0ZwY8OJp+JkwMf7iRXXS+PqPOjsGv+BbBc22XZ9931PczjoAZh7C+9qXHC0k0mwH13dgfQ8MOfaSTDBwNiSZh8mjhs16SYv1RlQ/ZKajboYQ9mTfgJrQ6HJ0anBK3+YL88rzFjgNY9FW2BoAZg8Bb+7joZ85kjn9EPmQrD0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/sJPdcQougj4e7b0DlFplHhPUA99kYsmzIthvtICeY=;
 b=Ef6Sqktz79dFbHzoiuFOwl4kf54TDvk8/CLdEYVcY9+4shxnvPrIpsTNo+5Of4SzeJNQ1EXtkRYNsPxEVx/Hx+lSYYU0b4wGdprGJV/cAvwcp2n9NZqFpde8MFW55SHJwcxyju8FQxw4wMV1OY82dXRd9EEgQZ5ayt7B+RCH/jlrEY019mvkSS96K1evKIQhGWvXFpAiaCETuOopzpiOMLQeZv/tgnrkD/eFTjwcD4faWiippzP+YuvzFFpBe+PZTN8DrKr75iP9iyz4cX6JbCBtk1S1N6GPicKGwNCan1gm0lsuWPOfq8g41qYDBqP84rMCH4QlTMmq1MAC1zdx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/sJPdcQougj4e7b0DlFplHhPUA99kYsmzIthvtICeY=;
 b=ANfKpYxRqOlfLFUmepaOE8exoS18ZhfOdZvxU/cnVZxt8uhY7IrBzB+Mf/GIte58aCVkkxlKkzGRzH5E93AjtZq8wIK68LBD/iOAOQA6yrUhBeRIzl2g9uNKhIOQuMieid6lGzo0inbtPFGCb5fw0t2CSU8tvn04CmKL/KSFJjtiLeTNiUCQdhmNe2D7wRSIE/nHfsBRlqRPOztoGQI/HyNPuWUtY97/HuteVelPdakwfC/6ZkGrq8X9KnfhsyF4YIBx7e5Vt973GsIHsc/HLHRueIcOgNtV4K5Lwf7mKS6F0Ddm5lXQdy+AS9C7tv6B5z9S+ojSznJSbW1NtJ/tgA==
Received: from SA9PR13CA0140.namprd13.prod.outlook.com (2603:10b6:806:27::25)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:58:39 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::69) by SA9PR13CA0140.outlook.office365.com
 (2603:10b6:806:27::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1 via Frontend Transport; Sun,
 11 Jan 2026 19:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:58:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:31 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:26 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 31/36] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
Date: Sun, 11 Jan 2026 19:53:17 +0000
Message-ID: <20260111195508.106943-32-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c16772-3849-414e-1fb8-08de514bd090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVdNK1BQdXNiK01kVzlYZ3NqNjAzN0E1cEhYRXFabjZ5RWk2TkNoOXJVcCtS?=
 =?utf-8?B?T0lxOVBHZVdJeTVXMm1wUTBNdE5VLzdNSGdNYnpjUWRRV1RlWFNIK2psNjBN?=
 =?utf-8?B?Qm1kQ3N4WDQvWUhMZFB5NHBpbUNiL09HN1hObFpnb0hYOXdrTkJEWTl0bHJK?=
 =?utf-8?B?RjRnemtjTEhOOTc1MEJEaE9XaFlRTVFmMFVhYW5xVWdrOCsrMjI1UCtmZ0J4?=
 =?utf-8?B?ektZV2QwV3lhNGY5R3dHQTYxSGtWWlVLYzhPSi9veWNSd1M1clA5Z3BTQVI5?=
 =?utf-8?B?VEFlNExLL0I3ZFJFL20wWjROM2kra0JYWTBjMmRncVJ2WjRkcTl4Mllkc3pp?=
 =?utf-8?B?Q0ZUU2d3eHJMUTlHeXZqM2RiQklYc2hTVUpvMTNRVzZTZjBVQW92Q0dxbHIr?=
 =?utf-8?B?UnZ2NEZRM2d5UG5HMnBQM29IV3JjVXNKTHhIQkxXMkdxTVJYaThMellhUTRx?=
 =?utf-8?B?eHVsMlhyNnBqRjdWb3RGYlE3YmM0WU5aMFp4T0Fhd1N2Y25pZHhzaHhCUDRv?=
 =?utf-8?B?YjVWNVVpMjA5UFpOMGZ3YmgyZEQvRkVFMVpQbDg0L1ZSYmplYjYwc2lESGNB?=
 =?utf-8?B?b3lHOVN5WlBqQkVrWDNCY1NpNFU5ODd4SjhPdGllWUFMS3g4aU1neFhsUGFO?=
 =?utf-8?B?VVd5ckFFSkxFUnkwcGhQVWRhSjE2aCtpenFzV2xlRHFwWGRZYk1rVjBDSGhD?=
 =?utf-8?B?TnNTOUV1REJ2bllZWEZnTUg3eHcxYVhZRXE0dUkvT1JTRXJGcTBoK3RuYWZH?=
 =?utf-8?B?UkFMd1haRUVrNHRuVkJwN0o2elpiUWl2aFdQRjdJd2hCTVREdWhOWDc1Zmov?=
 =?utf-8?B?Ylk4bzFLb1gweEdIdTAwUlJLblYzS3BTMllPN1YrQ0tLYU5mTU5vMm9GK2N4?=
 =?utf-8?B?eXYrTmVDZnVVUzVvZFdEcCsvRDlrZWRXTXFuZW0xaVRlV2hOc2t4aHRqRjFx?=
 =?utf-8?B?R050QW8rMGxGRTdYVmZnWjRTY3piZnM4aUlqcVhnVGRjNEkyM2Z6WXdLTzdM?=
 =?utf-8?B?bUhydzZvYWlWdXZ6TlRYR0VqS2FpWUZEdTdaVWdlaDhja3J5ZlhQTkJwcHZC?=
 =?utf-8?B?Q1V4ZzRFZkFtaENaV1FoVWgvKzRCNFk4UDdTS3lxRXBlRXZhS2F1RFBpeUhI?=
 =?utf-8?B?dmNjdXc4NnZ2eVVGUnBLRllVS3Bhby9BV3dEdmlkcWc1djBnWkFIMzRQV2Ix?=
 =?utf-8?B?NnlDc1ltc3JnZ0tINUdLb29JMXY2V3FUNkFSdjJMQThXK3FlSm9Fekp5QXBX?=
 =?utf-8?B?TU84WWszaWF4c0FGUzNxNCtqcHRwQVBsd0MzbXladEtUNEdRRHY2Z0EvWktW?=
 =?utf-8?B?WE9wU3I4WTkyS0FoNFFJSENqb1p5QzlBOGJHZ3NHR2xlMXhmWmh0azdQR2xh?=
 =?utf-8?B?dG96ZWhDaVFHYzRGZFdQMEFTZUYvVWdQZUk2YnFDKzZHOXBGMHhVTTUyVmwz?=
 =?utf-8?B?ZDVwN1JVRnVOVGVzODIzcjU2eEIzL1RyYjhTNTVySHN1WTFrL01RUXA5L25U?=
 =?utf-8?B?V2RlemIwckpwVlI4WXNHWSttZDBKaWQwRm9ld2pSUU9pRFlLSVNBSDZjZEtx?=
 =?utf-8?B?WndxeWFTemVIZjBOMDhQdXluNG5aamNRaG9UUHFLSlNtT0ZTSjg1b3BlT2Z3?=
 =?utf-8?B?U3hXTDU1cXpVaFp0NlF5MDJYcmtMTlQ1YWo3Z0JkeEdKWFFFcUEzKzc0MDNT?=
 =?utf-8?B?aFlJVmxQWk10b2pwOTE1OVFVOER2SGd2WkFYdW5FNTRndmJMRHJ4QitJRWli?=
 =?utf-8?B?QllkWi9nVWZON1U1WDQrRVFMTVBaM3RFODB3aGpMOFN6T2J2RmNyNUFZejhC?=
 =?utf-8?B?S3JSWFFESTBYZ1pnbUx2T3QzSmpWRXIyRFROUVhHdDVsbkRoMTd4Z0E2Wmc1?=
 =?utf-8?B?dGtDc3FGN1hnY0xiWXo0eDJzczdBVGd6dUtvaHZrcDhiMkwzS3BORTZIeDN1?=
 =?utf-8?B?azMzTTQyYkoyMTVEeDgyNHVsMXI2Q0hzZmhKSGthMUJXU1BiT1lTZ295WEIz?=
 =?utf-8?B?K3Z4UXN4T2JQc3c4Q1BFaUk1eVBQMy83bTNWMFk3d0ZneUkwRUxZaWJxMVZl?=
 =?utf-8?B?T0YzdWVqU0o0WEcrRXlTei9SSW0yRFpqbnFLakkxelZsTkRrNFU5MElyMDBU?=
 =?utf-8?Q?YMfc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:58:39.5151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c16772-3849-414e-1fb8-08de514bd090
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c                 | 6 +++++-
 hw/arm/smmuv3-accel.c              | 3 ++-
 hw/vfio/iommufd.c                  | 7 +++++--
 include/system/host_iommu_device.h | 3 +++
 include/system/iommufd.h           | 3 ++-
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index e68a2c934f..6381f9664b 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -388,7 +388,8 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
 
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
-                                     uint64_t *caps, Error **errp)
+                                     uint64_t *caps, uint8_t *max_pasid_log2,
+                                     Error **errp)
 {
     struct iommu_hw_info info = {
         .size = sizeof(info),
@@ -407,6 +408,9 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
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
index e5328c63a3..0b7dd1cf58 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -353,7 +353,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * instead.
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
-                                         &type, NULL, 0, &hw_caps, errp)) {
+                                         &type, NULL, 0, &hw_caps, NULL,
+                                         errp)) {
         return false;
     }
 
@@ -889,19 +890,21 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
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
index 67c42f78a3..b4ef50afbd 100644
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


