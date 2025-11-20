Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2CECF887F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMCVz-0001cA-99; Thu, 20 Nov 2025 16:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCVt-0001ba-EB; Thu, 20 Nov 2025 16:48:27 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCVq-0005wO-Qs; Thu, 20 Nov 2025 16:48:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCZ+3CxYMdwzusZ46r46KZAYXpNcb9O3+UsCKrsmkKe8jYgaDAZdcVGfjxJQsgiBTM/ZzcFRHy/sBCysUA4Qb9m6xNMCGUoTn5LDVJ7GdGdLJDe21xBVVY4A4TadnUC+LLo1dTk0JmE8wgMjYTnYC+Uw6SHiyk5Ht5OW/XYvVLVAhJTdxNNPrfNsx5qEvNtK5x29y1wMrSdClApys55Ed7ISz21sHtXB7cMWf0qSAByasWoLhr/GNy4nJ3y7sPwOqIrB6OTzDxN+vkU7+E61TXod2Esx9W2X3DbX/+Z2WvZ3vFrt2PllQnZOizsjwXGOxh16qg0svpALA4Wi0YDqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOtPCbV4m4N/Ge8sPSUqFFysuPueDvE/coGqKlGCk18=;
 b=Ho8yn2jw+BdDHyJDyuCEntcbNthBC9/uy3PQd6fFQkltzNlWp9bdhqscOr15Sn7JsMD/FnuJvyJjDjceTld/TusqrT3lr7wQv/mQlzlIjE91fLJhXj+ni4tudYlbJKZ9r0HeMcSu4kH5NmNYONiGCA+9muB+gtr5OFhauKrWMEAp/f8bKJsLp0U7tcmBdI9pcmixuN73Aa8BjxK4gl5uLX0ADbZWnrS3/n/jyGGVK+5ommWHXHJmzUkHkugX8xAYC0SqZNxGeMEtX8ilxtRIAbnyS2WR0JY96i2XOhpsBbv2r1RO3XOHDITYfPN7bMC7o2Ea2+sw1Q3FfNupnbdLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOtPCbV4m4N/Ge8sPSUqFFysuPueDvE/coGqKlGCk18=;
 b=Zq4jNS7kCX+94kEQEmkpInFWI/2cAnHK5H/kBpBK6ev29Id+L0dhQ5y9+w0SFO6V8ZLedEE4xH2k4SXTb0UsnOKbfSBRI3qoRaKujGSZzqmSP1ZSsxCw5Ai7/0aUjmn8H/0SaZEW0fE1KEs1ugwVcvwCvWSm7LQ4484Ct4xePdfjYJ+ldGx580RaJX59GEAsYgJyQvStO4O0aZ+JCEL/FwtS+o35VJNcVV3r5r++Mzdk80vjDz/smSP7MBrtChNL6bmzlbHw2w3kKzdKuFj/AHfy1lYRL007CRT9JbvRf7PhbitCWzbtqhI2BSIq5/ktoAILkgv7CfJeQwf+Q/dOGg==
Received: from DM6PR12CA0031.namprd12.prod.outlook.com (2603:10b6:5:1c0::44)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 20 Nov
 2025 21:48:18 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::7a) by DM6PR12CA0031.outlook.office365.com
 (2603:10b6:5:1c0::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 21:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:48:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:47:58 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:47:58 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 13:47:57 -0800
Date: Thu, 20 Nov 2025 13:47:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 29/33] hw/arm/smmuv3-accel: Add property to specify
 OAS bits
Message-ID: <aR+MjODa6/XFlCqz@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-30-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120132213.56581-30-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b67cf1-e123-45b9-dc2d-08de287e8408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk15QlBZbU05MlhlMzJMWWg2Y3NVN2JuWnZLaGtldlNDUzJxQ01wK3padDNU?=
 =?utf-8?B?Smp3Mmd6MDlPV05iNXFrODlkTVBpNHlTeUNRLzF0UE1IYXFGc25wUk1DT2Zh?=
 =?utf-8?B?UlFsSE55bkRXWkQ5dlZGREQrM3FMYzlwL3NwczlhQ0tTREhGK1BjQ3ZPVkxE?=
 =?utf-8?B?MlNKbURlaDc1dE1WSVFYNHZuUyt6ZWVWOGhsUXovNlZNZFV3dVFFZTNYSXJa?=
 =?utf-8?B?NWVmNllYTU1BREQ2NTFqTjNwWi9tQ1ZPbHVwTWVCM05pRk83eFR1cTJFcmwy?=
 =?utf-8?B?RjloZjIyTkNmZWsvT0tkMUJWeDJOK0JlblFSZmpJcmNHVXZwUEx3K2pLdnlk?=
 =?utf-8?B?blZlckU4S3laMGk3S09IMGJZQVgvNFI5S0ZHK0RKVnJIR1ZLcnpheEliUWx0?=
 =?utf-8?B?V3hlVHQ4TXBFemx1ZjVwSm5qOEZ3ZTQ0NVdWa01razI3U2dENUsrZHFvbjl3?=
 =?utf-8?B?d1Vwd2srS3YyN1lCN2JHVCtXNlpJUTMyMFhSZ0pkUXRic09YamhPZEtKb2Fw?=
 =?utf-8?B?WFE4b3dTbng5aE9FdjNjREVBZnhRWHN2L05wZ083MHhyRGNwdTUyN3doN0o3?=
 =?utf-8?B?OW9aUEFkSHRzQ0lZYU5ka0JqdHNlZHBqUnQ3MndGbzZnOHhrYVhETnlxMkQ1?=
 =?utf-8?B?djJSa3U1Q1RsdHRZbzlMc2M2dUtNUUxMSThXS2xMWEhJM1JuSTFoMkcxQ0kv?=
 =?utf-8?B?a1VqNGwwSHF6WlI4eEl5TTRlSWtqblZPM0drT2VoWHdlSENxc2tnSkV3dDdY?=
 =?utf-8?B?UlRDd2syRE4zc2FGUUJ4L3Y3WUoyK0kwWjUzOUJ5bytsN1FtUkZLS0NQWXJZ?=
 =?utf-8?B?SENwZWFWUExwRXhVeGcyNnRDb2I1NFozZEJlcXhrNDFESzBJMm5NTjNLK2Zm?=
 =?utf-8?B?ZWF3S0VrSm5PY0VSb1JoSVl4dTh5Z05Tc2hVdyt3SmxaNU5NcnN3VTByS1hB?=
 =?utf-8?B?NVVJWnlDc2V5dnVSVlhua3lhZlpUeDhZVGFFTFJ6V04vNmVRNEV4ZjZDemhI?=
 =?utf-8?B?eVVXZTA0WWRGdW1rV3JLZUVjY0ljR0Q1aGlwNUtlYUs4bERZdmIyczFYekgy?=
 =?utf-8?B?OGJxcmE0UVp1OCt2ZlJiZXVUemxTb2tsQ0NLVUFiSGpwdUI0YjVtL1djQ3Zv?=
 =?utf-8?B?TkphV0UwaHMyZ2hWQ2IvTmRHcklra00zMHhBeVJINk9HbTNXZ3pOWUIvaTJs?=
 =?utf-8?B?eHYyU2V3ellTNHNhbjNGbllpLzZzVjZyL2lHSFBGL2c5bXBvZ2tzS1NYUU9L?=
 =?utf-8?B?VkxDMFE1TmJZZ1FiZ2dCd1RlTXZsTG1NcW92NVZGeWprNERha3RjRlpQaSt1?=
 =?utf-8?B?Ti95ZWRHV1RHTTd0L2xIOWcxVWVXalNjNW1nRWtRaUtWendmc3YzSWIyV0JY?=
 =?utf-8?B?YlM2cE9DcElxalFTeWlibDI0TWdxSnpJaG92TjZyZWY5Y2VXc0pJV1pYNlBo?=
 =?utf-8?B?bit2a0R1R3NRWXJPcnR0MTZ3YytadU80N1MxUWZxdEJMR1RPV3JaMThiZ3lo?=
 =?utf-8?B?Y2p3cm5PTy9oYUJYckVQT1JmUnJvdEZ0Q285QU8wYjFtTkJsSllvcmpkb2c2?=
 =?utf-8?B?UEVpRlFvdkFpYTFtUUxVL0NlYXFPSHZSdUJVNVNUSUhiUzYzalJtLzlQN3JC?=
 =?utf-8?B?dno2MFN5VksraHBrYlg3SE5YakJxRlFJcFV1RG04THVnK1BkUTVxZ1EwaHlw?=
 =?utf-8?B?MHpVRjRRTWpwdTZ1QTg4R1FoMnJuNTByanZYa1MvQkhxTU5MWlh3N1I0TC94?=
 =?utf-8?B?M3V0ZzJjcUFELzBtZFUybHF6ZFBQR0NrYTF0STg1S042ZnJiUDZlbmczd0FG?=
 =?utf-8?B?Uzk3Myt0VnRmc29BNU1nWTlYclA4WjBIWHlTa1FkMWl5dU1EYjd3bXNVNVJ5?=
 =?utf-8?B?RlA5OFNYQWMxQnZtZDFFZU1sdnFKQ1hySmxJUHpqZ0hNdlZ4SEZRN1ZEejRm?=
 =?utf-8?B?QXBKenU4akNoWUN6bW94bUlnd3RPR0k5RzNDMTcvR21waWFWMjZ1dzJmVXlo?=
 =?utf-8?B?MVBPeHlmS3BlT25aUEFuMGs5RktjSzVycCsxd0llclVlc21sb2YwNm9FZlV3?=
 =?utf-8?B?TnhRcGZrRmpPQlRvWnNEdStFcE9rWDU5MTFsSHJsejhyVDQrTlpTejBNa2dL?=
 =?utf-8?Q?+Zy8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:48:17.7933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b67cf1-e123-45b9-dc2d-08de287e8408
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
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

On Thu, Nov 20, 2025 at 01:22:09PM +0000, Shameer Kolothum wrote:
> QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits.
> With accelerator mode enabled, a device may use SVA, where CPU page tables
> are shared with the SMMU, requiring an OAS at least as large as the
> CPU’s output address size. A user option is added to configure this.
> 
> However, the OAS value advertised by the virtual SMMU must remain
> compatible with the capabilities of the host SMMUv3. In accelerated
> mode, the host SMMU performs stage-2 translation and must be able to
> consume the intermediate physical addresses (IPA) produced by stage-1.
> 
> The OAS exposed by the virtual SMMU defines the maximum IPA width that
> stage-1 translations may generate. For AArch64 implementations, the
> maximum usable IPA size on the host SMMU is determined by its own OAS.
> Check that the configured OAS does not exceed what the host SMMU
> can safely support.
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    | 20 ++++++++++++++++++++
>  hw/arm/smmuv3-internal.h |  3 ++-
>  hw/arm/smmuv3.c          | 16 +++++++++++++++-
>  include/hw/arm/smmuv3.h  |  1 +
>  4 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 73c7ce586a..35a94c720a 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -27,6 +27,12 @@
>  static MemoryRegion root, sysmem;
>  static AddressSpace *shared_as_sysmem;
>  
> +static int smmuv3_oas_bits(uint32_t oas)
> +{
> +    static const int map[] = { 32, 36, 40, 42, 44, 48, 52, 56 };
> +    return () ? map[oas] : -EINVAL;

We should probably just:
	g_assert(oas < ARRAY_SIZE(map));

-EINVAL is useless anyway in the caller that prints it.

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

