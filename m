Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAE8C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbFV-0007Z3-Sx; Tue, 16 Jul 2024 02:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sTbFU-0007YY-0L
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sTbFK-0006OL-Pv
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721109664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCezvo/IWqfhQQZ8gqAJsIgy0jiUE88RwirGcIovuKY=;
 b=cD51274ULrvWEm+su3uEq8suxjMTuPeL4EBxi8aJh4E5E9UoDhkeMAWya9+8t95hKqkDPY
 PL5tll+IQqwjrOHHnTho0CvwDov+81Q5CAxzXuuro5nKDGvhj0SD4FyNdlOuMIb+ai2Bd4
 f6h71CvC7UK/Jr5AACkKSj9Kyopwp5k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-lUSlZ4-PPMWnh_AJA9qL8w-1; Tue, 16 Jul 2024 02:00:57 -0400
X-MC-Unique: lUSlZ4-PPMWnh_AJA9qL8w-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57d3eca4bb7so7426739a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 23:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721109656; x=1721714456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCezvo/IWqfhQQZ8gqAJsIgy0jiUE88RwirGcIovuKY=;
 b=VjPUeHcLO+bhXxuTGfuQaEMCA4hFlOsyioiutEWUeXDM7qHyWNrCvH8llLIc4uKnXB
 vah91XgSrjuK27lE8OU0v+NokDHonNFmAvQyTw6ptd2hp8ztuoK6gTXW+YnWJ3S2QdCV
 Q3HZ16ur/TGExn4QMRx3IcIuHusUfsBbztDRtNRwciUyGQfRj9hiXNUUzVDW8efuc9PF
 wvYneeltTzJG0e1BiuIR8IRGiSM2yiUWaD1p3TkKnDcYlz4qhnL1sfrOBQXYpgHQsF3s
 opHvSvhwt9YTIzKGaLGOAgASPF8lwP5onnu3odvMuImLoCO8EUXulP+/2IteKBdKZ3lT
 SV6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB4d4K2QuqPDn/Rt02DrUmdf1VBlf+8HCcDMn56+uQOesMG+vEfll7PIZyYZo40BhbDKYnNcz9DF/tLxH/ghjb3bWFf+U=
X-Gm-Message-State: AOJu0Yynqj6hu+VushtpbH9nMxk+/it/9+g97EdUXgnwnNRvRk9pWGe8
 6+T3dg7eEs5n+xAQH7XeQ5B6OASevBeB/QruaNLZK+ZxN1xUbC7AG4d4pLiCtBFV2xRC8KNXjzV
 YYlib/EMGkmXcZLnqD5YYhuo/WqTicFONs+uJMENVogvGVSAcX7QAu8uy3U+BbmNGKTaW1n2TMv
 sk8+JIJhKxjZ1dJK13YXS3UKvqx7E+xEv7McU=
X-Received: by 2002:a50:9ea3:0:b0:59c:1314:c3ae with SMTP id
 4fb4d7f45d1cf-59f0b10ac97mr546899a12.10.1721109655781; 
 Mon, 15 Jul 2024 23:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGUJJx9p6ngz14y27cL4E1JX4kq1lUnL0E1ilLllp89+53J8aichx7vik41Axs9V/Ixuop9vRQW2tm1JGX6IA=
X-Received: by 2002:a50:9ea3:0:b0:59c:1314:c3ae with SMTP id
 4fb4d7f45d1cf-59f0b10ac97mr546872a12.10.1721109655386; Mon, 15 Jul 2024
 23:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240716011349.821777-1-lulu@redhat.com>
 <CAPpAL=xKRjtAYPW9+sVfqnKR=ZOiThh+=XVEQb_aokD1WGKgAA@mail.gmail.com>
In-Reply-To: <CAPpAL=xKRjtAYPW9+sVfqnKR=ZOiThh+=XVEQb_aokD1WGKgAA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 16 Jul 2024 14:00:16 +0800
Message-ID: <CACLfguX7+e2_cbNcSET_kqkQvuB91drkG2Qw51Wr0Vm1tBu08g@mail.gmail.com>
Subject: Re: [RFC v2] virtio-net: check the mac address for vdpa device
To: Lei Yang <leiyang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
 netdev@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 16 Jul 2024 at 09:56, Lei Yang <leiyang@redhat.com> wrote:
>
> Hi Cindy
>
> If needed, QE can help test this MR before merging into the master branch=
.
>
> Best Regards
> Lei
>
sure=EF=BC=8C Really thanks for your help
thanks
cindy
>
> On Tue, Jul 16, 2024 at 9:14=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > When using a VDPA device, it is important to ensure that the MAC addres=
s
> > in the hardware matches the MAC address from the QEMU command line.
> >
> > There are only two acceptable situations:
> > 1. The hardware MAC address is the same as the MAC address specified in=
 the QEMU
> > command line, and both MAC addresses are not 0.
> > 2. The hardware MAC address is not 0, and the MAC address in the QEMU c=
ommand line is 0.
> > In this situation, the hardware MAC address will overwrite the QEMU com=
mand line address.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/virtio-net.c | 43 +++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 37 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 9c7e85caea..8f79785f59 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -178,8 +178,8 @@ static void virtio_net_get_config(VirtIODevice *vde=
v, uint8_t *config)
> >           * correctly elsewhere - just not reported by the device.
> >           */
> >          if (memcmp(&netcfg.mac, &zero, sizeof(zero)) =3D=3D 0) {
> > -            info_report("Zero hardware mac address detected. Ignoring.=
");
> > -            memcpy(netcfg.mac, n->mac, ETH_ALEN);
> > +          error_report("Zero hardware mac address detected in vdpa dev=
ice. "
> > +                       "please check the vdpa device!");
> >          }
> >
> >          netcfg.status |=3D virtio_tswap16(vdev,
> > @@ -3579,12 +3579,42 @@ static bool failover_hide_primary_device(Device=
Listener *listener,
> >      /* failover_primary_hidden is set during feature negotiation */
> >      return qatomic_read(&n->failover_primary_hidden);
> >  }
> > +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n=
,
> > +                                      MACAddr *cmdline_mac, Error **er=
rp) {
> > +  struct virtio_net_config hwcfg =3D {};
> > +  static const MACAddr zero =3D {.a =3D {0, 0, 0, 0, 0, 0}};
> >
> > +  vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, ETH=
_ALEN);
> > +
> > +  /* For VDPA device: Only two situations are acceptable:
> > +   * 1.The hardware MAC address is the same as the QEMU command line M=
AC
> > +   *   address, and both of them are not 0.
> > +   * 2.The hardware MAC address is NOT 0, and the QEMU command line MA=
C address
> > +   *   is 0. In this situation, the hardware MAC address will overwrit=
e the QEMU
> > +   *   command line address.
> > +   */
> > +
> > +  if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> > +    if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0) ||
> > +        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0)) {
> > +      /* overwrite the mac address with hardware address*/
> > +      memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
> > +      memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
> > +
> > +      return true;
> > +    }
> > +  }
> > +  error_setg(errp, "vdpa hardware mac !=3D the mac address from "
> > +                   "qemu cmdline, please check the the vdpa device's s=
etting.");
> > +
> > +  return false;
> > +}
> >  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      VirtIONet *n =3D VIRTIO_NET(dev);
> >      NetClientState *nc;
> > +    MACAddr macaddr_cmdline;
> >      int i;
> >
> >      if (n->net_conf.mtu) {
> > @@ -3692,6 +3722,7 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
> >      virtio_net_add_queue(n, 0);
> >
> >      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> > +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
> >      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
> >      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> >      n->status =3D VIRTIO_NET_S_LINK_UP;
> > @@ -3739,10 +3770,10 @@ static void virtio_net_device_realize(DeviceSta=
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
> > +     if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp)) {
> > +       virtio_cleanup(vdev);
> > +       return;
> > +     }
> >      }
> >      QTAILQ_INIT(&n->rsc_chains);
> >      n->qdev =3D dev;
> > --
> > 2.45.0
> >
> >
>


