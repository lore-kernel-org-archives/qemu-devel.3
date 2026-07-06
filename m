Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72271C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf5G-0008KP-Np; Mon, 06 Jul 2026 04:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf4f-0008Cv-IC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:53:18 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf4d-0006Tm-1t
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:53:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoPbRtyzPkPBRNcOz3Zf/olqYwcMIcVpiLbUjeXLPKYX2Kg17cpN4R1yQRAr3xj4AlKmFtkoPPumxTmia2oBMDTOX3ByHoUPH4psNqbgIGIIvJJ/BqeB7qVjPXNNeInzsDVUMH5v4vTp+quai96sGXpF+00z77slKhhiei7gKMZuHiGNaZ4JXUDg9Nh/q1Y1qEiXSWFLe13+MYR53Z3NMegLR5O+IgWOV+gADHyrUrl62Uf2JHkTY1ecBIocWhbHRg/kpdBceRR6s3lmPxba3WtBx1HH2d7f6DI1zDv7WVC3ONHnTTUtAKH60o2Yhb0xwsOzfgyo9n6rr3ikeEV/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD3LOwMNfBP3KwVhgyllRQaaVEfMDr+FkJucylR5Xrs=;
 b=nWMJ2mhYJQHwPOSB31p9BFcLCLgOa8qoMSfsyOBaF7rNxxObBJSgcehs/xTcs+Ud+1jcdRYdUTbU/Lu9KCBJIbmzNM3D1zrCBjZa7tn1yuzYuUYWxh3mSVnLoSBZp2RhFXXb4/G2EB/b7ffOviU/ZKKGLA/UeXH/Y0/Fg5f/oP4jpihblQVZoSeswNxV0RNSX4Mjca+2hIBgAx3q7bDbCalbamTs5wj2j5pra7NJZlvoaKcwwlmqkRWdHCCcRmz0gmQQ9SuY68zbAtPjFBAWUHAr9Bu92Zn2NZvcEZno8D5r/autXj3Ueq5FUhobgwWRjyiHQMUXjTXf8EkoQRw3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD3LOwMNfBP3KwVhgyllRQaaVEfMDr+FkJucylR5Xrs=;
 b=gFwrbbX7+0ePr9QJUOkfeqyTe06ZyXYrZLnWS2TUvBMClbjVkatgWQcHH9nmSsYbm5su66riQ/gxhmnTE87HabwP/gStjKOeay1UG3Ccb2oK8fL5QRYcFJM77MQOz+KhQFPPNTt0piWLPM2UUc9W02cc4l/mKuFduQwD5ltlUz/dX76fK3/92jxrwmSKxTdpQ4mZkPlLwVLO0Dii19kDoswEzbUike43S9JDV5gEZEAlM8JBEIEF7M9jCcZcezP9LxRH+6OAvWnHPNFXERbNsgkK1fe8g6OUFpkRJJKw2zhsBhYpA1vpHDleUfWB/Lg9Twr+R9eLum8DmvtU6B09TQ==
Received: from CH0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:610:e5::32)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 08:53:00 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::f) by CH0PR03CA0267.outlook.office365.com
 (2603:10b6:610:e5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 08:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:52:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:52:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:52:43 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:52:37 -0700
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
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v5 00/16] Make switchover-ack re-usable and add VFIO precopy
 REINIT feature
Date: Mon, 6 Jul 2026 11:51:55 +0300
Message-ID: <20260706085211.13905-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cad6db-23a4-4143-54bc-08dedb3bfb29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|13003099007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: J/P336dsLeUvy3h646DIcCvWiuSZwCllTRnOl0AWlBNPHNmaaHJZvHmd+kMGiLxOqu0z0Zr8A3sKtpMwHOdVKQTzGhtxHq07anGflPxC2xM4VEJHTAy3r4x5mcOZXxt1GV3ln/8duo2uSRyWE5hcCUrp5tEKmbHljHY8XvFZ/otbE7fapBjNufbirvN4518hJW7rCPcUff1qFhCq6pxECI8Vvj67hVy8lGU7EoMv64eaRogqcVUhqfYOcMdVKi+sANm7PyXT2Gjj7dLbjL7y39PgPw+mCzWZkO4QoEKJCR53bjrP9c4ql+hDapN9uFzGrC0LUO4Au9wUWfrr3ew9hNEVLBtsmkTkV9lhubWtGOYNNNgq5E7WfTQ6m3SHzE7RWF1nZJMTF0jHKXkScVv+6Hz0C0GFZfb6LzJNBZA5+/EU4R1aYSlMUqNolVlQF+rHHrqzMR7SgUzmuXlSB7/5fQ3lIov2Fz1Sh0PB8szkB6qXxbOVaQYivWOdWQhA18y70bZfCvZ/RMBzwkcPhLVgDmW6ubjjLct+ccCyPRAha9i6wO0iBw6YZ//aoUv/FxJzrowcrZcnkA7UDRX2h0QsusPwdUWboz9v3o/VPRE9MuTwiEo2AaEeb5NNNFWh1wV0kpr3NUNYHl9uT6wn3e4ufa2C35OB0C63hs1pHRALEyuOzMxUWdm0lyh3d5ic7qpJ92AoLSF96OuqgqtW5fsKig==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(13003099007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lZpRCl6WNMRXH0NeknQjeqpl6Emm0QVfXwXr8jFahF/p2Oj/VnfynkLjLla4qprlhkG5PO+GKtUAFt0wVk1CY9YT++xQQUDHmrB1TfjMF+9c9wcaHHdsPqqNo3qDLgW/2nz0Fw/fc8xwqZ8tx5/AYfmX0mU1clP3clDOvp3heK8lvgpsFSQtMq0AbDa12OvN7yerOw3FcFt/ehkmDsGXVLSdriukjvFcl1gHj0r3PKPMKg+JFnUVs523UhjH6q16RQNx9Fwg9XsJCsm+1JbLw6sOiyUlUNx2gQVQiwvAk8Pixg1I3xKLKJpaC6l5I51lt3wF+pAekV/FxGI6/fMltAAIQbPRu0fKTaM3EmX17NdhB2oH1gNMU2QAHO+opIPywyuh2zu8IyInkxi+VuzxbYdf7V7f+3GRLrSXvWLzI5oDBbKI7iktBSBAmekAfqf1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:52:59.4616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cad6db-23a4-4143-54bc-08dedb3bfb29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=avihaih@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hello,

Changes from v4 [5]:
* Rebased on top of master.
* Patch #1: Applied Cedric's change to error_prepend() message.
* Patch #3, #7 and #8 - Fixed COLO regression (removed R-b tags due to
  the changes).
* Added patch to refactor migration_completion_precopy() to return bool.
  (Philippe/Peter)
* Added patch to fix "switchover" misuse as verb. (Markus)
* Collected R-bs.

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

* Patches 1-8,14-16: Migration cleanups and the new switchover-ack mechanism
* Patches 9-13: VFIO cleanups and VFIO_PRECOPY_INFO_REINIT

Thanks.

[1] https://lore.kernel.org/all/20260317161753.18964-1-yishaih@nvidia.com/
[2] https://lore.kernel.org/qemu-devel/20260505081423.28326-1-avihaih@nvidia.com/
[3] https://lore.kernel.org/qemu-devel/20260602092621.382-1-avihaih@nvidia.com/
[4] https://lore.kernel.org/qemu-devel/20260609075812.32067-1-avihaih@nvidia.com/
[5] https://lore.kernel.org/qemu-devel/20260622101214.25770-1-avihaih@nvidia.com/

Avihai Horon (16):
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
  migration: Refactor migration_completion_precopy() to return bool
  migration: Fix "switchover" used as a verb in comments and docs

 docs/devel/migration/vfio.rst      |  17 ++-
 qapi/migration.json                |  16 +--
 hw/vfio/vfio-migration-internal.h  |   2 +
 include/migration/client-options.h |   1 +
 include/migration/misc.h           |   2 +
 include/migration/register.h       |  56 ++++----
 migration/migration.h              |  34 ++++-
 migration/savevm.h                 |  11 +-
 hw/core/machine.c                  |   1 +
 hw/s390x/s390-stattrib.c           |   2 +-
 hw/vfio/migration.c                | 204 +++++++++++++++++++++++------
 migration/block-dirty-bitmap.c     |  11 +-
 migration/colo.c                   |  14 ++
 migration/migration.c              |  98 +++++++++-----
 migration/options.c                |   9 ++
 migration/ram.c                    |  40 +++---
 migration/savevm.c                 | 195 +++++++++++++++++----------
 hw/vfio/trace-events               |   7 +-
 migration/trace-events             |   9 +-
 19 files changed, 511 insertions(+), 218 deletions(-)

-- 
2.40.1


