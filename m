Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B77C98335
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 08:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xANbP-0000ti-LC; Sat, 26 Sep 2026 04:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANab-0008KI-U8
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:17:01 -0400
Received: from mail-dl2-x0e.google.com ([2607:f8b0:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANaZ-0006rQ-3u
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:57 -0400
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-144efd1ea76so1013744c88.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790410612; x=1791015412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bykFcKA6UsA5TmzVTu+04YGJhlxe19nedknbhDiTTcM=;
 b=c2W8u1BXeq5+pvUJDBCX+IVkKRWdYe9YQjwpb2+uCXmYmNa4FiU/8RwCTDvZEh0DFp
 +tBgWWJLHS7DQQuTkZLlZjRIP6dpeL1w0Hi6POmDmrbLWTm+tShNaythUC7YjTQosxTR
 RQsYZnXQxRpakZU0WzLGrAMnuebOOT0D9wZ71CC8ptpP+rPGZRtB2nDIUBUrMJjt1fKf
 ZAeCZcV8hyV7x2o3szQb65bx1902Xy1XxprceGtYJk96Cu4DlU+pBvZR2OtA2AuW7yY5
 PMkkNn0t3wR3QKShFSLxHw1+AmelrW7LeuMmdAwL1nlQHVi28pn+wQm7BwV5WE6+QyBn
 1RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790410612; x=1791015412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bykFcKA6UsA5TmzVTu+04YGJhlxe19nedknbhDiTTcM=;
 b=N/XinlWV9lsxc4RO++Fot1uv40SswmVsDvh2gJ7nShByiIhTp7WQawcJa+pIRZ4QY1
 VOvrPNQFsUHQoMiziCX5tPyU4BtYpc4oDCHFHJ2HWAw8ewGDiiZ5WqfdwuYX+a9NqqCi
 PeKWL+xP3SsqNxVQrsvODioUqD06TUuKGNICZGTok8zSRfxOaBqIZ5JtHWVGIDoCcI+6
 aBKckFP0cDXkUMTGz08sac0RXu/43sqiUB9lCEMOW+DHWVjc2klYTLOQR+Ak9c0vpGch
 GWylPgZkM64z0YyXufnQGZlhCH1icVX2qw/Q+ex7xbgeM8ibTfiB2vnoFVyXZyUCCLCr
 f5nQ==
X-Gm-Message-State: AFuF++lUxiz0TiYVo4b3GgLVTw4HEsaPG+1UtN5gasvea0OjNe4BsdkZ
 3kh3++N/13YjPu5jMPIoLEm1/FhaKgVrmAoszmCXWQ98+tsHnFqH2RjsyuvcuGDP
X-Gm-Gg: AYBFou0S6dLRuQZSK2HBcigG7CQ3OGvGNnQ/hZ+U3B3tcxzc4gfHplhidNotLepbXgF
 hXdzVB+asjHGe4X3D+kxR0zTl/mvxfFadl2VQHe71IH4vG0s/JxOeZ1joUTKlWXwe/FgBfM+kmr
 cJB6LTpIpRc9q/SWpJ9ZP8V+gYpPQ2W7Jkfl31trrr/kEH/sNboZG1sWIfJPzaNY2SO+DsBIlCN
 xAmdtSJhvpPmopHVMlg4tEZ7aIcI1Y9H2W3t4660HuOFoRUv0jsoX0oSNe+RxcqGVbYU5RyfDRV
 /snyej7TfK246n39SJSYbNaixloGJHmhyl5Xa4DgdvDJecuBuTHBBSNUm620uag4XkGyWnFGovb
 BVLc8dtPboW4m9tuuCXGQXGDssaahCMdD0Pwssi3MF3uZZXqRNmMNmNtpHpXM4KIRZdKPw8OCdd
 RBLJuBWNZqKVEDvSNlU2Rv32ZepuXNyeZxe58ZeJkGTNUdyl9GnE+VFWGspCNahE0L2FxwOyMy8
 qTy0CfvNko+oCRwcqtfEK6Ef9pdZMk=
X-Received: by 2002:a05:7300:a987:b0:341:bcd4:7b6a with SMTP id
 5a478bee46e88-3426f8c1dcfmr3183022eec.4.1790410612304; 
 Sat, 26 Sep 2026 01:16:52 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34144f4eb9esm11970568eec.19.2026.09.26.01.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 01:16:51 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Laurent Vivier <laurent@vivier.eu>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 09/10] qapi: return MachineInfo typename from query-machines
Date: Sat, 26 Sep 2026 16:15:49 +0800
Message-ID: <20260926081551.29-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926081551.29-1-luoyonggang@gmail.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/core/machine-qmp-cmds.c |  1 +
 qapi/machine.json          |  6 +++-
 tests/qtest/qom-test.c     | 65 ++++++++++++++++++++++++++++++++++----
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 9c08b17510a..27ceed54a14 100644
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
index b1be5608b61..f5ead98e174 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -168,6 +168,9 @@
 #
 # @name: the name of the machine
 #
+# @typename: QOM type name of the machine, for qom-list-properties
+#     (since 11.2)
+#
 # @alias: an alias for the machine name
 #
 # @is-default: whether the machine is default
@@ -208,7 +211,7 @@
 # Since: 1.2
 ##
 { 'struct': 'MachineInfo',
-  'data': { 'name': 'str', '*alias': 'str',
+  'data': { 'name': 'str', 'typename': 'str', '*alias': 'str',
             '*is-default': 'bool', 'cpu-max': 'int',
             'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
             'deprecated': 'bool', '*default-cpu-type': 'str',
@@ -238,6 +241,7 @@
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
2.52.0.windows.1


