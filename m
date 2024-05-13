Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84E7C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 09:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Rrk-0002pn-O0; Mon, 13 May 2024 05:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s6Rre-0002pG-Pb
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:21:00 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s6Rrc-00043a-RU
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:20:58 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ee42b97b32so32430385ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1715592055; x=1716196855;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=buUgAL3CljCxvMHHz070GZd8+SUe4WlV5ftPMVIWAy8=;
 b=OJMs/FP6pt/xb4fbW0wpU8L7o74pzp6phddPqG6+J1PpcY4XltdsfCZsr4yyOct/20
 0chUZ9MsT+Zl0ullDdtHL2/Qt6r+mxXniQgqmcQUDbb8mz4NJES1wWX1b9Z1I+BQ+kG6
 HJTrMk4qWRmehv+RQm2ifP6ux35MsRhnTy5a6nQxdP3H4tKGwMNYd1B7t2PAwG+Tyllt
 GHMpA1jla3f5MgqyK+rSILhCI1+5t/VY/yuQaXwS/OCdxsPrjyf6I+tULHFBh3LkoAkQ
 6SvfEjSxpoaZGlhcHEd8tbs3+LjN/Ed6uEA+iJrkuTG8aU+MRzMqOijqIScrR9ETigNR
 AhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715592055; x=1716196855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=buUgAL3CljCxvMHHz070GZd8+SUe4WlV5ftPMVIWAy8=;
 b=SW95KJWBoUb/5zO7cp7rzyLKf5V7KRCMA4Lra9y7SBu8jUoGhQQody4dIONI5MpPR6
 uWrqCF6VZCBX7raV6a5xFJmua7tqeXV5yQ+fmCVWDNpSr/jqmQSsOgXSbCheHcTSJ3mz
 +L3r1CSZnMFR6JuJjXmw7pr3ZAzjSKTXmLCWG/qwFeMy90TKb6MC+kCIJDjsKNwmodl9
 8yeAc7h5ATpQ5S242vII/eXUTY/+hdt4mdQDQ9o5Qjikz+H2tiFIngsbLgBOvq6XiKbV
 TCvzXGfE0OohGO8LiJUhCO1nvry/nzKkfqHv5+vgKAGPA1WxfeHOAM9fuiA0PWjm7/Wr
 98Ww==
X-Gm-Message-State: AOJu0Yy71F+irj6ivEbEz1HcRBuWUKCxYwdTzgp81izlp1fGO6ZRl83T
 WyKYsNRFXufbBum7/fEBnQBC/343n88tVhkXMob3v8pqksNdNiagCrmZkKUsEfo=
X-Google-Smtp-Source: AGHT+IEhlD+wzGjD1rRjzUu1vJBCdGcmOx1gNjLYP/b9DBBFKiV++BeIQJmXD0lcipbrqMn0Sw9h7Q==
X-Received: by 2002:a17:902:d683:b0:1e2:6198:9e53 with SMTP id
 d9443c01a7336-1ef433d6fb2mr87988535ad.0.1715592055474; 
 Mon, 13 May 2024 02:20:55 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c138fa2sm74612475ad.261.2024.05.13.02.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 02:20:55 -0700 (PDT)
Message-ID: <f9291d63-dd25-49e2-8338-426f5b206861@daynix.com>
Date: Mon, 13 May 2024 18:20:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/10] virtio-gpu: Register capsets dynamically
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
References: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
 <20240511182251.1442078-10-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240511182251.1442078-10-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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

On 2024/05/12 3:22, Dmitry Osipenko wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> virtio_gpu_virgl_get_num_capsets will return "num_capsets", but we can't
> assume that capset_index 1 is always VIRGL2 once we'll support more capsets,
> like Venus and DRM capsets. Register capsets dynamically to avoid that problem.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-gl.c     |  6 ++++--
>   hw/display/virtio-gpu-virgl.c  | 33 +++++++++++++++++++++------------
>   include/hw/virtio/virtio-gpu.h |  4 +++-
>   3 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 95806999189e..431fc2881a00 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -124,8 +124,8 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>       }
>   
>       g->parent_obj.conf.flags |= (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
> -    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =
> -        virtio_gpu_virgl_get_num_capsets(g);
> +    g->capset_ids = virtio_gpu_virgl_get_capsets(g);
> +    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets = g->capset_ids->len;
>   
>   #ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
>       g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
> @@ -148,6 +148,8 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>       if (gl->renderer_inited) {
>           virtio_gpu_virgl_deinit(g);
>       }
> +
> +    g_array_unref(g->capset_ids);
>   }
>   
>   static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 3f2e406be3a4..135974431492 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -590,19 +590,13 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
>       VIRTIO_GPU_FILL_CMD(info);
>   
>       memset(&resp, 0, sizeof(resp));
> -    if (info.capset_index == 0) {
> -        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL;
> -        virgl_renderer_get_cap_set(resp.capset_id,
> -                                   &resp.capset_max_version,
> -                                   &resp.capset_max_size);
> -    } else if (info.capset_index == 1) {
> -        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL2;
> +
> +    if (info.capset_index < g->capset_ids->len) {
> +        resp.capset_id = g_array_index(g->capset_ids, uint32_t,
> +                                       info.capset_index);
>           virgl_renderer_get_cap_set(resp.capset_id,
>                                      &resp.capset_max_version,
>                                      &resp.capset_max_size);
> -    } else {
> -        resp.capset_max_version = 0;
> -        resp.capset_max_size = 0;
>       }
>       resp.hdr.type = VIRTIO_GPU_RESP_OK_CAPSET_INFO;
>       virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> @@ -1123,14 +1117,29 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       return 0;
>   }
>   
> -int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
> +static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t capset_id)
> +{
> +    g_array_append_val(capset_ids, capset_id);
> +}

Is it worthwhile to have a function for this?

