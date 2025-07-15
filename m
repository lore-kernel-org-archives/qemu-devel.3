Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361DAC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 18:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubkP0-000803-NE; Tue, 15 Jul 2025 14:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubjwO-0007k1-FN; Tue, 15 Jul 2025 13:59:44 -0400
Received: from mail-bn8nam12on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2418::607]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubjwM-0000sC-6S; Tue, 15 Jul 2025 13:59:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3WaWu2sbpXpb98EDUYCnb682D6d+MS8/8LY3UBOdwVBZRZGx7Yd6OR7b4YrB+JJtq23IHPGmTKCyYwbVpq7S0DWzbsF4Y6UjU4wA+KPVubqEM6acOZZfJiit6+7us6FNCkAz6KS8dX0pW27Xl97HHav7X9oweWvgmX6sAr5GQhpW0yulNwOXDYxniu2jDg4rRd+5ycTJczN42JTrIW5imKGPBv4Y3gRVPOG6d8zQr5gVgNRIsXwgarjvFtJGteNwqvmE+qOLhCRiHi9aLHqMrZDuJfn0Q7oPqJbSoa73mezCt0Ehgwk8xT6G4qDOZpXx/+TudH5PODLebafNWXRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE49+bqURHhEDFQ+Xgl9xXIG02i5SwsGQ5sXGe8HSsQ=;
 b=xJB/weRbPoOokxUQadlB5nz17QzrCigSCUXMOXyATzIzofLLF6yG5AcUUqIr17hs+L25tu5kE9aveJXcHsJMbUl6vwlHsJXrmQz4zdQ+Ykbyoantk/eql1RAh86I9vK+MYfSAOi2FbpcWPR8SctItdWofUxWSLe7tVWDUaj2UEVdWcmSLGlu652PAnz7Fibpvduu0sgMOaP2qlbsHW239k9BY8F0wg1zkISoZylkLtUT6VMJnoMKFSn3vvEwza1aG7Eywe8LpBzYkK947CT34g1w+XxjiBXQ4tz0Q1Lbp/eLkanTwwF9kCKNQVoWT3ZqJcmQpzSnY39MKCyZFeAyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE49+bqURHhEDFQ+Xgl9xXIG02i5SwsGQ5sXGe8HSsQ=;
 b=uf4LyokfkiYiY2greHUd74+iMQVnMEeEAkwnAZkzLq+E2CivFhvsSG3EtEfDE9Vjp6o3MsTIQyTavG+HifSxI5sAnooMvKlXUr6GDuY83ve8GqvJoJnrwP42HT146An+GX3zBT91i3c/4LmKki+IMgEaKLG9zjzmWbWWhIBrgDz7seT9+9KQuG0Ks6vMrIjFpM9/fPTS6jB6R/UhYO0yDd0XbACMI8LJ0LZgxtKq5lPATWyePKTqGI/eFe3YRDQ15S+QadicBPF7gTRcoVdQjXueO6QcikERS/wr8Yi1fsVpNT6OXVZKV7LOOcS7RU2/ynlgY4xjChS+vHXnXRB9ww==
Received: from PH8P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::27)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 15 Jul
 2025 17:59:35 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::fe) by PH8P222CA0017.outlook.office365.com
 (2603:10b6:510:2d7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 17:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 17:59:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 10:59:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Jul 2025 10:59:18 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 10:59:17 -0700
Date: Tue, 15 Jul 2025 10:59:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 772a68b8-ceef-48ad-b0bb-08ddc3c95bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wkz+AO6Z1kbu0levwrobOP8EUUJCkJRUt2aR+WCtbLoVCFEyS1kN0xkBhKwa?=
 =?us-ascii?Q?uI3Zxecep7yl1LWCeHgwuYi7xn5ZXbGTzKRLyl/3ASm8xIno5dBniuV1c3GP?=
 =?us-ascii?Q?YpatqPj0/SJ/s+aneHzBKTaNx43LtF5iygNzGjXKBqyMif8CIlH8q/lio7XZ?=
 =?us-ascii?Q?hro9d+A8wh95pUN7z74dXNYjtxqgNbtmTVRm6T4lfW8paMe+xXPdEjfmfPzN?=
 =?us-ascii?Q?Rm2OJQES7zu2zP4VwAFogJq4wPOGJ76lgy2eXK/9EbmmEO48p2ZMT84AGYUV?=
 =?us-ascii?Q?nsRcxC71JahTfKeNSa6O7pBv5Ys5P4MqfiVGI7R/2KJmc+IKJOaAjJIqZD5l?=
 =?us-ascii?Q?2CRyvAy1fadheTLlDU4QJyP2dPtug3gw9aZinO7nRLPfY/ee4s5YzUjI4NBy?=
 =?us-ascii?Q?Z1M9KJ5rldG/jpeaKPIi9pN9blAwA9FZwXChh0idXuAP9ksAQtj7bbtSJPzs?=
 =?us-ascii?Q?aQN9Zs2+MipmJiwO/KcThY+ZUuYshOInlB3Z4SSqskKU/vvS4sxV/Wxs5+/t?=
 =?us-ascii?Q?SryWTlwKSOtVT/yiq828tJBXYVtXthMGpmjvqmnB3jwQqiLN6x8ccECFTsjI?=
 =?us-ascii?Q?BmOZE0R4sCbOHb+7zRczjcjnDGcDQjf47z3v/4qEnf66u/0rY125oxk9Imf9?=
 =?us-ascii?Q?u+DoaKM66n7iU2Z9INa0cXHa2/+eezWzk/kkXklAIHnkWalYcccy+QrbL6pD?=
 =?us-ascii?Q?L+qbgel1j2TLqJ6G7f3VLxp9396pCvZCYWdNdsb9cyPcLlI3WFLIY/URKh6c?=
 =?us-ascii?Q?AwS6lTjy7qqk5rtv/9cPMltiRXRVyDuMZ8w9Uc0p/OgJi29vZM48eMTRKlfZ?=
 =?us-ascii?Q?FOBZXnJ4cs2+9n+P8b90AcY+W83q8WVEawr81B9FDWqao/eavFQeXFY7f38O?=
 =?us-ascii?Q?5GHv8swKBD0la+1iKkSPaqot3ZdjwYiysmeZMSqtVV9cMY9j6CU6BTq4JzcH?=
 =?us-ascii?Q?d8ziI7D4a13hM1nwGaO54ZwA6/ydyYwjmMORHyU/ewOZEDpLfmDTp8ql1Pij?=
 =?us-ascii?Q?564u0Z+J2fl766yRD/M+2C2eJcRp+ZKeCuv2IHz2OSaky6hn6ta0gILW0Znq?=
 =?us-ascii?Q?Nbgz+gGqC5aFtkbXJI5AXqDLT2/9OE2hCfLtU0ZfK5GZIUz92NBQ+mc38KvG?=
 =?us-ascii?Q?XJkNlMVHmRu7UHSZ55FUEuPNLZzv4dTSfDhiu6A30bPUWKXtXF9N9jDD//wq?=
 =?us-ascii?Q?XHvlXHN+26A7IDxuvH9IDuzH15ZOsSw1eRbhfCWSwis21H4hH1A/IDMKsVuv?=
 =?us-ascii?Q?NVwXY61/jEhHcYfkkfgtXDA+7xe/1EnhSeYbtjjdi3r0kUTtuioiSFWCObs2?=
 =?us-ascii?Q?sMZNIhLNu5Vdd0IX+hT2ePpbG89LH+FEzxKFf+SUKsUjGbOl6VY32xXon+cx?=
 =?us-ascii?Q?/nJgZnqsKR9n991TR0fmxMwNRwtkEIa0kjEqIXxkTTScafb8gKLwMmwEWR4Y?=
 =?us-ascii?Q?wGvfhMbZ+7XPNfVqRssyJXcLd/cZ1G67NF1RoM9jv83Tj/1bE18hIVaFMgii?=
 =?us-ascii?Q?UZAzyl+ZlEtuHReCLVAyhDp45FaX5PLsbnUpOMwBoG9teX41HpXqoa6MvQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:59:35.0234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772a68b8-ceef-48ad-b0bb-08ddc3c95bb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688
Received-SPF: permerror client-ip=2a01:111:f403:2418::607;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Tue, Jul 15, 2025 at 10:53:50AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >Subject: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
> >SMMUv3 to vfio-pci endpoints with iommufd
> >
> >Accelerated SMMUv3 is only useful when the device can take advantage of
> >the host's SMMUv3 in nested mode. To keep things simple and correct, we
> >only allow this feature for vfio-pci endpoint devices that use the iommufd
> >backend. We also allow non-endpoint emulated devices like PCI bridges and
> >root ports, so that users can plug in these vfio-pci devices.
> >
> >Another reason for this limit is to avoid problems with IOTLB
> >invalidations. Some commands (e.g., CMD_TLBI_NH_ASID) lack an associated
> >SID, making it difficult to trace the originating device. If we allowed
> >emulated endpoint devices, QEMU would have to invalidate both its own
> >software IOTLB and the host's hardware IOTLB, which could slow things
> >down.
> >
> >Since vfio-pci devices in nested mode rely on the host SMMUv3's nested
> >translation (S1+S2), their get_address_space() callback must return the
> >system address space to enable correct S2 mappings of guest RAM.
> >
> >So in short:
> > - vfio-pci devices return the system address space
> > - bridges and root ports return the IOMMU address space
> >
> >Note: On ARM, MSI doorbell addresses are also translated via SMMUv3.
> 
> So the translation result is a doorbell addr(gpa) for guest?
> IIUC, there should be a mapping between guest doorbell addr(gpa) to host
> doorbell addr(hpa) in stage2 page table? Where is this mapping setup?

Yes and yes.

On ARM, MSI is behind IOMMU. When 2-stage translation is enabled,
it goes through two stages as you understood.

There are a few ways to implement this, though the current kernel
only supports one solution, which is a hard-coded RMR (reserved
memory region).

The solution sets up a RMR region in the ACPI's IORT, which maps
the stage1 linearly, i.e. gIOVA=gPA.

The gPA=>hPA mappings in the stage-2 are done by the kernel that
polls an IOMMU_RESV_SW_MSI region defined in the kernel driver.

It's not the ideal solution, but it's the simplest to implement.

There are other ways to support this like a true 2-stage mapping
but they are still on the way.

For more details, please refer to this:
https://lore.kernel.org/all/cover.1740014950.git.nicolinc@nvidia.com/

> >+static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
> >+{
> >+
> >+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
> >+        object_dynamic_cast(OBJECT(pdev), "pxb-pcie") ||
> >+        object_dynamic_cast(OBJECT(pdev), "gpex-root")) {
> >+        return true;
> >+    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI) &&
> >+        object_property_find(OBJECT(pdev), "iommufd"))) {
> 
> Will this always return true?

It won't if a vfio-pci device doesn't have the "iommufd" property?

> >+        *vfio_pci = true;
> >+        return true;
> >+    }
> >+    return false;

Then, it returns "false" here.

> > static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void
> >*opaque,
> >                                               int devfn)
> > {
> >+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
> >     SMMUState *bs = opaque;
> >+    bool vfio_pci = false;
> >     SMMUPciBus *sbus;
> >     SMMUv3AccelDevice *accel_dev;
> >     SMMUDevice *sdev;
> >
> >+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
> >+        error_report("Device(%s) not allowed. Only PCIe root complex
> >devices "
> >+                     "or PCI bridge devices or vfio-pci endpoint devices
> >with "
> >+                     "iommufd as backend is allowed with
> >arm-smmuv3,accel=on",
> >+                     pdev->name);
> >+        exit(1);
> 
> Seems aggressive for a hotplug, could we fail hotplug instead of kill QEMU?

Hotplug will unlikely be supported well, as it would introduce
too much complication.

With iommufd, a vIOMMU object is allocated per device (vfio). If
the device fd (cdev) is not yet given to the QEMU. It isn't able
to allocate a vIOMMU object when creating a VM.

While a vIOMMU object can be allocated at a later stage once the
device is hotplugged. But things like IORT mappings aren't able
to get refreshed since the OS is likely already booted. Even an
IOMMU capability sync via the hw_info ioctl will be difficult to
do at the runtime post the guest iommu driver's initialization.

I am not 100% sure. But I think Intel model could have a similar
problem if the guest boots with zero cold-plugged device and then
hot-plugs a PASID-capable device at the runtime, when the guest-
level IOMMU driver is already inited?

FWIW, Shameer's cover-letter has the following line:
 "At least one vfio-pci device must currently be cold-plugged to
  a PCIe root complex associated with arm-smmuv3,accel=on."

Perhaps there should be a similar highlight in this smmuv3-accel
file as well (@Shameer).

Nicolin

