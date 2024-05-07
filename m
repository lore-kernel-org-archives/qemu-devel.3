Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4B0C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4MYy-0002Rf-Hf; Tue, 07 May 2024 11:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4MYs-0002R8-Bm
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:16:59 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4MYq-0004DB-Dg
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:16:58 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-23d477a1a4fso2382126fac.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715095014; x=1715699814; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SKuQ0NtGK0r0QKU5JGiXvVMw1MqkoWobQVNFOfSGtQ=;
 b=CHEOFf3+/PcyIrGTsPfGh9wexdrasdPmgztIn6pHDf8o95ITTSdjhHInyLwa42p923
 HPEtoDjHID6eLox2cwAI1YXkvJjs+NiY1TRlNnQG8U2T83mkX6RvIDE7kBlKwq0IQBs+
 0fb1qBETb0QzbLqVdBkoFpgO9bIR2OPhEX30qCRGShOL+++ww4tECvzA4EzC7s0hF7qb
 k3EMEzsGTYJuoZhvnWsdaxO5km+oi9bCnQP47XkIEJtFzR10BiWHoPI6JKZt30A+CdPl
 452ivGAMbWIkUKTeFM+wOpESHV6PHNO1kulpW/LvncPmRduLM3v8ZUkcUSD8dUqZNBNq
 hTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715095014; x=1715699814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9SKuQ0NtGK0r0QKU5JGiXvVMw1MqkoWobQVNFOfSGtQ=;
 b=cidhEd2nKuYIf6G7OTFfGJlt9wijGZ6gDILHV9/v7ml/S2hegov7YsTvAFLtjgrDUO
 ZBbPZf6Q+54bnFOoVHPl6xMfVWyhi3QK31Y5JShYTQiXCwCVuSEst9rn1eRBkR8pwlJr
 r/bX4L1Y2L38uriQ7DBk4wZAyeH5BbV9Wo1rI46ahlsgLEgtcyBSWbddsO+u9ROS6/M5
 bNbrVreBFALqualo3VE/I6pK2s2dbG/OAPZF83NNL+oVK6y+lmq+V1LBqwa7bo4DHBzi
 IiCfqZ9KKJPqBU+Bb7sfuYfNp2KGcOGiFQeHMkBiQO4D5d46JlCVGs5vEw23wMvb48i/
 MJdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAe2C5IgTe7M/VnzxUPGpGstrjNRsZIrs1TM8uxNg/XgzLEIFStAlPusRquuBDAytwew5/m/HIj44DoZHJmnlB5qXmseU=
X-Gm-Message-State: AOJu0Yz4kwCuO6bObWvV1ayVrJYWM2BbDqyDL8igkDjXn4W8thORAeHk
 ZBCl1FUvcuQnsjx58rcqL4hlzPuMGOVtDN3vTUJmxYOHm9oCfnqz0idoXIj7TiNGTFVHQzjPkR0
 jCwV/WHpHEZ5WWW4qZyVmyS6TB0I=
X-Google-Smtp-Source: AGHT+IHuOHXkY0M8pu0XR2B+yhPvdBnojUaeCEP4mxmLXQkC/WogZIwuqM8W1WAe8dTMe+vtgatLrdsawRKSVxd4bEE=
X-Received: by 2002:a05:6870:7195:b0:21f:d2a2:7ff4 with SMTP id
 d21-20020a056870719500b0021fd2a27ff4mr19309686oah.17.1715095014561; Tue, 07
 May 2024 08:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
 <20240504202834.399780-2-dmitry.osipenko@collabora.com>
In-Reply-To: <20240504202834.399780-2-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 May 2024 19:16:43 +0400
Message-ID: <CAJ+F1CKNDct66-v85UTbpDas7WkxsKPOsmaWHRa2CN2qW4kUmw@mail.gmail.com>
Subject: Re: [PATCH v10 01/10] virtio-gpu: Unrealize GL device
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Yiwei Zhang <zzyiwei@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oa1-x35.google.com
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

Hi

On Sun, May 5, 2024 at 12:29=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Even though GL GPU doesn't support hotplugging today, free virgl
> resources when GL device is unrealized. For consistency.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-gl.c     | 11 +++++++++++
>  hw/display/virtio-gpu-virgl.c  |  9 +++++++++
>  include/hw/virtio/virtio-gpu.h |  1 +
>  3 files changed, 21 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index e06be60dfbfc..0c0a8d136954 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -136,6 +136,16 @@ static Property virtio_gpu_gl_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
> +{
> +    VirtIOGPU *g =3D VIRTIO_GPU(qdev);
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(qdev);
> +
> +    if (gl->renderer_inited) {
> +        virtio_gpu_virgl_deinit(g);
> +    }
> +}
> +
>  static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -149,6 +159,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *kla=
ss, void *data)
>      vgc->update_cursor_data =3D virtio_gpu_gl_update_cursor_data;
>
>      vdc->realize =3D virtio_gpu_gl_device_realize;
> +    vdc->unrealize =3D virtio_gpu_gl_device_unrealize;
>      vdc->reset =3D virtio_gpu_gl_reset;
>      device_class_set_props(dc, virtio_gpu_gl_properties);
>  }
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 9f34d0e6619c..b0500eccf8e0 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -665,3 +665,12 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>
>      return capset2_max_ver ? 2 : 1;
>  }
> +
> +void virtio_gpu_virgl_deinit(VirtIOGPU *g)
> +{
> +    if (g->fence_poll) {
> +        timer_free(g->fence_poll);

might be worth to set g->fence_poll to NULL here, to be able to call
deinit() multiple times.

> +    }
> +
> +    virgl_renderer_cleanup(NULL);
> +}
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index ed44cdad6b34..b657187159d9 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -336,6 +336,7 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset(VirtIOGPU *g);
>  int virtio_gpu_virgl_init(VirtIOGPU *g);
> +void virtio_gpu_virgl_deinit(VirtIOGPU *g);
>  int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
>
>  #endif
> --
> 2.44.0
>

otherwise:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

