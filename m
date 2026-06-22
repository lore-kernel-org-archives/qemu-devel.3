Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB84ACDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbfp-0004pq-Q4; Mon, 22 Jun 2026 06:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbfZ-0004gM-9t
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:14:22 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbfW-0006Cq-3K
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:14:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUSG77sqkzCngmO3RKVdx1T6FVvQwKck3qDWDwoRHTzCc1J74WTs3tXzKqDkuv9tluYrqw/QCOODJ0anWuqfgsMoQH2A+GEYWD122xD8SOuG10vt2yXu7vEds1wx4dQ/GdzvswJv+7v/uAcZ20qZ/zRuacHRMctV5o4+GHID6/B6x7saeFg8Kj6+3X8mNstO3VvE5XdO24QaftF/USqY0fzeQ9g2/YFLZ86wu9b5zV7x/MZdk8xfRdSeCU/SiQ0BF5w6fnFc85c6U1//7koxd8oMUjqc6RhTK8ngZWq9YBYUjE3nHO40Nc8tuPm0p4GvO4BQwXjDH8SFi9DLQTZ6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Inqtjd09vCQC4e29otc598yk0i6N+toKmv9BnBlyE0U=;
 b=Mvk+6/AVGIYxap62sJ3SJTdK/feW+2rDhdMEH+2rVQDZVpzvbTgAEWgtY4FwEWIlDYxi0Wx8aW+/VoLesw4P7aVMBhsSK3uo/DlPu6df425Pn6yn27VTugQNbJigPHkmI2nsL1Kw3/blwU4uUzxvGS9m7/5s0F3mcEEINaABlter9enMQjHqyEzoNBP98MIxnCJOATFoxmBJwE2c1kIf/HM61I6eIcTBMZgvQt/GTDYHJWWIFPXhlJHwwHFExwNP8NNeN2e+IRnXcAcyAtLPdX01+QWgXL3KAgiw0Ish0lNWwplHImPkkmg2s80XJpDdACRH532tVGXwnAHvNwRbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inqtjd09vCQC4e29otc598yk0i6N+toKmv9BnBlyE0U=;
 b=DcaUFGTN13w2aKJTcZOhSRkUPbdUgsSsLEWDccYqWk0M/pT16fIM4+ySHxMBThGdQgUv0L6g8J9QWe23msNKvhOGPU+vaUDmbslZBrTCdYIs30e5oKCASgREnE+zzU/w7yTxQ7u/Wyf/u207EGTNxe2+UNXBxjhmEEP9pJJNVHDDrbwiex4WnaU4e0TxYgxTaMUmYTgZss+De0uzKnf4lGsic44xMoearvQp7iDxi/7YNoNGpJnkeuWy9022O8B+lOEfZudpKixyhZbA3dQgJiRHUefBvJoHnkq03cJXMPaim831ewzqKrrtybpqwG8oPqMYBU46wWnPHfAoT3tryg==
Received: from PH1PEPF0001330B.namprd07.prod.outlook.com (2603:10b6:518:1::1a)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 10:14:11 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF0001330B.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Mon,
 22 Jun 2026 10:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:14:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:13:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:13:49 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 03:13:44 -0700
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
Subject: [PATCH v4 04/14] migration: Log the approver in
 qemu_loadvm_approve_switchover()
Date: Mon, 22 Jun 2026 13:12:04 +0300
Message-ID: <20260622101214.25770-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260622101214.25770-1-avihaih@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c2c364-b4e7-4747-878f-08ded04700bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|7416014|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JfI9NL7X3BQBDdhsQAXlSr8mjoLPINySlKWkfAPHh+ACPjZsDDgytXHBkrvehxv7C8stpOG3Q+X0d4CrTk/Oygas+eLgye4AB9oJeZ7RCSZQwgy5xhDM0zrxiCn6usqZDdHVo1XrELso+K7CeH0BQ2MfOimZ3hLh3ISIAS4gaYbrp2iwGbweCO84oYrwKrqJbkuNm7DEp4Y44dWRWTT4ew9WKaKGd/Hp4T9TfYV+HahVX/4cLjIHgy7gS7SQQEytfPl+ZbAzJC6S4TG6yr8ClPx+hrilitM+jxkcpVBoc/jokCPEgEthN3qnFo0LfcP5EUL07yodblEWegjTA1Ah4grA3T9QD8FivV6vh6q8BwLBtYQC8S8m4S04s6DwKqS5ycMwDgbjl47Qcmh1vMxkFI/Fn8szhOEH7eJ25NC06REfYaa6u2CibMUPQggJ/1muG7s8xXhTfkjeckV2cwR0Bv35B0neNFnZvs60kv9F8ZJRzPAXJ0YE3pzl6UmggmT3i1sqKr/k6H8TCG0aGhFQ5nO9uYtGd/6adW46shUFkc9QtsHfpz/bp4HOYsUSSYqpFOFyfBsFnzTqkrG4rva7253X8dFciLbjtQkD1XUSZE6G8JXFgVXuE966BCOVfCZidH91ZrziOB+rOF2PzCY1DdPjpsIW3bmF/hxzNo8ZcB6s7ZxFJrXaWayH9HYx1N6rrI7wi4EUo3fOV+psoEm8sQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n4GcoaiafyR1bM4qsWdZ54aCTWXueVJQvmGQ53c/8soOfyLN7xOZWCYlPlKmuaYOkKbRmleLbated08ajGHdOnXjeiEJq5yLg4xJAkjecTrN7OX8zex7nF+h/aSL6Sqjx5PvHj4UhuomLEnaRVrZvqwrglzp/Ny131dptL2XM50wTbY66u732EQ3Oy+uV/uV7BWuvMh49IJAA95jp2S1yYEtxS+Zgh4pHpBm0nqnoWakqUrIQbRZ2OhGYfe/fVokb90ZUh2nniiVkEKsh4mPlIvlMMVf/dNXMI7NqNYrL0Yogkuw0nFJqBjNJp2EI+OpxXB+rPor3udCvIbtla4p86DjcBesoKdE2i+h39HbV+XjA+eWXd8CUXCTp0BhnlteRqqm+WId5IbIZkzFImNYvQpb67sImQymury1cQGxMibl8eQxd0DuNJg+s+x9oi5t
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:14:10.5858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c2c364-b4e7-4747-878f-08ded04700bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=avihaih@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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
index ed62defadc..8ff6c0b17e 100644
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


