Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B84C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 17:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtxw-0007hA-3Q; Fri, 02 May 2025 13:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uAtxr-0007fs-Qf; Fri, 02 May 2025 13:14:19 -0400
Received: from mail-bn8nam11on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2414::607]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uAtxp-000102-CO; Fri, 02 May 2025 13:14:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuM5onQpf0Bx9UbEoHT3n/Oh3bkY43MuHVuxWLREDUqeIFtALe0+mPEzzlEeWVBvhA72dONY6Ns6PYwEJ85SzLDUR3qX5yujzceRrSS8fM35S5jCXpCqSqBGHpqugk0AknOcARVhj+gVQHDNcIU1z+STTS1UcL3vZdWDAqoetdzQHBc2vDKfUu29c4Gwq0RYUewganitqWqjYSpRvULWP0jaIhk2tzxfkvg4nKcP8lA/A7oivs2v4p618Vcfewsz9Wx6V2mAms0ys/gDDj+qomh2qXZYqSRV2ykeJ8dt26WU5LUkJDyiTo1jSortQXLi52NMPOFC2/t7SHGtM8FNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QtpQBq571OnFxS+0BIclI67KL8U4z6kfdkHzfarB/c=;
 b=GhAxztS3hSJdnAEzmtlt3Cr2kMikZZK0VwLfc07NmJR4u1k77KZ+cf7N3FlBVcIdY1k5zW5F3L96yea2sJbBxk+zEu+bbKeA15erAn7EJ1fRvNo4b5wWrGvZ5CoRuT1RDZaXYR3MZIJdkb4CHVZNxkVRgSf0/CIuSSzq1TrmwgzovXyLfnnPKJun4+h79cJm+MfQiOUkSrqvyO5aGwDXaHGAcLn0+zi7h9q/eGGibtTvXzydP6Ez2+DyIRhA/HSbM+w8lgYU3bBvDtP5J6aw42FLxtKjrb+fREfrzcg6wOwYGb0csFGo3GMpNBVSfAPViaDK+l9a0BBR92rQ4MF8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QtpQBq571OnFxS+0BIclI67KL8U4z6kfdkHzfarB/c=;
 b=YfTRW7dOS63Vw/lyORINm4kEmrOoAyueFo6vBK8RaCFfpC47k5jio9h8RHSj5Wm6QyDU4CIXVWBRkCmA2iMXOZOaeqhVmSyE4uegc3R9y5mwHLl4q5gpvnqEqzrJgWN9q40w9JKkuKWgQVV/hhjOyxo3LSfPkrAd99EweM8oYrLI97YgfDgr5j9TD4p3EmEtXXnY1xjXimf55QulWVxmYZG3dJjBtQIRTpwG7wMT8+K3a6R31cTLX0OhMr6Unkv2zl8coXKeLD7Ci3gCeQoqZDlg8dRQF/YN7ocGlpdjRQzvNhsOtqYNxrIsQP6WTPjCpCOMo+9ZuNim4ap2IeHKSw==
Received: from BL1PR13CA0353.namprd13.prod.outlook.com (2603:10b6:208:2c6::28)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::621) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 2 May
 2025 17:14:08 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::da) by BL1PR13CA0353.outlook.office365.com
 (2603:10b6:208:2c6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.18 via Frontend Transport; Fri,
 2 May 2025 17:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 17:14:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 May 2025
 10:13:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 2 May
 2025 10:13:50 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 2 May 2025 10:13:49 -0700
Date: Fri, 2 May 2025 10:13:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2 2/6] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Message-ID: <aBT9S25tQTVGKkii@Asurada-Nvidia>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250502102707.110516-3-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 906ab8b8-cf8f-4178-5cc5-08dd899cbed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yTcMoXQLcddQwv9vcA2acre0+Lyp+n6najIWU9oNLQVHbSWu2nM+tzGWVX4R?=
 =?us-ascii?Q?/j+Z61QyVRFtz594C+RFpSkVD0eT3xtIkFHwvpSu74IoVGAvolnQHrrvuK00?=
 =?us-ascii?Q?qUt/lnghiWypVoLTYUFXxCvbWvjF3hRlhqC4/fMj2y4ZHfrj+R57msgPIHFQ?=
 =?us-ascii?Q?hWcWm/PtlHW+2mjM+Y61WYY/dcp36v4tb4HirCTqhJx+l9f6slM7b+yeI+m3?=
 =?us-ascii?Q?D4RHQ0gVJ9KGBkGbSUwMGvn3ep3IkrjE4eD/BfHwfWfTcG4xwYBImRGvptEx?=
 =?us-ascii?Q?9k1SvVq6EVpbDZdSP6MTca4Roe7QH+TZFQVz2p+fiuhXBzLNF+mgTZ8E9w7+?=
 =?us-ascii?Q?dgw07Ile24393iiiUoPmYAHCZwiuW3QvcjpTwzzHC4Ha0MkcBshAwbg4pjWz?=
 =?us-ascii?Q?D4mP+8h/SeSQMrUy7/H/jP1hbnGSft4QXPqq27sXf0ABOnJGMbMKkvFWeoJU?=
 =?us-ascii?Q?IrIaQkcsuOhUTcjMPMOrt1WvhchMlrpdCr73hn5SX15d3JzlvxHCgfKF01vR?=
 =?us-ascii?Q?vjqxQYtuGf2wTefCJJSfLKNqloDHqa1OJUayxgfFpp6PwzNRw43+I80sf/QY?=
 =?us-ascii?Q?FSB9YyKJ+Tp0MLHyijdhSgjO4QUkxCjcmhdWhf60/2UzZeBaHo75uZQ2sAB2?=
 =?us-ascii?Q?P54QH0f/dxpS7hfyBa/S0GNVW9njkdwFyMw++VaH2ncGU1yo6LNwENOT0FCV?=
 =?us-ascii?Q?czbF37W/LhilBB7hb9HFMvkRDj9ki7+TtYqGqq4T4bNSHcayovl1RM/6/fYw?=
 =?us-ascii?Q?+b3hK86idE9+Gs4I4wsLq5kvILRQAd4fMu7xIU1zoqXIoYlNt8XTfEgEHPoD?=
 =?us-ascii?Q?WTPa6vTIYdT8PnPD3mIMRsZo2h8rWpRAoABvVmd9TIn8uKndnWuBvvGoEMoI?=
 =?us-ascii?Q?3928bn3JGHrInAC2ABHGVBVt3VsqrXskdNWszcXSbOGvTFwDKaj67/SM0RpZ?=
 =?us-ascii?Q?0jSck4CGqZPkfYsQ8b1SGOZqk1wPm8VQrvCihjd/FgJgzkpzBUCYQVMFObnD?=
 =?us-ascii?Q?YiziujiAUZPFLMnqbMQzYTmALao6Aomn+kJaw+wBLkwNbKAHLYl71DQiHriE?=
 =?us-ascii?Q?Bp9FpLSL1jNGDLwXraxQxt+1qRN7JYxB60gMbQp+x/j1rNOG13SyPWH/TxPD?=
 =?us-ascii?Q?fGRg/YqP9yDCyrKkVmSatTs/ulOnn3HBzqsbeEoPeB3bYGt3SZskTh0N3/3j?=
 =?us-ascii?Q?1R2e/B1YkEfpGRKYOOaGUtcd5V/iRGdH2bmdgFSHs1w3nFTmp/jNFbvygtrO?=
 =?us-ascii?Q?VffGOnpcErvx5aiqb3qPdiTNCDuUbLzyXzYy2jCi5ddCHb12I9y5MaZKyXh9?=
 =?us-ascii?Q?Q+rMFrzcXitGbcoN5W8FnVs9Gsf+4mcfwNb01p1yiJrCHVEDQvCO1qc5/rje?=
 =?us-ascii?Q?zZUWJ+mA+hzzvrgJLi0XtUsrlI7tQ2w8467QnsCOqPxbSPXvWLeBwPn8kWb0?=
 =?us-ascii?Q?EGvep63ue1gxV6rQl8fuSke9FLsTYWHQMKwYRA5UOBB//xJC46aLiKXitq69?=
 =?us-ascii?Q?cyInG4RNYNBzozzZPzUwU4C1/GIl3PO7fs1o?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 17:14:06.4218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906ab8b8-cf8f-4178-5cc5-08dd899cbed9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8
Received-SPF: permerror client-ip=2a01:111:f403:2414::607;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

On Fri, May 02, 2025 at 11:27:03AM +0100, Shameer Kolothum wrote:
> @@ -43,6 +43,7 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/acpi/tpm.h"
>  #include "hw/acpi/hmat.h"
> +#include "hw/arm/smmuv3.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
> @@ -266,6 +267,75 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>      return idmap_a->input_base - idmap_b->input_base;
>  }
>  
> +struct SMMUv3Device {
> +    int irq;
> +    hwaddr base;
> +    GArray *smmu_idmaps;
> +    size_t offset;
> +};
> +typedef struct SMMUv3Device SMMUv3Device;

"SMMUv3Device" sounds too general, like coming from smmuv3.h :-/

Given this describes SMMUv3's IORT node, I still think we should
name it something like "IortSMMUv3Node" or so.

> +static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
> +{
> +    SMMUv3Device *sdev_a = (SMMUv3Device *)a;
> +    SMMUv3Device *sdev_b = (SMMUv3Device *)b;
> +    AcpiIortIdMapping *map_a = &g_array_index(sdev_a->smmu_idmaps,
> +                                              AcpiIortIdMapping, 0);
> +    AcpiIortIdMapping *map_b = &g_array_index(sdev_b->smmu_idmaps,
> +                                              AcpiIortIdMapping, 0);
> +    return map_a->input_base - map_b->input_base;
> +}
> +
> +static void
> +get_smmuv3_legacy_dev(VirtMachineState *vms, GArray * smmuv3_devices)

GArray *smmuv3_devices

Or maybe align with the non-legacy path, i.e. "sdev_blob"? Or the
other way around.

Otherwise, lgtm
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

