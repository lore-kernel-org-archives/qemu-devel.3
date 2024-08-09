Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F505C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLje-0006dx-6L; Fri, 09 Aug 2024 05:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1scLjc-0006V0-2S
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1scLja-0006lf-Ee
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723194989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1ApWBqj+s1ATNLFL8vyzUdDs9cShLwal7Wrp0HnO1Y=;
 b=IqfyjVCY2ZO3w8YlZZGKAJWLjPxJqQL/DI6hs4l28qJ4Q64DJcpBQkBPfIZmmDs/X+3iv6
 30bE0Kbwm0ufx6SA352HZPi4jSz9iEzUHBLXlMOPQNv+7rQ9jckuyCTO2sLHcJDYAjN1kb
 zHiOO1wKCPJ84cOhexOR36Y+b5AcKf0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Tp5vTHl2PSerWc5RpprRXg-1; Fri, 09 Aug 2024 05:16:28 -0400
X-MC-Unique: Tp5vTHl2PSerWc5RpprRXg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5b77228abf9so1403104a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 02:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723194987; x=1723799787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X1ApWBqj+s1ATNLFL8vyzUdDs9cShLwal7Wrp0HnO1Y=;
 b=altmnbYxyLlP7Dd5i8jGSo9qBIZUM1FR86XpCv56oxKcdcxo+3Pd+I3N7XXDRyQGE4
 6/P6ie/73CB/2lrKvldHjEk2qFvM08Vnc7mJYwJycuym3WcXtF1g6Dcvf/o5XurGxwKj
 7HSBY/sW8tm8bwDbpceB03WRHuo7ntiIHDsw8rW3brqzC9ZxOxNTML1efilzN3pgliGK
 XABZsDXVhX0zn1GbgGm0PDZi5sQI4FUfeJWx1jNenNg450jqagJipdUslGlHvmxi3K3M
 CdARuXzwVabra5w6/PKz0rLaVUtyq8mbYc67ptzFcJTcco1+d+XTqr96XCguXAkcvAPW
 N1Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCU27q6FXOZ4LyVNGzxjJQMxEohL6Km71NDp3kuNri9lqjkgnKVgGoSyXWGhDmWCCEq1tZcSgKsi3FL4caCbIPYlwPfgSQU=
X-Gm-Message-State: AOJu0YwlCPkcb34IMPs/o546SyEMyT9GJ77NkdrVDT8Q0t4lygRx5sGz
 7f8Ip6XYB2vvOFkvsVFpxs1BlZ2qMREVRXSuH7KqzpoRARA4MVvJvxEW5w96j+neADMOlwXqa2t
 V1vuzbN8oVhjHxz9CvQzvJeM8ekAjRiIfr0fL/t6yEqHK+wh5iiZoZz/Dy/c9SSZ724wOCTx42Z
 HaJGZbvhnO9oiV+OqDe7rtYqxxaX0=
X-Received: by 2002:a17:907:7f8c:b0:a7d:c9c6:a692 with SMTP id
 a640c23a62f3a-a80aa67afb6mr81790466b.51.1723194986951; 
 Fri, 09 Aug 2024 02:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeZO7lhdtQ+GX6Xjej9rrgYJmLbRF1g0D//KLEIaEel8WYJ99tO1uVde7e3K08qx8WC+5lWw0TkWL+drHLsbQ=
X-Received: by 2002:a17:907:7f8c:b0:a7d:c9c6:a692 with SMTP id
 a640c23a62f3a-a80aa67afb6mr81789066b.51.1723194986438; Fri, 09 Aug 2024
 02:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240806005814.51651-1-lulu@redhat.com>
 <20240806093013-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240806093013-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 9 Aug 2024 17:15:48 +0800
Message-ID: <CACLfguUeCLmFVmGgQj_nEOJOuKAkbx+LMmMHOmty0sbkB+LVYw@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio_net: Add the check for vdpa's mac address
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Tue, 6 Aug 2024 at 21:30, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Aug 06, 2024 at 08:58:01AM +0800, Cindy Lu wrote:
> > When using a VDPA device, it is important to ensure that
> > the MAC address in the hardware matches the MAC address
> > from the QEMU command line.
> > This will allow the device to boot.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Always post threads with a cover letter please.
>
Sure,will fix  this
thanks
cindy
>
> > ---
> >  hw/net/virtio-net.c | 33 +++++++++++++++++++++++++++++----
> >  1 file changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 9c7e85caea..7f51bd0dd3 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3579,12 +3579,36 @@ static bool failover_hide_primary_device(DeviceListener *listener,
> >      /* failover_primary_hidden is set during feature negotiation */
> >      return qatomic_read(&n->failover_primary_hidden);
> >  }
> > +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n, MACAddr *cmdline_mac,
> > +                                   Error **errp)
> > +{
> > +     struct virtio_net_config hwcfg = {};
> > +     static const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
> > +
> > +     vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, ETH_ALEN);
> > +
> > +    /*
> > +     * For VDPA device: Only two situations are acceptable:
> > +     * 1.The hardware MAC address is the same as the QEMU command line MAC
> > +     *   address, and both of them are not 0.
> > +     */
> > +
> > +     if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) != 0) {
> > +             if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) == 0)) {
> > +                     return true;
> > +             }
> > +     }
> > +     error_setg(errp, "vDPA device's mac != the mac address from qemu cmdline"
> > +                      "Please check the the vdpa device's setting.");
> >
> > +     return false;
> > +}
> >  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> >  {
> >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >      VirtIONet *n = VIRTIO_NET(dev);
> >      NetClientState *nc;
> > +    MACAddr macaddr_cmdline;
> >      int i;
> >
> >      if (n->net_conf.mtu) {
> > @@ -3692,6 +3716,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> >      virtio_net_add_queue(n, 0);
> >
> >      n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> > +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
> >      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
> >      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> >      n->status = VIRTIO_NET_S_LINK_UP;
> > @@ -3739,10 +3764,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> >      nc->rxfilter_notify_enabled = 1;
> >
> >     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > -        struct virtio_net_config netcfg = {};
> > -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > -        vhost_net_set_config(get_vhost_net(nc->peer),
> > -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
> > +        if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp)) {
> > +                virtio_cleanup(vdev);
> > +                return;
> > +        }
> >      }
> >      QTAILQ_INIT(&n->rsc_chains);
> >      n->qdev = dev;
> > --
> > 2.45.0
>


