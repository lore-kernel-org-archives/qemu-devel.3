Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965BFC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 09:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbGjt-000815-EN; Tue, 06 Aug 2024 05:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sbGjq-0007rP-Ol
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sbGjo-0004Pm-CM
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722937445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHPN7kw4eRSXzogWykEhxcX/hG8iQvyb2mAMDYVrLxQ=;
 b=TRHgSkApTBdI4pVn/Cbj7eeOzHqt9ZagOrZR9PKP8gUL+YPhpEgyJatiBFUzlvz13hUVhz
 8Aa+R8g2I/nvn6kCXiPOkkfwWwA2koEgYGYjhVN/ifKTSU+jmICFXibj4d20/mTQz/E9fe
 uXwhBf7+OAOMbUmtWyZVaziEdhaDjVU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-JwDBPrbZOFC2MTNP2JPGAA-1; Tue, 06 Aug 2024 05:44:03 -0400
X-MC-Unique: JwDBPrbZOFC2MTNP2JPGAA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5bb88479be6so558732a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 02:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722937442; x=1723542242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PHPN7kw4eRSXzogWykEhxcX/hG8iQvyb2mAMDYVrLxQ=;
 b=lvhSxR21+jztAF2ow7eHzaximqnH5TSnRQhxFKhH7HhmSY39+a4Y7Vh6KpiRuo9Liv
 GXkBXRYYtfz4TYWyRdEaFfz/jMa0bo8cbNhLPxk3X6pzyLEdACWawzRDISB+BtXO1pXM
 iyoTfD+yMWYknqr5NiGsFMr1e+YEglNvADCwxqGQIBnhdu1CqoMHAKPu7JjnmBCwV6JO
 6dqz+vkKbsPUNEnJnJmVWmB3ro2v5loL3x5Zllysq1F2D9Z0D4zi0vhredeoQ7wEvG5D
 Q/C4nI5jBfGqweaNqFdUJRaDJ5wsm+57T6/rBkuChZ79Fo25yyOCKv9Y/eu9tM5xKzZl
 CHHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgRIWCk554FeGNOm+YlimLpJTC6xHIeORsbYiFqrkuVBvuYrT5yc1v62TONYrtDjZv+l2vN7jnyOm88QY1smiGn29G8IE=
X-Gm-Message-State: AOJu0YxjFzW2q3V+Rk/pPH/viYxIvuiK/6GWt4TBF4dMcZKeiggsJc5L
 UpXo8VKgZ/YLhUlE/74WuRcZYF93geWDd9vDoyAZsOnmZZUUxVPGUyuI3eSx5Wl07ch4xtA7BS7
 LE/plKkXXNPWSw7L9qFRyogeOOCqP8komAYuYAetazUA5bAH5EmBTVHM3R3bNMcfAvdr4A4Fdou
 vzVFN5KQyQCI9MVc8taCTvdMlKe8I=
X-Received: by 2002:a05:6402:c08:b0:5b9:3846:8bab with SMTP id
 4fb4d7f45d1cf-5b938469427mr7876519a12.14.1722937442310; 
 Tue, 06 Aug 2024 02:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpEvIN7V+0+sife+UGRy4e1ef0xkq0c9X2aio8yzLizSgO+lDViAaX6/kIrYKA0egPBv79kGm3CWZ1T5Mz4YA=
X-Received: by 2002:a05:6402:c08:b0:5b9:3846:8bab with SMTP id
 4fb4d7f45d1cf-5b938469427mr7876499a12.14.1722937441819; Tue, 06 Aug 2024
 02:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240806005814.51651-1-lulu@redhat.com>
 <CACGkMEuCJT8KYsDgJaXzvy1Fhm6+tJinowdTtoAngsnvYjB54Q@mail.gmail.com>
In-Reply-To: <CACGkMEuCJT8KYsDgJaXzvy1Fhm6+tJinowdTtoAngsnvYjB54Q@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 6 Aug 2024 17:43:24 +0800
Message-ID: <CACLfguU47TPw5=GpS93AMWEYcy95JJ6+uG-PYpdmeD=hrKGa1Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio_net: Add the check for vdpa's mac address
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Tue, 6 Aug 2024 at 11:07, Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Aug 6, 2024 at 8:58=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > When using a VDPA device, it is important to ensure that
> > the MAC address in the hardware matches the MAC address
> > from the QEMU command line.
> > This will allow the device to boot.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/virtio-net.c | 33 +++++++++++++++++++++++++++++----
> >  1 file changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 9c7e85caea..7f51bd0dd3 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3579,12 +3579,36 @@ static bool failover_hide_primary_device(Device=
Listener *listener,
> >      /* failover_primary_hidden is set during feature negotiation */
> >      return qatomic_read(&n->failover_primary_hidden);
> >  }
> > +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n=
, MACAddr *cmdline_mac,
> > +                                     Error **errp)
> > +{
> > +       struct virtio_net_config hwcfg =3D {};
> > +       static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> > +
> > +       vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg=
, ETH_ALEN);
> > +
> > +    /*
> > +     * For VDPA device: Only two situations are acceptable:
> > +     * 1.The hardware MAC address is the same as the QEMU command line=
 MAC
> > +     *   address, and both of them are not 0.
>
> I guess there should be a bullet 2?
>
yes, there is a section 2, will change this code here
Thanks
cindy
> > +     */
> > +
> > +       if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> > +               if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =
=3D=3D 0)) {
> > +                       return true;
> > +               }
> > +       }
> > +       error_setg(errp, "vDPA device's mac !=3D the mac address from q=
emu cmdline"
> > +                        "Please check the the vdpa device's setting.")=
;
>
> For error messages I think it's better to use english instead of "!=3D"
> to describe the issue.
>
> >
> > +       return false;
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
> > @@ -3692,6 +3716,7 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
> >      virtio_net_add_queue(n, 0);
> >
> >      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> > +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
> >      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
> >      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> >      n->status =3D VIRTIO_NET_S_LINK_UP;
> > @@ -3739,10 +3764,10 @@ static void virtio_net_device_realize(DeviceSta=
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
> > +          if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp=
)) {
> > +                  virtio_cleanup(vdev);
> > +                  return;
> > +          }
>
> Any reason we remove vhost_net_set_config() here? It is not described
> in the commit or does it belong to another patch?
>
> Thanks
>
as we discussed before=EF=BC=8C the MAC address in hardware should have a
"higher priority"
than the MAC address in qemu cmdline. So I remove the set_config there,
the MAC address from the hardware will overwrite the MAC in qemu
cmdline. so don't need to set_config to hardware now
Thanks,
cindy
> >      }
> >      QTAILQ_INIT(&n->rsc_chains);
> >      n->qdev =3D dev;
> > --
> > 2.45.0
> >
>


