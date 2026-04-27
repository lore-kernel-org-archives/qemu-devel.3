Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E919FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH0v-0000d6-2b; Mon, 27 Apr 2026 04:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0s-0000cD-R8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:18 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0m-0001Tw-I7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so10075425f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277289; x=1777882089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TmErLYkkyC0UQ3cHtYrsC9C+y1iumERnceYY02O3hcE=;
 b=xPbbklx0SYfMg1/FSHscTSWVkaylF6ZZkBzOpcdVeVR19UHHUMTGX2gBXPTapk4M39
 24RiufFM7ZzajxWxALAf+nTSQCVn+4xBvZZyIu0jdiU95bgIq8h4AQj55JVdTs50e1ZE
 wiHiABicMijUBxPzqzPPepc8af/soovipmRyJH539loFJSS/fg7z48I6Y56tlqfP/NnA
 19XwPHTUCOU3HV/1c7GBZ/qUOVGjGvpdDIvOyf6Cy2A5fq0KH5ALZu9CHD5tyol355PV
 Jt0G3hyXHD1JaiwK8WeVK6ykT2XJOdjj+HwJ+/ohaUOjNe6oDDRD38p6Bji5UIpFLtpv
 88zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277289; x=1777882089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TmErLYkkyC0UQ3cHtYrsC9C+y1iumERnceYY02O3hcE=;
 b=HDgx9L9YV7WMo6s+RJ/1YIdCqiKk5laIGq6rd6b0EFUjePogguCCQv7I6sOZJbgzQW
 bYsSs9cC6YfcspzCwMmkI0Fx5aqNXbtXZ5uMCxWZXIVGnn1nhjFwXDJ4dQq8zjeuBV8I
 88zdQlEAVgNY42KMT2UU8U9OcNYpqWw3io50b19Lsh5TjrXmOwehKQA5oUQxzfpcp3ro
 dOlZ18+mKK0+xs7MzSJbxbi06QLumxViBgfj+u9gOKkZpM037oesf4Z7w7Yh1K3Z2CFa
 wRo+434SaJRb8jqMbPiYF9i9ZGHI3MICxjLC5HFMW05LZb7ktiRYk2VHXR3ocUw9vaiB
 ITQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ86JhtWS++1go10AsHYa7uvK1YQGyP3L+tZTfBOiJbn0JGfGo0IRiKd3d0+zu8Lgu1P5YjY0owWfpu1@nongnu.org
X-Gm-Message-State: AOJu0YwzHf+KYoJDOBbYwrP4rxLVQIWlFywVsV2KCuDD1CKT+q9KLgHJ
 WX6NnpGPRiathWmTafXurpsiQAlxInNTJzMBKDr7/qLyhzAgPAeCcP80BMhVqM7zl5wxi0uDbOW
 6ipv2rvA=
X-Gm-Gg: AeBDiesezDmd0RKb19NjVSjtFYMJ1JvTqelYNWrM+kOIXYqsYfAGnBgBPxOUXPh+xqp
 BGs5N7t+aqUGiXDqgCpaVAsYBltIF3STfX1VS7v8e23N7fNfSt6uk4SH/0f4+a8wfEB3u5W31KJ
 t2DDYm0AsgtJxXjnaoYjrV8ekZxT/Lk6gZa28TpSbwtoCIFN6d8DefXVB78uKYJzeiTJHmIp9dQ
 bDSqWE1E9GQVPxZJ/MJzFJF+O77/J6KP3fcKIo4o42W4xPZtfGufnPQ16Db0M0x/KlvdlYviwf4
 cYnTQyG4gwoG2f6sv0wvqX2wUklekf3Mbw05TCT+3W3M8PfKBPj6R+TAGXjpHC0BdreelOskWXJ
 2ZDxouTU6HNXt/+u5oysu2jKo7WZa5emxxGKG1WIMxpB5q4YHVMZPEqDElbHjmm9v43zssToa6G
 zqtAN9lQqnlFQlTQrKjhfKLDtxhmHyEjw11AxKHE5OA65aT2g1jRsfLXDROunBHn9QW0irHqApb
 DTbKnCH5l7dM3iQWpB7Yg==
X-Received: by 2002:a05:6000:200c:b0:43d:77f4:7145 with SMTP id
 ffacd0b85a97d-43fe3dd407dmr66647608f8f.19.1777277289285; 
 Mon, 27 Apr 2026 01:08:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm73442112f8f.22.2026.04.27.01.08.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:08:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 04/32] monitor: Extract completion declarations to
 'monitor/hmp-completion.h'
Date: Mon, 27 Apr 2026 10:07:10 +0200
Message-ID: <20260427080738.77138-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Many files include "monitor/hmp.h", but few of them really need
the completion declarations: move them to a distinct header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                      |  2 ++
 include/monitor/hmp-completion.h | 40 ++++++++++++++++++++++++++++++++
 include/monitor/hmp.h            | 21 -----------------
 chardev/char-hmp-cmds.c          |  1 +
 migration/migration-hmp-cmds.c   |  1 +
 monitor/hmp-target.c             |  1 +
 net/net-hmp-cmds.c               |  1 +
 qom/qom-hmp-cmds.c               |  1 +
 system/qdev-monitor.c            |  1 +
 system/runstate-hmp-cmds.c       |  1 +
 trace/trace-hmp-cmds.c           |  1 +
 ui/ui-hmp-cmds.c                 |  1 +
 12 files changed, 51 insertions(+), 21 deletions(-)
 create mode 100644 include/monitor/hmp-completion.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 35529266a26..fda43a7605b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3383,6 +3383,8 @@ F: monitor/monitor.c
 F: monitor/hmp*
 F: hmp.h
 F: hmp-commands*.hx
+F: include/monitor/hmp.h
+F: include/monitor/hmp-completion.h
 F: include/monitor/hmp-target.h
 F: tests/qtest/test-hmp.c
 F: include/qemu/qemu-print.h
diff --git a/include/monitor/hmp-completion.h b/include/monitor/hmp-completion.h
new file mode 100644
index 00000000000..dab21867dc9
--- /dev/null
+++ b/include/monitor/hmp-completion.h
@@ -0,0 +1,40 @@
+/*
+ * Human Monitor Completion handlers
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HMP_COMPLETION_H
+#define HMP_COMPLETION_H
+
+#include "qemu/readline.h"
+
+void object_add_completion(ReadLineState *rs, int nb_args, const char *str);
+void object_del_completion(ReadLineState *rs, int nb_args, const char *str);
+void device_add_completion(ReadLineState *rs, int nb_args, const char *str);
+void device_del_completion(ReadLineState *rs, int nb_args, const char *str);
+void sendkey_completion(ReadLineState *rs, int nb_args, const char *str);
+void chardev_remove_completion(ReadLineState *rs, int nb_args, const char *str);
+void chardev_add_completion(ReadLineState *rs, int nb_args, const char *str);
+void set_link_completion(ReadLineState *rs, int nb_args, const char *str);
+void netdev_add_completion(ReadLineState *rs, int nb_args, const char *str);
+void netdev_del_completion(ReadLineState *rs, int nb_args, const char *str);
+void ringbuf_write_completion(ReadLineState *rs, int nb_args, const char *str);
+void info_trace_events_completion(ReadLineState *rs, int nb_args,
+                                  const char *str);
+void trace_event_completion(ReadLineState *rs, int nb_args, const char *str);
+void watchdog_action_completion(ReadLineState *rs, int nb_args,
+                                const char *str);
+void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
+                                       const char *str);
+void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
+                                      const char *str);
+void delvm_completion(ReadLineState *rs, int nb_args, const char *str);
+void loadvm_completion(ReadLineState *rs, int nb_args, const char *str);
+
+#endif
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index e222bea60cd..9c2330205fc 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -114,27 +114,6 @@ void hmp_vhost_queue_status(Monitor *mon, const QDict *qdict);
 void hmp_virtio_queue_element(Monitor *mon, const QDict *qdict);
 void hmp_xen_event_inject(Monitor *mon, const QDict *qdict);
 void hmp_xen_event_list(Monitor *mon, const QDict *qdict);
-void object_add_completion(ReadLineState *rs, int nb_args, const char *str);
-void object_del_completion(ReadLineState *rs, int nb_args, const char *str);
-void device_add_completion(ReadLineState *rs, int nb_args, const char *str);
-void device_del_completion(ReadLineState *rs, int nb_args, const char *str);
-void sendkey_completion(ReadLineState *rs, int nb_args, const char *str);
-void chardev_remove_completion(ReadLineState *rs, int nb_args, const char *str);
-void chardev_add_completion(ReadLineState *rs, int nb_args, const char *str);
-void set_link_completion(ReadLineState *rs, int nb_args, const char *str);
-void netdev_add_completion(ReadLineState *rs, int nb_args, const char *str);
-void netdev_del_completion(ReadLineState *rs, int nb_args, const char *str);
-void ringbuf_write_completion(ReadLineState *rs, int nb_args, const char *str);
-void info_trace_events_completion(ReadLineState *rs, int nb_args, const char *str);
-void trace_event_completion(ReadLineState *rs, int nb_args, const char *str);
-void watchdog_action_completion(ReadLineState *rs, int nb_args,
-                                const char *str);
-void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
-                                       const char *str);
-void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
-                                      const char *str);
-void delvm_completion(ReadLineState *rs, int nb_args, const char *str);
-void loadvm_completion(ReadLineState *rs, int nb_args, const char *str);
 void hmp_rocker(Monitor *mon, const QDict *qdict);
 void hmp_rocker_ports(Monitor *mon, const QDict *qdict);
 void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict);
diff --git a/chardev/char-hmp-cmds.c b/chardev/char-hmp-cmds.c
index 8e9e1c1c021..f377e00b699 100644
--- a/chardev/char-hmp-cmds.c
+++ b/chardev/char-hmp-cmds.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "chardev/char.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0a193b8f54a..d5712d11b8c 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -17,6 +17,7 @@
 #include "block/qapi.h"
 #include "migration/snapshot.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 3f019ae2a28..da7dd7f31f2 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -29,6 +29,7 @@
 #include "system/device_tree.h"
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "block/block-hmp-cmds.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index e7c55d27876..2b24c9e6049 100644
--- a/net/net-hmp-cmds.c
+++ b/net/net-hmp-cmds.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "migration/misc.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "net/net.h"
 #include "net/hub.h"
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 32e40630c96..47110ca58c0 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/qdev.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qom.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 1ac6d9a8575..2ed95e83602 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/sysbus.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
 #include "system/arch_init.h"
diff --git a/system/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
index be1d6769926..02d1d42bf39 100644
--- a/system/runstate-hmp-cmds.c
+++ b/system/runstate-hmp-cmds.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "exec/cpu-common.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-run-state.h"
diff --git a/trace/trace-hmp-cmds.c b/trace/trace-hmp-cmds.c
index 45f4335ff5d..390173095cf 100644
--- a/trace/trace-hmp-cmds.c
+++ b/trace/trace-hmp-cmds.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-trace.h"
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 6c93d452c9c..1e9bc77bd80 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -18,6 +18,7 @@
 #include <spice/enums.h>
 #endif
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
-- 
2.53.0


