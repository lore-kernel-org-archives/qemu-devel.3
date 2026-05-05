Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEDBCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKB0c-0007Pt-EJ; Tue, 05 May 2026 04:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKB0W-0007Os-Vf
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:19:58 -0400
Received: from mail-eastusazon11011038.outbound.protection.outlook.com
 ([52.101.52.38] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKB0T-00082w-8N
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:19:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foS7tAF8wZh2oHRKP+wtlFJbdkFxmv1VoHtcHe8VX5gBp9XFvtv2Jjhg5kEOGOnrqacfJ7IEDRS7c6QrSZuAzQTq9ILU1EylhMgsp0LvAxMIzQvOASgc696SnGlSKmJEv4lqYbldPN8rXGWN0DUeL9C2jWPr4visZu4DfPoZC5i050Iz3ASMSZhf+R34ntJlB1DPcvTAHMkOuD591YgGpsJ24wj9fgi6ftwAFq7aO8bDrOYuJnxYAbllXAReg31eipY9XlZcu645P6LiF3DoQxN0YhDcFGY2j64IdyOMmR3DZO9UK4lFqHeoxQuP9elMYrXp8YSNOKc5SVMMShjnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcLnx2pS78z5Sy5PfbXR2wvZqALIPhTaS0ef+SOQC5o=;
 b=IYj3o6l5Kk3IM89Rg0/z/zF0vKODJvOm/k5aQQhDkVI0HrS6T1Bwo5wWrc8cFPu6iHCUGesK/fwhKo8j1oPPlNy7E9kj0dRofB5UczVmD9gEGfkGxpONrSNN58kWW4Tnr2/pCgCqEHkzHfMlrYaItLb4+4zwqeC1gQuKt2ogt1f6Ah71fBh7AkRMXX1+T9699Kn3N+vjzZh8q6nxoveh52xMS+VQIIqC8gzUgThdGehtJCvsaf3hh2Kz5Z3r+EcV9lS1Wi6bBT4unBKHXIbV7NFJvB95gBimsE0gykXuv8r97XFWUB2oBfeXFCEBSI66fosmrbKtAEDVwf24HFcmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcLnx2pS78z5Sy5PfbXR2wvZqALIPhTaS0ef+SOQC5o=;
 b=OausmUqWlLJq+jGwJMNAzWf5Jup7C2PdNCvBaIeOYrGMIk9SSbH1kt6n+fahmhHU6ElQxoWu/Dny3Pi+4NO0b0/rGILeVzdHNSTS6rDyWkBfT+Z3rUr1NUTKvST6gxBI9k+95gFQ2NghVPO8iSmbV7Loo0wmtVi5tbtpPshR6/aYHl/P66mGurzB+XBkQ4Mofug3UvGKhYOF1Q8jYJvCf46c0QZmc5NsNgUuEa2YMGlWkW59aPyZeHX6KlCsrFtgYIw0BgjguFZs5gCxO0NZtD6VpXcdlUBkeOC7jvZM/7PuMaf8uC+QZAaFLpMF29ixd2xp+iGdy5/slU5gkA3ACQ==
Received: from BN0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:408:e5::17)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:14:40 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e5:cafe::1b) by BN0PR02CA0042.outlook.office365.com
 (2603:10b6:408:e5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 08:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:14:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:28 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:27 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:14:24 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 00/14] Make switchover-ack re-usable and add VFIO precopy
 REINIT feature
Date: Tue, 5 May 2026 11:14:09 +0300
Message-ID: <20260505081423.28326-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 5031f1b4-9fb7-4400-6446-08deaa7e5b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info: yQ0pIqoKiQDWyYxnSrots1ZhNJJgdDTLNYrxcL3OUb0DrbJufYTWlW5qlkPXs2FVMjCVlYwXE2qh1UDgZz4vKa+lDWZELk2NeQkYRTr9UcxmSK+uPlGcSjLFbBPjHg32nU38iXIOlOuZWxw9+bFI/xkrLETDQ/0+LflIXdP9WfgL/TsEpDEAH05XorZA1Z55QZFGwmhDOvnKy/OqlE3tWh8LwFg5u6wC3CwX1EtN3DR3V8Ts5OvlSj4Ywb0sIkTtl/GpIZhm56sz41f3pksLBrWAh0BP6JmGSCFXfA8mzfiCV3+XfkoCYoyMmdbk91PFVSSiCECnYoQtXveiN5CKMO5zjOUxd48Kx/NjKaBhrnkqZY+0+MWv0mBhpRilS+SBvz8KqzIJNAKjclBPbQBPTiVD/DEd2AIwMaCTYENkd61lOIf95DFWFRG2pTBM3tCzb5YmfdC1W+RnLpi5WneT/cvZhVudpKClWYrXoh0aShP5iTkvF3liiZIcU3OpgggZ/kjXGSqQi6T9+IoDw2jWGkhwmR1CBqzbj/DTupzeT0nKaM1OI/RyO8OtFGdwbhklquH8KISaOn9EVNSjbOBqLiH/X7T8HdjCkiNC7oA8/fL7hiPw+ZoF2na2GWrvPsTh/LZQ6iT3LRF3FgCoWsKdd0c0btujEx3pTOeWpoTMhWTuRU0wlD1KseL5RukqZhQItnVUkDAWImanZnyjA1wPcxoMFmvZGM3JJQsbv8c8wzObFRv3va1On5YfMB1s1VN/
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(56012099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B8SGaKxQHvWlYqyq6g95eaF0UcwoPGbwQ1rGBR0j7zKMEGGUDPEI9grhYRp/zkHRzyKbj1ItJIep5VONuD57ECs8R85qy2ywhZgXm/PHfAIchIUf5uv4aUHWWrLVMNJi4imJvYWo6cfW/6dlfswlXHLV94IpE5TCqIzZZdbcQ+qJ9SVOVljeIO4w85rpAX1EyerMgk44cIMJkMNPYF1ccbifoawLJ7GFHiDj+yDtB7Xl94nULZUlGLM+a3ujRdOEbfWs0DI1TJGU1SCMknJMh5kjTQpzTCMDbIA9pKPGsSWhCWao5x0+Hb95kdyA8kYtN5wN6NdOyK5rTrXfzkA4Lmbfe5YC/nq0BLLYSzok+nzbwTkl0y8xP/FbcfK+0Wq5zDnMUf3y3ke6MqWR3+TUdXVqLVo4dTCc6pz6mCZWI0JsNbb5lYuOwxWoLdk5AhZV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:14:40.2154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5031f1b4-9fb7-4400-6446-08deaa7e5b18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
Received-SPF: permerror client-ip=52.101.52.38;
 envelope-from=avihaih@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hello,

This series adds support for the kernel VFIO_PRECOPY_INFO_REINIT feature
[1], which can reduce migration downtime in some VFIO precopy scenarios
(see the Tests section below). Supporting it requires refactoring
switchover-ack and making it re-usable; that work comes first.

The series is based on Peter's VFIO fixes series [2].
Based-on: 20260421202110.306051-1-peterx@redhat.com

=== Background ===

Switchover-ack is a mechanism to synchronize between source and
destination QEMU during migration to prevent the source from switching
over prematurely.

VFIO uses switchover-ack to ensure switchover happens only after
destination side has loaded the precopy initial bytes. This is important
for VFIO, as otherwise downtime could be impacted and be higher.

In its current state, switchover-ack is a one-time mechanism, meaning
that switchover is acked only once and past that another ACK cannot be
requested again. This was sufficient until now, as VFIO precopy initial
bytes was defined to be monotonically decreasing. Thus, when precopy
initial bytes reached zero for all VFIO devices, a single ACK would be
sent and its validity would hold.

=== Problem ===

Now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy initial
bytes to be re-initialized during precopy. Specifically, it means that
initial bytes can grow after reaching zero, which would invalidate a
previously sent switchover ACK.

=== Solution ===

To support VFIO_PRECOPY_INFO_REINIT, this series makes switchover-ack
re-usable and allows devices to request another switchover ACK when
needed.

In the new mechansim, switchover ACK can be requested for a specific
device and in different times, so switchover ACK is changed to be
per-device (instead of a single ACK for all devices) and source side is
the one who does the pending ACKs accounting (instead of destination
side).

The old (legacy) switchover-ack mechanism is kept for backward
compatibility and is turned on by a compatibility property for older
machines.

With that infrastructure in place, VFIO uses the new switchover-ack path
and implements VFIO_PRECOPY_INFO_REINIT.

=== Tests ===

Functional and performance tests were run.

Performance tests were done by migrating a single VM with:
* 8 GB RAM
* 4 mlx5 VFIO devices:
  - One device with 1GB of device data (stopcopy data) that runs
    workload during precopy so VFIO_PRECOPY_INFO_REINIT is exercised
    (generate new initial_bytes chunks during precopy).
  - The other 3 devices are idle.

In this setup, VFIO_PRECOPY_INFO_REINIT reduced total migration downtime by
about 43%, and downtime attributed to the busy VFIO device by about 67%:

With VFIO_PRECOPY_INFO_REINIT:
  1335ms total (~520ms from the VFIO device running the workload).

Without VFIO_PRECOPY_INFO_REINIT:
  2352ms total (~1600ms from the VFIO device running the workload).

Functional tests covered the main code paths and combinations, including
legacy and new switchover-ack across versions, for example:
* Migration between QEMU 11.0 (old binary) and 11.1 (new binary).
* Migration between two 11.1 binaries with different machine versions.
* Migration when the VFIO device has no VFIO_PRECOPY_INFO_REINIT.
* Migration when the VFIO device has no VFIO precopy support.

=== Patch Breakdown ===

* Patches 1-2: Update Linux headers
* Patches 3-8,14: Migration cleanups and the new switchover-ack mechanism
* Patches 9-13: VFIO cleanups and VFIO_PRECOPY_INFO_REINIT

Thanks.

[1] https://lore.kernel.org/all/20260317161753.18964-1-yishaih@nvidia.com/
[2] https://lore.kernel.org/qemu-devel/20260421202110.306051-1-peterx@redhat.com/

Avihai Horon (14):
  scripts/update-linux-headers: Add typelimits.h
  linux-headers: Update to Linux v7.1-rc1
  migration: Propagate errors in migration_completion_precopy()
  migration: Log the approver in qemu_loadvm_approve_switchover()
  migration: Replace switchover_ack_needed SaveVMHandler
  migration: Rename switchover-ack code to legacy
  migration: Make switchover-ack re-usable
  migration: Check switchover-ack during switchover phase
  vfio/migration: Re-query precopy size before sending
    VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
  vfio/migration: Add Error ** parameter to vfio_migration_init()
  vfio/migration: Add new switchover-ack mechanism
  vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT feature
  vfio/migration: Check VFIO_PRECOPY_INFO_REINIT during switchover
  migration: Enable new switchover-ack

 docs/devel/migration/vfio.rst                 |   4 +-
 hw/vfio/vfio-migration-internal.h             |   2 +
 include/migration/client-options.h            |   1 +
 include/migration/misc.h                      |   2 +
 include/migration/register.h                  |  21 +-
 include/standard-headers/drm/drm_fourcc.h     |  28 +-
 include/standard-headers/linux/const.h        |  18 +
 include/standard-headers/linux/ethtool.h      |  28 +-
 .../linux/input-event-codes.h                 |  13 +
 include/standard-headers/linux/pci_regs.h     |  71 ++-
 include/standard-headers/linux/typelimits.h   |   8 +
 include/standard-headers/linux/virtio_ring.h  |   3 +-
 include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
 include/standard-headers/linux/vmclock-abi.h  |  20 +
 linux-headers/asm-arm64/kvm.h                 |   1 +
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/unistd.h            |   5 +-
 linux-headers/asm-loongarch/kvm.h             |   5 +
 linux-headers/asm-loongarch/kvm_para.h        |   1 +
 linux-headers/asm-loongarch/unistd_64.h       |   2 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |  11 +-
 linux-headers/asm-riscv/ptrace.h              |  37 ++
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/unistd_32.h            | 446 ------------------
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |  21 +-
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/const.h                   |  18 +
 linux-headers/linux/iommufd.h                 |  48 ++
 linux-headers/linux/kvm.h                     |  46 +-
 linux-headers/linux/mshv.h                    |   4 +-
 linux-headers/linux/psp-sev.h                 |   2 +-
 linux-headers/linux/stddef.h                  |   4 +
 linux-headers/linux/vduse.h                   |  85 +++-
 linux-headers/linux/vfio.h                    |  30 +-
 migration/migration.h                         |  17 +-
 migration/savevm.h                            |   4 +-
 hw/core/machine.c                             |   4 +-
 hw/vfio/migration.c                           | 195 +++++++-
 migration/migration.c                         |  65 ++-
 migration/options.c                           |   9 +
 migration/savevm.c                            | 146 ++++--
 hw/vfio/trace-events                          |   5 +-
 migration/trace-events                        |   8 +-
 scripts/update-linux-headers.sh               |   2 +
 53 files changed, 1109 insertions(+), 580 deletions(-)
 create mode 100644 include/standard-headers/linux/typelimits.h
 create mode 100644 include/standard-headers/linux/virtio_rtc.h
 delete mode 100644 linux-headers/asm-s390/unistd_32.h

-- 
2.40.1


