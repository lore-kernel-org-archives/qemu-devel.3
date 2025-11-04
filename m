Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E83CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 18:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLNH-0001YR-Mi; Tue, 04 Nov 2025 13:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGLIU-0003dd-16; Tue, 04 Nov 2025 12:58:30 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGLIS-0007ao-A5; Tue, 04 Nov 2025 12:58:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp2jeMFmBz81XAsDfoLeINVE7IzUvTLVlWOhdR3GpAveMCOvKDTvkq2Cnu6gKehzTEqqieHvzyCWGHuwKAzn07w352lXJKPUPtJN0QHgVyPAQ1+hWjQShKRCdiJk0SBqnAt/e1s5IN1Jt7ya5o0XWFgcviY1o2U92obsqfTvP+Vu518G2P4B0nWk0yHx0jy7PIpQJzbheZ1otoJaqeLpcqtuiwUequIVkcAG8Jrek1HfXDEQtzUEEpu16FFQGfMMAHeS+iLMxD6yJQkpQ0R5CnTjq1+DEXvYzCjPp9hoagoRjaeeC7m1vr9WuZBVy6oBskf+r/1Isse0ELh4hBdUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQWVHrN+Gj8syVpU70/Pec49UmvQPqFfwIuGqK4KrjI=;
 b=PU9lhZWNWYuxG2mD70IUcXGOuthbhexBbAiDPOVF2pkL4l8Fo5NarWBvEj1ApWLQQAwR+P/Fys8m5+oU0vBkrmGV7IknZvC9+yrObpg7xm3wfTLVLhaoW+/TnVK2p6TB8puz1FDh0z33ePstTwbWRwyP86xbsCqoEHXlDdMWyFGt1os7llrYsFVVBvvYzDRATRbHUy5Tg4eC5FKOwOf+uo0DqTHsV1z9vyfxBunxcZOslGy8K46GET1c57a0eJz+V2XZioON7j0SnL16L2idE+dDBuGvkv4sZv2MGAhgN+Kw9sCqrIRxL0V7L/cUPqZLS4l1ThbxLq9velrFbMmuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQWVHrN+Gj8syVpU70/Pec49UmvQPqFfwIuGqK4KrjI=;
 b=d74bhJ0TQT4mrywqAeXGmz4Owd2m7ghgkzxWrVL5kfKh2Vv8ivY/rCzgaqFEuOSjIfz6Nc+ZSpI3A45MTgU3Jz32SZV2NzXbPRm4mX9OJQykj/CtYa56w7s//OeMZx7apSfurEbBdr8g4xz1u2pgm4kzrqTWam5DAvaBm4CPNTnjx/LYbjpdv8kbHMJ9r2Vz6mSmgQluwvNLXA1glvnmWPE9CfwpsF8y71i00NWuepXXqdfpbtP5HH45+NEbIv4WO5AllsZmOIFxxsAefA+1Xc3TXo8U75Ty5O0eJoUsij7MY0gSwcUHWtBIBpvdipTyNZYM9EZaZYG77zt4bNmBpQ==
Received: from DS7PR05CA0096.namprd05.prod.outlook.com (2603:10b6:8:56::28) by
 CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:58:11 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::17) by DS7PR05CA0096.outlook.office365.com
 (2603:10b6:8:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:57:58 +0000
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
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:58:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:57:56 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:57:55 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 09:57:54 -0800
Date: Tue, 4 Nov 2025 09:57:53 -0800
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
Message-ID: <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
References: <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <20251104142052.GD1537560@nvidia.com>
 <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104145157.GF1537560@nvidia.com>
 <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104151234.GG1537560@nvidia.com>
 <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104153535.GH1537560@nvidia.com>
 <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104174152.GI1537560@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 12319ac0-4014-4548-d545-08de1bcbb81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NTjdujnhkjoQzf3lSFMSb5WV7DeftNGIHGfrd55+5imd0BIZAkbpuE3xy35e?=
 =?us-ascii?Q?jbn2Jbepl3EGTDRqIbd1aieLOlPoLhLrj6EfgB6C255wsYxJBK+fl6gqIX4z?=
 =?us-ascii?Q?vhuUu8BhUE0ESfPG9fsHQwEc2x1vOsPzDUuLUiUWGdxaC9LaQUhjIM0hwKxw?=
 =?us-ascii?Q?qjpJ8TkmYyBnAKOiEgC3+m8mYjknnMtqenHBeQ7lu787sBqFwfMLYHYoFiaX?=
 =?us-ascii?Q?yeUmVMNwRIxUMHCGgt0WNLrAEuNAfItXakznJetUHwjOtG1Y9b2cPaIAlmTt?=
 =?us-ascii?Q?M1FRGKC/o6g0STQjo6lj+Gk71ISHcpWUKh+9Zar0GfOJIUvu2Y6A5Vi3If6M?=
 =?us-ascii?Q?pujR+kn62S7vZXy2iILJ4wm0QFegEirVaeKVEuuQA+ijVz4MsANaeXS2aMzx?=
 =?us-ascii?Q?dXVU/YWSsG99b7Cm5y3Yp/zyuwW2NXqsl+saiUfUmruXbAgu+d72NG7INcj/?=
 =?us-ascii?Q?AziTfxJPkOnmwjkANwcAQSB18nLr53fn84GqI2bEBc4zh27N0iFOXxCHWDM4?=
 =?us-ascii?Q?xZkwTA8768f9Fwx2oVb+Wg+VMR0+1xV9xVAkPYwop3oXi6ngTjHvMiZsKah6?=
 =?us-ascii?Q?ZN6cJ/VT3Sf5MMxZborzGuApypcNAL26ECWf/OzMbgU63CkPgS8d2S/7AXet?=
 =?us-ascii?Q?h91wnK0SM+jxgZ3f+2FjgyD6NcKAIQfy9x/3iaZBbbh5zMAfM2yGsHyGVpl5?=
 =?us-ascii?Q?RV5ddKfloGV45+B/xCDqk5pMxU5I+40L+n0QY9gqjGIUMvwqZYeDoS2eDCG5?=
 =?us-ascii?Q?wVsQb8alBY/IiC1SM3vJFNnYe1PfgfT7oUccy8IM8qgWPgqR0x7QKeK7a6O8?=
 =?us-ascii?Q?XgRyAEh5jGUHKrLMnlQZazV+wOyqLTr0ZqsfPyrDVl7x0UzTUGNCQGkhWJy1?=
 =?us-ascii?Q?/hXG8P4016mtX/O9/OmcQlkokL+sdE5XdeJlRtDWzYI2KbtgvOvZ3na3lXip?=
 =?us-ascii?Q?WkULSK4ieBJq/TzODPQJaEoJFlykDr0L8qFpnz/mHI7FKs0T494wdCnwBt67?=
 =?us-ascii?Q?480yMkWmtxwe4rjktPDlmTvzlxxxwny7tRGEfYnPtpZR9uplzXuQQxhwUESH?=
 =?us-ascii?Q?4nfa7mh0EUiKsG8GfKf9q/SiziMEvWUUzSCZOzBAVnnxGNAj4o2AmUOpdRUn?=
 =?us-ascii?Q?+KM1Yf6x5L22kvgUo3mXKHNlxCx2GpqVrIx9QQZIweb2+xHAXVqzOwGR+VAF?=
 =?us-ascii?Q?3b1SoLIB5WlwOjCb/NBkxAGs31Iw+RW1nKZNoSvjajCRlcQaC44/xLmaVJML?=
 =?us-ascii?Q?P2yJYBiu4kajVYXu9Y/KxS5y3T/G768KtmkmXqo6QXpBwKnddSIuX9i7dNRf?=
 =?us-ascii?Q?wXr2W+xUextVGVcRZwjPTz/nn/6zy0JhqLeUnpQ9w2ZwY2bkMuFo0LU1+ijz?=
 =?us-ascii?Q?leG7pK1F+GXWC3+nB0nQDCZ4cbwdIqQyaM8Y94gXyypSlXrEseGpfcNooXni?=
 =?us-ascii?Q?OcycX7d//UGqj/9xccUlWZAJ2BInRtAWxsqDhb67YXiKscofJPWcZ5VVs4n1?=
 =?us-ascii?Q?Ka+CDlDBdI1BcPNg6uZFpGblcXbZfxru63Te3y/eArbZXR28bPfrzAa2uBEJ?=
 =?us-ascii?Q?Tx3f1tU3KmZfLj3KLuI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:58:11.2975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12319ac0-4014-4548-d545-08de1bcbb81c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 01:41:52PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 04, 2025 at 09:11:55AM -0800, Nicolin Chen wrote:
> > On Tue, Nov 04, 2025 at 11:35:35AM -0400, Jason Gunthorpe wrote:
> > > On Tue, Nov 04, 2025 at 03:20:59PM +0000, Shameer Kolothum wrote:
> > > > > On Tue, Nov 04, 2025 at 02:58:44PM +0000, Shameer Kolothum wrote:
> > > > > > > Sure it is trapped, but nothing should be looking at the MSI address
> > > > > > > from the guest, it is meaningless and wrong information. Just ignore
> > > > > > > it.
> > > > > >
> > > > > > Hmm.. we need to setup the doorbell address correctly.
> > > > > 
> > > > > > If we don't do the translation here, it will use the Guest IOVA
> > > > > > address. Remember, we are using the IORT RMR identity mapping to get
> > > > > > MSI working.
> > > > > 
> > > > > Either you use the RMR value, which is forced by the kernel into the
> > > > > physical MSI through iommufd and kernel ignores anything qemu
> > > > > does. So fully ignore the guest's vMSI address.
> > > > 
> > > > Well, we are sort of trying to do the same through this patch here. 
> > > > But to avoid a "translation" completely it will involve some changes to
> > > > Qemu pci subsystem. I think this is the least intrusive path I can think
> > > > of now. And this is a one time setup mostly.
> > > 
> > > Should be explained in the commit message that the translation is
> > > pointless. I'm not sure about this, any translation seems risky
> > > because it could fail. The guest can use any IOVA for MSI and none may
> > > fail.
> > 
> > In the current design of KVM in QEMU, it does a generic translation
> > from gIOVA->gPA for the doorbell location to inject IRQ, whether VM
> > has an accelerated IOMMU or an emulated IOMMU.
> 
> And what happens if the translation fails because there is no mapping?
> It should be ignored for this case and not ignored for others.

It errors out and does no injection. IOW, yea, "ignored".

Nicolin

