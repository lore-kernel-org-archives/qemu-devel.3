Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2E2CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 06:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrY1u-0000kG-T6; Tue, 02 Apr 2024 02:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rrY1s-0000jk-Fv
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rrY1q-00053C-N4
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712040832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfLgYMXYib6ziqN0Bk7/PkGpEoPfFrTFtid+pAgHGX0=;
 b=CJb2xnPUlftkNi3bb5w/vwMnkYm/dp0EmdRXTUV+z+c4FVRU8DOLRCf6cReW4GfidP7RLA
 EXRE1I9LpGgU+5dmvv70Hghq/FFXLjhyLEvWyrs/HJOzlPzvv3vS6PuBhBpPEGmcNP1YsK
 EibNYrQHnawRQtPA6n5zSdIn1RA13b0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-SVpMS_K5NhymCZ7vktTfCA-1; Tue, 02 Apr 2024 02:53:51 -0400
X-MC-Unique: SVpMS_K5NhymCZ7vktTfCA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-414aa7bd274so23063495e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 23:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712040830; x=1712645630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfLgYMXYib6ziqN0Bk7/PkGpEoPfFrTFtid+pAgHGX0=;
 b=LqHNgD53n9bmuSzBQiNUhzKmC5DzVLI1vIqqtsUum4G/3efhG06Juehv/xZRL24+pZ
 ehIcW8Gd0oleZni9CSZfIPAr81ROE/w2+0dLuj50MBaOlQxaSEMmddEdz4LAr7u0Qo61
 QkenNQpwgM/KvCy1jTUWt/CieAYtV3A/Mx1wb46upn61ULxHNxaVqYRjWG5FYivVZHJj
 IgCHudR6Rnqbq33T4ktD1JoRmhpAytb5HqHyf8FDZ9R9e+Qu/HdKodx9GVfbxeviDsgf
 mFfz8TopvKiS/oikxwgpnXXU467Ps81syQD4Z9N7F/JVy5DhgBirq7yi5DLqPs5aL5mw
 SlRw==
X-Gm-Message-State: AOJu0Yz0PQ6/rTdlCRw3qtTv5k82THFM6x89Yd3q80aCE031ya58dMLt
 vjWTIbUv0M+WwgKjWtYzYpHx0wJwA2uUYhcAuvgGeh4r2ncQ/eseOI4EEiUwCT8zPrJqmQu0Efl
 IHiOYG9KKakvBhGoZJdG/GshOfEsMjQQJADn/UcL8fSXOKg7xApJh
X-Received: by 2002:a05:600c:35c5:b0:413:f4d0:c233 with SMTP id
 r5-20020a05600c35c500b00413f4d0c233mr7173692wmq.35.1712040830315; 
 Mon, 01 Apr 2024 23:53:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSiJDCbtLv4ANgwEXKDK+NGDyPHHtiZ/nHdP5zmwqow62dne7vyPmblKezTO8tMP70vu8TJQ==
X-Received: by 2002:a05:600c:35c5:b0:413:f4d0:c233 with SMTP id
 r5-20020a05600c35c500b00413f4d0c233mr7173676wmq.35.1712040829663; 
 Mon, 01 Apr 2024 23:53:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:2fbc:c1b6:60e7:b08c:a69d])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c154e00b00414674a1a40sm16800903wmg.45.2024.04.01.23.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 23:53:49 -0700 (PDT)
Date: Tue, 2 Apr 2024 02:53:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yajun Wu <yajunw@nvidia.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, maxime.coquelin@redhat.com,
 Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH] virtio-net: fix qemu set used ring flag even vhost started
Message-ID: <20240402025316-mutt-send-email-mst@kernel.org>
References: <20240402045109.97729-1-yajunw@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402045109.97729-1-yajunw@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Apr 02, 2024 at 12:51:09PM +0800, Yajun Wu wrote:
> When vhost-user or vhost-kernel is handling virtio net datapath, qemu
> should not touch used ring.
> 
> But with vhost-user socket reconnect scenario, in a very rare case (has
> pending kick event). VRING_USED_F_NO_NOTIFY is set by qemu in
> following code path:
> 
> 	#0  virtio_queue_split_set_notification (vq=0x7ff5f4c920a8, enable=0) at ../hw/virtio/virtio.c:511
> 	#1  0x0000559d6dbf033b in virtio_queue_set_notification (vq=0x7ff5f4c920a8, enable=0) at ../hw/virtio/virtio.c:576
> 	#2  0x0000559d6dbbbdbc in virtio_net_handle_tx_bh (vdev=0x559d703a6aa0, vq=0x7ff5f4c920a8) at ../hw/net/virtio-net.c:2801
> 	#3  0x0000559d6dbf4791 in virtio_queue_notify_vq (vq=0x7ff5f4c920a8) at ../hw/virtio/virtio.c:2248
> 	#4  0x0000559d6dbf79da in virtio_queue_host_notifier_read (n=0x7ff5f4c9211c) at ../hw/virtio/virtio.c:3525
> 	#5  0x0000559d6d9a5814 in virtio_bus_cleanup_host_notifier (bus=0x559d703a6a20, n=1) at ../hw/virtio/virtio-bus.c:321
> 	#6  0x0000559d6dbf83c9 in virtio_device_stop_ioeventfd_impl (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3774
> 	#7  0x0000559d6d9a55c8 in virtio_bus_stop_ioeventfd (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:259
> 	#8  0x0000559d6d9a53e8 in virtio_bus_grab_ioeventfd (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:199
> 	#9  0x0000559d6dbf841c in virtio_device_grab_ioeventfd (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3783
> 	#10 0x0000559d6d9bde18 in vhost_dev_enable_notifiers (hdev=0x559d707edd70, vdev=0x559d703a6aa0) at ../hw/virtio/vhost.c:1592
> 	#11 0x0000559d6d89a0b8 in vhost_net_start_one (net=0x559d707edd70, dev=0x559d703a6aa0) at ../hw/net/vhost_net.c:266
> 	#12 0x0000559d6d89a6df in vhost_net_start (dev=0x559d703a6aa0, ncs=0x559d7048d890, data_queue_pairs=31, cvq=0) at ../hw/net/vhost_net.c:412
> 	#13 0x0000559d6dbb5b89 in virtio_net_vhost_status (n=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:311
> 	#14 0x0000559d6dbb5e34 in virtio_net_set_status (vdev=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:392
> 	#15 0x0000559d6dbb60d8 in virtio_net_set_link_status (nc=0x559d7048d890) at ../hw/net/virtio-net.c:455
> 	#16 0x0000559d6da64863 in qmp_set_link (name=0x559d6f0b83d0 "hostnet1", up=true, errp=0x7ffdd76569f0) at ../net/net.c:1459
> 	#17 0x0000559d6da7226e in net_vhost_user_event (opaque=0x559d6f0b83d0, event=CHR_EVENT_OPENED) at ../net/vhost-user.c:301
> 	#18 0x0000559d6ddc7f63 in chr_be_event (s=0x559d6f2ffea0, event=CHR_EVENT_OPENED) at ../chardev/char.c:62
> 	#19 0x0000559d6ddc7fdc in qemu_chr_be_event (s=0x559d6f2ffea0, event=CHR_EVENT_OPENED) at ../chardev/char.c:82
> 
> This issue causes guest kernel stop kicking device and traffic stop.
> 
> Add vhost_started check in virtio_net_handle_tx_bh to fix this wrong
> VRING_USED_F_NO_NOTIFY set.
> 
> Signed-off-by: Yajun Wu <yajunw@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/net/virtio-net.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a6ff000cd9..8035e01fdf 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2865,6 +2865,10 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
>      VirtIONet *n = VIRTIO_NET(vdev);
>      VirtIONetQueue *q = &n->vqs[vq2q(virtio_get_queue_index(vq))];
>  
> +    if (n->vhost_started) {
> +        return;
> +    }
> +
>      if (unlikely((n->status & VIRTIO_NET_S_LINK_UP) == 0)) {
>          virtio_net_drop_tx_queue_data(vdev, vq);
>          return;
> -- 
> 2.27.0


