Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C5606A333
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bvdhikxg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=X5qooiJn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HJ-0002dI-4G; Wed, 28 Oct 2026 13:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fw-0007j0-0M
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ft-0003qm-PV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XqhvxUVpombCjmAwjmm5BTwgJ42rWV/z09huDiwROrQ=;
 b=bvdhikxgJnONLrPqEKBarTwwSlu+dWV5WEyVzFMAJz4Pa71aVn052Re4oOkyUprnSoBO/w
 aaPrniIiL3ERUx5M4FJrHXUNpJwBOYOPNWWNCMtIT7yALoKks1qF3DNI28fTfDRHDHdLjA
 PMft2xPCgwoQMGz/T/sw4UxOgF4p2IY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-EOgZX_SdPG-V4D2-inoJMA-1; Wed, 28 Oct 2026 13:16:03 -0400
X-MC-Unique: EOgZX_SdPG-V4D2-inoJMA-1
X-Mimecast-MFC-AGG-ID: EOgZX_SdPG-V4D2-inoJMA_1793207762
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48c46582442so803771f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207762; x=1793812562; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XqhvxUVpombCjmAwjmm5BTwgJ42rWV/z09huDiwROrQ=;
 b=X5qooiJnI1DNkpBftCH7H7hhlyQZUsA8vGBKQ4drQwI4ulZH3S6I8XfgaOME8pTY/E
 1opsPP/Z0uIP30JYqHvOIL+SMeZNsUhzG+Pd0g5GPUEXR9r8DI4fMmMQS6wNySVUX8tI
 67n9I1SDWriNKy8wXZLMjdRfGVf2rvRsGhI82/dxrtOoREP4gZ/sMmIltii7gX0YzQt/
 kiCeEUxARWplNavx8BgPd5sTHzXJIeV39C/GyVX1DfKKy6+2q+oVaxFRlF46AVCA+xed
 K+HQUncciY4L7yiAt334ClnNv4G7PtcG4rRqwhtCGCuAFK17QLvZnwKc6sFk/4WrO3Vh
 wNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207762; x=1793812562;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XqhvxUVpombCjmAwjmm5BTwgJ42rWV/z09huDiwROrQ=;
 b=Ku1uvLS4cBXx0pSw37VaCJiB/wu5LRrkycQsezCpswAYndp73zpEFvUWyCmDZtBmFk
 K46LCiRvQ0XKAAbv+Kjnbty98ZpY5M9TLMcUJSIcsJ8LGk+nURk/iwxn/VP9O9rpfI3/
 faVNp3UGE9he9kgsr3zTxiK4Q1s+V3Clwp8ngAi5krqNyYZG+pacjNh/q3fAEXa1iFm1
 2TGAaoyNTArQrM41ie3A3sMEt29FavJT5uqOPtFb9DfqG7eUeA5FUWr7RytBDEfOUW/5
 Gf0LOarMsNOESTQJukWfbrToZZKGM0TJX8s6vRf/bOVBb5SsTvl8b8bT5cPfrAagFybV
 9UcA==
X-Gm-Message-State: AFq9FYKxSfO2OFPJbBqR7LCTW1sihwHrPeygBJcnJNI+8IGpDKx7wpUG
 SH/9lW89QKpM0L6n37hxfU/3iRWwp8IbHksFZ4RlSUfiqZrBxOb9eU+bIEEXKF/Lo4dwEaQg7mG
 krcA5+DEd9Czk8C5nG2gXP8F6SdLaYHQw3bCIyZmFnu0RQFzzplY1VX8q20+8GNmqKIQ8vlV25Z
 oj5KMb2Z3WY6YiMgaItMpwoL4PkAoF6D9NTw==
X-Gm-Gg: AYBFou1pjcAjlpk+cv0pX3Nw0Z+pUqeC3lAiyp+2AMlOsysd7WrMcHOcFyl3d7GWynv
 Ina46oxQ1u8K51qtD0KS3syT+hCYQm/jkY3sCAAd+RU08oRa+vDzG5kW7SIuaRIwX8VxKFg5IAp
 rL3famQPild8MwSoAToFZnNmSTgUT4gReLYAugkIhK1KIzCqUyCsvtfIeu9gwGv0hurPTxNAJvf
 DIATPrbsM/2u9SdDTl0hmBthVjidnNAL22q25fgNXcBBTWygVIeXjS6/lkkrnqIE+P5OHq2kIky
 MR9vPl40bRkz4g0gLO5Uz+aP095FeSAmdOEHVnqPAF0EB8Vh1GVk2ERYJ/sfXYn4gqvOxpMgELY
 Mtc3dO/nT/+1h9N98dICW6kB2bej+UTI/2IVcz5kz
X-Received: by 2002:a05:6000:240e:b0:48e:f07:160e with SMTP id
 ffacd0b85a97d-48e5d5c46e4mr7632389f8f.38.1793207761820; 
 Wed, 28 Oct 2026 10:16:01 -0700 (PDT)
X-Received: by 2002:a05:6000:240e:b0:48e:f07:160e with SMTP id
 ffacd0b85a97d-48e5d5c46e4mr7632280f8f.38.1793207761172; 
 Wed, 28 Oct 2026 10:16:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb851sm25583227f8f.26.2026.10.28.10.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:00 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yuho Choi <dbgh9129@gmail.com>, Yuho Choi <oss.patchbox@gmail.com>,
 Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, vhost-user@lists.linux.dev
Subject: [PULL 46/78] vhost-user: remove shared object entries during cleanup
Message-ID: <05b213ca8e2b63ba56e978fdb252549909e1f635.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yuho Choi <dbgh9129@gmail.com>

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
Reviewed-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260910053012.1395885-1-oss.patchbox@gmail.com>
---
 include/hw/virtio/virtio-dmabuf.h |  8 ++++++
 hw/display/virtio-dmabuf.c        | 18 +++++++++++++
 hw/virtio/vhost-user.c            |  1 +
 tests/unit/test-virtio-dmabuf.c   | 43 +++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
index 627c3b6db7..a1ad362c37 100644
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
diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 5e0395be77..636372543a 100644
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
index 65889b0776..3402accc6f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2711,6 +2711,7 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
     if (u->backend_sioc) {
         close_backend_channel(u);
     }
+    virtio_remove_vhost_device(dev);
     g_free(u->region_rb);
     u->region_rb = NULL;
     g_free(u->region_rb_offset);
diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
index a45ec52f42..395ea6f464 100644
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
-- 
MST


