Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED130D1D892
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5Z5-0002tU-RU; Thu, 04 Dec 2025 04:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vR5Yu-0002pK-7z; Thu, 04 Dec 2025 04:23:46 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vR5Yq-0004ck-Md; Thu, 04 Dec 2025 04:23:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqSXrPoa5gKEA/sCucN1FNNj1VkYfQyGJeqblG0JQZjmrWRgWj13bQkn7iyFxINNTDd+2EoIyJFEPGjQxrdjQJ+foHW8jR+u24cgneLVYvcM9geOzjr2KMe8ZrC1OON/+yWCkOA9b/dX9TEJVN+Kc8+9OVCDKgUH6Eyt7aBsQCHTMxT6U4JsmTEldcHZYjc5kc4JpBIubCuh/J8ERroFrEJnz2Yp8BTsBaEt5aSnXUzMXCZVwYYDwmKS7xyQQboMw5HJ4mjkSSrKg1m4L4eyXAbS0dR6Br1g09PEhfWvikaVPRAdRDXQLf291AZkjnm83lUpFv+ICoBxXzMmyAdNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5LO3B9LPUyKCNwcn3Or35mhVuy0WUxdjPmlmF1QiDU=;
 b=QjGxm3eMV/K2PmiqJbrEpfLSffrBM4F7zMzXb6OfaBcGgPxMWsw84sGIe17ITKjMuSJ8l7+k8lT3YuI+oLQNv1T+GUQOTdTxClHuLRuWuaftSIiawL3jYZgPrz+oInWUGwQuyMWy6Hpvh01kJKWjtPzNOmxq6cHV4TR6qWBXE6LUjRS9dl5e41HhnWolm7M0rCgWG8OVI496aLgWc8rfY4ZCDfQRDvn+6KEYVyNb/0OGJPfvX6cow7mGP9HoLSSSrZO9xbAiq26HlQ85RSGPAKq4blGl2rWJB8AF19zazyR/oK65GxN/erm/PTTRAvlSSvxTkKyaiFL5zS0Xbdl3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5LO3B9LPUyKCNwcn3Or35mhVuy0WUxdjPmlmF1QiDU=;
 b=YztuP/NHOZWeE/qpBRzV8H3Do7bQMK03rO5HlQbdDiV8dJz4/pP+2rB9XuyhR7U/MG42anxcCfvqLpwDCgimtktdha+Lx3Xkpyrw427naxT38XbO1oKFqUL3J82hSB766+3hX7zFClKdzQaR9mUwRakn4F/k/0k+JDHXltCYj3nJF5Ib3QsByDANH8evWMbVY9dSeHl1ji4FFUoPWxOHaV6g19xKO34J7y6rUAaz1Ys5R5YOYZJSRh30/B1FzrSK00DqeZElKG7TRneHicxeS//8VL9vYF8dHcL1Vln8X4zcRDAFx11y/p1fsZ5wY5nSVr5iRJtQ8Bu4dYzDNUgpng==
Received: from BL1PR13CA0448.namprd13.prod.outlook.com (2603:10b6:208:2c3::33)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 09:23:33 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::41) by BL1PR13CA0448.outlook.office365.com
 (2603:10b6:208:2c3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.10 via Frontend Transport; Thu,
 4 Dec 2025 09:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 09:23:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 01:23:16 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 01:23:12 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v2 0/4] vEVENTQ support for accelerated SMMUv3 devices
Date: Thu, 4 Dec 2025 09:22:37 +0000
Message-ID: <20251204092245.5157-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 71acdfdc-4e80-49c0-9a79-08de3316cb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVByaXFSY1hydXNEOGFWbjZYZzJDMGR1TE9iVkppaUdqM3gwa3FjbXRNbDJo?=
 =?utf-8?B?ZEQ4ZDNQaFlrem1TQkZDSVJUYmYrZytSRnRLeEpJVkExMXFURkp3ek8rcGEy?=
 =?utf-8?B?c0dsZkR5cnhveE0wVFlnaTVRdEZTQ3VZdWFETC9WbW5uN2lPVDg5UU0ycjRQ?=
 =?utf-8?B?NkFpZmRuRVlQZVdwMk9lYXVNYmZGU09ZNm5JNFJVcU1MaVc2ZjVDeXR5RUQ0?=
 =?utf-8?B?ay9vVVI1OWN0UTErTzlBUjNqWDg4bTN4N1duYXNLK3BiMTdkdjkyOGJYWTZj?=
 =?utf-8?B?OG1TY09SQ1g0Q05JdHVCd01ONGRRQWxzVjBobGUyejNMR0JtTTB4K1h2cXEx?=
 =?utf-8?B?T0x5VWFNSHVKdHlrbmxNVFZhcHZjc1VqUDhGR3FGMzNNSTd2WTh2WDhYYW9y?=
 =?utf-8?B?YitYNm1uMitpWXFTZ0w1MWFPQWtUVkgvYWdwZ3gxeFNQdlBnRDl2QkpyRGs0?=
 =?utf-8?B?ZUJaeE5OMU5ZcGY3UzdiUmhkWmsvYncwcGtGcS8xMHNObkhyZzlHeVVHa3VY?=
 =?utf-8?B?NzJqN0M2U0theEE2c2FZUGQrd0lLYjVPY2kyaHBGQktlMFllN3dBSi9VRTRx?=
 =?utf-8?B?SkVWeWlIWjFNVVg3Vk4xLzIxZ3RGVEs2cGNnendJbVJiMkp4SjJtYUtOcmlS?=
 =?utf-8?B?a2ZUNUJWdVdOTWNIUWlwbTkrQTduMk1JaHQ2L2I0SWhiRFJSZmp4YkJHaDli?=
 =?utf-8?B?Y2VuMlc1UmtFSHFvMnFaaGtlaEJ5Sk91UmJpMWdYUWlIbjM3bTB3bUVMdVAz?=
 =?utf-8?B?QXFZSUpQRDFtaDRBM3hXc1FBUzV3RWlqbHhScUZ2RHFmRFB4aWliNmRwbC9m?=
 =?utf-8?B?VTlmMTZqVUdOWnk1OVlsM3lScUJQb2RIUWgrSUJmRUtXb0dOdFVGaTFVQnVY?=
 =?utf-8?B?UVRrc0t0MjRNUEEwN0Y3YzNpdkhoRzhJWUVzZjIvbnhtdG1jai9yS3N0Rmh1?=
 =?utf-8?B?aXl5a053Zm9JeHFBZzN4TmY4S0J5Qmg5Z0k0dzBWZEJESndLc3o4aG1WNlYw?=
 =?utf-8?B?aVc4NWpTeGszTG5qcUZIOVJPMTRJQ0R2THpRRENycDZvTDBuVTA0VGFWUmty?=
 =?utf-8?B?MlZ2TWh3SVlqbW5wTi9vWXVQaDNUVEZkOThLVmlEZmg5M0p1MTBFMUducFFx?=
 =?utf-8?B?Z21VdXpITE9PeE5nZk4zWmFERVFHUlZkR1pKbTREMHVsMG96QWpUN2Vya3ln?=
 =?utf-8?B?NU9xV0JhTzRhcnF5ZXUrTUNrcHpTNzNGN01iQnhZd2lFYjFqL3dCNjkxY1hN?=
 =?utf-8?B?Ti91aGs4NkZjUW9rQU9FL25iN2pDWm5sSnFBclJPLzA4a0xqakhaT1U4U2tx?=
 =?utf-8?B?WkhsNlE0WitYU3NBNmZSeGlEM3FDSFhNWGEvK24vN3UzQU9iYnJqUTYyNmpn?=
 =?utf-8?B?aGdURWtTaFpxZWlhN0NWVmtFTUlQMzB0MEphRW12N0hYNGMyV1IyVUgyVGdU?=
 =?utf-8?B?L1FYRzVhSU9mUkUvS2JZZDdPZUhKMUZyR25yVzA3WUh3b0ZWcE5qMmRPcGVH?=
 =?utf-8?B?dHk4ajltSTdjVk1iR0xRZEdidXRnaUw2UHR6cHY4OVRRNndrR0RlMFpjUitz?=
 =?utf-8?B?R3FGUzNFK3plaldxRDdCZmVxVUVXMmNCYWJjbFpmRHQveFpZcjlHd2ZuNHhm?=
 =?utf-8?B?dElWOExyNjdPa3FVUWlJNUxqOE1vcnJZQ3lOaWRsSWZMVllSZHYxRUw4eDYz?=
 =?utf-8?B?b2k4alZrS0t6UGZOY2psT25kOERZY0VtME9zRkhOQUJYcFRBOWpIWm1qYW8r?=
 =?utf-8?B?T3VWWEFydXZBRHN0Z05sNmV6ZXp3QlZTUGlJQzVEaWVXS2tCQndYSzBsNGJP?=
 =?utf-8?B?U29VcFZyenFvTU12VFdwUHhrc3BFeVg0TGV1N0srbVpaNHlyczA2NUFpRjRm?=
 =?utf-8?B?WjB1TDdGU0U4cGdHVno5OENjQ3R5RE5UVy9xSC8vVjJZbTJUQkY0NGVGcnc1?=
 =?utf-8?B?aW9oVzdCblUrOWpveHJhQkFOYUhqbHhVRldUNGxYN2RxSUc1RFJ4SFNOTW9F?=
 =?utf-8?B?M05mYXVnOTJqVUh6REVQdUV5QVFsTHdMNTIrdFVkODZxbUdGUmdiejRrb05o?=
 =?utf-8?B?N0Q0S2Z5QVJ1UzRjVGFsU3EyWWlFYUVaTXMybW5Ea1puK1dpbWtnN0FTcUpm?=
 =?utf-8?Q?UBGd3TDR2JEjWyEflPZ8vm1hw?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 09:23:32.4592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71acdfdc-4e80-49c0-9a79-08de3316cb49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Hi,

Changes from RFC v1:
https://lore.kernel.org/qemu-devel/20251105154657.37386-1-skolothumtho@nvidia.com/

 -Rebased on v6[0] of the "accelerated SMMUv3" series
 -Addressed feedback on the RFC. Thanks!
 -Dropped the RFC tag as the accelerated series is now more mature, and once
  that lands, it makes sense to pick this up as well since it enables the
  delivery of SMMUv3 events to the guest.

When accel=on is enabled for an SMMUv3 instance, the host hardware SMMUv3
may generate Stage-1 (S1) fault or event notifications that are intended
for the vIOMMU instance in userspace.

This series adds QEMU support for receiving such host events through the
vEVENTQ interface and propagating them to the guest. The implementation
uses the vEVENTQ support provided by the IOMMUFD subsystem in the kernel.

I have lightly this on a Grace platform using some hacks to generate fault
events. Further testing and feedback are welcome.

Thanks,
Shameer

[0]https://lore.kernel.org/qemu-devel/20251120132213.56581-1-skolothumtho@nvidia.com/

Nicolin Chen (2):
  backends/iommufd: Introduce iommufd_backend_alloc_veventq
  hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices

Shameer Kolothum (2):
  hw/arm/smmuv3: Introduce a helper function for event propagation
  hw/arm/smmuv3-accel: Read and propagate host vIOMMU events

 backends/iommufd.c       |  31 ++++++++++
 backends/trace-events    |   1 +
 hw/arm/smmuv3-accel.c    | 120 ++++++++++++++++++++++++++++++++++++++-
 hw/arm/smmuv3-accel.h    |   8 +++
 hw/arm/smmuv3-internal.h |   4 ++
 hw/arm/smmuv3.c          |  25 ++++++--
 hw/arm/trace-events      |   2 +-
 include/system/iommufd.h |  12 ++++
 8 files changed, 195 insertions(+), 8 deletions(-)

-- 
2.43.0


