Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E14C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YQ-0002Nw-IR; Thu, 25 Jan 2024 11:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YM-0002Ld-10
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:10 -0500
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YK-0000Ud-FF
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXHx0gtNvoxtK656ITuWbqXY9y+qJ8/gDEZhRhtEa7g5fjnfnRc4Zp6x3pttL7TM6br1i/pICDA7Qnuk9cKdoMogtbmF5zhx7S7LaFPRI+NYxhEhHvavTOVzu/IqGAs7Y0UK9YND9cdd1w7Gvv4kUQ0dkccwlTUvsa/hy5L6rMCf6xTI5E4XxIyZM3Ps9BFVFVOCLRnyoJiE8LPYJt6JkjmAUZYI1e7nNn4NG2c06aarHqCxThSks0oY40L/ioLEdz8/bAwbrTXg5XKcy/PAq0LQ4E8tUCABJaa3p6zRxaFK5Stf1d7gp6oxuBRGr+Hov8ZCBTmO8tRyU8Fe7hzP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwmzgEVX6nKNGBPsEnFTDyi0KTRJ8ZEj0HC+zADAaq4=;
 b=b4UYS/TqhRS8o9abjoCCwJ+KF/l/An3kZR47QIjIfQI3/Wig+UYBimTgXOv1Z4Z3r45i4aOn0iZYgkIQsJQtbjY9UZ623fCh5EccyC2gjTBG40KnImr0bj1wjd3mmySiBHimZR4NHht19RnjPpAMeZv5uq+jC3FVabqwScGyrBlzTI2gTroPm6D5M00ypUZCGHV+NJlT5HmMDWB6tVHBH9BuEqn2sHeRIIGiCwWJUtGoRb01ALz82GNAy1QezqhIYNjNm9vzX6dgmWNFYlkB11+4dkxTXcLPZ1yzp5+i3BllJLNYa/elMAxgfJTYMh0NKTpSApn+GYI9DPn1sX9BGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwmzgEVX6nKNGBPsEnFTDyi0KTRJ8ZEj0HC+zADAaq4=;
 b=lkSdLCGnXsEBZnRGqop+S/1smm/ZQ9KSz8LnZZTM2lQZxOpqZtVzIsGm3XZO5ldbMWe+covQw9BZWwJXszuU5Gr+JoKZGxHIEn5dNHFt3Ajo2VSlvsmRu3+1YIu4jhjsENM5d3lIgway1uV7MQQ9wSf4QGL+fxgCwwlx1rUMdWTtebVPOAbVue+qk+N3lhCG9Y8IIMuP1M/yd6+uNUzLQAJWjYrniAndkoUYX71PWVLFzFCYOiiM7mDNoqNRP7Imeg9K2E7iNBNA4EIWSkliHImikOmfR9fPeKq/+UYFh7J+5MMc3ZrvgSeDmsh7ZW6uh+rx/XC+3qgTIhtrBllTxQ==
Received: from CYZPR12CA0001.namprd12.prod.outlook.com (2603:10b6:930:8b::8)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 16:26:03 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::1a) by CYZPR12CA0001.outlook.office365.com
 (2603:10b6:930:8b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Thu, 25 Jan 2024 16:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:26:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:53 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:52 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:51 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 13/17] migration: Store MigrationAddress in MigrationState
Date: Thu, 25 Jan 2024 18:25:24 +0200
Message-ID: <20240125162528.7552-14-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b338b6-61ea-48d0-4ba4-08dc1dc252f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FNUenRp3HfKlNm5Hce1hnSx4VEQAGeivIMeIkVbtZfAX9Tqd66PULKXCw/dvJZFflPooglKTFPkdpbkN0EM4DLPrXqLbDJ1Ui0de4kPtoTnqpKnR1R/4pJlv261b7Y7olTWlUuSl7A6mnHfTt8m9znZAfqCeD1V77NWORuUft0r2tT5kjY/Bsx3/H0oXkrp+RU5iKruD5EoUQRHnqmXII4/b4VgSyBHkh7C2YgV4C5bdodufbF3yoIX1jqfpqgjLx0cYTrcInfp9Khc9GEEaPQWhtNQ0P0naLY24VHiLDp/BF7+6FN/iBw0vb5CeIi/vgoDXsqDc7i6V6FQwBynEBv6fU+2SMlVxMIT6RslAUlLINh29xsw0i5HymsxwWnXJC5xxOB+V+1qSjIDsWC1J59SrAQekFGokWHEeK/yZzCdaJhKwrXpwjWhnqNi+yRfwo+uWJauwt28Hwtm+GhhUf/mj4wbC0d7qTG1IUH0rJgzMGyRGt5JUCyq8UOi0NyYwAME0xaicL7/z5vx/fke0zqKpKLj4fqE1IOAhZkb66abHLTZceKLR3mMvjA/HfTAjP1AB9pFiNQgsbWB73wekP+HQHHXMqaVBK3GaQKpIjOW3+BopPBGu4DlM617kvPQNXmun7Mq36yeW3g1f+cbumusTpVGekf1B/XWdlNcdP97tq9/7JsjGF4gN2hRz8QednS94suDOiORlss0E+1JoHOIFaM/8jTTUTCGlFW2gGNeXxPiKhrzBP8WFK4DMQNY
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(26005)(6916009)(7696005)(6666004)(2616005)(1076003)(70586007)(316002)(54906003)(107886003)(336012)(70206006)(8936002)(4326008)(40460700003)(8676002)(5660300002)(40480700001)(478600001)(47076005)(36860700001)(2906002)(82740400003)(426003)(356005)(86362001)(7636003)(41300700001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:26:03.1367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b338b6-61ea-48d0-4ba4-08dc1dc252f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
Received-SPF: softfail client-ip=2a01:111:f403:200a::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This will be used in the new migration channel creation API in the
following patches.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.h | 3 +++
 migration/migration.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index 17972dac34..dc370ab3e8 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -470,6 +470,9 @@ struct MigrationState {
     bool switchover_acked;
     /* Is this a rdma migration */
     bool rdma_migration;
+
+    /* The address used for this migration */
+    MigrationAddress *address;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/migration.c b/migration/migration.c
index d81d96eaa5..deaa79ff14 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1286,6 +1286,8 @@ static void migrate_fd_cleanup(MigrationState *s)
     s->hostname = NULL;
     json_writer_free(s->vmdesc);
     s->vmdesc = NULL;
+    qapi_free_MigrationAddress(s->address);
+    s->address = NULL;
 
     qemu_savevm_state_cleanup();
 
@@ -1974,6 +1976,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
+    s->address = QAPI_CLONE(MigrationAddress, addr);
+
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
@@ -2005,6 +2009,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
         migrate_fd_error(s, local_err);
         error_propagate(errp, local_err);
+        qapi_free_MigrationAddress(s->address);
+        s->address = NULL;
         return;
     }
 }
-- 
2.26.3


