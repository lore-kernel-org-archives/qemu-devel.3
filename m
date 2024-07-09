Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC09FC3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 02:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR0n3-0003kD-RN; Mon, 08 Jul 2024 22:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sR0n2-0003jj-R3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sR0n0-0002qO-RU
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720492869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ea8fcQsnfvgA6AMjWTZwa9nbeJLfNBi73zhiiBRr0B4=;
 b=fcqxDWVDOCU7v+MQfQqmRqxZ8BdUUynWFxa5QTY69A99JtwYrjVzKNQsycyFdQW5uN0GFz
 43OwEp3KytA2U+a6xAPpTCwM1ZNCKEOqoCUEvtXGlIDLOXHhmpcan4ZyXV/iMscqrq8kzr
 V0un/3bDiR37JsBefJYD1to4Wqbcx4k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-oVu1asc7Myeok8k7l2lPUQ-1; Mon, 08 Jul 2024 22:41:06 -0400
X-MC-Unique: oVu1asc7Myeok8k7l2lPUQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a77c6ea022fso586258866b.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 19:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720492865; x=1721097665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ea8fcQsnfvgA6AMjWTZwa9nbeJLfNBi73zhiiBRr0B4=;
 b=Q+hmRU9U2WMxVW64o9JrcbikuHZehXi8H4M5LTVe4LvJpE6THZp2B3+tIzzd+d79jB
 kW+2d5x1nQJdSpAkqgl+gYN2VCywLXjWlNirCrkGNjvW0CUE5GnONR9Opy3/aaTvI5Hn
 fDpDUdg1YQvtfX5YBJDse3qZGb6TdhI8uy8IWlFLVvrYOCCb0EkhoSbYmD0bJK1W8Tax
 sbLY6a6gbhNjF23KaT/RmrNtEijSrYoNyBnOcRZbUXGPpTSvEMMhV7U3HnpM13xzaDPW
 w7WaojzMnRBq+c3zxiUVKwo+S+/V/wA81rvPyNrVtr3hh2DWdnngITbdep/56CFwYO2L
 easg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCxSQy5Yv3ltnF3lKQNaeMVZCxge1sqs4VxF4QvNAvWvPiGjRTgiSSUGuTB0DUbzonqefixcy293K3gIauSnzTaJMblwA=
X-Gm-Message-State: AOJu0YxLDzcKiPlZf9jChD5NUz/oonCmLo+XamN7lkG6biry6/YfGNeO
 eM8+Dug0gVzEpRlquGiwqHdC5CHD21girvQqhnpFoz+E1Dqbh1yIT0khSXSd7qAFViU4kkP1cbm
 22Nqv1ShWOq1U0ET/y+vzvd7l9UZeoRN3MK1ZKCZBTaHnUiwnqi/59Zu+YG3UKRlX0GSK+MHjZZ
 gYObx1Q0jv+FIiG5JJDLjpc8kRUmY=
X-Received: by 2002:a17:906:e20f:b0:a6f:dd93:7ffb with SMTP id
 a640c23a62f3a-a780d205b62mr59103366b.1.1720492865340; 
 Mon, 08 Jul 2024 19:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhMQlBdDHbDutKUFFPVTRPtTTpyoeounlD7dVOwdxsPjbJ/5CffnuoeyScxwwTCQBlgYlZWzoRChJCP+H3I3A=
X-Received: by 2002:a17:906:e20f:b0:a6f:dd93:7ffb with SMTP id
 a640c23a62f3a-a780d205b62mr59102266b.1.1720492864975; Mon, 08 Jul 2024
 19:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240709022707.579474-1-lulu@redhat.com>
 <CACGkMEt9ixHst2P++YZ5qkA6tjSTCm+9WvJcv4=jW4ST=PiwMw@mail.gmail.com>
In-Reply-To: <CACGkMEt9ixHst2P++YZ5qkA6tjSTCm+9WvJcv4=jW4ST=PiwMw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 10:40:28 +0800
Message-ID: <CACLfguXtnMs19LR1xVxEqv_kPVJyppDxj3m42UvbHforWv1WMw@mail.gmail.com>
Subject: Re: [RFC] virtio-net: check the mac address for vdpa device
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
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

On Tue, 9 Jul 2024 at 10:33, Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Jul 9, 2024 at 10:27=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > When using VDPA device, we should verify whether the MAC address in the
> > hardware matches the MAC address from the QEMU command line. If not,
> > we will need to update the related information.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> This seems to be a workaround, for example it means the mac address
> set from the qemu command line has the higher priority compared to the
> one that is provisioned by the host?
>
> At least we need to have a warning here?
>
In this design, the MAC address from the host will take higher
priority over the MAC address from the command line. I'm not sure if
this is acceptable?
sure, will add some warning here
> Thanks
>
> > ---
> >  hw/net/virtio-net.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 9c7e85caea..db04331b82 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3739,10 +3739,17 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)
> >      nc->rxfilter_notify_enabled =3D 1;
> >
> >     if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST=
_VDPA) {
> > -        struct virtio_net_config netcfg =3D {};
> > -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > -        vhost_net_set_config(get_vhost_net(nc->peer),
> > -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRO=
NTEND);
> > +     struct virtio_net_config netcfg =3D {};
> > +     static const MACAddr zero =3D {.a =3D {0, 0, 0, 0, 0, 0}};
> > +     vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
> > +                          ETH_ALEN);
> > +     if ((memcmp(&netcfg.mac, &n->nic_conf.macaddr, sizeof(MACAddr)) !=
=3D 0) &&
> > +         memcmp(&netcfg.mac, &zero, sizeof(zero) !=3D 0)) {
> > +       memcpy(&n->nic_conf.macaddr, &netcfg.mac, sizeof(MACAddr));
> > +       memcpy(&n->mac[0], &netcfg.mac, sizeof(MACAddr));
> > +     }
> > +     vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,=
 0,
> > +                          ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
> >      }
> >      QTAILQ_INIT(&n->rsc_chains);
> >      n->qdev =3D dev;
> > --
> > 2.45.0
> >
>


