Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30833606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q/ff3rZ7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9PI-0004Vh-6X; Wed, 28 Oct 2026 15:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xM9P7-0004V0-UD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:33:47 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xM9P6-0006he-2B
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:33:45 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso2412244eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793216022; cv=none;
 d=google.com; s=arc-20260327;
 b=RRpkpqAraBoQJKtoBr20nWIprx9Sau+n9KToflyvzo5DhiaE6zBg0F7IQdzjIFymTT
 VyYZ7uregvxZt6aGj8QIcepqoW3TtSPMWe7wDvBQ0W67/k4Poa6aTxTcjpuCrmB8kJgZ
 ZGe2DgpK6qqnb2AzARtNCPB9qxBziRsVjMCDsjYJytJh1G95pTSaiqB5Hsfzm9L5CUBN
 2SVattQFCIe9CDDDtdXjvx28uVVT8z2n6gB1rgHTtyfB0n5i9f9dKzapvG0WSsXYGwC2
 euIenVQwb9djxkkunlYhrEpYU9CaYUKqdqtWR2k7GyBdQ7kpAUC86l2GVOd0CX5vEM1p
 mNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WgEO3vIJTA8mDuL0R7PWikHaVm/tBeTJHeV17LgddFA=;
 fh=ft66mKYwM7yeS/7Gyh/VQZ+LtGBVE/NxGRY7vUJSvqs=;
 b=N8A342PzNlunUdxmDcqLU6yJctvr+LTkzZA16jbiAvAUpTFdhhlqtcIFVrEYnBmJ17
 pl4YotcsJRy7SJMSH58YvNRYF5rO1+sjCxFnJz2Ak3YVzh2KdYqsQ2+dWZWmFFKso8ZG
 aWQYjz+XN6G3lzCBhnpwz7czJKWKJh9iWYTSEu+kfYqykbmqBvWNd5gDPDXYMN3VWdLi
 dYI2nTKp6MT85Wl7O8C+ivHZb5rWVtY9wZLSyFbrxKAYmdHgouD3XQZYoKfxACHN2e4M
 ajiYzExsl+A7or5CBendy+63ozHtk4sdqp+zOZJ7LshGjzSqsCjMqxiktZAkzupG3dT8
 0eaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793216022; x=1793820822; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WgEO3vIJTA8mDuL0R7PWikHaVm/tBeTJHeV17LgddFA=;
 b=Q/ff3rZ7ZFfY9D3V+DVYm24pfa1YEglh+4FWQYiVsadAq/aXYLUeLdd6/K2ZKY9RQW
 MyCky1xVQtLxObFLVgoQ/r2CVxCWWul4e7bL75ypTIjI/UXsFG5okOHd2N3CIhC54i0t
 kaKCmNNaEOQGDqOURYO2xuNZDygr67C3Vit2y45/i2I6wNwodKx8Zt6UfwIZ91n6nfjV
 ADYF0nC7kMQdNFMzA9C8cWF+uKb6U4/APow2VdKGbTjIDhphtxzM1s4c6wFl1ZZBf49a
 HEOYBrbwfIWdh3Ne6eX/WOaIcXYf2bs8squIt7V/glvNZbUbqW7kgOxSISEV4tvDRy5O
 GFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793216022; x=1793820822;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WgEO3vIJTA8mDuL0R7PWikHaVm/tBeTJHeV17LgddFA=;
 b=d84uW6kR5ABVwkwwrdxWqIe0+bbEzO1gx7rZusFx9mldmPjRpJuvMc2bMs9XSTTnLF
 IWIPF+KeNX1veCClxpYKm9kx+tmz/hnFGsq7q1zA13J6MxP5dew5IQXNVhN4aZW3X1Z7
 YAnh+g0/yLTcBzfATzbh6IFq9+wA4ExC+dUiUyGGQkVr+ZYSA9vyZhqGguOO7CQVfsLw
 M3e3Hfd/i/WM06AEFpC4ViQjxIl/oU2BWoU7AO2Jz4dmpVzjcQMEp797pePi5B37D+vD
 XUu1a+ofSHu14k6VM053T0YtkL8xI09/UJWTr5COSlzusbP9VWfcuQkrGP61nU4Oy5ix
 MGtQ==
X-Gm-Message-State: AFq9FYKOr6SioR2rXhUrO2fQz5qO4Om9VzDZtYw8BodRoTzRpiWUicxn
 drWtPJ2ZZowG+OfTEJjAZaogRpL3CmCAk6BGOpsS1leF5uGLR+Kg3BC4bBvgc9Moq6LNH3Xr/bE
 vwtAqmDZHpjRT+E+VSFTwU9avkgYLeI8=
X-Gm-Gg: AYBFou3wOIN1/QACOCC8gD7ozGHnITEqvypAIzOHV2IicQj/Q13eOSXpntig0JkpPJV
 E2tKKYLbTbYOmV+SYgs8D/n7btgrFETqQdYEP2t2li+y42TEqpiK9aq+rL+P3ouPC7HbVMzGGi4
 ZJ8ixFSsTc4G8uWH/cECFOQRJJ1eZtu4W2hiKeBGUAuz5bJrLgjJYcKOqbgSWffVDjy5g2pX+Xs
 wJfiDaOrsNkjDuQDbPSedlO1WSoospVWVQS9zeOSIBpdNw+hdBP88JglnkVRClOQJysDlsJjfgj
 q5r529vKh7PIzloqUiAvdtWg9/zaEKQ26PogIlZT8RGK4zsIbqHofKvkgODwyaSfXz+0gpz2USK
 6QHFsvWGYxrcBQBTgu8OjI/oAoYW3Bci/C7Qzc7CyHtQ/8t0uRibBRL3xx27k+VGZVGz5Dw==
X-Received: by 2002:a05:7301:fc14:b0:36a:180f:3154 with SMTP id
 5a478bee46e88-36a2015a1a1mr4068220eec.18.1793216021736; Wed, 28 Oct 2026
 12:33:41 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
 <20261022-vhost-user-posix-v1-5-0bd4d450d23c@gmail.com>
 <20261027192445.GC933537@shajnocz.csb>
 <auGyOJGAo8Qivhu8@sgarzare-redhat> <20261028123346.GA1217203@shajnocz.csb>
 <auHzRD3kwZlil74F@sgarzare-redhat> <20261028184345.GB1305253@shajnocz.csb>
In-Reply-To: <20261028184345.GB1305253@shajnocz.csb>
From: Tim Pambor <timpambor@gmail.com>
Date: Wed, 28 Oct 2026 20:33:30 +0100
X-Gm-Features: AclHuK8BHER9zE7F699LbGt4KfyjOonpBExRAFOPlYsMIgBkfi8jy6af4JZap2I
Message-ID: <CAOX+r5_G66x98G08xG1R-R3wGENOxKjh54KE5pR69DmGahnQDw@mail.gmail.com>
Subject: Re: [PATCH 5/8] vhost-user: enable frontends on any POSIX system
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-block@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>,
 Brad Smith <brad@comstyle.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=timpambor@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 7:44=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Wed, Oct 28, 2026 at 02:23:55PM +0100, Stefano Garzarella wrote:
> > On Wed, Oct 28, 2026 at 08:33:46AM -0400, Stefan Hajnoczi wrote:
> > > On Wed, Oct 28, 2026 at 09:32:05AM +0100, Stefano Garzarella wrote:
> > > > On Tue, Oct 27, 2026 at 03:24:45PM -0400, Stefan Hajnoczi wrote:
> > > > > On Thu, Oct 22, 2026 at 03:47:26PM +0200, Tim Pambor wrote:
> > > > > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > > > > > index 6e05c995f1..788913953d 100644
> > > > > > --- a/hw/net/vhost_net.c
> > > > > > +++ b/hw/net/vhost_net.c
> > > > > > @@ -33,7 +33,13 @@
> > > > > >  #include "standard-headers/linux/virtio_ring.h"
> > > > > >  #include "hw/virtio/vhost.h"
> > > > > >  #include "hw/virtio/virtio-bus.h"
> > > > > > +#if defined(__linux__)
> > > > > >  #include "linux-headers/linux/vhost.h"
> > > > > > +#endif
> > > > > > +
> > > > > > +#ifndef VHOST_FILE_UNBIND
> > > > > > +#define VHOST_FILE_UNBIND -1
> > > > > > +#endif
> > > > >
> > > > > This constant is for hw/virtio/vhost.c's vhost_net_set_backend() =
API. It
> > > > > should be defined along with that API. Define it alongside
> > > > > vhost_net_set_backend() in hw/virtio/vhost.h and call it
> > > > > VHOST_NET_FILE_UNBIND?
> > > > >
> > > >
> > > > That constant is defined by a Linux header (see
> > > > linux-headers/linux/vhost.h). Are you suggesting to add another con=
stant
> > > > that is defined with VHOST_FILE_UNBIND on Linux and -1 on other pla=
tforms?
> > >
> > > Looking again, we should probably just use -1 instead of a constant
> >
> > Yep, this would be fine too.
> > I don't remember why I did in this way, maybe to keep the diff smaller
> > enough, but I don't have a strong opinion, we can avoid this ifndef and=
 use
> > -1 everywhere if you prefer that.
>
> IMO VHOST_FILE_UNBIND doesn't belong in vhost_net.c, so it would be nice
> to avoid the #ifndef.

So, for v2, is it ok if I replace the one usage of VHOST_FILE_UNBIND in
vhost_net.c with -1 and remove the #ifndef?

> > > since include/standard-headers/linux/vhost_types.h doesn't even defin=
e a
> > > constant:
> > >
> > >  struct vhost_vring_file {
> > >     unsigned int index;
> > >     int fd; /* Pass -1 to unbind from file. */
> > >
> > >  };
> > >
> > > It's strange that VHOST_FILE_UNBIND was defined in <linux/vhost.h>
> > > instead of <linux/vhost_types.h> where struct vhost_vring_file is
> > > defined.
> >
> > Oh, VHOST_FILE_UNBIND was introduced after struct vhost_vring_file, wit=
h
> > commit 776f395004d8 ("vhost_vdpa: Support config interrupt in vdpa").
> >
> > But I agree that should be moved to vhost_types.h. BTW <linux/vhost.h>
> > already includes <linux/vhost_types.h>, so maybe we can fix it without =
too
> > much trouble.
>
> Yes, that change seems safe and will improve things in the long term.

Or should I send a patch to linux adding VHOST_FILE_UNBIND to vhost_types.h
and then drop it from vhost.h and remove the #ifndef?

> Stefan
>

