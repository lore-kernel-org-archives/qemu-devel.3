Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE73BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 20:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5z7-0002ff-Rc; Tue, 11 Mar 2025 16:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ts5z4-0002eS-8J; Tue, 11 Mar 2025 16:13:50 -0400
Received: from mail-dm3nam02on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2405::606]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ts5z2-0002tF-5j; Tue, 11 Mar 2025 16:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xINBJWCoJBbjCKr60cezmzpaT6A03fbrh0OiVyMMiPONMvsF1gtkGETX1e7MOcObghxOpFGdGtrWQlojN7vmsQkhFEmkAZVcdmxDLBnQ6o51+voPWoVd6PDzho12gIHd/BSdkI7f3jnSjpuiuGjPlP7ASuXY5KJu540Z883n27wcEWoZVwqXA++0LZgVHD7uEVZPub2EUX5+dh9ON57sKBSkx7+Xr/MQ0bEoeHVx87lFZ4hosoSQGqb8/krj47ZcUZRzCQtixNwDK9CLAe73wmyhb5mL1APVqzkBvEWH5PaxAu6LCVfszMIf8z8TK4wa/g6iho2oc/2Uk0fx14wnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npwQYgOzRkwfLHXR6BMImYs3HR1o29kh4449RfVSIu8=;
 b=Tdy5KvBRY30curkIgP8SRp2fSw9BAvPH3IG2AkOrymj/oSzAbGgu6UkB2eJ5dJFPP+xzgcfYVDOXwojgKttl5i4m3TAzFss/46l/S2MJpclU7hd649Ckc4kYyaXRxGDCjCrwq3D/ZflpmZ034t36Qjtfxr9uJ3/6x6GfTE3FUhk0dloK3RO2R1C6dSuTuZXVX3Wy4+3KclDVGXZT/bqHWjLOeN7E3rNWeyrLD5fDECeqlqSNXVIxruC0iRb+MDUrK3pv9Yj51tuWkPmO3oAPD7/mon3wn0sbnrKLadvdxJAIBI9QhKa+BoGuw2LxBqSr9Cu3fYWq+6+8jEjTzu/zqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npwQYgOzRkwfLHXR6BMImYs3HR1o29kh4449RfVSIu8=;
 b=fpiKvlSAj+VWGeM4tgAdx8QxUIsVLXUrwbAVzkAulo6De7iIpmWq3WrWzcdOrmE4udB7K9t0k46PI7GyuN2FMCn9HK9xJGm8smqvqJtmRIL0Ko4RjwrWjSYj7f2ZRULCDteR9btazJV179n1Gm8OlpgfJWICqD84wMMMw4S5FRAnmX5v0mWq2m2y9IZLFOF/Ju/1wIJktei5zWYvYSKcUW3WCHTTvO8Uz7w0O+gtG2B7ZDoSXW221MTwp6eV4B6bs6dPTZUK5l+nAX7oIST7J16ATtKhaQDXqsOeQa+VGz5J73AmFlkaSfcfm1a4C23L4EO7hrBW4fhEWDByj8PdYA==
Received: from SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:13:39 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::e4) by SA9PR13CA0127.outlook.office365.com
 (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.18 via Frontend Transport; Tue,
 11 Mar 2025 20:13:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:13:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 13:13:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Mar
 2025 13:13:20 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 13:13:19 -0700
Date: Tue, 11 Mar 2025 13:13:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Message-ID: <Z9CZXQ4O4TtsySY0@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: ead70c37-b8b8-4c4a-70dd-08dd60d935eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8xQuS0e3l1mPVr1d6l5VgwBj/G5nix8AiDWxWE2NlUyl4mm8yUh63r1x6Q4g?=
 =?us-ascii?Q?YWUTLepAa3g94rWsQxoSF4tbfy5dizQIL/WAW6j38q7NfMl1tNLwBWt+iiLt?=
 =?us-ascii?Q?ZNH4xQ8NZT12V+xMTTHGb6AsDtsnyxszIQ8BY9epAZiCu2g3b+N7JEgdodC2?=
 =?us-ascii?Q?Poadrc1Tmtw+5fG/oSkrIA78HwcHcJsbkra7SixInQ27ZXFHJrX+YEg4dFqI?=
 =?us-ascii?Q?DNvn8YpU+3KdeLmD9xUKfcYnxv9dFvoI6FN4qW7LMigcutC7BB2MzMzu2lee?=
 =?us-ascii?Q?vx/Njlbrlczq2OoaPGzgieMVz1zzjoSWPtQPavsMGGj99d8M3dCZfn3GkqFT?=
 =?us-ascii?Q?UIZxmON+k4VkJMK7H/zXsOr7PbqBuf+YNEQi3lchv817tnY5bcKBZeDA+FjV?=
 =?us-ascii?Q?DPZxQfntGPRbH69J9BJErOxx+nDMysTZnjiN6YQlUt0smH9bkxjerM8JNbaT?=
 =?us-ascii?Q?GiEBn0CzJVXDHgv8DUWFsOfcPBcwEzAADnTSLos3Vn5qACvXh9ISMkp36Kqy?=
 =?us-ascii?Q?l9LbHrosbvb4qCocUrysyO4zeZCz9l6821mvrL85MTSDaTu020DjKNAQrGsz?=
 =?us-ascii?Q?/HqfPOFnRJde37Ej+w3sjfkzp4CW/+buOsmIa3qVcNaLCcOjyVPhMpR8ne8z?=
 =?us-ascii?Q?vcLqocSaORb6PkBpUJNeb+y7X1erkHVVoenu9kPUVcPOvL69jYgustgfys93?=
 =?us-ascii?Q?3gprNNIDsDsuS5GKy6aBzgCUhXMVSBz8R2D0cdc50B0Z6KkHm+Iw/gn1qAPU?=
 =?us-ascii?Q?xr+lwkgQnb+Yws97ai3toXmochFsNuEr0ftTdG+50OwzzCglClYPeMBzoPhi?=
 =?us-ascii?Q?+03oHOAnOT8sI9VQNMFNK9XgrPvZZoo2Rcr2BNA9QP/vTUunI5KbdYoUMp85?=
 =?us-ascii?Q?HHcSpWd9wGK8CeKXqs2kS63XwIrvOMpqy0FdnI43F2j9lcn7lOFoFisMnWtd?=
 =?us-ascii?Q?AI8+/c0xY28kBa4eqwwx37PLCzXxXzJ7S6Szh5QH+2PE+IG5KIlPvPxBDl1t?=
 =?us-ascii?Q?FjHsYQC2Y6FriVXf4ddqFvE4Sz4MHrNGrIk8AS6XQy1H3lYgYhhUJcQHtvvb?=
 =?us-ascii?Q?AlAyOv2N2ulDYCLP/EFSyD4ZRZd9Zhw2foVqUumiOoxMjaWa0icJ1kKhFP7y?=
 =?us-ascii?Q?oWPwfQ7gAA1IG3UfvdMBCLLZs7g9Q1qDPzNd20EYmhPTzgQ/sB/LRS3Ybxta?=
 =?us-ascii?Q?8/cnfCgWTrT0GofEgbKiMPAgjOXriKQKVaV1555+Yxw6s0fdPNg8QqUydfad?=
 =?us-ascii?Q?Oo2T1VEyb+p1MI8N2w9M0P1OGQeQIyyz9mKQxi2KnI/N1hbZbN5cTYqIsb/m?=
 =?us-ascii?Q?/Iz8zczW7fD/+rtGO3UZyR9logBRZbg4t7ipXPOssWywXtJ3Kw2W7TwUZb9n?=
 =?us-ascii?Q?yy+Cmdd6GUkempxzpf2TF9GyBXGRgcm+zgrlt3/6VM3ezaSoRdeYo8JXnJcV?=
 =?us-ascii?Q?JCtg0MmPgCcxbru3sVgKeg6xa+ZKy4iwj+FlqshCxpzFutlm72ide/8ekgwL?=
 =?us-ascii?Q?iLJZReHY+xT5cVM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:13:38.3864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead70c37-b8b8-4c4a-70dd-08dd60d935eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34
Received-SPF: softfail client-ip=2a01:111:f403:2405::606;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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

On Tue, Mar 11, 2025 at 02:10:28PM +0000, Shameer Kolothum wrote:
> +/*
> + * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
> + * Copyright (C) 2025 NVIDIA

+ * Copyright (C) 2025 NVIDIA CORPORATION & AFFILIATES

> + * Written by Nicolin Chen, Shameer Kolothum

(Thanks for adding my name!)

>  struct SMMUBaseClass {
> diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
> new file mode 100644
> index 0000000000..56fe376bf4
> --- /dev/null
> +++ b/include/hw/arm/smmuv3-accel.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
> + * Copyright (C) 2025 NVIDIA

Ditto

> + * Written by Nicolin Chen, Shameer Kolothum
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_ARM_SMMUV3_ACCEL_H
> +#define HW_ARM_SMMUV3_ACCEL_H
> +
> +#include "hw/arm/smmu-common.h"
> +#include "hw/arm/smmuv3.h"

> +#include "qom/object.h"

smmuv3.h seems to include smmu-common.h and object.h already.

Nicolin

