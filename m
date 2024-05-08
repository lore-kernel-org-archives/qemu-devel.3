Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D711C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 06:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4bE4-0004i3-GF; Wed, 08 May 2024 02:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4bE1-0004g7-1x
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:56:26 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4bDy-0001Dx-Dc
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:56:24 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6203f553e5fso38020477b3.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 23:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715151381; x=1715756181; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qpMNn1Aekh5DY0thMJwtwHHqh3hMzaZmZVn+/wV15+o=;
 b=glXLRYwOAFxTw1i5bj7+1L/wii/evGh0VE9qBIjtuRBhyGgpnyuDrsMFkoV6w1m9wy
 XNkcuei9OGnZouQI8aFaidBmX9OVtOQBS7yuoyr466xQA4qyrITOQU987l0HuyNAMGct
 RqrElbnumGkMGfq4WFIA/I9N/De2cLbYXzunx1FFdcpq/uws6hpf5OpSv6brFft5VE+T
 jVs6Hsmhc36VfSA5kfubpjzy3smHZYz+4Rm+7BritnjjPs9+eZqZtCnmYt4EXmFdKB68
 qSzbo3e+JlgR0A/ruYZg+Xmnnf4IHLeprpm+kkxp433Swu/Jiv0gHotduGBuvou01XaR
 mnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715151381; x=1715756181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qpMNn1Aekh5DY0thMJwtwHHqh3hMzaZmZVn+/wV15+o=;
 b=f5ZSUgxGB7M18VBYyV8MicKmj1UqUOfCLtrl2JnQH3ysbYdhaiQjsjorG2tvcER6Gs
 umJAgD3zIufvk6Co2531AK+uxbBMVfnvnHje23Jw/jZ+F9Pi/epzPDdTiQ9vxQDU1Yu8
 wvxSN1MWbyJq9wlCBJOZa9oGiWnKMMM1x+ET/22A7+2QeugO/Zp1C0oVbO3BF+PGnlX1
 FaU07PgubDhcHlp5g4jiXgPKWP5/uPKbzqw8l4YCq9nnNwU/pAIWzRMAq2682ZC8PMUA
 vOkTxqU6wZ2Y7ZOyqUuT1IEZ50KUBl2uDOp+9I3akt9NJOMM1txw+gxYOGhzBvHVJ5U0
 q/mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiOS88vi6WyUotRoMLmyEvOWim/KxXap2FR4dezbfzU2EA/93eHxzrQPNsdJzd+XErDSKionmdixW6ZEchjG8hqTZU1s4=
X-Gm-Message-State: AOJu0YyU4GJfgEYvUiW4iySKYMV1lr/yf6R8n1Kj1TdyyeJ1pQSqa1k1
 u1Hf36VAqcx/9/u/MKFME/paaFintSIVE6KgX4zm52mo9uIK/KheAKXTW1+I5/4syXUSFPz6nFM
 tRQiFhwg2q83C7avNnkf4p9AVxhw=
X-Google-Smtp-Source: AGHT+IFlH1EHdTMMBv1ov8LUYftWMqS6JExy38Ru0KCOX0tQVX0n5qvz8QSsDS2uX7jWubb3zVngF8En74aOi22PXsM=
X-Received: by 2002:a0d:ea16:0:b0:61b:e238:70a with SMTP id
 00721157ae682-62085d82c68mr19691957b3.49.1715151380692; Tue, 07 May 2024
 23:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
 <20240504202834.399780-10-dmitry.osipenko@collabora.com>
In-Reply-To: <20240504202834.399780-10-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 May 2024 10:56:08 +0400
Message-ID: <CAJ+F1C+SUkn6f9Y5=fFm1TpW3d-wUZ99SVdXL93yvQ9CwZjWpQ@mail.gmail.com>
Subject: Re: [PATCH v10 09/10] virtio-gpu: Register capsets dynamically
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1133.google.com
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

On Sun, May 5, 2024 at 12:29=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>
> virtio_gpu_virgl_get_num_capsets will return "num_capsets", but we can't
> assume that capset_index 1 is always VIRGL2 once we'll support more capse=
ts,
> like Venus and DRM capsets. Register capsets dynamically to avoid that pr=
oblem.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu-gl.c     |  6 ++++--
>  hw/display/virtio-gpu-virgl.c  | 33 +++++++++++++++++++++------------
>  include/hw/virtio/virtio-gpu.h |  4 +++-
>  3 files changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 2a9e549ad2e9..cd39e0650862 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -125,8 +125,8 @@ static void virtio_gpu_gl_device_realize(DeviceState =
*qdev, Error **errp)
>      }
>
>      g->parent_obj.conf.flags |=3D (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
> -    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =3D
> -        virtio_gpu_virgl_get_num_capsets(g);
> +    g->capset_ids =3D virtio_gpu_virgl_get_capsets(g);
> +    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =3D g->capset_ids->len=
;
>
>  #ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
>      g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENAB=
LED;
> @@ -149,6 +149,8 @@ static void virtio_gpu_gl_device_unrealize(DeviceStat=
e *qdev)
>      if (gl->renderer_inited) {
>          virtio_gpu_virgl_deinit(g);
>      }
> +
> +    g_array_unref(g->capset_ids);
>  }
>
>  static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index d92c58b77865..1babda4efad5 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -585,19 +585,13 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
>      VIRTIO_GPU_FILL_CMD(info);
>
>      memset(&resp, 0, sizeof(resp));
> -    if (info.capset_index =3D=3D 0) {
> -        resp.capset_id =3D VIRTIO_GPU_CAPSET_VIRGL;
> -        virgl_renderer_get_cap_set(resp.capset_id,
> -                                   &resp.capset_max_version,
> -                                   &resp.capset_max_size);
> -    } else if (info.capset_index =3D=3D 1) {
> -        resp.capset_id =3D VIRTIO_GPU_CAPSET_VIRGL2;
> +
> +    if (info.capset_index < g->capset_ids->len) {
> +        resp.capset_id =3D g_array_index(g->capset_ids, uint32_t,
> +                                       info.capset_index);
>          virgl_renderer_get_cap_set(resp.capset_id,
>                                     &resp.capset_max_version,
>                                     &resp.capset_max_size);
> -    } else {
> -        resp.capset_max_version =3D 0;
> -        resp.capset_max_size =3D 0;
>      }
>      resp.hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET_INFO;
>      virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> @@ -1120,14 +1114,29 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>      return 0;
>  }
>
> -int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
> +static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t cap=
set_id)
> +{
> +    g_array_append_val(capset_ids, capset_id);
> +}
> +
> +GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
>  {
>      uint32_t capset2_max_ver, capset2_max_size;
> +    GArray *capset_ids;
> +
> +    capset_ids =3D g_array_new(false, false, sizeof(uint32_t));
> +
> +    /* VIRGL is always supported. */
> +    virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
> +
>      virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
>                                &capset2_max_ver,
>                                &capset2_max_size);
> +    if (capset2_max_ver) {
> +        virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2=
);
> +    }
>
> -    return capset2_max_ver ? 2 : 1;
> +    return capset_ids;
>  }
>
>  void virtio_gpu_virgl_deinit(VirtIOGPU *g)
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index a98847b88087..105308a36865 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -213,6 +213,8 @@ struct VirtIOGPU {
>      } dmabuf;
>
>      QEMUBH *cmdq_resume_bh;
> +
> +    GArray *capset_ids;
>  };
>
>  struct VirtIOGPUClass {
> @@ -347,6 +349,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset(VirtIOGPU *g);
>  int virtio_gpu_virgl_init(VirtIOGPU *g);
>  void virtio_gpu_virgl_deinit(VirtIOGPU *g);
> -int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
> +GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
>
>  #endif
> --
> 2.44.0
>


--=20
Marc-Andr=C3=A9 Lureau

