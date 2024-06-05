Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E18C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEl1l-0007LT-Uu; Wed, 05 Jun 2024 03:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sEl1l-0007Im-4K
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sEl1j-0004aT-Gv
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717572342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1uH3JVfpOHt4cmUIhQ0XYf7hQEI1P3L3/uwvE5MbOQ0=;
 b=MJNeNQvn6Gb5WsfZddY7lpZyftljc5jXUu1wmg6+Am0aGGEI6ZDpD2PsJw+jAstXBpN203
 RYD4VOKS1GpYP8yP/EUhzy0gy0TkNkiyiYDSHChObckmekvYOktTl92C2/xTrujGbHzgRf
 7r8NJ7I0YYS+S8hu38MxpGJ+8pCgqPI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-NrJ3xxp_P-2be3jX1GhN2w-1; Wed, 05 Jun 2024 03:25:41 -0400
X-MC-Unique: NrJ3xxp_P-2be3jX1GhN2w-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1f682e7079bso24541005ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717572340; x=1718177140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uH3JVfpOHt4cmUIhQ0XYf7hQEI1P3L3/uwvE5MbOQ0=;
 b=PP/0J9AnchimCgw6OYiQiPYIzaMGC34EA8Sdu+pn/GN88zIfMo28qCYzccmDbUb+VW
 ukdyUPkPTEfgPs83RpH3R7bfJgyWg0lJXUXW/p7HVV5byHT9xSiwnhS963Q9hF/3kZGv
 OkC+s48gwYNrTPyKdW8RF1UZepDIp/97BrdBgO8QjRJq1l3f81kOyZCRbwxMJ9I+8qHa
 2NH15R5YuzN0cPVx/1WyzUul/JCsSDiPh0NUFiUrd8UfJm9RirT7SjGUhrb9PCFomW09
 FgeMHCfNct7yJ6wLDPYwBhXahnAlcKUknU46EkoIRjPt0/jwuMGEz9Bz49HVsXE084Dg
 J4yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtu5lBh9uy5WeS7uskC6uYpS/ABWw+pkA6jsIeyD8QXR3wQ4dVvAHTBs80MudeYo+FDdyY+w03vv3KSybigGegDMT744A=
X-Gm-Message-State: AOJu0Ywq/Lqh0goVWy0fLpSaxGudtGlks9o8JUotnWyKvjKi8ZtpmApu
 tCWxSAktze0GnIFDQuEpU4Fh4KQqBE/lr3TWPap2Fri01c0KaTy2Qq+ovHZJ+CuVHR05veMLD0e
 f0WiQtm7cZziLC4P8BlfVyIOHc1Roj6dvaEcn1zlISLG9FBI23GeS
X-Received: by 2002:a17:902:fa86:b0:1f6:1a91:e744 with SMTP id
 d9443c01a7336-1f6a5a11c60mr15807425ad.21.1717572340365; 
 Wed, 05 Jun 2024 00:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2pXxei2mOz5vemilMrrAdP0lTynzCw1RMTI4JTiecXktHkDYoptMQ0rL187vDTNo66IRbxw==
X-Received: by 2002:a17:902:fa86:b0:1f6:1a91:e744 with SMTP id
 d9443c01a7336-1f6a5a11c60mr15807265ad.21.1717572339869; 
 Wed, 05 Jun 2024 00:25:39 -0700 (PDT)
Received: from localhost.localdomain ([203.163.232.78])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1f6703f7673sm56329335ad.210.2024.06.05.00.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 00:25:39 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] tests/qtest/libqtest: add qtest_has_cpu() api
Date: Wed,  5 Jun 2024 12:55:10 +0530
Message-ID: <20240605072512.67692-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240605072512.67692-1-anisinha@redhat.com>
References: <20240605072512.67692-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


