Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0890DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkeZ-0001al-5I; Fri, 19 Apr 2024 05:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rxkeW-0001aO-Nh
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:35:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rxkeU-0007PK-RR
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:35:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ed627829e6so1976433b3a.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 02:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713519325; x=1714124125;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CFww3Er8UpmFtR4xNpTCJ88277vTOUuy2UDxCB1YJE4=;
 b=kaNhsTTBlO2uJq89ZajVKd1+zGSSxsN+XKJiwiW8i3VzMroxSKayOKsWAAWCot8iHa
 8qtAvdcNMJjgBzTDIfSIRJNxdnpKekQtX3kxq9wfRuRqkm3oXWncmPSLqekWo/wgt7Lz
 vy0UwAuV4EnS9eDBkkjo4jn+HtxMUK83MfNtoLlKXO1W7Y136LvUxnvwOVxu08hZQ2Mq
 AD1jvpc+KmVpY21C1lQ7Xqr6mQavPHzBTrFLVsuWo5rgUbfqLuaXjibWC85dys1sssUF
 70Ke/uCXJVQPzbqH8FNSxg6l9HPzAXnPnQT4ia4MifFXYjG6rK1H8WJ735V6xfjU099B
 aNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713519325; x=1714124125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CFww3Er8UpmFtR4xNpTCJ88277vTOUuy2UDxCB1YJE4=;
 b=IUAzUjKJry4581AAYPPw35XJP+UwErVMWEeMNFM4Vdj5I9Be3xJNqKWAfkwbTrNwjO
 W4WHsjHb4O58YRdGcE4D/JYHnqjV84p1Dt5ixLOSQI3K1Pv5GDghANjy/US7Yh/IyIuR
 Mf6qWQ0gpeFWG43pwb5SaE299P6FqvN4NdKwBumaTusGst4mv90q6Rf+cBkyvB02L4P4
 M9InsL8b9ydVVJMMOy8Wgo9NSNCGa0a0/GN1yeTQUhYuF4UfgSJMcrwkkaoS8Vi54u8K
 brIgcpInk8bfvZqxxn4FTLtRYyo6p4rDZTimkvQmO28SL5NSSpm6apCPXcCTvjBe0jD1
 DtCg==
X-Gm-Message-State: AOJu0Yxai/SD53O1NZ0HMqJpgsH2ChbyRQ2bnKem3IfRUxvoCb0KaFJT
 n6Wa1WGPkV7ya4Die87y7FgiM09ZTZacI+gCd25lAnBPfqJVI1GyXI+Sw9EZakQ=
X-Google-Smtp-Source: AGHT+IHIaWl1i6mNWg06/FUZ0bbqPA4J17IO5jxFgJz3m4Hj8vcoymisKZIf2usWQmVj7gBM7xwzBg==
X-Received: by 2002:a05:6a21:498c:b0:1a9:4343:765f with SMTP id
 ax12-20020a056a21498c00b001a94343765fmr1420434pzc.23.1713519324972; 
 Fri, 19 Apr 2024 02:35:24 -0700 (PDT)
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a17090ab38e00b002a03456ccabsm4460653pjr.30.2024.04.19.02.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 02:35:24 -0700 (PDT)
Message-ID: <39ab65dc-1ffe-4fa3-bf97-0aafa071f6dd@daynix.com>
Date: Fri, 19 Apr 2024 18:35:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/11] virtio-gpu: Register capsets dynamically
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
 <20240418190040.1110210-11-dmitry.osipenko@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240418190040.1110210-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> virtio_gpu_virgl_get_num_capsets will return "num_capsets", but we can't
> assume that capset_index 1 is always VIRGL2 once we'll support more capsets,
> like Venus and DRM capsets. Register capsets dynamically to avoid that problem.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-virgl.c  | 37 ++++++++++++++++++++++------------
>   include/hw/virtio/virtio-gpu.h |  3 +++
>   2 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index eee3816b987f..c0e1ca3ff339 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -558,19 +558,12 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
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
> +    if (info.capset_index < g->num_capsets) {
> +        resp.capset_id = g->capset_ids[info.capset_index];
>           virgl_renderer_get_cap_set(resp.capset_id,
>                                      &resp.capset_max_version,
>                                      &resp.capset_max_size);
> -    } else {
> -        resp.capset_max_version = 0;
> -        resp.capset_max_size = 0;
>       }
>       resp.hdr.type = VIRTIO_GPU_RESP_OK_CAPSET_INFO;
>       virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> @@ -1120,12 +1113,30 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       return 0;
>   }
>   
> +static void virtio_gpu_virgl_add_capset(VirtIOGPU *g, uint32_t capset_id)
> +{
> +    g->capset_ids = g_realloc_n(g->capset_ids, g->num_capsets + 1,
> +                                sizeof(*g->capset_ids));
> +    g->capset_ids[g->num_capsets++] = capset_id;
> +}
> +
>   int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>   {
>       uint32_t capset2_max_ver, capset2_max_size;
> +
> +    if (g->num_capsets) {
> +        return g->num_capsets;
> +    }
> +
> +    /* VIRGL is always supported. */
> +    virtio_gpu_virgl_add_capset(g, VIRTIO_GPU_CAPSET_VIRGL);
> +
>       virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
> -                              &capset2_max_ver,
> -                              &capset2_max_size);
> +                               &capset2_max_ver,
> +                               &capset2_max_size);
> +    if (capset2_max_ver) {
> +        virtio_gpu_virgl_add_capset(g, VIRTIO_GPU_CAPSET_VIRGL2);
> +    }
>   
> -    return capset2_max_ver ? 2 : 1;
> +    return g->num_capsets;
>   }
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index d2a0d542fbb3..3d7d001a85c5 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -218,6 +218,9 @@ struct VirtIOGPU {
>           QTAILQ_HEAD(, VGPUDMABuf) bufs;
>           VGPUDMABuf *primary[VIRTIO_GPU_MAX_SCANOUTS];
>       } dmabuf;
> +
> +    uint32_t *capset_ids;
> +    uint32_t num_capsets;

Use GArray.

