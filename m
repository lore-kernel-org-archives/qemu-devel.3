Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F230DCCF2DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 11:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhn3U-0006xw-SU; Mon, 19 Jan 2026 06:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3T-0006rG-NC
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3S-0006YD-32
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:19 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso26958795e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 03:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768820656; x=1769425456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/5ri0x0HKOQ4AevWnY2CiNFX91P9a3QRDv363s7aV8=;
 b=XfNHp/TrPO1lkJtC/QCvoRAOP8HvOwXhAeUDnP2Ke9d2kzKHL0+IW/cGJ3H6ecfZhk
 azMeHSstJSRpy14opES4lLwIDXhu7jo5kAukj5qbssE7/bo2tPxwlYc5A7v+RVtJCSNE
 dAHklFGs6KpZY6ve1pefOh7VXddpTE1H8q8+mXBI9RbKGRhWyineba+Y19y3zz7KgsVP
 5VBa5C9WuB5Ut+gxTBo0m3VqJAo1X7pu//dzADL3pnQoP3rvZ4O8jYc9BhqWu03L/o0T
 8440RqAJata7Ob7BIK6RLeps8UAfJUbSj7V6QUjLUiT3/lSZWG/XJdr4iR6J3pRMdthr
 FhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768820656; x=1769425456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2/5ri0x0HKOQ4AevWnY2CiNFX91P9a3QRDv363s7aV8=;
 b=u8siMuZ16ajasJXCZjPuJz0HAwoL7cg2aVABO0TvDWwFtp/wT90o6mAyRw/4KwP114
 hkJgPqZtyDyEjViiraubgOd2wE+BUCrSxycBkZzS6c3q41IAAJpo3erBfL9zh1QzCPBa
 uVN/tkrYp2WbLvOQupYvsPbO70wajUPo/FL5p+Fg4sR7ysHbXgP1lYJJ28/A2xV1oeyn
 pMf2IjNv74UIWKtLGP58zTyxSekE68YNhnmsPy4EW9m7+bV4G3yQ2bK3um0vr89muX8n
 7sSSh0q91RSBWu8wwplGwMUm+ATdrvH1AeOLrpagEk7oRb8Vx4jnbhvQzroxiL25ElGm
 g5eQ==
X-Gm-Message-State: AOJu0YygCt/yOzUm62ZUdxfo+Nrw+OivUsfXFpNRZdENyj3m8n4yAv/m
 FKKvDbTz3RYrBnKb18naNnteJRUy4GPki3RdYqSp1d6iIlltDtJqiY2fsXapqoaelB+NXHdVfA6
 kq/0lB3I=
X-Gm-Gg: AY/fxX7SjIoUHozQo769+Y64QgSjJK1xhy7uhK3OT/g0c1xHs+fur4J+aT40DcSct3v
 Jh5exjZa3elgyg7vSTqKttOzQDp7uVuFA4uSIwO9Dod3GXj3qNwh8H8O4FDQ+n5uqZngwowXjGp
 pBSJDHaIJNRqgcR87ls29nDnotMND2sXkdzU72ZY3TB5fLZqeldDASkOwIf3YLT2QgW5pdK9f79
 tGv4i84dEWdLHtxXEMq0Ae+hxzdCZboQ/Vg+OqUAmcqQaZ0v5lTNXc9yRc/URNahdxiBGKZzs4c
 0pDK3S0bJ3sqve3l5Rm1OqluUmvxzesujG3TR00oXSCpT7LVnl7mmz4fqtrPuk9Swy7Gsb71cML
 /WTscmkc0vCRV+GdGXW+C566ebBmnSDS4Pf08jmbwZg1Y4rcx48CMXp0v2ILx+Ad6MsWFPK2o1d
 HB5cFZp64v1Q/LP5W6LF2jxbgzS6IYxWN3ENxnNfMm5uTDbxouScO1VhEuSNEkVrD3MH8m/Xw=
X-Received: by 2002:a05:600c:8184:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-4801e530d08mr129131105e9.1.1768820655782; 
 Mon, 19 Jan 2026 03:04:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe74987sm82032795e9.8.2026.01.19.03.04.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jan 2026 03:04:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 2/8] monitor: Add hmp_cmds_for_target() helper
Date: Mon, 19 Jan 2026 12:03:52 +0100
Message-ID: <20260119110358.66821-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119110358.66821-1-philmd@linaro.org>
References: <20260119110358.66821-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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


