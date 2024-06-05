Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD49C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEsZb-0000fC-JB; Wed, 05 Jun 2024 11:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1sEsZa-0000eS-Bg
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:29:10 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1sEsZU-0007XJ-KT
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:29:10 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c1a4192d55so1883460a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717601343; x=1718206143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muSU+HuMkQPsObvQhf3lD7P12fVE5VIQ4NmZQsA6m0g=;
 b=HNOCXB6xVxdacRa22KhOY7hG1lpGE+S2Xf/ryk7tbugcUdcy3ZYXdolN1sm3QJ/3U6
 /iaD/La3Fxkx/tlftVqYvGr/ugtaMsB3UyjIQLGW8Ft0kLPfcW5XGO84bPVnH7I89m1K
 Fm2BA/4KsTXv6Cst8NOPlXx0KEFJjS9E4+DdZWNd4Ik8X6l04ZTGNNIYyuhq0oaIoY5R
 pEVkUrw0Kc7PZeoAKnv0zskVlGNqwwMyVXRVB/V4yWrC6QH7xQN/KGUUfgQR9c8Ob/PC
 hcVOxfXn+6/9JvyNQm3nkJ4A3vnvoeQQLl6D9RlKjw1Fr0jPmDjYAFXAhq+R4Ht9dLL8
 4KWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717601343; x=1718206143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muSU+HuMkQPsObvQhf3lD7P12fVE5VIQ4NmZQsA6m0g=;
 b=w2GOcYCiMWXmpL25lwHdZWMNLP2vGp1XnXzOdm2THP23F4LdWkLNfc3cl2Wn3U4+F/
 huB23A+4OiIqAWz0ju3fhTt1Q+HQKRjjK3giKmnglqZZ8kSRK+qou7iT2CBzozdSwqD8
 jbUUUlzadOn9SOntDWvU5jFlex3YPfHL4EYQVmq3afa1KCrV6O/qZkI9d2SdE7AiuPJs
 i7KbyMJ8iso/UiGdqshHKVsfFRdmkLRTh4gEu4EI2bOlfkmqOedQGznF1HCtQRgmWwFl
 V41PW21d4MYTog5G2KfEjw71HNcBgYqO6o4qMF5PzW/r/ij/zHq3VzF5Lms5WUVJpJ/p
 B7QQ==
X-Gm-Message-State: AOJu0Yw1+U9q28hs57mvoeTZvwjp5nybjsy+7hzPAYjuy6ZAiL2fcO50
 b0NIDfrBzC2vplKFj9lkGjbxyRooB0yfUtl44rzqVNEGJAmPqBDvVITPepNNTvY=
X-Google-Smtp-Source: AGHT+IH0VUmOcWnQskUVsFXf+siPRGl4HlLJ66Psc34i7l0h1fB2Gl+Kfr7yhHO16R1XzJ4s85HSZg==
X-Received: by 2002:a17:90a:ac16:b0:2bf:ac8a:c795 with SMTP id
 98e67ed59e1d1-2c27db4a1e3mr3250415a91.34.1717601342914; 
 Wed, 05 Jun 2024 08:29:02 -0700 (PDT)
Received: from localhost ([103.192.227.74]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28063a485sm1623884a91.3.2024.06.05.08.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 08:29:02 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/3] virtio-gpu: rutabaga: Poll rutabaga upon events
Date: Wed,  5 Jun 2024 23:28:29 +0800
Message-ID: <20240605152832.11618-3-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
References: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

To make virglrenderer work properly, we must poll it periodically or
when the event fd is readable, but this functionality is absent now.
This change registers the event fd as a gsource to the main loop and
attaches polling function as callback to the gsource.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 hw/display/virtio-gpu-rutabaga.c | 97 +++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-gpu.h   |  1 +
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 2ba6869606..ecb146315a 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -899,6 +899,93 @@ virtio_gpu_rutabaga_aio_cb(void *opaque)
     g_free(data);
 }
 
+
+static void
+virtio_gpu_fence_poll(void *opaque)
+{
+    VirtIOGPU *g = opaque;
+    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
+
+    rutabaga_poll(vr->rutabaga);
+}
+
+typedef void (*vu_watch_cb) (VirtIOGPURutabaga *dev, int condition, void *data);
+
+static void
+event_poll_cb(VirtIOGPURutabaga *dev, int condition, void *data)
+{
+    virtio_gpu_fence_poll(data);
+}
+
+typedef struct VrSrc {
+    GSource parent;
+    VirtIOGPURutabaga *dev;
+    GPollFD gfd;
+} VrSrc;
+
+static gboolean
+vr_src_prepare(GSource *gsrc, gint *timeout)
+{
+    g_assert(timeout);
+
+    *timeout = -1;
+    return FALSE;
+}
+
+static gboolean
+vr_src_check(GSource *gsrc)
+{
+    VrSrc *src = (VrSrc *)gsrc;
+
+    g_assert(src);
+
+    return src->gfd.revents & src->gfd.events;
+}
+
+static gboolean
+vr_src_dispatch(GSource *gsrc, GSourceFunc cb, gpointer data)
+{
+    VrSrc *src = (VrSrc *)gsrc;
+
+    g_assert(src);
+
+    ((vu_watch_cb)cb)(src->dev, src->gfd.revents, data);
+
+    return G_SOURCE_CONTINUE;
+}
+
+static GSourceFuncs vug_src_funcs = {
+    vr_src_prepare,
+    vr_src_check,
+    vr_src_dispatch,
+    NULL
+};
+
+static GSource *
+vr_source_new(VirtIOGPURutabaga *dev, int fd, GIOCondition cond,
+              vu_watch_cb vu_cb, gpointer data)
+{
+    GSource *gsrc;
+    VrSrc *src;
+    guint id;
+
+    g_assert(fd >= 0);
+    g_assert(vu_cb);
+
+    gsrc = g_source_new(&vug_src_funcs, sizeof(VrSrc));
+    g_source_set_callback(gsrc, (GSourceFunc)vu_cb, data, NULL);
+    src = (VrSrc *)gsrc;
+    src->dev = dev;
+    src->gfd.fd = fd;
+    src->gfd.events = cond;
+
+    g_source_add_poll(gsrc, &src->gfd);
+    id = g_source_attach(gsrc, g_main_context_get_thread_default());
+    g_assert(id);
+
+    return gsrc;
+}
+
 static void
 virtio_gpu_rutabaga_fence_cb(uint64_t user_data,
                              const struct rutabaga_fence *fence)
@@ -954,6 +1041,7 @@ virtio_gpu_rutabaga_debug_cb(uint64_t user_data,
 static bool virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)
 {
     int result;
+    int poll_descriptor;
     struct rutabaga_builder builder = { 0 };
     struct rutabaga_channel channel = { 0 };
     struct rutabaga_channels channels = { 0 };
@@ -1031,7 +1119,14 @@ static bool virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)
         error_setg_errno(errp, -result, "Failed to init rutabaga");
         return false;
     }
-
+    result = rutabaga_poll_descriptor(vr->rutabaga, &poll_descriptor);
+    if (result) {
+        error_setg_errno(errp, -result, "Failed to get rutabaga poll descriptor");
+        return false;
+    }
+    if (poll_descriptor >= 0)
+        vr->poll_event_source = vr_source_new(vr, poll_descriptor, G_IO_IN,
+                                              event_poll_cb, g);
     return true;
 }
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7a59379f5a..47a4347a9e 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -261,6 +261,7 @@ struct VirtIOGPURutabaga {
     char *wsi;
     bool headless;
     uint32_t num_capsets;
+    GSource *poll_event_source;
     struct rutabaga *rutabaga;
 };
 
-- 
2.45.0


