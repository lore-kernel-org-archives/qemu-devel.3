Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E647606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=aUX69GIn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JFCYqFv9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQz3A-0000KW-G5; Tue, 10 Nov 2026 22:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQz39-0000KK-9y
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:31:03 -0500
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQz37-0000i8-M9
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:31:03 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A2B957A0298
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:31:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 22:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1794367860; x=1794454260; bh=vjXjM+LUcnCJU9DIvIdTlAhdfhw0abyP
 np0ApelIgyI=; b=aUX69GInIieLZR/2tLdr/JJ8PzF8osLqjNg8HQ/9VbMV9xUg
 SEi17nj99OFWcXULmFBJsEu/yN+009tVqibgEkaKXB9gYi5l1t9Wda8ZSwhNvIJQ
 FZsGRv/aZBrxUON1PyBnuXdwDJ4jakROh4DnmogEdc/2gj9UsEkte5R6MpxEeBzn
 d8dpI1+zQHSQRNk2xFUH2w13e+YN9iOFJvRSAIhKVG3lF2i41tMp3NmbMUaPhswG
 kVmS9sqm2YyoRQzqf5AYu0/Zmy0oEFKM5EAGhOB7l/BZplqofNwLulh4CjBELxTo
 ulT6Ban2OswVeNGV8OIQ1wR9tHQVKOsGtnPv+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794367860; x=
 1794454260; bh=vjXjM+LUcnCJU9DIvIdTlAhdfhw0abyPnp0ApelIgyI=; b=J
 FCYqFv92Gwa8t0nDc4QQd1yT4ZNyO1XFcPYoEBvwd5EF2N/t0oI7j6nX3Rcb2Fyh
 REemIhHekubHCBXBH2ETrt0ciP+2983z0EJ3BNcXEDBbCMIVVkAK1QogJZ4klzif
 34fRSVtfISkjfmpHJaztkq6w5YRWEFD6NtrutpcSaxdBNzFZMLviamg3aUoAVej2
 oqw+2YPQfF/cXWuKVaxf02qSHSa2xFZwxQ6PkHBhwIQ7mEI8gquCa1EJYpF+XpfQ
 svSxSLEYFnOADuBpirZNrbTdUlYW1/VjUBxD1Xsm+qAg0IKKcORBqKuFZCw7UL/7
 MA8VFGwIuOD+2ruUMODmg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794367860; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:NwESx6wOZLIYqx01w/mHpLCSeTUkOcc5P6apiR9KUdkiZvQ
 b1Mug3MadrlCdXL4WQZoULN4H8/6aIoJwx/bYd5fL+6+IQT3cS2Sz2gVbFU0sV4u
 zllrc+uxnwjbi+Ts+Uo8xAjQea0IuLBr8rPKQ1Rq04RmqTC2ma1BX6xK56LTzRBQ
 v6SxkeZFuJy2PyJNkNkgAKM7nl0vXH/8GwAl/pTSZEaSbviIw9+tqkaovQJdMAfE
 ufT+SdY7UofF/Y0TleN/0UM4Pog9YZfqFPtAF/P/hwvR75Y2OYW+RP0iq3ujhPu+
 OSZ8HruUQJrB0+CZObX9BvWL47Fqx2Em6jwQxbw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:7GypaooU9F+sSjyymYwGFF7NXQgQPXBC5NnyHrMYSbc=:vjXjM+LUcnCJU9DIvIdTlAhdfhw0abyPnp0ApelIgyI=;
X-ME-Sender: <xms:dOHzapm9rFqDQIZBL_Cpa6wKfhnSE9GRbWTG-N_E7IGMLgmQA3SfOg>
 <xme:dOHzau6PPZf4K2AOnjobIU8TsuAlN_cvGYA8d1b18bky-DmVxPDwkV2D5COJiZxGN
 SOLPMmtHNE2qOxVywvp80pistMuSocn4fXTW92NfX77-utNgYPgEBkS9w>
X-ME-Received: <xmr:dOHzavh3yDuCUcV9Y3BP6RoXx0wld_jhFLN9HVJU4l7A3eafXgtmQMkjC-rNW2rUXh_tvWRNGHrnXNmFtW3nN4Iitjw>
X-ME-Proxy-Cause: dmFkZTFk+hD0IpLtrHVYBOzo3CcxfM/bo+0M0biLXCFotV50YFW0fUrlDUGdUY2X4odBrN
 NxwPZL5y61hfN3BRRavdkvm2xI2ahXbKu1rJCZgo38CA2ZZYmZzlRpXTG9mEskgC1f09EM
 esXr5FlOHx7bRpyxSirrBzZvmEfbskehRwNQXCWKp80IY7f+njRvYb5uoBqGjV/zPwDi5D
 BqzzwLt68w5V5E0yuW5xh7IxpoVmVJ3/QiqvzJgWndOCAWijFxG5EL7vzIZD8353ErwL9b
 fUn3VtXCMTEP/TnKLvIhnA5H20sdjY44nLLwhQXTDP4ah3QE0FVMdEpZuzQdpJR3Bho1TS
 +VLD9PaTeHdmIgtUBzy5N2XICVWTsQSwNC4wGZs2W9TrIym1gNg66flbPyIWhPJ1z1xho4
 3SLZteCi2ad8kdUq7olVAboGvhrMzQl0tlmhhEID7/SyNDmFx/6QRkYO5Pmo5LYQ16w0Eu
 cymAfKN93ORQZoVDS8eOUNqOJKupAVOnNUVbqJoOD+g3zbd5rHGoQClFARlWxtprzL6WQa
 LR6gpP8jAh6HmDFczLt7XFO+EKQihm/PgI2gZDqws/j19lmoPErZlMMWuqwJgBsAPcxKvT
 VTG0wRillyIzvxQmnMtxlok7tF+vLAqIeVJqwS8/NhfSiHC0pP8Tpeop7HQw
X-ME-Proxy: <xmx:dOHzarHfLMfxkDnofhr_mlxFlsWtUmtr--bS_lSMlfdr5KOd4mAOeQ>
 <xmx:dOHzalQCzWfbjDUaqIIi8Ezn0WfooDELSmIaNzdlTVa48dvjrthJrg>
 <xmx:dOHzaoyTutQloJiS99YzXja8UDWOoUtlrCRwaCAg0UMq0vZqNCmkLg>
 <xmx:dOHzahcpT8kZjY-07Au6C74dtL3v0E0s1rVbm30cNHQxXZSQk4cveQ>
 <xmx:dOHzamJw42eWGiEIN9ciwviC9CvoyYAnngcY_Lwkd60YHWbYHoxTaYHx>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 22:30:57 -0500 (EST)
Message-ID: <a32a547c54cdd7727f168ecdb01eef715b5519d4.camel@alistair23.me>
Subject: Re: [PATCH 6/6] hw/net/xilinx_axienet: Fix packet double-buffering
 issue
From: Alistair <alistair@alistair23.me>
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell	
 <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, "open
 list:Xilinx Zynq" <qemu-arm@nongnu.org>, Frank Chang
 <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Date: Wed, 11 Nov 2026 13:30:55 +1000
In-Reply-To: <20261015033733.35116-7-jay.chang@sifive.com>
References: <20261015033733.35116-1-jay.chang@sifive.com>
 <20261015033733.35116-7-jay.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.152;
 envelope-from=alistair@alistair23.me; helo=fhigh-b1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-10-15 at 11:37 +0800, Jay Chang wrote:
> In the Xilinx AXI Ethernet device model, U-Boot network commands
> (ping, dhcp, tftp) all fail due to a packet duplication bug.
>=20
> The original implementation had a packet duplication issue where the
> same
> packet could exist in both the internal buffer and the incoming
> queue:
>=20
> Problem Flow:
> 1. eth_rx() receives a packet from the network layer.
> 2. Packet is processed and stored in s->rxmem buffer.
> 3. axienet_eth_rx_notify() is called to push data to DMA.
> 4. If DMA cannot accept data immediately, the rxpos is 0 and wth_rx
> will return 0
> 5. Because eth_rx callback returns 0, the network layer queues this
> packet again in the incoming queue.
> 6. Now the same packet exists in TWO places:
> =C2=A0=C2=A0 - Already copied in s->rxmem buffer
> =C2=A0=C2=A0 - Queued in the incoming packet queue
> 7. This causes duplicate packets to be delivered to the guest
> 8. Network protocols fail due to receiving identical packets twice
>=20
> Root Cause:
> eth_rx() did not check if the DMA stream could accept data before
> copying the packet into the internal buffer. This caused unnecessary
> buffering and potential double-processing.
>=20
> Fix:
> 1. Check stream_can_push() at the beginning of eth_rx()
> =C2=A0=C2=A0 - If DMA cannot accept data, set need_flush and return 0
> immediately
> =C2=A0=C2=A0 - This prevents packet buffering when DMA is not ready
> =C2=A0=C2=A0 - The packet will be redelivered by QEMU's network layer
>=20
> 2. Move need_flush check outside the while loop in
> axienet_eth_rx_notify()
> =C2=A0=C2=A0 - Ensures flush happens even when rxsize =3D=3D 0
> =C2=A0=C2=A0 - Handles edge cases where the buffer is already empty but f=
lush
> is needed
>=20
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0hw/net/xilinx_axienet.c | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index d35f4a847d..cb9aa47707 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -699,6 +699,12 @@ static void axienet_eth_rx_notify(void *opaque)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /* Check need_flush outside the loop for an empty RX =
buffer. */
> +=C2=A0=C2=A0=C2=A0 if (!s->rxsize && s->need_flush) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->need_flush =3D false;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_flush_queued_packets(qem=
u_get_queue(s->nic));
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 enet_update_irq(s);
> =C2=A0}
> =C2=A0
> @@ -722,6 +728,12 @@ static ssize_t eth_rx(NetClientState *nc, const
> uint8_t *buf, size_t size)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /* Check if DMA can accept data before processing pac=
ket */
> +=C2=A0=C2=A0=C2=A0 if (!stream_can_push(s->tx_data_dev, axienet_eth_rx_n=
otify, s))
> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->need_flush =3D true;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 unicast =3D ~buf[0] & 0x1;
> =C2=A0=C2=A0=C2=A0=C2=A0 broadcast =3D memcmp(buf, sa_bcast, 6) =3D=3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0 multicast =3D !unicast && !broadcast;

