Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF35C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIbM-00086T-U8; Mon, 01 Jul 2024 11:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOIbL-00083w-39
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOIbI-0002y2-Qh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719846351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UCFKGTjyGzH1yB11pItitgP9hgvzMFjW6AIon4oZDiE=;
 b=Zz0rBHHYRncPqRx7bJkTLyKLpUJFF0HtwZbVwL8LrBjWbJz31qvRrLV7JmttqDMo4Zd9pk
 dMzJKo5vN0rUrhIPcDn+UqfGsvcu4Rcv64c/wJvz2ErUWouHBV9zr+pFBVrLyzJ6Ve7GQ0
 lRMKehF5kgydb37eu5LbZizWgy6QtWg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-ou_adOR8NqirrC-kjx8OvQ-1; Mon, 01 Jul 2024 11:05:50 -0400
X-MC-Unique: ou_adOR8NqirrC-kjx8OvQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ee49ce152eso29406211fa.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846349; x=1720451149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCFKGTjyGzH1yB11pItitgP9hgvzMFjW6AIon4oZDiE=;
 b=HUb1QAmPVWYXGWoNDxa5nY0MpTZT9/5D1OjnDQTPMShdwxgYRoOuCI8A3IlWtTkT15
 BGm+QWj/qT+STlD45e0jo/6u1iVYmxkVZYv7eRuImCR6ObJtz+XrdBaApC2pSOeR5dlV
 RHMikCLDOj44rDibDu4PRxR6rij9CvTvyJZVwiEIvLFoa8bD+uBg8tsSVg2LyLvyGBK3
 yAKTbiji4WAlTgb5ZUCpaohv2/liGzggx0jUgwZNdgPj1oNibG/3KSO6BD7GIMjtPcY6
 JSmO2it81uTG/x8OuZWqxb2Ywf+s/uF7B+A2cnLKvfT++iHUcsr7iBl0uovj5q/CrC2M
 Jl8w==
X-Gm-Message-State: AOJu0Yz+bMamzAfG9WVg1wbbhdI5Y75vNugVmkfiKBadrk0hXyz+6Xqk
 xaEO+37in0NPI9kiWYqXt04PG4+qY8piZ1Ah0fcrfd8HSF2iXyjA3DoxZc6+DBoen4V8FWxPw75
 WXlodRB4+cRKPnUy7V9qhFdcB8QAw9ZQpRovYswkJF24/5GTpFUVX
X-Received: by 2002:a2e:8687:0:b0:2ec:4d48:75f3 with SMTP id
 38308e7fff4ca-2ee5e6f4bb6mr35107171fa.45.1719846348870; 
 Mon, 01 Jul 2024 08:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAlFAE2gzfo/RoF3PP0plroGdyaDCgmcyfJCW/d4M4bu69J2z43vAVRxffkAPr+4IIKFLXvQ==
X-Received: by 2002:a2e:8687:0:b0:2ec:4d48:75f3 with SMTP id
 38308e7fff4ca-2ee5e6f4bb6mr35106811fa.45.1719846347996; 
 Mon, 01 Jul 2024 08:05:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:614d:9fb:6fdd:72a4:f3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a073sm156554575e9.32.2024.07.01.08.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 08:05:47 -0700 (PDT)
Date: Mon, 1 Jul 2024 11:05:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, qemu-stable@nongnu.org
Subject: Re: [PATCH v7] virtio-net: Fix network stall at the host side
 waiting for kick
Message-ID: <20240701105110-mutt-send-email-mst@kernel.org>
References: <20240701140017.49223-1-east.moutain.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701140017.49223-1-east.moutain.yang@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Jul 01, 2024 at 10:00:17PM +0800, Wencheng Yang wrote:
> From: thomas <east.moutain.yang@gmail.com>
> 
> Patch 06b12970174 ("virtio-net: fix network stall under load")
> added double-check to test whether the available buffer size
> can satisfy the request or not, in case the guest has added
> some buffers to the avail ring simultaneously after the first
> check. It will be lucky if the available buffer size becomes
> okay after the double-check, then the host can send the packet
> to the guest. If the buffer size still can't satisfy the request,
> even if the guest has added some buffers, viritio-net would
> stall at the host side forever.
> 
> The patch checks whether the guest has added some buffers
> after last check of avail idx when the available buffers are
> not sufficient, if so then recheck the available buffers
> in the loop.
> 
> The patch also reverts patch "06b12970174".
> 
> The case below can reproduce the stall.
> 
>                                        Guest 0
>                                      +--------+
>                                      | iperf  |
>                     ---------------> | server |
>          Host       |                +--------+
>        +--------+   |                    ...
>        | iperf  |----
>        | client |----                  Guest n
>        +--------+   |                +--------+
>                     |                | iperf  |
>                     ---------------> | server |
>                                      +--------+
> 
> Boot many guests from qemu with virtio network:
>  qemu ... -netdev tap,id=net_x \
>     -device virtio-net-pci-non-transitional,\
>     iommu_platform=on,mac=xx:xx:xx:xx:xx:xx,netdev=net_x
> 
> Each guest acts as iperf server with commands below:
>  iperf3 -s -D -i 10 -p 8001
>  iperf3 -s -D -i 10 -p 8002
> 
> The host as iperf client:
>  iperf3 -c guest_IP -p 8001 -i 30 -w 256k -P 20 -t 40000
>  iperf3 -c guest_IP -p 8002 -i 30 -w 256k -P 20 -t 40000
> 
> After some time, the host loses connection to the guest,
> the guest can send packet to the host, but can't receive
> packet from host.
> 
> It's more likely to happen if SWIOTLB is enabled in the guest,
> allocating and freeing bounce buffer takes some CPU ticks,
> copying from/to bounce buffer takes more CPU ticks, compared
> with that there is no bounce buffer in the guest.
> Once the rate of producing packets from the host approximates
> the rate of receiveing packets in the guest, the guest would
> loop in NAPI.
> 
>          receive packets    ---
>                |             |
>                v             |
>            free buf      virtnet_poll
>                |             |
>                v             |
>      add buf to avail ring  ---
>                |
>                |  need kick the host?
>                |  NAPI continues
>                v
>          receive packets    ---
>                |             |
>                v             |
>            free buf      virtnet_poll
>                |             |
>                v             |
>      add buf to avail ring  ---
>                |
>                v
>               ...           ...
> 
> On the other hand, the host fetches free buf from avail
> ring, if the buf in the avail ring is not enough, the
> host notifies the guest the event by writing the avail
> idx read from avail ring to the event idx of used ring,
> then the host goes to sleep, waiting for the kick signal
> from the guest.
> 
> Once the guest finds the host is waiting for kick singal
> (in virtqueue_kick_prepare_split()), it kicks the host.
> 
> The host may stall forever at the sequences below:
> 
>          Host                        Guest
>      ------------                 -----------
>  fetch buf, send packet           receive packet ---
>          ...                          ...         |
>  fetch buf, send packet             add buf       |
>          ...                        add buf   virtnet_poll
>     buf not enough      avail idx-> add buf       |
>     read avail idx                  add buf       |
>                                     add buf      ---
>                                   receive packet ---
>     write event idx                   ...         |
>     wait for kick                   add buf   virtnet_poll
>                                       ...         |
>                                                  ---
>                                  no more packet, exit NAPI
> 
> In the first loop of NAPI above, indicated in the range of
> virtnet_poll above, the host is sending packets while the
> guest is receiving packets and adding buffers.
>  step 1: The buf is not enough, for example, a big packet
>          needs 5 buf, but the available buf count is 3.
>          The host read current avail idx.
>  step 2: The guest adds some buf, then checks whether the
>          host is waiting for kick signal, not at this time.
>          The used ring is not empty, the guest continues
>          the second loop of NAPI.
>  step 3: The host writes the avail idx read from avail
>          ring to used ring as event idx via
>          virtio_queue_set_notification(q->rx_vq, 1).
>  step 4: At the end of the second loop of NAPI, recheck
>          whether kick is needed, as the event idx in the
>          used ring written by the host is beyound the
>          range of kick condition, the guest will not
>          send kick signal to the host.
> 
> Fixes: 06b12970174 ("virtio-net: fix network stall under load")
> Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
> ---
> 
> Changelog:
> v7:
> - Add function virtio_queue_set_notification_and_check()
> - Restore the function sequence introduce in v6
> 
> v6:
> - Take packed packed queue into cosideration
> - Adjust function sequence to fix compilation issue
> 
> v5:
> - Modify return type of virtio_queue_set_notification() to
>   bool to indicate whether the guest has added some buffers
>   after last check of avail idx
> - Loop in virtio_net_has_buffers() if the available buffers
>   are not sufficient and the guest has added some buffers.
> - Revert patch "06b12970174"
> - Update the subject
> 
> v4:
> - Correct spelling mistake in the subject
> - Describe the issue that virtio-net is blocked at host side
> 
> v3:
> - Add virtio-net tag in the subject
> - Refine commit log
> 
> v2:
> - Add SOB tag at the end of the commit message
> - Place Fixes tag at the end of the commit message
> 
> v1:
> - Initial patch
> 
>  hw/net/virtio-net.c        | 19 ++++++++-----------
>  hw/virtio/virtio.c         | 39 ++++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio.h |  1 +
>  3 files changed, 48 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9c7e85caea..357c651d9b 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1642,18 +1642,15 @@ static bool virtio_net_can_receive(NetClientState *nc)
>  static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
>  {
>      VirtIONet *n = q->n;
> -    if (virtio_queue_empty(q->rx_vq) ||
> -        (n->mergeable_rx_bufs &&
> -         !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> -        virtio_queue_set_notification(q->rx_vq, 1);
> -
> -        /* To avoid a race condition where the guest has made some buffers
> -         * available after the above check but before notification was
> -         * enabled, check for available buffers again.
> -         */
> -        if (virtio_queue_empty(q->rx_vq) ||
> +
> +    while (virtio_queue_empty(q->rx_vq) ||
>              (n->mergeable_rx_bufs &&
> -             !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> +            !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> +        /* guest may have made some buf, try again */
> +        if (virtio_queue_set_notification_and_check(q->rx_vq, 1)) {
> +            virtio_queue_set_notification(q->rx_vq, 0);
> +            continue;
> +        } else {
>              return 0;
>          }
>      }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..b165764017 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -668,6 +668,45 @@ static inline bool is_desc_avail(uint16_t flags, bool wrap_counter)
>      return (avail != used) && (avail == wrap_counter);
>  }
>  
> +bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enable)
> +{
> +    uint16_t shadow_idx;
> +    VRingPackedDesc desc;
> +    VRingMemoryRegionCaches *caches;
> +
> +    vq->notification = enable;
> +
> +    if (!vq->vring.desc) {
> +        return false;
> +    }
> +
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        virtio_queue_packed_set_notification(vq, enable);
> +
> +        if (enable) {
> +            caches = vring_get_region_caches(vq);
> +            if (!caches) {
> +                return false;
> +            }
> +
> +            vring_packed_desc_read(vq->vdev, &desc, &caches->desc,
> +                                   vq->shadow_avail_idx, true);
> +            if (is_desc_avail(desc.flags, vq->shadow_avail_wrap_counter)) {
> +                return true;
> +            }
> +        }
> +    } else {
> +        shadow_idx = vq->shadow_avail_idx;
> +        virtio_queue_split_set_notification(vq, enable);
> +
> +        if (enable) {
> +            return shadow_idx != vring_avail_idx(vq);
> +        }
> +    }
> +
> +    return false;
> +}

Please document what this does.
So this will return false if ring has any availabe buffers?
Equivalent to:

bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enable)
{
        virtio_queue_packed_set_notification(vq, enable);
	return virtio_queue_empty(vq);
}


or am I missing something?

> +
>  /* Fetch avail_idx from VQ memory only when we really need to know if
>   * guest has added some buffers.
>   * Called within rcu_read_lock().  */
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7d5ffdc145..ed85023b87 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -302,6 +302,7 @@ void virtio_notify_config(VirtIODevice *vdev);
>  
>  bool virtio_queue_get_notification(VirtQueue *vq);
>  void virtio_queue_set_notification(VirtQueue *vq, int enable);
> +bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enable);
>  
>  int virtio_queue_ready(VirtQueue *vq);
>  
> -- 
> 2.39.0


