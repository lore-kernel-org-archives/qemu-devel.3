Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C67BC98327
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 16:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh9BM-0003PJ-3h; Sat, 17 Jan 2026 11:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9BK-0003L6-LS
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:29:46 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9BI-0006DY-U6
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:29:46 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so2653965f8f.2
 for <qemu-devel@nongnu.org>; Sat, 17 Jan 2026 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768667383; x=1769272183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfRg586HPJ+mDGPLeFyi+xxSw4nPOXQ2RpG1oIDhHxM=;
 b=Fl7J6X4pLR3a50WUTHtLUyPJDH8W6464evcOq3qCsc9ghX0IuECshL3HCXCr9JfUr2
 xsLa3T0kToAcI7uvbvg7kSSLZB++l5U1L6VwOV1TOfWUxRWCAfZf1XIpMNmLnz6zH2S7
 yqLxUN3FruQd5h7Z0u3ZdpEAQYwhOxZb/X0ad9dlpGoceWcH++/xV/ACw+c9h4IjayT7
 INS76mumnvxua56ZjQOgmuEYZ/sal9nLSGj02PTwkxdyhbjLzXyvQiOY+2lh6DB1jqTk
 QFvsmYNQAKvogvqYyzUExey+lhIANFjytDVJRydMRBknLQCqYUM460Ec6cCKDP8Auaiw
 ROkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768667383; x=1769272183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VfRg586HPJ+mDGPLeFyi+xxSw4nPOXQ2RpG1oIDhHxM=;
 b=RO4S2QeR42t5zJ6sCleQw4W/5TtW/sRUpesuU+ZUqQlWWlegoh4ovfZUx7k0gKbTOL
 NpiQSLXUTfuzCFGBzXdAozys68CopnxOU92ovrtFOf9wV0QVHZ9XzrvD4l14HgYip1d2
 xQOqqC22uaqYwD6zziF6mUmdg0rI9F/pssaXJFm0TcrpUCXF2JeoeKMgmn9WcPnVmEH7
 vcIBGBPlw7laagPUu3rDtWtjGu0nrxyc6VOQdILx2kwBNScJ6ZXnFFl4dJE1DoKnamyy
 sQSateYOPmwSNnHxGHzOEO2Tq1DoSrXqX4n379ZTNr2PVtlw7L3whvZer2A8jQ6Xvs4M
 dkUA==
X-Gm-Message-State: AOJu0Yy8ApuPmsT1F6rQN0pM59O60AJsAioZEwPyo+9DkJz/Hkgssy/S
 D7f3GsCtI4L8f2Od6uPoRKs5btsAGKyAlMG1mthaf/o551eaCvMSnwBYKHN4aojn+vXUsQ/wYq9
 TrDa1nTI=
X-Gm-Gg: AY/fxX7yamCPJ4x4eHE+j0dWsPL+EMqdOogZsctc/2pV0BcNlbF9wFQZuZWZ+Y6pwTC
 3N5ynoRMdKh3hKkDAADM6y3etE5PdgPX/V2s94uy/zuTLAimCBqRZ5UqAFAXvgC2uZNDz9yLUsW
 s5LkjhjtGQg2OQaJ5Gih3K+12kvzKe9WYZPsq0QcMuWlNwaWXqbPSeRqF4FXZNVZZ7DboMngU0V
 gzxHIG89mmgR+Gn4DwuU5rUW24IxbO3OSBw+PNAOvIxcICX/ZuuetLFiNHw8e3Rw+McpiupysGN
 /x7Xieh2rtGTVD52OLtIb2sXflCTiHV5CaIc4RQrn0YR7HUrJANsmHr6k+xUWDNbH2bqIXEDWHy
 u04NLuNZBbZs/EFk/gk6Pk7Zhm5aHj/7aCYcEkBe6DraWv+C64Bmi4j/fu5DoJj7gHZW1NW4wi7
 9ipICJIpkHwL7SbeFKze/pBpC8WebIwGFgHT0vfjKij9cxSDbT8VbLSZIXYj5+
X-Received: by 2002:adf:fe51:0:b0:430:f5ed:83fc with SMTP id
 ffacd0b85a97d-43569970a6dmr6076847f8f.11.1768667382913; 
 Sat, 17 Jan 2026 08:29:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997eb1fsm12057839f8f.35.2026.01.17.08.29.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 Jan 2026 08:29:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/8] monitor: Add hmp_cmds_for_target() helper
Date: Sat, 17 Jan 2026 17:29:20 +0100
Message-ID: <20260117162926.74225-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117162926.74225-1-philmd@linaro.org>
References: <20260117162926.74225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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


