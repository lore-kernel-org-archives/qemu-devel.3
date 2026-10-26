Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A133606A327
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nzEDtAv8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOQg-0007M1-E7; Mon, 26 Oct 2026 13:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xLOQd-0007LV-07
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:24:11 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xLOQZ-0007FH-JT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWrcCLF10NpQWOsj3QNFYHPvpJV6r/V3YStD1niE8WcGiK9ai/jUFsnpEZ+uiGPmspMKDJmANSrSdyvBc9isUsG7w45/F2SgL7y18ZpXc7xMSKe0JiFYUvrlZCsHVm5Oeg1X3G5PWVWLCT7pLZ+Bk+22JqnLaYzmirJpz95zqi9MbljGXkaDapSDL2ucc5VsUoyNOvXWaerNu4khp4/VgPB/0MNEDixjmBrX7VYmq1fQQWykYNIepk8fO/iYSEW03R7k3/Uz5eqptpn9S56FAhnFkP/zJR7rIiTXqRPyjyJW792tt5VD+OC4Tz/jp87lSx/QKQi8DZanCjf1tmX6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF8Yj1CiyQDNKPHEXLgQH3IMA1Bt2ycL43QWAVSOvGs=;
 b=k4AcZSwxaCapu5sUubBLdbJQvSwAFpwxBnsW98vbZJK3YxhqgT+0yKvjy9uoYt2thzH7AxCOnxofnPSW7h/bXhYkGo60O5SP4yw5XCEdHdL0n93J0pbAgzRjnU34ks/ZIbHa4B7mR4/Wnd9KksOjtgBqehCBGmJWQKqC4o8Vi9nvWpG0rO8+ftNzHGSWYbBBAkK/N03m0cZv/I9gIrjUofKen+S3rdJ4ZSvvwmoulasvoaMhFrK/UOGB+hYUVnowhphgN7MPucosHNghHeCHa7Fn+bqua38d75O+PMPHBA6FlLUWZ4shjEDR+D5D5Lgbch2C4xHtObMSBDOQ49oW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF8Yj1CiyQDNKPHEXLgQH3IMA1Bt2ycL43QWAVSOvGs=;
 b=nzEDtAv8ZfeVVhOJO4rZf9u6uRRfMmbqyBUA3CZu8MbEWrhWIZY4NTOz1enoEdOr87A5GWMYrKa9EOZc2uCiAZpNy6Kjtxz+psQU/52+i0Jq6Aev/IwLJfkcY540GL9l/XstMSGgIRen9upT9lUzjSe3iAjPjZ6nBg4l4+w5la0=
Received: from DS7P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::6) by
 DS4PR12MB258939.namprd12.prod.outlook.com (2603:10b6:8:506::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 17:24:01 +0000
Received: from CY7PEPF000000EC.namprd04.prod.outlook.com
 (2603:10b6:8:25c:cafe::1a) by DS7P221CA0015.outlook.office365.com
 (2603:10b6:8:25c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 17:24:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000EC.mail.protection.outlook.com (10.167.247.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 17:24:01 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 12:23:58 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <thomas.lendacky@amd.com>, <huibo.wang@amd.com>
Subject: [PATCH v3 1/3] hw/cpu: Add async_run_on_cpu_after_accel()
Date: Mon, 26 Oct 2026 12:21:47 -0500
Message-ID: <20261026172300.2061829-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026172300.2061829-1-michael.roth@amd.com>
References: <20261026172300.2061829-1-michael.roth@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000EC:EE_|DS4PR12MB258939:EE_
X-MS-Office365-Filtering-Correlation-Id: c75c83a7-0cb7-41a2-6bb9-08df3385ed71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|30052699003|36860700016|82310400026|261026140227099003|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: iUMEsu0tVvDEPPdCqsv+9QZ6Y9EvgrtotFA7BXnj0Y5o7cQSBtL8XeLjLdRmPbkx+JO194+I7PlcrxrtprKT8I1Mvuzy1wVnAWWQkqOe1rXZU8G7tAZ7tMokXjk476HDbyH9G2DsZyuPGFWLIyLPI699n5VKEeFbjCsOIR8P8Y7aAYua50cA4BXsb32DPxbDJr6CYEF8uRgZzu/L6p3ouo54PIQGEoOelwFyU9Ic7BcQNoqC7WvHQMT6kwXVNhZeUV9DiPbjke5jSJ3juRpa2LwOFX0LTvOLnV3kJI0ZZnXfrQdd1OyruiTkOGVH8rSNgz4igx0UCZLaExM3MEK6dmswmQ5YWuM7MGUvo+CGofYsTZ5j61IaZ3uv7vgniYncVISI/2+rgHg6md6XW1lW0PO5g+u8Ifgpm1eNADuP5yFJvdsfpsN+K6yTHC80XQBWlTe5tjoohFCcSirhgDfqTWIkYaUgMijjS2PO3NawqNGlrCsxln4MmKobdZkqt6+qKQeL1GnA1CefAuPqSWJDCSJ8TWqQ4sw5Z3eKTcRoM7WScKp1jNQ8cHZCgON4yfDovJRn24i8oMff80c7nKQKIEg6IDNRqjGYGyk+ce50nCVF0Z7BYPj5P6+V+bibL9iHuxNRLfb1qY4NkYMDTtAYo1G2TaCz4AKjTkr5eok2ZEmdTdgKf8NotUdBkIZTkgYwgiEUnqy6RMyuPUlA0h9N0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(30052699003)(36860700016)(82310400026)(261026140227099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CgfUfJe0JHiXCVXUS7kMgfp53xyepGMnS0kv7s2UTqCynyc/V2MAHIII2QtqF+1BOXo2QyNZbNNKELooE8wys/hPt0fkXBBTQkYm3yjpQwF0d9ezU8U9XBKGIDub4xuXdTEk1Rb/1S4nEnfwQQDZbiRT1H7jX2eNt5JTfkDXqVjoX4DeUyi15Svc9R2PJzoQRwyaecuNCgRELvTX4573mjrDvztNpqi4JExgSSHDXlgIQxvWjUEqFgg/kHAW3KizieGm/1a5NZFwGNFIRFKciRidGt4Og/wsFj5w0s5wW2NwsGBTaOEpsOCMo7L2sncGDwF+hDr9bKT97WrP20ilMDP7ciLPkyskmAoPveE1EYa14WZ0O8JaT+GVy48XHVcMlaEksb0OGsYU76nlvgUENczGoJk9XpJ2NSsnFg7f4y9s6yOV4nUkhwwXP0eWJ1h2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 17:24:01.6323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75c83a7-0cb7-41a2-6bb9-08df3385ed71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000EC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB258939
Received-SPF: pass client-ip=2a01:111:f403:c112::7;
 envelope-from=Michael.Roth@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For some operations, hypervisors/accelerators like KVM might requiring
calling back into the accelerator code prior to userspace being able to
complete handling of certains operations. One common example is I/O
emulation where the accelerator call may be necessary to complete
pending work on the accelerator side and confirming completion to
userspace via another exit, which (for this particular case) already has
handling in KVM-specific code.

In some cases however, userspace may need to perform additional work on
behalf of the vCPU after the accelerator exists, requiring some kind of
per-vCPU callback mechanism. async_run_on_cpu() already provides
something very similar, but it forces an exit from the inner loop, and
is processed at the start of the outer loop, so those callbacks might
be issued before the accelerator has a chance to get called again.

Introduce a new variant, async_run_on_cpu_after_accel(), that is
designed to queue up work to be processed after the next accelerator
exit, and without unnecessarily forcing an exit from the inner loop. The
handling is via process_queued_cpu_accel_work(), which is left to
accelerator/arch-specific code to implement in their inner loops where
appropriate.

KVM will use this general per-vCPU infrastructure to handle callbacks
for these cases. Other accelerators maybe have other uses in the future.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 cpu-common.c          | 66 +++++++++++++++++++++++++++++++++++++++++++
 hw/core/cpu-common.c  |  2 ++
 include/hw/core/cpu.h | 33 ++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/cpu-common.c b/cpu-common.c
index adb76b3a78..0e735da673 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -141,6 +141,23 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
     cpu_exit(cpu);
 }
 
+/*
+ * Queue work on a CPU to run after the next accelerator exit.
+ *
+ * This helper intentionally leaves the inner loop running rather than forcing
+ * an exit via cpu_exit(), since the intention is to immediately call back into
+ * the accelerator to process pending events, and then upon exiting issue
+ * callbacks/notifications to any CPUs that need to complete any work that is
+ * pending on that accelerator call/exit.
+ */
+static void queue_accel_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
+{
+    assert(wi->free);
+    qemu_mutex_lock(&cpu->work_mutex);
+    QSIMPLEQ_INSERT_TAIL(&cpu->accel_work_list, wi, node);
+    qemu_mutex_unlock(&cpu->work_mutex);
+}
+
 void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
                    QemuMutex *mutex)
 {
@@ -178,6 +195,24 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     queue_work_on_cpu(cpu, wi);
 }
 
+void async_run_on_cpu_after_accel(CPUState *cpu, run_on_cpu_func func,
+                                  run_on_cpu_data data)
+{
+    struct qemu_work_item *wi;
+
+    wi = g_new0(struct qemu_work_item, 1);
+
+    /*
+     * Only asynchronous accelerator work items are allowed. I.e. wi->free
+     * must be true. Subsequent code will assert this.
+     */
+    wi->func = func;
+    wi->data = data;
+    wi->free = true;
+
+    queue_accel_work_on_cpu(cpu, wi);
+}
+
 /* Wait for pending exclusive operations to complete.  The CPU list lock
    must be held.  */
 static inline void exclusive_idle(void)
@@ -349,6 +384,37 @@ void free_queued_cpu_work(CPUState *cpu)
     }
 }
 
+void free_queued_cpu_accel_work(CPUState *cpu)
+{
+    while (!QSIMPLEQ_EMPTY(&cpu->accel_work_list)) {
+        struct qemu_work_item *wi = QSIMPLEQ_FIRST(&cpu->accel_work_list);
+        QSIMPLEQ_REMOVE_HEAD(&cpu->accel_work_list, node);
+        assert(wi->free);
+        g_free(wi);
+    }
+}
+
+void process_queued_cpu_accel_work(CPUState *cpu)
+{
+    struct qemu_work_item *wi;
+
+    qemu_mutex_lock(&cpu->work_mutex);
+
+    while (!QSIMPLEQ_EMPTY(&cpu->accel_work_list)) {
+        wi = QSIMPLEQ_FIRST(&cpu->accel_work_list);
+        QSIMPLEQ_REMOVE_HEAD(&cpu->accel_work_list, node);
+
+        qemu_mutex_unlock(&cpu->work_mutex);
+        wi->func(cpu, wi->data);
+        qemu_mutex_lock(&cpu->work_mutex);
+
+        assert(wi->free);
+        g_free(wi);
+    }
+
+    qemu_mutex_unlock(&cpu->work_mutex);
+}
+
 void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 4f4c87f33a..599963a85d 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -304,6 +304,7 @@ static void cpu_common_initfn(Object *obj)
     qemu_mutex_init(&cpu->work_mutex);
     qemu_lockcnt_init(&cpu->in_ioctl_lock);
     QSIMPLEQ_INIT(&cpu->work_list);
+    QSIMPLEQ_INIT(&cpu->accel_work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
@@ -332,6 +333,7 @@ static void cpu_common_finalize(Object *obj)
     }
 #endif
     free_queued_cpu_work(cpu);
+    free_queued_cpu_accel_work(cpu);
     /* If cleanup didn't happen in context to gdb_unregister_coprocessor_all */
     if (cpu->gdb_regs) {
         g_array_free(cpu->gdb_regs, TRUE);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5b7c330047..8c55269074 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -523,6 +523,7 @@ struct CPUState {
 
     QemuMutex work_mutex;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
+    QSIMPLEQ_HEAD(, qemu_work_item) accel_work_list;
 
     struct CPUAddressSpace *cpu_ases;
     AddressSpace *as;
@@ -968,6 +969,24 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
  */
 void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
+/**
+ * async_run_on_cpu_after_accel:
+ * @cpu: The vCPU to run on.
+ * @func: The function to be executed.
+ * @data: Data to pass to the function.
+ *
+ * Schedules the function @func for execution on the vCPU @cpu asynchronously,
+ * to be handled only after the next invocation of the configured accelerator.
+ * Unlike async_run_on_cpu(), @func will not be run with the BQL held and is
+ * instead left to @func itself to take if needed.
+ *
+ * This does not guarantee any sort of expedited exiting from the accelerator
+ * or the inner loop; this aspect is instead left up to
+ * accelerator/arch-specific code.
+ */
+void async_run_on_cpu_after_accel(CPUState *cpu, run_on_cpu_func func,
+                                  run_on_cpu_data data);
+
 /**
  * async_safe_run_on_cpu:
  * @cpu: The vCPU to run on.
@@ -1115,12 +1134,26 @@ void cpu_remove_sync(CPUState *cpu);
  */
 void free_queued_cpu_work(CPUState *cpu);
 
+/**
+ * free_queued_cpu_accel_work() - free all items on CPU accel work queue
+ * @cpu: The CPU which accel work queue to free.
+ */
+void free_queued_cpu_accel_work(CPUState *cpu);
+
 /**
  * process_queued_cpu_work() - process all items on CPU work queue
  * @cpu: The CPU which work queue to process.
  */
 void process_queued_cpu_work(CPUState *cpu);
 
+/**
+ * process_queued_cpu_accel_work() - process all items on CPU accel work queue
+ * @cpu: The CPU which work queue to process.
+ *
+ * Must be called without the BQL held.
+ */
+void process_queued_cpu_accel_work(CPUState *cpu);
+
 /**
  * cpu_exec_start:
  * @cpu: The CPU for the current thread.
-- 
2.43.0


