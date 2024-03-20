Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46505C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 04:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmnPP-0004Ss-4V; Wed, 20 Mar 2024 00:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rmnPN-0004Sj-LA
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 00:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rmnPL-0001WP-HY
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 00:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710908309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e4L7q4YaXguEEQrlgz3WhAf0ySlicWoms1YSyQyLgcU=;
 b=CFj1PnP2GKz3Uaod4ogghItrr7OGgCeyHkhtvTJXRV6WHXFitKuo3e93zLE2vyoRbWmjDl
 ftrldjrkNUYteIMs7iC8M7Z/oi24ejzQjiauzKa9bx70gn8y0qHjjx20PuqRBWWHqIENf1
 e3og1KiWXeVjDArzt/yMbtEOiPV37nM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-5P-pF_iZNZOZhNNP92NHYw-1; Wed, 20 Mar 2024 00:18:27 -0400
X-MC-Unique: 5P-pF_iZNZOZhNNP92NHYw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29de02b98caso5290205a91.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 21:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710908306; x=1711513106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4L7q4YaXguEEQrlgz3WhAf0ySlicWoms1YSyQyLgcU=;
 b=BGMLO3V7z0ZtA5KnvPA6/nxikrDqaN8GcuNnWHU1P5Y2PrxQtIQSi3uxEvZrmAWs/a
 Xa7AoLgQCly/H7AZ8ofbCQRrReXBn8iKrCoATxGohZOC6pJ2oeIscmUyRFucIZkrHDaV
 2kJpbvaGo7cfZr+aqxDysPKwEiMtuS0b8bALdomz+MqoAx75OLfd58D1nnGHKZ9ptJw8
 hB//fzpAkBTZ1kH72CzNaBEMrUF4K5evv5oKrs+/Dtncm45F2kkOGMaSZqM4FVky23Bl
 ijEf1HovKaW3FMZzrhaLPVae8Ggj8/O0+Is6DLnLQuGGZARZs1OSRcmYSlmOXdVx5Ywq
 /Pug==
X-Gm-Message-State: AOJu0YzeLmJPgxcSmNmuYlJo7kaV3l5DP3EyoFYWqSprVS8Egd661rxm
 5Ru5wCw5JFf+QZNbBRTso5IHgcpzSpsVzRB6M9IZCMIDQzv7MUapWbh1xLMW/OH2onlDdH+LTqy
 kqGBM42Wwy60LL35YyZOY9NwvmNIavtVeUB5FLjbOyIQC3fGARMhRDzw3m9jAgswnbMrQpLq+PT
 jDipvQFWyJrWX+FXRa40Fk2z0+Hww=
X-Received: by 2002:a17:90a:6f01:b0:29c:7769:419b with SMTP id
 d1-20020a17090a6f0100b0029c7769419bmr4581628pjk.9.1710908306017; 
 Tue, 19 Mar 2024 21:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENIQUGc/Y7ySSQuQV+W0xEB7Fc6cFOZqFGOpfGepRMLdBiosbrLzVOzv8px71zQ59MpEVXWpUhZbkSdChSRMc=
X-Received: by 2002:a17:90a:6f01:b0:29c:7769:419b with SMTP id
 d1-20020a17090a6f0100b0029c7769419bmr4581617pjk.9.1710908305681; Tue, 19 Mar
 2024 21:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240207092702.25242-1-sgarzare@redhat.com>
 <CACGkMEvRizRGOjOz_AVQw8wsGU3g8+-yHtnKM=yn=3RtY-Hayg@mail.gmail.com>
 <uufps7n6otfwygiszepy76ltohvsqqo45rwyc6axja3isebda2@mn4rjbji66qt>
 <CACGkMEt-z3YCh81M2yxnCa9PjLpR8qQ8rLQ5rRCMP6=m9yKpFw@mail.gmail.com>
 <uofjifqnl57vxigv4ebplfk4menefsgplnvvbprisubkywujbw@273bn7kc5hjg>
In-Reply-To: <uofjifqnl57vxigv4ebplfk4menefsgplnvvbprisubkywujbw@273bn7kc5hjg>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 12:18:14 +0800
Message-ID: <CACGkMEusWU9d3hp7m1hzhH9PayfYcw5DTDYn9SEbCdBT7evvAg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: check vhost_vdpa_set_vring_ready() return
 value
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, lulu@redhat.com, kwolf@redhat.com, 
 eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On Mon, Mar 18, 2024 at 4:27=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Mon, Mar 18, 2024 at 12:31:59PM +0800, Jason Wang wrote:
> >On Fri, Mar 15, 2024 at 4:23=E2=80=AFPM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> >>
> >> On Thu, Mar 14, 2024 at 11:17:01AM +0800, Jason Wang wrote:
> >> >On Wed, Feb 7, 2024 at 5:27=E2=80=AFPM Stefano Garzarella <sgarzare@r=
edhat.com> wrote:
> >> >>
> >> >> vhost_vdpa_set_vring_ready() could already fail, but if Linux's
> >> >> patch [1] will be merged, it may fail with more chance if
> >> >> userspace does not activate virtqueues before DRIVER_OK when
> >> >> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.
> >> >
> >> >I wonder what happens if we just leave it as is.
> >>
> >> Are you referring to this patch or the kernel patch?
> >
> >This patch.
> >
> >>
> >> Here I'm just checking the return value of vhost_vdpa_set_vring_ready(=
).
> >> It can return an error also without that kernel patch, so IMHO is
> >> better to check the return value here in QEMU.
> >>
> >> What issue do you see with this patch applied?
> >
> >For the parent which can enable after driver_ok but not advertise it.
>
> But this patch is not changing anything in that sense, it just controls
> the return value of the VHOST_VDPA_SET_VRING_ENABLE ioctl.
>
> Why would QEMU ignore an error if it can't activate vrings?
> If we really want to ignore it we should document it both in QEMU, but
> also in the kernel, because honestly the way the code is now it
> shouldn't fail from what I understand.
>
> That said, even if we ignore it, IMHO we should at least print a warning
> in QEMU.

Right.

>
> >
> >(To say the truth, I'm not sure if we need to care about this)
>
> I agree on that, but this is related to the patch in the kernel, not
.> this simple patch to fix QEMU error path, right?

Or it's the charge of the Qemu vDPA layer to avoid calling
set_vq_ready() after driver_ok if no
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK. Or it might be too late.

>
> >
> >>
> >> >
> >> >VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We do know enabling could be
> >> >done after driver_ok.
> >> >Without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We don't know whether
> >> >enabling could be done after driver_ok or not.
> >>
> >> I see your point, indeed I didn't send a v2 of that patch.
> >> Maybe we should document that, because it could be interpreted that if
> >> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated the enabling
> >> should always be done before driver_ok (which is true for example in
> >> VDUSE).
> >
> >I see, so I think we probably need the fix.
> >
> >>
> >> BTW I think we should discuss it in the kernel patch.
> >>
> >> Thanks,
> >> Stefano
> >>
> >> >
> >> >Thanks
> >> >
> >> >>
> >> >> So better check its return value anyway.
> >> >>
> >> >> [1] https://lore.kernel.org/virtualization/20240206145154.118044-1-=
sgarzare@redhat.com/T/#u
> >> >>
> >> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> >> ---
> >> >> Note: This patch conflicts with [2], but the resolution is simple,
> >> >> so for now I sent a patch for the current master, but I'll rebase
> >> >> this patch if we merge the other one first.
> >
> >Will go through [2].
>
> Here I meant that the conflict is only in the code touched, because
> Kevin's patch remove/move some of the code touched by this patch.
> And rightly he checked the return value of the ioctl as I would like to
> do in the other places where we call the same ioctl.
>
> So honestly I still don't understand what's wrong with this patch...

Nothing wrong now.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Thanks,
> Stefano
>
> >
> >Thanks
> >
> >
> >> >>
> >> >> [2]
> >> >> https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@red=
hat.com/
> >> >> ---
> >> >>  hw/virtio/vdpa-dev.c |  8 +++++++-
> >> >>  net/vhost-vdpa.c     | 15 ++++++++++++---
> >> >>  2 files changed, 19 insertions(+), 4 deletions(-)
> >> >>
> >> >> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> >> >> index eb9ecea83b..d57cd76c18 100644
> >> >> --- a/hw/virtio/vdpa-dev.c
> >> >> +++ b/hw/virtio/vdpa-dev.c
> >> >> @@ -259,7 +259,11 @@ static int vhost_vdpa_device_start(VirtIODevic=
e *vdev, Error **errp)
> >> >>          goto err_guest_notifiers;
> >> >>      }
> >> >>      for (i =3D 0; i < s->dev.nvqs; ++i) {
> >> >> -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> >> >> +        ret =3D vhost_vdpa_set_vring_ready(&s->vdpa, i);
> >> >> +        if (ret < 0) {
> >> >> +            error_setg_errno(errp, -ret, "Error starting vring %d"=
, i);
> >> >> +            goto err_dev_stop;
> >> >> +        }
> >> >>      }
> >> >>      s->started =3D true;
> >> >>
> >> >> @@ -274,6 +278,8 @@ static int vhost_vdpa_device_start(VirtIODevice=
 *vdev, Error **errp)
> >> >>
> >> >>      return ret;
> >> >>
> >> >> +err_dev_stop:
> >> >> +    vhost_dev_stop(&s->dev, vdev, false);
> >> >>  err_guest_notifiers:
> >> >>      k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
> >> >>  err_host_notifiers:
> >> >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >> >> index 3726ee5d67..e3d8036479 100644
> >> >> --- a/net/vhost-vdpa.c
> >> >> +++ b/net/vhost-vdpa.c
> >> >> @@ -381,7 +381,10 @@ static int vhost_vdpa_net_data_load(NetClientS=
tate *nc)
> >> >>      }
> >> >>
> >> >>      for (int i =3D 0; i < v->dev->nvqs; ++i) {
> >> >> -        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
> >> >> +        int ret =3D vhost_vdpa_set_vring_ready(v, i + v->dev->vq_i=
ndex);
> >> >> +        if (ret < 0) {
> >> >> +            return ret;
> >> >> +        }
> >> >>      }
> >> >>      return 0;
> >> >>  }
> >> >> @@ -1213,7 +1216,10 @@ static int vhost_vdpa_net_cvq_load(NetClient=
State *nc)
> >> >>
> >> >>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> >> >>
> >> >> -    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
> >> >> +    r =3D vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
> >> >> +    if (unlikely(r < 0)) {
> >> >> +        return r;
> >> >> +    }
> >> >>
> >> >>      if (v->shadow_vqs_enabled) {
> >> >>          n =3D VIRTIO_NET(v->dev->vdev);
> >> >> @@ -1252,7 +1258,10 @@ static int vhost_vdpa_net_cvq_load(NetClient=
State *nc)
> >> >>      }
> >> >>
> >> >>      for (int i =3D 0; i < v->dev->vq_index; ++i) {
> >> >> -        vhost_vdpa_set_vring_ready(v, i);
> >> >> +        r =3D vhost_vdpa_set_vring_ready(v, i);
> >> >> +        if (unlikely(r < 0)) {
> >> >> +            return r;
> >> >> +        }
> >> >>      }
> >> >>
> >> >>      return 0;
> >> >> --
> >> >> 2.43.0
> >> >>
> >> >
> >>
> >
>


