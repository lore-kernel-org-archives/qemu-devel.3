Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA997C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2cu-0004cr-6V; Thu, 25 Jan 2024 11:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2cr-0004cI-9A
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:30:49 -0500
Received: from mail-mw2nam04on2084.outbound.protection.outlook.com
 ([40.107.101.84] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2cn-0001Vm-Q2
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:30:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5p1a2N2B72OgcEnpySZjwVupfZtBkObbN8+e7cTg8WsR5IbSZz4KvG4ZZU15uBH2jPUILxX8g1D0bI5HhkIJ3SUXCGCtZQTKpSmhkRQFAZ+AXioVp3LPK+cY2Dq4et/Q2taCZ2nb6u7/5kGsG06Q0eDkUhkaAODRku6wM4EmSZLkqsvuW8vMLgnkOtsjJiysJIQWjqZyUKkSzcm/8QGgPZefj++HRoH4FkZBfWIFiBpJXY/4984fgJccu5tczJRA2LY0lIPVECHjxf2zMALcFtwKkxv814noCptlKFmRgOr78YBie0imDuSolzvvk7YbyzVd5sW2FdsObjXBqYfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUeKX84Z0ksgv3Ii0eo+2R7PHDBxU8/ipQhyf/Zq1CI=;
 b=J/wUYPp/Ea1u8OjX8/QbVCSN/Phb2G6ifxrSejcz+SL5m1RwfNYtRB/PvB/utb7D+UsbSqUM1J2T+ke/7/1Aq3ZOSDHfLK6B+gj9IOXL3dTj9kgR73N4XI9zdtKOqvjvBa0fL9V+vLeOSVCQjDok4xDf1BMC90z0TMnihq0yze1PZ/LJ304VQnuSvXtrsIA4jzWd5J1xHGKnvETwxjEL5zli4veRsV/VaOGPy5hiy3HT+RrhRnBOf9zOTYHGYxbOytCjXOzIMXDZ7Z9g5Srj+wtPJXxKjuB1AymXDPEwDYY5+vuPFl4kEUXriblyv9g9kdDMjSht+QAFBQm69I8pXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUeKX84Z0ksgv3Ii0eo+2R7PHDBxU8/ipQhyf/Zq1CI=;
 b=QqRaM9JnT1gB+WGMeuO+WRGiQNmp81QpAJibZzYYr1XuUmkc1s4tOExWb0QOmIkXRtjWvRw92Iz+uXtxtluRVdQZnyP5AAcozgnRsyqOZiVlZrEV304PLlEXxzy50I3nEzv9mwA0C9TJcgPAzLPsEcPbVFzwrf8Dz6nmhdtctZ3bkx0a3Gbihlm6kykH5egkPXgtlKF10nkeuJhOjeKwdoONzvAKWCWv/oZPp2Lih2Re0wJHNo3Zu556cQYUdsRqLN53h8JsfBCYaZgJ76mnDIzehX/0oDHOJMDER6SB8/CQjoOKkyU1LXQLXOX/bjXWAmphoVVOJBot77MKt2keIw==
Received: from DM6PR05CA0046.namprd05.prod.outlook.com (2603:10b6:5:335::15)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 16:25:37 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::eb) by DM6PR05CA0046.outlook.office365.com
 (2603:10b6:5:335::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:30 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:30 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:29 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 00/17] migration: Add new migration channel connect and TLS
 upgrade APIs
Date: Thu, 25 Jan 2024 18:25:11 +0200
Message-ID: <20240125162528.7552-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2d6b6e-2e28-4301-c3bd-08dc1dc24322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BAN37wQ0LgkKxK3/nii4DtocPQkCK0vTiuhwX5NhqXbrhYvnO8ZvnfpR4Xng38ICRZnZsa11B7baLYAkKsvR7jLd0W5gIcu0uXXNFGInuHlBVVgDIQZ52PmlxCTisdtMVdCLLe/GX4H/P/Ss68MuiqQQ3v5a4TFBohDRaIlSf6Z79Ipfzygh+TIPvxbQjM1hLH6fMs7i4s+wGjJmCRJAQ8kpfHYu3TgXiRe9bWPtlJ53i0GooQqgoLhSvRFDSZ7z8zT9jocWrQP4G1gf0WDGlo2maixlT2RrtDbEkgEb5xx68S1jL7bm7d23qoq602EW//Njp00lkufx7/lucKJsBe7Y7xuz9QWS36MUmW+TQ7xuXqIAquFtGdW3zoLgc/eE5IaQrtSk4OakXkL/jGu8FUdWWSFCZ2gO4RQDCl9Vc+ke1P8iZ/nxEbuEB8orR5Y8dOx5QMFQD7oHzOOgZVAI7WYskbrfEVBGzpDxssodm3MjlOO2LKstIg1N/Ryt+hf10ZoaGoBQ/9dpfpyNdsFIC/2pkkpkvAhLPSdjTps06M+LZkcd3uxpk7ILGKIx3gOUe+dJyMXKerJ4zBzb1W/6N6iTWFQFPqSESXiLkgH9QsbbuD7F3lq0t7P+ebsyvPCrTFY8qm4xIdD8+2kkU4rcsaE1/zfBOV308LHSFq6wHVVr/VLjAgieJMxbZ8qGjjzVBXxxK+soh6SbaXA9PFtVXM2OdroIlsNiy0lRGqaXpU=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(36840700001)(46966006)(40470700004)(4326008)(8936002)(8676002)(36756003)(7696005)(426003)(2906002)(83380400001)(336012)(107886003)(2616005)(5660300002)(26005)(1076003)(86362001)(41300700001)(478600001)(70586007)(70206006)(6666004)(6916009)(54906003)(316002)(47076005)(356005)(7636003)(36860700001)(40480700001)(40460700003)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:36.5574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2d6b6e-2e28-4301-c3bd-08dc1dc24322
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
Received-SPF: softfail client-ip=40.107.101.84;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Today there are several types of migration channels that can be used
during migration: main migration channel, multifd channels and postcopy
preempt channel. Each channel type has its own code to connect and to
TLS upgrade itself when needed. There is no unified API for these tasks
and it makes the code a bit unclear and cumbersome.

This series aims to solve this by introducing two new APIs for the above
tasks that will replace the existing code.

The first one is an API to TLS upgrade migration channels. A new
function, migration_tls_channel_connect(), is introduced and is used by
main migration, multifd and postcopy preempt channels.

The second one is an API to connect migration channels. A new function,
migration_channel_connect(), is introduced and is used by all migration
channels other than main migration channel, i.e., multifd and postcopy
preempt channels. The reason it's not used by main migration channel is
because the main channel is a bit special and has different flows, and I
didn't see a smooth way to include it.

Patch breakdown:
1-5: Some fixes and cleanups.
6-12: Add new migration channel TLS upgrade API.
13-17: Add new migration channel connect API.

Thanks for reviewing.

Avihai Horon (17):
  migration: Fix logic of channels and transport compatibility check
  migration: Move local_err check in migration_ioc_process_incoming()
  migration: Rename default_channel to main_channel
  migration/multifd: Set p->running = true in the right place
  migration/multifd: Wait for multifd channels creation before
    proceeding
  migration/tls: Rename main migration channel TLS functions
  migration/tls: Add new migration channel TLS upgrade API
  migration: Use the new TLS upgrade API for main channel
  migration/multifd: Use the new TLS upgrade API for multifd channels
  migration/postcopy: Use the new TLS upgrade API for preempt channel
  migration/tls: Make migration_tls_client_create() static
  migration/multifd: Consolidate TLS/non-TLS multifd channel error flow
  migration: Store MigrationAddress in MigrationState
  migration: Rename migration_channel_connect()
  migration: Add new migration channel connect API
  migration/multifd: Use the new migration channel connect API for
    multifd
  migration/postcopy: Use the new migration channel connect API for
    postcopy preempt

 migration/channel.h      |  30 +++++++--
 migration/migration.h    |   5 ++
 migration/multifd.h      |   3 +
 migration/postcopy-ram.h |   2 +-
 migration/tls.h          |  30 +++++++--
 migration/channel.c      | 106 +++++++++++++++++++++++++----
 migration/exec.c         |   2 +-
 migration/fd.c           |   2 +-
 migration/file.c         |   2 +-
 migration/migration.c    |  47 ++++++++-----
 migration/multifd.c      | 142 +++++++++++----------------------------
 migration/postcopy-ram.c | 111 +++++++++++-------------------
 migration/ram.c          |   7 ++
 migration/socket.c       |   2 +-
 migration/tls.c          |  94 +++++++++++++++++---------
 migration/trace-events   |  16 ++---
 16 files changed, 344 insertions(+), 257 deletions(-)

-- 
2.26.3


