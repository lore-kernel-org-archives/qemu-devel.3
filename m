Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD75CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKclg-0008EB-Uc; Wed, 06 May 2026 09:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclc-00087f-J0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclZ-0008PX-Ub
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso35852155e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075899; x=1778680699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oAJWvOlyHXXa761YRrbvQ94Cv0yNBj3ubObQ8ebHkXo=;
 b=BUahVIbjANbh3ZnWjsJlgwMOiKd7jBd1N9nZttvB7mPHYv8Vm0BzjHM8gvtvAuE/GI
 H9nHiZo9IHLCaqwmX587Nv8WjfbnoNBCMdYqRerHpsjYqmhPg9BOgXOBiTueKJYJUpBV
 CoG7tXScMXAFckdkjFaIi98+BjQZlUAOJ0eyAmhmo+cuY9uSm3/Q3ZkQFRgob3izTo+M
 2qCo0HRJp9suhQp0mvolbzpUxVcrcBuQDf92xhjiFp4gs5yUu6Y1VO7rStf8V/xk6lUb
 9xOv6kksgj1H3OaCzOdaj4hm/CSEe2K7Kvb68jCO+3twb1BdKPS3IKPrKVvDRyrWWDVB
 uvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075899; x=1778680699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oAJWvOlyHXXa761YRrbvQ94Cv0yNBj3ubObQ8ebHkXo=;
 b=c1OLZFJQWsIZf89i4peKkLPhkuQhZMS164B7nzL4Z6Ynrmi5oxY0ohHlXkOlpA/DBO
 EG/saxuhnBkYRcKjjSIVlvqFdo1tczdtucQO8CQJsrdEDX92XRjfzwGDrDvN+iFkunLF
 Oivizcvj/Rc8gwUODKOPD/YqIcti4uvrWaE2ppg8R4nSdgcamYg2ksGluVKfJCllHzdb
 q9REUX+qPc/jYKizQGfFuWEuAmJW+/rl6IGZFr91Za6Qc7zQqi/NkQaYv0hc3ntzsqys
 zR04J4AbsldAO9v8oSmx6Jj5i9pcQqU68kx5iSUyR/oATYPnSd5eDa9Cqm5WZppQQnLK
 q49w==
X-Gm-Message-State: AOJu0YzD+Jmc67Z4gnqdcSlJRD8fkiadkSd66p4q4ICriVp8ZS7O1K6l
 cCy+XeUUhcLoWWMhoaaow37ciokf/44ox6H8qINX6RDu7z/phN2exhsK0OJt61Rg54UbtqKuKYK
 Ues9n4xE=
X-Gm-Gg: AeBDieslCGSyIdaZgvToZ2ONEsM6dsNlZ/AyyvxgLK0SyCqoCkjBEBJ2p2s2lHd+Gqa
 uoakutZSD6l5QQ8apHO5L1OmWXrbfZUn8BcbWV1e655S+YpxcyKQiCKc4xgY9DoxCQVrxg7xbT/
 YqjERKhJdg7daOIwRmjqB5AbpZMMDT4zsRnhO4w3w9UwmiKKFCXVOVMublllHKT79wEMTSHMcmY
 coYg07D41HibB4JXruyA60opEBpfuHftfOSok+RP11J4jJUYYvZq0BPzvEkHlN7qZaJRkOTXzjF
 WQNnMUzDWzT6xrm5EKuR14++86h2j1oXXpB5EqLDM9jCB5Z5je2Sfo/ZyiqX2s4ethzuXUVfdHn
 atPQnW4dpXVSxhWTtXbfwyBi2Dd/NsK/xJtZzGPaI3/JX1PN3oBjgcKcG/H6rY8UlALIDYRpG9O
 FRai07FJJdN3jasivhv26xd62z2JpQYeO591JIav8+ZdIszD1DVkjAEmmmMLBc9ho0zz0d+2ykO
 IqRpq84D3M=
X-Received: by 2002:a05:600c:b8a:b0:48a:56de:d620 with SMTP id
 5b1f17b1804b1-48e51f32ac3mr64925905e9.14.1778075899312; 
 Wed, 06 May 2026 06:58:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530a67dcsm27288165e9.2.2026.05.06.06.58.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:58:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 023/110] monitor: Extract completion declarations to
 'monitor/hmp-completion.h'
Date: Wed,  6 May 2026 15:53:55 +0200
Message-ID: <20260506135524.20617-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Message-Id: <20260320160811.28611-2-philmd@linaro.org>
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
index afa178c5cce..ac47299fd83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3403,6 +3403,8 @@ F: monitor/monitor.c
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
index 9b66458d21f..27ce1c303f4 100644
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
index 5c00bbf483b..e90eb6247ea 100644
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


