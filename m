Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA730C83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 19:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZaQS-0000Gi-Ar; Wed, 09 Jul 2025 15:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZaQP-0000GG-Kr
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 15:25:49 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com
 ([40.107.243.57] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZaQM-0007by-VQ
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 15:25:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpvHb/cHW+L5RZTlZe6HUIw5ctON47TBTyLcPVa4/hvOhI3h7Fu7rwkksb569WTFcx81Bx27tfNhdCX3G6+cgJ6jhXDu5EHN7/JDOMU/FR451hcHsc37Vgh1R6s4d0LoksF3VblgEQyKFxXiRUxwnT24Suxe9Zqq69MNGnbh59Ga+TSIxqVyxokQwxMf6p/I3OjMnTKz9Xh5UBklwLlVb5z0Nq2gcS7ESIwqCoAmfl0Nw0LYvgAz9Ev7WH5FR2r4boZ39ffRHHQPcViIL3giJhFyNNenM+O5F2XpToV6baXhL0st03MQZUdqXM6v8ooc7hglYMQ411epxUoN3MZrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/BPLBh8MPWZllXMbp5624ubhVjWH9/apye5MOAfUZs=;
 b=yzQPtSJNokKCzp6esRC1Kz++5xqRjDjgUzRCysd0ZVAx5dbLkjxrXupqJWCl/r2E0ZkK1JtxUHsdJbsS1UgGxnkrZVsbQVWqnSl0SBHecqHLQ2sg/34kDsjxw4sP/UFLSiUz9WMliedg+C6nWbxtz7RRs3c34gn+9/3R1Bp925e9TovL63ZsI0r48IPH0AvsvBUzahkv0D/g3L4m++3+IfW83T4XXS9FjDuWnCvZg/e0xlND3UYrM1FsGfPj2smAeJA+quic6zTmCIAPES4rJvOaVzfLlUnbWUd3pahswJCgQswRRvDQ0eTZfy7tat64VELiDXK5C3oB6bwu4g7T/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/BPLBh8MPWZllXMbp5624ubhVjWH9/apye5MOAfUZs=;
 b=GMzTimrU33mBj7Mjflme+YNlsbxK5sLMg4xsBtu8apGPaWRQMTezqp3QyuMA/mXUs/gkVzwk8QEdaAL+bQpR6QrcLVspcMTRJr4dhGStRd/dsX5OhO/JzJNw/DwJA7hKOkYVyrKSObI3GcWvxfNGwqYx1LRtYX45wMTFDuBct7GWlCevd0qNw9K0YchFZYDFoCmcBmHUo7qu4yE8PVyL9k36uTgOagHeUfn0U0tB8nBwiLhXavT8Pejy5GIPzHtH1+HS6X8yhaHcocpoi8GcJN0DdzDctYaZmWM/1rqXQA/HBnuKQSey7SJjcv808GwGZHU4Nmb2Nz9ijflhHLN15w==
Received: from SJ0PR05CA0101.namprd05.prod.outlook.com (2603:10b6:a03:334::16)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Wed, 9 Jul
 2025 19:20:37 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::57) by SJ0PR05CA0101.outlook.office365.com
 (2603:10b6:a03:334::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 19:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 19:20:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 12:20:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 12:20:21 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 12:20:20 -0700
Date: Wed, 9 Jul 2025 12:20:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Donald Dutile <ddutile@redhat.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>,
 <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Message-ID: <aG7A8hxd1R4iVhGT@Asurada-Nvidia>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
 <01584206-e2c0-4881-aaf5-d6c552a30873@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <01584206-e2c0-4881-aaf5-d6c552a30873@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 48558887-9359-4aac-9930-08ddbf1dafad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q8NOIVLoNPhmLqj8VIz/eCT2U6LhBJm0jPVu21hymYUPuHzGYlFpg5chsFvc?=
 =?us-ascii?Q?Km0dSdfCbq0GnxUtdEhLXmTofbny+AGBZNIJkq8W3EZI+VwiQmeJKnqs7Od6?=
 =?us-ascii?Q?bk5hL+tdVEPcbfnD/iglUmie7PEG+XBg8zkIe462PqzbKChwS6nzMVkOojHb?=
 =?us-ascii?Q?F0zKnPbhbFqTM+e85MIw1YXgY3gk1+svy96hYt4VtKPW3A6daS7IhCzOO/KM?=
 =?us-ascii?Q?FEDQ7fMXg6N/43w91hsXR3LB1C70aYc/WZZAojBIUn0faOvcW/ENKqYyF2JB?=
 =?us-ascii?Q?zRic2JITn01psiaard24vE1QDrzWo/nh10T1w7+pOZd1FU5I4Neap9S89lRM?=
 =?us-ascii?Q?HnComKubRCIWFuxtQmVQXlgUWUyqDyse5swjKX7eOK4NAhidzjkKd5yDnXrw?=
 =?us-ascii?Q?QAurfPUMmaOEiNOMl5V+d2JHQ6ld07rwbj3L6awvjrAf1IrwldUa/IrGP3Hy?=
 =?us-ascii?Q?DD16yjR9AsSbT1ighu3k2iBFYRJ5VXLZqcL0kiYou3xo5sSgZPsqXOB+d2hP?=
 =?us-ascii?Q?0gxXo9Eia+tC09VjGFwlj7Vnxov4vnRS40idNOB1mhwDs80XXD/rwRzWmlbg?=
 =?us-ascii?Q?xShn0Xufgrh8k4mN4w2+7JmpqjRzmY2nIYBzqF4C55BHfCL8PcjvYFwrtL7q?=
 =?us-ascii?Q?2xv6E8S4mpTlQ9CU58Z33myIoRHOoPM/MAsH4Td91/MO2njY3gt3KHdc3is6?=
 =?us-ascii?Q?D0D8k0SRMxvT67td1GqKKWjsjD14aOm13V0QUQ2kMKtLNmnwUpxPl7c4mDUe?=
 =?us-ascii?Q?6bIXa4Pu1zk8l3gTSZEpjUbUm+I9baWn6QXdfoVpRcXA9F8YsR5Ro/VrDgaq?=
 =?us-ascii?Q?XHvsd0aT8Qoy2g1cp+0WQgwj6bgmBRHXcGG/oA7CarB9VQcyTtTTJ3XxDyNH?=
 =?us-ascii?Q?mLk4XUZF3f19HTc8fBG6oxYkAO2cwz0Kebq8WItAWIetQNwq7p0NuIHKv1C5?=
 =?us-ascii?Q?QAgEZ7C42Sf7kp1i3egRZFJa6AtTP9bEwToBAkyblPFLwY3Lvvog6WaC0Ad8?=
 =?us-ascii?Q?fjzYx3bcByn2WvGrJ1ZjDc8IgbxnNxLSb5HAGvb/5cBGnITYrll4kslkXlAX?=
 =?us-ascii?Q?0j87ULk6W2AMJEhlEY8kFir+VKl+fUoNme3Ckt/oAeKapjWznM9FyjbmWVij?=
 =?us-ascii?Q?FGdzbvJoxva4u6qyKtS0ZFG2RCBOKJF09VU/NUPYQZUb5IfOMF6U0Ng1PL6k?=
 =?us-ascii?Q?PVuk8Y+KSrzoO5OEafFsGiNRXlrMwygh2c1M3MRLrA9ky5lUhWm9Evcwqsi3?=
 =?us-ascii?Q?14KOXFSqZALrjgifrNb8vE8Y8wE0H5/suU5AK04EtATOt0CwC+ehHgA9f3bk?=
 =?us-ascii?Q?yD2W4N7iqeanmc4PAmjqcDQnu1NxIuwV8k0a1IJkHvNG3IQ0xQlWL8Z9izTE?=
 =?us-ascii?Q?rceXtytr1kN1xN0Nl8ydETKMbuuH0c/uLmFacCWuRleRY0AcTN//e5SlYaln?=
 =?us-ascii?Q?DhOfc6gla0OYX3YuNoYyW+gDdl3z6a7FCSFJDgil0DwJP2SA+QK7RKuVHCmF?=
 =?us-ascii?Q?KywNnaWk0cSUf4wixoJTeue7bdu4w4T8wSuw?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 19:20:37.7448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48558887-9359-4aac-9930-08ddbf1dafad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
Received-SPF: permerror client-ip=40.107.243.57;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jul 09, 2025 at 01:55:46PM -0400, Donald Dutile wrote:
> > > +enum {
> > > +    VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table supported */
> > > +};
> > 
> > Thanks for this work. I am happy to see that we can share the
> > common code that allocates a NESTING_PARENT in the core using
> > this flag.
> > 
> > Yet on ARM, a STAGE1 page table isn't always a nested S1, the
> > hardware accelerated one. More often, it can be just a regular
> > 1-stage translation table via emulated translation code and an
> > emulated iotlb.
> > 
> Because the user-created smmuv3 started as 'accelerated smmuv3',
> and had been 'de-accelerated' to simply 'user created smmuv3',
> I'm looking for some clarification in the above statement/request.
> 
> Is the above suppose to reflect that a nested IOMMU has some hw-acceleration
> in its Stage1 implementation?
> If so, then call it that: STAGE1_ACCEL.
> If it's suppose to represent that an IOMMU has nested/2-stage support,
> then the above is a valid cap;  -but-, having a nested/2-stage support IOMMU
> doesn't necessarily mean its accelerated.

Well, there are an emulated "nested" mode and an hw-accelerated
"nested" mode in the smmuv3 code, so we had to choose something
like "accel" over "nested".

Here, on the other hand, I think the core using this CAP would
unlikely care about an emulated "nested" mode in the individual
vIOMMU..

So I suggested:
     /* hardware-accelerated nested stage-1 page table support */
    VIOMMU_CAP_NESTED_S1 = BIT_ULL(0),

which it should be clear IMHO.

If not, maybe go a bit further like "VIOMMU_CAP_HW_NESTED_S1"?

Thanks
Nicolin

