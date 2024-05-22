Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E38BC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9jGq-0008If-0u; Wed, 22 May 2024 06:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9jGn-0008Hk-Cd
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:32:29 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9jGl-0000H5-DY
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:32:28 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59cdd185b9so152565566b.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716373945; x=1716978745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yNwVZxT4PYwaurJSplUO3c9LvWBXjT1168NPOeMsOL8=;
 b=K40+V7RJIdHaZW81EPcT7Ytsu5mO7ODVDak3Gs+X/408ZTwmYGBeAJ4vNwo/99s0U+
 7nzdip82x0lr/ndi17iXzpeQYh4g6q7KS5mxMq2QTZGNpYh0aBsJQcsn9/qheO/iEMIQ
 tz2C8epx8jnDYJ0YvHuLmv+WnFu6NGxWh9xhBoj76aoZ1OqFQmkPIuyv2V+Oe0uv4aDM
 Qb8SAg0lG3cdFuEAepikCGs7uyBO0PYlUoSVpRci8l/rhPUNC71WFl9ZshxLSNVWjmwi
 cIIzco2SU9vwl2xe+TnlrCPUoL7XBW3yfBZv7wpFNNZ9VvMscTnq3gFKH9ic3K7v9rPv
 vULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716373945; x=1716978745;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yNwVZxT4PYwaurJSplUO3c9LvWBXjT1168NPOeMsOL8=;
 b=AeeTvNHU3z0miHNIRH0qsn51LW8MjhlxufzeZZTNuxt7MgqxIsEMsH4nWWq4KQhCpH
 213z8IjK3/VKk9kcW2m98Efm45G8akCH+cH+YhydwI14EYk3XjY4MfCRNjZd8oLgubIJ
 bUbYf6YHw0TgCoaLL3qL2L8EcxUvh9gHHXYsRMdPaqU0VIxDzKt8nV399rWRtxqVplpP
 cLyLHbb6YQsI2g/MTzd3V+R6pt+VCjpqS3oI3yTk2ylun19PB3fGFRdFTbXkJfK2IBzK
 HiLnJNHHA4Z5mpermU3BJshHKdIYlJq750M+pyvRO6LICNAZ3RZ95Dddnc/0GlgScHut
 JCow==
X-Forwarded-Encrypted: i=1;
 AJvYcCURzLPd3W5ylzOv6SqwVzHRjw1FdhoJwToPeoRb/IfmPd8L6/8I/oqZ4ujvM0QQipOrtWOmRWQPr1G1tMkRDPS8CUv1CMM=
X-Gm-Message-State: AOJu0Yx8swicogHkOcnhdx+aOBnP43Ic0NvFvQ+a9yd5nRPhwFrNsnSj
 prwciXmRAbG5B5cKzuun6yez9MwE4ni1uPB/faeMLnzRuE8eDlfgyjcOBAJrfUs=
X-Google-Smtp-Source: AGHT+IFu6qnB8STPzFDg2qxdbI6ApUhaSNJT2Vdj4OHPdOOrsrR7U9cjky5cB1P5czUufD+yiBQ8dw==
X-Received: by 2002:a17:906:3ac2:b0:a5a:24ab:f5e with SMTP id
 a640c23a62f3a-a62232b6411mr125505466b.25.1716373945235; 
 Wed, 22 May 2024 03:32:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781ce5dsm1752255066b.42.2024.05.22.03.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 03:32:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2F8555F78B;
 Wed, 22 May 2024 11:32:24 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Antonio Caggiano
 <quic_acaggian@quicinc.com>,  "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>,  Robert Beckett <bob.beckett@collabora.com>,  Gert
 Wollny <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan
 Singh <gurchetansingh@chromium.org>,  ernunes@redhat.com,  Alyssa Ross
 <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v12 01/13] virtio-gpu: Unrealize GL device
In-Reply-To: <20240519212712.2605419-2-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Mon, 20 May 2024 00:27:00 +0300")
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <20240519212712.2605419-2-dmitry.osipenko@collabora.com>
Date: Wed, 22 May 2024 11:32:24 +0100
Message-ID: <87zfsigmrr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> Even though GL GPU doesn't support hotplugging today, free virgl
> resources when GL device is unrealized. For consistency.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-gl.c     | 11 +++++++++++
>  hw/display/virtio-gpu-virgl.c  |  6 ++++++
>  include/hw/virtio/virtio-gpu.h |  1 +
>  3 files changed, 18 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index e06be60dfbfc..0c0a8d136954 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -136,6 +136,16 @@ static Property virtio_gpu_gl_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20=20
> +static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
> +{
> +    VirtIOGPU *g =3D VIRTIO_GPU(qdev);
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(qdev);
> +
> +    if (gl->renderer_inited) {
> +        virtio_gpu_virgl_deinit(g);

Should we reset the flag at this point or are we relying on the QOM
lifetime to ensure *gl will be gone shortly after this?

> +    }
> +}
> +
>  static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -149,6 +159,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *kla=
ss, void *data)
>      vgc->update_cursor_data =3D virtio_gpu_gl_update_cursor_data;
>=20=20
>      vdc->realize =3D virtio_gpu_gl_device_realize;
> +    vdc->unrealize =3D virtio_gpu_gl_device_unrealize;
>      vdc->reset =3D virtio_gpu_gl_reset;
>      device_class_set_props(dc, virtio_gpu_gl_properties);
>  }
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 9f34d0e6619c..6ba4c24fda1d 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -665,3 +665,9 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>=20=20
>      return capset2_max_ver ? 2 : 1;
>  }
> +
> +void virtio_gpu_virgl_deinit(VirtIOGPU *g)
> +{
> +    timer_free(g->fence_poll);
> +    virgl_renderer_cleanup(NULL);
> +}
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 56d6e821bf04..8ece1ec2e98b 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -336,6 +336,7 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset(VirtIOGPU *g);
>  int virtio_gpu_virgl_init(VirtIOGPU *g);
> +void virtio_gpu_virgl_deinit(VirtIOGPU *g);
>  int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
>=20=20
>  #endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

