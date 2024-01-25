Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6B7C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YH-0002Jf-4Q; Thu, 25 Jan 2024 11:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2Y4-0002H4-4b
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:25:52 -0500
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2Y2-0000R9-D0
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:25:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5atxKd5NicLOaUyiMNTDHOwKt7se7V085xmExuaNyhQVH7RXBdOjPHE3RU8wVeqfoSqEvT4LuqtJXt6dDH6aOUDYPsVrhuvt2kbg/UgxNnX5qNRXDr2ehrHQepKkrGabXmtiPAykK2h/IcRIpf3EyySwwGK+7Df4bYyv9J+onFSeV3RI8mnlVMzvBdXOhTIkYiMnXv2qT64HBDKAZsIY9ymOHquddTndll4nPL7/EQa3u4pBUVSYqai67+z3stD/5nSBUdkLvVbePg7YQIicKXBXuCY4fC2QrDoQzcC2g2wK5xPpRZ1Bs1XnuPb3qA6yfCFYF9j5bRsAgE6D0OH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5e8kRabni7h6uSmKIfcUNkTJ7spjOv2ouVVhTzHaA4=;
 b=ATHOTt3OItQ91GMYMKrO9xe29gzrwO0lQtM8GfoUhT06H4Ruts5sy/2GVXsKm9Nqdmxxbmp5tgTTm4Cai9Ww4ZEwZM5qubfi5CHihwuhgPEsyOz2nWco+esPhnZR88k8kfHmGxTnwjpunWNdY9ldWa1ORanZW+lzOmXXNyNFz/pXb3DyO3lnpj7sLfHuFOgHrbhksIwmemJ51BbZQJdSh3rVU5KADBjGqiczw/EAvmOZ6B7fd6HdrREIv8ggjLgRcKQY1b3DFz0zYIhhm54P7BEz+Xbi854ZmMpDDKCrnn7D+eoe2iNf/Bg2tfwwnfH/L3mKQ+YfMXOjChNmI9lxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5e8kRabni7h6uSmKIfcUNkTJ7spjOv2ouVVhTzHaA4=;
 b=ciqt33uZGgS0GQJakNghAFwqoOS9vSPnT0VlhlUi+1q2Vx7o43ukxkkPWt1lOayLZYD4+MhnQf9Ugr6IrZjeUkh8BdM6hjGECAXXNx+kWnWw3/9yGoVb5AIz2rdS/S3ojs45ZDB8L7L7OcSiwqlJSX1tH9PuVjKQdg8wuyBfb/M/TJAcJH5fkE0OI405rEdFZrLqbd4mAb0sWW7rl6sKJUe1jrZwOgkJgzY4MMN3wyN7Q6R1zYnCMFwIMBcXYH4qO5JZzDEDnnrDAIKLpaInN6h3Ys7k/3kcVpNSwciraS/oLHnwiVQ5wigyD+caCFoqaz2dBi0nTvpVhgHVnJCEZw==
Received: from CH0PR03CA0391.namprd03.prod.outlook.com (2603:10b6:610:11b::10)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 16:25:42 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::26) by CH0PR03CA0391.outlook.office365.com
 (2603:10b6:610:11b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:35 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:35 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:34 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 03/17] migration: Rename default_channel to main_channel
Date: Thu, 25 Jan 2024 18:25:14 +0200
Message-ID: <20240125162528.7552-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b5ff43-2b1f-4e0c-eacd-08dc1dc24636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jl9KSN5sxY7X1iwHzOcckyDxeHh5ZgIuEzlJ9gNy4t3AnyMsB3yto/5sHblIx1JcooG3gjV5vSVI8CzYvNKVgHhe9009wKOkkrC8Vo9Rz8fQDHkmkvquM1NxO2C6LGzbkmubO3ofmBF9SbNKrxv4TlkN0vT+WCQ6PsGXvjKVGejnUQUE3hCrLUDElOi54o7JMcZ8z6mjUdChA5yMr1/VdWCBj9LSJLk5FUQB+TzeOCP9RsRYWs8eoR+IgLoRmqHT+yUQ6JTkulK/3Pueh8TVfOsWjiBjDpjzHTRtYAb9JWJPVqN2cE0h+N8mptPCWyZdC+lofAhsprB7S0ayQUYT/sRQ8mKHC6N7aYjeQuQkgtp+svvTIbBUKiC6paECJY1bgDzaw/TBhMARv0HZiljGJE+SUDMYvuKMX/qMZMwuKUJGHIiSFdq+sqYmRLAdsrkJXWvsCmCMkMeaHQMVguQdc596h/jCIPLSo80dm1HxnHIeQ434zi3ED5ykziwdumjpQSrPvbvZcueFr7nLLHx8RrMgs0yP+qrcYjKLeB5dxFrwnW3GT2/8BukHOL9bGG+3ykH7ZmoQLsBtA+SZVEWF7AGILiyQlu9ziLPZ0ygZh8M45P9kapJOrKv1Crsbd3BvUWWug/uf5oroP36G1g7xvLD9iQ4VrvnCFzkguBtWwFRPI7Dt7VZa9HlGEArWOYs+mbYGRVXPbUlo8Xi3IvAgx78pNhuEKs7xBSf+2qvaaes=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(36756003)(82740400003)(2906002)(5660300002)(7636003)(36860700001)(86362001)(41300700001)(356005)(4326008)(336012)(478600001)(26005)(426003)(1076003)(47076005)(2616005)(7696005)(107886003)(6666004)(70586007)(54906003)(70206006)(8676002)(8936002)(83380400001)(6916009)(316002)(40480700001)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:41.7226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b5ff43-2b1f-4e0c-eacd-08dc1dc24636
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990
Received-SPF: softfail client-ip=2a01:111:f403:2009::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

migration_ioc_process_incoming() uses the term "default_channel" to
describe the main migration channel. Rename it to the more commonly used
and informative term "main_channel".

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ccd497ca21..9c769a1ecd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -823,7 +823,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
     QEMUFile *f;
-    bool default_channel = true;
+    bool main_channel = true;
     uint32_t channel_magic = 0;
     int ret = 0;
 
@@ -846,16 +846,16 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
             return;
         }
 
-        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
+        main_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
     } else {
-        default_channel = !mis->from_src_file;
+        main_channel = !mis->from_src_file;
     }
 
     if (multifd_load_setup(errp) != 0) {
         return;
     }
 
-    if (default_channel) {
+    if (main_channel) {
         f = qemu_file_new_input(ioc);
         migration_incoming_setup(f);
     } else {
@@ -874,7 +874,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
         }
     }
 
-    if (migration_should_start_incoming(default_channel)) {
+    if (migration_should_start_incoming(main_channel)) {
         /* If it's a recovery, we're done */
         if (postcopy_try_recover()) {
             return;
-- 
2.26.3


