Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CDECD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsT4Z-0006Z0-4J; Thu, 04 Apr 2024 15:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4W-0006Yd-WA
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4U-0000LB-EI
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4162c210c33so4760425e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712260104; x=1712864904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoLqAKUnWG07Qqq94XYH6NjRAB/Z33lL8UXEZ52j+Q0=;
 b=d9j6nG9keKA1GjJfv589GEHtJ57ylR00ITtGUnEOTahERCmGaOBK20MEru84olqkd9
 mBSX2GFBFV7hMyQ5+eCyC8UVqMoHXyRLRWGNPz2daTPbZYETY+chwFwvipGhw04r586l
 q5z772nDlOrWCV3NPGB0Cf6VaiaETUKbLcn4/Bp8NtEBhkUM9Txi13xSKX7L+1Mfy5d5
 aV4QnBuqjjO0ZN3c9+gliIta+iOSQJBWJ4t1nuVHsMTEUvq2Zcdt5DX8bAXH6XgJNnPf
 4kcggEDjrdjSnZA660Rp2cTPUvkzhO0yRI34SoeuGVVm9Ou6KMD4zZr70U6NwACUhJMO
 w8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712260104; x=1712864904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aoLqAKUnWG07Qqq94XYH6NjRAB/Z33lL8UXEZ52j+Q0=;
 b=h36TruTWKsyc/uN+qY1sKzCjte5WgPslb1BgX2jClx6cM/DCbfS1DiRfTBvet/12IP
 Z31Dl4xNZIXBTsQ6c7xIXSgNJSTIEL/bj9BVriig0T1nbUiec6h2DlRsoLUC3RLshjYs
 ce0sSRwkuxuzi1aihI1mfaWTE23T0fn0nUoCEa2wFdCVfd127tz5V0iNxVo2LWPUXXzd
 lZ6O2LXaEv/sPffXS1imDsWjgGifZTPj4LOIFh7zpZw48Wv5izsyzZcOEW7+Stch8gea
 z4XQo0HIjdjLgVqKKlnLAFUij71SnLQrM1IZA9KI0mUKpDWV3Ut/U6gm6VjHF5jc9pdt
 qMlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJXlf0XMjI/jnAoES4BcHOoxBCJeAw1kdLrjJliJn2MWX8r0AnQboO6EVpdByC7VeNol3eyghzKMeUR0cd0Fn76lk+Clk=
X-Gm-Message-State: AOJu0Yz31HRvp8VMSrA5PuA71TGck5YL4BPe6pBVHtFWMFzkjl1OG1Us
 mDBTy7MvI1nxisgetPU71KaMQ0gZHTv1qvPMpoqir533OvMLNK9wGL0uvhTXpdw=
X-Google-Smtp-Source: AGHT+IGFWyg03HMLbT0CsVHbhdgxGmJjKJEkdTqU4XgrYpOV6/5HmyG7fsDxCX75q/UyVHyGBZOuJA==
X-Received: by 2002:a05:600c:4a05:b0:416:2b19:beef with SMTP id
 c5-20020a05600c4a0500b004162b19beefmr1771569wmp.11.1712260103837; 
 Thu, 04 Apr 2024 12:48:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 fc9-20020a05600c524900b004162d0676cdsm228087wmb.29.2024.04.04.12.48.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:48:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-9.1 4/7] util/qemu-config: Extract QMP commands to
 qemu-config-qmp.c
Date: Thu,  4 Apr 2024 21:47:54 +0200
Message-ID: <20240404194757.9343-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240404194757.9343-1-philmd@linaro.org>
References: <20240404194757.9343-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

QMP is irrelevant for user emulation. Extract the code
related to QMP in a different source file, which won't
be build for user emulation binaries. This avoid pulling
pointless code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/config-file.h |   3 +
 util/qemu-config-qmp.c     | 206 +++++++++++++++++++++++++++++++++++++
 util/qemu-config.c         | 204 +-----------------------------------
 util/meson.build           |   1 +
 4 files changed, 212 insertions(+), 202 deletions(-)
 create mode 100644 util/qemu-config-qmp.c

diff --git a/include/qemu/config-file.h b/include/qemu/config-file.h
index b82a778123..8b9d6df173 100644
--- a/include/qemu/config-file.h
+++ b/include/qemu/config-file.h
@@ -8,6 +8,9 @@ QemuOptsList *qemu_find_opts(const char *group);
 QemuOptsList *qemu_find_opts_err(const char *group, Error **errp);
 QemuOpts *qemu_find_opts_singleton(const char *group);
 
+extern QemuOptsList *vm_config_groups[48];
+extern QemuOptsList *drive_config_groups[5];
+
 void qemu_add_opts(QemuOptsList *list);
 void qemu_add_drive_opts(QemuOptsList *list);
 int qemu_global_option(const char *str);
diff --git a/util/qemu-config-qmp.c b/util/qemu-config-qmp.c
new file mode 100644
index 0000000000..24477a0e44
--- /dev/null
+++ b/util/qemu-config-qmp.c
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
+#include "qapi/qmp/qlist.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "hw/boards.h"
+
+static CommandLineParameterInfoList *query_option_descs(const QemuOptDesc *desc)
+{
+    CommandLineParameterInfoList *param_list = NULL;
+    CommandLineParameterInfo *info;
+    int i;
+
+    for (i = 0; desc[i].name != NULL; i++) {
+        info = g_malloc0(sizeof(*info));
+        info->name = g_strdup(desc[i].name);
+
+        switch (desc[i].type) {
+        case QEMU_OPT_STRING:
+            info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
+            break;
+        case QEMU_OPT_BOOL:
+            info->type = COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
+            break;
+        case QEMU_OPT_NUMBER:
+            info->type = COMMAND_LINE_PARAMETER_TYPE_NUMBER;
+            break;
+        case QEMU_OPT_SIZE:
+            info->type = COMMAND_LINE_PARAMETER_TYPE_SIZE;
+            break;
+        }
+
+        info->help = g_strdup(desc[i].help);
+        info->q_default = g_strdup(desc[i].def_value_str);
+
+        QAPI_LIST_PREPEND(param_list, info);
+    }
+
+    return param_list;
+}
+
+/* remove repeated entry from the info list */
+static void cleanup_infolist(CommandLineParameterInfoList *head)
+{
+    CommandLineParameterInfoList *pre_entry, *cur, *del_entry;
+
+    cur = head;
+    while (cur->next) {
+        pre_entry = head;
+        while (pre_entry != cur->next) {
+            if (!strcmp(pre_entry->value->name, cur->next->value->name)) {
+                del_entry = cur->next;
+                cur->next = cur->next->next;
+                del_entry->next = NULL;
+                qapi_free_CommandLineParameterInfoList(del_entry);
+                break;
+            }
+            pre_entry = pre_entry->next;
+        }
+        cur = cur->next;
+    }
+}
+
+/* merge the description items of two parameter infolists */
+static void connect_infolist(CommandLineParameterInfoList *head,
+                             CommandLineParameterInfoList *new)
+{
+    CommandLineParameterInfoList *cur;
+
+    cur = head;
+    while (cur->next) {
+        cur = cur->next;
+    }
+    cur->next = new;
+}
+
+/* access all the local QemuOptsLists for drive option */
+static CommandLineParameterInfoList *get_drive_infolist(void)
+{
+    CommandLineParameterInfoList *head = NULL, *cur;
+    int i;
+
+    for (i = 0; drive_config_groups[i] != NULL; i++) {
+        if (!head) {
+            head = query_option_descs(drive_config_groups[i]->desc);
+        } else {
+            cur = query_option_descs(drive_config_groups[i]->desc);
+            connect_infolist(head, cur);
+        }
+    }
+    cleanup_infolist(head);
+
+    return head;
+}
+
+static CommandLineParameterInfo *objprop_to_cmdline_prop(ObjectProperty *prop)
+{
+    CommandLineParameterInfo *info;
+
+    info = g_malloc0(sizeof(*info));
+    info->name = g_strdup(prop->name);
+
+    if (g_str_equal(prop->type, "bool") || g_str_equal(prop->type, "OnOffAuto")) {
+        info->type = COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
+    } else if (g_str_equal(prop->type, "int")) {
+        info->type = COMMAND_LINE_PARAMETER_TYPE_NUMBER;
+    } else if (g_str_equal(prop->type, "size")) {
+        info->type = COMMAND_LINE_PARAMETER_TYPE_SIZE;
+    } else {
+        info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
+    }
+
+    if (prop->description) {
+        info->help = g_strdup(prop->description);
+    }
+
+    return info;
+}
+
+static CommandLineParameterInfoList *query_all_machine_properties(void)
+{
+    CommandLineParameterInfoList *params = NULL, *clpiter;
+    CommandLineParameterInfo *info;
+    GSList *machines, *curr_mach;
+    ObjectPropertyIterator op_iter;
+    ObjectProperty *prop;
+    bool is_new;
+
+    machines = object_class_get_list(TYPE_MACHINE, false);
+    assert(machines);
+
+    /* Loop over all machine classes */
+    for (curr_mach = machines; curr_mach; curr_mach = curr_mach->next) {
+        object_class_property_iter_init(&op_iter, curr_mach->data);
+        /* ... and over the properties of each machine: */
+        while ((prop = object_property_iter_next(&op_iter))) {
+            if (!prop->set) {
+                continue;
+            }
+            /*
+             * Check whether the property has already been put into the list
+             * (via another machine class)
+             */
+            is_new = true;
+            for (clpiter = params; clpiter != NULL; clpiter = clpiter->next) {
+                if (g_str_equal(clpiter->value->name, prop->name)) {
+                    is_new = false;
+                    break;
+                }
+            }
+            /* If it hasn't been added before, add it now to the list */
+            if (is_new) {
+                info = objprop_to_cmdline_prop(prop);
+                QAPI_LIST_PREPEND(params, info);
+            }
+        }
+    }
+
+    g_slist_free(machines);
+
+    /* Add entry for the "type" parameter */
+    info = g_malloc0(sizeof(*info));
+    info->name = g_strdup("type");
+    info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
+    info->help = g_strdup("machine type");
+    QAPI_LIST_PREPEND(params, info);
+
+    return params;
+}
+
+CommandLineOptionInfoList *qmp_query_command_line_options(const char *option,
+                                                          Error **errp)
+{
+    CommandLineOptionInfoList *conf_list = NULL;
+    CommandLineOptionInfo *info;
+    int i;
+
+    for (i = 0; vm_config_groups[i] != NULL; i++) {
+        if (!option || !strcmp(option, vm_config_groups[i]->name)) {
+            info = g_malloc0(sizeof(*info));
+            info->option = g_strdup(vm_config_groups[i]->name);
+            if (!strcmp("drive", vm_config_groups[i]->name)) {
+                info->parameters = get_drive_infolist();
+            } else {
+                info->parameters =
+                    query_option_descs(vm_config_groups[i]->desc);
+            }
+            QAPI_LIST_PREPEND(conf_list, info);
+        }
+    }
+
+    if (!option || !strcmp(option, "machine")) {
+        info = g_malloc0(sizeof(*info));
+        info->option = g_strdup("machine");
+        info->parameters = query_all_machine_properties();
+        QAPI_LIST_PREPEND(conf_list, info);
+    }
+
+    if (conf_list == NULL) {
+        error_setg(errp, "invalid option name: %s", option);
+    }
+
+    return conf_list;
+}
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 42076efe1e..a90c18dad2 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -1,16 +1,14 @@
 #include "qemu/osdep.h"
 #include "block/qdict.h" /* for qdict_extract_subqdict() */
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "hw/boards.h"
 
-static QemuOptsList *vm_config_groups[48];
-static QemuOptsList *drive_config_groups[5];
+QemuOptsList *vm_config_groups[48];
+QemuOptsList *drive_config_groups[5];
 
 static QemuOptsList *find_list(QemuOptsList **lists, const char *group,
                                Error **errp)
@@ -55,204 +53,6 @@ QemuOpts *qemu_find_opts_singleton(const char *group)
     return opts;
 }
 
-static CommandLineParameterInfoList *query_option_descs(const QemuOptDesc *desc)
-{
-    CommandLineParameterInfoList *param_list = NULL;
-    CommandLineParameterInfo *info;
-    int i;
-
-    for (i = 0; desc[i].name != NULL; i++) {
-        info = g_malloc0(sizeof(*info));
-        info->name = g_strdup(desc[i].name);
-
-        switch (desc[i].type) {
-        case QEMU_OPT_STRING:
-            info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
-            break;
-        case QEMU_OPT_BOOL:
-            info->type = COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
-            break;
-        case QEMU_OPT_NUMBER:
-            info->type = COMMAND_LINE_PARAMETER_TYPE_NUMBER;
-            break;
-        case QEMU_OPT_SIZE:
-            info->type = COMMAND_LINE_PARAMETER_TYPE_SIZE;
-            break;
-        }
-
-        info->help = g_strdup(desc[i].help);
-        info->q_default = g_strdup(desc[i].def_value_str);
-
-        QAPI_LIST_PREPEND(param_list, info);
-    }
-
-    return param_list;
-}
-
-/* remove repeated entry from the info list */
-static void cleanup_infolist(CommandLineParameterInfoList *head)
-{
-    CommandLineParameterInfoList *pre_entry, *cur, *del_entry;
-
-    cur = head;
-    while (cur->next) {
-        pre_entry = head;
-        while (pre_entry != cur->next) {
-            if (!strcmp(pre_entry->value->name, cur->next->value->name)) {
-                del_entry = cur->next;
-                cur->next = cur->next->next;
-                del_entry->next = NULL;
-                qapi_free_CommandLineParameterInfoList(del_entry);
-                break;
-            }
-            pre_entry = pre_entry->next;
-        }
-        cur = cur->next;
-    }
-}
-
-/* merge the description items of two parameter infolists */
-static void connect_infolist(CommandLineParameterInfoList *head,
-                             CommandLineParameterInfoList *new)
-{
-    CommandLineParameterInfoList *cur;
-
-    cur = head;
-    while (cur->next) {
-        cur = cur->next;
-    }
-    cur->next = new;
-}
-
-/* access all the local QemuOptsLists for drive option */
-static CommandLineParameterInfoList *get_drive_infolist(void)
-{
-    CommandLineParameterInfoList *head = NULL, *cur;
-    int i;
-
-    for (i = 0; drive_config_groups[i] != NULL; i++) {
-        if (!head) {
-            head = query_option_descs(drive_config_groups[i]->desc);
-        } else {
-            cur = query_option_descs(drive_config_groups[i]->desc);
-            connect_infolist(head, cur);
-        }
-    }
-    cleanup_infolist(head);
-
-    return head;
-}
-
-static CommandLineParameterInfo *objprop_to_cmdline_prop(ObjectProperty *prop)
-{
-    CommandLineParameterInfo *info;
-
-    info = g_malloc0(sizeof(*info));
-    info->name = g_strdup(prop->name);
-
-    if (g_str_equal(prop->type, "bool") || g_str_equal(prop->type, "OnOffAuto")) {
-        info->type = COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
-    } else if (g_str_equal(prop->type, "int")) {
-        info->type = COMMAND_LINE_PARAMETER_TYPE_NUMBER;
-    } else if (g_str_equal(prop->type, "size")) {
-        info->type = COMMAND_LINE_PARAMETER_TYPE_SIZE;
-    } else {
-        info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
-    }
-
-    if (prop->description) {
-        info->help = g_strdup(prop->description);
-    }
-
-    return info;
-}
-
-static CommandLineParameterInfoList *query_all_machine_properties(void)
-{
-    CommandLineParameterInfoList *params = NULL, *clpiter;
-    CommandLineParameterInfo *info;
-    GSList *machines, *curr_mach;
-    ObjectPropertyIterator op_iter;
-    ObjectProperty *prop;
-    bool is_new;
-
-    machines = object_class_get_list(TYPE_MACHINE, false);
-    assert(machines);
-
-    /* Loop over all machine classes */
-    for (curr_mach = machines; curr_mach; curr_mach = curr_mach->next) {
-        object_class_property_iter_init(&op_iter, curr_mach->data);
-        /* ... and over the properties of each machine: */
-        while ((prop = object_property_iter_next(&op_iter))) {
-            if (!prop->set) {
-                continue;
-            }
-            /*
-             * Check whether the property has already been put into the list
-             * (via another machine class)
-             */
-            is_new = true;
-            for (clpiter = params; clpiter != NULL; clpiter = clpiter->next) {
-                if (g_str_equal(clpiter->value->name, prop->name)) {
-                    is_new = false;
-                    break;
-                }
-            }
-            /* If it hasn't been added before, add it now to the list */
-            if (is_new) {
-                info = objprop_to_cmdline_prop(prop);
-                QAPI_LIST_PREPEND(params, info);
-            }
-        }
-    }
-
-    g_slist_free(machines);
-
-    /* Add entry for the "type" parameter */
-    info = g_malloc0(sizeof(*info));
-    info->name = g_strdup("type");
-    info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
-    info->help = g_strdup("machine type");
-    QAPI_LIST_PREPEND(params, info);
-
-    return params;
-}
-
-CommandLineOptionInfoList *qmp_query_command_line_options(const char *option,
-                                                          Error **errp)
-{
-    CommandLineOptionInfoList *conf_list = NULL;
-    CommandLineOptionInfo *info;
-    int i;
-
-    for (i = 0; vm_config_groups[i] != NULL; i++) {
-        if (!option || !strcmp(option, vm_config_groups[i]->name)) {
-            info = g_malloc0(sizeof(*info));
-            info->option = g_strdup(vm_config_groups[i]->name);
-            if (!strcmp("drive", vm_config_groups[i]->name)) {
-                info->parameters = get_drive_infolist();
-            } else {
-                info->parameters =
-                    query_option_descs(vm_config_groups[i]->desc);
-            }
-            QAPI_LIST_PREPEND(conf_list, info);
-        }
-    }
-
-    if (!option || !strcmp(option, "machine")) {
-        info = g_malloc0(sizeof(*info));
-        info->option = g_strdup("machine");
-        info->parameters = query_all_machine_properties();
-        QAPI_LIST_PREPEND(conf_list, info);
-    }
-
-    if (conf_list == NULL) {
-        error_setg(errp, "invalid option name: %s", option);
-    }
-
-    return conf_list;
-}
-
 QemuOptsList *qemu_find_opts_err(const char *group, Error **errp)
 {
     return find_list(vm_config_groups, group, errp);
diff --git a/util/meson.build b/util/meson.build
index 247f55a80d..636b17a414 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -75,6 +75,7 @@ if have_system
   if host_os == 'linux'
     util_ss.add(files('userfaultfd.c'))
   endif
+  util_ss.add(files('qemu-config-qmp.c'))
   util_ss.add(files('yank.c'))
 endif
 
-- 
2.41.0


