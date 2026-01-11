Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0BCD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Xi-0006Fg-TF; Sun, 11 Jan 2026 14:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Xc-0006Ch-Kh; Sun, 11 Jan 2026 14:56:01 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1XZ-0003p9-UQ; Sun, 11 Jan 2026 14:55:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bADFa57v4db5bI7C8An3D8NQWtFc+tn+etMosQgD/Bml8gDYe2ZrohrARKrQb9SXaSnYAhvn2iMD+HkwGwQa6uf66KkooemYAbLqa0H7pu1tpEb2yzGhuTEdrQMt7uXbb3PfnnHB49G/WELToOpDtUMHqSYg3a1bOOxE/DX1E6qef+3DbwrGytxapX6NqefTh2vANszffCJsXw0bTI+ovTajR0K1gRM9ndVpPvJDRAgs/EcEEAlMbh2Wlqykq4pK4KzoRPVgc1OWwVqnN18SY4ycOVTbNv4Uka0PpYoui0ofHTv2WWKZT0SJfZKylhQRG42rsjPxzfZ05sVDF+8orQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEJyr06DUF8WuVWGsXPtNcjboCxqS82OTScVQCt4Ga0=;
 b=Q2b0rtyYZQlZ5q8saH2JqnjEwkYNSbxvQJB9fOhnslt+UvfQfmbfxe8jVooVK8iGIN9JAta+cyQ2cjRPs+FReRgF1oJ62A0AMIBZG8MaMAmo8v1yKqvCuW1Jof8tM+LBX24iBU9ZQiG8VjSGDZq5U47EtNtTx/PkGOOZvxTT9JFyrhJxUkX8m+CxYZ0nposfFc7ZJ1atLXBIe4JRXcdilRLsfHdYq1EfIWU/+dAIN6X2vE9fD7tPcQVpIZ+fpBKiXjscapOOAaL2b3+INiL0zRgOsVakItDYtIpNXZFzYPyL9y/yAWr5WldwCfMuYSd5tVLji7sPx0OfPA3PobjqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEJyr06DUF8WuVWGsXPtNcjboCxqS82OTScVQCt4Ga0=;
 b=eAg21jAr5SD82qUEPBZUeCiiT53FNrjCBZmXEYene1TG0Sc96Br9ZI1khg2NElYwx6IJ6lvNtNMzgikoGLV4ymCGxvPAJcNsjUGJEdsUQY5cKc+mEmIcBfQzLKEQGTtH8iMvMYBVPDnANc6O4QR7ap/SfnHUbxUTElKKbAqzBm6DwyGdFoz8W8TYapnI81yM0iKYcpdkfpSvbh2oPx88dM2kENXNe1z4FE8AxiPUIbvOSK2B1hDZvUMtPVPfd4h7kTOfXpGMx9KWTaW39iwcx4WPSZklbg4vjDi9Iv0HHElvwcm82pP/VF4Gmg9V7OZUQXdT2vy07HtRGEIvKI6nMQ==
Received: from PH0PR07CA0073.namprd07.prod.outlook.com (2603:10b6:510:f::18)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:55:48 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::4a) by PH0PR07CA0073.outlook.office365.com
 (2603:10b6:510:f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:55:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:55:37 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:55:33 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 00/36] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Date: Sun, 11 Jan 2026 19:52:46 +0000
Message-ID: <20260111195508.106943-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebc11a3-1fae-4c9b-0216-08de514b6a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnQwYWJIcHNOcUw5RnZkY0JWSjZaMjVlTXdVSUJka25lZ2g2SXdZQ3ZTRzk2?=
 =?utf-8?B?cTFseit6eG9Hb0hNMnI1cjNKZGtadThiOHdCZjJSRnFBRDBZT0dxS3p0YXpH?=
 =?utf-8?B?NTcxSVAwemhsNnNTK3hYbVJhN01ZSm9sUEg2L2F6dzVQMUw0VWVyT1ZQNlUv?=
 =?utf-8?B?dStObWVzaHBVbXJ4MnFWdGFLUGx6K3BzV2hCcDUrY2xRSjV5bUlhN1FJcnpN?=
 =?utf-8?B?THBIZlM4QnRuc01VeW5GU3ZuWkExd0pLSEYzR0lCU0UrcW94VnBaVDF1WUEy?=
 =?utf-8?B?UDQ3SUZQYUxRZldSR0lGdUFUc00raUdwVjNQU0JaMFFmOE9xYlgvV01RWWV5?=
 =?utf-8?B?Q3daRVVVaUxpcTAyOEpiOTlTYlA5VnNuUDVQeWIxMVY5dVZIQmJLT2Zydlc0?=
 =?utf-8?B?QUhpaE5DRjEveHhFdThWL1RGT21PdzY5VUZSQnpoTlI0ZzJ1dHZVSnZxYWxv?=
 =?utf-8?B?ck1mdFlTeENYeDU1allvMVFNb0dUQ2V0dFgzWmxxUkdmR0pZVlgzMitxTDlS?=
 =?utf-8?B?bXlWRDZzb2hVbEE1QThmSTdxWUhiZWl6RndOd2VjQWdweXBOZngzM3RmMUFu?=
 =?utf-8?B?YlBydHNpT2pER3BqbjZtQndxUHAwTHU2REJjdllQdmw5WTdMZ2pkMGo5MTRi?=
 =?utf-8?B?b0tTRW1jM3JFeHB5T1dCRkRNTkJWQUpTTEVnZTJBSjZucDByR1NvQlgyNzNU?=
 =?utf-8?B?VVE3M0hwSkVCeGdnYkc4T1MxdFFYRDU2VFdUODlIR0lTenNLR1RBekQ3YWtL?=
 =?utf-8?B?ODc1WWNVblVxRW5PSWNqajRoWXNwK2x5UVFOM3NyMHNPMjBFdGNBZlFsSklO?=
 =?utf-8?B?NFFQZXZpL1lzWE52a2dGT2piSEVPZjcwTjNIUWJWNGVLOHpMVThuUEZUTEhB?=
 =?utf-8?B?TVRlbGQ3OWNqR28ycXEwVXZyaWx0K3QrNlZoai9ITHJLTzZYUzZRazAraHVY?=
 =?utf-8?B?ejNUTXhKQ2ZxQ2JUdGgwRUxBMDA5QWtqcGl6ZExsQnNPWkJhMzRzNStvTFNy?=
 =?utf-8?B?ekI5UFNvbUl0L0xzS0VWUlBZRjllNFd0SHdSUGhiYS9ycE1hc3B5alN1Q2Zz?=
 =?utf-8?B?ZnprWjFxNkNEYjNTSWNLNGZCQ256RUE4c0IrV2ZvOXRsS1dzektmU1I0YXdP?=
 =?utf-8?B?dno1VFFWbTV3Y01lNHZYOWg0b0djU1lHTHlrNFc5cHlkSllQZ0dvK3hwb094?=
 =?utf-8?B?QUtZbTBLbGs4QjFHelU5YllBanBmUzF2N2Z0dmRtSmoxYXJ0TFpsL28vVTRS?=
 =?utf-8?B?OHdSRDlndGo4aGRHYzdBNVZHODRoN044VTBiZ0VlU3Q0T3d2NXc5TkMzVmhk?=
 =?utf-8?B?S21sOXBOalI3UFlkZlpCR3B3bkZPaXhYeVl2RS8reXRtU205UkU5ZG53eEpo?=
 =?utf-8?B?Qi9mMXh1bXBrcDZXelZNZzRVVWc5TzNILzEvOTRuSkVjTmxHcWRvMDh4bGQv?=
 =?utf-8?B?YnlZRjFxcm1VSkc1Tzd1bTN5U3NnS1BzZWlFOE5uMmFiZ1A5NE1sL0Mydlhq?=
 =?utf-8?B?V2sxNkNEZWk3Y1lMS0JORjYrRXhubE9xVjlVN0pNS2JwVEtjMGNoKzNFeTRW?=
 =?utf-8?B?WERjTGV5SkoyM0ZSYlM5UzhMZGJudi9uTWRIc0Z5VnEwbWtlaFlWc0RIYmda?=
 =?utf-8?B?azN6RUg4QmdrSEJuN0Y5WitXS21PY1J0ZTcvZ2R6L1dTSlUybmErUVBMNHEr?=
 =?utf-8?B?WXpjNUhHVW1LeTNYVHpodzVqdXhuNmt2MWR4dytGRks3ODhVeVU4bzBHOWEv?=
 =?utf-8?B?SC9vNXhjWGt2NFJPZzhJT1E5SmxFbVdQcnlpWnFBRklFR0I4dnJldmhZMlhS?=
 =?utf-8?B?UlJXcFhkVXZLd3kxaWNOOHpaOTVQTi9VZEJPSlU0ZjB2NEpzaTJkR2g0Rmtw?=
 =?utf-8?B?cjhHZWxmaUJzbDlGdmtMMDJrWk00a0dObUNLa1BKMFIxRFcwY2dRSXVHeklJ?=
 =?utf-8?B?TEhwUmZIelRBQnBUbmxVcFA2c1ExcVViTHdvWllyb1c2VXM2bUZZTWMycUxq?=
 =?utf-8?B?WTBKUS80WnRkeFNIV0hpVlVlcldvSkpZZzd5dEpXb21ON2Jod0VCSUhDdlRX?=
 =?utf-8?B?dERMdWZuU2pBYTl6cXFndGpJTzZXcFdJNXoxMWNGcGcxaFN2Z3pPY1ZlMEVF?=
 =?utf-8?Q?6Ww8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:55:47.9064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebc11a3-1fae-4c9b-0216-08de514b6a47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi,

Major changes since v6:
 https://lore.kernel.org/qemu-devel/20251120132213.56581-1-skolothumtho@nvidia.com/

 - Addressed feedback from v6 and picked up R-by tags. Thanks!
 - Fixed build and compilation issues reported on multiple architectures.
 - Reworked and introduced a HostIOMMUDeviceClass callback to retrieve
   pasid info(patch #32)
 - Added an helper to insert a CAP ID at an offset in PCIe config space
   (patch #33)
 - Added an x-vpasid-cap-offset property for vfio-pci devices to allow
   opt-in synthesis of the PASID capability (patch #35).
 - Renamed the pasid property to ssidsize (patch #36).
 - VFIO/IOMMUFD changes depend on Zhenzhong’s pass-through support series,
   patches 4/5/8 [0].

Patch organization:

1–27: Enable accelerated SMMUv3 with features aligned to the default QEMU
SMMUv3 implementation, including IORT RMR-based MSI support.

28–30: Add user-configurable options for RIL, ATS, and OAS features.

31–36: Add PASID support, including required VFIO changes.

Testing:
 Basic sanity testing was performed on an NVIDIA Grace platform with GPU
 device assignment. A CUDA test application was used to validate the SVA
 use case. Additional testing and feedback are welcome.

Eg: Qemu Cmd line:

qemu-system-aarch64 -machine virt,gic-version=3,highmem-mmio-size=2T \
-cpu host -smp cpus=4 -m size=16G,slots=2,maxmem=66G -nographic \
-bios QEMU_EFI.fd -object iommufd,id=iommufd0 -enable-kvm \
-object memory-backend-ram,size=8G,id=m0 \
-object memory-backend-ram,size=8G,id=m1 \
-numa node,memdev=m0,cpus=0-3,nodeid=0 -numa node,memdev=m1,nodeid=1 \
-numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 -numa node,nodeid=5 \
-numa node,nodeid=6 -numa node,nodeid=7 -numa node,nodeid=8 -numa node,nodeid=9 \
-device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0 \
-device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.0,accel=on,ats=on,ril=off,ssidsize=20,oas=48 \
-device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,pref64-reserve=512G,id=dev0 \
-device vfio-pci,host=0019:06:00.0,rombar=0,id=dev0,iommufd=iommufd0,bus=pcie.port1,x-vpasid-cap-offset=0xff8 \
-object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
...
-object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \
-device pxb-pcie,id=pcie.2,bus_nr=8,bus=pcie.0 \
-device arm-smmuv3,primary-bus=pcie.2,id=smmuv3.1,accel=on,ats=on,ril=off,ssidsize=20,oas=48 \
-device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=2,pref64-reserve=512G \
-device vfio-pci,host=0018:06:00.0,rombar=0,id=dev1,iommufd=iommufd0,bus=pcie.port2,x-vpasid-cap-offset=0xff8 \
-device virtio-blk-device,drive=fs \
-drive file=image.qcow2,index=0,media=disk,format=qcow2,if=none,id=fs \
-net none \
-nographic

A complete branch can be found here,
https://github.com/shamiali2008/qemu-master/tree/master-smmuv3-accel-v7-ext

Please take a look and let me know your feedback.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20260106061304.314546-1-zhenzhong.duan@intel.com/

Details from RFCv3 Cover letter:
-------------------------------
https://lore.kernel.org/qemu-devel/20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com/

This patch series introduces initial support for a user-creatable,
accelerated SMMUv3 device (-device arm-smmuv3,accel=on) in QEMU.

This is based on the user-creatable SMMUv3 device series [0].

Why this is needed:

On ARM, to enable vfio-pci pass-through devices in a VM, the host SMMUv3
must be set up in nested translation mode (Stage 1 + Stage 2), with
Stage 1 (S1) controlled by the guest and Stage 2 (S2) managed by the host.

This series introduces an optional accel property for the SMMUv3 device,
indicating that the guest will try to leverage host SMMUv3 features for
acceleration. By default, enabling accel configures the host SMMUv3 in
nested mode to support vfio-pci pass-through.

This new accelerated, user-creatable SMMUv3 device lets you:

 -Set up a VM with multiple SMMUv3s, each tied to a different physical SMMUv3
  on the host. Typically, you’d have multiple PCIe PXB root complexes in the
  VM (one per virtual NUMA node), and each of them can have its own SMMUv3.
  This setup mirrors the host's layout, where each NUMA node has its own
  SMMUv3, and helps build VMs that are more aligned with the host's NUMA
  topology.

 -The host–guest SMMUv3 association results in reduced invalidation broadcasts
  and lookups for devices behind different physical SMMUv3s.

 -Simplifies handling of host SMMUv3s with differing feature sets.

 -Lays the groundwork for additional capabilities like vCMDQ support.
-------------------------------

Eric Auger (2):
  hw/pci-host/gpex: Allow to generate preserve boot config DSM #5
  hw/arm/virt-acpi-build: Add IORT RMR regions to handle MSI nested
    binding

Nicolin Chen (3):
  backends/iommufd: Introduce iommufd_backend_alloc_vdev
  hw/arm/smmuv3-accel: Add set/unset_iommu_device callback
  hw/arm/smmuv3-accel: Add nested vSTE install/uninstall support

Shameer Kolothum (31):
  hw/arm/smmu-common: Factor out common helper functions and export
  hw/arm/smmu-common: Make iommu ops part of SMMUState
  hw/arm/smmuv3-accel: Introduce smmuv3 accel device
  hw/arm/smmuv3-accel: Initialize shared system address space
  hw/pci/pci: Move pci_init_bus_master() after adding device to bus
  hw/pci/pci: Add optional supports_address_space() callback
  hw/pci-bridge/pci_expander_bridge: Move TYPE_PXB_PCIE_DEV to header
  hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to vfio-pci endpoints
    with iommufd
  hw/arm/smmuv3: Implement get_viommu_cap() callback
  hw/arm/smmuv3: propagate smmuv3_cmdq_consume() errors to caller
  hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
  hw/pci/pci: Introduce a callback to retrieve the MSI doorbell GPA
    directly
  hw/arm/smmuv3-accel: Implement get_msi_direct_gpa callback
  hw/arm/virt: Set msi-gpa property
  hw/arm/smmuv3-accel: Add support to issue invalidation cmd to host
  hw/arm/smmuv3: Initialize ID registers early during realize()
  hw/arm/smmuv3-accel: Get host SMMUv3 hw info and validate
  hw/arm/virt: Set PCI preserve_config for accel SMMUv3
  tests/qtest/bios-tables-test: Prepare for IORT revison upgrade
  tests/qtest/bios-tables-test: Update IORT blobs after revision upgrade
  hw/arm/smmuv3: Block migration when accel is enabled
  hw/arm/smmuv3: Add accel property for SMMUv3 device
  hw/arm/smmuv3-accel: Add a property to specify RIL support
  hw/arm/smmuv3-accel: Add support for ATS
  hw/arm/smmuv3-accel: Add property to specify OAS bits
  backends/iommufd: Retrieve PASID width from
    iommufd_backend_get_device_info()
  backends/iommufd: Add get_pasid_info() callback
  hw/pci: Add helper to insert PCIe extended capability at a fixed
    offset
  hw/pci: Factor out common PASID capability initialization
  hw/vfio/pci: Synthesize PASID capability for vfio-pci devices
  hw/arm/smmuv3-accel: Make SubstreamID support configurable

 backends/iommufd.c                            |  50 +-
 backends/trace-events                         |   1 +
 hw/arm/Kconfig                                |   5 +
 hw/arm/meson.build                            |   3 +-
 hw/arm/smmu-common.c                          |  51 +-
 hw/arm/smmuv3-accel.c                         | 768 ++++++++++++++++++
 hw/arm/smmuv3-accel.h                         |  88 ++
 hw/arm/smmuv3-internal.h                      |  30 +-
 hw/arm/smmuv3.c                               | 227 +++++-
 hw/arm/trace-events                           |   6 +
 hw/arm/virt-acpi-build.c                      | 127 ++-
 hw/arm/virt.c                                 |  40 +-
 hw/pci-bridge/pci_expander_bridge.c           |   1 -
 hw/pci-host/gpex-acpi.c                       |  29 +-
 hw/pci/pci.c                                  |  43 +-
 hw/pci/pcie.c                                 |  77 +-
 hw/vfio/iommufd.c                             |   7 +-
 hw/vfio/pci.c                                 |  84 ++
 hw/vfio/pci.h                                 |   1 +
 include/hw/arm/smmu-common.h                  |   7 +
 include/hw/arm/smmuv3.h                       |  10 +
 include/hw/arm/virt.h                         |   1 +
 include/hw/core/iommu.h                       |   1 +
 include/hw/pci-host/gpex.h                    |   1 +
 include/hw/pci/pci.h                          |  36 +
 include/hw/pci/pci_bridge.h                   |   1 +
 include/hw/pci/pcie.h                         |   4 +
 include/system/host_iommu_device.h            |  18 +
 include/system/iommufd.h                      |  15 +-
 target/arm/kvm.c                              |  18 +-
 tests/data/acpi/aarch64/virt/IORT             | Bin 128 -> 128 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off     | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 364 -> 364 bytes
 .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
 34 files changed, 1650 insertions(+), 100 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 hw/arm/smmuv3-accel.h

-- 
2.43.0


