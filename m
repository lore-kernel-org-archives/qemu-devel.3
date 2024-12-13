Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A64E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 00:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLtXs-0007yY-4O; Thu, 12 Dec 2024 19:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tLtXq-0007yA-I0; Thu, 12 Dec 2024 19:28:38 -0500
Received: from mail-dm6nam10on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:2413::60a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tLtXn-0004Zt-IF; Thu, 12 Dec 2024 19:28:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btBYHRF6/BAl3HSyuCw8p7iRFpeOOTVMFN5OXmgDQxkSm8zLIVSMmDGkb6vLvBOVd2sz1QjVB7gCucXgrOWimI2UxBIqbS0leI1usAZ2CH3P7JCMMYLKGhvmTgIW5ZAfpepbaR6bWTd7xO4sG2qd7FEvRzfK90lCPWJsRBgKbQF1Tsb0fLDBjr7RWTBdG0qfXUVUM1mtQmhmuvZ8k0QxmTKx5zWW4k3rDUloG2e7B0Ey/fuMBk0hlPrwxZXuWY3cZksSggVLFr0L41U7mcBX4eyvyUIxusZzDbsDPdp/XzOiaSfGV/D+LS3yJB48kAAhCq9ebis3ZYbFvoQtiiQN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUmLaQ/fkcc2Rkow0z5zVm88phY+upRqx9hQtODW0Sg=;
 b=YZ6bt2x924Rf44x4IFlA1f00T21lOR+nVaWpT4GM4cs4TcSbOZ9Uxu1R0dOmhmbrWT/eyk8l4x8CBeTZ5wJXl377v4Tbbp7/xKJP6aXDPdCuvCIr/IGqQBKynyX/zkL8V0cpeegAHFhLz0sTiRL4UMxCEQ/vfyWat9GTeZCK4s0a54BSKEW5jkEYEXi5dp/9sDq1iUkbpafC0VNb6szw/6nzFL+NaV6xEQpd4WqwigOtPtSFRgXh6dpzRjfI/DZjZ2zcoptEMEc6gFyTN8cwv2Vx02SURDeWUu68iJiVHRnTFIlFWslfUFiLjS3WocdvveNe68JXGdLuLOAq2a6Nsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUmLaQ/fkcc2Rkow0z5zVm88phY+upRqx9hQtODW0Sg=;
 b=lKqXYiHBbQktgiJn0gs4tNqLGfG67YLtHfTHtqdjyLZIpxjto2wpCH9myaPYzyxWpMCyu5QlBCVS2aTzP5zh9iLYH7/aXItowjCxkdid9V+UzFo17GoW2vQT/3dQ67LskE71Tf6tPlFGHeL13F4c40nECKxYW3y95KsT21PgPpsTXgsUTAQO5GqwHzapK7wE5MN4gC3VRgglzx2lsffxhV+JNEwasCqy9dD85nLoua39jP+RSme11XHW1sRkILEH7pM09YnPz3vhvvZ1vI6B8VXtZ66xyuxKw5CbWQb7+LltRFVt+bAX7nQ0/8ov+7DDJWyK81hS2mSV9q2PU3jGqw==
Received: from BL1PR13CA0150.namprd13.prod.outlook.com (2603:10b6:208:2bb::35)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 00:28:22 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::d) by BL1PR13CA0150.outlook.office365.com
 (2603:10b6:208:2bb::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 00:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 00:28:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 16:28:04 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 16:28:04 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 16:28:03 -0800
Date: Thu, 12 Dec 2024 16:28:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with multiple
 SMMU nodes
Message-ID: <Z1t/kXRh2SrOiF3V@Asurada-Nvidia>
References: <efb9fb7fb0f04d92b7776cdbc474585d@huawei.com>
 <48bb0455-7c2e-4cc6-aa15-ebe4311d8430@redhat.com>
 <0803ec1a010a46b9811543e1044c3176@huawei.com>
 <aafc5fba-8d68-4796-a846-265362e7acac@redhat.com>
 <30ff8ac9ee9b4012aa6962c86ac06375@huawei.com>
 <41a67d4e-f7b8-4586-8d52-c32df400b675@redhat.com>
 <e13f2e9c0a6341e8b25b7945bc7bf413@huawei.com>
 <c14feb2934a0478180635bbdb27d5e53@huawei.com>
 <Z1ipHKP4L/++143Q@Asurada-Nvidia>
 <74114c0db34b420a90e9fe5bd991767e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <74114c0db34b420a90e9fe5bd991767e@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 361e5972-4513-4c91-f643-08dd1b0d0cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l6y5R0MKFGo3c8PoMAG4Bjiht+BHg/RDMjDdZVlxKnW69VSmYUXDQgRW9g+S?=
 =?us-ascii?Q?ZspWn1UByv0sJuA48SS3P4ZV8l7AwtV5VokBbZY8nk+jwGW2hQcmFTqEvvBd?=
 =?us-ascii?Q?pge7sZeGDhQsf75tIgUbXU+9E9hvB6sN3ppH7kbqXM11IxmRfQFgYnYgRbA3?=
 =?us-ascii?Q?sz+b9fO0lTxDFLFV5ttT78B/4EBl7Vl38QLMFnTUaN8rL1UwzL6ZnoLGDHcr?=
 =?us-ascii?Q?FR+isTEaexeYdhEu1ER7dRQit9wo750DZQ4XnGPEWVh4pjFnsGG4vgVBAeqJ?=
 =?us-ascii?Q?cpRzb9emSXRT9TVRnQI9epsIuSDllnzwKxoQgxaLzKYc/coDOpapadTpaw70?=
 =?us-ascii?Q?DSIxFwjqhnsGKGFkAtutt1LEuJAcyqUKm5b/IZJUtizqdi0X6Mn2qDHYnM+d?=
 =?us-ascii?Q?QBG72afleV3lalWCd0Kk1r5pDufZUO7q53Tfi6+o2T/BlbK1Ubf/j8kT+Sb4?=
 =?us-ascii?Q?vG76Z+OqRLKAsNxrXLAhR/CSQVsMv7YJCG1T+P4XuRKWbCVZ6EG/ihA4w6IH?=
 =?us-ascii?Q?LKbM2eXTvQS5CqYxLiVLDlDW42sYvgqaZbedg1D5o8NpTPiAPsdi6KH0hOGG?=
 =?us-ascii?Q?IvcFSUqfFP5na7bjyf4dQtwnI9vJ6J6xkG2K06rfIf/f2ZbUeprzHtARs3/e?=
 =?us-ascii?Q?O6mAtU9QLHsDrENXeUz3z0onNqPxoQaEISeOxTnbooWGiNgjR1BS+wiCbPTp?=
 =?us-ascii?Q?9tGaXIfd5OR+r63O1T3dHe/1byWgnULq7UCzGOMDYhVR63iTfAF8iH9jgzp/?=
 =?us-ascii?Q?+1ry0tMDia8pwfWEvKcHiibP3bxKsleaqudBFRGZzysojGIFoDaYLkljHgkx?=
 =?us-ascii?Q?V0QJqfsSLCF3LewLeABc0RLE7yL562fhTWpUeDaCgeQ+yh7HMiWjwdCrUy/T?=
 =?us-ascii?Q?dLTuwU4t32wNBCLn2JgRlsI1SCEEpRMBry8jjOthOmI1IfL81IsjTSXgvG7q?=
 =?us-ascii?Q?C+44oByixTdrkcslIayjHr+4EkpIoRL+owiXOK864RN31OvZeba4PcCi/PQP?=
 =?us-ascii?Q?1fwXZfZ0hb99JWAC02gYyv/PSjs9avVmCe6q3kaep+qT/V38RGyxuocL+NFc?=
 =?us-ascii?Q?Vd0do8DQtsSrSqlXabERP8twGN64t6pz1AsCFz1iv+VZ9gEko5vm7uGuPFxv?=
 =?us-ascii?Q?7kJv4/3LadCuS0osstwt2FNoLqWjtcb3QgBUOPsMjDuNmzFU6oAPStfVZEiX?=
 =?us-ascii?Q?9Dkn7k8G2LCbdV/r2S/gyqaSSUPfNufz5pzZtXtnBLuJR2+r/aFnRBA7pW9B?=
 =?us-ascii?Q?tD6sqwMLYuDkyQFwVC6NmwVrVs9NXX38+evU6pgxZUFOKPGz1g+fdwHERtA8?=
 =?us-ascii?Q?htg9chBe6u9vuLyQiFZXeqzRb01Tj/bM1AlGooj/neUgUD/wSkMBSXY0mA0M?=
 =?us-ascii?Q?y280WIMXJj53rM9vKDlgRJ+J2dr6y0qTzfJwVdaXBLEoXyeGBnRlgMhZ/vIm?=
 =?us-ascii?Q?WN6kJ3j7h58jam2+8tneuGx7UO+w5XwC?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 00:28:21.6576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 361e5972-4513-4c91-f643-08dd1b0d0cb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
Received-SPF: softfail client-ip=2a01:111:f403:2413::60a;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
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

On Wed, Dec 11, 2024 at 03:21:37PM +0000, Shameerali Kolothum Thodi wrote:
> > Once a device reaches to the pci_device_set_iommu_device() call,
> > it should be attached to an IDENTIY/bypass proxy s1_hwpt, so the
> > smmu_find_add_as() will return the iommu as.
> 
> Agree. The above situation you explained is perfectly fine with vfio-pci dev.
> 
> > So, the fact that your hack is working means the hotplug routine
> > is likely missing a pci_device_set_iommu_device() call, IMHO, or
> > probably it should do pci_device_iommu_address_space() after the
> > device finishes pci_device_set_iommu_device() instead..
> 
> The problem is not with the hot added vfio-pci dev but with the
> pcie-root-port device. When we hot add a vfio-pci to a root port,
> Qemu will inject an interrupt for the Guest root port device and
> that kick starts the vfio-pci device add process. This involves writing
> to the MSI address the Guest  kernel configures for the root port dev. 
> 
> As per the current logic, the root port dev will have sysmem address
> space and in IORT we have root port dev id in smmu idmap. This
> will not work as Guest kernel configures a translated IOVA for MSI.
> 
> I think we have discussed this issue of returning different address
> spaces before here[0]. But that was in a different context though.
> The hack mentioned in [0] actually works for this case as well, where
> we add an extra check to see the dev is vfio-pci or not. But I am not
> sure that is the best way to handle this.
> 
> Another option is to exclude all the root port devices from IORT idmap.
> But that looks not an ideal one to me as it actually sits behind an SMMUv3
> in this case.
> 
> Please let me know if you have any ideas.

Oh... I completely forgot that...

So, we need to make sure the sdev/PCIDevice is a passthrough dev
that will go through the set_iommu_device callback. Otherwise,
just return the iommu address space.

Perhaps we could set a flag during vfio_realize() in PCIDevice *
pdev, so later we could cast the sdev to pdev and recheck that.

Or, we could do something like your approach:
-----------------------------------------------------------------
@@ -896,9 +896,11 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
     SMMUState *s = opaque;
     SMMUPciBus *sbus = smmu_get_sbus(s, bus);
     SMMUDevice *sdev = smmu_get_sdev(s, sbus, bus, devfn);
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
+    bool has_iommufd = !!object_property_find(OBJECT(pdev), "iommufd");

     /* Return the system as if the device uses stage-2 only */
-    if (s->nested && !sdev->s1_hwpt) {
+    if (s->nested && !sdev->s1_hwpt && has_iommufd) {
         return &sdev->as_sysmem;
     } else {
         return &sdev->as;
-----------------------------------------------------------------

vfio-pci might not guarantee that it has an "iommufd" property so
checking the property explicitly might be nicer.

Thanks
Nic

