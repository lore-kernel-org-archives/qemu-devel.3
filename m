Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC3606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wzx8DG+I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLxBr-0001GK-J2; Wed, 28 Oct 2026 02:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLxBh-0001EY-UD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:31:06 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLxBf-0004ps-W1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:31:05 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1931ff67a29so1581453c88.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793169062; x=1793773862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9wBsuhzBS1+hdqxSnx58WpDiwWoNuTMy5FSLro+Gmf4=;
 b=Wzx8DG+IyournoVbRwKbRQXoqTziD3B+eOVbn8tK96JHZvRyGk4ZHguO0exbpLs6sL
 pqghYP4QhLRzpclRyAEEA3+bBXeh6WRbXapP6cx9bAswwKLqLcKXqfqI2gHhgWgGL+/x
 opF+B+GynVM0FspkPp2Pzc+ginPGf6KjTjg5V8yAcvfNmIhNVhh8/cxKTuY48fmMQfDD
 XetYiFDWDNmBBOOnellwd0qgt1TAOnibpRQmn7nwla411pnnwCY18o9R4YpUHLX41EWE
 vYIARKKF++oXgfbStQklSJX0nMja2dQOL/VFoHzRCtpPh85/tR0VwKOuZjj8e+taDDTC
 MGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793169062; x=1793773862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9wBsuhzBS1+hdqxSnx58WpDiwWoNuTMy5FSLro+Gmf4=;
 b=E0flVUS0KBsABNZYrxvIdhlCTM9Naz8lZO3nFymtytBwHuIQw7jS7hkyi49NFnNYEC
 KBXZ2vIuEg06e05gXG872Mq4PKGKkVEKsb3psLUNjVB0z8fm2u9Dp2b7rd5xomAiT4nM
 RLVWwof0RrpDp0QZKlSkKVblaP53pJjqlfQt8yMkhxcdusc3kab42n2hRWUSD8kxRd0v
 q0kxV8M1k5ov8mtGA9Q86C5wEhwG6o4c8tjQ/yfrbw3PpPzTkgeoxOZh97AcJi3wXX1X
 2kVtRZ8YS+Io5fAJYS/C+Mg0rwsjSgT4mG/FZ2oZM6Xo7tHfYhukA0ktJSFFctHASUCu
 Pthw==
X-Gm-Message-State: AFq9FYIDpF7RfQuyjk5lAi4EUmNb0vmJgmo5N8u+HCoTmhKD7Dh7uvw9
 W1JOxIqdnX3LHp/GhjRtRQX5qLVMgJw1TVkCYM+w9XvnWq3C8AygMGz96103uGAf
X-Gm-Gg: AYBFou1Z4lM1IWlTMcy8+Zl0GzxZDsczTlFGaoUG8XJ08MvIlnzz2YzKVcGDintOFSk
 G+ZFg8axGup9+7SNh8WalRr63GUHgrHHVV9auf6Hym0xSzPhxmDseAJdNAbJ9Ued6TSUYWAoeMD
 hd2Lvwj/UqjFwiIpcu9oTF2pQBqsLW01jK6S5mgmBcTjs/yxww5Y/cSvSYmupRGUkn++lmvSQ2B
 GHrNhqCEk5uDTfKO+3YweL9Qu+akqGdKLaZis/7mcWuMNALYtfycnzhLZWkRTQizXeFjrJNUlKS
 yBdnKzEFN8duBADUZeWJVkoBVdvRGulhpTmBLoX76/DKgPCvPzazs+PKnaMr+mpHcZCHVFi9Q2+
 Q2N3PFxP1EAgbstMAPVrInd8LHkAmDVd0sRiKaJsqIlS5I+B6iUPOFkIsPkkNPyAIVgVwt24mc1
 eSJxLJ7YfCYhGOGUaDngMLZCu3e25mRwyG5oxfFEXl1FcpPjEMTdRWw8IE9ioVrkwt5m1IXuZDU
 tf/KdOY9oNYm2HYnPa/AQUCNFbqqR8r1gbRJRnTyuWNwXVZubGAXwbBc9NsYoUwtqResADSdg5z
 RvCFXhzHGD4Ud1eu3DkwyoPSQqK1+O4XzbVNnY8QU+bZL8srFA==
X-Received: by 2002:a05:701b:4511:20b0:149:1feb:6d9d with SMTP id
 a92af1059eb24-1a6cc819e39mr2147654c88.19.1793169062293; 
 Tue, 27 Oct 2026 23:31:02 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1a75e5c6d4fsm4512584c88.14.2026.10.27.23.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 23:31:01 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Weiwei Li <liwei1518@gmail.com>
Subject: [PATCH v2 1/3] accel: register CPU parent for each target
Date: Wed, 28 Oct 2026 14:30:46 +0800
Message-ID: <20261028063049.2530-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028063049.2530-1-luoyonggang@gmail.com>
References: <20261028063049.2530-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122d.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A multi-target binary registers one accel-$cpu_type parent per linked
target. accel-target.c is compiled once per target and calls
accel_register_cpu_type() with that target's target_arch and
CPU_RESOLVING_TYPE. A bool array keyed by SysEmuTarget records which
arch already registered. Targets that share one CPU_RESOLVING_TYPE
reuse the parent from the earlier arch.

test-multi-target checks that each target's accel parent exists after
QOM init.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/accel-common.c           | 31 ++++++++++++++++++++++++++++---
 accel/accel-internal.h         |  2 ++
 accel/accel-target.c           | 21 +++++++++++++++++++++
 accel/meson.build              |  1 +
 tests/unit/test-multi-target.c | 22 ++++++++++++++++++++++
 5 files changed, 74 insertions(+), 3 deletions(-)
 create mode 100644 accel/accel-target.c

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 00a400243f0..0d04b8c5749 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -130,9 +130,9 @@ static const TypeInfo accel_types[] = {
 
 DEFINE_TYPES(accel_types)
 
-static void register_accel_target_type(void)
+static void register_accel_target_type(const char *cpu_type)
 {
-    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
+    g_autofree char *name = g_strconcat("accel-", cpu_type, NULL);
     const TypeInfo accel_cpu_type = {
         .name = name,
         .parent = TYPE_OBJECT,
@@ -143,4 +143,29 @@ static void register_accel_target_type(void)
     type_register_static(&accel_cpu_type);
 }
 
-type_init(register_accel_target_type);
+void accel_register_cpu_type(SysEmuTarget arch, const char *cpu_type)
+{
+    static bool accel_cpu_registered[SYS_EMU_TARGET__MAX];
+    static const char *accel_cpu_types[SYS_EMU_TARGET__MAX];
+
+    if (accel_cpu_registered[arch]) {
+        return;
+    }
+
+    /*
+     * Keyed by target_arch. Targets that share CPU_RESOLVING_TYPE already
+     * have a parent from an earlier target_arch.
+     */
+    for (int i = 0; i < SYS_EMU_TARGET__MAX; i++) {
+        if (accel_cpu_registered[i] &&
+            g_str_equal(accel_cpu_types[i], cpu_type)) {
+            accel_cpu_registered[arch] = true;
+            accel_cpu_types[arch] = cpu_type;
+            return;
+        }
+    }
+
+    accel_cpu_registered[arch] = true;
+    accel_cpu_types[arch] = cpu_type;
+    register_accel_target_type(cpu_type);
+}
diff --git a/accel/accel-internal.h b/accel/accel-internal.h
index d3a4422cbf7..736b07c5f08 100644
--- a/accel/accel-internal.h
+++ b/accel/accel-internal.h
@@ -11,7 +11,9 @@
 #define ACCEL_INTERNAL_H
 
 #include "qemu/accel.h"
+#include "qapi/qapi-types-machine.h"
 
 void accel_init_ops_interfaces(AccelClass *ac);
+void accel_register_cpu_type(SysEmuTarget arch, const char *cpu_type);
 
 #endif /* ACCEL_SYSTEM_H */
diff --git a/accel/accel-target.c b/accel/accel-target.c
new file mode 100644
index 00000000000..202238035d5
--- /dev/null
+++ b/accel/accel-target.c
@@ -0,0 +1,21 @@
+/*
+ * Per-target accelerator CPU parent registration.
+ *
+ * Compiled once per target. Must not define a global symbol, so each
+ * copy can be linked into one binary.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "accel/accel-cpu-target.h"
+#include "accel-internal.h"
+
+static void register_accel_target_type(void)
+{
+    accel_register_cpu_type(glue(SYS_EMU_TARGET_, TARGET_ARCH_VARIANT),
+                            CPU_RESOLVING_TYPE);
+}
+
+type_init(register_accel_target_type);
diff --git a/accel/meson.build b/accel/meson.build
index 1b5b37e3097..7da12b9741f 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,4 +1,5 @@
 common_ss.add(files('accel-common.c'))
+specific_ss.add(files('accel-target.c'))
 system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c', 'accel-irq.c'))
 user_ss.add(files('accel-user.c'))
 
diff --git a/tests/unit/test-multi-target.c b/tests/unit/test-multi-target.c
index c7559827a08..de75d6e9d35 100644
--- a/tests/unit/test-multi-target.c
+++ b/tests/unit/test-multi-target.c
@@ -51,6 +51,24 @@ static void test_qom_types_are_unique(const void *data)
     object_class_get_list("", false);
 }
 
+static void test_accel_cpu_parent_per_target(const void *data)
+{
+    const TargetInfo *ti = data;
+    g_autofree char *name = NULL;
+
+    if (!g_test_subprocess()) {
+        g_test_trap_subprocess(NULL, 0, G_TEST_SUBPROCESS_INHERIT_STDERR);
+        g_test_trap_assert_passed();
+        return;
+    }
+
+    target_info_qom_set_target_info(ti);
+    module_call_init(MODULE_INIT_QOM);
+
+    name = g_strconcat("accel-", ti->cpu_type, NULL);
+    g_assert_nonnull(object_class_by_name(name));
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -64,7 +82,11 @@ int main(int argc, char **argv)
         g_autofree char *path =
             g_strdup_printf("/multi-targets/qom-types-are-unique/%s",
                             ti->target_name);
+        g_autofree char *accel_path =
+            g_strdup_printf("/multi-targets/accel-cpu-parent-per-target/%s",
+                            ti->target_name);
         g_test_add_data_func(path, ti, test_qom_types_are_unique);
+        g_test_add_data_func(accel_path, ti, test_accel_cpu_parent_per_target);
     }
 
     return g_test_run();
-- 
2.55.0.windows.3


