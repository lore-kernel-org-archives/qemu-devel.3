Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2773606A329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H2wDNocI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xObYP-0005KF-SU; Wed, 04 Nov 2026 09:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xObYC-0005IX-B3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:01:25 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xObYA-00077B-8E
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:01:16 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-46556b9e02cso465878fac.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 06:01:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793800873; cv=none;
 d=google.com; s=arc-20260327;
 b=onARlyEh5XWDPWADqKEeDhP8NYVrAogY6JRR7SXdglEwT4vT/kg4wFrOHVTDXlIj4k
 WU8zB1Pg0p0V+G6rJYdb7/T+rgwfGa/Tqv9ppC3u7t9/BCP5tM19LUujIr/IxzWBwW0j
 5bgakBKxw++NywUBiogM1N3mTSSLq0aiDgjQovcZRTjZbSf5um/voYfecv15AdlPj2Yf
 tejNO/u4MFHz2H4NOumsyGSXBUUDN31dofxKaxnJkDWtp3jeOPGxWsDICKeWs491tXK8
 LMF5bTYBx3AiPfXvEw55X32mez0OU6ITug/2tj7UftI9LeZYwYz0QS01P0pTxAGlTQbr
 8wcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=vJo8pblmCHLKy/0j/JXqcN6x4ye22xwk1nVorsoogP4=;
 fh=vpsakiF8uwCWKB4ZsKICZZ334eoBdPNTowjTdQSfNNM=;
 b=jC75kfcVUZ2BYwVqQ6QmsasQyfjjT3B9n/QXiD1VklevyMGXNFFy3dmgYCTNFyxWfO
 SU36w4CT2QFYnUsztQm3abEqLrKrg7GWQKYBv9XngaqWdpXPBKx1h4QPNbiIM4gxVjof
 0anRKf0Vr1rbQ8AfrUcLlTjAL5NI3Ir4l6pAIEqCqaEZ3/V6kFE09F0MiVWlP/fzK+Cg
 EQwzMeIY9911NqL0zDcnSVooGCjPXP70/aOTHVo6vMDbchDfPc7rn/7HIeKd2piAZA5j
 Hp0kMKU3NH1z6v7O19v946xfVjSdRY+vGWuPtNOq81zfNiD3A8thdlxzobuhGJXlrm+T
 4I0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793800873; x=1794405673; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vJo8pblmCHLKy/0j/JXqcN6x4ye22xwk1nVorsoogP4=;
 b=H2wDNocI7XsF9ABwRt+GlkeqoJjA6BvGqVyxXMAZ8UYrTtoXK/agbBrtjFHN7oLY0B
 pNKbG6qw2iWefMJEfE+LJiP2/ukq+9kTRjzQKBeixk9dJoClhwrMpobsnItf8gaSrPZs
 B/TLgTRvtUgYN2ZcEypR7b4ZxEvP+dm+7Y3iAdQ9qyJaYHeZnsQGxhqTVtL8Gb4W+bNb
 RJ6LwDUiYYuZBfz8KanPZfuVRNXYa7sMzfpjl4odBcoipItCNLndI77YJkZn36m0CCmQ
 KtEBeJruCSrVc4MSL8CGtkbezsQKobBEG4xWBwpZCj4WaXfpQX2YFLyLzLcDgle18IOv
 6AVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793800873; x=1794405673;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vJo8pblmCHLKy/0j/JXqcN6x4ye22xwk1nVorsoogP4=;
 b=HAvWIqUlluo5HWH8GBdU2IQ8W3AVhgpAOUXJVgOfDkCyPUGAmOubxQN4rV3U4m8EuK
 h7wMlh9ZCQXm9ZiChL8kixtNrrAvsOYzdXU6gUp1dcRs1NzadjX4WZesNA+bSowX2YS0
 xWCIGM2vn+TtvxPn0SZmGLV4yJRoRyV6m2nZhTCFmBb9wyPWtyDiZw6Fy10AUJ37xagu
 pd+aqAKRdDQUY8jGSVVaniQS8Rx0j2Vws1EeWinsh8I0dr7yDqceCp6bVMRfU0fjsYqB
 NzKtEeeIOYl2dhRjw8HYf6+delpvkxYoCMPJQOP1pTqDzl1LW+gWP4FI3qvr0aEeubo+
 KWZA==
X-Gm-Message-State: APuU4Z/yFBgOCwGbMzzK5X3XgYn+3SVyDuSV2tS8pEGdKNHfSDMDR7E+
 IimbCZQjjTiK+J4vvjHmVuTcRslRh/eKFbvk02/XFsJkc9Ub/nOkP12A276XBtHeKC6ra2jQlNc
 eWI5yyWS/fNWA6YL/RR8j2prlKlAK+bI=
X-Gm-Gg: AYBFou2oj5CZN7ckmQBb8OZ68nlFLCv7BWhosTJO5c1srKeSK9mj2tqZKRpmzBA5cBa
 F9bYhL8F4rUwWyuJFXnlBNuBotzsBgMFo0pb0WX8+P2FRAqGDjEZK7Rn8qIQFgMXc3wp9KGTMOb
 LpylVYVFkc4bSBuiOjnF+xibg9n0YvEkS6AB8DuChPpBEeznn+LirUqwdNtQFH188/dtLvgjaXI
 Ahq+qdBNG32kgSQ6pJVz0aENSK3L7HUSI7scTCENFsKXRwafSarAZRtgSxK/Pt8pUv+neZUdP6l
 PQzhUbiNnJXlDzmqzYTpPS1WKhBtT7qB70u1P/wEYkitQ54VFm0eF40dMzFeaF6WYU0Y5UyeCZ9
 J7ichRlHAE2srmBwlr8VywEzT13CIQ76Xs+dTX8edGX9y4ntVTc4TMfOIoX49DK0uyLNHjs+OlP
 733HaLxOX8c/tyNST8F8rBqJZwHhA71rYQLcfWmnr/adM=
X-Received: by 2002:a05:6871:c001:b0:49d:d318:c12 with SMTP id
 586e51a60fabf-4a8e0a57914mr8905374fac.32.1793800872548; Wed, 04 Nov 2026
 06:01:12 -0800 (PST)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Nov 2026 06:01:11 -0800
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Nov 2026 15:01:11 +0100
From: Marcelo Manzo <marcelomanzo@gmail.com>
In-Reply-To: <CAFEAcA8qH8gda9K6OyCz99D-SHTp7n4rK9QnoyeWHwsicTcLyw@mail.gmail.com>
References: <CAFEAcA8qH8gda9K6OyCz99D-SHTp7n4rK9QnoyeWHwsicTcLyw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Nov 2026 06:01:11 -0800
X-Gm-Features: AclHuK9FWHPLkDFM00_fDmBsZVviRc_0Pcv7AMe2kf6VU9HdgIMoU6jxSwcr4Fc
Message-ID: <CAGaQodJeKUkBYMJ-=m+z4PeSFyEC_YSmppGijpvyZ8meEXbKKg@mail.gmail.com>
Subject: Re: Re: [PULL 13/47] hw/net/bcm2838_genet: implement GENET RX path
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ce5f99065f73cf7e"
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=marcelomanzo@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000ce5f99065f73cf7e
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

Thanks for flagging this. You're right about the CRC: the payload clamp
didn't allow for it, so BUFLENGTH could end up larger than the buffer the
guest supplied. Also, the clamp compared against the whole RING_BUF_SIZE
register (whose upper half is the ring size), rather than the buffer length.

The 12-bit overflow Coverity reports can't actually happen today, because
receive() already drops frames larger than MAX_PACKET_SIZE (1518), so
BUFLENGTH tops out around 1588. But it was not obvious from the descriptor
code.

While looking I also noticed that a guest-programmed buffer size of 0 makes
the loop copy zero bytes per iteration and never finish the frame. I read
this from the code and have not reproduced it.

I have sent a patch, "[PATCH] hw/net/bcm2838_genet: fit the RX frame within
the guest's buffer", that limits the payload to the guest's buffer size
minus the status block, pad and CRC. BUFLENGTH is then at most the buffer
size, so it fits the field by construction. A buffer too small to hold any
payload is logged as a guest error and the frame is dropped.

I tested it by booting stock Raspberry Pi OS Trixie (20 MB upload and 60 MB
download through GENET, no errors) and the SRS magicbox Bullseye and Trixie
images (SSH and web UI up). It builds on target-arm.next and checkpatch is
clean. The guest-error path and the case where a frame is split across
descriptors are not covered by a test, since Linux uses 2048-byte buffers.

Lorand Marton's pending "hold RX frames while the ring is full" patch edits
the same function, so whichever lands second will need a small rebase.

Marcelo

On Wed, Nov 04, 2026 05:59 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Mon, 2 Nov 2026 at 13:36, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > From: Sergey Kambalin <serg.oker@gmail.com>
> >
> > Implement the receive DMA ring handling: qemu_can_receive()/
> > receive() callbacks for the NIC's netdev peer, copying incoming
> > frame data into descriptor buffers on the active RX ring,
> > classifying broadcast/multicast, and raising the RXDMA_MBDONE
> > interrupt as descriptors complete.
>
> Coverity suggests that the handling of lengths in the receive
> code here may not be right (CID 1690161); Marcelo, could you
> have a look, please?
>
> > +    while (len < size) {
> > +        size_t l = size - len;
> > +        size_t buf_size = MIN(ring->ring_buf_size & 0xffff,
> > +                              sizeof(s->rx_packet));
> > +        uint8_t *dma_buf = s->rx_packet;
> > +        hwaddr dma_buf_addr =
> > +            bcm2838_genet_make_u64(desc->address_hi, desc->address_lo);
> > +        MemTxResult mem_tx_result = MEMTX_OK;
> > +        const size_t frame_off = sizeof(BCM2838GenetXmitStatus) + 2;
>
> Here we calculate a frame_off assuming we have the xmit status
> struct and another 2 bytes as well as the payload...
>
> > +        uint8_t *frame_buf = dma_buf + frame_off;
> > +
> > +        bool crc_fwd = FIELD_EX32(s->regs.umac.cmd, GENET_UMAC_CMD,
> CRC_FWD);
> > +        size_t buflength;
> > +        uint32_t prod_index;
> > +
> > +        if (l > ring->ring_buf_size) {
> > +            l = ring->ring_buf_size;
> > +        }
> > +        /* Never copy more than fits in rx_packet after the status
> block */
> > +        if (l > sizeof(s->rx_packet) - frame_off) {
> > +            l = sizeof(s->rx_packet) - frame_off;
> > +        }
>
> ...and here we drop the amount of payload to allow for that...
>
> > +
> > +        memcpy(frame_buf, buf + len, l);
> > +
> > +        len += l;
> > +
> > +        desc->length_status = FIELD_DP32(desc->length_status,
> > +                                         GENET_RDMA_LENGTH_STATUS,
> > +                                         EOP, !!(len >= size));
> > +
> > +        buflength = l + sizeof(BCM2838GenetXmitStatus) + 2;
> > +        if (crc_fwd) {
> > +            buflength += 4;
> > +        }
>
> ...but here we calculate buflen with payload + struct + 2 +
> also potentially an extra 4 for the CRC. Shouldn't we have
> allowed for the CRC in the earlier calculations somehow too?
>
> > +
> > +        desc->length_status = FIELD_DP32(desc->length_status,
> > +                                         GENET_RDMA_LENGTH_STATUS,
> > +                                         BUFLENGTH, buflength);
>
> The thing Coverity thinks happens is that buflength might not
> fit in the 12 bit descriptor field.
>
> thanks
> -- PMM
>

--000000000000ce5f99065f73cf7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Hi Peter,<br><br>Thanks for flagging this. Yo=
u&#39;re right about the CRC: the payload clamp didn&#39;t allow for it, so=
 BUFLENGTH could end up larger than the buffer the guest supplied. Also, th=
e clamp compared against the whole RING_BUF_SIZE register (whose upper half=
 is the ring size), rather than the buffer length.<br><br>The 12-bit overfl=
ow Coverity reports can&#39;t actually happen today, because receive() alre=
ady drops frames larger than MAX_PACKET_SIZE (1518), so BUFLENGTH tops out =
around 1588. But it was not obvious from the descriptor code.<br><br>While =
looking I also noticed that a guest-programmed buffer size of 0 makes the l=
oop copy zero bytes per iteration and never finish the frame. I read this f=
rom the code and have not reproduced it.<br><br>I have sent a patch, &quot;=
[PATCH] hw/net/bcm2838_genet: fit the RX frame within the guest&#39;s buffe=
r&quot;, that limits the payload to the guest&#39;s buffer size minus the s=
tatus block, pad and CRC. BUFLENGTH is then at most the buffer size, so it =
fits the field by construction. A buffer too small to hold any payload is l=
ogged as a guest error and the frame is dropped.<br><br>I tested it by boot=
ing stock Raspberry Pi OS Trixie (20 MB upload and 60 MB download through G=
ENET, no errors) and the SRS magicbox Bullseye and Trixie images (SSH and w=
eb UI up). It builds on target-arm.next and checkpatch is clean. The guest-=
error path and the case where a frame is split across descriptors are not c=
overed by a test, since Linux uses 2048-byte buffers.<br><br>Lorand Marton&=
#39;s pending &quot;hold RX frames while the ring is full&quot; patch edits=
 the same function, so whichever lands second will need a small rebase.<br>=
<br>Marcelo<br></div></body></html><br><div class=3D"gmail_extra"><div>On W=
ed, Nov 04, 2026 05:59 AM, Peter Maydell &lt;<a href=3D"mailto:peter.maydel=
l@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Mon, 2 Nov 2026 at 13:36, Peter Maydell &lt;<a href=3D"mai=
lto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a=
>&gt; wrote:<br>
&gt;<br>
&gt; From: Sergey Kambalin &lt;<a href=3D"mailto:serg.oker@gmail.com" targe=
t=3D"_blank">serg.oker@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Implement the receive DMA ring handling: qemu_can_receive()/<br>
&gt; receive() callbacks for the NIC&#39;s netdev peer, copying incoming<br=
>
&gt; frame data into descriptor buffers on the active RX ring,<br>
&gt; classifying broadcast/multicast, and raising the RXDMA_MBDONE<br>
&gt; interrupt as descriptors complete.<br>
<br>
Coverity suggests that the handling of lengths in the receive<br>
code here may not be right (CID 1690161); Marcelo, could you<br>
have a look, please?<br>
<br>
&gt; +=C2=A0 =C2=A0 while (len &lt; size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t l =3D size - len;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t buf_size =3D MIN(ring-&gt;ring_buf=
_size &amp; 0xffff,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(s-&gt;rx_packet));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *dma_buf =3D s-&gt;rx_packet;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr dma_buf_addr =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bcm2838_genet_make_u64(desc=
-&gt;a<wbr>ddress_hi, desc-&gt;address_lo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MemTxResult mem_tx_result =3D MEMTX_OK;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const size_t frame_off =3D sizeof(BCM2838=
GenetXmitStatus) + 2;<br>
<br>
Here we calculate a frame_off assuming we have the xmit status<br>
struct and another 2 bytes as well as the payload...<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *frame_buf =3D dma_buf + frame_of=
f;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool crc_fwd =3D FIELD_EX32(s-&gt;regs.um=
ac.cmd, GENET_UMAC_CMD, CRC_FWD);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t buflength;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t prod_index;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (l &gt; ring-&gt;ring_buf_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l =3D ring-&gt;ring_buf_siz=
e;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Never copy more than fits in rx_packet=
 after the status block */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (l &gt; sizeof(s-&gt;rx_packet) - fram=
e_off) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l =3D sizeof(s-&gt;rx_packe=
t) - frame_off;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
...and here we drop the amount of payload to allow for that...<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(frame_buf, buf + len, l);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D l;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc-&gt;length_status =3D FIELD_DP32(des=
c-&gt;length_status<wbr>,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0GENET_RDMA_LENGTH_STATUS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0EOP, !!(len &gt;=3D size));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buflength =3D l + sizeof(BCM2838GenetXmit=
Status) + 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (crc_fwd) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buflength +=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
...but here we calculate buflen with payload + struct + 2 +<br>
also potentially an extra 4 for the CRC. Shouldn&#39;t we have<br>
allowed for the CRC in the earlier calculations somehow too?<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc-&gt;length_status =3D FIELD_DP32(des=
c-&gt;length_status<wbr>,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0GENET_RDMA_LENGTH_STATUS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0BUFLENGTH, buflength);<br>
<br>
The thing Coverity thinks happens is that buflength might not<br>
fit in the 12 bit descriptor field.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000ce5f99065f73cf7e--

