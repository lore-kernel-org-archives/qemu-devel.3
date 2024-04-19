Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F44C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxknI-0003h8-8y; Fri, 19 Apr 2024 05:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rxknH-0003gz-9c
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:44:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rxknE-0000hD-PN
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:44:30 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e2c725e234so22901955ad.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 02:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713519866; x=1714124666;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F9LOB0c1ualbirFbVvIYp136xfZdYGqKSG3cKAuwQvU=;
 b=nagrOF2Utu+wct/f9y8v2xpOEcXfcfJ48mSUWrHoST+nYCmS3D6AcGIcJ+Uop0j8jZ
 rddW8V/FeXbxnhZ5olj9SznACNTTn7Ek/DJ9UnzwCxVk336d8lw/Ef8wnbx43afpM6U0
 d1CeiTWXKOWBxD5SJFPkQJvAmvfrgI7m0knouqBOcxykIlT2Lnpf6BOw/mzvgBcb2vOP
 TtQgbw7A1UIrQZt8VVFOBZFE/0AI5RUjLwSJ2MXYV29lhctSNtmUBaNVQk+oyXyqT6hf
 l+hzIYoOAIiSSt6phjLIMFQ56tlHTbEo2jvanM+zVUGuh6ePOh2L3Nz9OjQReeJprVXM
 8v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713519866; x=1714124666;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F9LOB0c1ualbirFbVvIYp136xfZdYGqKSG3cKAuwQvU=;
 b=l5FUWKOwQ/SsLr9X2zHpiEZy12KdeSM8LPmhSL2mZUZkKl5aFsZcUhW7s7OJLtMNLV
 AdqgZYf6dggS/11clkqGU/ggoM7U5tBpfW71N7odvPhiY4j4oOWeut+tdhA+YoU4Bit5
 DV1huNNjhUewitk1Tj1EMh4UtC9XInJnm0KiCnCO6/uIrLnwuwThP6CiK0W64JBkUJ82
 lS1s+zCIf2d4U20UIItjnXTj6d4TqIbEjhfcTz+JL6ebNA6mt5a03t1ckk7F5Fx6N4y0
 GSwpbNeyE1reM0YBZI6Xzhyjm3VCvkjW8m2JVEHwUdUV0RYdwbmbAwYSGCDsIxlF9NJX
 5UCA==
X-Gm-Message-State: AOJu0YxieIuiGYdfpXjsPxr8h+ZiCQitA3wt2SmLCRedYi946iAniNbd
 u05jnDfx+4wwaf0TFnbmSN3+Klx9Ok/eBN7VBp3RB/z1lMJsEXpBoMbG9eM/Pbo=
X-Google-Smtp-Source: AGHT+IGXZY2AAgWI9LhummlEclBlBv4pYRPCWalSq0G9HXA5unmPuo7W9Ym18hMAO5Q3N1cOTJWzZA==
X-Received: by 2002:a17:902:e750:b0:1e2:c350:b46a with SMTP id
 p16-20020a170902e75000b001e2c350b46amr2398853plf.27.1713519866384; 
 Fri, 19 Apr 2024 02:44:26 -0700 (PDT)
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a17090264d000b001e3e409722csm3000323pli.5.2024.04.19.02.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 02:44:26 -0700 (PDT)
Message-ID: <52a14554-b839-4be7-8101-fd8563371b36@daynix.com>
Date: Fri, 19 Apr 2024 18:44:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/11] virtio-gpu: Support Venus context
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
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
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
 <20240418190040.1110210-12-dmitry.osipenko@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240418190040.1110210-12-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/04/19 4:00, Dmitry Osipenko wrote:
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Request Venus when initializing VirGL and if vulkan=true flag is set for
> virtio-gpu device.
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-virgl.c  | 14 ++++++++++++++
>   hw/display/virtio-gpu.c        | 15 +++++++++++++++
>   include/hw/virtio/virtio-gpu.h |  3 +++
>   meson.build                    |  1 +
>   4 files changed, 33 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index c0e1ca3ff339..2eac09370b84 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1095,6 +1095,11 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>           flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
>       }
>   #endif
> +#ifdef VIRGL_RENDERER_VENUS
> +    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
> +        flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
> +    }
> +#endif
>   
>       ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>       if (ret != 0) {
> @@ -1138,5 +1143,14 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>           virtio_gpu_virgl_add_capset(g, VIRTIO_GPU_CAPSET_VIRGL2);
>       }
>   
> +    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
> +        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
> +                                   &capset2_max_ver,
> +                                   &capset2_max_size);
> +        if (capset2_max_size) {

Now capset2_max_ver and capset2_max_size are misnomers as they are used 
not only for VIRTIO_GPU_CAPSET_VIRGL2 but also VIRTIO_GPU_CAPSET_VENUS. 
Just removing the "capset2_" prefix would be fine.

> +            virtio_gpu_virgl_add_capset(g, VIRTIO_GPU_CAPSET_VENUS);
> +        }
> +    }
> +
>       return g->num_capsets;
>   }
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index fbf5c0e6b8b7..a811a86dd600 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1496,6 +1496,19 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>   #endif
>       }
>   
> +    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
> +#ifdef HAVE_VIRGL_VENUS
> +        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
> +            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
> +            error_setg(errp, "venus requires enabled blob and hostmem options");
> +            return;
> +        }
> +#else
> +        error_setg(errp, "old virglrenderer, venus unsupported");
> +        return;
> +#endif
> +    }
> + >       if (!virtio_gpu_base_device_realize(qdev,
>                                           virtio_gpu_handle_ctrl_cb,
>                                           virtio_gpu_handle_cursor_cb,
> @@ -1672,6 +1685,8 @@ static Property virtio_gpu_properties[] = {
>       DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
>                       VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
>       DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
> +    DEFINE_PROP_BIT("vulkan", VirtIOGPU, parent_obj.conf.flags,
> +                    VIRTIO_GPU_FLAG_VENUS_ENABLED, false),

This property shouldn't be added here because it is specific to 
virtio-gpu-gl.

