Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A59ECA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usND4-0000iV-5r; Sat, 30 Aug 2025 11:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urusS-0002Gh-DD
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:54:34 -0400
Received: from mail-dm6nam11on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2415::62e]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urusL-0002bH-Ry
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:54:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjDC5VBBYY9uhlc7TVUaoDVnVk/9N2c9y/MXvRM0bEEdNFivaEP5uoQyjohroKzDgnNK/EpgSOCOrXdX0GpItPBppBXDfS9NjeqC63EzxHStpn29n6Z64LxZQWCeiCDniXbXDZb6kkOp1KdOim7bcNC/Qz8qJm/aBp4PFzuoUvLle3YVvg1AmCOLyDoo8uucV2ILmACIlrvHu3NC7I0VrD7kOnq+t22UPGvwXI4E6pk0tJLgBlPC0GFaoXDCo1xqlbNF6C4Ej9uw8XVzoTfQ6G50jI8VwBlYhUR7OYfw9QTj0B3NeJ85GBlYaHxVbOiLvH9XduHKiRH1f8MzbzuJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAev/+24X+uGf7WFS9D33rVew8lK8iLv1eksPb2h9ew=;
 b=uGYknwTPWM/OZd/a4gbHtJg4TG7naGShFELB3WOrA1mCNYB7yMCJMiHG8Atq+ZFJWGQ+Y0P8AdveMEbC0YTulP/HzmDHf827xS3exDoq9MVHj1z1YYH20j5vv7xZ09eDYLxWBkM+L5qU2PIsQByG/McIeSgCpaOuWM6PnAoLiYhgHPv09khIfbnHFLOq4BhcqLVKGgP1f7Vcf3wfVyfAPAsvLifdwcCKwp3dOixqKh4BnKulhDc/wSjj8EcC94SfYVkroQJgQiXa4cOPoboYL7zRk8d22X3piHathlsz/FgQz+3PLQnjvOSGgIXjXulVJ7YjNecMJjU2+v3iCNBGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAev/+24X+uGf7WFS9D33rVew8lK8iLv1eksPb2h9ew=;
 b=uPpRNfUnwTVoQPrnyaC9xiJbE/A4SunegkTwLkw7biP95tPCP1FH5LvM5cX/h1gUMYOPFFDncbgvlMMyPdFcZyV9WEjh0kHH3D/T9NPvEqUq7vwFfnGsD+lttghCEKXgaGSLVAdKGREAfr3llxSaKHdcoARbWFrVc2rGZO3sCgqYnseq506oTXMhG2Ju8Zzbybho73RDChH13/y4sMM1iQ9PNb1fhWTowFVnH/xmrgQCJAsS2iAsWURtDpSFea+31u9vAqawUkJfYbpNwvrPGbKqs0FQcaWGt7/0SujhLtx3XiKTTzPwaIQkkW0B7jR0NKgAe3UMTRY6gCKVFhVw/Q==
Received: from CH2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:610:53::32)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 08:54:13 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::4a) by CH2PR17CA0022.outlook.office365.com
 (2603:10b6:610:53::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Fri,
 29 Aug 2025 08:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:54:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:54:03 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:54:02 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 29 Aug 2025 01:54:01 -0700
Date: Fri, 29 Aug 2025 01:54:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>,
 <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
Message-ID: <aLFqqHGNEkKknRoY@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-21-zhenzhong.duan@intel.com>
 <aKkDXiSwWGgio0dM@Asurada-Nvidia>
 <fba0b1ce-13de-4c80-9f44-4adc07cc6934@intel.com>
 <aK8fsD+c0LAXzB3y@Asurada-Nvidia>
 <6dc3e334-7f22-4f8f-a801-b9ce07b0bc4f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6dc3e334-7f22-4f8f-a801-b9ce07b0bc4f@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DS0PR12MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3390eb-b6c3-4e75-ba91-08dde6d9a0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pRtTfYJxelQdglpBE3esu6AN3gCa2zXmiUzytnbHyNsdRRMVGbFz49L/e2mo?=
 =?us-ascii?Q?w8HkvDn/cVNOcrmJXGnp+wbBhSbcJN6qe6kQ7N/s29AcstP3iR2c8cPaRI3+?=
 =?us-ascii?Q?Sna+UntuqIZaVLLRLg7owUK+eYUrLpkpPES7U+4LGVdAZixvy4etMIOe2rIi?=
 =?us-ascii?Q?n9c0xeho2IMENUotcz6wKVsmei1vC+nDSwFz5Ux9SoOZVhB/75jRipxl5toQ?=
 =?us-ascii?Q?9FpZjOkD0Yv0oISNrxaYXZy59xw7IOjK739n4kcseRQmf7n3j+uXZXNbDTXP?=
 =?us-ascii?Q?d/ixvyYKynp2ZruQgVWgpihwdCR2p06TkBc/5i6gNC5fKNukvUt6k0oHNudU?=
 =?us-ascii?Q?mZdVmZ8qIvy4IZKzMtsf8QKhmBwD7fW+fysKyVlsxhrfj3WyZdrwahyy9ONT?=
 =?us-ascii?Q?Ah/A36hsEm//GoNvYJsV77wo56vZLqBHbfVsOWjD8dBcNr7H2rqE9xzojGyN?=
 =?us-ascii?Q?wQoYJNlRBVbc8PVZQaPN0v1snvCxYkqO3s3xNTHBEnIuJdzlUPoB2p7IDT9W?=
 =?us-ascii?Q?mgVxYv0W8Je3mr75Eu1FrKI2dUeOzngtqFsT9Nl3gsBATw8Zp6sAIqzcFrKa?=
 =?us-ascii?Q?GaVHlvOtDkpfpp+SIRaoFHn06OiUaY03HOHefpdvZj6SpD6xMhG73UGXjetx?=
 =?us-ascii?Q?li7NfnBqumoSolbFDm3C3VRTS3f6W7TgiTMjdTX+pGeEnPgpE/Xi2FOz15/h?=
 =?us-ascii?Q?IzxlX1OzZadd2gKsl6eJIaocvtZ+0jnOKgIfjJIMAXS0DF217bbcByXFUQeI?=
 =?us-ascii?Q?AH1xq7Xc+HOaf/C5M/a3JD19TmIigWjpcisDMxamevEZWcviRTrBwqy9AkF8?=
 =?us-ascii?Q?iFan6SmO3Jk3CoKS3ijo1IJ75/ysLa4LTFhYnaPf8VaXYrHNzD8Ldka/Q8m7?=
 =?us-ascii?Q?uIo503iIrwo9t1IKoH/pjNhy8qLm537L5u2xWyDOrRhj6ehUDdBXsgjnD+Vj?=
 =?us-ascii?Q?zNLbu7e/yn6TYktjNc5TKk2ctN7IuxqX2kyXhnSXciZeLJ7B9zHJSOznb+nI?=
 =?us-ascii?Q?Ksk9/XM0X/Xq/DEQc+xwKWQUjSyHcFBX31sE/ExLHECgIvjxcL4vVShPpLgV?=
 =?us-ascii?Q?CPmOWn2Ye6a1Tx0pBwV7rK/Pm6uLWGi5tjGWwum/XJHB1C3OUPqk9sbA7vxv?=
 =?us-ascii?Q?/q5cx7uUQYxKdEIjgcrLdeubHG3WnaimGZ3CK089mtqq9c2cIWKr0V6iDQo+?=
 =?us-ascii?Q?E9Zgw9F16jp6oWCm3WIChIzIyTjvtoGy0IY1bVx/iwYM1xBoAH6rvqouivIn?=
 =?us-ascii?Q?h/qfVkUGovPitEZnzm4FyGByLy4jIYhICgA8yyc6ftQTKZDZQicadmAC/pzQ?=
 =?us-ascii?Q?bufDQXMzNuagAkaG+UlvA4H2BTekWRULuslFOQWM+L1hwzvVa7Zu82b2A4/G?=
 =?us-ascii?Q?0DyozubHIbMwh85N/r9VzxFSFthtt5ViCQa3uvIPXAYkOAC5ne+RIpSjeWON?=
 =?us-ascii?Q?dOOTpoigonlAmtTMDbITDa6GSf/BIZTtJ9IKnC42dEQagaE45Kc5umfmoSc4?=
 =?us-ascii?Q?dBwp70fO29FEIbAx2tPZbTwY6sKAUPB55RJp?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:54:13.4782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3390eb-b6c3-4e75-ba91-08dde6d9a0c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582
Received-SPF: permerror client-ip=2a01:111:f403:2415::62e;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Aug 29, 2025 at 04:16:41PM +0800, Yi Liu wrote:
> On 2025/8/27 23:09, Nicolin Chen wrote:
> > On Wed, Aug 27, 2025 at 07:56:38PM +0800, Yi Liu wrote:
> > > On 2025/8/23 07:55, Nicolin Chen wrote:
> > We could start with a function that loads the HostIOMMUDeviceCaps (or
> > just VendorCaps) dealing with vendor types and outputs generic ones:
> > 
> >          host_iommu_flags = host_iommu_decode_vendor_caps(&vendor_caps);
> > 
> >          if (hwpt_flags & IOMMU_HWPT_ALLOC_NEST_PARENT &&
> >              host_iommu_flags & HOST_IOMMU_FLAG_BYPASS_RO) {
> >               container->bcontainer.bypass_ro = true;
> >          }
> > 
> > Over time, it can even grow into a separate file, if there are more
> > vendor specific requirement.
> 
> you also have valid point. I've also considered to let vIOMMU to invoke
> the vfio_listener_register(). This might need to change the VFIO logic a
> lot. Conceptually, it does not stand very well... And it is too heavy
> for WA an errata...

I think it's fine to use a flag. Zhenzhong's bypass_ro patch looks
quite clean to me.

> So may we just start with a function as you proposed?

Yea.

I imagined that kind of decoding function in the backend/iommufd.c
or somewhere closer to HostIOMMU structure/function in this file.

And I expected that the WANTS_NESTING_PARENT flag would need some
validation from the vendor specific hw info too, by ensuring IOMMU
HW does support nesting. Then we could reject the allocation of a
nesting parent at an earlier stage.

Now, we are doing in a way of pre-allocating a nesting parent HWPT
(so long as vIOMMU wants) and letting the set_iommu_device callback
do the validation of the HW info. I think that's fine as well..

Yet one way or another, we do put iommu_hw_info_vtd (HW IOMMU caps)
in the vIOMMU code and validate that in the vIOMMU code right? So,
argubly the whole separation between vIOMMU and HW IOMMU things is
not that perfectly implemented? :-/

Thanks
Nic

