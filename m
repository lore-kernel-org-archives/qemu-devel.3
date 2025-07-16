Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B0BC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6im-0007T3-MR; Wed, 16 Jul 2025 14:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc6hI-0006Sy-36; Wed, 16 Jul 2025 14:17:40 -0400
Received: from mail-dm6nam12on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2417::616]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc6hF-0000RT-HG; Wed, 16 Jul 2025 14:17:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4iJH1FTyFy/aT1+golGwC8mw7TIAbDJkLH20cTuTeLDBk5x9QCkjjW1OrTeGyeRXXM3YX7iVkt3ZKfYKzE/sBpjtxp1c28pBjvlq2DHIG2X5c6OHNsFS24xIxuTpPf6ExIaO3QEfmX0J3cDdtyLNqnQ9GfowFkqkc7bEuuR4EMhPIwYLS80YHahe7YPTcp+gnvTLo6nXbQ7T0fObUu+opfAcMM+4K8dlMhdymfL3B6bVqecnZXE7Fhs37pFGDp9DlDaxM39yyPqSwkKajxrZI3AoM47Pmo9EfIe5i5UxOGGS/0DgQz+skzbEnW9ToWqlrIoOitdBHJYBgpM0SI7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLTRvHrVtGrPmJ/Mn/d4VqcnwHPhd8ANUUHSL6bzl/A=;
 b=fEhOBinZopwqRwB6fk8ggwstbZp5aUDkvgUEVRU2z48rNyNw+Nr3xArtSHU+2ZJ5o98PDrNTh1SGGtPKbmGaJ6iTaTNYVtpKyUVrRS8xgKYddgYAWLqqAYm08qL4RpmNT4FgSmxw2DCjErmqsbS3mclwfAT5WIPTHiWnoMGzmNqErhdEtitgAsjvoK4FeZqas9gr9/HnrEGzDSRo1xvmwBrAS05UxdCoboID5RR699oQtBl8jJt6yqbCdZCbrnQkAzu03uFZn2jvEOeaPP49jK37uJMAOSBK4aW0JSi+JNK4118Lr5etuabUhf14e5d8PhARrQBil8OMv80KJ8iB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLTRvHrVtGrPmJ/Mn/d4VqcnwHPhd8ANUUHSL6bzl/A=;
 b=sZ9rUkmJVyU3k4mlCIm9nq8DhYmzpOmzq9ij/gdekXQs49uWMBsB6ChmzX0gaxUrUWPZaU4A/+lxci7zfvaFOehtRuvP9bTFTdzAkvIseRBFw+M8z9aSww4ihBlUNW6bndxImr2AhupIJH+Cj8p0/guHJOW1LtVh2MCQehcSQoU0UhiSkwHOy4B9IpgDIVOsZQA1JX6aNCXZUG6q74QB1I+i1N9LfV/ulhLVy19UWZA5u6LnqD2h2I7zmmPaEg/RH82FmBfuPCFkqI+SGMKfY0k6ZczrUees2fYOzN+s/igxQ3QTBqzcShtJF16kjnWk5MQ6RqEEhrBncO/iRlDABQ==
Received: from MW4PR02CA0014.namprd02.prod.outlook.com (2603:10b6:303:16d::29)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 16 Jul
 2025 18:17:29 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::98) by MW4PR02CA0014.outlook.office365.com
 (2603:10b6:303:16d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 18:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 18:17:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 11:17:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 11:17:08 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 11:17:08 -0700
Date: Wed, 16 Jul 2025 11:17:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 09/15] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Message-ID: <aHfsouiDfi7ldyeU@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-10-shameerali.kolothum.thodi@huawei.com>
 <aHbgc8LXuuuJ/cz0@Asurada-Nvidia>
 <6110ab250e844af9982dddb230fb8707@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6110ab250e844af9982dddb230fb8707@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 334e9a42-f5d9-4588-86e3-08ddc49504fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K8Ne2Z00HqaXJ8GKC2ceqxJUdO8v39jSKsLvUsDruYolV7YGwE8GptW1g+DC?=
 =?us-ascii?Q?B4QrRFjJqisd50GhSnFmnyE2Mo/rOY35GgBLUhQN52syCA3ojgdzDgr7L5zg?=
 =?us-ascii?Q?Tf/K4MprWXLHY1AB+5vTePGt2y0e4EabQyT0LhSgmqjF0CUz8vw5G+5weFCp?=
 =?us-ascii?Q?QJgV2nEHh6GcuAwhl25qh6wIig0SRJauC5lzWV5Xhgj05U9XnWxZHoXK0Ht7?=
 =?us-ascii?Q?7Xd8mJpCUlbXzXXPfGl/xDWcs2biz/+N/6sHMT6MqlrOH7Qel7gJEFQ2bKGN?=
 =?us-ascii?Q?UeuvraoCIHPvjJJFguPTHyOEYX0bI8KWI20yqPHUVa1W8jwLzHKSfwEfsYvP?=
 =?us-ascii?Q?ajjfJQK/t2EKkOgxpQO12ox0dd6rbtmMTNXe5AXzrs/O62U7AvYOJXYp+ENz?=
 =?us-ascii?Q?lZmkJxT1AXXUE6/Tu1WfUmODV6SspCI1PwLvG+XWbKVHs+4t/ciVHsioBGKu?=
 =?us-ascii?Q?zsNcooMb03hw4FXFtJ/vN9u9wkvY5xc9VLudDit84oPo8I0vA9fiIajIRaw1?=
 =?us-ascii?Q?EpY/AIoITSxf97ZPem0JNGYpuSPR0tC7cksHf/lfjtrhSrDCccXFNKYqIsR0?=
 =?us-ascii?Q?fuK3y5hWU3dbE1yBRmvy/mHXTMpG3Qtl4cnlKt/Kc/782BjxMDpeQlONHPwp?=
 =?us-ascii?Q?9lEzcMhLbAxmC1nEmpGgC1fQrf3T/cTreIeuEyyiRsQQOMQKlRpuEKXebysU?=
 =?us-ascii?Q?yCxuZfs0VK4DZ8aJN4lGFCk4znqtWskynwzaPHk+08wPT8YA3TkmmGS9yEn0?=
 =?us-ascii?Q?yBVtdbxCG3rd6O2moWQwSJIsTdEp5iuidldpFXvbiGDgoUK1+37LPbwKD5o9?=
 =?us-ascii?Q?zdn9vzyaD0YTDNVjr09hr3SKbegh1S47lFtZquDsT8cOpfUQUiKse8WqLf3D?=
 =?us-ascii?Q?Bj8mH9LgspB7Dx4eO7/67+K7kzH5kwNb/xp6MGfNsgReEFMrP1fPm7Aw4teL?=
 =?us-ascii?Q?C4u+jq0Q3ZxJDq4f/COz0TZcpIPHRQj84NgLmXXYDT10OBnhqDH0MYlQtiEU?=
 =?us-ascii?Q?aB9Kw1pQ6ZNd5+Rxo8wxafniaB+DpGHW9Ylk8sTCDn0+LiMNym+YLdqkKF4D?=
 =?us-ascii?Q?RYNAhjUMjVyrPsmXY2dXx82VHqE/rvY1pnZRX8kTXZYHFwf+PhH95YlCfqlu?=
 =?us-ascii?Q?jh62AGp02W95dzXPdR7wbbvjFy4RlfzjR7peQ5DQSQCLfNMIW9GeyjjNyEAk?=
 =?us-ascii?Q?IhRpz4p9dohLbBC5ZOg+9vO8eIH0NIf9jxtSfxWzXEWX7AWY1pDzhMmbikU6?=
 =?us-ascii?Q?JKAJhzbcjq+aCDNmbJWAIWAvnTRiXi0d2iGP/RJhDJ4TX8exzgo7e82hlY9R?=
 =?us-ascii?Q?JdL1/qwzPqTSjRXNzbpbuTbJ7QfuKNbi1S5W9i0PgPGYuiKLBHWqFgi3oex5?=
 =?us-ascii?Q?fkbW92BO/e8m7M6Rd5S+hsu3KKeoVQD9OSelem7kTTrGSXWf9KoJClaTtxgG?=
 =?us-ascii?Q?afiP24h5CCj8wR0apxxOhiOIA/cUQjFnvaM/ZZomP4MSpU6duhtItZQ6bS5A?=
 =?us-ascii?Q?nrMJJUJ8HZmGVGMEs1OcdBbI93DOGtV0RJwR?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:17:26.8030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334e9a42-f5d9-4588-86e3-08ddc49504fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
Received-SPF: permerror client-ip=2a01:111:f403:2417::616;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 08:36:38AM +0000, Shameerali Kolothum Thodi wrote:
> > > +    g_hash_table_foreach(bs->configs, smmuv3_accel_ste_range, range);
> > 
> > This will not work correctly?
> > 
> > The bs->configs is a cache that gets an entry inserted to when a
> > config is fetched via smmuv3_get_config(), which gets invoked by
> > smmuv3_notify_iova() and smmuv3_translate() only.
> > 
> > But CMDQ_OP_CFGI_ALL can actually happen very early, e.g. Linux
> > driver does that in the probe() right after SMMU CMDQ is enabled,
> > at which point neither smmuv3_notify_iova nor smmuv3_translate
> > could ever get invoked, meaning that the g_hash_table is empty.
> > 
> > Without the acceleration, this foreach works because vSMMU does
> > not need to do anything since the cache is indeed empty.
> > 
> > But, with accel, it must call smmuv3_accel_install_nested_ste().
> 
> Ok. The only place I can see CMDQ_OP_CFGI_ALL get invoked by Linux
> kernel is during arm_smmu_device_reset() and that is to clear all.
> But I am not sure we will have any valid STEs at that time. Just curious,
> are you seeing any issues with this at the moment?

I recall that (not for this series) I hit some issue with a guest
having "iommu.passthrough=y" string in its bootcmd. The guest OS
initialized all SIDs to a Config.Bypass mode accordingly. But that
was not handled correctly by QEMU so the host was not getting any
request to program a stage-1 bypass STE to the HW.

So, I think there would be a similar issue here.

Nicolin

