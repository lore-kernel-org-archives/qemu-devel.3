Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BC0C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUoWC-0004Gt-Jw; Tue, 30 Jan 2024 08:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUoWA-0004GJ-AM
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:51:14 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUoVv-0002GV-5O
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:51:13 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55f082c2c92so2907410a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 05:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706622657; x=1707227457; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrzG9MutAFQcDArrmdMRLYd4LyLH50CKX4dxKix7kk4=;
 b=IXekr/09tghBcIc/KDpTaIJkoO+/qDJr22drqMYWqTcnEETmyyi2CZKyX8o+smBtrG
 0n4uvouNx5rux/0uNWurrSnopR6Z9XjyBOhpfn3F4N8uJLZQ4H5Jh+BU467G1PdqbNQB
 zGHhNCnp/fqmo35xh7aLpYaQ2vSfJII9oi3jvRxodXjTPPxv2+Ua+w8HEt6uH9ucnzr6
 b9NEEg9J7TnTglpovwCG7lO1lxguIqA1SY5KnOGnBnc/lNkC6vaqoXtvytsPe7lgO691
 04/H5q5BhUVr9HnWRt0zCO56QTdgIAhniKhx2Am+QRAYs55Gh+6Ov5SX0LYufJhIkTgT
 61Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706622657; x=1707227457;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lrzG9MutAFQcDArrmdMRLYd4LyLH50CKX4dxKix7kk4=;
 b=j3+WL1y3zNImUEOP8zr+q5UGGfNxVxJwzg7cv+ugsGWWbobO2Zk3KlWY1J+RUdLDaW
 7p5tzka6viUxNM0MS8ISvn1iWp+NLYR1NW8cMyF7134ORneqGmNS0E2xGnOUxWztcaRX
 6b2i1OaifB37XaeWlCDeffHcXyycctLJNZIa+sA33hbrY7k2XSo+twcB9wcPFKACT3xG
 QmozCVnZSJqGl0vjvuJlqyh1umTss2udTLj7juekMSiHk/fOfNdngX9ntB6X2PD+Hn0c
 rVmADWp6NadV2y2ljiVTCBwWWHrljS4Z9hdJYXVGl9AsJUFL1us+Idjt5Ng3+KHHfpXa
 zAgQ==
X-Gm-Message-State: AOJu0YwzbyoJU3cMnzgMvwzNHp1MQ0BQwuV+d7lek2gLsKauHdpO61iB
 b+YkyyEgBCT+dh7sXvZqVNZT51tALOTrKSnC8kJlw+8LJb+e+d+gRMVqK62qd2Y2cqAmcUe3L+e
 ejN4AI/Ti2zaTuW7mvCwNPnK9nj3HYap8cUz8FQ==
X-Google-Smtp-Source: AGHT+IFpsNizZrKY9gpAeZX833CDSiJyGStLaqJRa7uTR4LHaiTVqYsIiUkQAom7oiQC5l/n5c4ZTN+r8xYXM0+zQkM=
X-Received: by 2002:a05:6402:40c8:b0:55c:9c5c:1c7e with SMTP id
 z8-20020a05640240c800b0055c9c5c1c7emr7676881edb.31.1706622657183; Tue, 30 Jan
 2024 05:50:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
 <926db899bebc1f9ca575bfd29d140f7658050a82.1706542958.git.manos.pitsidianakis@linaro.org>
 <CAJ+F1CL-ikZMQzYv_7VydAthTAfSUnYNONg+YUMKhw90+zAgcg@mail.gmail.com>
 <CAAjaMXbK1huSUTu7T9QnzbABcVLXE2hG=CHgFFOUD-A_6_AOUw@mail.gmail.com>
 <CAJ+F1CKLSphCvCKr5cnNqHmo7+cUf+STX1QvZkMogkcPVJ9U0A@mail.gmail.com>
In-Reply-To: <CAJ+F1CKLSphCvCKr5cnNqHmo7+cUf+STX1QvZkMogkcPVJ9U0A@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 30 Jan 2024 15:50:41 +0200
Message-ID: <CAAjaMXZGOfbT+V_dwFs6kYrOJp8GXF445nz8vr9Y6Nf5bW8RPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtio-gpu-rutabaga.c: override resource_destroy
 method
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Jan 2024 at 15:10, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Tue, Jan 30, 2024 at 5:01=E2=80=AFPM Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > On Tue, 30 Jan 2024 at 14:50, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@gmail.com> wrote:
> > >
> > > Hi
> > >
> > > On Mon, Jan 29, 2024 at 7:46=E2=80=AFPM Manos Pitsidianakis
> > > <manos.pitsidianakis@linaro.org> wrote:
> > > >
> > > > When the Rutabaga GPU device frees resources, it calls
> > > > rutabaga_resource_unref for that resource_id. However, when the gen=
eric
> > > > VirtIOGPU functions destroys resources, it only removes the
> > > > virtio_gpu_simple_resource from the device's VirtIOGPU->reslist lis=
t.
> > > > The rutabaga resource associated with that resource_id is then leak=
ed.
> > > >
> > > > This commit overrides the resource_destroy class method introduced =
in
> > > > the previous commit to fix this.
> > > >
> > > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > > ---
> > > >  hw/display/virtio-gpu-rutabaga.c | 51 ++++++++++++++++++++++++----=
----
> > > >  1 file changed, 39 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-g=
pu-rutabaga.c
> > > > index 9e67f9bd51..6ac0776005 100644
> > > > --- a/hw/display/virtio-gpu-rutabaga.c
> > > > +++ b/hw/display/virtio-gpu-rutabaga.c
> > > > @@ -148,14 +148,42 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
> > > >  }
> > > >
> > > >  static void
> > > > +virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
> > > > +                                   struct virtio_gpu_simple_resour=
ce *res,
> > > > +                                   Error **errp)
> > > > +{
> > > > +    int32_t result;
> > > > +    const char *strerror =3D NULL;
> > > > +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > > > +
> > > > +    result =3D rutabaga_resource_unref(vr->rutabaga, res->resource=
_id);
> > > > +    if (result) {
> > > > +        error_setg(errp, "%s: rutabaga_resource_unref returned %"P=
RIi32
> > > > +                   " for resource_id =3D %"PRIu32, __func__, resul=
t,
> > > > +                   res->resource_id);
> > > > +        strerror =3D strerrorname_np((int)result);
> > > > +        if (strerror !=3D NULL) {
> > > > +            error_append_hint(errp, "%s: %s\n",
> > > > +                              strerror, strerrordesc_np((int)resul=
t) ? : "");
> > > > +        }
> > > > +    }
> > >
> > > There is error_setg_errno()
> >
> > I did not use it on purpose because I was not certain if rutabaga_gfx
> > starts using other error numbers in the future. I don't like my
> > approach but I don't like assuming it's an errno either to be
> > honest... Which one seems better to you?
> >
>
> In that case, don't use strerrordesc_np() either :)

strerrordesc_np will be valid if strerrorname_np() does not return NULL.

> I think we can assume they will keep using errno though, unless they
> clearly communicate this and break API, which seems unlikely to me.

I will use error_setg_errno then, thanks!

Manos

> > Thanks,
> > Manos
> >
> > > > +
> > > > +    if (res->image) {
> > > > +        pixman_image_unref(res->image);
> > > > +    }
> > > > +
> > > > +    QTAILQ_REMOVE(&g->reslist, res, next);
> > > > +    g_free(res);
> > > > +}
> > > > +
> > > > +static void
> > > >  rutabaga_cmd_resource_unref(VirtIOGPU *g,
> > > >                              struct virtio_gpu_ctrl_command *cmd)
> > > >  {
> > > > -    int32_t result;
> > > > +    int32_t result =3D 0;
> > > >      struct virtio_gpu_simple_resource *res;
> > > >      struct virtio_gpu_resource_unref unref;
> > > > -
> > > > -    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> > > > +    Error *local_err =3D NULL;
> > > >
> > > >      VIRTIO_GPU_FILL_CMD(unref);
> > > >
> > > > @@ -164,15 +192,14 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,
> > > >      res =3D virtio_gpu_find_resource(g, unref.resource_id);
> > > >      CHECK(res, cmd);
> > > >
> > > > -    result =3D rutabaga_resource_unref(vr->rutabaga, unref.resourc=
e_id);
> > > > -    CHECK(!result, cmd);
> > > > -
> > > > -    if (res->image) {
> > > > -        pixman_image_unref(res->image);
> > > > +    virtio_gpu_rutabaga_resource_unref(g, res, &local_err);
> > > > +    if (local_err) {
> > > > +        error_report_err(local_err);
> > > > +        /* local_err was freed, do not reuse it. */
> > > > +        local_err =3D NULL;
> > > > +        result =3D 1;
> > > >      }
> > > > -
> > > > -    QTAILQ_REMOVE(&g->reslist, res, next);
> > > > -    g_free(res);
> > > > +    CHECK(!result, cmd);
> > > >  }
> > > >
> > > >  static void
> > > > @@ -1099,7 +1126,7 @@ static void virtio_gpu_rutabaga_class_init(Ob=
jectClass *klass, void *data)
> > > >      vgc->handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl;
> > > >      vgc->process_cmd =3D virtio_gpu_rutabaga_process_cmd;
> > > >      vgc->update_cursor_data =3D virtio_gpu_rutabaga_update_cursor;
> > > > -
> > > > +    vgc->resource_destroy =3D virtio_gpu_rutabaga_resource_unref;
> > > >      vdc->realize =3D virtio_gpu_rutabaga_realize;
> > > >      device_class_set_props(dc, virtio_gpu_rutabaga_properties);
> > > >  }
> > > > --
> > > > =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=
=CF=87=CE=B8=CE=AE=CF=84=CF=89
> > > >
> > >
> > >
> > > --
> > > Marc-Andr=C3=A9 Lureau
>
>
>
> --
> Marc-Andr=C3=A9 Lureau

