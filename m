Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9EAC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUnke-0002bN-RH; Tue, 30 Jan 2024 08:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUnkQ-0002T5-Nv
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:01:55 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUnkL-0007Ph-S0
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:01:52 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55eedf5a284so3110693a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 05:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706619699; x=1707224499; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLXGgARUyhqaofNhC8usGY6wYzWMuPvYAD//3dIcea4=;
 b=b4qv0/ZwW9aEe2nyDsaMMJmSw+yQwRThzfgEA6jdgcgV1PKZ6c8P7xDwXo1EVMPSyC
 w2XBB4iFEAdfzoQ0Fbh2tVM6Ot1IisNhFQ+3MuosOlEGpAT8oSaPZJookvUJZ6TbjzZv
 8xwSZVV0meuLR+cKujxzWuf3MChbnqWOVAuAslTw/wK4rX5VtrKgDpfoTX4qf02QjMcp
 jzmXlw+HR97pe+wRcFvy+6JYKqD7WQTp7kczek8Gy557yB5QHA9ciQGVETdIJ0KbEDGJ
 0zVV0683J/nxXYG1qD6qsGXajE0i3JY5Z9WxU0zwhICkP1KwW/rCeTjSJycYbnbIIexu
 UqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706619699; x=1707224499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aLXGgARUyhqaofNhC8usGY6wYzWMuPvYAD//3dIcea4=;
 b=SSG55U+l8f4vHGxiXBCvj0wJR2sDKTNw+z7yzmaYhDZhjjeWEaW+81o/8OaYRIvl6D
 l2vkD07ayb5qKiR0lfwMCX06aA0N6uDjlwi+HwrSfsKCSTRPLTFCWw3TDlPsAZTEg0ia
 sBmZA0AdJ+5uKRWdiHpKmwrV8oJTEqmDKxajKf74ig6C3B5DplmA4cWf78hV6JxmkafF
 U/hhWbZk63Uzt8exq0CUA4BTehhda5h+RTuCgjliJRn0IMQzpJgQwhxVfnLgHLk52XVh
 UAlV07TqiiqtX4+DRCdL90a8JvdTkSLwrzuWuQV/kn7vysK5q1gJ8uzjg7mZQ2Chc4Zy
 6Djw==
X-Gm-Message-State: AOJu0Yxbqqie3cuC+OI8IzuTrL9Bq/A4SrhKH4Dy8xWhz62hVTG5swn3
 Gg/n0gMKD/JzpGq/F0IcLMPSiTp1i6QayweHLNQ4MOa2nVYMPU6/vH0Ke21juvpZ4V6thFrTLGB
 GWDVmQLfkvNvxdKKXgbTm1Akom0BpNUcsRT2lRQ==
X-Google-Smtp-Source: AGHT+IGHqfBuJE4uEyfR7o0KQkQLi7UBE0eekBYotYBFsIT18ZhW78Lc/tR9tlT2DjSUTV3ZKtomFqfkdmR/fs5T8To=
X-Received: by 2002:a05:6402:22a3:b0:55f:2c48:abe0 with SMTP id
 cx3-20020a05640222a300b0055f2c48abe0mr1979293edb.23.1706619699052; Tue, 30
 Jan 2024 05:01:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
 <926db899bebc1f9ca575bfd29d140f7658050a82.1706542958.git.manos.pitsidianakis@linaro.org>
 <CAJ+F1CL-ikZMQzYv_7VydAthTAfSUnYNONg+YUMKhw90+zAgcg@mail.gmail.com>
In-Reply-To: <CAJ+F1CL-ikZMQzYv_7VydAthTAfSUnYNONg+YUMKhw90+zAgcg@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 30 Jan 2024 15:01:23 +0200
Message-ID: <CAAjaMXbK1huSUTu7T9QnzbABcVLXE2hG=CHgFFOUD-A_6_AOUw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtio-gpu-rutabaga.c: override resource_destroy
 method
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 30 Jan 2024 at 14:50, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Mon, Jan 29, 2024 at 7:46=E2=80=AFPM Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > When the Rutabaga GPU device frees resources, it calls
> > rutabaga_resource_unref for that resource_id. However, when the generic
> > VirtIOGPU functions destroys resources, it only removes the
> > virtio_gpu_simple_resource from the device's VirtIOGPU->reslist list.
> > The rutabaga resource associated with that resource_id is then leaked.
> >
> > This commit overrides the resource_destroy class method introduced in
> > the previous commit to fix this.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >  hw/display/virtio-gpu-rutabaga.c | 51 ++++++++++++++++++++++++--------
> >  1 file changed, 39 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-r=
utabaga.c
> > index 9e67f9bd51..6ac0776005 100644
> > --- a/hw/display/virtio-gpu-rutabaga.c
> > +++ b/hw/display/virtio-gpu-rutabaga.c
> > @@ -148,14 +148,42 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
> >  }
> >
> >  static void
> > +virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
> > +                                   struct virtio_gpu_simple_resource *=
res,
> > +                                   Error **errp)
> > +{
> > +    int32_t result;
> > +    const char *strerror =3D NULL;
> > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +
> > +    result =3D rutabaga_resource_unref(vr->rutabaga, res->resource_id)=
;
> > +    if (result) {
> > +        error_setg(errp, "%s: rutabaga_resource_unref returned %"PRIi3=
2
> > +                   " for resource_id =3D %"PRIu32, __func__, result,
> > +                   res->resource_id);
> > +        strerror =3D strerrorname_np((int)result);
> > +        if (strerror !=3D NULL) {
> > +            error_append_hint(errp, "%s: %s\n",
> > +                              strerror, strerrordesc_np((int)result) ?=
 : "");
> > +        }
> > +    }
>
> There is error_setg_errno()

I did not use it on purpose because I was not certain if rutabaga_gfx
starts using other error numbers in the future. I don't like my
approach but I don't like assuming it's an errno either to be
honest... Which one seems better to you?

Thanks,
Manos

> > +
> > +    if (res->image) {
> > +        pixman_image_unref(res->image);
> > +    }
> > +
> > +    QTAILQ_REMOVE(&g->reslist, res, next);
> > +    g_free(res);
> > +}
> > +
> > +static void
> >  rutabaga_cmd_resource_unref(VirtIOGPU *g,
> >                              struct virtio_gpu_ctrl_command *cmd)
> >  {
> > -    int32_t result;
> > +    int32_t result =3D 0;
> >      struct virtio_gpu_simple_resource *res;
> >      struct virtio_gpu_resource_unref unref;
> > -
> > -    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > +    Error *local_err =3D NULL;
> >
> >      VIRTIO_GPU_FILL_CMD(unref);
> >
> > @@ -164,15 +192,14 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,
> >      res =3D virtio_gpu_find_resource(g, unref.resource_id);
> >      CHECK(res, cmd);
> >
> > -    result =3D rutabaga_resource_unref(vr->rutabaga, unref.resource_id=
);
> > -    CHECK(!result, cmd);
> > -
> > -    if (res->image) {
> > -        pixman_image_unref(res->image);
> > +    virtio_gpu_rutabaga_resource_unref(g, res, &local_err);
> > +    if (local_err) {
> > +        error_report_err(local_err);
> > +        /* local_err was freed, do not reuse it. */
> > +        local_err =3D NULL;
> > +        result =3D 1;
> >      }
> > -
> > -    QTAILQ_REMOVE(&g->reslist, res, next);
> > -    g_free(res);
> > +    CHECK(!result, cmd);
> >  }
> >
> >  static void
> > @@ -1099,7 +1126,7 @@ static void virtio_gpu_rutabaga_class_init(Object=
Class *klass, void *data)
> >      vgc->handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl;
> >      vgc->process_cmd =3D virtio_gpu_rutabaga_process_cmd;
> >      vgc->update_cursor_data =3D virtio_gpu_rutabaga_update_cursor;
> > -
> > +    vgc->resource_destroy =3D virtio_gpu_rutabaga_resource_unref;
> >      vdc->realize =3D virtio_gpu_rutabaga_realize;
> >      device_class_set_props(dc, virtio_gpu_rutabaga_properties);
> >  }
> > --
> > =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau

