Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212B0C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 05:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLG4H-0006mz-9M; Sun, 23 Jun 2024 01:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLG4E-0006mp-KJ
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 01:47:11 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLG4D-000167-19
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 01:47:10 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fa2782a8ccso1774655ad.2
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 22:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719121627; x=1719726427;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AAiZSHq1e37l3lYZVPlPrVgktdU/E/QA/kD/yyBBBjw=;
 b=yNobe9Y5+T963M3/mCwWSiA/9g0erbucpD7402syxX4xwWq0Nw0jTjG2eJUmUW42st
 QJDy4H74yNPGK/PhjxeOLP5lDcLOTP2vZqsXLyapoWIIUv4yULVJpPMTlRShLCQ/pJLE
 Y144pXvs6PXFgkDxHQh4gum9ZK9XjtY+5WHZFaGTKQPCknNDJ00BGdeMdt1yU9pqFzTw
 cAMnxyAydDQKWvXW8e9Soc4pHyOZbE/bs2058a1qkINUiOgNrQXnHP++NyfhVFSquN4e
 UA3zZNrcTN0jEI/aUNWewNX4vVDYsx8/aYqz8rpBAIJOw8WSkJuz0TYl8LMf13mPzPe5
 72DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719121627; x=1719726427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AAiZSHq1e37l3lYZVPlPrVgktdU/E/QA/kD/yyBBBjw=;
 b=P+tdvj+Jfht5xgwGYvmFwjlSsDsyAwSr0xgWnvSpmi1kL1d1z3l9M1jMYZeFeYe3Vw
 eGy61oB0d3jE9KF/soZEpbsFmSNkmwLY7PM67+qEx3+lsh2VCSk3tAc+Gdm7IvrXSmlt
 ycPjgPBs/tAXkNdlIG5evP2geuqFmi1GBNDDVOQMFlbw8Lc4e7DKLaT5NZ6+ZiFp3wNV
 /u3i6NznoS/PRZ0qF/3yFQLIVzZ51BaoEW2Y3PgiRw0Qh7DYuC4u9XbbEEkvLjOF78OV
 X5zunlvdM0zOa0Cf9/4iRGfii9mR3EXdLyWl7RPbat6Umz4lOKnOYFRuBe2Z6m7BHEQS
 YqVA==
X-Gm-Message-State: AOJu0YzowMfSJM4O63RG9NT+zNy20NA9/rwQWRNdKKs+z7Qzf74897dJ
 Vb2+DWIMho34S2t60Pjuw2qrCtA80A3mKTPbX/UCHTfSUWEBYRSGaRur6OCfszJsXoRqLuaHaoc
 0WrY=
X-Google-Smtp-Source: AGHT+IEcQrEqfD6Wzk7Woe27AtEHV7wPW283aho7fy82/nZFzl+l0qXLh/lNf0ViVGhgbkA0JmBm4w==
X-Received: by 2002:a17:902:a3c3:b0:1f8:3c47:9da6 with SMTP id
 d9443c01a7336-1fa23f5dbbemr14007935ad.69.1719121627028; 
 Sat, 22 Jun 2024 22:47:07 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebabc13fsm39574185ad.250.2024.06.22.22.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jun 2024 22:47:06 -0700 (PDT)
Message-ID: <b210ea92-9a7a-435a-bf33-0cdce3c3fdfd@daynix.com>
Date: Sun, 23 Jun 2024 14:47:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 12/14] virtio-gpu: Handle resource blob commands
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
References: <20240622215511.154763-1-dmitry.osipenko@collabora.com>
 <20240622215511.154763-13-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240622215511.154763-13-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

On 2024/06/23 6:55, Dmitry Osipenko wrote:
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
>   hw/display/virtio-gpu-virgl.c  | 334 +++++++++++++++++++++++++++++++--
>   hw/display/virtio-gpu.c        |   6 +-
>   include/hw/virtio/virtio-gpu.h |   2 +
>   4 files changed, 330 insertions(+), 15 deletions(-)
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
> index 60befab7efc2..f6cb4fe5b28e 100644
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
> @@ -49,6 +50,152 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>   }
>   #endif
>   
> +#if VIRGL_VERSION_MAJOR >= 1
> +typedef enum {
> +    HOSTMEM_MR_UNMAPPING,
> +    HOSTMEM_MR_FINISH_UNMAPPING,
> +} HostmemMRState;

Now you can make it a mere bool.

