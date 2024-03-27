Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7C0C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 02:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpJN8-0004yr-Ka; Tue, 26 Mar 2024 22:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpJN6-0004yW-62
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpJN4-0001qR-8q
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711507833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OQAzJjBU1ZX2nNF5nWSkeUDWXgJGMC6FyHsha2mxtM=;
 b=inYoqayS56O52+RGZIua/H0XJCXmehFkfzK7yQkYF3tQkvWdr+/iNZWHxQroyJSZk6GQN0
 39uqPCZo4eJ63MKZYl2+58fd8C39qM01+Qwa0nOJs7Aq9GXj6nV7sdBvgw44wWfZrLshuY
 nZEEGcq4oD7kx0WRP2VSgLla7HAOVWQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-mrrvQMeAPmO_jNnaMed-JA-1; Tue, 26 Mar 2024 22:50:30 -0400
X-MC-Unique: mrrvQMeAPmO_jNnaMed-JA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29feefd1a95so4987429a91.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 19:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711507829; x=1712112629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OQAzJjBU1ZX2nNF5nWSkeUDWXgJGMC6FyHsha2mxtM=;
 b=T4D599cp8g2Ewdkoh25qOCpAuRW9z7/76Hk1etU9e8da/Ijr0HdtuCfFZjfAXZGZm8
 Y6ucdW8aFv0GVp/sUJnUU62R2x7VWbSIVwuxEDo943GeASIViBRYqEJZsz/+lpWKdkds
 Klp9Aglk1tNG1tWUoFGnpLjrIwEyrLbkw1TppY58FcL5Yxv7iBr42Wq4ox9GDroFKAyU
 34RgwXxj/ZVlp9K9IL3utBGH2W6H8o+cpXO73F5nHjisp3ZeEZvWuOFrFhEeWvz/JewC
 K11eACxTNXH3t8ylZnV/kGcRLzwge2Kh+pf7Se9RV64yktpqd8/yHtvkgX1Z/AhU0XJf
 TGWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAkhbYMBwlRr1wJ1cc5gWVJszlz/7g+wUiyNGX0uMFRrQsTrYPn4Brx0+KVcQO24sd3Uc6grt4J6hrTber5CNFpSSGyn4=
X-Gm-Message-State: AOJu0YzelvGstjMelQtrWr0K71XjH3o+Fn2wrEx20ouk8cl94xXbh37G
 hd8/wue3zo+Nt8sHmSXlSy0BMEPZA0EteYv6EP8tMT3YdHPcYVtfFeT50SB3zCcoRP7zyssoL7q
 TlcgU/f35VLjWY40w36gnIfqpCinWGKyPX8knnD+tvTfxldeeSTpXeU/NmQZGlON8arWWf2Ufut
 7s5Suq79lY1Jv+aASx/t0MrqwtNp0=
X-Received: by 2002:a17:90a:dd88:b0:29f:6bfa:207d with SMTP id
 l8-20020a17090add8800b0029f6bfa207dmr1665362pjv.29.1711507829222; 
 Tue, 26 Mar 2024 19:50:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDFHqymneivOQ/Gug1CnZ3P/OE0pyTcb9aqi+GjOc1tIx56JdNZDor5fWwBcjjqD2JQKGYmzvAamlRiu8DrRE=
X-Received: by 2002:a17:90a:dd88:b0:29f:6bfa:207d with SMTP id
 l8-20020a17090add8800b0029f6bfa207dmr1665354pjv.29.1711507828911; Tue, 26 Mar
 2024 19:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240324-tx-v1-1-a3b4135749ec@daynix.com>
 <CACGkMEvBoe4XQeHOR64rNwAPM-vBMsfLQApWpUoMtvwsSVCpUQ@mail.gmail.com>
 <a31d0734-823b-4b67-8888-46f0c787cf8f@daynix.com>
In-Reply-To: <a31d0734-823b-4b67-8888-46f0c787cf8f@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 10:50:18 +0800
Message-ID: <CACGkMEvYQr2=0DF99ge9DotJg-O3H1FmZQAzhb=6RVWSvvGqmA@mail.gmail.com>
Subject: Re: [PATCH] hw/net/net_tx_pkt: Fix virtio header without checksum
 offloading
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On Tue, Mar 26, 2024 at 3:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/03/26 15:51, Jason Wang wrote:
> > On Sun, Mar 24, 2024 at 4:32=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> It is incorrect to have the VIRTIO_NET_HDR_F_NEEDS_CSUM set when
> >> checksum offloading is disabled so clear the bit. Set the
> >> VIRTIO_NET_HDR_F_DATA_VALID bit instead to tell the checksum is valid.
> >>
> >> TCP/UDP checksum is usually offloaded when the peer requires virtio
> >> headers because they can instruct the peer to compute checksum. Howeve=
r,
> >> igb disables TX checksum offloading when a VF is enabled whether the
> >> peer requires virtio headers because a transmitted packet can be route=
d
> >> to it and it expects the packet has a proper checksum. Therefore, it
> >> is necessary to have a correct virtio header even when checksum
> >> offloading is disabled.
> >>
> >> A real TCP/UDP checksum will be computed and saved in the buffer when
> >> checksum offloading is disabled. The virtio specification requires to
> >> set the packet checksum stored in the buffer to the TCP/UDP pseudo
> >> header when the VIRTIO_NET_HDR_F_NEEDS_CSUM bit is set so the bit must
> >> be cleared in that case.
> >>
> >> The VIRTIO_NET_HDR_F_NEEDS_CSUM bit also tells to skip checksum
> >> validation. Even if checksum offloading is disabled, it is desirable t=
o
> >> skip checksum validation because the checksum is always correct. Use t=
he
> >> VIRTIO_NET_HDR_F_DATA_VALID bit to claim the validity of the checksum.
> >>
> >> Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for loopba=
ck")
> >> Buglink: https://issues.redhat.com/browse/RHEL-23067
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   hw/net/net_tx_pkt.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> >> index 2e5f58b3c9cc..c225cf706513 100644
> >> --- a/hw/net/net_tx_pkt.c
> >> +++ b/hw/net/net_tx_pkt.c
> >> @@ -833,6 +833,9 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, =
bool offload,
> >>
> >>       if (offload || gso_type =3D=3D VIRTIO_NET_HDR_GSO_NONE) {
> >>           if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F_NEEDS=
_CSUM) {
> >> +            pkt->virt_hdr.flags =3D
> >> +                (pkt->virt_hdr.flags & ~VIRTIO_NET_HDR_F_NEEDS_CSUM) =
|
> >> +                VIRTIO_NET_HDR_F_DATA_VALID;
> >
> > Why VIRTIO_NET_HDR_F_DATA_VALID is used in TX path?
>
> On igb, a packet sent from a PCI function may be routed to another
> function. The virtio header updated here will be directly provided to
> the RX path in such a case.

But I meant for example net_tx_pkt_send_custom() is used in
e1000e_tx_pkt_send() which is the tx path on the host.

VIRTIO_NET_HDR_F_DATA_VALID is not necessary in the tx path.

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> > Thanks
> >
> >>               net_tx_pkt_do_sw_csum(pkt, &pkt->vec[NET_TX_PKT_L2HDR_FR=
AG],
> >>                                     pkt->payload_frags + NET_TX_PKT_PL=
_START_FRAG - 1,
> >>                                     pkt->payload_len);
> >>
> >> ---
> >> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
> >> change-id: 20240324-tx-c57d3c22ad73
> >>
> >> Best regards,
> >> --
> >> Akihiko Odaki <akihiko.odaki@daynix.com>
> >>
> >
>


