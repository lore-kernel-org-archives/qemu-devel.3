Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F75CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 17:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFyQo-00077P-Dr; Mon, 03 Nov 2025 12:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vFyQf-00076L-1S; Mon, 03 Nov 2025 12:33:18 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vFyQZ-0005vQ-4f; Mon, 03 Nov 2025 12:33:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlRKhRo9/kpTe66CZ1pd3GId5P4I3HBO8E+h6bWV6TtKiz4/H+SpZH6jm+dmjp/njqBaOAaVz1QTirAzibQtiVCXwwcveIUiwpXvhahBEhFL7krN5BIJSSJBk/KMxhQNTTlLnfkI8ACAgSWn1gM4pXC4POEZ1X3AMcC1y9wv5fHS9f6xsuO4fWixaidm3AXPyLEgDWhGryLlm+6s6PB9eMXbjPPO8o47zX3yosdOi1OPOmjDJ0ctl2lm6lvKWDwt4zldvj6HF5WGy5h6veaawMn20k099iCl4HCjJ3ke3b7wztEp9+fZgepO6qbD+N2AdZKpgwUbL8nHjnzVi5+yJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHNwC+go8rbyuhnZcbRaD0WGgl86kGJbSobvr/bd1/M=;
 b=as9eK0OR3M6DNFX2M2bUzYEaVYkAlC9/xTpgscfypzihiRRF7POWWFlSDtOm4Gzbg1IeKiiyYWabUh9WK8v/ZDo1aU7x7FL2L/ctYgAZUxUmsmfslOu780EVHPl3g/zaNidZ5tRTnRs341aTPQWjhpy6pCFqPVijL19olX7/CLDjDNMaRdHsQI8QE2GgVKZf6f9MZPKRWNdy+Un9Z8HcpGEWiD5qw2QG6oaEsfr5aGJlU5RZKqPMbEXcxsyB+g1970S8A2dwOFLNa9KVFk8faOgcc4XqJRwUfdEhbkPlJIqtx88JWqtlkDJtt0H2qdZWKOM7gkrcnHEcDq3C6pDw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHNwC+go8rbyuhnZcbRaD0WGgl86kGJbSobvr/bd1/M=;
 b=Lhireex9//p9gcepB7P14idjOJ4hX/hQOtLRfM+8tZLi+yniI16HvkWioKY+jwPtO4GeQ5ipICcqHafORzGibKCTR3IpKc8tUs2UByPDZvNCHLxXCN6zjmcM5tx6DDrTgv03JcyPRPoWCfmgqcRmzYczyTFkRxPmly1BHb7raVr40eV3ZKr2W7FetN84ts/OYDSCcJQ+B0lQtGKUEL5gMzUhcLuzMyboAnfNoEHKQrX3wAU9IIdF8z7qGXcwkRHH9HnWFrnEmUssM6N2Fv45ZQny0yPNbcas8gB3vtusaq7zL9bThXC1sPgdZ5B7nPGBxP8BFXcztx+w8DJSH0e6qQ==
Received: from BY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:1d0::17)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 17:32:54 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::4f) by BY5PR04CA0007.outlook.office365.com
 (2603:10b6:a03:1d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 17:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Mon, 3 Nov 2025 17:32:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Nov
 2025 09:32:29 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 09:32:28 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 09:32:27 -0800
Date: Mon, 3 Nov 2025 09:32:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 13/32] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Message-ID: <aQjnKvO7uy81gnax@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-14-skolothumtho@nvidia.com>
 <aQVLzfaxxSfw1HBL@Asurada-Nvidia>
 <CH3PR12MB75484B6FB1F67EC13F4338DBABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75484B6FB1F67EC13F4338DBABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b630f3-4393-4256-ade9-08de1aff052b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VCBaJkCmlc5AFoCLxzuEHNJWLgSmhTxE/4VFB2F888b6/CLrarfZFnVcfkwj?=
 =?us-ascii?Q?88O28xen+c0OMzdmFmZq7dBIt8VzPJnYuyi8XIgS57yJ2RsBcC942kdYmVI9?=
 =?us-ascii?Q?1QpPeHI8N5CZ8a76KwCVSkSucTPSRKhv7LjCrI3lIoRmqRqjX2hhBq7nHZx1?=
 =?us-ascii?Q?gReIY1O2zdeTNR/VkuQ+1mEGFxIijBPMv12ozKD8RqEUTed3zIf2OtRnWzJV?=
 =?us-ascii?Q?Q+Yi2TVsi2yoVxYAEi+uXspc/YP/+Z2yWuyyLiK6R/pfF1vApkfpDOD+eu7o?=
 =?us-ascii?Q?6WStZzKIwrylI7d4jahGTdO4fRKr0y+Nz7SylC8f6GEQg+zbO1afAYRcE9VY?=
 =?us-ascii?Q?t7GHObU/oUcBm6CFfnWDpLWubgncPI6cjCRgsiKRwOIi/8RrcLC1jNt1rNGB?=
 =?us-ascii?Q?vbPG3Go7zRiuhpSz8uo2+LGGV6XUP43cou720G6OBSkCABmjDiBfbV0rYG4G?=
 =?us-ascii?Q?Me+q+kk9hI81ORjiojsZZfDCfMHEnxgLX+AWWOcm4oRp7zkx16iOBo/45GlM?=
 =?us-ascii?Q?p4i29VaQUIsk1CeCwiH8Z2SLW+XfjZ2aPsEoCrHDWSgp5BeN0MFNXEo37eoe?=
 =?us-ascii?Q?62uJa9pSEYV+TP8DKPoUDRXswE99bZ4AuTZqivNbXIwmZ841zuwo4IG/L4c6?=
 =?us-ascii?Q?rSM1n1vGz4Df2Xh+sRsdKoGYb+5cqVZjeBHszSc0s0yzvEihoPhteqvqe669?=
 =?us-ascii?Q?zPsvgp5Iordblr4seTVkK+srfitwUPuBVwSvqhg0GppV+24bBlzyw+7h20bx?=
 =?us-ascii?Q?oLOtjUFQ6uwzXMyETQe8eJmh98VNAYITH/74NEV+++RSyigPCj2hvuxCmE6w?=
 =?us-ascii?Q?J2HD71cydtehq6TBwwd0FSInGH2ur8Ty//ZpLlyEsEJGK3Rr4mU7fZj1yAQ7?=
 =?us-ascii?Q?WZoRcBxOcudpF/h4v1dV9iWa/LTKL6zmdfakT2Is4kwCKkmIy4FJp0rwNoW8?=
 =?us-ascii?Q?okkqAsqriANZALn/U4yt7Yeqfa8n5bnGyZIJMqUrkWAvgNhHk329l606zVNA?=
 =?us-ascii?Q?7iEti0uWuMTmAysMZBl3fpTiwLkmhuBm+us5WnUMjuvMdcSq3bNUAsbH8TP0?=
 =?us-ascii?Q?CFex3VtNd1T0v8wuw/w36gO/frtlKl859Z/8oN5LXi1N3jTdmsnc6efFreQA?=
 =?us-ascii?Q?+ZtEwfLYtqtevb9fr4qpwub+GN6WwraKp7t/u9g612sFPzjW8VNyxmZ63W+y?=
 =?us-ascii?Q?2JdZ3+OZvGsrXjEbKzm6l3GbmsfGRiZ3g4mL6gfStkojDsTTTGycK6Oww/y9?=
 =?us-ascii?Q?n/I7HOFDMM0WSA18hQemQblx6XhK2MdfqPjEAbkmgn/X24uE5JkZNcLCPOZf?=
 =?us-ascii?Q?hFvHxvnPSxnTYriy5EHJA5FEV2iVeoSff7iuMwQy5+Ztvb7j0tMRLIv3V4/N?=
 =?us-ascii?Q?oUrb7cspFtavtVO20fjI/qRxpSIJVUnxKMrZx35z+rOj7bdmLe8AuSDUul0s?=
 =?us-ascii?Q?ZICQLnXoNsjioO/MjMkA6piA3pSN6ITS6TzKC7I3PUr9q70wwR86n9th1MzS?=
 =?us-ascii?Q?78Uq0lOtOP/o22FeVDqHID6VcKlsh0WmNk6Av1dGWHkUeK3VnF0y9uOKRfTX?=
 =?us-ascii?Q?wOZ2rZSar7h9UJEtclM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 17:32:53.6967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b630f3-4393-4256-ade9-08de1aff052b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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

On Mon, Nov 03, 2025 at 07:11:18AM -0800, Shameer Kolothum wrote:
> > > +    if (s1_hwpt) {
> > > +        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev, true, errp)) {
> > > +            return false;
> > > +        }
> > > +    }
> > 
> > I think we could have some improvements here.
> > 
> > The current flow is:
> >     (attached to s1_hwpt1)
> >     attach to bypass/abort_hwpt // no issue though.
> >     free s1_hwpt1
> >     alloc s2_hwpt2
> >     attach to s2_hwpt2
> > 
> > It could have been a flow like replace() in the kernel:
> >     (attached to s1_hwpt1)
> >     alloc s2_hwpt2
> >     attach to s2_hwpt2 /* skipping bypass/abort */
> >     free s1_hwpt
> 
> Not sure I get the above, you mean in this _instatl_nested_ste() path,
> we have a case where we need to alloc a S2 HWPT and attach?

Oh no. s1_hwpt1 and s1_hwpt2. The point is that we don't really
need that bypass/abort attachment (i.e. the uninstall function)
when switching between two nested hwpts. The sample code that I
shared should cover this already.

> > That being said, HW doesn't seem to propagate C_BAD_STE during a
> > CFGI_STE or CFGI_STE_RANGE, IIUIC. It reports C_BAD_STE event when
> > a transaction starts. If we want to perfectly mimic the hardware,
> > we'd have to set up a bad STE down to the HW, which will trigger a
> > C_BAD_STE vevent to be forwarded by vEVENTQ.
> 
> I don't think we need to mimic that behaviour. We could return an event
> from here to Guest if required or just have error_report().

I am not sure about that. Reporting event on CMD_CFGI_STE doesn't
sound like a correct behavior following the HW spec.

error_report() would be fine. But we might need to leave a FIXME.

Nicolin

