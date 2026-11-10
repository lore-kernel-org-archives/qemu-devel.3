Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8D606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M1uRCPPo;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=G1g3MHyQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQjwb-0003iX-Cb; Tue, 10 Nov 2026 06:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xQjwW-0003iF-Jk
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 06:23:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xQjwS-0006Wf-Mv
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 06:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794309786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3+Vx40IuCCbI8xf3+YWUqLp3Uzf/NDmIt59DnID8jg=;
 b=M1uRCPPocZ/Qc76QMumrP9OAfKYzcSi+ftoMVxWX+gRBWnuqTP39B2Zi2e+Vbq5oDF0xNx
 Hy68mjaLkdXAHCLTlvhEhJA9jMm0bo7VYQJugZQfhiBgsuImly8iIfxSrlIJJnG1/fRMNm
 Sq4U+0vrbzEyFFSI3DTmQ8tsrLMfjlw=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-2d35hYRsNu2-nmgxgyo9jA-1; Tue, 10 Nov 2026 06:23:04 -0500
X-MC-Unique: 2d35hYRsNu2-nmgxgyo9jA-1
X-Mimecast-MFC-AGG-ID: 2d35hYRsNu2-nmgxgyo9jA_1794309783
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-67a6eb09b1eso2482077d50.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 03:23:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794309783; cv=none;
 d=google.com; s=arc-20260327;
 b=TxU8tpupYdD01UuGIEoi+qkN3gFnGmm77jPhpwHL2OgGnU5fpLq30NLJsT69ZtQ+i8
 9JSTOiWiBog5WSwKfzlePrqCZy4lal6KixoVlW1gnSadYP+4au21xGkc+OXb6BcoecU4
 CJHLAO4fxt9xLfLsZ3us0S2o1jraUh4Cti7sMUuCxol8Vq5HrT6dWY30JC3GZPgwsNsb
 0FS9Ug6Hz0aWkWW4TwHJ7Km47h/eBKZbc9pokNPz8/6lEZ3F27tG80Bd9P+b9YLZlty5
 4sX1LXf7BoFKP4fx4QQAqyzmpU//5bnmVwZUWcTieKDx4V/RnrAOIveRFrNiChW++9ZA
 iohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X3+Vx40IuCCbI8xf3+YWUqLp3Uzf/NDmIt59DnID8jg=;
 fh=QHOQ+x7Y9AZFpz+A0eTWNi4f86ToJYs7NMf89ciYuK8=;
 b=FXOPCwwGGBZi+ALC5DjsEKZxABgPBZubdtFoxGqJAKf17rst3TKIQT5V6f0SqDjEZD
 eViwrmRpel7ARj2k5vif+13jFgibeaiYh1g8qsAK7hfIWZ0qU5Antuqt8u/ZpPvuiUFQ
 jksmVfIrR9JXncgEg+nfngSyfRfmadZSr8Rl1E8gOntj4Kf+uig+6iPMTRme1VLvKMHu
 RjFcvQmzeL5dH7br3O5JIMI8DsghLExXvRsVNFDnabbbJNL3WvJtlL7SAK6Gt44u21ry
 zTnSAkKCUeHvn7YZn4ankFFUvMhzZQ7VNJqHzGdSb4tk993YmqJbPyPKEFcth61p2rN3
 B+qA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794309783; x=1794914583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X3+Vx40IuCCbI8xf3+YWUqLp3Uzf/NDmIt59DnID8jg=;
 b=G1g3MHyQGmfZVdtYPV3oHHR/unuyGFYpRfMYC8PSTQJYGYtS/eBtqEPN1fh+qvTyDi
 vp8lMA+mxVHAfm1gNpnQ2j8UR1Udl2/yXZn2pQNsv4OVB7LN7ob+oQQ4VLjjtCz+DQJ3
 vSB3V9KL4uOD2llZJCjMXGMBxQTU8ZYG1gEwi6ZKu7Qx+7Z3Csqzfd9az22M7DiF3cMc
 GJEld2YQpAPY22GDkCUuvgnI1MSD7hXojcDwCTgQIy38N7ocU+vmbndV4Ssvq+uJtkX3
 yOpoWiLtP1Jp+dhKCGiIMtMSwDp0RJWS9oZazGgxDDOjSq3Ige6V+PDDVqgKgfnNqmpN
 V8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794309783; x=1794914583;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X3+Vx40IuCCbI8xf3+YWUqLp3Uzf/NDmIt59DnID8jg=;
 b=T2uatJjaa21BKiaxNiZDqs0sPX63vqi8MwvWhJzkyrhNPK59/wV7CYUWcPAn3KjfuH
 LZGrB4CKXIzrswSb/ZipHnzyBdd5TLUA/C6zWeBLgN2RGRXPxgaS8/x/qFqguFhIEwlt
 qWKdtu9YPAK5jVhHHiwIVRVnsp8moUOEhI9X71SuuzI3gge6eOArYloORoSjtobSa9m6
 /k+Lv2adsYjUjnOW6daBhcinAvmCHhwS1HhUR/GLsQuTHS5LtZQ1SztcOhFlduOADj/X
 hWJEUOnY4UoU6lpDOZaeykM5oqiSrLQcOlOU9PGwZcfol/Zzyd/Q83GBlrMM5PG0tsZC
 BoLA==
X-Gm-Message-State: APuU4Z/FHxNGY2ue/mXLI3f6rFfy6zzLiETvKhi4HArVzjVbrnvLyx6o
 ah3SXmYYaXLIsjlKsMbz2Wg2wxgSRGNz9ZbrivZrRjZ5TAo5PXq4sQkDT1TddtLOxYPoojPwQeF
 P7Qx2opBTe2LkR/yLwSyB27OO33KroMBb/6UYUwIyGBja5S4GWDtXrJ2ccELBEAwmTGyMkiggon
 1i8xz+t5v+PEEubawYlFhHqUGDAkyv+dg=
X-Gm-Gg: AYBFou2Y1rjoKWUVnkSa+GgQmZYLR+vw2BqJEXqp4Z2wW7kQpOaIVFvZmQFSkN6l8v9
 KG7NARM4JPxtWvxw79cJkl2trg4iMOwb+I1p+DZ8lXMNe6VedHio34QDFdNt8No3RMQufjAlLZo
 60WXZ8OaFAdPLGzE+MoWXbr5FlKetc274mEDssd+ht+Zh9yXJr2Uk0jw0zK22sPBLpQOAFmYJpY
 cNjOWj/ChDY5TTN+UCAEFBbS7oCHPa4ptZXAJGB5SJYW7sllqojZr7VX+4=
X-Received: by 2002:a05:690e:130e:b0:675:4396:af23 with SMTP id
 956f58d0204a3-67c56775788mr963117d50.70.1794309783429; 
 Tue, 10 Nov 2026 03:23:03 -0800 (PST)
X-Received: by 2002:a05:690e:130e:b0:675:4396:af23 with SMTP id
 956f58d0204a3-67c56775788mr963106d50.70.1794309782890; Tue, 10 Nov 2026
 03:23:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261017192232.1545578-1-kdutta@redhat.com>
 <20261017192232.1545578-3-kdutta@redhat.com>
In-Reply-To: <20261017192232.1545578-3-kdutta@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 10 Nov 2026 12:22:26 +0100
X-Gm-Features: AclHuK9afXIrxxIcWXbUN5pb3ldOr6WXsLRv09COAoA3k-JmUI4D3c7vh4g2cqk
Message-ID: <CAJaqyWf9WuQ_qQJoTbxb=RyYVyG0dsOL1BvM8djS0GbiSTiTeg@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] [PATCH 2/3] virtio-net: Add VIRTIO_NET_F_NOTF_COAL
 support
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The subject should not include two [PATCH] blocks.


On Sat, Oct 17, 2026 at 9:22=E2=80=AFPM Koushik Dutta <kdutta@redhat.com> w=
rote:
>
> Implement notification coalescing to reduce interrupt overhead.
> Guests configure time-based (microseconds) or count-based (packets)
> coalescing via ethtool -C. Coalescing state is migrated via VMState
> for live migration support.
>
>   Note: Coalescing is disabled when tx=3Dtimer is configured, as timer
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
> @@ -158,6 +158,16 @@ static void flush_or_purge_queued_packets(NetClientS=
tate *nc)
>   * - we could suppress RX interrupt if we were so inclined.
>   */
>
> +static void virtio_net_rx_notify(void *opaque)
> +{
> +    VirtIONetQueue *q =3D opaque;
> +    VirtIONet *n =3D q->n;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    q->rx_coal.pkt_cnt =3D 0;
> +    virtio_notify(vdev, q->rx_vq);
> +}
> +
>  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
>      VirtIONet *n =3D VIRTIO_NET(vdev);
> @@ -1003,6 +1013,90 @@ static void virtio_net_set_features(VirtIODevice *=
vdev,
>      }
>  }
>
> +static void virtio_net_tx_notification_timer(void *opaque)
> +{
> +    VirtIONetQueue *q =3D opaque;
> +    VirtIONet *n =3D q->n;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    q->tx_coal.pkt_cnt =3D 0;
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
> +    if (q->tx_coal.packets > 0 && q->tx_coal.pkt_cnt >=3D q->tx_coal.pac=
kets) {
> +        q->tx_coal.pkt_cnt =3D 0;
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
> +                                  struct iovec *iov, unsigned int iov_cn=
t)
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
> +    s =3D iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
> +    if (s !=3D sizeof(coal)) {
> +        return VIRTIO_NET_ERR;
> +    }
> +
> +    if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
> +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> +            q =3D &n->vqs[i];
> +            q->rx_coal.usecs =3D le32_to_cpu(coal.max_usecs);
> +            q->rx_coal.packets =3D le32_to_cpu(coal.max_packets);
> +            q->rx_coal.pkt_cnt =3D 0;
> +            if (q->rx_coal.usecs > 0) {
> +                g_clear_pointer(&q->rx_coal.timer, timer_free);
> +                q->rx_coal.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                                virtio_net_rx_notify,
> +                                                q);
> +            } else {
> +                g_clear_pointer(&q->rx_coal.timer, timer_free);
> +            }
> +        }
> +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> +            q =3D &n->vqs[i];
> +            q->tx_coal.usecs =3D le32_to_cpu(coal.max_usecs);
> +            q->tx_coal.packets =3D le32_to_cpu(coal.max_packets);
> +            q->tx_coal.pkt_cnt =3D 0;
> +            if (q->tx_coal.usecs > 0) {
> +                g_clear_pointer(&q->tx_coal.timer, timer_free);
> +                q->tx_coal.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                                virtio_net_tx_notificati=
on_timer,
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
>                                       struct iovec *iov, unsigned int iov=
_cnt)
>  {
> @@ -1582,6 +1676,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vde=
v,
>          status =3D virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
>      } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
>          status =3D virtio_net_handle_offloads(n, ctrl.cmd, iov, out_num)=
;
> +    } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_NOTF_COAL) {
> +        status =3D virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
>      }
>
>      s =3D iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
> @@ -2056,7 +2152,23 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
te *nc, const uint8_t *buf,
>      }
>
>      virtqueue_flush(q->rx_vq, i);
> -    virtio_notify(vdev, q->rx_vq);
> +
> +    /* rx coalescing */
> +    q->rx_coal.pkt_cnt +=3D i;
> +    if (q->rx_coal.usecs =3D=3D 0 || q->rx_coal.pkt_cnt >=3D q->rx_coal.=
packets) {
> +        if (q->rx_coal.timer) {
> +            timer_del(q->rx_coal.timer);
> +        }
> +        virtio_net_rx_notify(q);
> +    } else {
> +        if (q->rx_coal.timer) {
> +            if (!timer_pending(q->rx_coal.timer)) {
> +                timer_mod(q->rx_coal.timer,
> +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                          q->rx_coal.usecs * 1000); /* Converted to ns *=
/
> +            }
> +        }
> +    }
>
>      return size;
>
> @@ -2739,7 +2851,9 @@ static void virtio_net_tx_complete(NetClientState *=
nc, ssize_t len)
>      int ret;
>
>      virtqueue_push(q->tx_vq, q->async_tx.elem, 0);
> -    virtio_notify(vdev, q->tx_vq);
> +    if (virtio_net_tx_should_notify(q)) {
> +        virtio_notify(vdev, q->tx_vq);
> +    }
>
>      g_free(q->async_tx.elem);
>      q->async_tx.elem =3D NULL;
> @@ -2851,7 +2965,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue =
*q)
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
>          if (++num_packets >=3D n->tx_burst) {
> @@ -3054,6 +3171,12 @@ static void virtio_net_add_queue(VirtIONet *n, int=
 index)
>                              &DEVICE(vdev)->mem_reentrancy_guard);
>
>      n->vqs[index].tx_waiting =3D 0;
> +    n->vqs[index].rx_coal.pkt_cnt =3D 0;
> +    n->vqs[index].tx_coal.pkt_cnt =3D 0;
> +    n->vqs[index].rx_coal.usecs =3D 0;
> +    n->vqs[index].tx_coal.usecs =3D 0;
> +    n->vqs[index].rx_coal.packets =3D 0;
> +    n->vqs[index].tx_coal.packets =3D 0;
>      n->vqs[index].n =3D n;
>  }
>
> @@ -3066,6 +3189,10 @@ static void virtio_net_del_queue(VirtIONet *n, int=
 index)
>      qemu_purge_queued_packets(nc);
>
>      virtio_del_queue(vdev, index * 2);
> +
> +    g_clear_pointer(&q->rx_coal.timer, timer_free);
> +    g_clear_pointer(&q->tx_coal.timer, timer_free);
> +
>      if (q->tx_timer) {
>          timer_free(q->tx_timer);
>          q->tx_timer =3D NULL;
> @@ -3156,6 +3283,13 @@ static void virtio_net_get_features(VirtIODevice *=
vdev, uint64_t *features,
>      virtio_features_or(features, features, n->host_features_ex);
>
>      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> +    if (n->tx_timer_activate) {
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
> +    } else {
> +        if (!virtio_has_feature(*features, VIRTIO_NET_F_NOTF_COAL)) {
> +            *features &=3D ~(1ULL << VIRTIO_NET_F_NOTF_COAL);
> +        }
> +    }
>
>      if (n->peers_wait_incoming) {
>          /*
> @@ -3336,6 +3470,21 @@ static int virtio_net_post_load_device(void *opaqu=
e, int version_id)
>          return -EINVAL;
>      }
>
> +    for (i =3D 0; i < n->max_queue_pairs; i++) {
> +        VirtIONetQueue *q =3D &n->vqs[i];
> +        if (q->rx_coal.usecs > 0 && !q->rx_coal.timer) {
> +            q->rx_coal.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                            virtio_net_rx_notify,
> +                                            q);
> +        }
> +
> +        if (q->tx_coal.usecs > 0 && !q->tx_coal.timer) {
> +            q->tx_coal.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                            virtio_net_tx_notification_t=
imer,
> +                                            q);
> +        }
> +    }
> +
>      return 0;
>  }
>
> @@ -3355,13 +3504,49 @@ static int virtio_net_post_load_virtio(VirtIODevi=
ce *vdev)
>      return 0;
>  }
>
> +static const VMStateDescription vmstate_virtio_net_coal =3D {
> +    .name =3D "virtio-net-coal",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT32(usecs, VirtIONetCoal),
> +        VMSTATE_UINT32(packets, VirtIONetCoal),
> +        VMSTATE_UINT32(pkt_cnt, VirtIONetCoal),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static bool virtio_net_queue_notf_coal_needed(void *opaque)
> +{
> +    VirtIONetQueue *q =3D opaque;
> +    return q->rx_coal.usecs > 0 || q->tx_coal.usecs > 0;
> +}
> +
> +static const VMStateDescription vmstate_virtio_net_queue_notf_coal =3D {
> +    .name =3D "virtio-net-queue-tx_waiting/notf-coal",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D virtio_net_queue_notf_coal_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_STRUCT(rx_coal, VirtIONetQueue, 0,
> +                       vmstate_virtio_net_coal, VirtIONetCoal),
> +        VMSTATE_STRUCT(tx_coal, VirtIONetQueue, 0,
> +                       vmstate_virtio_net_coal, VirtIONetCoal),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  /* tx_waiting field of a VirtIONetQueue */
>  static const VMStateDescription vmstate_virtio_net_queue_tx_waiting =3D =
{
>      .name =3D "virtio-net-queue-tx_waiting",
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT32(tx_waiting, VirtIONetQueue),
>          VMSTATE_END_OF_LIST()
> -   },
> +    },
> +    .subsections =3D (const VMStateDescription * const []) {
> +        &vmstate_virtio_net_queue_notf_coal,
> +        NULL
> +    }
>  };
>
>  static bool max_queue_pairs_gt_1(void *opaque, int version_id)
> @@ -4117,6 +4302,10 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>
>      if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") =3D=3D 0) {
>          n->tx_timer_activate =3D true;
> +        if (n->host_features & (1ULL << VIRTIO_NET_F_NOTF_COAL)) {
> +            warn_report("virtio-net: 'vq_notf_coal' is incompatible with=
 'tx=3Dtimer',"
> +                        "disabling notification coalescing");
> +        }
>      }
>
>      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
> @@ -4413,6 +4602,8 @@ static const Property virtio_net_properties[] =3D {
>                        VIRTIO_NET_F_GUEST_USO6, true),
>      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                        VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
> +                      VIRTIO_NET_F_NOTF_COAL, false),
>      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
>                                    rss_data.specified_hash_types,
>                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
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
> +    uint32_t pkt_cnt;  /* Current packet count since last notification *=
/
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
> @@ -52,6 +52,7 @@ static const int user_feature_bits[] =3D {
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
> @@ -69,6 +69,7 @@ static const int kernel_feature_bits[] =3D {
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
> @@ -54,6 +54,7 @@ static const int user_feature_bits[] =3D {
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
> @@ -71,6 +71,7 @@ static const int vdpa_feature_bits[] =3D {
>      VIRTIO_NET_F_CTRL_RX,
>      VIRTIO_NET_F_CTRL_RX_EXTRA,
>      VIRTIO_NET_F_CTRL_VLAN,
> +    VIRTIO_NET_F_NOTF_COAL,
>      VIRTIO_NET_F_CTRL_VQ,
>      VIRTIO_NET_F_GSO,
>      VIRTIO_NET_F_GUEST_CSUM,
> --
> 2.53.0
>


