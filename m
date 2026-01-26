Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0600CF65DC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKBE-0002rI-LQ; Mon, 26 Jan 2026 05:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKAf-0001zA-Vn; Mon, 26 Jan 2026 05:50:15 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKAe-00068W-7e; Mon, 26 Jan 2026 05:50:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dxkf1OuBCVMw9UWJeJjoXqVTUCozHIj16dGoC+C4+mg6pr6JLMaC0wX7PxyI/yjZ7Z8USt/kfDdOOrvEnQ5u6A1FiUxh7htChtGcdRmnd/3WOCAed9f2Y6Pmjwt+VlaSKaoVNoQX14oF45UR0TM5SEWxggE5/BnyWD/+zzQ8GIduw5KSDOsWYwzH3AVgxQnSkJC1LOyIWym5BlIMMHb1dyLJa8hBVsZJgX91XNayzR7TmxJma4sXGVT/AxIBwMlEz/Ls6bgH/PJC/E46uPfsGQyAIxDLBB43KEVxdygyWZpOo8r32K54f1o3PZ/kEDJR8Ek/YzoRM7tbpOFfZ2qLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5BU+DOUQmpX64C1uCWW7bOgE7Mi6tAx5KeioyOARu8=;
 b=wUWYb+YZf56eR82SMrHsvhyEWRH0PrR3y9vsU61KbR3zO8E208PSgkn852snYZaHC5MLLrTNlt2pkPpISBfnTVDPw3dPnlRi5vQ9ssFrN39kketD71hrYUoAE9tNPGt77w2HBsMiw52RfUdab0BA5r4PTn+58UXAwIFyvuQSN8cGXjnf72MMbuBWLEG6lqErp0beKYnWV68GXp2qXuIHvPbbJZGfWm4ogf2gkVbbf5SIenI9A/Kg4YqU0BmmXMI10Egx+DbNg5KjrzMiAaawq52dloT2VPx3E3y1ptAp9mztl1/q4yua7iUHbMxgU3+iZI7GuCbX26EkWVnYUUSkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5BU+DOUQmpX64C1uCWW7bOgE7Mi6tAx5KeioyOARu8=;
 b=FWulHf3cZSbYkGEb1cPhSPTRgT60IRTjqN9vpfd4AylSjMkc1YN47pXLjPu5kz2RoC5E0g6UtxO+vHbmm4ZE93FY1LOJ1MJDzN7D1SyjsvesLojUHAUDQoRDpiOUrlaf9E5nkdhnAEJGprJdswqoc+fOUDs0T4Co4M4JJ4kGE3e3xWAXGjmtxeBFPOgDwh1QeToNZ3xzbNffqGi/VJsvhsvoGFVC0PGLsbqdcANeG6tSLrDk5AFAQgAyt8/wbNfF7XdeT+r/JVq1dvy6dAcHtGfGaFxleKsbTiOgqoAOkF2Hmia1nvDE38MGprSptk/CbdjJSDQ24zk037+e+0pn0A==
Received: from PH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::14)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:50:05 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::30) by PH5P220CA0009.outlook.office365.com
 (2603:10b6:510:34a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:50:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:49:47 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:49:43 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 32/37] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
Date: Mon, 26 Jan 2026 10:43:29 +0000
Message-ID: <20260126104342.253965-33-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: c457e538-7405-4344-ded6-08de5cc8aa2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3h4TEUvd1c4cjE3SENkd1dSRlRPaVdtd3BMVnp3MkRxUGFhcjh5cUpXZXI0?=
 =?utf-8?B?Q1Rxa3pNZDdMSHk4NGpHOWt6UkhHajYxVFIrQVZKMUh5US9QVHpiS0d4d2tN?=
 =?utf-8?B?UTlVZm10TWs3My9zeVNaN1AvbFBoeUNSUnk4WXMrU3FEd3g5THk4bUR4VkhX?=
 =?utf-8?B?ZkhKSGZQS3h4Zi9DenowN1l6T2ZocVVsYUZBcmx5T1pHWm8yZkZZTVUxbTVB?=
 =?utf-8?B?Skx5TGp1UExqMkRBOFVGVUZMSERPRnBvRjZFL0IwcjlPMWg4YkFMU3phaEtX?=
 =?utf-8?B?MEdZNUhPbXM0ZFFvTGxrb0JhTlVKbW90RHM0TnE5Vm11MUZUVXU5WWg0VGVG?=
 =?utf-8?B?ZGRKZnBBNElHVVFjZ0s5enViV0hMazZvR3hmbGt5UnA1UHVMU3dNb2tXWDNx?=
 =?utf-8?B?alBBNVVSQ3lSV1RPRDh6SEtyOFpaNGVMTHZDYTRmOUhQOGlEeHFkSUxXS2x1?=
 =?utf-8?B?SVZ3SENaSnZkVWJNclhTR0hsYWhDSHo2eGFWUitzR0Y5VzMrbC9yMTM2c21F?=
 =?utf-8?B?bkxWNy9HV3g4bUJsM0NMRjZjTTF4UTRjQVVKY0FzVGRBL1E5VFAzeCtHb2hB?=
 =?utf-8?B?OTd5dkRqcDE0VGx0OXlGNjFUcGw1WFlVWEZha245ZU1HcUo0OVdJWWcvRUhN?=
 =?utf-8?B?dnlMak9vS0N5Q3A0R24vYkRpNW94VzRzQmU5Y3RZQU10SGxqVGFWSnZIeTEv?=
 =?utf-8?B?YktOOVJ6U2U0ZDhhNVRudGVwZ2xWVDQ5dEd4cHJ6cGFLbit1SWxPZndKSWVK?=
 =?utf-8?B?RTJFc1Q1Q2xCemx3d3NERml6WldUZ2wwd05pZ0U0akpWZ2ZkSUxDczdNWGpS?=
 =?utf-8?B?RnhFV2NXdjIxa1RuS01UMU9rL2tmZHZFZkdYcXZqSWlFR0FYVXdGVHpEYjh2?=
 =?utf-8?B?MWh3ZWNTd0gvRGNKQnhBRGJOd2RuUzRqbHNzM0NSRGJlOUVKK1gzNVNWWUEw?=
 =?utf-8?B?anZUNG9LK2lZY01CS1lZYmgwd2ZOeEh1OTNTY2NmVGRNbE9OMHlUc2ZLY1pq?=
 =?utf-8?B?bUNTTkxXYkwzZ2ZDOFJRQVloNXRuY2pVbTlhZlY0OGFBU29QTjM1ZXRyR1dy?=
 =?utf-8?B?T205cEc4M0N1czhuNHYzODZFa212ZTdiUU16cjlpTi9YR3g4enJ4ZHd5a3Bo?=
 =?utf-8?B?dzk3QjN6NFpSWk0rcnczZXVZWTFRZGJhdVZmSkpTa295RXpna1p3bjRTTitD?=
 =?utf-8?B?bHQ1RElFQnFhUzNBb2ROTjNaLzhhSnRQVWhqZzJEZTFMcFlMSnZpL0FuWFdE?=
 =?utf-8?B?S21GSmhWaFFWZGJBUDAvZk5lVEh3QnB2dzlES1pnWFZBN08xM0hMMGNvUklu?=
 =?utf-8?B?dFJMWGhZQ0pRWTdpRVdCdlJJcTJjTUR6YUM3cEJYN0xSOUhhQ2hFZDR0TVZ3?=
 =?utf-8?B?aHhSeVV3aDI0TDJQQnpWUGo4MG81MjJRemF0L016dG5IaFBNVzl1L2ZkKzBo?=
 =?utf-8?B?ZDFUazFOblZzMkk3bjBWcHRaeFI3dGh2R2w3cFVxOTMxUlZUTDFpNXIwSktp?=
 =?utf-8?B?NFhIbnlTTXRqdE5qYWtwKzB1ajVoSmtOdW9kVGlnVnpmWm5MbkV6U1Fkc0NE?=
 =?utf-8?B?d2k0L2FuRGVQV0Q3M3ZUV0FLQmVxNGZtRXFRcTRja0tJcFRJUFRaNHhQV01K?=
 =?utf-8?B?anFES1ZXUmpxd0poVGRIMVg0dVZoZkpxcGYyWWQ4cFNiVTlVaXBIcUE4Z2xh?=
 =?utf-8?B?VyttRGwxQkdlUnM1TDhXckJKUS9yVUJERmplK3dDUEpwdStvSUFuRndMSjJa?=
 =?utf-8?B?S3d4UmdGa3Q0amRKNTM5T291RWNtOE1OYnJUeitCNmVteDdvakxLQnl0eHhv?=
 =?utf-8?B?K2VhZER0ckJRbTF6a3N3R29QbTZ4SHQ5a1lSRGpESHY0V1l5LzU0TENGZzhh?=
 =?utf-8?B?dVdEWTdPRFhDbHp6SnV1S2JjbFhmell0R0orZS92SmN5eGhrMytHcjZTQXc0?=
 =?utf-8?B?Y1k2NGpCb0k2WlR1dUJoRDNYRjhWQi9nMVZFcWIrUnpqRllYUTBwUXRKLzQ2?=
 =?utf-8?B?OVlrcnFLT2R1S2hsVm5VVGYyNi9YOElXK0twRXIrVnNMQi9iQmYwbG5hdlJT?=
 =?utf-8?B?M216UjRrWU5BRGFUd05hV2hhbHM3ZmNXSWRQeDNrWGo3dktOWjNUTnlpbnAy?=
 =?utf-8?B?bDZ0QkZscnVCbnBSck01Sll4S29tcEZSL2pRZ0JMM3oyeTRCUjdnaFVGMjF6?=
 =?utf-8?B?dDJwclUwOVpJSWVpZityZjllTkN2MXU5T280YmJsUzdneU0rNlJSbG56cGxW?=
 =?utf-8?B?ZFkyaXh1NDRLbnQyWnFkeHNTWjd3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:50:04.9955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c457e538-7405-4344-ded6-08de5cc8aa2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
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


