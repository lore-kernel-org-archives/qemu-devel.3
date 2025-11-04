Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F374CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKaD-0002df-Dx; Tue, 04 Nov 2025 12:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGKa9-0002cm-Bg; Tue, 04 Nov 2025 12:12:33 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGKa7-00055r-CV; Tue, 04 Nov 2025 12:12:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVF0Aivz3RH6jfdWtP3rh+LznTmjIu/QBwiohbtL6Sw+X2A5njkJG9HaZvhLaopxy8nnKiyZvU4PNRSAOT9g5uZTJSsXhTmZ9qWFmNbmVHdFfA13BNIyUDvHXC4CXD+c+VyA1a3RdnSFhQjYyN6nkJHOWUO+VeOlDt0nTxKiUx9ghwq/lIlPhwbDpqlRhSXmtxnmkqFIPdTDVOIP/p3ZTX3KsYU/3b6bxXwrsIvW7BVKDxg/Jof8Kv1Ts6iZqs/n/dPHEYu//xaXhKodyiP28lffHpDEV9WRpx9qbYNs57ioCou8vvIg8RuZAqkGs6BqkeKJ4u4bB73B7Dc78h4HNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9NC5A93KMae9iv4i9Bb9VRaqyyxtaVPR69jpJZ3Pmc=;
 b=rxKHhKSgmBjqNmLGyiQ0HY16T9h+86Sf8Lt/cq0NLwsDHh6Ac0wXVcQD3vvvVI1LbU7x4CcZ2+J9jhoq9eqVyb0Fo8nPnpzWrOIJSi3d/oB3USgdiwud4SwWtf1qxMCkCzyksSFABn2TbQ+vrb3ECy3SKbDHmMgF0fqoyBr+BIVn+1i0e74OvZeaV78LHjMmJ5ofW77AyStx4CvO02ujbmy03DNY3U+jb8kri70z/VZY5Sj7Jslgdp8OMsUuZ/oqi6CEgD4XE0AZGxaZEEHLtT1N5wG4EybQeviJ9aqcNXZ7nd4rM32vLgtpBnMkScwlSVxGy5kAVnDT9RyoXEVxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9NC5A93KMae9iv4i9Bb9VRaqyyxtaVPR69jpJZ3Pmc=;
 b=AP/UMj7WIigjzRnWG2AuKARbRr68hkv7i9HMGSuBSEUXxtQcZpaQyN8EF1/diRcsCbi0rUh1rrU9lGOiPjHscljZnAJ+Ry2cY6tN7JpFheagpQ1JPPlxqkdRs+GhGusJvKXzwnxw/hOdt6O5yCk+qEBmDGT5GiuQRaNSlVoxTw68FzvrJVxkRedL8OtImBxWe3h5G40vel8K+mR2nWc8bN4fQ4awyWUsaDktxXJFxrogBrRJ5+WnzfZH4CKFrW01E8x8TWmeQyGXY1JR2084302tH3Osx8d6ovCtpRnpmS6zIY+Y/EUPp2vngIVKfU29W/S0JEWfMBJZl+wB6FgmbQ==
Received: from PH7P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::33)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:12:19 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::a7) by PH7P223CA0025.outlook.office365.com
 (2603:10b6:510:338::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:12:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:11:58 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:11:57 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 09:11:56 -0800
Date: Tue, 4 Nov 2025 09:11:55 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, Eric Auger
 <eric.auger@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <20251104142052.GD1537560@nvidia.com>
 <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104145157.GF1537560@nvidia.com>
 <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104151234.GG1537560@nvidia.com>
 <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104153535.GH1537560@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104153535.GH1537560@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cc457d-2782-4d90-4938-08de1bc54f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SiA4CVWJ/c/lgStt4wZsQPLp3O5ohhDbJkZCHdx4Qpi8sfk/U9cUkCWFEx2o?=
 =?us-ascii?Q?eqb+dqvWLo566VnUj+r2ysHc8wP7+wwnTo9PU3wA1gApKjy7NggUYtbvIPQ5?=
 =?us-ascii?Q?/Os4zet3dXwHSidZylhcelVRRe7qgV51PqxM1k8yyQGExNKX9repcrzPGq/s?=
 =?us-ascii?Q?jzCZYmFg69stYvQ7dDCpbauYYquaMLc3xLMkq3iqwY2fvJMkZ/+cYOXpTAn3?=
 =?us-ascii?Q?RWTtUDOvVCBLRX4OgAfIgfivJqUmKaT9X9KzzpuNKMgSI4TFNzAobye81foN?=
 =?us-ascii?Q?4U6B2ieQGfofxFFZdYElJAOPPEwP5LULdU/o+T+MmhXtUY1VrZd/4Tx17Ija?=
 =?us-ascii?Q?b8ygn3lDNMlCkk6GhQMqZU83MVxg6A1hSJo5VtedYQ4KlDr1+gzeuh2jBZfP?=
 =?us-ascii?Q?nc58vI7bzPGveLqVfF3OU/6ngUB4MDLGdbik9Wq1gxZNSphSZ6XtB+8DsTck?=
 =?us-ascii?Q?rj2HhlOjZN6wLwJERytLv2C0fNw5uMCcdv0rw5kScTWDRQe7zKtjLH8TpxIe?=
 =?us-ascii?Q?WPLNFoqCBxZY7bgR8FdzY+qOBm9G5A9Ic/2NQ3aH+q5tM9fIN1sN47IdYJZy?=
 =?us-ascii?Q?BJk7b20gaIK9sn/91T9Cp1Z229AAAJ3ThSQvbHKUpb3sDzPMmihr+BgTzDKB?=
 =?us-ascii?Q?JnOQkcBnXNy8sxGKV4DVVwrhncSEtWLH+Fg1iRYRaPIL0Uo1ZjyqLwpKZLiD?=
 =?us-ascii?Q?0YP4ga/Y9c8sp/+tX7Nhj1u4Wi0VtlaJIkgNNkiE3lhL6MA9W0g4uUgFhRkU?=
 =?us-ascii?Q?4Wkts8/5Mn/uY8c/bYn4tm5qLJ/ZcWKGunLY667/PgeoxUuxmmlbuAWmmXkZ?=
 =?us-ascii?Q?1IVKIz16GzNbBrgIY+58ZrU9khfypHRyJg1ZeC7lnJB5x1FAq56Z+8OQxg1l?=
 =?us-ascii?Q?DxH07H0l4WV6MPyu6EGv0NUlDUZU15w2OWD8sFiLn8i7UqppqJ7KnWotn7O6?=
 =?us-ascii?Q?fl7ZJpS/oSvyjqC8TTsAEC/uPllXbO7P689mNft0rC+bFv84s9vE6yDeHuxH?=
 =?us-ascii?Q?QlKvLftu+bHJA1aqGIQM0ns1krX25hBJZFdvAt8K14IjeAH/4KrbacUbyUtP?=
 =?us-ascii?Q?FMx4fP2gmDmafeXcJida+M2W4AI72o33M/3kwmTwoqBnM2FHG3bS/5n9bVms?=
 =?us-ascii?Q?u2fCYPbijg92iaOKEQSiC8AxoCRwSq2Vm3sJ1WcbYOsk/xjqg4aheqc4LzoB?=
 =?us-ascii?Q?WnncD0JW5a4RbLg8Vkd83UWbtmAv7OqdEJ+9dFoWvenlYU+XOqXXM1muQ7AT?=
 =?us-ascii?Q?y6dwnFxpnuGx+LnVzaYut4v1vqFKKhOSfIulR8GtXftslcIIlk/yc5Yf75G7?=
 =?us-ascii?Q?fLOr8xjHsFFGnOq7e75pQKu2dZrZHj05UY/ZSzLU4dE1MjPtWTSeBtnA9s5C?=
 =?us-ascii?Q?AlhaZL8I9wwSDsirieR+2mxDDmyIQ8lZ4RTb4TTsdBk9eJ9rpcu7yKoro9Vb?=
 =?us-ascii?Q?g5D+bg5bKnvtOKnM75AfcksEy+XOYiNY82StIPUg8N9FzFG5TEsNtkK4D9Jv?=
 =?us-ascii?Q?y7n9/skda7E5Qj/uWJ2rUoBSfr4EOQECx3UtpVWIfMAuoXW/d75pvZyp+ECY?=
 =?us-ascii?Q?MdV8KkuXZbE3qz6Kf1w=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:12:18.7996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cc457d-2782-4d90-4938-08de1bc54f7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nicolinc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 11:35:35AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 04, 2025 at 03:20:59PM +0000, Shameer Kolothum wrote:
> > > On Tue, Nov 04, 2025 at 02:58:44PM +0000, Shameer Kolothum wrote:
> > > > > Sure it is trapped, but nothing should be looking at the MSI address
> > > > > from the guest, it is meaningless and wrong information. Just ignore
> > > > > it.
> > > >
> > > > Hmm.. we need to setup the doorbell address correctly.
> > > 
> > > > If we don't do the translation here, it will use the Guest IOVA
> > > > address. Remember, we are using the IORT RMR identity mapping to get
> > > > MSI working.
> > > 
> > > Either you use the RMR value, which is forced by the kernel into the
> > > physical MSI through iommufd and kernel ignores anything qemu
> > > does. So fully ignore the guest's vMSI address.
> > 
> > Well, we are sort of trying to do the same through this patch here. 
> > But to avoid a "translation" completely it will involve some changes to
> > Qemu pci subsystem. I think this is the least intrusive path I can think
> > of now. And this is a one time setup mostly.
> 
> Should be explained in the commit message that the translation is
> pointless. I'm not sure about this, any translation seems risky
> because it could fail. The guest can use any IOVA for MSI and none may
> fail.

In the current design of KVM in QEMU, it does a generic translation
from gIOVA->gPA for the doorbell location to inject IRQ, whether VM
has an accelerated IOMMU or an emulated IOMMU.

In the accelerated case, this translation is pointless for the SMMU
HW underlying. But the IRQ injection routine still stands.

We could have invented something like get_msi_physical_address, but
the vPCI device is programmed with gIOVA for MSI. So it makes sense
for VMM to follow that gIOVA? Even if the gIOVA is a wrong address,
I think VMM shouldn't correct that, since a real HW wouldn't.

Thanks
Nicolin

