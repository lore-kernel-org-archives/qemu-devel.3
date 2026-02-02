Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07445E7FDE9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1Nh-0005UP-3F; Mon, 02 Feb 2026 16:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1N4-00058y-SV
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:22:13 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1N3-0007gK-7M
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:22:10 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso41023355e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067326; x=1770672126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F+HvSsb0ZAdJxK5XJMrPwEmF7QygJjcq1rhHcla45EU=;
 b=CKctd0djY8IASQKiQktVPyWWkWIp8cHvKd+21o+w4plXI3MrQiycShzRl26aQ5ZKy0
 BjDjmUuOJ1xmknObBtzexB1/kujzcvdpGtQTXwuAOzAuPVQ8ZOIaqOje+UPCDzChvO+Z
 WHd6d9B8zuk29M22HpA5VU0dT0Kn6honKhbcME4VZBQvFvJK08On9F9I7dOzTQ9gVFp5
 mI6nlXmzNoH2N2fjiN1CpwRLxPVCTzpCBy7FLJ1BTni5Onfpt+jTmVDeStwZuTDUB7H9
 Dsv2m2dxVPZunr/Xiz25oc5clQV2iDqCaVGbO+DsFexZ9uebNUTxYy35jJqODGOzDDZu
 U0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067326; x=1770672126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F+HvSsb0ZAdJxK5XJMrPwEmF7QygJjcq1rhHcla45EU=;
 b=AFnnJaS8E1OqvuG4cqctpgpT+nuNldS2xXUKselpCQvKdSKiyNjxeplygP0BEJzz/R
 xumZOjj7g6AA19eE/clRgDVjNTKYmckl4JCLunl9CxtAMPl/SrEDOkt2iyfbFTiI38OQ
 wTxwac78I0NDt67tZHxffq6JY90k6cfl2fqadXoZnKfbnVx5sZYYyG3HEa9OL2WM7Gd7
 b4RrmW0JB8NRf7jE3LV5jXMQfDymfIAV6fy+kgDtPb4gmTLKgGKrwbfiTqFCkmx5pEoK
 vQyAqI1TejXwVJeOT+jkSkK2ShHqKUqi3C8kKLN8BSXrth12xSUIijXpQ5dGa64uzXIr
 y4KA==
X-Gm-Message-State: AOJu0YwGOx7Jd4xjleAQTh75hfw2RLV4whU8vNZWXq9iyUa+y8wQOIyo
 p+KWWkqDMKkMLj3YjSk1dsXZBW2yQqXz5Y2t0YOYhBXPaouO4UJIEvPBVq2VJOqthIUWdYxMnrm
 VB8GA5Hc=
X-Gm-Gg: AZuq6aLDAfz5/q6LmL/0tjEaTvYis53xKSQFGES2IzAhgE+eZhMTrP0IrpWPVR9+f24
 OKoqGd1/oFkd+XXHxNkP+FLePcm0/AcV/w4aL2RAbXgV7pFzJHLubMhMvyWW2Tdo6spz34q+Ijj
 6VoXUku0KVZPK2XHRyH5Rtm5lpXsFFLiSWPm3zIBVW41hBhYQUPPA7eB65nh7+2TWzx/z5Idwoe
 qft5RFdGAN675I5D6QA83BVZNo6ZaonFEHO/Jt9amHm8DKaJLnHfDMzRFO2NYTHMmGa0Wgu4sz9
 uSkeIK5ygE9hjGbKVCXuOObUwnrBtFznIODolE+ZiD/N9O/sxEs3rezavoUGhCjVgmpOjqHChGv
 um3HQM71YON4SX/vUDefgRwwfRaWq2WmGyKu+VJjqspupWXNVAAtTxi3qccBrzbCQXol8XHVUN0
 oazMFZacKt+HET3WMLktY75jbjgec0xlqbzmuXLSxFzlVsoru6UvJ++li46X4U
X-Received: by 2002:a05:600c:8b27:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-482db4998ddmr161055115e9.27.1770067326253; 
 Mon, 02 Feb 2026 13:22:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48305129419sm14158905e9.6.2026.02.02.13.22.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:22:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] monitor: Add hmp_cmds_for_target() helper
Date: Mon,  2 Feb 2026 22:20:18 +0100
Message-ID: <20260202212019.94205-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

HMPCommand arrays are filled with target-specific
commands, so defined in a target-specific unit.
Introduce the hmp_cmds_for_target() to allow
target-agnostic code to access the arrays.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260129164039.58472-4-philmd@linaro.org>
---
 monitor/monitor-internal.h |  9 +++++++--
 monitor/hmp-target.c       | 13 ++++++++-----
 monitor/hmp.c              |  8 +++++---
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 7735c731083..feca111ae31 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -169,8 +169,6 @@ extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
-extern HMPCommand hmp_cmds[];
-
 void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
                        bool use_io_thread);
 void monitor_data_destroy(Monitor *mon);
@@ -187,4 +185,11 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
+/*
+ * hmp_cmds_for_target: Return array of HMPCommand entries
+ *
+ * If @info_command is true, return the particular 'info foo' commands array.
+ */
+HMPCommand *hmp_cmds_for_target(bool info_command);
+
 #endif
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 37dfd7fd4c6..59c60d13b52 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -44,8 +44,6 @@
 /* Make devices configuration available for use in hmp-commands*.hx templates */
 #include CONFIG_DEVICES
 
-static HMPCommand hmp_info_cmds[];
-
 /**
  * Is @name in the '|' separated list of names @list?
  */
@@ -76,11 +74,16 @@ static HMPCommand hmp_info_cmds[] = {
 };
 
 /* hmp_cmds and hmp_info_cmds would be sorted at runtime */
-HMPCommand hmp_cmds[] = {
+static HMPCommand hmp_cmds[] = {
 #include "hmp-commands.h"
     { NULL, NULL, },
 };
 
+HMPCommand *hmp_cmds_for_target(bool info_command)
+{
+    return info_command ? hmp_info_cmds : hmp_cmds;
+}
+
 /*
  * Set @pval to the value in the register identified by @name.
  * return 0 if OK, -1 if not found
@@ -148,7 +151,7 @@ static void __attribute__((__constructor__)) sortcmdlist(void)
 void monitor_register_hmp(const char *name, bool info,
                           void (*cmd)(Monitor *mon, const QDict *qdict))
 {
-    HMPCommand *table = info ? hmp_info_cmds : hmp_cmds;
+    HMPCommand *table = hmp_cmds_for_target(info);
 
     while (table->name != NULL) {
         if (strcmp(table->name, name) == 0) {
@@ -164,7 +167,7 @@ void monitor_register_hmp(const char *name, bool info,
 void monitor_register_hmp_info_hrt(const char *name,
                                    HumanReadableText *(*handler)(Error **errp))
 {
-    HMPCommand *table = hmp_info_cmds;
+    HMPCommand *table = hmp_cmds_for_target(true);
 
     while (table->name != NULL) {
         if (strcmp(table->name, name) == 0) {
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 4caafbc7146..17e5756986f 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -301,7 +301,7 @@ void hmp_help_cmd(Monitor *mon, const char *name)
     }
 
     /* 2. dump the contents according to parsed args */
-    help_cmd_dump(mon, hmp_cmds, args, nb_args, 0);
+    help_cmd_dump(mon, hmp_cmds_for_target(false), args, nb_args, 0);
 
     free_cmdline_args(args, nb_args);
 }
@@ -1131,7 +1131,8 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
 
     trace_handle_hmp_command(mon, cmdline);
 
-    cmd = monitor_parse_command(mon, cmdline, &cmdline, hmp_cmds);
+    cmd = monitor_parse_command(mon, cmdline, &cmdline,
+                                hmp_cmds_for_target(false));
     if (!cmd) {
         return;
     }
@@ -1375,7 +1376,8 @@ static void monitor_find_completion(void *opaque,
     }
 
     /* 2. auto complete according to args */
-    monitor_find_completion_by_table(mon, hmp_cmds, args, nb_args);
+    monitor_find_completion_by_table(mon, hmp_cmds_for_target(false),
+                                     args, nb_args);
 
 cleanup:
     free_cmdline_args(args, nb_args);
-- 
2.52.0


