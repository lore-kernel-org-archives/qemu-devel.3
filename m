Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6AFCD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 07:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjRN-0002ub-Es; Mon, 08 Apr 2024 03:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtjRL-0002uD-If
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtjRJ-0000vm-P4
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712561352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IIlv6P86xpieXM2tFtNCpY9uMS8ndypX9AgcUYxv1Fk=;
 b=YU2z79+Nxo2w4oqUKgmmce0FzIbgAtsTKawWfY6EBNbcBIqyAb/SRJCa/RN8kH3mOZFL9s
 ADOvhW5eoBu/IS5QCyzoceCjqu2bcQxzPtGhNXKSNrBBK+GmVL1uRr/HEjiDkOliAgfj9K
 vRhNCgSs+fBW3ElUcVAcP+/b2b7YxPg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-GfDMLGsdPEqZKxuRgM2BGQ-1; Mon, 08 Apr 2024 03:26:48 -0400
X-MC-Unique: GfDMLGsdPEqZKxuRgM2BGQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2a2fec91d48so3126386a91.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 00:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712561207; x=1713166007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IIlv6P86xpieXM2tFtNCpY9uMS8ndypX9AgcUYxv1Fk=;
 b=DeWLj8OYd3IAZoNT8AowVSLN97KVMQu7jY4ojOBTvU8emyCpX7vP7gN7vAKAxJkooN
 i1NsZ7UGOXavZbW5qAK8zTV315nu2rfa95jGCRhE18YUweY6CZhM4OxI59HQ70VjimW4
 lfvtw3tCn9hHhc0/YXZVK9N6Ego1N3n2LgaiQjXAZmE6ElT6pn8QMQ8UDAag0bMqIWHH
 PNq+1/KujO0d7/A5YvPIKzq3c1k73Cbdvq12M3AfbqLdxbB/IyuchJBeR6PPgrOW+3Ij
 YShGaHPUCw6+mBlpvrwXXXkdwbR3nFKDzMk/FVUHlli9ypRMADY31hdUYWvCmpDzaGOl
 Ii+A==
X-Gm-Message-State: AOJu0Yz3V+ijfx9j3UXe3YFSV+JCDJ/U8NFOVMq9wyv+OtRaRrKjXG1m
 cb4DYAP8JbYYHuy1OD9cu1b8+edV+wXVzkSdX4DoGDsZSPLUEmgasWNuQp781VaS0mRCw3Za2uI
 A7CPyCk2PgjtT/xwY0WyWmyBSJKr0EhTl11AFvfKyCj8/w1/T/z33kVdoheFFx1htTJLpwJ7Mpl
 89bjwT3f6tQUo+p7NYvjpPwxya/pOKv/ODsjM=
X-Received: by 2002:a17:90a:1fc9:b0:2a2:1900:493 with SMTP id
 z9-20020a17090a1fc900b002a219000493mr5337850pjz.40.1712561206901; 
 Mon, 08 Apr 2024 00:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp+nwhukXMnivhyYbopqHfIC5h1QXWBXFHXQ6GPN3HxVSxlz1Hzfib42zxjEMdJ3WDWOmIvx2IJSiEekfs7a0=
X-Received: by 2002:a17:90a:1fc9:b0:2a2:1900:493 with SMTP id
 z9-20020a17090a1fc900b002a219000493mr5337839pjz.40.1712561206634; Mon, 08 Apr
 2024 00:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240405112015.11919-1-adobriyan@yandex-team.ru>
In-Reply-To: <20240405112015.11919-1-adobriyan@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 15:26:35 +0800
Message-ID: <CACGkMEv-znr-sSXLHmBvcrLMDyrT739tqRQkcQbzLc4XPyU4ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-net: fix bug 1451 aka
 "assert(!virtio_net_get_subqueue(nc)->async_tx.elem); "
To: Alexey Dobriyan <adobriyan@yandex-team.ru>
Cc: qemu-devel@nongnu.org, adobriyan@gmail.com, mst@redhat.com, 
 vsementsov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
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

On Fri, Apr 5, 2024 at 7:22=E2=80=AFPM Alexey Dobriyan <adobriyan@yandex-te=
am.ru> wrote:
>
> Don't send zero length packets in virtio_net_flush_tx().
>
> Reproducer from https://gitlab.com/qemu-project/qemu/-/issues/1451
> creates small packet (1 segment, len =3D 10 =3D=3D n->guest_hdr_len),
> destroys queue.
>
> "if (n->host_hdr_len !=3D n->guest_hdr_len)" is triggered, if body create=
s
> zero length/zero segment packet, because there is nothing after guest
> header.

And in this case host_hdr_len is 0.

>
> qemu_sendv_packet_async() tries to send it.
>
> slirp discards it because it is smaller than Ethernet header,
> but returns 0.
>
> 0 length is propagated upwards and is interpreted as "packet has been sen=
t"
> which is terrible because queue is being destroyed, nothing has been sent=
,
> nobody is waiting for TX to complete and assert it triggered.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@yandex-team.ru>
> ---
>  hw/net/virtio-net.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 58014a92ad..258633f885 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2765,18 +2765,14 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue=
 *q)
>          out_sg =3D elem->out_sg;
>          if (out_num < 1) {
>              virtio_error(vdev, "virtio-net header not in first element")=
;
> -            virtqueue_detach_element(q->tx_vq, elem, 0);
> -            g_free(elem);
> -            return -EINVAL;
> +            goto detach;
>          }
>
>          if (n->has_vnet_hdr) {
>              if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) =
<
>                  n->guest_hdr_len) {
>                  virtio_error(vdev, "virtio-net header incorrect");
> -                virtqueue_detach_element(q->tx_vq, elem, 0);
> -                g_free(elem);
> -                return -EINVAL;
> +                goto detach;
>              }
>              if (n->needs_vnet_hdr_swap) {
>                  virtio_net_hdr_swap(vdev, (void *) &vhdr);
> @@ -2807,6 +2803,11 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue =
*q)
>                               n->guest_hdr_len, -1);
>              out_num =3D sg_num;
>              out_sg =3D sg;
> +
> +            if (iov_size(out_sg, out_num) =3D=3D 0) {
> +                virtio_error(vdev, "virtio-net nothing to send");
> +                goto detach;
> +            }

Nit, I think we can do this check before the iov_copy()?

Thanks

>          }
>
>          ret =3D qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_=
index),
> @@ -2827,6 +2828,11 @@ drop:
>          }
>      }
>      return num_packets;
> +
> +detach:
> +    virtqueue_detach_element(q->tx_vq, elem, 0);
> +    g_free(elem);
> +    return -EINVAL;
>  }
>
>  static void virtio_net_tx_timer(void *opaque);
> --
> 2.34.1
>


