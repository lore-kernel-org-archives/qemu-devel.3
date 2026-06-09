Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F9ECD8CAC
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrMq-0001us-Qp; Tue, 09 Jun 2026 03:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrMn-0001uf-QH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 03:59:23 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrMl-0003R2-Q0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 03:59:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZouuwyR9y2+cgJp3HKTzRC8CpdcNclTDL9cQRA5JbvrYDsfxzkbWl+NaQUS5i73VSGSoMLfyaMSwH6+Hggf7ul6aslQ7ashrJTF6yTig0eFkLp5Nh9aRc3T3jzlLU8ycGIsomhRy+PorCkwCDRdiY0pBVUX2DcGEktoM+h+NV2A/32ofmQLeOoX6njMWbJVbl0Rzb6fy2Do0d2/Mz/4Jw/wEdy4I8MZ4n7qWTO0dZnftDxv2srjH60V1trgCrS6xIqqMEful+aUOZMDN8xLIpRSJZI15xTU9O3SEXATYFiO958N0uJX8YQzYtkqxcfa6xa4TwsG1Ey8od/Yhcg+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFq3YiKMz4RpqdOm84WQoj3vK+ZVFUlrFFI4B7g0Y+A=;
 b=XoWnbs26uH87ENhC04mvUwl/tsp8334QsNdwuGB4TTy6K7Or3KhWvAzfPv2xYPkoSc2qSa8yGIPCZ7KEYS2dGldLeM64J3QtQp6NFTEivfzIwYqTNbWcyHLgoidoHkTDRlTOte40FZ3H5jKG1gPMt9jOAxwuc5B6gLc+WxhxLFJWBpnpvyv1kg6U1Cs57o1b6r+43ifJOCtAV3EbBSASGy0g03jpoOeWXhN3OKNb6+MKWwpKs/O9VPfNSjlA4GjCiGuiz/6Lyuj3kSmaG708BfQlPXZSCwOkwrDHepGpfKPuc/IEAPiU4kk1v/y5pujADV0OYfUXtao6rsji5oprwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFq3YiKMz4RpqdOm84WQoj3vK+ZVFUlrFFI4B7g0Y+A=;
 b=WM6omTAIlV8PTF0JpRbRQqFh2CvqEPAwEg1d9Xddd0OQmjlJMht/YVr9ABwG+25Uzff7DVrQB3KKhL7U4LW6YcxeiZOW/9BQeT5O9WVWQPJ/NEhorbhRh7AH/R3b9GXRufgaSPnq1J3ITe/BcgJHhhpsE1/5t0N2a2jxjciqQ5eGz4tldbRAIQatIccw85CwrrrLTk7k1GDoOMrxoYj4WAPRUOojYCZRXbruCd/JiSn15Zvhfncm0l54IdNqHdCKfTzGi1CcVv0xnAkt2cnYtMit30u+8cOEzo/ChFCW1Qg8YrzUcgmE/NxxO2OSvR/FODIjuc9kCULBK2xsiyNj9g==
Received: from MN2PR16CA0052.namprd16.prod.outlook.com (2603:10b6:208:234::21)
 by DS5PPF922753E5F.namprd12.prod.outlook.com (2603:10b6:f:fc00::65a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:59:10 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::90) by MN2PR16CA0052.outlook.office365.com
 (2603:10b6:208:234::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Tue, 9
 Jun 2026 07:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:59:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:58:52 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:58:51 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 00:58:46 -0700
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
Subject: [PATCH v3 00/14] Make switchover-ack re-usable and add VFIO precopy
 REINIT feature
Date: Tue, 9 Jun 2026 10:57:58 +0300
Message-ID: <20260609075812.32067-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DS5PPF922753E5F:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe14c72-6b62-4b2b-0e80-08dec5fcfcb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|13003099007|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: syWQMmAdatVAg7jWqkaZ+GlE4DyZI/keV33t7R83aRUTMvLXTUBwTjgO9Gl/d2oRBFRQ+4jBAkFFqVPsXXZ6mOkEHAbEzSOAR6qiGfGrg2gmJfOPoIMq8SJaLMFbjT+AlsIuFc5135a41gVInl7Ri2iFl06u+iso2tU8RtfxOmqgjpTCWeVlbFcGhbZuCHYoZGFqqm0eJwkVAKZQLhPzzLYcGy4fx/Aw2rfyFCDv+VeRat16ft3JmnMqpopE8uirJ3mRB0hcSkM+GH8x2ftJ58Z/x6HgVzJGEwQHqV/FGNm1dx/nBgAE2bDkjVMp+MM/Vor5LQCDsluUF2O0rsSavlhTquBfZOVTngKvPxoJn/cs+fPVatdg6xlUypDqGbuphLWw0LDVZTUImd9fF5i9W7D0fNNdU0hoO3eeDIjIAeXasclKcib3MVAby52VekBgJTetkGt0nLXSOh9RZzYZ5iFe8PAwKpl7sYml1kps0wzOshDnC/gsaMZe4zq44d5LFzJuMKQye4jtBW3rrdCaVwccV2kSUT0utvG/eNar+6L6limxRs4TAEvDONN3MZF2ObnytJ+atcBIUeU+Akzq2jLa5BAGRyHPiJL62Zs3zdfh+RkyDud/DeR3mSHRJknkLwXxoKvEAtinTjbjN4HZMZ3fr/DUQ5pBmg62DLocIG3iqhzUi6vP/XKOBejHESSIV63yp+KE2SXLsTeVWMlmOICvdyfslzEtcUj6rR1VyEI4URssoFVott6lq6jRXrIv
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(13003099007)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H2JwYrlPt8ocughe8bwn564bzHpkczl6qT4GZV50lbiRC1XUdZRuOYFS3f2Di1WB/nGVRwKEmAZYlyWs/J9DftYrwCQRaC/HggGcXzM0C6AsSiu8tj7E6pIapHC01AVpOhshs1QAemxadUMCEI/eX/Y3V2/GMO3kUl6iobeJNUaR95bwB2bhPAEdfl7hQ4SoVZOfFs89+m9SKRq6yDSzYsj3Oa1CPApaqrrUUBTrDBTnWRqnEsNZ7sGghIFB6GyVBIGQOlIZx+raqmkPn6tGiCHffltCQnhuOMdWSJqDF6E573s0Q6h+d15pzjJybZytxW8S/lCwFAycSCv6Rfcy+vhskyEqbpcfpIHji2xfFTTZJh37OHfRCbuQ1dBOWE9M2QruGwuN/zKmKoepyo1GyUuOG/+CEgiN6KjPbNrk4RVGTHq/wwzEcY+az7s3n9wH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:59:09.3226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe14c72-6b62-4b2b-0e80-08dec5fcfcb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF922753E5F
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=avihaih@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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


