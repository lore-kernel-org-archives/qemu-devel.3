Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF869C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvjI-0000mh-Rc; Thu, 10 Jul 2025 14:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZv2F-0003e9-Tf
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:26:16 -0400
Received: from mail-dm6nam11on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2415::62f]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZv2D-0005C8-SM
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:26:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+/XgS0Psvw6zC1WxJJrSBR9IH3JASpdL3dmo3P+7ZMlDboyoDib0BmDThYg+l9I6lw0S+dvs6zHe89aSZBsHh7V02qag9zgZIAPng84O5B5F0HDjLoGrcd5ykOODgP8Ynw0jm1LAIodPiB8xBR/LAe89v+RX2sOb1jsNthrIDx6XO+xqJYgAkA4LflNHTOf/bXy/aAAs2V9P6DrmACAG6XC7w7t9DfmDo/4LYGWY8SaIoiA/Yk9HxSxKvfCoKe2vbpoWKDiO8NbyMxzpkhnovFUY9du38O0dwF4pqwkU7i84hRaewKkKDnSvGAYxUgr4ABGXKxnbDKAYe3cXM8KvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbXnBZm0Jq5wPo326YZ0KsTLPv5megMvqkURdi0OxPA=;
 b=qLBWxiWlK4oyxMi5SM20o9b4wq91Rjrrz76GC+ov4XNKmzPxoErFq7HcNALdXbFsH9Dn/aByHbMg5ZxUvfqIg2VyCRhA9n1PWByE2uUSemhNR17YgfDn8sviNdD8KB0UJHD1HUqFkZ35WCuSL53KJZzMEevu7uOJBgSon97L9xdPa8+NHEnYQ3/N4eEg2uOsKhYBjBmAReNaer1e2w3ppoAuhnWl3tRJyYeDT//408R5aOsAyn/HqKx8V6pzyg/iNNl0sJTOSQ1J7FxoMbngxIO5Vq6intk3eLJMj32kdYEj+RGMXWi8WUjaRXqro8r7N1pjh5ht9piOng65bc41HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbXnBZm0Jq5wPo326YZ0KsTLPv5megMvqkURdi0OxPA=;
 b=Dwgw52GEo6PCetB3hOU5cSSIkbypPOJtBoSRks3zw0c3Fj5zuoju7TsOwiyeXz6t78RiWwI/Ftc+EQmQ5k2rdl5tCbVK9WZyWzsuWcWsGXWc59lsgAgGKQJsktuDL03OxnV9ngJe9Pn+VcLI5kN94qLzoclrcTNA02K5bHZI2yIh0jg7ZYLFMVmXVekLwHtmOKbeJ64o3ztk5c1YOSGCVFQdBJ3Dl3OHTHNjgV3iUsZBe0h7LfD6IEDULv5mBx5eplLhwvC2Lz+EvRnOO1m2RoTokXkUCtkIWyKYJx0wAcfffwdNaIKJXNjfA4gx3qZfJxPfYTY54lZzwZBCuu9YGA==
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 10 Jul
 2025 17:26:09 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::39) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 17:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:26:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 10:25:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 10:25:54 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 10:25:54 -0700
Date: Thu, 10 Jul 2025 10:25:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Donald Dutile <ddutile@redhat.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "chao.p.peng@intel.com" <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Message-ID: <aG/3oIBACwovAq/4@Asurada-Nvidia>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
 <01584206-e2c0-4881-aaf5-d6c552a30873@redhat.com>
 <aG7A8hxd1R4iVhGT@Asurada-Nvidia>
 <b3787ed4219743e2a65edd13ff44d9b9@huawei.com>
 <5542e55f-5cd9-40f8-bb45-fe6d851140b1@redhat.com>
 <b0b447d4-ca5e-4462-8c02-958bd0c601de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b0b447d4-ca5e-4462-8c02-958bd0c601de@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f119c8-b16b-4914-1af8-08ddbfd6dbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XnMQwFNiaPKlBcmu/xLwCFJmRLYSpbn3ivNQGMf2H+1zlAO7YWv86Eog1/Dt?=
 =?us-ascii?Q?kCx5irlSvXakvXenCRZgRPEZo46PiXWiZeCc9AFhSbX1r7YBtAgcnJvRgKmg?=
 =?us-ascii?Q?bAtyrpso+LAnkARNZLppdtiJKUSNpyAul74xYxqt03eVyGOK4xtOVqjznjGk?=
 =?us-ascii?Q?DgI9Jnqp+usrYx6CtjasDN2T1Fr4AP0A/wNUwwBxjg22lDsWdy6UWaIr7kNw?=
 =?us-ascii?Q?7famhl1yyyRC3K5TMpmBfguFsD2/gR1oAdRmu4lz9V+z1mHNOUOfnwDCfIHw?=
 =?us-ascii?Q?GH9rUVNKLgf3NBxgWTeQ2BEJ1xi3C189hA/6w2zeb8y1KNi4o2tHXPgonOWU?=
 =?us-ascii?Q?G5+Eg+2rAaHSINYkimkqwDHdK+yiEC1TSmx0skiseTsp+KWOWi3PaN4HRRGA?=
 =?us-ascii?Q?CrNlc8vEJwV84gnBQwZBNj84exdMUO1Flw6uXyYmh1q9V3ttuWbDzA/x8RsJ?=
 =?us-ascii?Q?QVJzJcEaqQz/Oft0o6ANglQibWgn32jfEakaySK1Rtu6ORfGBa5sgtEYyHnP?=
 =?us-ascii?Q?BWjhEmVesd0yTutAcA6ijNstO3KMpT8D7NL7puKk7iF8tuEdkWmk7W9sE+tS?=
 =?us-ascii?Q?CGkmUQpcERz/rUdW+aWxOrd5J/IkJQa47bdUvKpYYfO9K+4IkL7QE7LxHHfT?=
 =?us-ascii?Q?/8BtDZu8UU7EZ1Ga7Oc0MaCH4/9U428ZDr0ZBaBYZgGmhbRozgPSkQpqY6lf?=
 =?us-ascii?Q?ZvX2Sm7F4hLlJZQy9QJErUJRDIG04h5G9sVc5PLlgfUFHaf11bBSUX1+gQox?=
 =?us-ascii?Q?or0hYY3jBlZoStYRURbCIaXtc/zdmnmRGEV3nhZ3BYuLIMLwPWwe00iTKL0T?=
 =?us-ascii?Q?N7IWY+fxXqrLnvPlhMi9oFOKVfPx2WXa5vBu/vBuXSon6XHJy47hjTHv2dCy?=
 =?us-ascii?Q?bgYxNxt4FmlU/apMtwgzVeVEVM5EooDngYM1mTBKqOZNAsbx/b7NCxQweJBo?=
 =?us-ascii?Q?Rf/qAfE9Rr49gxVLXe4++yAU90NPeNumlEd9KYWUOlCMOYuOQYdrUNOZwL5P?=
 =?us-ascii?Q?BDiZNYx6RiavxuzTx4xt4iwdOb1CCQEPGt6F47rA0uIx1ridUFp1D85sj4Lu?=
 =?us-ascii?Q?CTHeski+vucYUSAINPiM4if/bppElBmUpWbu8x7Vt3tP5IhsU+nnA4W14KvE?=
 =?us-ascii?Q?7sZA02IpnCh4+8DO4TZMxPdhWaw93G/P5m88ZjQyKfrGPs94sMdCQjkNxgXC?=
 =?us-ascii?Q?ayWBLRwRQLZ8kUF7mDP3pHtAnMZgDyn/OolTdquzDzGntga0BUKCF0pOfjK5?=
 =?us-ascii?Q?Vtsp7GLKbezF/FEp628P2A53L+kvJPFdAMfavWXaJDp253EfKxsqOcsP6qn7?=
 =?us-ascii?Q?+j40ECirb2Gg5M0XdU6QvV14t95f8g4yQgbG1g7G+USc6Xp0pMwkase7c73F?=
 =?us-ascii?Q?tVcA40lfOopF/A8mm75eYsM0l79gWC1hc+TU5MVohw/30pToFjL5nClL5b2A?=
 =?us-ascii?Q?qz8rSSvcLMHjcCJEfasQsOMkLbZurUgSI6e1BK94kqehT5Kf1UUQ4scE1Wz3?=
 =?us-ascii?Q?DorwdOJwkmLs7jY9bu6RvvGWnxjoGkADJQ4i?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:26:08.6556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f119c8-b16b-4914-1af8-08ddbfd6dbd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590
Received-SPF: permerror client-ip=2a01:111:f403:2415::62f;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

On Thu, Jul 10, 2025 at 01:07:11PM -0400, Donald Dutile wrote:
> > > > If not, maybe go a bit further like "VIOMMU_CAP_HW_NESTED_S1"?
> > > 
> > > I am not sure the _S1 part makes much sense in ARM case. It doesn't matter
> > > whether the Guest SMMUv3 is configured in s1/s2 or nested for this CAP.
> > > With the new SMMUv3 dev support, the user can pretty much specify,
> > > 
> > > -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.1,accel=on,stage={stage1|stage2|nested}
> > > 
> > > And I think it will work with a host SMMUv3 nested configuration in all the
> > > above cases. Unless I am missing something and we need to restrict its
> > > use with stage=stage1 only.
> > > 
> > > Thanks,
> > > Shameer
> > > 
> Shameer,
> I didn't think of these config options this way... so is this CAP always 0 for smmuv3's associated VIOMMU?

There should be a "bool hw_nesting" flag (or some other name) in
the SMMUState or SMMUDevice structure, that's set earlier by the
support of nested HWPT allocation/invalidation and other factors.
E.g. if "accel=on" is missing, set hw_nesting to false.

Then SMMU's get_viommu_cap() callback function will simply check
that flag.

> or ... should intel-iommu follow this same/smmuv3 config option(s) and avoid this VIOMMU CAP req. ?

We need this CAP for the vfio/pci core to allocate an S2 nesting
parent HWPT.

Thanks
Nicolin

