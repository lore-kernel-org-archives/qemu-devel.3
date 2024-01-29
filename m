Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB7CC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUMx1-0002y3-BI; Mon, 29 Jan 2024 03:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rUMww-0002xb-T2
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:25:04 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rUMwv-0001XX-3P
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:25:02 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-42a4516ec5dso26475191cf.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 00:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706516700; x=1707121500; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSU0Qw+M3empOIcP0mYJgmZI899Wpllvyj93AOcD71I=;
 b=I9HQmdEF3DkKFiu9Jgno9uyn7uZDPjn5GpMWgYyHcf6InY79Afoqwf/3+6kU10sZDx
 /lwyi35kjoGqKSOcQVaTjTbjqhMU6Y+CD4IarWemCBuCsSuvCGlL1DKsnYoy607W0GoV
 I9Vx5dYE/QwZCD4Q3g27FcOv7/KAxmG07/1SPvbBcTBnrvSEHSLjem1c/cGAgqei+PVz
 rKyJoJqN2AX+xGBV02cs4GbZceYeqTlq4R3lEi1e4e1BLwl+2y4+F0o9PMnbzrN1Rgxf
 iQq8PixcqfIkDmPevm+/wzebTeFD5CGIFNLGDyfJIQxFiVB31rNJtYACDIZFSAWKVecy
 mP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706516700; x=1707121500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSU0Qw+M3empOIcP0mYJgmZI899Wpllvyj93AOcD71I=;
 b=bTRlZtrfXIqQxKM7AlcJPAqjQD9XE/nxeAna9OmiR9nY517FZ9RWljcx4UXEJRgcC8
 nF+CrFE8g0VxDolGQZiBC8n2JY7NA2Z2FQdHCV4lyi8EmkyfQiqb8TgQmyPhg6xgnVES
 JwpoVbPojRCl4bnLbg10kK0zKPRn52KFVsv38lLkWpa4GoBgQba1M/EA1FCbOdDQg0Dx
 DOHSfzB5dO903L+bC6hENJ1vCfHLELWGjZ62xdK0KMgedRQlSfgUBTxO/Avt6i3A8Vql
 bij2JMEifFHQhns44ORh8LxorYpLzWdyes2mru+7yNWf4Iez7TOrFNONWmvCVlW+h4Hy
 pwTQ==
X-Gm-Message-State: AOJu0Yx4pomvwqE0dnIR7t1XGAJLAZFEPz64GKhxvkK9lajdtXlS0mgW
 uobYpuVyRlcZj85XTy3GIWhNDer6T+BBxlUoVxSnu8hUjYI5cHcTc18daljMIlzlNQshiwGCs/C
 NnN7b9SqzOUGbb2AdMPiAjpgzuqk=
X-Google-Smtp-Source: AGHT+IE1jqwylsTAeeneiLsqbjzQBD0TmCOTrPJlUoeioAsavcXZo80xtPsIhsklY9zuls4yt3DyjcyM1R1eTA1LJeg=
X-Received: by 2002:ac8:5805:0:b0:42a:751e:c2c2 with SMTP id
 g5-20020ac85805000000b0042a751ec2c2mr5851948qtg.40.1706516699964; Mon, 29 Jan
 2024 00:24:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
 <c123808b760f4d8d743c4fd4a04e730005ff673e.1706279540.git.manos.pitsidianakis@linaro.org>
 <b99352e9-efd2-42a3-b6de-a87832bb007c@linaro.org>
 <CAAjaMXaZco6AappQdC+8H9bnipD6A1VCd7b3rrk5h9VHO3qt_g@mail.gmail.com>
In-Reply-To: <CAAjaMXaZco6AappQdC+8H9bnipD6A1VCd7b3rrk5h9VHO3qt_g@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Jan 2024 12:24:48 +0400
Message-ID: <CAJ+F1CJQz1-ovEmR-=LV2Y2Zu0mUbLW_gw4n9nq_XO953bhDTw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] virtio-gpu.c: add resource_destroy class method
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
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

On Fri, Jan 26, 2024 at 10:20=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Fri, 26 Jan 2024 at 17:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > Hi Manos,
> >
> > On 26/1/24 15:41, Manos Pitsidianakis wrote:
> > > When destroying/unrefing resources, devices such as virtio-gpu-rutaba=
ga
> > > need to do their own bookkeeping (free rutabaga resources that are
> > > associated with the virtio_gpu_simple_resource).
> > >
> > > This commit adds a class method so that virtio-gpu-rutabaga can overr=
ide
> > > it in the next commit.
> > >
> > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > ---
> > >   hw/display/virtio-gpu.c        | 19 ++++++++++++++++---
> > >   include/hw/virtio/virtio-gpu.h |  2 ++
> > >   2 files changed, 18 insertions(+), 3 deletions(-)
> >
> >
> > >   static void virtio_gpu_resource_unref(VirtIOGPU *g,
> > > @@ -1488,11 +1491,20 @@ static void virtio_gpu_device_unrealize(Devic=
eState *qdev)
> > >   static void virtio_gpu_reset_bh(void *opaque)
> > >   {
> > >       VirtIOGPU *g =3D VIRTIO_GPU(opaque);
> > > +    VirtIOGPUClass *vgc =3D VIRTIO_GPU_GET_CLASS(g);
> > >       struct virtio_gpu_simple_resource *res, *tmp;
> > > +    int32_t result, resource_id;
> > >       int i =3D 0;
> > >
> > >       QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> > > -        virtio_gpu_resource_destroy(g, res);
> > > +        resource_id =3D res->resource_id;
> > > +        result =3D vgc->resource_destroy(g, res);
> > > +        if (result) {
> > > +            error_report("%s: %s resource_destroy"
> > > +                         "for resource_id =3D %d failed with return =
value =3D %d;",
> >
> > '%d' is for 'int', for 'int32_t' you need 'PRId32'.
>
> Thanks,
>
> > But why return that type instead of 'int'?
>
> Because devices might use FFI, and other languages use fixed size
> integers. Since rutabaga is the only one doing this right now, I used
> their integer width.
>

Imo introducing an API in QEMU, you should follow the conventions and
use bool/Error. Implementation should adapt with the rutabaga API.

> > > +                         __func__, object_get_typename(OBJECT(g)), r=
esource_id,
> > > +                         result);
> > > +        }
> > >       }
> >
> >
> > > diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virti=
o-gpu.h
> > > index 584ba2ed73..5683354236 100644
> > > --- a/include/hw/virtio/virtio-gpu.h
> > > +++ b/include/hw/virtio/virtio-gpu.h
> > > @@ -219,6 +219,8 @@ struct VirtIOGPUClass {
> > >       void (*update_cursor_data)(VirtIOGPU *g,
> > >                                  struct virtio_gpu_scanout *s,
> > >                                  uint32_t resource_id);
> > > +    int32_t (*resource_destroy)(VirtIOGPU *g,
> > > +                                struct virtio_gpu_simple_resource *r=
es);
> > >   };
> > >
> > >   struct VirtIOGPUGL {
> >
>

thanks

--=20
Marc-Andr=C3=A9 Lureau

