Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76008CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 19:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGMwQ-000878-Oe; Tue, 04 Nov 2025 14:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGMwP-00086p-PG; Tue, 04 Nov 2025 14:43:41 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGMwN-0006nQ-Pi; Tue, 04 Nov 2025 14:43:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xx7FYwW/WHQFmbmVv4uPDw8EfIhLmnInYERULYCWXWPrbfnVxebddXHfe+YX+TQ+AQ14tJMcoJivV/+Q1+lGSu71H2AG2SQrrCsyYqlWpsJ68lyWVIl9L7Yl9vhb3h19TLUiAhV1Xd+0peDao3bImcTljQQ4TQM6zlcbe3OLvmvg4rndt38FixaTXQ/+nCAPG3+CZXFP87JFaB4yjEJnxY9T3JGT8mLHAoq2MdY119enSwRADVSSCo3d+SxBzVNivLLlDVcC1oEeaLj12pocPnSgRY7UMLWkKP9tS9tzP7pmR0eyLccJ8E/xjHA04XGyyUfOlwHPQvTFLbTWS0x0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUuZlHeGJLAWtanGEoYXfZfMeOE4+JdcxRsfsmmNiS4=;
 b=KMxtbVHSXeKuBVh67xhnHrzw16ourf2v+DX5qL05Qa//YPSE2UVVfFDObZVXQ/U1JhrhWqh6qPQxZTW6VKs8li1BwDx1NG5myuhXWaHruvAW0Sf++9D8WUh5/K5AsqCRBrLEaGbu29L5HWBuXl4W07LdK37QNOQDrF60XArhzgy9x9NSpvOvCPdP9nkW+11gM5KyOQGp7s6kFmaTt4WgWcSl9VNASOunxrnBkZ6AlC3C8Qwt+uqqkBEqODhxNcRez9LtzWQADDbCXcJCHOx14Hm5uKv7Ch6/ZQj/eOnK5TrWOrFzA5JtmX+/VkadWSeq0zq0hetOGu2h7FJ/+iToqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUuZlHeGJLAWtanGEoYXfZfMeOE4+JdcxRsfsmmNiS4=;
 b=griy9V4WiMNgVznZKYQLlOipC9dX3YkjZi7vcX1Zi6aszFYS1UA287i5jjwd7h3O80xVJDJn6vNwlZfQYXN9WbsOyY7ySXRFT8EWH3912vpNNxy8slNxtfu+3zKph8+BCUlEsdBBBt1+9rmpvBrL/QfIvLcphtlDCAtDt10uQJZoQMGTh5z1qDGr4T/DpPROZM9fMf7cyj7oQec7RIXsVPeYfk2CV8tKxnn4U+Hoa8Xs5XXYSJCx4+yIYlBxdiH2zVkmXk/51nEY27r2J3hGAfOJhfFxce76L95BeFjueUuVbtA+hbPb6cQm9A/OxJE0D/ogtIi7A4s0LfMVtpnkBw==
Received: from MN0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::23)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 4 Nov
 2025 19:43:30 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::a1) by MN0P220CA0011.outlook.office365.com
 (2603:10b6:208:52e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 19:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 19:43:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 11:43:10 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 11:43:10 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 11:43:09 -0800
Date: Tue, 4 Nov 2025 11:43:07 -0800
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
Message-ID: <aQpXSymujCs9l+MQ@Asurada-Nvidia>
References: <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104153535.GH1537560@nvidia.com>
 <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com>
 <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
 <20251104180928.GK1537560@nvidia.com>
 <aQpJi37XslsYV+Ez@Asurada-Nvidia>
 <20251104185651.GL1537560@nvidia.com>
 <aQpUpv3Rde0PCCIv@Asurada-Nvidia>
 <20251104193521.GM1537560@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251104193521.GM1537560@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e90b60-f0e5-439c-bd9a-08de1bda6e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qAYdteYIscrtpyvCv+WyRfsY0yY8NYyiLNIAzVv3yKlQpo57FD19YWrmcRqF?=
 =?us-ascii?Q?S5gsKRhQST9iq7IphyeJm3pxvOEt6Cu4Ul6VvBwyCqrIHbn5zrjXLBKuZbJE?=
 =?us-ascii?Q?LzHY1rh6ryethROgcEMsThKjO8+WMR0BiYEw6AtQ01BDdJd3Gk+sB1vVWJJT?=
 =?us-ascii?Q?d45yTEbEO36etuBBx9Ohyhj4FryMLswcnqkurMbbA67jf+BeC+/t6p2366qf?=
 =?us-ascii?Q?EkK8PEU8fc5NwMFj5IeuEVs9HQCevJCwOaDT2I++/uq4QoJ/RrnmjBm/bu1m?=
 =?us-ascii?Q?7Vuho5Ilp3C0tN8I7d9TPkHBfCn7tZ8HeNDvbQkBI8qGWxDoeS2+Jf1wU6jV?=
 =?us-ascii?Q?L2pH3vpFUoAXF8P6lvYU211TF+1EnzJdNnCbXKLcNlvuFMgzhfq1+86HoAKs?=
 =?us-ascii?Q?lHLHer0fli7DtgrZJ33oo1SSCMLPfSXdE/orrf5Af7ysIEOOIrcSp4oqSctt?=
 =?us-ascii?Q?tBNWvWXeAdukPrqxIvIAO96xXCfUtFGQNnqqRnLoCbhH6SyXPJsexrSSar4Q?=
 =?us-ascii?Q?LvTJUINPmWZVBFQwjxGdWKB84Uj8iXtXVNIV8AhqcjkLhBPN4J6Cxe0tTPUi?=
 =?us-ascii?Q?tGPL6CT9NHYy+Tlp9iZ5IOkg81P8F4f8kH9icXdkdzYfKMrCVTW7jOpkN3lO?=
 =?us-ascii?Q?NpQnP2k99nlOx2QJ2/nVNort86OdoWzKM7JWH1VWKw7IVRiLV/gM4d/0eB1b?=
 =?us-ascii?Q?fn25f4ZULiPKS7nr3ZLtDP8rZRsXppfHVXGZf2FCjqntrCe8dYvZDbLSRA8b?=
 =?us-ascii?Q?RBX7gj+Frfn1vutZ1yCTxamA+7YJDlnzLzUsKUcmPBzRSZcDcF3N2Ts8LOg7?=
 =?us-ascii?Q?uV0/PeHntKK7hmbx0o4uaHxZkdX3nI8GW1SUWiQqmSI9b+uUAy7E/slauw9J?=
 =?us-ascii?Q?fwaaZ4YgYxG6lPLvaq8MKo4iJNzBwSUowOq40cTJ/KzQDO5n+WrrRAGdvWuU?=
 =?us-ascii?Q?+ybTlHCMREjruFK2NTUEsMVPvE1Ow8uzhiSXq5cgidt82/8YTXTSCOlSf13o?=
 =?us-ascii?Q?xjICpq4mwhqWV/YgWTkFPxj8R6xYjYMDyBFylIZN4DLQ/exRGBJqkGPqcPtz?=
 =?us-ascii?Q?4V7V8vfSXxg6buK1GJWuGMeMfrS9/LtNZRWCLub/vWrzFu20uC5cgetfVyzb?=
 =?us-ascii?Q?R6G/NSuPTtzTM/oSm/43+86KM405puM0bXF6GF8JB++6D/8zfaRoREKw1x/S?=
 =?us-ascii?Q?T16zv8v+D45fFAJv0OAj/O3HLIon5+ROXZaK/s6LEEj7rnUQNNVAooFjBEi+?=
 =?us-ascii?Q?9fIMVkxYFJBi2PziNg16tPgL20GWUI3O8QcRJt6GP9xZn+dwjghWiB2twHyQ?=
 =?us-ascii?Q?Fji3AZUSQFoMt6FrnR8L3EayofzPexLE8e0ZjdKyZuu1fE/7KX0YKvc4WRL1?=
 =?us-ascii?Q?mrM99qUreAnUZvlIEL3xyKUp+lE5vEO01MnDYNHAToJ2k6ptl74kupJuwdxK?=
 =?us-ascii?Q?lVFXH5uUa/KUAIGyS8EskCSf121WhW9Nqhv0MIf1FZz3YWteFsq6WnnitNOl?=
 =?us-ascii?Q?m9f3IcYSBeTZimAGbnArRF2eVUcqRjScSXAz1KvXx9h5FXAYuvjRnONK6Wie?=
 =?us-ascii?Q?jQ+h4lbq776Q8mXvAzE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 19:43:29.8635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e90b60-f0e5-439c-bd9a-08de1bda6e47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nicolinc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

On Tue, Nov 04, 2025 at 03:35:21PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 04, 2025 at 11:31:50AM -0800, Nicolin Chen wrote:
> > On Tue, Nov 04, 2025 at 02:56:51PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Nov 04, 2025 at 10:44:27AM -0800, Nicolin Chen wrote:
> > > > KVM would always get the IRQ from HW, since the HW is programmed
> > > > correctly. But if gIOVA->vITS is not mapped, i.e. gIOVA is given
> > > > incorrectly, it can't inject the IRQ.
> > > 
> > > But this is a software interrupt, and I think it should still just
> > > ignore vMSI's address and assume it is mapped to a legal ITS
> > > page. There is just no way to validate it.
> > >
> > > Even SW MSI shouldn't fail because the vMSI has some weird IOVA in it
> > > that isn't mapped in the S2. That's wrong and is something the guest
> > > is permitted to do.
> > 
> > Hmm, that feels like a self-correction? But in a baremetal case,
> > if HW is programmed with a weird IOVA, interrupt would not work,
> > right?
> 
> Right, but qemu has no way to duplicate that behavior unless it walks
> the full s1 and s2 page tables, which we have said it isn't going to
> do.

I think it could.

The stage-1 page table is in the guest RAM. And vSMMU has already
implemented the logic to walk through a guest page table. What KVM
has already been doing today is to ask vSMMU to translate that.

What we haven't implemented today is, if gIOVA is a weird one that
isn't translatable, vSMMU should trigger an F_TRANSLATION event as
the real HW does.

> So it should probably just ignore this check and assume the IOVA is
> set properly, exactly the same as if it was HW injected using the RMR.

Hmm, I am not sure about that, especially considering our plan to
support the true 2-stage mapping: gIOVA->vITS->pITS :-/

Thanks
Nicolin

