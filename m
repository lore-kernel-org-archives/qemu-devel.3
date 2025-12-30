Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DEAEE4997
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 17:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vadvR-0002E2-US; Tue, 30 Dec 2025 12:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vadvP-0002C1-LF; Tue, 30 Dec 2025 12:54:27 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vadvN-0000T4-Oz; Tue, 30 Dec 2025 12:54:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mz3WN2ickbFoSdSnwZ9lEsr0UmrFxIEBDPnINvg2hHY0up7qc5LJB1S7xzvqMXzx2K9wLj3UsIaPrQyOPlnlZTU0xnmY9B8c8QRRxm1c6a77XsrENy8hZjVB4t+nFA38u9IiX0Bam/9hHe9IWV2GNw9XfzTLFp1qqODqGKK9Cl6jUZxbDeRh+Yd73XF/lXBHuJaXMU8Kmn4ts0O24rQsO+z9rS22Yc6xnhsiPFtDGQImBvKPJCbNtcqThmxvcNyQKEKaBTIVcOzJp8PXg/UZu55w4jcp4/WS4KGut0pcnqLi5bjVdCS60pyp+2I24SOBW5l5S6rDdGJzzZItBt/nNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHbgccQ+1x66UlL3qNVRHrzeY0XvKWW10USwMG6RYcQ=;
 b=g6Xj6YKBr3prWf/27YOxDEYcfZx71lG38nOKaN7YRZ+xuWZ+mMIkdQBMYPqKfGUmiIiSODTdE6pasMro4uE6dNSL6vrOc3WF+qtPLibHtpOJtkbpeqe548Ky+1NIGrIPYG6Ui7a+zLLeIqBwl+uE67x34WtvfZeyJLwwIsYZzo5Ni8uT2yXn4CKnLN/v7uGcKgYI4MGUWBIaFXjN4quNqT4zuBis9K3xzh22GyAyjGNDtBh2M/gfIXH7xHCzqyeUf3Bo4JOUd0pvD3qsFSrTHU0w1A+vMluqpHnYJMERw+Dfc9CIuRvjHOy6+UunoAIV84kSpA0Ij/+uYoht11rEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHbgccQ+1x66UlL3qNVRHrzeY0XvKWW10USwMG6RYcQ=;
 b=Nl68vEVr8a18Zg/VvgJ88IkrBcF2R7XnipNryYZJNB98I/xdED508jErJVqfT8dN7W/+NWquoLZ8XSz5K/xjo+4ifSp1c707Vw0oVfknG7ke42ZmaP+PFccxMgbkTCJF6TV1Bup7mg6XRtr/U/ECj/2i7FzU4TTDK/Wzh6LWTT2UqzztQdikve/er+S9f8UExGAlWyEwS2k+BVAENsunqq9PMPRNqDx80W5a67EERBCduGBI8TuI2Phs7PfDuRm/vYlPLtKx83hSHB6eTLIZMu8Pv2Mm4UMm9glRDdaGt78QxvvvVxtGxTOmEQ+otY84vNOVZ8IOIYS7SLx5/0vjQw==
Received: from SN7PR04CA0228.namprd04.prod.outlook.com (2603:10b6:806:127::23)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 17:54:13 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::3e) by SN7PR04CA0228.outlook.office365.com
 (2603:10b6:806:127::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Tue,
 30 Dec 2025 17:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 17:54:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 09:54:04 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 30 Dec 2025 09:54:04 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 30 Dec 2025 09:54:03 -0800
Date: Tue, 30 Dec 2025 09:54:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate vEVENTQ object
Message-ID: <aVQRuUkeBroWIAHU@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-11-skolothumtho@nvidia.com>
 <aVLbS6g+Sd6vfaFc@Asurada-Nvidia>
 <CH3PR12MB754807EAC29B50A82B3B84E3ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB754807EAC29B50A82B3B84E3ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c11bd77-8677-4743-4c83-08de47cc70bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2cww/vudZYUsuaiI9sdmhWl40m/AHs4hfsvg+vhGeWCniLU5ctzs08/ZB2cb?=
 =?us-ascii?Q?tfITt0at3sEIWd9GEDuZOMqzT4xoUOBecTQB/vd536PWNltQaSLsgD2v39at?=
 =?us-ascii?Q?D9UFV+uka+C14Y8rNW/mkI6dfcHDB6IiOGa3HYT9If2WGUDqNlHcAYXcQ0KL?=
 =?us-ascii?Q?WpHxZ7P7ewBUfaLtAugJrw3DwUBpv2H2ayzr5p4Por4Ua4zqPjgbuIiY5C6G?=
 =?us-ascii?Q?PpGggIkD5PftgIzANsmOvlX/7E0DgsCuDmZb8xAu+qi82dCSYrOwG22WgROr?=
 =?us-ascii?Q?ArDtygDua7hbWDRSkhj4r5pXTG6Xa2AE1Tcja8BaRZHTvPyX+QOOVu0TcltE?=
 =?us-ascii?Q?fl95Yh2smoQNehB0A/sTOrpaxuOVBrMWcVpel7+Phps+C/yofPmBNKG19P85?=
 =?us-ascii?Q?YvbtIQ/7ON7TdKT68whEm2++AdE1SzhMSjCuxyyyKuRL4zkuwx+7+TU4zIwb?=
 =?us-ascii?Q?MBX+okx99Idul7Dq3xA5554spvvyL4CovgKfaqcA8VYknnmvtgOwdyA7Jt2s?=
 =?us-ascii?Q?a6JmSUUTcmibO9pJ3dD/YqBeGE0XgqundNmBVg3AtlMurEOQFf6M6IzPLS6H?=
 =?us-ascii?Q?XvKXV0P6OQIh6SGkXAEqWb5ue/Smk+wTFyTvtKjTFkRROm2Q4cqWbX1PEwAx?=
 =?us-ascii?Q?DVq3c416JYKQBvQDGkP9k6N1p+o3edO7U1CKXiXMKRJ27uaaSX6uTBKu4BXZ?=
 =?us-ascii?Q?3c4ViG2y3OQk9dDxeTDy+zgTtTBqbUUo6LNkJGyZqmBxGuJO6+KEMBVNbOMg?=
 =?us-ascii?Q?HHZXkaaZjI00LVWJ6cwEklvdJ88NrbAa0sScceZDB1qTDUHPZqy60MsBipS/?=
 =?us-ascii?Q?hwG7t2OdSOCBDRmusDn04XOzLwv+3S1ORrT4bicSTuWgmJTHxmERb1N/S6lG?=
 =?us-ascii?Q?GY0XLakAEc0jHYuKY8x7hS0D1efFjeVQn7OLMrHQ/9g2PN4lG73MTCPUBzFt?=
 =?us-ascii?Q?7QsJYkTTu5QAmblaF7Qw/VEYjJcFszqQI4M6acXEGX+XGWFpTtEozIOvyRvH?=
 =?us-ascii?Q?dH38XLmlXi4bosuu7rEg6SUdlTvf949OTrxW0Y9RZdUsXet1+8uT/wNOPSha?=
 =?us-ascii?Q?9DnAgkBTUNLUsqasrpdwVRN6pGJLN2Fwy8VNil1CX7ie6lF5rHeRbHYtBqi3?=
 =?us-ascii?Q?xbJMXc8yf/2sWgEyO5aCwIuW4C9QENpUQ6lBOMuGaJBYFyD/GKxBzUCi65eE?=
 =?us-ascii?Q?qhp43tjuj8/ptqF8cxmMK5zPSE3thCzgd7dCth1qWV4TWnh1nd6QEKeHtL/X?=
 =?us-ascii?Q?NAUcxnTDYGjaj2/pjmuwsZircXVECFaaub4Fwe5gy8JIMCUqj2No1HERzi6k?=
 =?us-ascii?Q?WWI77n+nWzrQ7/HcNC7iZwEWkoeXSSF/eRkB8qg9xDgJdzc3K9VuadVBuQbM?=
 =?us-ascii?Q?EqbWVZNv96BNAkKSJkRF5hDwCkkLrKt7+WzgwXP0PEIa43SwqOvEgrwtDD/C?=
 =?us-ascii?Q?pXZcHZyKvZsqsCHG7SgwOk9sLvRRE8jDOTcje5vlk86sr4XnG1GPZ9gRbg0U?=
 =?us-ascii?Q?uBNO/Q/M9nIakyebpLmy9ELFLVw4/vndBb5fuPXMlYf4OBQk9ARck3RE7TiU?=
 =?us-ascii?Q?SR3YX9s57W7W1HOC5Cs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 17:54:12.2235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c11bd77-8677-4743-4c83-08de47cc70bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

On Tue, Dec 30, 2025 at 01:47:08AM -0800, Shameer Kolothum wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: 29 December 2025 19:50
> > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> > <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>
> > Subject: Re: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate vEVENTQ
> > object
> > 
> > On Wed, Dec 10, 2025 at 01:37:31PM +0000, Shameer Kolothum wrote:
> > > @@ -259,11 +305,16 @@ static bool
> > tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
> > >          g_free(vcmdq);
> > >      }
> > >
> > > +    if (!tegra241_cmdqv_alloc_veventq(cmdqv, errp)) {
> > > +        return false;
> > > +    }
> > > +
> > 
> > I think this should be called in tegra241_cmdqv_alloc_viommu().
> 
> Should/Can we? _alloc_viommu() will happen before the Guest boot.

I think we can. vEVENTQ only needs vIOMMU ID. It's per VINTF v.s.
per VCMDQ (HW_QUEUE). So, it should follow vIOMMU.

Basically, we can allocate vIOMMU (VINTF) and its vEVENTQ even if
the VINTF doesn't contain any LVCMDQs, which are allocated/mapped
to the VINTF later via HW_QUEUE allocations.

> Unlike the SMMUv3 vEVENTQ for accel case, we restrict the hotplug
> use case when the tegra214-cmdqv is set. And as soon as Guest setup vCMDQ
> the vEVENTQ is enabled here. Do you see any issues with this approach?

Once guest OS is booting, !tegra241_cmdqv_alloc_veventq will fail
tegra241_cmdqv_setup_vcmdq while it cannot break the guest OS any
more. Then, the whole thing wouldn't work although guest OS runs?

Nicolin

