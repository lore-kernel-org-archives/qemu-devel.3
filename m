Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC1DC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXMrK-0006CF-9b; Tue, 06 Feb 2024 09:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXMrH-00068c-2r
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:55:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXMrC-0001JK-Rd
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707231329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5ZqsCYS6nHz02xpx3RFUD7ZvLNXCC4bZZgpjAt8wyY=;
 b=MFL7cAyKctHq/PsV322Xv82PCQ3OX0eebgws8ufJE0C31Eni8qQWCmDTCmXMUk3gsHHe4y
 rayQvqsekJi2rmArU/63hEerjvimHDFjIAkcO7wBtRo6+BZBvo1jBqQi7whJvVXSuV3pRY
 yQRkt+T+uUDGcDFk84JDOWAvcHG/xV0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-eSUvWHiPOo6WQX9OpeNmCQ-1; Tue, 06 Feb 2024 09:55:28 -0500
X-MC-Unique: eSUvWHiPOo6WQX9OpeNmCQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dc647f65573so9470120276.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 06:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707231327; x=1707836127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5ZqsCYS6nHz02xpx3RFUD7ZvLNXCC4bZZgpjAt8wyY=;
 b=X2bUPFCEqbun9VzhR8O4e93PQUBI/vK5hGM6U+j5yYgTYAI7eziqKlotbIEzbn7PcS
 mXOm8harTMic1gOG65z9ghIV9/KG/Ic0OWmmp9d7EhG54ApGgLNzE03PrzkfwHYcJquo
 YcxsBD6zOzS78smzzkdaNu69z33vzCT538ZuWWqWTZdV5WIEdmG5ByyCUf4MAOq1KdiG
 9cn4DVJVH36uAesINvHNUopr+K8X9U1iWs8n5Oo62lwvZyabqqtMbuO345yFzMwtKVrh
 r/bIJxmkg3rlJJEkzFxkyoDEsvuMz/azrWiS2tMuCsEGsdKD0Ou1KsZEo3f6x5GNL8Tv
 NocQ==
X-Gm-Message-State: AOJu0YzdTIuubRY7R57Uhtk4Hk6VoL3c8Z22jYH0FFyUS5AITWfU2W/r
 yboNfalbPk75psaMGDQKmVZz9fnhto52KIJjdqgYAt/1DQ6NzKUGUjJe1LOZ10ifCz04OGLgTFR
 2/OjLpskwO1t7fLkPvBgr58F6qi0OxE/7LKGGEaFZze6cEdf29Ba2H9Md0O2KWs9+IddBt3qfBI
 A3lPnIoqyReNcaKirpLKHGMgIo91U=
X-Received: by 2002:a25:df41:0:b0:dc6:da83:88e6 with SMTP id
 w62-20020a25df41000000b00dc6da8388e6mr1710232ybg.32.1707231327363; 
 Tue, 06 Feb 2024 06:55:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPyyStxn/XetbR4vRRLgy0wJQgAF7U/pPsOiac5EnpQSqzVQ16ewuBc3AJeJ9KroJ+MW/5KH/xQhmYCA33E1M=
X-Received: by 2002:a25:df41:0:b0:dc6:da83:88e6 with SMTP id
 w62-20020a25df41000000b00dc6da8388e6mr1710209ybg.32.1707231327037; Tue, 06
 Feb 2024 06:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20240202132521.32714-1-kwolf@redhat.com>
 <zmopxf5zt6m36nfujntn72idlinm7qmx23wjvwiazmq4b75lsa@a2omit34pjif>
 <CACGkMEvLpg+nPgHsE_6stFM1OGXbHpuE=j7XLwt_YxpxhWJgZw@mail.gmail.com>
 <nvk6n7ln3ryga2ww4a6evbprauptzcn7uz34ar3uecbxjfre2z@msikqqpuk2vh>
In-Reply-To: <nvk6n7ln3ryga2ww4a6evbprauptzcn7uz34ar3uecbxjfre2z@msikqqpuk2vh>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 6 Feb 2024 15:55:14 +0100
Message-ID: <CAGxU2F4VHfNPN=FCDAJnFCkV0DMqbXi=TMzgU6WHofBJ07DuFw@mail.gmail.com>
Subject: Re: Re: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
To: Jason Wang <jasowang@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 6, 2024 at 9:31=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Tue, Feb 06, 2024 at 10:47:40AM +0800, Jason Wang wrote:
> >On Mon, Feb 5, 2024 at 6:51=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >>
> >> On Fri, Feb 02, 2024 at 02:25:21PM +0100, Kevin Wolf wrote:
> >> >VDUSE requires that virtqueues are first enabled before the DRIVER_OK
> >> >status flag is set; with the current API of the kernel module, it is
> >> >impossible to enable the opposite order in our block export code beca=
use
> >> >userspace is not notified when a virtqueue is enabled.
> >
> >Did this mean virtio-blk will enable a virtqueue after DRIVER_OK?
>
> It's not specific to virtio-blk, but to the generic vdpa device we have
> in QEMU (i.e. vhost-vdpa-device). Yep, after commit
> 6c4825476a4351530bcac17abab72295b75ffe98, virtqueues are enabled after
> DRIVER_OK.
>
> >Sepc is not clear about this and that's why we introduce
> >VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK.
>
> Ah, I didn't know about this new feature. So after commit
> 6c4825476a4351530bcac17abab72295b75ffe98 the vhost-vdpa-device is not
> complying with the specification, right?
>
> >
> >>
> >> Yeah, IMHO the VDUSE protocol is missing a VDUSE_SET_VQ_READY message,
> >
> >I think you meant when VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is
> >negotiated.
>
> At this point yes. But if VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not
> negotiated, should we return an error in vhost-vdpa kernel module if
> VHOST_VDPA_SET_VRING_ENABLE is called when DRIVER_OK is already set?

I just sent a patch:
https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarzare@red=
hat.com/T/#u

Then I discovered that we never check the return value of
vhost_vdpa_set_vring_ready() in QEMU.
I'll send a patch for that!

Stefano

>
> >If this is truth, it seems a little more complicated, for
> >example the get_backend_features needs to be forward to the userspace?
>
> I'm not understanding, don't we already have VHOST_GET_BACKEND_FEATURES
> for this? Or do you mean userspace on the VDUSE side?
>
> >This seems suboptimal to implement this in the spec first and then we
> >can leverage the features. Or we can have another parameter for the
> >ioctl that creates the vduse device.
>
> I got a little lost, though in vhost-user, the device can always expect
> a vring_enable/disable, so I thought it was not complicated in VDUSE.
>
> >
> >> I'll start another thread about that, but in the meantime I agree that
> >> we should fix QEMU since we need to work properly with old kernels as
> >> well.
> >>
> >> >
> >> >This requirement also mathces the normal initialisation order as done=
 by
> >> >the generic vhost code in QEMU. However, commit 6c482547 accidentally
> >> >changed the order for vdpa-dev and broke access to VDUSE devices with
> >> >this.
> >> >
> >> >This changes vdpa-dev to use the normal order again and use the stand=
ard
> >> >vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
> >> >used with vdpa-dev again after this fix.
> >>
> >> I like this approach and the patch LGTM, but I'm a bit worried about
> >> this function in hw/net/vhost_net.c:
> >>
> >>      int vhost_set_vring_enable(NetClientState *nc, int enable)
> >>      {
> >>          VHostNetState *net =3D get_vhost_net(nc);
> >>          const VhostOps *vhost_ops =3D net->dev.vhost_ops;
> >>
> >>          nc->vring_enable =3D enable;
> >>
> >>          if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
> >>              return vhost_ops->vhost_set_vring_enable(&net->dev, enabl=
e);
> >>          }
> >>
> >>          return 0;
> >>      }
> >>
> >> @Eugenio, @Jason, should we change some things there if vhost-vdpa
> >> implements the vhost_set_vring_enable callback?
> >
> >Eugenio may know more, I remember we need to enable cvq first for
> >shadow virtqueue to restore some states.
> >
> >>
> >> Do you remember why we didn't implement it from the beginning?
> >
> >It seems the vrings parameter is introduced after vhost-vdpa is
> >implemented.
>
> Sorry, I mean why we didn't implement the vhost_set_vring_enable
> callback for vhost-vdpa from the beginning.
>
> Thanks,
> Stefano


