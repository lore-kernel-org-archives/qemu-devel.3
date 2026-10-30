Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0370606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gxgc8mfN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMm6g-0000aB-81; Fri, 30 Oct 2026 08:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xMm6e-0000Zz-Fb
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:53:17 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xMm6c-0002vz-5J
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:53:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4KNlaHalRjgco1uCT48JKBqp/HfVjNulNK5GnKB1FgoAcq3mqiDRidri7ZCLHqoyhjdIPZt/ZVUgUWFqt2pZRqog/gnBh7Rh0aJkCmfW4C+OIYPq87mbuk0BrgAimq/nDVoSh7PnOHO4CLTt9OMr9wwm8VsKkNisIdNStE1AcF3fpXrdoFUwQrL7DitI2AmWRgd87vX09G45nNxuQM26NNdCTd7AQ+mfIl7PXl1xo4zXTThJaW1Z0pN2xw1MspmieLz3ZFWQLs191kphxKgIILSmvCo6m1mNR7dwaIq2sq6O0LS0NJJp+YnNncCK/plKrmDyFjDB/7khu8y8ivBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg2rGPpsazLeYxGfFI2aGtZJDGCcW0nt5cRKeDfWHvw=;
 b=iKhDOrpDim+yW2AVYUepztiV4fnV0ReH5YQlHpdw/9fi3SCArxcU5DNBlV9u+7No1aPNNgPlEsRckwPlyRglDZ7IX0WHLaGGlma+3yEb9UHPtmN110zRQP+If99EMNS9p5LNFmdMj1gYvgULAjX4omSeS9RekxJw5p7bWHWMJZAPlS6AEs4sOjlcVYESipG8c3ePR/VQrNbW5uQappYU9SAe/bWtL3WL/4mj8il1OkNQOXlwbzgI4iKquIhMb1VMHLCHJldVZyqlO+4oyfZeIbW5Dsz+s6s5DAJawjUbfpYQKkygJ74jQPVAwwU52+ryOiRt4wDtbAJCgU54s+M6Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg2rGPpsazLeYxGfFI2aGtZJDGCcW0nt5cRKeDfWHvw=;
 b=gxgc8mfNm09EBF/0a7R44VchingygbDoNNZiQ45B0l+i2r5e/WarGrzSoQHN8bd3PBPVOMN+j9H6UaKPu/uarulkHqw6aQPSGbsdFeaNvnuPE9r1ims224AI90NyvTP+a4N6Jx3zYxXHmQmi6wm3pBAD+uePVixZIaxJEkScPaI=
Received: from BY3PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:217::27)
 by DSVPR12MB999126.namprd12.prod.outlook.com (2603:10b6:8:383::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 12:53:06 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::4) by BY3PR04CA0022.outlook.office365.com
 (2603:10b6:a03:217::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 12:53:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 12:53:05 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 07:53:04 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <huibo.wang@amd.com>
Subject: [PATCH v4 1/3] hw/cpu: Add async_run_on_cpu_after_accel()
Date: Fri, 30 Oct 2026 07:49:33 -0500
Message-ID: <20261030125228.2160752-2-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|DSVPR12MB999126:EE_
X-MS-Office365-Filtering-Correlation-Id: 774345f1-0c9d-4ea7-147c-08df3684bdd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|30052699003|23010399003|10067099003|11063799006|6133799003|261009223027099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|56012099006|261026121527099003|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C2kGza0RCtDtilLXZ5GY7maZp3kpfLsnTW3BmHfjr7m3GpDDcullLq2/325HdTpOuq9Sb42AlVcnRra7wQv8GdtSJHspM18XPVHKzGpkXpsxgoaE7S7XPYT7MmTjrcfpXQYUGdrC6FHgHWdTiGmjLHje9aChom5VtekYVePTV4BMf8RQOM7SmGfEBexCo7GawPIil3w1pBRjOLpOgQfVklVRVU9Z5MeYqmn+0mNriShhBMJS736xBmHowC9uB+aS8+3zoD9YYl5YuXFQ33igFV/F96gVeLMGu9/xfTUlhcLRkfd3h95V1Vtu2fnVxRbRbrrMEQNhvP6cns1PfP/MBLyMCS63kOdD3pK2RRsc/DYF6drKOAdJgIXlt2xQ7EbFKEPlJ+tqs0X4BYl3rYi66y0+5kw/gDD7YVJ3sVuSXBCpERDwazgXoAW4OAM1V8iLMpgmKvWFPbjuPXhCMqhPbgpgcahR9f4wxGDPux2HVjSS9r4QMDQk18XTdEUKQV7S5t6tzUleQ5AsYgGZx9+g2/jzaZzrvtJNRb6F9sL4LqrK3Xrb4xoq0u17RIr1RH8MtLj08dAp4wuJcEFj3kyubNbr6AAA6OS0KDtYL088W6wkfq2hTSWppkcdyl9in0ZLtQFVKJnuVcL1ZyMQPs1DcvMHEDg2LqUT1mKzu+rE3/yZ1SAux7W8PW2Fh6vFaB/ykoNY71NQ5GFI9mRWDiPwHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(30052699003)(23010399003)(10067099003)(11063799006)(6133799003)(261009223027099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(56012099006)(261026121527099003)(261026140227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n39cxf+7Rv72k1vX8AfNqcVpjRVFoypg6vX/UvoRoBKOO+CKqkOJcnjmLx8MKB5XNWyNBKEQeZ6/xUmWu41q4HSYr4tSSQaCNSfoiiM8fvsqM/wbS22vsU0p2U6InOP2KxJwd/irNcpmGdG4iOmBvjcGVhPEl9wKV4AT5o0tHTTMKRJ6wpuT8VWldzPQDV4kSlw49fA95W1EZeaT2SCvWiNtgf7f3zrIE5p22+u2b5lmvAR9WP7gOjll4AEutBQmtpbqjwdrBvDiwhtrWSmVVgUIKa/qizU0VecRnIlgDjnGRmkfQU/y734F3lIttbHcsRWiSC7dHMafK2oaCXOGSoa/+KNjFaGyliqVm2uOJPIcJwH6vRZZGOhLF475BQE7ra0A438kRGXmnolyCt4n0vU3r43jk2H/pREJ0/az/tG8KWusUMod/tq0EVrNXCjG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:53:05.6738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 774345f1-0c9d-4ea7-147c-08df3684bdd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999126
Received-SPF: pass client-ip=2a01:111:f403:c107::9;
 envelope-from=Michael.Roth@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For some operations, hypervisors/accelerators like KVM might require
calling back into the accelerator code prior to userspace being able to
complete handling of certain operations. One common example is I/O
emulation where the accelerator call may be necessary to complete
pending work on the accelerator side, which then signals completion to
userspace via another CPU exit, such is the case with KVM via the
existing 'immediate_exit' machinery.

In some cases however, userspace may need to perform additional work on
behalf of the vCPU after the accelerator exits, requiring some kind of
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
for these cases. Other accelerators may have other uses in the future.

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
index 5b7c330047..30cd88eb0f 100644
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
+ * Unlike async_run_on_cpu(), @func will not be run with the BQL held; taking
+ * the lock is instead left to @func to handle if needed.
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


