Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6DEC25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 05:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDdrF-0004kt-7Y; Sun, 02 Jun 2024 01:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sDdrC-0004kD-WF
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 01:34:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sDdrB-0001gZ-6K
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 01:34:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f61f775738so23239495ad.2
 for <qemu-devel@nongnu.org>; Sat, 01 Jun 2024 22:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717306451; x=1717911251;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KfUqcvQzU7d6oh/3eDOI3qDz2MRuQZ6h3P5EjOOtqk4=;
 b=eG+pVPPLB0nQgeVZETnfQX3brpbfp1XY/Tgoj1/f0uHkSFuIJzYuiQ0DshaXC1gJ7O
 f6o6+Szk4Gr5NH+OcSlzj4AmgJgXSybbC8kBh+urYD9v61eThiPYL2qlcoz3QK+xy7nF
 rZ9v/t87KTTo4NLmHYQv14qnGgm7xxX8zOrynGy7QX7MeEOjRpxVYC44Wv/3EaXUmkTC
 8dQdqOyfaXYmkMxP9FkkhIvPKv+GDNj2lsdsIBbRv3POMImEH/hcvufzJwHkxqxHRCu7
 xBl0hAvR8751EtdgaV1r84Jlh7kPBfM4MtaS3K843j2QmzPDTMMWMgIRWAfth/UJwzvj
 X/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717306451; x=1717911251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KfUqcvQzU7d6oh/3eDOI3qDz2MRuQZ6h3P5EjOOtqk4=;
 b=CQ4bqNt+pednzS9+G430iPuwxx4CZ2YOw9EonaFGAdBzvRxVcWEXYh0SHj7sVKDoqz
 WkWSzUZd8XrpAViFslTHWVwIQblXKuG4UfW8PREwom6ziGu0pEp4wSqXybL/tJ5IlLYV
 JW1zvdh0qxOzPXB9vkMrXKhI64xgLuAAjh+tFNklwSRVcsGadrVRZTEgDcMHWV2kGYrQ
 8r0Umn42Bjeor265+zpr11giST3ZT+Qbe3192M4YpAtKzN4fNQuzQ9jixiwMTzqq5xSU
 5u1+mnizBZSmM4kQp22lHPnK3chfLcQRsl6LtSfEG+H50BCz0I+BpCxLXI2YJ/3LXsvV
 f/Gw==
X-Gm-Message-State: AOJu0Yw0l9r+ifS0yiSuHEsgAPFRoxdDIBzYbF1/B0AuA7SlPsQ8UnjN
 2scJyo47qVsjt/b1AK+WdbSA0CmruWh2r9OTCVSjaHaW5VCrhFpgKx6Wo1AqCv8=
X-Google-Smtp-Source: AGHT+IHg72TJxsMdXQhepO6/krmRnnGCocCcfAp0SQkSEZNkVmzX0sKIIZ0cLL5IptDTZvtOLgMedQ==
X-Received: by 2002:a17:903:1cc:b0:1f6:7209:52d0 with SMTP id
 d9443c01a7336-1f6720964b8mr2780885ad.29.1717306451097; 
 Sat, 01 Jun 2024 22:34:11 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323f20b3sm41137215ad.213.2024.06.01.22.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jun 2024 22:34:10 -0700 (PDT)
Message-ID: <c9891c82-b139-49cb-9f94-52a96cc20eea@daynix.com>
Date: Sun, 2 Jun 2024 14:34:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/13] virtio-gpu: Handle virtio_gpu_virgl_init()
 failure
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
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-4-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240527030233.3775514-4-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/05/27 12:02, Dmitry Osipenko wrote:
> virtio_gpu_virgl_init() may fail, leading to a further Qemu crash
> because Qemu assumes it never fails. Check virtio_gpu_virgl_init()
> return code and don't execute virtio commands on error. Failed
> virtio_gpu_virgl_init() will result in a timed out virtio commands
> for a guest OS.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-gl.c     | 29 +++++++++++++++++++++--------
>   include/hw/virtio/virtio-gpu.h | 11 +++++++++--
>   2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index e06be60dfbfc..38a2b1bd3916 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -29,9 +29,14 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
>                                                struct virtio_gpu_scanout *s,
>                                                uint32_t resource_id)
>   {
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>       uint32_t width, height;
>       uint32_t pixels, *data;
>   
> +    if (gl->renderer_state != RS_INITED) {
> +        return;
> +    }
> +
>       data = virgl_renderer_get_cursor_data(resource_id, &width, &height);
>       if (!data) {
>           return;
> @@ -65,13 +70,21 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>           return;
>       }
>   
> -    if (!gl->renderer_inited) {
> -        virtio_gpu_virgl_init(g);
> -        gl->renderer_inited = true;
> -    }
> -    if (gl->renderer_reset) {
> -        gl->renderer_reset = false;
> +    switch (gl->renderer_state) {
> +    case RS_RESET:
>           virtio_gpu_virgl_reset(g);
> +        /* fallthrough */
> +    case RS_START:
> +        if (virtio_gpu_virgl_init(g)) {
> +            gl->renderer_state = RS_INIT_FAILED;
> +        } else {
> +            gl->renderer_state = RS_INITED;
> +        }
> +        break;
> +    case RS_INIT_FAILED:
> +        return;
> +    case RS_INITED:
> +        break;
>       }
>   
>       cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
> @@ -98,9 +111,9 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
>        * GL functions must be called with the associated GL context in main
>        * thread, and when the renderer is unblocked.
>        */
> -    if (gl->renderer_inited && !gl->renderer_reset) {
> +    if (gl->renderer_state == RS_INITED) {
>           virtio_gpu_virgl_reset_scanout(g);
> -        gl->renderer_reset = true;
> +        gl->renderer_state = RS_RESET;
>       }
>   }
>   
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 7ff989a45a5c..6e71d799e5da 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -224,11 +224,18 @@ struct VirtIOGPUClass {
>                                Error **errp);
>   };
>   
> +/* VirtIOGPUGL renderer states */
> +typedef enum {
> +    RS_START,       /* starting state */
> +    RS_INIT_FAILED, /* failed initialisation */

Is the distinction between RS_START and RS_INIT_FAILED really necessary?

