Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D23C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNNA-0006Ls-Sg; Mon, 14 Jul 2025 13:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubMDD-0007qW-Un; Mon, 14 Jul 2025 12:39:32 -0400
Received: from mail-co1nam11on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2416::625]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubMD7-0005pv-8N; Mon, 14 Jul 2025 12:39:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hO2i/+kJAp4DL47c7m4BEUJjq6vPsU+lBGLmjfIkGrYACaBwkXMHgCLPYeNY4OeIDsfKSnMXKYFJcyWchJd5YttJW8fQVx82EWzJp2oB7R7Ksedb83oPKZVCWtoLCobBs7oHP7MaXnMNxtIU0ez4f8hmoh8KCzDgXhbDvfnkeEX0RL6Kfz2VKjwQ4eMa3KpWc74spJruL8TUm+YFtrZBCaAf5mpR7zv2WTrjOFCmg2gG6hn5gW7SiZ9vqeD8ksWLuAV95RcKYvKQYfmbrB8iXg2iyb3o0MQRvoqVu/8dSGarJcuRtk6ZqVvjyXxrvWgwcPYUyyj2f95xxM6YZ8pXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8elB4FViWxDRPKvX8oafm96KP9OxuE9oMVssvsAvjBE=;
 b=so9Y0y+nGmWysfBqRlp8T4Ry+8X7fvduwpHCvxPrpndutGnzsE//px8Be3Ox2wC7sXuTIJn0SWF0rrtUJZwYDoj25qyLrSXKjyycRoGKxT05Z9UGqFt4OE3NuU4Y0VUqAjBfWRNmg5jrDB4xW6t68rPK3+Vx+5QaSMDt12Ntt4MB5aSodrYaDv57rphIZtflw+BFIJtTDQmaclVWkNBm0v87UESq+pKAc1kr2ESVHhI+pB8vh3tDy7oZYuxPrjVpVLgd+WmHkUORzxyEHukpMsNH6LRdn5HVo6OhELM09Zr3+A7cx5RvKwcp8KfyH4CcyH2A93LvEiWPlmFTzkYw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8elB4FViWxDRPKvX8oafm96KP9OxuE9oMVssvsAvjBE=;
 b=axzn1pHpDvqTq/aQFVr4HtDz1/yxV+Dlkn/weiuVtiw/+ZbruEkW6FYJ+tnlfZF2waxTXt+vUrLkkWhGNGvsoXqhCaZTp09pVm/1YsgriuBjL2fXIXxdyD0VLH2SScPCIyHjkkxgs2weKI62U6dRe536wPmZURGsjVr5wMqzb37h4GCdCyqGurlQXnQ4Xo2wFC48MyvonUWjx669vH7o2mswBcCof4zff5OybRHInXZeRqgfdlAWDOY4HiHsfu3rosPhSwTNNjQj/59Et0QsOB7cbwxpmtmYc5YJgj9IjaCijrSK6E4ycdSOHizHSELXeVG7J3nrT/wO4Sa9CVRsDQ==
Received: from MN2PR22CA0023.namprd22.prod.outlook.com (2603:10b6:208:238::28)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Mon, 14 Jul
 2025 16:39:12 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:208:238:cafe::d5) by MN2PR22CA0023.outlook.office365.com
 (2603:10b6:208:238::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 16:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 16:39:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 09:38:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 09:38:49 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 09:38:48 -0700
Date: Mon, 14 Jul 2025 09:38:47 -0700
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 04/15] hw/arm/smmu-common: Introduce
 smmu_iommu_ops_by_type() helper
Message-ID: <aHUyl5hZKOeX7E+m@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714155941.22176-5-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 69044cd6-c193-43c4-e4c5-08ddc2f4f602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?WW0s6i6stMfH4IAV4FkB9St9gNO+Fy6dOgr7LIaacUH0wNRhOb6ZSJuzls?=
 =?iso-8859-1?Q?E6leOfoK44JnCtWhSxseELv8ohAPaLxUUr/s7tkpfVIAwJOIeCNjxhL35s?=
 =?iso-8859-1?Q?PGKh/WkoNU3jmxnK5X8IOSUwsQ9s0lUPtvfxSPMAWJ9dypqo21IPmg4M2k?=
 =?iso-8859-1?Q?dQBfkOe52u8cZBa4MYhjTE6SmBXyjavHZ0xT1u+8haCs4G2dkvsRlrjPed?=
 =?iso-8859-1?Q?o9oXKYYhcyGCBHGajrFQSIHtru9OzamFyijqtYVM4+8iHMt/AGiAUWEDUV?=
 =?iso-8859-1?Q?YDBf/l38qGMq7ySswPNbSea1S+gtPSyoWSVjJ+YK2ccOjkbuSfh1Omf0zB?=
 =?iso-8859-1?Q?yPUyUmz7W16tbaQxz3ROZiYwnO6buXsDnr/PB2ELq4K4AQIO2LcgSVX67x?=
 =?iso-8859-1?Q?ebxK9WxnxFuAt527htuaDUES/ajCXmqH/xPdYuOSyUVX1kqxAVQMXpKwux?=
 =?iso-8859-1?Q?vfmm5T0EjYjnX9YbN5njjaZGXDwvN8eTdjeoTg9lLihT46g/8JVLIf9o0m?=
 =?iso-8859-1?Q?Xq3PmAHOAZORcAG8eZYMtcfe3IE8k/LIntzxUrwypZMwZdKb0lFJYgisxh?=
 =?iso-8859-1?Q?3zdhS4fMvJ+ei4XQ8n5KIdSzSmYWeYFlAgFFaTiNRUXFAnwV8xllMvvFYb?=
 =?iso-8859-1?Q?It0Ig2Hah6Hi+S6giyIFEjbeBReskW9dv+X54atrOLnjoMh4M6+Sa1oX+x?=
 =?iso-8859-1?Q?T4xs89MJv4ZqHgIexNL5PFQ7cL7C8OvVh61rOVfYLC0Ed+qRCYYOfIKpbg?=
 =?iso-8859-1?Q?iZ0niP/XgaUDmUzzpfpms7aDKw/wiHc1aJVciDb5YOCtzXhsmOrTwGWejX?=
 =?iso-8859-1?Q?hFn7nzVZthKxbLWOtLaOYeAkdftQe2VQt2+/+RRk+uMNh0L8nv+80P419Z?=
 =?iso-8859-1?Q?KVKfEtwzFcZcBX8AafsQhb7pDoe8yf+gIm8sQ30QoOWPXUZJhU9eDdtr6v?=
 =?iso-8859-1?Q?HZmXOM9xb4klaCwwIIULN2VA71mpt4f8L0cXMt/YzqhJzQaK8g6uBCTBss?=
 =?iso-8859-1?Q?M9EoDE21fzhAdeaM3+M7mfcfYUv00MYqpnAfAWBBUuEV2qDCpF9z402YYo?=
 =?iso-8859-1?Q?1cM0zUl0IhyMYJv0GwJAXmd37rk8Np+PSc12Pnsx8gdF7k+0h5X1b0dODL?=
 =?iso-8859-1?Q?lu5ebOo4GtUzUCWyM5NX4+lal8qkhEeudOdbQqgWZx2ifRU8YWigIgofBH?=
 =?iso-8859-1?Q?gQyrRJetc6mHMdZP1JH2LOPT79Z4pgRWJwtIs/E8krDEcr1fMVsKWB7FBB?=
 =?iso-8859-1?Q?yyw9DMdYp3S3JfbxP7cvpV6mOktotcCOnTzEg5GpBB4MNx3IxJ1T/DRswJ?=
 =?iso-8859-1?Q?QWRfK4NE8LIgAQDgqyzqQDd4gKHLBP2xdJsgIKHomcEsiYEZRZO/NDww9l?=
 =?iso-8859-1?Q?/AM80j/G+s9hVgkIpj4AFsiSjEvZPKgTr+g6MMUgENRO0oYsoVAuPK9oBx?=
 =?iso-8859-1?Q?pjvAh/qRht/wcdmNvruKeQlAwrdFgDan5mQYsVnj4uqyi+sqgR5SxbMOYr?=
 =?iso-8859-1?Q?XxzoYwmsUO5VDK5YzJwLrFvgPzdkoFH/GJ4fOaw/q7ihO7Yip7Ir52AbVk?=
 =?iso-8859-1?Q?DzRa2Cxg1tRwHXjoo/J7TAnP4u46?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:39:10.9910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69044cd6-c193-43c4-e4c5-08ddc2f4f602
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
Received-SPF: permerror client-ip=2a01:111:f403:2416::625;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Mon, Jul 14, 2025 at 04:59:30PM +0100, Shameer Kolothum wrote:
> Allows to retrieve the PCIIOMMUOps based on the SMMU type. This will be
> useful when we add support for accelerated SMMUV3 in subsequent patches
> as that requires a different set of callbacks for iommu ops.
> 
> No special handling is required for now and returns the default ops
> in base SMMU Class.
> 
> No functional changes intended.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> +static const PCIIOMMUOps *smmu_iommu_ops_by_type(SMMUState *s)
> +{
> +    SMMUBaseClass *sbc;
> +
> +    sbc = ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMU));
> +    assert(sbc->iommu_ops);

I have an impression that QEMU uses the glib version more, so it
could be g_assert(). But I do see a lots of assert() also in the
existing code. So, just a note here, not a strong suggestion.

