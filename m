Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDFEFF8861
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 12:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcU1-0006ag-4B; Sat, 25 Apr 2026 08:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wGcTx-0006aI-2O
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 08:51:38 -0400
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wGcTs-0001Ad-3N
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 08:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qA
 35ELgLfV3WQ47A+J7U+2Qbpuj2MRAZs59pEpnwF6A=; b=C8dPDT1y5wCh54Zf12
 J7Sqis90W25vS6HPCDUMesDLZfz4ikAlK0/w43zORrcNf7en5ZDLkNnOVIeWKNv8
 S2AqibydVLp/X3+8LJhZNBQOcrEBSs2FSZDLLkvJZ2gIPiwHt4XOsSm99jsmAgGi
 eP06Pc31Mx3qb+8g46v2lF/n0=
Received: from alano.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wDXP0XEuOxp+Fm4Bg--.64504S3; 
 Sat, 25 Apr 2026 20:51:21 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: dave@treblig.org,
	pbonzini@redhat.com,
	Alano Song <AlanoSong@163.com>
Subject: [PATCH v2 1/1] monitor: Add `clear` command
Date: Sat, 25 Apr 2026 20:51:13 +0800
Message-ID: <20260425125113.37341-2-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425125113.37341-1-AlanoSong@163.com>
References: <20260425125113.37341-1-AlanoSong@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXP0XEuOxp+Fm4Bg--.64504S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy8KFyfKrWUuw4rWr4xtFb_yoW8tF43pr
 Z5trWrK3y8J3Wxur1xAr9xWF15KrZ7uFZFkF9xAF98AF98Jw1Iva1kKr1qk3ZxXrWxKFyS
 vFy2qrWDGasFqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRxbbNUUUUU=
X-Originating-IP: [240e:36f:15cf:8780:308a:f2b4:e0e:95c7]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC9gn1CmnsuMmmhwAA3V
Received-SPF: pass client-ip=220.197.31.3; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The monitor screen can be cluttered after executing commands
like `info qtree`. It is useful to have a command to clear
current screen, just like linux `clear` command do.

This patch has been tested under monitors using stdio, vc,
tcp socket, unix socket and serial interfaces.

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 hmp-commands.hx       | 14 ++++++++++++++
 include/monitor/hmp.h |  1 +
 monitor/hmp-cmds.c    | 11 +++++++++++
 3 files changed, 26 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5cc4788f12..95f9166732 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -20,6 +20,20 @@ SRST
   Show the help for all commands or just for command *cmd*.
 ERST
 
+    {
+        .name       = "clear",
+        .args_type  = "",
+        .params     = "",
+        .help       = "clear the monitor screen",
+        .cmd        = hmp_clear,
+        .flags      = "p",
+    },
+
+SRST
+``clear``
+  Clear the monitor screen.
+ERST
+
     {
         .name       = "commit",
         .args_type  = "device:B",
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index e222bea60c..9b66458d21 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -165,6 +165,7 @@ void hmp_trace_event(Monitor *mon, const QDict *qdict);
 void hmp_trace_file(Monitor *mon, const QDict *qdict);
 void hmp_info_trace_events(Monitor *mon, const QDict *qdict);
 void hmp_help(Monitor *mon, const QDict *qdict);
+void hmp_clear(Monitor *mon, const QDict *qdict);
 void hmp_info_help(Monitor *mon, const QDict *qdict);
 void hmp_info_sync_profile(Monitor *mon, const QDict *qdict);
 void hmp_info_history(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bc26b39d70..608a208c6e 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -218,6 +218,17 @@ void hmp_help(Monitor *mon, const QDict *qdict)
     hmp_help_cmd(mon, qdict_get_try_str(qdict, "name"));
 }
 
+void hmp_clear(Monitor *mon, const QDict *qdict)
+{
+    /*
+     * Send an ANSI escape sequence:
+     * "\x1b[H" - move cursor to top-left
+     * "\x1b[2J" - clear visible screen
+     * "\x1b[3J" - clear scrollback
+     */
+    monitor_printf(mon, "\x1b[H\x1b[2J\x1b[3J");
+}
+
 void hmp_info_help(Monitor *mon, const QDict *qdict)
 {
     hmp_help_cmd(mon, "info");
-- 
2.43.0


