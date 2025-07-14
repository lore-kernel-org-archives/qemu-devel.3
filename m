Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3362C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 19:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubPKo-0000uT-LB; Mon, 14 Jul 2025 15:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubO6P-00023A-JX; Mon, 14 Jul 2025 14:40:37 -0400
Received: from mail-mw2nam10on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2412::610]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubNyE-0004sF-Oz; Mon, 14 Jul 2025 14:32:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWB/4EovKfQ+T60dIy0KJ1YSm2K4bsEplqBUg4f0GXkO1Z8AVpYDvcIDPmIeLG7ARBoK6NI7wK2rzOfdA2FBkI71y0wFvOtP4czm/ZQjYszh7PzHz6cfdUPkJTNrU39hao+R3J49DA63AV0K1BEFG/THeVa30o5/zb/GNyzy1WPV3bD5xM/cjRU2Hg190Jo99KYQP0GcWjTMmEVhSp742BMHkb2s8SWgNtgwLTdEV6FEaC3Kk+9oxto0tI3+zcF+CzwqTcX631ymN4gNRhrNuUWYInBPJG6PZ9rMoguH2ugHosCbEgn3PqikkzWbssioFcS0lU3y5MxJ0kAKySKp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQaGA2PZ/Y5vNEuP8r4953CKW1nFOy72wsMFdfz/Kd4=;
 b=TQ7VtA2aM9Hy0F/EINmnSXGn9U7K7UYIx94v5C7WdFc/fHXY6fl96sokR5VOraw4BSXvV2N7LzoUwN9LsaUcOpzDPIAes183L201mg6vjjxBmnadhzSj72bbheex4WkUm3OD/g5yf4/doocZqURAo8FLRFWMlkvX0m3xOyfICdT9r0HFpzJCb46dHQDnDLG57bXSFP0tV+AChHjepeh6s3yGpY25S+iVOIjV6+zT9eIxqhbeBMq4WJERz67+Uy2PDFCe7Z7omCJY+uYf7MUMCzuOec1z0p9uHoFDRYV067gUntXja/VJvhd/b1iopodXV4uX0b0TwhtgqZ94mFy/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQaGA2PZ/Y5vNEuP8r4953CKW1nFOy72wsMFdfz/Kd4=;
 b=aYJooKOxO2+TDNl2si58hdz4d8c1hqIqpNZjnD5LWo18Cmh3vpctZv3R166dIQGl7kzBJovqRU0Iye5eCGGYgFYMLdOmdONUO4wnkJupExZs6Lpbn1vhhzARlGekfT3sG4gd1me/EjaulT1IHYAoCehMXKWZW95VSM9UFLitRBXiEj28FRRHxEEU8ERPbwAriAawPy8e/nK0kTW7D/H2dCee1wUphpble0O6kfvXRDmG8i2Uzn2oVUK03M+BA9eDchd570qVB4f8O9ZBrx3D+wMqIV0jvUpqLopAgfzUrL5p4PuzLPls31hhlp2AknAlvIoatHLlF4n6//e6FEkP5w==
Received: from CY5PR13CA0041.namprd13.prod.outlook.com (2603:10b6:930:11::27)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 14 Jul
 2025 18:32:04 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:930:11:cafe::f2) by CY5PR13CA0041.outlook.office365.com
 (2603:10b6:930:11::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.15 via Frontend Transport; Mon,
 14 Jul 2025 18:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 18:32:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 11:31:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 11:31:45 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 11:31:44 -0700
Date: Mon, 14 Jul 2025 11:31:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 07/15] hw/arm/smmuv3: Implement get_viommu_cap()
 callback
Message-ID: <aHVNDujZgP6BaKLO@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-8-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-8-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c26ad99-5499-4e92-4808-08ddc304ba0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MIRQ6HpyPatvvlTQy3OPog/ViEDPIZwv7goRYNyl0HeZJxUNmttnsMLc4+VO?=
 =?us-ascii?Q?DzW/Z/E06OK7+vogZ9SeiBYYeFJyVwg0t1y/+Nn9bkgpaJwKUeDkfEXr1FjR?=
 =?us-ascii?Q?XdsxrgyRMSey3JjQVl3VFqu3MYl210IG86E2fKpD7GNunExtiOkyIiwcdTaz?=
 =?us-ascii?Q?HDkAR4gPyj1O3rEQOXHLwePL5BzRD4POvp0UzgddRB3puUChQiCZ8Dr2VSmW?=
 =?us-ascii?Q?0L4jVvnYfk0jppkf2ljkZiCqNPVCUKVAJ5Ga7Ar4E/bUoTvihWQe8kenIJbx?=
 =?us-ascii?Q?1eimm/I9veJiVOeOOOWpUZhdeKWW7YebHmuITwksnTEOglGXifpBExviYqVf?=
 =?us-ascii?Q?n5U6FvxKMHAyqQ9LE7hWK9bMO2LLwPm3QnOL2hSzQR8wLSx/Vk2vlqzNqq5f?=
 =?us-ascii?Q?wBO0ORcUXzMItptyL6Flsu2nKVcnocJve10R4T+UarajX81oiBjbPnyVl40a?=
 =?us-ascii?Q?9Cup3Ak1wsSXRldFoHaFPIfqTvSvOJgIGzy9IH37bCqWhkRimhvdAArVllua?=
 =?us-ascii?Q?JYbaFM68C+LCzbmIrvRYkrUzv+D+P3gK6VJoKtPlzsEiDm9ztmf3O+DiwgPM?=
 =?us-ascii?Q?lFyEVwaRYgpSnxXv62m98dQ2yCQQgYniB+BQaugiGoMfAWeUo+4BzSsw4Qrq?=
 =?us-ascii?Q?yh8cPwiPmn7BzZSRRiNevEddD3Wvo6HKbREg6Cyd/RF7p29fstK5/7oGAFBP?=
 =?us-ascii?Q?c7MlW/LeHQg4foK28pZD4xob+OnklwfwfwSd3Jio4HXAhUSKCkCYZtNuHK5Q?=
 =?us-ascii?Q?lIDQEzmEfLrerEWxJhRO+qtwh++0j8QWMQYvDUmExTEbzIj+n8+VSxE9A2NN?=
 =?us-ascii?Q?3QJnLlk0PH8WJHAOMA8GDrJ9X3Iu4SnNcHDUG1JM7Rk2yKOwromJNleL7OyD?=
 =?us-ascii?Q?FCt+aSAfT3dTnWHj1V5XEu7fS44V0eyDReoiWNCBFPAI8LWqZNdeB11WoDER?=
 =?us-ascii?Q?JMx0AiNT5y2odAKiVOycugt3wKV5xw9ItKYGk8Mm9eTCfPr+qDcBE3dIhKk8?=
 =?us-ascii?Q?jEvQrYblY6Y5zWbo9zaW69a0+RiIr/q22/WsYV+UUVFcXx/5RyIwTbsMJUfa?=
 =?us-ascii?Q?jwDOzKBL72Ro4CjjCfpEobmJlmmJdgEng2W3+vQAqiZTa+R9Rg5wc9/AHt7+?=
 =?us-ascii?Q?Nzo5yWUdEbU4Ty1dorvnudxvFMKtE3u5abGAOl2GQUgkg9x4rgyfApjpZxGB?=
 =?us-ascii?Q?8VwJn1xmWD1PqS9VuaaUv+hlzUzf3jRORxIwxR07URNNTN4lHx1bazWsIp4H?=
 =?us-ascii?Q?9ucYP0xJte8BTv17si2z9rgT5quyngIukctAKGuJIzdL9apA45ZUpJ0S3057?=
 =?us-ascii?Q?56NnMeK5Wr5kiI+ztCRVq1PRIh6AyODzxpECT8QBTNiZNjVb9aBYiWGmAL6/?=
 =?us-ascii?Q?1SbaD5mshxSlA++7nHQXsTx812yew/T6Ig9pn8k5vGWWkGBU5J+vWqJ2d0m+?=
 =?us-ascii?Q?G1i1Z4HT9GomrsR45sr4B0VB0PbP3mdt+77/WtnWnuYIrPtNLE3c0i78DhLr?=
 =?us-ascii?Q?d2FODzKLeN406yv7N7h/+dtMqZwT9GIYTvOC?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 18:32:02.3716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c26ad99-5499-4e92-4808-08ddc304ba0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510
Received-SPF: permerror client-ip=2a01:111:f403:2412::610;
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

On Mon, Jul 14, 2025 at 04:59:33PM +0100, Shameer Kolothum wrote:
> For accelerated SMMUv3, we need nested parent domain creation. Add the
> callback support so that VFIO can create a nested parent.
> 
> Since 'accel=on' for SMMUv3 requires the guest SMMUv3 to be configured
> in Stage 1 mode, ensure that the 'stage' property is explicitly set to
> Stage 1.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> @@ -81,8 +82,22 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>      }
>  }
>  
> +static uint64_t smmuv3_accel_get_viommu_cap(void *opaque)
> +{
> +    /*
> +     * Accelerated smmuv3 support only allowes Guest S1

s/allowes/allows

> +     * configuration. Hence report VIOMMU_CAP_STAGE1
> +     * so that VFIO can create nested parent domain.

Aligning with the kernel uAPI docs:

s/nested/a nesting

> +     * The real nested support should be reported from host

"The real HW nested stage-1 translation must be supported by the .."

> +     * SMMUv3 and if it doesn't, the nested parent allocation

s/nested/nesting

> +     * will fail anyway.
> +     */

And I think the lines are wrapped a bit too early. Should QEMU allow
up-to-80 characters?

Thanks
Nicolin

