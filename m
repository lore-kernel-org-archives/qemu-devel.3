Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F52C3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 03:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR164-0005yQ-KJ; Mon, 08 Jul 2024 23:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sR160-0005di-4C
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 23:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sR15y-0006bd-Fh
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 23:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720494044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTXhjjoWHbFVv5+DegVLx4ArcAOFYmFYxtarXAikFYw=;
 b=MaCzWmuZGB2e1iKdDhhccE9IupDUkjLyIXVEX94mYAXsyB3gw4rhidhOE5Yu1hBuCkD+tN
 W0Z+1eqhuz0MBRkgk1j744Y0n3gremRSgU1URLTaKF0UgAkENfDX4F9c++Nr6SDVz+izES
 1ruyu5TtFK/qx5kxmR2CoAybSD/f9oo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-hyrVXJRUOKqR5CG1MQZneQ-1; Mon, 08 Jul 2024 23:00:42 -0400
X-MC-Unique: hyrVXJRUOKqR5CG1MQZneQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-70affb2ea9aso3510848b3a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 20:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720494041; x=1721098841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZTXhjjoWHbFVv5+DegVLx4ArcAOFYmFYxtarXAikFYw=;
 b=NIp7vdWFuijKiC44z29SqVBtkBOuBGdzZcswg8p6+0bpGuF5/H6/zgDxYQeEwiw5h0
 yELLHr7C1kPlLivvAlpu0wtKhY01HjZR5fTWzBSed2BdQSSiVXt3NXbGv1QJW88Ta525
 2jW+nC8+zWTFM6nA7qQSt/PfR90gHg2V3KpleHT2HEIUjIHcYVmkFGq/mcVdW/QIGJzE
 dcd4rTLur/4GeKZ8HWDY0bG+IYoocOETq0y+v+b7ALZ4KHWQylF336RoHclv25Ho9fMs
 CHEVBibDmor2EAkgYgHh6lT+aNZ5oY+k1k3bcRtlwFnM+WNiClZ8+wcw7F2nmmU2+efw
 m+1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG4yZyDzB1ia+chJGB+69LhbYBfR/PH/OhhuqiSwyDhUKs3Nxlb78BcMzvzb4pJsvEGL/SE0axYvF1ciJKeJu0vqIEvbg=
X-Gm-Message-State: AOJu0YzWhKVhSjzh/m7vuESkDBc+fWfqkY6Rp/2N8mgD/jEKa9TCOVo2
 KvaFq4jwjMkHKc/EtkjXySi/7EEtX1ZSQKEyBptuKsg2mtogZn5xXU8FOCf0uXt2bro0u38YRtx
 RSnosL7gDzHTAWu/pGzYk12cFIWcRAhEq4PRIarYRYn1dRdhuAcyKS9vMNfdLUR2yifaUYTJNBV
 pGMfnx4jOQkkHachRs8IR4TY7V5HI=
X-Received: by 2002:a05:6a00:1d1a:b0:70b:14b4:b5de with SMTP id
 d2e1a72fcca58-70b4364ffc7mr1425228b3a.23.1720494040413; 
 Mon, 08 Jul 2024 20:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1HOU3OF40D2qHawMTt0UopK7Yioewl9souiiPY84jt3eL3Kraalo6fYevRuw7Vix7mRL85ENg+KJzf8Fp+E=
X-Received: by 2002:a05:6a00:1d1a:b0:70b:14b4:b5de with SMTP id
 d2e1a72fcca58-70b4364ffc7mr1425207b3a.23.1720494039900; Mon, 08 Jul 2024
 20:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240709022707.579474-1-lulu@redhat.com>
 <CACGkMEt9ixHst2P++YZ5qkA6tjSTCm+9WvJcv4=jW4ST=PiwMw@mail.gmail.com>
 <CACLfguXtnMs19LR1xVxEqv_kPVJyppDxj3m42UvbHforWv1WMw@mail.gmail.com>
 <CACGkMEt-G5-VMG1ydFSN2+Z=mcOryyhvWyAGu4rqARggpuQc3Q@mail.gmail.com>
 <CACLfguWmp4Qs473zO5GOLAXKVmmGPnqC+=A1Q=my-Va+LECxgw@mail.gmail.com>
In-Reply-To: <CACLfguWmp4Qs473zO5GOLAXKVmmGPnqC+=A1Q=my-Va+LECxgw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Jul 2024 11:00:28 +0800
Message-ID: <CACGkMEuZTrFyZ5qXEqaqQcfhyfe0mgGiCaLNG3Ck7ExPUKEDaw@mail.gmail.com>
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

On Tue, Jul 9, 2024 at 10:56=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, 9 Jul 2024 at 10:47, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Jul 9, 2024 at 10:41=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > On Tue, 9 Jul 2024 at 10:33, Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Tue, Jul 9, 2024 at 10:27=E2=80=AFAM Cindy Lu <lulu@redhat.com> =
wrote:
> > > > >
> > > > > When using VDPA device, we should verify whether the MAC address =
in the
> > > > > hardware matches the MAC address from the QEMU command line. If n=
ot,
> > > > > we will need to update the related information.
> > > > >
> > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > >
> > > > This seems to be a workaround, for example it means the mac address
> > > > set from the qemu command line has the higher priority compared to =
the
> > > > one that is provisioned by the host?
> > > >
> > > > At least we need to have a warning here?
> > > >
> > > In this design, the MAC address from the host will take higher
> > > priority over the MAC address from the command line. I'm not sure if
> > > this is acceptable?
> >
> > That's fine but it seems not what I read for this patch?
> >
> > As you try to set config, or anything I missed here?
> >
> > Thanks
> >
> yes I use   vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&net=
cfg,
>  ETH_ALEN); to get the mac  from hardware and copy it
> to n->nic_conf.macaddr and n->mac
>   memcpy(&n->nic_conf.macaddr, &netcfg.mac, sizeof(MACAddr));
>   memcpy(&n->mac[0], &netcfg.mac, sizeof(MACAddr));
> qemu will use this information for the following steps

I think we need to explain:

1) why do we need a get_config in realization, or what happens if we
don't do that. (AFAIK we will call get_config when a guest is trying
to read the config space).
2) why do we need a set_config, what happens if we don't do that.

Thanks

>
> Thanks
> cindy
>
> > > sure, will add some warning here
> > > > Thanks
> > > >
> > > > > ---
> > > > >  hw/net/virtio-net.c | 15 +++++++++++----
> > > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > > index 9c7e85caea..db04331b82 100644
> > > > > --- a/hw/net/virtio-net.c
> > > > > +++ b/hw/net/virtio-net.c
> > > > > @@ -3739,10 +3739,17 @@ static void virtio_net_device_realize(Dev=
iceState *dev, Error **errp)
> > > > >      nc->rxfilter_notify_enabled =3D 1;
> > > > >
> > > > >     if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER=
_VHOST_VDPA) {
> > > > > -        struct virtio_net_config netcfg =3D {};
> > > > > -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > > > > -        vhost_net_set_config(get_vhost_net(nc->peer),
> > > > > -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TY=
PE_FRONTEND);
> > > > > +     struct virtio_net_config netcfg =3D {};
> > > > > +     static const MACAddr zero =3D {.a =3D {0, 0, 0, 0, 0, 0}};
> > > > > +     vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&n=
etcfg,
> > > > > +                          ETH_ALEN);
> > > > > +     if ((memcmp(&netcfg.mac, &n->nic_conf.macaddr, sizeof(MACAd=
dr)) !=3D 0) &&
> > > > > +         memcmp(&netcfg.mac, &zero, sizeof(zero) !=3D 0)) {
> > > > > +       memcpy(&n->nic_conf.macaddr, &netcfg.mac, sizeof(MACAddr)=
);
> > > > > +       memcpy(&n->mac[0], &netcfg.mac, sizeof(MACAddr));
> > > > > +     }
> > > > > +     vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&n=
etcfg, 0,
> > > > > +                          ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTE=
ND);
> > > > >      }
> > > > >      QTAILQ_INIT(&n->rsc_chains);
> > > > >      n->qdev =3D dev;
> > > > > --
> > > > > 2.45.0
> > > > >
> > > >
> > >
> >
>


