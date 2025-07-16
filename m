Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81197C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6m3-00018N-Me; Wed, 16 Jul 2025 14:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc6lj-0000vp-EE; Wed, 16 Jul 2025 14:22:17 -0400
Received: from mail-dm6nam12on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62e]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc6lh-00016R-87; Wed, 16 Jul 2025 14:22:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEywn5x0HCpPwdo0wGvR8O09whcR0usv6xvBvdzSYgHneGuYkIpSXOVAsNh2+Sz39c8Vv2hESdrhP+JYBJD4uaoG2fxLwQagSHbvphN2GlzWO2MDLc3S2vV8bf90ExC+1CtiE8OnJDYZ8zSAJWJ2QFrzOeLbctmJxD2LKXQuJmG0qodCoVltJRWxhebR22Rypok1Rh1nE+YsSameuzXtej+h2anFGSW29f79zs0Zl9JvvwI0O6Lzzj00wMzzIpUa2bZDVaf9uKpApwuUsr4L8AF0jrP76pjOx/pz5eckjqG/rAQSl3Iu+4XY9IlJqWQ4SM11FkRHC7i5nPZoQ26BMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEjb84oRjL+8HpIUwFF0q+GgU2bxxlsNGCGZYYvCBGA=;
 b=qmP7BiKg+p7vBRsutDOv+9zagm44I5n/ZsGiY/MVujUfgddwU0OZf1zNgZGEuGW255Ygc/wWpX7FMFSNK2JwWvjhY+awgIvheDqeYnnbWmm3YJQJIypfpsA36OZcLE0J23d1CzaPrYpQx6Nu4AVrDK65IlhWGt+OYRodKkQgowgccsocKdOhDc7IeCcXZnadYCX0Bv34F9xzEta/OJthGtXNpgPEjiKBKL/26Z+bRN5OSZ0hR0BzeZW2GjrjvU5PbZqN1CZW3KxaeowI/LSm4JgCw1plC7ZDVcRkVoMgrEysnsoJYChxtBFocJPSGKy641MKmjU7D+TC6fEJjKifzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEjb84oRjL+8HpIUwFF0q+GgU2bxxlsNGCGZYYvCBGA=;
 b=MmVrq+faZly4cpE8oQF/OkwvdEm5ampExi6qviZ2PSM2Fqt3VNpevQDLQFCFwVjXqmU5g9ZmQ4n0sGHDtCAT8IpkEEF2XLTTbB1AZU+wJKylpFOwhNBTmM1/XZXCSs+m/CkA8dXQo6Cgd5LSewFUuHInUmUM3+vKPnFBryRVKdcNGst9Wk6MYLSMTAq3gshgLNogqAAFCbMEZwOdHqW8i/eTSnx6UV5OZNKhQn2UFNGQVp6s54QqBDFw+ILEQcmLDZrD4rA/WWuqf6niY1NEiHybXiU9NLZBolh5FEtlwLZu1ipyeBySOiIoVGie4cC8+V2gxKyA5QLiYPNK3wXEHQ==
Received: from SJ2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:a03:505::20)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Wed, 16 Jul
 2025 18:22:05 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:a03:505:cafe::ca) by SJ2PR07CA0011.outlook.office365.com
 (2603:10b6:a03:505::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 18:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Wed, 16 Jul 2025 18:22:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 11:21:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 11:21:45 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 11:21:44 -0700
Date: Wed, 16 Jul 2025 11:21:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "shameerkolothum@gmail.com"
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <aHfttvNNyCCjbWJO@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
 <IA3PR11MB9136E0D793F99E3837D208229256A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <798f739303f74fbca49a09a623a0a118@huawei.com>
 <aHfmmdXXKcFDnJLP@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aHfmmdXXKcFDnJLP@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 806fa0eb-b8c2-4302-9341-08ddc495a9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fa03nthwA97j1HxFqC219nblHmA2yevCpnuxWk/oCCeL0pL09cRjghIGhhm0?=
 =?us-ascii?Q?zLgBPN40DAvFVojHdTskGibDJzPaRQ8ZHxiyYvWbMMM6sEu/7X7+J4GTTX5g?=
 =?us-ascii?Q?MxuhYKQxRK4nNKB4zEkb9Hp/8YIeowy0w7zgtJSsv58LvuE1eCak9cSBj4iJ?=
 =?us-ascii?Q?rU/7OND5jwzyym6yaX7qdhCkdyqzDqmp7SCgZfKKrzt108cmlNOqnPIeQWVL?=
 =?us-ascii?Q?6aitP4UEGp4rW2ByYg+zjdoK0mcG3PFiZkzF8cfzs8ch3XL4NstBCIBNfMlk?=
 =?us-ascii?Q?C9xwH6hzkRzBjRHFHkhVPGmNZjeT++uz5oVyxLSys9eldV+79Ymm0qK3rDDc?=
 =?us-ascii?Q?UqM+0VkyToKiRhLWezAlyCM18VfB8As2YkgIP37l+ieVVsr1amYmoRAbiK1a?=
 =?us-ascii?Q?uySMrJ3AmvL2G8ZDsxeyS57h6aNOqXf5U2IqCsLntGzF9KFHhz/L4WtG55BB?=
 =?us-ascii?Q?8H3x0jd68xhiFI276GV7kmUx5NMzb2JR/AgJ2WAt7waJLx6E4p2ToIhpCAXn?=
 =?us-ascii?Q?OciOitzYxS8i1IQu/NhlLWggTXRifYBsULvvhPxrQxpeB89AOJ5O5UleLmBo?=
 =?us-ascii?Q?W/me+7dI15zxdq4fiQsNqw/dK/wgFlxW/FwB8bpb4PHaCurYbFIQ8MqxPKYL?=
 =?us-ascii?Q?Hj24MbouTB0dGg9OocrxtKMqJy/WYQEGp7cGQRJEUdCIwfs0EQHY4qhtVR5R?=
 =?us-ascii?Q?pIW2uW7i7/Z+TzVwbkhw5gzudTrupa+Nzu3PGzJm8Bd9QXiz9Hj+jjgxWnE7?=
 =?us-ascii?Q?fDJ5KFePVsQpirCgc58QpduK2ayI2Rehu0lzncDfOHxsXmrSPUhe4qLObeNP?=
 =?us-ascii?Q?2E7tyuORw0txNvHTELznh9Q9x3+nNIZ+Bbl8/LSVktojpAaKWMGtQ/LoPd3+?=
 =?us-ascii?Q?4iLdy2Ipa37dA6w9AYx40+hVQhsNql5V7lvwomsBtfuRKX43onxejah/6Hip?=
 =?us-ascii?Q?lReAA7qeftXdilGDcdt8evmbl0O1eU+ZHlnWt+bsub6Z9BBJsESls0k+9oIZ?=
 =?us-ascii?Q?Kp2R9vvpXoeSc3c4NJRk4A+cJu2dd23Vi/fkUPjsMOdLf1Pns6n1ZAfStahp?=
 =?us-ascii?Q?ygMEkZIhIdq95N4GGOCaVw6Q0bF5J09/LEs9fEk0YAHYeZHz7cMT0LlMiGZL?=
 =?us-ascii?Q?UQebzaU9bWINn0dXcZF5nlv8cefcSLfrXdU27GPKLDXjYtFm0PNLo2HHF6km?=
 =?us-ascii?Q?YVxOX8jqz7O6p/SMkDQ+JO+n0A6HaFyzPxorBnFIS4IVaFVkZXLVL+KPbb4b?=
 =?us-ascii?Q?f6NcSAvW/lDGLi1ERzpxHxbJkoGl5ZkRDWC6GSsg3NLpvFtoygDheyQi8kaW?=
 =?us-ascii?Q?lpiRTgcyi3SvPC9/Xa+G/U5JzyLvlo7G5MmRXx7CLYxa/+W/Qa6SVxbEpgvs?=
 =?us-ascii?Q?vEpFg4q+5OFoDDTYIa7kgvXKdjffxFRsaLt5o2jgpsUOYVWmBZJyft4oT8LA?=
 =?us-ascii?Q?1Zq9O6QZXaUUxoCZ/HMifbwr4tv5b7cPHiSvqPiq+kdVBTc9un+7lHTLZQEq?=
 =?us-ascii?Q?iOGEHhq9pqHqoo0NjGmPPdtfSoFp4bVQJ5w0?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:22:03.4064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 806fa0eb-b8c2-4302-9341-08ddc495a9dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
Received-SPF: permerror client-ip=2a01:111:f403:2417::62e;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 10:51:23AM -0700, Nicolin Chen wrote:
> On Wed, Jul 16, 2025 at 09:34:04AM +0000, Shameerali Kolothum Thodi wrote:
> > > >> Seems aggressive for a hotplug, could we fail hotplug instead of kill
> > > QEMU?
> > > >
> > > >Hotplug will unlikely be supported well, as it would introduce
> > > >too much complication.
> > > >
> > > >With iommufd, a vIOMMU object is allocated per device (vfio). If
> > > >the device fd (cdev) is not yet given to the QEMU. It isn't able
> > > >to allocate a vIOMMU object when creating a VM.
> > > >
> > > >While a vIOMMU object can be allocated at a later stage once the
> > > >device is hotplugged. But things like IORT mappings aren't able
> > > >to get refreshed since the OS is likely already booted. Even an
> > > >IOMMU capability sync via the hw_info ioctl will be difficult to
> > > >do at the runtime post the guest iommu driver's initialization.
> > > >
> > > >I am not 100% sure. But I think Intel model could have a similar
> > > >problem if the guest boots with zero cold-plugged device and then
> > > >hot-plugs a PASID-capable device at the runtime, when the guest-
> > > >level IOMMU driver is already inited?
> > > 
> > > For vtd we define a property for each capability we care about.
> > > When hotplug a device, we get hw_info through ioctl and compare
> > > host's capability with virtual vtd's property setting, if incompatible,
> > > we fail the hotplug.
> > > 
> > > In old implementation we sync host iommu caps into virtual vtd's cap,
> > > but that's Naked by maintainer. The suggested way is to define property
> > > for each capability we care and do compatibility check.
> > > 
> > > There is a "pasid" property in virtual vtd, only when it's true, the PASID-
> > > capable
> > > device can work with pasid.
> > 
> > Thanks for this information. I think probably we need to take a look at this as
> > this doesn't have a dependency on cold-plug device to be present for SMMUv3.
> > Will go through intel vtd implementation.
> 
> I see. A compatibility test sounds promising.
> 
> It still feels tricky when dealing with multi vSMMU instances, if
> some instances don't have a cold-plug device to poll hw_info. We
> would need to pre-define all the feature bits. Then, run the test
> on every hotplug device attached later to the vSMMU instance.
> 
> Maybe we could do something wise:
> The sysfs node provides all the IOMMU nodes. So, we could compare
> the node names to see if they are likely symmetric or not. Nodes
> sharing the same naming pattern are more likely created by the
> same IOMMU driver. So, as a speculation, a vSMMU instance with no
> coldplug device could borrow the bits from a vSMMU instance with
> a device?
> 
> Sure, individual IOMMU instances could differ in specific fields
> despite using the same node name. This would unfortunately lead
> to hotplug failure upon the compatibility check.

Hmm, forget what I said here. Each vSMMU instance should be pre
defined with a list of parameters. So, we will need to run the
compatibility test not only for hotplug devices, but coldplug
ones too.

Thanks
Nicolin

