Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F71CCD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrNa-00026X-Gx; Tue, 09 Jun 2026 04:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrNY-00024b-IG
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:00:08 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrNW-0003zL-4m
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:00:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4KM+RiR7LqfU+uxAhzjj3z9J0Mlk6zpHvP25RRzc9mBTR2e1iwbbz2oEiUuWDEs4ZFcAPxEX5MsWDQSm4Ld99a293p5APWxxqpa2Ht8tYvnqo21Y8ThZNgttEEFrnKuEjIXfSWGzJTMcGEcmB9nQq1B6ps0bAbmPdBK5wleug9n8CkX3yVOV27hkcAH2qgdaPJIvBWX+D3Dc8o7JKPYfhh+eU15rkPAVFXj5z/4jvhep/unX73mMpbeE7/yDlezWpnglCA1BE/cBkC1eH7Bwigt1unWpHecw70HEOmecr+MAv99/NXGbPP4nnJmixPjEJoYzdtcxM+i/JOtBhk/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Inqtjd09vCQC4e29otc598yk0i6N+toKmv9BnBlyE0U=;
 b=GyCWPK5l2PbJlO2RyX69aSXQ9dKL20ZOw5HU3be5chYzmV3az6u7xqt/fhb1P+eTXBrBrXruWkgQyd6VHj23+wgx8Q93PClmnx+LcRxbIZbI9wImVRT8fa/rOZ4xhQxg+hz7aw5H2JVIftRRtL8Gaf4brf7be/XVLAynei6NR6FVrDp7OWLeIznKlyh5aVmK4vaGCCGNyJID9fhJQS2uDj9vQgAmmCt5rqdL49rXCP/PiTnp+c7rCqDUjg6iZqOz6ptFor5+5EWP78ja1/29INJiOANMDkfbcqJ7HpBnWuhakiKK0K0fDkO2YLrcRXR4Kgy6eMubQNf7n+XyMsiIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inqtjd09vCQC4e29otc598yk0i6N+toKmv9BnBlyE0U=;
 b=MoZFcjX9+k34LPBJ9bw72BqjnrOFsdqHlm4wcCJGmf5Vso3w9VVl6Lb5FGu0JPDu5Tgmqm12ygrrB29J60PFxTYGt6p7nyKQwXxgk3OHND3N3i8sQLlHXV7i+lmE7Y48Ty92h+TPf3sf5wFYiU1yH5b7qC4vPjO30Xc+6V+CEhUKb0BPMJshTkZc4HcA9NiyWae/6qvJuWI74WrTaWlqKNr18TWtUI/APoOEq8iCe/uyakxVdO5MNk44Z/73XDoFfzlyAtXSj/627t757AwVtN/SMGFg8PHFn9riYmobulgJAcP/1ZzZmAjDGJiBGsYULgVJCS9eWNaqY0/04G4g8A==
Received: from BN1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:408:e2::7)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 08:00:00 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::79) by BN1PR13CA0002.outlook.office365.com
 (2603:10b6:408:e2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 08:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:59:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:59:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:59:42 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 00:59:36 -0700
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
Subject: [PATCH v3 04/14] migration: Log the approver in
 qemu_loadvm_approve_switchover()
Date: Tue, 9 Jun 2026 10:58:02 +0300
Message-ID: <20260609075812.32067-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: cf83e228-e083-4a41-5b67-08dec5fd1aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: R9sJFkvLncrrmr1gIhyPOQiwZw9VdHkXTHNr92jomfYeQ+8Zt5UOj42CICCA9Ryi1d9Trbfd2FDBFdupvPYfugQKHVXeqELmRhVFbUGetX8LZ5Mb9wD1WCAj9qfDUGFfUfNAG6lGntADTk7bezaJ6HKO1SYty5wlWyjB5FF0vgpIALmVKGMp36hwf7WxrIf/+neL1iaiRON0J614cevvzTA+E3kLnUxVnf5ritfUzOV1nQ2hWbsnhbuXoo+WWXSy7NQeCboooHEISBx4iXXSSBf63iMxUEgKSwryOWfMhJ6ZVaoqgDVlo4zUbivaEtPVKyTHPEQjx3VrvJyEbYX/oGoAB3ywT6UtXL8Jlg5SOfxfnDwIa3VRZ3UMucI74HBC8Mhx4WnAuIVEF11m2CcmDnQ3BlL9QztkiuG8T1lKkqOiEDhGRA8zHrxcs8d8MZK7kkf1+taonZCnQ3oRYqzUE0KbCu9xYc8yLdzSZ++08NRyuvTGeMG4FKsocDBNgknTOxLHjq5snujapGr/AlaB7fESsHSPTuB/KMVYT7Bbj+tX3CHQ2+P4+R+4I48HfdoXR0ghXY0+YLy2zcUAvYERyVdzcepscx+qFW9ifPtjHd0JCPA86rTbKTmSrLHlVNh4R2I9GQi4dDJhrl6oNq5yOWswtRRJLfAWW8vbpuNmdZ6PbFTxH7GXYtAbmHnVAZkCS8/vBNdZLUkhHiMOqKraOZiEu1esOmdUDpFH2hvK2nw=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2fP2dhmEyGwwVBgd32ns4G09AT32DQH86T1axKiA+3WJKAMgkmFoOFFlsLfDdASv1fPx6eHTWfvFr8lxNU8KhSlMMr/O1Cu3SNoShrJ5bt9mO0MeNVSjfsp50m2KRiuPfwAen4I0YbqfYyh2HC+vFdyrQe1k/nKbPOVydoYsZmzNalJLvNvCE2bF9R9LdLX8Z/RrGfBzle4k6UfBHDz194fcJb70vePy87Q5E6m1TagYHBADYJwaaUFEEq+RmpqTFBveuaTseZfZyw9KQaEfjIqgVDSGsux08Svpm2m3V7MewKBAkYoCRZ6l1jWhSRN9nTVlh9ToQE4s1gUzeEiiVqVFqmtqYNFbvaPRGqHe3gH2y0JFzCpqEFcB49xjV3O9T9YJWdQxFvR4JSXi6BwTTcY1biW6ITgTZTY9NQSzQZbfc2Q/CHJBrgUjninYA4vk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:59:59.6373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf83e228-e083-4a41-5b67-08dec5fd1aaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=avihaih@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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


