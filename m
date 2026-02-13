Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AFAEF99E0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 22:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr1g8-0006YH-Dr; Fri, 13 Feb 2026 17:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr1g5-0006XN-0v; Fri, 13 Feb 2026 17:30:22 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr1g2-0000og-8K; Fri, 13 Feb 2026 17:30:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Avk8eMgoooNQbDlCD1mCMmCQ4br0UJ6AM06QzYz1bpoiR+SZwhG7onNuYhNCOz/EMGT1X7awjNtdDBEgkcYK/Am/NAWusX87maaD4vpiVydypjn8FyytzSvX+1ucW1Sk8F/Y/YSi1sJtxYLaMWVHo2SJdzT9PAi6vYLnmyQY54xMviKL3cJRyToOayjnBCtkcalWV65JSylRoEH/7JUGmeJVvT/7Ye9EtkReQqt+xR3TmCJMB3cG1LU/ssSOk3/hQHhBs6O8F9dk+PnaGNPoUlRVdiq5X/mg389pZDWNGs3jkKXby3EP0vk/FHO/XsWLEXrmvcIC9HxTD73CEbOg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H29hpjlVU2shiEOkG+4zVdv1sT68WCnrvVa2UDeXmpE=;
 b=tnNAWHnm0mj+ewA26nhceXPJhXrWPXx8Bye3jos6JYK21iQRjAOyJ4CHpqcslJplAZo0SdthCxQZhsEQVfKTRhauzoAjzBkwMdIREtgv/QCff/k8P8UmgwnJdsSdQV1YeehO0khbV8GWMPd+uh+BbepoTimR0tz3fDWuVF44BJ7wf3jlG2JUVkOKkLxQq049/ZCRahRbq2C/U7qvsILKNiqLcgp1AaiaFxuLXxe5q5xpPDUhmcOMLUaV+MwnbBE1gPc1XTJdgruKms4E8lE3Bg1hPqbqZZfDgKtm/ZvkSWE9C4BiDLsvNdEc63Sk84ZEkfkaCScbSlKKA+RbXIxulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H29hpjlVU2shiEOkG+4zVdv1sT68WCnrvVa2UDeXmpE=;
 b=hESm4F1VJZk87Jl9Zqv/fQedya1NVWZRF/lbp75vuNdh3VfG0OD5Ufvqgx2G7Xv8eG25pSXTe2nE9VugEIqelbEu4FWEesKZSK2Ndw++HvYtFafVE2848g96pWXpIfG8ydT1kcRjQqJrwUPtI+h3zgI7ELvVVXC+KldOBiqTGNyUPidiyCMp5fL1IC3pfY1R9kC6YPJ+OsrK5lU1/ZG9DhDljAD6DITfcfAe1qLuELlLgskWXn5QNa4TKAfnbwq8dmLP+ap/X/CPhqaBNqUNb1JAuS1YLAeHUx35mavMxcRTqmbQIPcii2+lh0IUB9Op7ojxvz/erJsgC5u9v83Faw==
Received: from BL1PR13CA0096.namprd13.prod.outlook.com (2603:10b6:208:2b9::11)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 22:30:07 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2b9:cafe::ab) by BL1PR13CA0096.outlook.office365.com
 (2603:10b6:208:2b9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.10 via Frontend Transport; Fri,
 13 Feb 2026 22:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 22:30:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 14:29:43 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 14:29:43 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 14:29:41 -0800
Date: Fri, 13 Feb 2026 14:29:40 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Message-ID: <aY+l1Pp87TkiqNeL@nvidia.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
 <20260213103942.142823-6-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260213103942.142823-6-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: bb78265a-aa99-4430-aac1-08de6b4f7084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sSlOqw1Z2zpBmHzRwcEYKOzA6OXZpW2eorqyF/O3Xt7EC9XM1hES8Q0ka4ud?=
 =?us-ascii?Q?L2kPhIc3yl6xTH5IW7v+hj3GVHL0E9dk1YKhW0fz1s41LMKRPFShVqQscXWG?=
 =?us-ascii?Q?RrV6AcAa+jxIp6KcmNqyvlfjYI8N5/EQ87dTxzDrNNfljr6xhVU4uumrL3q9?=
 =?us-ascii?Q?PdO0EUEz5NoAxuf4Pt5ICxfivwpcur8LZkyRgr0CI8Fo49S8UrgTi34we2aw?=
 =?us-ascii?Q?hJ8bz6tNEFwBdZHGT++asALUko2WqOvgzxxCw4M4a7QrvnU/vnyON0CvLtFS?=
 =?us-ascii?Q?9kxf0YtRyctPZ1vPkyIMAJQU2kFxkehDosWv8Vd32vRdHGscKm2FjlHC7PwO?=
 =?us-ascii?Q?UL0P0PAI8+5iPpu+4nTuS3yMsag69Pf6VIYNJrYHR+CcB0RFrxYMZtLGO2zF?=
 =?us-ascii?Q?q+3+y0TGrRDK3JNenZA1rOBhWy+WSFa69Nu+ReFxOT7qaTQDL9upNzCKc+0o?=
 =?us-ascii?Q?f+YSJobv2Pp4Kf2MmcimzQlq856dw6HNBv8yNrhTsZ09sGXHfxX5ptu0xRBk?=
 =?us-ascii?Q?xEfXQv/joFzUfac27FerQuQj8AfEMnkfN6uiE7uIAQNBBQWm+q7Rqb2b5Fc0?=
 =?us-ascii?Q?wXbXftyvN4a9VLLPerR3TCoh4x3txLRqBbNvo2MCixNR5QH/i9gx8iJNEAOU?=
 =?us-ascii?Q?UTJABNNYtAX0V/P0onCUjz3meMD9g5QvXzTcniRYauXSedxkkSqf3Q1eOghZ?=
 =?us-ascii?Q?hsWC7Rs6+TR5mIpQKElF4bga9BSMRFlh0kUNstgNdxl2eP9eHJ2wad195Vlw?=
 =?us-ascii?Q?LtA2A7Gdm2hFPcnPf0l+rbcON+5kt4xO1pfT+Rvl+C95pYe7+0k+lZ6MGLXs?=
 =?us-ascii?Q?Ua3w2wF9K1Tj+x6icnzDNGzIGCwxAYNLyHe2iOUq1ESOKEOM2XLyT86q2Uap?=
 =?us-ascii?Q?KR7uCeuCwPQXO1jzYyLJGdwf8WdlYEpbx/lLky8aq79SmtmJQ4KnqFc7HgUN?=
 =?us-ascii?Q?0iBTIOmrrGaK/YHeg2/Xv0Kr+662KRM8QlO42cREL1BHLzPJ55yhcVIuVyDF?=
 =?us-ascii?Q?I1E2sHKyMqCmlgg9IurZ8aQOQqna3gUywWJ5Uw5RLJ8fSr1dGAvZI1wvQPHi?=
 =?us-ascii?Q?9O18otlCVhfehiOYA3RZJiCv0S5+4vFQfRYSy0AUEqHmbtDHt4Y70EfzZSce?=
 =?us-ascii?Q?zWDN4A3xb4Dido8KBLm5iLB4LXAT7rp3YteNC+qWdd2Kk3ZSPlkN4GfA4O/4?=
 =?us-ascii?Q?WC0EDIHPmkKv+kPz4vHIFzF9jod8fQLrXkTwYMVopAeSCzmXxeHlbPfaoYOY?=
 =?us-ascii?Q?FrTmK+KDlyVQflpQetOViLs+rG2+ftSB21fpMYEBHhw8bw35ZF804pu/01aU?=
 =?us-ascii?Q?kFvMrb9SeHS06dOIN8r+LOGTKUHrfjsOxjtWaT03GC2nT5oJ78KAxl05Ow+h?=
 =?us-ascii?Q?HKetGT5RjGhyk9cvOfV/rZ7zFiXm7OLem+VohRETZW6/rVje73t1zVgLpx59?=
 =?us-ascii?Q?8RK9GeSQoD8GA8DQLIUzCCu7imbkQaLD9Fq9CLUoFAbDM5sYZ/98weZcWg1Y?=
 =?us-ascii?Q?c/QU6aTWLJIqTragFLRbJQj5Q/BYTwgdkcQaIEerqcCmMOzr0/1yK9ap5XGG?=
 =?us-ascii?Q?1PQs9jIBaO60CKS2PtW/hWDBDsH+d8UEhQs1VqgvUJIm2oNPRYmbjWCnFkP8?=
 =?us-ascii?Q?DhVzswrT8/H3fqZ4zJi2/TKlwXg/ye/X0xMXt/YFjoy53qrPgeNSn1OPnzD2?=
 =?us-ascii?Q?pXIUbg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ePVr6m/B4mOu1SZ8QHu2pNFHLjD70bCtVS1ipgBlCNs9lZCRi48QtTDMvPekDc3x1a6Lp5HJHtr8hHQtIHtakFKj+B9zH2Z5rz49dwryzqBrt+XNYTq0ySenKe0mT5Lt6cChupk82TKghh31nqcu2K1SQT48Xd1uyBc8y26VS/+HeGHTVkQA9fyxnshbCxWuBRLEdJHuKkWeT3abw7AJKe22rfWzoFXOkmJZfHf5PkkDet7Yz3KBAuWAL+p2UOQNs6kH4Z5R4kL/lnnEDXDv1AuSXxtt9rMhBClHpNQ7TRCgRa6yfi9bibLAwOXLSGRMQld7vef8aadWT6dHp2FpnUXFjiYqduuzPyvLvgjupyb7jxjhL7qmVd20emCwfAayU+fqQVRk7fPg2MiVZBM5cLtewjvbZvggxC/f7I7tlCkU57cTlWeKol7VEjGcUp0G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 22:30:06.5604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb78265a-aa99-4430-aac1-08de6b4f7084
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

On Fri, Feb 13, 2026 at 10:39:42AM +0000, Shameer Kolothum wrote:
>  typedef struct SMMUv3AccelState {
>      IOMMUFDViommu *viommu;
>      IOMMUFDVeventq *veventq;
> +    uint32_t last_event_seq;
> +    bool event_start;

I see tegra241-cmdqv having these two as well. It seems they are
required by all veventq users. So, let's move these two into the
common IOMMUFDVeventq?

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

