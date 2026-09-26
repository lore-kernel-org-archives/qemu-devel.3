Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5E6C9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMPl-0002Ed-Sw; Sat, 26 Sep 2026 03:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMPg-0002DS-AH
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:01:37 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMPe-0000Qx-My
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:01:36 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-341fe27b718so1359060eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406093; x=1791010893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TZMKrJ9OTgOVuSw0xuj4IN8VaH3KKEmXiPudtyfK+aY=;
 b=EQ37lXl7eCdx2fkFXhKpx7uKs3+kYESeHYwNoXiusJXaQaoFem/F/vxNYgYp50uXrR
 x2Gxsgb6fzeE8PdgeavqBjWv0uPvO82f4RO78AKqurcFZIJHyATxcYUrz3QwFR9UnuSv
 jS4fHgRADXTS7a08nBjxquihaU1Np4Cw52fGBflDyetVTTyGxftsjFzl4IIoXAYFgE5b
 JERNLKCmfHj/R+vcm125BETms4fMf2eUsxbkwWzhgpE0S4ezve1yM9AqQKbPukvMGLT6
 L+HiUMSijaGDPe0nC1Cl1znsj9Z0/33dzE9VjR+XMri7roDnpV2oPo48W/+WqxST7jGM
 yUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406093; x=1791010893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TZMKrJ9OTgOVuSw0xuj4IN8VaH3KKEmXiPudtyfK+aY=;
 b=axLlSsDuKy4dEv3F3Gvs9EKxbAeubORIYFyZxgGWoyzL1N4Wl0fnvpjkVh6rgo7UWw
 9dWujX6pulqFMcklEfdVN0zr1+/sy62ZoB4vbvo4Fspv+yaiYqRfsVcpO7wjWups3TAD
 t3tUiYQ3AbyCh87aYoDC/wWvwt4a38TQzSd3I77o9LlqrHOP5c26ivihoBdvP+NYMfKz
 pRIV4wM31xjC9Ri35f3XU2Xh5S0M7OZaQ1UxDkheG3aZxJcia+wkBX0Kf9PoobPF4e5y
 cDRF9M7LAuJyfqIMiSB6AI5Oh28sqz09cpDqYT5YnJhViVNudec9KdRhLdELkymBLcZz
 Rd+Q==
X-Gm-Message-State: AFuF++lM1c0fN6OuBEz6FhjOYLmr0eVNLy41srfWQPmzRcdKSYomDq4c
 1xF7h9w286YQPFscv+9zS4naCdcaV1iaROKSNngQR3i/y6lW+3IQTHo0DecidGNZ
X-Gm-Gg: AYBFou28w7L7EITL32YhREcIRRnGCiau1TEZo7rMZN5zZYQtSXzF0i9RnMt5rQfIByY
 E5gBlj3KK/OrnH9HvwkJaxKBqhHWIutGGBicY6NzHDUrz9EwLfouvVLZ38zMRC7kiaU7y4M7uGs
 GqZjtu2/7PgXZtILE92i/H8Dkt2KEMLom5Fa9wCQLTDEe+Mkds/91uicfi5hfygBNbVchKXc0IQ
 Sh8Bw3w7R/Fc5aBma+XOWBU9u4+cEgjB+ehe5ETj6NUDztmJfuhD0Juy/S29SJvJ2jhiTrCaG0M
 cYXnxSq6dDT00pz0rR/OKkh8Cct2VVsjWCcZuyG3qjrzYtXtv3Ya/VLd6mCo/6r4p8Qsf5UVePc
 TvkV2/zA2JRZu7POaZ3s2Q+o5WOiB8T5DSzAdjaAgfofv3BxR/X4GXhtgf+tEnrPmQi/w2CGVwc
 +110V9tIKQIsC28raUoFh70RjhFTICR93NttSMdCLWsRcaBY8RP8FmTNGswVd5Pan0VpfXpZn9w
 cwUsDoAvtNGD0gpOKAqd33Yyudj8BM=
X-Received: by 2002:a05:693c:26c2:b0:33e:3f5b:3ffa with SMTP id
 5a478bee46e88-342700c4766mr2065592eec.10.1790406093187; 
 Sat, 26 Sep 2026 00:01:33 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:01:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 07/55] tests/unit: add test-target-info
Date: Sat, 26 Sep 2026 15:00:06 +0800
Message-ID: <20260926070057.1234-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Collect each target-info-def.c object in target_info_def_objects,
keyed by target dir. Link every value so constructors fill the
list. Assert target_info() is not NULL and target_info_list() has
one entry per linked object.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build                   |  6 +++++-
 tests/unit/meson.build        |  4 ++++
 tests/unit/test-target-info.c | 38 +++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 tests/unit/test-target-info.c

diff --git a/meson.build b/meson.build
index c404d222d9f..93237429713 100644
--- a/meson.build
+++ b/meson.build
@@ -4259,6 +4259,8 @@ endif
 
 traceable = []
 emulators = {}
+target_info_def = files('target-info-def.c')
+target_info_def_objects = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
@@ -4330,7 +4332,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-def.c')
+  arch_srcs += target_info_def
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
@@ -4408,6 +4410,8 @@ foreach target : target_dirs
                  c_args: c_args,
                  build_by_default: false)
 
+  target_info_def_objects += {target: lib.extract_objects(target_info_def)}
+
   if target.endswith('-softmmu')
     execs = [{
       'name': 'qemu-system-' + target_name,
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index e47bc7225ab..dc980a35955 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -43,6 +43,10 @@ tests = {
   'test-qgraph': ['../qtest/libqos/qgraph.c'],
   'check-qom-interface': [qom],
   'check-qom-proplist': [qom],
+  'test-target-info': [qom, declare_dependency(
+    objects: target_info_def_objects.values(),
+    compile_args: ['-DTARGET_INFO_DEF_COUNT=@0@'.format(
+      target_info_def_objects.values().length())])],
   'test-qemu-opts': [],
   'test-keyval': [testqapi],
   'test-logging': [],
diff --git a/tests/unit/test-target-info.c b/tests/unit/test-target-info.c
new file mode 100644
index 00000000000..e6de9b259e8
--- /dev/null
+++ b/tests/unit/test-target-info.c
@@ -0,0 +1,38 @@
+/*
+ * TargetInfo unit tests
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info.h"
+#include "qemu/target-info-def.h"
+
+static int target_info_list_count(void)
+{
+    TargetInfoNode *node;
+    int n = 0;
+
+    QLIST_FOREACH(node, target_info_list(), next) {
+        n++;
+    }
+    return n;
+}
+
+static void test_target_info_not_null(void)
+{
+    g_assert_nonnull(target_info());
+}
+
+static void test_target_info_list_count(void)
+{
+    g_assert_cmpint(target_info_list_count(), ==, TARGET_INFO_DEF_COUNT);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/target-info/not-null", test_target_info_not_null);
+    g_test_add_func("/target-info/list-count", test_target_info_list_count);
+    return g_test_run();
+}
-- 
2.52.0.windows.1


