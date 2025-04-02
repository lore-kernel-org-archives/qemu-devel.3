Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE327C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 16:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0131-0000wT-IE; Wed, 02 Apr 2025 12:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u012u-0000uV-Tq
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u012t-0007k6-6y
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743611669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8qUN/rJOe4i6clAhR6DcT05Kj3wBL+CIVhZflKqWA0=;
 b=UGZJS15pIMA28KTDoeakK9H0KHztLTmXyCFJwohz0Mth9caAoh01zjaiDxsO2vZ+Oel4Ki
 zxAbyUiNHJOTjlKMF7yPmDN4tvvwm7F+nQbXMXNq1Z9CLhKrSgOS8TPJZOjTpiC5cCzAFo
 mOvgmB7mYhhFBFYr4SdiCSNURp7C6fA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-fg1_MFlSPuqWsj8WrBMcEA-1; Wed, 02 Apr 2025 12:34:27 -0400
X-MC-Unique: fg1_MFlSPuqWsj8WrBMcEA-1
X-Mimecast-MFC-AGG-ID: fg1_MFlSPuqWsj8WrBMcEA_1743611666
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912539665cso585689f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 09:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743611666; x=1744216466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8qUN/rJOe4i6clAhR6DcT05Kj3wBL+CIVhZflKqWA0=;
 b=Qqbkx5UhsdwcYG52lyuT5eV6qHO9n3oLn5Qmq5iRMyvWg/CcaCO9npBZSyF0ijMG93
 NDPIj2Pvf3QtneeqFO7vaF5MtS4yDwgw6fAuR6Lv8dk9TnkKf6BNaD8zhi6/Pp2I/W4U
 MhlcOb/zqFgDB+NwffyFiE7KqUqFHVONEQckxXpCKocywxiAgAOC65j351B8J2jVDNlB
 aCHiH4erMorCOT9jbXK7th1Be/pZxExoD9z2Iyjoy/YrIXZUdfu1/9Muknf5AxjUQiYF
 Z6Im+fH8NOn131TKbP8Jc81bnuo6waC5F4lRwo2T7u/2aDaZ7TCtZOXClapEIYdywRLe
 5WXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNo/sD7x2R2ZYCXqaTDbJ/bA5WZITxbX36vBNvwJinfxldfey21vnN7p3Fmvd8ztGYHgxxtS/JlJjm@nongnu.org
X-Gm-Message-State: AOJu0YxUyYR+w7MheqkAu52pOmj4bEgfE8ZN3R+Q3IIo5HDofXFqGNox
 1q3mUUe8CgvyTSOflqoxdTdsxe8Uq3+USgeexRJhGAcSASS6qFD13EbRxiOcFEzPcHD5AKi4UWV
 uKarda71VbWeeO9KZKdLT96V/Ba+EO3PMEmyc2rcEEd+26S++Rkl7
X-Gm-Gg: ASbGncuRu1gr3YZLXb7E9OPLkB1eXGU4SdyIFwFSbU9aCIJhKvgTc5FQygt1xMM70RT
 8I/1ApybhAJa584xLo4HHYTHVOgSVwskuabtOep2ntSbtGELWVCakx2j4jjURkPe4c3a2z1KI7K
 kja2uzp10YRGXSjOTvwwMWeYpum9dv76Xzvt4HQnv78czxGKNw5WGtzhXK1rrIOfYtUCq5/oacT
 Ge4gUNWmkgy2gfspU0X3VD88V7oq7iYf9y2m9YI0XexH96LmhG81l8N8+Ij7P5Up2PBI/hsdI7t
 Rt1OLryaLg==
X-Received: by 2002:a05:6000:4387:b0:391:2a79:a110 with SMTP id
 ffacd0b85a97d-39c2e637f56mr168444f8f.29.1743611666323; 
 Wed, 02 Apr 2025 09:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7muzYCjesFXXyRd/2qO506uYcDBV6+BtI7nbFiME/cAieNgNdWvZHHvknPtTBmblMoP9yBg==
X-Received: by 2002:a05:6000:4387:b0:391:2a79:a110 with SMTP id
 ffacd0b85a97d-39c2e637f56mr168429f8f.29.1743611665999; 
 Wed, 02 Apr 2025 09:34:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e304sm17527085f8f.73.2025.04.02.09.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 09:34:25 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:34:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 2/4] virtio_net: Add the check for vdpa's mac address
Message-ID: <20250402123150-mutt-send-email-mst@kernel.org>
References: <20250326132021.1215568-1-lulu@redhat.com>
 <20250326132021.1215568-3-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326132021.1215568-3-lulu@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Mar 26, 2025 at 09:19:31PM +0800, Cindy Lu wrote:
> When using a VDPA device, it is important to ensure that the MAC
> address is correctly set. The MAC address in the hardware should
> match the MAC address from the QEMU command line. This is a recommended
> configuration and will allow the system to boot.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index de87cfadff..a3b431e000 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3749,12 +3749,43 @@ static bool failover_hide_primary_device(DeviceListener *listener,
>      /* failover_primary_hidden is set during feature negotiation */
>      return qatomic_read(&n->failover_primary_hidden);
>  }
> +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
> +                                      MACAddr *cmdline_mac, Error **errp)
> +{
> +    struct virtio_net_config hwcfg = {};
> +    static const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
> +
> +    vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, ETH_ALEN);
> +
> +    /*For VDPA device following situations are acceptable:*/


/* This is how you format comments in QEMU */



/*Never like this*/

> +    if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) != 0) {
> +        /*
> +         * 1.The hardware MAC address is the same as the QEMU command line MAC

space after .

> +         *   address, and both of them are not 0.
> +         */
> +        if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) == 0)) {
> +            return true;
> +        }
> +    }
>  
> +    error_setg(errp,
> +               "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
> +               "not same with the cmdline's mac %02x:%02x:%02x:%02x:%02x:%02x,"

the same with the command line mac (avoid abbreviation)

> +               "Please check.",

space after , and no uppercase

> +               hwcfg.mac[0], hwcfg.mac[1], hwcfg.mac[2], hwcfg.mac[3],
> +               hwcfg.mac[4], hwcfg.mac[5], cmdline_mac->a[0], cmdline_mac->a[1],
> +               cmdline_mac->a[2], cmdline_mac->a[3], cmdline_mac->a[4],
> +               cmdline_mac->a[5]);


check what?  maybe "initialization failed"?

> +
> +    return false;
> +}
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VirtIONet *n = VIRTIO_NET(dev);
>      NetClientState *nc;
> +    MACAddr macaddr_cmdline;
>      int i;
>  
>      if (n->net_conf.mtu) {
> @@ -3862,6 +3893,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>      virtio_net_add_queue(n, 0);
>  
>      n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
>      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>      n->status = VIRTIO_NET_S_LINK_UP;
> @@ -3908,7 +3940,13 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>      nc = qemu_get_queue(n->nic);
>      nc->rxfilter_notify_enabled = 1;
>  
> -   if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> +    if (nc->peer && (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA)) {
> +        if (nc->peer->check_mac) {
> +            if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp)) {
> +                virtio_cleanup(vdev);
> +                return;
> +            }
> +        }
>          struct virtio_net_config netcfg = {};
>          memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
>          vhost_net_set_config(get_vhost_net(nc->peer),
> -- 
> 2.45.0


