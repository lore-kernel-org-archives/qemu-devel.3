Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEA2D0C85F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcjQ-0002Ya-9u; Tue, 13 Jan 2026 06:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfcjO-0002Wi-L2; Tue, 13 Jan 2026 06:38:38 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfcjM-0003mZ-H4; Tue, 13 Jan 2026 06:38:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viV09EyLTXwlunpPRisIEqF6DqfMlLbhDBHc+Y1NEOQm47BXnQZ+d12gtqpmJmV8KSxJq9dUtznJLqxlhsZkDkKbNeKuPzV1mEQe2NdkkgMnKhtON1R61Kx7rpl+KJ/2gShBYbLyfycwnA7UsHwK5Juqm4p/feq8WQST8rO7qvJJZNwTwsieHVbqYX0uxWWQY1J1BupyhB58Wp5LGBfwIv1PQ95Yr9XtXCe5Mb7S7Z4vTdkf/l9MeITFbpqtWfaxCwyxMCyiasv/hjzY5FcyEFmtxIwe5EZ2t0LfqEq+sBKpMIBcixB49cwGk4HdZ3dTaPJHIrGGLbd/9H12IGz5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex76deSOKCmny0lvlVvmnKCxzBPzGp4wtMJEeNSwJR8=;
 b=ZR95r/frtPqwOuN7yGekZ1qLupAN6PUtxQbstyxGtSPKUvehj9zxajj7zGZaDkTD5z7OFv385FpvBEBTGlpxtS0/hS5qbZexhV5fEu8SfRw+HAyobwMMJTL3sQ3jII9ksoD2s3CPcZSUhCUQgzuoXh7XFAetqc/lFmYviOQombO5WEwbhkzaLsUZpjJE7lJ4CsfRTjMF1ztWYypCnwpnQVic6DBKoSa6r9iGR9LHk6q4+IzTcWH4HdKt/Wi3sPR2zXbLMsShS/cRPkcf6k4G1jXcl5iococtYSt2QJPrzYyyUBoqO60p/mdHY2NBQSjoXDmhemhWYr0E9EArV7hTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex76deSOKCmny0lvlVvmnKCxzBPzGp4wtMJEeNSwJR8=;
 b=S7FSzc09D+ulx13tN5sywP8SRB2I+c29q2khBLhmpihrwpRSCPSPViRF2bY1ipvScujLxak+tYBN/+Sv2B0c/Sm8ySB51dkjepweXAtVnMPHO7a1J9vBGgen7KwAOaafNsC/yGg9ShsLqtS4MHlWAyBereHNHTYG9XmO6H2SFsJAc65T/f1oW1O+y7WXxDWJIKKwUfKF3VpGRjYdssR61oSdwHjUaRcXh4WGK7LNsTLOW9dU+vkg5YpEc4QzcXqxcATkBQQmdF13lBrp3N2UZUHFP+OhdTPyUmc9xqTQPLZ2+LJl2MjwojHZ0uvhVjI0gE5sUYAiDW5RxRDbvYjsiQ==
Received: from MN2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:208:239::8)
 by IA4PR12MB9811.namprd12.prod.outlook.com (2603:10b6:208:54e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 11:38:31 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::9c) by MN2PR08CA0003.outlook.office365.com
 (2603:10b6:208:239::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 11:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 11:38:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 03:38:15 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 03:38:12 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v2 0/4] vfio: Add DMABUF support for PCI BAR regions
Date: Tue, 13 Jan 2026 11:37:50 +0000
Message-ID: <20260113113754.1189-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|IA4PR12MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: 875b03d2-b731-4e89-db9e-08de52984737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|7142099003|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjAxMDFjUzBwUS9CRFViRDd5TEludFVLdmliYVpUVlNGaWFweXFLaWFpbnVC?=
 =?utf-8?B?WUdhTVRkZ25MemZ4dk8vWGNjcGVaSE94b2gydnFSTTZsZTByS3hPeTRPM0Nt?=
 =?utf-8?B?N2hBclNnUVJEeDYwdWtUcTRUYzcwTEFzTkxhWkk5emlCNzF4WUtvNStTNVMz?=
 =?utf-8?B?OG1lNzlkMDRhN3lXYWRIQnZ6N2ZPT2pPUGNNV3ljZVZNMGFyNTBmSm4rZ3M0?=
 =?utf-8?B?a3czYzRtVUYxQW9SQ2xGY1ZyRWhTQkEvb0w0bWVMZ3A2OXNSU3MwbVJacm93?=
 =?utf-8?B?em56OXppSXcwOTlTdVhaSUZQc3B3bUxTR3Vlc1RaTXdXUklwWmV0M3ZpNVl0?=
 =?utf-8?B?V005SHNDaFFrM1gzSVcyZFBpS2lHdXBzUGtlSWkrVlJ3OFMrSGh2c0FGakNu?=
 =?utf-8?B?Qkp3MUFRTlBlQjh3MW5CV1FxMzNVeXUrN011aERVMHRmTUZ6VUNzd0xzZHE4?=
 =?utf-8?B?NUIrdkZrY0IvSUo5cjc5ME1xSVZWbVRaeVU4SzIybTNIMVdGS1lpVDc3ajYy?=
 =?utf-8?B?TnF4VGJPQ2I2cituYUlxWWRZU1UxWWx2NUd6SEk0T3U2dmlxVFpNTjdaSHhI?=
 =?utf-8?B?bWlyYU5jN0hvSzFmMU9KUFZzNjQ2bW5nZlhhQWZiNVZITFY3cFN6bS9nQ3JN?=
 =?utf-8?B?ODBRbWsxWjdzSG1UZEZJTitIRlAzQ29WVWk2T2lOSWwwOGdwMVJRUm51a1lR?=
 =?utf-8?B?UC95UnA1ZFJUbHlhNkhmNUNTRHl4RnBvdkVsNTRVL2U0OEczalFlVVFZeDJ3?=
 =?utf-8?B?ZHU4bUtoRmJpUG90Und6NkVSZVVkcnhuYlhRVzJXNWxCU0szK2UzRHo2RjdM?=
 =?utf-8?B?MkNXWndYdlB6NjVBbk1zUWVGVkxDa3J4bXM2ODhSMEhJc0pIUk1rbllKYnpK?=
 =?utf-8?B?U1h1QkpPNGZudlExVXM0R1FCV3U0S2srQ29kMU8xbEJMeFN4QkhybVI1MHds?=
 =?utf-8?B?eTNxSjgzRng2b21DaWpra3V4K09WdEtwdUNSWTVKM2hTeXFORzZHc0JnM0Ri?=
 =?utf-8?B?VHRud3pSOUQ0NUI5eFl4WXdaSUNNK2xjYTYzS3ByTkZpNG5HT3BldHJwcCtK?=
 =?utf-8?B?RnFpeHpCcXBiVDdraHEvbHlwakFlZG5BeTRuRi9TaWFWb3lJQkJyd1dxZVJu?=
 =?utf-8?B?TGhJVldETlhleldsa0hhMGUrRTh2V2Vna0VENDE1bzZKd3V5eGxLc1BSL2hJ?=
 =?utf-8?B?b0JYdkhFenhGSm9veUFJbldOMUJybDI4RnNFT29BYVl2U0hLSitsVDV1REYv?=
 =?utf-8?B?UDBBdEtuODZYUXA4b2VPWmpXS0l4TSswVC9TRitiWHI5bzBFUHNUNnBpNnNw?=
 =?utf-8?B?R01kdXpDMHVJdTA2NFBmSEFCdmxNMUlyaDE1UHg2Vjdpem9xeUM5eWpJcE1p?=
 =?utf-8?B?ZWZBSzlFQy93SzRZZXc0ZkFRZE5UNjR3RFZ1Wk91YktEa1JEeW1tWDJJUFQz?=
 =?utf-8?B?dytPRkpwWFB2MFlMdnJtTGpwTmxwdWJQTFBkeGN0NUN0SXhKTGxvS2FySVov?=
 =?utf-8?B?aWtrVmFFSFdQWHFaNTNycm5VNk1Da1NwZy9xYytnNEVzTjFwZDJYblFlSDYw?=
 =?utf-8?B?aXdvdUpWaUVpRkFVMGVNTU55QTMxYUNiZ0xQM0hMSWVIU2oxWERjVlhuaFNp?=
 =?utf-8?B?a1lPRHBNa1dXblB1RjJTaGxsSDJkK3hFRkE3V1FaYmRDbUNDRllYdkFGOGN4?=
 =?utf-8?B?cTZMN01iaXVEK2hxWWF6dGJZZ1lXNnRrcjdFRWhBVzhxOXFITi9zalMrQmNw?=
 =?utf-8?B?ZHhpN08zbjZsSFdzanB4REpEck5UeHNvOVdlQUhSZU9vS25POUhFekV0NW1x?=
 =?utf-8?B?dzBTOWNxL2ZPY3FMc1JFUjk1OHBwZFRTckdvWGFiM3BzUlg5U2Y3QnZjMldR?=
 =?utf-8?B?K1BkVUV1ZWRnVFpYZUdJekQrdklrRVNpTEZaT3h0QUpGaG1Md2g3cVhkOS9Q?=
 =?utf-8?B?WTR3dno4NU5GMFd1enVzdHZRVlFUaDdCTzhtYSs5eWorUHZyZE9hSWRrL25Q?=
 =?utf-8?B?aXE4M2s3enR4cGk3bzUyYWpVMWQvcnlsR1BnMklQU0tTVmRXWW1nb2x6cU5G?=
 =?utf-8?B?Z3c5QmFsc1h6OWdRclhEL3o1NzFxTm1UejlhZkloRDhuMVgvb0UraGNZVldu?=
 =?utf-8?Q?kTlM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7142099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 11:38:31.4571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875b03d2-b731-4e89-db9e-08de52984737
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9811
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

Hi,

Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
use cases. This adds support for vfio devices to create a dmabuf for
each mapped BAR region.

Changes from v1:
https://lore.kernel.org/qemu-devel/20251222135357.143339-1-skolothumtho@nvidia.com/
 
 - Addressed feedback on v1. Thanks!.
 - Added a helper function to retreive device feature(patch #3)
 - This has dependnecy on patches sent by Cédric[0][1] 

The dmabuf support was sanity tested on an NVIDIA grace paltform.

Please take a look and let me know.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20260112155341.1209988-1-clg@redhat.com/
[1] https://lore.kernel.org/qemu-devel/20260108185012.2568277-1-clg@redhat.com/

Nicolin Chen (1):
  hw/vfio/region: Create dmabuf for PCI BAR per region

Shameer Kolothum (3):
  linux-headers: Update to Linux v6.19-rc1
  hw/net/virtio-net: Adapt hash handling to updated UAPI
  hw/vfio: Add helper to retrieve device feature

 hw/net/virtio-net.c                           |  11 +-
 hw/vfio/container.c                           |   2 +-
 hw/vfio/device.c                              |  10 +
 hw/vfio/listener.c                            |   4 +-
 hw/vfio/region.c                              |  69 ++-
 hw/vfio/trace-events                          |   1 +
 include/hw/vfio/vfio-device.h                 |   3 +
 include/standard-headers/drm/drm_fourcc.h     |  25 +-
 include/standard-headers/linux/ethtool.h      |   5 +
 .../linux/input-event-codes.h                 |  14 +-
 include/standard-headers/linux/pci_regs.h     |  89 ++++
 include/standard-headers/linux/virtio_net.h   |   3 +-
 include/standard-headers/linux/virtio_pci.h   |   2 +-
 linux-headers/asm-arm64/kvm.h                 |   2 +-
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/unistd.h            |   4 +-
 linux-headers/asm-loongarch/kvm.h             |   1 +
 linux-headers/asm-loongarch/unistd.h          |   6 +
 linux-headers/asm-loongarch/unistd_64.h       |   1 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |   3 +
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/bitsperlong.h          |   4 -
 linux-headers/asm-s390/unistd.h               |   4 -
 linux-headers/asm-s390/unistd_32.h            | 446 ------------------
 linux-headers/asm-s390/unistd_64.h            |   9 +-
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/iommufd.h                 |  10 +
 linux-headers/linux/kvm.h                     |  11 +
 linux-headers/linux/mshv.h                    | 116 ++++-
 linux-headers/linux/psp-sev.h                 |  66 ++-
 linux-headers/linux/vfio.h                    |  28 ++
 40 files changed, 455 insertions(+), 506 deletions(-)
 delete mode 100644 linux-headers/asm-s390/unistd_32.h

-- 
2.43.0


