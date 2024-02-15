Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF4EC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafGL-0000Pt-QH; Thu, 15 Feb 2024 12:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rafGJ-0000Pi-Lb
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rafGH-0002gp-4r
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708017060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQ9DEHVWOD46+d0QtZQcOsdei6wI+ORMcZsYZcUa7YY=;
 b=C+dii2zofAQ0zDhlT5r81K0BQm7wMwB6ZBwvGH61cdYDtx28RURyz8gUHqHnHVjIowwlXO
 kjVwUsA6bEP0vbs6zfWAtvoJFZz2uzJMpL7Ssls9gy/uIPQRaKRc37jzlIpNd1mh+agZLo
 xL+J/hjYs+nR3G5/i2JhByYks+PLlac=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-INleiHZ2NUmd0qB13S0BTg-1; Thu, 15 Feb 2024 12:10:58 -0500
X-MC-Unique: INleiHZ2NUmd0qB13S0BTg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6047a047f58so18360357b3.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708017058; x=1708621858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQ9DEHVWOD46+d0QtZQcOsdei6wI+ORMcZsYZcUa7YY=;
 b=iotXMvHBZETgxLvNc+JT1Vaw6T3nYXU7Md2i7lThiYfnL5CXEcwGa8yBk+1OkMBxO8
 FjHiQFJt3vYw0UcZ2GRdFrVi+I5su/+fk/RmxpuiVJEs1NGamlPM84bwPDoJty2ndzLQ
 QCnoM0gQp0p2q1cCtnUYyd5pbBv2CastDbzg+RQ/ncaeRbUg49T+WNbMVM7reoo2xAFY
 886N6/shv2vFW+ZeS/MJ1hRkp8ILbbGF1O1LL4H/yPqrhCTmw9VdkzGyD2SUhvsqKEFw
 ioWYdMcTRMAvGdcmyEtnwLhauxcwH+pQE7wv2CT5/kFOSAH+zJqjz1Yr2MAXvCMTuLAi
 BHGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKfpzoHFOYXqC+Tt2Od0OYUfDbrRp7oB5Q9UsAF4YaY78xfEtomNDGconxqpwGzEs19Lq5wumkjSFIs7dZilrAdr2pvn0=
X-Gm-Message-State: AOJu0YwyQe/We9Fchq3blGQTn0hdAoiONT6E24y8e0V1qygpeuOcHfIZ
 bX85wraehEB7MLyWMx2feUXqHBjPEHfGqv+eYKbvBwSZYKwuw9dZ1wvi9UNHn+DV8Xm8vP3REYA
 /82o51k/wO3fjP440caRfKyyI+0i1I0izOYMRgoQ+IYhvUkI1F5so0mEe8jYtTQ97JOrAjm3gDt
 fE9j9LH14NfHVe0fWEG93gRNJXvcI=
X-Received: by 2002:a81:8390:0:b0:607:b864:530d with SMTP id
 t138-20020a818390000000b00607b864530dmr2225919ywf.27.1708017057954; 
 Thu, 15 Feb 2024 09:10:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3dtMMR8AwQPbnLhf4RNYwc3CWCLeJ8No/GlLTChVLaoxOeiRR8NVeukuXvlEZ/MNz2/1vZCfCKnKbSMRr7aY=
X-Received: by 2002:a81:8390:0:b0:607:b864:530d with SMTP id
 t138-20020a818390000000b00607b864530dmr2225898ywf.27.1708017057694; Thu, 15
 Feb 2024 09:10:57 -0800 (PST)
MIME-Version: 1.0
References: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
 <1707910082-10243-13-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWe9t=jkW2ZQvv5Z6+4x9R2DQhSKbqVNDUN1b2WXfiSVfQ@mail.gmail.com>
In-Reply-To: <CAJaqyWe9t=jkW2ZQvv5Z6+4x9R2DQhSKbqVNDUN1b2WXfiSVfQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 Feb 2024 18:10:21 +0100
Message-ID: <CAJaqyWc23kSMH6m4h5YiR_pLbctpjEWQVq7XLCdAeM3ANuX1Wg@mail.gmail.com>
Subject: Re: [PATCH 12/12] vdpa: fix network breakage after cancelling
 migration
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
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

On Thu, Feb 15, 2024 at 5:15=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Feb 14, 2024 at 1:39=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com=
> wrote:
> >
> > Fix an issue where cancellation of ongoing migration ends up
> > with no network connectivity.
> >
> > When canceling migration, SVQ will be switched back to the
> > passthrough mode, but the right call fd is not programed to
> > the device and the svq's own call fd is still used. At the
> > point of this transitioning period, the shadow_vqs_enabled
> > hadn't been set back to false yet, causing the installation
> > of call fd inadvertently bypassed.
> >
> > Fixes: a8ac88585da1 ("vhost: Add Shadow VirtQueue call forwarding capab=
ilities")
> > Cc: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > ---
> >  hw/virtio/vhost-vdpa.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index 004110f..dfeca8b 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -1468,7 +1468,15 @@ static int vhost_vdpa_set_vring_call(struct vhos=
t_dev *dev,
> >
> >      /* Remember last call fd because we can switch to SVQ anytime. */
> >      vhost_svq_set_svq_call_fd(svq, file->fd);
> > -    if (v->shadow_vqs_enabled) {
> > +    /*
> > +     * When SVQ is transitioning to off, shadow_vqs_enabled has
> > +     * not been set back to false yet, but the underlying call fd
> > +     * will have to switch back to the guest notifier to signal the
> > +     * passthrough virtqueues. In other situations, SVQ's own call
> > +     * fd shall be used to signal the device model.
> > +     */
> > +    if (v->shadow_vqs_enabled &&
> > +        v->shared->svq_switching !=3D SVQ_TSTATE_DISABLING) {
>
> I think it would be great to not need to add more status variables to
> vhost_vdpa (or any struct).
>
> What if we recover the call file descriptor at vhost_vdpa_svqs_stop?
> This way everything is more symmetrical as kick and call are set by
> vhost_vdpa_svqs_start.
>

Also, we could check for dev->started.

> Thanks!
>
> >          return 0;
> >      }
> >
> > --
> > 1.8.3.1
> >


