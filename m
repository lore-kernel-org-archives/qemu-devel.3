Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167D0C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9EL-00034R-0h; Mon, 03 Mar 2025 12:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tp9EC-0002vS-Um; Mon, 03 Mar 2025 12:05:18 -0500
Received: from mail-dm6nam12on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2417::604]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tp9E9-0008LU-0Y; Mon, 03 Mar 2025 12:05:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcmWTEnsXSBT4zf78lUugcjeJwr4l0FEuqWWiCImqnB/F1WHNqOqetkbcuuCEtDUJFTPhca3ZV0293+U4OYu8i5MY91SkaLqdSPN8SgqTevUtev6vNdgehHKR3AP1wCqk0Od+hKG3lj42SIEeTdkKT/Kk/y1JOZRxci2tmG2SnRNHVuNnYrT+U3aoTDDBKLxX0rIJGi4lberNUcDq1ZAz1arTuFHGn8hO3KiXQw0Ryb1znnN5QVeA0AysNTE9NwENzk+pgm9Rf6RT4b1P35Tm03K0IUwgWu6cHXHuU4WSO+gpLbsC2znlAVsXOhlVy5/8GP22eT/i3f3SsC7oXeV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAurUJhbhOyZze5Y79LS98Ivkx2aqd4b5rwViJRZbqQ=;
 b=uzcQ35gzYDJnbEO8pF8iUzfavuFCWSsu7zapapQLrrXEDg/23EXE697B3X+vXOQF5LD/+UaN7W1DuedOKvOn6Sv7DFVRGvYhp6erj6wEXBF9qqoYQcbp1wx/rR/0V++ty9UAe8iLujvQeUltHzT/RcMrLRvMuwct/7zgtj57yIEq2dpndGstQrcLpM7XhLM3OhVb/X9ATK2jiJn9NO9u8vITlKP39OhrjhYE5xL7UbSUZaDJDD6wbiISxf7K0bW4zNI0dSj07PzEQL2uQm+TQgwr0hrXh4EONmoO+6Gx1hN8LSz22rbkxNZ9yed5t2A2IsmJHIHqlDO/TcNMvelgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAurUJhbhOyZze5Y79LS98Ivkx2aqd4b5rwViJRZbqQ=;
 b=P9E+IEGppFyp1rn9nSwNKi8eggdj0OwNpaSH8RwkMncqQ9ggRu4weedeB+6drvWfMPalBmwAWm/EMRtH/bqMSe7iSU2tbBrYYSlhLLxGoQ68EcZOQTRHBe8wIlbRnKqjcUuiWKMLcKQQ68NUdJqJygHf/0YyoEsiQxlbcnliijQMDX3KE8dHFaLcPI8XMv0noO+14e8s9dSgUWFcrcnoXT+tvnuecC+tGHyUQt40HlOQPtCKMEenWMXxFBFDV76nCVXLoJcKzD98J4UoAVPX3sOFseGJyoRm2AVJYec4OLuYJ/vBLxD8/guRvkNiHsfFBAlN39KHRn5yEIlpkbrgNg==
Received: from DM6PR03CA0046.namprd03.prod.outlook.com (2603:10b6:5:100::23)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:05:01 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::1a) by DM6PR03CA0046.outlook.office365.com
 (2603:10b6:5:100::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.27 via Frontend Transport; Mon,
 3 Mar 2025 17:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 17:04:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 09:04:45 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 09:04:45 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Mar 2025 09:04:44 -0800
Date: Mon, 3 Mar 2025 09:04:43 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Eric Auger <eric.auger@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?=
 <berrange@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z8XhKyxHwsZo2eBK@Asurada-Nvidia>
References: <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <f4e64a3a-5c1d-49f2-ac72-b84ecd353c9d@redhat.com>
 <Z6EQENkHJy7TrkYy@Asurada-Nvidia>
 <77f736f6-9ef9-462b-916e-c8cfff279044@redhat.com>
 <Z6KsAE9wnjWU0xMs@Asurada-Nvidia>
 <8224c38797344d1a9c0f453774925db3@huawei.com>
 <Z6UGVP3olKvakHUh@Asurada-Nvidia>
 <48e3ac70f9fb4867a9ef835c22d4fda8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48e3ac70f9fb4867a9ef835c22d4fda8@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3e66e9-6b13-413a-930b-08dd5a758814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGZhUjA4R0tWQzNwc2Q5dEVQWjFJZFk0aGhXWG1YOWV2MGRlVnVVejZFalRR?=
 =?utf-8?B?TitWa0hDTkRqVUlWb1VrWFA5aGZPcVZOZUlJK3JtRlNDZHoyT1pOYVZWcEFZ?=
 =?utf-8?B?b1ZkRG9xNUtpVlZiekxiS2RBNTZlL1RSV0lPb2pxTmV2QXVUSE44eUJHV0g2?=
 =?utf-8?B?NFFPQXp3U3J2UzROYUxSdW5XN1hGZFZibDkxR2xuQ0NRd1I4NG80eS9DS1dr?=
 =?utf-8?B?TzI4OUhiWkhaRWp0YWROTngyaENRZ0pHb3dHVllrSVZIalBBbm9HWmR6VW9L?=
 =?utf-8?B?cGhBaUxHdU42OU1lOWk4MDVCK1UyRW5qRFlUTitNSXAxZVVNNkh6YW5NWnEv?=
 =?utf-8?B?YWJWVlgvSThPT1Z6V0ZsOVUyeDd1c2s5TnkzLzkrYXlYT2JCeFVrM1krM3p0?=
 =?utf-8?B?N2dXcUt2MG55UTVWM1JKdTZIeE9JVHo0djhWSi9hQURwanI0MVJGcENIdEYz?=
 =?utf-8?B?ZmNjLzNVYU5MMjJDemhMUldZQ2pzdjBkSFJIdnR0cW9SNkcwUFN2aTgvSlh6?=
 =?utf-8?B?T3pYc1k5ZkxRRER6ZXUrR3dUVEhINldLMXEyMEUyVVRWUlVYc3hnUk1ST3Ax?=
 =?utf-8?B?byttUTI2Z1hrRHhGQ2hNSmhMejI1b0Z5OUJIV2IwenM1RjY3MVFWVzk3WFhD?=
 =?utf-8?B?V3VwVDcrVTd5NitDN0JUQ3NmLzV3ZlI5VXVERmRnTWtHVkdiS2s0b1VUNEtU?=
 =?utf-8?B?VnQ4VW55Yi85bW1KUnljMFkwUk8xZXhWZjk0N2JxdTM3OUFYalhUNE1jN2tB?=
 =?utf-8?B?bkphQTFUd0VMUFA2bWF0d0tOeURWM1dtZk9NeTJvU0N2YWE2bXIvMXNhNnBU?=
 =?utf-8?B?c3pCT05RWmp0bDlTTS9Dano2N09HNnRGRWdaQVZRa2tkakdNRDJFK0RRYmpm?=
 =?utf-8?B?VWwxZEdEZUFqMkNzVGcxZXl2YXJBU2pib2FBTk0xTElWL2dGck02SnNYQVFp?=
 =?utf-8?B?d0RBd3ZoV0c2RkVHSnBudWNwTGpNd0NuYkwvUFk3TVNaN2l0eisyUmtKcjQ1?=
 =?utf-8?B?UXBUb0hVOE1RaXd4eG5YRlZsRmdETTZnWkwvaHdzVFFsSS9ialhQbW1zRUto?=
 =?utf-8?B?bUMrb2JIMXoyeFVlRDFmNENmZFV3cjJwS20xcnRjZ2xCQ2tDcFA4S0N4SGhO?=
 =?utf-8?B?a3VuWkt5cGJSaHhqRUs5Y0NUMWRyM2RTa1lzUWxWYWU2RU52Y25STXRlSmNL?=
 =?utf-8?B?R2NyVnZDV0NIT3h6WDBmM2sxbGxyVjQzRmhNMmFkUVFRdzAyMEVES3pvOTdY?=
 =?utf-8?B?cXhiYUl0ekhVS3dpUTJxMWRjMjlKd2FhamdmbXJVZHdvcDF4Y2tzd29EZGla?=
 =?utf-8?B?eC9VMTdWb1A3YS9zUDRRUlNHSWovbk03dFBXT3BDS1JreWU3MENyMDg1bHVi?=
 =?utf-8?B?RlZGSGUxazE2QWhMaW91ZXJTVUNhUkwraXN5VGh2anVTV0ZpNTZSMWhIK2tw?=
 =?utf-8?B?VnpKRGJwTTlNL21ndFU0OHJ5VWx5blFCMUtwNGIrTytOT0JoUEJDazMwRFY0?=
 =?utf-8?B?S2FMNWpJL3Y1OGIwNmNUKyticjBjZGlkV2pRNFhWRjlNZkhNdFY5ZHo1aWFG?=
 =?utf-8?B?Y1JrajVoKzVkdUtBV2JyMlNUbW43ZXMzMHR0RjUyTDNiUVBvUWg2UVVOdUVZ?=
 =?utf-8?B?QmJYTmF6b1AxU21wQ2ZFVDFTNW5SSHV5cDdXMUVXdEVpbzF2N0svV3NLMUZh?=
 =?utf-8?B?MW56d0ZxNHNCbmRGY2o0VS9HaHR0TlhrckxKdUxjYkg3OG1xcnhFUWVKTk04?=
 =?utf-8?B?SlkyV2RkMVMwY3NESmNBSm9NVnRNK0h6eHI2Ymx0a1BtMHpmcWZZQ25EbFZX?=
 =?utf-8?B?VlFuMmRxaEVQaUs4QnpEQnNZWGprUzJJWUMvM0RsaE1lUkdyOUdZR1JFRWxD?=
 =?utf-8?B?ZWdFZ2pPMzNZQmZnYW5UdmZ5WmFrQUpaMXFkeDRiRDB0Szk2RUtDOUphUnVn?=
 =?utf-8?B?RkJsRFJhUXFYS3pRRWtML3JmVy9DRklMUkN2Vi9pTXphWitUVXdNSk5lVVg2?=
 =?utf-8?Q?yjjrVw0OTpYygeRt4MUG9Xy6lb7u6E=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:04:59.5326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3e66e9-6b13-413a-930b-08dd5a758814
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
Received-SPF: softfail client-ip=2a01:111:f403:2417::604;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

On Mon, Mar 03, 2025 at 03:21:57PM +0000, Shameerali Kolothum Thodi wrote:
> I am working on the above now and have quick question to you😊.
> 
> Looking at the smmu_dev_attach_viommu() fn here[0],
> it appears to do the following:
> 
> 1. Alloc a s2_hwpt if not allocated already and attach it.
> 2. Allocate abort and bypass hwpt
> 3. Attach bypass hwpt.
> 
> I didn't get why we are doing the step 3 here. To me it looks like,
> when we attach the s2_hwpt(ie, the nested parent domain attach), 
> the kernel will do,
> 
> arm_smmu_attach_dev()
>   arm_smmu_make_s2_domain_ste()
> 
> It appears through step 3, we achieve the same thing again.
> 
> Or it is possible I missed something obvious here.

Because a device cannot attach to a vIOMMU object directly, but
only via a proxy hwpt_nested. So, this bypass hwpt gives us the
port to associate the device to the vIOMMU, before a vDEVICE or
a "translate" hwpt_nested is allocated.

Currently it's the same because an S2 parent hwpt holds a VMID,
so we could just attach the device to the S2 hwpt for the same
STE configuration as attaching the device to the proxy bypass
hwpt. Yet, this will change in the future after letting vIOMMU
objects hold their own VMIDs to share a common S2 parent hwpt
that won't have a VMID, i.e. arm_smmu_make_s2_domain_ste() will
need the vIOMMU object to get the VMID for STE.

I should have added a few lines of comments there :)

Thanks
Nicolin

