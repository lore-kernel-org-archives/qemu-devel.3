Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC341C982CC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6vFC-0004aO-HB; Wed, 16 Sep 2026 15:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x6vF3-0004Zo-Ui
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:24:26 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x6vF2-0005fg-9W
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:24:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEjJ6uA2gp4omooFuCB0hm/dFD1kgnx17PX4ewV34AL7EeP/OKB9Y+jXMn92sKfcgcNKdVNlZKzrEHiTa2VB74trX45LpmwKTKXXOnkBIxJYtz6nz+s6xuk+lcrYiyECYejkDgKBQcOg867r0fDN8VrUM3BuhOgQnvre2KKvJPTRfsUUxi1ztoDubABqS9vqXwhHhAIfFbLz4hdDEWS7JG3B0mNVsDqQOuFApFlcn7CzeryEdBi46KrKhY1EDWm9YC6PuanIIL04C3F4DNIddfaReFK1hmNtQ94tehoxEMVBNAITFJJ8FNkjCH96cAAR4qFRQeBqARYK1iDWHe6gYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDNBuMe1NB7DvbTK1fFKmwja4VZvfukLOCwCeqS8P2M=;
 b=uPfUWxHw8jd7XuJOmQMwvnF5POr/t8yTfLOgfuqyOVhT736rrB8cLDvH67owABqcxNUgEuCUZkGk/c19wougFeKztxUOVXIfL4UvhrVCUzGYDq6xEJ3sJjUYJg0t6dElNMdM/9PfpBeJwA9YfpdyY/H9W7+hwsdHeijJKx+2nZwQuVqjEKNXAz3usdalJeCJW+ozY1eT+ct7XKMSTLnvrSN4WHlMr+xRR+9e6/C07314iIdLDUIIMM7SCJgo5dJDKbtOqA8e72lTNbHpBypBtrFHKcYFaVd3+D6LYiTnVT98N6SrQtPz3PhcUHb+nqbHPddwfEZpK2Uf0bvrBvqSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDNBuMe1NB7DvbTK1fFKmwja4VZvfukLOCwCeqS8P2M=;
 b=eajwoIKUm6+vxcHTTfNM+SxAJlLc3nlEwN8+hnqQdO4GWXuf8bXF5cY7RCOMYII0fZttM2KDX88xIcNOMQCMsLfr85nGNYX7qX8yqOHMfCKunC9TQX5CagLAx1AbRLEFW0AZtBJlPNEUhR5bmQ93RC4HzqvQ9ikXmCoGfZZtbcv2cpg43w/2+upuCf+M2ZtSDIZH5us5jTnmvYQwclB1NpkT7LPsStt3O0jWmxyVECbxG4tT0o111el08TS4EGJvGrbEuKrLGkfAcR+ZTp13WmKzsnqte/B4pFHdzDaPkR/ZXC8YSANsn1r07azmdQrtcZ7vc8RXeha5+VI3LwdNiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by MW4PR12MB7213.namprd12.prod.outlook.com
 (2603:10b6:303:22a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 19:24:13 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 19:24:13 +0000
From: Tushar Dave <tdave@nvidia.com>
To: devel@edk2.groups.io
Cc: gaoliming@byosoft.com.cn, ardb+tianocore@kernel.org, sami.mujawar@arm.com,
 jiewen.yao@intel.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [PATCH 0/3] MdeModulePkg, ArmVirtPkg, OvmfPkg: fixed PCI BAR placement
Date: Wed, 16 Sep 2026 14:24:05 -0500
Message-Id: <20260916192408.928411-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bcabfe-5e59-4925-dfd9-08df14281792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: OOhisXi8q/kCGKTPPHhyRMgySa7F+sUndtF5WZF97R0c6yhI1IlmcsB1srdd0+Su7qaSzx0c5HYlEK6ydwQsFtrphQwxmPUatU1vQOtQdY45F80wpNzwesXAyZ8h96PpUsOewNdSn+58Dm4F0d0KLqlXGLRiwvaiB/7OyHsXedulIl5D+i8NIIWp8Qz9JULvtu/UwpOMZYHX4cDcZruK2VLun3NehgLH2y/dTW3/6J9DChspSzqTiUn80gPwOpvsCNYUY36lqiB+z1vc+7uYyXhNvnqV3zljEMPRLJKJ5BqYnICEqwnFukJ5Ms/9D1YhC5ISDGBi2Quhvg+bzmwTTm8jveT6MJC9mtoJ+CxSrjEbwTCdyghKG1iAwbcfxs+Ezz9F5GDt0KTdXNkrEAFXHWrWi0T95zfzRcB1bwehinCQUnYGyId+sLdmUXeiQyzt0AjqmTz206OC9f+PRJ6fT3cazXUFmi5Y+MWArRCldFAN/Ywh4XZvbxE8hX/6wvnc6emxCA+ZlNPZ1BkB4DYDimEyXkIFxFMusHe81lG7x27xuiNTD6XwgGVWNWHH7I0zn1rcFBzwqCxc14qWa5yaqzVQlkQ881AYdx/faWIAsB+TTZlKv4/bkQVt+TCLCBDAAvCvbCGIaP4HAuBGfi+n1Znjf9zV/rH4tp84Ex92O1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UwilYQet7VWhmkETEPR331n58HgPZcRip0loeOqn97YTqA0FVUKFbKjGzXjr?=
 =?us-ascii?Q?bU2cAnquOIvdWmXTe57Em4UUdj1xXVN2SUoX0D7RSSHUFf6wqVWOvGeoOSTq?=
 =?us-ascii?Q?+02tGnfUpa+z3KZwbyLHiRXY/DxFQyeCNp2zG8iNv0Ol2sJGnDypOz/Z6EaZ?=
 =?us-ascii?Q?xqDye+yF3UgfePHRRirbHpGCGk7tPyD24S57+LMMAgdYUkjK1Dxy2O6YXH7T?=
 =?us-ascii?Q?YOg1IYK5g/vISfBfMJjGQPaMmXwM1Jnj8Ol3GGxbEEFSyk/FvJPHFALoh2h/?=
 =?us-ascii?Q?7cblY993syReBNL1Z3Ha7m8XGqT9fk/SEmFvuaospa/9w+dQthK7GWny88c1?=
 =?us-ascii?Q?Qp3Ao3qIAyXSEbwym8MumiOfKyIZVQuex65iOiCk8MKEsave99lLhVUapxQ2?=
 =?us-ascii?Q?8tRMoLAGChbo0YaQChPKtX1v/UVgm1LRur8BJiOfNVwJdUlrhhPKBJYqZhTX?=
 =?us-ascii?Q?jBOAxCERlp1wnsEQ53QnV5KqagOHVY4r8Ca0Z+2MUaH0VsBdbAD6G+2P1gnd?=
 =?us-ascii?Q?OjZAbqDUmknt6u8aTKoSy1bhv6VTy//zqyZ4BfM/kmY6cgG78kS1qV5blhPc?=
 =?us-ascii?Q?w88553St8cP4I03OHwoeJfBfqPYbqluAc9wVLevcuK72clP/47CvVNkqi7ds?=
 =?us-ascii?Q?E7QBXNwVCO+h6BwtIdDgsJD6luSSIG430FmpK9KaCt+Zp2WGePeCGos0kg9v?=
 =?us-ascii?Q?5En5Lr8aN0s3ggu28C0yq/KxpByllU+TCLkYT+SVgxd+AHVZu3vx+QcZ4ReE?=
 =?us-ascii?Q?Qnf4YaYW7E1aSvcpP1R3/Rnfw0M75PI4hH7oVhZiqhhy9py17DZHtF2BqfS1?=
 =?us-ascii?Q?gUAh45obF/4JGM1LvUqwpAQK+EwqfR6YEyYp3D7pPp1U6Pnu6ylZJdTsQKAQ?=
 =?us-ascii?Q?z7nOW/87gtSNouQhwQt/NycMww1gaVcwHEY5qoiLw/T8EqNH2DEzJpgv/2wj?=
 =?us-ascii?Q?AgxQCVbEdFD5qW5yqbwpKyiX8n/It3YfVytY7AXVYXL9VKEwxNjojXVy598d?=
 =?us-ascii?Q?UzTPGbqv+RetGb6KYVFhK+Fq7Azao95FhmCJKRd+f0sjSn2dmiWyWLGAbKRN?=
 =?us-ascii?Q?yYp3yeqxd4hoee/eLR4yCubUs3wNJO+AKNsFgFDDLh2c8TubgTuruqWh05wU?=
 =?us-ascii?Q?oSc1Fphf+o9ZGq9mW4HPqJ4w1lo0JueusU9/h+sZ8/MA4N+ze96CyjLHZ4Wv?=
 =?us-ascii?Q?TC9Q48a68z9HxzfPz8bqqrEReb4xCzfClRLzAXG2bDlYYSk2+t+KK5o3lu0J?=
 =?us-ascii?Q?PyADUPqzP+330DvdDP4aYM5RtJOSKDs78J6fUqedZw4KZ0VEK/Hyg9yhTjnC?=
 =?us-ascii?Q?9+UaZSlmzCb2nn5+kOs/ANF6sdmwgX4zL0vbESJZ625pAModeMVgq8RLadbP?=
 =?us-ascii?Q?UOGzhN4RtBNUDsV61X7Lmsmts3CawCr7ADMp8tCdlsGVH38tKXFZdGLXK1it?=
 =?us-ascii?Q?U7oEDRwph9+dr7uXOX0xV7t9AEfll9PRxcEc5SdUQmhqI/8ZQQpdF6mR7nm1?=
 =?us-ascii?Q?d0G4cGTOZAsqEhbioXTGQckBLnOb6YwgZrt09NpSHyY8lP262wcH38QvegWV?=
 =?us-ascii?Q?s6fb9s2om4Fms8K7P71zP6VAvfY8ordePpg7AizaRarT4bsWksp15MHt3+/U?=
 =?us-ascii?Q?mUxDt8Se2Qns7VHhdzw84Coj4cLLyrtU0AXyfhenzzi7AF/nW4cKb3LUd9oc?=
 =?us-ascii?Q?TmGFiAuokFMxbD86lYIvs0aLVAi6ot4bo9eheb6C+JfTBnb0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bcabfe-5e59-4925-dfd9-08df14281792
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:24:13.7180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVkhP5wtAGycOn9ztL+zdZKIVTbSRycQO8nKfMk3441TQO7eHmqtN6YfOjOtSG+LybMfvXpMgpAGSBa7HK3vdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=tdave@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is the firmware companion to the QEMU series [1], which validates
fixed BAR configuration and exports it to firmware through the
"etc/fixed-bars" fw_cfg file.

The existing IncompatiblePciDeviceSupportDxe driver is extended to read
the fw_cfg blob and supply fixed BAR addresses to PciBusDxe. The PciBusDxe
changes honor these addresses both when programming a BAR directly and
when sizing and programming the bridge windows above it, so a fixed BAR
behind one or more bridges is placed correctly and covered by the
appropriate bridge windows.

Testing:

The series was tested together with the QEMU companion patches on the
AArch64 virt machine across a range of PCIe topologies: emulated devices,
VFIO passthrough devices, PCIe switches, single and multiple fixed-BAR
endpoints under a shared root port, and fixed BARs behind nested bridges.

Changes since RFC v2:

- Integrate fixed-BAR handling into the existing
  IncompatiblePciDeviceSupportDxe driver instead of adding a new
  QemuFixedBarsDxe driver.
- Size and program PCI bridge windows for fixed BARs as part of
  PciBusDxe's own normal resource calculation and programming
  (CalculateResourceAperture()/ProgramPpbApperture()), instead of a
  separate post-enumeration reprogramming pass.

RFC v2:
https://lore.kernel.org/qemu-devel/20260827004530.600410-1-tdave@nvidia.com/

[1] QEMU companion series:
https://lore.kernel.org/qemu-arm/20260916185554.917526-1-tdave@nvidia.com/

A git branch with this series applied is available at:
https://github.com/tdavenvidia/edk2/tree/Upstream-fixed-bar-Sep-15-V1

The related QEMU change is available at:
https://github.com/tdavenvidia/upstream-qemu/tree/Upstream-fixed-bar-Sep-15-V1

Tushar Dave (3):
  MdeModulePkg/PciBusDxe: honor fixed BAR addresses from IncompatiblePci
  ArmVirtPkg,OvmfPkg: fold fixed BAR placement into IncompatiblePci
  MdeModulePkg/PciBusDxe: size and program bridge windows for fixed BARs

 ArmVirtPkg/ArmVirtQemu.dsc                    |   2 +
 ArmVirtPkg/ArmVirtQemuFvMain.fdf.inc          |   1 +
 MdeModulePkg/Bus/Pci/PciBusDxe/PciBus.h       |   2 +
 .../Bus/Pci/PciBusDxe/PciEnumeratorSupport.c  |  12 +
 .../Bus/Pci/PciBusDxe/PciResourceSupport.c    | 121 +++++
 .../Bus/Pci/PciBusDxe/PciResourceSupport.h    |   7 +
 .../FixedBars.c                               | 413 ++++++++++++++++++
 .../FixedBars.h                               |  63 +++
 .../IncompatiblePciDeviceSupport.c            | 114 +++--
 .../IncompatiblePciDeviceSupport.inf          |   8 +-
 10 files changed, 712 insertions(+), 31 deletions(-)
 create mode 100644 OvmfPkg/IncompatiblePciDeviceSupportDxe/FixedBars.c
 create mode 100644 OvmfPkg/IncompatiblePciDeviceSupportDxe/FixedBars.h

-- 
2.34.1


