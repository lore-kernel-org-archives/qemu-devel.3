Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54E5C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuwh-0006O1-9T; Thu, 10 Jul 2025 13:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZuZ5-0006MP-W2; Thu, 10 Jul 2025 12:56:08 -0400
Received: from mail-dm6nam10on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2413::625]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZuZ1-00057C-6C; Thu, 10 Jul 2025 12:56:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYQ/aLfhYLaxKefO9hQmJC/iF7a6gSE4NvAGrQkNmbsjvkq84HVQHOTXWIu5KZpkflkingDMcgDt4oTWDX8lQpc/sx5NQTHC2hvim7dgE2c9gXu6QGY0Rdmv0zs6B5VwOovORAmJrJkUd90gyvpeuBORebmaXOF3ZcXMeuzxqcw8oynBdh2caQXshR5D4byZWgt3FxZ5O2YqfnKUkHN1kO0Ywvmr3Y2blaBDHO5OHVcEk7/K8sYPSjPmdKpZyiPcAjcwSC6as1O6ao+Z2FKxAh1jFQa2ZbqoxsQ0rZVdqj0UYSzhdCxzwRVjvwFIlEoXytMf59kSayL3uY4nNszrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxNSFbiOxc1VtJmc1uet0y6ffrdZknThRr9Yd86D2bM=;
 b=MqRi0DQ9T2/GJfqs00pKW1PiSe6p90YGtUCwVubtILt/4Lkn1sY2+PXqLKVadH6v5g30N/XJFPBIjLuXwN6yiloiXOOctdnFhfo01MAxNO+h3Hz+Rj53QPeX9nI7eTLDTOoQwUTHeyuqepVFrbouww+UhiHcRZ1EfdLWysQg0nnq9t0FcdjEUDRKieK+iXCgKV6JHzNHox/9j9cTsqNOMyHKKmjNdpUyy26hyuQ5x4M7zyKa6dR1/vtVtYUrVzUieAKiJA9EKsmBAhr6+1lWaXi++wpQFfBo3bzKOs9ONAzNbbKHkSC46S68Pms8fCE3iVg43r19ba0t39KDtUrkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxNSFbiOxc1VtJmc1uet0y6ffrdZknThRr9Yd86D2bM=;
 b=HjpDnEK2+ec5o+Af+onUhxmQFIfg5q5olIcFBC5HbabngQUCDDvjYzN7j1tKmqBON1+wV8RHGeoZRfUmi/L2jZL02T9tSCSJmUta2EYm1b+PXs9pN6aa5ziEubwW6ngI6UkshEv6IqOmZ2ybpO9ag1w73BxtETZ0sOJg1olS/IjQqixlkBDQi5BHkc+rE1wvLUDo+fMXydMDv+vwqN5PsV2IZeBeukSp97ZtIXKzoCImbgBUhTNilEd8pQPqb9G1DOB500qNt3BAcpODJRz3jeplwJuHoZjSkK0dtVCyL2wWDibJ/ofc776K1E+o3Ig7EgH8uD8NhNyLGBW/7rLAfQ==
Received: from LV3P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::18)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 10 Jul
 2025 16:55:55 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:234:cafe::5a) by LV3P220CA0009.outlook.office365.com
 (2603:10b6:408:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Thu,
 10 Jul 2025 16:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.1 via Frontend Transport; Thu, 10 Jul 2025 16:55:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 09:55:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Jul
 2025 09:55:36 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 09:55:34 -0700
Date: Thu, 10 Jul 2025 09:55:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Donald Dutile <ddutile@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 07/12] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Message-ID: <aG/whNETIoHGnI5O@Asurada-Nvidia>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-8-shameerali.kolothum.thodi@huawei.com>
 <aG2M/BI3UAYxKCD3@Asurada-Nvidia>
 <741503f8f96148b389b875e6b6812c1a@huawei.com>
 <aG8ECVeOYXPzBEVB@Asurada-Nvidia>
 <3a51c0e0f3ce4c2580ff596008615439@huawei.com>
 <aef834e0-d6dc-40d0-a6aa-24ed44b77325@redhat.com>
 <f3bfc4cdb0ca47da8f3e4bc38b58d3b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f3bfc4cdb0ca47da8f3e4bc38b58d3b6@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 79862850-badd-477c-9000-08ddbfd2a26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WZ0N5J/wZo02wPDSgUqHDb9sGLHpJM3jpqcBkmsyeMi5gky1ZrgM4ScYPacw?=
 =?us-ascii?Q?TlLUm4c5M7cS77qWKE3FjYAWMkKQG+StxaTl+PRZtT6dE1VIMzIMLv4sXqyH?=
 =?us-ascii?Q?w4/gtQBeeVmXt7UqhfHDs21YKrTbjlgviVLC1X1p62BIQ+FnH62R+vHukgo6?=
 =?us-ascii?Q?0hLlHjcbuzXG440OLAGkIdhpxJv7yLM8A30QE5IxCITS+hxTMzHbI81EJrmm?=
 =?us-ascii?Q?9/aZKHy5zjHm4amrB8jK8VvpnGLdGC6Sl2OKHKeHLhIqpCbl87M4DGthn2u9?=
 =?us-ascii?Q?KSCQXm2/sYpRL+GRdqvrdI/Ga47jyZo/hMqO8VNLwGC86wkXOpdYyxM0bTcz?=
 =?us-ascii?Q?zIZPBGsYLKIR89z0CT/72FISXT2SyWqXLk1mlbStxlt+ixCfQ/uBqd+3FSrU?=
 =?us-ascii?Q?IZUs5NYHZJUc5CmVkWwQYaK4RVHcMxhRBRffspgefQ1RggmWqtPgkT9CsUjJ?=
 =?us-ascii?Q?UI3yWA15EhQApj+07lZRfneRmPJ+NE/661xZ9IVkI7t9LBI7tw9PQNpdGmUw?=
 =?us-ascii?Q?2m7dP5rcaSUSYkG1w+4GLKrgoOpSUpRn062Y5U+tNdFOACscBEPTHtCCP+e7?=
 =?us-ascii?Q?uwyGiL/2bOnBFt0WLDQEAF2fWzOxixdAatQ6iOi4zymwuKwSXiCiTCzRMmuO?=
 =?us-ascii?Q?NrbgulelxYSL44kictS3ZdfvbisbnOJmQ+b5fAnMJJTawNYjopNHE4AqFKZk?=
 =?us-ascii?Q?SFjyxAZBhalN7ThnmKA3DnsJ5gjecyg5oiQgTqFTAqoQdJTxq8ZEY2hY4OYT?=
 =?us-ascii?Q?WiFmx6HhBAzknfoHZRzNu6hMnFroLwqiWc3/50kuMJGic+wTR32zoJi1QhvI?=
 =?us-ascii?Q?p56yt9WrAcemneMi1lOA6auZ6QzL3z6Va6ryBg1vZwMUlZR3DsgpuwdTvCXy?=
 =?us-ascii?Q?sk4JXavrWCfq6+84Jy6LMz3N5Zft1FISbZ+qSrtQW+A2eWU6c8dKhfL64FoR?=
 =?us-ascii?Q?bX/GLq2pKKCstPDQBXEb77+MBKD54LZ6bNjnTd3qPVAp/Y7MQBfkpYgOs03o?=
 =?us-ascii?Q?WjScOPvPkAWFKPXqGz1pyojgs6XsG+wD+rsT0Tjd7rYl+/NXesfYcifIU6gy?=
 =?us-ascii?Q?Qgc24iWcKaUcaDGa0qoU9V2XXblYEo3ew8HBjMBTiOmDBcN0vhbiQIbPPuk7?=
 =?us-ascii?Q?YeHqUcSg2GpGdWlapAyTjWzUefH2i5K+/1HsQLdD1NsL0xIEyMUdEx5nzlYb?=
 =?us-ascii?Q?SVUgFbpMio+zWWFv3DAnMZilJRMTpm/67OiU2Rn6lMfDsuB1L0Ybn/J2i7DM?=
 =?us-ascii?Q?fObV+pYAvE5VzD807Q2eib2e7J4NZr4SLg+mh/kMDfsttOup2n6Hazc5NeeT?=
 =?us-ascii?Q?z5kZjDI9fCidyWX5UOhnQYEvXnglL9RIdnOs3pUmmFsPBIIkPgXrZg8HbpOa?=
 =?us-ascii?Q?/ce+1A32F6oe3enrLsBYBkbMRJWVYwV/Gtj6e/lYV6zpW68unBsrkGUDnese?=
 =?us-ascii?Q?VjGsmps+lDHkpa30TG4KSgR0W11MqlOb/tQoAaC3V0iiX8otRD7JcXet9tla?=
 =?us-ascii?Q?vxHkHJAKjY9niaBZyDQPExRn2ABUBLoGTajHhjOBiAmXtpXmWycViaFjtg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
Content-Transfer-Encoding: 7bit
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 16:55:54.3590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79862850-badd-477c-9000-08ddbfd2a26c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
Received-SPF: permerror client-ip=2a01:111:f403:2413::625;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Thu, Jul 10, 2025 at 04:21:41PM +0000, Shameerali Kolothum Thodi wrote:
> > >> On Wed, Jul 09, 2025 at 08:20:35AM +0000, Shameerali Kolothum Thodi
> > >> wrote:
> > >>>> On Tue, Jul 08, 2025 at 04:40:50PM +0100, Shameer Kolothum wrote:
> > >>>>> @@ -2909,6 +2909,19 @@ static void
> > >>>> pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> > >>>>>               }
> > >>>>>           }
> > >>>>>
> > >>>>> +        /*
> > >>>>> +         * When multiple PCI Express Root Buses are defined using
> > >>>>> + pxb-
> > >>>> pcie,
> > >>>>> +         * the IOMMU configuration may be specific to each root bus.
> > >>>> However,
> > >>>>> +         * pxb-pcie acts as a special root complex whose parent
> > >>>>> + is
> > >>>> effectively
> > >>>>> +         * the default root complex(pcie.0). Ensure that we retrieve the
> > >>>>> +         * correct IOMMU ops(if any) in such cases.
> > >>>>> +         */
> > >>>>> +        if (pci_bus_is_express(iommu_bus) &&
> > >>>> pci_bus_is_root(iommu_bus)) {
> > >>>>> +            if (!iommu_bus->iommu_per_bus && parent_bus-
> > >>>>> iommu_per_bus) {
> > >>>>> +                break;
> > >>>>
> > >>>> Mind elaborating why the current bus must unset iommu_per_bus
> > >> while
> > >>>> its parent sets iommu_per_bus?
> > >>>>
> > >>>> My understanding is that for a pxb-pcie we should set
> > iommu_per_bus
> > >>>> but for its parent (the default root complex) we should unset its
> > >>>> iommu_per_bus?
> > >>>
> > >>> Well, for new arm-smmuv3 dev you need an associated pcie root
> > >>> complex. Either the default pcie.0 or a pxb-pcie one. And as I
> > >>> mentioned in my reply to the other thread(patch #2) and commit log
> > >> here,
> > >>> the pxb-pcie is special extra root complex in Qemu which has pcie.0
> > >>> has parent bus.
> > >>>
> > >>> The above pci_device_get_iommu_bus_devfn() at present, iterate over
> > >> the
> > >>> parent_dev if it is set and returns the parent_bus IOMMU ops even if
> > >>> the associated pxb-pcie bus doesn't have any IOMMU. This creates
> > >>> problem for a case that is described here in the cover letter here,
> > >>> https://lore.kernel.org/qemu-devel/20250708154055.101012-1-
> > >> shameerali.kolothum.thodi@huawei.com/
> > >>>
> > >>> (Please see "Major changes from v4:" section)
> > >>>
> > >>> To address that issue, this patch introduces an new helper function
> > >>> to
> > >> specify that
> > >>> the IOMMU ops are specific to the associated root
> > >> complex(iommu_per_bus) and
> > >>> use that to return the correct IOMMU ops.
> > >>>
> > >>> Hope with that context it is clear now.
> > >>
> > >> Hmm, I was not questioning the context, I get what the patch is
> > >> supposed to do.
> > >>
> > >> I was asking the logic that is unclear to me why it breaks when:
> > >>      !pxb-pcie->iommu_per_bus && pcie.0->iommu_per_bus
> > >>
> > >> Or in which case pcie.0 would be set to iommu_per_bus=true?
> > >
> > > Yes. Consider the example I gave in cover  letter,
> > >
> > > -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.1 \ -device
> > > virtio-net-pci,bus=pcie.0,netdev=net0,id=virtionet.0 \ -device
> > > pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \ -device
> > > arm-smmuv3,primary-bus=pcie.1,id=smmuv3.2 \ -device
> > > pcie-root-port,id=pcie.port1,chassis=2,bus=pcie.1 \ -device
> > > virtio-net-pci,bus=pcie.port1,netdev=net1,id=virtionet.1
> > >
> > > pcie.0 is behind new SMMUv3 dev(smmuv3.1) and has iommu_per_bus
> > set.
> > > pcie.1 has no SMMv3U and iommu_per_bus is not set for it.
> > pcie.1 doesn't?   then what is this line saying/meaning?:
> >   -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.2 \
> > 
> > I read that as an smmuv3 attached to pcie.1, with an id of smmuv3.2; just
> > as I read this config:
> >   -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.1 \ as an smmuv3
> > attached to pcie.0 iwth id smmuv3.1
> 
> Oops..I forgot to delete that from the config:
> This is what I meant,
> 
> -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.1 \
> -device virtio-net-pci,bus=pcie.0,netdev=net0,id=virtionet.0 \
> -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port1,chassis=2,bus=pcie.1 \
> -device virtio-net-pci,bus=pcie.port1,netdev=net1,id=virtionet.1 \

So, the logic is trying to avoid:
        "iommu_bus = parent_bus;"
for a case that parent_bus (pcie.0) having its own IOMMU.

But shouldn't it be just "if (parent_bus->iommu_per_bus)"?

Why does the current iommu_bus->iommu_per_bus has to be unset?

I think "iommu_bus = parent_bus" should be avoided too even if
the current iommu_bus has its own IOMMU, i.e. iommu_per_bus is
set?

Thanks
Nicolin

