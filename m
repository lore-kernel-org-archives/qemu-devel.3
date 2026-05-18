Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605FBCD4F57
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 18:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP2mS-00072D-0P; Mon, 18 May 2026 14:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <933552b2cfc2c442fac7f4e68c777dce20ee8d7e@kylie.crudebyte.com>)
 id 1wP2lg-0006QK-Qr; Mon, 18 May 2026 14:32:56 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <933552b2cfc2c442fac7f4e68c777dce20ee8d7e@kylie.crudebyte.com>)
 id 1wP2lf-0002h4-0c; Mon, 18 May 2026 14:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=p/F1BCg5h9kR2piod5kuo35i5pYgag2fdNeBSD44JP8=; b=K4X4y
 tyfshaKHEArazQ42gWpFHYZ0PEKr8M73XsDxnzfUo4zghrwv3nhgws9/tygsQj5tzxIGgnNlTsuPC
 y1KKHe9JGCSM7YPz0Kp2KcCt4W57q00TKlbXSotzcMSXRyvBGQMNknHmRGtlAevPQiDDWVL0IRDFV
 kJglyVkQRRvXCGqbDf9a3T8A96TzYv53UNbOJVo3eIymPyYeszcz8+BzzHIKrpGA3m3artnkOv4iU
 c3pbEmKwuV676evQTbJo0wGWhsxojiAEnvleozRMqWmA7FmvLSJVhn8v32Ge3tqMd2zk+p8NcXD2X
 G+uBMeZ7urle1UIgUK8O002oreSghfM0N4r82H0w7enwjsfsu3CZ0NGdGR6NuT6W4Nj+qsETfj3sU
 wHTAKrFBr8W6GkiM8HK8Ooa2aspJXBDl+0nYi4P3kon4vzzyqLlXdfs+T/B6ImYxEKpGplnmGZssy
 hVUoQZxxoC4U6MGAksqPyeQ4gZzAIg5Y9dAAaVpoZ0vbnpUwEbdkytqCHtxMs8lkY5Jftwu//GYC7
 GZHzM0ceHKHHc8CFfwa5N85JDzPfrf1uBQGqowB68fz2/ztjwvfoLywBGhUAtpyxndzLE+XNRlAsN
 LvGGA+xuTmpPy+2B/RImhJWZDQ2VE+b7G9sqGS3ppdgGhvPk/xjOMT6b5UTCPs=;
Message-ID: <933552b2cfc2c442fac7f4e68c777dce20ee8d7e.1779126034.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779126034.git.qemu_oss@crudebyte.com>
References: <cover.1779126034.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 18 May 2026 19:36:03 +0200
Subject: [PATCH 6/6] tests/9pfs: add deep absolute path test
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=933552b2cfc2c442fac7f4e68c777dce20ee8d7e@kylie.crudebyte.com;
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


