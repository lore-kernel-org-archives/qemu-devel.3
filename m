Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0244C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 07:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0cEx-0005Tn-15; Sat, 27 Apr 2024 03:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0cEn-0005SS-DT
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 03:12:45 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0cEk-0002IO-6X
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 03:12:45 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f07de6ab93so2671226b3a.2
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 00:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714201958; x=1714806758;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dyr4Pjmf1PqayEDanF951LmhzodO0Cz+1ukNxa1NGPo=;
 b=L6vUDYjH22FvIwr0KB05sas6A2eAtkLMa5cSuet17OIyjyqIsJ1QWnroLZJ7asEB9k
 dTiY2v9kF7dSr7egjqFUNOt0jHvf6WU8Qq2/mVSha95Njjp7gY5a/Wfe4E8+Q04/I0Dl
 x54uGjgVzxIlPkFMpDT9gt5RdM0GLO51Ho6sqALCXXMwV6Ivo3tiQvEwp4IpD9vEmkAk
 6kUVF6BD3ZQ4j3yex7Ri1XbIHfx2JS52Lhx4TBM9msPAGrhIkXGBl+kxrOfrWaN6k8nk
 FbC75doWq4rTgYWAfBlHslV8iBzusi5areEbDtN05e6DpW6nlNioaZ9O6Do+uFbcrIQG
 oM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714201958; x=1714806758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dyr4Pjmf1PqayEDanF951LmhzodO0Cz+1ukNxa1NGPo=;
 b=ZtoNEMXArm06S7HEx7v4mdJ7Zs9HYwQ7c+V1QSzB0Cu5r+YfwMeedQbpbcQWZvXIhN
 yqwT8+Nr01WKjhBMsFi7IYich9uAieaUY8RiRPJx3NrinnxSPk2VWVHNgEtZNzIc7aDL
 Oej9nWvReWaBLEud/WxXXWb6OOBuGYbMk4lET9O//hphFLDR85maPGSaFqeSVHR1UbzZ
 yOa1oItY65gHEv37oImRBkAhpHQpoxdPItKUMLWXta8KuFZvfPE84sZd0trvAjWEAbUY
 fNq4YB47iRONCDCtGVHdG9GkW976eqX2/Pozqd35qMev36FQVULEp/rSZT7kOXTklGwf
 9EyA==
X-Gm-Message-State: AOJu0YxfPNYaXBrhBl4FhEiZMMi9LJMZauAB94mwQbkvVP3GHwTfyw/7
 DGwe56p7SOT6/J4VZ1HRQhM3Fw1dOwNFjahMWAa+p3X22NwRWeJWCCBvIawooCM=
X-Google-Smtp-Source: AGHT+IF83PsbFXY/qBmXFQnihI1YGH0QyVuNnkXQZoeVQzksuV+AHEpBFHfxVV80ASpQTsFJk03dBw==
X-Received: by 2002:a05:6a00:3d11:b0:6f3:8468:f9d1 with SMTP id
 lo17-20020a056a003d1100b006f38468f9d1mr5469663pfb.14.1714201958338; 
 Sat, 27 Apr 2024 00:12:38 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a62c106000000b006ed0199bd57sm16983567pfg.177.2024.04.27.00.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Apr 2024 00:12:38 -0700 (PDT)
Message-ID: <557f5ddb-4326-48bc-b34e-bda9d51cadcc@daynix.com>
Date: Sat, 27 Apr 2024 16:12:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/11] virtio-gpu: Register capsets dynamically
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
References: <20240425154539.2680550-1-dmitry.osipenko@collabora.com>
 <20240425154539.2680550-10-dmitry.osipenko@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240425154539.2680550-10-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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

On 2024/04/26 0:45, Dmitry Osipenko wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> virtio_gpu_virgl_get_num_capsets will return "num_capsets", but we can't
> assume that capset_index 1 is always VIRGL2 once we'll support more capsets,
> like Venus and DRM capsets. Register capsets dynamically to avoid that problem.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-virgl.c  | 34 +++++++++++++++++++++++-----------
>   include/hw/virtio/virtio-gpu.h |  2 ++
>   2 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index de788df155bf..9aa1fd78f1e1 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -597,19 +597,13 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
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
> @@ -1159,12 +1153,30 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       return 0;
>   }
>   
> +static void virtio_gpu_virgl_add_capset(VirtIOGPU *g, uint32_t capset_id)
> +{
> +    g_array_append_val(g->capset_ids, capset_id);
> +}
> +
>   int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>   {
>       uint32_t capset2_max_ver, capset2_max_size;
> +
> +    if (g->capset_ids) {

Move capset_ids initialization to virtio_gpu_virgl_init() to save this 
conditional. capset_ids also needs to be freed when the device gets 
unrealized.

