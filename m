Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ECDC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 02:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubsLo-0003lH-PA; Tue, 15 Jul 2025 22:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubsLm-0003jY-0L; Tue, 15 Jul 2025 22:58:30 -0400
Received: from mail-mw2nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubsLj-00054B-I9; Tue, 15 Jul 2025 22:58:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1+POvxAOwG0XNUapTLmius9jOBT3Kna6z/s9hmR017HcVN1TmVLNNlwYClcqu0DhMMAG7ZmuytMX00M+fdMh8nYYIAkpDmKZppyeTaSHfIf5Zjo2RldJv/VU/Zpe0gM5CHhsMzO3ucn+114SNw+5G+ETk1pZ06KvcKGNPd+UKM8NNlCj+4Ma7guTr12/DFT+YVOyhUudE4CnfWa+s+FYtL7LMBams50uaROMLcUqK0NO/SYqjP8ZEjjHJtM0tlQjogddImYgN9oo+lLTZtQpmpfuiPoHx+ChmQhy/nA/BgvaXsDiwS/+w6yr5BD+b/+tHQYec7QqsmC/Eb7U1QiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Wv/M+oCN+KnOoH8k4V2xqSmmvgUmWLyUYfg4BDQohk=;
 b=TFoTi3cFTPkguRzaF/12whFxcDRwMQw/xWdApL1rD8qWqfOYsmmI65Gc/3yy4v+lV/Gt93udpoQW8JMfBHWcJYUmUBYAlvT4VIwaJP6ED+P+48jxDadxT5crdAcC42EFW94GohN9TloFtXQk8eq6oHazBXKSd0qY+Y0takpO6w0NvbYzcgb+voW3zPVbf6CyRwmsdDpfC6xGij5uYZyK1PVL3BkZNQylao8xfdDfhmuvLH8otsqVndin935UeRvzVOviWYl5Gb2BKOAIZzW7BjsFy5s3z3of06NOQcW+l1KI8YfJ2oBzvhjOjrHiSgz38LKf2DpBBcp36yabIkdr8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Wv/M+oCN+KnOoH8k4V2xqSmmvgUmWLyUYfg4BDQohk=;
 b=EFIzVynZIZvXRdJ7Bkqwb8kJD5USFrq7z1IBK02Q5mW/bCwzqHK/dRy1UZcAAdPplpBYZHNMvZekhOx5QTl6+eq9LspvUtVJEsVKtn5K5nOc6kzAsZNx1vIqjAQIKAJoZwP2CjQ9mNK0bxAHo+YBoGZd/Tyc0vDTgc/2W5wNbm20rdNcAVVTMalP7YXpygYx0dR5b+OHjIlR+SpyuZqkQuqU0hia6kx04ELDmKnR/s0vOP1VfZWESHmMqV8ynm9YwSh+QEliP7+PIcH3spPfDO+qEk+L7D5F97xgG7O0y2aCQBNgizWo6U5LyDEPBxTUXsXJjayMsHckdyZMoSGHTg==
Received: from MN2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:23a::23)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 02:58:17 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::67) by MN2PR03CA0018.outlook.office365.com
 (2603:10b6:208:23a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 02:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 02:58:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 19:58:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 19:57:59 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 19:57:59 -0700
Date: Tue, 15 Jul 2025 19:57:57 -0700
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <aHcVNYtd9qe+sHAT@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f0d6cd-7360-43bd-cfe3-08ddc4149c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?hH7f9UuNYnTL4tT0/iZZOmQrz/Cebb6eObKCHkqkgSyS+yGJ8ipzvMT6Ej?=
 =?iso-8859-1?Q?IiIo3ewZHeRm5pUJwyqqfbFOT563zK0Iz2NdgKXZtlAyA9XJbvljLvmBtM?=
 =?iso-8859-1?Q?NpaS35YI8W7QA5ogMt5JwyfW6M1lRszSw2VeO2QIcGwbLDhcRn8Rbz6ynm?=
 =?iso-8859-1?Q?UoTQE9dEoCGc8v4YpaWUuatrt/xo3iXZml14angoj6BAh/v908TBRW77p1?=
 =?iso-8859-1?Q?PYikot/6Ck+U3sm0g8tb8qgXEpMD3pjAcOQfpoWPSEVtL+YiXlg5tjI093?=
 =?iso-8859-1?Q?FN4ll+MgN0W+/51TNRSGOnwdxnfkbiwgIX+ZRE0XxXHFuMNm5fAuZ1asZM?=
 =?iso-8859-1?Q?v9xLSYIXoTC7R27R5mSurz9o54fbR77EsZj/1JsClqZ8rFjFgNlASB3kda?=
 =?iso-8859-1?Q?oxokX4WwfW0m6MbWywtUmIg1rFFUz5meLbpIG4RaMzR/HnBx5cljo3kWE0?=
 =?iso-8859-1?Q?IwOPagCVgCeR4s3P1U5PWgq3IoXa2dR3kcUmAc6UkV0j7OGdkk9T+XYPHY?=
 =?iso-8859-1?Q?cp5SdRLY0zc5iUzkUA+1iMM6lfPefnpSHFlYNc2LYDTGtwH8PNgExr6HOc?=
 =?iso-8859-1?Q?aoG2XRpfWk7wQJezW104RxQ6UN+7WXWC1nt0hvQQaVp5A7J6DMGx+2DRPD?=
 =?iso-8859-1?Q?QggvvhW9/ueXp8053kXiphrv2RtviMtVvbUCVCuJ4MgNt8N+1pYkbKIgk+?=
 =?iso-8859-1?Q?yQCj7f1QuWDGaeaDOuvbSA2DxkwKGdEsbKHxKEeJ89DOpgs/WqRklL6SI/?=
 =?iso-8859-1?Q?5Hu473Yk3BTT9SHBSmmGdLP5JRQ3kna6lCGT09g5oDIQR7kAmKpfOJEjjJ?=
 =?iso-8859-1?Q?gYXFsz+e2pIJtWzWll2PgO6ikPeSDkGybnLHFqFwZDCT4VHZRASwsoLqfg?=
 =?iso-8859-1?Q?NX7FEJV/3wEes13ckRdnaTWA+qsNs7yL0U8w+vKgoDbvqMz4ZVMSi+XKit?=
 =?iso-8859-1?Q?FPTMJyTRIWO7KvwvciWLNUTgv6S9Jl3H33hSSZtbNRY3scrNpTE34VQFQq?=
 =?iso-8859-1?Q?7eoUr2eKqhL9oyrgO9MyTx/nsKfptfvyxCuyVexLNyCDENN/rfGBrbyh+U?=
 =?iso-8859-1?Q?UA+dkbcJdS7PI2sgk8zvFEyBdkHknhO+GDT0J4z7/eBfxx80Thrh2utGuc?=
 =?iso-8859-1?Q?Ht2wRG0H4lWXWdHPwa1DHwJV2S/uzaUKc3BPYTHqgnEd2F59Y/UEhX8g8G?=
 =?iso-8859-1?Q?8AfvRsgROxdk5IgLBocv8198HGSL2bS98q3oMmGJv6A98XoGUiFoZ1VeEW?=
 =?iso-8859-1?Q?dmTme5/L5BgThPoOMBPpf0220mSQNQ88ksM47f74r1UKnXpKYEocvP9jon?=
 =?iso-8859-1?Q?isgFhhca+XO6TBCKNnYQIrPZWQAnJS1lOLDrngZJOb6mfXLtoZmBOVKFmS?=
 =?iso-8859-1?Q?qnH2tEDfYPQ1+nbvleDxijRf+lEOR7KvC0cTyOhQxePm6hzwJmB39EWR6D?=
 =?iso-8859-1?Q?NytVKv4FBbLuB+qWqPW9v+e7USuPrXsdaSJKmiXaEGVnk2JdQUejioMiTB?=
 =?iso-8859-1?Q?oT5PHSo873h5GYNYLOqFV/PjhDJ35AdirbOyw/CVlA7dZj/8Y+1M+KMaxN?=
 =?iso-8859-1?Q?3lO2i/HBEbEbeV2YNnXuGTuQvavY?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:58:15.6381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f0d6cd-7360-43bd-cfe3-08ddc4149c5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
Received-SPF: permerror client-ip=2a01:111:f403:200a::61a;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jul 14, 2025 at 04:59:40PM +0100, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Not all fields in the SMMU IDR registers are meaningful for userspace.
> Only the following fields can be used:
> 
>   - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF  
>   - IDR1: SIDSIZE, SSIDSIZE  
>   - IDR3: BBML, RIL  
>   - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K

But half of these fields are not validated in the patch :-/

My vSMMU didn't work until I added entries like SIDSIZE, SSIDSIZE,
TERM_MODEL, STALL_MODEL, and RIL.

I think IDR5.OAS should be also added in the list. Maybe we should
update the kernel uAPI meanwhile.

> +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN4K);
> +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, val);
> +    }
> +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN16K);
> +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, val);
> +    }
> +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN64K);
> +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, val);

Unless there is some conflicts between the QEMU emulation and the
SMMU HW, I think we should probably just override these fields to
the HW values, instead of running comparisons. The justification
could be that these fields are unlikely going to be controlled by
the QEMU but supported directly by the real HW.

For example, if HW supports SSIDSIZE=5, there seems to be no good
reason to limit it to SSIDSIZE=4? Even if the default SSIDSIZE in
the smmuv3_init_regs() is 4.

> @@ -1903,6 +1904,9 @@ static void smmu_reset_exit(Object *obj, ResetType type)
>      }
>  
>      smmuv3_init_regs(s);
> +    if (sys->accel) {
> +        smmuv3_accel_init_regs(s);
> +    }

I feel that we should likely do an if-else instead, i.e.

    if (sys->accel) {
        smmuv3_accel_init_regs(s);
    } else {
        smmuv3_init_regs(s);
    }

The smmuv3_init_regs() enables certain bits that really should be
set by the returned IDRs from hw_info in smmuv3_accel_init_regs().

Doing an overriding call can potentially give us some trouble in
the future if there are new bits being introduced and enabled in
smmuv3_init_regs() but missed in smmuv3_accel_init_regs().

So, it can be simpler in the long run if smmuv3_accel_init_regs()
initializes in its own way, IMHO.

Thanks
Nicolin 

