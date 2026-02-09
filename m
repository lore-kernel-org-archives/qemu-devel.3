Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC11E7E0D5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 19:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpX9x-0003kk-Qb; Mon, 09 Feb 2026 14:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpX9w-0003kW-Ei; Mon, 09 Feb 2026 14:43:00 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpX9u-0006dQ-Kx; Mon, 09 Feb 2026 14:43:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4PYWKcFPJbduqEh63uq2iptTXqocnaLBl4n01GGMkUDEq4/JYrPWazkKpALPUh8rFsGu36UbMKI6o1CsFt7Ihk7kg3SZvmkDJTm9PtdMbrHdnmqamQyT8UBlEG/9jhELd5ZJnWariyVRKWQGmsAaXt28Fz5IGahyeemfDh8Z/ZOsFWhcUCLZOlbCOgkPpMUe1TUXM/QhOttJ5mpgHm/vlullj+y8+pFNSmozuh0BSBX3QZS5y2KKomIx25fMRV72jXqS3i+lwyBkcMrxTK/lCSs54DG0Ff2/wjoVHiDKqnGGkBndn3qPf0StGWPyPoU95UzSBquDj69i3F6ndcQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoTk7ciks9ykjStHdO1iZqQiDTWq/yFMRiL3/209+gc=;
 b=kD3fZTlTreuYtSl73aku6pDTD/R7gujnMuD0oKkL6R1ZqugqyICueaRtWdKZCpkxxrJLatUwaoIAt47ORhi2O8Uy+zHBOiSFBUoowDimNSCtpvfM4wO9hwBbEjIdwZ8bHBLW9yIKnG3NrklvpjOsiViIWAoCSw5wuoftZoraIzXSAfbe75x64qOSGY+1WGmCkjX5LeWtQfX02N/slbtQgofn016w2TRs5WrPNmKIhfpXTSu9qhmQtvVn58Jpa2nfTAQRMkxfFr6Clr/9c29sz9x+NU0O3m9ah47jijtkTsknLtcGA9/beJfvd3Eh4d4HqGFlhUhft0xmJeYb8OdY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoTk7ciks9ykjStHdO1iZqQiDTWq/yFMRiL3/209+gc=;
 b=Uym3RYgLSgw01qWYoCrsoJRjOrniNfeB5rf771pRIk6eWXE1P3ovzpku46QJ7Lam8mn8y7vGh6J2qM/R666h46vujEtbCfDOao+6ukvJjFHRTr6yx4brCv+Z9vhwxqs9U6sohYMr53G5k4ToYZX9O5HVEg6PCeGFPmROnfqrjrjjYt536Q8Qv0oZw+AdMUjBYkhFTIZbTjYt+NQXbJ+mcSlHXAVwbSaERhLr73QNQ0vW0XxDt6ElxeHvrhFDmzudq8KxaZG03lLMbR49hPT2ZFqHtcteVJtLQiujCK+dxBXS8NCF0UVcaHX4KK/32XZoc/zKxUJybWIVFOCfkoNLtg==
Received: from SA9PR13CA0044.namprd13.prod.outlook.com (2603:10b6:806:22::19)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 19:42:50 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::37) by SA9PR13CA0044.outlook.office365.com
 (2603:10b6:806:22::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Mon,
 9 Feb 2026 19:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 19:42:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 11:42:26 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 11:42:26 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 11:42:25 -0800
Date: Mon, 9 Feb 2026 11:42:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Message-ID: <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260206144823.80655-6-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c51672b-95db-44d8-cffb-08de68136890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vPne9mj9Ew6YpddflOae0eZGLiUUlT0xZWY9jMw9sD9Ruuq+sum8G+OTXfy6?=
 =?us-ascii?Q?hYX7Hu97tf51oI22Rhly5H2lctAgn8DkRYmn5Mc0hHHq/Puea1GajxP2Au6w?=
 =?us-ascii?Q?4UzzKGhNBoppezx1HvsOQWIRmg8nY0Y/vGDsmrMlDZ9Zm1z4DFmIP5Sj+PJG?=
 =?us-ascii?Q?lC5xSMiTdF4MSHbN6SlkjyBb7ZbACl5/P6ntIbmuKvUQ+W7FcmH0e+leJf8r?=
 =?us-ascii?Q?TKPJc6kFc0ihmx1Wv9miXzgkmY6f8R3Uonmn5lEXpZezaP6qFQGBMQnMEywK?=
 =?us-ascii?Q?RiGFbhalx/JeJc4FNMW2OigyMII/VGkW4qiIgZZ7Z3zeXeMmz3rV17/IJDDZ?=
 =?us-ascii?Q?MFj8cVvPF4MpzEyOLKueA6Qbgvh6+lH4deV7ck8IkLo/zm52fILfWYOw8xBL?=
 =?us-ascii?Q?+W2l3Fs1J6w/pvnwzaIlziaZkt7YHLyMAhN8YXz3nTSCUEB5UyDhchcHWGXg?=
 =?us-ascii?Q?baq2E1maxZRBbSj2gIVaLE+WLGIiaGJzw1ARt4Pl3OPt+hA6eERf7lpedqk5?=
 =?us-ascii?Q?DZUGkPPwlwE81/tSKxacL/ubqNiZE/MArANEZkziiC9j4/QLjSupzEYDi4nZ?=
 =?us-ascii?Q?CGzkevdOJN3eFHF+czfLZkGYPOmGJBOxxyeooxTZ/wrqFiKz7xXyjNWKikAN?=
 =?us-ascii?Q?ThYOlqWRQtC2aAismR+eD7wWo6ofTrzKVZMj4dWm9ZMLByJt1PM8IhllHVqj?=
 =?us-ascii?Q?s+A+mQ7TrrbeWxWYKTpK2CTSrgR+9Ic/WmK6yIS7pa/1G/NA8t81Yx83WHNC?=
 =?us-ascii?Q?W2faRrY7arxzns2yXiaqYpkYBbmiPNMKfs0ETg2aME90MgSH9BDUvxExXR9U?=
 =?us-ascii?Q?I79NzbTunrXfWWk/NVouAf6iUZgyiDuRk/r0rjtfa84pJchKuWcXGkEVmf+n?=
 =?us-ascii?Q?S/4a+VCTwbzYsbyxCfYpk+r1P/Em+eI3yPfP0gHswqqZAgV4SJAiHnYHv9vr?=
 =?us-ascii?Q?Nxk95jN/X7L2pGyw7RujZBQSqeBPEwXG2/I+L152mTsDmn8gHY0B5hGE40sr?=
 =?us-ascii?Q?nqcNCoVW0Wfy2P/EiaF3y84lYNyzxefqlOMBZLMP6cZK3ZOHiR6GL8caSI/3?=
 =?us-ascii?Q?+pzaOwqLLDXsItP4q17JiPum8Myve79cTZOzf1XVgZIHyyM30Kv/lZDIEMR8?=
 =?us-ascii?Q?0sxeTILKIsFNOd2X5YojH7CkClSXnUwn1i/9KOGfFZE/q0srec8RvFFdP+90?=
 =?us-ascii?Q?mA2CHXJjYZMGh0EOHVBYxsy8TYyv0dKpndNxdJKKw+vyvSBYqdFTsbl8wc+8?=
 =?us-ascii?Q?FewhPbjsUlJRZssggpJ0fCDm7f/7WPKAcH9i7gfZ/BZ+UQQkV6ERgpamIZ/x?=
 =?us-ascii?Q?aTMtuAwXQQqtiBLUoHGE70WUmKqORGbFdIqH4uOxBq2vpIFARbzNCG7bu1xe?=
 =?us-ascii?Q?0GuyvgMEbJ6/WqA8Y9Vx+JHpBj1aS73RA9nm+SCV/6K4IKNz3H7qHEGmQ+Uu?=
 =?us-ascii?Q?ELljfX4gncJ0jGIWKZb3BH19QC/7qtJLDj78U8Sv0M8H79Es4rkBe8q0XS+a?=
 =?us-ascii?Q?kllIuqHnTZWxEcn5uCiRamNJxwzaVEaMWJ4I7WWlLgiIcGaXYHIBp2mUCwQi?=
 =?us-ascii?Q?dwHVRAjWefqu3V3QwU/At1fuu/I7DS1KQgVMviTteQtUqMXUWZEKAsRRt8mX?=
 =?us-ascii?Q?BM2sStktnI8trIgqzhFw/yWaPJNq67qVL0JSIJ7wCRiefQZW7YQGO+tNQcbs?=
 =?us-ascii?Q?HsR2lw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g0P3tReDF7/npF/3X9TQfcw8cvLhJCC5YFxPNdMD3qNHTfppEk/olCN+fa1hhq9qVcENoHEcm3WeO9RhgooZzdZtQ5JI/u0dq40lyT/yJGJiCkPEpQg0n5PaSyEET+70OzxFl+2YCtOmiv+RPTeVLC6JShTWqTK93qJpucIp72PFEu2X10NYyXxzdGpI8huhpA1kqCJ1Zvcc9wQNeDHK1Oa0os7cWXW0X1o6JBHtaXIfavtin5ngB5gpQLwBxiKd7xzZtQhTiYLj/IcC2GWw+uiUi40aiXFJHyg93D2wjtWG1xW8gtPbdNyfW+Kcxt0T5+C9mlRxFG6MOpNypY53MAEBS6J8A0lqX598YBqjgINT3fikTZa+pHpmARHvn3xTZudLj7Op1rV6jJ5Fw4xj4YrVidVo+HEnCsRrVyJO4i6mNB/B8bJW0W9LybztYEp7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:42:49.9680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c51672b-95db-44d8-cffb-08de68136890
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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

On Fri, Feb 06, 2026 at 02:48:04PM +0000, Shameer Kolothum wrote:
> CMDQ-Virtualization (CMDQV) is a hardware extension to SMMUv3 that enables
> virtualization of multiple command queues (VCMDQs).

Let's mention "NVIDIA", noting it's a non-standard extension.

> CMDQV support is a specialization of the IOMMUFD backed accelerated
> SMMUv3 path. Introduce an ops interface to factor CMDQV specific
> initialization and CMDQV vIOMMU/vEVENTQ allocation behavior out of
> the base implementation. The ops pointer and associated state are
> stored in the accelerated SMMUv3 state.
> 
> No functional change
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index c9c10e55c3..ca087240e5 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -16,6 +16,23 @@
>  #endif
>  #include CONFIG_DEVICES
>  
> +/*
> + * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
> + * support multiple VCMDQs with virtualization capabilities.

Ditto

> + * CMDQV specific behavior is factored behind this ops interface.
> + */
> +typedef struct SMMUv3AccelCmdqvOps {
> +    bool (*init)(SMMUv3State *s, Error **errp);

> +    bool (*alloc_viommu)(SMMUv3State *s,
> +                         HostIOMMUDeviceIOMMUFD *idev,
> +                         uint32_t *out_viommu_id,
> +                         Error **errp);
> +    void (*free_viommu)(SMMUv3State *s);

I don't see much value of having alloc/free_viommu..

Type and data structure are the only difference from the standard
viommu routine, and both are already in the uAPI header. 

> +    bool (*alloc_veventq)(SMMUv3State *s,  Error **errp);
> +    void (*free_veventq)(SMMUv3State *s);

alloc_/free_veventq can be moved into alloc/free_viommu functions.

> +    void (*reset)(SMMUv3State *s);
> +} SMMUv3AccelCmdqvOps;

Overall, an ops structure feels unnecessary to me. Maybe init and
reset are somewhat plausible. But nobody else would reuse this ops
structure that is exclusive to Tegra241CMDQV?

>  /*
>   * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
>   * Holds bypass and abort proxy HWPT IDs used for device attachment.
> @@ -28,6 +45,8 @@ typedef struct SMMUv3AccelState {
>      uint32_t bypass_hwpt_id;
>      uint32_t abort_hwpt_id;
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> +    const SMMUv3AccelCmdqvOps *cmdqv_ops;
> +    void *cmdqv;

Having two pointers for the same extension feels redundant. Maybe
merge them with:

typedef struct SMMUv3AccelCmdqv {
    void *private; // points to Tegra241CMDQV
    struct iommu_viommu_tegra241_cmdqv viommu_data;
} SMMUv3AccelCmdqv;

...

SMMUv3AccelState {
    ...
    SMMUv3AccelCmdqv *cmdqv;
};

?

Nicolin

