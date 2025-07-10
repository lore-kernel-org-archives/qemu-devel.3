Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6C5C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvYN-0004W4-WC; Thu, 10 Jul 2025 13:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZusw-00020O-1D
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:16:39 -0400
Received: from mail-bn1nam02on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2407::602]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZusr-000200-QM
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:16:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/jnFiClEQPevTcUpf3Y1Ts8sXhTVqnl7EtfxAzZVbxVP3Zab/mC1Y7xDjrWw6IdB5jZxWJOa8BnEWWnb32v9FrlqH+CUvxpPyNrLAO03QLHjSkecPcWVf8F4IgrqdCJOzcxQ4yun4ygjJSkvVz6sU0BLCH3ieTHFDB3Arv8BARyy0oBzepu8+Ig6oXurtswdz2xZcHYKTQLpcSGXPSO25DoovBDCL/vDGVpX97zw4f4ndolx6OFWVl3xF9FP9ZKDTblqyR8HQ9JFz9lV+g/b0ESEfZp709olSD98UtGtXlB7C9Dvp8z9P/iSPOpLx6ljtfe6KMjxqkz3nERlheyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvxgC2gGjFedoMzx50feNydY8srcYJ9jVF4cF/m+/pU=;
 b=GIio4HyJ3nlWwwRZqfCgNeJKGFS9xhDV6OCfGXbh9Jiz1jKFU5mM4flFw0aY232B+V9Xz9PE6U7Z5vXloS7AoDOdVb5unBYsR+pBTm2wxL40mPJwHS8nMAF5qTiOrj2hMjH0UbtHjpjdFR/UGzChWSJ2r59LVQObeLa13/V1ji/dkA7A10hKCNBfxKKiGXHHw5g8RPxbb97f9zMrZA7xLTW2Rqzv7s87soL8wvape7QoWtf/EnXBZU6VIiMhY2150vVulsk5Xvj7cWVWUPSddmO10ttYtuSa6BUox3iypfDZ39A27eCUKwBLeExzGiE9x3uZi3gHZCfB719f9+VNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvxgC2gGjFedoMzx50feNydY8srcYJ9jVF4cF/m+/pU=;
 b=SuJHXM0L6FG/xFV1wwgaLczuY4aE6KUDEzGg+Ai4bZEAtfh6krlJLM3KTh55Dnt103cTQS5+x6CnD0NZLrOm6tPH9nfmUTo2W1jAJsidNhHukXWfk5kbLTtJ7wJeofVuhw6Jly/lDZZorqdwRLqG46QEDjEjcFj1iwIR6m6706KRYRtXe5rx+RB2b31ZqJeWAyUE/gpus3gmzIVECMkJa2Bovn1ryymINzxkPRdJEb80JtNwNTgBMnrIbt+n5JxMw4YWlwtaC1t4/nWbMkI+1/cdMKMr0Hz2FFTvo0SiXVlYtBk3WX7ZOOO5S7iNCtc85oJPl/B9NIlpumkIM8rT7Q==
Received: from MN2PR05CA0030.namprd05.prod.outlook.com (2603:10b6:208:c0::43)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 10 Jul
 2025 17:16:23 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:c0:cafe::3b) by MN2PR05CA0030.outlook.office365.com
 (2603:10b6:208:c0::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.7 via Frontend Transport; Thu,
 10 Jul 2025 17:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.1 via Frontend Transport; Thu, 10 Jul 2025 17:16:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 10:16:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 10:16:05 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 10:16:05 -0700
Date: Thu, 10 Jul 2025 10:16:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Donald Dutile <ddutile@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "chao.p.peng@intel.com" <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Message-ID: <aG/1U0qUq3lg0Dij@Asurada-Nvidia>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
 <01584206-e2c0-4881-aaf5-d6c552a30873@redhat.com>
 <aG7A8hxd1R4iVhGT@Asurada-Nvidia>
 <b3787ed4219743e2a65edd13ff44d9b9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b3787ed4219743e2a65edd13ff44d9b9@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a20c55-88dc-4a44-ef37-08ddbfd57e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CmL3CkEx+ybrhGomhxA7by3YOSoeZx8zlCl9dciNxus/2yPSA8QITNcenMLb?=
 =?us-ascii?Q?MCMk4goud2rxnuZ//Ad3GAWXSpoa53Ourf3sk5KPXqBXuaUYwbBL8AEfu/IA?=
 =?us-ascii?Q?TuWUGJc6s6hOxlJ9VtmBE7KcmVm3ojoAAGR3kCjn/VS1+UdBNvVxiruRLDaw?=
 =?us-ascii?Q?SKYkRLBYFvfl58CVi/5vU5KWwZOEPBiqGkuCq5teYGI5YhlNGfpg77Sf1l47?=
 =?us-ascii?Q?UKkjdghb8eyNR6qa4iFeCJ7YHZbcGCaWaJqk0ezo2X/utY5Io6+4MBfHpRfJ?=
 =?us-ascii?Q?HsMeSf7d4bXIEIuOi/75mr+4aEU9ZFwjV34otFWJ4Y8Eyynx4VbtSPlZCLXa?=
 =?us-ascii?Q?viRKUweUFuWqvt7Ub64a9ELeRCT6nv+d0S5jofgTOG5+w6IBVUI+Q8C3wE3A?=
 =?us-ascii?Q?e+Dzqsc7lQY6/rxiG66m7RRiZ2xR98uhCpfZqXS+G5DRyE7IyMi4/BKP1xF3?=
 =?us-ascii?Q?uAFnIks8zvy5cdNhW1P1glKP3sZ+D+Bvk274AGtzfj+X1oOM779hs8YuvG5x?=
 =?us-ascii?Q?jwZP7wlO87erpZd18psaYTOpBI3pStOXPBM2dYd12x8T/dVFWZcMU6bGusEA?=
 =?us-ascii?Q?IuzIWn4wllbdlYqUQHWyuDSH2QPWIKUHjwnn4sKeSb+fv0pq1XICN/66E70E?=
 =?us-ascii?Q?Vii8aOVmoKc/sbY37VLOGDAlz0yautQT1fHWSsrDIHuqXaIx6tpybYB4vGWv?=
 =?us-ascii?Q?1afwb8VDyIrtVMhn04QFTBsAuMPuTZ5RICbR9lHdmJ3pZT3dT3ijQWd8BAQ2?=
 =?us-ascii?Q?Xwcz5Cv9wJj9t2/CZtzt1GBAmf2b5JsPvlkpxaHhLGEGl/Ob1f2hi9zJfJOY?=
 =?us-ascii?Q?2c44ERWLxGHpXLHfNi4OfOi6juJcx7ZXtDWmqbxD1pXW9QQmv0sr8O8ra4sc?=
 =?us-ascii?Q?uut+XEuP2W7P2fe0Of3X6vehza/ue++Q+mLQ2hCTVFh0YLK1TRwQEH30YH90?=
 =?us-ascii?Q?WswDmzP7oQDC9Gcx9mevpVhRXaV5NWTV5F+dXc/5BtIOcA2TWcaGXh2WTNQ+?=
 =?us-ascii?Q?ZDLin0SdtzAiOgyv76zvrqe/0+S9KIMTtwv0Qo4QxB3vA4W0BIKY3pNyRszj?=
 =?us-ascii?Q?+KqKAvTFTCoQ28ZsFu1CseCxFdQB5SbDFkv7WLA3CNrvxkaPWW3RoL30W8vg?=
 =?us-ascii?Q?DHZGry5wBrPAtRWwh2nMzht0dEA+ecIOTrBz17dmOcrwxpNmBIYKduJGD3A8?=
 =?us-ascii?Q?r4izFtJjA1TcOzVtAJtfPVrilsyTP/vhJr00DKXtBSPIyid6Ev2FjrhS5pBo?=
 =?us-ascii?Q?aCSbTA4ytPD5dWynGM1LCKQbkuHrdB1ZVrFB4s7em/NvAu1ZLCV+w/I/yrOI?=
 =?us-ascii?Q?/fbtwflt1fpg9uT3meRHmV109h5iw8sjKTYXNs6vFkU7LLu7mTbhgjL+lDvf?=
 =?us-ascii?Q?31tmizJs/MZIQcIobiToBb2BqeYPtdKsFGrWqyzTFck0a0bfg8BPGcS9/h1D?=
 =?us-ascii?Q?o8Bf57VbVXx509nQgrJ5zy77+cH9qS6Qk2/vME63aM0F9+PcR+OaF1cQ6+lh?=
 =?us-ascii?Q?41dakx8STVSR8qYxPQS5PvUB61FCTCAfk3OG?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:16:22.7039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a20c55-88dc-4a44-ef37-08ddbfd57e8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
Received-SPF: permerror client-ip=2a01:111:f403:2407::602;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 10, 2025 at 08:11:28AM +0000, Shameerali Kolothum Thodi wrote:
> > So I suggested:
> >      /* hardware-accelerated nested stage-1 page table support */
> >     VIOMMU_CAP_NESTED_S1 = BIT_ULL(0),
> > 
> > which it should be clear IMHO.
> > 
> > If not, maybe go a bit further like "VIOMMU_CAP_HW_NESTED_S1"?
> 
> I am not sure the _S1 part makes much sense in ARM case. It doesn't matter
> whether the Guest SMMUv3 is configured in s1/s2 or nested for this CAP. 
> With the new SMMUv3 dev support, the user can pretty much specify,
> 
> -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.1,accel=on,stage={stage1|stage2|nested}
> 
> And I think it will work with a host SMMUv3 nested configuration in all the
> above cases. Unless I am missing something and
[...]
> we need to restrict its
> use with stage=stage1 only.

I think we do..

The HW nesting works when we forward the s1ctxptr and make sure
that "stage-1" is the last stage, in other word, the only stage.

Otherwise how can we support stage2/nested in a HW nesting case?

Thanks
Nicolin

