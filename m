Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AAFC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 17:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruF4U-00048q-N6; Tue, 09 Apr 2024 13:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adobriyan@gmail.com>)
 id 1ruF4P-00047x-3p
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:15:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adobriyan@gmail.com>)
 id 1ruF4I-0005iF-4u
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:15:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4169ebcc924so8828085e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712682930; x=1713287730; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uqoAzk/rcyHsRiN93dZu/zo/voGsLmoiCY/kzMq2aC0=;
 b=A74jfZ4YYIkXFUasYOZe6Auf4N1cp9rzLEX4G8PL65I/lllluZnR1mbWXqTJ3QnRJt
 oJPxufVPJ1os9DTKbLbHInpMcaVHfl0ZEvovLgnC3C8oukqRJ7qXdDkMF2gtHrEMXwkQ
 xFInHTg5LBQEWyGJR/AHwX3ATCLrnd6An5DyQN4MdKqENk53+F8Cs0DJJlnjfUMya3up
 dttkpkwNxrm6UZjOyrSZoxZnbb7Y/h0pVrPcYybQW/UY/ZHZQ6/iQKo1vk7NV5ohH3Sj
 eQiSa3T2jGxnjehiv7FeIXX+0abh3jQ/Cz99uew1hZbWyKOahfroSXmFIP/ruKMBNzE+
 ew7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712682930; x=1713287730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqoAzk/rcyHsRiN93dZu/zo/voGsLmoiCY/kzMq2aC0=;
 b=BgABKUBgjC6hZoEUS6XXkddHDkpwuyKd7wkwP6rDE/CF68K9ReJ1wv4De6ZCgLHil7
 gEFZgPYBHi/+6m6m/5l4b4ItiCHkd/3X5I7Z5ZcTgdS0w6r7mjldwMpbWRU5zhvhSfCk
 wtdwha3hbGcHwuxNyPJjGe/iIoXG0bBPwX8NDIc77EHncfhpeEHQ/v4oQf9jzT6M4CnW
 4KoujnnpXTB5mtpR8axozk7xbZCuRR8g3oJCFbsQ8LYW68FMxfrlRczupG9O4aZO5YlA
 Kpu1JsWhr23AERZ2zfn6tM2jGXNC61D0qfbEtdbioVMkP9pU+BEtBWzcpFfnC4NU0F0n
 OwnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5AYKDpL+el6ZpvPA84hPNwbTNOat3B5rh0foTi5PO+GAX6rVg6jU2bVY+lNIZmphsIh72cobrnM9wbETnW/AtMSoW7wY=
X-Gm-Message-State: AOJu0YyU21xDUufplzT5B9D7eutL1Zg3wd0mtsFWRAjVB5qfFNtUvC6w
 qS6kZ/EynMLOa5FHSXNBRP1h9tU8rVxSoPDzNgw4doSNaUcS8ng=
X-Google-Smtp-Source: AGHT+IHOi45WSegR+OBmeOUTNMonp/YQsUwhOaZ3gcQBDX5/pDxq1WVVqzlBlhTpzlpTSpus0mPAxA==
X-Received: by 2002:a05:600c:45ce:b0:414:7b3b:ca7c with SMTP id
 s14-20020a05600c45ce00b004147b3bca7cmr261374wmo.14.1712682929791; 
 Tue, 09 Apr 2024 10:15:29 -0700 (PDT)
Received: from p183 ([46.53.249.134]) by smtp.gmail.com with ESMTPSA id
 i21-20020a05600c355500b0041665b6e111sm9296596wmq.12.2024.04.09.10.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 10:15:29 -0700 (PDT)
Date: Tue, 9 Apr 2024 20:15:27 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexey Dobriyan <adobriyan@yandex-team.ru>, qemu-devel@nongnu.org,
 jasowang@redhat.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH 1/1] virtio-net: fix bug 1451 aka
 "assert(!virtio_net_get_subqueue(nc)->async_tx.elem);"
Message-ID: <8e95e5be-dd39-498b-b527-52f34fb0ba43@p183>
References: <20240405112015.11919-1-adobriyan@yandex-team.ru>
 <20240409025022-mutt-send-email-mst@kernel.org>
 <1270933f-ed20-4b59-b450-0ee4103a6eeb@p183>
 <20240409124038-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409124038-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=adobriyan@gmail.com; helo=mail-wm1-x32c.google.com
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

On Tue, Apr 09, 2024 at 12:41:39PM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 09, 2024 at 07:37:04PM +0300, Alexey Dobriyan wrote:
> > On Tue, Apr 09, 2024 at 02:51:38AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Apr 05, 2024 at 02:20:15PM +0300, Alexey Dobriyan wrote:
> > > > Don't send zero length packets in virtio_net_flush_tx().
> > > > 
> > > > Reproducer from https://gitlab.com/qemu-project/qemu/-/issues/1451
> > > > creates small packet (1 segment, len = 10 == n->guest_hdr_len),
> > > > destroys queue.
> > > > 
> > > > "if (n->host_hdr_len != n->guest_hdr_len)" is triggered, if body creates
> > > > zero length/zero segment packet, because there is nothing after guest
> > > > header.
> > > > 
> > > > qemu_sendv_packet_async() tries to send it.
> > > > 
> > > > slirp discards it because it is smaller than Ethernet header,
> > > > but returns 0.
> > > 
> > > won't the same issue trigger with a 1 byte packet
> > > as opposed to a 0 byte packet though?
> > 
> > I don't think so. Only "return 0" is problematic from qemu_sendv_packet_async().
> > ->deliver hooks are supposed to return total length, so 1 should be fine.
> 
> 
> But you said it's smaller than Ethernet is the problem?

No, the problem is iov_cnt=0 packet is being generated, which enters
qemu_sendv_packet_async(), discarded inside slirp driver, but
net_slirp_receive() returns 0 which is the length of meaningless packet.
which is propagated upwards.

> > > > 0 length is propagated upwards and is interpreted as "packet has been sent"
> > > > which is terrible because queue is being destroyed, nothing has been sent,
> > > > nobody is waiting for TX to complete and assert it triggered.
> > > > 
> > > > Signed-off-by: Alexey Dobriyan <adobriyan@yandex-team.ru>
> > > > ---
> > > >  hw/net/virtio-net.c | 18 ++++++++++++------
> > > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > index 58014a92ad..258633f885 100644
> > > > --- a/hw/net/virtio-net.c
> > > > +++ b/hw/net/virtio-net.c
> > > > @@ -2765,18 +2765,14 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
> > > >          out_sg = elem->out_sg;
> > > >          if (out_num < 1) {
> > > >              virtio_error(vdev, "virtio-net header not in first element");
> > > > -            virtqueue_detach_element(q->tx_vq, elem, 0);
> > > > -            g_free(elem);
> > > > -            return -EINVAL;
> > > > +            goto detach;
> > > >          }
> > > >  
> > > >          if (n->has_vnet_hdr) {
> > > >              if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
> > > >                  n->guest_hdr_len) {
> > > >                  virtio_error(vdev, "virtio-net header incorrect");
> > > > -                virtqueue_detach_element(q->tx_vq, elem, 0);
> > > > -                g_free(elem);
> > > > -                return -EINVAL;
> > > > +                goto detach;
> > > >              }
> > > >              if (n->needs_vnet_hdr_swap) {
> > > >                  virtio_net_hdr_swap(vdev, (void *) &vhdr);
> > > > @@ -2807,6 +2803,11 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
> > > >                               n->guest_hdr_len, -1);
> > > >              out_num = sg_num;
> > > >              out_sg = sg;
> > > > +
> > > > +            if (iov_size(out_sg, out_num) == 0) {
> > > > +                virtio_error(vdev, "virtio-net nothing to send");
> > > > +                goto detach;
> > > > +            }
> > > >          }
> > > >  
> > > >          ret = qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_index),
> > > > @@ -2827,6 +2828,11 @@ drop:
> > > >          }
> > > >      }
> > > >      return num_packets;
> > > > +
> > > > +detach:
> > > > +    virtqueue_detach_element(q->tx_vq, elem, 0);
> > > > +    g_free(elem);
> > > > +    return -EINVAL;
> > > >  }
> > > >  
> > > >  static void virtio_net_tx_timer(void *opaque);
> > > > -- 
> > > > 2.34.1
> > > 
> 

