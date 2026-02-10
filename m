Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6FBE94623
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 00:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpbHn-0002PU-9s; Mon, 09 Feb 2026 19:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpbHj-0002OF-SJ; Mon, 09 Feb 2026 19:07:20 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpbHh-0007MA-OD; Mon, 09 Feb 2026 19:07:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TV8Ot1D2oHUxNcf5N2/MyZvDW9NQUOwRHlIKYTLJNNHm25VQ2xFOZGjB6GdZtNFfY+JFip9zWUOmT4oH6Z5HWdobKT28yjJUtPDJwkJfLlGZib/Zyb05wJ7klNUwsAzyVFGxRA1FrisVz3wO863c0sEFCAFqlOBwHPmuzU8lv+BFyeCNtRdVFLIvuQIyiEhAYhU3uNLyA0a+OB+A1p5wOSV5yF+OXmi/2kiQPjzz8i63kaFnUwx7ovHNIJanKTmJxTP5nnCTvipR7Y8bpbg0d3qC5sruaWbRFchlOSBn110gqPJMAMFDJ0h7Rtd4F9x004SZWVGyxUJVloQLpQkSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt/2OYIq69d2MXHOGpm32nEhLfAYhMOzO3lr3r7qugA=;
 b=NlzCDyjxc2YOou4BaRt0DcQk40LT/KL7anDZwfvw/OisEs41MBj0Wycj94e+nqIhZ5MoCJ36pKKi1YjRSBQxw7WX5u98cWZpulIb3sEBqzcQ4b7nnANv1+XhUAXuqHLu2Ha8FGpP5wW471tKmO7SlsSRl9vpsI4gijcwloMUhLw2/KdcZ7vT9rauXOQWsgxBOR1RZlKFGD8kD3AZ2JBwifUrPdHQZbKhfxOgBc3YAyigqysbk68Sig3fIq2k7gNqGn06a1waC5RTiJWGaq5ZnBT83DxCGuW3qxBJYnDCeDZ0adt7UKHzJNPCBHd09oWmsQZlwdtZx41L8ExOggAFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt/2OYIq69d2MXHOGpm32nEhLfAYhMOzO3lr3r7qugA=;
 b=Nzxz96h3zVQEoLToKepQRHfly5WWLlyZq6yim6j76ZAdRFG/7Lv8XeG8bQAVBXRwv8LKvNlORQZY1hlLjl8DwgE/HRgyGos/r0TvmClFR2tZ6fpE51ZPHa2zNKws3vHMneM5eHdnZ+zzs3sIYTy7BA/4McZVMzMU3yz74zY37N317g7YZySkriPyYh0HujnVL6rI1+SByqbJ1I2Yk3RlbWFqRuKsJgGZvw/lWALdqVcyVpHgkyyZtZoPLk5usfabTk5kQvUSOrIIJkEa1DsIwZaYxAZuwy5UyY7pLVAzrELGgxXtIjl+pm2L4AepKDviUznWImW745t5sfeAnRCs1g==
Received: from SA1P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::26)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 00:07:09 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::d) by SA1P222CA0024.outlook.office365.com
 (2603:10b6:806:22c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Tue,
 10 Feb 2026 00:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 00:07:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 16:06:56 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 16:06:55 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 16:06:54 -0800
Date: Mon, 9 Feb 2026 16:06:53 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 22/24] hw/arm/smmuv3: Add per-device identifier
 poroperty
Message-ID: <aYp2nVDudWiUEGAa@Asurada-Nvidia>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-23-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260206144823.80655-23-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: abf888d2-e9f1-4448-d45a-08de6838558b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zyENbALI0B9zYcn5Mp+KfwggxfKrqABetczUvmzw59/YO2tLGpwVjv7voW3X?=
 =?us-ascii?Q?bGCPpLKPvNJKl+u4s20Ih5AxlHOGNC4G4Eeb+yi50mPAi7A1RNW+DigluPjI?=
 =?us-ascii?Q?4H9K1lCcAc64vPHQY8ftB3SeOHISmGYzEhUEY6iOjy3f0WEcoqTBOnozdn4X?=
 =?us-ascii?Q?2M/dvrgh1IJOYfMVERwuU4day/ObDPw9VWZ3JZuPkKlMi2CAPSB47ojToSEu?=
 =?us-ascii?Q?05637AOBJJ6VmESjhSQ8I0AtULJfYYxA4e5IPIyrMgJfbvG3v8V9kkwzVdxI?=
 =?us-ascii?Q?mRdv38F5+4kr/maRmBxqbJ1gkoBUkRBl9wBWKgKAdR7CaQ0/f1swcvT9Sq+8?=
 =?us-ascii?Q?TmRkoHc+EKTVLWO0cTPWxVgruT48GmXtRnnGVz6KdmkgHlp+QURKdJzu1qUH?=
 =?us-ascii?Q?L4uIZt12feVlMynQHC3/cDzLgDJjGN7MJ/moWnKTyfyXCO6n1eqDbC8s/PQ5?=
 =?us-ascii?Q?bCSlkWlV/wApS2v6kARQEb5Y7obLXE3X1mVNfPn78Im9E+pzigXZu5HR68//?=
 =?us-ascii?Q?my1qY5xCLqOm/0LywuZls1Gf0QJ58VEo8as9ZtA3yIQhCkMw5L2pbSTG/sPm?=
 =?us-ascii?Q?uh1Spkx2ydoywC/un/Gf7GBV5t30xZm65qA0++wCrkKrH2XeG3D0fWsPZkzk?=
 =?us-ascii?Q?EBPE1NSP8+uBt8lC+jiuqxQPxty9ld4FAmE8F5nMDcDSZIaaLqh3mbBqZ6j9?=
 =?us-ascii?Q?18LSgPJBlF2qh1uxFQ3o0nMbIdhae7rcLYpmC87pap2hwVdBxld0h0+BuaB8?=
 =?us-ascii?Q?X8vLTlKfUjd6JQlgF0RVQuljHjDEDaYxnquQgfQusWaN2P+2PTC+o0xEKI3y?=
 =?us-ascii?Q?fc4kjCnWadoMZfLebHpIsnWSZsf6xV9OH1vpn6KMVzsKIVpDA+vktty5b9lN?=
 =?us-ascii?Q?sGZGWcH3XeC9urqcxVnrIqwmX1KJdiCLs6Z90mmWrgQI8jgk10bTmsBL4SVE?=
 =?us-ascii?Q?4A1usk8B8zDgG9DdcByu8R5b492YbN9Fm7RLw6JDBZxYoO1DZdUf6iwduip+?=
 =?us-ascii?Q?Lau9zI3d/7fs4RkyTJR2rI85XuvA4ceEXkYIN322Dj+o0gmZmpvTiwFUzmZ6?=
 =?us-ascii?Q?u8s/bVjJ5bspVXKt9U1xiOmRgNCZLi03kSpFCuCD+3VzPKalMEqbOJ99uT+x?=
 =?us-ascii?Q?sQMEuUz3aQTk8/V84J34pRDivmE/2AtP2tTSYdc5LzQh/E1amYZISY5nLIzQ?=
 =?us-ascii?Q?XeCvn5MSaC42kJOorvEaOnERhWNnTLEZuDRC6vNOlM+KAgVIzLZj8y3Y/Nwm?=
 =?us-ascii?Q?L0wvUBxakDok66jl5iEtdxsyISKHEHRt1LJ+o5T8BT34pmK8SM0CX2ScSzwC?=
 =?us-ascii?Q?DeWVL7oIl9D5dhoCsFhZRO/qYrbBOA5fEDfhFivKOWd+ITih3S0RcOMOxfzk?=
 =?us-ascii?Q?g3FkE1YqRocJdMO/uMvkRQwB9bXM2rE/2ICW+wTN78SB6FNjEcEw/rAg+N96?=
 =?us-ascii?Q?9uKRKgZ679miFOL96++0WGubHgGClDnw1uDGp4JTEEb6XhBx3JSLHUcEtJh1?=
 =?us-ascii?Q?4mboMs9S9P86KcZM/gTEs5kpkAqBrD/GnEbR0p1Ko93YV15jTzTp3/uiZHRc?=
 =?us-ascii?Q?RhZV5R8c3QbblcrO+ZdEIn3GEVyNJBDcXxsLu9s6i6b9xtLoGOtdxk+uKntt?=
 =?us-ascii?Q?8WzG4NxwiwKLn7K4WLCDs6BD9TOKCHPbKriNIIXeBGUJQLHQkUq33waz69/b?=
 =?us-ascii?Q?pJ5Qzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GJSJLVbV2CQgYUVNW2gjX0FHnIZUEj7tNPup/Aew1vU6sGkDB0hJTFxUWS78avh31Vkut4tzEoJwwz3l4QdA3rj9qDiXUB3yIJqTr1n9DrLXhau5CApvtc23Y6EUM08nMHXYIQ2YPQWUQnbiGpnly2Hv+AsnNikHHGnlGtsWE2S46+0TaGh3l0sbELg3LS0ORXlrUyy0l+5rJwD37V2hfj++xTnvdFDaikJINMrtNlqThKw60JxdJ+hNBTg+7pbYEk75C2RVC7mKXYllpZjhvfxlLIB81lPkLhjo/06k9v8VRMsYzVIWEe2BxfozQBMLimXYICUIwfloEWGJmC5KDJV9FCDfO+dmpgYj9XfvHaRrWVhoBTTV8e5pf6YX4WfmUZzidU4B87+yxknt371ZPQoYooFfIbhFTYXYvWEiGQCv5r+9VIgDRO7yPOoTq8EH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 00:07:09.4310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf888d2-e9f1-4448-d45a-08de6838558b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

On Fri, Feb 06, 2026 at 02:48:21PM +0000, Shameer Kolothum wrote:
> Add an "identifier" property to the SMMUv3 device and use it when
> building the ACPI IORT SMMUv3 node Identifier field.
> 
> This avoids relying on enumeration order and provides a stable
> per-device identifier. This is useful when we add support for
> Tegra241 CMDQV DSDT in subsequent patch.
> 
> No functional change intended.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With nits:

> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 7858bf2c33..7f84c87a46 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2114,6 +2114,7 @@ static const Property smmuv3_properties[] = {
>       * Defaults to stage 1
>       */
>      DEFINE_PROP_STRING("stage", SMMUv3State, stage),
> +    DEFINE_PROP_UINT8("identifier", SMMUv3State, identifier, 0),

Perhaps add a line of comments for where we use it.

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 390845c503..22ee5c4a41 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3059,12 +3059,15 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                         (vms->legacy_smmuv3_present) ?
>                         "iommu=smmuv3" : "virtio-iommu");
>          } else if (vms->iommu == VIRT_IOMMU_NONE) {
> +            static uint8_t id;

Local static feels odd. Perhaps make it global?

