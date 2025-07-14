Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960D6C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNum-0007b2-S2; Mon, 14 Jul 2025 14:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubMuY-0002Pu-EG; Mon, 14 Jul 2025 13:24:18 -0400
Received: from mail-mw2nam10on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2412::61b]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubMuU-00052x-N6; Mon, 14 Jul 2025 13:24:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qelaKA6aZrvMXLr/hVkra3hC9pe+2mUMLh/TA33DNxITSnOXCzD+6tpRQpGqzGebX/mWd/G3ZtFasJyQGfeNFcItchaxcP73m+Q4nkRf1Ht8qSIkbz+gakVCRO+ShJ5pokgVfkWT1Ae5UV8wXuTLAxmXTdq3uT63LX/20EwDzSJnwYbHNYAcfXawPL1lm/uHVAgl2y09Onk0u6rmR63nzNqyhOkSq0i/cYQ5WTKiXc2FfSxKPdN3zlAZwXGwmj8aKEjAJoFxzzsLcswXUzxA43qSDaktHVY9IjwWkBZDMN8jdP1jCwV0hiO9uLJs2y2BBtC6EZMYpM54IDuN29gltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMvBtzWo2o3YKgjOdVOVj+BFHaRpDFgoqw20zUK+CH0=;
 b=yOh9jy6ElcJ9iGXopIkcLu5sVPJqoZeAR5GMbu+uKU0Y2S+21goBWk/qctN2nktlJc+2ufUgiE7LE2KgsaOHdq4hvAHE7qgSx5mPaW7+9if88FoG1pj1ZKfmySQvSQO90Fwkq9B1hVGHKON8KptNP6+dAkUl5EY75443q4btPztFXJ5wZuLFJnG7RAxK8JUamKQD/qujuJHQ2VOtg/Ru5z1edNR91BmEhQGxXSvR4ibb3dVhDgJN7DAOszyepFm67zYUz+6eLhJ/6DRNkLp+k9L+Zh4w+Rx8T0Wy7B9R75hBcZga9gzXh6QAN26O915c7wc+B5qS6T2V1Gad99qQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMvBtzWo2o3YKgjOdVOVj+BFHaRpDFgoqw20zUK+CH0=;
 b=TuSqO0nQ6l8hTWu+pjlfU+RXMkrfzOQkxeiZyyxSDoR59TUgE4H82c6Eev7DDszstZe++XyLhK6aZa3YXBB8fe/xKNlJGhj/zm8nbPAuaNxk3x5WF3nCSd0MK3r1yc10Nx9b/r2KDqJEqrDC2NTSx9bh6ndphUj8mtdjU1hCsNr2MpDgGWGkl/47aX0reZRGx9b4dNNVNBwtvCblFpGwAbBYzwGDjPNDXxzm0mPG3r6zvIXZ9xnwrDvzDrU3vphUzX4hO4xjFOPmP+u16RqX0PRp3EpfmI5ifFMKBaa+uen1zUoNUsLJNjmG/OX7NwdiLp8FwfGxbujumbT88xmVfw==
Received: from BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::34)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 17:24:07 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::19) by BN9P220CA0029.outlook.office365.com
 (2603:10b6:408:13e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 17:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 17:24:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 10:23:48 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 10:23:47 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 10:23:46 -0700
Date: Mon, 14 Jul 2025 10:23:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Message-ID: <aHU9INgBsFgvtec+@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: a6afc41f-d0e2-480e-1273-08ddc2fb3d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ivl+uGDwQ2umFD3Wp42jCtzY6rRC5mL/795V65FHFIj5TnPhAQZA4+tcFitX?=
 =?us-ascii?Q?tMkoaxeL39t48OSBMiW2LU1xLj+rL9Y+6EHc8UL0c6CHldFG9wxAVnH/4QBx?=
 =?us-ascii?Q?KxY4F8JvPVDTU/Ujl8vXxC9w8WFFqNk31UzQQJhV39hO4LILEcmmYy7kHFyo?=
 =?us-ascii?Q?721SqF918lyKcAHqxeoT1WpVvkJcD+u+TQlvAv4dEpncn6wet48nU4d4hClj?=
 =?us-ascii?Q?s5PYLt+5s5HmSosjUe8a6A61lnTKqXXoAcTJgUzSi1h2EIEksveiWEPumlzO?=
 =?us-ascii?Q?jnhFqypKxcuMJfH7sJc1L0QWya9HXbuVGeDAnMKC9VxPBcR73dXiS+6tmDxE?=
 =?us-ascii?Q?yepSEWDXKY9Ud15OAANG0qs9qPTVFk9Ni3ZU5QEzNPbiSBtW8TMy/WEc2w7i?=
 =?us-ascii?Q?e+MB7EjVdpjGzcYxNBs+qLnFGva55Vd2gqJ28UomMASD6jCEDc+IVCOHayxv?=
 =?us-ascii?Q?UVJ2p9bEg8QfuUzYEe6tR8e7K32LBwBXdPGY4Tj2uDMzRGC1XioReVwvI3T2?=
 =?us-ascii?Q?pYxMdoRiJO/NfhqAfUzWwbnMYQK75nKZay9KlmQUfzk8KroOervmt6Zvzn0s?=
 =?us-ascii?Q?t67xgq4Zd5xmYIphaLLcSRlQlw69z+9+yvqTsboD8dVumFU3Uaey/jtLMU19?=
 =?us-ascii?Q?kw5SoZjgiML4E90E5VFQ0vvgBTn8vuRiVEWMI4eOK/eLhyphPtpIK1+2i7o4?=
 =?us-ascii?Q?PjfRPpCmNGqImHJaO/hrxtD5Uo6Xt6al5amYghoMGCV5Yn2+OtHNyp4vAXCR?=
 =?us-ascii?Q?EyAUjcYxDvRO8mkerqz7pFUfQvK/Ydd9DIEwGxHUEpVbWPe24J39DeW/PYjY?=
 =?us-ascii?Q?pguX+q/nHYoPKNn+ybZuFl+0d43eMJOH3ZfqqpFyKO4Ml9aOglrXQ9A1quSk?=
 =?us-ascii?Q?XtdkQxhLJ/PPhkBUIJ2EKUxVgMzpBR4LfTPlVXujD6VGxVV7YQPELyZb7QqG?=
 =?us-ascii?Q?KWtgOJ5KkJUIuJERSdLI0CFI0cFkaNSldratx6mmDUAqu6TOahZKsCfgnMy1?=
 =?us-ascii?Q?koAV0eWVLYNm+UekLx3mhGOE4WzOpMeGRnZ4yojJE90qq3qy80TEwqGtvVQl?=
 =?us-ascii?Q?7TwEyGawgmIlL04cYEStcMyhj7WXpi2tqRM+CPnYeMtFK7S7t4K91aOaulo5?=
 =?us-ascii?Q?eO/mg1vo+u8JRTiULck19gXXrAg5B7zh93YMrbicv4khMVhzh7EwDR3Y01Cw?=
 =?us-ascii?Q?8UqQ+WS5/rGd8tIQ6/R3F0Q3BLQyUmV8LypDaA9WqYhKo1/KzuwOyJuwwrYR?=
 =?us-ascii?Q?vSSsec3w/TIz28uQJQhuFB2UBAQ/EOQ0bBjDVeQJOjYiz2wRlEhScHdAgI+a?=
 =?us-ascii?Q?MLQKFcayExDD0UWanWHXijgO1NxDlYCyBfUEM71oMhzBUUtoVwwh4Y61qFt6?=
 =?us-ascii?Q?NXqRb8AjPT5KcerkD9z5wi6i5TMWJq+XVt713JW2GqPwmJx1t/JarZHXYvpV?=
 =?us-ascii?Q?4ctR0O3PQ67pRJGF/kq6jdi4BsN5wcOCDqt2XFoNNTH1ROs4ZR0MMQv2v88X?=
 =?us-ascii?Q?nyjhQypKdVHbo4OMQPjJV+GYkVkpKVlHpf09?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 17:24:07.1846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6afc41f-d0e2-480e-1273-08ddc2fb3d14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
Received-SPF: permerror client-ip=2a01:111:f403:2412::61b;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 14, 2025 at 04:59:31PM +0100, Shameer Kolothum wrote:
> Also setup specific PCIIOMMUOps for accel SMMUv3 as accel
> SMMUv3 will have different handling for those ops callbacks
> in subsequent patches.
> 
> The "accel" property is not yet added, so users cannot set it at this
> point. It will be introduced in a subsequent patch once the necessary
> support is in place.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Overall the patch looks good to me,
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

with some nits:

> @@ -61,7 +61,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
> -arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
> +arm_ss.add(when: ['CONFIG_ARM_SMMUV3', 'CONFIG_IOMMUFD'], if_true: files('smmuv3-accel.c'))

Wondering why "arm_common_ss" is changed to "arm_ss"?

> +static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
> +                                                PCIBus *bus, int devfn)

There seems to be an extra space in the 2nd line.

> +{
> +    SMMUDevice *sdev = sbus->pbdev[devfn];
> +    SMMUv3AccelDevice *accel_dev;
> +
> +    if (sdev) {
> +        accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    } else {
> +        accel_dev = g_new0(SMMUv3AccelDevice, 1);
> +        sdev = &accel_dev->sdev;
> +
> +        sbus->pbdev[devfn] = sdev;
> +        smmu_init_sdev(bs, sdev, bus, devfn);
> +    }

Could just:
    if (sdev) {
        return container_of(sdev, SMMUv3AccelDevice, sdev);
    }

Then, no extra indentations for the rest of the code.

> +
> +    return accel_dev;
> +}
> +
> +static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
> +                                              int devfn)
> +{
> +    SMMUState *bs = opaque;
> +    SMMUPciBus *sbus;
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUDevice *sdev;
> +
> +    sbus = smmu_get_sbus(bs, bus);
> +    accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +    sdev = &accel_dev->sdev;

Maybe just:

+    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
+    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
+    SMMUDevice *sdev = &accel_dev->sdev;

?

> +typedef struct SMMUv3AccelDevice {
> +    SMMUDevice  sdev;

Let's drop the extra space in between.

> +} SMMUv3AccelDevice;
> +
> +#endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index eb94623555..c459d24427 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -162,6 +162,7 @@ struct SMMUState {
>      uint8_t bus_num;
>      PCIBus *primary_bus;
>      bool smmu_per_bus; /* SMMU is specific to the primary_bus */
> +    bool accel; /* SMMU has accelerator support */

How about:
"SMMU is in the HW-accelerated mode for stage-1 translation"
?

Thanks
Nicolin

