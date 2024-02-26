Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B426CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebhT-00038a-CA; Mon, 26 Feb 2024 09:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebhS-00038Q-AO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:22 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebhQ-00023t-0c
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:21 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5645960cd56so3517893a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 06:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708956677; x=1709561477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wvzvKLs6IMYvaFbkImFBMdxhcoPyLIxhzY1NCn0H/34=;
 b=F3bu97khhaWE+UYP8MWAylO0sHz7WE6mIgWLTREP4QnLSFFTiA1wpi003QRmA7qw2s
 EzkK79zEYHXUmxjrbssvfKW44a9qv4q8xLJLj8BN9RDW2vKhHAu1oEjopPmOdBgqatfm
 ghn5hpsclAJtCKcJYkEZShFzJ67ta2NwKcccJ8mE8S4uu6jr8tXd11x4UXOQGzxuuwty
 N2+Z57zB79wUoefgQyD93qFkmrnsvSpeN16Wdv9wOAsqKcdzIGNyOTGmLVy6xV5dthe+
 LBmDA4sh1Vh30yJGSTKDEvfHD0Fm0d7tUXZtYblwjzaDFTdLE0Vmn99a+8dt1fK3uIh+
 8QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708956677; x=1709561477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvzvKLs6IMYvaFbkImFBMdxhcoPyLIxhzY1NCn0H/34=;
 b=PKacu8xwUZQdlJqfaMiGaveHvTGGgvViOfg7Zd26C3vRfVgNPhNQDUsO8+m1FpNiwM
 uQn3Pr/8a+jLmszYE7DAM40ex32tlr0kWG3dByMBFJmwU+o9dCKblJlkoRNXZPdtcVq5
 J2fnlmMZkLThOrYl3ZY7OyWxJFBC6rPEsYz6XAVwpIl+8wi8Swt6DZ24xCF2B53XoRtl
 PqI4zYrMS/1CxbXPoOR4eu9ljYNGNYNRLGtgJ47zs8M/tTVWkHVEO9ktdLnk84tdGTap
 8dHDa8C1Xfk/EEsc9r86+ezMJAAI2ma4MEp6Ax1xJ6v5rHQ0/cn7/2D5m1JdeSDSbBJQ
 1I0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvEfNvycz3OfrR0YjLSXQL7nMdqkhaabAzrZ5Rqtw79j06L+2JYi2+Qm2GCMl0ao8rwv6+fr0m5QzAork3NsQpGFjJ4/M=
X-Gm-Message-State: AOJu0YxgLx6O2AoPrG5WFUaFOHSmcHAt+bG7J2Bjg39I0b/v6YPFwPnF
 OltrUU0YYi0/srX65bCa0whB1f5fMwPl/IME+LjC6qPLKOJLJlVdWesk3id6Kfue1WhNPY7WSUt
 5
X-Google-Smtp-Source: AGHT+IEPwhW0JLcf0feBXL+XrTPlbEZf4bQ57sCWSCdV1Ptoo/yyI7iuMwlBW8LYlXRZUQ+l1qrB4A==
X-Received: by 2002:a17:906:a298:b0:a3f:29e0:c9b4 with SMTP id
 i24-20020a170906a29800b00a3f29e0c9b4mr4853501ejz.30.1708956677584; 
 Mon, 26 Feb 2024 06:11:17 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 ld17-20020a170906f95100b00a3cf9b832eesm2453393ejb.40.2024.02.26.06.11.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 06:11:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 1/5] util: str_split
Date: Mon, 26 Feb 2024 15:11:03 +0100
Message-ID: <20240226141108.73664-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226141108.73664-1-philmd@linaro.org>
References: <20240226141108.73664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Generalize hmp_split_at_comma() to take any delimiter string, rename
as str_split(), and move it to util/strList.c.

No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <1708638470-114846-2-git-send-email-steven.sistare@oracle.com>
[PMD: Cover new files in 'QAPI' section in MAINTAINERS]
Message-ID: <d126c937-c705-476f-baa5-d5e258780cc0@oracle.com>
---
 MAINTAINERS            |  2 ++
 include/monitor/hmp.h  |  1 -
 include/qemu/strList.h | 25 +++++++++++++++++++++++++
 monitor/hmp-cmds.c     | 19 -------------------
 net/net-hmp-cmds.c     |  3 ++-
 stats/stats-hmp-cmds.c |  3 ++-
 util/strList.c         | 24 ++++++++++++++++++++++++
 util/meson.build       |  1 +
 8 files changed, 56 insertions(+), 22 deletions(-)
 create mode 100644 include/qemu/strList.h
 create mode 100644 util/strList.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 992799171f..7970d34cdd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3196,6 +3196,8 @@ X: qapi/*.json
 F: include/qapi/
 X: include/qapi/qmp/
 F: include/qapi/qmp/dispatch.h
+F: include/qemu/strList.h
+F: util/strList.c
 F: tests/qapi-schema/
 F: tests/unit/test-*-visitor.c
 F: tests/unit/test-qapi-*.c
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 13f9a2dedb..2df661ee3a 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -19,7 +19,6 @@
 
 bool hmp_handle_error(Monitor *mon, Error *err);
 void hmp_help_cmd(Monitor *mon, const char *name);
-strList *hmp_split_at_comma(const char *str);
 
 void hmp_info_name(Monitor *mon, const QDict *qdict);
 void hmp_info_version(Monitor *mon, const QDict *qdict);
diff --git a/include/qemu/strList.h b/include/qemu/strList.h
new file mode 100644
index 0000000000..4e2e78624e
--- /dev/null
+++ b/include/qemu/strList.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_STR_LIST_H
+#define QEMU_STR_LIST_H
+
+#include "qapi/qapi-builtin-types.h"
+
+/*
+ * Split @str into a strList using the delimiter string @delim.
+ * The delimiter is not included in the result.
+ * Return NULL if @str is NULL or an empty string.
+ * A leading, trailing, or consecutive delimiter produces an
+ * empty string at that position in the output.
+ * All strings are g_strdup'd, and the result can be freed
+ * using qapi_free_strList, or by declaring a local variable
+ * with g_autoptr(strList).
+ */
+strList *str_split(const char *str, const char *delim);
+
+#endif
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 871898ac46..66b68a0ad3 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -38,25 +38,6 @@ bool hmp_handle_error(Monitor *mon, Error *err)
     return false;
 }
 
-/*
- * Split @str at comma.
- * A null @str defaults to "".
- */
-strList *hmp_split_at_comma(const char *str)
-{
-    char **split = g_strsplit(str ?: "", ",", -1);
-    strList *res = NULL;
-    strList **tail = &res;
-    int i;
-
-    for (i = 0; split[i]; i++) {
-        QAPI_LIST_APPEND(tail, split[i]);
-    }
-
-    g_free(split);
-    return res;
-}
-
 void hmp_info_name(Monitor *mon, const QDict *qdict)
 {
     NameInfo *info;
diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index 41d326bf5f..969cdd1e4d 100644
--- a/net/net-hmp-cmds.c
+++ b/net/net-hmp-cmds.c
@@ -26,6 +26,7 @@
 #include "qemu/config-file.h"
 #include "qemu/help_option.h"
 #include "qemu/option.h"
+#include "qemu/strList.h"
 
 void hmp_info_network(Monitor *mon, const QDict *qdict)
 {
@@ -72,7 +73,7 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict)
                                             migrate_announce_params());
 
     qapi_free_strList(params->interfaces);
-    params->interfaces = hmp_split_at_comma(interfaces_str);
+    params->interfaces = str_split(interfaces_str, ",");
     params->has_interfaces = params->interfaces != NULL;
     params->id = g_strdup(id);
     qmp_announce_self(params, NULL);
diff --git a/stats/stats-hmp-cmds.c b/stats/stats-hmp-cmds.c
index 1f91bf8bd5..62db8c613c 100644
--- a/stats/stats-hmp-cmds.c
+++ b/stats/stats-hmp-cmds.c
@@ -10,6 +10,7 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qemu/cutils.h"
+#include "qemu/strList.h"
 #include "hw/core/cpu.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/error.h"
@@ -176,7 +177,7 @@ static StatsFilter *stats_filter(StatsTarget target, const char *names,
             request->provider = provider_idx;
             if (names && !g_str_equal(names, "*")) {
                 request->has_names = true;
-                request->names = hmp_split_at_comma(names);
+                request->names = str_split(names, ",");
             }
             QAPI_LIST_PREPEND(request_list, request);
         }
diff --git a/util/strList.c b/util/strList.c
new file mode 100644
index 0000000000..7588c7c797
--- /dev/null
+++ b/util/strList.c
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2023 Red Hat, Inc.
+ * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/strList.h"
+
+strList *str_split(const char *str, const char *delim)
+{
+    g_autofree char **split = g_strsplit(str ?: "", delim, -1);
+    strList *res = NULL;
+    strList **tail = &res;
+    int i;
+
+    for (i = 0; split[i]; i++) {
+        QAPI_LIST_APPEND(tail, split[i]);
+    }
+
+    return res;
+}
diff --git a/util/meson.build b/util/meson.build
index 0ef9886be0..bd125a4094 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -1,4 +1,5 @@
 util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
+util_ss.add(files('strList.c'))
 util_ss.add(files('thread-context.c'), numa)
 if not config_host_data.get('CONFIG_ATOMIC64')
   util_ss.add(files('atomic64.c'))
-- 
2.41.0


