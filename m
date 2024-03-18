Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA267C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 19:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmINk-0006vE-Om; Mon, 18 Mar 2024 15:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmINi-0006rI-3C
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmINf-0005tT-Qz
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710789043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NuVb/UqkSnTIBEw/mKV9yAZ/bK7f6ovYGaVzMCRSh/w=;
 b=ZbZFiUswFe44fMPYfNI3J6WutTbRGdkPRaRhgUv4kH/06Waj4l4Jmj7IrnweW8O8BsGmN7
 GVjNEbxV8AgWcjXL7swJ9813vaBsj/28YS/VMcelLhU0Zq4Pa7qjfJcljWFQes4zSgOK/r
 XlD33Sx8iih2EiQDsHGwnLC9T1KGRWA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-3Ipz65MRO1enPnedVQCNkA-1; Mon, 18 Mar 2024 15:10:40 -0400
X-MC-Unique: 3Ipz65MRO1enPnedVQCNkA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dced704f17cso7909658276.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 12:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710789040; x=1711393840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NuVb/UqkSnTIBEw/mKV9yAZ/bK7f6ovYGaVzMCRSh/w=;
 b=SVhVyYBeJKbgjlwCZjaDCOHMHTc3Wrt0d7WKNgQnJnOcbIw0XMos7PUIG717E2Tggr
 EsiJToPhZ7SP3VPwoFTRWK+y/rQrId3t9xZM7A4c82J6k4R6fxf9j52+skjAiMIG4kWa
 EpHN7TftCX/BOS6zKFPlx7Ut6gcOJalpSrnS8zfm2dZ0bnu4P9RKU72RE9JV6qNyk7kt
 oiTmGGncAFmjkCzKD4wE0SoQ9HDg9c7EOxDac5ahrHBDpINFuo9W2H12jl0cNzczP/GK
 qh7yDJ2AZE/1jONNIhob1VXFUy+beZOmPGcucgTJBkwLznmNaanGc1OcX1sf+Eztk0iP
 e1zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh/QrJNblHhdP4TYXKZbBfWpjuFCYI42/soRHYiDMJiS5ZOp35u7o1bUF1hX0/XE5wGoCeqQ934RkVl88E8jsLaQFlReI=
X-Gm-Message-State: AOJu0Yy6eBlzY9+RjexotCDMtPEm3m56I+xBaP0G0ltVMDHVdhkILxty
 jRfdwLO5ra4Dwk+i7XTavX+1Zkx8W96kem1grG51B0KRkpHzpuFgh+lLW4DyfAqO5kE+y5+mnpN
 YOGbUrs+NVOT/DiJPzqKqiDOzKnAbSigHfpi0+/b7LyGDL8ICCl4RFg3Bo9vI31VEPA7JfWDqE0
 eMXp8OxNy0p6YzsDmswhj1j8ALZd4=
X-Received: by 2002:a25:1346:0:b0:dbd:120e:f337 with SMTP id
 67-20020a251346000000b00dbd120ef337mr8401784ybt.30.1710789040104; 
 Mon, 18 Mar 2024 12:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2tUIYkgI+9b2fOP/C5l4MG5PiFteiotS1DI65MI71Ph3C+d+UsN/cmCZECJ0/XAS3s8tJmHqZmiEpvO2MgJs=
X-Received: by 2002:a25:1346:0:b0:dbd:120e:f337 with SMTP id
 67-20020a251346000000b00dbd120ef337mr8401767ybt.30.1710789039843; Mon, 18 Mar
 2024 12:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240207092702.25242-1-sgarzare@redhat.com>
 <CACGkMEvRizRGOjOz_AVQw8wsGU3g8+-yHtnKM=yn=3RtY-Hayg@mail.gmail.com>
 <uufps7n6otfwygiszepy76ltohvsqqo45rwyc6axja3isebda2@mn4rjbji66qt>
 <CACGkMEt-z3YCh81M2yxnCa9PjLpR8qQ8rLQ5rRCMP6=m9yKpFw@mail.gmail.com>
In-Reply-To: <CACGkMEt-z3YCh81M2yxnCa9PjLpR8qQ8rLQ5rRCMP6=m9yKpFw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 18 Mar 2024 20:10:03 +0100
Message-ID: <CAJaqyWesHbdj8WbfbEuyhLDfWURW-SMK_+ONOb4=QvcMF6NdDA@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: check vhost_vdpa_set_vring_ready() return
 value
To: Jason Wang <jasowang@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 mst@redhat.com, lulu@redhat.com, kwolf@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Mar 18, 2024 at 5:35=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Mar 15, 2024 at 4:23=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > On Thu, Mar 14, 2024 at 11:17:01AM +0800, Jason Wang wrote:
> > >On Wed, Feb 7, 2024 at 5:27=E2=80=AFPM Stefano Garzarella <sgarzare@re=
dhat.com> wrote:
> > >>
> > >> vhost_vdpa_set_vring_ready() could already fail, but if Linux's
> > >> patch [1] will be merged, it may fail with more chance if
> > >> userspace does not activate virtqueues before DRIVER_OK when
> > >> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.
> > >
> > >I wonder what happens if we just leave it as is.
> >
> > Are you referring to this patch or the kernel patch?
>
> This patch.
>
> >
> > Here I'm just checking the return value of vhost_vdpa_set_vring_ready()=
.
> > It can return an error also without that kernel patch, so IMHO is
> > better to check the return value here in QEMU.
> >
> > What issue do you see with this patch applied?
>
> For the parent which can enable after driver_ok but not advertise it.
>
> (To say the truth, I'm not sure if we need to care about this)
>
> >
> > >
> > >VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We do know enabling could be
> > >done after driver_ok.
> > >Without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We don't know whether
> > >enabling could be done after driver_ok or not.
> >
> > I see your point, indeed I didn't send a v2 of that patch.
> > Maybe we should document that, because it could be interpreted that if
> > VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated the enabling
> > should always be done before driver_ok (which is true for example in
> > VDUSE).
>
> I see, so I think we probably need the fix.
>

A more complete fix is proper checking for
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK. But even with that, checking
for failure in the ioctl is also worth it, isn't it?

The only point I see to not checking is to closely mimic virtio
behavior, but vDPA can already fail here.

> >
> > BTW I think we should discuss it in the kernel patch.
> >
> > Thanks,
> > Stefano
> >
> > >
> > >Thanks
> > >
> > >>
> > >> So better check its return value anyway.
> > >>
> > >> [1] https://lore.kernel.org/virtualization/20240206145154.118044-1-s=
garzare@redhat.com/T/#u
> > >>
> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >> ---
> > >> Note: This patch conflicts with [2], but the resolution is simple,
> > >> so for now I sent a patch for the current master, but I'll rebase
> > >> this patch if we merge the other one first.
>
> Will go through [2].
>
> Thanks
>
>
> > >>
> > >> [2]
> > >> https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redh=
at.com/
> > >> ---
> > >>  hw/virtio/vdpa-dev.c |  8 +++++++-
> > >>  net/vhost-vdpa.c     | 15 ++++++++++++---
> > >>  2 files changed, 19 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> > >> index eb9ecea83b..d57cd76c18 100644
> > >> --- a/hw/virtio/vdpa-dev.c
> > >> +++ b/hw/virtio/vdpa-dev.c
> > >> @@ -259,7 +259,11 @@ static int vhost_vdpa_device_start(VirtIODevice=
 *vdev, Error **errp)
> > >>          goto err_guest_notifiers;
> > >>      }
> > >>      for (i =3D 0; i < s->dev.nvqs; ++i) {
> > >> -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> > >> +        ret =3D vhost_vdpa_set_vring_ready(&s->vdpa, i);
> > >> +        if (ret < 0) {
> > >> +            error_setg_errno(errp, -ret, "Error starting vring %d",=
 i);
> > >> +            goto err_dev_stop;
> > >> +        }
> > >>      }
> > >>      s->started =3D true;
> > >>
> > >> @@ -274,6 +278,8 @@ static int vhost_vdpa_device_start(VirtIODevice =
*vdev, Error **errp)
> > >>
> > >>      return ret;
> > >>
> > >> +err_dev_stop:
> > >> +    vhost_dev_stop(&s->dev, vdev, false);
> > >>  err_guest_notifiers:
> > >>      k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
> > >>  err_host_notifiers:
> > >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > >> index 3726ee5d67..e3d8036479 100644
> > >> --- a/net/vhost-vdpa.c
> > >> +++ b/net/vhost-vdpa.c
> > >> @@ -381,7 +381,10 @@ static int vhost_vdpa_net_data_load(NetClientSt=
ate *nc)
> > >>      }
> > >>
> > >>      for (int i =3D 0; i < v->dev->nvqs; ++i) {
> > >> -        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
> > >> +        int ret =3D vhost_vdpa_set_vring_ready(v, i + v->dev->vq_in=
dex);
> > >> +        if (ret < 0) {
> > >> +            return ret;
> > >> +        }
> > >>      }
> > >>      return 0;
> > >>  }
> > >> @@ -1213,7 +1216,10 @@ static int vhost_vdpa_net_cvq_load(NetClientS=
tate *nc)
> > >>
> > >>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > >>
> > >> -    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
> > >> +    r =3D vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
> > >> +    if (unlikely(r < 0)) {
> > >> +        return r;
> > >> +    }
> > >>
> > >>      if (v->shadow_vqs_enabled) {
> > >>          n =3D VIRTIO_NET(v->dev->vdev);
> > >> @@ -1252,7 +1258,10 @@ static int vhost_vdpa_net_cvq_load(NetClientS=
tate *nc)
> > >>      }
> > >>
> > >>      for (int i =3D 0; i < v->dev->vq_index; ++i) {
> > >> -        vhost_vdpa_set_vring_ready(v, i);
> > >> +        r =3D vhost_vdpa_set_vring_ready(v, i);
> > >> +        if (unlikely(r < 0)) {
> > >> +            return r;
> > >> +        }
> > >>      }
> > >>
> > >>      return 0;
> > >> --
> > >> 2.43.0
> > >>
> > >
> >
>


