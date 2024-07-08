Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E358C3DA41
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 03:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQewj-0000OV-Gl; Sun, 07 Jul 2024 23:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sQewh-0000D7-If
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 23:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sQewf-0005Un-Ht
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 23:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720408897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9qsxE2Bl0meYSIeOd93gXq+RAu4CTeyiBXWxH1fg3c=;
 b=DKpaIWdiKtlYTl8oo9aLIn7kJAVN80ed/R+TOm+GQHetx8YbNf1a1uCuiO7OWHdUHnN2eE
 MKFNyQDHi4rs8VMmN742Ib2U4gdbPySv10poZXscoycE3WkkUXcgJTgHayEQrq0eWDBk6G
 hjQDvBFraircptnlAeGmnb9JDOh9Fb8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-nVG_3EyNNQOS4bo0cq1UeQ-1; Sun, 07 Jul 2024 23:21:35 -0400
X-MC-Unique: nVG_3EyNNQOS4bo0cq1UeQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-703674b18cfso1100502a34.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 20:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720408895; x=1721013695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9qsxE2Bl0meYSIeOd93gXq+RAu4CTeyiBXWxH1fg3c=;
 b=ofI7ZMb97t5ixNtqaKzK5EjyaWp9KpiHNFk+DcJ+ZaGepOhFCrswMSPSwfc9yGv132
 +/0VtR4xgRnsh2P5rIhLdiAYCruthuLa1Fto8Tfn1tzsmf1PEIGM75ixj01k63qDOWSR
 tKn76kfk1IUnjAJoPN0UEe51N1wSSS5ZvFQgCBEu6gnRVpCxzE8+jHH9uCVpWxfZmV8E
 6E1Jrg35yGs65Snr3H0VRTJW8ZrWlACV6cZ5bykrZK+o2DTH6iXWRadl849WaYOqqC+V
 l/oiLDk1JX/9zB3PsFTIHIhG/cAgAkBIopPfcO6AwmoQDKwZGizoWj5vBKT7l3c/bHk0
 9IAQ==
X-Gm-Message-State: AOJu0Yw9cJIHnpNJooava9iATS5cHnsOMqsNSJ0+WLdl8r90hU8nsUSJ
 lWcaOnh7DFAhHIWIsJ+OtH9VnUhNPOyIPEbK5/1q/9b+ds/DZbxUTi7odOhyohtddIMlriRR/Bf
 fV88nzqGPxHiMAjthI9+vk7xfQTMke/VxMwyf0M2Zl9DZ8ghJWezq6h/B+aAnIm5PdOAr6QBU/b
 OGEOGrSSYKTDJy4SW/HlBzpj4ah3E=
X-Received: by 2002:a05:6358:988e:b0:1a6:1ed1:2366 with SMTP id
 e5c5f4694b2df-1aa98c244b0mr1070706355d.16.1720408894868; 
 Sun, 07 Jul 2024 20:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTUCTDqqh+ud0IltVlQwda8t9OMK6YYZPf7ayojxtDTjflpc0nLFHQJcM73bkvlaTVrq7zHJEKUDQLExDS1fo=
X-Received: by 2002:a05:6358:988e:b0:1a6:1ed1:2366 with SMTP id
 e5c5f4694b2df-1aa98c244b0mr1070705155d.16.1720408894433; Sun, 07 Jul 2024
 20:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
In-Reply-To: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 11:21:18 +0800
Message-ID: <CACGkMEuX+FxOtWD9YoMF-T_VsgMezCT5ff_5Wk5CwQ3kNu41Aw@mail.gmail.com>
Subject: Re: [PATCH] e1000: Fix the unexpected assumption that the receive
 buffer is full
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Sat, Jul 6, 2024 at 4:30=E2=80=AFAM Hyman Huang <yong.huang@smartx.com> =
wrote:
>
> Unexpected work by certain Windows guests equipped with the e1000
> interface can cause the network to go down and never come back up
> again unless the guest's interface is reset.
>
> To reproduce the failure:
> 1. Set up two guests with a Windows 2016 or 2019 server operating
>    system.

I vaguely remember e1000 support for Windows has been deprecated for
several years...

That's why e1000e or igb is implemented in Qemu.

> 2. Set up the e1000 interface for the guests.
> 3. Pressurize the network slightly between two guests using the iPerf too=
l.
>
> The network goes down after a few days (2-5days), and the issue
> is the result of not adhering to the e1000 specification. Refer
> to the details of the specification at the following link:
> https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-control=
lers-software-dev-manual.pdf
>
> Chapter 3.2.6 describe the Receive Descriptor Tail register(RDT)
> as following:
> This register holds a value that is an offset from the base, and
> identifies the location beyond the last descriptor hardware can
> process. Note that tail should still point to an area in the
> descriptor ring (somewhere between RDBA and RDBA + RDLEN).
> This is because tail points to the location where software writes
> the first new descriptor.
>
> This means that if the provider=E2=80=94in this case, QEMU=E2=80=94has no=
t yet
> loaded the packet,

What do you mean by "load" here?

> RDT should never point to that place.

And "that place"?

> When
> implementing the emulation of the e1000 interface, QEMU evaluates
> if the receive ring buffer is full once the RDT equals the RDH,
> based on the assumption that guest drivers adhere to this
> criterion strictly.
>
> We applied the following log patch to assist in analyzing the
> issue and eventually obtained the unexpected information.
>
> Log patch:
> -----------------------------------------------------------------
> |--- a/hw/net/e1000.c
> |+++ b/hw/net/e1000.c
> |@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)
> | static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
> | {
> |     int bufs;
> |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u, s->mac_reg=
[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH], s->mac_re=
g[RDT]);
> |+
> |     /* Fast-path short packets */
> |     if (total_size <=3D s->rxbuf_size) {
> |         if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] && s->last_overrun)
> |@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, const struct=
 iovec *iov, int iovcnt)
> |         s->rxbuf_min_shift)
> |         n |=3D E1000_ICS_RXDMT0;
> |
> |+    DBGOUT(RX, "rxbuf_size =3D %u, s->mac_reg[RDLEN] =3D %u, s->mac_reg=
[RDH] =3D %u, s->mac_reg[RDT] =3D %u\n",
> |+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH], s->mac_re=
g[RDT]);
> |+
> -----------------------------------------------------------------
>
> The last few logs of information when the network is down:
>
> e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 16384=
, s->mac_reg[RDH] =3D 897, s->mac_reg[RDT] =3D 885
> <- the receive ring buffer is checked for fullness in the
> e1000_has_rxbufs function, not full.
>
> e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 1638=
4, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> <- RDT stays the same, RDH updates to 898, and 1 descriptor
> utilized after putting the packet to ring buffer.
>
> e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 16384=
, s->mac_reg[RDH] =3D 898, s->mac_reg[RDT] =3D 885
> <- the receive ring buffer is checked for fullness in the
> e1000_has_rxbufs function, not full.
>
> e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 1638=
4, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> <- RDT stays the same, RDH updates to 899, and 1 descriptor
> utilized after putting the packet to ring buffer.
>
> e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 16384=
, s->mac_reg[RDH] =3D 899, s->mac_reg[RDT] =3D 885
> <- the receive ring buffer is checked for fullness in the
> e1000_has_rxbufs function, not full.
>
> e1000: total_size =3D 64, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 1638=
4, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 885
> <- RDT stays the same, RDH updates to 900 , and 1 descriptor
> utilized after putting the packet to ring buffer.
>
> e1000: total_size =3D 1, rxbuf_size =3D 2048, s->mac_reg[RDLEN] =3D 16384=
, s->mac_reg[RDH] =3D 900, s->mac_reg[RDT] =3D 900
> <- The ring is full, according to e1000_has_rxbufs, because
> of the RDT update to 900 and equals RDH !

Just to make sure I understand this, RDT=3D=3DRDH means the ring is empty I=
 think?

See commit:

commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
Author: Dmitry Fleytman <dmitry@daynix.com>
Date:   Fri Oct 19 07:56:55 2012 +0200

    e1000: drop check_rxov, always treat RX ring with RDH =3D=3D RDT as emp=
ty

    Real HW always treats RX ring with RDH =3D=3D RDT as empty.
    Emulation is supposed to behave the same.

    Reported-by: Chris Webb <chris.webb@elastichosts.com>
    Reported-by: Richard Davies <richard.davies@elastichosts.com>
    Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Or did you mean we need to revert the above commit in fact?

Thanks


