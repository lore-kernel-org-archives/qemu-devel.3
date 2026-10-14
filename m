Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C51CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvMj-0003nZ-Tj; Wed, 14 Oct 2026 05:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvMh-0003g7-HI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:33:39 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvMf-0000Vs-8N
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:33:39 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-141395927feso7368357c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970416; x=1792575216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jFyMk/+YVZ0ocRUJE83NYvrijKAU06rfQuE3NqKtQGU=;
 b=Ni8RjBmr52RFhyLabbbmCE1son+i76vE44F6NJULjxREeOuYA+l6rUU2aMf/ByU1lr
 +Owg4KCQOE7JIAdkyqEJ1xOUA/3iE4xQGeAJzm60FpvWVjY68dHN3rYZmzAl68F9ocbx
 /pyjugTQk8acLvt4OREP+dc9gs7aNGi172zq3Q+rdheS66KlRTlHiNArCYQmHQa+Q5Ry
 QaaY5XZtf4uyXuUu6rIs1TF2I4JSoawIMfc6AGs7GiX528Jf2qh6ohOIviktpsJw6RDk
 YT40stw3UEGrgZfQteVmFRBEHeZXMPq0EAP+WiLCIcGmW7oW6wwqWdwT4CVsNQxEDXBF
 D1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970416; x=1792575216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jFyMk/+YVZ0ocRUJE83NYvrijKAU06rfQuE3NqKtQGU=;
 b=v+WEXRmZVSKYUyuyu8BOl62r8fB3JXlAwvZXY/ABtTTCPFZzZo1ekMZmjjNL15Ow64
 650QfQLYYo0LpLTTJqOk9W6YB9hjY0e6W0S+PQpIew5aQRmNFs93BrauIU2B1wrBOOjF
 9q5OEEPe62EoBlVFiloVM37cZbQElrWoJC1E8BXXrazriuVIN3LRGP0m1j30/JZedPOr
 p3KA1snGXghh1fJsJWNL9aPv+P8UWtUpXDlyv8idAxkqrhVsvBUGFU0rMZb04xEvyflN
 n3uGt1DepiLhPIPB2zGcjjuusjaCHuctgKI+D3odV68V1xC4bMZhrLWEKdI5CQPkvASv
 2cfQ==
X-Gm-Message-State: AFq9FYLfuoUfDUALPcbHTAt/aZWDZgFRFjPV8whns2geQ9yBhyb5pTMk
 WTiwYutMrRGU0I+5hF4DrotI/dFBu2G7dS8Ys0qT6oc2Jp5Ct9G5wp6mBDN9LzUNy0Y=
X-Gm-Gg: AYBFou0PUMaUZBg/s0i4nNPEo/dv58LGyRrBmgIHvfSLMKOUQuvJt1TYC0KB//91wQp
 7i3nJcl8FVgIJIju6NvTTA0VPRhz6il7hYpJZLj6sUsFhso6GOqwYMIh2mjzosr3R28jYvjqAHQ
 /hlC0VJSRtkHAjPKpxPr96tcK1w0JoxMVhMVDSIbtabSa1sDgEsYPpbVlUYhkeUU3jARw3Iy3tv
 lKvkqs/nN5GRJ7LsuCaXLy3QGS5MMKG2/n0VYOvBGPO2xze1WtmiItv/9MwLfl89JvHZe/otj42
 y611u13zb3pAoTvEoq2zWohtQGYShWfoTzpgpMoZfTzmXi9BJFRaNMIMuxK695dExsZd44G6/cr
 ibaVH6/r5qtbtuToBSXKhbufUDd9225cQjXHQ7moDt2PsUi4492EL4iSn4t/1eT5XPXhvfQHdjA
 YBM64LCrYy61+GWuXKq+8zwGvr4z3V+Z0SIZskxrwBJPDQtLvJqGtiITvWzNG6KJTX0DaMZKjD7
 kxqXXZPIOJroFsOCA==
X-Received: by 2002:a05:701b:2803:b0:16a:b995:dc7c with SMTP id
 a92af1059eb24-16ab995dd20mr21112448c88.21.1791970415751; 
 Wed, 14 Oct 2026 02:33:35 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:33:34 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 09/34] accel: register CPU parent for each target
Date: Wed, 14 Oct 2026 17:31:19 +0800
Message-ID: <20261014093152.834-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1231.google.com
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
index c2922e0fed5..704e3297ef9 100644
--- a/tests/unit/test-multi-target.c
+++ b/tests/unit/test-multi-target.c
@@ -17,6 +17,7 @@
 #include "qemu/base-arch-defs.h"
 #include "qemu/module.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info-qom.h"
 #include "qom/object.h"
 
@@ -70,6 +71,18 @@ static void test_machine_targets(void)
     }
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
@@ -86,5 +99,7 @@ int main(int argc, char **argv)
                     test_qom_types_are_unique);
     g_test_add_func("/multi-targets/machine-targets",
                     test_machine_targets);
+    g_test_add_func("/multi-targets/accel-cpu-parent-per-target",
+                    test_accel_cpu_parent_per_target);
     return g_test_run();
 }
-- 
2.55.0.windows.3


