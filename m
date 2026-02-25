Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45431FD3760
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 14:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvFdc-0007Gf-5c; Wed, 25 Feb 2026 09:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vvFd9-00077h-AY
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:12:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vvFd6-0000wD-Rv
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772028757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opXL8PAZ1J7Jui5GHbAGK075GsSCrO+kNmzVn8AQodo=;
 b=WdEsrwX5BiITQncRgKnsJjoO31Li6iU9hqVXk+eodYTehqFe2eAc0cYxswU3NZKUHNbHLL
 tjcWhdOMbNkoOPyAUO3/mWHRzkKC5yjpaPXFt726jPS0yvuVIUGsI+AZpqmVA5pUtACwcC
 /j5sTPttF0FAzB/niJWRHXA2O/n0u2o=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-O5WZvPkoMMqiyXg4lAgysA-1; Wed, 25 Feb 2026 09:12:36 -0500
X-MC-Unique: O5WZvPkoMMqiyXg4lAgysA-1
X-Mimecast-MFC-AGG-ID: O5WZvPkoMMqiyXg4lAgysA_1772028756
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-64c98481d1eso4155250d50.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 06:12:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772028756; cv=none;
 d=google.com; s=arc-20240605;
 b=GmQaPKOhQDyEbhGRyJarvEtIJ/oQEOim5qi4+BhP0MRNhqKwstQTF6ECJIHp8BRbyK
 57SOnavsYTBRfLcwaT8aADqmQ2BBPD2OUSUaLxQ5XHmInO+8LkNA1Root0oGAX3zZEON
 Z256qgX6eVi/5zur5e/dqrovvL2o6dpb6eM8CzuF5vzFgNEYqjb9Mu3WIGlWsue0frwO
 GQbH5djZX4U58cBPE3SShb1xvku9+h3am8/CbKfOcYmQGzxao08L7kn26Y7FFN9N0TtA
 KOzik80uLb1xP/498SCxksiChbOMoC8iB2aHMr1KtlXnDFU9qZ5+MdQH3c5+DDWerYlA
 d/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=opXL8PAZ1J7Jui5GHbAGK075GsSCrO+kNmzVn8AQodo=;
 fh=FkAvTCYy53Brn1mygBnZ89KOLvB58/3O3yc9PUJgZYE=;
 b=GBqc9tVfIXOJbRO4ZF2ytVmk8gS24OsNhnIQuO3G8SdFLUzb2vmZg6bJ8n4m2cCo+v
 EJKZ5hMZdJ48HzIDfpygPp1NEzb2jzb8UmdxQQornqPiLbTCJk9QLVzN3HWYOfEgjUTN
 L+XRkY6acEHE2V/K2UL16iQvaZOqlqmcudzIpfoEryz7xDWGikdPk7Uq2AV9ShAeG/g+
 S9CvXvF0QqjNgCcPdWQBISEehZF2oAUlIni5iinP3AMo2aNIW+hFYEM+4jFFt98HfgDd
 78g04zrap1JpmWu978uPfqXzZWDKtMg4ufAAbvKDuhiBLIyG2Jd021cyYW63gEicpfUF
 pqvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772028756; x=1772633556; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opXL8PAZ1J7Jui5GHbAGK075GsSCrO+kNmzVn8AQodo=;
 b=h+K1viYGfKGQjHP+SFcSlJZHq6qV/H2+lLTmjT1IEuRYKzvM4qjcZ3osTzuc1CFSWb
 TIAZGNjkuGPxFfHFDt4r5pyVQ+oMXO5uIshRaZLFpMdxTzyWu+4SoYcVlsEk7l7m3fNQ
 apvhzzKgELt9YQ0pCIf9+bvBcIZvx7qHjZKz9b6ecoHP6WLamQC6UM+yMlWwkb9Rtu41
 I+9SL30QNYMgsJ1A4i3uGwPkd+Rt4Cnx1DCVh0ko48efeYcrvxbN8G2w9aAsNZyTFBub
 GKQ1Aj8Qx3l3da8UpzXoFkUSy8bM/IKJgLMukHX5mrOA/m51jWDoTzZnLr5FPguHjGzn
 JLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772028756; x=1772633556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=opXL8PAZ1J7Jui5GHbAGK075GsSCrO+kNmzVn8AQodo=;
 b=tkdR2gGEEoCMaEWIuYWiLbECZq2PsObcJaPvjeS/GRjVZ1TPYWIIYr9WwFtGlk04D1
 GeAszilF0KZN+F1LrzkTHZRDqcIXoJVKmgVJ3rco2lLuEJpG6rPBv2wKmr0vnVX/qljV
 PR08Gjm0Vcm3H3Ipm1m1p52RhGwzUTpZhBLQ+vAP6iUTHdqew6sz0Iq/Q2DJbgVNb3VP
 zwx5pBccvCnlBwdhDPjX69seVrWykFsLN+7XlWJ5ZofgUp+ECV2CpbTfBDRa1Qgi2QBw
 PVeIZPUdn06bwv57IaUr5BsCNCBvUXIfpgKR7fvfUI0y7y4P6hz+G2Bc/nlAh9S36wZe
 +IwQ==
X-Gm-Message-State: AOJu0Yy8fNhklSi0vOStKGDs3RlSw5/3yDHSYHRZkSl/iSYByprIsC/f
 3dwjibf6nDdv3/i1e2rjb1dqD8Key4lRp1z/jI6eTYNXDbfw2yKEHpXyUkxZecNjrWe8/dG4nqI
 FcDOMZoSpoWuVOmAXCHmI2Qfnt6HB6K2g5i/QAsT3NgZ6W+rnGEoeAGkV7P/ZNJMyoZ5V6BuBIi
 gQ3vFKEL6gFf7Lb4D/ZgGGhq9Xf8+WjW4=
X-Gm-Gg: ATEYQzwjReLKq/cknTUoJ+DVPJQqkIyy28IkpTCTjiW9+JjYoxi1D6R4AwLeRNcYdWY
 1sCGHg+Z3rSGC+OmSv/sOyryBS1BBOcqDvLGObT5CFWN452vfrzohnKZr2szBuokj+PdKEojmoE
 cLgb20ZkzpWQLcLKLk5RkXTIBP966/iDeWcx/0msUfU3O4DAw6R/j0Hse+7LQL3k2FntCJJKya9
 h5lCg==
X-Received: by 2002:a05:690e:444b:b0:64c:a3de:57c7 with SMTP id
 956f58d0204a3-64cb250c4c2mr414450d50.58.1772028750678; 
 Wed, 25 Feb 2026 06:12:30 -0800 (PST)
X-Received: by 2002:a05:690e:444b:b0:64c:a3de:57c7 with SMTP id
 956f58d0204a3-64cb250c4c2mr414417d50.58.1772028750068; Wed, 25 Feb 2026
 06:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20260223203454.347800-1-kdutta@redhat.com>
In-Reply-To: <20260223203454.347800-1-kdutta@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 25 Feb 2026 15:11:52 +0100
X-Gm-Features: AaiRm50i3zh866_v2WByNp2klfW4I88P3pTsi5zfdz6gW1l_EFnpDLjEF1RmVks
Message-ID: <CAJaqyWdD8i=XU_3azSgzkXB0izryD8xNZteV3kbgqXzHMrSb0g@mail.gmail.com>
Subject: Re: [PATCH] hw/net/virtio-net: add support for notification coalescing
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Feb 23, 2026 at 10:18=E2=80=AFPM Koushik Dutta <kdutta@redhat.com> =
wrote:
>
> Implement VirtIO Network Notification Coalescing (Bit 53).
> This allows the guest to manage interrupt frequency using ethtool
> -C for both RX and TX paths.
>
> - Added VIRTIO_NET_F_NOTF_COAL to host features.
> - Implemented VIRTIO_NET_CTRL_NOTF_COAL class handling in
>   virtio_net_handle_ctrl_iov.
> - Added logic to store and apply rx/tx usecs and max_packets.
> - Added packet counters and threshold logic for both RX and TX data paths=
.
> - Dynamic Dispatcher: Implemented a dispatcher mechanism that
>   dynamically switches/activates the notification callback logic
>   only after the guest enables TX coalescing via ethtool.
>
> This reduces interrupt overhead by batching notifications based on
> either a packet count or a time-based threshold.
>

As an idea for the future, we could add VirtIO event_idx to the mix if
the driver supports it, allowing the tx queue to be notified only when
the tx threshold is reached. But the original code did not even use it
so this is enough for a first version.

> Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> ---
>  hw/net/virtio-net.c            | 110 ++++++++++++++++++++++++++++-----
>  include/hw/virtio/virtio-net.h |   7 +++
>  2 files changed, 100 insertions(+), 17 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index eccb48ad42..e30aa198f3 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -157,6 +157,15 @@ static void flush_or_purge_queued_packets(NetClientS=
tate *nc)
>   * - we could suppress RX interrupt if we were so inclined.
>   */
>
> +static void virtio_net_rx_timer_cb(void *opaque)
> +{
> +    VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    n->rx_pkt_cnt =3D 0;
> +    virtio_notify(vdev, n->vqs[0].rx_vq);
> +}
> +

I'd rename this to "virtio_net_rx_notify" or similar, as it might not
be called from the timer.

>  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
>      VirtIONet *n =3D VIRTIO_NET(vdev);
> @@ -1081,6 +1090,29 @@ static int virtio_net_handle_offloads(VirtIONet *n=
, uint8_t cmd,
>      }
>  }
>
> +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
> +                                  struct iovec *iov, unsigned int iov_cn=
t)
> +{
> +    struct virtio_net_ctrl_coal coal;
> +    size_t s;
> +
> +    s =3D iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
> +    if (s !=3D sizeof(coal)) {
> +        return VIRTIO_NET_ERR;
> +    }
> +
> +    if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
> +        n->rx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> +        n->rx_coal_packets =3D le32_to_cpu(coal.max_packets);
> +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
> +    }
> +
> +    return VIRTIO_NET_OK;
> +}
> +
>  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
>                                   struct iovec *iov, unsigned int iov_cnt=
)
>  {
> @@ -1582,6 +1614,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vde=
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
> @@ -2041,7 +2075,18 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
te *nc, const uint8_t *buf,
>      }
>
>      virtqueue_flush(q->rx_vq, i);
> -    virtio_notify(vdev, q->rx_vq);
> +
> +    /* rx coalescing */
> +    n->rx_pkt_cnt +=3D i;
> +    if (n->rx_coal_usecs =3D=3D 0 || n->rx_pkt_cnt >=3D n->rx_coal_packe=
ts) {
> +        timer_del(n->rx_index_timer);
> +        virtio_net_rx_timer_cb(n);
> +    } else {
> +        if (n->rx_pkt_cnt =3D=3D i) {
> +            timer_mod(n->rx_index_timer,
> +                      qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_coal=
_usecs);
> +        }
> +    }
>
>      return size;
>
> @@ -2900,6 +2945,7 @@ static void virtio_net_tx_timer(void *opaque)
>      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
>          return;
>      }
> +    n->tx_pkt_cnt -=3D ret;
>      /*
>       * If we flush a full burst of packets, assume there are
>       * more coming and immediately rearm
> @@ -2919,6 +2965,7 @@ static void virtio_net_tx_timer(void *opaque)
>      ret =3D virtio_net_flush_tx(q);
>      if (ret > 0) {
>          virtio_queue_set_notification(q->tx_vq, 0);
> +        n->tx_pkt_cnt -=3D ret;
>          q->tx_waiting =3D 1;
>          timer_mod(q->tx_timer,
>                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> @@ -2974,27 +3021,45 @@ static void virtio_net_tx_bh(void *opaque)
>      }
>  }
>
> -static void virtio_net_add_queue(VirtIONet *n, int index)
> +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue =
*vq)
>  {
> -    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    VirtIONet *n =3D VIRTIO_NET(vdev);
>
> -    n->vqs[index].rx_vq =3D virtio_add_queue(vdev, n->net_conf.rx_queue_=
size,
> -                                           virtio_net_handle_rx);
> +    n->tx_pkt_cnt++;
> +    bool use_timer =3D (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer=
")) ||

Let's remove strcmp from the hot path, even if it can be optimized
because it is a short string.

Also, use_timer could be true even if conf.tx is not timer &&
tx_coal_usecs is 0 but tx_coal_packets is > 0. Maybe rename it to
delay_tx, coalesce, or something similar?

> +                     (n->tx_coal_usecs > 0) || (n->tx_coal_packets > 0);
>
> -    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_timer);
> -        n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                              virtio_net_tx_timer,
> -                                              &n->vqs[index]);
> +    if (use_timer && n->tx_pkt_cnt < n->tx_coal_packets) {
> +        virtio_net_handle_tx_timer(vdev, vq);
>      } else {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_bh);
> -        n->vqs[index].tx_bh =3D qemu_bh_new_guarded(virtio_net_tx_bh, &n=
->vqs[index],
> -                                                  &DEVICE(vdev)->mem_ree=
ntrancy_guard);
> +        n->tx_pkt_cnt =3D 0;
> +        virtio_net_handle_tx_bh(vdev, vq);
>      }
> +}
> +
> +static void virtio_net_add_queue(VirtIONet *n, int index)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    n->vqs[index].rx_vq =3D
> +        virtio_add_queue(vdev,
> +                         n->net_conf.rx_queue_size,
> +                         virtio_net_handle_rx);
> +
> +    n->vqs[index].tx_vq =3D
> +        virtio_add_queue(vdev,
> +                         n->net_conf.tx_queue_size,
> +                         virtio_net_handle_tx_dispatch);
> +
> +    n->vqs[index].tx_timer =3D
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                     virtio_net_tx_timer,
> +                     &n->vqs[index]);
> +

Maybe we can delay creating the timer if it is not needed?

> +    n->vqs[index].tx_bh =3D
> +        qemu_bh_new_guarded(virtio_net_tx_bh,
> +                            &n->vqs[index],
> +                            &DEVICE(vdev)->mem_reentrancy_guard);

It seems to me the new function requiring reentrancy guarding is
virtio_net_handle_tx_dispatch now. Or am I missing something?

>
>      n->vqs[index].tx_waiting =3D 0;
>      n->vqs[index].n =3D n;
> @@ -3089,6 +3154,7 @@ static void virtio_net_get_features(VirtIODevice *v=
dev, uint64_t *features,
>      virtio_features_or(features, features, n->host_features_ex);
>
>      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> +    virtio_add_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
>
>      if (!peer_has_vnet_hdr(n)) {
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> @@ -4048,6 +4114,14 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>              n->rss_data.specified_hash_types.on_bits |
>              n->rss_data.specified_hash_types.auto_bits;
>      }
> +    n->rx_pkt_cnt =3D 0;
> +    n->tx_pkt_cnt =3D 0;
> +    n->rx_coal_usecs =3D 0;
> +    n->tx_coal_usecs =3D 0;
> +    n->rx_coal_packets =3D 1;
> +    n->tx_coal_packets =3D 0;

Maybe is good to homogeneize the {t,r}x_coal_packets default to either
0 or 1? Or am I missing why they're different?

> +    n->rx_index_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                     virtio_net_rx_timer_cb, n);
>  }
>
>  static void virtio_net_device_unrealize(DeviceState *dev)
> @@ -4262,6 +4336,8 @@ static const Property virtio_net_properties[] =3D {
>                        VIRTIO_NET_F_GUEST_USO6, true),
>      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                        VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
> +                      VIRTIO_NET_F_NOTF_COAL, true),
>      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
>                                    rss_data.specified_hash_types,
>                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index 5b8ab7bda7..33d01d080b 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -231,6 +231,13 @@ struct VirtIONet {
>      struct EBPFRSSContext ebpf_rss;
>      uint32_t nr_ebpf_rss_fds;
>      char **ebpf_rss_fds;
> +    QEMUTimer *rx_index_timer;
> +    uint32_t rx_coal_usecs;
> +    uint32_t rx_coal_packets;
> +    uint32_t rx_pkt_cnt;
> +    uint32_t tx_coal_usecs;
> +    uint32_t tx_coal_packets;
> +    uint32_t tx_pkt_cnt;
>  };
>
>  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
> --
> 2.53.0
>
>


