Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CF0C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicQC-00078Y-M5; Wed, 21 Jan 2026 12:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQA-00073Y-RO; Wed, 21 Jan 2026 12:55:10 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQ7-0000x5-NV; Wed, 21 Jan 2026 12:55:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3xCw20ZiqKCapu3CmKmrn+0Qx3TuTB3xRGkAxtRl7t8zVUBkcGSCM870nCRtEdAtjmBVV9nWkwAUTLQ18iPt7NlwSinkYFkCWm5d6FivoklHlm1DLsmNBeNZVgQKNAbO2krkCGit8NYT952oT9lnScUJmm0x6AnQnJaNI7WJGoX0mb5Z9Jcb9WrCPmT/uBYttE3pJav3CU1f51Fi1SlhE52ujk8XM5yrGmynTiLzcY/g0bUJHRdNBUh4jjZrhkW8YdVCnTF+aXmqmpRf5dAt8DJlG4DNDZcz5vokXzCD8mTICqA7nPVojY2FmrjohBK8mrl90gkeco0VjDagZtOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdrgAELl1vilW/RbGeCrwo7eTYghx13cd8PTi0C+Opk=;
 b=iwVEytpHLbGIZPtoLhrUqfGo6z4m9ArH/+mdMRV7RKzOIB6+1N+zlgWqxIpsyWczxX/qetiIx1hG5oI3CGI2LPiUpYywDfH1ASGqR6xUT5mwxpvPEPwJDIoIVSo9CHsl3OOScz9aa8dXITfwB3m5ylQlK9mznKMaBiR/w87F1ACEAGJ9CtuFJUW3R9NSeffoSQanaD+AtoGLWvKspKN3Q36pWp7v8+CaGFx0EgVrRA9oQ5HJlEZuXRXltJihgAVxEZ095t4mUrTT7yt3ZFJLZbwyv9X7f3pFwrtNHaCpC8DrREpWkjfwDAV34UZvwQLlbFRJ5XXCsYhqMfv5O2PuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdrgAELl1vilW/RbGeCrwo7eTYghx13cd8PTi0C+Opk=;
 b=mLTTI2ngTyPW7QyCFPwjILR+qgH5kag1ClrHma9GHi9fwEltPTC2g1nqvAvOpz4Rouc94TuCudo8x3PgtloJZhunoB02ubcBt0EwYwl0wHfj4Q/2hJhalk7Mz/kYng3iSGrEYvIQttsWwzEYnIncIVRTf3N9R+cEh1NRsVzKFRBGq5KdgcCeSvRDMi0hwtVU0QcYU5pQwx2yoxEfnZYTbYwMxRd4zIPLzRUQsa90e5LHS9TmE2+OClg3AEekc5/wTWzeksVM18OztOXvBxR3WXFQY6xlD4PIIX42plEWv9hSRpIAAde5fLAFDSZnk8QDvU0KuQncTSqY6vw41xFFkg==
Received: from BN1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:408:e2::8)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:54:59 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::ca) by BN1PR13CA0003.outlook.office365.com
 (2603:10b6:408:e2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 17:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:54:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:54:40 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:54:35 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Date: Wed, 21 Jan 2026 17:52:05 +0000
Message-ID: <20260121175248.87649-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 08078dca-8a1c-4ede-75b7-08de59163168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0sxVkZwNUhTRFBkVk1vWENiaFQyUkRjaFNTZzJqZnphandlVlNyLzJKTG9N?=
 =?utf-8?B?Nm0yQWZ3Z3ZKWWxaQ1NYbkNmUDN5UUttSm5pSXVtUlA0cVhYZEh2bDM0RWox?=
 =?utf-8?B?YXJtWWxPWUNtalFnUnE2UTc5ZmRGdmh2bUZOS08wSGphUkRKZWlSc1djYlBr?=
 =?utf-8?B?OUIyUThkUnpnSHd6UVZnZ2lsM3dYWlA1ZG9Nd3piRTh0a3pUcU0vZVBMaU0w?=
 =?utf-8?B?QStsN0V0NDRsZVlRcVB4S1pHMXZwNERYNmZXbG1qUzdLcDQ5aFRHUS9CQWti?=
 =?utf-8?B?NWd5bjBrSzF5eC9lbWNSM3MrekYycmt3TkYvSzVnMmxEc0hQMitZK28xdGs4?=
 =?utf-8?B?bVlrTlpmS0sweEFTNGNxQkwwZ0txUUJlZG4vU3JIdmpDQktka1pYeTdObElM?=
 =?utf-8?B?dVduMUw4Sm1PK25zckZveGRIanY0Vk1tRXYxbUtLUW9tRnloNGdoOFR5QldK?=
 =?utf-8?B?TEMvOWYwdGVSVmE2VW82Vm5qUytqMk0yNTdGWnJuSHZRdzliS0xINlVOU3dh?=
 =?utf-8?B?STQvb2tYL1dodjJJTU0wbG1taHlRREE4V09taHBBdGJoaU1XdkhhUkRIMnZ6?=
 =?utf-8?B?M0FxRTJRZHpUeFdBdC9XU1ZuNUlVYjB0ZmRZcHRYaHdGMm5MbkVOSDF6ZUpj?=
 =?utf-8?B?YkVpNDJ0UUQ0U0FDWm14Q2pCRHRFV1MxY0cySXBUbkFlbzZwU0ZnSVVxL3Bl?=
 =?utf-8?B?aFJyVHNnS1h5UisrWEhwaU9VZ1NhOGM4THd5K1lYcy9US25OS1VldmhNd1Ny?=
 =?utf-8?B?Wmh6cmVuMFVYWVpCNms1bFlGYmRnbTlwZUxBbklpaEVESVVVcS9yK1NOT05X?=
 =?utf-8?B?MHhXZ3lPbzFDVGU5aTREcXFiYzBtdkxmS0dJWlMwdXhXd0xuL00xd1htUDV4?=
 =?utf-8?B?YjA1Sk5hRVpRTjVMcmF2WDFyMlU3ekZFT3EyN1ppZ05hUTdKMzNKWnl4SGZD?=
 =?utf-8?B?WWJ1b3JEWTdsbGFISTJVSkNxY20xU3NodjJlSG9wMmYrWk96ekM1NHd4TUox?=
 =?utf-8?B?K0VPWUlXMTNZa2I1eHBLMDZPUTFHQ0FEb09ZZldyZm1zNXlIZjhyczdTa3RZ?=
 =?utf-8?B?WGYzWXk5ZzExbG1hOGwzMk5XWUEvVVVIeWRYSXVLUG54WWJHZ2Nndm0vaG9I?=
 =?utf-8?B?VWcrcUZML3FWYW5sc3ZTd2NpeVdGZ3FadE1MRWU2dEhZRzhJT2dCUFhyTDlQ?=
 =?utf-8?B?bkh2Y1dGT2pDc0NybXRyeG1qak5QTlQ3LytMQ2dpVnk1OXUxT1RaMUNwUlo3?=
 =?utf-8?B?TzhTZjlTRGRNa3Jnd29LdFpGU2g1QVBVRWlYU0RpM1JaOXNwVGVQZ0wyWEd5?=
 =?utf-8?B?ODJCQk5yYm5sNkNqM081TDB5MTc5ZWNnZmNsejEyVjZ1KzU3a1huQklJblVk?=
 =?utf-8?B?bDk2VjBWZEloSmh5YXBiUWJGY1BMZVRhZUZRei9oQkdtOUI2YmE4OEVZd1Zy?=
 =?utf-8?B?ckhtRWtlVW5wYzViNkdlM25KOWZoU1Fta0lnTzYzeDhNWlVwbVRqUlVscFV1?=
 =?utf-8?B?U3JYa2JDdzUzNlMwczAxSThRWlVqRm9TWk5jcmpJSSs3SGVwTDdQV3djOWtI?=
 =?utf-8?B?eTdiQWN6d2VrdndiZEVaMDFpWml3KzgxRkVudVIwTnhyczVoWWtVS0IzQlhz?=
 =?utf-8?B?TWk1L3hOTEdTU1Z6aTJrU0J6MktyelYrRVRZVmZpNW1EcVVYWjgyMWZWT2ll?=
 =?utf-8?B?SXNaSXU2YUxWcnQvcmhXdEtWdkp4NDRyOHdkZk0zOGZKd241dDFEaXVGVWFW?=
 =?utf-8?B?ZVpPcVJnV3g5c3Y5OFU1eEVnWGgxcms3Q2ZBUTlKN1VWS1piVDczMUdKVUxI?=
 =?utf-8?B?aFZKWXBMaXhYMTczd3lxYU5BaEdWQ0Y0NnFMNm1SbGJnNHZlZ1c3c3ArNVJ6?=
 =?utf-8?B?MDZESXlPU1N5SG9HeDAydkJPdWkvVXdqZUdPOWN6U3FXdUlaaDdEMDhlSmhM?=
 =?utf-8?B?OVNzdlRSS2ZaTHdUc0RrdHNldVdwLy90SVk2VVZLUDdna0h4SHBrTFUwNmpT?=
 =?utf-8?B?K2pGVUFhdStNUVUyWnFUNHpzTFJkL1ZJWVRqaWh5aW1hQ3dvMHpxYjR6Ukh3?=
 =?utf-8?B?eWhzc3d0TzZqN1BRVFM3dVliSk15QWxWY2ExSmEzWjR5N1pLWWsyeTdNSGxw?=
 =?utf-8?B?M2NhdjRIZWV1ZkRtT3JyK2I5ejdMalc5Vm91aDBLL0M4TndwaGZVK3NJVDJF?=
 =?utf-8?B?M1I5YTJpb0kzSC9PVUxkekN3L3BleHRzalRkb29pNGc1Um1sVVJ1ekYrOXJw?=
 =?utf-8?Q?mJGXUcvGqz1oalrGHkfmE4YndygzNFJyq1rBhDQyn8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:54:58.5114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08078dca-8a1c-4ede-75b7-08de59163168
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi,

Changes since v7:
 https://lore.kernel.org/qemu-devel/20260111195508.106943-1-skolothumtho@nvidia.com/
 -Addressed comments and collected R-by and T-by tags. Thanks!.
 -Rebased to latest master.
 -Reworked PASID support patches (patch #34, #36).

I think this series is in good shape now and mature enough for inclusion.

Patch organization:

1–28: Enable accelerated SMMUv3 with features aligned to the default QEMU
SMMUv3 implementation, including IORT RMR-based MSI support.

29–31: Add user-configurable options for RIL, ATS, and OAS features.

32–37: Add PASID support, including required VFIO changes.

Please take a look and let me know your feedback.

Thanks,
Shameer

A complete branch can be found here,
https://github.com/shamiali2008/qemu-master/tree/master-smmuv3-accel-v8-dmabuf-v4

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

Nicolin Chen (4):
  backends/iommufd: Introduce iommufd_backend_alloc_viommu
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

 backends/iommufd.c                            |  76 +-
 backends/trace-events                         |   2 +
 hw/arm/Kconfig                                |   5 +
 hw/arm/meson.build                            |   3 +-
 hw/arm/smmu-common.c                          |  51 +-
 hw/arm/smmuv3-accel.c                         | 768 ++++++++++++++++++
 hw/arm/smmuv3-accel.h                         |  88 ++
 hw/arm/smmuv3-internal.h                      |   1 +
 hw/arm/smmuv3.c                               | 227 +++++-
 hw/arm/trace-events                           |   6 +
 hw/arm/virt-acpi-build.c                      | 127 ++-
 hw/arm/virt.c                                 |  39 +-
 hw/pci-bridge/pci_expander_bridge.c           |   1 -
 hw/pci-host/gpex-acpi.c                       |  29 +-
 hw/pci/pci.c                                  |  43 +-
 hw/pci/pcie.c                                 |  88 +-
 hw/vfio/iommufd.c                             |   6 +-
 hw/vfio/pci.c                                 |  75 ++
 hw/vfio/pci.h                                 |   1 +
 hw/vfio/trace-events                          |   1 +
 include/hw/arm/smmu-common.h                  |   7 +
 include/hw/arm/smmuv3-common.h                |  27 +-
 include/hw/arm/smmuv3.h                       |  10 +
 include/hw/arm/virt.h                         |   1 +
 include/hw/core/iommu.h                       |   1 +
 include/hw/pci-host/gpex.h                    |   1 +
 include/hw/pci/pci.h                          |  36 +
 include/hw/pci/pci_bridge.h                   |   1 +
 include/hw/pci/pcie.h                         |   4 +
 include/system/host_iommu_device.h            |  20 +
 include/system/iommufd.h                      |  29 +-
 target/arm/kvm.c                              |  18 +-
 tests/data/acpi/aarch64/virt/IORT             | Bin 128 -> 128 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off     | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 364 -> 364 bytes
 .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
 36 files changed, 1692 insertions(+), 100 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 hw/arm/smmuv3-accel.h

-- 
2.43.0


