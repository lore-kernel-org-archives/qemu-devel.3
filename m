Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACF9C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruETK-0005sT-Lv; Tue, 09 Apr 2024 12:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adobriyan@gmail.com>)
 id 1ruETI-0005sE-0H
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:37:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adobriyan@gmail.com>)
 id 1ruETA-0006yL-8i
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:37:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4169e385984so8711205e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712680628; x=1713285428; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fB6FduRxQytIaWIsdNHPZwA3/7llnAILeuGfl7TYaTM=;
 b=MTBOb1C2WyVlOHUL/zfrkl1aL5pOSeBukE32P0/28WkUR5aaxP7vI2cdPkyQHMD6yZ
 aiO4tHN4oFU6YIMlygf9xw+x2SaQ3ZK/vPTNqygo7++v8Ei7XGlu89eUn2fVI9TWpWzj
 xUS5R2BTnpidK+uL94V7pIxFF8OWU48vvmpIEmxpxBjlRhH1hY3nrAXQ4+lENety2Cim
 //PnKERTwXlkrSxO0jPAYydtEXIdBehnlPO3sxXu5PaUTnusTZPthaDwP89rUEx438tc
 YOJd4r5H5yYgvJyvRVf9wPGkQruz93WDCNECwwmJOW+zde4/tfWcX3mMdk423d+rFYru
 giHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712680628; x=1713285428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fB6FduRxQytIaWIsdNHPZwA3/7llnAILeuGfl7TYaTM=;
 b=suuuJxX38Puy3F3vrDSdtKmFSqR1D9OKIzd4nVWDkgcATwBLDUh2nv4Ifi83Wtaa+P
 pWwE0d0z3vwRnF9oJ5XDA5sJbau0kPkX/zb9aC87J938R/29WLs9coZu+GhIi0LwfzEg
 G+nLElBzyu8yZSGgXCpEYZFWpFqAV7v2RTqQfwwMTytJXqZEtB3bjVgTCKP73EaqMONZ
 wvESbCplM6W9B3ExKWboJOaQn5nlPbbKkPsdYMtSOs1B61c/FEITJ3st4TL5lYHZePYq
 Dmfs0WU0xrdwCprE00ENgaeYk5iV2adXVuKglZkvTPF7jwFO1J9wilq46yFKsW8JCq5j
 iSvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViBORA/m5SkoVNhtluQuVU6+1CqeH9SDZEoWNeSoPxZWOfY3VViL/pfUX880DaKOmNVDXlLPDYttWhxgv5exqlojug+bU=
X-Gm-Message-State: AOJu0YyAFIcSESJDfY+iV2Az8oR+0sqLSiba9v381/yTgLeY+HyXTjiY
 p+cEVZJy+Hzi7VteihKoImLZH/v8VPPW55vbWISEigvEACkHpF4=
X-Google-Smtp-Source: AGHT+IG2URpNZKSm4YUzzyARZVqzxjUMZyyhiKDJSOdNMCl5YpWtA8sQ1PtPMczovXqya0CWc2FPkA==
X-Received: by 2002:a05:600c:3b22:b0:416:6344:8948 with SMTP id
 m34-20020a05600c3b2200b0041663448948mr182969wms.2.1712680627937; 
 Tue, 09 Apr 2024 09:37:07 -0700 (PDT)
Received: from p183 ([46.53.249.134]) by smtp.gmail.com with ESMTPSA id
 p4-20020a05600c1d8400b00416b74deaf0sm1552039wms.33.2024.04.09.09.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:37:07 -0700 (PDT)
Date: Tue, 9 Apr 2024 19:37:04 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexey Dobriyan <adobriyan@yandex-team.ru>, qemu-devel@nongnu.org,
 jasowang@redhat.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH 1/1] virtio-net: fix bug 1451 aka
 "assert(!virtio_net_get_subqueue(nc)->async_tx.elem);"
Message-ID: <1270933f-ed20-4b59-b450-0ee4103a6eeb@p183>
References: <20240405112015.11919-1-adobriyan@yandex-team.ru>
 <20240409025022-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409025022-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=adobriyan@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 09, 2024 at 02:51:38AM -0400, Michael S. Tsirkin wrote:
> On Fri, Apr 05, 2024 at 02:20:15PM +0300, Alexey Dobriyan wrote:
> > Don't send zero length packets in virtio_net_flush_tx().
> > 
> > Reproducer from https://gitlab.com/qemu-project/qemu/-/issues/1451
> > creates small packet (1 segment, len = 10 == n->guest_hdr_len),
> > destroys queue.
> > 
> > "if (n->host_hdr_len != n->guest_hdr_len)" is triggered, if body creates
> > zero length/zero segment packet, because there is nothing after guest
> > header.
> > 
> > qemu_sendv_packet_async() tries to send it.
> > 
> > slirp discards it because it is smaller than Ethernet header,
> > but returns 0.
> 
> won't the same issue trigger with a 1 byte packet
> as opposed to a 0 byte packet though?

I don't think so. Only "return 0" is problematic from qemu_sendv_packet_async().
->deliver hooks are supposed to return total length, so 1 should be fine.

> > 0 length is propagated upwards and is interpreted as "packet has been sent"
> > which is terrible because queue is being destroyed, nothing has been sent,
> > nobody is waiting for TX to complete and assert it triggered.
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@yandex-team.ru>
> > ---
> >  hw/net/virtio-net.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 58014a92ad..258633f885 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -2765,18 +2765,14 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
> >          out_sg = elem->out_sg;
> >          if (out_num < 1) {
> >              virtio_error(vdev, "virtio-net header not in first element");
> > -            virtqueue_detach_element(q->tx_vq, elem, 0);
> > -            g_free(elem);
> > -            return -EINVAL;
> > +            goto detach;
> >          }
> >  
> >          if (n->has_vnet_hdr) {
> >              if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
> >                  n->guest_hdr_len) {
> >                  virtio_error(vdev, "virtio-net header incorrect");
> > -                virtqueue_detach_element(q->tx_vq, elem, 0);
> > -                g_free(elem);
> > -                return -EINVAL;
> > +                goto detach;
> >              }
> >              if (n->needs_vnet_hdr_swap) {
> >                  virtio_net_hdr_swap(vdev, (void *) &vhdr);
> > @@ -2807,6 +2803,11 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
> >                               n->guest_hdr_len, -1);
> >              out_num = sg_num;
> >              out_sg = sg;
> > +
> > +            if (iov_size(out_sg, out_num) == 0) {
> > +                virtio_error(vdev, "virtio-net nothing to send");
> > +                goto detach;
> > +            }
> >          }
> >  
> >          ret = qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_index),
> > @@ -2827,6 +2828,11 @@ drop:
> >          }
> >      }
> >      return num_packets;
> > +
> > +detach:
> > +    virtqueue_detach_element(q->tx_vq, elem, 0);
> > +    g_free(elem);
> > +    return -EINVAL;
> >  }
> >  
> >  static void virtio_net_tx_timer(void *opaque);
> > -- 
> > 2.34.1
> 

