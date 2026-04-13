Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8975DE93812
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 04:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8XP-0004Sw-Lw; Mon, 13 Apr 2026 00:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1wC8XJ-0004Sd-FX
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:04:34 -0400
Received: from mail-eastus2azon11011051.outbound.protection.outlook.com
 ([52.101.57.51] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1wC8XG-0003Ly-TB
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:04:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENFZ/qQ+CI92g76eSVkrIcAqnEQZ8Yc4W1Nk7PfrkmReH5Ljpd1pHoAB12ADpvVDVWpRL5jVrY6PxhHZdAyIeiAgNWj3LPGaafndpLK7y1uoVso7H47qqImg1uDWmS1+jPeBOwd0ENd4HWFiLsnCDmnkKAlmIyg2tzfBM8XPsw/C7YJ8HOUhVy1OYWKIk3LOYcH5Pv83z+Ux7WsJ3kG1WiW0CBh4Y4RyfzldohSTwjoojn/D1H8UYv6XzG1is9XRQufDRZNpSwUi7L/FPMty9JHIMsm3xD3uWu9ZhUn3LlAWHS8nkJLZPcy3L1kaAJ/VMdnsMifbFMS2ZVqLAccj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHHsw3oSSF1Yhxk3MroG1RBNWUtJghj0HKZM38JEpLk=;
 b=NV3OvV8K8oQAzNRRaiFVq/TcDtKh3hJthGHMDuidGj5g5BRv8NqKVPxwaNgR1iHAaGIHa/r0PE/ffCbxcMOl02vFMyDLpG8Xb+qO8CwZh7JaEPs/77mJYWzyxtB/y9fvtdssVsKHF5c4/wi+9wGu5R5vS3XUzoFCyYNZ+PO9C5h/jIL4TNgqfjaoDaoc4if08++IDPEHImHJ1wIMRnXPEXWiQgWdFlembtMQ/YkKiqbh5jpsow4O0Rh2mHiRSj33IJR+/DNA1MvhZ5qVxnogWBf0YeyKI/EeWofNDNdnptpuvDgBfKwGtNUYWaCFJquBAU/QhfL6rwDxEGi0a11UUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHHsw3oSSF1Yhxk3MroG1RBNWUtJghj0HKZM38JEpLk=;
 b=Z4i23cXWRW0QkeUYQ2XUqTDcGslvdWGTKYghB+uKamiow3oF6ErVOYbFY2xIrY4h5ay//gql8EHvqJLeFHciVv4XzC55YH1me8x26W95qwernZ/KYE5u1B+mt2Sn3pH7+jsYosnIRP9ClEjhq1m68FWBhriVvASW0mf6gMFV/A4=
Received: from MN0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:52f::12)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Mon, 13 Apr
 2026 03:59:21 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:52f:cafe::5f) by MN0PR03CA0005.outlook.office365.com
 (2603:10b6:208:52f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 03:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Mon, 13 Apr 2026 03:59:20 +0000
Received: from hjbog-srdc-36.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Apr
 2026 22:59:17 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <PengJu.Zhou@amd.com>, <Qing.Ma@amd.com>, Samuel Zhang
 <guoqing.zhang@amd.com>
Subject: [PATCH v5] migration/rdma: add x-rdma-chunk-size parameter
Date: Mon, 13 Apr 2026 11:57:03 +0800
Message-ID: <20260413035703.2602065-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 958d2796-f243-409a-4c38-08de99110a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1OMTBkq4FTXEaXhnYLflnI+4LE0z6S12LlhD+SvhEm34OF5IMWIgtqDNTAr8dn/1/wiJw+AA69nCUsftUtQ51GsgSBl+E3NJPOaXtcElYX/TrIn5yS3GM7yuktLIJ3EkWuqERO0cZxKdWvcan2sOr6m+6uy6UIlmkXZ/iLXyq3PxP3H5jK3XQeB9jn1czSbjOARafKxy1l0w4p00KHNppPR6HQSmSU++9SA1j9h3R6O2WxNAigghSw+Tdjq1S3N3iM//m592L1U4Gov8nbuy/O13uAncKwlfgJqatgbKuDB8+ix47MSKtow+RY2zdoWxYIpvaodM8SxHRbgQ3n9jO0Xig2jyA6DiJM4pLmPajDzHatNJHNGkGjv47sHpCSq6ZhdHx+13SXIdIWMrCxskC5NtWikXhn11rcmU99fVMj5IKtGyTAOPyQmSXN7zfYSkDcToOMGrjUSNE5Mn6AYG4mbA2XDMdjBWIbKEJwYk//8FVfWOAp+3WYCxiHJOB0tcaMLk9Bq03S626tyR2+eMcs8uV/z0x4gf6yejXkAd8dWnE4Shgqym/MHtdi0KMRbnru+4EGmmpPMJlMwZUClJ0vneL/t3FAEhp9PWgZ4TD7F5PmFpjSgRDs5rWsOxsSblUSZCB16HbJkyaadFEF0QPCVS7eziwSNCSc7JNJ1h2EQ+ohjw26EGacOC37ZeWSxuy2fgznTlKCB+EZJwxQ/P58cY1llgV4m8OwfTAakzgY3+x4g6GkjGQxK0wkYERNlqLDEQEn7G8u3PI6e7IKClbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HWm4U6q4B4Q8DwebXXLqIK6BZYIvo6yNDtpPnJZTO8zpcHnyxDCQfGm+SSRWB9CqFQXfW4ILWXyO5voDDdlJS49wNtdyv7d9IufRzgewYSyJGio5/Vlf6iKfdTFH9Eq3BOo7H7JWAn0OTSWsgUG9xfQpzQoRGCU3Bm9m8RdURPxDCjYs4b4/chsjqONCR3/e5wY6tX4bZ/FmN+eDJwTXThIf1TaKaNh1JcxaAJyLVBwSONamLcgDPbMVWlGHqJjRTkvZNy6Hh3IvOcZfENHuGwJnu6IWeCshDso0oE9Z9etoEOnLJbFPSzB8t1k6H6pI+bn5iWZ05cAgt3qS6kZBD92B1agLJrVtd/KIcveCOqIAEq0d8n1Tk8gvp0/nmp0PC+PrInH5pC8pScy/EE0ede1hEKC0l2+sNiyZgEua5Cq2s212nwknXtT3T22nuIzu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 03:59:20.3430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 958d2796-f243-409a-4c38-08de99110a8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681
Received-SPF: permerror client-ip=52.101.57.51;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The default 1MB RDMA chunk size causes slow live migration because
each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.

Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
faster migration.
Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`

Performance with RDMA live migration of 8GB RAM VM:

| x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
|-----------------------|----------|-------------------|
| 1M (default)          | 37.915   |  1,007            |
| 32M                   | 17.880   |  2,260            |
| 1024M                 |  4.368   | 17,529            |

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Li Zhijian <lizhijian@fujitsu.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
---
v2:
- Renamed x-rdma-chunk-shift to x-rdma-chunk-size (byte count)
- Added validation in migrate_params_check()
- Added hmp_migrate_set_parameter() support
- Added hmp_info_migrate_parameters() support
- Added migrate_mark_all_params_present()
- Use qemu_strtosz() for size suffix support
v3: [Markus]
- Use visit_type_size() in HMP set parameter
- Use MiB/GiB constants
v4: [Markus]
- Remove superfluous comment on DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE
- Use "Only applies when migrating via RDMA" in QAPI doc
v5:
- Document that x-rdma-chunk-size must be set to the same value on both
    source and destination before migration starts.
- Add Acked-by and Tested-by from Li Zhijian.

 migration/migration-hmp-cmds.c | 11 +++++++++++
 migration/options.c            | 33 ++++++++++++++++++++++++++++++++-
 migration/options.h            |  1 +
 migration/rdma.c               | 30 ++++++++++++++++--------------
 qapi/migration.json            | 13 +++++++++++--
 5 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0a193b8f54..4f6c1dbf89 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -451,6 +451,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
                            params->direct_io ? "on" : "off");
         }
 
+        if (params->has_x_rdma_chunk_size) {
+            monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
+                           MigrationParameter_str(
+                               MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
+                           params->x_rdma_chunk_size);
+        }
+
         assert(params->has_cpr_exec_command);
         monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
     }
@@ -734,6 +741,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_direct_io = true;
         visit_type_bool(v, param, &p->direct_io, &err);
         break;
+    case MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE:
+        p->has_x_rdma_chunk_size = true;
+        visit_type_size(v, param, &p->x_rdma_chunk_size, &err);
+        break;
     case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
         /*
          * NOTE: g_autofree will only auto g_free() the strv array when
diff --git a/migration/options.c b/migration/options.c
index 7556fbc06b..2b5158200b 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -90,6 +91,7 @@ const PropertyInfo qdev_prop_StrOrNull;
 
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
+#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           MiB
 
 const Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
@@ -183,6 +185,9 @@ const Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
+    DEFINE_PROP_UINT64("x-rdma-chunk-size", MigrationState,
+                      parameters.x_rdma_chunk_size,
+                      DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -1000,6 +1005,15 @@ ZeroPageDetection migrate_zero_page_detection(void)
     return s->parameters.zero_page_detection;
 }
 
+uint64_t migrate_rdma_chunk_size(void)
+{
+    MigrationState *s = migrate_get_current();
+    uint64_t size = s->parameters.x_rdma_chunk_size;
+
+    assert(MiB <= size && size <= GiB && is_power_of_2(size));
+    return size;
+}
+
 /* parameters helpers */
 
 AnnounceParameters *migrate_announce_params(void)
@@ -1062,7 +1076,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_announce_step, &p->has_block_bitmap_mapping,
         &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
         &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
-        &p->has_cpr_exec_command,
+        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
     };
 
     len = ARRAY_SIZE(has_fields);
@@ -1273,6 +1287,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_x_rdma_chunk_size &&
+        (params->x_rdma_chunk_size < MiB ||
+         params->x_rdma_chunk_size > GiB ||
+         !is_power_of_2(params->x_rdma_chunk_size))) {
+        error_setg(errp, "Option x_rdma_chunk_size expects "
+                   "a power of 2 in the range 1MiB to 1024MiB");
+        return false;
+    }
+
     return true;
 }
 
@@ -1398,6 +1421,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
         dest->direct_io = params->direct_io;
     }
 
+    if (params->has_x_rdma_chunk_size) {
+        dest->x_rdma_chunk_size = params->x_rdma_chunk_size;
+    }
+
     if (params->has_cpr_exec_command) {
         dest->cpr_exec_command = params->cpr_exec_command;
     }
@@ -1524,6 +1551,10 @@ static void migrate_params_apply(MigrationParameters *params)
         s->parameters.direct_io = params->direct_io;
     }
 
+    if (params->has_x_rdma_chunk_size) {
+        s->parameters.x_rdma_chunk_size = params->x_rdma_chunk_size;
+    }
+
     if (params->has_cpr_exec_command) {
         qapi_free_strList(s->parameters.cpr_exec_command);
         s->parameters.cpr_exec_command =
diff --git a/migration/options.h b/migration/options.h
index b502871097..b46221998a 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -87,6 +87,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
+uint64_t migrate_rdma_chunk_size(void);
 
 /* parameters helpers */
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 55ab85650a..3e37a1d440 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -45,10 +45,12 @@
 #define RDMA_RESOLVE_TIMEOUT_MS 10000
 
 /* Do not merge data if larger than this. */
-#define RDMA_MERGE_MAX (2 * 1024 * 1024)
-#define RDMA_SIGNALED_SEND_MAX (RDMA_MERGE_MAX / 4096)
+static inline uint64_t rdma_merge_max(void)
+{
+    return migrate_rdma_chunk_size() * 2;
+}
 
-#define RDMA_REG_CHUNK_SHIFT 20 /* 1 MB */
+#define RDMA_SIGNALED_SEND_MAX 512
 
 /*
  * This is only for non-live state being migrated.
@@ -527,21 +529,21 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
 static inline uint64_t ram_chunk_index(const uint8_t *start,
                                        const uint8_t *host)
 {
-    return ((uintptr_t) host - (uintptr_t) start) >> RDMA_REG_CHUNK_SHIFT;
+    return ((uintptr_t) host - (uintptr_t) start) / migrate_rdma_chunk_size();
 }
 
 static inline uint8_t *ram_chunk_start(const RDMALocalBlock *rdma_ram_block,
                                        uint64_t i)
 {
     return (uint8_t *)(uintptr_t)(rdma_ram_block->local_host_addr +
-                                  (i << RDMA_REG_CHUNK_SHIFT));
+                                  (i * migrate_rdma_chunk_size()));
 }
 
 static inline uint8_t *ram_chunk_end(const RDMALocalBlock *rdma_ram_block,
                                      uint64_t i)
 {
     uint8_t *result = ram_chunk_start(rdma_ram_block, i) +
-                                         (1UL << RDMA_REG_CHUNK_SHIFT);
+                                         migrate_rdma_chunk_size();
 
     if (result > (rdma_ram_block->local_host_addr + rdma_ram_block->length)) {
         result = rdma_ram_block->local_host_addr + rdma_ram_block->length;
@@ -1841,6 +1843,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
     struct ibv_send_wr *bad_wr;
     int reg_result_idx, ret, count = 0;
     uint64_t chunk, chunks;
+    uint64_t chunk_size = migrate_rdma_chunk_size();
     uint8_t *chunk_start, *chunk_end;
     RDMALocalBlock *block = &(rdma->local_ram_blocks.block[current_index]);
     RDMARegister reg;
@@ -1861,22 +1864,21 @@ retry:
     chunk_start = ram_chunk_start(block, chunk);
 
     if (block->is_ram_block) {
-        chunks = length / (1UL << RDMA_REG_CHUNK_SHIFT);
+        chunks = length / chunk_size;
 
-        if (chunks && ((length % (1UL << RDMA_REG_CHUNK_SHIFT)) == 0)) {
+        if (chunks && ((length % chunk_size) == 0)) {
             chunks--;
         }
     } else {
-        chunks = block->length / (1UL << RDMA_REG_CHUNK_SHIFT);
+        chunks = block->length / chunk_size;
 
-        if (chunks && ((block->length % (1UL << RDMA_REG_CHUNK_SHIFT)) == 0)) {
+        if (chunks && ((block->length % chunk_size) == 0)) {
             chunks--;
         }
     }
 
     trace_qemu_rdma_write_one_top(chunks + 1,
-                                  (chunks + 1) *
-                                  (1UL << RDMA_REG_CHUNK_SHIFT) / 1024 / 1024);
+                                  (chunks + 1) * chunk_size / 1024 / 1024);
 
     chunk_end = ram_chunk_end(block, chunk + chunks);
 
@@ -2176,7 +2178,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
     rdma->current_length += len;
 
     /* flush it if buffer is too large */
-    if (rdma->current_length >= RDMA_MERGE_MAX) {
+    if (rdma->current_length >= rdma_merge_max()) {
         return qemu_rdma_write_flush(rdma, errp);
     }
 
@@ -3522,7 +3524,7 @@ int rdma_registration_handle(QEMUFile *f)
                 } else {
                     chunk = reg->key.chunk;
                     host_addr = block->local_host_addr +
-                        (reg->key.chunk * (1UL << RDMA_REG_CHUNK_SHIFT));
+                        (reg->key.chunk * migrate_rdma_chunk_size());
                     /* Check for particularly bad chunk value */
                     if (host_addr < (void *)block->local_host_addr) {
                         error_report("rdma: bad chunk for block %s"
diff --git a/qapi/migration.json b/qapi/migration.json
index 7134d4ce47..0db115ec5e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -806,7 +806,7 @@
 #
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -831,6 +831,7 @@
            'mode',
            'zero-page-detection',
            'direct-io',
+           { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
            'cpr-exec-command'] }
 
 ##
@@ -1007,9 +1008,15 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @x-rdma-chunk-size: RDMA memory registration chunk size in bytes.
+#     Default is 1MiB.  Must be a power of 2 in the range
+#     [1MiB, 1024MiB].  Only applies when migrating via RDMA.
+#     Must be set to the same value on both source and destination
+#     before migration starts.  (Since 11.1)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -1046,6 +1053,8 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
+            '*x-rdma-chunk-size': { 'type': 'uint64',
+                                    'features': [ 'unstable' ] },
             '*cpr-exec-command': [ 'str' ]} }
 
 ##
-- 
2.43.7


