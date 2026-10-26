Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1315606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OcWHPa6Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOR4-0007TD-PY; Mon, 26 Oct 2026 13:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xLOQv-0007N5-02
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:24:31 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xLOQt-0007GK-3i
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:24:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV9men4rkt1lw4yxVuBxalDJDwmXz3ipqIEvTkz2708iYLBO5nQSV+lspwsor5kbTpTae4THMF2Hnpz4/NVucovOcRPpWsLlbohFhPgpPBLAZv1VtJRFaBuvxes8NnT1Z00XDUC3Ggt81pwE7gXrrKI4EAYQuOn6iaI2k/Oxg03AsqA+ma4QOuNnVJV/OJpYgHFk6XZivAyKV6aScntr+18pKTIOD/XjhwKn5I3rC1DrCxL7tZiMSWteP9OzZntyqR/EigohOYcaV2ghzLGffNturVaI8ernaJqQ0j/aPYyzvEp2CQeIy0yomHD3bSqmxPJM43Gy2kV9wHlmOdOsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8GBiUtmAHnfg3kH79SSMByFny7bcN4DvB/ldo/Lfi0=;
 b=P6jK8Skb3Lr+2dcrK3VwFmpPl9LEnWBT08eOCOqxKCWdjpHKE7ovdT25fBnc4SeVtbt2XhkI79HUaQOoaJYXQVgkrEGH4OkMLgGVU55Qh/Cz5WFgUk86pVfCPmPciIBaOIjYK1VYnb+pM2z0DqjIYa3etOAzk1zeVRauU5OXkYk0g159FMZeTz1UKBhVDdQiR7GMYvyhRzp0+gNGu9ObLPwCPHFyKN9KfgUNbg6XVSz2ixZ0j8HIvqoMibVxzblVGaxu1U++KXChuZY/PBcUannabY2jlwyTD5+yiDHiVKrVLP/0+HSgSUEJrfczuYwqbRraSzIsqe5DeIqPXRSttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8GBiUtmAHnfg3kH79SSMByFny7bcN4DvB/ldo/Lfi0=;
 b=OcWHPa6QuuE0slVGYBjD5IjQ05YYyiDr8YCC51urCGqkMaih/sjARrqpSRxV9tvNF6QIUpFIyqc6AnIwS4+d0YPYty2Wlk1qrIFItPLuSNVWaZBSlNZuQe6sKSQqdFiL5SZsBmoSnZl9kdxngUVVtjcm+6Uke4zG7w0VMTNAArM=
Received: from DM6PR04CA0021.namprd04.prod.outlook.com (2603:10b6:5:334::26)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 17:24:20 +0000
Received: from DS8PEPF000000E0.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::5) by DM6PR04CA0021.outlook.office365.com
 (2603:10b6:5:334::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 17:24:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E0.mail.protection.outlook.com (10.167.23.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 17:24:20 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 12:24:19 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <thomas.lendacky@amd.com>, <huibo.wang@amd.com>
Subject: [PATCH v3 2/3] accel/kvm: Add kvm_immediate_exit callback
 infrastructure
Date: Mon, 26 Oct 2026 12:21:48 -0500
Message-ID: <20261026172300.2061829-3-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E0:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 3843f10a-df29-464f-998b-08df3385f86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|22082099003|261026140227099003|56012099006|11063799006|261022105027099003|10067099003|261021121427099003|261009223027099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: z4hJLSPQBjq69cZ12ov+s5AI28puFytp/EGshhAc2qMVqv6cEJjTS63xbJfzHOMcUewQfZ73hON5vHg/6RsTM82gQ4wq/X7vQaFSce0jQ8Zw62xqTBIS//joByndXb9Sz9szH+PVUIEisUMxndUg5friulRW/fBG2TDqxEohVPr4xcERiTrIG+A5T0YQc1vbEpNcMIS66Un8IBokm44RNWqnUAOfjdooAMkp1fdnj+u5wWB35RLdi2dMb1ce50PNvr+BCuE6BXO7hXC39wRQdtgDHBpXGKwJOnzTnfUTmZIzkYZ0xrrU9sldMYyOD12um5fAOf00OiKZ4xeTV4Q1z4uRFZVE0ABFvGuZQJtSVTY5ls0CGVbTxbA+xL6k3LXxPrHX0kctHwu+5850CNKDsMIVKiqQArXgX552y6GmPVUgIwISmwnsMkKosoMUTVesSFEcU44h8TZXCMitfwNj+lAkUniExrJSSXKFoeF37eICeaUz/JXX2o0qLTBNOmOHVfvo/cVpWv7o0MRTOambGtwry37OxPvp1rWxtw5RuuF0fdC994QCbl63OT6WsK/XgSY8tJ8G6rtEeyeCVHNNNSLbclFngUQIKyE3lSPxGAty4C/JlZd05kcdop8gyu2IA37DBvdtFGSaJLOlPaJ8moWPtu3e9/0nXuwytcYv4GBO3qyDdRUn/C3ybZrhiv5U+N3L5ctsBVVi4BRC3YcCCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(261026140227099003)(56012099006)(11063799006)(261022105027099003)(10067099003)(261021121427099003)(261009223027099003)(261022075727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q8vuvBuumro7c0f898HuCmZJcywoe4o9KK9VZZDzNH/eXaV0pYq8/qE7NHQtJlFuyQewW6/uPrIuyeWgNOYPtmM7dAkOroi21Z7dx65ZzThAiFHLxqzWambo7hVFjQAoyPC7ECZvxahXTHeMvSoX15pAx00ZdDQKVw3XisUoveh+Q1tqBbLY26ZGOx/Ln1mQ9LEphkQTyYEyVLMudHhlBMcDxXRHItQV+8oSDID4/bHwTRFeypt7rkZx85iaZZPJ3zpDdbtGmeUQjRB/ntB/N5C68mgQmNGPWJ8MQKs86a5Wvq4nu851vREjX42fi81DuRfQmbMgfhNbZ+Uu88JOH1XDo7kl/gVdUPcJK2AxT6rP0yyDJX1/RrB0ApaNaJA+UM8A6PSeQTPdyuRXl7h0n9gMhqm5ltZ2gQXvRe80B/jUD/yv5Gc6jRdDAJ2C9req
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 17:24:20.0884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3843f10a-df29-464f-998b-08df3385f86a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS8PEPF000000E0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=Michael.Roth@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Provide a generic mechanism so that users of struct kvm_run's
'immediate_exit' flag can register a callback that can be issued after
returning from KVM. Utilize the recently-added
async_run_on_cpu_after_accel() interface, with a small wrapper to set
the 'immediate_exit' to arm any new callbacks.

As with async_run_on_cpu_after_accel(), these callbacks are not run with
the BQL held; that is left to individual callback implementations when
needed.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 accel/kvm/kvm-all.c  | 20 ++++++++++++++++++++
 include/system/kvm.h | 11 +++++++++++
 2 files changed, 31 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index db8fba53f3..a6bc0b3bed 100644
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
@@ -3511,6 +3524,13 @@ int kvm_cpu_exec(CPUState *cpu)
             if (run_ret == -EINTR || run_ret == -EAGAIN) {
                 trace_kvm_io_window_exit();
                 kvm_eat_signals(cpu);
+                /*
+                 * This will process any events queued by
+                 * kvm_add_immediate_exit_callback(). This is intentionally run
+                 * after 'immediate_exit' field is cleared by kvm_eat_signal()
+                 * so that queued accel work can requeue itself if needed.
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


