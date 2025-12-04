Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4784D1D892
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5Zf-0003Lq-5k; Thu, 04 Dec 2025 04:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vR5Zd-0003Ii-Iw; Thu, 04 Dec 2025 04:24:29 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vR5Zb-0004nE-TS; Thu, 04 Dec 2025 04:24:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1/5EXBS+yA7l0qb90GgMQV0lE9ZQ+vo0I3T83N0qVAN2iFsz1esRBfJKodNzsCksX00p9mLGH24EIJvMPxMSQnpV7fGvzwXeNOj2FY/A6M5BwJNsxfxEgm7NXqIWvQvum1Ewj8bqnEFXk1dggbMVNYntFlhS9VaF5eIaG4PsKjrXLaKgIc0RdkPxb37hQW9RG6EVp8Q4efDqrBaPzbzbwpo3nWnsMzTX5sUzlJ5wdbBbxUJuukFfE16ARKNvEDZ6yyc0doNdrMaNypr2NXCmfeKkhdLclAExhaoj2H2ofgYkXQv05QNSea5A5ifIJFm5sZEIInMQKwdOkaELHsp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8feV5kXDMCnUmeRNWrHEQgm5xQKPjRKxFhE8vQhGeE=;
 b=HCP+CcsLNP1CEs98Uiuc77S3PDWb7/xDQDXOHKiyjW1h7LS1L774kfE6PWCGIBo6nB/mYwOimeakwo/UBUH6JAGFpirgjf6LRpoY6JyJr9wbUqZBF7pUb5mnJiEM730zRUrRsvt60XmsirQr9JJjNBmvuYkbICRVUxi7uAy3ftoLo/V25yB10Ng1+5LPnuTn4YiNmwAE8ijKzFbLstrFyGoyDbDiknc9yhAhtrCrwWduXZy3/oYFJMEaqWDBM/9lE1OEuf4qLm4dTZMOIKbiTNySJQ5N8DXLag/9sh/FMAE/8kQqxDouVXn/QOZrM/VYi25l6bAhkvCyRT7qgHrH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8feV5kXDMCnUmeRNWrHEQgm5xQKPjRKxFhE8vQhGeE=;
 b=fHwsewxWc/eShZspdON+YIVc4rHk1yU3GH3PaXD4splngM5BF2rvcuPhLqnUD9UMSiV0XzSJ4w/S8Tpu1OVek6JmEhhCdTRxSOstal0HE8v25LBcFXhrqphq+o8jYvqoknr9ANxSJfa9VfmhI9wwecb40toMcI6BdTjIvaj1khL7QMRz+s5caCKqeHPfXEar7v1vMSZUYlhwo0LXWWsK7HvFhrv7LVcOxGnYl3vIOeBR3TufB2avNd0216UIistQhU2tRwNZjSJzV24rfZua1hjzlTZXngycD4/oYLybNmWrQhJutTRpIS1edFFX0rF86BDvTeZuTOWs1t81AiVe9A==
Received: from BN9PR03CA0519.namprd03.prod.outlook.com (2603:10b6:408:131::14)
 by BN7PPFED9549B84.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 09:24:18 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::27) by BN9PR03CA0519.outlook.office365.com
 (2603:10b6:408:131::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Thu,
 4 Dec 2025 09:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 09:24:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 01:23:26 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 01:23:23 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v2 2/4] hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated
 SMMUv3 devices
Date: Thu, 4 Dec 2025 09:22:39 +0000
Message-ID: <20251204092245.5157-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204092245.5157-1-skolothumtho@nvidia.com>
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f96404-9d4b-47c0-dc0d-08de3316e62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THBuWUduVkcySU5zVXBHWFNKWmEzRUQ5RDd6ekE3emhkaG9lTzdYTXhTQ2dP?=
 =?utf-8?B?a3dFS0NiVmkzc3BrS2I5MTZ2SEFYdUpUUW1QMklFMzVoVGNWVHZNM0QxNUpV?=
 =?utf-8?B?T1ZNWDRxWFpqOXBGUWxaTkR6Wi9pS2Rybm9SNWlFTzFYSXN4d2syVTh1WVhl?=
 =?utf-8?B?ZGlRckdiWGpWSDk4RjdlTUNXcE5GUDdtZnNjWWJnM1JHbGlWdzNGRFhQV1Jn?=
 =?utf-8?B?QTh5djA2QVRiWVIvZlR5SkIrdTUrcG92cHZGajROdE81TkJnTEZQdERKV1RZ?=
 =?utf-8?B?Y0lUTXBTZjAyZUE1S0VPc3JaN29yWjRVVkRCR2srRHZrNUExZlhGS3lHOWdD?=
 =?utf-8?B?dzZsRUs2clpSWU5HY3QyVjRLWkFoRS9tQjFIODB4cWc0WkRsVUxCZkZma2di?=
 =?utf-8?B?YTVvTU5mc2x6WWMzdUw4cXlyVVlPS2F6NjZ1MyswZkloZE0zK0c0TE9ZM05Z?=
 =?utf-8?B?SEhpNDBCM2xPWVhadk15SU44bGNXSW1yWnFEN2pYQWEwUXVLYXlkMGNNLysr?=
 =?utf-8?B?OVovQm84QVhQRGlYRG9XMmU2T25KSlBTTHFGQVhJN1lhQjVXcHJ0WTQvWGFs?=
 =?utf-8?B?ZjVOZHVFeDVuQmxvUTczWE9EVmhPS21rMU9VblNzOU9weFhZOHVWT1dTM1ZM?=
 =?utf-8?B?Y1NzTlV2cjhqajlES3FpTHNzWlRqSlltYVVvK1JqeWsrdmlCT3ZVOHVYVTlE?=
 =?utf-8?B?WHJOS3NOUDkybXdEbXVNZERlWmgzUnBpZnRjTWZQSStMYVh5QzIweWtsWUFj?=
 =?utf-8?B?RjlsNnB5MjYyTUVwM1FqTzVqNXVrNjVUQnlpQVVPSVBoZVEwNVNJcXo3ZE1I?=
 =?utf-8?B?cFcvTmZ5bTdRUjhvMnAvdFRmU2RJVVB4WUF5ZStwVmRSbm1MMkhuZzM1WEJC?=
 =?utf-8?B?RWV1UmdEempQRk9Ma0RHeFNRdUJhTmxRNkp0SVl1djdNSEhhbEcyMDlPMFNT?=
 =?utf-8?B?cVpGNHZ3Y3JhUDVWdzd4eFk0djByVkVuSTFQbmR6ZW9BSHE5dDBCTkR0Q3lI?=
 =?utf-8?B?QTNKKy96ZnAzeExET09KaitpRGk2ZHpJSVdTMGtqK1JTQUFscmF4b3hLWG5o?=
 =?utf-8?B?cnRXQWhlZzNLWkplUm1KL2YyS0pqdTFKSENESmdQYjZPSENad2xOUXJrNGVi?=
 =?utf-8?B?ZWYxVExiSjZBZmI4Slc0L2tNUTYwaExoQ1JkOUludFJQTG13OExnU1ZrTHdt?=
 =?utf-8?B?UVZ0aFh0ekdPS01kZnZ5N3NnamxLc3QzN0xvYkxSaDNCUTZJY1hMQlpKc0VV?=
 =?utf-8?B?MXRzRVJXbXNzdGdlVndWM0FpZVZwK2NIb3RTZXRmRTI0clBrd2RtcG5UWFhF?=
 =?utf-8?B?Sk1QaWRzRWExVkV1OFI0ZVFUMkprUE9LNVQ5UW1uc0JyNTFlKzZSZ2VxQVdv?=
 =?utf-8?B?SGd0R3F6cjhmNkFyZ0NFUFFFWndsT2lkSm4wNnJXQk5peVBDOHBuVDloeG50?=
 =?utf-8?B?bHF0U2JkVThPaUJrSmdqRWludFNTZjVTNHNmWkZDbEJ5ZzY1Y2krRUs1Ujdt?=
 =?utf-8?B?amZaL2hNbEVJTzlyREh1VElBY2RqRG1leFJMSGcraFl4MFlPWEZTMVZzMUlr?=
 =?utf-8?B?WTJOQ0VRdlVnUUNGZlBzRC9PcnE0TlhjUlNLdktFT1lCZGJ1OHdwUkIrSGd3?=
 =?utf-8?B?bDk2eWtXT2xBTkdHM2hqUllUNklKSFl1dXQvT0NYTG1OOTZseTVvd2MraU4w?=
 =?utf-8?B?allLNmdHN3B1ZkFwcFg3RGIxaXhzU2JXR1NDY1FzRUNsYmgvZ0V3SldlcWtO?=
 =?utf-8?B?bWRhdGVJYW1DRDM3bGF0cjh0WVBEK21rVGRvTEhIejNJOTVjbFErU25vaURO?=
 =?utf-8?B?OERaRGxqOStnRXdtcEpkWWFnekJibFoyRk5oM0lzSFFuOXFuL1BxMnUvVGdn?=
 =?utf-8?B?Q0tMVlJjQmV6ajBXUThkRi9OcDBHMnNYTmx6RjlIV0RzdDdQWDZHOUk2R3da?=
 =?utf-8?B?RVg5T2ZUc2RtSERPMmxRck52bURod2RVTTBaOXd4MWprMTdnUjhZQ294Rzhi?=
 =?utf-8?B?VWU2bHpqL21SRVpoYnhVekplbWw0SllIVXV0WEQzMElidk1sbnUxVkR1WEt1?=
 =?utf-8?B?YmlOeEREVERDWW04bHJzZE55NC8vbHNpV0xhMjluSU9mRmQ0bjNHU2VtbDFC?=
 =?utf-8?Q?jukg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 09:24:17.3638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f96404-9d4b-47c0-dc0d-08de3316e62b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

When the guest enables the Event Queue and a vIOMMU is present, allocate a
vEVENTQ object so that host-side events related to the vIOMMU can be
received and propagated back to the guest.

For cold-plugged devices using SMMUv3 acceleration, the vIOMMU is created
before the guest boots. In this case, the vEVENTQ is allocated when the
guest writes to SMMU_CR0 and sets EVENTQEN = 1.

If no cold-plugged device exists at boot (i.e. no vIOMMU initially), the
vEVENTQ is allocated when a vIOMMU is created, i.e. during the first
device hot-plug.

Event read and propagation will be added in a later patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
 hw/arm/smmuv3-accel.h |  6 +++++
 hw/arm/smmuv3.c       |  4 +++
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index dc0f61e841..74f0be3731 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -378,6 +378,58 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
+{
+    IOMMUFDVeventq *veventq = accel->veventq;
+
+    if (!veventq) {
+        return;
+    }
+    iommufd_backend_free_id(accel->viommu.iommufd, veventq->veventq_id);
+    g_free(veventq);
+    accel->veventq = NULL;
+}
+
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDVeventq *veventq;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+
+    if (!accel) {
+        return true;
+    }
+
+    if (accel->veventq) {
+        return true;
+    }
+
+    /*
+     * Check whether the Guest has enabled the Event Queue. The queue enabled
+     * means EVENTQ_BASE has been programmed with a valid base address and size.
+     * If it’s not yet configured, return and retry later.
+     */
+    if (!smmuv3_eventq_enabled(s)) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_veventq(accel->viommu.iommufd,
+                                       accel->viommu.viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_ARM_SMMUV3,
+                                       1 << s->eventq.log2size, &veventq_id,
+                                       &veventq_fd, errp)) {
+        return false;
+    }
+
+    veventq = g_new(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    veventq->viommu = &accel->viommu;
+    accel->veventq = veventq;
+    return true;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -421,14 +473,21 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         goto free_abort_hwpt;
     }
 
+    /* Allocate a vEVENTQ if guest has enabled event queue */
+    if (!smmuv3_accel_alloc_veventq(s, errp)) {
+        goto free_bypass_hwpt;
+    }
+
     /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
-        goto free_bypass_hwpt;
+        goto free_veventq;
     }
     s->s_accel = accel;
     return true;
 
+free_veventq:
+    smmuv3_accel_free_veventq(accel);
 free_bypass_hwpt:
     iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
 free_abort_hwpt:
@@ -537,6 +596,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
 
     if (QLIST_EMPTY(&accel->device_list)) {
+        smmuv3_accel_free_veventq(accel);
         iommufd_backend_free_id(accel->viommu.iommufd, accel->bypass_hwpt_id);
         iommufd_backend_free_id(accel->viommu.iommufd, accel->abort_hwpt_id);
         iommufd_backend_free_id(accel->viommu.iommufd, accel->viommu.viommu_id);
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 2f2904d86b..7b0f585769 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -20,6 +20,7 @@
  */
 typedef struct SMMUv3AccelState {
     IOMMUFDViommu viommu;
+    IOMMUFDVeventq *veventq;
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
@@ -48,6 +49,7 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -78,6 +80,10 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 static inline void smmuv3_accel_idr_override(SMMUv3State *s)
 {
 }
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 763f069a35..ac60ca0ce7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1602,6 +1602,10 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         s->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
         smmuv3_cmdq_consume(s, &local_err);
+        /* Allocate vEVENTQ if guest enables EventQ and vIOMMU is ready */
+        if (local_err == NULL) {
+            smmuv3_accel_alloc_veventq(s, &local_err);
+        }
         break;
     case A_CR1:
         s->cr[1] = data;
-- 
2.43.0


