Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1CBC71159
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 03:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRMn2-0008MN-Jm; Mon, 16 Jun 2025 23:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uRMn1-0008Kw-46
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 23:15:11 -0400
Received: from mail-dm6nam11on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2415::60f]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uRMmx-0005m0-PB
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 23:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZhkSUMXo225U33irJQsFp6hVE/nSTz3KdD1BYGDHhGpnfDjZrUuizXJ3sd6qJNqBcjrlCr/cCJMN8WfE2Gl/rP175E3a/Bom+qwef3anuCJRMbUxs8F10d4vh4XEjSJVtUcen3lAlYXGH39ydJNqk8uKpSXcDp7mQtj57Up8eR6HYttlfiELwe0KG4gEjLujyBaSi+TajIb0FVoMzLCWBcskIs7/NMFT4kUW8pdlvaVLfmt2OiKuCz5KjcFQOEs7wuGzyBCJFpAwdwOclTh0T52NhiCJ7NxuV70cwGlMFrWPAA9GQMS3jDukB7j6uoFz+IXPcn2ZJfkEYrTnZuHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ApzUBQjTbI+Y9UyQRc3i1GsJ75GmD6u1wxhDRpcG3Q=;
 b=O6QWf0tviT3VzQdWDvOqohPCgFFwI/uaTsrZ2OsOZcdn90OrRr716PhmRlT68K1bfhKJ60E+5kdtOGRaBOkZ64s6pnJfj7O+AlYGoV/LAOXE8xExNVVvcAmXgYauTWp8UhtNheHmDPD6JezaW6LD18/ZHr+N5mHFRcVYoXzY9ZfJASk9zhs3aE9/OmOzZOrPlLsRFUkzskcmWRjpfr9N+nTbiGWipzNbUSqTBcfKk0O0UaNnIXiQvqxcIbPcySRmJxQwPd+LyVQgku/Q5VTqbhWk77hl6WYr77jT/S+QQZOHiUG77KXirf3DHmvozmgiwaiieKSx/bYHZKcx09vj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ApzUBQjTbI+Y9UyQRc3i1GsJ75GmD6u1wxhDRpcG3Q=;
 b=OpTMbYFkpGBSPNvFF7DMl+KnIh0rj7V1xuo/46dAHdEWm3YPTHkiuI/XkQV2yxJ2+85HrNukgEo7v5lUD17kedjizgYKchqJMRQf9BPfTlFnaDhpkDC8M5jlMMSI3gJulIPZAuOi7x8bM2kuscL9EYZ4ffaJFURrI9evM/nS0zpLPfZTxdRBLxPXeBzWywQW5ANUlmse2qIyfuvI1Vq2b8T42iOEambWQGRpvWXcbGzPBsNhSJK0oz8P/IDLl+HLsjkdZQ+V/Oq6Kp0MByOGmqW1oRAwQllBjdgJRXPuZaXnUJGmu98vj4dTdwv4CvqX/zK2eE8/Ju+Ys6/CEloNVQ==
Received: from BN9PR03CA0948.namprd03.prod.outlook.com (2603:10b6:408:108::23)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 03:15:01 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::c5) by BN9PR03CA0948.outlook.office365.com
 (2603:10b6:408:108::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Tue,
 17 Jun 2025 03:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:15:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 20:14:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 20:14:50 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 20:14:34 -0700
Date: Mon, 16 Jun 2025 20:14:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Message-ID: <aFDdkxPODYnyG0Vo@nvidia.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <aE+wCIG8KHb3u1lV@nvidia.com>
 <IA3PR11MB91369A0E98CC76ABDBA365809270A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB91369A0E98CC76ABDBA365809270A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: 629cdba8-2a4d-4a7e-b317-08ddad4d25c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W6+BXMnc7R9Xx74JtG++cR+1jJPt9stNo7kj2XeC2Z3kYhikAIljMr6KJPhw?=
 =?us-ascii?Q?M69KPPntEDn/qIc51bRABHYr8CuSf6EOVWme9bXL0qn0axXzHuaCAWmFhaxe?=
 =?us-ascii?Q?Hacb1w3+yA0mKjyQazpOsrqAvh9kVvVHb+kO8Z2y46CQlHxUhMG6ECCLJkkF?=
 =?us-ascii?Q?4bv2SO7eAyb8D4iWMWCSHiS8RObu5upG3Hpw9Tdr9TC/B7rUhv1rDNVbjXC1?=
 =?us-ascii?Q?uIjSi6HbZKRUusEieBWIz6ALCb8N4NB/CvJ3wm7rvdeOJzpTw0XpRaIL9GDw?=
 =?us-ascii?Q?bwLvskQ4IQ2SXHw5rSFD1fQr1OqkxVsmyKyVVFN6uAHiibrySIIgMPF82MJx?=
 =?us-ascii?Q?bmW2TRPQIDkpmjiG3iCAfOwyrunvoVgiIURFP5ozV9oathAddCPh6f3V0PF9?=
 =?us-ascii?Q?9zCYIUigw4rDzO71WZJBNpoRTF5498KSoEmbvSGEVn/LjOOBPvIFcQ0RWTyi?=
 =?us-ascii?Q?Yqg/0xuTwFp57L/pdDq50DNj4ujedM1g8BswYwbWg3RRRphB7W8ztJACHMck?=
 =?us-ascii?Q?7XYaGsuDE+UWIdn3OWSwcORV6f6pZZN1W+wiL3b4Zv+sIGSuK1y2g1oUYdLh?=
 =?us-ascii?Q?wI88Y4bh2hmwsDlRr14MOG2TnuOBtXcYVIK2AX5yJz9YrRpyO+bhZDPgwqKA?=
 =?us-ascii?Q?iwIlVTY2aMF1cWuIzADtq7i+2FhMvwNzQGMHERI5yeCF+XF7WB/TKFsve+LA?=
 =?us-ascii?Q?8pIYEnNrlcbquudyyFTcg8ZYGB3U2BY7gG/w6EXcxKrkNiFZydHa5RIQbbey?=
 =?us-ascii?Q?1OQSI8bsLJra8DzQZrsqUhSdv8niwQXrctZYNGoytb1wJ3Iwb/uXygb04to4?=
 =?us-ascii?Q?uzWwkC9H+WCdNCvCHEESS8XikF4ljKGdRa//Dgmw2QqGEHL2OQqOCwr85atY?=
 =?us-ascii?Q?iFSemz7Sad8P5tm4Nm20YkdltjkIqUNB1mrLkvAXyIIo03eI6Bfv8FINzTRt?=
 =?us-ascii?Q?evJyCeaIqC6vkgDJakX3aSIKtt9Utl/NqWUapVtQsrUEOZiDTtRIGsAyHSGy?=
 =?us-ascii?Q?qHvIsV0YYFWaTpnE2ijJL5VAH6ERq7SZZOZWip8kpPdkaFuk4qw7Y3K0GHv1?=
 =?us-ascii?Q?2aRmj2ir3CDQq08Y1RnRVZRKjlo2tcgwX4CrKucT7lWX9bLKqGszsUIu9mmx?=
 =?us-ascii?Q?rSE3JHst680OnE+ihIs+7ZwJtnOsA594MeCTDfZnHJEZTS1AT6SdTePxuO0M?=
 =?us-ascii?Q?cbGPWqjJs4Y6SEZgr5zURgictCeqscclb80z+1gKTyviS7jgaRIy/ZysQAQ6?=
 =?us-ascii?Q?fCBSpJkfvNiW0WtAR1MpWxJXbeOkfPScGjyrLvQk6P/2SPmDtWH+DVR0ssIN?=
 =?us-ascii?Q?ONoZt/j9aYH5DzjQmukqQtNFqmAoNvmhHHWujsrPqVud8ZoGAKAIV4qYsnbr?=
 =?us-ascii?Q?7GkS+Xoa9rHLoQjwKJrqLyFQtDwPvNU4+gF7v3d5MuNqJ2Vs2WtuaF7GWmMC?=
 =?us-ascii?Q?o0agB93qPiv77lU/LPN/w/ykXZ2/e0MP/E34qTFFt/vdFjCBVAHKknZqwb8m?=
 =?us-ascii?Q?tvtZNEbcmtTmJ1UL1na0aNnn+zdbancIm4Pn?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:15:01.2070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 629cdba8-2a4d-4a7e-b317-08ddad4d25c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
Received-SPF: permerror client-ip=2a01:111:f403:2415::60f;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

On Mon, Jun 16, 2025 at 08:15:11AM +0000, Duan, Zhenzhong wrote:
> >IIUIC, the guest kernel cmdline can switch the mode between the
> >stage1 (nesting) and stage2 (legacy/emulated VT-d), right?
> 
> Right. E.g., kexec from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off",
> Then first kernel will run in scalable mode and use stage1(nesting) and
> second kernel will run in legacy mode and use stage2.

In scalable mode, guest kernel has a stage1 (nested) domain and
host kernel has a stage2 (nesting parent) domain. In this case,
the VFIO container IOAS could be the system AS corresponding to
the kernel-managed stage2 domain.

In legacy mode, guest kernel has a stage2 (normal) domain while
host kernel has a stage2 (shadow) domain? In this case, the VFIO
container IOAS should be the iommu AS corresponding to the kernel
guest-level stage2 domain (or should it be shadow)?

The ARM model that Shameer is proposing only allows a nested SMMU
when such a legacy mode is off. This simplifies a lot of things.
But the difficulty of the VT-d model is that it has to rely on a
guest bootcmd during runtime..

Nicolin

