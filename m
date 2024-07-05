Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F684C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfyv-0002zF-L1; Fri, 05 Jul 2024 06:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPfym-0002tn-0d
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPfyi-0002ZU-Je
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720174542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ycs9ATVtTKNEltaFjxPk1iwIj+bKWanOCjb/GEd+7hg=;
 b=bZQHGDIMhetEDEdKOPkDuXsKs1JluUA03kZdi6S63AIbU8ZYt6nvm4qSKm3sq+smPCexry
 cWQBSAHJi0qBP1ZeX7OcR1UXS2Ls+8Vx+UQx1J3luHdywBungVRKyK/bRju67xFMPVBdiM
 x7HBoF17gaZNVDSUcDGllILUjPqxVT4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-r4s8DxVSNIyXqehulyyzIA-1; Fri, 05 Jul 2024 06:15:41 -0400
X-MC-Unique: r4s8DxVSNIyXqehulyyzIA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42568f0cc18so10315725e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720174540; x=1720779340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ycs9ATVtTKNEltaFjxPk1iwIj+bKWanOCjb/GEd+7hg=;
 b=DF2aJVirESyNJDpB+3QRpSDXLFfhXehYvAlLUUU5GeahV1iRF6o2smhUifZMCEK/CL
 tvLlhjsIMdGOyHXrFZr7jVt+xqkJz9Efs2uzFbHIPTU06hoyhT8w3osMdBNtUGAb/iUO
 1Og0q48vGQcW5Kjd+CKYvcTeHWVpEivZJTWliQaUt1XGuOnb25vm57Ezs5zEfWHYJwhT
 wDZFS/e4YE9XPoZ85OZgfvfE69bkFXcteYT3ZkaliEzhe1YTFeciYshvv5LQ9YEFWn0C
 S6thfjupEB1VZX4IDuCkQtDgpNf4wFym+hFESSkTYrEH7umdU73lDhDOriSlR1sl55HG
 14Xg==
X-Gm-Message-State: AOJu0Yy+jXu2Qni847nHLU6JOMTNdf8eg8wSBtEb15uwLN5qv6v7BPgs
 wmNUcURw3ZSZTl8PbNIAoVpsFsHTELIiqM6fzOos+hfeOfdgXqLvYQBiFOqWTaEBXxau1PoE/bc
 Mxgw66WC9EQoaf56+P5tFOR6SAJDxSTs9FHrKD9KwkM1Y73BtI8iz
X-Received: by 2002:a5d:5188:0:b0:367:892a:b32 with SMTP id
 ffacd0b85a97d-367a068b252mr2548636f8f.60.1720174540154; 
 Fri, 05 Jul 2024 03:15:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEHvDok8NKlogoN1qEPN8n1grvNVMWTgNGRrV3MD3V3gcOzr4i8xgQQZ3w1OwqQMgrqGSVfw==
X-Received: by 2002:a5d:5188:0:b0:367:892a:b32 with SMTP id
 ffacd0b85a97d-367a068b252mr2548607f8f.60.1720174539429; 
 Fri, 05 Jul 2024 03:15:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a13b61f7sm3033673f8f.13.2024.07.05.03.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 03:15:38 -0700 (PDT)
Date: Fri, 5 Jul 2024 06:15:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, stefanha@redhat.com,
 hreitz@redhat.com, qemu-stable@nongnu.org
Subject: Re: [PATCH v8] virtio-net: Fix network stall at the host side
 waiting for kick
Message-ID: <20240705061423-mutt-send-email-mst@kernel.org>
References: <20240705100502.4112-1-east.moutain.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705100502.4112-1-east.moutain.yang@gmail.com>
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

On Fri, Jul 05, 2024 at 06:05:02PM +0800, Wencheng Yang wrote:
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
> The patch enables notification and checks whether the guest has
> added some buffers since last check of available buffers when
> the available buffers are insufficient. If no buffer is added,
> return false, else recheck the available buffers in the loop.
> If the available buffers are sufficient, disable notification
> and return true.
> 
> Changes:
> 1. Change the return type of virtqueue_get_avail_bytes() from void
>    to int, let it return the shadow_avail_idx of the virtqueue
>    on success.
> 2. Add a new API: virtio_queue_enable_notification_and_check(),
>    it takes the return value of virtqueue_get_avail_bytes() as
>    input arg, enables notification firstly, then checks whether
>    the guest has added some buffers or not since last check of
>    available buffers, return ture if yes.
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
> packet from the host.
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
> Changelog:
> v8:
> - Change virtqueue_get_avail_bytes() return type from void
>   to int, it returns shadow_avail_idx on success.
> - virtio_queue_set_notification_and_check() accepts two args,
>   the second arg is the shadow idx retruned from
>   virtqueue_get_avail_bytes()
> - Add function virtio_queue_poll(), it accepts shadow idx
>   returned from virtqueue_get_avail_bytes() as the second
>   arg, and tells whether guest had add some buffers since
>   last check of available buffers.
> 
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
>  hw/net/virtio-net.c        | 34 +++++++++++++++--------
>  hw/virtio/virtio.c         | 56 ++++++++++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio.h | 12 ++++++--
>  3 files changed, 85 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9c7e85caea..a652aa3a16 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1641,24 +1641,34 @@ static bool virtio_net_can_receive(NetClientState *nc)
>  
>  static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
>  {
> +    int shadow_idx;
> +    unsigned int in_bytes;
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
> -            (n->mergeable_rx_bufs &&
> -             !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> +
> +    while (virtio_queue_empty(q->rx_vq) || n->mergeable_rx_bufs) {
> +        shadow_idx = virtqueue_get_avail_bytes(q->rx_vq, &in_bytes, NULL,
> +                                               bufsize, 0);
> +        /* invalid shadow idx */
> +        if (shadow_idx < 0) {
> +            return 0;
> +        }

wait does not this mean you have disabled notification on
error? and previously we enabled it, did we not?
cleaner to have virtio_queue_enable_notification_and_check
handle the value <0 internally, no?

> +
> +        /* buffer is enough, disable notifiaction */
> +        if (bufsize <= in_bytes) {
> +            break;
> +        }
> +
> +        if (virtio_queue_enable_notification_and_check(q->rx_vq,
> +                                                       (unsigned)shadow_idx)) {
> +            /* guest has added some buffers, try again */
> +            continue;
> +        } else {
>              return 0;
>          }
>      }
>  
>      virtio_queue_set_notification(q->rx_vq, 0);
> +
>      return 1;
>  }
>  
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..d04f4d9b2e 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -745,6 +745,56 @@ int virtio_queue_empty(VirtQueue *vq)
>      }
>  }
>  
> +static bool virtio_queue_split_poll(VirtQueue *vq, unsigned shadow_idx)
> +{
> +    if (unlikely(!vq->vring.avail)) {
> +        return false;
> +    }
> +
> +    return (uint16_t)shadow_idx != vring_avail_idx(vq);
> +}
> +
> +static bool virtio_queue_packed_poll(VirtQueue *vq, unsigned shadow_idx)
> +{
> +    VRingPackedDesc desc;
> +    VRingMemoryRegionCaches *caches;
> +
> +    if (unlikely(!vq->vring.desc)) {
> +        return false;
> +    }
> +
> +    caches = vring_get_region_caches(vq);
> +    if (!caches) {
> +        return false;
> +    }
> +
> +    vring_packed_desc_read(vq->vdev, &desc, &caches->desc,
> +                           shadow_idx, true);
> +
> +    return is_desc_avail(desc.flags, vq->shadow_avail_wrap_counter);
> +}
> +
> +static bool virtio_queue_poll(VirtQueue *vq, unsigned shadow_idx)
> +{
> +    if (virtio_device_disabled(vq->vdev)) {
> +        return false;
> +    }
> +
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        return virtio_queue_packed_poll(vq, shadow_idx);
> +    } else {
> +        return virtio_queue_split_poll(vq, shadow_idx);
> +    }
> +}
> +
> +bool virtio_queue_enable_notification_and_check(VirtQueue *vq,
> +                                                unsigned shadow_idx)
> +{
> +    virtio_queue_set_notification(vq, 1);
> +
> +    return virtio_queue_poll(vq, shadow_idx);
> +}
> +
>  static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *elem,
>                                 unsigned int len)
>  {
> @@ -1332,7 +1382,7 @@ err:
>      goto done;
>  }
>  
> -void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
> +int virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
>                                 unsigned int *out_bytes,
>                                 unsigned max_in_bytes, unsigned max_out_bytes)
>  {
> @@ -1367,7 +1417,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
>                                          caches);
>      }
>  
> -    return;
> +    return (int)vq->shadow_avail_idx;
>  err:
>      if (in_bytes) {
>          *in_bytes = 0;
> @@ -1375,6 +1425,8 @@ err:
>      if (out_bytes) {
>          *out_bytes = 0;
>      }
> +
> +    return -1;
>  }
>  
>  int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7d5ffdc145..c4ce7b544e 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -271,9 +271,9 @@ void qemu_put_virtqueue_element(VirtIODevice *vdev, QEMUFile *f,
>                                  VirtQueueElement *elem);
>  int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
>                            unsigned int out_bytes);
> -void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
> -                               unsigned int *out_bytes,
> -                               unsigned max_in_bytes, unsigned max_out_bytes);
> +int virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
> +                              unsigned int *out_bytes, unsigned max_in_bytes,
> +                              unsigned max_out_bytes);
>  
>  void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq);
>  void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
> @@ -307,6 +307,12 @@ int virtio_queue_ready(VirtQueue *vq);
>  
>  int virtio_queue_empty(VirtQueue *vq);
>  
> +/**
> + * enable notification and check whether guest has added some
> + * buffers since last sync of shadow_avail_idx from the queue
> + */
> +bool virtio_queue_enable_notification_and_check(VirtQueue *vq,
> +                                                unsigned shadow_idx);
>  /* Host binding interface.  */
>  
>  uint32_t virtio_config_readb(VirtIODevice *vdev, uint32_t addr);
> -- 
> 2.39.0


