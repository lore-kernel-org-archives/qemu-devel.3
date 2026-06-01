Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44908CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU00p-0004R6-TV; Mon, 01 Jun 2026 06:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <198627807a6b94e2aab157cf345f98edb1ac1a7a@kylie.crudebyte.com>)
 id 1wU00n-0004Qg-7O; Mon, 01 Jun 2026 06:36:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <198627807a6b94e2aab157cf345f98edb1ac1a7a@kylie.crudebyte.com>)
 id 1wU00k-00072G-4e; Mon, 01 Jun 2026 06:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=dAZnEm7vTJ3oFE09BJyT1XgyhO/mjQhAShsQCc1F6As=; b=hZvM0
 iX3rGq+4q58GGZzJjDP+vWwJ2VCrPy7/2Ts30ABDCVVr7vLXygHJKMdZoImDdrD+jFe6w0QXgazQf
 IGID/nZ9QEzwcFvA8ppLuq4vQ34BcLtB38WkBzTi4yM59FfEPxX5cgAfoIz4O2RcAHVaUat4XpdZi
 QBHnL+Qi2cj8zZq4rJnq2Rk5BbWw7z2oJhRaK3drrjgIp1jqWP/WpM72TWcOjZr17WGngrz1iPNo+
 G6nNS5qVM15EjyZ0H2NIffCagI3l3h8Nz+Lqes8P9GgIq8wbJyYaFUXMTUiBYOIPWJ5jy9RgYcTlV
 scvDvxlm4GqcC3AM6Fw4eUC+UziOfTBaLFA8TA8vcK/lbyhVJLR2ZdM27zugkVGEOdJjKr5KArNjw
 d7BYET/oSqNQjiBunCsZx0fPOVTg1tFOLuino60ENlnDC9MfOv4badi74QkZaaseSySQIP4fBgOor
 5tZcoTIIbNtfhduTRi1FUENDsS2+Po/+vMm0kJtaotQ2usNA3plz5WwYzHou5ng/mJfLSN5LyRf6v
 30qsxNK0vxxnDnG54eIeBO0b3lMEheRrYQKHLTVa3py9UIaObOSXOJF9DSSjEifQ+YzuLZd1BaX2p
 EEfstg9W847yRCYf6sNjKIwNqC/7PBxiVPfQyDMbTJN6aPY7fmIgK3f5b4IMPI=;
Message-ID: <198627807a6b94e2aab157cf345f98edb1ac1a7a.1780307575.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780307575.git.qemu_oss@crudebyte.com>
References: <cover.1780307575.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 01 Jun 2026 11:52:56 +0200
Subject: [PULL 6/7] tests/9pfs: add deep absolute path test
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wang Jihe <wangjihe.mail@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=198627807a6b94e2aab157cf345f98edb1ac1a7a@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add fs_deep_absolute_path test that creates a deep directory
structure with an absolute path length exceeding 16-bit range
(i.e. >65536) to verify the previous buffer overflow fix.

This is a slow test (may take several seconds) and therefore
registered as "slow" test and not running by default.

Use -m slow to run this test.

Link: https://gitlab.com/qemu-project/qemu/-/issues/3358
Link: https://lore.kernel.org/qemu-devel/933552b2cfc2c442fac7f4e68c777dce20ee8d7e.1779126034.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index ac38ccf595..1c69d41e33 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "libqos/virtio.h"
 #include "libqos/virtio-9p-client.h"
 
 #define twalk(...) v9fs_twalk((TWalkOpt) __VA_ARGS__)
@@ -752,6 +753,72 @@ static void fs_use_after_unlink(void *obj, void *data,
     g_assert_cmpint(attr.size, ==, 2001);
 }
 
+/* https://gitlab.com/qemu-project/qemu/-/issues/3358 */
+static void fs_deep_absolute_path(void *obj, void *data,
+                                  QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    v9fs_set_allocator(t_alloc);
+
+    if (!g_test_slow()) {
+        g_test_skip("This is a slow test, run with -m slow");
+        return;
+    }
+
+    GString *path = g_string_new("/");
+    char name[256];
+    uint32_t current_fid = 0;
+
+    tattach({ .client = v9p });
+
+    /* Create deep directory structure until absolute path length
+     * exceeds 16-bit range.
+     */
+    while (path->len <= 65536) {
+        /* use 255-byte name (NAME_MAX) to reduce iterations to ~257 */
+        memset(name, 'A', 255);
+        name[255] = '\0';
+
+        /* create the directory relative to current FID */
+        tmkdir({
+            .client = v9p,
+            .dfid = current_fid,
+            .name = name
+        });
+
+        /* just for locally tracking the current path length */
+        g_string_append(path, name);
+        g_string_append(path, "/");
+
+        /* acquire new FID for the newly created directory */
+        char *wnames[] = { name };
+        current_fid = twalk({
+            .client = v9p,
+            .fid = current_fid,
+            .nwname = 1,
+            .wnames = wnames
+        }).newfid;
+
+        /* Reset descriptor pool to avoid exhaustion. The simplified
+         * virtio test driver does never free descriptors back to the pool
+         * after use, so we must manually reset it for the required high
+         * amount of 9p requests here.
+         */
+        qvirtqueue_reset_pool(v9p->vq);
+    }
+
+    /* check if the deepest directory is accessible */
+    v9fs_attr attr = {};
+    tgetattr({
+        .client = v9p,
+        .fid = current_fid,
+        .request_mask = P9_GETATTR_BASIC,
+        .rgetattr.attr = &attr
+    });
+
+    g_string_free(path, TRUE);
+}
+
 static void cleanup_9p_local_driver(void *data)
 {
     /* remove previously created test dir when test is completed */
@@ -819,6 +886,8 @@ static void register_virtio_9p_test(void)
                  &opts);
     qos_add_test("local/use_after_unlink", "virtio-9p", fs_use_after_unlink,
                  &opts);
+    qos_add_test("local/deep_absolute_path", "virtio-9p",
+                 fs_deep_absolute_path, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.47.3


