Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6C7C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 13:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGexz-0004ws-2J; Mon, 10 Jun 2024 09:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sGexx-0004w0-5M
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 09:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sGexv-0000XY-C8
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 09:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718025697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EiCz0YmwSf8jny6o5ialPhe2vYmWAhn9Cwq4PQll8Hk=;
 b=SsQEkdCeDAZIJa+w0dmYIay3qQm/U3IGFQpRKveeKqHqe2sBa2XSPW8MJtuFLlnidnRgU6
 JScO0tFJukqeyPmu8Vbl+JiFHPTKXkRpnZ7HAb5jVH0WgbMBLwMgoZTiVG+B8Xwgfzq82X
 W504xHQXv0EnkByX5sHND8HPbNScASk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-0MSkSzyPNq6KbgXB0_KV_g-1; Mon, 10 Jun 2024 09:21:33 -0400
X-MC-Unique: 0MSkSzyPNq6KbgXB0_KV_g-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7025a6ab99cso3881451b3a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 06:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718025691; x=1718630491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EiCz0YmwSf8jny6o5ialPhe2vYmWAhn9Cwq4PQll8Hk=;
 b=EvgD0HvnVi18p/3cwV5h+edKrtxbnwVvi9WaDF7W60tPrgy5P3/J8gGQM1TD9JSmsH
 lHcu3vs23dHjK5BnJctxxm0gSFMv/zrDIlQNxdo0SJujGGU5lMH4u8OIY+AKwmcKmPp2
 qnjEHKfomIGR2BBwFrfSE/3No/d0AIKzoytI2frMnxm8yz0vVvivkeQp8SzNqu2OjA3+
 GtClJn6DQ0QDGum3n4L5j+AZL3Fe9frAMNv2fwXmLjgHloC7znrWaGerUlkbFJXr2DjP
 sZddJ8KgLpdDd1dkJiM/E/8Gh+IURPo+MKdGdT2pQvcI8Nq2t0iyioqI+BvstgHsWA/9
 6jwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBIQQTx98rbQQ6vjA1vfeURsr78rwLCZetjiLdsXmJmq7VU9Ktjli44kQIBXNbgvmZOZXR1Vgp38jv5hY9LMB2NDKePUM=
X-Gm-Message-State: AOJu0YydxnVERdkfHy8tHP1pdB5tDoFYrKcAnsMOUZpwkUI+AZow1Ym5
 zSqXlDp7cxAOMzRWgQBHCDcxDYGhMYfx9sPx+s/US2krqoPGCREokCAPuiQP57iN+eP7QV7+uY4
 mGjK0UjA9M4vaeS7ekH5iShpyadMbC+/i0093izNG9352JNiIpXLKVeaJpkXu
X-Received: by 2002:a05:6a00:983:b0:704:6ea0:2bba with SMTP id
 d2e1a72fcca58-7046ea05ad1mr5814867b3a.4.1718025691558; 
 Mon, 10 Jun 2024 06:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRQMBm9EIW7vo3eIW6DSYPlRwyW0uBZecVq09BKQgQtSudIHN26FCe+avT4KQSXaDKIa9Pug==
X-Received: by 2002:a05:6a00:983:b0:704:6ea0:2bba with SMTP id
 d2e1a72fcca58-7046ea05ad1mr5814843b3a.4.1718025691204; 
 Mon, 10 Jun 2024 06:21:31 -0700 (PDT)
Received: from localhost.localdomain ([115.96.118.89])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7042f11b2acsm3187790b3a.197.2024.06.10.06.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 06:21:30 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Reviewed-by=20=3A=20Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] tests/qtest/libqtest: add qtest_has_cpu() api
Date: Mon, 10 Jun 2024 18:51:22 +0530
Message-ID: <20240610132123.6381-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Added a new test api qtest_has_cpu() in order to check availability of some
cpu models in the current QEMU binary. The specific architecture of the QEMU
binary is selected using the QTEST_QEMU_BINARY environment variable. This api
would be useful to run tests against some older cpu models after checking if
QEMU actually supported these models.

CC: thuth@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/libqtest.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.h |  8 ++++
 2 files changed, 91 insertions(+)

changelist:
v2: changes related to suggestions made by danpb. added tags.

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index d8f80d335e..7647818c66 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -37,6 +37,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qbool.h"
 
 #define MAX_IRQ 256
 
@@ -1471,6 +1472,12 @@ struct MachInfo {
     char *alias;
 };
 
+struct CpuInfo {
+    char *name;
+    char *alias_of;
+    bool deprecated;
+};
+
 static void qtest_free_machine_list(struct MachInfo *machines)
 {
     if (machines) {
@@ -1550,6 +1557,82 @@ static struct MachInfo *qtest_get_machines(const char *var)
     return machines;
 }
 
+static struct CpuInfo *qtest_get_cpus(void)
+{
+    static struct CpuInfo *cpus;
+    QDict *response, *minfo;
+    QList *list;
+    const QListEntry *p;
+    QObject *qobj;
+    QString *qstr;
+    QBool *qbool;
+    QTestState *qts;
+    int idx;
+
+    if (cpus) {
+        return cpus;
+    }
+
+    silence_spawn_log = !g_test_verbose();
+
+    qts = qtest_init_with_env(NULL, "-machine none");
+    response = qtest_qmp(qts, "{ 'execute': 'query-cpu-definitions' }");
+    g_assert(response);
+    list = qdict_get_qlist(response, "return");
+    g_assert(list);
+
+    cpus = g_new0(struct CpuInfo, qlist_size(list) + 1);
+
+    for (p = qlist_first(list), idx = 0; p; p = qlist_next(p), idx++) {
+        minfo = qobject_to(QDict, qlist_entry_obj(p));
+        g_assert(minfo);
+
+        qobj = qdict_get(minfo, "name");
+        g_assert(qobj);
+        qstr = qobject_to(QString, qobj);
+        g_assert(qstr);
+        cpus[idx].name = g_strdup(qstring_get_str(qstr));
+
+        qobj = qdict_get(minfo, "alias_of");
+        if (qobj) { /* old machines do not report aliases */
+            qstr = qobject_to(QString, qobj);
+            g_assert(qstr);
+            cpus[idx].alias_of = g_strdup(qstring_get_str(qstr));
+        } else {
+            cpus[idx].alias_of = NULL;
+        }
+
+        qobj = qdict_get(minfo, "deprecated");
+        qbool = qobject_to(QBool, qobj);
+        g_assert(qbool);
+        cpus[idx].deprecated = qbool_get_bool(qbool);
+    }
+
+    qtest_quit(qts);
+    qobject_unref(response);
+
+    silence_spawn_log = false;
+
+    return cpus;
+}
+
+bool qtest_has_cpu(const char *cpu)
+{
+    struct CpuInfo *cpus;
+    int i;
+
+    cpus = qtest_get_cpus();
+
+    for (i = 0; cpus[i].name != NULL; i++) {
+        if (g_str_equal(cpu, cpus[i].name) ||
+            (cpus[i].alias_of && g_str_equal(cpu, cpus[i].alias_of))) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 void qtest_cb_for_every_machine(void (*cb)(const char *machine),
                                 bool skip_old_versioned)
 {
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 6e3d3525bf..c94b64f960 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -949,6 +949,14 @@ bool qtest_has_machine(const char *machine);
  */
 bool qtest_has_machine_with_env(const char *var, const char *machine);
 
+/**
+ * qtest_has_cpu:
+ * @cpu: The cpu to look for
+ *
+ * Returns: true if the cpu is available in the target binary.
+ */
+bool qtest_has_cpu(const char *cpu);
+
 /**
  * qtest_has_device:
  * @device: The device to look for
-- 
2.42.0


