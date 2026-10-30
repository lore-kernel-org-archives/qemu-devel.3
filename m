Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E58606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0HO2yeOx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMm6y-0000s8-UN; Fri, 30 Oct 2026 08:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xMm6x-0000rd-5r
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:53:35 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xMm6v-0002xP-79
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYBna5IYbb3LadpPX0ERPVOi5Pl2db80bd1CWNNztk9nhUFz0kFjaaaCiwdqOUioZjugxCNxTeoglGBAaDXXlNEaygl7hUf91XN9nKRsL6p24xyljPoD9fZ4uKFhtM8DjGo1LnOoGUu/N9v7z2J3Ib6nT9wQTk3X6YUVd2hUAxsOt66pYX4QjKgx6JWaDcoORv6yXOfA6JWsH5DDmhCgHhyZRgxCCQj0bY2MBV7lyyu3zWQpUlsMm0u5lXV4iGo/o6imf77Sib4qiiTWftTz5xFmWlSZmS0+Ewb6zYoU81LjAFgsggrAODI40AbN844sp0EHVq6uzBWt7N1vqC+SDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAl7WnWk5TD7Ah8mt8vKlHCIhQl1PlsaHUx1rAE524M=;
 b=cmLO8VW5nGwdcGUkbONS2yLiakqADMX2qVhhjn3vR5Gv1Qlw8+TH0n/HKrMneHPKEBmWfldP093bJoDieS2tVPYeC7Q+O1N9je6IJMwSfsAVDXVGERKg6BZOEHi/Hz5T7d25bFYKOPXIHXQVBqVb1JFqRTOrwjS0p6ssWQzNRTLG2yblmGPyiDf91wXpmELJvLp2jxydZ5fkfCPF/cuUjbtP344vzZZP918fKAeW7VNjNuZu2cfXCGYeDTLCsPeupPsk034qOJKFn75qEUcECNJbyi+u8GT/8UncLEyLNNttho/hJkHtotWeqYvkZhelWUAwi2H4WhBILY3+zOUvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAl7WnWk5TD7Ah8mt8vKlHCIhQl1PlsaHUx1rAE524M=;
 b=0HO2yeOxqwpq2ffFuO0hrNDN5uWXNJne4HzDVzcBygDJOwB8X02ZhwixPYW+XaTnj4dXd2RHjhKhmub56SktPCYEdNsG/OAkMUJO6IGfyytDDEhPzVI1/p8vdoc8106JZ5Qif9aDzYeiuPJ5dxXYjanEKA70VM4BhT4u4zNwsfI=
Received: from SJ0PR05CA0180.namprd05.prod.outlook.com (2603:10b6:a03:339::35)
 by SAWPR12MB999141.namprd12.prod.outlook.com (2603:10b6:806:4e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 12:53:26 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::93) by SJ0PR05CA0180.outlook.office365.com
 (2603:10b6:a03:339::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4 via Frontend Transport; Fri, 30
 Oct 2026 12:53:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 12:53:26 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 07:53:25 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <huibo.wang@amd.com>
Subject: [PATCH v4 2/3] accel/kvm: Add kvm_immediate_exit callback
 infrastructure
Date: Fri, 30 Oct 2026 07:49:34 -0500
Message-ID: <20261030125228.2160752-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030125228.2160752-1-michael.roth@amd.com>
References: <20261030125228.2160752-1-michael.roth@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|SAWPR12MB999141:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f942328-c2a0-4b81-32e6-08df3684ca22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|22082099003|261026121527099003|18002099003|10067099003|11063799006|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261009223027099003|261026140227099003|56012099006;
X-Microsoft-Antispam-Message-Info: BvcHwh5iBYFyCgddOKpsWTMoz8iTf7ZrP2BItZBC//LIyebi6hGmknRA1AsByVEYPNiaLC7aaCGXLV1lojXinnI5zcf2Zn+PQZiqjqtHAzcd43Ar/ROff2ZoUGRDrfhdhx5eF9I5r6MP6kA+bFwCF09B214IgYljq79/UH4U1dnv8Sfx1sRW7xOGIRm/V9ldeZPWiwfakd6aSe5jzCUfbQ83CMgcN7LwsnfvqlI5TMkwP0Ksfa1Laz3BbjY0AA4Rir7072O5SqAyfWSVWYCuBiUokeBCc/PFtO05ZhBgEPWgUxppZPJH31WIHLLcVk0gTZ9iIh8cXIbx3mr3paEn8FLRK3S3NymrOZ7Jf7R8xiH0Od1W7Nf596aVeClI6BLYFf3j2NHLk6NNBxQ9LGdjKfWA0G8txFvQ12jdBTgd72h+j7wJ1P8687behEheBesCor2QXqSYq1517C4iCzAFy7q7ixagapee8nuK0wXxAb9T2SeCz9u8NwlUidPOztlRbUXjkzvcmck9RXIUlbnuPiIoSvOt1hTn7vSOHC67bzcoAKLlS4yxzG0Tmptem77Af1Uq2Luqh3+PT9pV1rotSfMldgT8nmGZQoJS2MC0/zJxCBGc1r/rn4fqe6P7cJ50diV+1TAUlGdoL+wzPJGhTyC4zIX0YHOORNSZsD6pbKg4LjLtn4JlV9DC9Kd/YF09DRe+odWBy++c7ITrcBUwEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(22082099003)(261026121527099003)(18002099003)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261026140227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jZLq0RKVJtIeBd6XHOqQyFX37Zzq+dtqChlEUvhJy7LJ82WA2KFcwyRVOHak0YEaSmT7BJyWBxCSsfAMyAZPMMgW2fO1OuW+Ce6uTErD+JoomNnjBSjcgiksNWJxm1uN+LUc4xQEJPA6Gwe3vvUVLb0tGgsvEWs1UEyfmIQiDtNgHy2LWJtqrEZqBE89Q2lCYrRmgjdTiqdWmupQYYNB9hQCYspuoNVK4WeSds/WvPL8DqFULQta/2nfnP1cqQAItAWHwYPPH5lxt+ED5ENtWuSjTsVQlXuSSZFYgheLRB+qP/ojHfy65YQ9x+B9TZyrapKmWKCti+sLxe3OmUCrMSduZy5nBwwxsn3yoIW+xmWxQTt/5Pop42Fet4T1lfZ9vH3BcO+fBzwbyEx++cXWfJ6S8UxLp9rL04JCljOclmh6+9RKbWWY9U8gudLSOWVp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:53:26.3461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f942328-c2a0-4b81-32e6-08df3684ca22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999141
Received-SPF: pass client-ip=2a01:111:f403:c112::5;
 envelope-from=Michael.Roth@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Provide a generic mechanism so that users of struct kvm_run's
'immediate_exit' flag can register a callback that can be issued after
returning from KVM. Utilize the recently-added
async_run_on_cpu_after_accel() interface, with a small wrapper to set
the 'immediate_exit' flag upon queuing of any new callbacks.

As with async_run_on_cpu_after_accel(), these callbacks are not run with
the BQL held; that is left to individual callback implementations when
needed.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 accel/kvm/kvm-all.c  | 21 +++++++++++++++++++++
 include/system/kvm.h | 11 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index db8fba53f3..fd908f9b51 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3449,6 +3449,19 @@ out_unref:
     return ret;
 }
 
+/*
+ * Queue up CPU work to run after the next call to KVM_RUN.
+ *
+ * Requires KVM_CAP_IMMEDIATE_EXIT.
+ */
+void kvm_add_immediate_exit_callback(CPUState *cpu, run_on_cpu_func cb,
+                                     run_on_cpu_data data)
+{
+    assert(kvm_immediate_exit);
+    async_run_on_cpu_after_accel(cpu, cb, data);
+    kvm_cpu_kick(cpu);
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     struct kvm_run *run = cpu->kvm_run;
@@ -3511,6 +3524,14 @@ int kvm_cpu_exec(CPUState *cpu)
             if (run_ret == -EINTR || run_ret == -EAGAIN) {
                 trace_kvm_io_window_exit();
                 kvm_eat_signals(cpu);
+                /*
+                 * This will process any events queued by
+                 * kvm_add_immediate_exit_callback(). This is intentionally run
+                 * after the 'immediate_exit' field is cleared by
+                 * kvm_eat_signals() so that queued accel work can requeue
+                 * itself if needed.
+                 */
+                process_queued_cpu_accel_work(cpu);
                 ret = EXCP_INTERRUPT;
                 break;
             }
diff --git a/include/system/kvm.h b/include/system/kvm.h
index d29624034c..2c08992bce 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -21,6 +21,7 @@
 #include "qemu/accel.h"
 #include "accel/accel-route.h"
 #include "qom/object.h"
+#include "hw/core/cpu.h"
 
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_KVM
@@ -594,4 +595,14 @@ void kvm_vcpufd_add_change_notifier(NotifierWithReturn *n);
  */
 void kvm_vcpufd_remove_change_notifier(NotifierWithReturn *n);
 
+/**
+ * kvm_add_immediate_exit_callback - register a callback to be performed after
+ * the next call to KVM_RUN (with immediate_exit set via kvm_cpu_kick()).
+ * @cpu: CPU to run the callback on.
+ * @cb: The callback to run.
+ * @data: The data to pass to the callback.
+ */
+void kvm_add_immediate_exit_callback(CPUState *cpu, run_on_cpu_func cb,
+                                     run_on_cpu_data data);
+
 #endif
-- 
2.43.0


