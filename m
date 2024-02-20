Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA254C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNYi-0004Xd-La; Tue, 20 Feb 2024 05:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcNYg-0004XQ-MH
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:41:06 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcNYe-0001uP-C7
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:41:05 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a3e891b5e4eso215363766b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 02:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708425662; x=1709030462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Fk/8xWzhbIT0C/mQXPqK/yaZTZF3wYuFrin0OLRQpfo=;
 b=kLLYUaCE/OKgUNF9qXYhG5rQqm85f8jIfaL++tTpRP6Y2fswmFDpVgIjkCc5hCuamg
 LxxvwDYvPlLZUot2JuXTHFtJl37Fb+ftIFhQt+6t34zYCbLs6mnHsvRH4lcJKBzAvM/T
 U6qT7X+v2+yWNWVUGEsa1w7QtOVaH3RleojD5nBUcChlRKMXG++AKmAltiqmgZWox98r
 GtgrbqDXs5/O21P/Zg5JP6BCRrBNLZW1ThNJn77BNgWi3kK5CxB+XjOyhCWsolLtUC/E
 A6Q4TK3p4RaUy3F48uK9yAAgrzQm0SHH0/mWtIEEtGWC+/Lgr3KW9HIheDjNH46aQSHO
 1W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708425662; x=1709030462;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fk/8xWzhbIT0C/mQXPqK/yaZTZF3wYuFrin0OLRQpfo=;
 b=AcRwPmkGFrNLyOmjZYP9+td/kUoM+8LfXWklRpVTKnreRETHaRFwByxocaX+N7lv2a
 +jjbrEjZlLq3sEqStqyb+FkNKc1EC0qEX9kKt/d4TZrB+5zSXUTdZPgQvoEQkjm1nmIG
 mtuRLTfOaUrdIJgF0b7xSZQtQchg/YxctKvYJwlWq67nPH5l1x712jL5EuV2JemqPYav
 Nr4mZ7qqp/WK/AyJ98Lb4htAOamifIjHy1bGz7tC2Eu+kChJByy+R72ZTwcgiEgoblnS
 UeS0kFc0WqXc4gD96JVa4EGz8k4ScP5TxS6Eo0TD16UkP6jR3xkXTOU/srg85ORAXy6p
 txaw==
X-Gm-Message-State: AOJu0YwHYSZRAWWk/8eGBWRatYTULRww+m9ckyFFIZMpKQWHoJ5Q7l38
 YnNWkR152W2XC+rlpu6Owo7QjK1DBrKo31QDiOn1d1//W5gAfFNmul3gAAG6KxZ/i0QFlhn3tuk
 5e4I=
X-Google-Smtp-Source: AGHT+IF5J8BU+eU2gyUiMoEM/ZV5tgBOsTZmuTJr99IFEjM1GkKq4nlvZ/sMfSz7b3aIiOq6bDvx+A==
X-Received: by 2002:a17:906:a1cd:b0:a3c:f0ec:cff9 with SMTP id
 bx13-20020a170906a1cd00b00a3cf0eccff9mr7965873ejb.7.1708425662565; 
 Tue, 20 Feb 2024 02:41:02 -0800 (PST)
Received: from meli.delivery (adsl-101.37.6.0.tellas.gr. [37.6.0.101])
 by smtp.gmail.com with ESMTPSA id
 af1-20020a170906998100b00a3ecfef7f1esm1201170ejc.189.2024.02.20.02.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 02:41:02 -0800 (PST)
Date: Tue, 20 Feb 2024 12:39:22 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Albert Esteve <aesteve@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 alex.bennee@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@gmail.com, Albert Esteve <aesteve@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 4/5] hw/virtio: cleanup shared resources
User-Agent: meli 0.8.5-rc.3
References: <20240219143423.272012-1-aesteve@redhat.com>
 <20240219143423.272012-5-aesteve@redhat.com>
In-Reply-To: <20240219143423.272012-5-aesteve@redhat.com>
Message-ID: <95hoc.mwh14km4v8ef@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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

On Mon, 19 Feb 2024 16:34, Albert Esteve <aesteve@redhat.com> wrote:
>Ensure that we cleanup all virtio shared
>resources when the vhost devices is cleaned
>up (after a hot unplug, or a crash).
>
>To do so, we add a new function to the virtio_dmabuf
>API called `virtio_dmabuf_vhost_cleanup`, which
>loop through the table and removes all
>resources owned by the vhost device parameter.
>
>Also, add a test to verify that the new
>function in the API behaves as expected.
>
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>---



Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


> hw/display/virtio-dmabuf.c        | 21 ++++++++++++++++++++
> hw/virtio/vhost.c                 |  3 +++
> include/hw/virtio/virtio-dmabuf.h | 10 ++++++++++
> tests/unit/test-virtio-dmabuf.c   | 33 +++++++++++++++++++++++++++++++
> 4 files changed, 67 insertions(+)
>
>diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
>index 961094a561..703b5bd979 100644
>--- a/hw/display/virtio-dmabuf.c
>+++ b/hw/display/virtio-dmabuf.c
>@@ -141,6 +141,27 @@ SharedObjectType virtio_object_type(const QemuUUID *uuid)
>     return vso->type;
> }
> 
>+static bool virtio_dmabuf_resource_is_owned(gpointer key,
>+                                            gpointer value,
>+                                            gpointer dev)
>+{
>+    VirtioSharedObject *vso;
>+
>+    vso = (VirtioSharedObject *) value;
>+    return vso->type == TYPE_VHOST_DEV && vso->value.dev == dev;
>+}
>+
>+int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev)
>+{
>+    int num_removed;
>+
>+    WITH_QEMU_LOCK_GUARD(&lock) {
>+        num_removed = g_hash_table_foreach_remove(
>+            resource_uuids, (GHRFunc) virtio_dmabuf_resource_is_owned, dev);
>+    }
>+    return num_removed;
>+}
>+
> void virtio_free_resources(void)
> {
>     WITH_QEMU_LOCK_GUARD(&lock) {
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 2c9ac79468..c5622eac14 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -16,6 +16,7 @@
> #include "qemu/osdep.h"
> #include "qapi/error.h"
> #include "hw/virtio/vhost.h"
>+#include "hw/virtio/virtio-dmabuf.h"
> #include "qemu/atomic.h"
> #include "qemu/range.h"
> #include "qemu/error-report.h"
>@@ -1599,6 +1600,8 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>     migrate_del_blocker(&hdev->migration_blocker);
>     g_free(hdev->mem);
>     g_free(hdev->mem_sections);
>+    /* free virtio shared objects */
>+    virtio_dmabuf_vhost_cleanup(hdev);
>     if (hdev->vhost_ops) {
>         hdev->vhost_ops->vhost_backend_cleanup(hdev);
>     }
>diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
>index 627d84dce9..950cd24967 100644
>--- a/include/hw/virtio/virtio-dmabuf.h
>+++ b/include/hw/virtio/virtio-dmabuf.h
>@@ -119,6 +119,16 @@ struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid);
>  */
> SharedObjectType virtio_object_type(const QemuUUID *uuid);
> 
>+/**
>+ * virtio_dmabuf_vhost_cleanup() - Destroys all entries of the shared
>+ * resources lookup table that are owned by the vhost backend
>+ * @dev: the pointer to the vhost device that owns the entries. Data is owned
>+ *       by the called of the function.
>+ * 
>+ * Return: the number of resource entries removed.
>+ */
>+int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev);
>+
> /**
>  * virtio_free_resources() - Destroys all keys and values of the shared
>  * resources lookup table, and frees them
>diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
>index 20213455ee..e5cf7ee19f 100644
>--- a/tests/unit/test-virtio-dmabuf.c
>+++ b/tests/unit/test-virtio-dmabuf.c
>@@ -107,6 +107,38 @@ static void test_add_invalid_resource(void)
>     }
> }
> 
>+static void test_cleanup_res(void)
>+{
>+    QemuUUID uuids[20], uuid_alt;
>+    struct vhost_dev *dev = g_new0(struct vhost_dev, 1);
>+    struct vhost_dev *dev_alt = g_new0(struct vhost_dev, 1);
>+    int i, num_removed;
>+
>+    for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
>+        qemu_uuid_generate(&uuids[i]);
>+        virtio_add_vhost_device(&uuids[i], dev);
>+        /* vhost device is found */
>+        g_assert(virtio_lookup_vhost_device(&uuids[i]) != NULL);
>+    }
>+    qemu_uuid_generate(&uuid_alt);
>+    virtio_add_vhost_device(&uuid_alt, dev_alt);
>+    /* vhost device is found */
>+    g_assert(virtio_lookup_vhost_device(&uuid_alt) != NULL);
>+    /* cleanup all dev resources */
>+    num_removed = virtio_dmabuf_vhost_cleanup(dev);
>+    g_assert_cmpint(num_removed, ==, ARRAY_SIZE(uuids));
>+    for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
>+        /* None of the dev resources is found after free'd */
>+        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, -1);
>+    }
>+    /* uuid_alt is still in the hash table */
>+    g_assert(virtio_lookup_vhost_device(&uuid_alt) != NULL);
>+
>+    virtio_free_resources();
>+    g_free(dev);
>+    g_free(dev_alt);
>+}
>+
> static void test_free_resources(void)
> {
>     QemuUUID uuids[20];
>@@ -136,6 +168,7 @@ int main(int argc, char **argv)
>                     test_remove_invalid_resource);
>     g_test_add_func("/virtio-dmabuf/add_invalid_res",
>                     test_add_invalid_resource);
>+    g_test_add_func("/virtio-dmabuf/cleanup_dev", test_cleanup_res);
>     g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
> 
>     return g_test_run();
>-- 
>2.43.1
>
>

