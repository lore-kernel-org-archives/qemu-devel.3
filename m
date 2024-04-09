Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BCFCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 12:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruAmb-0000bd-Ks; Tue, 09 Apr 2024 08:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adobriyan@gmail.com>)
 id 1ru4Y0-0003jP-4V
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 02:01:32 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adobriyan@gmail.com>)
 id 1ru4Xw-0008SK-Ql
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 02:01:30 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-516dc51bb72so3295652e87.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 23:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712642486; x=1713247286; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NQD7qerk0+z1kLV8gnPc3cxn642KJVL5ZZhdatZuU24=;
 b=G0s5Qjd+5lpTXqnK9cj3NswJjgy9yCEq9Gi32wSaqYGZZe4HR7a+1k94ygL37DL5pd
 OQNLL8qoV6bq5FKh16CZXR6dqY1e0UGPQdmYICuvW74MG3v1Agj3jjfvrfcpCxDj6K9c
 aLg9QWbzLldnGFOrPx5g5WU7IWYQxekcgi7J3gY2dCsf69wh5saxsHoEj2JJGQztyjbG
 Lj5gxmDvN/3n6mfXMgKQUSeT1g3yBrB3B7xHTrIC2plufScj3P3T+f661cuBxhGDp8A7
 3rdx/cXz7LR0NZWoNrV5/2ETUiVdfwtJ56oQuyTFYkf4iNHOR9/aVAF0o03nqDtY3F3c
 4XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712642486; x=1713247286;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NQD7qerk0+z1kLV8gnPc3cxn642KJVL5ZZhdatZuU24=;
 b=RdksfjHcLQ7OVAcoruTXtp1f4cVXp8CsneLTaC3l+ECy4GjtAufoNFONfSol+UCCk6
 oA0OJsGCTmpjxCyjzLnFG6Go6c0seuxuVViw9LBNhZz60JlU8uPvt+87MhI1ixA2O4OF
 rH826xHb/NymflKDpiReOSPMV1+e8meSiGcFbiYkg0Nby1uoEK2XVNprfSuzRoULnnWA
 XvQRKDECPm0ueQInGMKhyg84yNFK9ENCrLaEbnQwW/XcNOQGkIqS6kLW+OucCf1Swy9L
 k8/6VXUnnNQ79+DzPDEm0L6tlzjLakl5pVtqabMevtJA4GTbJFPbOykbgj0AamUPkEof
 iycg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5KzVATLY4119Wc39+gdNaLwVwbra8rqpDUvkLjNBtY2Wx+Wntoc0ogwz92AZxszqDB+dz/drZaXozXquKISYHZWWd5mo=
X-Gm-Message-State: AOJu0Yy/VI6pdf7r80YPlxNcR5bm8movrsJYv5BB/aciqZDfU9lOXsDf
 5ZYBsaxSduFtNJV2p4eTWYqrMF5xNKLpjh7yok05e/LG05tDiQo=
X-Google-Smtp-Source: AGHT+IHKA5mSD1VLyUbbpk3j8rPO9I+e5DLXR6FyjgWpfQMtTgK+6k3ucibr3opMaVHna37XWyALAQ==
X-Received: by 2002:a05:6512:4015:b0:513:d1c7:7d37 with SMTP id
 br21-20020a056512401500b00513d1c77d37mr8781046lfb.51.1712642485852; 
 Mon, 08 Apr 2024 23:01:25 -0700 (PDT)
Received: from p183 ([46.53.248.67]) by smtp.gmail.com with ESMTPSA id
 fm13-20020a05600c0c0d00b00416458c71f2sm10312007wmb.45.2024.04.08.23.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 23:01:25 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:01:23 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Alexey Dobriyan <adobriyan@yandex-team.ru>, qemu-devel@nongnu.org,
 mst@redhat.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH 1/1] virtio-net: fix bug 1451 aka
 "assert(!virtio_net_get_subqueue(nc)->async_tx.elem);"
Message-ID: <f5628612-9cc2-4ff1-8a36-a26830c9f098@p183>
References: <20240405112015.11919-1-adobriyan@yandex-team.ru>
 <CACGkMEv-znr-sSXLHmBvcrLMDyrT739tqRQkcQbzLc4XPyU4ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv-znr-sSXLHmBvcrLMDyrT739tqRQkcQbzLc4XPyU4ZQ@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=adobriyan@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Apr 2024 08:40:58 -0400
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

On Mon, Apr 08, 2024 at 03:26:35PM +0800, Jason Wang wrote:
> On Fri, Apr 5, 2024 at 7:22 PM Alexey Dobriyan <adobriyan@yandex-team.ru> wrote:
> >
> > Don't send zero length packets in virtio_net_flush_tx().
> >
> > Reproducer from https://gitlab.com/qemu-project/qemu/-/issues/1451
> > creates small packet (1 segment, len = 10 == n->guest_hdr_len),
> > destroys queue.
> >
> > "if (n->host_hdr_len != n->guest_hdr_len)" is triggered, if body creates
> > zero length/zero segment packet, because there is nothing after guest
> > header.
> 
> And in this case host_hdr_len is 0.

Yes.

> > qemu_sendv_packet_async() tries to send it.
> >
> > slirp discards it because it is smaller than Ethernet header,
> > but returns 0.
> >
> > 0 length is propagated upwards and is interpreted as "packet has been sent"
> > which is terrible because queue is being destroyed, nothing has been sent,
> > nobody is waiting for TX to complete and assert it triggered.

> > @@ -2807,6 +2803,11 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
> >                               n->guest_hdr_len, -1);
> >              out_num = sg_num;
> >              out_sg = sg;
> > +
> > +            if (iov_size(out_sg, out_num) == 0) {
> > +                virtio_error(vdev, "virtio-net nothing to send");
> > +                goto detach;
> > +            }
> 
> Nit, I think we can do this check before the iov_copy()?

I'd rather check for "badness" right before emitting packet.

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
> >
> 

