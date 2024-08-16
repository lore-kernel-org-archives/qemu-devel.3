Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21266C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serVh-0000Ad-Kc; Fri, 16 Aug 2024 03:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1serVe-0008R0-FN
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1serVc-0005m3-JF
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723793787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQgrKftoTowdd7gG6RAmNXc8eGVx01z0Sw15sk9xzDg=;
 b=RxlLnAhOj8Q+2qQojATsAZ7sob8Mc/QlpRjiapqWAPGHuIW+QUTvDZRJzmj0+tc62Ps4VT
 a8IdEZstVuGBudmqQ+Rj41VjklZUvMk4Hr4IzKBJwy2ShLOpC6aUOCC3eFntDvKoL7B05J
 vKQWXkL4qP3yIHW2jU377q0WqGjQVx0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-l8GZyS_6NWenul4R7VKAqw-1; Fri, 16 Aug 2024 03:36:21 -0400
X-MC-Unique: l8GZyS_6NWenul4R7VKAqw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5a2d4fb1e73so1383622a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723793780; x=1724398580;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQgrKftoTowdd7gG6RAmNXc8eGVx01z0Sw15sk9xzDg=;
 b=BnF1nErwIhexo8R4CXqmcYKnFMh13Xr0VK6NXyeWLiCVQMUP3EnqdFGXSv8D7EKKVe
 rKP2mu9AZ7ksd1RZuUsmlcGX5XaVf1KZW7cZYTL/TVOTncBunM/eBOVq3iVv6+ot/oy4
 tf2h4SlarTTzoeTE6Ju4axc6X4ziGG7SI4QfWhx06/+Kvyg3dmiKxVAMkfOqqr4ZAGqP
 Mc/88QdVXIU4BMa4QNrwriJsj23TAHarfKBSlCM2kfGdaF1QBDlfMB62KFU7a8qr7dPI
 n5W99Dwr/oS4BeBxFlN8s3fAPkATfmQMPwV2yXVYYQXTwOText7Lr09g2rBslhw2dnwp
 BOig==
X-Gm-Message-State: AOJu0YwggDS/RdAsCxg8xBYncb5PyzhG1zWzELfIUlDMc/AHPMyasGgL
 Jco+cmhYvU8+4A0tquRVaXYM9HVyhgi68KTU4n69LSp2j8UDs/MIkOArIqMQ8RVBv091ODTY/1e
 cGgbq9SF4p7X14cRHJ5IySt/88mLxEcFQe4DoV8Wof0apfE4NU6MX
X-Received: by 2002:aa7:d288:0:b0:58b:fd23:7065 with SMTP id
 4fb4d7f45d1cf-5beca593154mr1087586a12.16.1723793779715; 
 Fri, 16 Aug 2024 00:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOoxCv7H8cKpupuArMkrX0xvOnyQQI6eH6YgDKDuSU8s+aTt4a5oxS9Eac1M3lp6KmZ83TLQ==
X-Received: by 2002:aa7:d288:0:b0:58b:fd23:7065 with SMTP id
 4fb4d7f45d1cf-5beca593154mr1087564a12.16.1723793778892; 
 Fri, 16 Aug 2024 00:36:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:3378:6322:e9ee:713:b9ed])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbe7f952sm1865744a12.70.2024.08.16.00.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 00:36:18 -0700 (PDT)
Date: Fri, 16 Aug 2024 03:36:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zuoboqun <zuoboqun@baidu.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost_net: configure all host notifiers in a single MR
 transaction
Message-ID: <20240816033545-mutt-send-email-mst@kernel.org>
References: <20240816070835.8309-1-zuoboqun@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816070835.8309-1-zuoboqun@baidu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 16, 2024 at 03:08:35PM +0800, zuoboqun wrote:
> This allows the vhost_net device which has multiple virtqueues to batch
> the setup of all its host notifiers. This significantly reduces the
> vhost_net device starting and stoping time, e.g. the time spend
> on enabling notifiers reduce from 630ms to 75ms and the time spend on
> disabling notifiers reduce from 441ms to 45ms for a VM with 192 vCPUs
> and 15 vhost-user-net devices (64vq per device) in our case.
> 
> Signed-off-by: zuoboqun <zuoboqun@baidu.com>

Looks good, tagged for past the release.

> ---
>  hw/net/vhost_net.c        | 155 +++++++++++++++++++++++++++++++++++---
>  hw/virtio/vhost.c         |   6 +-
>  include/hw/virtio/vhost.h |   4 +
>  3 files changed, 150 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index a788e6937e..28a9aca1a7 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -160,6 +160,135 @@ void vhost_net_save_acked_features(NetClientState *nc)
>  #endif
>  }
>  
> +static void vhost_net_disable_notifiers_nvhosts(VirtIODevice *dev,
> +                NetClientState *ncs, int data_queue_pairs, int nvhosts)
> +{
> +    VirtIONet *n = VIRTIO_NET(dev);
> +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
> +    struct vhost_net *net;
> +    struct vhost_dev *hdev;
> +    int r, i, j;
> +    NetClientState *peer;
> +
> +    /*
> +     * Batch all the host notifiers in a single transaction to avoid
> +     * quadratic time complexity in address_space_update_ioeventfds().
> +     */
> +    memory_region_transaction_begin();
> +
> +    for (i = 0; i < nvhosts; i++) {
> +        if (i < data_queue_pairs) {
> +            peer = qemu_get_peer(ncs, i);
> +        } else {
> +            peer = qemu_get_peer(ncs, n->max_queue_pairs);
> +        }
> +
> +        net = get_vhost_net(peer);
> +        hdev = &net->dev;
> +        for (j = 0; j < hdev->nvqs; j++) {
> +            r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
> +                                             hdev->vq_index + j,
> +                                             false);
> +            if (r < 0) {
> +                error_report("vhost %d VQ %d notifier cleanup failed: %d",
> +                              i, j, -r);
> +            }
> +            assert(r >= 0);
> +        }
> +    }
> +    /*
> +     * The transaction expects the ioeventfds to be open when it
> +     * commits. Do it now, before the cleanup loop.
> +     */
> +    memory_region_transaction_commit();
> +
> +    for (i = 0; i < nvhosts; i++) {
> +        if (i < data_queue_pairs) {
> +            peer = qemu_get_peer(ncs, i);
> +        } else {
> +            peer = qemu_get_peer(ncs, n->max_queue_pairs);
> +        }
> +
> +        net = get_vhost_net(peer);
> +        hdev = &net->dev;
> +        for (j = 0; j < hdev->nvqs; j++) {
> +            virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus),
> +                                             hdev->vq_index + j);
> +        }
> +        virtio_device_release_ioeventfd(dev);
> +    }
> +}
> +
> +static int vhost_net_enable_notifiers(VirtIODevice *dev,
> +                NetClientState *ncs, int data_queue_pairs, int cvq)
> +{
> +    VirtIONet *n = VIRTIO_NET(dev);
> +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
> +    int nvhosts = data_queue_pairs + cvq;
> +    struct vhost_net *net;
> +    struct vhost_dev *hdev;
> +    int r, i, j;
> +    NetClientState *peer;
> +
> +    /*
> +     * Batch all the host notifiers in a single transaction to avoid
> +     * quadratic time complexity in address_space_update_ioeventfds().
> +     */
> +    memory_region_transaction_begin();
> +
> +    for (i = 0; i < nvhosts; i++) {
> +        if (i < data_queue_pairs) {
> +            peer = qemu_get_peer(ncs, i);
> +        } else {
> +            peer = qemu_get_peer(ncs, n->max_queue_pairs);
> +        }
> +
> +        net = get_vhost_net(peer);
> +        hdev = &net->dev;
> +        /*
> +         * We will pass the notifiers to the kernel, make sure that QEMU
> +         * doesn't interfere.
> +         */
> +        r = virtio_device_grab_ioeventfd(dev);
> +        if (r < 0) {
> +            error_report("binding does not support host notifiers");
> +            memory_region_transaction_commit();
> +            goto fail_nvhosts;
> +        }
> +
> +        for (j = 0; j < hdev->nvqs; j++) {
> +            r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
> +                                             hdev->vq_index + j,
> +                                             true);
> +            if (r < 0) {
> +                error_report("vhost %d VQ %d notifier binding failed: %d",
> +                              i, j, -r);
> +                memory_region_transaction_commit();
> +                vhost_dev_disable_notifiers_nvqs(hdev, dev, j);
> +                goto fail_nvhosts;
> +            }
> +        }
> +    }
> +
> +    memory_region_transaction_commit();
> +
> +    return 0;
> +fail_nvhosts:
> +    vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs, i);
> +    return r;
> +}
> +
> +/*
> + * Stop processing guest IO notifications in qemu.
> + * Start processing them in vhost in kernel.
> + */
> +static void vhost_net_disable_notifiers(VirtIODevice *dev,
> +                NetClientState *ncs, int data_queue_pairs, int cvq)
> +{
> +    vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs,
> +                                        data_queue_pairs + cvq);
> +}
> +
>  static int vhost_net_get_fd(NetClientState *backend)
>  {
>      switch (backend->info->type) {
> @@ -270,11 +399,6 @@ static int vhost_net_start_one(struct vhost_net *net,
>          }
>      }
>  
> -    r = vhost_dev_enable_notifiers(&net->dev, dev);
> -    if (r < 0) {
> -        goto fail_notifiers;
> -    }
> -
>      r = vhost_dev_start(&net->dev, dev, false);
>      if (r < 0) {
>          goto fail_start;
> @@ -326,8 +450,6 @@ fail:
>      }
>      vhost_dev_stop(&net->dev, dev, false);
>  fail_start:
> -    vhost_dev_disable_notifiers(&net->dev, dev);
> -fail_notifiers:
>      return r;
>  }
>  
> @@ -349,7 +471,6 @@ static void vhost_net_stop_one(struct vhost_net *net,
>      if (net->nc->info->stop) {
>          net->nc->info->stop(net->nc);
>      }
> -    vhost_dev_disable_notifiers(&net->dev, dev);
>  }
>  
>  int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
> @@ -394,10 +515,16 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
>          }
>       }
>  
> +    r = vhost_net_enable_notifiers(dev, ncs, data_queue_pairs, cvq);
> +    if (r < 0) {
> +        error_report("Error enabling host notifiers: %d", -r);
> +        goto err;
> +    }
> +
>      r = k->set_guest_notifiers(qbus->parent, total_notifiers, true);
>      if (r < 0) {
>          error_report("Error binding guest notifier: %d", -r);
> -        goto err;
> +        goto err_host_notifiers;
>      }
>  
>      for (i = 0; i < nvhosts; i++) {
> @@ -412,19 +539,19 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
>              r = vhost_set_vring_enable(peer, peer->vring_enable);
>  
>              if (r < 0) {
> -                goto err_start;
> +                goto err_guest_notifiers;
>              }
>          }
>  
>          r = vhost_net_start_one(get_vhost_net(peer), dev);
>          if (r < 0) {
> -            goto err_start;
> +            goto err_guest_notifiers;
>          }
>      }
>  
>      return 0;
>  
> -err_start:
> +err_guest_notifiers:
>      while (--i >= 0) {
>          peer = qemu_get_peer(ncs, i < data_queue_pairs ?
>                                    i : n->max_queue_pairs);
> @@ -435,6 +562,8 @@ err_start:
>          fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", e);
>          fflush(stderr);
>      }
> +err_host_notifiers:
> +    vhost_net_disable_notifiers(dev, ncs, data_queue_pairs, cvq);
>  err:
>      return r;
>  }
> @@ -466,6 +595,8 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
>          fflush(stderr);
>      }
>      assert(r >= 0);
> +
> +    vhost_net_disable_notifiers(dev, ncs, data_queue_pairs, cvq);
>  }
>  
>  void vhost_net_cleanup(struct vhost_net *net)
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 06fc71746e..7c5ef81b55 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1682,9 +1682,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>      memset(hdev, 0, sizeof(struct vhost_dev));
>  }
>  
> -static void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
> -                                             VirtIODevice *vdev,
> -                                             unsigned int nvqs)
> +void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
> +                                      VirtIODevice *vdev,
> +                                      unsigned int nvqs)
>  {
>      BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
>      int i, r;
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index d75faf46e9..c75be46c06 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -171,6 +171,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>   */
>  void vhost_dev_cleanup(struct vhost_dev *hdev);
>  
> +void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
> +                                      VirtIODevice *vdev,
> +                                      unsigned int nvqs);
> +
>  /**
>   * vhost_dev_enable_notifiers() - enable event notifiers
>   * @hdev: common vhost_dev structure
> -- 
> 2.42.0.windows.2


