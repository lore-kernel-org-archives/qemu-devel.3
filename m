Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F26C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQuQ-0000m6-JM; Mon, 14 Jul 2025 17:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPHj-000545-Pt; Mon, 14 Jul 2025 15:56:24 -0400
Received: from mail-bn8nam11on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2414::619]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPHh-0004Mo-NI; Mon, 14 Jul 2025 15:56:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zvu5czgaEmljTet1cVdutNXOX22HaY/8xdExYMZHjuPiqox73+P62l/DLl0TBwjNFbpmUAQzHSsANCQy7rP+SGAQ5cWTJwabjwEn2AxjGSw1z44o1FMuk/Lxyv6dMh5IbmJJ8TMhghgChT9xK3EaQ5bP5gmf4nf7Yd3BWgn6ITz3rTEOyIXDVaMEnhYW42bVIXwFdo9Qm9fghUAishFsM1Upm/CGYiDYC8pXqQJgyU/JpPnEVhtRr3MIY7qNm24EsGyYBO6GyZLsvwRSJL4ID7FVkJ/QWA8qBNybU+1F1YE5EbSAm5qZkUN6Uky+1yw1pgw0w4HW8+lUfHe9NgeaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0h4F5lGLdYxi1DMVRzK5Rw99fNemsimhilRaoTJdt8=;
 b=JWGShNV9Tp07SVcHTB36W1/wQXzh2mEMp8BF9XVFFtO8NMYSnN4xRsZRATpLzJE0TrTEAwzWTJ7hv0boutKAQFz9G3nnViUpYq/vSeJA1fHPdcHPFjk9Ch1RxvNpT01N2jNVdASWBUYnqHuUIrDja+7cApW1RLLTAuDbue0oE0qHh2y2951HikVivh0ss/Yb/d2D+L0ZsoflTIz57JIvqMxnKeeVm3HWfmKyIHgAF+NPIkgjsuHf3Z5K55JT5Xeb2db62PSNv+r2WWLEIthRkLXs967R/PcQ76UHCSc+zrIJn8UE7aRE4prOYdE0SUubt9pK90mSfRF9j/Y7pDSy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0h4F5lGLdYxi1DMVRzK5Rw99fNemsimhilRaoTJdt8=;
 b=U453hgi3Zt4iQ9r6OZCw5LKVD8e7pGAugCj2TTDhNtXMhZOPH+9H8pC3mz721nNZ2ZRjwwPIM1MI4Xw1igcbKSSkIlLeTC/k5W1RRkCFJy6UCUwnAoR9XPXCQPoiTLVSR/ZCPcDSyodpAQhmBuBMqSEbEssVkjqxFcwYapl1H2CgAX7URFnXyEkgtKRVS2XybLKOm84wRSEfC1VyORnq8hZT2bfAEggsLmW7qyVMYC6mfWSkG+RGWlRqQXxcvpCThSMJC4HzXZlpF4Q6VRi6U6WDXhSaA/RAxOa2Lkb6mW7p61U7CyVDoJyJB/KDIcrmj8be4PwSfqTcOAeexdgFWw==
Received: from SA9PR13CA0056.namprd13.prod.outlook.com (2603:10b6:806:22::31)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 19:56:17 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:22:cafe::60) by SA9PR13CA0056.outlook.office365.com
 (2603:10b6:806:22::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.15 via Frontend Transport; Mon,
 14 Jul 2025 19:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 19:56:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 12:55:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 12:55:57 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 12:55:56 -0700
Date: Mon, 14 Jul 2025 12:55:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 12/15] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Message-ID: <aHVgyvi0ktXSCeEH@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-13-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-13-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 70069927-0739-4575-4353-08ddc3107e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X4xceJIHeIh2yfmX7w65Is5Ikc/FezHZ9iPudkcJ4+q5V6r3MdwgMi3mN01i?=
 =?us-ascii?Q?KBGyjKOutYBAJZTUbnJ8tXZ77WT+iCcoGjxp2yzohBvq6ta0xYD+OUdZYJyc?=
 =?us-ascii?Q?IV+9jN49cV/r01qRliQMkaifsGeTFuyUi+eg9eV2yfBT7gB4QquVUdlHc5LM?=
 =?us-ascii?Q?51HojHovdmrPG6iLuAtzME6reXc4ca+UjpQZz/19TKM0ougzTrUYgAQqZTv8?=
 =?us-ascii?Q?AYTPCjlrAaGpsncLSywC9QxI8Mc8Z/XYTDzbAqQNNLv+l0DwooG2Vc3ddOcG?=
 =?us-ascii?Q?NSha6K5vwsKkJ0JoQtiqsDJDVce1osS4nlR5j8mpcByvdDBgZpqCpSdmTZq5?=
 =?us-ascii?Q?LKZqXUMBfDVulexgrnz5tB+g9Olue/WDNj7XkFPBixpWdxNTHxo9pZzPpq4K?=
 =?us-ascii?Q?R6UBhi1p2Ln1mdIAPVBfn+LhfPP9iw2ShF/V5iDiSTdgDtRS1V8lG3oboLnv?=
 =?us-ascii?Q?9engeb1pJ5NOzsmpO9VvcxJo5TYPIsBjmzvsEbdG8xJR6S0d7q5QG0wrvFGx?=
 =?us-ascii?Q?6cBM9rZYiS90ORkLiPz5cxffQsDMGQhEpZH7wfuad240zTL7nOmbS5BqsH+z?=
 =?us-ascii?Q?seVYu48yG6kPYJkQbbVMe7dvIva/2CRNIYWhPOYDTXZ5PQrjs6bUi1YupWTt?=
 =?us-ascii?Q?XyQqXU0mJ2ZTg+A+UDVvD9CW8n1JDGAWtG27pLc0+0wBdLVA6BikOlk4+AKM?=
 =?us-ascii?Q?7TVfZH7Ef0/bElYId5R49da4G8JWwnhA6aKh1tpzuEtS+TTWdr+6G1PR3iie?=
 =?us-ascii?Q?NGvNqF5luF7JQhpzGqBpi6MZThLhY7kjW6MxaIZiA/vDRB6DEBRVUXbsCYlh?=
 =?us-ascii?Q?TA3jXRRUHaz1cKk4Qb3OjWH+1AcBe6bDizfiMQcuu5O3psem/uvMnfR9uzWq?=
 =?us-ascii?Q?rRjy6BwJOApqkCKYHG/Y42+2q8tiHxuqOm+vYOOCnRFqdFyKERJIMVOHbCr0?=
 =?us-ascii?Q?5WPtO0Us5bFlFVq0eZxBQAY/TZhc81GQ4cswGl0IuuofYImwr4NZ741KDKP/?=
 =?us-ascii?Q?UyBxiDrtx9scQWU0ZFjf3KMZMeecxDyXWp8jDy9Azr0rSxdGIX7k/71Ntez8?=
 =?us-ascii?Q?5kvYKopZvIF6CpSzNEubE20IXuSD+FUhhejlFnPznnBUIu9cGypJyBQxvfcu?=
 =?us-ascii?Q?ZclBZ5lpyalfiylxV2Gl/GqA6LZM0ynhaJwZvsA3kcgkwOhSzdf1UugqJrG/?=
 =?us-ascii?Q?FhiJeYtT+1VPrZzM01B9tHJFRTbpg1MjQbq1BG27eEJtByZahiJooW3PyaFm?=
 =?us-ascii?Q?2yqLWM0maV/fj4ugEwGRNtkbg3QebnYBGQpdS4q3CDnUZQCXjKHnBCKig8zs?=
 =?us-ascii?Q?NPoClgUzD1C3x69MZUBnVZESJrGRdpVYekWr91QAaRelb1jCJTW/wHS8uvYV?=
 =?us-ascii?Q?TXtTbVYtWCvhvfiutat8hw+c+yxBNlG0U/I4mLfdrz37Dc/xnMKaj3vDyrGz?=
 =?us-ascii?Q?9B4HjRHW9KcZOkdMaErnBnOdefDyuPSnINSnPCKgnlo5ThSMYZtS/TP6RXjQ?=
 =?us-ascii?Q?OchnFddYUjyclFJGmQLP3z3TKqxKECgQggmO?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 19:56:16.2858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70069927-0739-4575-4353-08ddc3107e6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
Received-SPF: permerror client-ip=2a01:111:f403:2414::619;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

On Mon, Jul 14, 2025 at 04:59:38PM +0100, Shameer Kolothum wrote:
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 21028e60c8..d06c9664ba 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -13,6 +13,7 @@
>  #include "hw/arm/smmu-common.h"
>  #include "system/iommufd.h"
>  #include <linux/iommufd.h>
> +#include "smmuv3-internal.h"

Let's organize in alphabetical order.

> +static inline void smmuv3_accel_batch_cmd(SMMUState *bs, SMMUDevice *sdev,
> +                                          SMMUCommandBatch *batch,
> +                                          struct Cmd *cmd, uint32_t *cons)
> +{
> +    return;

Leave it blank since void?

Nicolin

