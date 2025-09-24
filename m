Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549A2CAC5A7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Klr-0003fp-Ke; Wed, 24 Sep 2025 04:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v1Kln-0003fW-LT
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:22:35 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v1Klk-0004XY-0N
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:22:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9vK5zcIp6LPTsMBG6HSxiYtrNfgKG2F2TzuuIO2Lcc8VJPb/s6+zGHXdXNXWf84uJC4sgUQXtMGudpfOZkSDp+GAMQeeax9tXySD0hOzyv7/R/0zGu/lrUD3TVw/HtZerxU2eT/cJRcZeLmIxPyeEDLKWi8xYu+dlrZbY02XOl4nyxWi+Jyvuyuwflep6thxiNR+kH0L3ydRgWzPbBYYq3FDALGXdTcoakXgyZnnzY4yMQW0KTvGVsV1vczQEHOWlCeYGxYmkVHRu89xsqOGTAKnP/3s4FcX8qNoAP+scZyKnVW3Dipyb8FSxxQtlFYVihJoTkAI3JpJYHfXMW8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/zp/rDJwwGSY8gANp/m7kBZRtPW82rOnhi2LCOBePc=;
 b=CioWeQGxJ34V5H6TA4hko+aLZNh8zC9ZbMLDCokzgniE/f9qbth0PPv+GHwKZsz1tGBfZyxDY14/6iPGx5EdWFhR3p929s+sS/ZqvodJWHtUxtLd6zDn076v/hWr2dBe3h+3zr8emSqbRVcv2fhMWWivObTN4AmuMxNXNHI7nzWGisp/yq33/UOKImqOP35ziC0ktS3VQt5bdvPjkXjWVWROjOVVYUCf0xMH2+vXz9+iOCvCqgalqrS5dK8bDDp4I9SIRvIwCcXP+H3q/45MlooqF8yfK1F6g1YQf/ml+OU4Nxed8heuTLbJRFZpt9BFJRhLaBCovtzyJdn1LTS1eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/zp/rDJwwGSY8gANp/m7kBZRtPW82rOnhi2LCOBePc=;
 b=cjsL1YfVSP+y9KNOzx2IotCEGWP5QF+QHDPAcBeYxLGw3kp5VL9rEDEcn+xCdsCDQmtC9XrG1YcYKn7ClU8TLjzgMpmRHVuC2S29Qrfix7vO+LcWgeKy9DUyjNoc1j6opGcpRMcvebUi4vi6JmcaV6IzGnFXes1ZPOa7SBO6DH/Zj22BXtOHfR5GjCtEhLAmpvGpFn3ujxO6d20uqd/pPwur3AxWHtpwsCS/BID8BNLCPyvAaNxVFud4h3MFk9GceofCcH77Bg2nPscWBxfmH7M+hKHOz4QXflw9veOCoccv2NqItynv/GBF6Aw06D+FlQdtoRSOvurHVR0vNfC2Ew==
Received: from MW4PR04CA0059.namprd04.prod.outlook.com (2603:10b6:303:6a::34)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 08:22:18 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::7f) by MW4PR04CA0059.outlook.office365.com
 (2603:10b6:303:6a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 08:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 08:22:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 24 Sep
 2025 01:21:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 01:21:54 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 24 Sep 2025 01:21:53 -0700
Date: Wed, 24 Sep 2025 01:21:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v6 05/22] hw/pci: Introduce pci_device_get_viommu_flags()
Message-ID: <aNOqH3u3vNFRukew@Asurada-Nvidia>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-6-zhenzhong.duan@intel.com>
 <aNLrOIbBxZy00cS4@Asurada-Nvidia>
 <IA3PR11MB9136AE59AECA079CB61C4165921CA@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136AE59AECA079CB61C4165921CA@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f0713d-5938-46e5-0d72-08ddfb437991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bmBj2xr87JMl1tNY8fRSY+x0S1TwMknQZBW9pEdG+kqgzqMNuXm+DM+8+Ogw?=
 =?us-ascii?Q?qZHU0hkEfeAgl6KF9fNmTTCRf8OG37q30E+tcNYbDZSqHfcY0J+l/RZuqSSU?=
 =?us-ascii?Q?txqUzpR+IwXCfe3zXoH0OFEu/M3aYWKnMkte6z2/SL8jkcF2VQTHa94qXM7u?=
 =?us-ascii?Q?FM0aAtFQaMxlo2/GxPZZ8YMZR5Co3oGeemJICOn13OqgqTGDQ5lHA8sFcMVc?=
 =?us-ascii?Q?+ZyIEUBd8z3tdY4xEgvitEpTGFAYqyJXNtkqlBpuFnnZRlmQzmP0s5Sev9CG?=
 =?us-ascii?Q?EbnC8kW5tegpicdyaPTLDGnUohi7/GR6cF1umI8gvjWp8mJWtcUvMhZ8fYo/?=
 =?us-ascii?Q?qpdoRQ/0KGRMuuh44IdxwFQ58ACmkYsJ+uhVj7ceKQoFouG6cr3ZyUuvkjdU?=
 =?us-ascii?Q?6arDGkcgH2jrlVZpaW6TnsMHYBaVp1RchFRbXGAJTLun+XZ55kUDwidJKry0?=
 =?us-ascii?Q?FRig6NiTxhvImS4XsbtHO+3MqztFM/BxKed4mSILykCCebYc6T8DnvOhQz98?=
 =?us-ascii?Q?Dl/IZYYGIwhrElYUa9cioVtPmF70naz1dJzVXb8o93s01yEp20tZPK9F+Bhx?=
 =?us-ascii?Q?TuuJQnhZQ8Jiwbf5xgNMDQ7efy4J0B6VtIAhio4dSAPCdADcPQN20NMqaJdf?=
 =?us-ascii?Q?PUlVNm/N8rY6RRmKX43GIL69YYnQVis9UruMIvf8APuhr0ZddIGK6K+B4hSG?=
 =?us-ascii?Q?iBrek4BmeQHJRM6PXz4vW4brmpuego/j5xT4nyaZpsesNz2vTs1hemOcQ8sl?=
 =?us-ascii?Q?YogfFLx7jhKr/R/CI08W+FXRAopCxe6oTLUEQxh7HGSYzbuqnvG8nqZBFQE7?=
 =?us-ascii?Q?5Ie7upgL61tFd82j/ZvmQcWXLah7JQkmQG3U0t+tN8xz+3yHSCUSpJslfZRx?=
 =?us-ascii?Q?0PPDETR6df8irndxoT2Yny8m2aFXLAxv6OOcLMUbCo/+H+9GfyDquMMfApSZ?=
 =?us-ascii?Q?CI2P6h37PoOQkqQJmhTw7hBEynFDNGSFC2yaeB/3m4m98IfACWtsee8TNS40?=
 =?us-ascii?Q?g7Wm2JV1//rGT9LdZgLMwKnrN+PHGqbTq4qIYH5TgYrEN+JfTw+bGgAEcOI3?=
 =?us-ascii?Q?C5ELRypFwfQB1CtheB81wiFh3WWP3QGgiacusR56JtYFuRkuHpOCK1UECsmk?=
 =?us-ascii?Q?snvvrdN/1K72uW739ypDJlLmacR7JOTYdnF6oZ+YY8oBMchpwlUiPDjWbZyu?=
 =?us-ascii?Q?ufo2nJJaXAmHc7Hpx/nbqPk5Idx0Z+12AIL5VwiAKPyEL0OLd9ZktQCI2uFP?=
 =?us-ascii?Q?IYfmL+QiCHjXATyVjKLk2S2uZskRXplUfVCfMvsXG9Y4C3qcM3ZWkUZOMLB1?=
 =?us-ascii?Q?8DqX5HGY4Ob+o0D0Upalvpx3OT512Ysn18YL5WK96A7PDtifk/KA6cKZgfzd?=
 =?us-ascii?Q?zsf+Q8/vAlnl667ebbFktAjOiv7UEkS9INMBiH2RlBLuCq6phZLbpWcGBcTa?=
 =?us-ascii?Q?R6EzJSq9U42jtFf9l6nWnpPbWSJ4rg01xvk1yNLQHNQZKWVecHfHZ43O2vut?=
 =?us-ascii?Q?6OtqiFy576cWvdBol41FYnz45JhOgzTVaqhe?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:22:17.5923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f0713d-5938-46e5-0d72-08ddfb437991
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 24, 2025 at 07:05:42AM +0000, Duan, Zhenzhong wrote:
> >From: Nicolin Chen <nicolinc@nvidia.com>
> >Subject: Re: [PATCH v6 05/22] hw/pci: Introduce
> >> get_viommu_flags() is designed to return 64bit bitmap of purely vIOMMU
> >> flags which are only determined by user's configuration, no host
> >> capabilities involved. Reasons are:
> >>
> >> 1. host may has heterogeneous IOMMUs, each with different capabilities
> >> 2. this is migration friendly, return value is consistent between source
> >>    and target.
> >> 3. host IOMMU capabilities are passed to vIOMMU through
> >set_iommu_device()
> >>    interface which have to be after attach_device(), when
> >get_viommu_flags()
> >>    is called in attach_device(), there is no way for vIOMMU to get host
> >>    IOMMU capabilities yet, so only pure vIOMMU flags can be returned.
> >
> >"no way" sounds too strong..
> >
> >There is an iommufd_backend_get_device_info() call there. So, we
> >could have passed the host IOMMU capabilities to a vIOMMU. Just,
> >we chose not to (assuming for migration reason?).
> 
> What about 'it's hard for vIOMMU to get host IOMMU...'?

vfio-iommufd core code gets all the host IOMMU caps via the vfio
device but chooses to not forward to vIOMMU. So, it's neither "no
way" nor "hard" :)

To be honest, I don't feel this very related to be the reason 3
to justify for the new op/API. 1 and 2 are quite okay?

Having said that, it's probably good to add as a side note:

"
Note that this op will be invoked at the attach_device() stage, at which
point host IOMMU capabilities are not yet forwarded to the vIOMMU through
the set_iommu_device() callback that will be after the attach_device().

See the below sequence:
"

Nicolin

