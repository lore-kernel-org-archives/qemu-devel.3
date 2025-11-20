Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E31CF887F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 22:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMCr5-0007jZ-26; Thu, 20 Nov 2025 17:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCr3-0007j9-AT; Thu, 20 Nov 2025 17:10:17 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCqu-0002bB-6l; Thu, 20 Nov 2025 17:10:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4TmQ9g/xU1JbEmKHXsVT/Qp3tPeEiWVUAH1/4WeU8pR70KY6gDI4lzdc7BZYYz+UIvf0OCX/uU8pNasR1MWxJfbbBW7XcqPJWXLPMljXJasOex5B2M+RWJujOB23rWKQ2DRF+VV2p2qia3jPxYGSXSZOCaJ8TkpuR0j28CqO2RXbBLJo7Y1WMsXe5lJ8FizclXNKJm+ctaD6mEBVjTf14xCSnXmzMpNsVXdLUg9b4RP7xMNxQxyBzBAtZIKefHlw/v8QrCiIOeg8i/mx6VPUwhcWaeic0k1IkYbJTCGy/Q3KRQP0LIYsfAWJhHPkC89Lq8ymqTSVtqGpgGh+oK9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3sGT59m6ofT4TBRyEEWisxnvWTZP3LNk6BHlPpkonc=;
 b=UjgKAxHqedQo49p7CKNwERA/y+P+pNM9sDqXsyQZHTkYuIw1Igi7hlJTSpRJmFWtoQTCLsExmu1dZ/DXK4jgKONIFhKCzLmnqfS353rYlgw08pApHLKWisWnxpvNEkpEkeqraZzyzaVpwqKwdu8LWGGh/3snd5WkfShJ+rsp/TYna1Qht8UQhyoMK9j2pWKfZCbiE3KLjxINl1NW5TfMhk6gf+CKvZsHfvNVs1PpxqZrfIasoLdGkkOYC3Vj/ghARBmJMNvT0f6T5x72/KIm88wePm0GKf9eWl/BAmnUq9CF01bJ69P5s40h15dRY31bqCd+TlyGzC3lK7m1rN8oQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3sGT59m6ofT4TBRyEEWisxnvWTZP3LNk6BHlPpkonc=;
 b=UnD4duyncEc7OxXwnY/2/IUr+WeBXtQVYaRSbbN5Q6DGzRg/qEBlVVYZzHpGNLGHn8kA1zPqtHqVT+1bSzT1a+4KsJTfYbLW8ZdfqmhEf8y87UdW4q34yJ4bwelrJvy98jyzXOp5iZGSqXXfnrtsuDz6yJruW2Vkey73GAJuY9BdNf4tTiNMArfvNOyMYtoek2wjtnYWClsP3wB5FBtnct2JPP5XqYGEmEuBm2IqGW0VR7hqZovASvxXTu46BCZMpcOHOxbwwvfIXwp0S793ZJBGdkeUnQhyDa5wiVRE8MaVyCjqiChzYh3s3Zp+5olE0BUmayToBZBQMDkVDunP+A==
Received: from BL1PR13CA0124.namprd13.prod.outlook.com (2603:10b6:208:2bb::9)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Thu, 20 Nov
 2025 22:10:00 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::b4) by BL1PR13CA0124.outlook.office365.com
 (2603:10b6:208:2bb::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 22:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 22:10:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 14:09:37 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 14:09:37 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 14:09:36 -0800
Date: Thu, 20 Nov 2025 14:09:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 33/33] hw/arm/smmuv3-accel: Add support for PASID enable
Message-ID: <aR+RngqP3HTLZIlH@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-34-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-34-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ca2f66-daf5-476e-1d43-08de28818c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZhMpamdIFtLKTn4wxiqCR/2vgw9E28wBRCU/nReWz2HMYP2SGC35T7DhMoW0?=
 =?us-ascii?Q?PMMWdFVy+5r5dDmbbutTk0bONT9UI5/fqDavyJSDMzXo/1rJDHW7M+Y2IQxO?=
 =?us-ascii?Q?OkFTdw96lVtehj4tqjbXOindpQbUj6oQD3kt9meYl1SMSRvh/eLVAq2gqIMm?=
 =?us-ascii?Q?aXLfqmCXFzcAnnT1hST0zaTbKKEL2zO6MLmFwl4L+SWQWYYXvuNRlqFm/3NF?=
 =?us-ascii?Q?3yckP/oJz0KaVARgZKrAic34oVlTtwWp6WPoFGMTstpRTJ4wysJINJW7euN5?=
 =?us-ascii?Q?BKE7yAYgSbk/UIMzQ2r6FZEQMYtDCcxKV0zIGh9YHiR3lrDtsUuWicVRHs5m?=
 =?us-ascii?Q?fl6UOhD2pWx4m3o/M3P1bi+8jofksju//7eTK1GdKFiiaQIIEUmN8jSkuU0h?=
 =?us-ascii?Q?rk41G+hOBbz+Ut+MeUcTQEHbg1jl/LtHpDMOHLGfRDRPzcJRIpWWaTHVILJc?=
 =?us-ascii?Q?uegzLKRxR0k8TivPDl8Y0c9GE+1UjNE3olJOdWOr/rb/0oqMrpfeThCIw+o6?=
 =?us-ascii?Q?yyXqXxlT41p8U22u1keOK+92d5OwDQGGYDgI0P+7IWjagip6XGYbub1eqUSN?=
 =?us-ascii?Q?D70lrtPjs/Bw0B4SJYYuRIRBdrhumdGN3Sxj0fn7rciaAzRQGS63X0MUlGUQ?=
 =?us-ascii?Q?IllFcSezC/twJYaAQFAsGyzH/LdUqwU24OgiH6FppACQveDtEF6ZpotAmqf9?=
 =?us-ascii?Q?2uglujpjtDUXb0WQMmxqPQHE4R/rpvYC5nO2SpHoj8FW237NZpyZty6pFNUW?=
 =?us-ascii?Q?B658UGD9WspHONa/mDuO73/Tauye/ROCfu2FbQ+qUVf9dSAGEaTgLZIOgiCb?=
 =?us-ascii?Q?lOcQ/RoBSznKymKBIKg9Rt4FArcqOpT/lrUjPMsgkG0thiIKUHdv5+8b7fJf?=
 =?us-ascii?Q?oZgP6Xl+BWGz4dpDitTzPMqNRCkmmBKwkDSppq76DnsoGrlvUTMfXPO5ZOKq?=
 =?us-ascii?Q?+mVecWgIAtzlNa0pYAAsZFv6ICwHm81ooIcKRVbDMLhmE10fIeVbpXnFFKom?=
 =?us-ascii?Q?iw5qwWLz8SU66r1x01a58a1gdAAd01l2lYHnp85zchc4ixVBtW7TygY4Veke?=
 =?us-ascii?Q?zgEOdKHhSWF9EA9JO7ykUEFOdHpl090A/ZbHsNoiQWMGUEa5e+72NbwR+ymk?=
 =?us-ascii?Q?WhkYMpVhgzKX7Jnj42qJvM41avvT9q5htTJh3RlGI0DCg93ByqcGwIOpPVnL?=
 =?us-ascii?Q?UAgy/yUf9+YKAQQldgdeh5G3QqL8jtyXOAdYhbEyrHyUnnM3EwEnMUQNvhek?=
 =?us-ascii?Q?1+xaLHMf+NolM/mI8n05jQ/2gOu5kEnDVMiqEySiErBMw1FLeSDk9QlYeulb?=
 =?us-ascii?Q?mKbwxWZ8VmNu8XyI3ifJUrmskCEGyXR7oRFIgr1NosRDxxBiSGlNuO0/okFu?=
 =?us-ascii?Q?x8k9sB2elkstZYkPWRKwSJqch3onY6o6/jKg7SOBZE/pFzbJtd8ydixTr02E?=
 =?us-ascii?Q?kTcqIlIcWOtV2xfHYse+bOT8D9TCT+2dAYMWu9uWewP1B8RW0C7mQKuBql/M?=
 =?us-ascii?Q?O2CQdbQXUvXud9HNEz12O3+58+rw5RkOVdO2e/nyR5o9g/r6OqFIXkgrMw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 22:10:00.1075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ca2f66-daf5-476e-1d43-08de28818c4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nicolinc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

On Thu, Nov 20, 2025 at 01:22:13PM +0000, Shameer Kolothum wrote:
> +++ b/hw/arm/smmuv3-accel.c
> @@ -67,6 +67,12 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>          error_setg(errp, "Host SMMUv3 SIDSIZE not compatible");
>          return false;
>      }
> +    /* If user enables PASID support(pasid=on), QEMU sets SSIDSIZE to 16 */
> +    if (FIELD_EX32(info->idr[1], IDR1, SSIDSIZE) <
> +                FIELD_EX32(s->idr[1], IDR1, SSIDSIZE)) {
> +        error_setg(errp, "Host SMMUv3 SSIDSIZE not compatible");
> +        return false;
> +    }

I think we can print the values: host vs VM. And at SIDSIZE above
as well.

> @@ -2084,6 +2090,7 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>      DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> +    DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
>  };

Instead of doing a boolean "pasid", perhaps ssidsize and sidsize
should be configurable. Then, user can follow the not-compatible
print to set correct SSIDSIZE and SIDSIZE.

They can also choose to set a higher value if underlying SMMU HW
supports that.

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

