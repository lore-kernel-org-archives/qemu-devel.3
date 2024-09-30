Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C04CF6499
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 11:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svEDE-00075M-Mw; Mon, 30 Sep 2024 07:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1svEDD-00071N-04
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1svEDB-0000xZ-1X
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727694304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI6vdAX6P8pCLvnCDCCiW5lJFQZHaZI1UZWj3exIWWk=;
 b=b/97+fP1QWoFGbo/5/ofljFsOCWFPKOQXll3Ygw+Evc0z03kxAyYb8vSN2d+Zh2BdjTnsk
 qkxUZEHB5Ad4ipohV6R9kbnlEI1s7GAwZIUr7PJVK7ey+yaTMXvugDp4yhomoNyylL1cDa
 2egxVCZLwi46aIi111lo6TX3ZK1FNI4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-72UJNtH2Ol6VJT5IgYMaFQ-1; Mon, 30 Sep 2024 07:05:01 -0400
X-MC-Unique: 72UJNtH2Ol6VJT5IgYMaFQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6e23ee3110fso57743347b3.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 04:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727694301; x=1728299101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fI6vdAX6P8pCLvnCDCCiW5lJFQZHaZI1UZWj3exIWWk=;
 b=K6uq5juvuIB07dAANGNPeI4kJd/Zde4nV8m1CspI58jI3vf2IrbJ2nW72k+ei/Mhdv
 zqqmECJqRV4YZE6s42VBgdeDi7bMGDlG7KYbixTTk0oxj5G4vky2aEVaNKkzlhLrwJzx
 DU7qYF5Gr//iVjIiWPNrWcBotFWC68fsOrLbQaXbQn9PUIWaQhmhMWIRO7RsF2kYG5I6
 ECVQI6spOheA2JEyBAFer+t+f/DmVYPY2pbWjJ3K5ETqFosDWgcRBnXFgGs8//lQVKAs
 yhQW08tvq2dnop0epSXHxXvtBfLYTOwWBpHP8Xo5+u2s5/6BfJz8zHL2rqI1EIwyYQ0f
 AgEQ==
X-Gm-Message-State: AOJu0YyI5n17WC8hYendSy/6siFa1qvUyQGl60kDqn8zLTmRWRK1SDgB
 LoXSZuaOLSbD8ml3kjBlrdQQ7hCr89sqY6xMRBhj6bGSbr67cOBY95KKXDAErW2tAiBXVftNvel
 WfM6zvR+PNPsDxmCjgwBN9KwVRjHHx9LvP/E01K5oBg36DcUewrsxfCjKfO68qCIaSqvgDZHCO6
 kXwHVSWJ/ATbN78F6gOcSEMHxqsZ4=
X-Received: by 2002:a05:690c:470b:b0:6e2:7dd:af66 with SMTP id
 00721157ae682-6e247584b10mr67558407b3.19.1727694301235; 
 Mon, 30 Sep 2024 04:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBVDporanaK+EKpeHjD2fgiI4JHBmDXqew8LQG0F351b96Kd+mEG/KsdoPPAVfMY+l+jlLJo6Ng9yEE9bKwv4=
X-Received: by 2002:a05:690c:470b:b0:6e2:7dd:af66 with SMTP id
 00721157ae682-6e247584b10mr67558147b3.19.1727694300922; Mon, 30 Sep 2024
 04:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-20-marcandre.lureau@redhat.com>
 <CAJaqyWf2OAy74jK6yBWiy9fZ-OL=v7V=A-60kViG5K8SM2qJDQ@mail.gmail.com>
In-Reply-To: <CAJaqyWf2OAy74jK6yBWiy9fZ-OL=v7V=A-60kViG5K8SM2qJDQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 30 Sep 2024 13:04:25 +0200
Message-ID: <CAJaqyWc0Fnnb96XUF7ra2MeLTOkWtREcjPch+kWC9p8P4Bh40Q@mail.gmail.com>
Subject: Re: [PATCH v3 19/22] RFC: hw/virtio: a potential leak fix
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 qemu-block@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 30, 2024 at 1:02=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Sep 30, 2024 at 10:17=E2=80=AFAM <marcandre.lureau@redhat.com> wr=
ote:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > vhost_svq_get_buf() may return a VirtQueueElement that should be freed.
> >
> > It's unclear to me if the vhost_svq_get_buf() call should always return=
 NULL.
> >
>
> Continuing conversation of v2,
>
> Yes there are situations where vhost_svq_get_buf can return a valid
> buffer here and we could leak memory, so this fixes a bug.
>
> So,
>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>

(I hit "send" too early)

Wwe could use a better patch subject though. Even "Freeing leaked
memory from vhost_svq_get_buf in vhost_svq_poll" would work better for
me. What do you think?

Thanks!

> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/virtio/vhost-shadow-virtqueue.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shado=
w-virtqueue.c
> > index 3b2beaea24..37aca8b431 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -414,6 +414,7 @@ static uint16_t vhost_svq_last_desc_of_chain(const =
VhostShadowVirtqueue *svq,
> >      return i;
> >  }
> >
> > +G_GNUC_WARN_UNUSED_RESULT
> >  static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
> >                                             uint32_t *len)
> >  {
> > @@ -528,6 +529,7 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, si=
ze_t num)
> >      size_t len =3D 0;
> >
> >      while (num--) {
> > +        g_autofree VirtQueueElement *elem =3D NULL;
> >          int64_t start_us =3D g_get_monotonic_time();
> >          uint32_t r =3D 0;
> >
> > @@ -541,7 +543,7 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, si=
ze_t num)
> >              }
> >          } while (true);
> >
> > -        vhost_svq_get_buf(svq, &r);
> > +        elem =3D vhost_svq_get_buf(svq, &r);
> >          len +=3D r;
> >      }
> >
> > --
> > 2.45.2.827.g557ae147e6
> >


