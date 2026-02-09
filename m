Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A73E94614
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 22:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpZfN-0000JO-6o; Mon, 09 Feb 2026 17:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpZfC-0000HP-UZ; Mon, 09 Feb 2026 17:23:26 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vpZf9-00073F-KS; Mon, 09 Feb 2026 17:23:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdtkLqo93JL0pdGnkwN1u7z5RFHwduJchA6tvOLLQt+M93J/GmcM3VY2B6DAz0D93PWQsqBNO1s1cxLhBjB/CgZLIiZhyWVXPPeELF1IJAotlXStJcGOkmlYcd/8DbOu15iIV7YIVYVzaH2kCeBVhtM7Q+tDzrmnEqYi3NSAlcMhB15a5hGWYzAtnCuB1dLvOFbbrGnmFO9VZEFrHLXNQsjZH93gHZl64VBoBmLfBTHYgW5LsPpr8I36kgPwpYV4POWd3YCmo4Yfi0N/wjlBXo0usZS1jhqYChKXg0JFx8jGXThkP+bgqcqh7RTqgFE6FB5u3uh46FXyAC+Lf62IaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsdygl7Hoqhjha1ULZkdrbpnfvwC20AQoavdCL42Tls=;
 b=FbbUkey7L3ZgNAifMw8yTn4WAqUCI27+7/ATjHiYiU2/JILQGHvy9b9/UOjAPszCMZA9VUeSBAC7C5GrahnUKAymCTOdh7dU1cPd0T4Q2VnYrrMhRhbhM34dE1wWUwFD0Sg3ch/wdLq93QvkozFvc9o2YNtbOwZ7U0gwOgaxykDLwJrsVRh6xAPn3ycMDgifqnYMzZ6zq208ghSegBvBDiw0do3tlXvFNZIbW+X3rV3ihKRZ8FST9C6+c3b5NdzHq6hPu3sB7ewptO4HRkNzGyX/aqVHC3uf3DV4AfYqj+lsjP6007ri9oFT5oA0Z0KUGm69Cjwo1DudTMG28QQcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsdygl7Hoqhjha1ULZkdrbpnfvwC20AQoavdCL42Tls=;
 b=HG764SfCEafyXm6BChY9acHt9xg3uG0cigd9U+jXpb7iwuVzoVdJBstMLx1iVEoOJ01dj3hIbA71nuz3pFwNYFKQDYSGDhkqeNDkxtDMdrGS/i/2+AzlGbbFmPw0Lw/oGEhZWmYAiyfOFlSVDJ48B5u2Xoac1ANRPinndpyU7YpOTxcWFSaKq3LklvuVmfr97YHO5bn+Ao8ESsAmgpYtvP6O8cmAhKkFkVdDmV/mxYPaVU576cLFG8ruV64n/slRBED7oZVGc0DEfS7bXx579p8/7zHMWmhyKw88iBPuzxs5T/J/DudOU48cs2PJf3m3e9LKWb6NornBh60sbeYMpA==
Received: from CH0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:610:75::33)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 22:23:15 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::8a) by CH0PR04CA0118.outlook.office365.com
 (2603:10b6:610:75::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 22:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 22:23:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 14:22:58 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Feb 2026 14:22:57 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 14:22:56 -0800
Date: Mon, 9 Feb 2026 14:22:55 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Message-ID: <aYpeP5sv75JBQ+Bc@Asurada-Nvidia>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260206144823.80655-6-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 91147f40-0c96-4598-d0c6-08de6829d164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XBx6EEmsMW/6OI1Icp712jDhk5y3uDDnmCZ3x6tkaqduF3uYiuXWEx8SOUOb?=
 =?us-ascii?Q?z0/zzEVi6KXkuTA1WFF+Mo5yZZ3LVJ0zIXScVjHbQ9UnLJpb0smMyaSg/YZW?=
 =?us-ascii?Q?bR17U5+LDN6u4z/VSSvcGTUtw3Su83gWnYPED4tp2mJ/LvjldJrXhp79wIm+?=
 =?us-ascii?Q?Bn3frdqVtaN9hbriptY3MRqG1j0vMxGq+kM8ecZOr6JXd6qsqUqL03/6cikm?=
 =?us-ascii?Q?uRQYHpB//T/3zHm0gWZCra8ioGgQpi47fl0ZlWflO4IjZu6cUa9aF45qx+A9?=
 =?us-ascii?Q?PvH56eb8KFwYpJm1ObqOeE0tMJHxR+ZGUHAJYuvTqXK6nq1dpdtAdkonzHMR?=
 =?us-ascii?Q?iszU0abkHeMZwNSbq/NS1lZwPcdv2vUd+NOKMRBciFRsHrWHD+MXLnhdnWtB?=
 =?us-ascii?Q?JjREAANnRTnljpj7PU3YvOn98m76EihXpDoejKEerPm5UxTEabV31mTb7RN6?=
 =?us-ascii?Q?n3+3mIk7f9HsOvWDAKcGIoZ5ytlEbfNMDCyHmxzjLRw12k7AlIcTL/73o70t?=
 =?us-ascii?Q?aHufYeLQCHtim87Nw8XI+XrVEYFiu79wAicHQJj0vX1S917CSKBlZd7N3Osq?=
 =?us-ascii?Q?tN2A3HveVO54hC2eOT/7ysbtHy0nSbKYZDBg0qdqaS4qLk8JFBzp4fNrJua0?=
 =?us-ascii?Q?O/VDoPwuMf/Sjey2bWcxzeYjwLboXDDyEm/owrF3BzggX/M4RiuSMq9kMR5p?=
 =?us-ascii?Q?h8hJG4GdZur/nI7u8LDsFCmu+yZz2W3Uhn9+40Ouyrg+jRpBPwDcyVr5T9I1?=
 =?us-ascii?Q?sQChp6S6HV2/Z1WYzVhgzDYbDE3Yf1bE0yGxIDp4BnIyqsSODqoB5gV4XI5L?=
 =?us-ascii?Q?rJF51XOWTr8GdH1s4NjoIyPipqBRgRSMXkimEgQx3x44ug4zgcRUzHVJqwkx?=
 =?us-ascii?Q?kkGUdQlgwH82cXLhKh7F+cdF4SJMtB5NLcjyWZx7kG+JY4KXSx64k2y+67P9?=
 =?us-ascii?Q?LT6XweyhA+la8qwk+f5O508qve/tBJ9bI1Q/GX55O4ZO3ATfNFK8eeVEm7zg?=
 =?us-ascii?Q?3NVE46UVLq8xAppKdXezxlgXaQJmXZEFCNVzeGd9LOpuJdIOtGM7a32J70JA?=
 =?us-ascii?Q?Hr6T9lLSUZx9IYEW++BV3Z542ow9O3Yu2B3itakJh63g9z+fJBEgQvzJDOPu?=
 =?us-ascii?Q?rEZa5dDOhotC0xeyd4kRBgBvs/AARzSKhsDdwiugsbGp2VYwe7BEm/OeKHHl?=
 =?us-ascii?Q?ru15aZybjP/Qe9je8Am1W1gwDiXbhm+VDRIV9v9L/lZx31zADMFIVhOgHxnz?=
 =?us-ascii?Q?bI5YUJIgD9Ro3QDoL4ZzfdvAzM4nlhgfVrsUBStluOgfSHx5zBSEw9NOUwnT?=
 =?us-ascii?Q?wwsCdJH2isWmYbzd0pfmtmM0bQzJAxT4cK2f2jtda9AbdhA48z1uuSPIbWvj?=
 =?us-ascii?Q?N6zjVcbPFKpAYurof6vjUKnIRvtPjUZmNjGQbU2359bQQDE8C28dml/0N3dx?=
 =?us-ascii?Q?VNEi1juYnR7r3lw9wKmun7J+nFhVYBafMzOGB+GaqH7oyqxhCg1uHX9m1aKB?=
 =?us-ascii?Q?xck3IqchAkDll2Dtl4UCipaFJt0YlhHVN5dchq1rOkSgHjRbQdX0Q24knAzf?=
 =?us-ascii?Q?uCaSD4HUpbA8Kpr7WbqVyE2XvRyDtPLpHm9BsXaHZSDoWvf31C7i/qZjJZdP?=
 =?us-ascii?Q?UJSRJaC52iyllhpWCDnl1CMnIoqcjYMDTVVzxGWRDWqe/vHaAHC4meEhwKZF?=
 =?us-ascii?Q?/P17Tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BTXpkXj0YOLw9rq70fdovdwCwO4V4zgH7RZ23ICcaGIATw3LNYzsJf+fG/TFJOP8ks2vNjIn/dI7jTqG6SpBvUJlZkJP2OQ+RtijdevExbRwLslLQI8Yn/QPzP39f9MeKbFpiXXw3uzbmhfiJ9ECdTkGav5obhn4qRlVt50COIprZdpkztMMt8bemCelIrYEqR0UGyFUQZ5cSz7woaonwdVVjv+6ETpqxBjmbMfsBMbrK73zFicYKGYes1B4DlybhVb2GtWednJZBqVnyp1ahT6NehtVT3OzUvOBJm9NnfOb59wW2JmiJC/wmmEAcZw/sf8bocLyVn76sRmnkOzZ0vg8qLilsfAKHrmxDyH3Gj9fkLwYIcqGqjPNICeyq69pCd5svtzd+Y4Hz9H1dj++D2LkeQpv09bkvYEZAFZw+f8PACOHEaLIvC1Njv/5SvfJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 22:23:14.7749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91147f40-0c96-4598-d0c6-08de6829d164
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
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
structure that is defined exclusively for Tegra241CMDQV?

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

