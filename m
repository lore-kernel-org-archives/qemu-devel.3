Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D82CCFA1B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 15:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGflK-0006ek-10; Wed, 05 Nov 2025 10:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGflH-0006e2-Va; Wed, 05 Nov 2025 10:49:28 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGflG-0002RJ-7A; Wed, 05 Nov 2025 10:49:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDJH/eX7b/7VC61j57GSqk4/BtjvSbnY75rW5pL2JrdM+YMSBGC39SHjtMzWquokMzszBGFLneRf9oZKdqaSlH3b3w78P+CvVf/40rILp+E97DHVRTlWzvthwfh/ebq7eX4+YimwkoG9ZM5QchU77cW3vKr7MvEQG8kESAxbAHs8P4rytoHQ+T5CoD2HyiNY99viEaYm6mAKDJnXu5DNTvk8aPdP9iWCn29Gpg09x4G78CgOIHQGx31m3HQnp1GKEevQY79DXUQqtRnaRPJRzqaf2Foe+/lNcpO6svjhWcmMDPqbLheGzgEyceZmY6YlxblmSuTyQoQ/CPz8nLg2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzervJU+kzZ+yyzbe7wwSfAhWbog2j8aVElbS2ZJiG0=;
 b=wBWSDvoDYW5EO3dG4zKls8zRFwoFbz5FlqRhCuIFTQ8oE36N+sYpkRnWDuGes3Kp0wZKSYRA1kYTveuX8JyJ3pdNYEqmF1tDkOsLoTX2EgU8CnHMnUoMmJFyr7RP9saAxtNfBKEWGUPguLKBG0pwi7Z3QC9AObMUfjtGRo4tHxuxVYSK/pSK5QSLXOt31m4wHPow+v1KnUiJ8lcgde86XzVpxH3tsnBdLMoms3x5IB6MblpZFkgFz4knIORUfJrMA1/cQ3uhNcMuvQ1m0eY39JX6Oq9EE1EiGyLnWEwy66+CxKAIhV6135B6ChUx/HRg61idnKbx+nEQ2Embvvb3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzervJU+kzZ+yyzbe7wwSfAhWbog2j8aVElbS2ZJiG0=;
 b=Ic6x9ym8KIn07v8P9J0ZtUV2+xzaJFgCwJV+OVrTXO7C53evCr1PuLlUX5kBNQV+ovk9qLtCK411ITrDzMh2m9Tez2SBO0bfUg0z9+4nH+zOW8HK/yjR+TsYXDszDMVwVDoXHmhv5VWFN2U5WzmNzCGtl5TYEJd8u/+yRoFcqz8UzqUuQTSFZpO/DOBMqC2Fwa5BRin37WdJXpty9AfB8AB2M02xR8d5NFjfH6W+qWqGUmhPgzuk71tlE7tZxJ9dWzQTIP9d5roR8Vs6BPIUfF80jEP98QSqMl2Ivmy+r3tgHm2OgFdLjve5VdPBt90RQqsYnHCufAAVmhwDRs8hXg==
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 15:49:12 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::83) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 15:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:49:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:48:54 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:48:51 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <jgg@nvidia.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 0/4] vEVENTQ support for accelerated SMMUv3 devices 
Date: Wed, 5 Nov 2025 15:46:48 +0000
Message-ID: <20251105154657.37386-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 797b66e2-c068-4cc7-5726-08de1c82dd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVlwdm1aQ1lVaTUyN3d3cnhUMXJpYUVBYU9vb0VtVEZtREtoZ1FtN3BiL1R6?=
 =?utf-8?B?WE9Mc3AzNEFZY3RIN29kUEkwUTlqZzF6dVVBOW80NUNaV3RGUWIwQkxTZFMx?=
 =?utf-8?B?SEk3ZXoyQ3B2SlpXTTVlS0FJd2pzT3RkL0pMOWprS3dJanVWZ2c4bURvc3Ar?=
 =?utf-8?B?dXBIVmIyZ0JSdGpvNkRnRjdGakcveTVWQXhyVkxjVTVqV3lKMSt3QVFQdklh?=
 =?utf-8?B?UU9lU1ZXVm1lU25qSzlteEtOUXdVajdnYTR3bFFRNW5OTUxUZ0hwR1AwMlFi?=
 =?utf-8?B?eXRaNldDSGVCNm1UT1JmSE85UWlGRTlmL21lc0ZPdmtzYWlZY1pIMXdwR0xy?=
 =?utf-8?B?a0p0cmo4OXR1a2J6NHhSc01SdjVWNUR3UXlneUM0MTN5WUMxT1Q1TUFhaThN?=
 =?utf-8?B?WldSSXo1RFBkazN6cDhlaHZSSC81bFd0TGFlY0xrRk5Jb1I0dExnUmF6bUlm?=
 =?utf-8?B?bUtyaDNGZXNSRGZ1VjltR2FndkN2Vk1XbnJLeXBCMHA3NlVMMnBJSXl5YUQ1?=
 =?utf-8?B?dlo1ak1jTFZjZUVpNUR5bVBOdXJBSmtCUk9QR2NkMUJyamx5RTBGQU5CQXA3?=
 =?utf-8?B?WTlXVmNXSWVtL0RPL1lBMmR1ZFZqQWIvaytLSnN2MEYwSVhVRHRhZXY3VXc1?=
 =?utf-8?B?UUx4VmlCWDVkM3J6UkNPREh5cDZOOHJPMmtTV3NPUW9ZSHVpMTIyb3IrS2NZ?=
 =?utf-8?B?LzBVY3pKNXdoVnFsODI0OWllUGdhZm5yekZONkxKdjlvMFNOQ05TS2pBMWo2?=
 =?utf-8?B?eWEzOUw1bjRHN0ladlVkSmVYSmc3OTVRemZRS2NvK29GRXFpZ2hEaFpaempO?=
 =?utf-8?B?RnJDcVJZVlppTGh5WFd4MEFvU2ZnR2RxRmNuNlZ4K0toa011NGpPUExMdXJK?=
 =?utf-8?B?TkpnT0YwK3VJQVBxQndwTENHbjVsVWhFdktiL01ieFdoWmR5MTJUc2VyZmJo?=
 =?utf-8?B?WWxNaUxNa2pNSXU4TmRWaHRNQ25rbkIvR2lVbTZkdlZSZEwrMm5BOGxtbzdx?=
 =?utf-8?B?Nk9WT0wrQkZSRFE0WTQrQVdXdW5rWnlyUjNoem5EdHpIaVlLU0RITlFmUnhr?=
 =?utf-8?B?M3RoWFVQVTU5dzY0VTR2blRzNkpGc3RWMThmaHo4Rk5wcHVnamVHb3RPWUcr?=
 =?utf-8?B?S2x0aWN0ZDhkTGJPM3dheFJyZGVuV2RUYk8yY1VkMFF6YU5BWEt5c05tcEFW?=
 =?utf-8?B?a3NCTDR1NmtuR1hCelNIVVRtNG9Jclo3dTJtd2ovVG1IUytrdmJINC85UUtI?=
 =?utf-8?B?TlFnalVoSUw1cFovMFExVXBsZ0dNMmp0azZGVkNwRWlkTkxmZDByZjZDOG5i?=
 =?utf-8?B?ZlhtR0FxZ05TZ3NrTWhlN1pOVmdrZTVlM0c4eUZ1NXA4VFd4VUNXNlRzTE4r?=
 =?utf-8?B?TE9TTkFHZkFuclBlN1hwN2w5M3lkM1ZvaVJJY2pGRDkyZCtaQndqZGJyTDVn?=
 =?utf-8?B?cVMzemRTWUIrVzJaWXlRcjdDQjQrcjlKc2tzc3RZVTd2MGJ6ZDV6M2lIWVZ0?=
 =?utf-8?B?VTlmTGl5cFc4bmR5SUl0Y2E2a2YydHRFZWxqbVF4NmFGOHB3MFozL3haRXpZ?=
 =?utf-8?B?Y3oxa0I4d0V5cWdpYlFOb0VteWJNOVVlaXVBVTVERXUxQm84QnhCQkdxRDFI?=
 =?utf-8?B?akpnbVVqWi8yQUpRdlRnWDZHMk9DVG9hVUw4K0N2U05pRlBtYytiNG1DbEJS?=
 =?utf-8?B?THZqS1g3ZVIvdGdoZ2dFVC9JNkJtcGsvU1pCTHJyNHM4V2V3RjZwSmxoNWM0?=
 =?utf-8?B?aVhzR080c01id2didE1pZU5ZMWdNc2UxZG9hRGhCNUJRVmJubnhSUHJEYnla?=
 =?utf-8?B?SHBscFp0bDRyMkdvbGtKOTlLWktHak84KzBqemNhQ2h2L1VwYVowa2ZSL1Nr?=
 =?utf-8?B?YzlzNm5oSkFrNFN0bHFrTzdNV3lReUtJK1RaeGJDRHFWZWVSYTgwOGxmM0xo?=
 =?utf-8?B?UnBDNUtqbmZiRmlPMUlXb2JKZTBQNUNrT2tJSE5QRkxjTGpoT3E4MjdlWVpn?=
 =?utf-8?B?L3QyblBvbkdKR21yOEJORFZrMHBoclF1TElNNzk1YXFkNUJKekY1NHZ5cm1l?=
 =?utf-8?B?QitHVTc3azZ0TnlMbG9SbHZ5WS8rN1l4RHhpL1FWZHdYM2dYZnFsZmhiMHBE?=
 =?utf-8?Q?pmT8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:49:11.7249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 797b66e2-c068-4cc7-5726-08de1c82dd67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

Hi,

When accel=on is enabled for an SMMUv3 instance, the host hardware SMMUv3
may generate Stage-1 (S1) fault or event notifications that are targeted
toward the vIOMMU instance in userspace.

This series adds support in QEMU to receive such host events through a
vEVENTQ object and propagate them to the guest. The implementation
leverages the vEVENTQ interface provided by the IOMMUFD kernel subsystem.

This is being sent as an RFC since it depends on the "Add support for
user-creatable accelerated SMMUv3" series which is currently under
discussion[0].

I have lightly tested this on a Grace platform with some hacks to generate
faults events. Further testing and feedbacks welcome.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20251031105005.24618-1-skolothumtho@nvidia.com/

Nicolin Chen (2):
  backends/iommufd: Introduce iommufd_backend_alloc_veventq
  hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices

Shameer Kolothum (2):
  hw/arm/smmuv3: Introduce a helper function for event propagation
  hw/arm/smmuv3-accel: Read and propagate host vIOMMU events

 backends/iommufd.c       |  31 ++++++++++
 backends/trace-events    |   1 +
 hw/arm/smmuv3-accel.c    | 123 +++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h    |   8 +++
 hw/arm/smmuv3-internal.h |   4 ++
 hw/arm/smmuv3.c          |  28 +++++++--
 hw/arm/trace-events      |   2 +-
 include/system/iommufd.h |  12 ++++
 8 files changed, 202 insertions(+), 7 deletions(-)

-- 
2.43.0


