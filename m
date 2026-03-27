Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9CA10BA420
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yVn-0005ss-8L; Fri, 27 Mar 2026 00:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w5yVk-0005sV-VB
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:09:29 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w5yVb-0002zp-43
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:09:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUkG0Pn3fMD2T0f7AS2upLhiL5aGAtp9gXYxijC6MDeknkA9udyuY95Ocy3ln4hxHlCqnTTtUa3GKjXO2BQJwq6nh0fMfpq8p25wLMxzGKKMRQlH2SbLHzt9l8Zmc35vZ5giXT8pKO84GnQw4wZNGVuUc9nYXJq+E1H05pgZznmh89v6GHEkfgRLMDSzP7cLeVN5a6JofAa7ill7s7xZGAK+CX5nT4wyFTH6RfoDH8OJUdmGdgWdS888kOeSf01ZBFKNLr7msvAb4JMkuEzZKoVJU6w3QXwoEpOSfruiNg22WhoNVOzFVDThUIr8OxPhIv23vS2M/wXSMrFp7Hc4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot08//oyHdVZuuanTueOzja8pBxK/UWsjA7GXtCkTx8=;
 b=yJB0OgN2vaJbxlGqUgIyJQtpQ1c+eoWHehXzssyxhLTRBGCkKnav5CJ4tCkOZW1Oi8bIXj4AJ9REBRr9Wf7UbQFUWpJQ7BQKKuwjoaaXHF7Yi3JOiNUVDxx2WojbOu3ne6FmBECZyINW91Non0ZNo75Q2hwUT6d+feiLdkmBeCsYnR1ByXfswjOo0vGLuBpy9lnjRbMV6OHBxZ2EAVQw3CC8GM4P9E7lutBn1rw/vGg6sr8xZoVATw9+T2G4/ESy6Hc0A3xE9VEdIbD49qoTPRHHhh8mBbghkRQMNIL1RFomLGlS5hJCSljRErtel4NQLLKB4Am2P6TkKbVxkwqXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot08//oyHdVZuuanTueOzja8pBxK/UWsjA7GXtCkTx8=;
 b=W32kCrg94T+zy9tkyAWBowmCcnx0DxY2kaCHRc27T6a5E9QkPqVgZffuHDsgVZH3/rEql5yS32R/Yy24GSAlhqYf+evi4JasnTn7dOns5JNNv9lbUzBhVvNgx5qvcReAWiUmhbDdvxpAE8Xg8ImBVYLEV3j4S+t4t5Voj4yAPL/nHrKoE+THWkuQxQzUp1WY2LWRClODxBOVlytQSH5xb/gu9IKD3AnEp4Uq5xjG++wghGR7d3J6Nh18Ai02H3W4D0rAKCa7b2MblvVwevHzlf2y2+l8RAynjBIUs0czcHsuH4UL2HSmNJJXnpqMlefTCubaKkf+omZNOIFewyWVSQ==
Received: from CH2PR14CA0054.namprd14.prod.outlook.com (2603:10b6:610:56::34)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 04:09:07 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::ff) by CH2PR14CA0054.outlook.office365.com
 (2603:10b6:610:56::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 04:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 04:09:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 21:09:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 21:09:03 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 21:09:01 -0700
Date: Thu, 26 Mar 2026 21:08:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@bull.com"
 <clement.mathieu--drif@bull.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, 
 Yi L" <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: Re: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Message-ID: <acYC2ko1r8OkAvq0@nvidia.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-4-zhenzhong.duan@intel.com>
 <acW5AXhPDT+wZ2qf@nvidia.com>
 <IA3PR11MB9136D7618C06EFF1D66561549257A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136D7618C06EFF1D66561549257A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa381ab-5008-437a-e4b0-08de8bb6971b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|30052699003|376014|7416014|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: LwLMTJLIZFWsPT2+5r+iS111JK9ZP3V3jS0QbPP8N2fn9wjcgIrFBd8Ez9z+IfczWRbAPWrdDYBv2pobIj+jPMGuuB+Pqyh1c79MFASUGnQV/N02aRUB/T34Lpj+/6CxCyTlXZLn1DqICimy/1luFaLpHpcWNvGBO+lZRyhvn0bKmjUcxzzEq8co+TZiBX87mWCSxkfz1wBcZenKlGmjqjGkCWykDNCN+kr8oq4GI/SaRcyWmcg5d/tHvU5HjDajaZmQO2IKO2MBrShTp8G8UTbBBlpNr1beNjxZqPFPoalMoe8LVndPySV0M1JQ69smDpUXVwlq+GuW6e+R5GxQcfavtuzlzc3G4U389hLAIXpdklx0ZF54mGy1z8jd/jwKRC2i4eE6EG1Emd1ZxEliIypTc5yU+yhwRq3isrQHAmm4lk9agHTYWeat4HwXREKM1Zm7TblZhRTrytGk2iS75a+cOK8U5dxVaWOZmenz8w4nUVBJorGU58JJvgZwVdMNH0Td7YDYRnSoEbJoe+UVh8veq+xjvwyqIhaAbVKGtp8jttnB1kShJGR2rZzq2G6ELnKS4HpSNL3ees2MSez0xlUqMZCnw1s2dzOaFuj5rSeuSD6spDjTYRuJRMOjg7dspkagIjLMMAL6qscbeYKzpgRndHyv1ZfVlCW5IMXvYMauaDQHXII3L057kO4v0xJMlylhdXxwWnZcfwUYTktL5viI9dyXXCbFO2tZ+5LVGwoisdVcyoRAgYVpB6wLVT9gfu9AnKuOKPAwx+a7WwFlcg==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(30052699003)(376014)(7416014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RMZbuBThjTtofTFG6tdVmzsJMl3OOKST5geM7sjF1D7qJzY9iA5EW6YmhD2a7y1yZP/gIGi6AWIENysiC0wlaDYI4Kf5ifh0Udntp/UgWfd56jAgPyxI2J5dHcuSYKrfMhPfNXA+h6SVlGltIYN1RwuNhQFpND7BnUFlVCp+rMlhVkGxe9Hz1HbC6+0Cag4oujolXYu5BHDVG77GK2XLcyvHdGlniIssETkZ5Yghf8fb0gxkqYnlvdWa6rl4v48EF7yplJCUhIMEQIDkwYks63+Xl8MuD5dT3ndx7yYE8V1x6C6SzjdHESA5yoZS19PYp/i9y9aawgXN7GYLQ2j6RlmVacadhoBuBy7/veiGAK9nBCmOsYeVZBGLtpHZa/CXfpa22RuJplEkMxsZLJgLDQapZqprpTCpra58DozklBkCI6zxSa/2etNfDngtGZ1G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:09:06.7252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa381ab-5008-437a-e4b0-08de8bb6971b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nicolinc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 27, 2026 at 02:29:20AM +0000, Duan, Zhenzhong wrote:
> >-----Original Message-----
> >From: Nicolin Chen <nicolinc@nvidia.com>
> >Subject: Re: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt with
> >IOMMU_HWPT_ALLOC_PASID flag
> >
> >On Thu, Mar 26, 2026 at 05:11:17AM -0400, Zhenzhong Duan wrote:
> >> @@ -430,6 +431,11 @@ static bool
> >iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
> >>          }
> >>      }
> >>
> >> +    if (max_pasid_log2 &&
> >> +        vfio_device_get_viommu_flags_pasid_supported(vbasedev)) {
> >> +        flags |= IOMMU_HWPT_ALLOC_PASID;
> >> +    }
> >
> >This would set it to:
> >	IOMMU_HWPT_ALLOC_PASID | IOMMU_HWPT_ALLOC_NEST_PARENT
> >which isn't supported on ARM :-/
> 
> I am a bit confused, if smmu supports dirty tracking, flags would be
> set to IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT,
> in arm_smmu_domain_alloc_paging_flags(), I see it will return -EOPNOTSUPP.
> So how did smmu work in this case?

You hit a point. I almost forgot we need to do something with that
dirty tracking flag. This is currently broken..

For NVIDIA, the current generation Grace CPU doesn't support dirty
tracking. So, our QEMU VMs don't set that flag. This is just lucky
for us. Yet, it would trigger -EOPNOTSUPP on ARM CPU that supports,
as you mentioned.

For pasid attachment however, ARM doesn't need it: regular pasid=0
attach already has the pointer to a stage-1 PASID table.

Nicolin

