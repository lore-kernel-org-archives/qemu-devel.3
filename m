Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98509D3C907
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKP7-0007JN-VE; Wed, 10 Dec 2025 08:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKOw-0007I4-4C; Wed, 10 Dec 2025 08:38:42 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKOt-0001Fw-It; Wed, 10 Dec 2025 08:38:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olH9DrZSW8vWuguupjj+OVO85WmA8laWLklW9i+Hz7XxKd9FmczLkJ3v/V/TCyWCUcXFwqwkdJQ5BEgi/WEdwLqEj7n0LjjUIZMVpTTywPz57la4r+7pb3yhTTPWU5VIQ5mSfClJ8Yb6r0y0W8+5P8N8OqfD4Vz6bbSNX08vxZOxdPuK0P9SonkI+83410tabJzVYhK+isCGiAedjtR3xpHjTzBV+8h9Y/I7szNSqK0uLcOOSIxCPRdSi5yWrRr6s84MQcZ9P3rcc4+U+jpGODNeAAAsDQEVK0xdNIX3uQaQpy51D+OZxpbnF5+yaFptVAvQgS79JuxDbwMNWheEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIwNLI4bu3RpPqtD22XbFCdU6ERaWyhqAokdi1Q48DM=;
 b=s/hVbThUdk8DlKUCMg5dCzk+wO07NYAz0RhXmpLyUKysweoJjCgABna30BTGeQRLpcvQB4ODaJf79LHc5WwY8rq3VEdTrl3VFxKKr1YU8JIm99ZCfkU8aImrQjSyl+Sz2DtfswpeXyTeW3UMEagM2UhIhJ+blybgQ9RkqnHuPhUEIiIaR0Nlk6O0O48nHZDcs3CwiI3BYptNfzPsEGt9r9lmUHMoyeNAV+U7hY590+GgeswTpmkTjA10UsZYCAkzKQ+ukxWOvucUSWAs3Bo5d+yzHfFUirk+Q2QHPeFXZvyHtwzHsyw5uzev2Y81xCMzGDkemBqSOisfyHsRTWYWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIwNLI4bu3RpPqtD22XbFCdU6ERaWyhqAokdi1Q48DM=;
 b=hUGeD6aS1GicjdtLOTjedzRQUxIBWNw3CN2oTv+7fED4eYxHhZGy2VeYZhnvSgUNd2Yr61rMBpofHxHIFcA36wmThV8i5/d+/uxT4vq37S2jbKKuX3J9VRyJ+v04SNwoCAuSIuXlpQ3lXd2syHKr5F42If84OfA5PlTh9taaN7fd8LPTD0/Y5hLPQPDdfSB9cQ2iXL4UmzBnSeyafzW86VSWAFfgttvbuIROD8WGS6dW+8Ql/C/B6ka6DaV3L28poBrsPgdoDgDm/LlkCZLaxhgwYDKiBvqmd5vIXgGlEYymDGJAlBpELu4GrNXVCMnLKp+TYzAhaziVgRsDHoszpA==
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 13:38:29 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::c5) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Wed,
 10 Dec 2025 13:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 13:38:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:12 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:10 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 00/16] hw/arm: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3 
Date: Wed, 10 Dec 2025 13:37:21 +0000
Message-ID: <20251210133737.78257-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1fdbee-4356-4ddd-9a38-08de37f16700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFR3Yk10MEo5Y3ZEWFB4aG44RFRVNjd5V2xVYUVCUk5MdXovUGhzSkM3cVVO?=
 =?utf-8?B?VDBORmNLelFncmVJMDRLVEFXdmlxd25PQzlMNDRQRXdweHFJdEs5NzIvY1ZW?=
 =?utf-8?B?WjFWOFJTYXJjSzB2LzF0R2lJZm4wKzZxV3NvcFl1VDJhRFpEcFZTUjVuVUpy?=
 =?utf-8?B?aWV4QzI1UHpNNnExQjNwL2UyTXB3UTE0ZkJsSHdaVGZMNlNNZ0dldk1nUTlK?=
 =?utf-8?B?enRJZTVCcjJEbE9nc2JIQ2JISCtkSEtJMTZpNXluamF5SWU1RllQSTFjMnMx?=
 =?utf-8?B?TllPN01PMjIzRnRqWUllWHM0Q2UrN0ZzalU2djNRd3crRGFqT01NZ1ZsY0dz?=
 =?utf-8?B?Z2JHR1d1RmM2ZXlaVzNOdklEYm9ZdzZsenFQK25NczBxbnBWNDY3aVBxWnpn?=
 =?utf-8?B?bU8yOWFMQk8xajJTd09lWlc3RjFnbUw5QnhhbVNSL2Q0ZXZHZUIraFhxbnhC?=
 =?utf-8?B?djl2SzJ6YlJDcWIvMVduZ0FXSERJQTNWOGgyWFpsMjlwUk5ER21TQkd6Zml5?=
 =?utf-8?B?VHdSQXhmTFV2MnhpVVYrWVl4Ym9HZytUYmgzWE05eGZrcjJVQjhzTWpJNG9k?=
 =?utf-8?B?QkJDMG54bitMNWZ0a25ZWlZqR2pwN0RTTGQreHM0N08vWUNXbWFTRUV4TlhD?=
 =?utf-8?B?bUFQT29vRitqRGllQXV0RDBMd1h3dC9WR0N5dTNhbEwwVkdlTExGdmFLWVJ0?=
 =?utf-8?B?ZDVrb3pSSFZLUUlHN2NBamhaYTZoc2V0V3ZYMmd3OEV5MVAyM2c5aHg2TEdj?=
 =?utf-8?B?enJSWXlFbS9IaXJKOGx1M21oaiswbnNCS2laWHZjZmpZZmQ0UDRYMitaTzRw?=
 =?utf-8?B?Q2dDSnZIWnRrSnFvNlBlSmFSVU93NUhxVU1Yb1UvT1R5UTZIdFU0TTJYSHlv?=
 =?utf-8?B?MzI2U0V3K0IyMlRQV2lLbjFCRVRFU05vczB0aFpwZjBGcXExditCMFN4UjN3?=
 =?utf-8?B?UThHSVF5SFVBaFBMYnF0WDBFLzFEMFFQemVsdVlnUExnK0QxeGhwYS9OM291?=
 =?utf-8?B?c3R4V2ZnYzJ5K202cjJZWmMzeGdOb0NRQnZjTWdHTjl5WmFtYXg4aUY2dm1D?=
 =?utf-8?B?am0zUzI3K3cvT2RLT2tsb25UUUJGZmt4dEZWM241NmtKQlBydFVrNXZ5SnNx?=
 =?utf-8?B?aHc2dzI1OHNKaVM0T2t5eENpcVphR0dlaU5iWjFlK3JGSDFGOEQ3eTRGYld2?=
 =?utf-8?B?T0hBdFFuNFliYzZOVm1QdkpuRzlKbSszdWNPQ3dBY3pZQytyR0w4c1NKNXJR?=
 =?utf-8?B?UE5MUVp2ZUMya0NjdHUxT0ZWY08yb3pocXlWcnloM3NRajNvUDYzMUtodW12?=
 =?utf-8?B?bUhFL1dIM1NJOWtHRzFCNzJTUHB2TitSUDVnTTNhSVVzQmdzVVVmZE45dnc4?=
 =?utf-8?B?eStPMUJxaHIxNVdxdnFwNitSVG5XWXMrOVpYVzhWUmNqRjRvOTQySjNnVWJ0?=
 =?utf-8?B?ZW15VkQvV1BsQU1jaXgxVkRVYW43WHFaYVdWMlR1U3JiUVdwR2tCcm5CL2Fa?=
 =?utf-8?B?K1JiYTlzeGxiODF2VXVYK3M2SDluSVFXdjBZN3J5ZFI1U3M5U1pxbUZTSE9m?=
 =?utf-8?B?UFhvM2NLa1RvKy9xTjBmZ3gzL1FRdzdaREFmL3RoejZ6eFpxd3M0Yy9TSjl2?=
 =?utf-8?B?ZEpkSHVIRGk4YnBWZi9hVmJhaXN3MkUyTG03ZWIwVE11VHczQzJ4a05kNUto?=
 =?utf-8?B?TWRKekxlYUtRWHpZNzRXS3B3Mk52RHJTck9YaGUxRW1vMXVWRFZIQWlpWUtx?=
 =?utf-8?B?WDd4V3czREFLc3NnYk94RHRCZ0g1ZFZ2WWZBOXppakhQK3VJNUdOQWJ0aUFx?=
 =?utf-8?B?UXFsVS9qbVRSbzArUlp3UXorc1BLRGVhVmttbU1RU3pXUVMyc3dBMFpXaThC?=
 =?utf-8?B?SEswaHdFaFR6L09zeXdqSXRyVGp0WFozUW1yZm4xYVd1aGVCbGZBSk82Vkpn?=
 =?utf-8?B?RHNzVE01R0IzV09RUHY0ekExdVBqRHBNSDYyODZQWFZ2c1BQU01NMm5RazBw?=
 =?utf-8?B?ZjJrZTNYekx4OWdxb1hnWmtXVnlWZHRxckRiTzFrRmw4U09hYWlqNnpjY3dq?=
 =?utf-8?B?d1VjNld0WUsyZHpDSEY3czd4YkdXVGcwSE9BSEwwekE4ZmpvQXE3REhJT2Zr?=
 =?utf-8?Q?2Vs9nX0tI4YM4jkmMKrb6ESN+?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:38:28.6453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1fdbee-4356-4ddd-9a38-08de37f16700
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
Received-SPF: softfail client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi,

This RFC series adds initial support for NVIDIA Tegra241 CMDQV
(Command Queue Virtualisation), an extension to ARM SMMUv3 that
provides hardware accelerated virtual command queues (VCMDQs) for
guests. CMDQV allows guests to issue SMMU invalidation commands
directly to hardware without VM exits, significantly reducing TLBI
overhead.

Thanks to Nicolin for the initial patches and testing on which this RFC
is based.

This is based on v6[0] of the SMMUv3 accel series, which is still under
review, though nearing convergence.  This is sent as an RFC, with the goal
of gathering early feedback on the CMDQV design and its integration with
the SMMUv3 acceleration path.

Background:

Tegra241 CMDQV extends SMMUv3 by allocating per-VM "virtual interfaces"
(VINTFs), each hosting up to 128 VCMDQs.

Each VINTF exposes two 64KB MMIO pages:
 - Page0 – guest owned control and status registers (directly mapped
           into the VM)
 - Page1 – queue configuration registers (trapped/emulated by QEMU)

Unlike the standard SMMU CMDQ, a guest owned Tegra241 VCMDQ does not
support the full command set. Only a subset, primarily invalidation
related commands, is accepted by the CMDQV hardware. For this reason,
a distinct CMDQV device must be exposed to the guest, and the guest OS
must include a Tegra241 CMDQV aware driver to take advantage of the
hardware acceleration.

VCMDQ support is integrated via the IOMMU_HW_QUEUE_ALLOC mechanism,
allowing QEMU to attach guest configured VCMDQ buffers to the
underlying CMDQV hardware through IOMMUFD. The Linux kernel already
supports the full CMDQV virtualisation model via IOMMUFD[0].

Summary of QEMU changes:

 - Integrated into the existing SMMUv3 accel path via a
   "tegra241-cmdqv" property.
 - Support for allocating vIOMMU objects of type
   IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.
 - Mapping and emulation of the CMDQV MMIO register layout.
 - VCMDQ/VINTF read/write handling and queue allocation using IOMMUFD
   APIs.
 - Reset and initialisation hooks, including checks for at least one
   cold-plugged device.
 - CMDQV hardware reads guest queue memory using host physical addresses
   provided through IOMMUFD, which requires that the VCMDQ buffer be
   physically contiguous not only in guest PA space but also in host
   PA space. When Tegra241 CMDQV is enabled, QEMU must therefore only
   expose a CMDQV size that the host can reliably back with contiguous
   physical memory. Because of this constraint, it is suggested to use
   huge pages to back the guest RAM.
 - ACPI DSDT node generation for CMDQV devices on the virt machine.

These patches have been sanity tested on NVIDIA Grace platforms.

ToDo / revisit:
 - Prevent hot-unplug of the last device associated with vIOMMU as
   this might allow associating a different host SMMU/CMDQV.
 - Locking requirements around error event propagation.

Feedback and testing are very welcome.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20251120132213.56581-1-skolothumtho@nvidia.com/
[1] https://lore.kernel.org/all/cover.1752126748.git.nicolinc@nvidia.com/

Nicolin Chen (12):
  backends/iommufd: Update iommufd_backend_get_device_info
  backends/iommufd: Update iommufd_backend_alloc_viommu to allow user
    ptr
  backends/iommufd: Introduce iommufd_backend_alloc_hw_queue
  backends/iommufd: Introduce iommufd_backend_viommu_mmap
  hw/arm/tegra241-cmdqv: Add initial Tegra241 CMDQ-Virtualisation
    support
  hw/arm/tegra241-cmdqv: Map VINTF Page0 into guest
  hw/arm/tegra241-cmdqv: Add read emulation support for registers
  system/physmem: Add helper to check whether a guest PA maps to RAM
  hw/arm/tegra241-cmdqv:: Add write emulation for registers
  hw/arm/tegra241-cmdqv: Add reset handler
  hw/arm/tegra241-cmdqv: Limit queue size based on backend page size
  hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in DSDT

Shameer Kolothum (4):
  hw/arm/tegra241-cmdqv: Allocate vEVENTQ object
  hw/arm/tegra241-cmdqv: Read and propagate Tegra241 CMDQV errors
  virt-acpi-build: Rename AcpiIortSMMUv3Dev to AcpiSMMUv3Dev
  hw/arm/smmuv3: Add tegra241-cmdqv property for SMMUv3 device

 backends/iommufd.c        |  65 ++++
 backends/trace-events     |   2 +
 hw/arm/Kconfig            |   5 +
 hw/arm/meson.build        |   1 +
 hw/arm/smmuv3-accel.c     |  16 +-
 hw/arm/smmuv3.c           |  18 +
 hw/arm/tegra241-cmdqv.c   | 759 ++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h   | 337 +++++++++++++++++
 hw/arm/trace-events       |   5 +
 hw/arm/virt-acpi-build.c  | 110 +++++-
 hw/vfio/iommufd.c         |   6 +-
 include/exec/cpu-common.h |   2 +
 include/hw/arm/smmuv3.h   |   3 +
 include/hw/arm/virt.h     |   2 +
 include/system/iommufd.h  |  16 +
 system/physmem.c          |  12 +
 16 files changed, 1332 insertions(+), 27 deletions(-)
 create mode 100644 hw/arm/tegra241-cmdqv.c
 create mode 100644 hw/arm/tegra241-cmdqv.h

-- 
2.43.0


