Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5AAC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 06:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR3Qm-0001kt-Gc; Mon, 16 Jun 2025 02:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR3Qk-0001kc-EO
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 02:34:54 -0400
Received: from mail-bn8nam11on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2414::604]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR3Qi-0004uT-26
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 02:34:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugd696fTi+9hCdHCHwdtzh7Qujjcgdkfp3gsXmbfBd4DePNPXaSx16nYbuAJpQ6nCBeQ+ifwE353Lk3T4vQiOt+LGabKn/ysGYzME7aPWpUFIcVLaZdJ6YUjc5A+3NDTbxhFO9rGBbzmNqgclQhyNOyEU7b5xhYWtX+beJI9WAGZQHDOklx+nHBqifYs1EdkkS3qGI1Pt7B+1YF/xid/OENiH55mJguRMSOaghJJF9bgdVmwq80HY8VdvAZKSmiaFKL2y+GHYXV+d6RINIjMZFtFC5gUn7c8FZXKybacitOvKkcSmJZkwr4rpOiA7uCES9fAQnRW9TscOT7IZMB8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8iiH729XErepzSR0MuCd+IOem6SAvxR/BGAUILAMcg=;
 b=yWNuC+myewhXAw1gHOpFBUMY9msXenJnR3vbL7aiMUlEHFliOKY3NfAXisFDfcEAZmqRIgkwHxFdeSHa6Z6aXAiSVaT01QScEolo/0ugP4AqQ/8H68FFUJl6o14Cxct39utIkvh0eumMxtLwo2qZl0sGFfIw8hAgpsBHR/DN9fX1yfc4+08sv5micXTvPKp7vZ1nKW/lHSool5AHp+jGg5YJyYSBccfyMqC3nKJ6HEhYagWbZebmWnc6O2MMVGM11dfhP7Y3N539yDCK0nURrlaMniEN74wQ4G2/lMQb6xCbDgQoJjDw4FMEzPQb5Udb0xDBCos5xH/enjtbe89IqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8iiH729XErepzSR0MuCd+IOem6SAvxR/BGAUILAMcg=;
 b=sLXX+2Y0ooJRomvTZv16L2xiiPsTGGZiJoLgx2HLS1AsNF8Iwexp2P/aH/bPEKAKyx6b249rDmkh4KV5RGApgzG3XhWIX+kr1PJE8tnJNVRgtDBZsooGECQq9g1+4pw/iEvIk5wLgrYyeJxt3oYoSlsk6U4KJHqn3qBACRrDWhsZCWWvZNU8HSZj7fAJTFfaNTZ1IEriyDu2zv2eAu8t7u03749/Xkv+Y7awocIJAY88UWo47z3t76gIxzHrBxw0Pd1Ezsqrw0svYKnQRH+bFARbaBR0rqJtjO/5tHoGyUIaDW2Jm1BtKzNtbBjcVQIE9dAaMGWFEE0v2PGVsay39g==
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by IA4PR12MB9764.namprd12.prod.outlook.com (2603:10b6:208:5d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 06:34:47 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::d) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Mon,
 16 Jun 2025 06:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.0 via Frontend Transport; Mon, 16 Jun 2025 06:34:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 23:34:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 15 Jun
 2025 23:34:30 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 23:34:26 -0700
Date: Sun, 15 Jun 2025 23:34:24 -0700
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
Message-ID: <aE+68E03aAXEynBd@nvidia.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
 <IA3PR11MB91365922FBD407DD25E382C39270A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB91365922FBD407DD25E382C39270A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|IA4PR12MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: c16bb58a-084a-41e5-840a-08ddac9fe36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4iMca5vF1KFcmiUN0kFNeoevCidpi+b45mMEiwp9cfXtr4NHn8+FBiloiuyI?=
 =?us-ascii?Q?bSeUddoFd7x5S2x0ow+076C+T2q0pZgeq124Nf1JSkf1RXkQcQpU8HfvCn8l?=
 =?us-ascii?Q?ncSDantayw2OiMrMyXQDmzY3CwLD3cJ8DFRq0oTsYXFRU6OfhYrQSVROE5oX?=
 =?us-ascii?Q?RkudM0CQKAS/dwRrbzGP+e1AGQznSyteTbJ6UKygRCJKZ0N0YYbQwrJlF/6F?=
 =?us-ascii?Q?LcQe102qRNI1EaMyI4CqQrpQgEhOl+kxqLI6JVghU2i0Ynwv0u2HenqZ9Jjv?=
 =?us-ascii?Q?ljbQjeS3zhtcRo9yFYJOL5BflS/lDnRRLXMGj4qPAcIStIFguq3wmWIoh60L?=
 =?us-ascii?Q?lgsAefxOJZi8PAotC9r4bWAO+iBSto7c4bxQmeMmTi+QDwszHEzO3snjJA7w?=
 =?us-ascii?Q?eHHPDtTn2D1aukk5ejzL6nSEbIR5ynBloYwyWU3mfFqGS6Kyk+Vd5x4wSudj?=
 =?us-ascii?Q?cQNIl72huQyJZEoE9ugUcvKYBSQvrRzTBDor1pVmCCQAUPrM4jDv0ayVcIbk?=
 =?us-ascii?Q?9N9hkxC9+uH1DOtRLtZ2Kp7XBAkHJgrmgD5CuGNsS4ks4S/ZhcLQ+VoMpKbY?=
 =?us-ascii?Q?+1uHnz5TFgZuy3GuBDPDu9Sir875XXsLbWcf1s5ZED4nu30xatjjKMb6LFeG?=
 =?us-ascii?Q?YTFszhQq1DrzgsXbJ3On1iaIoBmg/cnbMLQFIBbRC7dutQP0bNr8AtqoqVqP?=
 =?us-ascii?Q?8Q2n9FwWAMfeSlE0geKxhtN/d6OR6laDmqSSbuF8NaWieVq1heEEFN0cMUu3?=
 =?us-ascii?Q?+1PqVuXggU2CHYxjsj4fVEutzG9j+HXC/0QcZLfkmVKFR1twbWFL7p7fNm/f?=
 =?us-ascii?Q?04+GVTGYKuQawDOQb6BpDCObvCx7V5Z0YMEuKrHNJZm1nJIPURQZJXIcsOjY?=
 =?us-ascii?Q?14uLjiiDR+Db4jI9HWrnwT4ya4vBuUlVdGy2GTTGa2x4DIVYUr4zNus85HCg?=
 =?us-ascii?Q?Ge4E2bY6r1joCqqVxDknJqLGeZ9InxySyUjGTFZeAxNNcWmJRBFI/kchU0Au?=
 =?us-ascii?Q?gjLnGo0kMNdrc9QXBWGMFNQ1H1FouZlwmKo2cJwSaJOHS4TC43GRVfRSVqOA?=
 =?us-ascii?Q?lKygIes/ccfHYhZ0DXiTWnb4bI82lUvcbdL3QsGZmbuxzuF39q5U/LDB49j7?=
 =?us-ascii?Q?hEN61C2Y/afT8ynKc12dRYln1nXDGu7HpXhWc14d95q08cvMQdtGbPRY2nwX?=
 =?us-ascii?Q?Ed3ROv9P9KoO2QjlMEDvJ/6nqbu+DPys78d9g/4yX/FFfT/TlS4ZX2VHUWt2?=
 =?us-ascii?Q?QZhsWyLZTLgK2BH7+n8coqArOpFdAVv0AAPNtbUY3dJOzXLuz+dMS1Vb7eKz?=
 =?us-ascii?Q?RS+A1Jkeo5t6LYlV6cuzhrD0YXIW2w/kAzJlGYLcjzY+nUeCS4626A+i+yzt?=
 =?us-ascii?Q?JD6mGHPA/ez7YjynN43rRKlmC5UlR0T5sv1/9NzbuBR7t+jCVGXjFojQWTS6?=
 =?us-ascii?Q?LpS/2nwtM6lcN52MHurDTPVCr7h25kYAlAjgj/9SqOtflg+jH58wn4e2QLvy?=
 =?us-ascii?Q?BtT4puBmDq+O7vXVlQqWaHZroE/slMDhGmSH?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 06:34:46.9600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c16bb58a-084a-41e5-840a-08ddac9fe36a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9764
Received-SPF: permerror client-ip=2a01:111:f403:2414::604;
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

On Mon, Jun 16, 2025 at 03:24:06AM +0000, Duan, Zhenzhong wrote:
> Hi @Liu, Yi L @Nicolin Chen, for emulated/passthru devices
> behind the same pcie-pci bridge, I think of an idea, adding
> a new PCI callback:
> 
> AddressSpace * (*get_address_space_extend)(PCIBus *bus, 
> void *opaque, int devfn, bool accel_dev);
>
> which pass in real bus/devfn and a new param accel_dev which
> is true for vfio device.

Just =y for all vfio (passthrough) devices?

ARM tentatively does this for get_address_space using Shameer's
trick to detect if the device is a passthrough VFIO one:

    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
    bool has_iommufd = !!object_property_find(OBJECT(pdev), "iommufd");

    if (smmu->nested && ... && has_iommufd) {
        return &sdev->as_sysmem;
    }

So, I guess "accel_dev" could be just:
    !!object_property_find(OBJECT(pdev), "iommufd")
?

> Vtd implements this callback and return separate AS for vfio
> device if it's under an pcie-pci bridge and flts=on;
> otherwise it fallback to call .get_address_space(). This way
> emulated devices and passthru devices behind the same pcie-pci
> bridge can have different AS.

Again, if "vfio-device" tag with "iommufd" property is enough to
identify devices to separate their address spaces, perhaps the
existing get_address_space is enough.

> If above idea is acceptable, then only obstacle is ERRATA_772415,
> maybe we can let VFIO check this errata and bypass RO mapping from
> beginning?

Yes. There can be some communication between vIOMMU and the VFIO
core.

> Or we just block this VFIO device running with flts=on if
> ERRATA_772415 and suggesting running with flts=off?

That sounds like a simpler solution, so long as nobody complains
about this limitation :)

Thanks
Nicolin

