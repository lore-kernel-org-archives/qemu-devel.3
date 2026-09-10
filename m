Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF61FC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dQW-00014M-Ea; Thu, 10 Sep 2026 07:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbgh9129@gmail.com>)
 id 1x4XMi-0005Xk-19
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 01:30:28 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbgh9129@gmail.com>)
 id 1x4XMf-00083O-WC
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 01:30:27 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-5306d609317so46233681cf.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 22:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789018224; x=1789623024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GFTVTurJ16TC/k+mw5oCSNr4dT4tAIHmIzv4RdIN++A=;
 b=JWUvNbOfqMEK8/UjMHaZxamEPl7lNRV3bMYPtflzb1qyzVFqGb6X05fFx27vQ8owG2
 Yi5lWpOXgk/nFKP7O8Xc9wucByEYp8gCDtdzBxlOQwI9hhc4IUZF8T2034AZ7Db81YWR
 BzE+JtGNs23PnrlkERU71eb8HFqGESylkqzEpc5hzcyGPqwKrOQkSR8O4PlqvFTah6YO
 NnKSPmhZJxwmZSmXUe9kN9hhX68lQR/Ot35xx5WEAnG8FD/urSXdzWAlif69RpV4SE1A
 gnbTcsHGpvG2/vg0ZEEdEfltD2fy76+0FEBZIGC5YQ8BeENY2VwJyyNvfhr8xiAccd5o
 2BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789018224; x=1789623024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GFTVTurJ16TC/k+mw5oCSNr4dT4tAIHmIzv4RdIN++A=;
 b=iXEFcWYt0ZyRa6aZinnfXNRjpQ4ZTgRfrJpnGQRQSc9+lqryIbYyk1A5TVDrjM2pIL
 910SB2PVtV6Wuth3+Um7+qssvPJMtwTmDhXDN2UOqbdPyDcyoF3oMCZi/m7XgXTiplX1
 RLTXCMmmOlDhLYt3CaFXeQi3wsAS50IyLaSU+J1z710I8tOOdZXqSAL/qc98cJbGlFwU
 4u1iCFl7SHOfdjO6WL2rDQ0QAZtd/z4UQSyL/tuFMqae4fdI3dR0TzP2qgWyGQvyTF9v
 aXQsk8VgrQK3MqCEg1YutB9dGV/4O/abjrF3SzbRuZhTFvPdZuRO7AFU7TbclJ7Na17u
 VVQg==
X-Gm-Message-State: AFuF++lHIXiFMAX5eca+ggBR/RBW0aQsiSfUL5k0BjKJ8d7Ol5XOJOaL
 ZB6U1aoDlak2NUbwu2N+fsJI2sWczSBtKCaXZ/QTR8zG/b5+QFfLm+Ya9cGRX/3n
X-Gm-Gg: AYBFou1fpqjAA3/hlluBTxFLWYv4lglK9XfZmDSlNs7dff2AxcoMVSXcHeFZH7yBuli
 jNyk1NrJh7T591fb4Dqb9Uc0aj0AKVo9tu7qKeHBziJtI5Ak5vinwL6FRu5Ql6gapjyE6F5N91I
 KX0+mWnvffFM3BW7I/WpbzQAKZ6BFjGJ5g9k00G6VPttmErNqCRWSv6s2eT6bu//hFB+nsKUtfi
 SCmsnj06bMonIdndIvY2ZjDJVtf1mkWTptHmY/FqTzk2qElmjvhqxmsnPWgXn0oZ+FZpc1L4njr
 5yJAiRIkURZRChmVeT/9hvehzE8hczMwT210e8MBs3BjDOLbGArchwr90DwNBD+XGE0bVPPiHyf
 8UFYOs9nt421JR4JKSECanoCrbgsZZj69pFbHPXhvguMo2J5BrlVuJWIHl8bMN/kcHamC1rSN4E
 nPofFY7Bb8TqcV6DD8pQw0V16D5dMkkXfqY1ZTdaW5bEAPHVgAXUGI64fam0r0Wdb/TV5dflgYq
 3eAjywmP74qfkqKwDxOSf5wLXHOX5bL12W1lUphtnsaDXBCTRK9Ab/HwyxLCRoPvoWSbOtwSoF0
 /4U=
X-Received: by 2002:a05:622a:5c05:b0:52d:8257:666d with SMTP id
 d75a77b69052e-5305483acf5mr528097121cf.11.1789018224153; 
 Wed, 09 Sep 2026 22:30:24 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53054207c16sm158638951cf.28.2026.09.09.22.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 22:30:23 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
X-Google-Original-From: Yuho Choi <oss.patchbox@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] vhost-user: remove shared object entries during cleanup
Date: Thu, 10 Sep 2026 01:30:12 -0400
Message-ID: <20260910053012.1395885-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=dbgh9129@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Sep 2026 07:58:46 -0400
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

SHARED_OBJECT_ADD publishes a borrowed vhost_dev pointer in the global
UUID table. If an exporter goes away without sending SHARED_OBJECT_REMOVE,
vhost_user_backend_cleanup() frees dev->opaque but leaves these entries
behind. A later lookup from another backend can dereference the NULL
opaque pointer, or access a freed vhost_dev if its containing allocation
has also been released.

Remove all entries exported by the device after closing its backend
request channel and before freeing its state. Match both the resource
type and owner pointer so other exporters and dma-buf entries are kept.

Add unit coverage for multiple UUIDs per owner, unrelated resources,
repeated cleanup, UUID reuse, and an uninitialized or empty table.

Fixes: 160947666276 ("vhost-user: add shared_object msg")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 hw/display/virtio-dmabuf.c        | 18 +++++++++++++
 hw/virtio/vhost-user.c            |  1 +
 include/hw/virtio/virtio-dmabuf.h |  8 ++++++
 tests/unit/test-virtio-dmabuf.c   | 43 +++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 5e0395be77c..636372543a5 100644
--- a/hw/display/virtio-dmabuf.c
+++ b/hw/display/virtio-dmabuf.c
@@ -96,6 +96,24 @@ bool virtio_remove_resource(const QemuUUID *uuid)
     return result;
 }
 
+static gboolean virtio_vhost_device_match(gpointer key, gpointer value,
+                                         gpointer dev)
+{
+    VirtioSharedObject *vso = value;
+
+    return vso->type == TYPE_VHOST_DEV && vso->value == dev;
+}
+
+void virtio_remove_vhost_device(struct vhost_dev *dev)
+{
+    g_mutex_lock(&lock);
+    if (resource_uuids != NULL) {
+        g_hash_table_foreach_remove(resource_uuids, virtio_vhost_device_match,
+                                    dev);
+    }
+    g_mutex_unlock(&lock);
+}
+
 static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
 {
     gpointer lookup_res = NULL;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2881cec72d9..4b32a61a0ba 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2679,6 +2679,7 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
     if (u->backend_sioc) {
         close_backend_channel(u);
     }
+    virtio_remove_vhost_device(dev);
     g_free(u->region_rb);
     u->region_rb = NULL;
     g_free(u->region_rb_offset);
diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
index 627c3b6db79..a1ad362c379 100644
--- a/include/hw/virtio/virtio-dmabuf.h
+++ b/include/hw/virtio/virtio-dmabuf.h
@@ -65,6 +65,14 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev);
  */
 bool virtio_remove_resource(const QemuUUID *uuid);
 
+/**
+ * virtio_remove_vhost_device() - Remove a vhost device's exported resources
+ * @dev: the exporter whose entries are to be removed
+ *
+ * The caller must remove the entries before cleaning up the device.
+ */
+void virtio_remove_vhost_device(struct vhost_dev *dev);
+
 /**
  * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the lookup table
  * @uuid: resource's UUID
diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
index a45ec52f421..395ea6f464d 100644
--- a/tests/unit/test-virtio-dmabuf.c
+++ b/tests/unit/test-virtio-dmabuf.c
@@ -22,6 +22,47 @@
 #include "hw/virtio/virtio-dmabuf.h"
 
 
+static void test_remove_vhost_device(void)
+{
+    struct vhost_dev dev = { 0 }, other = { 0 };
+    QemuUUID uuids[2], other_uuid, dmabuf_uuid;
+    int i;
+
+    /* Also allow cleanup before any resources have been registered. */
+    virtio_remove_vhost_device(&dev);
+
+    for (i = 0; i < ARRAY_SIZE(uuids); i++) {
+        qemu_uuid_generate(&uuids[i]);
+        g_assert_true(virtio_add_vhost_device(&uuids[i], &dev));
+    }
+    qemu_uuid_generate(&other_uuid);
+    g_assert_true(virtio_add_vhost_device(&other_uuid, &other));
+    qemu_uuid_generate(&dmabuf_uuid);
+    g_assert_true(virtio_add_dmabuf(&dmabuf_uuid, 3));
+
+    virtio_remove_vhost_device(&dev);
+    for (i = 0; i < ARRAY_SIZE(uuids); i++) {
+        g_assert_null(virtio_lookup_vhost_device(&uuids[i]));
+        g_assert_cmpint(virtio_object_type(&uuids[i]), ==, TYPE_INVALID);
+    }
+
+    /* Repeated cleanup must preserve unrelated resources. */
+    virtio_remove_vhost_device(&dev);
+    g_assert_true(virtio_lookup_vhost_device(&other_uuid) == &other);
+    g_assert_cmpint(virtio_lookup_dmabuf(&dmabuf_uuid), ==, 3);
+
+    /* Removed UUIDs can be exported by another device. */
+    g_assert_true(virtio_add_vhost_device(&uuids[0], &other));
+    virtio_remove_vhost_device(&other);
+    g_assert_null(virtio_lookup_vhost_device(&uuids[0]));
+    g_assert_null(virtio_lookup_vhost_device(&other_uuid));
+    g_assert_true(virtio_remove_resource(&dmabuf_uuid));
+
+    virtio_remove_vhost_device(&dev);
+    virtio_free_resources();
+    virtio_remove_vhost_device(&dev);
+}
+
 static void test_add_remove_resources(void)
 {
     QemuUUID uuid;
@@ -125,6 +166,8 @@ static void test_free_resources(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/virtio-dmabuf/remove_vhost_device",
+                    test_remove_vhost_device);
     g_test_add_func("/virtio-dmabuf/add_rm_res", test_add_remove_resources);
     g_test_add_func("/virtio-dmabuf/add_rm_dev", test_add_remove_dev);
     g_test_add_func("/virtio-dmabuf/rm_invalid_res",

base-commit: 1df256f5968e9f7c3c4533a1383b071c044a36d6
-- 
2.43.0


