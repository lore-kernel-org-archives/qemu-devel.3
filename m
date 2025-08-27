Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5A2CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEKo-00065f-R1; Wed, 27 Aug 2025 07:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urBsr-0006TZ-Q4
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:51:58 -0400
Received: from mail-dm6nam11on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2415::625]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urBso-0002TQ-Q7
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:51:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymCKFuJGPZ4ORrE8OPBKGO3EWVrRLFuI9rNPVMQW6VXGLc5l0It4Uw48tzAjVfWU5HnTA8m6mKkCnKlIDgOoN930hKhyng7fKqvJ7jThEPvlH7kDAXqEg+OoZuwJfVP7E//JQOh4bM3CV8g7yt4KXhGaSG9Y9q+IjsLiEyWSnWCs0eQ6YXe6m7WYld0Hmf6ZQKzPuX+PrtvL2oQazK3xBeEVdiTAFJA4BHTMuB3ZTXve2DSpEUTY3nPi+rQjAF9hU6FIFyh0NxEV8QJVpzfKS2BavE29fjoLXprSDtV5rEBlNIx4RiAjzzjH1F1LSboor8XctDqDxkIsBBfMdecKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Rz7/sSFQHvQMWf44QOnmDwWza+V5eCUTjRIyokt+2c=;
 b=Mh9xDPv9LIj1A89rafBHyPcl29esk/43/c9PeBitUPr3rqxThStsmYT7LscaPsmpDZiGsvN+/Y3dMnW1NQ210CkVgNULAruRRoa55MbIA6VZwG86vxOOANQj8bBpmdu9MFZHNI3x8Z0Uyt6khJQWGeX2y4XQ/iG8mFS1NfQEy1WcL0z7Q57GK6Ivl+TfC7WtwjDlVnfQB99uwtohKpYv2g90t6IL5v8fh3FGjr306xM0QOxu0mIXvlV/I3owxgliQ170If2BQwaZvG87GkXnP8+VKVLCsd2lveq0bpt4K/lrGQ9PlWywBBW6QHm3ybC+rABIY+ytuSgdkuh/m6tgrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rz7/sSFQHvQMWf44QOnmDwWza+V5eCUTjRIyokt+2c=;
 b=frbynJiF0zPKm/4P5R5PqEIgDH1mvGNB/56DKojBVSsg74hJ6NoGoxLscyEjv5SjXEj6K7HL6cM9BMk53oCJSXQnaU0TN+TFkupCrGFi6Lg4yHx9DrbPU17/IrZy0WLzFvwkEFrT+SDkbeq/iq4gZ1QLw/XvxDrELvhQXmcrYP+ibQvZYiwPC+ZUtfzpqI5npRXRdQ7OMDr2D/Z7t6ELQXq6a/vDAE11i9pWz6rVCH+aIOb85SaMLchXGAzFwlbnnqMeQDeOd4SoPDS0TA8z1gTMhoqyOntA/3bnGssRJzYUITJ484g7mKkiGk7Rxfwnzjm5LaSId7Sp1vd1eB7x9g==
Received: from MN2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:208:1a0::25)
 by SJ5PPF8AECCE022.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 27 Aug
 2025 08:51:46 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::8f) by MN2PR07CA0015.outlook.office365.com
 (2603:10b6:208:1a0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 08:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 08:51:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 01:51:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 01:51:24 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 01:51:23 -0700
Date: Wed, 27 Aug 2025 01:51:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 07/21] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Message-ID: <aK7HCQFFNz6KLL6l@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-8-zhenzhong.duan@intel.com>
 <aK3tAUUn5t61VPyk@Asurada-Nvidia>
 <IA3PR11MB913642ABC862B837CF0DF4359238A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB913642ABC862B837CF0DF4359238A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SJ5PPF8AECCE022:EE_
X-MS-Office365-Filtering-Correlation-Id: 131c4b83-2404-4fac-6363-08dde546f415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uQugsNvAbRXcg3zG6IMU1fPwP3F7TZYrtcMClTzb5r1VkDB82hnWP1qRLgT2?=
 =?us-ascii?Q?2Cnbe47ZpusOTg04kfRSa3xBvqvOKkfv4TmGMCtbCf4QYCMhjCf9iUNPCxnj?=
 =?us-ascii?Q?F+YxJyYA7w2WGMC+yQTiZgtvkykX/AZmgb1rLrS+TflQ98RCK85kVnGvRopn?=
 =?us-ascii?Q?4PiyUmzrCkBbic+RZvCd1QoyA481pW2HSBpeqI3/6EceF3ntqvTP7I/1vkQ4?=
 =?us-ascii?Q?TNuONxq17IKyIonUYExa7MyoJIs9BmbYJzcIJwSQcXJb/cYRvozzkJfSK0kT?=
 =?us-ascii?Q?mUgNOquHpIm5tYBj43te8qCZWU5m6QY0VS9HWcCyYB1o/7iMXuZ9mYlRhp+X?=
 =?us-ascii?Q?On0MjXdUG3vYUQwd2n3clhgoJQX86Nk31WXgcHWQZKvJTVX1IgjHY2WO1JWl?=
 =?us-ascii?Q?8fuUER39R6Jpc8+g8gmj58HQkWb/15OlVFdvIoZHMkOYcQe+k2I9Q+jWTjP4?=
 =?us-ascii?Q?TWYNinRSDjMjo1cVg8nVK7nWbPxfmcDPiWDmMbL/oMYCzh3qsiSXKrH0hebM?=
 =?us-ascii?Q?ykLuJyCi0Ooemkhxy/RDzvlvZ/ZoBwMJ5ZpLzv8KdT+TMspoTMsGmqb1L+tS?=
 =?us-ascii?Q?Svf8fVuyX6ud6ovAxqUHcw613L/ozGjtXDe8tg65UZ9+8wAhz9O04865hk4V?=
 =?us-ascii?Q?oNg09hDEdIKSQh6RmCz1JrfiUp7qcZlAUyQxGDO42GIHGvVMCEmsGdCkvC3C?=
 =?us-ascii?Q?2tz4ChGymGgV8J2SEWWfXLJFOwPd1sCMcMB2XrbriSqqgj5ymv39tvqjIGM9?=
 =?us-ascii?Q?hb/Kms7Hu94LxJoBiXkk+xX+O/VE6usXBUta9THp/Ru1lvhScSpvdd/LFtsQ?=
 =?us-ascii?Q?4Pon/geTQLaqWycBYN4T3vFHdMIJ8V9viJy9/625vtyIwlVTAtV/lyHhwtUP?=
 =?us-ascii?Q?Y9IY+2p+OH25uoHDHYpoXmJxXbdu1eRB3CUa2UJWXCu6+RA64ma2nmmAwtwq?=
 =?us-ascii?Q?dYlHdlVlKoVwVRW7N1jKYlyD1PgZ8ZK84fnA5KBts/hDAmIx3kac3ZbabiWv?=
 =?us-ascii?Q?vSp0SSz4OGFKXA5TwBwCzPDgTFzT6nv9gBov2RuKPE3DBqdSkxVJpTasyL7l?=
 =?us-ascii?Q?TzX9LeMSX9V0b2XKVI7E+lYStpzjJGNO3FdmSfwxcsNPumCa9esCc4NqN//z?=
 =?us-ascii?Q?Y0Bp3elf+JAxYxDIDDQkgKktY+9m9gMGH8PYyoWJ9MdLxejLE+rpVl02ikvC?=
 =?us-ascii?Q?/pB2Wtb1zRaOY/EDeujdsKmV109hHHqOqSBhyi8TgqeJyWw5mnNWZKinTTCp?=
 =?us-ascii?Q?hB0IaM5ZbydqNDZaY0BxQAxayEYd5yYhcmLiv+a/J/fkh15kvqEmvict7uSE?=
 =?us-ascii?Q?J1TQ1h8WDJsVFpH7RET3NzJs3FpNA34jOJJT4abUpXQKxj9tiUHRRXrdgLFL?=
 =?us-ascii?Q?g2XJXNTfJIe1P+sG1WHJEGgIH8HarFo/jVoCqbyr2/SQKsRvLoXEtCXhkFDf?=
 =?us-ascii?Q?20/8gjidxT7827i+OgD+mg2PiFIilzuUanHewvHzTwCNIfLI2AdI5zjdffL0?=
 =?us-ascii?Q?rK1BBHs+fxcARZIxwzLkfQqMcL+HCt+msPIf?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 08:51:46.0141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131c4b83-2404-4fac-6363-08dde546f415
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8AECCE022
Received-SPF: permerror client-ip=2a01:111:f403:2415::625;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Aug 2025 07:28:55 -0400
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

On Wed, Aug 27, 2025 at 06:45:42AM +0000, Duan, Zhenzhong wrote:
> Hi
> 
> >-----Original Message-----
> >From: Nicolin Chen <nicolinc@nvidia.com>
> >Subject: Re: [PATCH v5 07/21] intel_iommu: Introduce a new structure
> >VTDHostIOMMUDevice
> >
> >Hi Zhenzhong/Yi,
> >
> >On Fri, Aug 22, 2025 at 02:40:45AM -0400, Zhenzhong Duan wrote:
> >> @@ -4371,6 +4374,7 @@ static bool vtd_dev_set_iommu_device(PCIBus
> >*bus, void *opaque, int devfn,
> >>                                       HostIOMMUDevice *hiod,
> >Error **errp)
> >>  {
> >>      IntelIOMMUState *s = opaque;
> >> +    VTDHostIOMMUDevice *vtd_hiod;
> >>      struct vtd_as_key key = {
> >>          .bus = bus,
> >>          .devfn = devfn,
> >
> >I wonder if the bus/devfn here would always reflect the actual BDF
> >numbers in this function, on an x86 VM.
> 
> devfn is enumerated by QEMU, see do_pci_register_device(),

Oh, thanks for the direction.

> bus number is enumerated in BIOS or kernel.
> So we can't use BDF number as key, we use PCIBus pointer + devfn
> as the key instead.

Yea, I figured that out.

> >With ARM, when the device is attached to a pxb bus, the bus/devfn
> >here are both 0, so PCI_BUILD_BDF() using these two returns 0 too.
> >
> >QEMU command for the device:
> > -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0 \
> > -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=on \
> > -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0 \
> > -device
> >vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.port1,rombar=0,id=dev0,iom
> >mufd=iommufd0
> >
> >QEMU log:
> >smmuv3_accel_set_iommu_device: bus=0, devfn=0, sid=0
> 
> There is only one device under pcie.port1, devfn is initialized to 0,
> bus number isn't enumerated yet during realize() so 0.

That's a pain for ARM... It needs to set BDF number early for some
use case. Shameer's current solution is doing after the guest kernel
boots, very late. So we might want to move it forward..

So, it'd be very ideal to have BDF in the set_iommu_device callback.
Otherwise, we'd have to add something like set_iommu_vdevice op to
invoke in the PCI core.

> >The set_iommu_device op is invoked by vfio_pci_realize() where the
> >the BDF number won't get ready for this kind of PCI setup until a
> >later stage that I can't identify yet..
> >
> >Given that VTD wants the BDF number too, I start to wonder whether
> >the set_iommu_device op is invoked in the right place or not..
> >
> >Maybe VTD works because it saves the bus pointer v.s. bus_num(=0),
> >so its bus_num would be updated when later code calculates the BDF
> >number using the saved bus pointer (in the key). Nonetheless, the
> >saved devfn (in the key) is 0, which wouldn't be updated later as
> >the bus_num. So, if the device is supposed to have a devfn (!=0),
> >this wouldn't work?
> 
> Both PCIBus pointer and devfn are fixed value for a QEMU instance,
> never changed.

I see. devfn wouldn't be changed. Only the bus_num will be updated
in the later stage. So, it's not a problem for Intel.

Thanks
Nicolin

