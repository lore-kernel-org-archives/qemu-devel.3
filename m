Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F95606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jQmCuTxY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf8s-00068p-Ks; Tue, 27 Oct 2026 07:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf88-0005IX-P8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:14:12 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf86-00034N-OF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:14:12 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so2281278c88.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099649; x=1793704449; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EuzVL9RT8cyqNbxbd4w1mFeuaPb3DvaZU8xvI5Mhco8=;
 b=jQmCuTxYOwPoQybg7FoP05my+ZfQ1VH1i1g5ax8C+Ph0GKWEXBkugyMazS7HCtFwnz
 bBcaD+5P0jbj9+xtL6hv8j85eer4lh7UMMrbCwSjRW5LAySicrsaxGa1V8G3VMon+IQE
 5BNCiHiReiQG93YGV4wTDXuqMSekUYCfC4cbXFuEfk0qIaUOL3NbmseLrrUTuVC5KeTm
 Cq1vGeMyQ9GlU2Tmg3vAYRv2OXjTvhKJSQC7wFgX4Qihqx6HIaAf6JSX6yOWPTpjWyiE
 3CZasoFD4kgFrea+EQ+B1nlkA9DgjV5G7ocVnrGS22l7RgHW7nVxL+vQ7oL0o0t5ZN1O
 H+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099649; x=1793704449;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EuzVL9RT8cyqNbxbd4w1mFeuaPb3DvaZU8xvI5Mhco8=;
 b=1EQ5dHkCHS7+nIXUcQBvpo2xfRzC5XtvZDEH7EI6IT5jfQcReB4e423J0jTypODKeq
 3pQm/72uF6gE9XM+ssHyhe1d6MgUpCyNMcaEPexVMt9EyW0OZ2s3irN8Ufng2VBxj5Lw
 /qcSDqYB19y7aGL8i67dZQXo6Fpa1CJoJVLB2o3ZTQtIPrw4pJbgFyph+q+Y7Uu9lR8k
 cbRqS3iI6qWDuPStHvQK2Wo75Jed36DqPwQ+ZZsNs9eVtQI23r95p1hVoKD/OG78ppLj
 UrKizLoyOvwVsopjRBnLy8C8r55npt6t3XeP6NS0QnkrT8yDn3R4dIOfNSkZ4CYoFD+x
 de5Q==
X-Gm-Message-State: AFq9FYLdIa288Ud7tjpHIpZMxa8yfLu09yk/tPr7SS7xT+34/6MVn8uO
 c0SFTxmzkeFxKy9nfJLYZNi7B67WIW3aJBcYbBEtq2SPBn2TAxlR27wLBFMJjW+Y
X-Gm-Gg: AYBFou2W/AWBfFoRElm5E50/m44q9soxTSR1XsuxrI0Dzy46XhhVzpyQqyFpEYWo+9L
 h9OpLnXyWiTsf9rw8QDLaEXTyfmQojlOeYdQNmflC/vnuUwoGsk0OJSdgWOEfYWoEP5olca96RH
 BMd6tmMawfuI2m/fTjVjzENb7MEBov3XpvAi/asWy6C5ZTTqg25vBNKLvQavyWfICWoMbSMYb7q
 ciN+etoxVB4bVQKzhT9xg/vgaKr0NSOK75tTe6BxluMnnY7lrdh957I3vpLHT6WwoHrQ1zwQa25
 wIHEOOprn/jR8eetMF6x7LGWLVezAAy0fTPXYbFB3wwoI4pDM7FQ0Kj4riV81QJ9ucDhrCZ48rf
 e2EulVqau1W6+Z0s676oHX4de1VFVeaES3M3reGpC7P5Iq3I+QwZTtv3D9oKcBGJ7UQje/DniJE
 KQCoA35qo07Fjh9kBGIi0QF5XqKls9PrkIqSVHdnIpk2YChnktNbunFt1yV9Q2Zntv3lWZ7CH3J
 KuB/0ZiYWkny7YMEns0Jq7CaiHgV/JMP+uaH1BUXNCKATK1bCc5odWbKx8QR1iSolKAewZ/wnad
 h5w7LTIQvstp
X-Received: by 2002:a05:701b:4248:20b0:193:9aa3:4758 with SMTP id
 a92af1059eb24-19929f6dc66mr14866141c88.4.1793099649244; 
 Tue, 27 Oct 2026 04:14:09 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:14:08 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Song Gao <17746591750@163.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Eric Blake <eblake@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 16/17] qapi: return MachineInfo typename from query-machines
Date: Tue, 27 Oct 2026 19:12:14 +0800
Message-ID: <20261027111216.392-17-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

target_heterogeneous() needs MachineInfo typename: a prefixed type
such as arm-virt-11.1-machine does not match -M virt-11.1.
qemu-system-<target> keeps its behavior, so the QOM type is still
the -M name plus "-machine". typename can still be used when
target_heterogeneous() is false. Return the QOM type from
object_class_get_name() in qmp_query_machines().
test_query_machines_typename checks that qom-list-properties accepts
it.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine-qmp-cmds.c |  1 +
 qapi/machine.json          |  6 +++-
 tests/qtest/qom-test.c     | 65 ++++++++++++++++++++++++++++++++++----
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 07a048d0a9e..14af09a8844 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -174,6 +174,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         }
 
         info->name = g_strdup(mc->name);
+        info->q_typename = g_strdup(object_class_get_name(OBJECT_CLASS(mc)));
         info->cpu_max = !mc->max_cpus ? 1 : mc->max_cpus;
         info->hotpluggable_cpus = mc->has_hotpluggable_cpus;
         info->numa_mem_supported = mc->numa_mem_supported;
diff --git a/qapi/machine.json b/qapi/machine.json
index 9b145c635ba..7739f08d1ba 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -161,6 +161,9 @@
 #
 # @name: the name of the machine
 #
+# @typename: QOM type name of the machine, for qom-list-properties
+#     (since 11.2)
+#
 # @alias: an alias for the machine name
 #
 # @is-default: whether the machine is default
@@ -201,7 +204,7 @@
 # Since: 1.2
 ##
 { 'struct': 'MachineInfo',
-  'data': { 'name': 'str', '*alias': 'str',
+  'data': { 'name': 'str', 'typename': 'str', '*alias': 'str',
             '*is-default': 'bool', 'cpu-max': 'int',
             'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
             'deprecated': 'bool', '*default-cpu-type': 'str',
@@ -230,6 +233,7 @@
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


