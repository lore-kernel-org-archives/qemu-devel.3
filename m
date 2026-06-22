Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CC3CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbeU-0003yo-5p; Mon, 22 Jun 2026 06:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbeS-0003yN-IR
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:13:12 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbeQ-00060r-2d
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYsPqU4vKAZ3qPH2WteWkV3TKsWrA5JgV0VewTBGAuLXFXnwg4rPmhi+hO9UPAw1HwtBSxivLc+lgFapP5G6jc3brIfxlwbkUnL3HPr0hfCKqM/zBFUMVHurMOwQSaoyYjY1ZDKOZTMdg9NhvDca1HYpENYwrY9+M3Ui131RGdUvq9N6L80TxlfUD2IqhKguuO7BIpU6gW6FsCh2BPV6LfmqLnkE3o5BH6wEKvXfBqeCKucAzc0TjfLWEExjKOa7VWGFmeYAOOuxyG6f91snfo6sHYYYsCEqXWjPqP+PpaXRbtWhJL2au6iQhc3nrRniAozagZTLJ8WVltxjoMfJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfdQ/vWPIm7K5m4bTiMCSs8AeXW47R6WnQVGrlL/VPY=;
 b=KLHgPxzsVPZCd1VEe7XIibCcEPLSjEz2cfCVtPkFGf2ZwBAgI1nLj10XPuVzhCN9dtzaR9EeRfL/Za8RcNfR27xeBIGCU4rCYEg2W0LWhIiRsvU8xRXs2U6hAmg1nXpsmA0mP8/aW5KFnCM/LicqPwEj7zOxAE3+BMq3gn0T7c7rUf6+MWpbLgkfmmFRZpu+Ks1PQiij3O2SKEHlUKsFklPKD/EHi2sIyYgjCokYB+zxo/D1MajLDLRGwbXQeIIXcoWmRzfHntVjiq+qsiCeDau2rWQx+NW0ZKNx8QQBY+Srw8cqqKoK/pi2pOfU7rJjJZf+ppxuuvOdkvUqEraDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfdQ/vWPIm7K5m4bTiMCSs8AeXW47R6WnQVGrlL/VPY=;
 b=jRvFWrf49a2rJVHWHQ24KzVf6Br35mB7VW0vN69gTEJfabOGo4q7ACjU9S6Eo3MT49PcF9hVytbDKd8nMLvB/sGXtNs9HOnd+uITIn5ARiqA0oCpS3ONPKhKamHLWlfKzGavAER+nlqhi1sAT+abu/GuSjtvvs5fi3rr3b1JgpCZild2lV6VWGa6Le/pAdbz8RJAFJuQWKOi7hI/ghPF7sjTvArO26zuNfNLBlOMrHIn57209lh6jmoAvTiFqnXPc5xYyIQ7k+wza7YeL93NR3pBNh5xAbq/Rj4eGVG75b8dtBpUNSyUg0pK595nhLoOrcO9REycY81smKOJapmFIA==
Received: from PH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::15)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 10:13:00 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::7d) by PH5P222CA0011.outlook.office365.com
 (2603:10b6:510:34b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 10:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:12:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:12:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:12:44 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 03:12:39 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v4 00/14] Make switchover-ack re-usable and add VFIO precopy
 REINIT feature
Date: Mon, 22 Jun 2026 13:12:00 +0300
Message-ID: <20260622101214.25770-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 933e6538-ce49-46fd-1bb0-08ded046d66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|7416014|23010399003|82310400026|1800799024|11063799006|56012099006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: ofMncqn9IhpjBnpqtr8zB8i23rLbdwZIfbw7ObbrubeZVUS5ko0I0te2yPLaB1iR2DiGhrY7yqWpBZTUPw9Awg9QhE9nqybPsYUZVLN5+EYbvCRPce1DFpt8/vCbA9YO+U7+W4Xw/N6eVAEW0vKLHHtRJMKd9ckM2aimHe6mi4RgpHHVX5rvWcpv6YfSsb4ttduoJjdrKlfwa+h2N9UDD48q63KphK55ohSVliTNtklSBTZX+dixzhAGRLTIc+RhiXgya+lTiaG965LZe1Eo1wfdnrXXKl17sRHXPm3FcjX1UWb9TZ55j1aBOMhlZXPFug4iN4+vz6kCqScUTI8r20PQLMncIrCGw1wAv3rERxg34CM01EGjwUN+X7j9rA3KVrwK7DH8sNOm06VanSs3g5pUB/FXTv0+Fin/ap1kqXYJgptK03IZVIg2cm+1J+syXHgYHwg6fH9cMHe/aR38X0HXCVU8Exx0gYu6/hCLcAqyKtW5JFa9zDaUqDYtvp0Q/oLmKYLaERIq2WeXkk+5J08l82aLbmuzENFz2F8nCP3c3aYiE2UCpy/8QDP1yFnHG+BCC0y7OHVZo0s7/qYeJoI7pBz32uZ6zJP2K+chhOnU2y4mP/MsyU/B3I8/caujVNla8yfRhFm/nxDp5krik/SOCZWH3qchfaLRvUEqN6Pq9mmu+Hc9l8ztmo4BkHpoDFK2lb4UoxGg9bFuvfUiGg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(82310400026)(1800799024)(11063799006)(56012099006)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z6j55YtEi0iT5yEteQcp6rG+V7/4WrlMnsWezHtxrN/geq53y344keZKL7ffuA8eSYBgy44643TWu1T3goAGo+/epo1YvYqyspDRtb97epniQDigvWHJIGL7ncWlBqeqO63uXk8jTIkuQgn86ZkxOtrPFgSDiOziw5DUJSlj2X5VpAcsWZ0NF8H9F/3AaGDHFyDn4D77B0ImI5aZ5pxuwJ66qNsyDWxmmiSdKastugAtCM9T5DZQPWF18q+qz2WIAWG4ncokbKlPGF4dP1RS6K4xMFppnsqlg0p8lxZ2QFBpX4XN47n5sYefjCWWyfIlvIyI8NYH2k+HAefDLIb0yTh6XDCllmE8EMhynZk9ulEOhTRWhAGt10xdA95wIvkGBbrjlDJOlPlIvblMyVxbiGZGMfhWtsaBQOzHzjkjU+sGuVrq2ojfO0B682+V7QQ7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:12:59.5939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 933e6538-ce49-46fd-1bb0-08ded046d66e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=avihaih@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hello,

Changes from v3 [4]:
* Rebased on top of master.
* Patch #7: Moved switchover-ack-legacy machine compat entry to patch
  #14. (Peter)
* Collected R-bs.

Changes from v2 [3]:
* Rebased on top of master.
* Patch #1: Added Error **errp parameter to
  qemu_savevm_state_complete_precopy(). (Peter)
* Added new patch that replaces migration_bitmap_sync() with
  migration_bitmap_sync_precopy() in ram_postcopy_send_discard_bitmap().
  (Peter)
* Patch #2:
  - Dropped dirty sync from ram_postcopy_send_discard_bitmap(). (Peter)
  - Added explanatory comment to qemu_savevm_query_pending_final() call
    site for precopy and postcopy case. (Peter)
  - Removed skipping of final pending query for cmma, vfio and block
    dirty bitmap, and updated mig_stats.dirty_bytes_total
    unconditionally. (Peter)
* Patch #6: Rephrased switchover-ack QAPI documentation and fixed
  return-path markup. (Markus)
* Patch #7: Moved new switchover-ack requests check during switchover
  inside qemu_savevm_query_pending_final() and used local
  switchover_ack_pending counter instead of global one. (Peter)
* Patch #9: Changed vfio_migration_init() to return bool. (Philippe)
* Collected R-bs.

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

* Patches 1-8,14: Migration cleanups and the new switchover-ack mechanism
* Patches 9-13: VFIO cleanups and VFIO_PRECOPY_INFO_REINIT

Thanks.

[1] https://lore.kernel.org/all/20260317161753.18964-1-yishaih@nvidia.com/
[2] https://lore.kernel.org/qemu-devel/20260505081423.28326-1-avihaih@nvidia.com/
[3] https://lore.kernel.org/qemu-devel/20260602092621.382-1-avihaih@nvidia.com/
[4] https://lore.kernel.org/qemu-devel/20260609075812.32067-1-avihaih@nvidia.com/

Avihai Horon (14):
  migration: Propagate errors in migration_completion_precopy()
  migration/ram: Use migration_bitmap_sync_precopy() for postcopy
    discard
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
 qapi/migration.json                |  14 +-
 hw/vfio/vfio-migration-internal.h  |   2 +
 include/migration/client-options.h |   1 +
 include/migration/misc.h           |   2 +
 include/migration/register.h       |  56 ++++----
 migration/migration.h              |  34 ++++-
 migration/savevm.h                 |   9 +-
 hw/core/machine.c                  |   1 +
 hw/s390x/s390-stattrib.c           |   2 +-
 hw/vfio/migration.c                | 204 +++++++++++++++++++++++------
 migration/block-dirty-bitmap.c     |  11 +-
 migration/migration.c              |  73 +++++++++--
 migration/options.c                |   9 ++
 migration/ram.c                    |  40 +++---
 migration/savevm.c                 | 173 ++++++++++++++++--------
 hw/vfio/trace-events               |   7 +-
 migration/trace-events             |   9 +-
 18 files changed, 476 insertions(+), 188 deletions(-)

-- 
2.40.1


