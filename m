Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB259C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 06:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru5Ie-0006pg-HI; Tue, 09 Apr 2024 02:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5Ic-0006pO-J2
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 02:49:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5IZ-0001c9-Gp
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 02:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712645377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GxdEMEnvJp0prgraFJkiygpZvNlGz6/xsvms31K1e+I=;
 b=TjKrO80ai0G8IibyrXsEDnQe871AjuMjeAyHCCsqbLwd8eAWjt7WaKyTTu3aLhgY4eUdru
 +f1N5MZpRJwy9KO+57xxrv6iMqvaut3QcVptBTtwe3eUNhOvnZDMguOWF4SG1V5OCCy/jz
 SrN2Yx3Xfv5z88kYFCPo0M6MaBWnhhc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-S_TjNWBKPFKhJLrtN_Cuig-1; Tue, 09 Apr 2024 02:49:36 -0400
X-MC-Unique: S_TjNWBKPFKhJLrtN_Cuig-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a51c03c9b8bso90761066b.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 23:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712645375; x=1713250175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxdEMEnvJp0prgraFJkiygpZvNlGz6/xsvms31K1e+I=;
 b=AgcAZ7XuhC/POpIq3ew8xd1sK42ars0Zpde3rBBYzXqEOx6S7NcexDYVwKIBJXfwgo
 HNPzTZDOetQQtpSvFUWi4b5e0uE/EyeJoNwjzP42J9J6uPSONZuLcn4nrZc9hg9xVAli
 71b2Vc5bq1kIJzaNamnLdh+nRP5GzEn30WCh9lUetbrro+yRFBcUk9AdT/WljyDQXBC2
 LTxSNfpxVWNfsGcXkyeJPS0pHTD4JwCDu3H5wq8iXwaA+omaAx9dOz37GIzbJtmlDUoy
 b/qePcnuwmUK/gyMPCNsZ7BECiJ3Dq6Ag712JYIOtDt6/PGgYYuBPgen5KUpCG0rgQH2
 Ibog==
X-Gm-Message-State: AOJu0YzfxaK2IMUN2/scc/Pma3yNOWVrwOkPh4Xg8PfA5S+qTYMKkM3y
 zoDRncZlFQQ8MzX/a1RyRN1XGzNk4NN6drH2TWUXwRCYW5WC5AuLJOakU4Wp8lS+Yb9MQpSRGlW
 yRyteithxob1glYSE4Js1zACAUnmyelmu3C1FQOT/hYXs7QObvuQb
X-Received: by 2002:a17:906:eceb:b0:a51:bca7:3a93 with SMTP id
 qt11-20020a170906eceb00b00a51bca73a93mr4841681ejb.28.1712645374908; 
 Mon, 08 Apr 2024 23:49:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjKtsSez8/RBdjEQrW1y+gYgDcy5MzNzQCaNwjE4tmZ1PxW8+yZ3jp/aNZSbWySHEO/A689w==
X-Received: by 2002:a17:906:eceb:b0:a51:bca7:3a93 with SMTP id
 qt11-20020a170906eceb00b00a51bca73a93mr4841675ejb.28.1712645374364; 
 Mon, 08 Apr 2024 23:49:34 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 h19-20020a1709070b1300b00a51971dd79csm5386383ejl.143.2024.04.08.23.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 23:49:33 -0700 (PDT)
Date: Tue, 9 Apr 2024 02:49:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexey Dobriyan <adobriyan@yandex-team.ru>
Cc: qemu-devel@nongnu.org, adobriyan@gmail.com, jasowang@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 1/1] virtio-net: fix bug 1451 aka
 "assert(!virtio_net_get_subqueue(nc)->async_tx.elem);"
Message-ID: <20240409023928-mutt-send-email-mst@kernel.org>
References: <20240405112015.11919-1-adobriyan@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405112015.11919-1-adobriyan@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

On Fri, Apr 05, 2024 at 02:20:15PM +0300, Alexey Dobriyan wrote:
> Don't send zero length packets in virtio_net_flush_tx().
> 
> Reproducer from https://gitlab.com/qemu-project/qemu/-/issues/1451
> creates small packet (1 segment, len = 10 == n->guest_hdr_len),
> destroys queue.
> 
> "if (n->host_hdr_len != n->guest_hdr_len)" is triggered, if body creates
> zero length/zero segment packet, because there is nothing after guest
> header.
> 
> qemu_sendv_packet_async() tries to send it.
> 
> slirp discards it because it is smaller than Ethernet header,
> but returns 0.
> 
> 0 length is propagated upwards and is interpreted as "packet has been sent"
> which is terrible because queue is being destroyed, nothing has been sent,
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
> @@ -2765,18 +2765,14 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>          out_sg = elem->out_sg;
>          if (out_num < 1) {
>              virtio_error(vdev, "virtio-net header not in first element");
> -            virtqueue_detach_element(q->tx_vq, elem, 0);
> -            g_free(elem);
> -            return -EINVAL;
> +            goto detach;
>          }
>  
>          if (n->has_vnet_hdr) {
>              if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
>                  n->guest_hdr_len) {
>                  virtio_error(vdev, "virtio-net header incorrect");
> -                virtqueue_detach_element(q->tx_vq, elem, 0);
> -                g_free(elem);
> -                return -EINVAL;
> +                goto detach;
>              }
>              if (n->needs_vnet_hdr_swap) {
>                  virtio_net_hdr_swap(vdev, (void *) &vhdr);
> @@ -2807,6 +2803,11 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>                               n->guest_hdr_len, -1);
>              out_num = sg_num;
>              out_sg = sg;
> +
> +            if (iov_size(out_sg, out_num) == 0) {

calling iov_size an extra time on data path and scanning
a potentially long s/g list just so we can check
it's not 0 is not welcome, though.


won't the previous iov_copy return 0 in this case?

> +                virtio_error(vdev, "virtio-net nothing to send");
> +                goto detach;
> +            }
>          }
>  
>          ret = qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_index),
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


