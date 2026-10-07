Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C28CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQDQ-00005z-Um; Wed, 07 Oct 2026 07:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEQDJ-00005Z-7P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:53:37 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEQDG-0007yt-KW
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:53:36 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so2604603c88.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791374013; x=1791978813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FWRVQ3jBfSGZKPdb9DGRc2T/uyHns9MeYc28joKvsbY=;
 b=Ug9uS1Zl11pSjsNu6QXxzVOTwumvnMX29RT5LT8mba2w9uYKD41roVKMfn2RphF794
 93S9PTkKPmREMbYSjfjLXsXuvg30MdNSMQW/N6+wRZLiMwIQxO+4sGag6kHQOh/KWN5e
 UkrRXbiR9oVcaHbzOrPI5DLxnjdNDHiB4oMURnxmzcUX6JkCHJ18nx6bQhtGIdIXqx5g
 /ZKK6KmOJhXkUmiOhfzMc3JUgUs91+aaDiECfvsKDGiUSJTC9WnHnreWjNxHN2eaTiGu
 7kFVwZttWUPtzcyPisP99TuTo9w7lAEMvV/Fp48KIraOkQ4/Z2EuO7nQSvahKdIAyht/
 xiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791374013; x=1791978813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FWRVQ3jBfSGZKPdb9DGRc2T/uyHns9MeYc28joKvsbY=;
 b=sAxiovUoFfT+MZVxa3o3M1yqUXT01fLa4+VncmdZQZzev6n9HUadNgy7Ptsg9FfW8C
 WWqfbrDeOcb7eY//mf+/c0JDmoDK4uaRVOiwdx98pOtLAlUbu8LS4Qy9+ffZl2bE3TOs
 jI6LHqqY1+SnwvJB6kKZ6Igx9PFxSAg8sq2bTIreWW6814xKDNuYKVXkNxy6syQZjhv2
 wUqb1yq7pXOc6FXH8uUbU1i19ZJPn5hAc3B+p0DaDApgNGXH/c17kaoiqkA0ikBD4bI1
 y6y0rkQmfkUGhaYWSkID2oVtAQ3xrEKkNSfq4u11zW6t6ayPLjXSiReQORdQ5MenkFwD
 lB5w==
X-Gm-Message-State: AFuF++n0+gdL2zfvQ3ABMKXxVuDPPAA5jBDpApWc8fh8sjWKzWAHjL7J
 /0tpWnPvAXYHKzcpwlaMtkfBKLLctJrbmP8q4XVZFOlKjdjCoOrnR2AAARPFInZq
X-Gm-Gg: AYBFou265otWV6jlj+ba1vYwF+HVXroWxQ1LMas/MtrG70+jTPgFqP0IKe1WyULGSdD
 uxr0JCba0LnWcwy+FAds7RM6AH5/Q1JR6kfN066kkYw8iD8zXaGezr1rabOb0pPQc0+PMrgRM/H
 Na7PmlGO+5HpdbNMuEp8T8tJZN43im6WuZf7jRWqa5J8BtAXvByH+fFgKCzyOAbBzseS5uB82fs
 YGqKic898BFgqRzfNuVcRmR+KdkrjuUR/VbOsVg27ZL00N6iP+W5U0wSnh0ZCeixDFiF+YsgeNr
 p+kGp23RMX90vT4LnoqIIw8THJ45Bro8r8yq3fVC1odAninpgKfk75aaFtn05YKjo81OM4ICZi9
 YC/kOgpCnrlU0wg8JghQ4b6i+6ywrpQccY0+TVX2ICXEgfpeWpljBUnVbZEO0xdyxiXH70nu0yI
 FW0nPbIW9LfcjDFwSkwODopGInaFFpSE/77fZhLVklJ/47T42g2fBiIe7EOK0ng81sZ+Y7q0/fG
 bOSKMzM/CQhoe0IDg==
X-Received: by 2002:a05:701b:42c7:10b0:144:eaa7:2763 with SMTP id
 a92af1059eb24-16205514412mr2134967c88.16.1791374012942; 
 Wed, 07 Oct 2026 04:53:32 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1616980c3b7sm6429520c88.16.2026.10.07.04.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 04:53:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH 4/8] target-info: replace QOM registration with a constructor
 list
Date: Wed,  7 Oct 2026 19:48:01 +0800
Message-ID: <20261007115253.328-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261007115253.328-1-luoyonggang@gmail.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122b.google.com
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

Register target definitions through constructors instead of
MODULE_INIT_TARGET_INFO, making target_info_list() and target_info()
available on entry to main(), without explicit initialization or a
call to module_call_init(MODULE_INIT_QOM).

Keep the target list sorted by target_arch and default to its first
entry. Provide an unknown TargetInfo fallback for target-independent
tools such as qemu-img and unit tests that link no target-info-def.c
objects.

Remove the obsolete QOM target-info registration infrastructure and
update the multi-target test to inspect target information before
initializing QOM.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/module.h           |  1 -
 include/qemu/target-info-def.h  | 56 +++++++++++++++++++++++++++---
 include/qemu/target-info-init.h | 53 ----------------------------
 include/qemu/target-info-qom.h  | 31 -----------------
 include/qemu/target-info.h      |  9 +++++
 meson.build                     |  6 ++--
 system/vl.c                     |  4 ---
 target-info-def.c               |  1 -
 target-info-qom.c               | 60 --------------------------------
 target-info.c                   | 61 ++++++++++++++++++++++++++++++++-
 tests/qtest/fuzz/fuzz.c         |  3 --
 tests/unit/test-multi-target.c  | 12 +++----
 12 files changed, 129 insertions(+), 168 deletions(-)
 delete mode 100644 include/qemu/target-info-init.h
 delete mode 100644 include/qemu/target-info-qom.h
 delete mode 100644 target-info-qom.c

diff --git a/include/qemu/module.h b/include/qemu/module.h
index fccf017bf9e..9885ac9afb3 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -43,7 +43,6 @@ typedef enum {
     MODULE_INIT_MIGRATION,
     MODULE_INIT_BLOCK,
     MODULE_INIT_OPTS,
-    MODULE_INIT_TARGET_INFO,
     MODULE_INIT_QOM,
     MODULE_INIT_TRACE,
     MODULE_INIT_XEN_BACKEND,
diff --git a/include/qemu/target-info-def.h b/include/qemu/target-info-def.h
index 8019d2c7196..080e30a5b0e 100644
--- a/include/qemu/target-info-def.h
+++ b/include/qemu/target-info-def.h
@@ -11,8 +11,10 @@
 
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
+#include "qemu/queue.h"
+#include "qemu/target-info.h"
 
-typedef struct TargetInfo {
+struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *target_name;
     /* related to TARGET_ARCH definition */
@@ -30,13 +32,57 @@ typedef struct TargetInfo {
     unsigned page_bits_init;
     /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
     bool page_bits_vary;
-} TargetInfo;
+};
+
+typedef struct TargetInfoNode TargetInfoNode;
+typedef QLIST_HEAD(, TargetInfoNode) TargetInfoList;
+
+struct TargetInfoNode {
+    const TargetInfo *info;
+    QLIST_ENTRY(TargetInfoNode) next;
+};
+
+/**
+ * target_info_list:
+ *
+ * TargetInfo is a static list, not a QOM type. Constructors insert
+ * entries before main(), so type_init can use it.
+ *
+ * Returns: registered TargetInfoNode list head, sorted by
+ *          info->target_arch. The list is owned by target-info
+ *          and must not be modified. Iterate with
+ *          QLIST_FOREACH(..., next) and use node->info.
+ */
+const TargetInfoList *target_info_list(void);
 
 /**
- * target_info:
+ * target_info_select:
+ * @ti: TargetInfo to make current
  *
- * Returns: The TargetInfo structure definition for this target binary.
+ * Sets target_info() to @ti.
+ */
+void target_info_select(const TargetInfo *ti);
+
+/**
+ * target_info_list_add:
+ * @node: static TargetInfoNode whose info points at a const TargetInfo
+ *
+ * Inserts @node into target_info_list(), sorted by info->target_arch.
+ * Sets target_info() to the first list entry.
+ */
+void target_info_list_add(TargetInfoNode *node);
+
+/*
+ * Register @ti before main(). Linked into the executable, not a DSO.
+ * @ti is a unique identifier in this translation unit.
  */
-const TargetInfo *target_info(void);
+#define target_info_init(ti)                                            \
+    static TargetInfoNode ti##_node = {                                 \
+        .info = &(ti),                                                  \
+    };                                                                  \
+    static void __attribute__((constructor)) do_qemu_init_##ti(void)    \
+    {                                                                   \
+        target_info_list_add(&ti##_node);                               \
+    }
 
 #endif
diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
deleted file mode 100644
index b7024c9faef..00000000000
--- a/include/qemu/target-info-init.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * QEMU target info initialization
- *
- * Copyright (c) Qualcomm
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- *
- * This file is included by each file defining a TargetInfo structure and is
- * responsible for registering it.
- */
-
-#ifndef QEMU_TARGET_INFO_INIT_H
-#define QEMU_TARGET_INFO_INIT_H
-
-#define DEFINE_TARGET_INFO_TYPE(info)                                       \
-static void do_qemu_init_target_info(void)                                  \
-{                                                                           \
-    type_register_static(&info);                                            \
-}                                                                           \
-module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
-
-#ifdef COMPILING_PER_TARGET
-#ifdef CONFIG_USER_ONLY
-
-/*
- * User mode does not support multiple targets in the same binary, so just
- * define target_info().
- */
-#define target_info_init(ti_var)        \
-const TargetInfo *target_info(void)     \
-{                                       \
-    return &ti_var;                     \
-}
-
-#else /* CONFIG_USER_ONLY */
-
-#include "qemu/target-info-qom.h"
-#include "qom/object.h"
-
-#define target_info_init(ti_var)                                            \
-static const TypeInfo target_info_qom_target_type_info = {                  \
-    .name =  TYPE_TARGET_INFO"-"TARGET_NAME,                                \
-    .parent = TYPE_TARGET_INFO,                                             \
-    .instance_size = sizeof(TargetInfoQom),                                 \
-    .class_size = sizeof(TargetInfoQomClass),                               \
-    .class_data = &ti_var,                                                  \
-};                                                                          \
-DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
-
-#endif /* CONFIG_USER_ONLY */
-#endif /* COMPILING_PER_TARGET */
-
-#endif /* QEMU_TARGET_INFO_INIT_H */
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
deleted file mode 100644
index ba2e4370afb..00000000000
--- a/include/qemu/target-info-qom.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * QEMU target info QOM types
- *
- * Copyright (c) Qualcomm
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef QEMU_TARGET_INFO_QOM_H
-#define QEMU_TARGET_INFO_QOM_H
-
-#include "qemu/target-info-def.h"
-#include "qom/object.h"
-
-#define TYPE_TARGET_INFO "target-info"
-
-typedef struct TargetInfoQom {
-    Object parent_obj;
-} TargetInfoQom;
-
-typedef struct TargetInfoQomClass {
-    ObjectClass parent_class;
-    const TargetInfo *target_info;
-} TargetInfoQomClass;
-
-OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
-
-void target_info_qom_set_target(void);
-void target_info_qom_set_target_info(const TargetInfo *ti);
-
-#endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index adda363ac39..d1928cecf84 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -9,6 +9,15 @@
 #ifndef QEMU_TARGET_INFO_H
 #define QEMU_TARGET_INFO_H
 
+typedef struct TargetInfo TargetInfo;
+
+/**
+ * target_info:
+ *
+ * Returns: The TargetInfo structure definition for the selected target.
+ */
+const TargetInfo *target_info(void);
+
 /**
  * target_name:
  *
diff --git a/meson.build b/meson.build
index ac78c58cb91..4097784e7a2 100644
--- a/meson.build
+++ b/meson.build
@@ -3777,6 +3777,9 @@ if enable_modules
   modulecommon = declare_dependency(objects: libmodulecommon.extract_all_objects(recursive: false), compile_args: '-DBUILD_DSO')
 endif
 
+qom_ss.add(files(
+  'target-info.c',
+))
 qom_ss = qom_ss.apply({})
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
@@ -3869,9 +3872,6 @@ endif
 common_ss.add(pagevary)
 system_ss.add(files('page-vary-system.c'))
 
-common_ss.add(files('target-info.c'))
-system_ss.add(files('target-info-qom.c'))
-
 if 'CONFIG_TCG' in config_all_accel
   subdir('contrib/plugins')
 endif
diff --git a/system/vl.c b/system/vl.c
index 468a9fc247a..2c50aa01a2e 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -28,7 +28,6 @@
 #include "qemu/units.h"
 #include "qemu/module.h"
 #include "qemu/target-info.h"
-#include "qemu/target-info-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/core/qdev-properties.h"
@@ -2914,9 +2913,6 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
-    module_call_init(MODULE_INIT_TARGET_INFO);
-    target_info_qom_set_target();
-
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
 
diff --git a/target-info-def.c b/target-info-def.c
index fa19cabc55f..3041d64ccd2 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-def.h"
-#include "qemu/target-info-init.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
 #include "exec/cpu-defs.h"
diff --git a/target-info-qom.c b/target-info-qom.c
deleted file mode 100644
index aeeedb7e818..00000000000
--- a/target-info-qom.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * QEMU binary/target API (QOM types)
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qom/object.h"
-#include "qemu/target-info-def.h"
-#include "qemu/target-info-init.h"
-#include "qemu/target-info-qom.h"
-
-static void target_info_qom_class_init(ObjectClass *oc, const void * data)
-{
-    TargetInfoQomClass *klass = TARGET_INFO_CLASS(oc);
-    klass->target_info = data;
-}
-
-static const TypeInfo target_info_parent_type = {
-    .name = TYPE_TARGET_INFO,
-    .parent = TYPE_OBJECT,
-    .instance_size = sizeof(TargetInfoQom),
-    .class_size = sizeof(TargetInfoQomClass),
-    /* use class_base_init so children classes can set class_data accordingly */
-    .class_base_init = target_info_qom_class_init,
-    /* children classes will be concrete, which allows to easily query them
-     * without listing this parent class also */
-    .abstract = true,
-};
-
-DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
-
-static const TargetInfo *target_info_ptr;
-
-const TargetInfo *target_info(void)
-{
-    return target_info_ptr;
-}
-
-void target_info_qom_set_target(void)
-{
-    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
-
-    size_t num_found = g_slist_length(targets);
-    if (num_found != 1) {
-        error_setg(&error_fatal, num_found == 0 ?
-                                 "no target-info is available" :
-                                 "more than one target-info is available");
-    }
-
-    target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
-}
-
-void target_info_qom_set_target_info(const TargetInfo *ti)
-{
-    target_info_ptr = ti;
-}
diff --git a/target-info.c b/target-info.c
index 6b365113955..8ccb333e365 100644
--- a/target-info.c
+++ b/target-info.c
@@ -10,7 +10,66 @@
 #include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
 #include "qemu/target-info-def.h"
-#include "qapi/error.h"
+#include "exec/page-vary.h"
+
+/*
+ * Tools such as qemu-img and unit tests may link target-info.c without any
+ * target-info-def.c objects. Their target list remains empty, so use this
+ * fallback.
+ */
+static const TargetInfo target_info_default = {
+    .target_arch = SYS_EMU_TARGET__MAX,
+    .target_name = "unknown",
+    .long_bits = 64,
+    .endianness = ENDIAN_MODE_LITTLE,
+    .page_bits_init = TARGET_PAGE_BITS_MIN,
+};
+
+static const TargetInfo *target_info_ptr = &target_info_default;
+static TargetInfoList target_infos = QLIST_HEAD_INITIALIZER(target_infos);
+
+const TargetInfo *target_info(void)
+{
+    g_assert(target_info_ptr != NULL);
+    return target_info_ptr;
+}
+
+const TargetInfoList *target_info_list(void)
+{
+    return &target_infos;
+}
+
+void target_info_select(const TargetInfo *ti)
+{
+    g_assert(ti != NULL);
+    target_info_ptr = ti;
+}
+
+void target_info_list_add(TargetInfoNode *node)
+{
+    const TargetInfo *info;
+    TargetInfoNode *cur, *prev = NULL;
+
+    g_assert(node && node->info);
+    info = node->info;
+    QLIST_FOREACH(cur, &target_infos, next) {
+        if (info->target_arch < cur->info->target_arch) {
+            QLIST_INSERT_BEFORE(cur, node, next);
+            break;
+        }
+        prev = cur;
+    }
+    if (!cur) {
+        if (prev) {
+            QLIST_INSERT_AFTER(prev, node, next);
+        } else {
+            QLIST_INSERT_HEAD(&target_infos, node, next);
+        }
+    }
+
+    /* Default to the first entry in the target_arch-sorted list. */
+    target_info_select(QLIST_FIRST(&target_infos)->info);
+}
 
 const char *target_name(void)
 {
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index a3a131c80f8..d2355989616 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -22,7 +22,6 @@
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/rcu.h"
-#include "qemu/target-info-qom.h"
 #include "tests/qtest/libqtest.h"
 #include "tests/qtest/libqos/qgraph.h"
 #include "fuzz.h"
@@ -173,8 +172,6 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 
     /* Initialize qgraph and modules */
     qos_graph_init();
-    module_call_init(MODULE_INIT_TARGET_INFO);
-    target_info_qom_set_target();
     module_call_init(MODULE_INIT_FUZZ_TARGET);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_LIBQOS);
diff --git a/tests/unit/test-multi-target.c b/tests/unit/test-multi-target.c
index 89b55bb1632..150254a3ba3 100644
--- a/tests/unit/test-multi-target.c
+++ b/tests/unit/test-multi-target.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/target-info.h"
-#include "qemu/target-info-qom.h"
+#include "qemu/target-info-def.h"
 #include "qom/object.h"
 
 #ifdef CONFIG_SDL
@@ -32,11 +32,11 @@ int (*qemu_main)(void);
 
 static void test_qom_types_are_unique(void)
 {
-    module_call_init(MODULE_INIT_TARGET_INFO);
-    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
-    g_assert(targets);
-    const TargetInfo *first_ti = TARGET_INFO_CLASS(targets->data)->target_info;
-    target_info_qom_set_target_info(first_ti);
+    const TargetInfoList *targets = target_info_list();
+
+    g_assert_nonnull(QLIST_FIRST(targets));
+
+    g_assert_nonnull(target_info());
 
     /* register all types */
     module_call_init(MODULE_INIT_QOM);
-- 
2.55.0.windows.3


