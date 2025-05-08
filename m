Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F116C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCz5B-0001ys-Io; Thu, 08 May 2025 07:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangxueqian@gmail.com>)
 id 1uCz54-0001yC-QW
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:06:23 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jiangxueqian@gmail.com>)
 id 1uCz52-0001x2-Pu
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:06:22 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso1267697b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746702378; x=1747307178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HSo5QiLzoTXiF8cyOy7nWOiKErAXqNoXcuL8NKQN4R8=;
 b=l1TWMzzxasBkDhPFu+svjBcI8+hhJmqTzNfj8GoZ8Qlx8SZZVe01Nsn1t/KUoqyN1U
 ZxFm/JRVbY2O/f4JAS3Ku1gwU0CbAdn8PwmRg0MgLfmMbg2XWrYvcmUh54nmwVclTfGu
 7lpDio1dL1Lbw8ThHAjADjLET8m3NjlCJTOD94dL+X0kt9uvSQHdlXsnU8D4FOs8vP9G
 o1qc4LQV1NZdFesyBz9684YB6sGVS9Wk6PZyiEg1N7EKb0BLZtecGYqaxmIMZZvFCIeL
 pcu4fePplfEHal2fnmNA24VusnqvlFGdOBQKQXVQZ9EOHk1s7fLpfO6MFp2HesCOO3+P
 UKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746702378; x=1747307178;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HSo5QiLzoTXiF8cyOy7nWOiKErAXqNoXcuL8NKQN4R8=;
 b=RVPkRmTx4Kg6pMBqLzQ6XAqsxe9/Yxl76ZCY5Ruc/fEfMB7tHoOWeUbTeNywIqT6F5
 OVxnSI9EEZlrp9+L02a4nuSZHidsj1gCd3dY2W9ln3rtqvtdNox2Q7WUMGQMPRGIklw8
 2CsvHi5UiipIy9piRey3i9Aefl+AzZ3dz3rUonn4Wo9E3hUX1S7vwRnFkjLCk+tn1KN9
 TBObbNIT1cIkneJImDfuiL0683AYTLO1PlLZwlpiqZhgcjLj07Ub6vUFs0GmcNO4OjFp
 XDx+Xmqzuv9Aikb1XfdJc2Z0YeUvPalaCAFV6/ju/MgF+FiLapQM59w7nISK2naAklrW
 18JQ==
X-Gm-Message-State: AOJu0YzlEX6JMwS8s2JgbHaEFpq+5+sjLmQRGl5VUkWVY41TlbaUYPnR
 viWE9QzWW0aprPM29q2H6caxEoH4WyEhaH6nQ1swfF8bOub7Ka1hlwMeWw==
X-Gm-Gg: ASbGnct2+g0vmb7+YgRJjV/unYV3YGSDBnAhzhweOZt79/Ou+DT4bKe4clwjZPopIl+
 myFOzbYWa8qnp11bPo11gCXcTR39NGo6U0cj1M7rWOq4rSbaoWB9vc8/4ynAKECRQVhTIIT0zUX
 M98OzhZyzTXZOi9Be6LM2uonJQPf7rKEqEQVVgEBGtWRyXNC0vDhK2Uijfh7GiSDdKBw6L9t5l5
 eYg31vxRpmZSR8zqd1IiAAkCfP0oGjCIPKR/LVe/UdjbopQks+T/tOYjKf66NUEd2aXn8yu4H+V
 BLR2Denf4VUNemWXAat4neVcAat8KOu+83k0JhmYQou6Ggeofnjk2e9dN48=
X-Google-Smtp-Source: AGHT+IGWQIY8MzvyQLG6+fYYBFL+KEnvAbrYWGkrkWD3tjRCk7Bo29dqtly17WHOgXefHIflf520XA==
X-Received: by 2002:a05:6a20:d04f:b0:1f5:8eec:e517 with SMTP id
 adf61e73a8af0-2148b728042mr10110829637.9.1746702378316; 
 Thu, 08 May 2025 04:06:18 -0700 (PDT)
Received: from [192.168.11.20] ([74.48.121.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b20010bdec2sm821823a12.52.2025.05.08.04.06.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 04:06:17 -0700 (PDT)
Message-ID: <36adc357-91d0-495f-afe0-7679e056eb98@gmail.com>
Date: Thu, 8 May 2025 19:06:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jiang XueQian <jiangxueqian@gmail.com>
Subject: Re: [PATCH] virtio-gpu-gl: Add 'serverfd' property
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20250403155129.3396821-1-jiangxueqian@gmail.com>
Content-Language: en-US
In-Reply-To: <20250403155129.3396821-1-jiangxueqian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=jiangxueqian@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Ping.

On 4/3/25 11:51 PM, Jiang XueQian wrote:
> This property passes socket of a externally started virgl_render_server
> to virglrenderer, so that it won't try to spawn new process and get
> killed by seccomp, allowing virtio-gpu-gl venus and sandbox to enable
> at the same time.
> 
> Signed-off-by: Jiang XueQian <jiangxueqian@gmail.com>
> ---
>   hw/display/virtio-gpu-gl.c     | 15 +++++++++++++++
>   hw/display/virtio-gpu-virgl.c  | 17 +++++++++++++++++
>   include/hw/virtio/virtio-gpu.h |  2 ++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 683fad3bf8..e7c89f7c29 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -22,6 +22,7 @@
>   #include "hw/virtio/virtio-gpu-bswap.h"
>   #include "hw/virtio/virtio-gpu-pixman.h"
>   #include "hw/qdev-properties.h"
> +#include "monitor/monitor.h"
>   
>   #include <virglrenderer.h>
>   
> @@ -143,6 +144,17 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>           return;
>       }
>   
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
> +    if (g->parent_obj.conf.serverfd) {
> +        g->parent_obj.conf.serverfd_parsed =
> +            monitor_fd_param(monitor_cur(), g->parent_obj.conf.serverfd, errp);
> +        if (g->parent_obj.conf.serverfd_parsed < 0) {
> +            error_prepend(errp, "unable to parse serverfd: ");
> +            return;
> +        }
> +    }
> +#endif
> +
>       g->parent_obj.conf.flags |= (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
>       g->capset_ids = virtio_gpu_virgl_get_capsets(g);
>       VIRTIO_GPU_BASE(g)->virtio_config.num_capsets = g->capset_ids->len;
> @@ -159,6 +171,9 @@ static const Property virtio_gpu_gl_properties[] = {
>                       VIRTIO_GPU_FLAG_STATS_ENABLED, false),
>       DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
>                       VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
> +    DEFINE_PROP_STRING("serverfd", VirtIOGPU, parent_obj.conf.serverfd),
> +#endif
>   };
>   
>   static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 145a0b3879..420aae3b05 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1030,6 +1030,19 @@ static int virgl_make_context_current(void *opaque, int scanout_idx,
>                                      qctx);
>   }
>   
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
> +static int virgl_get_server_fd(void *opaque, uint32_t version)
> +{
> +    VirtIOGPU *g = opaque;
> +
> +    if (g->parent_obj.conf.serverfd) {
> +        return g->parent_obj.conf.serverfd_parsed;
> +    }
> +
> +    return -1;
> +}
> +#endif
> +
>   static struct virgl_renderer_callbacks virtio_gpu_3d_cbs = {
>       .version             = 1,
>       .write_fence         = virgl_write_fence,
> @@ -1097,6 +1110,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       uint32_t flags = 0;
>       VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>   
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
> +    virtio_gpu_3d_cbs.version = 3;
> +    virtio_gpu_3d_cbs.get_server_fd = virgl_get_server_fd;
> +#endif
>   #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
>       if (qemu_egl_display) {
>           virtio_gpu_3d_cbs.version = 4;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index a42957c4e2..40a81f500c 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -128,6 +128,8 @@ struct virtio_gpu_base_conf {
>       uint32_t xres;
>       uint32_t yres;
>       uint64_t hostmem;
> +    char *serverfd;
> +    int serverfd_parsed;
>   };
>   
>   struct virtio_gpu_ctrl_command {


