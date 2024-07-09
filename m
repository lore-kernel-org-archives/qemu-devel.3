Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBDEC3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 02:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR0tr-0007pQ-Mz; Mon, 08 Jul 2024 22:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sR0tc-0006ys-P5
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sR0tZ-0003yw-GK
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720493274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IfM8VNyqetsgSfQRL5ZOKAWvEEYEwNid5P2Z7k/shYs=;
 b=IFsEOIQohpXznEvWYTy2Fvic+Qj3AXex2XEiW7sXJxm2k8uDgSJH3DqXq16jqRPek7Itzn
 zos2y7Hju0LMBRjmQf44Oi336EcaZi/EkJ2DmyomyKur44irhNKxhRc27ra9CyN0NT7no0
 IK5X4zym7ZRvq/EMhzig/z68jtXDlVo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-7TBeOiZINva-kQA_Mf7CcQ-1; Mon, 08 Jul 2024 22:47:50 -0400
X-MC-Unique: 7TBeOiZINva-kQA_Mf7CcQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3d93f4b2832so117284b6e.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 19:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720493269; x=1721098069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IfM8VNyqetsgSfQRL5ZOKAWvEEYEwNid5P2Z7k/shYs=;
 b=c9O8/PdMv23nqmGpRG17joBL3FWyzUSBWr91uCo3DzyQdTTEfac1gUOq8ecv4qSTOc
 dtU2j3kiILU74L8ZpSLgN81+Q06PTYCLcZMqQ2ci3GqFGB1A9w0VlXtTzhm1B9koM6g7
 0RA6xgkXCB5t9rA5FZ1Yg39xZK0g3408Qr4ZZbEc4HRK/kd5FoPtgC4vTpr5uCnz00yV
 n/1BEx/VLzfdcqbvBh6SsAV3Vg14igpctYdJc952UGkNMq0HUWHBnp7547UEiHkNjOcw
 3YZIpvlN2H3cmk2bAvZOYsr9zPnutgx/IcfRpRBmTlppB2Z3Gz0dAk0Az4MGR9Ak+GXl
 8zSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtuxgCu70mGHj9VAbRicms6V2bCV9wAHjUPI+U1/cbb8lwCJ10kvubA4mKnJcHl0IRzsUJEOgs466tX0zY00gsjiTMiiw=
X-Gm-Message-State: AOJu0YzJ73/sEDWsbR8ePYoxqHShnBnmAw09g8fY111ePIeCUdqmp6aw
 HTV57J1auvzA+FYrHdKciMxvq7jM+IK5nIk2Oa5zsxIXEscanHPdTpxxV/SbyNFa9sfdis/8n3n
 FPckCPDX8Dx6QFDIBj67ADOsPW3boYeRakFU7Ng+kuUIXl7DMp58dUWGQEiUQws9XAvDFwh18oO
 rHslUv6hJa9OEsy+dv5gGoy/WGaVQ=
X-Received: by 2002:a05:6808:1312:b0:3d9:243a:7ae8 with SMTP id
 5614622812f47-3d93c08c8cfmr1174317b6e.39.1720493269346; 
 Mon, 08 Jul 2024 19:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhaGO6Py2i5ioLApBwALwuXiLMZpq4gyRpG8fR9GlCwI6tnwffhfLgoU30ZhZtpCgjsc+8uIthUYbMcsN+e+s=
X-Received: by 2002:a05:6808:1312:b0:3d9:243a:7ae8 with SMTP id
 5614622812f47-3d93c08c8cfmr1174306b6e.39.1720493269026; Mon, 08 Jul 2024
 19:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240709022707.579474-1-lulu@redhat.com>
 <CACGkMEt9ixHst2P++YZ5qkA6tjSTCm+9WvJcv4=jW4ST=PiwMw@mail.gmail.com>
 <CACLfguXtnMs19LR1xVxEqv_kPVJyppDxj3m42UvbHforWv1WMw@mail.gmail.com>
In-Reply-To: <CACLfguXtnMs19LR1xVxEqv_kPVJyppDxj3m42UvbHforWv1WMw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Jul 2024 10:47:37 +0800
Message-ID: <CACGkMEt-G5-VMG1ydFSN2+Z=mcOryyhvWyAGu4rqARggpuQc3Q@mail.gmail.com>
Subject: Re: [RFC] virtio-net: check the mac address for vdpa device
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, 9 Jul 2024 at 10:33, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Jul 9, 2024 at 10:27=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > When using VDPA device, we should verify whether the MAC address in t=
he
> > > hardware matches the MAC address from the QEMU command line. If not,
> > > we will need to update the related information.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> >
> > This seems to be a workaround, for example it means the mac address
> > set from the qemu command line has the higher priority compared to the
> > one that is provisioned by the host?
> >
> > At least we need to have a warning here?
> >
> In this design, the MAC address from the host will take higher
> priority over the MAC address from the command line. I'm not sure if
> this is acceptable?

That's fine but it seems not what I read for this patch?

As you try to set config, or anything I missed here?

Thanks

> sure, will add some warning here
> > Thanks
> >
> > > ---
> > >  hw/net/virtio-net.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 9c7e85caea..db04331b82 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -3739,10 +3739,17 @@ static void virtio_net_device_realize(DeviceS=
tate *dev, Error **errp)
> > >      nc->rxfilter_notify_enabled =3D 1;
> > >
> > >     if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHO=
ST_VDPA) {
> > > -        struct virtio_net_config netcfg =3D {};
> > > -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > > -        vhost_net_set_config(get_vhost_net(nc->peer),
> > > -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_F=
RONTEND);
> > > +     struct virtio_net_config netcfg =3D {};
> > > +     static const MACAddr zero =3D {.a =3D {0, 0, 0, 0, 0, 0}};
> > > +     vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcf=
g,
> > > +                          ETH_ALEN);
> > > +     if ((memcmp(&netcfg.mac, &n->nic_conf.macaddr, sizeof(MACAddr))=
 !=3D 0) &&
> > > +         memcmp(&netcfg.mac, &zero, sizeof(zero) !=3D 0)) {
> > > +       memcpy(&n->nic_conf.macaddr, &netcfg.mac, sizeof(MACAddr));
> > > +       memcpy(&n->mac[0], &netcfg.mac, sizeof(MACAddr));
> > > +     }
> > > +     vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcf=
g, 0,
> > > +                          ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
> > >      }
> > >      QTAILQ_INIT(&n->rsc_chains);
> > >      n->qdev =3D dev;
> > > --
> > > 2.45.0
> > >
> >
>


