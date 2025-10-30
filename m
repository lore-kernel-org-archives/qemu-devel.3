Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D59CCF9F6
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 05:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vELDl-0007qS-K3; Thu, 30 Oct 2025 01:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vELDk-0007q1-0o; Thu, 30 Oct 2025 01:29:12 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vELDY-0005hV-1k; Thu, 30 Oct 2025 01:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiDPszAoIRjrMgQuF931D6VcHQGM1QjEQp4U5/GZU0EvzrT4gdycR8ORQnTkEaivDKIY7IsfBKvdVLEBTk9Cf5RG+KwF68yirp3H++Cst8kgdWSiKD0CkebOK/wx/DWi78QW41T4Sm2M5nNgUzYPoDK8WQflJ8H3zD0yI+LfAClxDU0VDQKL2X4EcqRVlc4/bbta/tFUwbEb6uOiyoQHYI8C4ZHRKk74/GJ8rdFzBUGmN6zA1ggFN3mjgke9CGdXp6rBH8W5UgXA1OCJvLxHTkNfJrFuB2utzkwcOA2TuE2o5fU9NqhDiWumjhe6g+gbCNZXrYdyILC3IF4Ks+GB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHSzZNzRtQ3dtFzlut9II97HHMtsYjqlQfNQPZbkQaQ=;
 b=IaZH7BDeCv/yVsPhCnJAHf47GGBt/i3giI4GJ/7dA+Ecoba22qpos7TBiEacioglE0kSZ7X2O31V9h3Z6eNN2mE2L9vvX4faBG5spp5EDxDWbUhstJIvopAUCED+nrBlwKW3eohrJ8wXzlzwdmag0LS1nDcibTIk0uZLM4tDRFMibHbiF4C8WZixP5KJ42lcZ/ml4xmWxuOqW46zMGfHkiuMSeoeblZN5+eUNyU7l0RiT3nAUr/1ZzWqRLUaOMh8hmLjWpVBHuuZeo/IJd3zJkGutN73QV5NVm+R+TehL848mIaAmOyFCfHVC7v+p0quh/Mb9MTXfyj21E3UTxq4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHSzZNzRtQ3dtFzlut9II97HHMtsYjqlQfNQPZbkQaQ=;
 b=gfVf9sRWx+c4fdwzqd15UGEuaxhCze5KNCQqkAXkiLUc3V0PMyOl4sVTQwBdaTIJ/c/Maw8xRT+yOIn3Y2Ald6BJlxrTp/ekaZqtcGklq0Lm50A/erzXFHQeim+vyTytPNcKe4IXO8xkquoyIootm2TDp26atdIOV9JrFDPMUcWlISrp9M2FYaL0XjsTTsf3IsgLV/n/gr9KmfzNpAe5Od2sJll3NUzSWBNY7GD+xMg3Ww5FnKtBLRdK/tmc/bQ546BbDVMm2Fu90INw2Qp3riSC3JjVedYM4bc0HCZrDPEBXR7Qf6Dgauztg7Io8W400OwTizYlP8tQknwtRhjopg==
Received: from SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) by SA3PR12MB9227.namprd12.prod.outlook.com
 (2603:10b6:806:398::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 05:28:48 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::75) by SN6PR2101CA0022.outlook.office365.com
 (2603:10b6:805:106::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Thu,
 30 Oct 2025 05:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 05:28:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 22:28:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 22:28:35 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 22:28:34 -0700
Date: Wed, 29 Oct 2025 22:28:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Message-ID: <aQL3gNT+1Ehgi1pn@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-20-skolothumtho@nvidia.com>
 <aPF9l5GwctGN0tqT@Asurada-Nvidia>
 <76ce5b05-98fe-4682-a5ca-2f87b7535f35@redhat.com>
 <CH3PR12MB75480062975BA40AD454742CABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQGXibWAiMpXAQlF@Asurada-Nvidia>
 <CH3PR12MB7548FB14A0D0F08688DE9CCDABFAA@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB7548FB14A0D0F08688DE9CCDABFAA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 207cf71f-2d72-496f-b2ea-08de17753451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2pDWWFHM0UwMklPVFM3L3o3cUNxTER2ZUdQd0pRWWY1clJZQmVNTUd4eFl1?=
 =?utf-8?B?YVRqSW1LQStFQk5oaTFORVE4UVRQcVlGNnlmSFMrSnB0aFZCaldhSnB3VUZC?=
 =?utf-8?B?aSt6c0lNSHRUbTl2SjVLQkZ0THd5VW4vazJzaUYvMVIvTmk1ZFZFYnF0b2hL?=
 =?utf-8?B?eDQ4NDVSVFNrWWgvcDVpV0NGdFptbGpsYlkyKzhXaVVwYUdJRTFZT0xGb1B6?=
 =?utf-8?B?RXlDRllXSUhMNnVsMm5UWkc5d3VBSlBwdjhDdWIwN2tvUU52QlMzWXA0RDM3?=
 =?utf-8?B?VGlOZHBNbUMyOFg2SVI0UzdXVW1mK3NEU2pGcGI1VkFNUkpyZTRzR0hLNnVK?=
 =?utf-8?B?NTN2a1FQSDM5cWVud3ArUHQ2UnNnM1BlZ1pESjRKekljdnpDZGQ2a3ZGWVAy?=
 =?utf-8?B?cXFVV0FkRmxKS3Q1dFdzeVR0cHlGTmtXMnhmSXl0anpiRG5STGJLOEphN2tl?=
 =?utf-8?B?UExMN1FOYTEvYTJHSlRjSURaTmRJeXVBZ2hsQ3REbUVtT29CbU1LWmZjNksw?=
 =?utf-8?B?TDFJS1pCN3A0WXpzVXl0WVJJMUF6T0FYZ1pTWmdKNkZyUGxxYkNGako4N29t?=
 =?utf-8?B?cWdmd0pEaTN0QnFLaE1YaTBwTnJuZVp1bzJOTTF6UEtTN1dOZ09Sbk9kYWly?=
 =?utf-8?B?ekJZdi9uWDc5OGprOUdXNzBWK0RLU2FyQ3I0T0hqYnRyZGRCSDR3RDdMNFUx?=
 =?utf-8?B?aHBUNEVwbCswTmpJWjh3dHNmS2l6MW90OGNYa0E1ZGE5UXEyVG9ZazFEczhr?=
 =?utf-8?B?ZXU2ZFZ2L2VzMkNLZXJjbHplcVg2cnhjNVIvSkhURmI5UDgySVZhUmxKeHNy?=
 =?utf-8?B?a3JpZ1VaNDVCZ21JV1NjNzNLSVlJYTQ2U2haZVQ1RWFFUW1rb25MeW9mbGh5?=
 =?utf-8?B?elF5VnJXWXl6R0piVUo2Z0x3aFJoSkEwd3pmWWcrYlFkYk5xUDRicjliSkQ2?=
 =?utf-8?B?cU1YeWo2d3BaS2dWMXBvc0JVTUdUNkdTbyt3RnppQVpseVdaeGJJK0ZVSzlh?=
 =?utf-8?B?UitlMnhHMnRxQTdxejRDdk11b2Z2aWJyVGJSRzNMbTlhazF6Z2c3V1BMa0h1?=
 =?utf-8?B?TEhwTWVNc0JzLzVLZmx6aTdJYzB4cjVkb29kSlprcTQ2RUlyTmxOZ2ZhMGlK?=
 =?utf-8?B?cDNxeVRWZFhxZFNsZUlEbVg4US9KV2dvVVU0cDB2TE1XRjBQbmQrTWZjWnJZ?=
 =?utf-8?B?bUlmUWgwVjBBa2lTOFZkc1loV2RFRUNFRmRtYTg5SDhEdkxGL0NmT3AvNDli?=
 =?utf-8?B?alNBbDh0MDYxdDBGOHRHWlE1bVdzYjdxVHBsMkI0T0tzbjJVL2tLcFh4ak5Z?=
 =?utf-8?B?T1d6b3RTeGNKV0dBM2VwSmlhM2l5ZkpqVzVTclFFZEFuOVhMU1VHNDZRYTV2?=
 =?utf-8?B?RDFEQTQydnVkYTVFb3lvRDFHMGJaOFlxcC81T2FFTVBZQ2dvTHJYbGREcGNk?=
 =?utf-8?B?SFBzZDJwaEFpbGRvK1JBS3hwT2lIaWZ6VmxZVkFrWC9jOC9GbmhucUNuQUFq?=
 =?utf-8?B?Q21ZRFZVaFdCUFZpRGhTNlFMR1VqUTI0RGhNUkY5bFZyM1RWVGNwWjZ1TjFw?=
 =?utf-8?B?V2l0cmN0ZkJBYlp1TXlYZlhJaWR3NDlFUFRMeWZhQjZ2MERQU0RhTHlqTTF3?=
 =?utf-8?B?MmtkTk52TVNxVkZYK0dBVVh1VjF2TUpLQVFEK0xrT2ZIZytaMlptRHMvY3Ez?=
 =?utf-8?B?WnplcHJiSVVreDc5Y1V3K3BZZUYrbUM0clhUVUVzeEdaMk1qclBwSlZOclI4?=
 =?utf-8?B?RGhRdWY3eDZvWDA3VVN4eW9DTkZ0cE05ZFlDZXdSSXFvdjNPMVZIcnpLTzBB?=
 =?utf-8?B?UnJVNjZHMHNJLzZxcU9jTWErWW1uUUUwMlN0UTk1bWZZNFd5RWlIQmVPeVJU?=
 =?utf-8?B?cElyZFBjNHRudytaZGhMc2REK3poN0hzTFplZENQYUpHeFkrWmh6RE93WWpa?=
 =?utf-8?B?b1E0TGxWd1VOaXE4Wk1lZmppMmtTRVl0QndhWTZKaGJQRW5zKzFIOFgzYkRh?=
 =?utf-8?B?VGIrb3dWZ3A1UkQ1anhZMW83RlZ0RDJsMXVsNFU2aW9jZFFDck1ObUJKL1o1?=
 =?utf-8?B?QnFxNjUyMTVxUTUxd2xTRHFGbTE3WURRT3FUOVJCb1lPdjdXMDJXRG51eGtN?=
 =?utf-8?Q?fA8E=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:28:48.8737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 207cf71f-2d72-496f-b2ea-08de17753451
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=nicolinc@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.399, SPF_HELO_NONE=0.001,
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

On Wed, Oct 29, 2025 at 11:19:59AM -0700, Shameer Kolothum wrote:
> > According to SMMU spec 6.3 GBPA register's Additional information:
> >  - If SMMU_IDR1.ATTR_TYPES_OVR == 0, MTCFG, SHCFG, ALLOCCFG are
> >    effectively fixed as Use incoming and it is IMPLEMENTATION
> >    SPECIFIC whether these fields read as zero or a previously
> >    written value. In this case, MemAttr reads as UNKNOWN.
> >  - If SMMU_IDR1.ATTR_PERMS_OVR == 0, INSTCFG and PRIVCFG are
> >    effectively fixed as Use incoming and it is IMPLEMENTATION
> >    SPECIFIC whether these fields read as zero or a previously
> >    written value.
> > 
> > On the other hand, QEMU seems to set both OVR fields to 0, so all
> > those "other attributes" wouldn't be necessarily forwarded to the
> > kernel?
> 
> OK. Based on the QEMU OVR value, GBPA now resets to 0x1000, meaning
> SHCFG = 0b01 (Use incoming). However, in the current vSTE bypass/abort
> cases, SHCFG is set to 0b00 (Non-shareable).

Ah, no, my bad. SHCFG will need to be forwarded, if the hw_info
call reports that host SMMU has SMMU_IDR1.ATTR_TYPES_OVR == 1.

So, the SHCFG=incoming has been the default case, but to support
a non-incoming configuration, kernel needs to allow SHCFG in the
vSTE.

> However, I think the SHCFG will be overridden by S2FWB.

I don't think S2FWB affects SHCFG. SHCFG has been set by kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c?h=v6.18-rc3#n1681

> So, I don’t think we need to modify anything at this stage. In general,
> though, the kernel might need to propagate some of these attributes,
> possibly INSTCFG and PRIVCFG, since they are not overridden by S2FWB ?

Yes. I have drafted a few patches, and will send soon.

Thanks
Nicolin

