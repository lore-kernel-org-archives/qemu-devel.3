Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42572C3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 02:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR11n-0004A0-91; Mon, 08 Jul 2024 22:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sR11e-0003qJ-Dv
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sR11c-0005f8-QD
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720493774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ne9pPGDzs2TuxyX0kT6HGJ0VUhUH/lEWGFfy7NHmJe8=;
 b=PR2ZC9x0/xo6Q2qe7fvXTqF2AY1tLL5gJbGPgON/u4XItoBNJ5MVXx1ISOd9EPoVsQdD8O
 iIoOIwdB7o9vLltCA6KxdhSQjM4oA0r9TuICSl2fcfDOfU4rJs0bTU8hqcX5IMxR2JsOWK
 tQdwrwAPAYgMGFiAejYR3noqcoHgHv0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-zh0V3DewNmy7tj74mLieqQ-1; Mon, 08 Jul 2024 22:56:12 -0400
X-MC-Unique: zh0V3DewNmy7tj74mLieqQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7535875ab7so682493566b.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 19:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720493771; x=1721098571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ne9pPGDzs2TuxyX0kT6HGJ0VUhUH/lEWGFfy7NHmJe8=;
 b=vkxoTzOm7BY2vme4Byow5o+JI0nDKXp+fT0ZZpqf7MHNZgYKHopXUXZjCbGHUmo8b/
 VmoIpwACunC0LEBjiOcJRxkv8Gi/J515jcSamtvp/U/0qreFJlM1D0n3ApinaNqNUOzi
 XrAe8M4hJjCKMWBV6eEnGhx9vjxvw4NXzSfhC1f+68NmXT9JzQqbcZ6++CX8vy0uKKi/
 NGLUqOdnoYU3dezMo2s09qKByIp1fyJ0XD39SXqNR6j9vtUaD13x/9ET7vKw21FQ/ouC
 qHhIwINTChwEYGMHv6bnk36qlG06ExUUzf3I89jkDa7PRRGe1aCgXoDsn0+fgtHkqva/
 yUiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaMp6++JlkS7iNCdcoe5F/C1wRfor4sZnAvgmnMuJsWbEl1v9k6nV0QKD92/c3IfMKlOcuHoAamvOQ9PQrzRDI+kRO51Y=
X-Gm-Message-State: AOJu0YyA/bWTxxtDZQUOEPaXs/oRHohEWzoSzhoO9kqZor2e1tue28FK
 Q1tDl6JvO8YTA8WoUucw39nJjmbiTH4mpplXkVUPPUIVZUJ+lKOye730vjn9/888CVdXqHEfFEv
 K+Qjlu2XaQJMlX+turE6JR0of5atndjhjkXSkYw5iqfwcfDYZXzZK/5muskNXplGSE3ZQR9tIuB
 dGKY4QpNSfgJTbmacxz7OBIOm9zso=
X-Received: by 2002:a17:906:fa90:b0:a77:cdae:6a59 with SMTP id
 a640c23a62f3a-a780d250410mr61013866b.21.1720493771007; 
 Mon, 08 Jul 2024 19:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9jvF0gplf+tkGfrFX9RVXkNP34tMjcfeCKuIOEURNybhkmB0pnrljlkV0HFmykXearUrlHBeulbDKWMwWJx8=
X-Received: by 2002:a17:906:fa90:b0:a77:cdae:6a59 with SMTP id
 a640c23a62f3a-a780d250410mr61013366b.21.1720493770594; Mon, 08 Jul 2024
 19:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240709022707.579474-1-lulu@redhat.com>
 <CACGkMEt9ixHst2P++YZ5qkA6tjSTCm+9WvJcv4=jW4ST=PiwMw@mail.gmail.com>
 <CACLfguXtnMs19LR1xVxEqv_kPVJyppDxj3m42UvbHforWv1WMw@mail.gmail.com>
 <CACGkMEt-G5-VMG1ydFSN2+Z=mcOryyhvWyAGu4rqARggpuQc3Q@mail.gmail.com>
In-Reply-To: <CACGkMEt-G5-VMG1ydFSN2+Z=mcOryyhvWyAGu4rqARggpuQc3Q@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 10:55:33 +0800
Message-ID: <CACLfguWmp4Qs473zO5GOLAXKVmmGPnqC+=A1Q=my-Va+LECxgw@mail.gmail.com>
Subject: Re: [RFC] virtio-net: check the mac address for vdpa device
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
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

On Tue, 9 Jul 2024 at 10:47, Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Tue, 9 Jul 2024 at 10:33, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Tue, Jul 9, 2024 at 10:27=E2=80=AFAM Cindy Lu <lulu@redhat.com> wr=
ote:
> > > >
> > > > When using VDPA device, we should verify whether the MAC address in=
 the
> > > > hardware matches the MAC address from the QEMU command line. If not=
,
> > > > we will need to update the related information.
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >
> > > This seems to be a workaround, for example it means the mac address
> > > set from the qemu command line has the higher priority compared to th=
e
> > > one that is provisioned by the host?
> > >
> > > At least we need to have a warning here?
> > >
> > In this design, the MAC address from the host will take higher
> > priority over the MAC address from the command line. I'm not sure if
> > this is acceptable?
>
> That's fine but it seems not what I read for this patch?
>
> As you try to set config, or anything I missed here?
>
> Thanks
>
yes I use   vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcf=
g,
 ETH_ALEN); to get the mac  from hardware and copy it
to n->nic_conf.macaddr and n->mac
  memcpy(&n->nic_conf.macaddr, &netcfg.mac, sizeof(MACAddr));
  memcpy(&n->mac[0], &netcfg.mac, sizeof(MACAddr));
qemu will use this information for the following steps

Thanks
cindy

> > sure, will add some warning here
> > > Thanks
> > >
> > > > ---
> > > >  hw/net/virtio-net.c | 15 +++++++++++----
> > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > index 9c7e85caea..db04331b82 100644
> > > > --- a/hw/net/virtio-net.c
> > > > +++ b/hw/net/virtio-net.c
> > > > @@ -3739,10 +3739,17 @@ static void virtio_net_device_realize(Devic=
eState *dev, Error **errp)
> > > >      nc->rxfilter_notify_enabled =3D 1;
> > > >
> > > >     if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_V=
HOST_VDPA) {
> > > > -        struct virtio_net_config netcfg =3D {};
> > > > -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > > > -        vhost_net_set_config(get_vhost_net(nc->peer),
> > > > -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE=
_FRONTEND);
> > > > +     struct virtio_net_config netcfg =3D {};
> > > > +     static const MACAddr zero =3D {.a =3D {0, 0, 0, 0, 0, 0}};
> > > > +     vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&net=
cfg,
> > > > +                          ETH_ALEN);
> > > > +     if ((memcmp(&netcfg.mac, &n->nic_conf.macaddr, sizeof(MACAddr=
)) !=3D 0) &&
> > > > +         memcmp(&netcfg.mac, &zero, sizeof(zero) !=3D 0)) {
> > > > +       memcpy(&n->nic_conf.macaddr, &netcfg.mac, sizeof(MACAddr));
> > > > +       memcpy(&n->mac[0], &netcfg.mac, sizeof(MACAddr));
> > > > +     }
> > > > +     vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&net=
cfg, 0,
> > > > +                          ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND=
);
> > > >      }
> > > >      QTAILQ_INIT(&n->rsc_chains);
> > > >      n->qdev =3D dev;
> > > > --
> > > > 2.45.0
> > > >
> > >
> >
>


