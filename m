Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAB8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFzfE-0007ht-V5; Mon, 03 Nov 2025 13:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vFzfB-0007ha-0X; Mon, 03 Nov 2025 13:52:21 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vFzf5-0004Oz-Sj; Mon, 03 Nov 2025 13:52:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJCG1hF0cpExMnR5tg0CWP2FyfNUSPxXFcB7b8HV7TeDSiCgneUyYBhI7yjsNFXRgfSC1DTcnosFsmeQdEua2YRbd4UWnz4Vr76VIkzaAS76faTmKciL1EeUSBGj2sIfCcw0KnH5OZKp9GRla8GD2aqfHGlRh/bSz0yjp/mFM+XHYeYaE9DpLOideU6cbbJTdFaBuL4pUNbVtfue5Xq6nYDvKoyQQm4fC2KBVwZKS6QsmWapTWfEIQrmvd5QUK70CtM+cEF2uhIE0B5qS9fdGzAR3zdA83aC3lshV4qniQFrZ5lY8OShXieEW9PcnB9xD0JeqO0SrDepWqvhVIaCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Put7Xe1uJJevP3Cq7r/rbAugVBkTuDN3ONV1xvxEw0w=;
 b=lgL1P9ZsRd1Zygnp51j23RZZVcADcdr1I+SdjWd8IM2l9gc1KVCX5f+JON3c+psBC5nQX+Q4QcDEYGm+0CxEXLDYxdlho7U/YGUHzXOsuDH75FwN+ooTfD4jqgYT5jfTYiZQ9VusB/xjVpU/yUzqA1BrzrHQiOJ2pNFkVZp75KpPjpwSThMxZVkUoY7D3j+9/0cAvIWq1VRsykNbZ8ajUKYUI3YF0zSJ6RUUFY+UtX32pgmFxvS4F6tEjnNgdLHOs2ECxA+c4m6PnDCG/DhcgPRCQ6dkfTTiMSo3KguitE1mgLZX26wqu7GcWeFVB+BO6BTgseol+/fmff3jXtCRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Put7Xe1uJJevP3Cq7r/rbAugVBkTuDN3ONV1xvxEw0w=;
 b=UgZAFdayykWTcrIUDCfsbFKqW3TtnidSo6lKiRZwp4bH/NNU6m1711hGNIMHHMq+36s4JZgHxkMhIAbkfRBVlQ8xqPHwutHNMNPsSK2duQYT74mF+cq5VakgiaNiYkfffitx6u7yQK8PtwOPsAic20rfurfBJBOKDWBQgAoOCqbHHrQjAuO4/hRJqtaL3B/7r65nc8AitaUCLiu6ZKoHTpcmHfVZGE6j+BZeUcBDQ/T8DimKSfMP2XKgoI4U4gvPPqZizCm/QKbL6s8wuqyfTsO23jYcLvjtyvXvoH2SFVCdvoUOhOYl/sKLOR+z8LTfG09KIls6jIKRRZuM37009g==
Received: from BYAPR08CA0031.namprd08.prod.outlook.com (2603:10b6:a03:100::44)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:52:02 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:100:cafe::fa) by BYAPR08CA0031.outlook.office365.com
 (2603:10b6:a03:100::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:52:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Nov
 2025 10:51:52 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Nov 2025 10:51:52 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 10:51:51 -0800
Date: Mon, 3 Nov 2025 10:51:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Message-ID: <aQj5xQwsq/kBaJP/@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-18-skolothumtho@nvidia.com>
 <aQVVxV4I/nh3aAXn@Asurada-Nvidia>
 <CH3PR12MB75481D898FF28E9832B0013EABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQjpzdwbJVPN7AqF@Asurada-Nvidia>
 <CH3PR12MB7548CBA8B4C962BE867C9362ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB7548CBA8B4C962BE867C9362ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|BN7PPFEE0F400A9:EE_
X-MS-Office365-Filtering-Correlation-Id: e34d192b-6819-4b14-5b77-08de1b0a1356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2JKVHRubnhiS1NFakdPNjFEMEx1VVNuMVpSeE5ZQy94YXZoWmx3SmEwYnJY?=
 =?utf-8?B?bWEyT0RyaHFCVEtpSzY3RWthc0szRXN1YTFCeVdzN2NTZGt5NjBHdFpodlR3?=
 =?utf-8?B?WVFDQ3NkdVFwWlA1UGV6MGs5M0kzczNQR012VkpydEsraUNtWWJCNUV0YXNO?=
 =?utf-8?B?SEVQcW1nYnB0VlJXbDRvZGhpTndhQ0NibTVCK3VoZ0Z5NHJHWFdVd29Vemly?=
 =?utf-8?B?TXMzWlRtM2pKMEhwQlpNWEJJMzUxNzZ5eGVRYXB4OU0rZkdNYys5Y0k2KzNr?=
 =?utf-8?B?bTNCNUxxK29ZWk85NVpTSlpTWUZ3R0dodEJ6eklzcVNPcGVIUXNWa2EwWmJo?=
 =?utf-8?B?NEVtV1R2cy8wbTkxaDVHN0RaZ0pVUHRDeEFKY0J1a0FVZ2ZncFl4eDRLbDVI?=
 =?utf-8?B?NWtneG5xSm5INFNGT2I4cjVLdHpEOGFNNGFzaERLSmw2RFhRNkFob0p2R2c3?=
 =?utf-8?B?OUlwSEFCTHBUd0xIYU9TV09zTnlrbVd3LzFKVythWDl3OTFNVDRuTXJzREgv?=
 =?utf-8?B?cGd4dDh3VXo0THp6WlBaUldvMUI3RWhGRHZWK3V5R0JnZ3pWOGxwekE5NEhD?=
 =?utf-8?B?c0c1cEhyODNSeHU2T0JUMWN2YjNxTVFleGx4UC81Y3h3bTFXa2dmOVZ4dGNy?=
 =?utf-8?B?T1VrNW41UmJGdVc3cXMxV2FRcHBZbStnT0lUbXc2Wmt0alZabHdiYkt2MHgz?=
 =?utf-8?B?M2NNYTFkQ1ZXeG9pazZDK0VMMDAvdzlybno5TEtZZE9yN3Yyd3BSaEFVckJv?=
 =?utf-8?B?MmovRmg4NmtaOS9mMEMwUC8yRjdWdUxHaGRyTDZkUFZ2c255WEdtSHQrSnVE?=
 =?utf-8?B?TThXenJ3L3I5ZnRGVmN6NDlEOTdCT1B5QUhKWXBPVWFNUHp6dS9rU3VBQU1I?=
 =?utf-8?B?NWMxVWZ5TlNmNG5lcTB2eWFzYTFIbS9RM29YbGpseTg1UmJUdFZ5Y3VGbmJu?=
 =?utf-8?B?TW1acXRXQnhOakFNWjhwUzhqSWh5NG03ZXFWMlZHU3ROU1AxSjl0dmpYemk0?=
 =?utf-8?B?bld1WDV1L1VQTnY3UkhyM0xkUzBwT3VXeHFuUlVhb21tSTAzNVkyNTg1R1JW?=
 =?utf-8?B?YzVnT1RtRTliSFhhbG12VHZnK1hpNE5oY3FhbU5taklIZVVGbi9WSnBwNDIr?=
 =?utf-8?B?QXVQdHM5TUxxcGE5cVZpbFVXU0wxdWpvT1RzM2ozLzFtQ3RmT01zR0VYMEdK?=
 =?utf-8?B?K0daV094MitmS1pBY0RHb25DNytDZ2l5SnhOYXhjNGJQS1RLRkkwR0k1Qkg2?=
 =?utf-8?B?L0liR1VJRW1SSzNZRTczSTFRUVhTaW5TYUdnMXAyMzhuY1ZxYm0yZEFhV3Jq?=
 =?utf-8?B?d25TNHNTblNyaGQwc3RGdzRyWHptMDRJTkFsUGsvWFBKb0FGTC82UGluZ1NN?=
 =?utf-8?B?QWhMQ01LNnVwck9HYmg2Wk5YZ3pwTVVocGVJcGZNb1ZyR09ROU1uTUxMQWEw?=
 =?utf-8?B?UFVaVXpaRUxYOUVtRGFEVWoyRmp4WklSdjhBWVdzR0FVOWdzZEFoWEpLWlNt?=
 =?utf-8?B?K1pTeDVJWUJ1dGd5MHBPZEhiZ0J4ZDV3dzNHN0lhcjdBbGZ4S0ovZGFoK2dG?=
 =?utf-8?B?dHJ1SGV5UC9wSTI0QTF2ZnZqOUJJS1lqZ1RRczZsV2lrcTg4SmRzWFlSa2lx?=
 =?utf-8?B?YkUrRDlsdVhpQ1J2VUZWa3FhRGFMdytPOExRVlA1Z3NDMFp4eEFWZU1XOWg1?=
 =?utf-8?B?VkJwSG45VEZlS0xiRmNNZ1lGcUlOMmhKWjVrR0FadFdUSGlvb3lxYUVGa1BF?=
 =?utf-8?B?akdNbS9LSnMzVVI0Y2d3ZTVHNkEvMHViNFRibHc3UFVQeGZqcTE2em5ad1ZQ?=
 =?utf-8?B?ZEJxenJzVHIxSWczUkphWnB4LzgxYXUyUjBOL0l4NzZxdGoxTy9ycEtSajI2?=
 =?utf-8?B?WUdxUFFkemVOUFN6Wkk2R1VXMitCUnd3WkhOOEsvOStPRmtvU1A4aUs1MG1y?=
 =?utf-8?B?NVRZZGI1TFlXMk5nVEd0S3UxdG9PdEkvZXF4QkwzT2JKVkg5UzhiT1hnVDBs?=
 =?utf-8?B?anpUemlON1VXRzVuYW5ZeVhQT3M1MEtvcEJKRlpMU0F4ejNxaTFiblJNWlJs?=
 =?utf-8?B?ZGR4d1VxeHBkUkdSdmZ6bWxaajJqNGtXNFdWRG1RNjZjNDRoL2JmK0V5Qzda?=
 =?utf-8?Q?JX4k=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:52:02.1016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34d192b-6819-4b14-5b77-08de1b0a1356
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

On Mon, Nov 03, 2025 at 10:17:20AM -0800, Shameer Kolothum wrote:
> > > The general
> > > idea is, we will pass the errp to accel functions and report or
> > > propagate from here.
> > 
> > But there is no "errp" in smmuv3_cmdq_consume() to propagate the these
> > local_errs further? It ends at the error_report_err().
> > 
> > If we only get local_err and print them, why not just print them inside the
> > _accel functions?
> 
> Right, we don’t propagate error now. But in future it might come
> handy. I would personally keep the error propagation facility if possible.

smmuv3_cmdq_consume() is called in smmu_writel() only. Where do we
plan to propagate that in the future?

> Also, this was added as per Eric's comment on RFC v3.
>
> https://lore.kernel.org/qemu-devel/41ceadf1-07de-4c8a-8935-d709ac7cf6bc@redhat.com/

If only we have a top function that does error_report_err() in one
place.. Duplicating error_report_err(local_err) doesn't look clean
to me.

Maybe smmu_writel() could do:
{
+   Error *errp = NULL;

    switch (offset) {
    case A_XXX:
        smmuv3_cmdq_consume(..., errp);
+       return MEMTX_OK;
-       break;
    ...
    case A_YYY:
        smmuv3_cmdq_consume(..., errp);
+       return MEMTX_OK;
-       break;
    }
+   error_report_err(errp);
+   return MEMTX_OK;
}

Any better idea, Eric?

Nicolin

