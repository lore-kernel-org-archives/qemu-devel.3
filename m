Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BABCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 22:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vExCs-00005U-0i; Fri, 31 Oct 2025 18:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vExCm-0008WH-MQ; Fri, 31 Oct 2025 18:02:45 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vExCe-0000pN-MR; Fri, 31 Oct 2025 18:02:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlsdbcOqBoN/d4hT6HhSUt0KDRd7GpRJJrelnRuQkIl0yIwIo/qrejmCimxnl1QbrNGAtXL51Vt0MCDcQd8V/YMVxlUDEbhkAsgGAoyTxeOOxw6kkZNC4Pwr4E3iBDQhFU3e8GEhKXEvAICTdsN3a4oQifKqRdUpjQ0fg6OTqGW6zXomCPm+IL6429RaaEieCL3czul6XPOBhNMmUq7YP0JspPN7ry8Bq8bUkKE6ayeOVqxq/7ssL6jby1/A9NeWnytgowmfAWtd+nm6AypKDNs2SF8jI/587kYLAEezZpVezPcUHoAjhyM9nVncE836DDXMt73j009s4buI4q4Y/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu8+9di1/ngE1jQqlqyanUKAFv8ZZqsbfoH7OjBj4EU=;
 b=SWK4tfpdtV6obCYtbt4QFexDxAhzGhTM3d+xFiKxbmU0k1k9qI/igacE1MSDk7nY+wGK+8G6FK39RT7wz4o106X2FfkN9ICRxnXLAJ4P2bCCRnjtmim5arj6HDf6RU0SyQEBozzWgddHRWjbTIx6+gHIZfCvexQ/l9kk+Hh4gcW/l7CCnKZ1XqiGKEGcuPeA1vmnKcHG/eYSrlaqdrwCGKgVt8N0ELBMxXsUIJXPjyEB0oLvkEkwWrb0YzJLEOuiAbm4Z/BKtwihnvgjHqOIqjWuR2t1Tw6FQfIUfT7NXQjtZlRlsXKeOT26jRdkmMpbzbeAJC+FVrWDWHvYFJ59IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu8+9di1/ngE1jQqlqyanUKAFv8ZZqsbfoH7OjBj4EU=;
 b=i6IcOZ5dZ0RsDbq09NBgXNoEUZHf6GqL6K37hpRBZ26z+XW4tzrM4EmhQrQwGVEFg/43UjS49AlEbPVTe7E15nfEhTZ2yLlL/oblMaW8qRfKNi8IkXcmt9yu/8pE6NEjXjEU6reqBvJJzjLWump3ZYQF7oxxmUzqMYGQ5kDA1DfpFHtWgvKX53fjsF+L9kOKxtAyoSxc3kYA7JGLcUzvpOdRoD2QjargYYEHdJBzw6ePqsWWwRfdjwUQqINcmbOEwqFsNfXKL3GOmaBxhQvz/Ys4gYqzfWXer9QNOoTSguE4DTlV4T81lUpzp8wPiGzTsJ9he6C523GKKwv7bIjznA==
Received: from BN9PR03CA0425.namprd03.prod.outlook.com (2603:10b6:408:113::10)
 by DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Fri, 31 Oct
 2025 22:02:25 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::c9) by BN9PR03CA0425.outlook.office365.com
 (2603:10b6:408:113::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 22:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 22:02:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 15:02:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 15:02:08 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 15:02:06 -0700
Date: Fri, 31 Oct 2025 15:02:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 12/32] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Message-ID: <aQUx3e2ZtJKMgfnd@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-13-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031105005.24618-13-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: bab19fda-d6bf-4180-4ccb-08de18c92bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?44b4WXOBkM6UacLqcR9MOWVl/XywZxV/ZzZgTh/MdTFYILMKiKVVbOLTuXGQ?=
 =?us-ascii?Q?2twvw1pWVMELFnWuhetgL4V4OxiqgEkN31nx+jOf8QuGqOvHD4ow6GAX5ADX?=
 =?us-ascii?Q?WTOVeStUSItuvPfAzPKq1fAVwsxgU/zgsCQn4M2NUROMj1ixv9PPLTV9vu8/?=
 =?us-ascii?Q?QejSdhrwCGKdLasl4XWZmBsh4wYUsnE6lNj145FArm4DjKn4Ok3VmH2BDehi?=
 =?us-ascii?Q?pdNPTQdZQTtw9Wg7CaJvXOgISGr03j8CsNtoc+Z9k3K9u0xsHryVjfHBo1rg?=
 =?us-ascii?Q?Hc3/AtCFggJOJfrpcNS+XWV9Hh/B706HsDJQhjmIdESdzNEM+/OQyc76qtWU?=
 =?us-ascii?Q?sjt8pdGAJuX9gZ3BUctnmc2OR8jN3nYKNw0TE7c2/zEd6NF9UfrFIaWXjeTG?=
 =?us-ascii?Q?cl6hBHZrdgy1tZQteKe9tVmsVl2rVOqHdVV+hSHYxVCz5t1Wrzu8RS9BPJtl?=
 =?us-ascii?Q?4806cdm+TGR3wSK6MdJwWromPlVrj8uyPNFvRwfPXcRv3Y3iNLWWRJc07498?=
 =?us-ascii?Q?MofoU8NgtPIBObdXKjPVdjiBy10HNA5QPCBuIYW4UxJiWB+GxjsZVpwFzbXy?=
 =?us-ascii?Q?8Xv3KvyX/LOHUMSnDMorkpARwEQzwp68gqPOZcneQCKqzz/i1AJe1xQ0TCVc?=
 =?us-ascii?Q?v9Kh0QNaWPuWWHM4HiJ3hIe+HZKqUTTJC4A5zn096b2ADUhH86xuvU0FnAhh?=
 =?us-ascii?Q?wRCzo9MljAmGOFl9JiNXs5ikzChPa5G9KH6SlPUO1xuKkFdZwOdfiKSHnMHE?=
 =?us-ascii?Q?4nkxfPCRn5ExVAhwKiHxCJXmykTCtY5T3gQY89WA4ulP6Zhsrt5m4PH5QiAc?=
 =?us-ascii?Q?61J7K1/BhtdNhn5m5nHEP1Nc7wR7cqo78I2JxePBr7LFeq5R03Z2y2ObF5cx?=
 =?us-ascii?Q?JyfDr13nANG06dNiA+E4tg0LLRWuGLr72G1Us16I5BnrMEh3cXXPYTd38/f/?=
 =?us-ascii?Q?HIT+jxrX8/wHeaRvrWZznqEYW2R/kFgqr8t2PCSsDsVkTafBSNT5NfVS/H49?=
 =?us-ascii?Q?Ph+MUflNUOYpGZXym+nq52YUe8bew9RWZNbKuAHHa9922P/46OsFUz5YR9Tu?=
 =?us-ascii?Q?fYgCc6KQXh5KLUfGaZ6WCmN3Kjjos6XOhdIjs5isMBV+WhIBy0AVMkdDktVm?=
 =?us-ascii?Q?EZ8FjjpNGEaZ5wLcOSqE4Es3OsXGNJWEIdBRyDPKuB1oFplMCXzCk2bamCPV?=
 =?us-ascii?Q?5zyZzHLb9thAgMaSdNW2VrjK/nQ4rX/E6UqNGDzIwcZQOgs6iwMxfN8Mlts0?=
 =?us-ascii?Q?2c4aV6yJiyFnw4JyMEkGfTMR0LDSVnX2ISNLfhgRcnK8YHgkamxtGtaYzvC8?=
 =?us-ascii?Q?KfM+WjV0PK2C64RTX8vHwbUJxhbf6osrt5SlQnM6ZQIfhRX257eG9UAoLWVC?=
 =?us-ascii?Q?ZTRRvRTv+9gWJfGT0ASLUaFQp59yYZq/PhjaK+IQPVjZzyxvzEB4Bj6dLhvp?=
 =?us-ascii?Q?t/sjHabbi0/8AYmvtmfQpyr3cobDkVGZexog7qMMboG7/zqpcvBqVe5NZFZZ?=
 =?us-ascii?Q?yeVEXU80H+ZP4ySX3MJvJBErnZwOz9VFUJpEqfyjTnQup5CyC5e5yUyvq/Cr?=
 =?us-ascii?Q?dJyDvFS6KntoUffSyIs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 22:02:23.6379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab19fda-d6bf-4180-4ccb-08de18c92bf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

On Fri, Oct 31, 2025 at 10:49:45AM +0000, Shameer Kolothum wrote:
> +static bool
> +smmuv3_accel_dev_alloc_viommu(SMMUv3AccelDevice *accel_dev,
> +                              HostIOMMUDeviceIOMMUFD *idev, Error **errp)

Let's make it simply do alloc() on s_accel:

static bool smmuv3_accel_alloc_viommu(SMMUv3AccelState *s_accel,
                                      HostIOMMUDeviceIOMMUFD *idev,
                                      Error **errp)

Then..

> +    SMMUDevice *sdev = &accel_dev->sdev;
> +    SMMUState *bs = sdev->smmu;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUv3AccelState *s_accel = s->s_accel;

Drop these.

> +    if (s_accel->vsmmu) {
> +        accel_dev->vsmmu = s_accel->vsmmu;
> +        return true;
> +    }

And this.

> +static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> +                                          HostIOMMUDevice *hiod, Error **errp)
[...]
> +    if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
> +        error_append_hint(errp, "Device 0x%x: Unable to alloc viommu", sid);
> +        return false;
> +    }

And here:

    if (!s_accel->vsmmu && !smmuv3_accel_alloc_viommu(s_accel, idev, errp)) {
        error_append_hint(errp, "Device 0x%x: Unable to alloc viommu", sid);
        return false;
    }

    accel_dev->idev = idev;
    accel_dev->vsmmu = s_accel->vsmmu;

Feels slightly cleaner.

> +/*
> + * Represents a virtual SMMU instance backed by an iommufd vIOMMU object.
> + * Holds references to the core iommufd vIOMMU object and to proxy HWPTs

I read "reference" as a pointer, yet...

> + * (bypass and abort) used for device attachment.
> + */
> +typedef struct SMMUViommu {
> +    IOMMUFDBackend *iommufd;
> +    IOMMUFDViommu viommu;
> +    uint32_t bypass_hwpt_id;
> +    uint32_t abort_hwpt_id;

...viommu is a containment and two HWPTs are IDs.

So, it'd sound more accurate, being:

/*
 * Represents a virtual SMMU instance backed by an iommufd vIOMMU object.
 * Holds bypass and abort proxy HWPT ids used for device attachment.
 */

> +typedef struct SMMUv3AccelState {
> +    SMMUViommu *vsmmu;
> +} SMMUv3AccelState;

Hmm, maybe we don't need another layer of structure. Every access
or validation to s_accel is for s_accel->vsmmu.

e.g.
    if (!s_accel || !s_accel->vsmmu) {
could be
    if (!s_accel) {

So, let's try merging them into one. And feel free to leave one
of your favorite.

Nic

