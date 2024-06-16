Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB89C27C6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 09:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIm4L-0003Ux-RP; Sun, 16 Jun 2024 05:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sIm4K-0003UI-Ec
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 05:21:00 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sIm4G-0000Ok-V4
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 05:21:00 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7eb75c0d0a7so114375639f.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 02:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1718529653; x=1719134453;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WJTITI7d6cxE49mcL6eEYXUnlLOz8oJzi5iQhh15Hz0=;
 b=B1VZizSzRIvbpMlsxbHVHlhTchC1/FiljnU3rEcHbq1SDQ7ZVYhPIJ0tLkZx4X1FHI
 AztF0/uJFRKX0Txw+2Al6N6DoIWjr4j7rX9tran3x2fwfrciQLfPDE0HAZ3R2i8YUVms
 Ah7TSnZru9pkoedTPxcIV99GG83viEu/OVR72y7j+Vz5zBsNguiPWd07RFo2Bq8NBcfx
 8GNk1TfgqIj2DqEgI8XsGZS6n7eGepkxGCtY0YOWWWtVCAqSzoY0bz9Q17KqTMHwqBHr
 vG4B49LDDwz4/obcDQ/XkEmxjjYziRyrRobmT3jZHJa4QO4j18qH0k/f0o/3XuLHnwhi
 sgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718529653; x=1719134453;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJTITI7d6cxE49mcL6eEYXUnlLOz8oJzi5iQhh15Hz0=;
 b=IjngBctwg1D6HQGpVKOvhe23XMmDb+U8PNQuCcrAa8u96Ko6FyqnHA0ntOhbLOMXpw
 dIZ8TvCsBcDjTcOmZhwcP0ZQgXV/uURWcRRYALp9x8UiuleIsmi5ouEfRNueXDu56e1Z
 bvjhT1yFu9VnaV2MSM6om+lEwwgI+ScM18PHMEAtT5noWcWKkxaKPCO8HMRMUxyDJlWp
 GRUZ3JMRGhy1RJrRfMfeTWchnkrnEDoUbD5sW26j3bNMaCiSh634+B4lzyL24lRcHVvz
 WUVCKbWm75mGL1bSnlZcLBQHJ9dTDk+Z8rvprfiHLjJFRaA93B5k1G9cz8fUgoSS0kBV
 by3g==
X-Gm-Message-State: AOJu0Yx7Fsez9wcP2QLDrk4O5barjNCpiQL3OHEdeYs1UueITJUJpPMS
 qG6byDVi10Hvrlx1nY3YLJM3LgAbSr/wh5x2h86LgBKqy4ztLR7ZDjZUHWd3w6A=
X-Google-Smtp-Source: AGHT+IE1SrKyJDhVDITnRD4EDPz1qhCyLPKc6xhU8//330Dvzb6h7/jXeQwYNkKGMzKafUq96/aJnQ==
X-Received: by 2002:a92:c24c:0:b0:374:a6de:19b7 with SMTP id
 e9e14a558f8ab-375e0ec366fmr82673045ab.26.1718529653064; 
 Sun, 16 Jun 2024 02:20:53 -0700 (PDT)
Received: from [10.4.77.246] ([118.103.63.129])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc96c442sm5695914b3a.77.2024.06.16.02.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 02:20:52 -0700 (PDT)
Message-ID: <1bacb98f-d264-40ef-b241-04e5b888ce37@daynix.com>
Date: Sun, 16 Jun 2024 18:20:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 10/14] virtio-gpu: Support blob scanout using dmabuf fd
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
 <20240616010357.2874662-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240616010357.2874662-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd2f.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2024/06/16 10:03, Dmitry Osipenko wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> Support displaying blob resources by handling SET_SCANOUT_BLOB
> command.
> 
> Signed-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-virgl.c  | 109 +++++++++++++++++++++++++++++++++
>   hw/display/virtio-gpu.c        |  12 ++--
>   include/hw/virtio/virtio-gpu.h |   7 +++
>   3 files changed, 122 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 3ffea478e723..60befab7efc2 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -17,6 +17,8 @@
>   #include "trace.h"
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-gpu.h"
> +#include "hw/virtio/virtio-gpu-bswap.h"
> +#include "hw/virtio/virtio-gpu-pixman.h"
>   
>   #include "ui/egl-helpers.h"
>   
> @@ -78,6 +80,7 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>       res->base.height = c2d.height;
>       res->base.format = c2d.format;
>       res->base.resource_id = c2d.resource_id;
> +    res->base.dmabuf_fd = -1;
>       QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
>   
>       args.handle = c2d.resource_id;
> @@ -125,6 +128,7 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>       res->base.height = c3d.height;
>       res->base.format = c3d.format;
>       res->base.resource_id = c3d.resource_id;
> +    res->base.dmabuf_fd = -1;
>       QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
>   
>       args.handle = c3d.resource_id;
> @@ -509,6 +513,106 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>       g_free(resp);
>   }
>   
> +#if VIRGL_VERSION_MAJOR >= 1
> +static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
> +                                       struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_framebuffer fb = { 0 };
> +    struct virgl_renderer_resource_info info;
> +    struct virtio_gpu_virgl_resource *res;
> +    struct virtio_gpu_set_scanout_blob ss;
> +    uint64_t fbend;
> +
> +    VIRTIO_GPU_FILL_CMD(ss);
> +    virtio_gpu_scanout_blob_bswap(&ss);
> +    trace_virtio_gpu_cmd_set_scanout_blob(ss.scanout_id, ss.resource_id,
> +                                          ss.r.width, ss.r.height, ss.r.x,
> +                                          ss.r.y);
> +
> +    if (ss.scanout_id >= g->parent_obj.conf.max_outputs) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified %d",
> +                      __func__, ss.scanout_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
> +        return;
> +    }
> +
> +    if (ss.resource_id == 0) {
> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
> +        return;
> +    }
> +
> +    if (ss.width < 16 ||
> +        ss.height < 16 ||
> +        ss.r.x + ss.r.width > ss.width ||
> +        ss.r.y + ss.r.height > ss.height) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
> +                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
> +                      __func__, ss.scanout_id, ss.resource_id,
> +                      ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> +                      ss.width, ss.height);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    res = virtio_gpu_virgl_find_resource(g, ss.resource_id);
> +    if (!res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (virgl_renderer_resource_get_info(ss.resource_id, &info)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not have info %d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (res->base.dmabuf_fd < 0) {
> +        res->base.dmabuf_fd = info.fd;

res->base.dmabuf_fd is conditionally assigned but 
virgl_renderer_resource_get_info() is called unconditionally, which is 
inconsistent.

The relevant code is better to be moved into 
virgl_cmd_resource_create_blob() for consistenty with 
virtio_gpu_resource_create_blob().

