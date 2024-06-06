Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DDBC27C5E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 04:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF4zX-0008C8-BX; Thu, 06 Jun 2024 00:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sF4zV-0008C0-Gz
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sF4zT-0008JC-Ud
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717649082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1uH3JVfpOHt4cmUIhQ0XYf7hQEI1P3L3/uwvE5MbOQ0=;
 b=iiPing+Buezh9bNjLS2Bb2pZ9OGhrnusB53Dd1KOjwB7/OvBH4zookGR3jghrl0Np/JP8L
 qob4AMDGwgLz38dX06DUKTkWpeQwkVVW8OMW/1XbpQabIPCjJe/wqYQKGRav8CuEwGGWqs
 h3oNZ30MCMjK9ZxGBcsOj1Z3HTY2dpc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-CTCIYIYIO7qHipT9AUY6uQ-1; Thu, 06 Jun 2024 00:44:40 -0400
X-MC-Unique: CTCIYIYIO7qHipT9AUY6uQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1f62e7432c7so5391725ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 21:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717649079; x=1718253879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uH3JVfpOHt4cmUIhQ0XYf7hQEI1P3L3/uwvE5MbOQ0=;
 b=dlp8t/s6afSOYpw0cYt6NiW6+oV8bJBz8pCSJGFIXS7DD7sfGCYoDQ3SJR2ljc4k5+
 xnMZ+fGd+MVM2xT1swATJiBZ5xm4S9G9CBLoUNNV7fV/MB18eYLEFC0RGO8TcMtgN4Vn
 xcQ+0mZiKZ6f7wKGrKPPerikHEXLeJ7dLNTGGlzPNNrfSidndzJaud2EhVX9Ozo9JtjK
 Sdqkb2u9+bnrHgS7mILVScw25vOfiHaHBD0T9LP/YJxdsHHRhhgdhsxfo6TLjM13ZmMt
 lmtQM2xFRUotaZXzas/JuEdtDcMt8ZWZPMWPWSeBp7oCGrAhU/eC7xvR21e4V45X+QYY
 4YxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUReb0dnw/MhkVb47cG7e5VkovWRkfyPXnmQzXWODGAydoyW4hmAre4BzoclRvA5UPDYzVwsKpYLp0zZCX2QS71KITesRc=
X-Gm-Message-State: AOJu0Yx2lap/EXmSploG4nfibQiz5M8HzcGhs/nj0JqdVWxJbPgcqtOJ
 unO7pTrzRkQI/g99josoc94kzWHvcos/y51IO2b+fbavJiicviJl32Leahxe85Y9b+gduxqPiKU
 0cQvDBIqvaHShOyzDiee9qvy7HFkSo3k2EF6qqa4VOTJTRMmZWk4M
X-Received: by 2002:a17:902:ced1:b0:1f6:8235:dbbc with SMTP id
 d9443c01a7336-1f6a5a23fdfmr53203135ad.29.1717649079440; 
 Wed, 05 Jun 2024 21:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxUT+6IJaKT/HJHkjna57ygcsZOUPHiyrKlwAGybgL4gONW3GDCjXVMt4svHfybH54oIkJAQ==
X-Received: by 2002:a17:902:ced1:b0:1f6:8235:dbbc with SMTP id
 d9443c01a7336-1f6a5a23fdfmr53203005ad.29.1717649079004; 
 Wed, 05 Jun 2024 21:44:39 -0700 (PDT)
Received: from localhost.localdomain ([203.163.239.242])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1f6bd81b9e2sm4057165ad.295.2024.06.05.21.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 21:44:38 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] tests/qtest/libqtest: add qtest_has_cpu() api
Date: Thu,  6 Jun 2024 10:14:18 +0530
Message-ID: <20240606044419.8806-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240606044419.8806-1-anisinha@redhat.com>
References: <20240606044419.8806-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
---
 tests/qtest/libqtest.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.h |  8 ++++
 2 files changed, 92 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index d8f80d335e..135a607728 100644
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
@@ -1550,6 +1557,83 @@ static struct MachInfo *qtest_get_machines(const char *var)
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
+    cpus = g_new(struct CpuInfo, qlist_size(list) + 1);
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
+    memset(&cpus[idx], 0, sizeof(struct CpuInfo)); /* Terminating entry */
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


