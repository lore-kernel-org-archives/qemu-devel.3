Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F5CCF885D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMBdt-0001kr-Ld; Thu, 20 Nov 2025 15:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBdr-0001j0-TO; Thu, 20 Nov 2025 15:52:35 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBdq-0001MU-Mq; Thu, 20 Nov 2025 15:52:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efWICyUqFnd3VwOCVSJWFI9mpGo0JdJhMJb2TYbBK5958pQ2Nqbv/Y5iiYOdVBRqPSVOrl9oPWWgXK75+20yspYh7JoeNpHn77ky376oBsBUF5OyHIAHyL9KzF2sPVG55CNTFhDBSf6P6T0sToUbc6mV4tjxHHYqRLVFDI9JX8vYlheGOyp1ez/GIquDOvxwKNAOqssWj9xdscEK+qTW8AIkzQs6ihpmgf4e0l0O3dTS4/hidNOy9BTMvccDXLSRjFKc5+STXP4SQc8cOx5O68qufVhwhQGp5B/RY2Rcn7Fd9EQV8VVirM76xEtt+eoEzvw6VVPraPNmM01RvXOgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvyuYDC1HcVQjcJp3wCb3X6Fox2m6b/TpICLDQXt7RQ=;
 b=t99M79GBk8dAcTBKED3NfWgnr19xqdE625AV3EYyn2i8hVrDEsRazPdFJ0/829wJJ/Yhlq83mGUVf2Hlqb9PpQGP30r1jg2Rmxm3/T738R+eFhiFGUjFbBg4JaCO+FH/NlnBzhUq49AoEAe7WdGJZ+L49IEuPIPaOI/P4IEmf70hJlXwmhRC2XRxPdg6/3g5gAxTzLxKXCX1i3YrrqQqXNuXUmYrf6maYnZrkNFJFR5/zawsJ8J32RyckzHXZUz+uNoeplfC4qztElEMXFuaUYG18Awop+ziVDGMdolytY+7JT+E8r+7wkXYbbgxNr6mkHj+DaHmgV7RIg7Pot7pHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvyuYDC1HcVQjcJp3wCb3X6Fox2m6b/TpICLDQXt7RQ=;
 b=lrhBGT/hAjfjDJM07nhVEyBbOSGQLmaSZ1x00YLFG5/vNkXjZv7CFvzspJa7aZ6IS0EGicUtE3s0SZfMIrGuFr+6FwCsVVH4VVRZzEEDJ+2mH0m1HDYsRr635qKLFkScS4dMhcs2o3A5yKDBMAk9BJHB3hn2GxcQkF9D2RDRJOW1bbF5M1ri1S+9Arrw1qxrm0sUNOvTXLQrVqYXnIpkmc/ZqDBoC3jx2shwXbzEMH1i4uo8uah5xA5QB6G/IF8mhYXJA9qheIm8Km9D/SzkzzvYjz3UVA6NsfW8sB36DD8Hx18mfgItCxWxDfNSpKDctebvEXu5j9wgFBf0Hyp3Kg==
Received: from CH2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:5a::13)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 20:52:27 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::52) by CH2PR08CA0003.outlook.office365.com
 (2603:10b6:610:5a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Thu,
 20 Nov 2025 20:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 20:52:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 12:52:05 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 12:52:04 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 12:52:03 -0800
Date: Thu, 20 Nov 2025 12:52:02 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 09/33] hw/pci-bridge/pci_expander_bridge: Move
 TYPE_PXB_PCIE_DEV to header
Message-ID: <aR9/cnKoKVjgPNSJ@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-10-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-10-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b25424-08fb-4af3-7983-08de2876b70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fOZ0XTTgDmAwW6no2wCs43huVPV+IO0OKo7WcUO6EA/rqbvc8Gq184Wz1rJW?=
 =?us-ascii?Q?D29Yvc/uX64dbK0PJn4UYBVuKDEDr88ohUQzzUtt5hmNH8e8/3NCbbodSuF8?=
 =?us-ascii?Q?8qZI84SneI3CHEgnI2MdWhz8CGUMMPR2q2KSlsJ91DA4prPZB40iPzogV/HE?=
 =?us-ascii?Q?mLhQr4Uy5Gi9+rBww4t8MHC3c5byWd7h7yzuePrqtvK4ekqM84v8JQ3K6+g7?=
 =?us-ascii?Q?MBrd8rUu3VfvOF30LnuLJNIg8y3Rn5LWfIt6YagFSw+TrOGp3oaIZdF4Gq+K?=
 =?us-ascii?Q?1EK8Kq2zyv03tomNymjj7Vh6ALeUayj5EFPKLzamIP1hqMK0S+K4bbRoce1b?=
 =?us-ascii?Q?EIciXMMZ9ucKxmJYPUCH72cmUil1XepHDKkeSaBahqTSZg/vXFR9skhew3TI?=
 =?us-ascii?Q?lLjk2VB8J/TeKsMMymOc5xL7LnFgwUMj9WA6FGVHca3LjTQZZl1DNyyhnTfj?=
 =?us-ascii?Q?wfzVwmKImr+3XLvm2s3ND6K2sshBSoNsJx4xyhygDkwKzpUuQQ5tjH2akiiw?=
 =?us-ascii?Q?gU1Lxjw4PBUZwEriMyEitg6BrGM6mIDBXtKQo1vr+4x6FYWSj0V3B5Sqvrhe?=
 =?us-ascii?Q?j/YQF6OpH4m/V+5woo3ekXdJ5lVc8kEYd78FY9kDfTgvpKoJvWmyTFpY5SMb?=
 =?us-ascii?Q?VCPUUoUsW7ZyimKBbQfHkyFghgibjXJNGPqmNX09AzdCNwMHaklEQIjd9snl?=
 =?us-ascii?Q?bSHERPG+cGLTBKdvhx91BM4WD7aF/8sfcKicce0H4Sx4Hv1+f7O9zONh7cac?=
 =?us-ascii?Q?zC0Rri7u2G78rvd/4D5e8O651qRIDCU/M7qoEaqoG1WeW8bWYrxr+usd6ti0?=
 =?us-ascii?Q?qgLyNXS99p2/6wcAH8rhUk6S6Jty3DPs13kiDw4z5UI2D9tc/hdORhyIotXA?=
 =?us-ascii?Q?FULdgCFemO+sovGYldUTdpeyayBdnXvvn2ewIwK47NaF60Dayscl5U2+S908?=
 =?us-ascii?Q?0Or3/wt7y+di0tmtsywfacM9k7yKXtlR65OGKucXyZu9h9gZpN2wXhNHk5tX?=
 =?us-ascii?Q?j8A5R9G6hB3TdSOyHoSY4SXTam/cG5tHvb0VkvwjjYzw/nbNZMRGbvzQ7x31?=
 =?us-ascii?Q?p3ocJB+SeiYIV3WIu4gqlxjUhPJiE1LTmFEh7ZHBOMCnYnVYp6KahfXXXwuR?=
 =?us-ascii?Q?/UEXuYJ8ntJaYsQxDPJ7xzTpfEjbxUoMf1t31tyvLzxBvMC12yAj80qNnfUh?=
 =?us-ascii?Q?zAl3d9aTFIt9lXQ/SvOX6hWPdgXf6z2Wp43BeYXbL3yodwhKqPNX+r6819Gg?=
 =?us-ascii?Q?+np4ZYb/U/ZZaL7MnYxhoF88Jv8G3RkCAMDiaYROy3vQpL0Z9mQ5lzaELQ65?=
 =?us-ascii?Q?RW2soUqAarBj0uf2ZBqYmGm0WVxR5FEcn0TYuE7+0Xzo8Mz9CDtM8BWqbJr8?=
 =?us-ascii?Q?9/CGDiOhg/yvZP5LmQMX1cmVNu2t2Ve9Qxoa3wMms3EORa0m4IDBy4AYDXGW?=
 =?us-ascii?Q?1o1+LaQbK3HMFJMDw4CxsyxL02bCCWSzB2X8wEn7yaB/4nX89fFGTKHd4ePl?=
 =?us-ascii?Q?6F/YZzL8G7zyvCPPxgZUDUwkbr4TUJhQzFuP5p52uxcvuav1tS8E0jEAaAwo?=
 =?us-ascii?Q?McqofydPv8AIvzBDpvg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 20:52:27.3921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b25424-08fb-4af3-7983-08de2876b70b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Thu, Nov 20, 2025 at 01:21:49PM +0000, Shameer Kolothum wrote:
> Move the TYPE_PXB_PCIE_DEV definition to header so that it can be
> referenced by other code in subsequent patch.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

