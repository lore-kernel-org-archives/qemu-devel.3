Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65425C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 09:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4zsF-0007kq-NS; Thu, 09 May 2024 05:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4zs4-0007ja-QJ
 for qemu-devel@nongnu.org; Thu, 09 May 2024 05:15:24 -0400
Received: from mail-co1nam11on2084.outbound.protection.outlook.com
 ([40.107.220.84] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4zs2-0005n4-Qq
 for qemu-devel@nongnu.org; Thu, 09 May 2024 05:15:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvFiQacWN+kvsI6UTadzrqnp1OBGsTp6420YLAJaDPefLAuwt9ofV4t7pgLD1v6Oy8PmTWZeDKWGWaUa8jCQAbrZjdnDgcbDyk7fgjd/+noL8ssKPWuLZNc4nvHr40fZ9yremF6C2RFCEyKjiQwt/VCOYhaFDnTBpbtbk8a2rrquJJhUUyP29TmUuwgN0t3qRGfVmQeGcU742x66ZbhTR+HNVtIxlUxmRc9+Qq0qaWvbIz+sNXelJE7s1ber/3sUqRWQqQFb1TIYGjNR+xCU1wAO033wA5ODc7P0dYE++FP9y89lW0WofLZAuuvNwio+zhEaGvpVdddhjPesIfn90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VXi05EyuMj1VxPxRYbsUPnj4maZCV+ITcES+wKYJsI=;
 b=cLLisJUMMnIGSx/uDyPppE0XtA0UCJ9JMKroXJsx/ut6QUt7uea6HzSzVTi9m/tMnYheBtkLQJw6X/61FStZ+nu9D6Gr9CqQIljUOKIsMK2H3azW5vq2bSxPl85mthI0gHRNEyk5g8I2QjQ2c9lEj6X5LSD9wRaog60i6ed5c+1g1PACijzAbpR+7ZPpK8wNYH6xSmL8hA3i+aC7Oz5ruaEDS3/Fd8LnfaeHTYpjiofEGO5y/vuYpXHBzssi3ZLZET5JsJSturKeN+NyyvK4WyKlgNZgi/2+09zPtyJ1EEm/kBpYkAbarL4OufzYOMo83sTaE2KK4DyAmj+IbmoUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VXi05EyuMj1VxPxRYbsUPnj4maZCV+ITcES+wKYJsI=;
 b=GK/UVAm/px+f3eLWB8v7TbihF0OyRbH5jJJKkVFvNoiUPI4/SXYXZIJuZjqJzqzcYcPuZ6Oc6NcAcjFZBltHZk2HehDNxSHUMHGKgxMuKgnaMfi5H1iXy25NvANs+v4uFTG3rzuOS/KIUzZX3tXDVG42CRZlfS38zOBYRGYPOx7WeCQurEQT7Uhquq1Sovlj+V/NtZJXSEk22MD30RGZPF3q0JjbeQ7zQxi+IBpeN1h5KSVpwjOE1Ly7cEAqNzzCSR0+TZDB/sfWCIefc/mUCp+Lu51HS+Wfagzu4fU/9mRJLxSphklR59FmNgpjLtn07rZ9qAPpieSp9gWBkxyRRg==
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 09:10:15 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::c9) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Thu, 9 May 2024 09:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:10:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:09:58 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:09:58 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 May
 2024 02:09:55 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 0/3] qapi/vfio: Add VFIO migration QAPI event
Date: Thu, 9 May 2024 12:09:51 +0300
Message-ID: <20240509090954.16447-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: f87f5af8-618f-4758-a0d4-08dc7007d68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v1jHvXmM5YlIgj1iTC4hfyoB1tLkQN/QyOV4Ie/Diap4dSBPRvZGX0qoCznW?=
 =?us-ascii?Q?SdmG3eg7Ph4WwNyQCovE3XYOxgTwSWRY8Nicl6l50sMSsDzU6NVZLmkn6j/Z?=
 =?us-ascii?Q?h0tTUaiJ4diQrNG9zwR7fcqO7kxYjNOHbl9TOTFXrcMmhpMJAUF1cVtfVskp?=
 =?us-ascii?Q?9bdagsfZa4layChWZizyrtr/d2tWN+Fy8KvbVIlQwX8r6MbLC4lklM3St2mh?=
 =?us-ascii?Q?1hPgT/smGpu7rA78WUsr6g5Q8fMOZzYQ2rCyU8FrX8BhD52XTZerOO3UGpsO?=
 =?us-ascii?Q?Ghc/sMh4FG4Ud/BooxkHhI5/jS9ffH/Y9sZlK+HKj8TGnDQbFH9ALnlyG8vN?=
 =?us-ascii?Q?8QvMWw/sxRXtsAcBUpRDDfYKOR9D6bNSyl8yYpjIwoKaCBSvEWOofrUOvgAP?=
 =?us-ascii?Q?U2uaH/b245qhVG3tjdZJirqjsY9ehAFH9bnXMyBQu8KqAXCBQXJEvrggLqn0?=
 =?us-ascii?Q?wYkrodIJZazIURokGZ2voBUTL1ciEGrzGb0E+ERNSrsvv9gUKfcnwwW1AMkW?=
 =?us-ascii?Q?E/rbI/517ZFEOTMJ/DXIOGrnnVxN8zUjwIRea3uvU2yDaUTMB8vOGZvjQbJy?=
 =?us-ascii?Q?hCHcOnyRkoFQdXfyJYXn08c5zXHHnnypQZwcwKdrcZ9sn4Cqe7I9zEjXoa5Z?=
 =?us-ascii?Q?OkAN5Gt/m6A/9HEWv87MM8CnEZnRyQBxI5DrovW9bqUITUXO6c5mskoflLlB?=
 =?us-ascii?Q?T28+EWCFgLEjfRocWVxqEwcbygqGmsX0qd5n0VsbWYzZtPeVT/Uj03rG+3LU?=
 =?us-ascii?Q?1+qY9qdNsNkJYD7AnAeu4z2brKPJ+PWSlK7fnW5IJF0FEElfPlvnWKntV1SM?=
 =?us-ascii?Q?VX//NUhGNd0YtZcVUTJbWt9cl40uemnLvr6mUgDLdOnk6odhrvHyGKEArO26?=
 =?us-ascii?Q?uKtWyFR81DLZOeGtkkKhVpH4sRa3cXOHBMyqpWi0miuf7EqasZc3wqJogeOr?=
 =?us-ascii?Q?ckK8JZHLuYFZnKh1mNENYBC/99hp4Efphed9Sov6mRoMcTbSBJxxv0Otg1k6?=
 =?us-ascii?Q?HtDbYVeHttm0v0xHE4EcSDUzh/07gUQzV+ITzQWFbXWs1U14CKZtEt/XUAWt?=
 =?us-ascii?Q?yUjj0fMZPQyWLmF51DFaIp6CuDqpdLlnH+R8Yjg3GBhssqOFETDuuNPlcsY/?=
 =?us-ascii?Q?QoR9v7v3UAWcmxgbcB8J74KyhwrJaqXUnR+ZPWsfSeXOPF3rgOL4sr5XH+4V?=
 =?us-ascii?Q?HghYkjjOvRXrZHBZqhKKk98QEM56IFgQvgDLfZwy+kFyhzKTnncSHbaUk/37?=
 =?us-ascii?Q?O7NHXmi/bDKrVe2Q3r+Ny0Et5MiJbY9CbMkAGLE/TPobcW/GiELjC5S4U7kt?=
 =?us-ascii?Q?K6v+6/+FXO3ClBjt31Le/wD29/MQKTFqWEgJC4rv0+F2sqMq12/tWN/8qwkp?=
 =?us-ascii?Q?9mSTUf8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:10:14.5049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87f5af8-618f-4758-a0d4-08dc7007d68d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
Received-SPF: softfail client-ip=40.107.220.84;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

This series adds a new QAPI event for VFIO device migration state 
change. This event will be emitted when a VFIO device changes its
state, for example, during migration or when stopping/starting the
guest.

This event can be used by management applications to get updates on the
current state of the VFIO device for their own purposes.

A new per VFIO device capability, "migration-events", is added so events
can be enabled only for the required devices. It is disabled by default.

Feedback/comments are appreciated,

Thanks.

Changes from v1 [1]:
* Added more info to patch #1 commit mesasge. (Markus)
* Renamed VFIODeviceMigState to VfioMigrationState and
  VFIO_DEVICE_MIG_STATE_CHANGED to VFIO_MIGRATION. (Joao, Markus)
* Added qom-path and qdev id to VFIO_MIGRATION event data. (Markus)
* Handled no-op state transitions in vfio_migration_set_state().
  (Cedric)
* Added helper to set VFIO state and emit VFIO event. (Peter)

[1]
https://lore.kernel.org/qemu-devel/20240430051621.19597-1-avihaih@nvidia.com/

Avihai Horon (3):
  qapi/vfio: Add VFIO migration QAPI event
  vfio/migration: Emit VFIO migration QAPI event
  vfio/migration: Don't emit STOP_COPY VFIO migration QAPI event twice

 MAINTAINERS                   |  1 +
 qapi/qapi-schema.json         |  1 +
 qapi/vfio.json                | 67 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/migration.c           | 60 +++++++++++++++++++++++++++++--
 hw/vfio/pci.c                 |  2 ++
 qapi/meson.build              |  1 +
 7 files changed, 130 insertions(+), 3 deletions(-)
 create mode 100644 qapi/vfio.json

-- 
2.26.3


