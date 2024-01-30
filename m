Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD0CC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 12:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUnZs-0005GM-7f; Tue, 30 Jan 2024 07:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rUnZn-0005Bb-OC
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:50:59 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rUnZl-0005Og-Jp
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:50:55 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42a9c21f9ecso12162951cf.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 04:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706619052; x=1707223852; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3KnXCCv6NztSUmS/XI3n+P3/1yeTTsnFfJwkgyt5MDE=;
 b=MCMZ6z0x95+4mlIgbwCSjR5rKs4DrGlRiwUPGC26cKygSues4zQxoBbm4c9prW3/CP
 DFXC74I0VZzLPWBAnUNLxKW4ZQI8lrObr9IGchWgDLrlhesE++1xtroly5BAaIKZGNxe
 OgL9oOa223KQ4LuqtiMpCiJWdAdaEtt80zTRp1RVzfUstBZYxH+AfmYmO4meQoPq/q/5
 qybz4vJdPDyY+V45Dax/SKG7VoisW9i0ozCP1o9lTSyZLqtfpKXGSrNPhY35X9Yv+JpJ
 G+DqZ0hvhvRwxejsqZkIbGiBh826Cnk6VvFbAFt77nH14QAbDvO+9sLBVbMMGq5Eej/C
 SlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706619052; x=1707223852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KnXCCv6NztSUmS/XI3n+P3/1yeTTsnFfJwkgyt5MDE=;
 b=eUdZui2BINYGgejiQa8GoYxoGYK9poyGwmMNYopFFF0+LTbsNHxGm8b7x2WBiyj4pL
 F7czPL0ePl3WwIv6qAcu+e57GhewnUKuPuGlxIcEhTkfH4lSt7zFa4Jf52RPR7VHq9+j
 swZqTqmFs4bJwnKwxMFN8V8FU4/D9lmLs+mpXk0d4mjBQmPvsIbJYg4RJaI7DG7gT7gY
 vo2lbK0MrebpAg6MgaISE8TQT8GapNhAQw9WR8uSWJUmV6DR/+yB8sYTFcvZbVcxoHD+
 m73YvPDeOVlBR/166h9AAhqqmDVKxrDjnEormNSf4ialX42jnRw5zNSkOh8VqN27PTwJ
 AnMA==
X-Gm-Message-State: AOJu0YxV/xMYd6yOWTi9xrMlPihUyNwo2dfdzW3AInYW42Z64gOihSFW
 gcZLqnHwr0GmmdvOleyjgLblEJKd9qyVRucJjJbc3xkkv7/pdeQukjx0LuTyNxLYs5RDY4coa5U
 qr3d/TQOGq4cxVDqRm0seihB3BTw=
X-Google-Smtp-Source: AGHT+IHvdKN2BuxZKNomE1M5jVyFVCgCfz+Mwjju0u2H2G2MTphJnfCqctFtnASfybzQ412DnAfbq463Fw3VDeGv/cI=
X-Received: by 2002:a05:622a:1a16:b0:42a:8507:c985 with SMTP id
 f22-20020a05622a1a1600b0042a8507c985mr10183677qtb.79.1706619052368; Tue, 30
 Jan 2024 04:50:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
 <926db899bebc1f9ca575bfd29d140f7658050a82.1706542958.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <926db899bebc1f9ca575bfd29d140f7658050a82.1706542958.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Jan 2024 16:50:41 +0400
Message-ID: <CAJ+F1CL-ikZMQzYv_7VydAthTAfSUnYNONg+YUMKhw90+zAgcg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtio-gpu-rutabaga.c: override resource_destroy
 method
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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
> When the Rutabaga GPU device frees resources, it calls
> rutabaga_resource_unref for that resource_id. However, when the generic
> VirtIOGPU functions destroys resources, it only removes the
> virtio_gpu_simple_resource from the device's VirtIOGPU->reslist list.
> The rutabaga resource associated with that resource_id is then leaked.
>
> This commit overrides the resource_destroy class method introduced in
> the previous commit to fix this.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/display/virtio-gpu-rutabaga.c | 51 ++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rut=
abaga.c
> index 9e67f9bd51..6ac0776005 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -148,14 +148,42 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
>  }
>
>  static void
> +virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
> +                                   struct virtio_gpu_simple_resource *re=
s,
> +                                   Error **errp)
> +{
> +    int32_t result;
> +    const char *strerror =3D NULL;
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    result =3D rutabaga_resource_unref(vr->rutabaga, res->resource_id);
> +    if (result) {
> +        error_setg(errp, "%s: rutabaga_resource_unref returned %"PRIi32
> +                   " for resource_id =3D %"PRIu32, __func__, result,
> +                   res->resource_id);
> +        strerror =3D strerrorname_np((int)result);
> +        if (strerror !=3D NULL) {
> +            error_append_hint(errp, "%s: %s\n",
> +                              strerror, strerrordesc_np((int)result) ? :=
 "");
> +        }
> +    }

There is error_setg_errno()

> +
> +    if (res->image) {
> +        pixman_image_unref(res->image);
> +    }
> +
> +    QTAILQ_REMOVE(&g->reslist, res, next);
> +    g_free(res);
> +}
> +
> +static void
>  rutabaga_cmd_resource_unref(VirtIOGPU *g,
>                              struct virtio_gpu_ctrl_command *cmd)
>  {
> -    int32_t result;
> +    int32_t result =3D 0;
>      struct virtio_gpu_simple_resource *res;
>      struct virtio_gpu_resource_unref unref;
> -
> -    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +    Error *local_err =3D NULL;
>
>      VIRTIO_GPU_FILL_CMD(unref);
>
> @@ -164,15 +192,14 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,
>      res =3D virtio_gpu_find_resource(g, unref.resource_id);
>      CHECK(res, cmd);
>
> -    result =3D rutabaga_resource_unref(vr->rutabaga, unref.resource_id);
> -    CHECK(!result, cmd);
> -
> -    if (res->image) {
> -        pixman_image_unref(res->image);
> +    virtio_gpu_rutabaga_resource_unref(g, res, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        /* local_err was freed, do not reuse it. */
> +        local_err =3D NULL;
> +        result =3D 1;
>      }
> -
> -    QTAILQ_REMOVE(&g->reslist, res, next);
> -    g_free(res);
> +    CHECK(!result, cmd);
>  }
>
>  static void
> @@ -1099,7 +1126,7 @@ static void virtio_gpu_rutabaga_class_init(ObjectCl=
ass *klass, void *data)
>      vgc->handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl;
>      vgc->process_cmd =3D virtio_gpu_rutabaga_process_cmd;
>      vgc->update_cursor_data =3D virtio_gpu_rutabaga_update_cursor;
> -
> +    vgc->resource_destroy =3D virtio_gpu_rutabaga_resource_unref;
>      vdc->realize =3D virtio_gpu_rutabaga_realize;
>      device_class_set_props(dc, virtio_gpu_rutabaga_properties);
>  }
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>


--=20
Marc-Andr=C3=A9 Lureau

