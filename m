Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E435EC54FC6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2024 20:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skrQo-0004Ix-V2; Sun, 01 Sep 2024 16:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxingran123456@outlook.com>)
 id 1sko9N-0002Mz-4r
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 13:14:05 -0400
Received: from mail-sy4aus01olkn20807.outbound.protection.outlook.com
 ([2a01:111:f403:2819::807]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxingran123456@outlook.com>)
 id 1sko9K-000630-9K
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 13:14:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ve2dNUeUW9nJVBWbBeho/pa/r0p9ZdXJWlEGgEcBDZWfckOA0Y178LsUbpKcFHQLEe6hNk2fjboVED51zPjHrMrwRAMKKOFWWwRLcb2wca1j/X6BaB3QAbHdC0i9HuE4wjfUYUsw19BnoTs8WSbBsLRdvvFVYVxk7iq9r755boNc5mdLUWW9/5hyUf7AX/Nt41AN7uDSfFyFo3xeHw6KkbTaILrsniWeJ7TpFv1mIQx80krvvoujcGGnye9WuWkVYzjfgDYkUhD86zet/MVW9JWTlsCenR6X1jZkTAr5r3pC4VJp6ZfM7PJQSWLBS8d+O4AGzr5zKmyQsiJoT8w3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BM2OP+5TCB/C9AVrntMMsJ/qOX9juZyhAtW4qSqNkA=;
 b=dSiMEJ88qiNA6sWuYhYEpar/psFDVdCU7aUR61ZAnavFMBfwiWzB/GoErFpbfNUOHkwnGpgZYtSvflR40MyQq7UtnFuabLjEp1TlVh2nLEtbf3U/meJ5fOxGElyUdHWPGQv17kP4QfbjDQCSWtRJvJ4NM/6oAN4AAuiePnc3kAOdOqhZu1+P+6NY/1AAIH7fsgt/j1cm/pB3Z598qw+X68ndA7XovfuAvgMpI2rSBt8jPNiXeoaCCrfSX3emKWE0pcXEjl7jia47gv+Ks/PRfxoa666EPyl+gtW/wO/E0h8Inu6Gq2muizaVgAKQNhMf1TSIvkcuOoYbTqHDF5ELhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BM2OP+5TCB/C9AVrntMMsJ/qOX9juZyhAtW4qSqNkA=;
 b=uYp3w2P6wpAQj8xOWeF3ljfvuJ1tYVNAnI2PTxHQhtWizINlCFHtmhpJ6OR3nMFCPAABD1uzpz8XujLpG5bgxYK8sGqsH7knOViEaElXPMyHR+9veAhJzCHa7Wj6GcODve3YTX1HU57JPpNnmalylX1aDdmHYQn8QQeTTxrAxOYpjEFQ8PjRK0JcjrJLxZ0DRNg0Ot7qydEaKRzr8Ja1aNFEBOdQyYREQ7DKwQ3ZI4CirNy3ivBkHSK4QrPbfyWWHNnrgsEGV53VaYGJ0eC7dbDzj11cLtKBFGKcycnQxDQKDfdQcS45hp/0iROTs+oPivhpvoTJVY/Dx9jtOUhObQ==
Received: from SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:258::8) by
 SY5P282MB4454.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:270::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Sun, 1 Sep 2024 16:37:07 +0000
Received: from SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7a8b:7271:4bc8:e317]) by SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7a8b:7271:4bc8:e317%7]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 16:37:07 +0000
From: Xingran Wang <wangxingran123456@outlook.com>
To: qemu-devel@nongnu.org
Cc: Xingran Wang <wangxingran123456@outlook.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] plugins: add two events for cpu_restore_state_from_tb() and
 cpu_io_recompile()
Date: Mon,  2 Sep 2024 00:34:06 +0800
Message-ID: <SY8P282MB4322879DBA2E5E3E3B72B383A1912@SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8ffQgFpobKdx+0iCWkl4N3gYQSrbHPro]
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:258::8)
X-Microsoft-Original-Message-ID: <20240901163406.2251666-1-wangxingran123456@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY8P282MB4322:EE_|SY5P282MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c929b2-8372-4ce2-5677-08dccaa451a1
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|5072599009|15080799006|8060799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: WynU/bQ2BT03nR/rJmFpE3uhNTV9u7afIWApk0+M+ZHha5h07g2ncZf+VXRQH9C4WptM34oVDyrosgvlrFI+dBGo+GI5UCxU/7feYh23kOysZDPg/bKNjHPAKipvYRjyn7GK4OV06Pw8qFUxLgv1B6l8pxv2cwHSjFwc8tYoREU2SMoWc/bkSDjnvICo9PB4ZRZbGdMwHhet9FZZBCWqBq8VhNI3yvuijpJwMiuXVv8FIYvKjcJsPG1tjnpLg6TQY69T3L1YcG6QDaljxEtR1826V15HCDTgS4bQsU5qRBXf89ZGxF4fBARahkdSk9nCUGJHbPqDevdVbtabrODYt+LR7vJ2hBuBC2v3tKzD3EMGN3HhOlz7CLJ2vwnAwLIQzTRp2ZzF/55ekyV0Er55uF4rW3lRZlva41MDkioWeR3Yb1PCDP7da9u7kuATi+HwUTf8yHirxXMt46d14pGdWMAqNkMhtFhmM1NyjeQQ4X3nbEvs0kOuoswc+bbt8EOee9NduQCTC8QKJL6WH0g94P8dBq5nekF6s0D50keWjinB4dzSY87rnL+ohe2ktzwRPMtfeBOdwl+kvSCaM3eExJYYANnSo0Dtk1j5WeuV49QKMaAmzAelZhqKm+W1gXoVNaagwGGA+LEQYqbvVBt3dZsItNTG18f5dveI5xCHooya7MXDatt+kYBTNMB+kqRukuMksA/fphHqt2VO36ZNf3rEd55CsvpVVvJW1Y9yaHA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AXL2QDjouPA5Pb/n42EgflWY7VNZcGpZgzKSumEVZHSRhi5Ba3hed9YEPD6f?=
 =?us-ascii?Q?hTQFg30ZPreEkxSl48g026RYW3YswWSA5ukqOATveKTNn4kg7/LF42oPRs7f?=
 =?us-ascii?Q?q68GCgkXmqDJCKVS540hFh2zQs0qoEe8nYrfyg7h6YR8drHUIVKeX9zxL0Md?=
 =?us-ascii?Q?QlZnm3nkdNVI9SLk5iXrdTeWOTNxX7R15yhIOXwuT/iu1PWUF5/xF8kvvHwO?=
 =?us-ascii?Q?UFjO0ntwGkXVwRd30xTfXbouz/blnXxlFMK71C2G1A4/lDgBaftudUvve9kV?=
 =?us-ascii?Q?DCHgWqCONKTaCuwhwcG8ogxrg0YQQfJISeFOCNt5WsJHLMnV7c+6H0LCPlvg?=
 =?us-ascii?Q?kb0FuCf/U/k2eqQRs3xc0wBbR1eDSOU4ca95JQD7pmGqj6Iv7UpwuC419Rjo?=
 =?us-ascii?Q?w3dJjIoUmbiPFkEDlTedcdueEXfkuzc7aAUgIkqcmqwsl2L82AUUrLGQpK+9?=
 =?us-ascii?Q?QGq8r5qTqtSG3RPp/5dOK0ogn9JJdHglfemrqKDqaefhhduDiEns5DvxECHG?=
 =?us-ascii?Q?BOH7eL6kOp4J6BXh/bU3sZANNX1J1kjCdygaYRgxYrE5NS3R8MjVh4aLu5l+?=
 =?us-ascii?Q?x4xesbBh/z2qRcIrj3pFdpeyVaqib4vz0dHjUsSeKrw7MxXaEa06Kun26DmG?=
 =?us-ascii?Q?Quba7Jn9KNOhe7aKXhElE/kKocHoP0NnfbACtNXcvcnl3PDRM+D03WXLIFeH?=
 =?us-ascii?Q?xZzKIGBCmSyNn8LvRt6qMdT7Vtk5dCxaud8q+r302ViEUcD26qqzlK7BsHLc?=
 =?us-ascii?Q?UvCudUAKZb10kOR2/wxAAa1DXJFax8YGEL2MaB7XzChbCp7agn+78CzLJYFF?=
 =?us-ascii?Q?G6gMtcSmti0JZPvtkvZgQt6zSoAdFHp63/V1wAJU61E29PZ3xKfcctJRNx1O?=
 =?us-ascii?Q?XZLw/Ups3DjqsQO/oxRH4MlHDlFbM0V7HO8IOGDXdajxmDdQMBs5fn5ASxlk?=
 =?us-ascii?Q?mEFoNQukh8clac0oRWJweWRLeh+HzpHHLiaXqhfdQ1lkc10q5YKhOjTy02Ae?=
 =?us-ascii?Q?W/HTnFMbILeVcuJZpqoOVY6V900t3B3rIRYUY8Fl0l3xNvh077fbUr/p7Ht7?=
 =?us-ascii?Q?1nDNCUfXjMOXXnS45G7PTVEtaZGh8muYgyspJtBuCDXxx+AHrIgnWn2MzvlG?=
 =?us-ascii?Q?eph2vuOnGVBAFpEzxlm0Sx3O3a7F9FK2OJYu04UdHWwv5M7UZWU9U8ED3qPx?=
 =?us-ascii?Q?IT1+NdZUUqKWrMi0XqcEWHNF2XdKyYR1BWLUbB5OlDZQeHvOujI8KCZoMX7K?=
 =?us-ascii?Q?N6M3toq/2GAhqg3J9qJ7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c929b2-8372-4ce2-5677-08dccaa451a1
X-MS-Exchange-CrossTenant-AuthSource: SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 16:37:07.4565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4454
X-OriginatorOrg: outlook.com
Received-SPF: pass client-ip=2a01:111:f403:2819::807;
 envelope-from=wangxingran123456@outlook.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Sep 2024 16:44:16 -0400
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

Currently, the instruction count obtained by plugins using the translation
block execution callback is larger than the actual value. Adding callbacks
in cpu_restore_state_from_tb() and cpu_io_recompile() allows plugins to
correct the instruction count when exiting a translation block
mid-execution, properly subtracting the excess unexecuted instructions.

Signed-off-by: Xingran Wang <wangxingran123456@outlook.com>
---
 accel/tcg/translate-all.c    |  27 ++++++++
 include/qemu/plugin-event.h  |   2 +
 include/qemu/plugin.h        |  24 +++++++
 include/qemu/qemu-plugin.h   | 131 +++++++++++++++++++++++++++++++++++
 plugins/api.c                |  78 +++++++++++++++++++++
 plugins/core.c               |  42 +++++++++++
 plugins/qemu-plugins.symbols |  10 +++
 tests/tcg/plugins/bb.c       |  25 +++++++
 8 files changed, 339 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fdf6d8ac19..642f684372 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -65,6 +65,7 @@
 #include "internal-target.h"
 #include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
+#include "qemu/plugin.h"
 
 TBContext tb_ctx;
 
@@ -218,6 +219,19 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
         cpu->neg.icount_decr.u16.low += insns_left;
     }
 
+#ifdef CONFIG_PLUGIN
+    /*
+     * Notify the plugin with the relevant information
+     * when restoring the execution state of a TB.
+     */
+    struct qemu_plugin_tb_restore ptb_restore;
+    ptb_restore.cpu_index = cpu->cpu_index;
+    ptb_restore.insns_left = insns_left;
+    ptb_restore.tb_n = tb->icount;
+    ptb_restore.tb_pc = tb->pc;
+    qemu_plugin_tb_restore_cb(cpu, &ptb_restore);
+#endif
+
     cpu->cc->tcg_ops->restore_state_to_opc(cpu, tb, data);
 }
 
@@ -641,6 +655,19 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
         }
     }
 
+#ifdef CONFIG_PLUGIN
+    /*
+     * Notify the plugin with the relevant information
+     * when cpu_io_recompile is triggered.
+     */
+    struct qemu_plugin_tb_recompile_io ptb_recompile_io;
+    ptb_recompile_io.cpu_index = cpu->cpu_index;
+    ptb_recompile_io.next_tb_n = n;
+    ptb_recompile_io.tb_pc = tb->pc;
+    ptb_recompile_io.cpu_pc = cpu->cc->get_pc(cpu);
+    qemu_plugin_tb_recompile_io_cb(cpu, &ptb_recompile_io);
+#endif
+
     cpu_loop_exit_noexc(cpu);
 }
 
diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
index 7056d8427b..875e2b6071 100644
--- a/include/qemu/plugin-event.h
+++ b/include/qemu/plugin-event.h
@@ -14,6 +14,8 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_INIT,
     QEMU_PLUGIN_EV_VCPU_EXIT,
     QEMU_PLUGIN_EV_VCPU_TB_TRANS,
+    QEMU_PLUGIN_EV_VCPU_TB_RESTORE,
+    QEMU_PLUGIN_EV_VCPU_TB_RECOMPILE_IO,
     QEMU_PLUGIN_EV_VCPU_IDLE,
     QEMU_PLUGIN_EV_VCPU_RESUME,
     QEMU_PLUGIN_EV_VCPU_SYSCALL,
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index af5f9db469..9250932e44 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -60,6 +60,8 @@ union qemu_plugin_cb_sig {
     qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
     qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
     qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
+    qemu_plugin_vcpu_tb_restore_cb_t   vcpu_tb_restore;
+    qemu_plugin_vcpu_tb_recompile_io_cb_t   vcpu_tb_recompile_io;
     qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
     qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
     qemu_plugin_vcpu_syscall_ret_cb_t vcpu_syscall_ret;
@@ -139,6 +141,22 @@ struct qemu_plugin_tb {
     GArray *cbs;
 };
 
+/* TranslationBlock Restore info */
+struct qemu_plugin_tb_restore {
+    unsigned int cpu_index;
+    int insns_left;
+    size_t tb_n;
+    uint64_t tb_pc;
+};
+
+/* TranslationBlock Recompile IO info */
+struct qemu_plugin_tb_recompile_io {
+    unsigned int cpu_index;
+    uint32_t next_tb_n;
+    uint64_t tb_pc;
+    uint64_t cpu_pc;
+};
+
 /**
  * struct CPUPluginState - per-CPU state for plugins
  * @event_mask: plugin event bitmap. Modified only via async work.
@@ -158,6 +176,12 @@ CPUPluginState *qemu_plugin_create_vcpu_state(void);
 void qemu_plugin_vcpu_init_hook(CPUState *cpu);
 void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
+void
+qemu_plugin_tb_restore_cb(CPUState *cpu,
+                          struct qemu_plugin_tb_restore *tb);
+void
+qemu_plugin_tb_recompile_io_cb(CPUState *cpu,
+                               struct qemu_plugin_tb_recompile_io *tb);
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
 void
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c71c705b69..e879175b23 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -228,6 +228,10 @@ struct qemu_plugin_tb;
 struct qemu_plugin_insn;
 /** struct qemu_plugin_scoreboard - Opaque handle for a scoreboard */
 struct qemu_plugin_scoreboard;
+/** struct qemu_plugin_tb_restore - Opaque handle for TB restore */
+struct qemu_plugin_tb_restore;
+/** struct qemu_plugin_tb_recompile_io - Opaque handle for recompile_io */
+struct qemu_plugin_tb_recompile_io;
 
 /**
  * typedef qemu_plugin_u64 - uint64_t member of an entry in a scoreboard
@@ -293,6 +297,22 @@ enum qemu_plugin_cond {
 typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
                                                struct qemu_plugin_tb *tb);
 
+/**
+ * typedef qemu_plugin_vcpu_tb_restore_cb_t - cpu restore state from TB callback
+ * @id: unique plugin id
+ * @tb_restore: opaque handle used for querying TB restore info.
+ */
+typedef void (*qemu_plugin_vcpu_tb_restore_cb_t)(qemu_plugin_id_t id,
+    struct qemu_plugin_tb_restore *tb_restore);
+
+/**
+ * typedef qemu_plugin_vcpu_tb_restore_cb_t - cpu io recompile callback
+ * @id: unique plugin id
+ * @tb_restore: opaque handle used for querying cpu io recompile info.
+ */
+typedef void (*qemu_plugin_vcpu_tb_recompile_io_cb_t)(qemu_plugin_id_t id,
+    struct qemu_plugin_tb_recompile_io *tb_recompile_io);
+
 /**
  * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
  * @id: plugin ID
@@ -309,6 +329,33 @@ QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t cb);
 
+/**
+ * qemu_plugin_register_vcpu_tb_restore_cb() - register a TB restore cb
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a TB restore occurs. The @cb
+ * function is passed an opaque qemu_plugin_type which it can query
+ * for additional information.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_tb_restore_cb(qemu_plugin_id_t id,
+    qemu_plugin_vcpu_tb_restore_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_tb_recompile_io_cb()
+ * register a cpu io recompile cb
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a cpu io recompile occurs. The @cb
+ * function is passed an opaque qemu_plugin_type which it can query
+ * for additional information.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_tb_recompile_io_cb(qemu_plugin_id_t id,
+    qemu_plugin_vcpu_tb_recompile_io_cb_t cb);
+
 /**
  * qemu_plugin_register_vcpu_tb_exec_cb() - register execution callback
  * @tb: the opaque qemu_plugin_tb handle for the translation
@@ -469,6 +516,90 @@ QEMU_PLUGIN_API
 struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
 
+/**
+ * qemu_plugin_tb_restore_cpu_index()
+ * query helper for cpu index where TB restore occurs
+ * @tb_restore: Opaque handle to the TB restore structure passed to the callback
+ *
+ * Returns: cpu index where the TB restore occurs.
+ */
+QEMU_PLUGIN_API
+unsigned int qemu_plugin_tb_restore_cpu_index(
+    const struct qemu_plugin_tb_restore *tb_restore);
+
+/**
+ * qemu_plugin_tb_restore_insns_left()
+ * query helper for number of unexecuted instructions in TB
+ * @tb_restore: Opaque handle to the TB restore structure passed to the callback
+ *
+ * Returns: number of unexecuted instructions in this block.
+ */
+QEMU_PLUGIN_API
+int qemu_plugin_tb_restore_insns_left(
+    const struct qemu_plugin_tb_restore *tb_restore);
+
+/**
+ * qemu_plugin_tb_restore_tb_n() - query helper for number of insns in TB
+ * @tb_restore: Opaque handle to the TB restore structure passed to the callback
+ *
+ * Returns: number of instructions in this block.
+ */
+QEMU_PLUGIN_API
+size_t qemu_plugin_tb_restore_tb_n(
+    const struct qemu_plugin_tb_restore *tb_restore);
+
+/**
+ * qemu_plugin_tb_restore_tb_pc() - query helper for vaddr of TB start
+ * @tb_restore: Opaque handle to the TB restore structure passed to the callback
+ *
+ * Returns: virtual address of block start.
+ */
+QEMU_PLUGIN_API
+uint64_t qemu_plugin_tb_restore_tb_pc(
+    const struct qemu_plugin_tb_restore *tb_restore);
+
+/**
+ * qemu_plugin_tb_recompile_io_cpu_index()
+ * query helper for cpu index where recompile I/O occurs
+ * @tb_recompile_io: Opaque handle to the TB recompile I/O structure
+ *
+ * Returns: cpu index where I/O recompile occurs.
+ */
+QEMU_PLUGIN_API
+unsigned int qemu_plugin_tb_recompile_io_cpu_index(
+    const struct qemu_plugin_tb_recompile_io *tb_recompile_io);
+
+/**
+ * qemu_plugin_tb_recompile_io_next_tb_n()
+ * query helper for number of insns in next TB
+ * @tb_recompile_io: Opaque handle to the TB recompile I/O structure
+ *
+ * Returns: number of instructions in next block.
+ */
+QEMU_PLUGIN_API
+uint32_t qemu_plugin_tb_recompile_io_next_tb_n(
+    const struct qemu_plugin_tb_recompile_io *tb_recompile_io);
+
+/**
+ * qemu_plugin_tb_recompile_io_tb_pc() - query helper for vaddr of TB start
+ * @tb_recompile_io: Opaque handle to the TB recompile I/O structure
+ *
+ * Returns: virtual address of block start.
+ */
+QEMU_PLUGIN_API
+uint64_t qemu_plugin_tb_recompile_io_tb_pc(
+    const struct qemu_plugin_tb_recompile_io *tb_recompile_io);
+
+/**
+ * qemu_plugin_tb_recompile_io_cpu_pc() - query helper for cpu program counter
+ * @tb_recompile_io: Opaque handle to the TB recompile I/O structure
+ *
+ * Returns: program counter of cpu where recompile I/O occurs.
+ */
+QEMU_PLUGIN_API
+uint64_t qemu_plugin_tb_recompile_io_cpu_pc(
+    const struct qemu_plugin_tb_recompile_io *tb_recompile_io);
+
 /**
  * qemu_plugin_insn_data() - copy instruction data
  * @insn: opaque instruction handle from qemu_plugin_tb_get_insn()
diff --git a/plugins/api.c b/plugins/api.c
index 2ff13d09de..50aee3b38c 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -206,6 +206,18 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_TB_TRANS, cb);
 }
 
+void qemu_plugin_register_vcpu_tb_restore_cb(qemu_plugin_id_t id,
+    qemu_plugin_vcpu_tb_restore_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_TB_RESTORE, cb);
+}
+
+void qemu_plugin_register_vcpu_tb_recompile_io_cb(qemu_plugin_id_t id,
+    qemu_plugin_vcpu_tb_recompile_io_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_TB_RECOMPILE_IO, cb);
+}
+
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb)
 {
@@ -257,6 +269,72 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
     return insn;
 }
 
+/*
+ * CPU restore state from TB information:
+ *
+ * A plugin can query various details about the TB being restored,
+ * including the CPU index, the number of remaining instructions to execute,
+ * the total number of instructions, and the virtual address of
+ * the start of the block.
+ */
+
+unsigned int qemu_plugin_tb_restore_cpu_index(
+    const struct qemu_plugin_tb_restore *tb_restore)
+{
+    return tb_restore->cpu_index;
+}
+
+int qemu_plugin_tb_restore_insns_left(
+    const struct qemu_plugin_tb_restore *tb_restore)
+{
+    return tb_restore->insns_left;
+}
+
+size_t qemu_plugin_tb_restore_tb_n(
+    const struct qemu_plugin_tb_restore *tb_restore)
+{
+    return tb_restore->tb_n;
+}
+
+uint64_t qemu_plugin_tb_restore_tb_pc(
+    const struct qemu_plugin_tb_restore *tb_restore)
+{
+    return tb_restore->tb_pc;
+}
+
+/*
+ * CPU Recompile I/O information:
+ *
+ * A plugin can query various details related to the I/O recompile process,
+ * including the CPU index, the number of instructions in next TB,
+ * the virtual address of the start of current block, and the program counter
+ * of the CPU at the time of the recompile.
+ */
+
+unsigned int qemu_plugin_tb_recompile_io_cpu_index(
+    const struct qemu_plugin_tb_recompile_io *tb_recompile_io)
+{
+    return tb_recompile_io->cpu_index;
+}
+
+uint32_t qemu_plugin_tb_recompile_io_next_tb_n(
+    const struct qemu_plugin_tb_recompile_io *tb_recompile_io)
+{
+    return tb_recompile_io->next_tb_n;
+}
+
+uint64_t qemu_plugin_tb_recompile_io_tb_pc(
+    const struct qemu_plugin_tb_recompile_io *tb_recompile_io)
+{
+    return tb_recompile_io->tb_pc;
+}
+
+uint64_t qemu_plugin_tb_recompile_io_cpu_pc(
+    const struct qemu_plugin_tb_recompile_io *tb_recompile_io)
+{
+    return tb_recompile_io->cpu_pc;
+}
+
 /*
  * Instruction information
  *
diff --git a/plugins/core.c b/plugins/core.c
index 2897453cac..a4f429b5f2 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -485,6 +485,48 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
+void qemu_plugin_tb_restore_cb(CPUState *cpu,
+                               struct qemu_plugin_tb_restore *tb_restore)
+{
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_TB_RESTORE;
+
+    /* no plugin_state->event_mask check here; caller should have checked */
+
+    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+        qemu_plugin_vcpu_tb_restore_cb_t func = cb->f.vcpu_tb_restore;
+
+        func(cb->ctx->id, tb_restore);
+    }
+}
+
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
+void qemu_plugin_tb_recompile_io_cb(CPUState *cpu,
+    struct qemu_plugin_tb_recompile_io *tb_recompile_io)
+{
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_TB_RECOMPILE_IO;
+
+    /* no plugin_state->event_mask check here; caller should have checked */
+
+    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+        qemu_plugin_vcpu_tb_recompile_io_cb_t func = cb->f.vcpu_tb_recompile_io;
+
+        func(cb->ctx->id, tb_recompile_io);
+    }
+}
+
 /*
  * Disable CFI checks.
  * The callback function has been loaded from an external library so we do not
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index ca773d8d9f..7dcd9f76d5 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -38,6 +38,8 @@
   qemu_plugin_register_vcpu_tb_exec_cond_cb;
   qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_tb_trans_cb;
+  qemu_plugin_register_vcpu_tb_restore_cb;
+  qemu_plugin_register_vcpu_tb_recompile_io_cb;
   qemu_plugin_request_time_control;
   qemu_plugin_reset;
   qemu_plugin_scoreboard_free;
@@ -47,6 +49,14 @@
   qemu_plugin_tb_get_insn;
   qemu_plugin_tb_n_insns;
   qemu_plugin_tb_vaddr;
+  qemu_plugin_tb_restore_cpu_index;
+  qemu_plugin_tb_restore_insns_left;
+  qemu_plugin_tb_restore_tb_n;
+  qemu_plugin_tb_restore_tb_pc;
+  qemu_plugin_tb_recompile_io_cpu_index;
+  qemu_plugin_tb_recompile_io_next_tb_n;
+  qemu_plugin_tb_recompile_io_tb_pc;
+  qemu_plugin_tb_recompile_io_cpu_pc;
   qemu_plugin_u64_add;
   qemu_plugin_u64_get;
   qemu_plugin_u64_set;
diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
index 36776dee1e..18a16e885f 100644
--- a/tests/tcg/plugins/bb.c
+++ b/tests/tcg/plugins/bb.c
@@ -93,6 +93,29 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
+static void vcpu_tb_restore(qemu_plugin_id_t id,
+                            struct qemu_plugin_tb_restore *tb_restore)
+{
+    unsigned int cpu_index;
+    cpu_index = qemu_plugin_tb_restore_cpu_index(tb_restore);
+    CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
+
+    size_t insns_left = qemu_plugin_tb_restore_insns_left(tb_restore);
+    count->insn_count -= insns_left;
+}
+
+static void vcpu_tb_recompile_io(qemu_plugin_id_t id,
+    struct qemu_plugin_tb_recompile_io *tb_recompile_io)
+{
+    unsigned int cpu_index;
+    cpu_index = qemu_plugin_tb_recompile_io_cpu_index(tb_recompile_io);
+    CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
+
+    uint32_t next_tb_n = qemu_plugin_tb_recompile_io_next_tb_n(tb_recompile_io);
+    count->insn_count += next_tb_n;
+}
+
+
 QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
@@ -128,6 +151,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_restore_cb(id, vcpu_tb_restore);
+    qemu_plugin_register_vcpu_tb_recompile_io_cb(id, vcpu_tb_recompile_io);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
-- 
2.34.1


