Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8158FC54E67
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 03:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm3YY-0008EV-48; Sun, 17 Mar 2024 23:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rm3YW-0008EJ-Q2
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rm3YV-0001HM-9T
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710732054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTAKG2BkpxCninIQkC7iYxofjgxVusdnTqholqs9wpc=;
 b=OdvV52BPNKQLYzwrIDTWFlKlk+DUiQcT6RBcDsoMLyEsjvzPOuUWAIjErT3lauf+FhSHoz
 uwsgA5zN5uvboSbIZbxFFgVKbfp+tuspKew9ur52iy2NRWDbHWeMBuL8mBn3gphr1ZAcW7
 35YNx3C6LatXPUsR3RzhGLt5wueBUeI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-g_tyVy9DOqu59fOEVfoPdw-1; Sun, 17 Mar 2024 23:20:52 -0400
X-MC-Unique: g_tyVy9DOqu59fOEVfoPdw-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1defe73383dso12983005ad.1
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 20:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710732051; x=1711336851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTAKG2BkpxCninIQkC7iYxofjgxVusdnTqholqs9wpc=;
 b=XEnD1oxjU6Rrc5/5Zyo88fgwPSURHl01nTIABLg10AwZqnDGPPGWLZD/vH4Mf9fyob
 /OjIxvvv+l2A6ShFGHJ2ujzQEea4KWATZE/eB9v0K5nB6pH854x2/TOtzJ/fs5FCCF+3
 nsX3OMasBrrgN+Vw0+vsyzMoS0xVrZe8Hx5bHPG92C5Ltfv9LUSzLySw24fdTIhR6sQf
 R86S+mMegl7wA/ErAjfeso8PAedJOrgq57xi5R0dyk0eykIY7YD1Fj8QQTRXdNmR6Lzu
 Qxt4Ft3ioZCqx16YmOiUChit+4tEHOoXKCwe7GD4a94Ztt2QNX5TG3Tj0KhzKgWfXNmc
 yLDQ==
X-Gm-Message-State: AOJu0YwuUxFrXzDqxS3sv7aMmrStGr3gp1t0cJ9pQiTNRnHnKfKa701Q
 8Jj4zT729fuMdOchjOEXxyuCFKX7wCPrS+tzVIiLZm7qypj/0PZgnh7MYVLuO7xYWzb0/jSvXHJ
 ZtdJYJ9HdIUGkGyRtExdYUHCV57jaGAJ1T896/uwYWnxgc867oEf8eQlYL2UwDW52RFWUayb+dN
 cBg88lX5gWHQcBjpNLvqAni9X2H4c=
X-Received: by 2002:a17:902:d486:b0:1e0:1bf6:1f89 with SMTP id
 c6-20020a170902d48600b001e01bf61f89mr3138703plg.0.1710732051037; 
 Sun, 17 Mar 2024 20:20:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDZvdr4ElrDGHTCpi/OsK9QXZnHrZpcKp0b67LUfMGhYPm6nzhKuKxQ3pY0sXvwrZonq/bqt5CyHYAEUyuv7E=
X-Received: by 2002:a17:902:d486:b0:1e0:1bf6:1f89 with SMTP id
 c6-20020a170902d48600b001e01bf61f89mr3138678plg.0.1710732050626; Sun, 17 Mar
 2024 20:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEt2-naXvHjCcPyQAoSfto44OVaSUqPtg_gvS8-wrhNwZA@mail.gmail.com>
 <9cb9fe47-f173-4cf1-8bc0-01971e47559c@oracle.com>
In-Reply-To: <9cb9fe47-f173-4cf1-8bc0-01971e47559c@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Mar 2024 11:20:39 +0800
Message-ID: <CACGkMEvjB45RzonvWMQ=OnDpm5M04u6ab6tT7b0=sMsEyBB-Vg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] vhost: dirty log should be per backend type
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com, 
 joao.m.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Mar 16, 2024 at 2:33=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 3/14/2024 8:50 PM, Jason Wang wrote:
> > On Fri, Mar 15, 2024 at 5:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> There could be a mix of both vhost-user and vhost-kernel clients
> >> in the same QEMU process, where separate vhost loggers for the
> >> specific vhost type have to be used. Make the vhost logger per
> >> backend type, and have them properly reference counted.
> > It's better to describe what's the advantage of doing this.
> Yes, I can add that to the log. Although it's a niche use case, it was
> actually a long standing limitation / bug that vhost-user and
> vhost-kernel loggers can't co-exist per QEMU process, but today it's
> just silent failure that may be ended up with. This bug fix removes that
> implicit limitation in the code.

Ok.

> >
> >> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>
> >> ---
> >> v3->v4:
> >>    - remove checking NULL return value from vhost_log_get
> >>
> >> v2->v3:
> >>    - remove non-effective assertion that never be reached
> >>    - do not return NULL from vhost_log_get()
> >>    - add neccessary assertions to vhost_log_get()
> >> ---
> >>   hw/virtio/vhost.c | 45 +++++++++++++++++++++++++++++++++------------
> >>   1 file changed, 33 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> index 2c9ac79..612f4db 100644
> >> --- a/hw/virtio/vhost.c
> >> +++ b/hw/virtio/vhost.c
> >> @@ -43,8 +43,8 @@
> >>       do { } while (0)
> >>   #endif
> >>
> >> -static struct vhost_log *vhost_log;
> >> -static struct vhost_log *vhost_log_shm;
> >> +static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
> >> +static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
> >>
> >>   /* Memslots used by backends that support private memslots (without =
an fd). */
> >>   static unsigned int used_memslots;
> >> @@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhost_de=
v *dev,
> >>           r =3D -1;
> >>       }
> >>
> >> +    if (r =3D=3D 0) {
> >> +        assert(dev->vhost_ops->backend_type =3D=3D backend_type);
> >> +    }
> >> +
> > Under which condition could we hit this?
> Just in case some other function inadvertently corrupted this earlier,
> we have to capture discrepancy in the first place... On the other hand,
> it will be helpful for other vhost backend writers to diagnose day-one
> bug in the code. I feel just code comment here will not be
> sufficient/helpful.

See below.

>
> >   It seems not good to assert a local logic.
> It seems to me quite a few local asserts are in the same file already,
> vhost_save_backend_state,

For example it has assert for

assert(!dev->started);

which is not the logic of the function itself but require
vhost_dev_start() not to be called before.

But it looks like this patch you assert the code just a few lines
above the assert itself?

dev->vhost_ops =3D &xxx_ops;

...

assert(dev->vhost_ops->backend_type =3D=3D backend_type)

?

Thanks

> vhost_load_backend_state,
> vhost_virtqueue_mask, vhost_config_mask, just to name a few. Why local
> assert a problem?
>
> Thanks,
> -Siwei
>
> > Thanks
> >
>


