Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEDFC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf5Y-00005g-2p; Mon, 06 Jul 2026 04:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf5W-0008VG-4G
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:02 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf5U-0006oa-EF
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/s2PBFsTsXm+qyyOIgxQ1NRU8urGZCP+7PoIFG8rehz+S2j3UVR7O6EusLDTJ+QLUcg41GcxOUSwXploNEBHz+H6aDcXCh4qBQeR9IAJiBcw9x3yb46y4LqfbkmSOaWmiAOgPh4B0+4puTOjGtJfhtCsnkN9fpYU9rBaLR+0F3KT7ZDOGqbmuiYn5HqI8BHYSUWW0w6f/Efy14xZCEBCqBY/TIvM76jApm/LIf9fDk3QkjZi0d/wO24BrfwI48x53O9E5rbpHxCvUFosZE1purgzpNgzMCi7GrlV/JNDgdY7Fxoi5EIslK56C/FDGc1latkYrOO9TX1AUR5LTuWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9h6Lba97BFf7vLoPufqhbaJuGzuPwH4gZTArYM9cHc=;
 b=sXvue2ghN9j3+CefrBMFfk7xsfd2nKfanMY74zXHv09S8i+ojJrXXrzqvhnqQWnN2daZYvjh/4MsJ/sv0WR4R2EgymXmxQayPbMs3oWWUqkTsJ4GNu6Xsyvfl8BNbn4CCiDilS8XFbH9Wwm6/V+oukzYTp8kzhqonQXqXNC+bfXla3VVbWx66vcifsampbdepqtqaLRmfa7wQfUrU608LxnX/bVDvVMOn9nOrROQmU4N2NWbqGfCSf0K0sguDUzIh4CEygR6Q1pLj7atcGNrZJRJi442ldVZeCBRzcgPO7/F6Rg50eHBgj97csUew3TZ0VXlIWLaSj0DTrkmPn9a5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9h6Lba97BFf7vLoPufqhbaJuGzuPwH4gZTArYM9cHc=;
 b=WhKe9U+gFS4wC1WK1dJlAjv1bLIHK+Ec2kolHO1vOkQE5oEWsVGPsUq8mzO2/w8+DSbv6bGMB+5nbKIx/Wm36FjvcHFafyNXha7NPL2Obyh8jqIlG201Figiwq+Jdes1tA/gNLjzuG6dHnKAm61iYGrBHFgSUaJKSO+Injx3CTocFPWInBuPw20C+eEUyIZPfXaL+IixaZ/KyCzuh1pTW1QP5YMMelX1ZpRAj364zC++rsbUQC6+k/i1UqNO5yXnPv4rGT6CEQONjMuCWoNLu409p4SKZNYsinzzBt569km62Bz5p8m/dQGIhwIQl2k9wV/bDZENPUzCwQdWuPAn0A==
Received: from DS7PR03CA0203.namprd03.prod.outlook.com (2603:10b6:5:3b6::28)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 08:53:54 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::2) by DS7PR03CA0203.outlook.office365.com
 (2603:10b6:5:3b6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Mon, 6
 Jul 2026 08:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:53:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:53:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:53:36 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:53:30 -0700
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
Subject: [PATCH v5 04/16] migration: Log the approver in
 qemu_loadvm_approve_switchover()
Date: Mon, 6 Jul 2026 11:51:59 +0300
Message-ID: <20260706085211.13905-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: 064fb722-5818-4ce4-88aa-08dedb3c1ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|7416014|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lTtY15vmgCNgwyQm0ODtFG/DmSZmYx0JcyKHdUFLyKWbk+WiuJBDEpyznp/hyY7ci130bmFhwG4ohnuzifhdYyDpt/NWIL67GKmBrcD5oJfwcmu5Xim3khC9EYZx9Jwk6e3Hs7FUTNQqr+l3oDjLPrPoN0Y2Hm0oVz1sMI9hP43sYx8TQGuUDZNdZ6FmKcR0VjNWpr4k/L2KCJq3ox9LmiyHW0wRs5Fnn6iV4s/K6dP4zXPuFi3dByA0VKbh2SWF0mTpyu0I/ZCkn0UtbdY/IlFTxNtYdllOMnzgl5ircGeIEx5XfJZ11F8/D6DVxhxEEXHs8xIhaQuI7gLEG2Oynn6uX1ftNPy43DnFIkpULPVAiXfrbOxpdm7X58NXn6FaFYBuxnAZE1cSz/wivVBU5tssuasgc7jGwoIPPzYAZhNz2cskqrwMGcttvG6dYfqUk+WKWKYu2zArtVxhASQ34hQjpiomBuX3WxYyKo0wbjszMi6YQTGtsBG8Blu4pYugqx9ZhFK4d1KvViHLpVa5zOZTOkKJfQlFxsO5tg4qNc741myUP4ErRxX2hq2FyF/YKYjqoC+8Wcm6lFKchIbCsSMyBR1l2gYV9OLHshDXP7oLbd9eKDPjNM7RE6fUx4QigOOAkoS7PkFcku9EVzEguwbxm2Ca6lkCAXw4wTw1Z5Ms4vHzGmPZyy/MXrYneoZJS5eECUa+bGiBFBnGy9xKhQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(7416014)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SNUtIiXQ+117TBnvjOYeFhjjxpMCFFnefOlJZUK/8jGm92tpArJDzxar/oQEr6R++ccqSN5B5IM/FIDaHyLSlygUE8HIzw+TB2oFGvq5FaN3Y+IkTDCkYC6bCJBEhWAYlpma5kgBrf6l17IJKpmlUg+Xco1SPrOjk6KiB9MwgltcX3wJkYzBLSpMH/4wITKvjnrM+YRg0i3zt/m4GRojO9LRu10XfQTaiiLbIhh1PLEjrLRXMbk2JyREFcyTRhOYM8vf+TXyqzO0KL5ZHXtMcruPkvGdB521LZXcE/nNuoFNpOMNWoHjl6y0wq0FaQ1jgaDBcvcUKc5UXB/jWpRuCI6SF+waS62aaD9kNmdDcsfI+wDEIcuHmR5BUC69qPg+smszbji3zcRWrOdB70KbDz1SOhINt+3KtnwLFNuzdtHVM1LGv3i8kU47rD9fWYkZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:53:53.9826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064fb722-5818-4ce4-88aa-08dedb3c1ba2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
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

Pass the device name that approved switchover to
qemu_loadvm_approve_switchover() and log it in the trace for debugging
purposes.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/savevm.h     | 2 +-
 hw/vfio/migration.c    | 2 +-
 migration/savevm.c     | 4 ++--
 migration/trace-events | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 81abd96dda..44424be347 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -71,7 +71,7 @@ void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
-int qemu_loadvm_approve_switchover(void);
+int qemu_loadvm_approve_switchover(const char *approver);
 int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
 int qemu_savevm_state_non_iterable_early(QEMUFile *f,
                                          JSONWriter *vmdesc,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 195498845e..180b316bae 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -847,7 +847,7 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
                 return -EINVAL;
             }
 
-            ret = qemu_loadvm_approve_switchover();
+            ret = qemu_loadvm_approve_switchover(vbasedev->name);
             if (ret) {
                 error_report(
                     "%s: qemu_loadvm_approve_switchover failed, err=%d (%s)",
diff --git a/migration/savevm.c b/migration/savevm.c
index 74d622583e..be81de2616 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3174,7 +3174,7 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     return 0;
 }
 
-int qemu_loadvm_approve_switchover(void)
+int qemu_loadvm_approve_switchover(const char *approver)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -3183,7 +3183,7 @@ int qemu_loadvm_approve_switchover(void)
     }
 
     mis->switchover_ack_pending_num--;
-    trace_loadvm_approve_switchover(mis->switchover_ack_pending_num);
+    trace_loadvm_approve_switchover(approver, mis->switchover_ack_pending_num);
 
     if (mis->switchover_ack_pending_num) {
         return 0;
diff --git a/migration/trace-events b/migration/trace-events
index 1c9212d3e2..c0c433744c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -24,7 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
 loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
-loadvm_approve_switchover(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
+loadvm_approve_switchover(const char *approver, unsigned int switchover_ack_pending_num) "Approver %s, switchover_ack_pending_num %u"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
-- 
2.40.1


