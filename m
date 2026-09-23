Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85008C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MwB-0004gX-M9; Wed, 23 Sep 2026 09:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mrj-0000P2-6E
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:18:37 -0400
Received: from mail-dl2-x10.google.com ([2607:f8b0:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mrf-0006v4-VQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:18:26 -0400
Received: by mail-dl2-x10.google.com with SMTP id
 a92af1059eb24-142dd04edb5so1431137c88.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169502; x=1790774302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yqkLIHs8nht5THiWcj2P453LN93rHp/TnF9wI3rp1V4=;
 b=ommQnWUpcJDJiR6l56NFITObmh5aqsyWTpAQWWfZNH27p6HUD8qgpznivXTzyx9lqk
 EFbc4tLbMLO38106wDCoL6vOal81n1W6H2FVtoqPClYWDBapKYF0a+/mwyPMmGMISrPw
 3eDvVe+MI2qd6Wo93eeaEWOhEBzvL5txi/CBUIQlrPb0NTERCvO0qOLoDugfUypundg2
 0sWYqXPpK3Kym9EH3JH1O3Dy3CszziYo3SUb9c6b/viUKwu5AMo1/6RNDEkqCULYGifr
 zoJyezPxpk374r54k7v30s2MOZBqJwuEaBGeotlaVs4jY9vmsdLlvz+uwiCTVUAEToqi
 1btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169502; x=1790774302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yqkLIHs8nht5THiWcj2P453LN93rHp/TnF9wI3rp1V4=;
 b=c8AqBg21PgME5ii6lMQvvcDdD3GAtAz0qC89ajeF54flMWKdHJcH/jARwJ0cdHI7re
 TOGqp1u2a3PlXzWvpk9M9NLIYBZbbSWEi0nz7llMYSyg+K+BzNLTkwznDUaQa/XtOw2e
 TgrnGFR26nb2pjETW0FYmfdrH016mWhY8QWKM5bRhuWqLuYpkqE3MWOK/XONkVXTOLJJ
 xxygyOUdqmQAOl2deilCWwoCvryslSDv7LsMmy2d990jYP6KorzftXEnBN9yYRmTftTI
 C/Y0hFT9ARFNu8/x3r+ImHKcZPzhsMxGDk+x2Vhtxt4YGSEm5hpEhii22GoQs5vMf9UA
 0xQQ==
X-Gm-Message-State: AFuF++mTN+yS+ITbG5hrVhWDBA9kOEegVta/xu2H3FXw7t8bBDoWwEG3
 3gOWdQPwbtJCKV40q6xm7Le37gzyawLlEkrC3eGBXlqihcBex1QZXZrDm65m8n5a7Ts=
X-Gm-Gg: AYBFou2XlKjoHmAfeZJ+KrpMB1uqVXs7orPO9FJiOctRTFby2B6EtklJQ0gRJhebZ1m
 +QzdmFM/D3XTOVaFxl0l0V7uacWC85R8fhJ0JT3JKoL7f5ZHIM35aiLJcyGnEaf/QjVX7Ji7OjQ
 FcpSpMuw3uH89DBdMb8nZw8fBDs2DmBobFg+4mGYyEbQIh1+xgPI43a2zIWrXNbbU/5Ftd9ktEV
 naaAFYUJiNc2VCPrhrJFqSrKn2THpIqzCivWT5H7PrxjrA66vvVpDS/3A7LA0BsCOZMqWEAtGXB
 J8bvPeVpjUioRIk+GsJwdmF1Ny8SVI6E1LzVvpkuL6PbT2m/3+zRkBKIqr/nlENV6GnZ103ogF9
 Q0VlBwcZ3KeMvuuMRQfcEmNicxIj77Tw31mk2lmFYZIo0+MKkphAC3ngYle9579YTZTHxCkr2fL
 IipOBxt5f6N4LebRFgEtg69eKL4PQyrU7LAQPhFIbCGmbuCtwOH/L6NpNnW26z4VNidXte8a9KI
 AmU25bC7Xr4qUrJbigePqNmxm5HbVGLbLeYJ7fi9Q==
X-Received: by 2002:a05:7022:fa9:b0:143:2719:a501 with SMTP id
 a92af1059eb24-144f9173969mr4195539c88.40.1790169493859; 
 Wed, 23 Sep 2026 06:18:13 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:18:12 -0700 (PDT)
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
Subject: [PATCH v3 009/114] tests/unit: add test-target-info
Date: Wed, 23 Sep 2026 21:14:43 +0800
Message-ID: <20260923131635.1894-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x10.google.com
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
index 9a6a80fd0c8..776d38c5afd 100644
--- a/meson.build
+++ b/meson.build
@@ -4260,6 +4260,8 @@ endif
 
 traceable = []
 emulators = {}
+target_info_def = files('target-info-def.c')
+target_info_def_objects = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
@@ -4331,7 +4333,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-def.c')
+  arch_srcs += target_info_def
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
@@ -4409,6 +4411,8 @@ foreach target : target_dirs
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


