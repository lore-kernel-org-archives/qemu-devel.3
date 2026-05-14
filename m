Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFCDCD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 03:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNMge-00084V-62; Wed, 13 May 2026 23:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1wNMgc-00084H-Bk
 for qemu-devel@nongnu.org; Wed, 13 May 2026 23:24:34 -0400
Received: from mail-northcentralusazon11010070.outbound.protection.outlook.com
 ([52.101.193.70] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1wNMgY-0005tx-PJ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 23:24:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLoPxUcHBEcCRYJciF38ZcqYQFMun1K7e9cGoi2BmWmGnOXbmfJ3EhO7nB1sAzJWZjEozwT13HXyI3WzHgsI7ZDoOfloEBrdMyy8//X0BF3l3bVQgmC1ch4LeBOEJeeDpwhPSZjj5tSAqIXLOTsAwWHt8Qo0CCAVTNyZ2maVkX1TlQz2hcRIhdgAdHwJrrV/sIwTwNaXjp38lDlSLtQiQD8HtLeVZwi9V+9CimMTddSZrPKDsK/SQL+8yn7fbwEsKEZMfl2o1WsMijtmIIDRffTD58p0kTygkZ/kKw+aaAH9FTFjfC8QMKlVx8SzVsti8O6H8auKHJUsjN7VUQikuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqred+lKBh3p1s7Q4f5BdbyXQYysRlcW1RxhfU7E9OU=;
 b=GS4fwLal/ZvI9kuXKWQu/6b1L6K9wG5i1+9vDyA66KpBMpO/KO/ygFoUJy8BfZAvrNmJq8s+nHd+zJJxxjYvltpIFGCfDbnkSq9TPTXeQt4FbpZ1+xYbnF2qPkKXTYeMn5qIWel8IZ24luvj3WoEmdq7gmCz7A1i81rkhr5nhTkV+Pq7ndSa3DAo5IXMKqP0h/XM4SpYqg7X2rm0+apr8MRyr2ttLLSHlCIEMNNeo1GR7YXI8Z2pTxPh5Pjpg09uzdB1BHoYzoCSVVNKkO5oPb+wmYjj9MCgGUaex26lK0TVfs8qv2XuTtjXrgL8zTwEb13T8hVWir19pZjbimyCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqred+lKBh3p1s7Q4f5BdbyXQYysRlcW1RxhfU7E9OU=;
 b=5m1gzm6Jlzn66Ws3iwMpc8d7Jekmxdx6DKWWXcUFVrzqs4rSPcbhWYu5LQ3ft6wAhuKSDg1XrOSIARUTM3MaSAxB1P03zY3yIJA5IL8V/lfiTJfXM8Hp+O01Yg1rcX3Z2XKjJwEhifRwSxlwFJiv+VJGGDtf8ZOEobT+z31UggI=
Received: from DS7PR03CA0351.namprd03.prod.outlook.com (2603:10b6:8:55::16) by
 DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Thu, 14 May 2026 03:19:06 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::e1) by DS7PR03CA0351.outlook.office365.com
 (2603:10b6:8:55::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 03:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 03:19:06 +0000
Received: from hjbog-srdc-36.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 22:19:01 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <qemu-devel@nongnu.org>
CC: <berrange@redhat.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <lizhijian@fujitsu.com>, <eblake@redhat.com>, <armbru@redhat.com>,
 <Emily.Deng@amd.com>, <Victor.Zhao@amd.com>, <PengJu.Zhou@amd.com>,
 <Qing.Ma@amd.com>, Samuel Zhang <guoqing.zhang@amd.com>
Subject: [PATCH] migration/rdma: change default rdma chunk size to 64MiB
Date: Thu, 14 May 2026 11:18:48 +0800
Message-ID: <20260514031848.2422203-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|DS2PR12MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb6e5fe-08f1-4d9e-a28f-08deb1678e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: zEqT712jD2sE2n9pjQ1ZId56zemEaDlf2XWL22O4W92MLa8tFXGrTWZyBKwOvoK81LwiQ/2P9TH0yyPATiMYcLE4Erj+JlHNC18a6QAHyTpiC3OglnKNnVkI0hhHMREe7ZwLwfnmOzKt3nLKxoeFWk3MdlJFeHMQCMmgYXLZoRs4MEUujVf+agLg+oTd4pcwoQV4YtqhfQ4VRgXFMS+Zlf7Q+WsyHZerl+ZJ4DoOhgoDBEZyxMw8Yg8x4bXiA+gZFtJg0wdJeO+hWr0pvj3AL3ygPucpkU7Qy/lNGuyO8nJ+11iXJ1UAsHTkgRS0BLnS9i9nGT2prJLHTTKakFkiwGFmdhvQqgcVH8fuNXTs5ubzSdYGf23UXYfgNVjdybOtqeshlPXubQveejJ8ywYy/vcKHqcr9Y5mN/fzHi+xcwECvsppXCIuR5unvAMFLcf3MrKZb7I1zoDqpbCPcGY+hR/Io0AmE8NfKBihJLrqFwe8yvmpF1EwwDKdZzzz9bGPsqqsIAo564hNpGspKF5vqtRi2jgfZU45aisLfSnwyd6SVi3RMzCL+GUjabebGI+1hdpQdANyc1IsnyfqW1ptk7JJW+FGDHPzf0FXMUrmGZQ5f5z0ze6j1NBaUJZ0/UxGHUX/v1zk1a3u4KTIwOO6dmrMjvceK23hZK92Bm4r9YaU5oKjSGuv5VLYa+q2vj32x+BJ3lZ3uItitQiTpIJOooKDeyWPpGewQsG6vhA+3rY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xKfqRlocoi2BLgqJS3PuxAYNS+3L8cp3AoEwfNcRvN9gR+itYdPUhjnd76SH8mNdaxDtrmQACIwM+ZwUu/8et3B1fzB7zFnqNYj0xIbnBCgPpFpCEOg4sa/5wXns7ylmXsRclB0uNBD80SDMQlzksMvwGtBrXNy8UxsEpuUcU5uSVVgZOPCBShE081xKz6res4k8fZsbFXUcLFq0zvfaQEQWqpnfzC11S01CBnA4Oq+Xq4rNwsKItjFg3Ehq3oR2FN00PBnYJbMzJHK0eumMCKExbg68ORCQBefybt307LZe0ktLR5F5oQ+3Xil8xQtutdyU6O+lOrup34RA3DhKGa6NSaxtARMB5ZYieQnx2q4IRErsBKsloqYKFllyNfbeCjIdf739GQGXXrqE4k1ZJBylQ9g5zsUJ3D+rW0K9vhP6lepsbBKrDNxEfnuh68BP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 03:19:06.4258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb6e5fe-08f1-4d9e-a28f-08deb1678e91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798
Received-SPF: permerror client-ip=52.101.193.70;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The 1MiB default dates back to the original RDMA implementation in
2013 (commit 2da776db48), and is too conservative for modern hardware.

64MiB captures most of the throughput gain (~10x over 1MiB) while
keeping transferred data low.  Larger chunks cause more data to be
retransferred per dirty page, so the largest chunk size is not
necessarily optimal (see 1024MiB row).  The x-rdma-chunk-size
parameter remains available for user tuning.

Test config: BlueField-3 ConnectX-7, 8GB VM RAM, pin-all off,
  `stress-ng --vm 4 --vm-bytes 1G --vm-method rand-set`

chunk_size  total(ms)  down(ms)  Throughput(Mbps)  transferred
1m            45,156    1,166          1,252.50     6.46 GiB
32m           15,034    1,864          3,401.26     5.57 GiB
64m            4,492    1,554         13,637.46     5.75 GiB
128m           3,940    1,662         16,860.59     6.06 GiB
1024m          3,665    2,238         24,676.59     8.04 GiB

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 migration/options.c | 2 +-
 qapi/migration.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 5cbfd29099..ea2137372c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -91,7 +91,7 @@ const PropertyInfo qdev_prop_StrOrNull;
 
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
-#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           MiB
+#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           (64 * MiB)
 
 const Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
diff --git a/qapi/migration.json b/qapi/migration.json
index 0db115ec5e..b3815f0594 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1009,7 +1009,7 @@
 #     the remainder its arguments.  (Since 10.2)
 #
 # @x-rdma-chunk-size: RDMA memory registration chunk size in bytes.
-#     Default is 1MiB.  Must be a power of 2 in the range
+#     Default is 64MiB.  Must be a power of 2 in the range
 #     [1MiB, 1024MiB].  Only applies when migrating via RDMA.
 #     Must be set to the same value on both source and destination
 #     before migration starts.  (Since 11.1)
-- 
2.43.7


