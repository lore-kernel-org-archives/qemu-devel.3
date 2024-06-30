Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FB1C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 16:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNxgD-0003yV-7F; Sun, 30 Jun 2024 12:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sNxfv-0003xF-Qi
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 12:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sNxfq-0006v2-ST
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 12:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719765908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bvRQKlvEV9uRtvAgYfrpbTquzXPqDjI6qhgeqqD78JU=;
 b=L3Tg1INa98BB9aU9xRSHfM9trXiQMXaf5YuVvndF4FKTo8zy4lfE5lsN0cDrA3bkE08JfM
 Q64weRN7GxiGT/wGYvx/yJr4hwef9NHqR33K4F4FkQ5RsReQu52NGxFI0adUfvvx1uazxR
 2Q3H2JL4mBh249oI9EnNSDFdc+6Or2M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-2oMvYWNHPJ2vPGY7im-VYQ-1; Sun, 30 Jun 2024 12:45:04 -0400
X-MC-Unique: 2oMvYWNHPJ2vPGY7im-VYQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ec617f8b6fso19679001fa.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 09:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719765903; x=1720370703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvRQKlvEV9uRtvAgYfrpbTquzXPqDjI6qhgeqqD78JU=;
 b=Q9SP3Sdr4KSvC4+NOWnvbGC6x6eIvPg7jZfBfDU78WRzaqxqOMDA3GfHCqiOITfj+e
 Jie3pg2biJTxy7ZOlY0THZm2yjm0O0+7ZeCtZo7N0CpQ61qzl5YigSVZ9rt1ni/qQGT8
 0StCJG5s/uqEOsqlKuAOpTZOhU7w3DdJA3PxVV8HI4cnHTp5w0B2i5mc44ZdelaFEQVs
 /wRy3eYJvmeoYMPS8N60jYW3hojPJx2/5oNEd3stJJUF3GYevagyuuX/DHYvMfrJSXQT
 fN+q9OVw6i5M8B0/XtwyES7+98RBy6RQeLUZEymhvold67M8+E0tPXLEwFUUnQEni6D4
 dsoA==
X-Gm-Message-State: AOJu0Yx+Rvb960CAOeP4oV6OLxa4xkyTQ8Jj8uoIkj/SaO1sKrk0QLye
 BCfyVD2PMYj0J7aMG7VYQmxlSGLAwht1BSx8sAupJkm1izoCpXYx9+GUsFggYZFFvbyjkQVvo0C
 lTp6vZ0PVScNSsm7cukGeRGs08iXOC1HdPsECnYuqyf2rRDsMWk4T
X-Received: by 2002:a05:6512:3d18:b0:52c:86d7:fa62 with SMTP id
 2adb3069b0e04-52e82661c77mr2546981e87.23.1719765903255; 
 Sun, 30 Jun 2024 09:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmITfH1McVF3aoe6Shcpdehtl+XUTvrAIllEagiqu65MYMo8FC/8wqQ1JTURj+dUV0MtZHTQ==
X-Received: by 2002:a05:6512:3d18:b0:52c:86d7:fa62 with SMTP id
 2adb3069b0e04-52e82661c77mr2546962e87.23.1719765902442; 
 Sun, 30 Jun 2024 09:45:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:7728:cff8:104f:5265:699])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b626sm115667065e9.15.2024.06.30.09.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 09:45:01 -0700 (PDT)
Date: Sun, 30 Jun 2024 12:44:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, qemu-stable@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6] virtio-net: Fix network stall at the host side
 waiting for kick
Message-ID: <20240630123044-mutt-send-email-mst@kernel.org>
References: <20240630063615.40467-1-east.moutain.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630063615.40467-1-east.moutain.yang@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Thanks for the patch!
Yes something to improve:


On Sun, Jun 30, 2024 at 02:36:15PM +0800, Wencheng Yang wrote:
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
>     waiting for kick                 add buf   virtnet_poll
>                                       ...         |
>                                                  ---
>                                  no more packet, exit NAPI
> 
> In the first loop of NAPI above, indicated in the range of
> virtnet_poll above, the host is sending packets while the
> guest is receiving packets and adding buf.
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

Put changelog after --- please.

> Changelog:
> v6:
> - Take packed queue into cosideration
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
> Fixes: 06b12970174 ("virtio-net: fix network stall under load")
> Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
> ---
>  hw/net/virtio-net.c        |  19 ++---
>  hw/virtio/virtio.c         | 157 ++++++++++++++++++++-----------------
>  include/hw/virtio/virtio.h |   2 +-
>  3 files changed, 96 insertions(+), 82 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9c7e85caea..13affc1f35 100644
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
> +        if (virtio_queue_set_notification(q->rx_vq, 1)) {
> +            virtio_queue_set_notification(q->rx_vq, 0);
> +            continue;
> +        } else {
>              return 0;
>          }
>      }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..24eaf4d88d 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -507,76 +507,6 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
>      address_space_cache_invalidate(&caches->used, pa, sizeof(val));
>  }
>  
> -static void virtio_queue_split_set_notification(VirtQueue *vq, int enable)
> -{
> -    RCU_READ_LOCK_GUARD();
> -
> -    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> -        vring_set_avail_event(vq, vring_avail_idx(vq));
> -    } else if (enable) {
> -        vring_used_flags_unset_bit(vq, VRING_USED_F_NO_NOTIFY);
> -    } else {
> -        vring_used_flags_set_bit(vq, VRING_USED_F_NO_NOTIFY);
> -    }
> -    if (enable) {
> -        /* Expose avail event/used flags before caller checks the avail idx. */
> -        smp_mb();
> -    }
> -}
> -
> -static void virtio_queue_packed_set_notification(VirtQueue *vq, int enable)
> -{
> -    uint16_t off_wrap;
> -    VRingPackedDescEvent e;
> -    VRingMemoryRegionCaches *caches;
> -
> -    RCU_READ_LOCK_GUARD();
> -    caches = vring_get_region_caches(vq);
> -    if (!caches) {
> -        return;
> -    }
> -
> -    vring_packed_event_read(vq->vdev, &caches->used, &e);
> -
> -    if (!enable) {
> -        e.flags = VRING_PACKED_EVENT_FLAG_DISABLE;
> -    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> -        off_wrap = vq->shadow_avail_idx | vq->shadow_avail_wrap_counter << 15;
> -        vring_packed_off_wrap_write(vq->vdev, &caches->used, off_wrap);
> -        /* Make sure off_wrap is wrote before flags */
> -        smp_wmb();
> -        e.flags = VRING_PACKED_EVENT_FLAG_DESC;
> -    } else {
> -        e.flags = VRING_PACKED_EVENT_FLAG_ENABLE;
> -    }
> -
> -    vring_packed_flags_write(vq->vdev, &caches->used, e.flags);
> -    if (enable) {
> -        /* Expose avail event/used flags before caller checks the avail idx. */
> -        smp_mb();
> -    }
> -}
> -
> -bool virtio_queue_get_notification(VirtQueue *vq)
> -{
> -    return vq->notification;
> -}
> -
> -void virtio_queue_set_notification(VirtQueue *vq, int enable)
> -{
> -    vq->notification = enable;
> -
> -    if (!vq->vring.desc) {
> -        return;
> -    }
> -
> -    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> -        virtio_queue_packed_set_notification(vq, enable);
> -    } else {
> -        virtio_queue_split_set_notification(vq, enable);
> -    }
> -}
> -
>  int virtio_queue_ready(VirtQueue *vq)
>  {
>      return vq->vring.avail != 0;
> @@ -668,6 +598,93 @@ static inline bool is_desc_avail(uint16_t flags, bool wrap_counter)
>      return (avail != used) && (avail == wrap_counter);
>  }
>  
> +static bool virtio_queue_split_set_notification(VirtQueue *vq, int enable)
> +{
> +    uint16_t shadow_idx;
> +
> +    RCU_READ_LOCK_GUARD();
> +
> +    shadow_idx = vq->shadow_avail_idx;
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> +        vring_set_avail_event(vq, vring_avail_idx(vq));
> +    } else if (enable) {
> +        vring_used_flags_unset_bit(vq, VRING_USED_F_NO_NOTIFY);
> +    } else {
> +        vring_used_flags_set_bit(vq, VRING_USED_F_NO_NOTIFY);
> +    }
> +    if (enable) {
> +        /* Expose avail event/used flags before caller checks the avail idx. */
> +        smp_mb();
> +
> +        /* If shadow_avail_idx is changed, guest has added some bufs */
> +        return shadow_idx != vring_avail_idx(vq);
> +    }
> +
> +    return false;
> +}
> +
> +static bool virtio_queue_packed_set_notification(VirtQueue *vq, int enable)
> +{
> +    uint16_t off_wrap;
> +    VRingPackedDesc desc;
> +    VRingPackedDescEvent e;
> +    VRingMemoryRegionCaches *caches;
> +
> +    RCU_READ_LOCK_GUARD();
> +    caches = vring_get_region_caches(vq);
> +    if (!caches) {
> +        return false;
> +    }
> +
> +    vring_packed_event_read(vq->vdev, &caches->used, &e);
> +
> +    if (!enable) {
> +        e.flags = VRING_PACKED_EVENT_FLAG_DISABLE;
> +    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> +        off_wrap = vq->shadow_avail_idx | vq->shadow_avail_wrap_counter << 15;
> +        vring_packed_off_wrap_write(vq->vdev, &caches->used, off_wrap);
> +        /* Make sure off_wrap is wrote before flags */
> +        smp_wmb();
> +        e.flags = VRING_PACKED_EVENT_FLAG_DESC;
> +    } else {
> +        e.flags = VRING_PACKED_EVENT_FLAG_ENABLE;
> +    }
> +
> +    vring_packed_flags_write(vq->vdev, &caches->used, e.flags);
> +    if (enable) {
> +        /* Expose avail event/used flags before caller checks the avail idx. */
> +        smp_mb();
> +
> +        /* If shadow_avail_idx becomes available, guest has added some bufs */
> +        vring_packed_desc_read(vq->vdev, &desc, &caches->desc,
> +                               vq->shadow_avail_idx, true);
> +        if (is_desc_avail(desc.flags, vq->shadow_avail_wrap_counter))
> +            return true;
> +    }
> +
> +    return false;
> +}
> +
> +bool virtio_queue_get_notification(VirtQueue *vq)
> +{
> +    return vq->notification;
> +}
> +
> +bool virtio_queue_set_notification(VirtQueue *vq, int enable)
> +{
> +    vq->notification = enable;
> +
> +    if (!vq->vring.desc) {
> +        return false;
> +    }
> +
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        return virtio_queue_packed_set_notification(vq, enable);
> +    } else {
> +        return virtio_queue_split_set_notification(vq, enable);
> +    }
> +}
> +

I think that the patch would be much smaller if you just
added virtio_queue_set_notification_and_check.
This way you are also not slowing down existing users
of virtio_queue_set_notification.


Also, I went over users of virtio_queue_set_notification:
blk,scsi all look ok, but I found at least another buggy one:
virtio_ballloon_get_free_page_hints 



I also wonder about the users in virtio.c:

static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
{
    VirtQueue *vq = container_of(n, VirtQueue, host_notifier);

    /* Caller polls once more after this to catch requests that race with us */
    virtio_queue_set_notification(vq, 1);
}
    
void virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ctx)
{   
    /*  
     * virtio_queue_aio_detach_host_notifier() can leave notifications disabled.
     * Re-enable them.  (And if detach has not been used before, notifications
     * being enabled is still the default state while a notifier is attached;
     * see virtio_queue_host_notifier_aio_poll_end(), which will always leave
     * notifications enabled once the polling section is left.)
     */ 
    if (!virtio_queue_get_notification(vq)) {
        virtio_queue_set_notification(vq, 1);
    }

    aio_set_event_notifier(ctx, &vq->host_notifier,
                           virtio_queue_host_notifier_read,
                           virtio_queue_host_notifier_aio_poll,
                           virtio_queue_host_notifier_aio_poll_ready);
    aio_set_event_notifier_poll(ctx, &vq->host_notifier,
                                virtio_queue_host_notifier_aio_poll_begin,
                                virtio_queue_host_notifier_aio_poll_end);

    /*
     * We will have ignored notifications about new requests from the guest
     * while no notifiers were attached, so "kick" the virt queue to process
     * those requests now.
     */
    event_notifier_set(&vq->host_notifier);
}

void virtio_queue_aio_attach_host_notifier_no_poll(VirtQueue *vq, AioContext *ctx)
{
    /* See virtio_queue_aio_attach_host_notifier() */
    if (!virtio_queue_get_notification(vq)) {
        virtio_queue_set_notification(vq, 1);
    }

    aio_set_event_notifier(ctx, &vq->host_notifier,
                           virtio_queue_host_notifier_read,
                           NULL, NULL);

    /*
     * See virtio_queue_aio_attach_host_notifier().
     * Note that this may be unnecessary for the type of virtqueues this
     * function is used for.  Still, it will not hurt to have a quick look into
     * whether we can/should process any of the virtqueue elements.
     */
    event_notifier_set(&vq->host_notifier);
}



These three look fundamentally racy:

Cc people who touched this area.

Stefan, Kevin, what do you guys think?


>  /* Fetch avail_idx from VQ memory only when we really need to know if
>   * guest has added some buffers.
>   * Called within rcu_read_lock().  */
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7d5ffdc145..e1a1621e2d 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -301,7 +301,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id);
>  void virtio_notify_config(VirtIODevice *vdev);
>  
>  bool virtio_queue_get_notification(VirtQueue *vq);
> -void virtio_queue_set_notification(VirtQueue *vq, int enable);
> +bool virtio_queue_set_notification(VirtQueue *vq, int enable);
>  
>  int virtio_queue_ready(VirtQueue *vq);
>  
> -- 
> 2.39.0


