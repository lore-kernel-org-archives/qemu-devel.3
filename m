Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC910C47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 12:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUnWL-0003CE-Dt; Tue, 30 Jan 2024 07:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rUnWB-0003AD-SJ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:47:13 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rUnW9-0004b5-FS
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:47:10 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-42b471540aaso2497881cf.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 04:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706618823; x=1707223623; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4ZMY3pNRZH9y69tonv0+6nZuel941F9tmAloyRfJ8Q=;
 b=J86RVgfFDM47gh4PtLtxpMg1X1jFJJjylNbLRkqIU++hGUsbphZfXmB0gQ4CV9g4oC
 x90+kaBK8e/fORGtFzU2bznwrPgvjFU3jhwpK5IrPeuDQaFi7zlJHrZnmxtSmdblo59p
 RSksgzBElpV3Dz4oYpBrHpECx8uWFmxrKIla3BzrJG8wlSFXyHZW9eVO2F7LWaRgSwfy
 F5akc0fXB41y0ShfcMs4YzqPPmf3lUAy1uVwmZYNuihkz27QBufLQa9dDXNay965CGS6
 HKSP1Yon/eSujUNd2QdIaT4GrnDJJi5UzXQQ0mIfT8bHZs8tmfm9VTIwpYVBwXMT2zA7
 dpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706618823; x=1707223623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4ZMY3pNRZH9y69tonv0+6nZuel941F9tmAloyRfJ8Q=;
 b=KJ4gbzbiGKUAxWypgGpN0tC6e+aFLJCMUdyiOK5dugiLsjBS7If+Y2Hjolk1V1Giop
 C1kbhdug/8Qu9z784hUTJVVFKYacMGS+hruLtmQ3M2vYc0Xjd+FDuKxvGIXImcO3sH8J
 poDpwjTVUXcYOok7xWVU6E7yhFDDfUnWLFEi5AUtkKBPNNsZSD6QC2IprlO3HMSq1vAt
 pBbqfLAtaqut7fNFcvKg8wBKIdfbyik31DjeAcUjfEIfuw23HT38/dYJwxeV4FIvXfak
 qXP0ho6L1yx+UqVeEkYubU72pw5zQgbcMWoiFO92pAgqY9HLUctju0HEWK1bI8q/pXD9
 AVZw==
X-Gm-Message-State: AOJu0YzXgO3SxBvvOmsZfUwMi5La/SvOinbk4B7HY4LbP9sFUtBnNuA1
 Se5/akUhYszz+DWSMh3Dy4RAFjyX1A8azamxw8PeQNA7HgG5//TOv6w0CW8OuzFC+gjRrkQ4ycb
 PEF1ZhI5GeYVkw9cbhPErf6J8+sw=
X-Google-Smtp-Source: AGHT+IEr7tbm+OFIF80YxsPt8IMDR8hwiiBigRRfnFfxamp/a9CyD3p7NlY2PV+W+65KM7vFSTe3PhQJeojOOilobwE=
X-Received: by 2002:a05:622a:156:b0:42a:a4d5:966f with SMTP id
 v22-20020a05622a015600b0042aa4d5966fmr4819499qtw.113.1706618822973; Tue, 30
 Jan 2024 04:47:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
 <78b15e8f7e2af529aeaed2e6ef37efa508cf405f.1706542958.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <78b15e8f7e2af529aeaed2e6ef37efa508cf405f.1706542958.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Jan 2024 16:46:51 +0400
Message-ID: <CAJ+F1CL8KKK4Sor5bZjVB7fGGhzWtb-VjkCAZPDeCjbeE8a98g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio-gpu.c: add resource_destroy class method
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jan 29, 2024 at 7:46=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> When destroying/unrefing resources, devices such as virtio-gpu-rutabaga
> need to do their own bookkeeping (free rutabaga resources that are
> associated with the virtio_gpu_simple_resource).
>
> This commit adds a class method so that virtio-gpu-rutabaga can override
> it in the next commit.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  include/hw/virtio/virtio-gpu.h |  3 +++
>  hw/display/virtio-gpu.c        | 25 ++++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 584ba2ed73..b28e7ef0d2 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -219,6 +219,9 @@ struct VirtIOGPUClass {
>      void (*update_cursor_data)(VirtIOGPU *g,
>                                 struct virtio_gpu_scanout *s,
>                                 uint32_t resource_id);
> +    void (*resource_destroy)(VirtIOGPU *g,
> +                             struct virtio_gpu_simple_resource *res,
> +                             Error **errp);
>  };
>
>  struct VirtIOGPUGL {
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 2b73ae585b..1c1ee230b3 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -402,7 +402,8 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g, =
int scanout_id)
>  }
>
>  static void virtio_gpu_resource_destroy(VirtIOGPU *g,
> -                                        struct virtio_gpu_simple_resourc=
e *res)
> +                                        struct virtio_gpu_simple_resourc=
e *res,
> +                                        Error **errp)
>  {
>      int i;
>
> @@ -438,7 +439,11 @@ static void virtio_gpu_resource_unref(VirtIOGPU *g,
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>          return;
>      }
> -    virtio_gpu_resource_destroy(g, res);
> +    /*
> +     * virtio_gpu_resource_destroy does not set any errors, so pass a NU=
LL errp
> +     * to ignore them.
> +     */
> +    virtio_gpu_resource_destroy(g, res, NULL);

&error_fatal would be better.

>  }
>
>  static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
> @@ -1488,11 +1493,24 @@ static void virtio_gpu_device_unrealize(DeviceSta=
te *qdev)
>  static void virtio_gpu_reset_bh(void *opaque)
>  {
>      VirtIOGPU *g =3D VIRTIO_GPU(opaque);
> +    VirtIOGPUClass *vgc =3D VIRTIO_GPU_GET_CLASS(g);
>      struct virtio_gpu_simple_resource *res, *tmp;
> +    uint32_t resource_id;
> +    Error *local_err =3D NULL;
>      int i =3D 0;
>
>      QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> -        virtio_gpu_resource_destroy(g, res);
> +        resource_id =3D res->resource_id;
> +        vgc->resource_destroy(g, res, &local_err);
> +        if (local_err) {
> +            error_append_hint(&local_err, "%s: %s resource_destroy"
> +                              "for resource_id =3D %"PRIu32" failed.\n",
> +                              __func__, object_get_typename(OBJECT(g)),
> +                              resource_id);
> +            /* error_report_err frees the error object for us */
> +            error_report_err(local_err);
> +            local_err =3D NULL;
> +        }
>      }
>
>      for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> @@ -1632,6 +1650,7 @@ static void virtio_gpu_class_init(ObjectClass *klas=
s, void *data)
>      vgc->handle_ctrl =3D virtio_gpu_handle_ctrl;
>      vgc->process_cmd =3D virtio_gpu_simple_process_cmd;
>      vgc->update_cursor_data =3D virtio_gpu_update_cursor_data;
> +    vgc->resource_destroy =3D virtio_gpu_resource_destroy;
>      vgbc->gl_flushed =3D virtio_gpu_handle_gl_flushed;
>
>      vdc->realize =3D virtio_gpu_device_realize;
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>

otherwise,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

