Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D850C9830C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Mxm-0000aR-DQ; Wed, 23 Sep 2026 09:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mtn-00023B-F6
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:20:48 -0400
Received: from mail-dl2-x0e.google.com ([2607:f8b0:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mtg-0007O2-CG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:20:31 -0400
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-144f47a9b57so961918c88.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169624; x=1790774424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MggXP4Uti4XPPjQvDWGWmS5irh6Dnb5s6/0zImLVthk=;
 b=YbRdB5NDRMiAg9sxJp9vOhvk+h43PrZFfxkmFYRZQFa1zORhpiaZ7vw29DAcF70t+4
 Mm9BhewJePXKD93hNsMB2yrmbXUuDyNWBP7cE/azYbGZdKggTkg3+rr2zRTt8F/p0ecu
 npuWNjvHwqbJRy/SiTKMz7lzzlaLbUJ81/a20jynvO1qNrNBCFsRhMvO3IX48rY2F1V0
 3rRJW9nUoN6DNNfqWiitnR//RO8ZtreTJB1gU4IKk8ns5nsNyMtaiDk86hc7SelxGZ+b
 lY4K9by0zeozrlfBE5GlB4vBAjCdnzAi5GyHYSsHCETGKT+47vFU7FFrfcnFpM9UDPjh
 40sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169624; x=1790774424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MggXP4Uti4XPPjQvDWGWmS5irh6Dnb5s6/0zImLVthk=;
 b=kJPIpUN50IJjqApAQ3mMEzInO12HhdBYtBijeOHluEO44fvE4q06pQZX53QaCMTCOw
 Q4lf2DU7FREeAM7SQRG7s1vNkUSfh+92Rn2nQBrVdt6LWFWcSpzKq+OMZX7voJKOU0N+
 3GTGaXyamPsP4Ptrr2VXaTfqKS2XXCBzZd3MWqA2vYCxLvaa2cZHXD3AQQW9Tk+M3Teh
 tXBdxletuU1tBJVQFM7Kt7xaytUmxVi0SFPpXjrBTeKVm4M2UA0pYWpBmt23ObS+mQSi
 jUAWfsrcBPXwqgLzZ6/MkDxaYC2rcVsIpQNeN+E40Z3z9xIggzhoDphnhXJhamtEPhNF
 w+zg==
X-Gm-Message-State: AFuF++lOtiaXD9f39x1EbJWXZFrKQKm1wkVUCU3/3kfsv9TxEswolnA+
 MPUT0NfiIWnAyU06m3mTL5R9kn3+hxylYA3Bp6YNWBwM9nAGtWZSEMcUxGftozKKtyQ=
X-Gm-Gg: AYBFou0vxir/JgW/H9teT7oMFuTk4V7IjmmJI96N0RQ5ICfZAKIRcH378qOual8ba3U
 l+iu4LPm7HHrT3JEgSqTBmecfJT9oQR7WJswDhaX2JjK6eYynqI/A/WQp/DEp919SzD2YhC78+Q
 O6kA24WAb9vS4Duh1HY+1o0/ilEic5p0FDtm9FM0hT1vkPdYqMrU743zGv1GYkEBXFqI6kW2A8Q
 nj9irtkMWsMLG04azuzl7z01vf0mN1RxUZspG0VEgDcL+Fl85FsfXoAnkYsMwgnliTLVUgonf/0
 ZqQC+jYNJC8PHBcjgpAUhJswO/LRQk1A6lyVuPqeJoDZO/JuEULayLvgvb183YvZib6Tx7v/lMp
 dIorkhtOBuXq6wrHkoM1tXPYqkju89hrdtP0D2FOSeCJ3Jdufl1mufzVTyC+D4do31kpCvRGOMr
 3SDvs3rnvBhTCf0o5rvBSDgLMEI+K1bzFtaycdyXsbI1/OV3zJcRTDoziBd44/sysgpGTuPwCWQ
 6vFbxoMPFodwpXLpemPqTtbYK8WOGV9JYiYpm5c4A==
X-Received: by 2002:a05:7301:7bc4:b0:333:f481:2252 with SMTP id
 5a478bee46e88-33e8ddc490amr4023550eec.34.1790169623518; 
 Wed, 23 Sep 2026 06:20:23 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:20:16 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 020/114] tests/unit: add module-init and qom is-available
 tests
Date: Wed, 23 Sep 2026 21:14:54 +0800
Message-ID: <20260923131635.1894-21-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
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

The hook phases and QOM inherit/filter path have no unit coverage.
Add test-module-init for before/after hooks and module_call_init_fn,
and test-qom-is-available for inherit, filter, and late register
when x86_64-softmmu is present.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/unit/meson.build             |   8 +
 tests/unit/test-module-init.c      | 186 +++++++++++++++++++++
 tests/unit/test-qom-is-available.c | 250 +++++++++++++++++++++++++++++
 3 files changed, 444 insertions(+)
 create mode 100644 tests/unit/test-module-init.c
 create mode 100644 tests/unit/test-qom-is-available.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index c806dbc4ffa..9387d2c34e6 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -2,6 +2,7 @@
 testblock = declare_dependency(dependencies: [block], sources: 'iothread.c')
 
 tests = {
+  'test-module-init': [],
   'check-block-qdict': [],
   'check-qdict': [],
   'check-qnum': [],
@@ -57,6 +58,13 @@ tests = {
   'test-envlist': [],
 }
 
+if 'x86_64-softmmu' in target_info_def_objects
+  tests += {
+    'test-qom-is-available': [qom, declare_dependency(
+      objects: target_info_def_objects['x86_64-softmmu'])],
+  }
+endif
+
 if have_system or have_tools
   tests += {
     'test-qmp-event': [testqapi],
diff --git a/tests/unit/test-module-init.c b/tests/unit/test-module-init.c
new file mode 100644
index 00000000000..85fa3ba3d54
--- /dev/null
+++ b/tests/unit/test-module-init.c
@@ -0,0 +1,186 @@
+/*
+ * Module before/after hooks, static ModuleEntry, and module_call_init_fn
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+
+#define SEQ_BEFORE 1
+#define SEQ_INIT_A 2
+#define SEQ_INIT_B 3
+#define SEQ_AFTER 4
+#define SEQ_FN 5
+
+static int seq[16];
+static int seq_n;
+static int first_seq[16];
+static int first_seq_n;
+static ModuleInitPhase last_phase;
+static ModuleInitPhase first_phase;
+static bool fail_before;
+static bool fail_after;
+static int fn_ran;
+static int dso_ran;
+
+static void seq_add(int id)
+{
+    g_assert_cmpint(seq_n, <, (int)ARRAY_SIZE(seq));
+    seq[seq_n++] = id;
+}
+
+static bool test_before(ModuleInitPhase phase, Error **errp)
+{
+    last_phase = phase;
+    seq_add(SEQ_BEFORE);
+    if (fail_before) {
+        error_setg(errp, "before failed");
+        return false;
+    }
+    return true;
+}
+
+static bool test_after(ModuleInitPhase phase, Error **errp)
+{
+    last_phase = phase;
+    seq_add(SEQ_AFTER);
+    if (fail_after) {
+        error_setg(errp, "after failed");
+        return false;
+    }
+    return true;
+}
+
+static void init_a(void)
+{
+    seq_add(SEQ_INIT_A);
+}
+
+static void init_b(void)
+{
+    seq_add(SEQ_INIT_B);
+}
+
+static void init_fn(void)
+{
+    fn_ran++;
+    seq_add(SEQ_FN);
+}
+
+static void init_dso(void)
+{
+    dso_ran++;
+}
+
+static ModuleEntry entry_a = {
+    .init = init_a,
+};
+
+static ModuleEntry entry_b = {
+    .init = init_b,
+};
+
+static ModuleEntry entry_dso = {
+    .init = init_dso,
+};
+
+static void reset_seq(void)
+{
+    seq_n = 0;
+    memset(seq, 0, sizeof(seq));
+}
+
+static void test_builtin_order(void)
+{
+    g_assert_cmpint(first_phase, ==, MODULE_INIT_PHASE_ON);
+    g_assert_cmpint(first_seq_n, ==, 4);
+    g_assert_cmpint(first_seq[0], ==, SEQ_BEFORE);
+    g_assert_cmpint(first_seq[1], ==, SEQ_INIT_A);
+    g_assert_cmpint(first_seq[2], ==, SEQ_INIT_B);
+    g_assert_cmpint(first_seq[3], ==, SEQ_AFTER);
+    g_assert_cmpint(dso_ran, ==, 0);
+}
+
+static void test_call_init_idempotent(void)
+{
+    reset_seq();
+    module_call_init(MODULE_INIT_FUZZ_TARGET);
+    g_assert_cmpint(seq_n, ==, 0);
+}
+
+static void test_call_init_fn(void)
+{
+    int old_fn = fn_ran;
+
+    reset_seq();
+    module_call_init_fn(MODULE_INIT_FUZZ_TARGET, init_fn, &error_abort);
+    g_assert_cmpint(last_phase, ==, MODULE_INIT_PHASE_DSO_AFTER);
+    g_assert_cmpint(fn_ran, ==, old_fn + 1);
+    g_assert_cmpint(seq_n, ==, 3);
+    g_assert_cmpint(seq[0], ==, SEQ_BEFORE);
+    g_assert_cmpint(seq[1], ==, SEQ_FN);
+    g_assert_cmpint(seq[2], ==, SEQ_AFTER);
+}
+
+static void test_before_fail(void)
+{
+    Error *err = NULL;
+    int old_fn = fn_ran;
+
+    reset_seq();
+    fail_before = true;
+    module_call_init_fn(MODULE_INIT_FUZZ_TARGET, init_fn, &err);
+    fail_before = false;
+    g_assert_nonnull(err);
+    g_assert_cmpstr(error_get_pretty(err), ==, "before failed");
+    g_assert_cmpint(fn_ran, ==, old_fn);
+    g_assert_cmpint(seq_n, ==, 1);
+    g_assert_cmpint(seq[0], ==, SEQ_BEFORE);
+    error_free(err);
+}
+
+static void test_after_fail(void)
+{
+    Error *err = NULL;
+    int old_fn = fn_ran;
+
+    reset_seq();
+    fail_after = true;
+    module_call_init_fn(MODULE_INIT_FUZZ_TARGET, init_fn, &err);
+    fail_after = false;
+    g_assert_nonnull(err);
+    g_assert_cmpstr(error_get_pretty(err), ==, "after failed");
+    g_assert_cmpint(fn_ran, ==, old_fn + 1);
+    g_assert_cmpint(seq_n, ==, 3);
+    g_assert_cmpint(seq[0], ==, SEQ_BEFORE);
+    g_assert_cmpint(seq[1], ==, SEQ_FN);
+    g_assert_cmpint(seq[2], ==, SEQ_AFTER);
+    error_free(err);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    register_module_hooks(MODULE_INIT_FUZZ_TARGET, test_before, test_after);
+    register_module_init(&entry_a, MODULE_INIT_FUZZ_TARGET);
+    register_module_init(&entry_b, MODULE_INIT_FUZZ_TARGET);
+    register_dso_module_init(&entry_dso, MODULE_INIT_FUZZ_TARGET);
+
+    reset_seq();
+    module_call_init(MODULE_INIT_FUZZ_TARGET);
+    first_seq_n = seq_n;
+    memcpy(first_seq, seq, sizeof(seq));
+    first_phase = last_phase;
+
+    g_test_add_func("/module/init/builtin-order", test_builtin_order);
+    g_test_add_func("/module/init/call-init-idempotent",
+                    test_call_init_idempotent);
+    g_test_add_func("/module/init/call-init-fn", test_call_init_fn);
+    g_test_add_func("/module/init/before-fail", test_before_fail);
+    g_test_add_func("/module/init/after-fail", test_after_fail);
+
+    return g_test_run();
+}
diff --git a/tests/unit/test-qom-is-available.c b/tests/unit/test-qom-is-available.c
new file mode 100644
index 00000000000..641f0cf1bb4
--- /dev/null
+++ b/tests/unit/test-qom-is-available.c
@@ -0,0 +1,250 @@
+/*
+ * QOM is_available inherit and filter after MODULE_INIT_QOM
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/target-info-def.h"
+#include "qom/object.h"
+
+#define TYPE_I386_PARENT "test-avail-i386-parent"
+#define TYPE_I386_CHILD "test-avail-i386-child"
+#define TYPE_NEVER "test-avail-never"
+#define TYPE_NEVER_CHILD "test-avail-never-child"
+#define TYPE_DROP_CHILD "test-avail-drop-child"
+#define TYPE_TEST_IF "test-avail-if"
+#define TYPE_LATE_KEEP "test-avail-late-keep"
+#define TYPE_LATE_DROP "test-avail-late-drop"
+#define TYPE_ORPHAN_PARENT "test-avail-orphan-parent"
+#define TYPE_ORPHAN "test-avail-orphan"
+#define TYPE_CYCLE_A "test-avail-cycle-a"
+#define TYPE_CYCLE_B "test-avail-cycle-b"
+
+static bool test_never(const TargetInfo *ti)
+{
+    (void)ti;
+    return false;
+}
+
+static const TypeInfo i386_parent_info = {
+    .name = TYPE_I386_PARENT,
+    .parent = TYPE_OBJECT,
+    .is_available = target_is_base_i386,
+};
+
+static const TypeInfo i386_child_info = {
+    .name = TYPE_I386_CHILD,
+    .parent = TYPE_I386_PARENT,
+};
+
+static const TypeInfo never_info = {
+    .name = TYPE_NEVER,
+    .parent = TYPE_OBJECT,
+    .is_available = test_never,
+};
+
+static const TypeInfo never_child_info = {
+    .name = TYPE_NEVER_CHILD,
+    .parent = TYPE_NEVER,
+};
+
+static const TypeInfo drop_child_info = {
+    .name = TYPE_DROP_CHILD,
+    .parent = TYPE_OBJECT,
+    .is_available = test_never,
+};
+
+static const TypeInfo test_if_info = {
+    .name = TYPE_TEST_IF,
+    .parent = TYPE_INTERFACE,
+};
+
+static void register_kept_types(void)
+{
+    /* Child before parent: inherit is a list walk, not register order. */
+    type_register_static(&i386_child_info);
+    type_register_static(&i386_parent_info);
+    type_register_static(&never_child_info);
+    type_register_static(&never_info);
+    type_register_static(&drop_child_info);
+    type_register_static(&test_if_info);
+}
+
+static void test_roots(void)
+{
+    ObjectClass *obj = object_class_by_name(TYPE_OBJECT);
+    ObjectClass *iface = object_class_by_name(TYPE_INTERFACE);
+
+    g_assert_nonnull(obj);
+    g_assert_nonnull(iface);
+    g_assert(object_class_get_is_available(obj) == target_is_any);
+    g_assert(object_class_get_is_available(iface) == target_is_any);
+    g_assert_true(object_class_get_is_available(obj)(target_info()));
+}
+
+static void test_inherit_family(void)
+{
+    ObjectClass *parent = object_class_by_name(TYPE_I386_PARENT);
+    ObjectClass *child = object_class_by_name(TYPE_I386_CHILD);
+
+    if (target_is_base_i386(target_info())) {
+        g_assert_nonnull(parent);
+        g_assert_nonnull(child);
+        g_assert(object_class_get_is_available(parent) == target_is_base_i386);
+        g_assert(object_class_get_is_available(child) == target_is_base_i386);
+    } else {
+        g_assert_null(parent);
+        g_assert_null(child);
+    }
+}
+
+static void test_filter_never(void)
+{
+    g_assert_null(object_class_by_name(TYPE_NEVER));
+    g_assert_null(object_class_by_name(TYPE_NEVER_CHILD));
+    g_assert_null(object_class_by_name(TYPE_DROP_CHILD));
+}
+
+static void test_interface_inherit(void)
+{
+    ObjectClass *klass = object_class_by_name(TYPE_TEST_IF);
+
+    g_assert_nonnull(klass);
+    g_assert(object_class_get_is_available(klass) == target_is_any);
+}
+
+static void register_late_keep(void)
+{
+    static const TypeInfo late_keep_info = {
+        .name = TYPE_LATE_KEEP,
+        .parent = TYPE_OBJECT,
+    };
+
+    type_register_static(&late_keep_info);
+}
+
+static void register_late_drop(void)
+{
+    static const TypeInfo late_drop_info = {
+        .name = TYPE_LATE_DROP,
+        .parent = TYPE_OBJECT,
+        .is_available = test_never,
+    };
+
+    type_register_static(&late_drop_info);
+}
+
+static void test_late_keep(void)
+{
+    ObjectClass *klass;
+
+    module_call_init_fn(MODULE_INIT_QOM, register_late_keep, &error_abort);
+    klass = object_class_by_name(TYPE_LATE_KEEP);
+    g_assert_nonnull(klass);
+    g_assert(object_class_get_is_available(klass) == target_is_any);
+}
+
+static void test_late_drop(void)
+{
+    module_call_init_fn(MODULE_INIT_QOM, register_late_drop, &error_abort);
+    g_assert_null(object_class_by_name(TYPE_LATE_DROP));
+}
+
+static void register_orphan(void)
+{
+    static const TypeInfo parent_info = {
+        .name = TYPE_ORPHAN_PARENT,
+        .parent = TYPE_OBJECT,
+        .is_available = test_never,
+    };
+    static const TypeInfo child_info = {
+        .name = TYPE_ORPHAN,
+        .parent = TYPE_ORPHAN_PARENT,
+        .is_available = target_is_any,
+    };
+
+    type_register_static(&parent_info);
+    type_register_static(&child_info);
+}
+
+static void test_orphan_parent(void)
+{
+    Error *err = NULL;
+
+    module_call_init_fn(MODULE_INIT_QOM, register_orphan, &err);
+    g_assert_nonnull(err);
+    g_assert_cmpstr(error_get_pretty(err), ==,
+                    "Type '" TYPE_ORPHAN "' is missing its parent '"
+                    TYPE_ORPHAN_PARENT "'");
+    error_free(err);
+}
+
+static void register_cycle(void)
+{
+    static const TypeInfo a_info = {
+        .name = TYPE_CYCLE_A,
+        .parent = TYPE_CYCLE_B,
+    };
+    static const TypeInfo b_info = {
+        .name = TYPE_CYCLE_B,
+        .parent = TYPE_CYCLE_A,
+    };
+
+    type_register_static(&a_info);
+    type_register_static(&b_info);
+}
+
+static void test_cycle(void)
+{
+    Error *err = NULL;
+
+    module_call_init_fn(MODULE_INIT_QOM, register_cycle, &err);
+    g_assert_nonnull(err);
+    g_assert_true(strstr(error_get_pretty(err), "cyclic parent chain") != NULL);
+    error_free(err);
+}
+
+static void test_init_fn_before_call_init(void)
+{
+    if (g_test_subprocess()) {
+        test_roots();
+        test_inherit_family();
+        test_filter_never();
+        test_interface_inherit();
+        return;
+    }
+    g_test_trap_subprocess(NULL, 0, 0);
+    g_test_trap_assert_passed();
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_assert_nonnull(target_info());
+
+    if (g_test_subprocess()) {
+        module_call_init_fn(MODULE_INIT_QOM, register_kept_types, &error_abort);
+        module_call_init(MODULE_INIT_QOM);
+    } else {
+        module_call_init(MODULE_INIT_QOM);
+        module_call_init_fn(MODULE_INIT_QOM, register_kept_types, &error_abort);
+    }
+
+    g_test_add_func("/qom/is-available/roots", test_roots);
+    g_test_add_func("/qom/is-available/inherit-family", test_inherit_family);
+    g_test_add_func("/qom/is-available/filter-never", test_filter_never);
+    g_test_add_func("/qom/is-available/interface-inherit",
+                    test_interface_inherit);
+    g_test_add_func("/qom/is-available/late-keep", test_late_keep);
+    g_test_add_func("/qom/is-available/late-drop", test_late_drop);
+    g_test_add_func("/qom/is-available/orphan-parent", test_orphan_parent);
+    g_test_add_func("/qom/is-available/cycle", test_cycle);
+    g_test_add_func("/qom/is-available/init-fn-before-call-init",
+                    test_init_fn_before_call_init);
+
+    return g_test_run();
+}
-- 
2.52.0.windows.1


