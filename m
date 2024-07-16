Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4210DC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbNe-0008Pn-Cn; Tue, 16 Jul 2024 02:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sTbNd-0008PK-9O
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sTbNb-0007yn-HW
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721110178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xCr4QOjbNAwVm0SUrjDdp3DhYqZ+zdG0bqY4x9ewhOo=;
 b=L+DWnORYqU72mavqbFA4x2SlkETEuGsP5MJhl0iCODM8ndhKat/ljRUvqYBRWsADRk6cuc
 4wsk1mmMMQYR/G/s7lQ3yOebUXf7eSGQndM3eytBNfKT493g5qgkudmFS+nAqzVzVW7Hqb
 giFZSS9F2IHMfOZEJ5zbmPlmBCYzPzE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-NgTg2YA2NJWiYVkA7Kh9gA-1; Tue, 16 Jul 2024 02:09:36 -0400
X-MC-Unique: NgTg2YA2NJWiYVkA7Kh9gA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ee91ac534bso51140601fa.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 23:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721110175; x=1721714975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCr4QOjbNAwVm0SUrjDdp3DhYqZ+zdG0bqY4x9ewhOo=;
 b=VPiAt+wwHEnnklUUH2vJxEZDDArSfO/kCY5cNGsBoE6N1ScgskRFPgXbihQaZcB/4s
 y9SIU9c0zNY4k70T9Xy8rcPFIIAJ39GRMvSdnFJOXF0MMkv8qqeH7jJJ3FAn5bjRvr2v
 Hk3IFkzoXgziwg62rNi3J6QbiVSzly6k954B5Z59nREdU1hGMeigWbweVFOCUcbmujeE
 oQ1HTjHG9WoCIy+vxxfrHOh59u5bAF/FYdBa5N82Ai5D/fV9KaTuAqOH9nKIWV4Jt3vU
 o/SX/JGVeZQmvs4ljF8IPZpGnQKoQTYJ4ZXd03aCmrI0BFF028rSVVOdwbfCHII4lPU0
 aTYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxsBS42bodVotlmZE9DMRnQRmiPhsqXkY8Jnt78dgy2kAGeVd9BoBBYUm+xl9p9q0jNXmku79Qqsx7km0TyEIsIDcYoMs=
X-Gm-Message-State: AOJu0YzVlBSCYPN7srHD9LhvRjI2dGy6kilZGbnCOANmHPErS9RlcG/0
 atR7kYjr/V0iBWQmuAngS0ZyQOF/kPWKoG0JT4tCcZzUqvnaS/yGbuB/7H/pFnjjFLs0vS1VA2p
 g69W0nYGvE+FLXbU6Ti3dlfMn/HIJQFJqaKcjJdFJn9jpLoesKOVe2xAq+syWIHWc0SO/nsE/wb
 pP6azL6dx/1yQJPwlQXDotmj5LFVk=
X-Received: by 2002:a2e:b38c:0:b0:2ee:7d37:498b with SMTP id
 38308e7fff4ca-2eef418cd81mr6651581fa.14.1721110175118; 
 Mon, 15 Jul 2024 23:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAwB3Rv5ly/janPFIozApu/7U95oDRWNxGH0c41tnTHx8NkeJK2tCxW6JunUGE3Zz5VJTKLyho/ALVAoDUrj4=
X-Received: by 2002:a2e:b38c:0:b0:2ee:7d37:498b with SMTP id
 38308e7fff4ca-2eef418cd81mr6651301fa.14.1721110174638; Mon, 15 Jul 2024
 23:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240716011349.821777-1-lulu@redhat.com>
 <CACGkMEszp7U-x7UeBy6vSGv0Hox8YBD0nmWK=DNpfx7F5xGZYw@mail.gmail.com>
In-Reply-To: <CACGkMEszp7U-x7UeBy6vSGv0Hox8YBD0nmWK=DNpfx7F5xGZYw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 16 Jul 2024 14:08:56 +0800
Message-ID: <CACLfguXNyp1iM+FnxVTrLRntcNxhHpfciE=z6nhhBtWYRFSy9w@mail.gmail.com>
Subject: Re: [RFC v2] virtio-net: check the mac address for vdpa device
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 16 Jul 2024 at 13:37, Jason Wang <jasowang@redhat.com> wrote:
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
>
> If this patch tries to do the above two, I'd suggest splitting it into
> two patches.
>
This code is very simple. So I have put these two into one function.
thanks
cindy
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
>
> I had two questions:
>
> 1) any reason to do this check while the guest is running?
> 2) I think we need a workaround for this, unless I miss something.
>
this is a code change to adjust the new fix. If the mac address is 0
the guest should fail
to load. Maybe I can just assert fail here?
Thanks
cindy
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
> > +   *   is 0.
>
> Did you mean -device virtio-net-pci,macaddr=3D0 ? Or you mean mac
> address is not specified in the qemu command line?
>
yes, what I mean is mac address not specified, sorry for the confusion,
I will rewrite this part
Thanks
cindy

> > In this situation, the hardware MAC address will overwrite the QEMU
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
>
> Thanks
>


