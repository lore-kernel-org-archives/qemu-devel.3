Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389F9D2D8F1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 10:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkgRm-00045Y-8y; Tue, 27 Jan 2026 05:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkgQg-0003Li-VH; Tue, 27 Jan 2026 05:36:17 -0500
Received: from mail-westusazon11012007.outbound.protection.outlook.com
 ([52.101.43.7] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkgQZ-00018o-Vl; Tue, 27 Jan 2026 05:36:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUVadQPlbWVbw+dL03a9yEZEUjDBZna33beZANtrz6dDPW6WSonYqRjkGqNIuFfgxRvuxbW+QZqq0WU6bMObCJJFezw5/JBIYzXGplpRrZKn76Cc2iae6FJ9bygbxv8u6RdTtHyjuiOj3wwn/5xJbilNvM63TSKlDR3d7mSl7/ktx8OPH//BTB//3VmF+Wkp9knha0G1iRqHbKWbkcGHBT7JUBfIpGx8vkrCaMWRGCEa1gJ/Ji1H8LGTqG6tiXXp/Rj+5a+/qZDbAFO4oShZXL8eh+q3E4ImmzDYlaXWkoK0DqpOq0XMjmxUdMGydJgLFQVeE8FBeRCF3RQq9hT/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgnqeGOE8oxsK14xlqmqjM/657i0ZjncsTE+c01eUr8=;
 b=rbeiTzjGJM+awv8oI/BcRUsXZFhlQO2BiT6ZNnApFhvnRghvTGoi/x06R5Zev74gto4uC/gXYsWH5IBSZ9Gj5A6RqZx75RYIaO4w96QozDKf3xrHKy+IgW8CEeovbkQuvlHr8QFYYwZMrVhrYBHWbCTzDfL5eaxivkD5WGn+cyIX/5cp6mrVf5TN95CN5f6OgzO4ilZt+f4p5WurvF2bkl3u63HTOVuHbkgDenDl1pC4OSwg/WRwNYpnV4L4K3C5KGYtiX6ZgZJlMCOXcwzTuUfA0Ah+nPulGg1+igrMWGhy9Su/KemkVOeIpxMUnFzXl7zPeB8zzpeWqSwoxCmhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgnqeGOE8oxsK14xlqmqjM/657i0ZjncsTE+c01eUr8=;
 b=PM43rmWxUQFnAZBRkMBv15RlfL2TwvIfmCaUalPF6PpKZIs5hR0/WpbsZLCS6nkTVn/iQrhizYS13kqXBn5RDbNIUZ5iH65YRov4Hfo0Gg6ryPGLdgjITNr10bGvqiLScgLJVqhzl/LtRysAJXEfUnKLVT/CC29g1wkAkocapi5aRFZryAfUaw6yrF20vG9ohHezEbsQoc1ZQWqS76wwILlmJDP2P1AbP44luLjBXG4GOnrFUi7F5ObK5JiMUgPOpuWQXHXeNqNGo4a2T4Z9diqfuVWR2r5xptNxgFPb2n01GCOtLpM91ZpF/k741FZsWLrbptGdYFGbu0aBo+LDuQ==
Received: from DM6PR04CA0007.namprd04.prod.outlook.com (2603:10b6:5:334::12)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 10:34:21 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::c3) by DM6PR04CA0007.outlook.office365.com
 (2603:10b6:5:334::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 10:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 10:34:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:34:08 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:34:06 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v3 0/4] vEVENTQ support for accelerated SMMUv3 devices
Date: Tue, 27 Jan 2026 10:33:24 +0000
Message-ID: <20260127103328.255382-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 4716b8f6-c44e-45c9-6460-08de5d8fa19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlFvbGErR3NocllPeSs2T1hlbFhaaUo1TEFuQWpiaG94T2hBMTQwSENUeVRG?=
 =?utf-8?B?Zm5wOGpMWW5scm9iTkI4SGNsaXAzbHVBT1FUWXY0dUtCYXllWVNOVk50eGhN?=
 =?utf-8?B?ckYwNlRLMkQ0U2NiY2JHY1FOZEkzL29GeHNyQkNXMlNudXBtQ1F6MzdUWWNO?=
 =?utf-8?B?cFc2aEYvRmwxMndsVTVLVTZGeGZXeTlZaTVhQ1BKMG1Od0ExcWo4UVJpL011?=
 =?utf-8?B?NUVncnc3OVVJZk0vWXN1a0hWUUFmOVQ1ajdNOTNEN3JubUxzb1Rma09uT1BV?=
 =?utf-8?B?WmVxL3Vaa09uNDhsSnYzYmg4Q2N4RkJCaENSZEFUSkRmdFVRZENBclVvUXVR?=
 =?utf-8?B?QlduRm9TT0NRREl0ZnZhZ3pLa1gzcE5EMTBiY3NRdEJYdEpHRndseTdCSHc3?=
 =?utf-8?B?aFUxRDNvdkFKTEUwWDVUUXN6WkhpYXZiOVRyd29WLzZuQTh1dmZ4cngzalRW?=
 =?utf-8?B?L2g4RHplTzhPMm9UaWFtMS9wVk5KRnlEcjVEdjQvNjIrblBZM0hMRGx3QVVX?=
 =?utf-8?B?UjNCVTlTbDNDOEQ3akJIUVJlYm5OZG5qTXdpcjB1dWRQTGVpa0ZRai9mY0FJ?=
 =?utf-8?B?WVM1TnRWNCs0R2ZOT0ZJWC9uNFowYXR3WEJELzZQZ3hvUmtjT0NZNlY3T29r?=
 =?utf-8?B?SXd2QVZ0ZTh4cjNnWVg0djd0Rjk3QjZsN1N3RlZNZTcrTWVVTzE3NkY1cDMv?=
 =?utf-8?B?dCtFaXFoN3ZkOUpNU0daeDMwRGlFV1ZaMjV6ek0wb0tXWXlSbHZncVM1RFJZ?=
 =?utf-8?B?Mi8yWU1LaGdXMkZqdzU2WEhFaXBNRTFITWQvK2c2LzdZdFd4V2tLaXliVzZK?=
 =?utf-8?B?dTZUU3Npa2UwV2VsZnFnUkVKWTlXZXlwdTZwYStiNXlCdEpKT2k5QTJqcnlt?=
 =?utf-8?B?Mm9tSWx1VEJ4SU5FclBsaWJiS01KaE5JQ3lTRXkyVkRHWlFGbTBNalNnanZs?=
 =?utf-8?B?NGxrT2M4TDNzQnhFOTdCQTAyeXhRclN2d3o5MWtwdGxwNy9VRWE2Z2hsM0tj?=
 =?utf-8?B?RHA4TGVCV01LbnoyS3dNd1JrVldlcEI4ZjdXNGNrMEVnakZOdENRZzI5S0Nw?=
 =?utf-8?B?QTdEK0ZibG93eEdON1BWdnpWMzJHZ1MrMHVLREhKL3FhNjJjaTNjK0VyTHFF?=
 =?utf-8?B?ZFlCekVDRXpaR0ZoeVZwenB0U1BLekREUUY0NE1hQVk0Zi85UUk3OGhnOFNq?=
 =?utf-8?B?Vkc3cy9zckVxSk1EQnVDVlBHOGduak9pN0J4NUN4UE5FNmdTcmZFSUZmZDhD?=
 =?utf-8?B?dlNpdU92NlVsSmhZMFlMMDFxYTREQnVwTkNUTmVBSTVUMnFwL2lKRUdleVVo?=
 =?utf-8?B?T0xaNCtJVHRyZkFrRVpNdlJLVXlHWEdTNVorc0RyT0h0UkVwUnoveEZEWFRL?=
 =?utf-8?B?MnByNWRSdWNIZkpZcVJpRS8wc2ZsMkNDYks0UktEaS9qUWJpN0tic1NSYTJF?=
 =?utf-8?B?cU1tWDA0czRrcUorUWo0eGczL0NKQ2RaMllpdStycmVHYmM5RHpPb01HbG1V?=
 =?utf-8?B?WkxyZlowN3N3TzZwcXpkL2c3MTlYOTJPREpSUGgvM2IzZGVvcGZmMXBpQjha?=
 =?utf-8?B?TWJCU2c2U0gzM04ycGpkRVN4dnAvbkgvWWQzR3E3SmlTZ2pQcnpuajl1Um9n?=
 =?utf-8?B?cmEzWUxsZ09hSXJ5d3dvN2ZpM3NrUHpJWDVINWM3Nm1TYjhlcEp5WVZhbDEr?=
 =?utf-8?B?WThEcnlTWjhkNVRNTWI5dm14Vm1FZy9LV0FqUGRlUUE5TVpPdzZ3VFhrV0xr?=
 =?utf-8?B?MHdzY1pFZmJCQWFoYTFPNTBwNWVxREQ4OWpxNTFNdDlsbC9hejlEdVJ1bEh3?=
 =?utf-8?B?a3VwYWxIQnJ3MUdGZGoxTjhOTWVzYWZVMlREc2N0cGsrMVJWY0I3cTBJQzFa?=
 =?utf-8?B?QnZYdkVUbi9tQmJRaWhSaUp0VTM1bFpTdmZHWW1UQXVFRDRRNU5yZ3EwSmlQ?=
 =?utf-8?B?eVJ2K1M3U2owTzFEdGlkTkNSMXIzSnNmREZJTEhQQ2tYclR1SjhEY2dHQjlk?=
 =?utf-8?B?QzA0bmhJcndIdURJNXREeExUbGsyRjVWT2ZVMEEzenVwRktYVWg4VFFra0pv?=
 =?utf-8?B?ZitRdjREV0lISzRrWkgxb2psSStHMkFXVFZHdnlPd3R3VHQxY2Vmb2Nid1RT?=
 =?utf-8?B?cHRmNjNnaHlDd29kRDNyREwyWEtiZFdjZGl2T1dZTTN3M0hxMUF3bTRueGI5?=
 =?utf-8?B?Y2psWXM3NUprV010S2trOWw5cE1MVlZNK0xmeUVYVGF6MFU5dU96dmFMTUdh?=
 =?utf-8?B?YzNYWXY0RjVOYUQ5UTRGcVlPRTJBPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 10:34:20.4959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4716b8f6-c44e-45c9-6460-08de5d8fa19e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
Received-SPF: permerror client-ip=52.101.43.7;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi,

Changes from v2:
 https://lore.kernel.org/qemu-devel/20251204092245.5157-1-skolothumtho@nvidia.com/

 -Rebased on v9 of the "accelerated SMMUv3" series[0].
 -Addressed feedback and picked up tags. Thanks!

When accel=on is enabled for an SMMUv3 instance, the host hardware SMMUv3
may generate Stage-1 (S1) event notifications that are intended for the
vIOMMU instance in userspace.

This series adds QEMU support for receiving such host events through the
vEVENTQ interface and propagating them to the guest. The implementation
uses the vEVENTQ support provided by the IOMMUFD subsystem in the kernel.

I have tested this on a Grace platform using some hacks to generate
events. Further testing and feedback are welcome. The complete branch
is here:
https://github.com/shamiali2008/qemu-master/tree/master-smmuv3-accel-v9-dmabuf-v4-veventq-v3

Given that the accelerated SMMUv3 v9 series is now applied, I think it
makes sense for this small series to go along with it.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20260126104342.253965-1-skolothumtho@nvidia.com/

Nicolin Chen (2):
  backends/iommufd: Introduce iommufd_backend_alloc_veventq
  hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices

Shameer Kolothum (2):
  hw/arm/smmuv3: Introduce a helper function for event propagation
  hw/arm/smmuv3-accel: Read and propagate host vIOMMU events

 backends/iommufd.c       |  31 ++++++++++
 backends/trace-events    |   1 +
 hw/arm/smmuv3-accel.c    | 125 ++++++++++++++++++++++++++++++++++++++-
 hw/arm/smmuv3-accel.h    |   8 +++
 hw/arm/smmuv3-internal.h |   4 ++
 hw/arm/smmuv3.c          |  25 ++++++--
 hw/arm/trace-events      |   2 +-
 include/system/iommufd.h |  12 ++++
 8 files changed, 199 insertions(+), 9 deletions(-)

-- 
2.43.0


