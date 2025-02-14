Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F74CC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 05:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiofj-0000Zf-Io; Fri, 14 Feb 2025 00:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tioff-0000Xg-E2; Fri, 14 Feb 2025 00:55:27 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tiofc-00083g-Ui; Fri, 14 Feb 2025 00:55:26 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BA689EAB0C;
 Fri, 14 Feb 2025 08:55:12 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B99BF1B5FC2;
 Fri, 14 Feb 2025 08:55:20 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A909A53460; Fri, 14 Feb 2025 08:55:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/4] overall: Remove unnecessary g_strdup_printf() calls
Date: Fri, 14 Feb 2025 08:55:17 +0300
Message-Id: <20250214055520.3159764-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250214055520.3159764-1-mjt@tls.msk.ru>
References: <20250214055520.3159764-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace g_strdup_printf("%s", value) -> g_strdup(value)
to avoid unnecessary string formatting.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 crypto/hash-afalg.c | 2 +-
 hw/ppc/spapr_caps.c | 2 +-
 plugins/loader.c    | 2 +-
 target/i386/cpu.c   | 2 +-
 trace/simple.c      | 2 +-
 ui/console.c        | 4 +---
 ui/gtk.c            | 3 +--
 util/module.c       | 2 +-
 8 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index 8c0ce5b520..bd3fe3b427 100644
--- a/crypto/hash-afalg.c
+++ b/crypto/hash-afalg.c
@@ -59,7 +59,7 @@ qcrypto_afalg_hash_format_name(QCryptoHashAlgo alg,
     if (is_hmac) {
         name = g_strdup_printf("hmac(%s)", alg_name);
     } else {
-        name = g_strdup_printf("%s", alg_name);
+        name = g_strdup(alg_name);
     }
 
     return name;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 7edd138360..904bff87ce 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -1034,7 +1034,7 @@ void spapr_caps_add_properties(SpaprMachineClass *smc)
     for (i = 0; i < ARRAY_SIZE(capability_table); i++) {
         SpaprCapabilityInfo *cap = &capability_table[i];
         g_autofree char *name = g_strdup_printf("cap-%s", cap->name);
-        g_autofree char *desc = g_strdup_printf("%s", cap->description);
+        g_autofree char *desc = g_strdup(cap->description);
 
         object_class_property_add(klass, name, cap->type,
                                   cap->get, cap->set,
diff --git a/plugins/loader.c b/plugins/loader.c
index ebc01da9c6..99686b5466 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -128,7 +128,7 @@ static int plugin_add(void *opaque, const char *name, const char *value,
                 /* Will treat arg="argname" as "argname=on" */
                 fullarg = g_strdup_printf("%s=%s", value, "on");
             } else {
-                fullarg = g_strdup_printf("%s", value);
+                fullarg = g_strdup(value);
             }
             warn_report("using 'arg=%s' is deprecated", value);
             error_printf("Please use '%s' directly\n", fullarg);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5dd60d281..72ab147e85 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6166,7 +6166,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
         desc = g_strdup_printf("%s [%s]", model_id, cc->model->note);
     }
     if (!desc) {
-        desc = g_strdup_printf("%s", model_id);
+        desc = g_strdup(model_id);
     }
 
     if (cc->model && cc->model->cpudef->deprecation_note) {
diff --git a/trace/simple.c b/trace/simple.c
index 18af590cf7..c0aba00cb7 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -366,7 +366,7 @@ void st_set_trace_file(const char *file)
         /* Type cast needed for Windows where getpid() returns an int. */
         trace_file_name = g_strdup_printf(CONFIG_TRACE_FILE "-" FMT_pid, (pid_t)getpid());
     } else {
-        trace_file_name = g_strdup_printf("%s", file);
+        trace_file_name = g_strdup(file);
     }
 
     st_set_trace_file_enabled(saved_enable);
diff --git a/ui/console.c b/ui/console.c
index 914ed2cc76..6456e8dd90 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1386,9 +1386,7 @@ char *qemu_console_get_label(QemuConsole *con)
                                        object_get_typename(c->device),
                                        c->head);
             } else {
-                return g_strdup_printf("%s", dev->id ?
-                                       dev->id :
-                                       object_get_typename(c->device));
+                return g_strdup(dev->id ? : object_get_typename(c->device));
             }
         }
         return g_strdup("VGA");
diff --git a/ui/gtk.c b/ui/gtk.c
index c023743148..59bda83da6 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1944,8 +1944,7 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
     vcd->console = vc;
 
     snprintf(buffer, sizeof(buffer), "vc%d", idx);
-    vc->label = g_strdup_printf("%s", vc->vte.chr->label
-                                ? vc->vte.chr->label : buffer);
+    vc->label = g_strdup(vc->vte.chr->label ? : buffer);
     group = gd_vc_menu_init(s, vc, idx, group, view_menu);
 
     vc->vte.terminal = vte_terminal_new();
diff --git a/util/module.c b/util/module.c
index 3eb0f06df1..1aa2079d01 100644
--- a/util/module.c
+++ b/util/module.c
@@ -234,7 +234,7 @@ int module_load(const char *prefix, const char *name, Error **errp)
 
     search_dir = getenv("QEMU_MODULE_DIR");
     if (search_dir != NULL) {
-        dirs[n_dirs++] = g_strdup_printf("%s", search_dir);
+        dirs[n_dirs++] = g_strdup(search_dir);
     }
     dirs[n_dirs++] = get_relocated_path(CONFIG_QEMU_MODDIR);
 
-- 
2.39.5


