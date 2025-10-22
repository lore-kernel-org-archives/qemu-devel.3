Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25C0CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 16:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBbeC-0001h6-7p; Wed, 22 Oct 2025 12:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1vBbe9-0001gC-Kp
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1vBbe6-00022G-FL
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761150304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLO9g/ipyGwLQjWP0yGHHBAhD+v32y6fnC0KHi2sJcQ=;
 b=UpWtwoh/pE9zIV/wYLCoUEdqunyr1LH9652Bc5hxx6WfC7/AmxRIm8YLHewJwscZ2tZGgM
 L+zpjLKEcdVGwQjp5nPwM96uY1HwoL58P6Ln7EcYM+U0o8YcBkLF70FjSvUkHhJfChV0pE
 jnW8zL8v4gL9IrElTMrnCfOYCacAXe0=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-B-PvnXvIM-C-K0EWACkHMA-1; Wed, 22 Oct 2025 12:23:56 -0400
X-MC-Unique: B-PvnXvIM-C-K0EWACkHMA-1
X-Mimecast-MFC-AGG-ID: B-PvnXvIM-C-K0EWACkHMA_1761150236
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-63e1e217b46so6561570d50.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 09:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761150236; x=1761755036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLO9g/ipyGwLQjWP0yGHHBAhD+v32y6fnC0KHi2sJcQ=;
 b=oOR5kLc3+iX5tKfk5YP6E6VIhQKHX6a/vT2UqMPiPXSKMpCoCpnRWv9VWZR/FFTxhJ
 ic0LcUZ5SxRjDxNmUadQWjwMwkJ2CmeBrqZv6xMtBZaJ2iz9lxx4OKANAZhQpVdHtZhv
 6BxJzavPI1193G/b+lmr9GStxAKTdJkqXbDAFhrOZgvt7YbLNLBNCZ2QOGu3xjYWHEA8
 kYjEAtjPGmAhr6h/xcDeBGgfitxiR7MoPZm/omKXzrK4XpZkZurBEJ6PnFrpCS6huitj
 SprtsIjuiLDudI/LBukJdOfakL84skMyAEdRITMsj3praMc9jcErnqYSCnOKB2bkKT43
 ivTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt4OYkLgFeTS/jX35iOa6ZMlDxinlwFXXGsc8IBqZ7vRNza/hKvgy1WJpesbAUpk3bgcSOhaseeCOt@nongnu.org
X-Gm-Message-State: AOJu0YxdrAfipmRARo5SwlScMYsc26rLZUt1Z+44DLe8pXZJ+hroBNy1
 iJ6ewcyoHJpmTBGhLIriF0PewZ6q7a/7Yf+CU9zjjCkcCe4so1ERf5TGGddEb4qYz/MkY0XV5cI
 NRWoe9T4FpG9zrFHHmejWmN+97DygpFBV3SqBQoaiCkLJ71v+IKil79LxRZwqrBq/7N55G4wqj0
 LRE9F3RURt0MpSA4daviQh4oNSDVGOs3I=
X-Gm-Gg: ASbGncvrvagDeXF2fPd/vFSRt2yO+H7Ydaual1y3GIPjAupLt/vct/6CihfVepZ2lg/
 F0vRClzLKd10N+nsL4C3BojJ1U8H07+tNkRRp2s4jHMGrZuQFSjwCMLg9Zis4FJbhRdw1jK0fcq
 ud1FZCPZSgBmry500RYBwPkIoQX1SGqFA4iSdMD0hOSREnMa3pJ7umd98=
X-Received: by 2002:a53:8383:0:b0:63e:8e4:4771 with SMTP id
 956f58d0204a3-63e1618db2dmr11975067d50.33.1761150235933; 
 Wed, 22 Oct 2025 09:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE357Pl0upESi+llwp445VN376keHKSM8iqcghYewu4fgSD/UXE2pOpaeKnup7cAJp8/Gzs6+N4KIiF3OB+gDY=
X-Received: by 2002:a53:8383:0:b0:63e:8e4:4771 with SMTP id
 956f58d0204a3-63e1618db2dmr11975061d50.33.1761150235634; Wed, 22 Oct 2025
 09:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251022133228.301365-1-gmaglione@redhat.com>
 <CAJaqyWccaCUfQLzQXdX+3+sQNz+-AjSvqmCignXR+URfz7FHww@mail.gmail.com>
 <den4gz23dnkg6eyjmfoflujd2oimw7ktxoz6ha727ei576w2iw@ei6aogzv6bt6>
In-Reply-To: <den4gz23dnkg6eyjmfoflujd2oimw7ktxoz6ha727ei576w2iw@ei6aogzv6bt6>
From: German Maglione <gmaglione@redhat.com>
Date: Wed, 22 Oct 2025 18:23:16 +0200
X-Gm-Features: AS18NWC3w5yA4u8C534Q_H72kLkZW5W0BfRzOHXG-EWyBFxS43Jnqa0e8FOfxtI
Message-ID: <CAJh=p+7m-_rOh_y8GCnK5ogS0fWjn+DrOrsPngeJr=+xsiFmbQ@mail.gmail.com>
Subject: Re: [PATCH] Make vhost_set_vring_file() synchronous
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, qemu-devel@nongnu.org, 
 Hanna Czenczek <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gmaglion@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 22, 2025 at 4:04=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Oct 22, 2025 at 03:49:25PM +0200, Eugenio Perez Martin wrote:
> >On Wed, Oct 22, 2025 at 3:32=E2=80=AFPM <gmaglione@redhat.com> wrote:
> >>
> >> From: German Maglione <gmaglione@redhat.com>
> >>
> >> QEMU sends all of VHOST_USER_SET_VRING_KICK, _CALL, and _ERR without
> >> setting the NEED_REPLY flag, i.e. by the time the respective
> >> vhost_user_set_vring_*() function returns, it is completely up to chan=
ce
> >> whether whether the back-end has already processed the request and
> >> switched over to the new FD for interrupts.
> >>
> >> At least for vhost_user_set_vring_call(), that is a problem: It is
> >> called through vhost_virtqueue_mask(), which is generally used in the
> >> VirtioDeviceClass.guest_notifier_mask() implementation, which is in tu=
rn
> >> called by virtio_pci_one_vector_unmask().  The fact that we do not wai=
t
> >> for the back-end to install the FD leads to a race there:
> >>
> >> Masking interrupts is implemented by redirecting interrupts to an
> >> internal event FD that is not connected to the guest.  Unmasking then
> >> re-installs the guest-connected IRQ FD, then checks if there are pendi=
ng
> >> interrupts left on the masked event FD, and if so, issues an interrupt
> >> to the guest.
> >>
> >> Because guest_notifier_mask() (through vhost_user_set_vring_call())
> >> doesn't wait for the back-end to switch over to the actual IRQ FD, it'=
s
> >> possible we check for pending interrupts while the back-end is still
> >> using the masked event FD, and then we will lose interrupts that occur
> >> before the back-end finally does switch over.
> >>
> >> Fix this by setting NEED_REPLY on those VHOST_USER_SET_VRING_* message=
s,
> >> so when we get that reply, we know that the back-end is now using the
> >> new FD.
> >>
> >
> >Fixes: 5f6f6664bf24 ("Add vhost-user as a vhost backend.") ?
> >
> >> Signed-off-by: German Maglione <gmaglione@redhat.com>
> >> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >> ---
> >>  hw/virtio/vhost-user.c | 18 +++++++++++++++++-
> >>  1 file changed, 17 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >> index 36c9c2e04d..641960293b 100644
> >> --- a/hw/virtio/vhost-user.c
> >> +++ b/hw/virtio/vhost-user.c
> >> @@ -1327,8 +1327,11 @@ static int vhost_set_vring_file(struct vhost_de=
v *dev,
> >>                                  VhostUserRequest request,
> >>                                  struct vhost_vring_file *file)
> >>  {
> >> +    int ret;
> >>      int fds[VHOST_USER_MAX_RAM_SLOTS];
> >>      size_t fd_num =3D 0;
> >> +    bool reply_supported =3D virtio_has_feature(dev->protocol_feature=
s,
> >> +                                              VHOST_USER_PROTOCOL_F_R=
EPLY_ACK);
> >
> >Why not use  directly?
>
> I was about to suggest the same thing, but IIUC does not support passing
> fds.
>
> However, yes, I agree that we should extend vhost_user_write_sync() in
> another patch and then use it either here and in other places (e.g.
> vhost_user_set_mem_table(), vhost_setup_backend_channel()).
>
> But maybe that could be a follow-up later, since this is a fix to
> backport without touching too much code around. Up to German and you,
> I'm fine with both.


If you don't mind, I prefer to keep this as small as possible, and extend
vhost_user_write_sync() in a follow-up

>
> Thanks,
> Stefano
>


--=20
German


