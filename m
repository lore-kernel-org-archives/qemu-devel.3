Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A1CD637A3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBI9P-000860-5I; Wed, 13 Nov 2024 13:31:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tBI9F-00084F-QO; Wed, 13 Nov 2024 13:31:26 -0500
Received: from mail-bn7nam10on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2009::610]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tBI9D-0003SI-Q7; Wed, 13 Nov 2024 13:31:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2COHK5ODKWXCCFIwnjxx0nwHYLZeCW9Lnynegxhs1mqGmVgT5/I6gID2INGsGWYg3PhZlMTKcjSNEQJ1xlcgR3McqTfMGf4e0O732qhoQuFb0R8jgQILKUsTpYSV6gmKzxzhJUg3cswBjQ7JHIFJqPkTBeHcg1IF+QOKDTjEzsBEY0J9xSKI4HXYsvN069qR5njWSnLgakHhkQtW5P2EjPFojqAWQxYZalimw191k0unKkKggNcPpjxfFuBqyLL0x4LFXFUAtHJ7MSngwX/t+dosP7rjAxM6oO0WJf0FJCK7evijlUg9hPM3UUR7ZrqfNiZEdU++jWv8evZclHl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib50fnDmhD+XBx7rqiL/2IGGODB/z6weXCls5UwuCEM=;
 b=Nrcq+kp1BzDiNGcFEmHuXbW/MO5JGPnn/5i1KscOFysUakNW6alnRFBDDJkvgBKJbMxdFT0PY/7ANtymAVI9kEq1GNGSBMWsBIUh7pkW+EDjKu5dQ6Ma2EbKZ6Hus6Tk88M4Xl9DDlyGrcRAspbq2T5ow57d/lhla70u7SoR+1IsdbP8FsYWoa6ys5ZYzLrCoyQ+SThWVPqrMVYA9hF0Icus+LQvbtJo0URnK4fGMUH7unqDTGNgSp6+/Kv7sF7pyzWWiHfp5btT7tCiLhO3Ld8q5508VDgdNcvSsJFZImFz+uKN6Iy8Fizilwkw3G99WZgj1XX63ofJLfLP5VmDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib50fnDmhD+XBx7rqiL/2IGGODB/z6weXCls5UwuCEM=;
 b=o559Oa8yN/PNuunaArr2/HOV8abv+JvZMWyjHt42eArZyllU91VFkz1euhS3NKTxQ7Sq/xFRdKzP12p7VbYhoUQhlnoBmwZ2/x/o7IR6YjKr+i/J7vkTD0qz0hQhJUJEy7YkxwUIzTzLnekWbLESuxMDuQUaNlZ63l+RP8LGDpY18Y8sBXJlNEznDIfVj3LFvBnEzsm8W584CNFTP0XsLzI+4Fho3HgfpzqVSonI7EMD1gDoE5v1RnlJPdka3Pn4wIx96bQUbx9gGsx3pi8wx6rr3dGHHSzZU4X7zl1BHSIEf2xrgZvWaHib5r/mvjTEpLl3LPL9IQymIn5KdFj6DQ==
Received: from DM6PR13CA0033.namprd13.prod.outlook.com (2603:10b6:5:bc::46) by
 DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 18:31:18 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::66) by DM6PR13CA0033.outlook.office365.com
 (2603:10b6:5:bc::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Wed, 13 Nov 2024 18:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 18:31:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 10:31:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 10:31:02 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 10:31:02 -0800
Date: Wed, 13 Nov 2024 10:31:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 5/5] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Message-ID: <ZzTwZWXp0dIZB3E4@Asurada-Nvidia>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241108125242.60136-6-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 134b81db-499e-4d3d-1256-08dd04115d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fv02MTxgPLFXRRKTSXrs1Wef2OgURDalewuDjaqJAEMDOci7ckdnCshAopRU?=
 =?us-ascii?Q?Jsq59CcaJqqvZbYcqJwBThpyzqZyF+h/0ZPF84wP8sN9FGHGrbnVsvgYBFAw?=
 =?us-ascii?Q?5GsO/vByAQccug4tD/OV2PIgYNttVd29AFGkbjmK39wQfeeD/TY4HqNNp6gF?=
 =?us-ascii?Q?ivuU197iokNjJXGRa+gy7N8RjpshENSjwzgaY4LhMgn2wTiEkGu9sJTbMWfT?=
 =?us-ascii?Q?z2YduPyCyoCydX/zIP0Y9MhVXOknpYiUDf7aUGbNeZ1Pg/rqdknjlf0ywgWS?=
 =?us-ascii?Q?GeqhU3BxYOID2fM1RD1it45QaFYOWLlU0Q4AYBqRgK5Ps31Hh9xKgCxGURG1?=
 =?us-ascii?Q?Z1LXoMylsLJbMpu+HLK9LGnapUSbHk3TTgJQFL2WSyjB0PBJ65Q3EOr8a2sw?=
 =?us-ascii?Q?r2wrEFVF3iS2ZXvCYb71NpiApvDD0tUdJY0PdVG7WD6pr6kmopmd4cxPkmf2?=
 =?us-ascii?Q?SJ7TVxkj1aUIoVAhjPKYmgA70YQywE7ZA76L7u8ahtzeYQ+gK4xzt8UacL1/?=
 =?us-ascii?Q?cZYlPhLFEMhyjBtMcx3jdjyD+dbFFGZaUPJgVPTeZW0omA62lnwTlV2ORVwX?=
 =?us-ascii?Q?dC2SzUQdVjGBA4EBP5jv6pMsRuGcUx0hlfKiROL5WBDdcLDSd4D/IN9yQsHT?=
 =?us-ascii?Q?too2GkQVE+SdpWgjJzeBaGV0jzAJAJS6wGEdU/WCMjNrka7gf/SMU18t88B/?=
 =?us-ascii?Q?hgFbuX3PBFuz0/rRuN3mjQmV2DxhZY7VtC2ZNaxDvLmLBsx/cmik7ibfPjpU?=
 =?us-ascii?Q?rkvzhw8lHUsLJhbEjAFpofxRztJRrZ4U0q3CyYsN9FiKqFrx3LvIm/ROyYlz?=
 =?us-ascii?Q?sV47dLxie674r6m74UU/qX+FJ9yS5zw5RYQfr/ZLH4xZMGefLS8/ab3twUpj?=
 =?us-ascii?Q?J9m5r/wZvCSEs3Y3JcreFktVWrrUWJlj6MrxKETIsnl2OPdjZp9fklBXPLMr?=
 =?us-ascii?Q?8YL9UtdATHqk6ePcx32sI8x6AC/qVw/5RXrRdVECQpZuoH9IvpGRQZnMsNLz?=
 =?us-ascii?Q?RJi1G6alVqEtK1nh895FSnVlK5II2RnQdNLoRFlaHyNQjYnvxGfQGbyZdCBE?=
 =?us-ascii?Q?2GnGmRpBdYq5PN0vc89+kViJxFCAPxN28RZiTHn37LOOxOjqgwJgKMZnyJLu?=
 =?us-ascii?Q?ZqYo1lr2FCA2S0vtMypBoTNQC/Gw7zUinllB6b0PNEf0yAK2+BLw3FQbZlSh?=
 =?us-ascii?Q?EHQ7fVKmM0s8/DAwcABWuSa4/+lsN1sdR6gD5w/08jXj8mmi/gGt++w9TUn8?=
 =?us-ascii?Q?iNw3AMEqsrxhCm2UpH3+InASbGNtC7+e4x5vM13vVVrC1B2M+sCehBf9peeM?=
 =?us-ascii?Q?F3t39klsiInBaOTLzeu+n7VZylLTxy/go5bWxoIJFRrDs8tgdbfAm1ZUOEZh?=
 =?us-ascii?Q?GpOpP4YSl/2JupepQjqyxq0QKnYhER22nfwTjGx8Y5msBYENyQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:31:18.1031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 134b81db-499e-4d3d-1256-08dd04115d48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528
Received-SPF: softfail client-ip=2a01:111:f403:2009::610;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
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

On Fri, Nov 08, 2024 at 12:52:42PM +0000, Shameer Kolothum wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> To handle SMMUv3 nested stage support it is practical to
> expose the guest with reserved memory regions (RMRs)
> covering the IOVAs used by the host kernel to map
> physical MSI doorbells.

There has been an ongoing solution for MSI alternative:
https://lore.kernel.org/kvm/cover.1731130093.git.nicolinc@nvidia.com/

So, I think we should keep this patch out of this series, instead
put it on top of the testing branch.

Thanks
Nicolin

