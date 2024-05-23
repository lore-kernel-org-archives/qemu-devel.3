Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942F6C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA2ka-0000El-Na; Thu, 23 May 2024 03:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA2kU-0000CQ-6f
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:20:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA2kR-0007K3-26
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:20:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-420180b5922so20174655e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716448820; x=1717053620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ztHb8wtSu2wZnFMiFBw4JthexfpC2luStpcFT6tZdC8=;
 b=Jxi1y2R3u7wPQCIGjS7VjuEb2a/i4MOu9eaOwa3Fi1jaZWEDXEGbgxRPKI6jZ5i7wB
 KQT1A5drssJdEmKuvBj1i8adCJUc0J5JlVazvL0125KOJpZ6wtSDbhIuMQoBK0jlMhVL
 DtVPC9ke96wJK6F4QkvktvUV+DNsGnKSK/NRpuyCOmZnMzT+Jcfn9Cyy00qZn08N1hv1
 r4bs7228OBVdIKtPTVD1rPvNgU09CMNVXekysFm0MK3dlp/WdvdZBnFwErGYfiEj7KgU
 EeNGYuH3WJdoi7BeYZNUkjzA43GbZLBPMlqEfSd9SIXUz2aS1g/L9LnFi8fkJhUo6cHx
 cWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716448820; x=1717053620;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ztHb8wtSu2wZnFMiFBw4JthexfpC2luStpcFT6tZdC8=;
 b=oP6jS+PPB8Owfo4EtBQA7iZoQ/GUKwPBOST9782PbVCVQ+Er2f/9FPwrXVqUbQS0AI
 fAuTW0MuwMv3LQ8o0PK37zlVWv8CBzF10FCPPYY9Z8/3AidwJwG1DuX3nDzUMw9DXNl4
 OtaBp7sFHLY9F9xqnY8kYZz0fZvVoLl7vhksRX7iFH4jNjQE38wG33g/YWQVnypq4vd0
 m1kTkOPgOiLGPdjTvFoLaQh/ESgZHLpUu80jf4rv66M5Osxqy0EGMc9R8t01Sc8a3mIu
 +v+DK9W0wXzF+GS9m3R98B4+G95wUKMXZW0JqhJc2vI7lDpT/mtEMIi7gwL47AbYAbOG
 /Fzg==
X-Gm-Message-State: AOJu0YxZF03MAzDEc+f93jVfzrrrQGtcm18+U+AxIY2h6kGgVtmISYZT
 TA6zvzDlQWguLKJ/Q2ehDBst84mC9VjOq0kjrQu2vxFkc/UrTIsuB6Bq9/Q2E//VPXlttcxqxGG
 W
X-Google-Smtp-Source: AGHT+IHnLnHRZH4IyZnbk9PjDmWxpLJiNvIuDIKDV8DZbq7UjVkh8QKMXJUBopERUtwE0D09um2qqg==
X-Received: by 2002:a7b:c4c8:0:b0:420:71f7:9752 with SMTP id
 5b1f17b1804b1-420fd320e8emr38452605e9.18.1716448820575; 
 Thu, 23 May 2024 00:20:20 -0700 (PDT)
Received: from meli-email.org (adsl-73.37.6.3.tellas.gr. [37.6.3.73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f5a576sm16445465e9.22.2024.05.23.00.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 00:20:20 -0700 (PDT)
Date: Thu, 23 May 2024 10:18:54 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 Roger Pau Monn=?UTF-8?B?w6kg?=<roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 Christian K=?UTF-8?B?w7Y=?= nig <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v12 13/13] virtio-gpu: Support Venus context
User-Agent: meli 0.8.5
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <20240519212712.2605419-14-dmitry.osipenko@collabora.com>
In-Reply-To: <20240519212712.2605419-14-dmitry.osipenko@collabora.com>
Message-ID: <dxgdu.i7na48y6cl2y@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

On Mon, 20 May 2024 00:27, Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>From: Antonio Caggiano <antonio.caggiano@collabora.com>
>
>Request Venus when initializing VirGL and if venus=true flag is set for
>virtio-gpu-gl device.
>
>Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>Signed-off-by: Huang Rui <ray.huang@amd.com>
>Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>---
> hw/display/virtio-gpu-gl.c     |  2 ++
> hw/display/virtio-gpu-virgl.c  | 22 ++++++++++++++++++----
> hw/display/virtio-gpu.c        | 13 +++++++++++++
> include/hw/virtio/virtio-gpu.h |  3 +++
> meson.build                    |  1 +
> 5 files changed, 37 insertions(+), 4 deletions(-)
>
>diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>index b8f395be8d2d..2078e74050bb 100644
>--- a/hw/display/virtio-gpu-gl.c
>+++ b/hw/display/virtio-gpu-gl.c
>@@ -148,6 +148,8 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
> static Property virtio_gpu_gl_properties[] = {
>     DEFINE_PROP_BIT("stats", VirtIOGPU, parent_obj.conf.flags,
>                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
>+    DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
>+                    VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
>     DEFINE_PROP_END_OF_LIST(),
> };
> 
>diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>index 70e2d28ba966..2e9862dd186a 100644
>--- a/hw/display/virtio-gpu-virgl.c
>+++ b/hw/display/virtio-gpu-virgl.c
>@@ -1130,6 +1130,11 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>         flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
>     }
> #endif
>+#ifdef VIRGL_RENDERER_VENUS
>+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
>+        flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
>+    }
>+#endif
> 
>     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>     if (ret != 0) {
>@@ -1161,7 +1166,7 @@ static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t capset_id)
> 
> GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
> {
>-    uint32_t capset2_max_ver, capset2_max_size;
>+    uint32_t capset_max_ver, capset_max_size;
>     GArray *capset_ids;
> 
>     capset_ids = g_array_new(false, false, sizeof(uint32_t));
>@@ -1170,12 +1175,21 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
>     virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
> 
>     virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
>-                              &capset2_max_ver,
>-                              &capset2_max_size);
>-    if (capset2_max_ver) {
>+                               &capset_max_ver,
>+                               &capset_max_size);
>+    if (capset_max_ver) {
>         virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2);
>     }
> 
>+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
>+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
>+                                   &capset_max_ver,
>+                                   &capset_max_size);
>+        if (capset_max_size) {
>+            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VENUS);
>+        }
>+    }
>+
>     return capset_ids;
> }
> 
>diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>index 052ab493a00b..0518bb858e88 100644
>--- a/hw/display/virtio-gpu.c
>+++ b/hw/display/virtio-gpu.c
>@@ -1491,6 +1491,19 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
> #endif
>     }
> 
>+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
>+#ifdef HAVE_VIRGL_VENUS
>+        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
>+            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
>+            error_setg(errp, "venus requires enabled blob and hostmem options");
>+            return;
>+        }
>+#else
>+        error_setg(errp, "old virglrenderer, venus unsupported");
>+        return;
>+#endif
>+    }
>+
>     if (!virtio_gpu_base_device_realize(qdev,
>                                         virtio_gpu_handle_ctrl_cb,
>                                         virtio_gpu_handle_cursor_cb,
>diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>index 7e1fee836802..ec5d7517f141 100644
>--- a/include/hw/virtio/virtio-gpu.h
>+++ b/include/hw/virtio/virtio-gpu.h
>@@ -99,6 +99,7 @@ enum virtio_gpu_base_conf_flags {
>     VIRTIO_GPU_FLAG_BLOB_ENABLED,
>     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
>     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
>+    VIRTIO_GPU_FLAG_VENUS_ENABLED,
> };
> 
> #define virtio_gpu_virgl_enabled(_cfg) \
>@@ -117,6 +118,8 @@ enum virtio_gpu_base_conf_flags {
>     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
> #define virtio_gpu_hostmem_enabled(_cfg) \
>     (_cfg.hostmem > 0)
>+#define virtio_gpu_venus_enabled(_cfg) \
>+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
> 

Can we have both venus and rutabaga enabled on the same virtio-gpu 
device? How would that work? It seems to me they should be mutually 
exclusive.


> struct virtio_gpu_base_conf {
>     uint32_t max_outputs;
>diff --git a/meson.build b/meson.build
>index 503a7736eda0..5a2b7b660c67 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -2305,6 +2305,7 @@ if virgl.version().version_compare('>=1.0.0')
>   config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT', 1)
>   config_host_data.set('HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS', 1)
>   config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
>+  config_host_data.set('HAVE_VIRGL_VENUS', 1)
> endif
> config_host_data.set('CONFIG_VIRTFS', have_virtfs)
> config_host_data.set('CONFIG_VTE', vte.found())
>-- 
>2.44.0
>
>

