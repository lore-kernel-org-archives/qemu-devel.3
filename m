Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3E4C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 18:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueHPk-0003YE-QR; Tue, 22 Jul 2025 14:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ueH0x-0003GF-0w; Tue, 22 Jul 2025 13:43:02 -0400
Received: from mail-co1nam11on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2416::62d]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ueH0u-00031Z-5P; Tue, 22 Jul 2025 13:42:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZEYRROJIV9e9qpaxFqVFT66WPau1LN4YvgjblDdLACIB3IIpCEmtgWYx6ifMRMcX+Dycrv1iUdE+sYH8GWvAfNW2BeQgey1iiR44pndC5QOEuZMmcmZ0hcrYon8UYxGX/ToegaKigJwt7JotFQwx4kFhULXeTEvxY+A2/bMSay2o+1gTFGrF4Eh29Sd6gGzYzdT6ker2nA7pqVrf+7GtGPd9AQQZzqcSHyu6hl29RZqf0ZUke7VmngkmBGUqOEbTbZk7oYg8z5p0Qf7TSXrv9nDBxUsIKjnJHuedtINWSusTw58P3qHWXa/msH/dx5SB8FkT4HvtK1UK9IAK4OKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/Yk9h2HakD3tFxdmazP7WuES2aNV+0bSfjDLr3wi+o=;
 b=pd7yXA9EoN2LB7SnMxM9gLyJ9Ka+hpvu7JbS9O/7I/f3ITIPx2P5OXKGsYDAB+ysNhRPrsoWY+Oys9gJfGtj+KwaiLxfSgVDKOD0JqlvitG7guHHRftWR/76DAnVHcozO92+IGCkO7U7dy1o2H+45ifdYREGSrn7asYzJdIrd8cCFN0f6Os1KHkfSu0+cmb5byukOecj4MdTLld+DJE6LsBRagfPZ+DVhhuZ3mp30BaUgW2wA8uFw+4rpFWpgdz0qzhvXtRR1PoYwc/jItKE1QRiZ8MlzkBqJeYxdCx6H1lyetbP+e3nFF/A65HL6k35ESfed/WtpvcHprNfj6UJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/Yk9h2HakD3tFxdmazP7WuES2aNV+0bSfjDLr3wi+o=;
 b=IzFXrixGPAB9TgZsXZSISGGwfh/dhp8w/1ruCw4XlPZq1gSt9aEOGgIxxXT7wmhiqIYoyW4RPbEnwd9sy7PlpWkvfDJ9A8Z8xTKBl8KAuxuyW9VYA2ymZeKaJNsfGAlD1vPPYdqFJL3JSRrs2VYz7RQycqEcvMX1w7hOTr3fLRAVxGukDuFi+h/vc7KQbhfk/1AaMaKl0dxFUUzPHND9k3nFN+gNpygBLR6BOM++P7qpcoe2mGjGPTowB/1RSctRdvmXxrRIK7Fy25/34kQgfn/EMwx0t1mrBr9qahMLS3/bga51UT1m/bk9J2C95bfj4htdmLY5YszViOXEy3Emhw==
Received: from CH5PR05CA0009.namprd05.prod.outlook.com (2603:10b6:610:1f0::15)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 17:42:44 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::44) by CH5PR05CA0009.outlook.office365.com
 (2603:10b6:610:1f0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 17:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 17:42:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 10:42:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Jul 2025 10:42:28 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 10:42:27 -0700
Date: Tue, 22 Jul 2025 10:42:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <aH/Ngn5BnmaPz0aw@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8a2cab-5423-471f-c4a4-08ddc9472947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sw5sv8V4AYr1VpXtktIprfqVdFHd5YAbFkyPVsIZ6J52VNiNDbxDDr71kSKW?=
 =?us-ascii?Q?BLzsYsaxQPrxU07/F8ZA0GzLVQgY0ywzYZc94ThA1Z0g7RkY5TFFb8X1iPZl?=
 =?us-ascii?Q?pTkINGr6MUWUZm5HIyh1Iyazd/7hSIgAgomn3vA72EEcNq8TN07LekhKJW3W?=
 =?us-ascii?Q?/ndGmTP6/Cq5s++JQCrJGpipBLRfK1UUeLVoDX0ssNcjZv4wLdPWaWn9w00I?=
 =?us-ascii?Q?3xyOJzg+ImKzYJh70YBeTpbFHcNzWYGi2+njQo2C4gqmjlyHUhMEqwSQ2mk4?=
 =?us-ascii?Q?mWU3rGzL2ONKFkpvXjmYLdteEoPZfmvkuf1yO4fxReRdnNQIeq9XVEtZxMky?=
 =?us-ascii?Q?aS+FyFjWD3ca7IYG4Oyo16F+7B7Fuc9ognKRbJ/qtn2OlM0rT7Xx1S5xXmLU?=
 =?us-ascii?Q?2egZBKDVNEUaabNjiFA2qchuOo7mdb+N2462hsSmodg2PcxnbpZ/We19wHqE?=
 =?us-ascii?Q?be3AXJkVpqwSjE7PzLsOAYRM0dgqHQqmMpjzIVgO/frbqCil2BKr99M7xeye?=
 =?us-ascii?Q?IxmGqkDD45KNfsDAgEedEBytaXAdicknk5/UDWSpcSpsVWGY057IgSNnv5eM?=
 =?us-ascii?Q?Z4Snz/4wxXf8TkfEkH2EthgZn15sZ1pQdLmyRHJeUvcrqY1wYERpBEJCLtgb?=
 =?us-ascii?Q?/lZ+vJ1mo3/wQYBUmaW3CibSMfUCN/YpKf2Stia5AkKPxLLB1Ky0yr0Jxc1i?=
 =?us-ascii?Q?I2sNvOFxuIZdX6Mpi6ZjI2FiGcdlUqC+2kz1VAdf29fAr14xHTXMh8l6PPQ7?=
 =?us-ascii?Q?OMZ2tjpsSe90BrMQ2I9wRGDOT2MZB699CmDIgmpXMZL/kij9C1Yto+agBQxO?=
 =?us-ascii?Q?qA/0foizOu2gnBMOpYN5oz3bZuz7pY2O1UJGGnRnM6Wp/RLtMJfDLpyWWW74?=
 =?us-ascii?Q?zmNTNbKKap7Nw/4NO8W5KPH4TVD2nMQA+TsxgDHl+t1a3ay3ayA4BH/wTpwP?=
 =?us-ascii?Q?/4ChBe+com37T9b/eSjMch3eT5KR4wEwpkaR0Zwy6FawwzfcfhAYSuo/Jxak?=
 =?us-ascii?Q?bIp28vkuFaZYfkJDXp0eXrUa5LpdcfPwlXzDFcqwM/E2rE1oMp47hntHa56T?=
 =?us-ascii?Q?Qq2r6C7+dXYLnf9EMEM5Fj+3EK2AS3dJvrfAOT2ckYnVSbo2Shx3KhvdelJn?=
 =?us-ascii?Q?0YtmwpO2geGH9CPL91CwAJbNkB27H5nBhm5tnDxueQPZNEIv7q4NBK7i9S4X?=
 =?us-ascii?Q?frq5DnhRFbNbLO05O9id19NUJ9oX12QV/o6cCX5NIb0vwNQLZ8RybkU2gizL?=
 =?us-ascii?Q?zyM3jxbRohdeF1pN8QOC1ts0IzBk6gms9Y5IeKAuA2fxSa9sCrjoHGcc5WRF?=
 =?us-ascii?Q?8ldF74TUFYfrNhPfIiYykbNZmEqWsxrEQqoyagoPB1qROk2xaObgG7ziXC8p?=
 =?us-ascii?Q?mehsbIGNXCW3pu/N4bVZUBO4GCj6HJFliN8uLBy8WjcKALClyCPSM+ImHe4O?=
 =?us-ascii?Q?PXh3VjAq4QDYB5QQeuOjDxnSAp3s/UQaTdBNbedzuXXZzFVRh1BcNRqFovRd?=
 =?us-ascii?Q?epAtNV47mwas2KsIiR4W29Pzg1/sAGaw+ZHu?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:42:42.7464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8a2cab-5423-471f-c4a4-08ddc9472947
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4
Received-SPF: permerror client-ip=2a01:111:f403:2416::62d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
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

On Mon, Jul 14, 2025 at 04:59:40PM +0100, Shameer Kolothum wrote:
> +void smmuv3_accel_init_regs(SMMUv3State *s)
> +{
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    SMMUv3AccelDevice *accel_dev;
> +    uint32_t data_type;
> +    uint32_t val;
> +    int ret;
> +
> +    if (s_accel->info.idr[0]) {
> +        /* We already got this */
> +        return;

We can avoid duplicated HW_INFO ioctls but probably shouldn't return
here, but just goto ..

> +    }
> +
> +    if (!s_accel->viommu || QLIST_EMPTY(&s_accel->viommu->device_list)) {
> +        error_report("For arm-smmuv3,accel=on case, atleast one cold-plugged "
> +                     "vfio-pci dev needs to be assigned");
> +        goto out_err;
> +    }
> +
> +    accel_dev = QLIST_FIRST(&s_accel->viommu->device_list);
> +    ret = smmuv3_accel_host_hw_info(accel_dev, &data_type,
> +                                    sizeof(s_accel->info), &s_accel->info);
> +    if (ret) {
> +        error_report("Failed to get Host SMMU device info");
> +        goto out_err;
> +    }
> +
> +    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
> +        error_report("Wrong data type (%d) for Host SMMU device info",
> +                     data_type);
> +        goto out_err;
> +    }

.. likely here:

> +    trace_smmuv3_accel_host_hw_info(s_accel->info.idr[0], s_accel->info.idr[1],
> +                                    s_accel->info.idr[3], s_accel->info.idr[5]);

The following register initializations shouldn't be skipped.

Otherwise, caps would not be the same after a system reboot.

Thanks
Nicolin

