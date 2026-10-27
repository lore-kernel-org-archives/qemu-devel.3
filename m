Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A83606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jblSAMdv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLZvb-0002cU-86; Tue, 27 Oct 2026 01:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLZvU-0002aE-CU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:40:49 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLZvR-0004Q8-TJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:40:47 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-3550c917fd3so5615806eec.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 22:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793079644; x=1793684444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aQ2Puf1sOISM8sL6HalNkRqjVmy85f1gdvZmdOYkrIo=;
 b=jblSAMdv9FBrX5UGTrsK/o0o6BHbCmOZ1RMzflm/p/YWTQFz8q/FYaW4fpaerwPg/8
 H+53dCUiQuLOnDXE5n3di2LG9gbXvUhOGuWZ3IsWAwicgXZGmsOL+UQyRPqe8440xGf5
 3tLJZsOKmXqM0BvOXZiH9kTvJ9QBkqP57PgyLFEtYCXAIWhwPqypKPsBXp+7rdWm5UGU
 D47aj5JUgFDO6Wp1XyAHSrZKw9RkBq64uIkvUXCRVAmf632mxUwx1mE0f43iQ1MX3tQ9
 B5SzRN9oTCXzZpRBDmE7iz6FLCPSyFjZ1ewKopONPCmkvvpJm+spp76M/4Ut1DP//KId
 UvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793079644; x=1793684444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aQ2Puf1sOISM8sL6HalNkRqjVmy85f1gdvZmdOYkrIo=;
 b=ZRm1RBcW4i4Mr4uZ/mgdo/XMsEOZUatfTMVFakGWeIMCx1qM3DE3G/h4urIAs7YJ6z
 deLOH02aNLPleeK6Yk45E4vzXCR4+baQyqqZyKDJ7WHTcx/0LAIr+VUNQNvu08N2UZIj
 4bu7OLqHbv7DvElTHyZitdkT1r0GWEWdwity2n5CpzTEG6i1aCO94lEg2C1OPTLdRj3C
 iOppoig9MQbasJ04QyK0bo/6vn/We2eW2fo3fE6Gyu5eT+osVvj7ELXouqWLcwxJeBa0
 pzkREwi9yJ+9sVVHpXxXFz/LYYJR/rwWx8fnyDJVjSbw1EPDhjdlWtrFwvXhWYc6uJMH
 PKYA==
X-Gm-Message-State: AFq9FYLs+xnF1GspmuoICPuqf8imgAKgjdAmfP2lRjrI/3OUhEaU/uLd
 zNAbADtH9MjY9avLjepIG4UnVD1yOL5RkFJRu/V5Xtg/dd3fnC4LtRaxTSOIN1IW
X-Gm-Gg: AYBFou0Kd7Fw5UkNclQGsFtw8kgby5vevrdRbMQDC3PXQ9O60NvHq6I9HYuRjcX7OFv
 SwYBCz+QuWudAlWL3S8s/wJIRWlANqzFtRLC3+jzrgvdfqeiqj7pdoAeio1N8ltcrtu7VBGF7uE
 hQjsIVfnlJ/y4c8AeIIIXaXRRrCi0WqEIysL6ErLQOJ71MuJZ9J1hbFkdCbnbTuHJmSsl77Sqxe
 qfiL24+P6KgcE8UHI2vTZ+snj2Z9liOSFSXCpC2TZvnmLX96LnQZ4SwtrG0oMewXx+AJQQyaeWS
 CDf4XVrsZbxuoMCzFm01xUCdmyOOvFq195/IDBMmOHTHJP2d0l+lRp3UDQdHO6xSdzyRuDL2aio
 egYWnqvFDuCkfOWfcltRldisG+PKPifJ8hb1LI7N0qosmN4INDX3zA5PnumRh8McW939aYdYE1e
 JHyMCBwlQZhDONEE//LoMGeaV0UE8gWMcw/5NPfHOe6Vkfe9cq9FlBKGLEDIxOFEaeYRUjNzqaj
 EBQtlUKhGJR3EYJ7IH2AIjxftXFY7Z+VzgbSJvbpTYKZpoSvmqxszKRybCUeDYK5Po4y2vsmQ29
 hqeJZt2JFrTUTff+YYE6
X-Received: by 2002:a05:7301:1509:b0:36a:270:ce76 with SMTP id
 5a478bee46e88-36a0270d1acmr6050803eec.33.1793079644275; 
 Mon, 26 Oct 2026 22:40:44 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-369e8ec9276sm51416372eec.25.2026.10.26.22.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 22:40:43 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 2/2] accel: register CPU parent for each target
Date: Tue, 27 Oct 2026 13:40:26 +0800
Message-ID: <20261027054026.2184-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261027054026.2184-1-luoyonggang@gmail.com>
References: <20261027054026.2184-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1336.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now we need use the prepared target-list to register different accel-$cpu_type
parent QOM type. So that multi-target won't error missing parent for different
accel for different arch.

Also add a test for it in test-multi-target.c

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/accel-common.c           |  6 ++----
 accel/accel-internal.h         |  1 +
 accel/accel-system.c           | 24 ++++++++++++++++++++++++
 accel/accel-user.c             |  7 +++++++
 tests/unit/test-multi-target.c | 15 +++++++++++++++
 5 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 00a400243f0..0f4e202d8f8 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -130,9 +130,9 @@ static const TypeInfo accel_types[] = {
 
 DEFINE_TYPES(accel_types)
 
-static void register_accel_target_type(void)
+void accel_register_cpu_type(const char *cpu_type)
 {
-    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
+    g_autofree char *name = g_strconcat("accel-", cpu_type, NULL);
     const TypeInfo accel_cpu_type = {
         .name = name,
         .parent = TYPE_OBJECT,
@@ -142,5 +142,3 @@ static void register_accel_target_type(void)
 
     type_register_static(&accel_cpu_type);
 }
-
-type_init(register_accel_target_type);
diff --git a/accel/accel-internal.h b/accel/accel-internal.h
index d3a4422cbf7..2b6f58526d3 100644
--- a/accel/accel-internal.h
+++ b/accel/accel-internal.h
@@ -13,5 +13,6 @@
 #include "qemu/accel.h"
 
 void accel_init_ops_interfaces(AccelClass *ac);
+void accel_register_cpu_type(const char *cpu_type);
 
 #endif /* ACCEL_SYSTEM_H */
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 1325b23864c..fdfa85179ee 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -25,6 +25,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qemu/target-info-def.h"
+#include "qemu/target-info-qom.h"
 #include "qom/compat-properties.h"
 #include "qapi/qapi-commands-accelerator.h"
 #include "monitor/monitor.h"
@@ -32,6 +34,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
 #include "accel/accel-ops.h"
+#include "accel/accel-cpu.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "qemu/error-report.h"
@@ -124,6 +127,27 @@ static const TypeInfo accel_ops_type_info = {
 
 static void accel_system_register_types(void)
 {
+    GSList *targets = target_info_qom_get_targets();
+    const TargetInfo *ti, *prev_ti;
+
     type_register_static(&accel_ops_type_info);
+
+    for (GSList *l = targets; l; l = l->next) {
+        bool duplicate = false;
+
+        ti = TARGET_INFO_CLASS(l->data)->target_info;
+        for (GSList *prev = targets; prev != l; prev = prev->next) {
+            prev_ti = TARGET_INFO_CLASS(prev->data)->target_info;
+            if (g_str_equal(prev_ti->cpu_type, ti->cpu_type)) {
+                duplicate = true;
+                break;
+            }
+        }
+        if (duplicate) {
+            continue;
+        }
+
+        accel_register_cpu_type(ti->cpu_type);
+    }
 }
 type_init(accel_system_register_types);
diff --git a/accel/accel-user.c b/accel/accel-user.c
index 7d192306a65..85ede70e5bd 100644
--- a/accel/accel-user.c
+++ b/accel/accel-user.c
@@ -9,8 +9,15 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qemu/target-info.h"
 #include "accel-internal.h"
 
+static void register_accel_target_type(void)
+{
+    accel_register_cpu_type(target_cpu_type());
+}
+type_init(register_accel_target_type);
+
 void accel_init_ops_interfaces(AccelClass *ac)
 {
     /* nothing */
diff --git a/tests/unit/test-multi-target.c b/tests/unit/test-multi-target.c
index a91fe8e6d07..9ace553ca05 100644
--- a/tests/unit/test-multi-target.c
+++ b/tests/unit/test-multi-target.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info-qom.h"
 #include "qom/object.h"
 
@@ -41,6 +42,18 @@ static void test_qom_types_are_unique(void)
     g_assert_true(targets == target_info_qom_get_targets());
 }
 
+static void test_accel_cpu_parent_per_target(void)
+{
+    g_assert(targets);
+
+    for (GSList *l = targets; l; l = l->next) {
+        const TargetInfo *ti = TARGET_INFO_CLASS(l->data)->target_info;
+        g_autofree char *name = g_strconcat("accel-", ti->cpu_type, NULL);
+
+        g_assert_nonnull(object_class_by_name(name));
+    }
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -55,5 +68,7 @@ int main(int argc, char **argv)
 
     g_test_add_func("/multi-targets/qom-types-are-unique",
                    test_qom_types_are_unique);
+    g_test_add_func("/multi-targets/accel-cpu-parent-per-target",
+                    test_accel_cpu_parent_per_target);
     return g_test_run();
 }
-- 
2.55.0.windows.3


