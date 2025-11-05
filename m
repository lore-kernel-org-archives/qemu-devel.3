Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F302CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 15:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGflX-0006gj-B4; Wed, 05 Nov 2025 10:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGflS-0006fr-BA; Wed, 05 Nov 2025 10:49:38 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGflQ-0002TR-MH; Wed, 05 Nov 2025 10:49:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkYCpJdviH9BHjYxbLIePs+lyF4Nh/gC5VCP/u7bYF/DfDxrQGe9G5HUJCMwMiITA1wdJwu4gd645dhWivWbVlHvUY7aq4QM6hJLO/S6OZLN9bl3iKo7EdNgSCAzelUj0usluBdeV8MKnOVIiPsTBRbrCoD0AZmQ11UmN96DYD/XYpfXLn0hTpdy982o4vUH+pXfz8+19cHhe0LWbW95K2XNtqvbvdA198hfqJIFAFfyDF8KGgtThS0OE0dCuAVu0HRCunpuBzdRBFvB6bqKATXA8qbaO2o7DAngvXtuGNkDkhQuF1/qr0qRrR3ZJHYhOUrD3XvAghKdELMztnFfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4BNHhucELwHCgSa+Uv1jakXyvmwsKG0hnWuaSCQQ5Y=;
 b=A0k0EhQ+24gbgM+XmIquBidtkR6qMvrK/T+fv5Sakk/iBEsffgKXB0wN1yVpr9+avtU4hlukBlDfylBK9PILp2cr6dmYhiwsTnUYNrBxeuTOutltrUtQOLsD3ZvfM6sZUPiIQ7srS1U5UUr94Ls0QcI9K2rEUTIcA1qB2LnZwj6vszyRadFxtzhyVOn0mohPHrFcnsMs4/ulRO/DcLrPEau13UGkRRpEHnMu7Os1UAx5HUST2zcp7DR+aSJSPKDLCkqJZHJHF1OD09w9wOjoZqURDyqHdtSMO9JxSDzy0iwE5RO4GnDPqsJ4UmeUA0NL9k+bnVdC0Ty0sbHidHs/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4BNHhucELwHCgSa+Uv1jakXyvmwsKG0hnWuaSCQQ5Y=;
 b=LDB95I8GKwl/w7vbHZdb0HGgUAHpbdD/qnEY8oqNSRByfQac3vu3RJc4sjJuDuY3sPvNiZQVB8EkFxQdZh3aPv+A8YKu4cYVJnhAkr82Q00vHkMWhP8h9KC6SHVtDPPb+9QerTRoPbdlzP+o0jGHe1kAJDfpvU18W7jM2MYCZZCiifWHFOpX97Ra6uhzI+IdAQGA5TVxM+8aqlo7yaQ9ny86jzW4yYJk3TJEjCBeDM6Mg29PboPLwpDsaWI5NZN3EByLh72YN6ycSIj3ih0qSmWqtoRhRWQ5ofp/eEFiY7QD1k9Hz2EOS5JGPDeqqgdUmswHZFaA3mo98ADPsSp/Lw==
Received: from SJ0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:a03:2c2::13)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 15:49:29 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::aa) by SJ0PR13CA0038.outlook.office365.com
 (2603:10b6:a03:2c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 15:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:49:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:49:10 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:49:08 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <jgg@nvidia.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 2/4] hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated
 SMMUv3 devices
Date: Wed, 5 Nov 2025 15:46:50 +0000
Message-ID: <20251105154657.37386-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154657.37386-1-skolothumtho@nvidia.com>
References: <20251105154657.37386-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1e0233-81a7-40b0-33db-08de1c82e778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0NhOTJ4MlI2QTNJQTBtbi9ITHhGV3p0NnV6VmlLUnZZWllHSFV1cks1WXZw?=
 =?utf-8?B?U1RSeGNEQXlnVFQ3ampHNVd6cDJIMjJMYjhqZms2bW1OSjdWb2tNbko4enYv?=
 =?utf-8?B?NnNCQVo0TnB6dGRWcmR6UnRLUFZ1YjhPYjA5MWh3T24ramlLUXcyTlo4TVVH?=
 =?utf-8?B?T2dTb0VLRG1YcEp5aGdjRnZmS2llNGVSd0FCUW5qZVdHdy92SHorWlExeXdV?=
 =?utf-8?B?Y1BzKyt2QnlqTHVLdVoweFNDMzd5UmthM1l6NXRVN3hqWFRkc2dOWk1sdG50?=
 =?utf-8?B?VURrM2ZUMElhN29Xb1h5UjlxbDBCL2x0UlJWMnNtcHhUNXdRYjhIUVJ6NzdS?=
 =?utf-8?B?ZzgzMERaOUkyUXIxMjc1WThMNERuR0g5RDhraE84akt6QnVEV3RPOEVxR2dE?=
 =?utf-8?B?TG9tL1lXRk1vbHZFQm5kQnVoaFExZTB6RjhjazBPbGJTWS8wRmU5L2RPME42?=
 =?utf-8?B?a2E1ZFgrSnVHNkM2MWdVbGhSOXJicHFmQlRYNmxFMjlEMzdWYmc1dUlBZWQ1?=
 =?utf-8?B?QXdUY25WdFBGREZyb3BvV0M4NG9maFl5d0g5bEpxS3BBQTZoenZnalVjTk9H?=
 =?utf-8?B?UGlVU3BERFQxOHdQWlZZMXpyT1doMDh6cDNzU3pPZWlQWGVML2cxa2xoa2ha?=
 =?utf-8?B?MTFNU3Z0bW13Q1ZlUHNDZ2lPU1J2dC9FMWV6VHgxQk1EUVNMVnNUeG41N1ZZ?=
 =?utf-8?B?K0ZudC9CQ1hGYTVnZjg0NVQ3TzF6QkJnVlVOOVRnODcrSjh2em5PVmpVaVVv?=
 =?utf-8?B?NTZyVkxmN24wcFZSbW5IN254TFpndFo4a055cTFScTBmWjdTSWRCNkN0NGdZ?=
 =?utf-8?B?U1lmYnJ4cjZEZ2RZWWFMMnIrK3RhTHpaZm5HVzdwVjhTR0c0eE85Nm9OL1BN?=
 =?utf-8?B?bXhLSHprR0RLZHNORFY1ZEZVQ3ZVMGRuT3NqaGhYOHRtOWFtTkQrT3BlVHA0?=
 =?utf-8?B?WnpxeXhZRmRPVjN1UWVsbG9NdkVPa0lnYlBkWXpNUjJFQmZOa3Urd1c5M2R6?=
 =?utf-8?B?ZXlPWGdIUWpIaTlTdkdISG5IUk9IZnNNZEFSaTQrUTF1R25LeWhJNFVBZVdH?=
 =?utf-8?B?OHZObEh0SGY0ZWxnZFpMN0FQcHQ2ZVNuakkrZWs4Nm13bTlSaHhrL3g5emtt?=
 =?utf-8?B?Y1FaRXl4dytwMEd3R1ZraXZaQTdjVm1KNVpQLzlvMkZIQW4zbUFPSkk1eDhQ?=
 =?utf-8?B?R0RmdHlPSWxlNXlLUUcvMFRoSDlvZDVULzVVMU1QMjJTVmtOYnI0ZmJsSStG?=
 =?utf-8?B?anFjSVltOFI3aG9qMnVjRW1OZ2hmb3dLZ3VaNmhPdjRrbU1PQWk3RGFKWnI2?=
 =?utf-8?B?dUtCVVNMbFdyT0VnbWErMU5PL1kyUjMzdjZVSGxNc0N3dEVRNjk5T0J0bm5S?=
 =?utf-8?B?OFZ5Q1ZKMmdBbk5OZk5Wb0Y3eXBtajA5QlZFS0Y2L2dya3MxTjBDbHRCTWdm?=
 =?utf-8?B?U2syQ3RQdWtkM0lPUndOUmthV0lNYi96djNLSWhXTzVKQ1k2M0lTQ1QvbW5z?=
 =?utf-8?B?RUpBbmRrbXZmRTJZMDh0UUd0S1RTT2N0a2hrR0ZiQ2x3WldNSTZPSG94bWlO?=
 =?utf-8?B?Y2NjUGI1NEI2d21BL1FNc21kempTM3R1WUlCdzlaVlhPVXUzKzN2Z0QwTU1G?=
 =?utf-8?B?RUhQek9CYjNpaU50dFJZL0wyTW9XcnU1cmdYeHVjZ04yRVBnWlc1WXh4bHU0?=
 =?utf-8?B?bmFmcmZ0ekpUWW1ZTWorcUFpVWFZRDEzT05vaHRhanljdlF1TGkwdXFiUWUz?=
 =?utf-8?B?ZUozQS9IODYrOUhqYzVHN0VlbUdSQTQyZzJLNDYwRWZOcisyWE40YmE1dWxE?=
 =?utf-8?B?OCtmUXB6N2ZFUU15cGl0QUNzOXpuUnJqVUU0MkVzVTFmNE02cFBqZlc3Njdt?=
 =?utf-8?B?aW5TOUtWOHB3WmRwc2lZZlM4VmJvdjhsU1BFRHBpUmVGK1B0YitvcG9IWTRN?=
 =?utf-8?B?eVpzSWhvVHVjOU8vSCtUcmltZU1qS1BtVGJwMlBYNk9CODRnRUVkT1g0YmJC?=
 =?utf-8?B?WlIxeDYxUjVvMFI5NWd1UVN4TEJMZ1p0UnFkd3FmUnJoVlQ1aVd5UXUyZ0lr?=
 =?utf-8?B?MHZrSEZodDVqK2x4eitickFod3JTVk5nWFIvOGJTdmdZLzcwNmNSeS9MbEs3?=
 =?utf-8?Q?33tI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:49:28.7546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1e0233-81a7-40b0-33db-08de1c82e778
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 hw/arm/smmuv3-accel.c | 61 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  6 +++++
 hw/arm/smmuv3.c       |  7 +++++
 3 files changed, 74 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 1f206be8e4..210e7ebf36 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -383,6 +383,59 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+static void smmuv3_accel_free_veventq(SMMUViommu *vsmmu)
+{
+    IOMMUFDVeventq *veventq = vsmmu->veventq;
+
+    if (!veventq) {
+        return;
+    }
+    iommufd_backend_free_id(vsmmu->iommufd, veventq->veventq_id);
+    g_free(veventq);
+    vsmmu->veventq = NULL;
+}
+
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *s_accel = s->s_accel;
+    IOMMUFDVeventq *veventq;
+    SMMUViommu *vsmmu;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+
+    if (!s_accel || !s_accel->vsmmu) {
+        return true;
+    }
+
+    vsmmu = s_accel->vsmmu;
+    if (vsmmu->veventq) {
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
+    if (!iommufd_backend_alloc_veventq(vsmmu->iommufd, vsmmu->viommu.viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_ARM_SMMUV3,
+                                       1 << s->eventq.log2size, &veventq_id,
+                                       &veventq_fd, errp)) {
+        return false;
+    }
+
+    veventq = g_new(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    veventq->viommu = &vsmmu->viommu;
+    vsmmu->veventq = veventq;
+    return true;
+}
+
 static bool
 smmuv3_accel_dev_alloc_viommu(SMMUv3AccelDevice *accel_dev,
                               HostIOMMUDeviceIOMMUFD *idev, Error **errp)
@@ -438,8 +491,15 @@ smmuv3_accel_dev_alloc_viommu(SMMUv3AccelDevice *accel_dev,
     vsmmu->iommufd = idev->iommufd;
     s_accel->vsmmu = vsmmu;
     accel_dev->vsmmu = vsmmu;
+
+    /* Allocate a vEVENTQ if guest has enabled event queue */
+    if (!smmuv3_accel_alloc_veventq(s, errp)) {
+        goto free_bypass_hwpt;
+    }
     return true;
 
+free_bypass_hwpt:
+    iommufd_backend_free_id(idev->iommufd, vsmmu->bypass_hwpt_id);
 free_abort_hwpt:
     iommufd_backend_free_id(idev->iommufd, vsmmu->abort_hwpt_id);
 free_viommu:
@@ -536,6 +596,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     }
 
     if (QLIST_EMPTY(&vsmmu->device_list)) {
+        smmuv3_accel_free_veventq(vsmmu);
         iommufd_backend_free_id(vsmmu->iommufd, vsmmu->bypass_hwpt_id);
         iommufd_backend_free_id(vsmmu->iommufd, vsmmu->abort_hwpt_id);
         iommufd_backend_free_id(vsmmu->iommufd, vsmmu->viommu.viommu_id);
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 4f5b672712..740253bc34 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -22,6 +22,7 @@
 typedef struct SMMUViommu {
     IOMMUFDBackend *iommufd;
     IOMMUFDViommu viommu;
+    IOMMUFDVeventq *veventq;
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
@@ -56,6 +57,7 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 void smmuv3_accel_gbpa_update(SMMUv3State *s);
 void smmuv3_accel_reset(SMMUv3State *s);
 void smmuv3_accel_idr_override(SMMUv3State *s);
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -87,6 +89,10 @@ static inline void smmuv3_accel_reset(SMMUv3State *s)
 static inline void smmuv3_accel_idr_override(SMMUv3State *s)
 {
 }
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e1140fe087..976a436bd4 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1616,12 +1616,19 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
                                uint64_t data, MemTxAttrs attrs)
 {
+    Error *local_err = NULL;
+
     switch (offset) {
     case A_CR0:
         s->cr[0] = data;
         s->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
         smmuv3_cmdq_consume(s);
+        /* Allocate vEVENTQ if guest enables EventQ and vIOMMU is ready */
+        if (!smmuv3_accel_alloc_veventq(s, &local_err)) {
+            error_report_err(local_err);
+            /* TODO: Should we return err? */
+        }
         return MEMTX_OK;
     case A_CR1:
         s->cr[1] = data;
-- 
2.43.0


