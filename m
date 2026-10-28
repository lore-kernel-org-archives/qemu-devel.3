Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667F606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W0Hc5+kC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=c0zTmvAa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3oP-0004ga-Fr; Wed, 28 Oct 2026 09:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM3oN-0004gI-Rf
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM3oL-0007ds-3J
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793194522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HH1VUpDKOYj79IOt3XAHcfmpgZ4OX1HPjHoVMpBEgB0=;
 b=W0Hc5+kCO0pVOMNbCxE6o0un0EPkEEWIN1HgpVzViT2KCwSINUmlr8EwNhzGpcsSnYA3os
 9mwvXEi+HUzqa8WnScc9Bjspxjdm8dDlugeW8TjaS2oFOotENMMGVvk1PFPsv4uJNumzVM
 MIvcy3NGIQpb/BnFh4YTqAde/OJkcPc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-287KKogfNhaYXnATyw-mKA-1; Wed, 28 Oct 2026 09:35:19 -0400
X-MC-Unique: 287KKogfNhaYXnATyw-mKA-1
X-Mimecast-MFC-AGG-ID: 287KKogfNhaYXnATyw-mKA_1793194518
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c3f8e149ccfso102885366b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793194518; x=1793799318; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HH1VUpDKOYj79IOt3XAHcfmpgZ4OX1HPjHoVMpBEgB0=;
 b=c0zTmvAazKadMxzm4RrLNYssvLHT/sOhJJz3pdCtFtcxa4vJBqZjF4zZxVOCN60cJl
 +bzGDPAQJDl//P57aYS+E0/OEkU0Ngs33aGA1mSIviyXk2NGi2/X+utNE9sDFIMxuHak
 nL0AVXKOvclWqb28iJe/hjtSoxsRoJr88bZDVwmN8OeXupjr0UsRdPUdEf7eJ/ap3C39
 +7a++i9e+7f5Tyo66PyOePeBa7Z4J3mf3rWyfHara1lrr0nxzfw0ZPicz+/if0hYrSjT
 7NhcGGs9e2Xwic4S9Nc8Q6HUGez5aqWSvdNhYCNugnWnaMp3+njinFW75ghqYIz/raQi
 h86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793194518; x=1793799318;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HH1VUpDKOYj79IOt3XAHcfmpgZ4OX1HPjHoVMpBEgB0=;
 b=sCGYNu8Wy9Eb/dh9UUEkuC2BtxoGsczq1N1qg+dYSZ4h4K67fptC4Dtt9fOjvbK7NS
 w+3pAwoN9SAjt5HgfVrf0IF+czh6zuhku1v5OWFEdv4hjPdTub0zyMTfMxnY+GTTSECi
 jdzeGQer4KnP4opJ/u2C/I7bpY6Mn3z+9Zb88Uc5G/X4is7qQW+9O5Ho72A3/VkLDeCZ
 FTqkoL6IKBgOhJg7JUbjcR3DVAXS4k6A0GaMNdt977Ei3llOdmBlpgY+94TApXdKs3Mr
 omFaeCe3pa7zZnx4eX95FnXePjdDq622pnprt95y/Q80PDF7gujZNMmHxqS3mRRjcALz
 Hrew==
X-Gm-Message-State: AFq9FYJJCULmbGBTiGRyQJSSovTxUFzvthT3D7vaFpPpIqpjsz5O8T+t
 8ToDYyXrthZiSnS5iS9D3uuDmCF62EprecjAkV22FwAB0lfMqYW8a1h/ZCdNQx5wreOxroki9oe
 lamzq9yFluGNRo6X6W5BYSz0z2VNCjI0j9UGAC7dpg8MYhe6ROR3xHPhn
X-Gm-Gg: AYBFou3ZLwhqWIx0tsHNmT8ghP5P6xq4yDxjXiTLrkucJqo+ykeZLZU4YZTLgqPxkPu
 YUB4/iZO0tUvDMTk5T68zookULMCnNrOBu3t1WlP5ZihXyBONJ09h6xmtdDV/7CsgtFoZ6H1QMS
 5YIqAfWIk3dhjvhiTiibqsNQG2neEPFCJpy1NO2SLEP0hInz1pM1ZNrra+agAwyG0+/nn4zS2Vs
 qFx65GiscngbDh8o0l0TEH1M/f4Fk+Hxo8xMOY9jZV8l2QScYNl1ovBYkyBrMr0+2jP4Vx1YaAV
 Ygm5QsqHZghxFdszmb+z5f5ooKXeg1ym3TNuZ0OKnl/jKR4doM4E2KMtjolXYqt5RNE1cq9/E5s
 UNhG4iV4poEdllxU8WMrPpRtXv7ERQVYuQhkX98X8
X-Received: by 2002:a17:907:3e06:b0:c46:a607:6922 with SMTP id
 a640c23a62f3a-c49bdf29082mr200538066b.25.1793194517807; 
 Wed, 28 Oct 2026 06:35:17 -0700 (PDT)
X-Received: by 2002:a17:907:3e06:b0:c46:a607:6922 with SMTP id
 a640c23a62f3a-c49bdf29082mr200534666b.25.1793194517083; 
 Wed, 28 Oct 2026 06:35:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd66bd15sm600971966b.55.2026.10.28.06.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:35:16 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:35:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v11 2/3] [PATCH 2/3] virtio-net: Add
 VIRTIO_NET_F_NOTF_COAL support
Message-ID: <20261028092722-mutt-send-email-mst@kernel.org>
References: <20261017192232.1545578-1-kdutta@redhat.com>
 <20261017192232.1545578-3-kdutta@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017192232.1545578-3-kdutta@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 18, 2026 at 12:52:31AM +0530, Koushik Dutta wrote:
> Implement notification coalescing to reduce interrupt overhead.
> Guests configure time-based (microseconds) or count-based (packets)
> coalescing via ethtool -C. Coalescing state is migrated via VMState
> for live migration support.
> 
>   Note: Coalescing is disabled when tx=timer is configured, as timer
>   mode already provides packet batching.
> 
>   Performance impact: 20% reduction in CPU overhead, 30% fewer interrupts
>   under moderate coalescing settings.
> 
> Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> ---
>  hw/net/virtio-net.c            | 199 ++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-net.h |  10 ++
>  net/passt.c                    |   1 +
>  net/tap.c                      |   1 +
>  net/vhost-user.c               |   1 +
>  net/vhost-vdpa.c               |   1 +
>  6 files changed, 209 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 5ca011f890..610cc2b580 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -158,6 +158,16 @@ static void flush_or_purge_queued_packets(NetClientState *nc)
>   * - we could suppress RX interrupt if we were so inclined.
>   */
>  
> +static void virtio_net_rx_notify(void *opaque)
> +{
> +    VirtIONetQueue *q = opaque;
> +    VirtIONet *n = q->n;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
> +
> +    q->rx_coal.pkt_cnt = 0;
> +    virtio_notify(vdev, q->rx_vq);
> +}
> +
>  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
>      VirtIONet *n = VIRTIO_NET(vdev);
> @@ -1003,6 +1013,90 @@ static void virtio_net_set_features(VirtIODevice *vdev,
>      }
>  }
>  
> +static void virtio_net_tx_notification_timer(void *opaque)
> +{
> +    VirtIONetQueue *q = opaque;
> +    VirtIONet *n = q->n;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
> +
> +    q->tx_coal.pkt_cnt = 0;
> +    virtio_notify(vdev, q->tx_vq);
> +}
> +
> +static bool virtio_net_tx_should_notify(VirtIONetQueue *q)
> +{
> +    if (!q->tx_coal.timer) {
> +        return true;
> +    }
> +
> +    q->tx_coal.pkt_cnt++;
> +
> +    if (q->tx_coal.packets > 0 && q->tx_coal.pkt_cnt >= q->tx_coal.packets) {
> +        q->tx_coal.pkt_cnt = 0;
> +        timer_del(q->tx_coal.timer);
> +        return true;
> +    }
> +
> +    if (!timer_pending(q->tx_coal.timer)) {
> +        timer_mod(q->tx_coal.timer,
> +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                  q->tx_coal.usecs * 1000);
> +    }
> +
> +    return false;
> +}
> +
> +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
> +                                  struct iovec *iov, unsigned int iov_cnt)
> +{
> +    struct virtio_net_ctrl_coal coal;
> +    VirtIONetQueue *q;
> +    size_t s;
> +    int i;
> +
> +    if (n->tx_timer_activate) {
> +        return VIRTIO_NET_ERR;
> +    }
> +
> +    s = iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
> +    if (s != sizeof(coal)) {
> +        return VIRTIO_NET_ERR;
> +    }
> +
> +    if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
> +        for (i = 0; i < n->max_queue_pairs; i++) {
> +            q = &n->vqs[i];
> +            q->rx_coal.usecs = le32_to_cpu(coal.max_usecs);
> +            q->rx_coal.packets = le32_to_cpu(coal.max_packets);
> +            q->rx_coal.pkt_cnt = 0;
> +            if (q->rx_coal.usecs > 0) {
> +                g_clear_pointer(&q->rx_coal.timer, timer_free);
> +                q->rx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                                virtio_net_rx_notify,
> +                                                q);
> +            } else {
> +                g_clear_pointer(&q->rx_coal.timer, timer_free);
> +            }
> +        }
> +    } else if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> +        for (i = 0; i < n->max_queue_pairs; i++) {
> +            q = &n->vqs[i];
> +            q->tx_coal.usecs = le32_to_cpu(coal.max_usecs);
> +            q->tx_coal.packets = le32_to_cpu(coal.max_packets);
> +            q->tx_coal.pkt_cnt = 0;
> +            if (q->tx_coal.usecs > 0) {
> +                g_clear_pointer(&q->tx_coal.timer, timer_free);
> +                q->tx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                                virtio_net_tx_notification_timer,
> +                                                q);
> +            } else {
> +                g_clear_pointer(&q->tx_coal.timer, timer_free);
> +            }
> +        }
> +    }
> +    return VIRTIO_NET_OK;
> +}
> +
>  static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
>                                       struct iovec *iov, unsigned int iov_cnt)
>  {
> @@ -1582,6 +1676,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
>          status = virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
>      } else if (ctrl.class == VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
>          status = virtio_net_handle_offloads(n, ctrl.cmd, iov, out_num);
> +    } else if (ctrl.class == VIRTIO_NET_CTRL_NOTF_COAL) {
> +        status = virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
>      }
>  
>      s = iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
> @@ -2056,7 +2152,23 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>      }
>  
>      virtqueue_flush(q->rx_vq, i);
> -    virtio_notify(vdev, q->rx_vq);
> +
> +    /* rx coalescing */
> +    q->rx_coal.pkt_cnt += i;
> +    if (q->rx_coal.usecs == 0 || q->rx_coal.pkt_cnt >= q->rx_coal.packets) {
> +        if (q->rx_coal.timer) {
> +            timer_del(q->rx_coal.timer);
> +        }
> +        virtio_net_rx_notify(q);
> +    } else {
> +        if (q->rx_coal.timer) {
> +            if (!timer_pending(q->rx_coal.timer)) {
> +                timer_mod(q->rx_coal.timer,
> +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                          q->rx_coal.usecs * 1000); /* Converted to ns */
> +            }
> +        }
> +    }
>  
>      return size;
>  
> @@ -2739,7 +2851,9 @@ static void virtio_net_tx_complete(NetClientState *nc, ssize_t len)
>      int ret;
>  
>      virtqueue_push(q->tx_vq, q->async_tx.elem, 0);
> -    virtio_notify(vdev, q->tx_vq);
> +    if (virtio_net_tx_should_notify(q)) {
> +        virtio_notify(vdev, q->tx_vq);
> +    }
>  
>      g_free(q->async_tx.elem);
>      q->async_tx.elem = NULL;
> @@ -2851,7 +2965,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>  
>  drop:
>          virtqueue_push(q->tx_vq, elem, 0);
> -        virtio_notify(vdev, q->tx_vq);
> +        if (virtio_net_tx_should_notify(q)) {
> +            virtio_notify(vdev, q->tx_vq);
> +        }
> +
>          g_free(elem);
>  
>          if (++num_packets >= n->tx_burst) {
> @@ -3054,6 +3171,12 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
>                              &DEVICE(vdev)->mem_reentrancy_guard);
>  
>      n->vqs[index].tx_waiting = 0;
> +    n->vqs[index].rx_coal.pkt_cnt = 0;
> +    n->vqs[index].tx_coal.pkt_cnt = 0;
> +    n->vqs[index].rx_coal.usecs = 0;
> +    n->vqs[index].tx_coal.usecs = 0;
> +    n->vqs[index].rx_coal.packets = 0;
> +    n->vqs[index].tx_coal.packets = 0;
>      n->vqs[index].n = n;
>  }
>  
> @@ -3066,6 +3189,10 @@ static void virtio_net_del_queue(VirtIONet *n, int index)
>      qemu_purge_queued_packets(nc);
>  
>      virtio_del_queue(vdev, index * 2);
> +
> +    g_clear_pointer(&q->rx_coal.timer, timer_free);
> +    g_clear_pointer(&q->tx_coal.timer, timer_free);
> +
>      if (q->tx_timer) {
>          timer_free(q->tx_timer);
>          q->tx_timer = NULL;
> @@ -3156,6 +3283,13 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>      virtio_features_or(features, features, n->host_features_ex);
>  
>      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> +    if (n->tx_timer_activate) {
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
> +    } else {
> +        if (!virtio_has_feature(*features, VIRTIO_NET_F_NOTF_COAL)) {
> +            *features &= ~(1ULL << VIRTIO_NET_F_NOTF_COAL);
> +        }
> +    }
>  
>      if (n->peers_wait_incoming) {
>          /*
> @@ -3336,6 +3470,21 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
>          return -EINVAL;
>      }
>  
> +    for (i = 0; i < n->max_queue_pairs; i++) {
> +        VirtIONetQueue *q = &n->vqs[i];
> +        if (q->rx_coal.usecs > 0 && !q->rx_coal.timer) {
> +            q->rx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                            virtio_net_rx_notify,
> +                                            q);
> +        }
> +
> +        if (q->tx_coal.usecs > 0 && !q->tx_coal.timer) {
> +            q->tx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                            virtio_net_tx_notification_timer,
> +                                            q);
> +        }
> +    }
> +
>      return 0;
>  }
>  
> @@ -3355,13 +3504,49 @@ static int virtio_net_post_load_virtio(VirtIODevice *vdev)
>      return 0;
>  }
>  
> +static const VMStateDescription vmstate_virtio_net_coal = {
> +    .name = "virtio-net-coal",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(usecs, VirtIONetCoal),
> +        VMSTATE_UINT32(packets, VirtIONetCoal),
> +        VMSTATE_UINT32(pkt_cnt, VirtIONetCoal),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static bool virtio_net_queue_notf_coal_needed(void *opaque)
> +{
> +    VirtIONetQueue *q = opaque;
> +    return q->rx_coal.usecs > 0 || q->tx_coal.usecs > 0;
> +}
> +
> +static const VMStateDescription vmstate_virtio_net_queue_notf_coal = {
> +    .name = "virtio-net-queue-tx_waiting/notf-coal",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = virtio_net_queue_notf_coal_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT(rx_coal, VirtIONetQueue, 0,
> +                       vmstate_virtio_net_coal, VirtIONetCoal),
> +        VMSTATE_STRUCT(tx_coal, VirtIONetQueue, 0,
> +                       vmstate_virtio_net_coal, VirtIONetCoal),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  /* tx_waiting field of a VirtIONetQueue */
>  static const VMStateDescription vmstate_virtio_net_queue_tx_waiting = {
>      .name = "virtio-net-queue-tx_waiting",
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(tx_waiting, VirtIONetQueue),
>          VMSTATE_END_OF_LIST()
> -   },
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_virtio_net_queue_notf_coal,
> +        NULL
> +    }
>  };
>  
>  static bool max_queue_pairs_gt_1(void *opaque, int version_id)
> @@ -4117,6 +4302,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  
>      if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") == 0) {
>          n->tx_timer_activate = true;
> +        if (n->host_features & (1ULL << VIRTIO_NET_F_NOTF_COAL)) {
> +            warn_report("virtio-net: 'vq_notf_coal' is incompatible with 'tx=timer',"
> +                        "disabling notification coalescing");
> +        }
>      }
>  
>      n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
> @@ -4413,6 +4602,8 @@ static const Property virtio_net_properties[] = {
>                        VIRTIO_NET_F_GUEST_USO6, true),
>      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                        VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
> +                      VIRTIO_NET_F_NOTF_COAL, false),
>      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
>                                    rss_data.specified_hash_types,
>                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index 2e7bc29967..c7bb61b3e5 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -155,6 +155,14 @@ typedef struct VirtioNetRssData {
>      uint16_t default_queue;
>  } VirtioNetRssData;
>  
> +/* Interrupt notification coalescing parameters */
> +typedef struct VirtIONetCoal {
> +    uint32_t usecs;    /* Timeout in microseconds */
> +    uint32_t packets;  /* Packet count threshold */
> +    uint32_t pkt_cnt;  /* Current packet count since last notification */
> +    QEMUTimer *timer;  /* Coalescing timer */
> +} VirtIONetCoal;
> +
>  typedef struct VirtIONetQueue {
>      VirtQueue *rx_vq;
>      VirtQueue *tx_vq;
> @@ -165,6 +173,8 @@ typedef struct VirtIONetQueue {
>          VirtQueueElement *elem;
>      } async_tx;
>      struct VirtIONet *n;
> +    VirtIONetCoal rx_coal;
> +    VirtIONetCoal tx_coal;
>  } VirtIONetQueue;
>  
>  struct VirtIONet {
> diff --git a/net/passt.c b/net/passt.c
> index e65198960e..5ce25d0463 100644
> --- a/net/passt.c
> +++ b/net/passt.c
> @@ -52,6 +52,7 @@ static const int user_feature_bits[] = {
>      VIRTIO_NET_F_GUEST_USO4,
>      VIRTIO_NET_F_GUEST_USO6,
>      VIRTIO_NET_F_HOST_USO,
> +    VIRTIO_NET_F_NOTF_COAL,
>  
>      /* This bit implies RARP isn't sent by QEMU out of band */
>      VIRTIO_NET_F_GUEST_ANNOUNCE,
> diff --git a/net/tap.c b/net/tap.c
> index d71e3dd117..59286e141d 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -69,6 +69,7 @@ static const int kernel_feature_bits[] = {
>      VIRTIO_F_NOTIFICATION_DATA,
>      VIRTIO_NET_F_RSC_EXT,
>      VIRTIO_NET_F_HASH_REPORT,
> +    VIRTIO_NET_F_NOTF_COAL,
>      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
>      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
>      VHOST_INVALID_FEATURE_BIT
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index b849de92da..4674ebb5b5 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -54,6 +54,7 @@ static const int user_feature_bits[] = {
>      VIRTIO_NET_F_GUEST_USO4,
>      VIRTIO_NET_F_GUEST_USO6,
>      VIRTIO_NET_F_HOST_USO,
> +    VIRTIO_NET_F_NOTF_COAL,
>  
>      /* This bit implies RARP isn't sent by QEMU out of band */
>      VIRTIO_NET_F_GUEST_ANNOUNCE,
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 1052361a4a..ebd77135da 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -71,6 +71,7 @@ static const int vdpa_feature_bits[] = {
>      VIRTIO_NET_F_CTRL_RX,
>      VIRTIO_NET_F_CTRL_RX_EXTRA,
>      VIRTIO_NET_F_CTRL_VLAN,
> +    VIRTIO_NET_F_NOTF_COAL,
>      VIRTIO_NET_F_CTRL_VQ,
>      VIRTIO_NET_F_GSO,
>      VIRTIO_NET_F_GUEST_CSUM,

which of these backends actually implement the feature?
We do not pass-through all bits not because we
like code duplication but because we never know
what configuration will be required from backend.


> -- 
> 2.53.0


