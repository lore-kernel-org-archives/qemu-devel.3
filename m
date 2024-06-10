Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74960C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 15:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGhLJ-0002HX-3r; Mon, 10 Jun 2024 11:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sGhLG-0002H0-0J
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sGhLE-0005wg-Ao
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718034831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwXaYEW/lT6rdZ/oAK0Wp6kiCb0kvAcN04wlh93LYmA=;
 b=Cz4KRe4dyojmdoUqXu+sNtvl76OczhNxhfkwscHvNBllEx80P9sq0FgGqT0NYNf3v0FUho
 4JxUZ8yKEPaRc4VPz0WRnH5TyZYBQ7B7up6rrvuCzq+WHDlmdYTDPdLIdmIQC0uOwm25Ro
 MVb48BqYWn5X45UCvO1C1ktDIcXEF5w=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-MoUwvzMoMOyoEYB91ZM6gw-1; Mon, 10 Jun 2024 11:53:49 -0400
X-MC-Unique: MoUwvzMoMOyoEYB91ZM6gw-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-375a15e8473so1422615ab.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 08:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718034828; x=1718639628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwXaYEW/lT6rdZ/oAK0Wp6kiCb0kvAcN04wlh93LYmA=;
 b=bPuqmf47GP6QApobAOn0IpglWi94szEpssfXs3FH753KBon9aGs/V6EqszEkuZ89x2
 KXrNw1ENx+XVj9WFoJ8NFWMMS21tmGZeLkWndBQmaDWj/yBOHsS7ZnEy3W623aaNpEZ2
 OXgC8qtzj/8bWl9Kn+eA8eyDOSAyJ+sclF4NGBC6WlLqzn5FnKUhqJVVaQpD9jtMR6Xv
 BdpZ3i/xMsae7mN5d/uYyILslV6Rs6wlBvjW1UIbUB7tIz/9VbPf4tAfyM+ye4u2dmh8
 DC3bsxdc18pRyqETpPT67ZwCD7dW0xOQMed1f+Die3uKOqvP0RB1ZwM4BN2DlJ8czdjk
 0I6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyoVgLt/QXWzW4ewkhDZfNaHMkDlnkrpKdGSqkMs/2Z/ZNfU8njdFHM1fLn8AB+835pVlpFCshlza14GhDj7sUuBsRXAw=
X-Gm-Message-State: AOJu0YxUESgDsoKBu3n0sZBlm26zAWQdu0S/q3OLbQ31I/hnMeT+3Ex+
 zWX6wj8KLG6eYwSMwsUN/r1dIyTxpyKuNKL9q83Z8DgaDdLR+8BYr7LpXJyc6JLpeC1w3/PmcDf
 zNRveqKhfZKMIyPYP+u8SQkd17RSAji+HZaZaLHNcOwCOLVcDfiSI
X-Received: by 2002:a92:ca4c:0:b0:374:972a:f8ae with SMTP id
 e9e14a558f8ab-3758030843bmr128710805ab.12.1718034828420; 
 Mon, 10 Jun 2024 08:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJuvV/YogbwJvPYta+jRmZjlMzxged66vXNSkUn++RMyKhR+kyqbza/gAVZHQyQyq+1hyi4w==
X-Received: by 2002:a92:ca4c:0:b0:374:972a:f8ae with SMTP id
 e9e14a558f8ab-3758030843bmr128710615ab.12.1718034828148; 
 Mon, 10 Jun 2024 08:53:48 -0700 (PDT)
Received: from localhost.localdomain ([115.96.118.89])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-6e3819ffa94sm5155290a12.85.2024.06.10.08.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 08:53:47 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Reviewed-by=20=3A=20Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] tests/qtest/libqtest: add qtest_has_cpu_model() api
Date: Mon, 10 Jun 2024 21:22:59 +0530
Message-ID: <20240610155303.7933-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240610155303.7933-1-anisinha@redhat.com>
References: <20240610155303.7933-1-anisinha@redhat.com>
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

Added a new test api qtest_has_cpu_model() in order to check availability of
some cpu models in the current QEMU binary. The specific architecture of the
QEMU binary is selected using the QTEST_QEMU_BINARY environment variable.
This api would be useful to run tests against some older cpu models after
checking if QEMU actually supported these models.

CC: thuth@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/libqtest.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.h |  8 ++++
 2 files changed, 91 insertions(+)

changelog:
v2: changes related to suggestions made by danpb. added tags.
v3: phil's suggestion to rename function and structure names.
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index d8f80d335e..18e2f7f282 100644
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
 
+struct CpuModel {
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
 
+static struct CpuModel *qtest_get_cpu_models(void)
+{
+    static struct CpuModel *cpus;
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
+    cpus = g_new0(struct CpuModel, qlist_size(list) + 1);
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
+bool qtest_has_cpu_model(const char *cpu)
+{
+    struct CpuModel *cpus;
+    int i;
+
+    cpus = qtest_get_cpu_models();
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
index 6e3d3525bf..beb96b18eb 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -949,6 +949,14 @@ bool qtest_has_machine(const char *machine);
  */
 bool qtest_has_machine_with_env(const char *var, const char *machine);
 
+/**
+ * qtest_has_cpu_model:
+ * @cpu: The cpu to look for
+ *
+ * Returns: true if the cpu is available in the target binary.
+ */
+bool qtest_has_cpu_model(const char *cpu);
+
 /**
  * qtest_has_device:
  * @device: The device to look for
-- 
2.42.0


