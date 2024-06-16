Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930FEC27C77
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 09:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIm70-0004SX-7v; Sun, 16 Jun 2024 05:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sIm6y-0004SM-R5
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 05:23:44 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sIm6x-0000lI-9k
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 05:23:44 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5b96a78639aso1412838eaf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1718529822; x=1719134622;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vh9If7REgHphTrzZwceRt61TncJOTmK4Bc5Has2fkhA=;
 b=CfrD9IBf5iyPI5Q/ORo6OcJfX9ANg3W9rTUtZemjGYRqQUSebGhSzupq6embTzb0Dq
 sKajUaoRsto6atQ58w55VERv9KnzE0b5AW9tNPcKty+ko9j2IIlY93s7KX2htGBsC/50
 WY4Mco9m8J/GRwL/JFd7r0mPSTDhHREdBOBVZqR9XGlvK6J2tu5oAF87sAeQ9anrSy00
 d1bZWSKSmcwjwHpEHYb9zT4RejQVk9TA0cXCq8aClPJ403tCX2QUyj7J8MPjszXihQLQ
 Vuagah4Xo5bsl5lv1nwGaKqBs2NYSI+oXJVKrdNy7zvX2b4WbpuXUTdcaaNlJ2LfHfBM
 0rKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718529822; x=1719134622;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vh9If7REgHphTrzZwceRt61TncJOTmK4Bc5Has2fkhA=;
 b=wt3m5Us8uOxiuHYI9qWDKGkXgcpkD3sDl5bxK8PHNicP8uKtS2MnbMyvMCZBLlk3EI
 91DPy8v1tzQmyoNRHlQWOJu+RbNG5lXnTASiy7kVJlw+t9BdqPgr8dj4mcsFWfMfR6Xn
 aGKOP7cWcyCEOljjjplVFGvXo5l9tGvQhfxnXQeqFs2i8b2zdH6X3YbARHmvCGkrgJ7v
 2wD+oqfGOUNxuZu6wT9Isz7Vx/72+n8ZUigDjguXvOsw0q3LSaaH5Bu6zDpBp9An3LF8
 cC4S1PxCpcCBNGAKiGoL/71n8yYzrp7XSA1u1uSzo6HtzsP/6H99rEtmC14M22Tnf5dS
 CyXg==
X-Gm-Message-State: AOJu0Yykc3qNSopLZHlzZOnQyiNw4jWQdK8xuCNikJp/f0tAggn6s6pD
 stIpXluN2QkUH2hjRIsjsL8hGoqMPGNwPZj71qDRnQ2j6Py9X1vn96av6/OjubI=
X-Google-Smtp-Source: AGHT+IESu5nANgLtmt/e76VqVHlSm1V5KiXZ2s1mMw3grw5pK/Vw0EBUgNEZ21qrQptQxkCOWvd91g==
X-Received: by 2002:a05:6358:7184:b0:19f:5631:97cd with SMTP id
 e5c5f4694b2df-19fa9e5c312mr972610455d.15.1718529821942; 
 Sun, 16 Jun 2024 02:23:41 -0700 (PDT)
Received: from [10.4.77.246] ([118.103.63.129])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e5c0e8sm60867645ad.38.2024.06.16.02.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 02:23:41 -0700 (PDT)
Message-ID: <547a6d27-60ca-46df-a5d7-e0030182e9d0@daynix.com>
Date: Sun, 16 Jun 2024 18:23:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 12/14] virtio-gpu: Handle resource blob commands
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
 <20240616010357.2874662-13-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240616010357.2874662-13-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c36;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc36.google.com
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
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Support BLOB resources creation, mapping and unmapping by calling the
> new stable virglrenderer 0.10 interface. Only enabled when available and
> via the blob config. E.g. -device virtio-vga-gl,blob=true
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-gl.c     |   3 +
>   hw/display/virtio-gpu-virgl.c  | 309 ++++++++++++++++++++++++++++++++-
>   hw/display/virtio-gpu.c        |   6 +-
>   include/hw/virtio/virtio-gpu.h |   2 +
>   4 files changed, 316 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 4fe9e6a0c21c..5f27568d3ec8 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -160,6 +160,9 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>       VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
>   
>       if (gl->renderer_state >= RS_INITED) {
> +#if VIRGL_VERSION_MAJOR >= 1
> +        qemu_bh_delete(gl->cmdq_resume_bh);
> +#endif
>           if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>               timer_free(gl->print_stats);
>           }
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 60befab7efc2..fed3e27b2fc9 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -26,6 +26,7 @@
>   
>   struct virtio_gpu_virgl_resource {
>       struct virtio_gpu_simple_resource base;
> +    MemoryRegion *mr;
>   };
>   
>   static struct virtio_gpu_virgl_resource *
> @@ -49,6 +50,153 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>   }
>   #endif
>   
> +#if VIRGL_VERSION_MAJOR >= 1
> +typedef enum {
> +    HOSTMEM_MR_MAPPED,

HOSTMEM_MR_MAPPED is no longer used.

