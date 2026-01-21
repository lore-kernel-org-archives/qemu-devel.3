Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D800BC44521
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWbJ-0004Mt-9f; Wed, 21 Jan 2026 06:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1viWbI-0004MI-2M; Wed, 21 Jan 2026 06:42:16 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1viWbG-00037J-AG; Wed, 21 Jan 2026 06:42:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sW2zJC4UE4S1y42Q67/XFfeorf7bmvt0lT1pb/knBPJLvgu7C5XFBXc5h1SDPYrTWs78BzJPcL4XsHemYsC9KdGp5mGh97pwO6Giz3iVd7tiJAXxzTo/PN7SNobsdholMHO/EWKRmyrGVAnbWtd+md0BCBjLxyQ4r6AQEFoOABMe//zPMPZkNrc2htyUVSVNI3avTSo9427MSE4WsHwE/5pSZfBrAed1QzRXuHhSU2N5RFbxnUGjXBzZoJcpvEiY5pVV+AwAjN7lmDKn/4j8AYEqJJu72mKcWxIl1ZNBtkXUIK6qKLvWh/FSozukNvCrJt7Ec5EH4ejXdavqlG5eYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2iSRxJTdGUtaCcfZU1bmO4iQjyawIXENeqDOXzT/Vg=;
 b=mMOjVNAxnI9msOruIeFpnBpuEd283R3Cmy0733LaFtmLqhvM9ARSjaz6nkKBHOSNn6r6t12Hg42Zmbs+ahJUbo/qOTYvaqbdrc3ufZ2H4YZLjA8h6CaZslmaRL7+QwKCMDobKNw8je1weXmS0CmcfryVuCO3RwyYsCbS69Yzu9lRPU1xR6bwq2EdioplxEKCynMyrpQ5GAcwU0TAxKqQbGnHOEXx3lLEmnFdc8q7oBFx0ra3dOE93Iqu3uR0fyBbp7+iq2P7k6U+e9QnEuSNm2qhWKXY2w3+p11mRJKe5tYmIuLYcwvOTP8pf1V90Li9fKiF5nCkgIiWwRht7bvRiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2iSRxJTdGUtaCcfZU1bmO4iQjyawIXENeqDOXzT/Vg=;
 b=I8fRkxtwfNX0qpiqzX/8ia5WgrnK7PK7NrIaF5Pxpe6pkiMjIjitB4GQE8Fq1IGCfVcvCCq0YGZiB0ro0VFX5c1hThkz/BigTDr7Va/YTB0nPYogBGrtexnNYIdWm7dPLcmTOwnmngkSALMe+cFtp2U0DjBdgzWTwGq+msuO9Hrngu4vPRpo/IHOK9BkHEuuyWtUYBMhUGuqsvXBrJblnGeKFmTd0SZNAFOxNQtRRjrqrfcrbwmj+ETvyDh9BNuuN+Ocek0P1ggjZ91o7O1bRLqRjlMY/7sau6brp57oJ27LDD4jMYubgtQaQue3ObeoIP37lNDuTwCeTzP0G6WfwA==
Received: from BN0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:e7::10)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:42:07 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::c5) by BN0PR03CA0035.outlook.office365.com
 (2603:10b6:408:e7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 11:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 11:42:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 03:41:57 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 03:41:54 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <vivek.kasireddy@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v4 0/3] vfio: Add DMABUF support for PCI BAR regions
Date: Wed, 21 Jan 2026 11:41:08 +0000
Message-ID: <20260121114111.34045-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e15f439-a9b6-4fed-b6b4-08de58e21ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0YwWVA4VGJaV1JwcXp3TXk2YTVOZHNzYjRQcyt3Sml2N2pZVFZUTEVKOUpx?=
 =?utf-8?B?YStHN2wrQjExVGtHa0sxcUJ0dXBpU3NZa054cW9BY0NEN00wQlIweVIvZjRL?=
 =?utf-8?B?QVlaNVh4eDNML1R5ZlpsTmtJNFR3RWUzT0o5OUkvRWxrT2R1MlB3MTRLek1S?=
 =?utf-8?B?TTVsbzZvS3JybkVXa1c3N0VmUUowTzdpNGd0SE8zZlVjdjNBQTROZmZTV3cv?=
 =?utf-8?B?TkdLejFGbUJwdkx4R2JKZzE4V29CTWFpVTJWTFdwWUxRdFhmU014bHFQN3ox?=
 =?utf-8?B?QVZpNzlvVkswVk8xbWk3UXQ1aXZyTTJ5Z1NwdFRtWFFSNUNmUDNtT1lZUmxM?=
 =?utf-8?B?MXNrL2NSRWdPKzJKRk9uQ3NVcnNybEdzTmdSNEZjTW9nVlVxdUdrK1A3dUZn?=
 =?utf-8?B?Kzkwa1V2R3VIMmtGQjBBWjF1N1pjVm5rMHY5ZzR2bHBYeFk0cW9vUWY5Z2tO?=
 =?utf-8?B?OFJESlBtK2RicEFOUjQ4ZGpWRlBvNkQ3REpYOVdKWXNnQUw1NWtvUVhXVm95?=
 =?utf-8?B?T01oR09DYTJ6OWhXY01ZOUVtNHJjbnNJNDJQMG9Td1pybXA1N0NwZUlHb2lN?=
 =?utf-8?B?NWhYZXl2UWVGdWpqUWZPenAxWWN4cklNM1g2bE9oeVpEWGpkZisrVW9rK3hY?=
 =?utf-8?B?VjBYUVZoZFRqcEpvc3lTb1ZHNlo4VndpTHNRQ2lCREpQV3RaMzdUcG5kdkla?=
 =?utf-8?B?Y2RQajJuUUo5eUVNWlF0TUY2OXZoMGpsVnJ4dEpIcmtPOTdQYlZTZVdrclBp?=
 =?utf-8?B?RTFkNnZVRDFWOFdqYzEybUtsTzExRm9tV3NJS2pYajBIUkNBdHBkYVlVM3VS?=
 =?utf-8?B?M0NoQUhvaVA5eDBWeXowbzRkYnNmeWRFQ0hiRTZwb2FkRkRmd2UzYmZQdGdP?=
 =?utf-8?B?cWdVMTFuOXRWN2l5RkxUNUlOK0FCN0pyZzRwVUxSaFJXV0swZkFXK2pFRitO?=
 =?utf-8?B?ajVIT08rWnVqNytaQ3MvNXZqTzRBZjVHOTV3OUY5SDFZc2ZOenFQUjFLZ0Z3?=
 =?utf-8?B?UVRDS2Z2eXY2Z0VDa3RFdlhNbVBuS0RNVFhJVDBhblp0S2ZCeGlFNTNaSGJi?=
 =?utf-8?B?TktPOXRQL2ZweDNzS1Y2V0RDdVAxbTBNSkJ6bUUwVEthSnpwYlNBNTYySjRB?=
 =?utf-8?B?UTgvdSsrcHVCNWpBMndFajErWXIySUdMY0ZlVFd5TjhqbHhIV1djV3A4Zzhq?=
 =?utf-8?B?M1NBTGpZYjRoMmJaNnhZTkd4WERETTcrMnlrV3JhcDlEWWt4cjNjWkgxcmw1?=
 =?utf-8?B?UzJlbVdLZWE0eEwyZjRRYTlzMFQ2eUxEU1dTdnVHNFgrUXFqYzh3TjhtUjdW?=
 =?utf-8?B?d243cyttQmt3WkpuSXBYRHk1RWJnRWxPYXpBSUVGeGVkMGNGVytCTERDcXpF?=
 =?utf-8?B?MXNlQlVZOXlLQlQrcTlQOFQwY2VRZEFUbEpoQzdJdnBtLzVBdnRZbEtuZ1d1?=
 =?utf-8?B?NDlrWDZEekpKR3llU24yb0FzN0VUSkIyYkhHN3dhSGRRZXFaQXZwL2hXRW5V?=
 =?utf-8?B?SDcyRGlML0s5UXpzSFR1azVWUnV3OUcxVDBMbTJOZ3RMUVZGVUNVUDNPOE5I?=
 =?utf-8?B?eVZnVWxGZ3RFU3VILzhVYkdtQjg5UlIxbTB3SEp5dEJGMUp4dzRqNTJwZkNV?=
 =?utf-8?B?VjRHcTE3VGRTMzQwbXZUTTlwU2I2ZCswRnRsYnJxdUNUOWY5a21iYmpqQ25Z?=
 =?utf-8?B?Vm5OSzhxcmZsZVBXd3VnRm45dFljOXlwVGMrN3c3ZmJzdzN2RGtUK0h4R1Yw?=
 =?utf-8?B?VHdZQWkwZm1VZW53MnZrZVc2U002bDF2RVh5cXVxUjl6OU5YakFkNmd5S3lv?=
 =?utf-8?B?dVNxcG85SzhXNVhyUlZyL2dxNG8yb2ZsbEprcXk2WS9tY0lLTGhkeldBNXpW?=
 =?utf-8?B?VTZxTkY1RU5uVWJiLzhrT2JVc1d2Z001Z3lHVU13enpXN1psVXdrSGNmc1cx?=
 =?utf-8?B?ajJDdHpqanJMa2cvNGdCWnRnR3J2emxkcWNIcWNFc3NIZHRqZ0l1ZFk5endB?=
 =?utf-8?B?aHk0akJNWGJVaGhFYldBQW5PWUlHaVNTdGNJZnVKaW1DM01NeTBCejRUQ1hp?=
 =?utf-8?B?RU5tT0s3MXpRYzd4YnJZUjJuTnRhNDh6TkRaWDZvMVdLYk55bFBsV2U5S0No?=
 =?utf-8?B?RDJRdU8rMVNJSytMMlFad2lTYzMva01kVDJDTVJ2WmVuaDZqMDdHNWxUMElT?=
 =?utf-8?B?c1MrOHBETnpXQVNLZEJCbFNXZHNWQ0Q3WTRzMWhLL3R4OCt1TEFaU3llYmpZ?=
 =?utf-8?B?MFlzZXFVTlRKaHRadzl0U3VtRkZ3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:42:06.6483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e15f439-a9b6-4fed-b6b4-08de58e21ac7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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

Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
use cases. This adds support for vfio devices to create a dmabuf for
each mapped BAR region.

Changes from v3:
 https://lore.kernel.org/qemu-devel/20260116092950.15796-1-skolothumtho@nvidia.com/
 
 - Folded in patch #2 to linux-headers update to avoid bisect failure
   due to build error.

The dmabuf support was sanity tested on an NVIDIA grace paltform.

Please take a look and let me know.

Thanks,
Shameer

Nicolin Chen (1):
  hw/vfio/region: Create dmabuf for PCI BAR per region

Shameer Kolothum (2):
  linux-headers: Update to Linux v6.19-rc1
  hw/vfio: Add helper to retrieve device feature

 hw/net/virtio-net.c                           |  11 +-
 hw/vfio/container.c                           |   2 +-
 hw/vfio/device.c                              |   9 ++
 hw/vfio/listener.c                            |   4 +-
 hw/vfio/region.c                              |  65 +++++++++-
 hw/vfio/trace-events                          |   1 +
 include/hw/vfio/vfio-device.h                 |   3 +
 include/standard-headers/drm/drm_fourcc.h     |  25 ++--
 include/standard-headers/linux/ethtool.h      |   5 +
 .../linux/input-event-codes.h                 |  14 ++-
 include/standard-headers/linux/pci_regs.h     |  89 ++++++++++++++
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
 linux-headers/asm-s390/unistd_64.h            |   9 +-
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/iommufd.h                 |  10 ++
 linux-headers/linux/kvm.h                     |  11 ++
 linux-headers/linux/mshv.h                    | 116 +++++++++++++++++-
 linux-headers/linux/psp-sev.h                 |  66 ++++++----
 linux-headers/linux/vfio.h                    |  28 +++++
 39 files changed, 450 insertions(+), 60 deletions(-)

-- 
2.43.0


