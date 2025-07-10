Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1346DC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvF6-0004ZO-UG; Thu, 10 Jul 2025 13:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZug3-0005Lp-5E; Thu, 10 Jul 2025 13:03:25 -0400
Received: from mail-bn8nam11on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2414::61c]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZufy-0006Ge-TJ; Thu, 10 Jul 2025 13:03:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJhKVs0bFE6cLULJ5pcxG+r/Xvc908GXi0xjLggptmu5CmboTZJGPYMYRUgMatqy4iwZf2GjI4U8sQYzjj/ze+NmmTbUhMq0nRLatHH3qqq5KYS3CfBnrocJCHr6MjfM2eFecpq45N7wwMhPXRjA4jSNRtjuRFl33bpEHjyRou3DYBP+VAGd+w4drisa1HHXHRUena6Dc4plEVBQqOjH7H0VUGg18h/NFLkqRHv30NDhqH9/qK5ajf0V+cH0sVuLjlC2PXh0cYVreUnufojlCSr/etP0/zYYU/RD3grnI6zsQChsWr5sIsV1UnFkZeqakL656qNsh9aq3YCTuJIKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkePf3HGw+gJH75Ew0gakNoekKcyLzf+VZTunWXpjd8=;
 b=s/MMaN0BSccckY5YRWDmlHrOWCft2Y4e9FCNAIcFTWWmCp8X8sWiyrdfak2xF2pP1jgEszF7q2GaOQ7hqb/Kr66dZS4hS3g+ow6ypgC4kVX27Z1ZX1KVugUm7J8X5LYZa5lJP9HkExGdwjMw9j7VLfj/7wLaAkoV6tM7+rhGX3+/yOCqIslvVX64EzVFbP82Z+BT5w5o1CZR+DcdPi/OcLm3lExI29YUY9D/BnuFCiu7oRZzzHNruvOc02glH0MpBagaODZmXHEIq6KiONtmKevpDy+gtc8Z6p1lQdAj1DnxrO9VmZhcqsb9K9xMNcfG39lFvElgwb2uKE9UhJZ53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkePf3HGw+gJH75Ew0gakNoekKcyLzf+VZTunWXpjd8=;
 b=ht0xnAy9Jl+jxGApK35o0lkdqrLdlknhyLbbFPczZQ+ewf9kzOxva6osFi+k08wlqn5dpsiuhpufNI5MCmE9uxAG5U6y/KzBnRpWXDox/a4mKTW3Ik/rKKiebOSFaj7+uhf3IAEDCdH29R1sA1P6FXdbHmEMFHwiWKINf9MWgKC/2oEe/8g83Zdqb3zQWHBSyJU+6W8JRdU+r2PbBa6SVKHMWlDevEtpUccmPsoYv9Tp+LDpb8htQflo4qqHOkxAH5x43c622833F3urlSkt0xT8yzDf8HeMh2zQ1DY2lHE/vB++A2S0rU1WouvmCZmwd/IX7i8BiZXzckFVHWjn8w==
Received: from DM6PR05CA0043.namprd05.prod.outlook.com (2603:10b6:5:335::12)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 10 Jul
 2025 17:03:04 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::e8) by DM6PR05CA0043.outlook.office365.com
 (2603:10b6:5:335::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.9 via Frontend Transport; Thu,
 10 Jul 2025 17:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:03:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 10:02:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 10:02:51 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 10:02:50 -0700
Date: Thu, 10 Jul 2025 10:02:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 02/12] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Message-ID: <aG/yOJCaWxx/u4jr@Asurada-Nvidia>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-3-shameerali.kolothum.thodi@huawei.com>
 <aG2GNcXW89stIZHa@Asurada-Nvidia>
 <92ca69322dea4a0b966ce9dd7eff0fb3@huawei.com>
 <aG8BKexuSHtSvySv@Asurada-Nvidia>
 <88a55d63d54f4586bd9992b6bdff5729@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <88a55d63d54f4586bd9992b6bdff5729@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 9764db2e-b8db-4316-e623-08ddbfd3a258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2EYR0m59oI/zykkMr2dnMUeH3eyfiwtlXZ/Lf3rtSpCXK5FZo5DgreqPUyEp?=
 =?us-ascii?Q?C4TSMCmTrIp/PXGyak57d7AeyTp8tOyV6e3jOm6PbDGcrrLBwZSPWvq/AzUO?=
 =?us-ascii?Q?PxI9kJDtZB59tq7gnzNjkizdcfw8z3bbqPX3IS1FlfBhOcvxz02Ft+M8OSkV?=
 =?us-ascii?Q?BOts9ERC+TkG0WKVyqN/TWNKMFb7RbjzTYWSWEzeI5wbPIfmaIc1bz0bOC7L?=
 =?us-ascii?Q?crhH3YLCuH6ff2Coyz9Er2VE5YRfKVHx4/vs0hR2F4R6DXN9lEDsUepuFqHI?=
 =?us-ascii?Q?sKCaJlbI7OScb3F5xyXrAZxPyXh6QV7osjOXnq34AWtBovkS/PHFBjob3TNd?=
 =?us-ascii?Q?7lPEVDZc5HMfooZ4bvF+Gx3x6AV98qYIxvEAmOVjabiR1jnfzwjU30wCMt7F?=
 =?us-ascii?Q?okePLcNG7EM3TZhy8R1LnOdo12x5rXy4DqqgKNmx4Nms7wD/QVBM2RIH1VlK?=
 =?us-ascii?Q?0/ksOmOb4NyMlun/zHjhdG9G6g2mWwDYLhE9ArZ+KcfE+oFPLp+HsJwNvHEy?=
 =?us-ascii?Q?OLJgybYWK3VQgzai1eZ38AuPoyugwDUlFbPSk02h8T4dC+mNW5b1BFVcWnpi?=
 =?us-ascii?Q?XCSFm7KGUqLr47VUWM5JhzjwZlzjwrTtdnOLEf5/PfNmNlJE96XeD/dsWR1P?=
 =?us-ascii?Q?H4W/iQs6227fQODbOR8RE59RUve5R9+HBUZ2dZyGocyXuXo7RBtwOXuz6qpv?=
 =?us-ascii?Q?yXF9MID2yhOIoJgR9Z30nA70cszjzAKGpRXMW+wOj0ZAPNDGKIf+YLwjdYlj?=
 =?us-ascii?Q?mSDiKX2hfyhLtBc3IbD0fs9gH9/JsALxlK/AHZGjhff9c0kcfLtgJWco5OMC?=
 =?us-ascii?Q?HTzo0GS43qY+G1BTCj70tebyfExUvNrA4ZjrqrMzvMEs8JAmGYNrhTMxQkOZ?=
 =?us-ascii?Q?bcxVJpUwQCV26tH5/tWchB+wNEfAgOaYCsRJDS0/qR43MOa/sPrzSNHyxIAi?=
 =?us-ascii?Q?dH2FaC02AfZSn9xvF3Zse6e/bPPzsWS2+aMB1b6/2tSPcK4jj9GrU4003HKE?=
 =?us-ascii?Q?W4ODvSdIh6Y8gYhSghm1nzULHxVT+SWozMQPtsoa+mk2DlUJ24FbS1/N+Yhc?=
 =?us-ascii?Q?QvpB1jsuGiaXFD28Cbet+NRFbEkcmxccChlrYHMmPkHJ+mFVwLNEyuqUZgaD?=
 =?us-ascii?Q?wNMgoVfIlPLM3ywvIIdPvdT/C/VvSOAgv6VcJoZ0/fJkhgnnMYxI2ZmRK62t?=
 =?us-ascii?Q?uGUGAN2afVzj/mMH02+8Yv4THYCouL0sUpz9zzhBgrQnPp8sO2f93+H31D7V?=
 =?us-ascii?Q?iJWw2GaalLk44rc6jZkp4Tds0QqeVW58iuSpianHYknSzjJgXm9GntY9t+VP?=
 =?us-ascii?Q?+YiFX5h1/jj6xldmhwqsL2bKrmLhl/ZtX+Ge0F95dmQtKRUO/Oi9TBNmuVC1?=
 =?us-ascii?Q?lYrW3pq1OGsD5QLAjRoju/Sw7MatM2+PheIH4wGTwvXp8AetTbn8HnvEpxbU?=
 =?us-ascii?Q?yx+2AdVWhp8YrRZnq2cOCJy4B5WYearYA+3uUX1bDjGMC50kWZl5oghIjQp8?=
 =?us-ascii?Q?GRSmlNjkk8neUV1YyUwOqlyX8QF3zKSRNu3O?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:03:03.8299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9764db2e-b8db-4316-e623-08ddbfd3a258
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
Received-SPF: permerror client-ip=2a01:111:f403:2414::61c;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

On Thu, Jul 10, 2025 at 07:27:10AM +0000, Shameerali Kolothum Thodi wrote:
> > On Wed, Jul 09, 2025 at 08:08:49AM +0000, Shameerali Kolothum Thodi
> > wrote:
> > > > On Tue, Jul 08, 2025 at 04:40:45PM +0100, Shameer Kolothum wrote:
> > > > > @@ -937,11 +939,32 @@ static void smmu_base_realize(DeviceState
> > > > *dev, Error **errp)
> > > > >                                       g_free, g_free);
> > > > >      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
> > > >
> > > > Although this is not introduced by this patch, is there a
> > > > g_hash_table_remove() somewhere in the code?
> > >
> > > g_hash_table_remove()  is to remove a key/value pair, isn't it?
> > 
> > Yes.
> > 
> > > Or you meant
> > > a corresponding free in case of failure here?
> > 
> > Yes. But I saw the other two g_hash_table_new_full calls were not
> > reverted in the exit path either. Then I saw smmu_base_reset_exit
> > does the clean up of those two but not this smmu_pcibus_by_busptr.
> 
> Ok. I think that is by design. The insert for busptr cache happens during
> early stages of Qemu through get_address_space() callback and
> smmu_base_reset_exit() is called after that, just before the Guest boot.
> So if you clean that cache at that time , you need to handle it differently
> at a later stage. Also I don't think it makes much sense to clear busptr
> before the Guest boot as it is not going to become stale unlike configs
> and iotlb.

Hmm, my main point was there is seemingly no "g_hash_table_remove"
for s->smmu_pcibus_by_busptr throughout the vIOMMU code.

> > > It's a realize() fn and errp is set
> > > if something goes wrong and QEMU will exit. Not sure we need an explicit
> > > free here.
> > >
> > > > > +    /*
> > > > > +     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie
> > based
> > > > extra
> > > > > +     * root complexes to be associated with SMMU.
> > > > > +     */
> > > > > +    if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
> > > > > +        object_dynamic_cast(OBJECT(pci_bus)->parent,
> > > > TYPE_PCI_HOST_BRIDGE)) {
> > > > > +        /*
> > > > > +         * For pxb-pcie, parent_dev will be set. Make sure it is
> > > > > +         * pxb-pcie indeed.
> > > > > +         */
> > > > > +        if (pci_bus->parent_dev) {
> > > > > +            if (!object_dynamic_cast(OBJECT(pci_bus),
> > TYPE_PXB_PCIE_BUS)) {
> > > >
> > > > The pci_bus_is_express(pci_bus) at the top is equivalent to:
> > > > 	object_dynamic_cast(OBJECT(pci_bus), TYPE_PCIE_BUS)
> > > > Then here it is doing:
> > > > 	object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)
> > >
> > > Yes.
> > 
> > Hmm?
> > 
> > We have these two types defined as two different strings, right?
> > 
> > #define TYPE_PCIE_BUS "PCIE"
> > #define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
> > 
> > So the first test is to make sure pci_bus string is "PCIE",
> > then the second one testing the same pci_bus string will
> > never be true?
> >
> 
> It will be true.
> 
> static const TypeInfo pxb_pcie_bus_info = {
>     .name          = TYPE_PXB_PCIE_BUS,
>     .parent        = TYPE_PCIE_BUS,
>     .instance_size = sizeof(PXBBus),
>     .class_init    = pxb_bus_class_init,
> };
> 
> TYPE_PXB_PCIE_BUS has a parent TYPE_PCIE_BUS. And the function
> object_dynamic_cast() does the magic. It will return non-null for an
> exact object type and also for its parents in the QOM hierarchy.

I see. Thanks for the explain.

> > > > So, this checks the same pci_bus but expects two different types?
> >
> > > In QEMU,  we can have three types of PCIe root complexes to be specified
> > for
> > > virt machine.
> > >
> > > 1. default pcie.0 (TYPE_GPEX_HOST --> TYPE_PCIE_HOST_BRIDGE -->
> > TYPE_PCI_HOST_BRIDGE)
> > > 2. pxb-pcie (TYPE_PXB_HOST  -->TYPE_PCI_HOST_BRIDGE)
> > > 2. pxb-cxl (TYPE_PXB_CXL_HOST  --> TYPE_PCI_HOST_BRIDGE)
> > >
> > > The above first check is to see whether the bus is  PCIE && root bus &&
> > parent
> > > of type TYPE_PCI_HOST_BRIDGE. This will identify all the above three
> > cases.
> > >
> > > Both pxb-pcie and pxb-cxl are special extra root complexes based on PCI
> > > expansion bridges and has a parent_dev set(both has pcie.0 has parent
> > bus).
> > >
> > > Hence we check to see parent_dev is set and make sure it is indeed
> > > TYPE_PXB_PCIE_BUS to avoid attaching to pxb-cxl.
> > 
> > I see. That's clear now. I think it'd help by writing:
> > 		/*
> > 		 * While pcie.0 doesn't set the parent_dev, either pxb-pcie
> > or
> > 		 * pxb-cxl does. Re-test the type to make sure it is pxb-pcie.
> > 		 */
> 
> I think it is already captured in the comments in this patch.

But I couldn't understand until your further clarification in the
mail :(

Thanks
Nicolin

