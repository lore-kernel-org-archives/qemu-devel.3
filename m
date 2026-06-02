Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861EBCD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULTg-0002HH-5M; Tue, 02 Jun 2026 05:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULTV-0002GD-GC
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:31:54 -0400
Received: from mail-westus3azon11012043.outbound.protection.outlook.com
 ([40.107.209.43] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULTT-0006W4-ES
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:31:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/cDKqNjl5bE9X0aNCzLQFwitGjORd7xRFkLFmXlHXQd4R+Ux1mwJPp+3fH36EhkobP7JW5YNK89Qg3Z6tH+gJymjb9cSOIq0fjCTNEFlnLfBiy7KGh5Y7QNZ2AvfVK2SWO1pyX8Y3ozUhEbdr75As2sh+FRPnMf+sWJ2HQjZFMlUt/PoYOZ4NOf5NGhJ2TxFf2aUkpPu11UARlaRPe/vxdaHZ0Op8vUFaNBcrG9KJp7INdwo/ek6kQgNHvq3+D7/a88WC6wtpBq64luKnXCgmA+K5stzXyqoCt/6hirzf+oTCCU2xDZsVm7E/mhbKQU2Kp9YY4yq2pkWnQsnQTYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nyKvVkTAEE3TKQ8o3l+zBuf96GNsdKgWAnU7fmvc3s=;
 b=yCYwGWXWE7UMcaoERZHB2aaplKuDXDJBcP0RangiCl675QiXTgQyaAFVNAx5jW6//8jwDooprzVKJx0gAAg6A+QGwyzPUBkEiivi4ujCV/C84e6fnJFRL0H7LhOB1nhBCf5vlP3QNDOoACAKdz+nH229iGJEEei4PjQYfPj8F5b3YgOUK0+fpgr+0xqX1haTE1Uwks9JxXsokcV0s/CFV1No8H8M+NTl5U7JmMlncxyz0R20cHLaXBxxBLsofpGcVPFVZ9SYrY2jEJwtTrmctfalkHY9uUWp2PaDx2ipxz2dMz1kQPWqQ87cERmn/jmnZFb0NTPa7OMaffO2no520w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nyKvVkTAEE3TKQ8o3l+zBuf96GNsdKgWAnU7fmvc3s=;
 b=aRw/ILanSvDHtwv3dbpGEXV7ylsmBB1G8FoaIBNGFiufH4dz7NJKfMvN6LPalWAsBBYTfsU5tnxgeYEaWPFITz3c52cLunbmaxZs7Y8qqWS6G8O/vdC5Hu8YWja9x+oqh8GIintqXRb9zlZmZNmXD60cHBWGQ7vBlDLR23vgka6djYb+zWjPNykWWuHuMidvBm7aqXWHaI6cOWyXv6zjFU/xhjX3Et+mYRHDVsDPD9Va5biIFpff6UN1Am/OzbJjl/avdBkbGjvo+rldki/Wy/nUEAJdWPyzDS7hGbtU3vBOD48v2mxFSJqufSoDfV/wxEgn8OcswBlaou7c77YKsg==
Received: from SA1P222CA0183.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::7)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 09:26:43 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::36) by SA1P222CA0183.outlook.office365.com
 (2603:10b6:806:3c4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 09:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:26:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:26:28 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:26:28 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:26:22 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 00/13] Make switchover-ack re-usable and add VFIO precopy
 REINIT feature
Date: Tue, 2 Jun 2026 12:26:08 +0300
Message-ID: <20260602092621.382-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 2653109c-cd41-4aa3-1c47-08dec0890f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|13003099007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jNT4EZdtDQnLofscYru2SFGr2CHX74svqC2fHFP4DBj/7uixJkRejqtQSah6p8nx6XF04psohTNNCucT7AcAAaD5BG8DxtD7yrdiXxED3PlTR5XJtYdpKxpOFPSU9YRGLuNefCeJebtmIGwJN7R81nSUnyG7kzxJ+CzQWTjZ79l62NE+uRQ/8Q/frc654QiQgdHQhaOvv+YgcvEphtUHTlufAOMDcM/ZlfF0s3d9vk3p7KmBK9OKWdOaRofxUWQmMMfycU0juhkL0odjPV/2VXkSBIPYSlWbXoutr1uMQyLJYVt/LGzi1oyAkjxmUBH2LhlGL2fqvrnksyI4Szt2YKI2SV11Q8FCghCDfVvr08Raiks/flQMjhRPGotpN3t2DkL71+kP8uKNdm584IiYzYvTRuTRf/5oCWmwT4PMPl/5BU6IqSsSHSWNjhTk2f2S7GOdJAqFQXneOgnU82GgtZEEWram4Q6RP0Ypxalg9nKDGNvbYyGCUItA+7VC5n98mcPNEFMtddaFV0wLiKXcZvQXaj6AgrN0Rho0IWBpYDZ7X1PNz6xE2KHj4l6MpoWNvgKX7D0Np9T6DwM0mSEwj9J+SHDsFiODujV8e1/vCK9pvbuhWsTZ1nOEYdMGtaIa5jz/aJLFzPVA2OhLDFoGfI5GGjrIiO7LvBDkJ4OFPGlpwiBOXKtdX85lzD7iNGSUgGZVWeRvxNM48kaLsM3svXO4JsOHutC/qTAYyiwb7X0=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(13003099007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CPlXxeNPIGTcIeS13xqjzL7Ttds49JCbRBswWjuqZejVvPufP+++TPiVVgdyfp1q6R0VtlWBkZDgv9Rb84aDp2OiTIIWAxcaJIBY116+e8IJcLJ5UmFLxwP0Xcd+aMrljYZ5xN1bxYKUYnJfx0Vrb298ntNVcx1VvO1oxbAC1xgS0dLfgAqS8FQ7DByVb6e0ZKu/EIv99mO5Ry/GKT0Gs0x1Nmx22VjFBP6pMWIRwaTkGzx86/+LK+NHKmZ4uSvz+A7HpcU9XTW2okWU3bNCqI2se2em39ZlZIqCtzLdIQOGqMR45o4w88sJj0mNd1FEomkaK9oC8pRs4H6S5jFsWAst32k30b+9lR6VvdUopd4Zgifsk4mwe8riRXcnBfK4P3i+VTggrLCAWzp4fJb6k5sdObLJ0EKYk6haEb67kIW/SZmRuUv5+pNiu9ByaCwE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:26:42.7117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2653109c-cd41-4aa3-1c47-08dec0890f0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
Received-SPF: permerror client-ip=40.107.209.43;
 envelope-from=avihaih@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hello,

Changes from v1 [2]:
* Rebased on top of master.
* Added a new patch that runs a final save_query_pending at switchover
  (replace RAM specific code). (Peter)
* Dropped patches #1 and #2 as they were already taken by Cedric (in
  some way or another).
* Patch #3: Used Error variable of migration_completion() instead of
  adding a new one in migration_completion_precopy(). (Cedric, Peter)
* Patch #6: Dropped renaming of qemu_loadvm_approve_switchover to legacy
  since in next patch it's renamed back again. (Peter)
* Patch #7: 
  - Rephrased switchover-ack QAPI documentation to be more general and
    not mention number of ACKs sent. (Peter)
  - Dropped the new request_switchover_ack SaveVMHandler and instead
    requested switchover ACKs via save_query_pending SaveVMHandler.
    (Peter)
  - Added documentation comment for legacy/new switchover-ack. (Peter)
* Patch #8: Adjusted according to changes in patch #7.
* Dropped patch #9 since the scenario that it comes to solve can't
  really happen (kept only the part that extracts sending of
  INIT_DATA_SENT flag to a helper). (Peter, Cedric)
* Patch #10: Used error_prepend() to add error prefix in
  vfio_migration_init(). (Cedric)
* Patch #11-13: Adjusted according to changes in patch #7.
* Patch #12: Added explanation about VFIO_PRECOPY_INFO_REINIT and an
  example to vfio migration documentation. (Peter)
* Collected R-bs.

===

This series adds support for the kernel VFIO_PRECOPY_INFO_REINIT feature
[1], which can reduce migration downtime in some VFIO precopy scenarios
(see the Tests section below). Supporting it requires refactoring
switchover-ack and making it re-usable; that work comes first.

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

* Patches 1-7,13: Migration cleanups and the new switchover-ack mechanism
* Patches 8-12: VFIO cleanups and VFIO_PRECOPY_INFO_REINIT

Thanks.

[1] https://lore.kernel.org/all/20260317161753.18964-1-yishaih@nvidia.com/
[2] https://lore.kernel.org/qemu-devel/20260505081423.28326-1-avihaih@nvidia.com/

Avihai Horon (13):
  migration: Propagate errors in migration_completion_precopy()
  migration: Run final save_query_pending at switchover
  migration: Log the approver in qemu_loadvm_approve_switchover()
  migration: Replace switchover_ack_needed SaveVMHandler
  migration: Rename switchover-ack code to legacy
  migration: Make switchover-ack re-usable
  migration: Fail migration if switchover-ack is requested after
    switchover decision
  vfio/migration: Extract VFIO_MIG_FLAG_DEV_INIT_DATA_SENT sending to
    helper
  vfio/migration: Add Error ** parameter to vfio_migration_init()
  vfio/migration: Add new switchover-ack mechanism
  vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT feature
  vfio/migration: Check VFIO_PRECOPY_INFO_REINIT during switchover
  migration: Enable new switchover-ack

 docs/devel/migration/vfio.rst      |  17 ++-
 qapi/migration.json                |  16 ++-
 hw/vfio/vfio-migration-internal.h  |   2 +
 include/migration/client-options.h |   1 +
 include/migration/misc.h           |   2 +
 include/migration/register.h       |  56 ++++-----
 migration/migration.h              |  34 +++++-
 migration/savevm.h                 |   7 +-
 hw/core/machine.c                  |   1 +
 hw/s390x/s390-stattrib.c           |   9 +-
 hw/vfio/migration.c                | 189 +++++++++++++++++++++++------
 migration/block-dirty-bitmap.c     |   6 +-
 migration/migration.c              |  92 ++++++++++++--
 migration/options.c                |   9 ++
 migration/ram.c                    |  37 +++---
 migration/savevm.c                 | 134 +++++++++++++-------
 hw/vfio/trace-events               |   7 +-
 migration/trace-events             |   9 +-
 18 files changed, 461 insertions(+), 167 deletions(-)

-- 
2.40.1


