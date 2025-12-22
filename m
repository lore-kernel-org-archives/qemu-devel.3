Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BEEE674B5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 13:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXgPI-0007by-6u; Mon, 22 Dec 2025 08:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vXgOS-0007Lk-Fk; Mon, 22 Dec 2025 08:56:17 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vXgOQ-0004cm-Q2; Mon, 22 Dec 2025 08:56:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfqIFxwrRu6TDaC3oZK5kDSCnGmx9v69vjzikKT++Rg2f26+jne0vjZN3EFmOIaqxYu0JyfWzcvBP3O+ADZtOVD4DnM5iYW1ibGhnu3XjeCeJPexSHrhRx6H+WvPERtVJHuRbDB7gF8CdPHIOJLjvFG+O7QiZjZpVdAiTPr20SXrRSGUC+CYw2uTBQrVTtYO/9mbdxPhzFuCfTmPneSMh78RK9j+5z8aRab1uZOtbh377sv2/SWNrAVEtF+5i/TOWXgi6XORcY7cu9otaw5GP+ofHeBGUZyg+cU0hjl6NQhbgfRgaRAQvfUxj+wHXJMI4jz18r/P6vnfRB7z+U5ArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEot3q88iNPj3YS4VFIKFJVD4WTxHrmoIS3c07hyO28=;
 b=yGsFoR/iyozRy1S9a1ands8y3DhEGsrff9WoZUbAvQ6Jb1dJKtJq6G0I4UIa6nZHScnOOC2KuMb8k0XjS14Io+zeMAWYUYBHeS1kBm5oq1JHCUxiMRRTbjACX+YC7+arqs286rC0YBMZ3xMX/QkW6fNrYZ7FS/5tRCg6ziBnIy4rmV8cNZ5EvuyJ6BPwRv5kM/eKAOkVjeLLk8P9Mvqh+lvsUkF5vrZZiNmFqvPuzxtgfJbee4+5k6orL3NLhzu1Qtvi8aJvRwbVdyRKscpNaknzqJMJ5yta9Tx//iRwtdljHzBzvfO+HZOxjrNxuVJdE7dAJBG7ouHGH2JRP6OWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEot3q88iNPj3YS4VFIKFJVD4WTxHrmoIS3c07hyO28=;
 b=m63MEBzRVJzv4ov7yAyEPjN373LFDPcTZn+ZMM4sPyIVMYHOa4ykEUunc+Qzd4pFj+lAOaAfbSku4t9rgPOMUCH3ydJrKA3UMjyaORUluGt95wuhTqUoQRyn1X7rh5NSoaAaNgqlwvQyd8/jfAhHb+J4eCnBbiv275YT4W65IKvE82+4RJr3IePkNShSn8h9JLaPgH0TaryQSL5Xo6/lI5PKXQJwrbHDhERX0hxZ0+1bCXClM6ITel6a6RGNW8iDx+47g9yoFGKCDj0UDyOJ1MFZ+W412iZZOTon65uFPU78sfBsfG7rTOet+MoEoIC4JTlf1ns/SouoGEp3zS5O8Q==
Received: from MN0P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::15)
 by LV0PR12MB999070.namprd12.prod.outlook.com (2603:10b6:408:32a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 13:56:04 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::88) by MN0P221CA0005.outlook.office365.com
 (2603:10b6:208:52a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 13:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 13:56:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 05:55:44 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 05:55:42 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <kjaju@nvidia.com>
Subject: [PATCH 0/3] vfio: Add DMABUF support for PCI BAR regions
Date: Mon, 22 Dec 2025 13:53:54 +0000
Message-ID: <20251222135357.143339-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|LV0PR12MB999070:EE_
X-MS-Office365-Filtering-Correlation-Id: ad677af2-8d26-413d-4344-08de4161d8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0hLaDdnSkZmVHFGSGxWMzQ4RXpQbXdPNXJlUGxQNjZvdzRmOXc4NEswa0pV?=
 =?utf-8?B?ODlickdJNk91SnhPUmUzT0tJQmhSR3kvQ0hZcXlPakRha24yZWFaRVJkallL?=
 =?utf-8?B?elJuMzUyTFd2N21GSzN1MDhlc0VSUXZETDIzY0VNNmJoYWxKMXQ3ZjdUM05V?=
 =?utf-8?B?QUo1THl6YnNYT1pZWFdUMitXUC8vdE52amh5aHgzNHd0VU9mTjZMQWpuZFQv?=
 =?utf-8?B?eFV0Q1ZCdXhYaHV6eWlxM1ZWZWMvbnJQN0tIeDhITVcvVXdITFVSLys3VnJR?=
 =?utf-8?B?ZktKZitGY292V1UwcmxlZmpOVVNpZklNWkJzUkkyVHhya1Jsb0JJSDZpczFM?=
 =?utf-8?B?ZVY0QnpEblRaWStFZmpneExLSUFCQjdlYkdYWmFuckFHdXBhNWZDMVY0MTRv?=
 =?utf-8?B?MzFmU0M0Vi9ySmJ0WS90Yi9CQUh5SnlSSnV1N0pZVXNCNTI3Q1Y1NFpuUWNw?=
 =?utf-8?B?aWNCT3NuS01ScHVQSW15eE1mKzhkUWhaV2JWWXkvVi9mKzk0WjhHWG9YZ1hu?=
 =?utf-8?B?aUdLOW40ZWRNVWcrMm16RDdkbGdWbk1PL0lOTGRNUFIxenh2RU9sM2JIK2Jx?=
 =?utf-8?B?V1Ixa0tCRjBVNUhuRkJ1eHpSSGQxZ1FBajYxRVdIOWI1QW1hQytCSXQyQ1VX?=
 =?utf-8?B?UFg3T0NkMHBuVDJ3Umk1V3V4aW10bGZMUEJvMkVyOWFvTVNZR2pwVXRxeXF6?=
 =?utf-8?B?Tkx2ajJ2dXdXeXNJdTgxOHBGM0N4U0lGQ2hGT1ZTMExRNjY4alRDN1NhcGxx?=
 =?utf-8?B?NEVXcTNwRSs3eXhqcldKUTVLbnhwbURaaUJxbHMzSmNXRDFUcWpxWmVSVDRC?=
 =?utf-8?B?MWpTM3lESzZnQkkySkdmU2F5NVBwK3dITGY0M3hQNTBnMWV4WUcxanhyS0tG?=
 =?utf-8?B?OEVnS2toM0VSU1Rydmd6RTAyOGVxRUpvRXFHSE1rV1VxZ1FIdjhYRnZRUG9V?=
 =?utf-8?B?aG1laU9KNUFQUmovemJjWi92dG1WdTVPWksyM0pwQjh5TXEwUUkwRkZabWh5?=
 =?utf-8?B?dGlyR3pOWVZXYjNtUFVMc0t1b3RnN29rYk50SmdJRFA1Mk1xeGlsNU5QWVQw?=
 =?utf-8?B?M1RQNGZCQ3NVbHdMaEJDZnlWeExBQW1nVmVscFIwd1ZxM3psdUFJbVQ3UkJV?=
 =?utf-8?B?QXZQQm0vMUx0Q01JTkhUYndPUENzYlZhSHF5ZWRCdGlqVnFzcmI3SDlrUzRX?=
 =?utf-8?B?SWdHOWgvVS9UVXlUSjdkMjVxd0ZhYkNLWk1kYjdvMzlSZDlhdEJ2cDN2SVBE?=
 =?utf-8?B?VUl1WXIwS2t1MDdYVU1POWdON05jdlEyanFkSUUra2FoQlY0RmNQaTQ0Mnc1?=
 =?utf-8?B?aCtnaVE4M2xUWDFVa0QzTWFKL3FBT09NM2dmckd2eDRxMFNwNnVsWXgyWC83?=
 =?utf-8?B?ck5jZEdHdW05ZVJYTHplRm5TVTNzZkJpWit1T05ocForQnYxcGFVUStEdWsy?=
 =?utf-8?B?T3lJVDdTUUFCU0lNb1lXSlZ5c2ZESS9IQ0ZmQ3FSSnRxRGtEN29pNlVSUU1v?=
 =?utf-8?B?UjdVUmRTSi9YSUFkbFNISTlBQXAyaS9vVS95djZCNEx1WUNSZGd6UmZxSlJF?=
 =?utf-8?B?Q0VLK2VydU9nWW9YbjVTMW9kaWc5d2dPSGIxRmNFUUIwbVJlSjZlazltMkh5?=
 =?utf-8?B?OW1GMTNTUWpyLzNxR0IxTDZtNU1QMUFNaUhyVU1lWjcxTTFvZnZiSWZnNVpi?=
 =?utf-8?B?TG9janVWd1Zqbnh3TjZyZUc5TEVQRENaVTVDVWZsU3BlY2UrQWJnb2FySFJW?=
 =?utf-8?B?cVhaQmpSL3NsMDZadXd2aGEvSnVaREl3bmRDTjNsV0p0ckxGTGZHWTlaZUhY?=
 =?utf-8?B?eDU3Qk5wMUpvTFgrUVlRT3k1bDdFZldYbzltbk1DQkV0WFpEK2ZFTmR5bTBP?=
 =?utf-8?B?MGJqMzcvL0FiV1kxM0o2bEZKRVluQm1oMm9tZkx5S2FhN2I3U24xVkR2eHZm?=
 =?utf-8?B?SVNYZVNkdDdjTlQ0WGdMNXVweU5iZ2cvbkZWU1FBa2hQVU04VjNXWVZpKyta?=
 =?utf-8?B?SDNuT3BCYmlqR0wrdkplUGJBUUczMWg4SVNhc2Y1ajdlQzRmdDhNN0ZIV1Vl?=
 =?utf-8?B?N1lGWGFjS09QY2RId0UvVVBMbUNGcUliRVREdVlvRlVGV054TS8xRHcyYWtK?=
 =?utf-8?Q?si1c=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 13:56:03.7508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad677af2-8d26-413d-4344-08de4161d8df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999070
Received-SPF: softfail client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
use cases. This adds support for vfio devices to create a dmabuf for
each mapped BAR region.

Requires linux-headers update to 6.19-rc1(patch #1). That update
introduces a virtio-net build issue, which is addressed by patch #2.

The dmabuf support was sanity tested on an NVIDIA grace paltform.

Please take a look and let me know.

Thanks,
Shameer

Nicolin Chen (1):
  hw/vfio/region: Create dmabuf for PCI BAR per region

Shameer Kolothum (2):
  linux-headers: Update to Linux v6.19-rc1
  hw/net/virtio-net: Adapt hash handling to updated UAPI

 hw/net/virtio-net.c                           |  11 +-
 hw/vfio/region.c                              |  57 ++-
 hw/vfio/trace-events                          |   1 +
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
 36 files changed, 427 insertions(+), 503 deletions(-)
 delete mode 100644 linux-headers/asm-s390/unistd_32.h

-- 
2.43.0


