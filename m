Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD4DEF900F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpQz-0003qC-CT; Wed, 04 Mar 2026 11:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQy-0003pc-Dd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:52 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQv-0002PL-Hc
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:52 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-65f812e0d93so10937041a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643047; x=1773247847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XB0LouhneiGd1+ORaYMQ9LlDP2eplcvPYyqDfPmQLc4=;
 b=uMizcNxEYRjuUiLgZ/Cux8lQDmlAOmEULInGcpL95KscZNPdvoife97Ec2fAPtmoFM
 u7gCx6w5FF6N1SiaqKfyGW8WcSkngcF1zlqKSpJWouKF+9mJUSFjJqkcIYbKPDzxpg7s
 PXU9SqAz9OJwMAnYy8RrrxmfTN7sjEqqsfiTWQ9h5GWRXgT+mXYQygaGaMBNhqKULbEZ
 JidNvcIYYrzjxiMhj9yKmtxHNwGNbfpiHrbSy2VrCRMPQ+9ts6WeL/fuCgJ6s2/Y5/Kv
 bksRS+Tm3UmAvxS8jGV+BDo6oHTKgfc3QYn0JXGHhdo2n31CBn0emWBtG5uAzYuOnuB0
 MSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643047; x=1773247847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XB0LouhneiGd1+ORaYMQ9LlDP2eplcvPYyqDfPmQLc4=;
 b=CHmPisLCUqjbtJvhTEG3ab8fkVZERIA+u0lTVbFGRZbJ4F7YerzJlsoRv7g3+OFrb5
 SMGEcZsutLTX6IQsxZfZm4DiecLXUvh4KyAO8ZVxbEbbPrr8oqBxvl8hJUSJHZZraf1C
 ukNZ/pWa7NujD10rsN0NKsF99LgJlT9O4QbQzKH9zFibr8zWql5dnQTzh3/geoA2W1ym
 QohnH1xrKEAAyrm+gOuOMJDBHYjIp6sK/fpHIKGiNupwXToNFL5MOw3AT4amRcVMQkrU
 sqB8Z7m5nqNNW1OtwrXGIjJz0qn1tu5XM/gYAdOcxjeoNZVCKSsbpM61U46vD1Xp1ELR
 rAjQ==
X-Gm-Message-State: AOJu0YwTJGgj/FaFY7Yiw0zoGOqmL6ko1Nq5z2BmT1ghp0vcOA9Racq9
 GWWnJrH3e5Qs08NDmORIzY8DvmqWcvQ+2q5A2hPLfNMwFn0xIMMVBH0ET/e1zLxvM5s=
X-Gm-Gg: ATEYQzzDJP0Fhb0Zw00m/bKrL1tdIhKspYs5XYli3fb06zZaNJ8b1h5MiUdIPGvCmwN
 N6i+FfW/jWsrGeFp+TLPTxHFxOnrnD00KIieOTl4bTI3vE9fjRtkrBxpqsY4fqmX7/dw4lH1TWQ
 s+pcTkio53CHVORor2DYZBNC4NrshDFWIFtodJtRYmG/HyMRjP9Kbr3gTHUc+XFpDxbeT+qrDdD
 3ODDA23UGQIbJtCe4XWKOGvGKm5cHTo2P0awWPIw5CZG5ZiPByM9sfg95f7b57cCtDUEpQQqaIS
 Iop97dQ6c6hRjhndWsrQ9pB1LKpLVHirWclO8E/OE5te1HpLD51+VWtbZmaychndw7AnuH1reEH
 nezRSWvECTjRArILf32YHv6kyR7JzIbUT4EJfeK1UKnk+cpRhlZ7U6f8D31P8nY0xEochyMrdI8
 9/i8PH8Ev/DHPSyfCd1YqEx8U=
X-Received: by 2002:a17:907:720b:b0:b93:6233:5fb2 with SMTP id
 a640c23a62f3a-b93f14306a5mr156205066b.41.1772643046542; 
 Wed, 04 Mar 2026 08:50:46 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b93968f2250sm575648466b.31.2026.03.04.08.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E0C0E5FC09;
 Wed, 04 Mar 2026 16:50:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH 02/20] virtio-gpu: Fix scanout dmabuf cleanup during resource
 destruction
Date: Wed,  4 Mar 2026 16:50:24 +0000
Message-ID: <20260304165043.1437519-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Dongwon Kim <dongwon.kim@intel.com>

When a virtio-gpu resource is destroyed, any associated udmabuf must be
properly torn down. Currently, the code may leave dangling references
to dmabuf file descriptors in the scanout primary buffers.

This patch updates virtio_gpu_fini_udmabuf to:
1. Iterate through all active scanouts.
2. Identify dmabufs that match the resource's file descriptor.
3. Close the dmabuf and invalidate the resource's FD reference to
   prevent use-after-free or double-close scenarios.
4. Finally, trigger the underlying udmabuf destruction.

This ensures that the display backend does not attempt to access
memory or FDs that have been released by the guest or the host.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260303010047.1925589-1-dongwon.kim@intel.com>
[AJB: fixed stub declaration]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/virtio/virtio-gpu.h        |  3 ++-
 hw/display/virtio-gpu-udmabuf-stubs.c |  2 +-
 hw/display/virtio-gpu-udmabuf.c       | 25 ++++++++++++++++++-------
 hw/display/virtio-gpu.c               |  2 +-
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 58e0f91fda6..65312f869dd 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -357,7 +357,8 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
 /* virtio-gpu-udmabuf.c */
 bool virtio_gpu_have_udmabuf(void);
 void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res);
+void virtio_gpu_fini_udmabuf(VirtIOGPU *g,
+                             struct virtio_gpu_simple_resource *res);
 int virtio_gpu_update_dmabuf(VirtIOGPU *g,
                              uint32_t scanout_id,
                              struct virtio_gpu_simple_resource *res,
diff --git a/hw/display/virtio-gpu-udmabuf-stubs.c b/hw/display/virtio-gpu-udmabuf-stubs.c
index f692e135103..85d03935a33 100644
--- a/hw/display/virtio-gpu-udmabuf-stubs.c
+++ b/hw/display/virtio-gpu-udmabuf-stubs.c
@@ -12,7 +12,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     /* nothing (stub) */
 }
 
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
+void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *res)
 {
     /* nothing (stub) */
 }
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d804f321aa3..bd5b44f5fba 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -151,13 +151,6 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     res->blob = pdata;
 }
 
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
-{
-    if (res->remapped) {
-        virtio_gpu_destroy_udmabuf(res);
-    }
-}
-
 static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
 {
     struct virtio_gpu_scanout *scanout;
@@ -169,6 +162,24 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
     g_free(dmabuf);
 }
 
+void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *res)
+{
+    int max_outputs = g->parent_obj.conf.max_outputs;
+    int i;
+
+    for (i = 0; i < max_outputs; i++) {
+        VGPUDMABuf *dmabuf = g->dmabuf.primary[i];
+
+        if (dmabuf && (res->dmabuf_fd != -1) &&
+            qemu_dmabuf_get_fds(dmabuf->buf, NULL)[0] == res->dmabuf_fd) {
+            qemu_dmabuf_close(dmabuf->buf);
+            res->dmabuf_fd = -1;
+        }
+    }
+
+    virtio_gpu_destroy_udmabuf(res);
+}
+
 static VGPUDMABuf
 *virtio_gpu_create_dmabuf(VirtIOGPU *g,
                           uint32_t scanout_id,
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 643e91ca2a7..b2af861f0d8 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -902,7 +902,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
     res->addrs = NULL;
 
     if (res->blob) {
-        virtio_gpu_fini_udmabuf(res);
+        virtio_gpu_fini_udmabuf(g, res);
     }
 }
 
-- 
2.47.3


