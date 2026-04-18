Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F253F99C89
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 20:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wECCS-00018s-9I; Sat, 18 Apr 2026 16:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wE5tt-0008OU-Jn
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 09:39:58 -0400
Received: from m16.mail.163.com ([117.135.210.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wE5tl-00015p-Sj
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 09:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=S+
 1HLW44bNI9f/DBkTRy2j11jyEQ6a4jbbdW2UT62Bc=; b=ZngS70lRconlWRP7vF
 5J95qJi/YBVpXD3gjR207brwPRu5Yb527LrX8bhbM0/580Q1pWNDiyvs1Aaoa0ed
 UJKkf8jERbzQjS1kKzCD1dJRDYwNxbpSN2k5UsNsVUajrLHllxbqZkTGVLElaYFf
 UtYbL5h7YgaUnoGsFY3yCUWbo=
Received: from alano.. (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wAnbwyRieNpZgJ8AQ--.38013S2; 
 Sat, 18 Apr 2026 21:39:29 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: dave@treblig.org,
	pbonzini@redhat.com,
	Alano Song <AlanoSong@163.com>
Subject: [PATCH] monitor: Add `clear` command
Date: Sat, 18 Apr 2026 21:39:27 +0800
Message-ID: <20260418133927.43012-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnbwyRieNpZgJ8AQ--.38013S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy8KFyfKrWUuw4rWr4xtFb_yoW8uryDpr
 s3trWrK3y8J3W3ur18Jr9xXF15CrZ7uFZFkFn8Z3s8AF98Jw1Iva1DKr1jk3ZxZrWxKFyS
 vFy2qrWDGa9Fqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR_9NcUUUUU=
X-Originating-IP: [240e:36f:15d3:7310:8613:2c33:e4f6:6535]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC9RLZ7WnjiZJ71QAA3s
Received-SPF: pass client-ip=117.135.210.4; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 18 Apr 2026 16:23:25 -0400
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
 monitor/hmp-cmds.c    |  5 +++++
 3 files changed, 20 insertions(+)

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
index bc26b39d70..3e9485478e 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -218,6 +218,11 @@ void hmp_help(Monitor *mon, const QDict *qdict)
     hmp_help_cmd(mon, qdict_get_try_str(qdict, "name"));
 }
 
+void hmp_clear(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "\x1b[3J\x1b[2J\x1b[H");
+}
+
 void hmp_info_help(Monitor *mon, const QDict *qdict)
 {
     hmp_help_cmd(mon, "info");
-- 
2.43.0


