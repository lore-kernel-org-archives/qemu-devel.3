Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BE9CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQCG-0004J9-FE; Mon, 27 Oct 2025 12:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vDQCC-0004Io-56; Mon, 27 Oct 2025 12:35:48 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vDQC4-000712-Bj; Mon, 27 Oct 2025 12:35:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyiPvg9M+fpcDUG0HNN3z+E2m0qs38uoNNb5rWc1Y32sYzPeZY+zJZ5DlDHtFU9erGfu+LTFJUPdGpBdY+kglyKZ7JDGf15ldIfmi0GcJJQOcMYl69cqxTtkT/Cj5XqAf6EbpVjliL4VOUGFHyduKZf8HAxXg4pA3miN+FfR0sEVaCEUG1g1q2wxMKNLp2ZuSM1myAF2O7iSWtZLZy2hwrbUNnq8Xhsyl/XIjAa5hKZKDQC8yGYT7rbp0WynyesSNtbPIz7ErZNISXv6azF6O2aUUSy31wR/zQjdpJWElUsWaORpDRJxEdynsvvJS72Kw6cOm2CFOBzZAYP9RZ7Iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSLulAlhd2G5aABWQE/rp5H/8PV+/g4V+Xypdi+/M+0=;
 b=ERKfBcMM/Y7XiFVhhIxZq/CWbWrO8h0dECOeohQjlnXj8yXUP6YzdnCOvnpj0GxIt6y1hvlFr4LJt+imWSdhQmNQ98CoJsLZPL3YrsowQrEntpADu7D56nby697ew3dhi8qufs7U2xE2beAh6WGvmz1KGDrifz5TWWWPS3CEcdaf7nlIUn35xOedqfjv0Au34RDdX9V8j7bzt5QD/efCpSmGRiGRRpIeMtk6LY1GbshtOh4w9M2olV3U0yHY4lHjp70eYax86NDUeHm8fnKI/XMsp/8Neh4T8FfH5FTSD0GWJukJr20F3lbyF/Xe7wx+c0xdETysvfWg56rshL3rvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSLulAlhd2G5aABWQE/rp5H/8PV+/g4V+Xypdi+/M+0=;
 b=B7YHXRNRWPxVxBcCqj3gPuP+5cKpt6kO3wozkFg1ql9uZonSbGH0iEdwhxbz8myX3LtslAEj19QUvDiYE/4NHN+khctQ9Ybhje/KGLkGiX3vtEReAx5/pzAFBOSWBWg274YIQBBK2elR2XIpHuVr/mB4Ray0z56X1AYerwl0MuH3bF3RqEscnRNFae1dqDPmsM1NbNWslM9ikd8PAA2btwJDZBbXi77DhVYI4JIoY7jPa9ntBWHv64pBSzhjCyzgqSpkSDFeq3NFwOmHl53P+p/FJ/qnrC0605Jh4ctVZe8LLaI9vIWteBqUS9AvoQ6LqiT1AFxELu2ndjfZa4dLTA==
Received: from MN0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::33)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 16:35:19 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::13) by MN0P220CA0025.outlook.office365.com
 (2603:10b6:208:52e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Mon,
 27 Oct 2025 16:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 16:35:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 09:35:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 09:35:02 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 09:35:01 -0700
Date: Mon, 27 Oct 2025 09:34:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Message-ID: <aP+fMyVXzA7/0mC2@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-20-skolothumtho@nvidia.com>
 <aPF9l5GwctGN0tqT@Asurada-Nvidia>
 <76ce5b05-98fe-4682-a5ca-2f87b7535f35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <76ce5b05-98fe-4682-a5ca-2f87b7535f35@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: f40850b4-55b9-4af3-7850-08de1576d109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Iq3v87QVI9Zzju3nxOVz+Yd00K0hHHi+0/FRUqnHxwiUu4Scky4Pc3xKloV?=
 =?us-ascii?Q?9sONEhSeCN5G9V73hN2Y/KVUJH6D3vZIjZToN4810O03X+8Kuqd//39uE3t5?=
 =?us-ascii?Q?tR/xSlyMfNQLJCobrxprKdqA+u8aZ/T/u+7bHd2RzuZlL1U9hYSiYjlitJyH?=
 =?us-ascii?Q?zaY6A1OAh2wPnPAvg4Bmy6fyuupGRCgQlSlvrwDjT53SSVHCxA8tXGHzNlNT?=
 =?us-ascii?Q?4PEddriho+367ypAiZdezOUMNZ7Mk7E0r47Ae4AmV6vP+P19e3lYMnTLHgHx?=
 =?us-ascii?Q?ULlnNV6mEzKeQWv9Z5/rHd59MxyvgEXKd3Fui077Exgeu+s+efiKt+3skXog?=
 =?us-ascii?Q?A+Ap3DTYTyEMFUHuGQGllMrqyyGaHZXMXz9yLjglEBfiDLmM5AiZyxffA2QW?=
 =?us-ascii?Q?dqG16GwNi0zIgFbqiEmGw1zeuhevjECcFqsVd8y2LtvAAerDl0SHT9m9JH6z?=
 =?us-ascii?Q?BUZJlsnQmdQtq1vTHhfHNFDOVe/kyVehwvJMBUZZfFNbQ5tMshfhFkMsHf1Y?=
 =?us-ascii?Q?o/nxGn0YZcjXG7zwYlOTd2l6kf6SdsVuKIn0zE2gZtxafWgTykvwgr6+ys7h?=
 =?us-ascii?Q?xxy0vwJpRYwZ1Z0M3A/q5mxhM9mmcfwPo9aBHsB1nwgHyjkQPM2BPSu9SpmB?=
 =?us-ascii?Q?3duiVhf4JTVQH85R7ahcn2ZD2NsBet3IhHArmaTMLfvDuNOlAFQ0O5Tfv+Dm?=
 =?us-ascii?Q?02Z849ugmRG5ZhtqNUlMaDr1PgZopuE0XP4L004reUUL9sepLSb79OZ4C+xf?=
 =?us-ascii?Q?a/3lCiEpAq7n5AEhw0g394nFVVMA/uwCi+2+098dk9YmgPXHODKf4LbEfBDV?=
 =?us-ascii?Q?yB+QeywHHovM28dEG+jKINK5OqDk3ObvPwFL0uYoneALfC9DLWqOh8mNwIbs?=
 =?us-ascii?Q?ALqnzJ7gXIeHt+DBDkzh0epJ04eIeeFq0ZWHfRqO6ifTUeP53vYsMbJLanal?=
 =?us-ascii?Q?6pAI/eYFc/HHYHGTa8OS0jh6QOtSdGZyIcJX/gDgNi/2eUiwhIcwDGhRGynz?=
 =?us-ascii?Q?JNbO/ag8N+JvC0DfPbEI77qSASU8r1uxY/9dt0LErDint4a3smw46dVmfgdu?=
 =?us-ascii?Q?mKhuUqqw5SX0UwtBz/GAqUpEL6Ycd8UfJZyr6gn6w8AFDIRXcUkHU8woH3Bo?=
 =?us-ascii?Q?XHlX3NI/dGluJTi+RQCbSL1ZjgQ+35pza6tR9DI6byPGXJrWXqv+6aeMN5Z7?=
 =?us-ascii?Q?FYISIB9KFSlKijLUAGW9MTxf4XYYKDIiTevev1eF14Fw7rbeKSAp83auidKV?=
 =?us-ascii?Q?aCB/e/wrnbXcfzWN1ZkYOOUdd9/LrXLfjMguUIFfLR+ANEihnH4cK7Q1Q1iG?=
 =?us-ascii?Q?W1ANutnfhhH71yvOXBizSYEX/KMmS/GxaZa0LqzJ6i90mdIzcEyanPRPW+++?=
 =?us-ascii?Q?6uqsPqrbHIErqQuF3AAFEJtXlME9ObqNTJBLu8PrwVuOEM6XTTxJkH8UIGnK?=
 =?us-ascii?Q?no5LfczDQyyF9HpcaUFAPta3hSBsc08u8ozBJpjrkXaweAzdr67RQEXzWlqf?=
 =?us-ascii?Q?yVANgP8XpBfdTW/ypgfc3HHhPE0Jx5yz9i1lmJngm2pa7bN/HK/rGgYO2/XG?=
 =?us-ascii?Q?mFb6Lx3Li9QlFN3U/eM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:35:18.8817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40850b4-55b9-4af3-7850-08de1576d109
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nicolinc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

On Mon, Oct 27, 2025 at 03:26:15PM +0100, Eric Auger wrote:
> On 10/17/25 1:19 AM, Nicolin Chen wrote:
> > On Mon, Sep 29, 2025 at 02:36:35PM +0100, Shameer Kolothum wrote:
> >> When the guest reboots with devices in nested mode (S1 + S2), any QEMU/UEFI
> >> access to those devices can fail because S1 translation is not valid during
> >> the reboot. For example, a passthrough NVMe device may hold GRUB boot info
> >> that UEFI tries to read during the reboot.
> >>
> >> Set S1 to bypass mode during reset to avoid such failures.
> > GBPA is set to bypass on reset so I think it's fine. Yet, maybe the
> > code should check that.
 
> shouldn't we check its actual value before setting bypass?

Yes, you are right. GBPA can be changed by the guest. So:

"maybe" -> "should"

> By the way the spec says is ABORT is set to 0x0:
> "Do not abort incoming transactions. Transactions bypass the SMMU with
> attributes given by other fields in this register."
> 
> Wondering about those attributes and they can apply on the host?

Not at this moment. vSTE only carries:
 * @ste: The first two double words of the user space Stream Table Entry for
 *       the translation. Must be little-endian.
 *       Allowed fields: (Refer to "5.2 Stream Table Entry" in SMMUv3 HW Spec)
 *       - word-0: V, Cfg, S1Fmt, S1ContextPtr, S1CDMax
 *       - word-1: EATS, S1DSS, S1CIR, S1COR, S1CSH, S1STALLD

So, kernel needs to expand the word-1 to support those GBPA fields.
I will send a kernel patch this week.

Thanks
Nicolin

