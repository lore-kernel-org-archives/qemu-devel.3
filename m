Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A96BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf7u-0004gb-Gd; Mon, 06 Jul 2026 04:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf7d-0004J5-OK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:56:16 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf7b-0007bL-V4
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:56:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqruzEbY6FCJIUV4dbWmkPTDpRNtpttb1u36Oi58QsbFTsYCoil8qT7UNSnMLzQ1pEHyyJPqV4aQXOSiuC4ZT/GUG+3RSCCxVJtWhdfbMJZP92xjlWekjDFXlAghKWBT1THNZxO8boUJTFG8vpw4PDEPQ8ouyXIhc3sYPMXNro8MEDAKWhnGcDSkvBzRkuUJrrwnXtc9KT46tqexQrp2QlyrhubHHSQQoPVTfON7X2hAUtejUXziEJhegzX81LcOUOKCsDi/CmeIb8PqBbP0BHw/OpOFIwYtYjW76pyW6qM5lhUKS+EX91uZyQhdqhpDLW8JyGfp2BBTdVRlRL1iDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtAI1XdYXMIVpBeae6tW8YjeCPXTl4ECpp7lyYmAQEQ=;
 b=s2dGAlXwlb/CnaM2NMlTXCKgK4PyTimZJcH/uCCgCSPPxdVEhnPkdtIxaf3sUkY7/FIBrf4W+m3MyujrPQA/kKjn0utzh/YRqLXEGA+wgoWxlx2OG6K8rIA0GB4LwCIcWd/Pb8zcQX99l/XOnA7ZyQ7iaHKbPJ5vKjvOBHfW1Vb0QQb9myhpjCOO6XTsyesOq+i/KXzs1c/bJ3F9tExW94JSh6TaFC3+8KK8SqCl5dNHMPjFgDimqFumcNyATxyCbdOatfkiF+mmOQpEgK+q3yusC4KdDzmcL0FKFazkVvn/UpdfhHyk0cErSeye1qzfiL1YCkjLQRkTvBGlJGuUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtAI1XdYXMIVpBeae6tW8YjeCPXTl4ECpp7lyYmAQEQ=;
 b=hLmkJYmpJ2r8Hk2kBO53tEjFRizuErGUjgi8uzLLUv1DkZZ/1Pw+mY2Ewk2q3OTDM/Kj5aZhoI7KBtoN2ePOybcbQRYkS2l5xTb7qvbJE5gMRwV9NveeC92tcuDz/67uEdv98/QqSShRJyJWcsCHa0+nbqzrSEoX43C6jIG/JWVmUA2vLwQiA44MvsYOGnDIPiUbhNb2yFbw5qYUjQs7ZAS4dE1Q5mFrX/KoLpOt2ax/3vxOOGmbT73Z/BVrQjUCVN/VgBU47xs1imHGa/lFcz4m3bZXgdQMB4gIQg3IX9jjdML9ib1aNOVxkwIjOLdtRuF5D61IhuAJATSrkcoJhQ==
Received: from CH0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:610:e5::8)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 08:56:00 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::b) by CH0PR03CA0243.outlook.office365.com
 (2603:10b6:610:e5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 08:55:59 +0000
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
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:55:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:55:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:55:42 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:55:36 -0700
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
Subject: [PATCH v5 16/16] migration: Fix "switchover" used as a verb in
 comments and docs
Date: Mon, 6 Jul 2026 11:52:11 +0300
Message-ID: <20260706085211.13905-17-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2047dd-8b3f-4ebd-ad79-08dedb3c6661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +LeJzWE6rTdjsBuH3r1JaR7na5QF+wQ9bg8lFBFWLW4ioVzF3isGGsPWsRHbvt1m/walRuHMaVGVMq4bxFBNZQs6drEs/vipRhYvvjPf6YY8eqnPJgccwJ70CRM15SWz1KKBpSvwMXYmuPdkV9xDWQ1rHw8Xl4XCku5efTSzLDR7Te6kLYxSyFbrAnQNB8sUTPIIj9BAJ+osdzenCUJFwowByMpnkdDUtTk4bODDpWygypUfSDFbhQIApkBSnfGpXOlrcDYzQY2hrRB88SQxnY929zWM7tzVUfjPpkEhAwyU7WyOl47bBdNMKauyCbnPtxcVnTQjEmHdCrCZZM/Stz1ghWiPU4SrLp55IQtsnDJVQYJG0Kd8UkiFJ3LHsFxkfvXpglLMe9S2UVpWSCdkd1nWxufJ4NH75YKBKJ+4Sgc9F4Z8QH7TX7BpvMV3ltxLGNcciinqUeUv2PEjUsj2VeimaNCjUzn7ZCiZsdlriJIe9m/ar/tRT6qHQ1zXA5NQgEapFjsaUTsn1qJr32GfI868AO02pxxJbpd6nqD8R03JuOm5V0xmJfb1uWtUW0dxIkGRdoFsJLC3dtNyQ/Gh0p81vOgOyuhJYM+ECGyJ6wBsw/cxr2lI1qwGd7hsZrrySdhX8eo4higfT4TInHsnd5XvgpLOBWJXv0yFjbry07yVohrQVkC/SGb+aC/5y1fqrsZHFabFbK487mwb2vBa0g==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fQjyCd2z1KW5roJqW8Nouq6jGnfSLfRV1jnptAnZ/MdikgTxsxURpTAnMu7YcoRbgpptpXT7rUVrwg7X+XqQ9gaUh8C4MoVqPYGEEwu/9e0wwW4oM5mZh/CrJeGsZXCHUmNCQgr6Goi6jGNr+Gg3Pod/aW4PR25p/o1oqYIbJ5cp+2kNIxKhPoJpKf1BgwKZ3PNjwNq+aBzxD+G+gddpRLU5LKf2vktlsJu3uU3nZ7vA2tt+qYdBTMmH4KM2WpUyN3sTUHl3O/wkL7CpjDIuXYDnBkRxKkTFJjnqzsSqD1yHzw1doT5GJ0u1E4dNr3Th3Khi52MtVxAeF+f6aB1SwqmaanvPFAbH2gpAipxSKTi5cid6fCgqhgECknzIyDwlKYQXaTZzLZdPf7uXZFgLL3Tv1FPJdrNMOzJLkQq6QD46Lxbol46ptRq3J+Ez71aI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:55:59.3681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2047dd-8b3f-4ebd-ad79-08dedb3c6661
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=avihaih@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

"Switchover" is a noun; the verb form is "switch over".  Replace all
instances where "switchover" was incorrectly used as a verb in comments
and documentation.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 qapi/migration.json   | 4 ++--
 migration/migration.h | 6 +++---
 migration/migration.c | 4 ++--
 migration/savevm.c    | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index d2f42c4b0f..66bd900465 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -509,7 +509,7 @@
 #
 # @switchover-ack: If enabled, migration will not stop the source VM
 #     and complete the migration until the destination has
-#     acknowledged that it is OK to switchover.  The acknowledgement
+#     acknowledged that it is OK to switch over.  The acknowledgement
 #     may depend, for example, on some device's data being loaded in
 #     the destination before doing switchover.  This can reduce
 #     downtime if devices that support this capability are present.
@@ -919,7 +919,7 @@
 #     migration can use during switchover phase, in bytes per
 #     second.  **Note:** this does not limit the bandwidth during
 #     switchover, but only for calculations when making decisions to
-#     switchover.  By default, this value is zero, which means QEMU
+#     switch over.  By default, this value is zero, which means QEMU
 #     will estimate the bandwidth automatically.  This can be set
 #     when the estimated value is not accurate, while the user is
 #     able to guarantee such bandwidth is available when switching
diff --git a/migration/migration.h b/migration/migration.h
index 44bce199cd..631421c784 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -496,12 +496,12 @@ struct MigrationState {
      * migration progresses, the devices on the destination acknowledge
      * switchover, decreasing the counter. When the counter reaches zero, a
      * single ACK message is sent to the source via the return path, indicating
-     * that it's OK to switchover.
+     * that it's OK to switch over.
      *
      * In new switchover-ack, the source is the one that keeps track of a
      * pending ACKs counter. As migration progresses, the destination sends ACK
      * message per-device via the return path, which decrements the source
-     * counter. When the counter reaches zero, it's OK to switchover. During
+     * counter. When the counter reaches zero, it's OK to switch over. During
      * precopy, source-side devices may request additional ACKs, which increment
      * the counter again.
      *
@@ -521,7 +521,7 @@ struct MigrationState {
     /*
      * Indicates the number of pending ACKs from the destination. The value may
      * increase or decrease during precopy as new ACKs are requested or
-     * received. When zero is reached, it's OK to switchover. In legacy
+     * received. When zero is reached, it's OK to switch over. In legacy
      * switchover-ack, it's initialized to 1 and decreased to zero upon ACK.
      */
     uint32_t switchover_ack_pending_num;
diff --git a/migration/migration.c b/migration/migration.c
index 7d5acd93c3..9736c14458 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3293,7 +3293,7 @@ static bool migration_iteration_next_ready(MigrationState *s,
                                            MigPendingData *pending)
 {
     /*
-     * If the estimated values already suggest us to switchover, mark this
+     * If the estimated values already suggest us to switch over, mark this
      * iteration finished, time to do a slow sync.
      */
     if (pending->total_bytes <= s->threshold_size) {
@@ -3418,7 +3418,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
             migration_iteration_go_next(s, &pending);
         }
 
-        /* Check can switchover after qemu_savevm_query_pending() */
+        /* Check if we can switch over after qemu_savevm_query_pending() */
         can_switchover = migration_can_switchover(s);
 
         /* Should we switch to postcopy now? */
diff --git a/migration/savevm.c b/migration/savevm.c
index bbb8d2b47c..34dd06f9f7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2509,7 +2509,7 @@ static int loadvm_postcopy_handle_switchover_start(Error **errp)
 
 /*
  * If legacy switchover-ack is enabled but no device uses it, need to send an
- * ACK to source that it's OK to switchover.
+ * ACK to source that it's OK to switch over.
  */
 static int loadvm_switchover_ack_no_users_legacy(MigrationIncomingState *mis,
                                                  Error **errp)
-- 
2.40.1


