Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DADC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EaU-0001L9-RN; Wed, 15 May 2024 09:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7EaS-0001KW-4f
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:22:28 -0400
Received: from mail-sn1nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::601]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7EaQ-0007HO-2s
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:22:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwhmoTD2lEu9LnDgj6sNtDIxSEf7l9ICZm0XXUgVDDbVwWhS6U4saycinxMWIZZtY9q/7Ca93aO0lzmdwKvI3c5yAayGCmdEhK2gP2OM0ZqWGloK+gJLliX6ZXpkYs83MmzL27veLKdroddIklFf4eKB+Izb1DD2X7UIJ1aoZZtWl3JSHgqhkty8O1jMbRLicyFO+7XZOwdNjv2tIhLBW64mEnNbcjzFMrX3frJlRz4Kaq4cmgk96u7/vt0Gn7WpFHGQZFyFxQqAL2EIj7PfFHc0+i+6xMAiyvtTYNzu+D1XzFDbo29VKII/DhTrpmLYG8U7gWwlMKxpm2Du29SkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5akPpisdGNxEHRO1SLzA54myalXy/FoOcXu+Y3TWzks=;
 b=Z2eBTTthcSxlNDPSM0YUdZ4fIXm1g3ExrLoIdF8wt4+JYrpm8TkqGYPXXumZZCTX8LFmyrWe+XX9GKg+jpsopJ21Babx0JB/oRG3DSEfz5/4h9jlv59S2RtkI6ZCrFr7vJ3HpHDmX4mnw+zL9rM0LlLLQCaFHOYdcHknHlx1nGCpZPT2c9z+I3GUIz26jYLC60xpLxtphm1bVn4muQN7xT3tOAX4wrYa46auvSjTFeP1pn3aY/tRFnvW8pwUjly7OF8cfpvKyZlVkws4wtTTfxX2+2rpH7z+oQuTa53Pi0qZjWYgZ1EypPAIp/iZKG91y4sQ0k1nITITw6Qa1Oz6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5akPpisdGNxEHRO1SLzA54myalXy/FoOcXu+Y3TWzks=;
 b=jmh8pI3ypQKhIgzKoN0Cy+aHUZwPc+SertVCgkTn4G1VOnSbEUmksssqXEBUwCglyixmNY2n2tBe8XfOI2co1zIyNm6LLsEHp82gbLa2oyI/h6dy6w3GwHJ1INNXppOnEoXmrf7NopTVf5xP1dKWL/bFmBbkE0v2+3buo4aoBFdpDX1Iz6KiPECm7MW1nDVorNTz24jm6qWdMurOn4W9EXf7xeEXPQkrJhUi4KM2cVACEx/en3YLOJpGzds+txLtn13g/USoAh61gylfT6ygkeR8r9s6WvwP6mTb3WIMGa57JK5K16m8g1P2SvdBIirU+vRCUwBf/L/PuUl6OdZvxg==
Received: from BL1PR13CA0444.namprd13.prod.outlook.com (2603:10b6:208:2c3::29)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 13:22:19 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::55) by BL1PR13CA0444.outlook.office365.com
 (2603:10b6:208:2c3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Wed, 15 May 2024 13:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 13:22:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 06:21:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 15 May 2024 06:21:51 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 15 May 2024 06:21:48 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 3/4] vfio/migration: Don't emit STOP_COPY VFIO migration
 QAPI event twice
Date: Wed, 15 May 2024 16:21:37 +0300
Message-ID: <20240515132138.4560-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240515132138.4560-1-avihaih@nvidia.com>
References: <20240515132138.4560-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb27b94-d10e-4f8b-64da-08dc74e20ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW9ibUFqTDA0ZVR4YXFKczdYYkxCa1lEMEpsVEhvTkJFdTkyY1RiM2Q4eXp4?=
 =?utf-8?B?M04vWWlVMGxWZGw0TUtpMmVsMUgyKzFRZUg4eHlWS0lWNmFXT3dCeDQ0cjRl?=
 =?utf-8?B?L3l2SGlwcmo3NHlBNDVzd3VDOXI1TkpYQnRUeUdQWmhKQ2htT3pXM3g1SFZM?=
 =?utf-8?B?WVBXQ3N2WkFLa1RxMzJaSnZjaFgrcjZka0lzS1BKYWI3cDgwZkQxeEVabnc3?=
 =?utf-8?B?Y0k1czVES1pLTkJxUjFNQlQzbERtRlRybTBWODY5bzFpN3E2c0tjUXFES0ZB?=
 =?utf-8?B?dk9EdEZuZmQ0VmFkSFNuZnkwNG9QT3A1S3ZUcTJKbXhudWlmR0ErVnZnWDdh?=
 =?utf-8?B?S25VdlR6VUtBY2JEVGd1aldRMXNYVThrQjRtaW5icmVvd2k3MXpLU3R1WmF6?=
 =?utf-8?B?REF0Ni9zK2tmY2d5TU53M3l0dGRlYjN4czJ5S0FUTDU2VjRJY0xFUWRjQk54?=
 =?utf-8?B?eWVLVmxFRkxYbXpFdUVydnBManlFTEFpektyTzJNTTQyc0hrN0tVT2c5cWIy?=
 =?utf-8?B?YWdUTEhpQjVLQjJrUUhCQ0VwVkExY1JDQU5PdTNCL1p2U2kxdFRSUzFpdVQ5?=
 =?utf-8?B?VjNrVTFwR3NCTzVBZitjNndRYzlmRjFmVWp1K2F3aHNBYVBGWWVKY05GY2M5?=
 =?utf-8?B?SVEwOG5tcDRoMTdlTStOdm9QZzROa1dxTzMwTENBYVVBSlUra2VsKzFxRHFN?=
 =?utf-8?B?MDZHSllkQ3VSWHhYZE5JZm9vR2xqdW4rbFFhTk9rQXJKdmUvTnJQb2ZlWG4x?=
 =?utf-8?B?N1AxVnAvaldWdG9IazZtTWdKTU1sdXdmR0dWVmp2ckZpQXNuYUVJWng2NCtr?=
 =?utf-8?B?V0UrM2pRekRyVm95VEpFRkFHaStSSkllWHE3Q0NuNzlFQ2pFb0p6MGNSbDh5?=
 =?utf-8?B?c0dlODNkb1IyL0NQdTFLOWttZmlQNTBqWkdEMnJzWmFpQU9YM2FFSTRTTTlv?=
 =?utf-8?B?azMzL2c1OEgvMmtjeUp2K01aNmVDTllxbXZTM0oyaVN0dGVRU3BLMkVyVWhy?=
 =?utf-8?B?WkVaZE5rYkNCNkRzd3g1bVFwRTZHQlVlTDhSMUdndjliRnI4anZnTzI4dUQ2?=
 =?utf-8?B?aE53UzlZNGUyMm5Eb0krQ1ByL2hmYXJyNkVVeFhsVjZPeDJreGI3TG1kUGl6?=
 =?utf-8?B?UWhwdkhMN3lFb0RXcm5QK2V3K0pidk9WUHhRZWFxbUp6YkNuVC9RQ2g2a2pz?=
 =?utf-8?B?NmJpK0tQVHB4NjBCcENwVFZZc3FVVEV3a1dWMFZWWlowRkN0YVAycE1PRjF4?=
 =?utf-8?B?UXpCQUxhS2c4d3VRZm01VkQzSmt2YnYvWEhGUlIydWYzYXdKbTVVQ0xoakh2?=
 =?utf-8?B?LzdHdE5XNlJPbXRmalNVcHNIZC9ZSWJmUUNqOXBQRytiVVp2QldtWWlsUlNv?=
 =?utf-8?B?LzNNak1GTkJNSW0xc3FadXV3UElXZFJuZW1PQ3VWRG8vL3lzMVNDUXc4TlhT?=
 =?utf-8?B?eXo4TjlTTGFzMGVaU2xZR0hOTWQ5Y0pRZjNTUnRFTWVUL3RqaG10S3RublZC?=
 =?utf-8?B?TSs2Qk41b3FoRTJDTnV0RnRkNlJPQ09CVUd0RFViMFQyakhMcE9qOGp0RnVC?=
 =?utf-8?B?Q09tNU82YnBnM0o2NzVtQnp6YU0reUFxRlZRQ2JSMWRNTWFPRUovNE9rSTMz?=
 =?utf-8?B?MnRDZU54TU1zVC9VVkk5THc2bWNHdkRiTzI0cHMwdHhzVjJQR1J1UnVTUmZS?=
 =?utf-8?B?MFNLdWZQcEFWWFRhNUp0Uk14aWtlQ0p3REhta0FPYnRyMDcwRUpQdEt5UU9E?=
 =?utf-8?B?aUZoNEdUYm56dTFmUHNKa2ZNZDIzMk5uR2RRRXo0ckdCTWVTMEhDd3pFMmFt?=
 =?utf-8?B?SDd5WDROOFZZTFRzNjhPQ0pRcUNJdkpCaGRLVkJzNjlCVU50cklDalZFOWVI?=
 =?utf-8?Q?3yoVnKs9WoaS3?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 13:22:18.4646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb27b94-d10e-4f8b-64da-08dc74e20ba4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When migrating a VFIO device that supports pre-copy, it is transitioned
to STOP_COPY twice: once in vfio_vmstate_change() and second time in
vfio_save_complete_precopy().

The second transition is harmless, as it's a STOP_COPY->STOP_COPY no-op
transition. However, with the newly added VFIO migration QAPI event, the
STOP_COPY event is undesirably emitted twice.

Prevent this by returning early in vfio_migration_set_state() if
new_state is the same as current device state.

Note that the STOP_COPY transition in vfio_save_complete_precopy() is
essential for VFIO devices that don't support pre-copy, for migrating an
already stopped guest and for snapshots.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 2e1a8f6031..f2b7a3067b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -146,6 +146,10 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         (struct vfio_device_feature_mig_state *)feature->data;
     int ret;
 
+    if (new_state == migration->device_state) {
+        return 0;
+    }
+
     feature->argsz = sizeof(buf);
     feature->flags =
         VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
-- 
2.26.3


