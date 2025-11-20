Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACF1CFA441
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMCJD-0006gq-NW; Thu, 20 Nov 2025 16:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCJC-0006gO-0o; Thu, 20 Nov 2025 16:35:18 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCJA-0002rp-7r; Thu, 20 Nov 2025 16:35:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqHlHcFezivZAgtrHfOFLmU2JGKd/eWaGzzw7ItqtDsyFhg3JoMq9Mtk0VgKg6rC+NdRuaRHcKiuXeV/ukbMzWRHx3sTlkWeVLGWojVA3yW3SoUE8RR/CBoKOyZcmKQ7U3/r9/IVmqXFpNOpnlzstOn/DSSfuhOZ9CrCYASAIDreQqGfkNGLnt9hGOGkkQw4cCOTLnA++nWL1xBHjxA+dDu5lWbuG6998Z2KnJNbTVHLOY2Eo4zhkT05Z+hhAh5CFlugOc09MsQDIkcXcfeki/DHbvZ77HebOXgXHcFsKSNrfuWGR40Q8xYQsfdwVSXp9LWvHqye9+hjlTsVS154Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNpfFgd55Tp+OB9Sf0fn0g55ZmmWlXnpqMcP+NI7fR8=;
 b=SCHkuH7eVLOlYB62//c+LpK6I/C8oAY9YTa2x+Yi/lkYv0f9QsF4d9s/wZGSe6nckDoq15mJ7/+Px+lVD73ZJxd6MAJcWyG+hq/jjkCj9f1id2mjQvJt9tUuOm2lYLxpO9XS9QmWusev8lNtTpu4/ovnng1ofxuFubEuynBs+HS5oWWUuZI7Zz7kY58iHfhvaV4MAXXRxOaq5RbIx4C+PuKSiCoHCiBv5ularkHq1pTSrmDYDXC1sNOFvPfBEkcOpNZoVf9/sUgwK2+U16gnFNlcTDAl6EX2GdwnWyZiHTOyuVNexfIc754M2hy9yG223t2u1CT5cM0DchiEgRZeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNpfFgd55Tp+OB9Sf0fn0g55ZmmWlXnpqMcP+NI7fR8=;
 b=GkuFZ7hGoQr19bM2gybFapWjSMYpUx3WhHeVAN96X3bM0mgrTKtM9gaCxmLX7+qP+fhSPZx6NapKo3MO3BwDQ0J368lXGi4QBWqcWEoBMYN2EHmDwqw2S7HWkV72ll8Ud5Hxo6nkk7+6bVjadQIx1FzEqbtRy4JzL3lLkGJAEUp2fd25AZxEPXwc4CZ3IYLhuIV1VXyfHQScZbXhK/VF6Y1CuNvh9WfImc1OMe56SJkrFqCs53cqHsdFbQxMxBLcuwjt4ofklod1EG17zeQRtUCDzCLW18HvPEycMMk/7vhoi9A1H2YDzvGytqtShlkT0wgy+ZF5XYDjyqogLPfxig==
Received: from PH8P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::11)
 by CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 21:35:08 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:348:cafe::24) by PH8P220CA0033.outlook.office365.com
 (2603:10b6:510:348::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 21:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Thu, 20 Nov 2025 21:35:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:35:01 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 20 Nov 2025 13:35:00 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 13:35:00 -0800
Date: Thu, 20 Nov 2025 13:34:58 -0800
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 27/33] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
Message-ID: <aR+JgmAxA0GgJEyr@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-28-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120132213.56581-28-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CH1PR12MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d716e5-47b0-417a-9edd-08de287cad00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?2SBgGchfeSsIx8WgtgeflDUbdwp3y/oyvBwSeZHfRqFTorJfs7pKUzD0q9?=
 =?iso-8859-1?Q?tAEoQ6tPvMyhcR2zak4XAdpOHf8nJh92Mu5Oq0KlOAcMRktDpaCrvjhNWp?=
 =?iso-8859-1?Q?/RnNLBKT+xJ9D0IRgYMKZUr8tCF55jxO6v4zpl8zgPr97ZpUZZKpzQuBS2?=
 =?iso-8859-1?Q?CuCryT/MrbR1W1tkUvuqfqyAnHeUrgnDXsKV/YqmiU3BuzTt0+C+p8od+x?=
 =?iso-8859-1?Q?flQCkFwM4J23xfmbLAWrzti7TKZUqzLrd9uV58IVuOhKB6+ONZMvVZoD8u?=
 =?iso-8859-1?Q?keuAHf+raKnwZLAdWMmOipC/h12OJD+YiUrp+4uWGr+/njZqPr+JMQNruA?=
 =?iso-8859-1?Q?0kj953KaSIX0y1IOSM8akU2Lxrb9Wm5k5pDHumSNIxQMUd8mYcaKDiKU6d?=
 =?iso-8859-1?Q?8PRHTKWMEu/qEhrRhHY9x20PxmUrpVnOWije8OoWUhLUlt3zvFnTIc+VxC?=
 =?iso-8859-1?Q?81RFTAK8Sc8RIXsfthXFBFpy4Sud3iSFMI84oSSFI/JorQEmY5O3074kob?=
 =?iso-8859-1?Q?l9hSoS+GiTBwoUUcExVRbjkxzdYp0IeW5Zx6LSnZKXaSD/VJPQIxU990R3?=
 =?iso-8859-1?Q?GbxBVDla0zrXLI5ICw+FIY77Epg8qZsKsdMi7PxwX6PVidQ3dZntehoCEf?=
 =?iso-8859-1?Q?t+cxS4ok9mhhMOg6o1NvXI8ZVBHYZb3AL+aiM78hKYlnw5ppcWldnWdCRk?=
 =?iso-8859-1?Q?gngS0gQ/raovbSpEzEnbKYlPxvq4Svi0ubTmXCOT98uTLNDSHMHmRC08Zd?=
 =?iso-8859-1?Q?ECJHX1F5KsHYj8soFhBTI/RRvbmgrykStYCT73MW8Pu3HiFQdBYgO+l+fK?=
 =?iso-8859-1?Q?r90H6w66LahqeNxb11fGqfREINSI5Rr4UhB2FI+bRAMjrZkPISQ7yxfUr5?=
 =?iso-8859-1?Q?mVJxYhq6bcvWQWQEaFIjn2OAmFjsS7OC0IWQTv3sdWJyQv1pplaaaMHKzD?=
 =?iso-8859-1?Q?7kOvXJkwNLLq8MGlqhl02qZNrF1M2gsimXpGN2+1+Wdhow+JQae7clsD7t?=
 =?iso-8859-1?Q?/LIqHqx6E3k2xzt0PIcn9bVzx4VvLUIEkjF0RuW9JTzmWkiqgKULicZnIa?=
 =?iso-8859-1?Q?pDTeToOGo9hI2KcS75jGipKZYzBiVVpFgNdxpAAK74Kqj0xaZrUZFDrSP9?=
 =?iso-8859-1?Q?ei2KxCXGpCB2GmH6upQMOVUPYF7XxFxxf88lYBj8zC0bnTe0PIzp5NKD+d?=
 =?iso-8859-1?Q?GIPq4iWOzqhYg94hfhmV71yNels79x8/2J1C2++dukGbG7qW4NG+C/tmmD?=
 =?iso-8859-1?Q?dEkWlcZqWaOOqQKYiFduPZePW13Xx4H/bXS+/A0AgOMpxlk5DXtgPn/Edh?=
 =?iso-8859-1?Q?XPjN4Bv/8dZWlbqAx7TvcBtm2rGXRLmb5i+vEThI1elu1L3E5VHvbyzk3I?=
 =?iso-8859-1?Q?Vg+9c9PQdxUzJTEMyKBBIP3YdrrHJJokRV/kBUsIzTsoVTmdQzmGOTqFAX?=
 =?iso-8859-1?Q?+vZd/oh4jSz2Jvkh/StcEt4/ANUheczXXCZmAgV59UVHxbah8Hv8AmMACl?=
 =?iso-8859-1?Q?rloBhosc67NvMPFoDXmIMW9Vhnhf00QWyVVeWRR2UjPfZ4sRPoGTEsEuq5?=
 =?iso-8859-1?Q?LPJX1L4i3aDR8VKGL+3+GmIAbN/7C8PmJyWkO+pV9fYi025GMk1N5ohP5H?=
 =?iso-8859-1?Q?YDzFZBO+uMQGY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:35:07.6545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d716e5-47b0-417a-9edd-08de287cad00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9717
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 20, 2025 at 01:22:07PM +0000, Shameer Kolothum wrote:
> Currently QEMU SMMUv3 has RIL support by default. But if accelerated mode
> is enabled, RIL has to be compatible with host SMMUv3 support.
> 
> Add a property so that the user can specify this.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 14 ++++++++++++--
>  hw/arm/smmuv3-accel.h   |  4 ++++
>  hw/arm/smmuv3.c         | 12 ++++++++++++
>  include/hw/arm/smmuv3.h |  1 +
>  4 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index aae7840c40..b6429c8b42 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -62,8 +62,8 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>          return false;
>      }
>  
> -    /* QEMU SMMUv3 supports Range Invalidation by default */
> -    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
> +    /* User can disable QEMU SMMUv3 Range Invalidation support */
> +    if (FIELD_EX32(info->idr[3], IDR3, RIL) >
>                  FIELD_EX32(s->idr[3], IDR3, RIL)) {

When (host) info->idr = 1 > (VM) s->idr = 0, it should work?

So, should it be "<" instead?

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

