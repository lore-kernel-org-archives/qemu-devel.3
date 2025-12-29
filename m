Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0B4E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIAk-0008Ju-A5; Mon, 29 Dec 2025 13:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaIA7-0008BT-SO; Mon, 29 Dec 2025 13:40:15 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaIA2-0005Fw-C0; Mon, 29 Dec 2025 13:40:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB48Fdq4muT6tHPbwD0H4Ylaw48qQgle1hUfRK1ChDfI23DTu063JyOnXlqhNQTw2iTT9mMIxzaJeRQnDBUSeZsaB7sxG1AU4Kj7FAfpFfMbo4HRMTHSJHg83rbqr8uUbuxxBA1xIUkFd84hTKTUSioVbHlHxqT5FR68FfObl6o7YDT98iGAeON++z0GAR7Ett7mdND9r9CtuKg13TtRWAhXVbFhe5vEZ8HyvqAYBdelYM+T5SB+s8z8DEQJtoB0xd4FQJ/w9K87ohRqlxJ8GhOPhWDKRamH6j7guGW2u/GAGQ/ZP/fPDJvUxC/XrExqxgxWEm2Iu54/xCJX8Mhvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPQEX4VmnvNrrGNYFzkE+5O3gILWdcyC6KXSY+aoeRE=;
 b=gnv+x291YdPK8D7tDPSNWNSL7YDmb59vn3+n26HiwWA01jIeVaiWQf45a6zMB+uAs2pjucw5hy3O3f/qV2iY5q6idCW7DZxaTWlISZHcIEjzVo6HmWXZxYJEn2dPFulwlm5wVyy5YROX+WtoH7NEPnnwQQ0Z3l1u9WPd8+kdwGRzvTGQoMWvJZTp91V8+1836eYe1Kg0e+NaiDM6klaZMK5mLpMazNLr2/TFSvwdAuY0qfoHPeQRQ52IlgOUik2cc4gl7xvCwNc4G7JXK8Rn4QWjcjITu6AHQze7HA72TZcSUraBgokAH5Lt03JD/qakBWkqQJYLi9TBJeWFH9SV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPQEX4VmnvNrrGNYFzkE+5O3gILWdcyC6KXSY+aoeRE=;
 b=AWdatSfUGM2rgtTwtybYcQIkS62tmlaCCMhNWlJoA/BiCkuDJw0WrEfd0qT0E4VEsFv30Hh9u2qNgp/Ake9J+h5K5NqVxgX5JdT8H4ftcq3BitdvxeC+9vpWlNqgntkw6JyRCFNklHjdOQatPdVeryWt+wBHoyMro7QjKl7yHr3OhW1FTZ/XoKedKj0S9Fxtr2nJrcAzJmnZzeP+j5xcnFVHAS4uWMpxQTKGBkei8DSErjsPTj7bN606/TgZCa/rKKcnW3mNv99UoMLrO199O1RjSNnZVz/1n1K+OtVUhazh3X6juQiOjJgQ72zj43DfDtEQ+v7VmuVy8IC7QUD4wQ==
Received: from CH2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:610:5a::26)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 18:39:48 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::69) by CH2PR08CA0016.outlook.office365.com
 (2603:10b6:610:5a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 18:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 18:39:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 10:39:38 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 10:39:37 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 10:39:37 -0800
Date: Mon, 29 Dec 2025 10:39:36 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 01/16] backends/iommufd: Update
 iommufd_backend_get_device_info
Message-ID: <aVLK6O7ZJEImtpjZ@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-2-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210133737.78257-2-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd58753-04bb-4d1e-451f-08de4709a4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8y55kBaJAz9kn08z0biFdG7sQAJiRSBBs8nP+tRBcDC04o7fJrF+E4ei09t+?=
 =?us-ascii?Q?l7uKzTjhh1RWeuWkyKsJqLwoCP6K4p3GQtfL5sP68K7E8ry1hy015d9KTJDR?=
 =?us-ascii?Q?YECpCQPwef0mH0TKJoY8mgv9kMf9WS+98kkf/k/Y1V/9uo/74fQ882LybZVP?=
 =?us-ascii?Q?RWdpMuMbHIXBhdWAT/QfUfEX4D2ws6c1QRPUkSJp+farFjqAbRYOTu0kA8Ii?=
 =?us-ascii?Q?DST1cDJAXnvXIk8UbnINqPkcaSl/8GXmMqbSrZTpLtK08z7ON46p6UBJOBc5?=
 =?us-ascii?Q?IFUnhQkbJGfRvJLhA/AZCfY8NAeBF+SW6/p8VunineGoVxE3Crv4cxa0i6Gc?=
 =?us-ascii?Q?OcgxHJjKXhW5tNdMu7Z5ByyQ7xC/g81J5v6/bT5c/kHVT+SioqlUzgasaT0k?=
 =?us-ascii?Q?irp1be9O2GUq3k3kEvRlRYvSivPEOVXg1H7lOHmMCSLif5UnLSwvEUhhHdDf?=
 =?us-ascii?Q?uxdncJebYZPnFnls+gX9MDrjlaGxAaPNWryB93VihcgXz6Tyy8YBoqhzeh5u?=
 =?us-ascii?Q?Fnv7EVuY6jto1mZUW+N2conrODGztkax9k8/cCyI2StLn+IeDri06RXPgVg6?=
 =?us-ascii?Q?6W1t7g2qx+8IDfoFDH6swrptzqkMKXmxNgRfveDxO2+wnD9VbB2oFXtyVKSA?=
 =?us-ascii?Q?9Paz2RH1FcvQEdR2dYbnMczu8gR5PHzJVpv2cXFY5z9Z45udTHc4VRR/ycRP?=
 =?us-ascii?Q?RCCoHBaNOyPKaF8M3Qb51HRZ/nwOUMXKpnedhey/72a99e7X6m15MbDxJlr1?=
 =?us-ascii?Q?hJD5Ucavi63G2BekdQiCcQPdzn9904o1ku4RYDCLiA2hWQ1h9C63VH5K8vVc?=
 =?us-ascii?Q?DrgUfmcXmIaX9KYGQKGpYil/T8i5WgwRVVw1mE0gy6XVqil+3ANQqPhRqATA?=
 =?us-ascii?Q?J+vQsnE3zpL8ymkXf7opEoWaEkIBFU+yMcQxvjhqmkU7KlrolPMdKHMqW6GR?=
 =?us-ascii?Q?BcMJ4EjcSa7iRaZduuH9AoitcjmbN3bbOVmt7mSCVDFmjc8ADh9eSjcYz/kp?=
 =?us-ascii?Q?/u3soQWk09YBlZpRii+6BhNqxRVQwSgBFZGesPIrBCSbuvxIP8b31qTwC1D2?=
 =?us-ascii?Q?FqQNgZEv9y4WYvJAmW/iU/METkHqGgAhST3rpzxVlaSLU7ugV3oJauPO+QwZ?=
 =?us-ascii?Q?psL9PI+Uzzf+Fwi61HHelO8shqaVh/cahn9YEaN3dnQDdmsKufC5MeqjtXej?=
 =?us-ascii?Q?MF3UPaTlwBayJpvYm8Y6EPbZgvQW/mPuYrtHo/qj6amy1+HLQfdLwkXJhpkD?=
 =?us-ascii?Q?6UZNXDB9x747d/QyuN/Y80Wytb3NTWs662/yRkPV1q55rIIjZe17VkgccUFu?=
 =?us-ascii?Q?rSRC+np2CworQoQNmxt4qapZDxy5MWNnxmT3gTQ9XZU5YThtzfvvyuLYOhm2?=
 =?us-ascii?Q?OaMEvcnkfuhItjhxoqRwccjHjzh0dhHzChALFgfWRZvg+pvTXDF5gARRhNbL?=
 =?us-ascii?Q?pe7c7Gr2cslpz7xptyoNQj8ld1+NiZeTztxLZvfDDWOmJP2Ug+1oLBccwzQk?=
 =?us-ascii?Q?/wLnB/2GG5nfSTeO/qYlFRQ7OZfsZbzyX2b34kL9GkDugOfVHouCwIFWnCoD?=
 =?us-ascii?Q?FJt7CHHAQDCkFcvRVjU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 18:39:47.9009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd58753-04bb-4d1e-451f-08de4709a4ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nicolinc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

On Wed, Dec 10, 2025 at 01:37:22PM +0000, Shameer Kolothum wrote:
> The updated IOMMUFD uAPI introduces the ability for userspace to request
> a specific hardware info data type via IOMMU_GET_HW_INFO. Update
> iommufd_backend_get_device_info() to set IOMMU_HW_INFO_FLAG_INPUT_TYPE
> when a non-zero type is supplied, and adjust all callers to pass an
> explicitly initialised type value.

Let's mention IOMMU_HW_INFO_TYPE_DEFAULT=0 v.s. just "initialized".

> +++ b/hw/vfio/iommufd.c
> @@ -306,7 +306,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
[...]
>      bcontainer->initialized = true;
>  
>  found_container:
> -    vbasedev->cpr.ioas_id = container->ioas_id;
> -
>      ret = ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
>      if (ret) {
>          error_setg_errno(errp, errno, "error getting device info");

I might have missed some details but this seems unrelated?

Nicolin

