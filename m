Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB64E77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL7AL-0008Qn-Ar; Tue, 10 Dec 2024 15:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tL7AC-0007rj-N0; Tue, 10 Dec 2024 15:49:04 -0500
Received: from mail-co1nam11on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2416::60e]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tL7A9-0002m1-Bu; Tue, 10 Dec 2024 15:49:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMmilJl2F+Gk+2PL5R500c57hZu0eMLp80T+KuVSPS0GBXxx9Lv532j13oT/BIn2mF0XH3It8b0q0pAIWZny0fJDQVkB3MiPA/O0t5xJ0nCNrT21oHqxAu8st35aJ5wAboWuFJRHpODHi/+OBOOVMJW7IrJSZ8/FKko9X3Cutu4P2h+MleS5GINgN1LpNZyeuNNOPPIpoAf9hRS7ECuaHF5Wqufl9cIWBKmLU49JtufFG1fl316pPUM+Mt5Yf2TnY/wQaSsXS9yVTkn1Z9VUalLC1dxVYWoClfD0gSxLQ99rlqhFq/zfQ6gscTQygMyBxXWvgwrrKJSSdgq8dZhpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ6O0qV4o8GaUzk8LSE1mcozPWGYSHHBzVGxPO255m8=;
 b=BXeIHS8YKMERhLD0I2XCB8SaFPWOovFkjXvHTtW9U9rfZMq38lpDJ8CvpWVgVS6xMrO+kKXnSu/pJI0nR4q+qOwJxDV/ZXx+3JOCGs+WhfRkJlLodCNS8ujSi/1zbG0RaEQtwtvFmMCouRfw1LScGaWwh/7zeabCV+neaqKJjDvmnsTQDdC0WhdPZ+IzPZYJdg32l6IB4PSiOUbhApZlIXCDIVA2hUok1k7hjOVtQKoB14qdIX+J7lhP2gNGSiuj3RdQCVzaIOPQqUEO+7xb47UF6aJmf3JjZhwTxAsNgoitAUfuqbb8OljSkIjAzVvBi1zbbMYSVenyG23IOLvrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ6O0qV4o8GaUzk8LSE1mcozPWGYSHHBzVGxPO255m8=;
 b=Z6+GCHgC/YHJ/V8voR1FFU5BSfCUnI7occlVoa3Pt9gxk1h7J1EWBWq/A9yUpUxZIubmOnsfw7+J7PCXQdqCuSAHpHen2yj2R179VxookcMmf0FWl7EDafs9WARfmFFu0CekJMncqN+3lA7cIMFlwxqCg3Fgkd2LCe/24ugVCHs9TWORNdpgYO26uCVxsL3O9ttjEozcfL9fpE+XR80uFDVFPmR+ySGj41uGlXXR+C7nTVnbfW7AVkaI5BqozgplyF+2+f9tMUfmNsLsvgohYnshL5hfWHD05p/noKJvVBuFouVHX2Kdsj4M+yD1RjUNFNX0TJkyZxCin1mM4ZMs5Q==
Received: from BN9PR03CA0707.namprd03.prod.outlook.com (2603:10b6:408:ef::22)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 20:48:43 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::5a) by BN9PR03CA0707.outlook.office365.com
 (2603:10b6:408:ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.18 via Frontend Transport; Tue,
 10 Dec 2024 20:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 20:48:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Dec
 2024 12:48:30 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 10 Dec 2024 12:48:30 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 10 Dec 2024 12:48:30 -0800
Date: Tue, 10 Dec 2024 12:48:28 -0800
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
Message-ID: <Z1ipHKP4L/++143Q@Asurada-Nvidia>
References: <20241108125242.60136-5-shameerali.kolothum.thodi@huawei.com>
 <1dcea5ca-806f-4f51-8b13-faf5d62eb086@redhat.com>
 <efb9fb7fb0f04d92b7776cdbc474585d@huawei.com>
 <48bb0455-7c2e-4cc6-aa15-ebe4311d8430@redhat.com>
 <0803ec1a010a46b9811543e1044c3176@huawei.com>
 <aafc5fba-8d68-4796-a846-265362e7acac@redhat.com>
 <30ff8ac9ee9b4012aa6962c86ac06375@huawei.com>
 <41a67d4e-f7b8-4586-8d52-c32df400b675@redhat.com>
 <e13f2e9c0a6341e8b25b7945bc7bf413@huawei.com>
 <c14feb2934a0478180635bbdb27d5e53@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c14feb2934a0478180635bbdb27d5e53@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bc86cd-0bb4-4d16-b40f-08dd195c088a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sOB2KEFcldy8wCamNiqWphY5kS6hyksnkNd+OVV8N+JVMzkdPNG6J7BEZbvk?=
 =?us-ascii?Q?KUEVlsmSGZegFDIf9mDzTWlCLTVKFvbofQ/lzckVBWJkJtY/7ODNeo/nRsZY?=
 =?us-ascii?Q?7JZOFZwqq273B0Ozejbsqom/1gOX3WYv7QiPJPRs1Kzp76gPgN2kDLfQ2Boi?=
 =?us-ascii?Q?1Vtf0EjPBJtwqR61Vc/xScsHEolGMtNFYqyMn6QvDvv1Ydp2ZdPnA60DT9HB?=
 =?us-ascii?Q?xPLp1W0yVo1kH2kWS4rs0ba2/VcKKQ1UfJN3Vbe4M+bHHr8Vp0eZOuo8n4ST?=
 =?us-ascii?Q?s8TE+kpLETbxs+/UnjCbIC6NNg1GfksXzTv25R/6+uWp0LJjaP8jHUtiSV36?=
 =?us-ascii?Q?yqlDMQ6qYEk0YWFuQms2/dPmzmwrBNwReJECbIpdurzquhEHckybdeW2IYjM?=
 =?us-ascii?Q?RriO5gdy26Qmjfn6ndOTgohgqnX8YP5ieydmNcZcWQ5wjb7rLOJtmR8TEDO6?=
 =?us-ascii?Q?DSEblXEtXfYU1Hh3WE5pieJcAd1g6ghWOL+WfA6jO/1l7PEO3avLVaoQ6C9U?=
 =?us-ascii?Q?rUvJz3muLJfeIiUcmCtt9QtPNNN3wR5vyhgwflwsrK99anxYL/p77425cB3y?=
 =?us-ascii?Q?z49hdSe6mIBXENOFQmal1SADkRDbvC1Z23qDo+qHtRIfINZdRSwh4+9T+Ene?=
 =?us-ascii?Q?Qjc4nnN1qjOTuufvVLYTKySegyKC0lMsF5gEXL4bJfotGFqivU2lpEIchaAE?=
 =?us-ascii?Q?65l5Ed71aIfSHv/etu7lJmtTx75o/kvW7wsmtmbckCn68LdpjTTSvnBiblaZ?=
 =?us-ascii?Q?sAyI3qOZmF0Xr9ddIoCWJ4pNWszZ3CJBHekNUu14U9HWdLqeI4npIFSIKxOb?=
 =?us-ascii?Q?oHfKgSggFWamNPPT6d2eKvWUuC0dqMQWUxvK8LrnFr8chUa4BEJB9SB2UUqA?=
 =?us-ascii?Q?mtjIomzVO/V2LvwbHFcNg3J/NEoBV53gUhgm5luFBNIFs5Kl8UkQxNHXv9LY?=
 =?us-ascii?Q?72iuicWwn2vKTUdJXcZZ7EfL6vBbxEKFLo2XL4CaNcm3skNr/iazRUhmIAXP?=
 =?us-ascii?Q?cvXTWfFY7doQrC2zCy5FZvv/yWBDXrvWPHnc3yuIXxCt8v9iSCjjRYwXu6G1?=
 =?us-ascii?Q?t8fk19nb0pOGey31L750PMmK3MJCqzm+TCvIJtfCpXHy9d1C9x9iviYn4/eM?=
 =?us-ascii?Q?bu+rdhWCBPsagnBSzu60amWXjuGiQFspyf9N/8AaAqfGXFEFIsNiqxtqyeNr?=
 =?us-ascii?Q?fguSwOCEMZwhvryNMliw3HgWwxVViF39h8tmWzSGoGD74ZzQm+hxKkW5JDJS?=
 =?us-ascii?Q?5gfwyFABt6bsqAEfusuYEXfWO6y5fLO+C/Ffew43SiUI+oqK0aqobW9EI5VR?=
 =?us-ascii?Q?JGPtXFUMB5rEVBO1UKIo1VYhD6LgbBL13hfilCK01Aq7k6zaLaMZR7WE6Y3H?=
 =?us-ascii?Q?/An/A/UfXh/xT4PzhKO67fzRo2olJFe9dkT2wrWOuAhWqGaa56JbgRtt7X5D?=
 =?us-ascii?Q?vzV4uWCII6Dj5JhjO/vGxEioIGqZJJPM?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:48:42.5440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bc86cd-0bb4-4d16-b40f-08dd195c088a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
Received-SPF: softfail client-ip=2a01:111:f403:2416::60e;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Thu, Nov 21, 2024 at 09:46:16AM +0000, Shameerali Kolothum Thodi wrote:
> Hi Eric,
> 
> > -----Original Message-----
> > From: Shameerali Kolothum Thodi
> > Sent: Wednesday, November 20, 2024 4:26 PM
> > To: 'eric.auger@redhat.com' <eric.auger@redhat.com>; qemu-
> > arm@nongnu.org; qemu-devel@nongnu.org
> > Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
> > ddutile@redhat.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
> > <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
> > Jonathan Cameron <jonathan.cameron@huawei.com>;
> > zhangfei.gao@linaro.org
> > Subject: RE: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with
> > multiple SMMU nodes
> > 
> > > > I think I have an idea why the hot add was not working.
> > > >
> > > > When we have the PCIe topology as something like below,
> > > >
> > > > -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \ -device
> > > > pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1 \ -device
> > > > pcie-root-port,id=pcie.port2,bus=pcie.1,chassis=2 \ -device
> > > > arm-smmuv3-nested,id=smmuv1,pci-bus=pcie.1 \ ...
> > > >
> > > > The current IORT generation includes the pcie-root-port dev ids also
> > > > in the SMMUv3 node idmaps.
> > > >
> > > > Hence, when Guest kernel loads, pcieport is also behind the SMMUv3.
> > > >
> > > > [    1.466670] pcieport 0000:64:00.0: Adding to iommu group 1
> > > > ...
> > > > [    1.448205] pcieport 0000:64:01.0: Adding to iommu group 2
> > >
> > > But it should be the same without multi-instantiation, no? I would
> > > have expected this as normal. Has you tested hot-plug without the
> > > series laterly? Do you have the same pb?
> > 
> > That is a good question. I will give it a try soon and update.
> 
> I tried hot add with the current SMMUv3(iommu=smmuv3) and hot add
> works when I added a virtio dev to pcie-root-port connected to a pxb-pcie.
> 
> And now I think I know(hopefully) the reason why it is not working with
> smmuv3-nested case. I think the root cause is this commit here,
> 
> (series: " cover-letter: Add HW accelerated nesting support for arm SMMUv3")

> This changes the way address space is returned for the devices.
> 
> static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
> {
>     SMMUState *s = opaque;
>     SMMUPciBus *sbus = smmu_get_sbus(s, bus);
>     SMMUDevice *sdev = smmu_get_sdev(s, sbus, bus, devfn);
> 
>     /* Return the system as if the device uses stage-2 only */
>     if (s->nested && !sdev->s1_hwpt) {
>         return &sdev->as_sysmem;
>     } else {
>         return &sdev->as;
>     }
> }
> 
> If we have entries in the SMMUv3 idmap for bus:devfn, then I think we should
> return IOMMU address space here. But the logic above returns sysmem
> address space for anything other than vfio/iommufd devices.
>
> The hot add works when I hacked the logic to return IOMMU address space
> for pcie root port devices.

That is to bypass the "if (memory_region_is_iommu(section->mr))"
in vfio_listener_region_add(), when the device gets initially
attached to the default container.

Once a device reaches to the pci_device_set_iommu_device() call,
it should be attached to an IDENTIY/bypass proxy s1_hwpt, so the
smmu_find_add_as() will return the iommu as.

So, the fact that your hack is working means the hotplug routine
is likely missing a pci_device_set_iommu_device() call, IMHO, or
probably it should do pci_device_iommu_address_space() after the
device finishes pci_device_set_iommu_device() instead..

Nicolin

