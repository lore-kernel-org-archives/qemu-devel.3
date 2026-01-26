Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABA5CF65DD
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK5U-0006xh-Uv; Mon, 26 Jan 2026 05:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5S-0006wE-Io; Mon, 26 Jan 2026 05:44:51 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5Q-0005If-7x; Mon, 26 Jan 2026 05:44:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5BBgFjHbUWVAgBRX1GOTqK11RQ9uTpyUIhabgAUNADjRmZnIswSkvd/xmKMSs67A4APrzIGgwG7d7KoN6AKz1rt3ck7AuVR4urrvUExmsfHSdQybHyc2T2Xn0puQnndzwyLU3oTxtotkV+LCnoc6a7AKZ7KTmUv8VsRHnO+UVrMhlgp51dA2B6NvFzkpYnqGu90NpR+TWIfU99ykn4bxfMKDhkycHH9vpzTeycanvDVfTuP4zri84kn3QyWLndpBehh3fGzHS3r6PPZzj/hiCYsBSMu8iYcQt6LjgZyib+PV9dOfyrAAdiG1kBi/z1Pt4WRWh8gMLWf5jVjXzIMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/0akEZ49m88dRnT+CV7VJ+LLk0q346D2AoTgIccDwI=;
 b=RNwm+frugg6JFx4QeSQOCU4Qkb7E7RXVFey9gTofbIcGS43Pz7uFzN3DBIF/EC4my5zw99ueO3xaV7HnA7gyGFYWd6Wq+OckbnLqh+YmwgmIUT4rCvTBse2972ZByUNLAc8TBtTqwXBTYLKtYUWeG/gp+5WhcLJqgfBgtmfA6TgTQgFeVvM89RG0ThhcZ3sNAptBuAyFqpC8HgYdNWR91lOz7XnOnRzlFxhpKUxklRrWUiEOmPSesgMonQCJbvmPOUPVuG3WraAuU8ayI4WvqbZPzbFgsyvaGVRvrmToVxukk+I9tPuqpRhwd1NQZIzNEhxa4AJa1iHnvadCyMBV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/0akEZ49m88dRnT+CV7VJ+LLk0q346D2AoTgIccDwI=;
 b=YcUhG4T2loRGCZrLqZC0SAGOY6Vne4kX8sWjdn23pvsfuPyMi8RODcazpqkDS6mULq/8t7zf8vfhOxHmHkU0JhL5Veg/eupUCEazMGZqMMNx+y7yItD5zpXXu+NypO/IlpZy31OXTAEtNV9qDlh2fJ3PIRXe9yweLW5LxPf8j6KjY/CsH43Bo9isGeSIiePoSS21qRtffvs1yIc/CQQFF/ySUoJQRE1ROXwiZh1dA5nVuYl9eRBE+nA7/6YEUZAdCJBoxpj9aktLbkGLTdfSACKiEvIFfKmE3wQi5DYq2wSj9B4mAjSyf/q/PCyAgEuZowRypI9Iqoe101xQk+brqQ==
Received: from BL0PR01CA0002.prod.exchangelabs.com (2603:10b6:208:71::15) by
 CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 10:44:40 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::2e) by BL0PR01CA0002.outlook.office365.com
 (2603:10b6:208:71::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:44:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:23 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:19 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Date: Mon, 26 Jan 2026 10:42:57 +0000
Message-ID: <20260126104342.253965-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: 37dbde0c-677d-44f2-ea64-08de5cc7e8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXl2Wkp6YkYxUUUya3ZpN3BiVzNZT2xvSVJ5cVd1b2ZzcHpFL0hCcVlCMWdw?=
 =?utf-8?B?Y2FQMER1K2FwR3R4OUpMS3liTThPOFRXWHlNV05BYkIwQUx5UEFuSno0QXlV?=
 =?utf-8?B?aTF4ZklrSDdsYTg3ZEhqcUpvWFRpZkVrZXZhMCttZHBHM1QweUgrczQ3ZXRx?=
 =?utf-8?B?ZW1IbEpMRkx1RFJ1OEtpWG12VUpxdEpuc3BJeXU1Q0V2cm5hejhBM1hhWUh2?=
 =?utf-8?B?blRDOFlONFdTVWY1Ni94Yzl4VHdjeVozbWZjRzFkUU9uMHQyYnZZcWNlVHlF?=
 =?utf-8?B?OFJTR3llNllaenFjV2lpUlQ3QXVZOGQ4TS9XQVFUTmhzWkpZd0Vvd0JiS1F2?=
 =?utf-8?B?Z1FFbXVBVDd3TVdKNDZLZm45MTI3dkFRUk9KRzIwaGNvcmJkd0dGOXArN2Na?=
 =?utf-8?B?NmQ3Rjh2RStsNVdiR0laNzVTN1BtNDlFOWkwZnZ5cldMSjNpcS9wN2MwVFhQ?=
 =?utf-8?B?VzZjUjFIWituV0U3dnFTcDk0b1FuWWxydkJHTlQxejhjZVoyUFkyNjVEUFd1?=
 =?utf-8?B?SlhVUkhDVVQ4MFFYQlg1SGMxb2lsZ2YyaFNGRmpZQmtKTTNsTi9JRlhzSUdX?=
 =?utf-8?B?dDVGcTQvUGp4K3NIU24xZWJjd0VycTdQSGdlUUQ5M0FaNDF2SHE5SmZtb2Np?=
 =?utf-8?B?ZFVCZGRKK1JVWTRXajdiWmlzYzFDaHVqWThVT2R0ZjN3R2NwRUVxNlVKdDJ2?=
 =?utf-8?B?NXN6RjVQUmc2YkRkdlg2cjZXdFg1TXNFN3FIRysyL2FFeHRsMTUyMm5Ea3J0?=
 =?utf-8?B?aS94R05FZkYvYklBZEp6amN0U3BwdU5zekd5QVY1Qm1vbjVGenZaLzVnZHQz?=
 =?utf-8?B?aUQ4YU1KVWczTFNSaVFIbHBhRm1IUDFrQzAvMjRVUDFNSVdZWkZxTFpIb25Q?=
 =?utf-8?B?OTZhNnUzaEVRSjJaSERWT2hEaXFMMmtEbGI5aURDTmJBR1VYTVNGU3ZDenFt?=
 =?utf-8?B?SlhaUlFGK0t6c2krZ1ZDRUxvZWtucXZ0Slg1NmZTeWJyREhGUTFOc3d5YkJO?=
 =?utf-8?B?QlV6S0FUSnBXN1BDQ0NidkFwRnh4Mm5lK1ZtYWpDZDhWUVUza3hwRDJMaU9I?=
 =?utf-8?B?ODdPMGhPdDAzUDBkU244TkxqbTF6QmJlSUx3UlhrTTh0VkpVYlV3TFdRT1Ew?=
 =?utf-8?B?YitoV3dvNXVsZTdyUTdSTitBanhtcHlaZklpVm9kZ0NKWCt5SVZDOFJRYmhv?=
 =?utf-8?B?QmQ2Q0NhUWpSRGk0K0ZQQldSN1RDOFJxM0pvNkpyakNzMS9yaVpBckRqbUo2?=
 =?utf-8?B?dkRpMkdZOHM4T0tOSmwycWxTcHFNVG02d1kxMXZoYXEvSHNtdVI1Rk9IZk5O?=
 =?utf-8?B?ZWVNL0lxeU1QWi81N2FEcm5oMHpEV1ZHMk9hNXY0dE9POWI4dVhIK1pQd0s1?=
 =?utf-8?B?dmpwZ3k4R2JjK3lsdnJ2cFViWjlXencyU003eUlrcW4rMDNJb1pVS3U2NHdt?=
 =?utf-8?B?SHR5SHV6dkR4KzRCcnBpaHhBVExjbUd2WTkxOC9LV1lPUnRTMWRVV29KSTJl?=
 =?utf-8?B?enN1aXVLd2U4NHhoanlhRS9PNVNCb0pMMTdvY0RSYmdtMU1KalgyRThocEJj?=
 =?utf-8?B?c083T0xraWM3Ui83cjNoUkh4TTdPK1o2amg4L3NKYUN6b0lzaGZZVnl4YXdK?=
 =?utf-8?B?dUFEVGhGMjhOdWRnL1JSU2VjU1NRSTNKKzRIZEI1Zi9JRTU4M1NIemhKK0hw?=
 =?utf-8?B?YUF0NWFEQmphTXpUcE5QSVowMk90TFFPanRFUHlPbXBsWEI1T200bG8vZGNW?=
 =?utf-8?B?dUlENFNsZmM3TkhRcHBVb3BJK0FBK1FNdjRUejF2eERVN0pUSzZldEY2Vy9n?=
 =?utf-8?B?OGRpYjRSQ3I0d1UzS21KUDgzaE92UXVwZVRkUG95RTFUVlVoSkY0MnBUa3lF?=
 =?utf-8?B?Qm1XblBTK2hiSUZrODNwYWZWSUl1Zk54K0pzRnBqMlVmS1AzOWdLbWdGREI0?=
 =?utf-8?B?MXFqV2VzeUpFUXA4RDRETG0wdjZ1dnRWVGZSVUFRNkNrRU52VXBKTW56WDU3?=
 =?utf-8?B?Z004NHFpMlkwUE03TWxJVUJKZG40cDZxRUozZG5QRHp5YmFNUUp3WnExSk5r?=
 =?utf-8?B?MkhBbmQ2RlR4LzFlTkNOeWRteEx3STZnQllyWGtLWlBEc3p5UnlZemZpbTBn?=
 =?utf-8?B?dTRHNzFYQ3VqM2JZcTZ1YmNEMVpxaXVoaUlhNEtUcEVYa0JIMnZHMEpFZFJG?=
 =?utf-8?B?cjZqd2Q0NHYrNWFDdDgxd2R2MnBpRDQ4dEdwdVZLRHFHWFhycFprcU5pdEFX?=
 =?utf-8?B?SmRUMHo1S1hJWXg2RVUzWnFmd2l3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:44:40.3915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dbde0c-677d-44f2-ea64-08de5cc7e8b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Changes from v8:
 https://lore.kernel.org/qemu-devel/20260121175248.87649-1-skolothumtho@nvidia.com/
 - Collected R-b tags. Thanks!.
 - Initialise the AcpiIortSMMUv3Dev struct(patch #25) to fix the reported
   CI test failure[0]. Please find the latest CI run results here[1].

Patch organization:

1–28: Enable accelerated SMMUv3 with features aligned to the default QEMU
SMMUv3 implementation, including IORT RMR-based MSI support.

29–31: Add user-configurable options for RIL, ATS, and OAS features.

32–37: Add PASID support, including required VFIO changes.

A complete branch can be found here,
https://github.com/shamiali2008/qemu-master/tree/master-smmuv3-accel-v9-dmabuf-v4

Please take a look and let me know your feedback.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/CAFEAcA_8Zd1_C+94wj2c+pJk3ebFT5_Zgt1Ww0qxzFqW=F98xA@mail.gmail.com/
[1] https://gitlab.com/shamiali2008/qemu/-/pipelines/2286045925

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
 hw/arm/virt-acpi-build.c                      | 131 ++-
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
 36 files changed, 1694 insertions(+), 102 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 hw/arm/smmuv3-accel.h

-- 
2.43.0


