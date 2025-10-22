Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64C3CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 16:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBc0P-0001bW-07; Wed, 22 Oct 2025 12:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1vBc0M-0001bM-IN
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1vBc0J-0004rK-Al
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761151679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7OUFSXJwkJr2K8oBNvUxHdRvD04+dj3m4Hr2sR/vNhE=;
 b=Z30PWUNjv07P06BsC1wEoqiphtJanwg9xaUdJ+INqbno7PqylyPLzSrnZJlKIVZcHTiiEG
 UvJgSosYwbQ5rCK4lmqUJHGbDKka32jzE7npYP0sLN+Eti0uLNl/Qyrn82Djc7bjffgSwD
 rPb2OGeEvAEkEowbngw/CqGxVXRQDI8=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-OT2FYVo5PIODeVfQpl0PFw-1; Wed, 22 Oct 2025 12:47:58 -0400
X-MC-Unique: OT2FYVo5PIODeVfQpl0PFw-1
X-Mimecast-MFC-AGG-ID: OT2FYVo5PIODeVfQpl0PFw_1761151678
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-63e37c94219so2239024d50.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 09:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761151678; x=1761756478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OUFSXJwkJr2K8oBNvUxHdRvD04+dj3m4Hr2sR/vNhE=;
 b=W3LiUdRIrwcFeEaIQkaE27t+qxhi1d3zTfKLmhHdOIMCErr5oO6IIVoa6trn/VFgsV
 +ZlXtEWoyy/THCzpPMsXrIOd07upXHmXvP94H+/TRgpJXqkHzBC9WKZTDlBHHWNRLb6A
 7+IawZyXSsmIYoKr7Rm8FsKcGafz3CLUyKBKw4jk5IMQBmvZRN4sOjZH0PpjXspmWz23
 wUt3RbQ04TgLR/S9mEOBpgRXqe7F1hvHna5xSobouAcIeMOE1jgG+6LjAxIRt0l0ppcB
 S/U9FMP7Pcv6Ereu8X55dSeXt7euM04VujN4iRIN++aF5lkelKrK6npVPNheaNwfXC7W
 Ynnw==
X-Gm-Message-State: AOJu0YwNufWf/wyLDy8PGYcPgZazBZiHBoeYcyR6gLoywtxH9/tCyNFI
 MPNo+zJNJFBOy/1bJtT3vtKv3de07LZ3fkeiefl1YxXl+voxMIr9h++giiTUhWMTzR/cltrT6sr
 5H5OACp7YP0POmAoDlHdXEHWH95WjV1eN5IBnlBkqJ97I6Il0CAfMbkre1isZyrtd90jJZc31CR
 K4qdeX9Xig0EkS46P/5u9BGNTzEc313uu2TxKNoVmsLA==
X-Gm-Gg: ASbGncsTaUhnxkiMVChERtLkoIbbCmZ0yaIRjRP4APlqh5HTNps/QqHQ0S6rnX1iznV
 YSLW/3gvCamIxZPXJCuJ2hkUtc7iWFbPRZ4tYLTDTIR8fHtPPDcldCDqzz2X5dgpmGinq6/bBjL
 pHlAq4jV4VvoyRivGV1Wy2eSlKKx/A5Q1ReEdgXIYJ0dXJgagQ8PvVoSU=
X-Received: by 2002:a05:690e:1587:10b0:636:2079:1879 with SMTP id
 956f58d0204a3-63f2f5a6647mr1489274d50.10.1761151677833; 
 Wed, 22 Oct 2025 09:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC0xTVd1hfQyMCf2qmd8fQw7BZTbBSXJ2IAlmus/9L6is5XijXk4xxoaRq2WsWhS/GA/pfIPN/3WuALiFZIN8=
X-Received: by 2002:a05:690e:1587:10b0:636:2079:1879 with SMTP id
 956f58d0204a3-63f2f5a6647mr1489242d50.10.1761151677334; Wed, 22 Oct 2025
 09:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251022133228.301365-1-gmaglione@redhat.com>
 <CAJaqyWccaCUfQLzQXdX+3+sQNz+-AjSvqmCignXR+URfz7FHww@mail.gmail.com>
In-Reply-To: <CAJaqyWccaCUfQLzQXdX+3+sQNz+-AjSvqmCignXR+URfz7FHww@mail.gmail.com>
From: German Maglione <gmaglione@redhat.com>
Date: Wed, 22 Oct 2025 18:47:20 +0200
X-Gm-Features: AS18NWDSPVR6S1AKa6vZBGKExllKxImK67IeAOaIu7kkedzkCA2H-BwfyYAITFc
Message-ID: <CAJh=p+4RMbPXMuB=_Fh+LSNjuu_=99Q33WRU1uT6FLO7AbQ4Fg@mail.gmail.com>
Subject: Re: [PATCH] Make vhost_set_vring_file() synchronous
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gmaglion@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 22, 2025 at 3:50=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Oct 22, 2025 at 3:32=E2=80=AFPM <gmaglione@redhat.com> wrote:
> >
> > From: German Maglione <gmaglione@redhat.com>
> >
> > QEMU sends all of VHOST_USER_SET_VRING_KICK, _CALL, and _ERR without
> > setting the NEED_REPLY flag, i.e. by the time the respective
> > vhost_user_set_vring_*() function returns, it is completely up to chanc=
e
> > whether whether the back-end has already processed the request and
> > switched over to the new FD for interrupts.
> >
> > At least for vhost_user_set_vring_call(), that is a problem: It is
> > called through vhost_virtqueue_mask(), which is generally used in the
> > VirtioDeviceClass.guest_notifier_mask() implementation, which is in tur=
n
> > called by virtio_pci_one_vector_unmask().  The fact that we do not wait
> > for the back-end to install the FD leads to a race there:
> >
> > Masking interrupts is implemented by redirecting interrupts to an
> > internal event FD that is not connected to the guest.  Unmasking then
> > re-installs the guest-connected IRQ FD, then checks if there are pendin=
g
> > interrupts left on the masked event FD, and if so, issues an interrupt
> > to the guest.
> >
> > Because guest_notifier_mask() (through vhost_user_set_vring_call())
> > doesn't wait for the back-end to switch over to the actual IRQ FD, it's
> > possible we check for pending interrupts while the back-end is still
> > using the masked event FD, and then we will lose interrupts that occur
> > before the back-end finally does switch over.
> >
> > Fix this by setting NEED_REPLY on those VHOST_USER_SET_VRING_* messages=
,
> > so when we get that reply, we know that the back-end is now using the
> > new FD.
> >
>
> Fixes: 5f6f6664bf24 ("Add vhost-user as a vhost backend.") ?

sorry, I missed this, Michael, should I add this in a new patch version?

>
> > Signed-off-by: German Maglione <gmaglione@redhat.com>
> > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > ---
> >  hw/virtio/vhost-user.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 36c9c2e04d..641960293b 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1327,8 +1327,11 @@ static int vhost_set_vring_file(struct vhost_dev=
 *dev,
> >                                  VhostUserRequest request,
> >                                  struct vhost_vring_file *file)
> >  {
> > +    int ret;
> >      int fds[VHOST_USER_MAX_RAM_SLOTS];
> >      size_t fd_num =3D 0;
> > +    bool reply_supported =3D virtio_has_feature(dev->protocol_features=
,
> > +                                              VHOST_USER_PROTOCOL_F_RE=
PLY_ACK);
>
> Why not use vhost_user_write_sync directly?
>
> >      VhostUserMsg msg =3D {
> >          .hdr.request =3D request,
> >          .hdr.flags =3D VHOST_USER_VERSION,
> > @@ -1336,13 +1339,26 @@ static int vhost_set_vring_file(struct vhost_de=
v *dev,
> >          .hdr.size =3D sizeof(msg.payload.u64),
> >      };
> >
> > +    if (reply_supported) {
> > +        msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > +    }
> > +
> >      if (file->fd > 0) {
> >          fds[fd_num++] =3D file->fd;
> >      } else {
> >          msg.payload.u64 |=3D VHOST_USER_VRING_NOFD_MASK;
> >      }
> >
> > -    return vhost_user_write(dev, &msg, fds, fd_num);
> > +    ret =3D vhost_user_write(dev, &msg, fds, fd_num);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    if (reply_supported) {
> > +        return process_message_reply(dev, &msg);
> > +    }
> > +
> > +    return 0;
> >  }
> >
> >  static int vhost_user_set_vring_kick(struct vhost_dev *dev,
> > --
> > 2.49.0
> >
>


--=20
German


