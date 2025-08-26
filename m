Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB20ECA0FED
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 20:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur0bj-0003K2-Uy; Tue, 26 Aug 2025 16:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uqxRW-0008VE-7S
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:26:46 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com
 ([40.107.223.75] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uqxRM-0003K2-BB
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1I1cVFyQaBVwY306qDVwDO4GWZKYDcpL2upIvg5gO3mqnijWIOGELcjaLpRlp1K2KSDhWs86xTQQ/HGCBzntV55JsCRKbgV8y+LixdwUcQTnHwa8SN6Aiwc43xjo29JoMZLNK0CKY+F0QhMGkd52Zhkm6i15vgaakfKq2qbUGp71b2Hdo0zVq+SKQF+0tNbGfHNi0lqvbjtzfSXLIftO1Q6S37T1VM3nH8QP1utlnHa8z+r4Ni9qNBSomYHmgdlpSo6J4Pg7jMhs7VSRw41WYULLMvL80ahFXIseek0+Uz2lEUz+koRYG5cJP8MF8OHYY6CRQPYp+jXalSTvGU1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03t1IPyoWDfpAaBU0yseMIHzSxsMWZqpmN9r/VOE3/Q=;
 b=dnRUlc0hGquNQ6VFkJuSuw99LsdVzCxiDwfWxuy8EQayJNAyGwIpSgyju6jRx7L0ZefWuEpKmRvtSXQF/rbJG3wj0XvwLags/rUIOs/HKED9zc7u6P/EBOCoafQcDE1e6EXBRrLdaTdIxWL2cUpuxQ9lDN/maFIVcWAYR/VH11Rf7gDXMswHMkbWtK3INz7iOZWpOv3qoaDb2W9pdeFrYEWOKGfXdfaOp2ElLXY69DAFuJrX3YHi9RhBMK/V514kv1nMnEtuRwitm31bNy1Ssh0vZUMil0/W+EMkEopFP2fXgrlAEY1IisF5POyd/MNJt+GcD/3Rz3t5xG9A1HCiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03t1IPyoWDfpAaBU0yseMIHzSxsMWZqpmN9r/VOE3/Q=;
 b=ZBTmvIet20g58qppmnOTUF3u4Mg92aI4Q06RmNcaD4/hONXKHtoYRAc2QAjW0rOawre58hP1h2l0e7/8A0Gu4y1l2qj52Nbxcm75qzpkKQ/6cBVorVYZamEoOIF4I8hCL8HOEvNs/SWfhO1sMXPnzQjj5+Fql5LTnga+VgcHk3693H895FL2bXdgt+Biy4wQ6/JT/69Gzir5VXpcejgpFxzcjyE9j04ACci6QiotlJWFI3KiggBrtHGGLFBu3U6YsFYko3AICOHxPV3+gKci25Z6/hvqprMYkeO2z+GKBf5nUALgDm99pXU47k03DraC2St1xFS3pe6JHLGL9ObSbw==
Received: from DM5PR08CA0060.namprd08.prod.outlook.com (2603:10b6:4:60::49) by
 DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Tue, 26 Aug 2025 17:21:27 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::ec) by DM5PR08CA0060.outlook.office365.com
 (2603:10b6:4:60::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Tue,
 26 Aug 2025 17:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 17:21:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 10:21:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 10:21:07 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 26 Aug 2025 10:21:06 -0700
Date: Tue, 26 Aug 2025 10:21:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 07/21] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Message-ID: <aK3tAUUn5t61VPyk@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-8-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822064101.123526-8-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f865e4-6642-4fe3-a517-08dde4c4fdb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UGjYMzGzMSyt87ETCXNO91kmGuLgVJy6BUkGU52IHhphyYcs8q+joc3r0koP?=
 =?us-ascii?Q?kG3imE4Te4CJuLXOUYs8eDefP+VugOSS0o21tiPjVpBCE4Hkk27SY1/+nnyN?=
 =?us-ascii?Q?gmt9HsxDMNkaKsyvNx7GgveqHqqDLzeMueKoTDXFXUiptexcyYUsyUpYobu3?=
 =?us-ascii?Q?yfsJJ/UdDXRbVA3WtlwRmS5duq/HfO06O28GWRq0cBtChUq+x8Bh87vL1x79?=
 =?us-ascii?Q?tHOdGGYmVV2c0CKpMYJX79M/v8TQqaMoPjvcDnSBxFEBQ850VCKTCKcV9Bbm?=
 =?us-ascii?Q?Ur0NBNH+ef24jm8t+Ex3W50XtmrnMgqfTDirW0M/evPI4hChs3BSpfZwzbeH?=
 =?us-ascii?Q?SuG7iwKj4EMeDloe0w/isVV/UDdXf+RTuIvIxioJWsgbc7sYIc5bOOPvOQmQ?=
 =?us-ascii?Q?Q7kIkQfP5qvjTk49Rvlur+IivZ+LTKZNJ7kYlOqRJN25fvKK1A9umnsC9khK?=
 =?us-ascii?Q?vaJ2Ojxye+PNVj7oBjxivoL19nOTvtxISt7aCJfpqlbAcFAm0cL/3VN0vMn2?=
 =?us-ascii?Q?lZiBP8qJqDoReyrJsgour9AlGBVK6MC1jcpu/vBHfhzR5QELns23/xvgkqOr?=
 =?us-ascii?Q?vlzobsUTXVXy3eAH9pp1bi3jklDEH8ctRO3fQZub5ilBoB4NkA2JYR0YjH9P?=
 =?us-ascii?Q?G7RTcMUvxU+ZHP36L/ePpEXeMjOSFtwdXSk8U3cblifzNl7XIAnnA8iL90Sd?=
 =?us-ascii?Q?RWYsVGPHrDZpDIhWIHE0ppRMujdTPsO+zcdLwSZ/sTP8FUXTXZdeXfyqzErO?=
 =?us-ascii?Q?FnJ0Gb5lOSXeBeUF+9R4yeud+keRZp03CJCRvJ8m/85uy9zYw92Y3aRLdayV?=
 =?us-ascii?Q?JuKuKDtokZEPvwZqwnOpRp2uwGOfxZrUFDqgtGDMTxz6WUFNi8WxSYIRjLfa?=
 =?us-ascii?Q?AnfCqKosxY6t0SChoeEv5g1A4jDs8DWYI1qetOsiViCmpoZnz/FTUNR5CRxV?=
 =?us-ascii?Q?dp3o7LBMsbKXpBqTFTLEv7dgBpd2XqOBgNtTctUMQfJ+QPvcWMPoDHi12pxR?=
 =?us-ascii?Q?jkdeTiNb8qJ0u/0t9wNY58SC/xFqOOFHUf4FK43tRyAYYhoKcXUQmqTyJjzV?=
 =?us-ascii?Q?BQwJ5It1jhSsNzz6Fble569SU3szw8ClWPU2SiSpNvaqMVm6jRqmgmIvImRa?=
 =?us-ascii?Q?motHqxNEjfTI0OJ5xHCb06pwZkEZB9XYKZpNMRMr5vNVW4iG6bubdwzhgRCJ?=
 =?us-ascii?Q?YvLvv5R+O06+vmFn+yb1XUJUN+RLfoOVp7dJVztEETA6AuyGxz1/6s1vlj23?=
 =?us-ascii?Q?wC/Whq6w2KBCtv5cVGFPpIVmv5A7EDG5PViaiSe6RIhXDkz/jppEDEBOd0+U?=
 =?us-ascii?Q?ujaPX/G8yvSVcXqbff92PIpclN/eZfUj4gVQ4z5Adybg/50ySMAlnaSgYzxy?=
 =?us-ascii?Q?cIa7BoDRLR0StlpzvqWOtttqp4qxmjU2gfExEmsImnRtXr2XuyHa9BsWv7Ba?=
 =?us-ascii?Q?/NCOP5RcIMiGA6RAKjazjw6W0Yjunh5ApSG+B1Rm+9GTyTswrjJyP1jBX+by?=
 =?us-ascii?Q?0qifMKVaJJel8vbQt8SGlQv9c3qlVrS50rju?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:21:27.6410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f865e4-6642-4fe3-a517-08dde4c4fdb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
Received-SPF: permerror client-ip=40.107.223.75;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 26 Aug 2025 16:49:28 -0400
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

Hi Zhenzhong/Yi,

On Fri, Aug 22, 2025 at 02:40:45AM -0400, Zhenzhong Duan wrote:
> @@ -4371,6 +4374,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                       HostIOMMUDevice *hiod, Error **errp)
>  {
>      IntelIOMMUState *s = opaque;
> +    VTDHostIOMMUDevice *vtd_hiod;
>      struct vtd_as_key key = {
>          .bus = bus,
>          .devfn = devfn,

I wonder if the bus/devfn here would always reflect the actual BDF
numbers in this function, on an x86 VM.

With ARM, when the device is attached to a pxb bus, the bus/devfn
here are both 0, so PCI_BUILD_BDF() using these two returns 0 too.

QEMU command for the device:
 -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0 \
 -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=on \
 -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0 \
 -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.port1,rombar=0,id=dev0,iommufd=iommufd0

QEMU log:
smmuv3_accel_set_iommu_device: bus=0, devfn=0, sid=0

The set_iommu_device op is invoked by vfio_pci_realize() where the
the BDF number won't get ready for this kind of PCI setup until a
later stage that I can't identify yet..

Given that VTD wants the BDF number too, I start to wonder whether
the set_iommu_device op is invoked in the right place or not..

Maybe VTD works because it saves the bus pointer v.s. bus_num(=0),
so its bus_num would be updated when later code calculates the BDF
number using the saved bus pointer (in the key). Nonetheless, the
saved devfn (in the key) is 0, which wouldn't be updated later as
the bus_num. So, if the device is supposed to have a devfn (!=0),
this wouldn't work?

Thanks
Nicolin

