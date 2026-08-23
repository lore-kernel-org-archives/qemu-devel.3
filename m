Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BF5C5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 15:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy9pA-00014H-4O; Sun, 23 Aug 2026 11:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9p7-0000uw-NS
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:09:25 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9p2-0000PZ-Fz
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:09:25 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38fdeaed181so3512680a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787497758; x=1788102558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=McOEX656sGwdTTJCIpURIyAYYj2SmU5EIhHs1+kHacM=;
 b=TYHzrpmgy6uPtN/MOPl48ppSSwAVva9+uvAMz1mOZsdzz9WdhuMLymYgpgT2k5wcao
 fWyWgH9mgmb98XunFyvAcDpzqamQXxDg3ZmdW12aJ9AHsOSRK/cdEKEfaqYsnAXgLgM7
 VF8v6axYjudeJ/Eny66Dz1nLku1kUJrpuE8M98ZesKsREISbbRyMMVkfACTpoJIObEkJ
 SaG6tICM0wpnFHwgmuDJ1CLknJDABINNhGlbpqh8zREjSj/Nk1DWDBk7fKnadNviTbaU
 3ok6mnLveFA7UVHyjDQSlJVVbb3cTENS7b8IaN2HOLrScTbyouBIjo3eJ7Z10lp9FVRI
 Gd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497758; x=1788102558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=McOEX656sGwdTTJCIpURIyAYYj2SmU5EIhHs1+kHacM=;
 b=YLLqZOFZYKfeEHFcZddcInL92jzEY73B7uXm1cfSy9f8jWynJdHw4/BtBtGC16kvAi
 /rf0Th0hiwDcmkcwh4fzo7nBVGbgCUSgdNneBlOZJ/yyEGGJWy2fcmVVumYLzkX62HOD
 60lZPxImKpR5rhQDd7IWZDRwgu2ZY7utEvEtTKvw/LkpXw6BahFelErgUdGLiujcFeMU
 HRa3IotqOEpb069Bn0eDkb72HgzhS1TqH29BWfr7kanHBFXMPESoCK33U1xYdWoaXFny
 WeGXShv/r3o6zn4HCPw5ImzeiPSz3z0LKtHmFeLZnXBLOADG3CmO0mhWrB/WV2LlfwuQ
 Fh/w==
X-Gm-Message-State: AFuF++n7HvVwyWIJT+goTthB0gAhk26q4yYUVZpamnhUc9dqpDz7quiw
 9/F7B+P7pbnh7NNpmh2eBpC27JSn3dx1RR4YWX9QnWc05aEajj85QKB2luW36VVb+Ws=
X-Gm-Gg: AR+sD118fDBbHJAtq3NFHdH+UUdagEJH2MC4TIDzpyWNGo9W2BbvzO0Nyk2ccf98ywV
 NNESUszUYYt9m5xSz9Z7JWYaq9Cy94DPRzh49Lmg+Vh9EuW6wafeA3MUaKfP7grkGgP9Rb7HGqL
 aP/q0SDzfsutXviyCkBGnQN0OnuROjWp5jBZ2yEPbH2ZFyqnvQKZ7R8K7QpaHWj5S3wejdhwhBF
 O6d5QkVQhUIi8inAW2ToDWci6Vi8ZS/fFNcqh4Wac1DJj16psmea3z3yE6Eafe3ug/707yBSvkc
 sPyUUrR3URXkFULQA+6RvLMLOWw/spNgRG8OO+n102RJnnRNPYQ8ERzsKn+uu56jRzSngUYQj2Z
 N5iUzE4A/bescIFe+9Jv1yDTmYqbsh67segjBP04MFtv8kcl6FaCrsJmeV5Pfm5LMVmv9V1kmkZ
 qVJbrt+mYbiKr2OxaiDbGmy8h4uA6HlQ1ZWlDjl9BIDBG+bjNsImkIWRgJDRgpc8O1jN6HyzbyO
 M08s3mzWCl/Mo+8CqLCaw==
X-Received: by 2002:a17:90b:4a81:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-395c34fed98mr31058811a91.4.1787497757907; 
 Sun, 23 Aug 2026 08:09:17 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1418619d6ecsm16024511c88.14.2026.08.23.08.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:09:17 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH 10/12] target-info: add -target and program-name selection
Date: Sun, 23 Aug 2026 23:07:28 +0800
Message-ID: <20260823150731.896-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260823150731.896-1-luoyonggang@gmail.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1030.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- Parse -target before TargetInfo is fixed; CLI overrides the program
  basename.
- Tokens are target_name or target_name-be / -le; -target help lists
  registered names in sorted order.
- When -target is omitted, infer the token from g_get_prgname(): strip
  .exe, take the longest dash-separated registered suffix, and retry
  without a trailing w for Windows GUI binaries.
- A basename that matches no registered token falls through to the
  unique default. Combined binaries with no suffix require -target
  when more than one default TargetInfo is registered.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info-qom.h |  10 +-
 qemu-options.hx                |  13 +++
 system/vl.c                    |  28 ++++--
 target-info-qom.c              | 167 ++++++++++++++++++++++++++++++---
 tests/qtest/fuzz/fuzz.c        |   2 +-
 5 files changed, 197 insertions(+), 23 deletions(-)

diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 842cf241e0a..3b59cf82d65 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -40,7 +40,15 @@ typedef struct TargetInfoQomClass {
 
 OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
 
-void target_info_qom_set_target(void);
+/**
+ * target_info_qom_set_target:
+ * @name: -target token, or NULL/%empty to infer from the program
+ * basename or the unique default
+ *
+ * Tokens are target_name (arch default endian) or target_name-be /
+ * target_name-le. -target overrides the program basename.
+ */
+void target_info_qom_set_target(const char *name);
 
 /**
  * get_machine_types_available:
diff --git a/qemu-options.hx b/qemu-options.hx
index 34970fffc94..638b531aa49 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -223,6 +223,19 @@ SRST
     as -machine.
 ERST
 
+DEF("target", HAS_ARG, QEMU_OPTION_target,
+    "-target name    select target ('-target help' for list)\n", QEMU_ARCH_ALL)
+SRST
+``-target name``
+    Select the emulation target (``-target help`` for the list). The
+    default endian is the architecture default (``riscv64`` is little
+    endian). The other endian uses a ``-be`` or ``-le`` suffix
+    (``riscv64-be``, ``ppc64-le``). If omitted, a matching suffix of
+    the program basename is used (``qemu-system-riscv64-be``, and
+    ``qemu-system-aarch64w.exe`` on Windows). ``-target`` overrides
+    the program name.
+ERST
+
 DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,
     "-cpu cpu        select CPU ('-cpu help' for list)\n", QEMU_ARCH_ALL)
 SRST
diff --git a/system/vl.c b/system/vl.c
index 83b9425de9b..405f434e036 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -166,6 +166,7 @@ typedef struct DeviceOption {
     QTAILQ_ENTRY(DeviceOption) next;
 } DeviceOption;
 
+static const char *target_option;
 static const char *cpu_option;
 static const char *mem_path;
 static const char *incoming;
@@ -2899,19 +2900,12 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
-    module_call_init(MODULE_INIT_TARGET_INFO);
-    target_info_qom_set_target();
-
-    module_init_info(qemu_modinfo);
-    module_allow_arch(target_name());
-
-    qemu_init_subsystems();
-
-    /* first pass of option parsing */
+    /*
+     * First pass: options needed before TargetInfo is fixed.
+     */
     optind = 1;
     while (optind < argc) {
         if (argv[optind][0] != '-') {
-            /* disk image */
             optind++;
         } else {
             const QEMUOption *popt;
@@ -2921,10 +2915,21 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_nouserconfig:
                 userconfig = false;
                 break;
+            case QEMU_OPTION_target:
+                target_option = optarg;
+                break;
             }
         }
     }
 
+    module_call_init(MODULE_INIT_TARGET_INFO);
+    target_info_qom_set_target(target_option);
+
+    module_init_info(qemu_modinfo);
+    module_allow_arch(target_name());
+
+    qemu_init_subsystems();
+
     machine_opts_dict = qdict_new();
     if (userconfig) {
         qemu_read_default_config_file(&error_fatal);
@@ -3687,6 +3692,9 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_nouserconfig:
                 /* Nothing to be parsed here. Especially, do not error out below. */
                 break;
+            case QEMU_OPTION_target:
+                /* Parsed before TargetInfo is selected. */
+                break;
 #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
             case QEMU_OPTION_daemonize:
                 os_set_daemonize(true);
diff --git a/target-info-qom.c b/target-info-qom.c
index 2c1c57b05fd..be03573a699 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/help_option.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "qemu/target-info-impl.h"
@@ -87,7 +88,139 @@ const TargetInfo *target_info(void)
     return target_info_ptr;
 }
 
-void target_info_qom_set_target(void)
+static const TargetInfo *target_info_from_class(ObjectClass *oc)
+{
+    return TARGET_INFO_CLASS(oc)->target_info;
+}
+
+/* Default token is target_name; the other endian is target_name-le or -be. */
+static char *target_info_option_name(const TargetInfo *ti)
+{
+    if (ti->is_default) {
+        return g_strdup(ti->target_name);
+    }
+    if (ti->endianness == ENDIAN_MODE_BIG) {
+        return g_strdup_printf("%s-be", ti->target_name);
+    }
+    return g_strdup_printf("%s-le", ti->target_name);
+}
+
+static gint target_info_token_name_cmp(gconstpointer a, gconstpointer b,
+                                       gpointer data)
+{
+    const TargetInfo *ta = target_info_from_class((ObjectClass *)a);
+    const TargetInfo *tb = target_info_from_class((ObjectClass *)b);
+    g_autofree char *na = target_info_option_name(ta);
+    g_autofree char *nb = target_info_option_name(tb);
+
+    return strcmp(na, nb);
+}
+
+static void G_NORETURN target_info_list_and_exit(GSList *targets)
+{
+    printf("Supported targets:\n");
+    for (GSList *l = targets; l; l = l->next) {
+        const TargetInfo *ti = target_info_from_class(l->data);
+        g_autofree char *opt_name = target_info_option_name(ti);
+
+        printf("  %s%s\n", opt_name, ti->is_default ? " (default)" : "");
+    }
+    exit(0);
+}
+
+static const TargetInfo *target_info_find_default(GSList *targets,
+                                                  size_t *num_default)
+{
+    const TargetInfo *chosen = NULL;
+
+    *num_default = 0;
+    for (GSList *l = targets; l; l = l->next) {
+        const TargetInfo *ti = target_info_from_class(l->data);
+
+        if (ti->is_default) {
+            (*num_default)++;
+            chosen = ti;
+        }
+    }
+    return chosen;
+}
+
+static const TargetInfo *target_info_find_token(GSList *targets,
+                                                const char *token)
+{
+    for (GSList *l = targets; l; l = l->next) {
+        const TargetInfo *ti = target_info_from_class(l->data);
+        g_autofree char *opt_name = target_info_option_name(ti);
+
+        if (!strcmp(opt_name, token)) {
+            return ti;
+        }
+    }
+    return NULL;
+}
+
+static bool target_info_base_match_token(const char *base, const char *token)
+{
+    size_t nlen = strlen(token);
+    size_t blen;
+
+    if (!base || !token[0] || !g_str_has_suffix(base, token)) {
+        return false;
+    }
+    blen = strlen(base);
+    return blen == nlen || base[blen - nlen - 1] == '-';
+}
+
+static const TargetInfo *target_info_find_prgname(GSList *targets,
+                                                  const char *base)
+{
+    const TargetInfo *chosen = NULL;
+    size_t best_len = 0;
+
+    if (!base || !base[0]) {
+        return NULL;
+    }
+
+    for (GSList *l = targets; l; l = l->next) {
+        const TargetInfo *ti = target_info_from_class(l->data);
+        g_autofree char *opt_name = target_info_option_name(ti);
+        size_t nlen = strlen(opt_name);
+
+        if (nlen > best_len &&
+            target_info_base_match_token(base, opt_name)) {
+            chosen = ti;
+            best_len = nlen;
+        }
+    }
+    return chosen;
+}
+
+static const TargetInfo *target_info_from_prgname(GSList *targets)
+{
+    const char *prg = g_get_prgname();
+    g_autofree char *base = NULL;
+    char *dot;
+    const TargetInfo *chosen;
+
+    if (!prg || !prg[0]) {
+        return NULL;
+    }
+
+    base = g_path_get_basename(prg);
+    dot = strrchr(base, '.');
+    if (dot && g_ascii_strcasecmp(dot, ".exe") == 0) {
+        *dot = '\0';
+    }
+
+    chosen = target_info_find_prgname(targets, base);
+    if (!chosen && strlen(base) > 1 && g_str_has_suffix(base, "w")) {
+        base[strlen(base) - 1] = '\0';
+        chosen = target_info_find_prgname(targets, base);
+    }
+    return chosen;
+}
+
+void target_info_qom_set_target(const char *name)
 {
     g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
     const TargetInfo *chosen = NULL;
@@ -98,25 +231,37 @@ void target_info_qom_set_target(void)
         error_setg(&error_fatal, "no target-info is available");
     }
 
-    if (num_found == 1) {
-        target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
+    if (name && is_help_option(name)) {
+        targets = g_slist_sort_with_data(targets, target_info_token_name_cmp,
+                                         NULL);
+        target_info_list_and_exit(targets);
+    }
+
+    if (name && name[0]) {
+        chosen = target_info_find_token(targets, name);
+        if (!chosen) {
+            error_setg(&error_fatal, "unknown target '%s'", name);
+        }
+        target_info_ptr = chosen;
         return;
     }
 
-    for (GSList *l = targets; l; l = l->next) {
-        const TargetInfo *ti = TARGET_INFO_CLASS(l->data)->target_info;
+    chosen = target_info_from_prgname(targets);
+    if (chosen) {
+        target_info_ptr = chosen;
+        return;
+    }
 
-        if (ti->is_default) {
-            num_default++;
-            chosen = ti;
-        }
+    if (num_found == 1) {
+        target_info_ptr = target_info_from_class(targets->data);
+        return;
     }
 
+    chosen = target_info_find_default(targets, &num_default);
     if (num_default != 1) {
         error_setg(&error_fatal, num_default == 0 ?
                                  "no default target-info is available" :
-                                 "more than one default target-info "
-                                 "is available");
+                                 "multiple default targets; use -target");
     }
 
     target_info_ptr = chosen;
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index a3a131c80f8..489c7138bb9 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -174,7 +174,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     /* Initialize qgraph and modules */
     qos_graph_init();
     module_call_init(MODULE_INIT_TARGET_INFO);
-    target_info_qom_set_target();
+    target_info_qom_set_target(NULL);
     module_call_init(MODULE_INIT_FUZZ_TARGET);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_LIBQOS);
-- 
2.52.0.windows.1


