Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC677CDD1D5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 19:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMJS-00056X-MD; Mon, 30 Sep 2024 15:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1svMJN-0004VF-Ao; Mon, 30 Sep 2024 15:44:01 -0400
Received: from mail-dm6nam12on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2417::60f]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1svMJK-00027Z-KS; Mon, 30 Sep 2024 15:44:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvK5McjrfPENgxRXNem2SBTUqmBLhFQBsxkWve94K0901wslqgMt5YykaqCQe/dg+1VeSa3/pcUSzZORGb0XJKF9Fcdk4YL2QNttm8yhgxq5PEEnp4+7SrfHkhb1lIytgOBxqqa1MnwOlAN93/rGR/w/p6vzJvcXbaWvlK8bnWI5lmRi8HUrs8nzXzUY0fr+eLGiXNFt7jxWBMWu7NM+Gos13Qh91TI0NHqW9VOxFyXEJ/Ytg/OzPC0dSSpHNkFfsOmTtsSbsf2YDKfBVAiX6lrgzulwZZNkid0GABWJFAqvNb5eESz1Yv1jvfXRZTsO/xwH++an4S7b0h09CwZ/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1XAbPDYIK/R57zKBNcqpFRULcIrha3/IJ0YEwvG8tg=;
 b=bBx/lisQwwSHKgby742W+NGedXMFlU6dbIsQoTQez2I3pDJRDcwsySRsuvaUZPKvStnsRA8DlHwXUV4l9uGn5c9/Ppc9dGyZ6j6g6A1920YQGYc/Jku+JUzA0WvrXpd4kEY5vU1CWshmYYrjQ8q1C+ZmryWO+IzqnB9JkOJkzB9hfKSWtG4JbLZwjRhVyfO9FjUeWzN25tgPMkQTA/47xdr8pfIEqno/JY96iAMW8bqWxNNHvCGUGTmpIkXRgEYKOMAdhf24G8mvVVfF3cMdmU/1yS/cKadRE+Hun/mk//91QCmtiMhmJhPLF48GclrRafc7FMn3ANyMQ36+WzH9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1XAbPDYIK/R57zKBNcqpFRULcIrha3/IJ0YEwvG8tg=;
 b=OqpfBLMxeu3Pd5QgR1xQ6vGyTSHNy6QYJATTzvS4vtbRsOmYGvZ69vxGsVt7kECUkpEAx88+duYhQM85x/UNEYdz0uo0sX6uV7jMFl61n3O13ykeufLytotTX9sLz9B1YsOgySEBq9KnvJekuahzN1qpoXfzUiU344fDL3Jw8x6Mm68pa8p7f+lYuhRHMW3JPZXalJBZ8K0wVgNsfl5k0qn+Hcd0Omjp8ulzOB0mUa1UQpiLQrzmC1xkqgxLKNkIUnwks0uH+/34HCTeMviNEIgCgiYoACHLMJRrfary2rieHfiROGkxscMszbSvdw8rx/2bMGlNSDKuSb69py1ACA==
Received: from LV3P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::19)
 by SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 19:43:48 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::2a) by LV3P220CA0018.outlook.office365.com
 (2603:10b6:408:234::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 19:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 19:43:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 12:43:44 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 30 Sep 2024 12:43:43 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 30 Sep 2024 12:43:43 -0700
Date: Mon, 30 Sep 2024 12:43:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, Michael Shavit
 <mshavit@google.com>, "Andrea Bolognani" <abologna@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Peter Xu" <peterx@redhat.com>
Subject: Re: nested-smmuv3 topic, Sep 2024
Message-ID: <Zvr/bf7KgLN1cjOl@Asurada-Nvidia>
References: <ZtlrLJzZqpnUrZQf@Asurada-Nvidia>
 <d0e3a60713da4ff1bb10245e789ecf24@huawei.com>
 <ZtoWVjmSXfQStlkF@nvidia.com>
 <e06e0a8a89d74d88b653d4f49d0b08fe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e06e0a8a89d74d88b653d4f49d0b08fe@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b07682-e93a-49cb-8ae8-08dce1883364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TWuIDXa+gc6yEK62Nn8UNiOwRnerYq04iXZKbvW9u5aOAhaTL0FWjyXJpkry?=
 =?us-ascii?Q?sB1+r65wC4DkM5jHIPmOR7ZIe/Es5mTSZ266E+6L9YnLy3TmRUt0M+JTGzDy?=
 =?us-ascii?Q?B7lmE/68vgvpRctjQDOqGPfOuFJb7xrChoffQmrnqsi2mS+cnECAkWMq0JFi?=
 =?us-ascii?Q?1te03bwvCUUqUN3OuYXctNSpbpe3DismXqH1oAHX+cDgQtxOobB+VhFy0G4J?=
 =?us-ascii?Q?fyS9OVK5XdP0OBU0NnB57+Z7srVm8Dnaohl+61k6bcC8S0Grm1Vmq6YNe9Z3?=
 =?us-ascii?Q?EPfCRy/mHGpZoM35jMTbbMZoi76keAiN3i7qs4PZxzymCeoRCrxhErWafOb5?=
 =?us-ascii?Q?qSBUnhHqQRi3TYlCcrAuT5dSx2DhajVlMQzxC4Y9e1TxKzGiW7qZEQIYnZi4?=
 =?us-ascii?Q?pSFg/NdZE7KOLlWjIyE90xDijQ5j/IYVQ5aNY5fcF+rYpFgS6XkNTMu4AhjU?=
 =?us-ascii?Q?GF0HNaMcq77mFQE7YaooeHBATL9v8NDyXBGRGs4xFW3onMjOKOjKxe0VO08G?=
 =?us-ascii?Q?ZUtkyBhm/FSjfy5BhWPDBhSzOZIRvRgjJNAOrs4wGCnaDTUFlu8FV3maiKxT?=
 =?us-ascii?Q?lS8hgvm1sAbInS2tSxUiphRBTna1QgarHMO+tNCv01B8Ft9xVkcrGUZR5SNc?=
 =?us-ascii?Q?X0Vx0S8HY9nRHPE/tdzVMiV4iTtZR9fIeF+8yDsYYPPBpsupABnKTsiCPA2e?=
 =?us-ascii?Q?z6zKvExjwRHwdHK2x4QEVyPKu8ewCb1Rji+LfgjRT/Z5h5VUXCB2Q3m7dvPq?=
 =?us-ascii?Q?dFQcrEas5QXn2FI2je736wNDKQGtWZBeV8uNn1w8a4wXbES87ZeoWSEB0aUB?=
 =?us-ascii?Q?FeZSaGvutd18G8QS2BMRnKPNjOBpQX5xTKC4xf4k1ElHiwl0UXxwowB/48vn?=
 =?us-ascii?Q?xcoGmCEQ9gcDR99aHpp4T1kr6pp3dAghQCzkvMY24tLkvikNrkvaLzgjea9G?=
 =?us-ascii?Q?RzPLFNtJ6rGP/nb9sYb2qhopKAsoK1PKcHzJNzo51JRNYCshNKscQDI8Z4qJ?=
 =?us-ascii?Q?fKRKU7byJZtWVQB0lrFqgdGJpTCEsR82ulZERPjOLkJmYPRSks3BlGBXz3xH?=
 =?us-ascii?Q?L5QoH7ByONNDtv8oAN2OZ6ITJqSsYT9IX85iXYZFC1mpF6HQJjRfzJoZHbV2?=
 =?us-ascii?Q?jT7uODH6+JaI2hxh/uynhP4Xuf6vOcOH+hccf9WnvZEL0B43P0txuCV0oHJY?=
 =?us-ascii?Q?ehyfPT52uLenhOpfde6udA8RHKqQTncZ5/T4QC2iAIQmKQVPdIAlzyq2U+LB?=
 =?us-ascii?Q?KjgR19kX8IoE9jZpWoYFnzTSpbtJTIe018kd3QdYruVIKnDtyFArcf7KWL5i?=
 =?us-ascii?Q?5ItulKwRFOZvwP/XOfLaua7ZWB63y1dP60sdXP9ojXedfyoUTNX8M+9y9xOU?=
 =?us-ascii?Q?d9fmpIowvqIWVcyThRt4kpY/5930?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:43:47.2234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b07682-e93a-49cb-8ae8-08dce1883364
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805
Received-SPF: softfail client-ip=2a01:111:f403:2417::60f;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Mon, Sep 30, 2024 at 10:45:31AM +0000, Shameerali Kolothum Thodi wrote:
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, September 5, 2024 9:37 PM
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: Eric Auger <eric.auger@redhat.com>; Mostafa Saleh
> > <smostafa@google.com>; qemu-arm@nongnu.org; qemu-
> > devel@nongnu.org; Peter Maydell <peter.maydell@linaro.org>; Jason
> > Gunthorpe <jgg@nvidia.com>; Jean-Philippe Brucker <jean-
> > philippe@linaro.org>; Moritz Fischer <mdf@kernel.org>; Michael Shavit
> > <mshavit@google.com>; Andrea Bolognani <abologna@redhat.com>;
> > Michael S. Tsirkin <mst@redhat.com>; Peter Xu <peterx@redhat.com>
> > Subject: Re: nested-smmuv3 topic, Sep 2024
> >
> > Hi Shameer,
> >
> > Thanks for the reply!
> >
> > On Thu, Sep 05, 2024 at 12:55:52PM +0000, Shameerali Kolothum Thodi
> > wrote:
> > > > The main takeaway from the discussion is to
> > > > 1) Turn the vSMMU module into a pluggable one, like intel-iommu
> > > > 2) Move the per-SMMU pxb bus and device auto-assign into libvirt
> > > >
> > > > Apart from the multi-vSMMU thing, there's basic nesting series:
> > > > 0) Keep updating to the latest kernel uAPIs to support nesting
> > >
> > > By this you mean the old HWPT based nested-smmuv3 support?
> >
> > HWPT + vIOMMU. The for-viommu/virq branches that I shared in my
> > kernel series have those changes. Invalidations is done via the
> > vIOMMU infrastructure.
> >
> > > >
> > > > I was trying to do all these three, but apparently too ambitious.
> > > > The kernel side of work is still taking a lot of my bandwidth. So
> > > > far I had almost-zero progress on task (1) and completely-zero on
> > > > task (2).
> > > >
> > > > <-- Help Needed --->
> > > > So, I'm wondering if anyone(s) might have some extra bandwidth in
> > > > the following months helping these two tasks, either of which can
> > > > be a standalone project I think.
> > > >
> > > > For task (0), I think I can keep updating the uAPI part, although
> > > > it'd need some help for reviews, which I was hoping to occur after
> > > > Intel sends the QEMU nesting backend patches. Once we know how big
> > > > the rework is going to be, we may need to borrow some help at that
> > > > point once again..
> > >
> > > I might have some bandwidth starting October and can take a look at
> > > task 1 above. I haven't gone through the VIOMMU API model completely
> > > yet and plan to do that soon.
> >
> 
> I had  an initial look at this and also had some discussions with Eric at KVM
> Forum(Thanks Eric!).

Wow, thank both of you!

> Going through the code, is it ok to introduce a "pci-bus" for the proposed
> nested SMMUv3 device which will create the link between the SMMUv3 dev
> and the associated root complex(pxb-pcie).
> 
> Something like below,
> 
> -device pxb-pcie,id=pcie.1,bus_nr=2,bus=pcie.0 \
> -device arm-nested-smmuv3,pci-bus=pcie.1 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1 \
> -device vfio-pci,host=0000:75:00.1, bus=pcie.port1 \
> ...
> -device pxb-pcie,id=pcie.2,bus_nr=8,bus=pcie.0 \
> -device arm-nested-smmuv3,pci-bus=pcie.2 \
> -device pcie-root-port,id=pcie.port2,bus=pcie.2 \
> -device vfio-pci,host=0000:75:00.2, bus=pcie.port2 \
> 
> This way we can invoke the pci_setup_iommu() with the
> right PCIBus during the nested SMMUv3 device realize fn.
> 
> Please let me know, if this works/scales with all the use cases we have.

That looks nice to me. Hopefully, IORT or Device Tree would be
easy to tie to the corresponding pci-bus as well..

> Also Eric mentioned that when he initially added the support for SMMUv3,
> the initial approach was -device based solution, but later changed to machine
> option instead based on review comments. I managed to find the link where
> this change was proposed(by Peter),
> 
> https://lore.kernel.org/all/CAFEAcA_H+sraWNVhEZc48eS11n6dC9CyEwTL44tPERiPBO+hbw@mail.gmail.com/
> 
> I hope the use cases we now have make it reasonable to introduce a "-device arm-nested-smmuv3" model.
> Please let me know if there are still objections to going this way.

I assume so. With multiple smmuv3 devices in the VM, we would need
this kinda flexibility to create them.

And FYI, I also found some resource in NVIDIA who will help me on
the QEMU workload, including our remaining task -- libvirt. I'll
align with them in the days ahead, and will keep all of us updated
after.

Thanks!
Nicolin

