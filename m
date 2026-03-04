Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69547EF9016
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR5-0003u5-CG; Wed, 04 Mar 2026 11:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR3-0003tQ-QH
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:57 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR1-0002Rj-CK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:57 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so766520766b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643054; x=1773247854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJmoRqaZG5iu6xmMVKnJGNOL+RO6aLUM+Ssy8DYxWzU=;
 b=AP4MfwUZXfb1HMHoERXNcYkf6oBGaXJFGHG7NrMpRHfLWWVRavP682JlHbQBsDJDtN
 bInCyQnhFtex+iO8MWN/vVXfHQt792QyNZ0qgWEdlGVi5Fg6rBp47LkmuYKG/NG4qBvU
 2b01K3FChsvhuu+L4D9WIzIZe0/ZJeCLY+TlxttZZn8BdCEdnf2EUBvTEHUCMo6sk9BH
 en/NVNgRzA9dAcfpK+jqgXQkPyXB8bgKYBLeNlZkPcL/gt7a1AKeo7d9dqVFNdHL6/H9
 TB6ASLYuOXuI5x8Pp2/15hk6gTa3WvO6sZywJBtRFG1Kg0uorGDp1d69TI0gINzqOAPJ
 WybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643054; x=1773247854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bJmoRqaZG5iu6xmMVKnJGNOL+RO6aLUM+Ssy8DYxWzU=;
 b=NcAQQiLTSI5QuzHNth8RbaJg8GLvOaXwQvjmuCpdnYX5fhv5sgQ6oScOpSKgNt4YGP
 vY5fsoSUNzRo6Kv4NSMY3SR5SjY1exiEMNieRnaM1eSzMY4grj75jsUu/Os1qdxSpTe+
 z4tiv5s4GiuKG/n0iOIakqM/JaPRN4soxgVIG22QJPbLdg6YOwfZrJKiw2w5TSpsUVFV
 KpcwXf6/A0Ug7/zdxwWdYEiJz+HaVZHnh0M8IJwcqHgfbJUvm3QCil2JekCrk3+VJVdk
 HixJvyWNHvirme8iBVmFzXRXYKC2QfLC+5jPIXq+cD1yg42TqSgHL6USQprVNwif8U0w
 2thQ==
X-Gm-Message-State: AOJu0YxgGlT9eDOh4oCdmCry5FmmU48YrAuJM/xhmYWtNtlRJ1jmm/NU
 4/eIdEFEuSXnPGX1+vh+YgMYdXUzVNMZ8+4gTFwGTYjJkm/hPYwT0q9t2+A7BJ0LbL8=
X-Gm-Gg: ATEYQzypQcMVGpyRLSjA/sOtShvkjsjBaiSVOd796WSRWhS0YeBCzYGgjSIu3Zd57mM
 dop7uueugZX3rdXhIS5UKz56bZdiV7m1AOnzPu/zm8rCShLFy5iV1Xy8+bojnE13qUoAxdU4/EG
 Kqcwt+/xrsSZSOYUFMWDBSFyEs5zc0CL+pASOukgoe5UEActpo5BXSM3neT+AYBQchGOCgOSLH4
 KEtizkLTgD3fmRDWOSXGvLmgaZt2nhenH/LcgfF/6DRaJlazaT1oXUYZEVQiD5stl4e71xFC30L
 jcxoAKfm6iGMW0Oj4PiCeKcGWXlq+9N3xzFLZJqkj2l1F5Odjhznpq7K5EqEZsxvFVlm+lMglu4
 pVqfaWmfbvHbYF4chOte8lSg8s8csvOmx1nFDQ3S7m9jFX1O+XinYuHBwa2TuxxbC+tnbqfza3d
 zDvUaX79llOTqJyYahswl2C+lR9ZAhugJ2Mw==
X-Received: by 2002:a17:906:f59f:b0:b93:c5a9:a5e6 with SMTP id
 a640c23a62f3a-b93f116ab5cmr160716966b.2.1772643053564; 
 Wed, 04 Mar 2026 08:50:53 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-660bf4d8249sm1678736a12.17.2026.03.04.08.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 88E2762D44;
 Wed, 04 Mar 2026 16:50:44 +0000 (GMT)
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
 qemu-stable@nongnu.org
Subject: [PATCH 09/20] virtio-gpu: Ensure BHs are invoked only from main-loop
 thread
Date: Wed,  4 Mar 2026 16:50:31 +0000
Message-ID: <20260304165043.1437519-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

QEMU's display GL core is tied to main-loop thread and virtio-gpu
interacts with display while processing GPU commands. Virtio-gpu BHs
work in generic AIO context that can be invoked on vCPU thread, while
GL and UI toolkits are bound to the main-loop thread.

Make virtio-gpu BHs use iohandler AIO context that is handled in a
main-loop thread only.

 0  SDL_GL_MakeCurrent() (libSDL3)
 1  SDL_GL_MakeCurrent_REAL() (libSDL2)
 2  sdl2_gl_make_context_current() (ui/sdl2-gl.c:201)
 3  make_current() (virglrenderer.c:639)
 4  vrend_finish_context_switch() (vrend_renderer.c:11630)
 5  vrend_hw_switch_context() (vrend_renderer.c:11613)
 6  vrend_renderer_force_ctx_0() (vrend_renderer.c:12986)
 7  virgl_renderer_force_ctx_0() (virglrenderer.c:460)
 8  virtio_gpu_virgl_process_cmd() (virtio-gpu-virgl.c:1013)
 9  virtio_gpu_process_cmdq() (virtio-gpu.c:1050)
 10 virtio_gpu_gl_handle_ctrl() (virtio-gpu-gl.c:86)
 11 aio_bh_poll() (util/async.c)
 12 aio_poll() (util/aio-posix.c)
 13 blk_pwrite() (block/block-gen.c:1985)
 14 pflash_update() (pflash_cfi01.c:396)
 15 pflash_write() (pflash_cfi01.c:541)
 16 memory_region_dispatch_write() (system/memory.c:1554)
 17 flatview_write() (system/physmem.c:3333)
 18 address_space_write() (system/physmem.c:3453)
 19 kvm_cpu_exec() (accel/kvm/kall-all.c:3248)
 20 kvm_vcpu_thread_fn() (accel/kvm/kaccel-ops.c:53)

Cc: qemu-stable@nongnu.org
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-8-dmitry.osipenko@collabora.com>
---
 include/hw/virtio/virtio.h    | 10 ++++++++++
 hw/display/virtio-gpu-virgl.c |  6 +++---
 hw/display/virtio-gpu.c       |  6 +++---
 hw/virtio/virtio.c            | 10 ++++++++++
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9dd93cf965a..6fb823f241f 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -547,4 +547,14 @@ QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
 #define virtio_bh_new_guarded(dev, cb, opaque) \
     virtio_bh_new_guarded_full((dev), (cb), (opaque), (stringify(cb)))
 
+/*
+ * The "_io" variant runs BH only on a main-loop thread, while generic BH
+ * may run on a vCPU thread.
+ */
+QEMUBH *virtio_bh_io_new_guarded_full(DeviceState *dev,
+                                      QEMUBHFunc *cb, void *opaque,
+                                      const char *name);
+#define virtio_bh_io_new_guarded(dev, cb, opaque) \
+    virtio_bh_io_new_guarded_full((dev), (cb), (opaque), (stringify(cb)))
+
 #endif
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 0f754829fb7..10c4b5160f4 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1203,9 +1203,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 
 #if VIRGL_VERSION_MAJOR >= 1
-    gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
-                                    virtio_gpu_virgl_resume_cmdq_bh,
-                                    g);
+    gl->cmdq_resume_bh = virtio_bh_io_new_guarded(DEVICE(g),
+                                                  virtio_gpu_virgl_resume_cmdq_bh,
+                                                  g);
 #endif
 
     return 0;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b2af861f0d8..a89d49aa8cc 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1526,9 +1526,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 
     g->ctrl_vq = virtio_get_queue(vdev, 0);
     g->cursor_vq = virtio_get_queue(vdev, 1);
-    g->ctrl_bh = virtio_bh_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
-    g->cursor_bh = virtio_bh_new_guarded(qdev, virtio_gpu_cursor_bh, g);
-    g->reset_bh = qemu_bh_new(virtio_gpu_reset_bh, g);
+    g->ctrl_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
+    g->cursor_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_cursor_bh, g);
+    g->reset_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_reset_bh, g);
     qemu_cond_init(&g->reset_cond);
     QTAILQ_INIT(&g->reslist);
     QTAILQ_INIT(&g->cmdq);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e9d55329525..7c486833075 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4497,3 +4497,13 @@ QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
     return qemu_bh_new_full(cb, opaque, name,
                             &transport->mem_reentrancy_guard);
 }
+
+QEMUBH *virtio_bh_io_new_guarded_full(DeviceState *dev,
+                                      QEMUBHFunc *cb, void *opaque,
+                                      const char *name)
+{
+    DeviceState *transport = qdev_get_parent_bus(dev)->parent;
+
+    return aio_bh_new_full(iohandler_get_aio_context(), cb, opaque, name,
+                           &transport->mem_reentrancy_guard);
+}
-- 
2.47.3


