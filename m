Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B16FC44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9Ps-0002oI-Gk; Tue, 07 Jul 2026 13:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wh9Pq-0002kU-FX; Tue, 07 Jul 2026 13:17:02 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wh9Po-0006uJ-N7; Tue, 07 Jul 2026 13:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7zFTqgpYkateV4Hgoj3/pchOwe/Rx77AdO8XJ3P8zWYNh1uFvX/dnt3Dccf6n5RoCI+u5/7W7d9l+utIuNMFcPfGjevvxAvKUNai3KCfDo9TlPCpy46YnsYbM05H97ISsK1/mA3jazDQU4Z0r+1rFfETJo8E4Etij42HQqziMh7fPTj6cG8kaC65+hOOQOQuC/j5wdq7rZDo15jnUl1i6wAtqnSJprDRXPaIITPlc9TwguXDQmrLzFO4OO2iU2VSuNd5yeWCviZ1KpJmwAKyx0wuPi5g/TbEJbVn3l+rYilWTjnFpa45MIG2eSFUobZA7yZDxP8swqbvLU8UPfPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZTcPfZg9JNCG++IbB2kZMO3TdPMG/uSglXd5OWyVVI=;
 b=Qdty6xn0jR3A36htBniRdJ9NR3wYiarCcgYueCq0M87g4JgBlS+7TzSE2AuRORQAjStlwtd4JSYJkZW82lCuCiLY8fI+VSVj1haKMSXm8wtdSxzmzY0e7LXGPCZXbEidqWBcCZzmZp/cy+9ySw9UdlzEOtKX2BfDmBf1dCpqGTSYc/uWmk8/qotUZI2yUnwFByqPwQrHkYUQ0XqsPve6c20wchRbQf/U3S4FpKErnCFOFRFDILrtygNehS3Iygvh46HGmcd5qQwTnAIRT4Of9NiVvef2iohpYPMixs1ierqNWMiPcdEnG5ldZBatsmWqV4aitRcuErSlFJfxUgQMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZTcPfZg9JNCG++IbB2kZMO3TdPMG/uSglXd5OWyVVI=;
 b=SNAEcCe/I5X1Xpl+5W/nGnNbqnF4ZCc9R2PwBAsQg8g4pEOITuM6ltEneehOpKPGFY4EB++lTAFfIMOmeUkMadqZWW98X6uv2za1RmPTufSTMykq3Vxjml8gtZZs/AqI2vTptjffuAI86jP/G8E/qRnzNMXMp92sKjjX40cYquMgyvq9tghaIzYmdqehok0QqVfhDQ7n05U0pFXrP0S+vc/AW6aXlqvoQOLTTvCFVdisxU5Klv7eg5kUAwxmzH2WTOUso8/LRK1cGjntDHH2KoKeL5rcIRL4Sw2rN3hbV4BA+zR44JgjBS6fW8YvXAZOjfV7zsIoSyuJzG57VTD1Og==
Received: from MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::6) by
 SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 7 Jul
 2026 17:16:52 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::85) by MW4P221CA0001.outlook.office365.com
 (2603:10b6:303:8b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Tue, 7
 Jul 2026 17:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:16:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 10:16:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Jul 2026 10:16:22 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Jul 2026 10:16:22 -0700
Date: Tue, 7 Jul 2026 10:16:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>
Subject: Re: [PATCH] hw/arm/tegra241-cmdqv: Do not sync GERRORN on VCMDQ
 allocation
Message-ID: <ak00ZY3SSti6z3JL@Asurada-Nvidia>
References: <20260707112450.111178-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260707112450.111178-1-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: d96f88d6-7b70-4013-b645-08dedc4b883d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: uMupEjyRljygKPXXmVGKwE75M4ooZvw74sO1uGcG1cgffRpvoxHH/BW54b4GSMykDMi41VzlDGOBZx0+Kx1NrhCetv4q1ub/JvtnIL/tIrE7LJNSMFdStQXWUwUkNt2qEWpGMH7cZB1TbDJB3YnoLHHQeiqNEtkgWV+32USUwM2K5c6mTAvD/G3pDIN/2NN2QaCZL+SMKtiQ1KUX0ldHwIjEVOMuqc8OpT0mWXim5J50NypC6ts8/lRKZKZ6yKe/Vhe2lLMvE0aNq2R6C5/NaJ4ThiglhWk+nO5zy5iGwsFpw41l1il1LLCue3IVz+BwBsR795EI7ti9ubty5h/RhiIv3Egj1REDxZ7YwIe/v2tSbn0EHCalhNac8KLxt2BoZwEO4s4oh6oC/XjuF4zww0eXVS2cu3wuDiXdRg2zvLwEEwZWvFnOgX05DtwZyDVnzXJoS7KRiCf8uG9CPBGd3y5Z4vcqq+Mu8nSea1s2U6TCOlE9J2jpfFvueIKx4MimMGRvNWpqRMCkSDmozNFl+qomNnXxJkqy1beLgJ9FrZrCJFgPdvWwkjK7/A8pTOW78ivsCOrveCuQ/fsRTnU5fPrgEuGUwo8ttZeNV7Y3JqLBcS2q0k0MGKtm3Nk35w9whyoHBDl3+KQa0j5iehoQmUW5b5ivh4l4rOYb9F2T/24FOBDnl55Jw4JYUAtQsmAgmW061In+Cl7OMxi4ZsJQGA==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K9pvX8U+cYd3g+HRhZKQ/Saa1IGIHDdd5FSeVlgyCZn64Aqy9LKOwjTtLdEnQnBQw3hKFWhn6iPQ0xLcfDS8l1SdHLc6eGGa6dtttaLeq+Yr8/jT0TmhU9iEHtiTJET/TbWzpdlKFgusHnptjW0ZqoGA1nczysYjxeCDzl+VM25L/2DVACGvbF3cF6ZFhed2Foyo3Hq9yKtLMrxiz06N61eGdZI8r2nnYIevK+hneCG7b9xd8jZLt/2rbJeQIB4n6iPrLVgsC3sWzt58ov7KaiNSNJFRkwC+cdwi9BzxyoGD/UI+MhfdjxqhvIKnjPsN4q3tzEk6pV/e24l+ooUamt5lQJ1+zcf8uRtCOrEniYGDOAhvdEUzRMgaZELoyIuYYbs3/CAry3RoyMN2br404pyW7yiBgDEeEIUZELEbMBkXAdNcFsCwmJZtJxpuq9gC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:16:49.8575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96f88d6-7b70-4013-b645-08dedc4b883d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jul 07, 2026 at 12:24:50PM +0100, Shameer Kolothum wrote:
> When a guest hits a command error, the hardware sets GERROR and the guest
> acknowledges it by writing GERRORN to match. These registers use toggle
> semantics, and since GERROR is read-only, both GERROR and GERRORN may
> remain set after an error has been handled. As long as they stay equal
> there is no pending error, so a subsequent VM is unaffected.
> 
> When a new VM starts, QEMU allocates the hardware VCMDQ and flushes its
> cached GERRORN of zero, while the hardware may still have both GERROR and
> GERRORN set from an error the previous guest acknowledged. This makes them
> differ again, so the hardware sees a pending error and stall the VCMDQ,
> leading to CMD_SYNC timeouts.
> 
> Do not sync GERRORN when allocating a hardware VCMDQ.
> 
> Fixes: 1d0f77535417 ("hw/arm/tegra241-cmdqv: Route allocated VCMDQ Page0 accesses to the mmap'd host VINTF page0")
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>

