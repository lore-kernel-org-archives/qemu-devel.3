Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6318A60A2609
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=FZSBB3NR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yJbX/zK6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQz1t-0007ki-Eb; Tue, 10 Nov 2026 22:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQz1r-0007js-Pt
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:29:43 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQz1q-00085c-7Z
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:29:43 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 740061D002A8
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:29:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 22:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1794367781; x=1794454181; bh=xU1jMkOEfBY+C3cqbXOUai/I0MeBrKoI
 70Kaw44x/jM=; b=FZSBB3NRVwfsPQhWJ9IGe95/MkR0ZNopUy966ALlafMc9KcC
 H3TPxHDt26xLvwZvUKRGM82B4lTREQdj0yPJ9lDwwqP1pnhChXcLjb2+yZJ7T5vl
 hs/8G6eDAHucIP/9J9ML0G5wDbIbC3YwQKc50FQJ9UrFy4TnYAusbTrhMqg4ScKC
 eyDboTq1fRWTn6NYLqGvzI33e4VJ+DQedRQZad3M4uR0OQBldHV3ALpkskmraVTA
 hKuqOHCDvNn0Q753ua9jPMCYJ+xYpjwgzQ1738YxmA6jHRwBDYKc13lk6eYKNlBI
 fVlcUJ+Y0HsLhFkUD5DwiG+zaKwetrpZXq5bpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794367781; x=
 1794454181; bh=xU1jMkOEfBY+C3cqbXOUai/I0MeBrKoI70Kaw44x/jM=; b=y
 JbX/zK6LUdyqd2NSlPPny9yZ7+pG9Tcy9QWvQFTB0D8JEmCMRYlVBhQFqQxazuzb
 apINqXY3oMG5izoFgP3Og9GQ6CgR3ITZ2t9EPyENIVzja/wdnCN6DREy2WlDk8qx
 S2WstnC+GWC5RP0c0VrPtbswxCSF23WSVGxIam+sZSuxfgxsWYGOU7QGmt+pSsSO
 6dPJihkQd0f/tCg2I8Q2eSqhwtwlmTz564w0+bVd6tLdu1z67mlgpQvK2/JvhaMD
 mpGSzwAWsAKI2UL+GW2S5sE7WxfZxixm1fU7Bp+EOyxnuviFdjNV4/VkVyChpKX0
 jZYQcd7ikNP09zCHTi0pg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794367781; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:EpZhOsRkvdsTKALhhfjTGDQpcXTiU7jZt1e6qq/MUo+FVlp
 hzTUBnTuvFUCpiky0+52GFy/zkgLPc6F5dnHvuoYxx6MM6gNfxO8Fr5GlfPq6o2W
 CJLQ015TlnXViI5qc2YU4H/M9/A+vr1WeND3iOj3xSCjbmNVbbHhCM5WBsMW07pW
 JV+QKZc+6fIBaEjARmfAFQBA6Utmm4+K98b6Ue5IYB018qc5nOFl9r+EdonhoBu5
 wdGdjaXlQQ0IBuE7pDj5/oK7W+aE5M0nOGAfOQ9LzjjKmttQyiL0B7ucfKl/Wbe8
 PeYS0MBmzLmAKaGRB4mXjXhD1GtKuQpdJMVlYdw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:k20BRj0ud4pGTYwm/ngKtFrXkrmxPT4D/rUHVUo2/kA=:xU1jMkOEfBY+C3cqbXOUai/I0MeBrKoI70Kaw44x/jM=;
X-ME-Sender: <xms:JeHzasRujyCwbsWsDgDrPFe5s_SlaOAI4WB4QvkWs2QbSwj1-69V8A>
 <xme:JeHzaj2hkyERqCDk59XFQIEJd2f9cW8S9YZifawCVWYRVwj2FPbX6OrgopGYkc0pw
 M1MoUqV8PD-xD1FFJa-S5wGVqEFn-WwhgBKVk7sgU6OzsVEuzPs8cE>
X-ME-Received: <xmr:JeHzapvQzuxO7tJcI5Dv6H1uzpL_j5VX5PGKi9oSotpIXmK-QB5RDUKs_Qov4xt1DblOuHPW1oConbsBX9yXbLBLqHE>
X-ME-Proxy-Cause: dmFkZTEa8c6FDBppr/q5ebq0aoIUN284cstTqPm3bmylL6ehN7YhdonrN2YQk4t5XfeIu4
 P4Y9nIRxY4COUBsfqjupCuZih5azBUMCC5Jf5wpoln+vnlnWqXyTs+lrd6bd+8Yl0t2LV8
 tPTCl5x5HKYTgtdS3PJOHcNNlqDpMun4EP1pcWwciQ4y5Rdx0HgcQ10+1Don/+DZZnm21U
 SnWrIQYaL9UQoB0iGyuyubnmzMFPMATt+/+HveXZNK826Nj7nr8ujvuXFqL7hhJyunqCfx
 eGYP36F4tyNoTjKHTaYNDLjzbkpi5YrDNwwq8mG/iAOjvQ3kjfVegoCXtjdrpJjtx71xgH
 qhDrgOHriR7nqvO3e4vyvidlwAYWge4szU6ds3WUSF4PxjWGCRyX13QHhstCXFpPJX6JrB
 jMA71BtgWz8ZYAtzUkcJVgiTLUkQD0J3pQDGmZflbX6mL2k/y5m6TOreDD2KI8NSGkKhPe
 cHH0EwTnynkeL7Tqc+GOQeeRqPWjnMSPuQNiRdVYxnI9BEunKCTgq1oc++vBOqbmTLAmkU
 aAhSalGvrmq7aSk/mR1UTpwd3vhUekKn01HcL1jv8n/Elw8tTyh+peCwc0vbCfuZy80KbH
 nLSQgc3t6aPnRiHs1NkObyVkRr6JErkU/Nmz1oRkGZ1IH1Js7l2RBW+id6UA
X-ME-Proxy: <xmx:JeHzahgPx-pWcfDWjLK3BRxiafwhr6G_2pzc32oc6RT5aQL1kFMkeg>
 <xmx:JeHzai-7_Rs4STCH8tpce1BhBfhJMKKLxJLn3rzCq4GRJ0caTd9dxw>
 <xmx:JeHzassKcqcU1rUCFZRuaUHE2Zej6QvB7AXPBB43XJNc-Z9kxhxLmA>
 <xmx:JeHzauqIo-YwOW6_xH0jSB-8hYASEpl_zT9Hvjr6SHeHMTB_-Df_8Q>
 <xmx:JeHzak2IcolzE8Y3KlylrLXHW1MgCT3xo2sxCDRdCDun0HNMPcjlBX_0>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 22:29:38 -0500 (EST)
Message-ID: <6c540b6d6e875833f2fb1bcf1e81ccb5937d6b4d.camel@alistair23.me>
Subject: Re: [PATCH 5/6] hw/dma/xilinx_axidma: Don't start transfer on
 TAILDESC write when halted
From: Alistair <alistair@alistair23.me>
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell	
 <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, "open
 list:Xilinx Zynq" <qemu-arm@nongnu.org>, Frank Chang
 <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Date: Wed, 11 Nov 2026 13:29:36 +1000
In-Reply-To: <20261015033733.35116-6-jay.chang@sifive.com>
References: <20261015033733.35116-1-jay.chang@sifive.com>
 <20261015033733.35116-6-jay.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.150;
 envelope-from=alistair@alistair23.me; helo=fout-b7-smtp.messagingengine.com
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
> Spec: "If the AXI DMA Channel is halted (DMASR.Halted =3D 1 and
> DMACR.RS =3D 0), a write by the CPU to the TAILDESC_PTR register has
> no effect except to reposition the pause point."
>=20
> Check DMASR.Halted and DMACR.RS in axidma_kick() so that a TAILDESC
> write while the channel is halted only updates the pointer and does
> not start a transfer.
>=20
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0hw/dma/xilinx_axidma.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 687b5080e0..a9c2c2a275 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -536,6 +536,10 @@ static uint64_t axidma_read(void *opaque, hwaddr
> addr, unsigned size)
> =C2=A0
> =C2=A0static void axidma_kick(XilinxAXIDMA *d, struct Stream *s, int sid)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0 if (stream_halted(s) && !stream_running(s)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 s->regs[R_DMASR] &=3D ~DMASR_IDLE;
> =C2=A0=C2=A0=C2=A0=C2=A0 if (!sid) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stream_process_mem2s(s, =
d->tx_data_dev, d->tx_control_dev);

