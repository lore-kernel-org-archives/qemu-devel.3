Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31608C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNWm-0003Gt-Fw; Tue, 20 Feb 2024 05:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcNWh-0003GS-0u
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:39:04 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcNWe-0001Vp-Vz
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:39:02 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so7114319a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 02:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708425539; x=1709030339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yHbuyEyEJLUqB1osHk3CLStsTygliiUGTdo9t+U7hG8=;
 b=ab0zQAxjy/H30rQegnvf8NHyFwqvs8d15lQeBc3O8FmR6Rtnq7DRaY6z3m6Fvw9TxX
 2+Q7zIkYFxanGIun3Wn5wJJzN5aXrmQVix41WEIOuTVONTJ3Y3ZnSfSOQOOrrl7xhm++
 rOqYPxtiNszelSrFvjU0Gql1j1Crjh7/qqNkOxsX27dtpkTLeZ4/ODXUkZ6pMubwHHLw
 SMayGqgcXdW9YyeaBxbFfJ1s8MDpxSaaP1g/s1OlVGwXysZy89u78s5rUqjJIBS0o0KK
 ydKQXqQeELJ/0k8BXc3LpUqWH8/tkKmVRmoUx4keEnjYfbk9WWZnZiL/ZUJSiw19VSVu
 oyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708425539; x=1709030339;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yHbuyEyEJLUqB1osHk3CLStsTygliiUGTdo9t+U7hG8=;
 b=RjCguJThPv/PW+3s9nC5q8uA3crkh4RLM8oPL7wy4BSfPqcm6eiwLZdIuHk7XrALDU
 m5jCY0ZO0f/sDm6bc5ZD25Qa9zCY1CoDeXnX/eJnjE2tO9VNi6VkdiDES8U/65NXCfoe
 OReLMq1/prK5I7oKcAK+hkZh8gzf5BwdOnGiW0Nvk4WkKB9WKifd5UcFXmSk7gmq3R2t
 lrlS97j99i2LxR7C5980UHz6DbMDBzAYRnvQ+05frmhgrgUN4ty0ROmfjF1sb2rpOhOa
 mxx/SkPcNdXqwTVj2hLWalse3nGELptzMj0EtDcqbVUx+u8hHTXeEDDnCcG4eqUBDRV5
 rr1w==
X-Gm-Message-State: AOJu0YzKArp8m9D+xHZ5bgO158ITMPWjsWk8HTymvbDAeX4yUoQFXbRB
 abMQoz4ehpLTgRcGqu0eVz6y61xMRKDmB4aYxIJlayKSGbdBTwgM5dYtSFQzUagcIwcl6G0hzoS
 hDaM=
X-Google-Smtp-Source: AGHT+IE3Avt11g7AjuhKZ6jPWo/vLWxPKoJwX0esyG907SV3CEsFNezF15OAMIbmDwoTll2LY//04w==
X-Received: by 2002:aa7:d74c:0:b0:564:20f5:6926 with SMTP id
 a12-20020aa7d74c000000b0056420f56926mr5940699eds.14.1708425539060; 
 Tue, 20 Feb 2024 02:38:59 -0800 (PST)
Received: from meli.delivery (adsl-101.37.6.0.tellas.gr. [37.6.0.101])
 by smtp.gmail.com with ESMTPSA id
 j24-20020aa7ca58000000b00564a2d7da28sm1151476edt.41.2024.02.20.02.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 02:38:58 -0800 (PST)
Date: Tue, 20 Feb 2024 12:34:38 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Albert Esteve <aesteve@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 alex.bennee@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@gmail.com, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v4 3/5] hw/virtio: change dmabuf mutex to QemuMutex
User-Agent: meli 0.8.5-rc.3
References: <20240219143423.272012-1-aesteve@redhat.com>
 <20240219143423.272012-4-aesteve@redhat.com>
In-Reply-To: <20240219143423.272012-4-aesteve@redhat.com>
Message-ID: <95hkw.qzghj1yo7yd4@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Albert,

This is a point of confusion for me; Volker recently pointed out in a 
patch for virtio-snd that all its code runs under the BQL. Is this code
ever called without BQL, for example do the backend read/write functions 
from vhost-user.c run without the BQL?

On Mon, 19 Feb 2024 16:34, Albert Esteve <aesteve@redhat.com> wrote:
>Change GMutex by QemuMutex to be able to use
>lock contexts with `WITH_QEMU_LOCK_GUARD`.
>
>As the lock needs to be initialised and there
>is no central point for initialisation, add
>an init public function and call it from
>virtio.c, each time a new backend structure
>is initialised.
>
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> hw/display/virtio-dmabuf.c        | 55 +++++++++++++++++--------------
> hw/virtio/virtio.c                |  3 ++
> include/hw/virtio/virtio-dmabuf.h |  5 +++
> tests/unit/test-virtio-dmabuf.c   |  5 +++
> 4 files changed, 43 insertions(+), 25 deletions(-)
>
>diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
>index 497cb6fa7c..961094a561 100644
>--- a/hw/display/virtio-dmabuf.c
>+++ b/hw/display/virtio-dmabuf.c
>@@ -11,11 +11,12 @@
>  */
> 
> #include "qemu/osdep.h"
>+#include "include/qemu/lockable.h"
> 
> #include "hw/virtio/virtio-dmabuf.h"
> 
> 
>-static GMutex lock;
>+static QemuMutex lock;
> static GHashTable *resource_uuids;
> 
> /*
>@@ -27,23 +28,27 @@ static int uuid_equal_func(const void *lhv, const void *rhv)
>     return qemu_uuid_is_equal(lhv, rhv);
> }
> 
>+void virtio_dmabuf_init(void) {
>+    qemu_mutex_init(&lock);
>+}
>+
> static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
> {
>     bool result = true;
> 
>-    g_mutex_lock(&lock);
>-    if (resource_uuids == NULL) {
>-        resource_uuids = g_hash_table_new_full(qemu_uuid_hash,
>-                                               uuid_equal_func,
>-                                               NULL,
>-                                               g_free);
>-    }
>-    if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
>-        g_hash_table_insert(resource_uuids, uuid, value);
>-    } else {
>-        result = false;
>+    WITH_QEMU_LOCK_GUARD(&lock) {
>+        if (resource_uuids == NULL) {
>+            resource_uuids = g_hash_table_new_full(qemu_uuid_hash,
>+                                                uuid_equal_func,
>+                                                NULL,
>+                                                g_free);
>+        }
>+        if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
>+            g_hash_table_insert(resource_uuids, uuid, value);
>+        } else {
>+            result = false;
>+        }
>     }
>-    g_mutex_unlock(&lock);
> 
>     return result;
> }
>@@ -87,9 +92,9 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
> bool virtio_remove_resource(const QemuUUID *uuid)
> {
>     bool result;
>-    g_mutex_lock(&lock);
>-    result = g_hash_table_remove(resource_uuids, uuid);
>-    g_mutex_unlock(&lock);
>+    WITH_QEMU_LOCK_GUARD(&lock) {
>+        result = g_hash_table_remove(resource_uuids, uuid);
>+    }
> 
>     return result;
> }
>@@ -98,11 +103,11 @@ static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
> {
>     gpointer lookup_res = NULL;
> 
>-    g_mutex_lock(&lock);
>-    if (resource_uuids != NULL) {
>-        lookup_res = g_hash_table_lookup(resource_uuids, uuid);
>+    WITH_QEMU_LOCK_GUARD(&lock) {
>+        if (resource_uuids != NULL) {
>+            lookup_res = g_hash_table_lookup(resource_uuids, uuid);
>+        }
>     }
>-    g_mutex_unlock(&lock);
> 
>     return (VirtioSharedObject *) lookup_res;
> }
>@@ -138,9 +143,9 @@ SharedObjectType virtio_object_type(const QemuUUID *uuid)
> 
> void virtio_free_resources(void)
> {
>-    g_mutex_lock(&lock);
>-    g_hash_table_destroy(resource_uuids);
>-    /* Reference count shall be 0 after the implicit unref on destroy */
>-    resource_uuids = NULL;
>-    g_mutex_unlock(&lock);
>+    WITH_QEMU_LOCK_GUARD(&lock) {
>+        g_hash_table_destroy(resource_uuids);
>+        /* Reference count shall be 0 after the implicit unref on destroy */
>+        resource_uuids = NULL;
>+    }
> }
>diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>index d229755eae..88189e7178 100644
>--- a/hw/virtio/virtio.c
>+++ b/hw/virtio/virtio.c
>@@ -29,6 +29,7 @@
> #include "hw/virtio/virtio-bus.h"
> #include "hw/qdev-properties.h"
> #include "hw/virtio/virtio-access.h"
>+#include "hw/virtio/virtio-dmabuf.h"
> #include "sysemu/dma.h"
> #include "sysemu/runstate.h"
> #include "virtio-qmp.h"
>@@ -3221,6 +3222,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
>     int i;
>     int nvectors = k->query_nvectors ? k->query_nvectors(qbus->parent) : 0;
> 
>+    // Ensure virtio dmabuf table is initialised.
>+    virtio_dmabuf_init();
>     if (nvectors) {
>         vdev->vector_queues =
>             g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
>diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
>index 891a43162d..627d84dce9 100644
>--- a/include/hw/virtio/virtio-dmabuf.h
>+++ b/include/hw/virtio/virtio-dmabuf.h
>@@ -50,6 +50,11 @@ typedef struct VirtioSharedObject {
>     } value;
> } VirtioSharedObject;
> 
>+/**
>+ * virtio_dmabuf_init() - Initialise virtio dmabuf internal structures.
>+ */
>+void virtio_dmabuf_init(void);
>+
> /**
>  * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table
>  * @uuid: new resource's UUID
>diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
>index a45ec52f42..20213455ee 100644
>--- a/tests/unit/test-virtio-dmabuf.c
>+++ b/tests/unit/test-virtio-dmabuf.c
>@@ -27,6 +27,7 @@ static void test_add_remove_resources(void)
>     QemuUUID uuid;
>     int i, dmabuf_fd;
> 
>+    virtio_dmabuf_init();
>     for (i = 0; i < 100; ++i) {
>         qemu_uuid_generate(&uuid);
>         dmabuf_fd = g_random_int_range(3, 500);
>@@ -46,6 +47,7 @@ static void test_add_remove_dev(void)
>     struct vhost_dev *dev = g_new0(struct vhost_dev, 1);
>     int i;
> 
>+    virtio_dmabuf_init();
>     for (i = 0; i < 100; ++i) {
>         qemu_uuid_generate(&uuid);
>         virtio_add_vhost_device(&uuid, dev);
>@@ -64,6 +66,7 @@ static void test_remove_invalid_resource(void)
>     QemuUUID uuid;
>     int i;
> 
>+    virtio_dmabuf_init();
>     for (i = 0; i < 20; ++i) {
>         qemu_uuid_generate(&uuid);
>         g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
>@@ -78,6 +81,7 @@ static void test_add_invalid_resource(void)
>     struct vhost_dev *dev = NULL;
>     int i, dmabuf_fd = -2, alt_dmabuf = 2;
> 
>+    virtio_dmabuf_init();
>     for (i = 0; i < 20; ++i) {
>         qemu_uuid_generate(&uuid);
>         /* Add a new resource with invalid (negative) resource fd */
>@@ -108,6 +112,7 @@ static void test_free_resources(void)
>     QemuUUID uuids[20];
>     int i, dmabuf_fd;
> 
>+    virtio_dmabuf_init();
>     for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
>         qemu_uuid_generate(&uuids[i]);
>         dmabuf_fd = g_random_int_range(3, 500);
>-- 
>2.43.1
>
>

