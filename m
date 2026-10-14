Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ACBCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvXN-0005E6-A0; Wed, 14 Oct 2026 05:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvX8-0004xd-RS
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:44:31 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvX6-00024p-Fz
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:44:26 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-17bc533fda3so755527c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791971056; x=1792575856; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GXB3QXKoY6wasyI186JoDtarXRkUlXykQdj7F/0KBfo=;
 b=l588tGwrOuENdFJXO3XVfBxeltW57SIlJqxQ+tYTW2qvj5mVyJtwSi+hkOltp6cj4u
 Vt2NyH20bGZwgGvJpBET4HSZeBP8Khh87xVGeZvJ9tVisBX6fEsZ2GH/JUIJ9f3nj5b2
 7d/gBv8YcqeS7xBS9i8EVq36YlWMfuPo9N70kVlDwNKbIj7pNQh1fpcWPv7VIKdRK0ZA
 2EVKBleiyYEoLXbBj2wZAN79409ueGxA7vj6DKsxEcoX5lpIOA4+W//kglObja3BS/WW
 udgn5qriVBbGJsWTy94SBz+VLwhT3nHiEE3wDkrGXu2l29WPOWHnXkyGliFQHWOL5jST
 bsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791971056; x=1792575856;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GXB3QXKoY6wasyI186JoDtarXRkUlXykQdj7F/0KBfo=;
 b=2x7qzhjlmBPAgy470sRjhy5XE5Q0HtNzeTnTTFnk5JlHKyIjr3++iIS1095kj+rzEB
 yYeh9W3LKWW2fKTkpnMq//Mmyi90xHrbgl+X0DTL565xSL04pDSVFQS1po2U9gMsOnOv
 afcmXUFl/t0dygH1QRG3KdyRjPLF+ilVRscAOEn5iJXh6rZtfH1KEsv1FiUDCBZk0knE
 o6WQ0lDXsTCEUYwTrYNmAHMKVT9B1Rt/k/taRadpZNENQzoT/JoCfAgv8mZ8BXnSxIZ9
 dmKuk+kpwnEBkoMQaOCCnNKhxR3e0n4oPEMJDO0FhMQYr3DOqDOrmfRpTTQhYtPem6HJ
 w7HQ==
X-Gm-Message-State: AFq9FYJyF8LDr2fgyk75O5Php+Wlc4lE/E5BCGh+ccU7+R673nahTMZl
 aUZD9Ppy+3k3qm+97nv5+X+dast4SxxfgiIdgPfu00JGwEfJX/ZpDWSK6YPNI1D4LUs=
X-Gm-Gg: AYBFou1vcP3loB1+Mva/kDT7h3xRggvypQgrwve5QSRASeBk9SfrqDOXmmV6Drrhnhc
 gmmYAYR6mQMCaqK+MrU570cFFnJktRLxPTCw+ukyrZ29NaYX262HCTdHPgIXQ7BHl/48FQw7vJP
 hIdJ2VqanhhDluf+FV3vWCSsx03uDOZTh7putYj1FaTBlMh95uZOb96aTq8H8NwWtGw6L7VDmej
 K6pboFcWAs2PuOhYZzwxx9U6SMj2FrAMq0BtvsffsDWqHnSjGXNKJ/UgnwujQ1jD7USjPyvORel
 XOBQAm76IPYNT/zmqQ2OIYJO1gCWD9LE0c/k7vkX+dmpsV7bUqtUYWX+7b5452raBT9m+r+Wbwf
 VLCiEVn36mrj3vEpOLoVKU9L/3noRjEa9SBOmAQKf07IZkM6BM5y2K9gmWDw8n//NYtHKnuNuAr
 ciPcv3/aoYsktEEtgoP8siigrYOrklWCW4QFU2kTbL1WtS2FA7g0YpNCCQvmgl+2gEihU0eCES4
 Ivw4yw5VTCwhE5eNMo=
X-Received: by 2002:a05:7022:170a:b0:15f:28e1:7c7d with SMTP id
 a92af1059eb24-16a61d5c4f6mr18481031c88.42.1791971055473; 
 Wed, 14 Oct 2026 02:44:15 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:44:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Song Gao <17746591750@163.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 26/34] qapi: return MachineInfo typename from query-machines
Date: Wed, 14 Oct 2026 17:41:41 +0800
Message-ID: <20261014094224.1976-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

query-machines returned only the -M name, so management apps inferred
the QOM type as that name plus "-machine". A prefixed type such as
arm-virt-11.1-machine no longer matches -M virt-11.1. Return the QOM
type in MachineInfo typename from object_class_get_name() in
qmp_query_machines(). test_query_machines_typename checks that
qom-list-properties accepts it.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/machine-qmp-cmds.c |  1 +
 qapi/machine.json          |  6 +++-
 tests/qtest/qom-test.c     | 65 ++++++++++++++++++++++++++++++++++----
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index bc614a75c7d..59818764dad 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -116,6 +116,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         }
 
         info->name = g_strdup(mc->name);
+        info->q_typename = g_strdup(object_class_get_name(OBJECT_CLASS(mc)));
         info->cpu_max = !mc->max_cpus ? 1 : mc->max_cpus;
         info->hotpluggable_cpus = mc->has_hotpluggable_cpus;
         info->numa_mem_supported = mc->numa_mem_supported;
diff --git a/qapi/machine.json b/qapi/machine.json
index a3d6e08a847..47fbc422ec5 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -162,6 +162,9 @@
 #
 # @name: the name of the machine
 #
+# @typename: QOM type name of the machine, for qom-list-properties
+#     (since 11.2)
+#
 # @alias: an alias for the machine name
 #
 # @is-default: whether the machine is default
@@ -202,7 +205,7 @@
 # Since: 1.2
 ##
 { 'struct': 'MachineInfo',
-  'data': { 'name': 'str', '*alias': 'str',
+  'data': { 'name': 'str', 'typename': 'str', '*alias': 'str',
             '*is-default': 'bool', 'cpu-max': 'int',
             'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
             'deprecated': 'bool', '*default-cpu-type': 'str',
@@ -231,6 +234,7 @@
 #               {
 #                  "hotpluggable-cpus": true,
 #                  "name": "pc-q35-6.2",
+#                  "typename": "pc-q35-6.2-machine",
 #                  "compat-props": [
 #                       {
 #                          "qom-type": "virtio-mem",
diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index cf4c6b5add5..4ee95af6d94 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -200,13 +200,32 @@ static void test_machine(gconstpointer data)
 
     if (g_test_slow()) {
         /* Make sure we can get the machine class properties: */
-        g_autofree char *qom_machine = g_strdup_printf("%s-machine", machine);
-
-        response = qtest_qmp(qts, "{ 'execute': 'qom-list-properties',"
-                                  "  'arguments': { 'typename': %s } }",
-                             qom_machine);
-        g_assert(response);
+        QList *list;
+        const QListEntry *p;
+        bool found = false;
+
+        response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
+        g_assert(!qdict_haskey(response, "error"));
+        list = qdict_get_qlist(response, "return");
+        g_assert(list);
+        for (p = qlist_first(list); p; p = qlist_next(p)) {
+            QDict *minfo = qobject_to(QDict, qlist_entry_obj(p));
+            QDict *props;
+
+            if (strcmp(qdict_get_str(minfo, "name"), machine)) {
+                continue;
+            }
+            props = qtest_qmp(qts, "{ 'execute': 'qom-list-properties',"
+                                   "  'arguments': { 'typename': %s } }",
+                              qdict_get_str(minfo, "typename"));
+            g_assert(!qdict_haskey(props, "error"));
+            g_assert(qdict_haskey(props, "return"));
+            qobject_unref(props);
+            found = true;
+            break;
+        }
         qobject_unref(response);
+        g_assert(found);
     }
 
     test_properties(qts, "/machine", true);
@@ -218,6 +237,39 @@ static void test_machine(gconstpointer data)
     qtest_quit(qts);
 }
 
+static void test_query_machines_typename(void)
+{
+    QTestState *qts;
+    QDict *response;
+    QList *list;
+    const QListEntry *p;
+    bool saw = false;
+
+    qts = qtest_init("-machine none");
+    response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
+    g_assert(!qdict_haskey(response, "error"));
+    list = qdict_get_qlist(response, "return");
+    g_assert(list);
+
+    for (p = qlist_first(list); p; p = qlist_next(p)) {
+        QDict *minfo = qobject_to(QDict, qlist_entry_obj(p));
+        const char *typename = qdict_get_str(minfo, "typename");
+        g_autoptr(QDict) props = NULL;
+
+        g_assert(g_str_has_suffix(typename, "-machine"));
+        props = qtest_qmp(qts, "{ 'execute': 'qom-list-properties',"
+                               "  'arguments': { 'typename': %s } }",
+                          typename);
+        g_assert(!qdict_haskey(props, "error"));
+        g_assert(qdict_haskey(props, "return"));
+        saw = true;
+    }
+
+    g_assert(saw);
+    qobject_unref(response);
+    qtest_quit(qts);
+}
+
 static void add_machine_test_case(const char *mname)
 {
     char *path;
@@ -250,6 +302,7 @@ int main(int argc, char **argv)
 
     qtest_cb_for_every_machine(add_machine_test_case, g_test_quick());
     qtest_add_func("qom/qom-qtests", test_qom_qtests);
+    qtest_add_func("qom/machine-typename", test_query_machines_typename);
 
     return g_test_run();
 }
-- 
2.55.0.windows.3


