Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C64D358D6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlV4u-0000f4-2U; Thu, 29 Jan 2026 11:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV4s-0000VC-2J
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV4p-0005C6-14
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:05 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so1021024f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769704861; x=1770309661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/5ri0x0HKOQ4AevWnY2CiNFX91P9a3QRDv363s7aV8=;
 b=kiAFKySkBMrXLTZwgavZueliq/6dukSt5nYF+cLVicuv/ZAdIRwplI6ms0f8kfkzgr
 jBXiQ4CIPUrZV6BpTdVeldTTPKn+xWTuQUs6BoBckemQGgXn+4Qke/DV55m/sIWOxAkR
 XA868fn/9lSSXt6lrLvaA20abIEFzXqdAifJ4AKJ+2vuuxzjaeDZQmVnf26CLjmqNiw3
 DCwKfd2N+M5EoWBYnmSbcFouH/rOa+byLlab5abgZZgj0duVB6NaJe2GMFxQA3rdOLz5
 HwfPvrywWU++1uioVR4cwGFzhYSb02Fe9ZbNETZPUrUUwrvE/UTlnqP+v/iig6VWACqt
 yJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704861; x=1770309661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2/5ri0x0HKOQ4AevWnY2CiNFX91P9a3QRDv363s7aV8=;
 b=mC5CbXaGgKA6OhH9eubcbNarx5BGPxiyHzFv0MrAbxJVqqHXA3eU/4PJnD1/ERckKL
 1gd6SxsdwYadp3ygNEPhj87nNsOAqfbhsrsz/+KwTJEf/IQh/LorbxghOaNLYGYSc9rh
 kPF2tbTR3t40fJdCB+tY4OLOCjMOQ42zJxAM02ODbAch1mrjLVDCbHXr6qxavl8OOtlr
 oLfVekz50iekvwKeB2DB74nK9L/WDnrA01n9By5tKYSyNccBkB7ZBCCDbi6QchLcL63+
 NVwMNh3CiCIoze+9y1SF4rFipzdZTJjUnnqSdOwo9ZzqPg1E5oPKWqbEjMpuLxh8NzE/
 z2FA==
X-Gm-Message-State: AOJu0YwmH8qcGchz98nnNgDBdm7dnhnuszP1RxHBj9YlcJfwZ8RQVhyZ
 8zjYnNSRvwaugl7Dxf1/TSAjTRT+IOFpC3SdyTKXqgSCsFcbTUtF2RFRl9iTdbwEzECc0lsY/z+
 +vPYsR+0=
X-Gm-Gg: AZuq6aKHw+M6SQZon6ZnNRosE7gHwVujoYcIpuDQWmS1iS3c2A6m39pVvW9eFOWBnG/
 Tt+UL4vovQJeVyRsZniaDOu0Hb77VrRjA+GvdoDUvJzdzik8/w2U2T+iyVzltJINp09f+jjXRjx
 UH0J4/5nXmIxySe6kcGDPLZY4QFaWnpgKrKSuTDRguR+cx8zh80dDBWr+GUTk//ok0+lGDhR9k3
 DxS0/2lktohxeXHE9JkYpxgz1ttSVTwH34fetLCiPBjAXMtv9gs4d3SWOcyVGumFr3mUoVn3RYy
 wjcLD353byruAA1MfDmnM8+4kBgBd+R0IpaD06aWUrH+a8lKswwJNgdotFMwT8NW7TDo5WrjdOY
 KScy+uJEHxtqHISaipF9YfiKCmvAdLliVrnV6ufnOZX6ep0MkcUsNd5eX/vz1eGp24DmCMo5BR5
 +b0jZZiop9DfJO8IyXiVF8u92leRAXaeKEvB7JDKldo8G8KzIuyA2s8HTeIfp1
X-Received: by 2002:a05:6000:430e:b0:435:dd81:4f4c with SMTP id
 ffacd0b85a97d-435f3a63167mr302299f8f.9.1769704861142; 
 Thu, 29 Jan 2026 08:41:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132368csm14359910f8f.31.2026.01.29.08.41.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 08:41:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH v5 3/9] monitor: Add hmp_cmds_for_target() helper
Date: Thu, 29 Jan 2026 17:40:32 +0100
Message-ID: <20260129164039.58472-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129164039.58472-1-philmd@linaro.org>
References: <20260129164039.58472-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


