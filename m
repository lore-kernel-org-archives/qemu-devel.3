Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1A9C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEYF-0008DV-8v; Tue, 09 Apr 2024 12:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ruEYC-0008DF-LF
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ruEXs-0007mh-56
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712680916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zn/TPk6Mc6LnljpxdQRL0WrH5VSJF6KCWAWDgqt7x70=;
 b=Lodo1V+WwmZmffx4cTJA8/9iOao9ZAC4D0IfTV1WAUcmkVT/wZFUVI8c8ujZOCqkOvYDIh
 NOL8t/agtD3e2fLkeOWL29/g8GeAjA0Zg0RQ9mzxJfTooOY1cXLTsSfx59A92pztRn8xVY
 ZULd9Kcg7C0e8k9UZu9ZdGnFmUgRLtk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-RPchDGbANSm_517vTqnESg-1; Tue, 09 Apr 2024 12:41:52 -0400
X-MC-Unique: RPchDGbANSm_517vTqnESg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-56e4827e584so2941650a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712680911; x=1713285711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zn/TPk6Mc6LnljpxdQRL0WrH5VSJF6KCWAWDgqt7x70=;
 b=hw0aKkQPLwR7MfkrA2E98Y+VjuX8VXhLX80I1dpBWpet+asXmKQ8cym8fdENqF/N/o
 57x3aJc45S0419x/gO/ItRga7uQNylfh5MvofPp+fL+b9NxC2za1ADTqNUqy077S4WCS
 s6D5Rzg19pv/GHxSkEnO4XfKjGpB7BDMKNtqC5cV7hc1mmtqTlvqVDcn2DPYnOtUXWgU
 6MaolbO4b1wG0J3WnT4Gq7yQOTDWvHY7a9fKT8SsbhfGrdORuBlfbhQrvDuXxXM5lZm6
 DvI2Ufwt9XR59aGJcoRjsCGTk+bYZNPGNMZaPmlngMMIgpHyWrJF9HbzCRYKlAov5oNd
 U5fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk9GFvnbQKHFFJEcu5Szj0x2FugUkc1vYPxQzfVYDjTCEGsv9+3D5N4Di+ALWi+th46j/vj4FhSmN5GNsma9ICn068JtI=
X-Gm-Message-State: AOJu0YwcCX2mQcLzcn3OU5PqNCLDr/m7P7/2ocmeDuI/a5sFljDAUQOE
 Y5bw9vdqtAZG6PhQtUeo6MOVqDWD5Ax27ev88wO2XZVUrCgEvFRhBSiqPBpwcBZvuqU3gCvYTdt
 RTfva00ETu/spvDPAr592YlnMiLeDibJk/VtfMC5kEN6Y/jwBYNF2
X-Received: by 2002:a05:6402:11cd:b0:56e:6f6a:9575 with SMTP id
 j13-20020a05640211cd00b0056e6f6a9575mr2713892edw.1.1712680911216; 
 Tue, 09 Apr 2024 09:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR9n8Zxa63ei5rz/ajVx77r+yyqId7csThq0GBQd4lHUSJosftKQbHw5g1cj3pM78tSeaJRg==
X-Received: by 2002:a05:6402:11cd:b0:56e:6f6a:9575 with SMTP id
 j13-20020a05640211cd00b0056e6f6a9575mr2713871edw.1.1712680910673; 
 Tue, 09 Apr 2024 09:41:50 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 x26-20020aa7d6da000000b0056e460eda12sm4125740edr.55.2024.04.09.09.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:41:50 -0700 (PDT)
Date: Tue, 9 Apr 2024 12:41:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Alexey Dobriyan <adobriyan@yandex-team.ru>, qemu-devel@nongnu.org,
 jasowang@redhat.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH 1/1] virtio-net: fix bug 1451 aka
 "assert(!virtio_net_get_subqueue(nc)->async_tx.elem);"
Message-ID: <20240409124038-mutt-send-email-mst@kernel.org>
References: <20240405112015.11919-1-adobriyan@yandex-team.ru>
 <20240409025022-mutt-send-email-mst@kernel.org>
 <1270933f-ed20-4b59-b450-0ee4103a6eeb@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1270933f-ed20-4b59-b450-0ee4103a6eeb@p183>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Apr 09, 2024 at 07:37:04PM +0300, Alexey Dobriyan wrote:
> On Tue, Apr 09, 2024 at 02:51:38AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Apr 05, 2024 at 02:20:15PM +0300, Alexey Dobriyan wrote:
> > > Don't send zero length packets in virtio_net_flush_tx().
> > > 
> > > Reproducer from https://gitlab.com/qemu-project/qemu/-/issues/1451
> > > creates small packet (1 segment, len = 10 == n->guest_hdr_len),
> > > destroys queue.
> > > 
> > > "if (n->host_hdr_len != n->guest_hdr_len)" is triggered, if body creates
> > > zero length/zero segment packet, because there is nothing after guest
> > > header.
> > > 
> > > qemu_sendv_packet_async() tries to send it.
> > > 
> > > slirp discards it because it is smaller than Ethernet header,
> > > but returns 0.
> > 
> > won't the same issue trigger with a 1 byte packet
> > as opposed to a 0 byte packet though?
> 
> I don't think so. Only "return 0" is problematic from qemu_sendv_packet_async().
> ->deliver hooks are supposed to return total length, so 1 should be fine.


But you said it's smaller than Ethernet is the problem?

> > > 0 length is propagated upwards and is interpreted as "packet has been sent"
> > > which is terrible because queue is being destroyed, nothing has been sent,
> > > nobody is waiting for TX to complete and assert it triggered.
> > > 
> > > Signed-off-by: Alexey Dobriyan <adobriyan@yandex-team.ru>
> > > ---
> > >  hw/net/virtio-net.c | 18 ++++++++++++------
> > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 58014a92ad..258633f885 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -2765,18 +2765,14 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
> > >          out_sg = elem->out_sg;
> > >          if (out_num < 1) {
> > >              virtio_error(vdev, "virtio-net header not in first element");
> > > -            virtqueue_detach_element(q->tx_vq, elem, 0);
> > > -            g_free(elem);
> > > -            return -EINVAL;
> > > +            goto detach;
> > >          }
> > >  
> > >          if (n->has_vnet_hdr) {
> > >              if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
> > >                  n->guest_hdr_len) {
> > >                  virtio_error(vdev, "virtio-net header incorrect");
> > > -                virtqueue_detach_element(q->tx_vq, elem, 0);
> > > -                g_free(elem);
> > > -                return -EINVAL;
> > > +                goto detach;
> > >              }
> > >              if (n->needs_vnet_hdr_swap) {
> > >                  virtio_net_hdr_swap(vdev, (void *) &vhdr);
> > > @@ -2807,6 +2803,11 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
> > >                               n->guest_hdr_len, -1);
> > >              out_num = sg_num;
> > >              out_sg = sg;
> > > +
> > > +            if (iov_size(out_sg, out_num) == 0) {
> > > +                virtio_error(vdev, "virtio-net nothing to send");
> > > +                goto detach;
> > > +            }
> > >          }
> > >  
> > >          ret = qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_index),
> > > @@ -2827,6 +2828,11 @@ drop:
> > >          }
> > >      }
> > >      return num_packets;
> > > +
> > > +detach:
> > > +    virtqueue_detach_element(q->tx_vq, elem, 0);
> > > +    g_free(elem);
> > > +    return -EINVAL;
> > >  }
> > >  
> > >  static void virtio_net_tx_timer(void *opaque);
> > > -- 
> > > 2.34.1
> > 


