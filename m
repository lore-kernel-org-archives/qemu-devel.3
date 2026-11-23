Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C6606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 05:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=lXTIg8AK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AZocUD3s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVMTz-00067G-QB; Mon, 23 Nov 2026 00:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xVMTy-00066s-3F
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 00:20:50 -0500
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xVMTv-0005sz-Uk
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 00:20:49 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DF1C97A05C6
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 00:20:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 23 Nov 2026 00:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1795411245; x=1795497645; bh=LUNt6E21oFVhc9LjhQGtJL+cKBVipiI0
 2oFHHZywdLQ=; b=lXTIg8AKben4sv89sjaxEkfWQhiIWz6bdx2kBEyYt2Az8Mgm
 uvYu7vehK7QYyAqDgarBGyU/AkJsT4Ds1JiiEAUauL4vOa4VRyXDj3kaNG8M2rJ7
 LAt0goaLF1AA7mcFABjSJ2QFql+LHmF2VcuJFFwmeEVtN2U8Sm8aA99DKnEnYFtg
 t2svmx87NGifaOkcgfK7PeTyr25xAtzL33Uo904ht3lq86/kiT6J81jX/CY9eXOd
 +5tl+PzSq8N+RZ5OgAOvcHlhXcVuHJgJiHOlHpqWW7wbWSfVvWwOrsBc1VJcLat5
 QqJExrYpcEH7vQRA1i1nJ5sGaWDLAnDGXgG/7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795411245; x=
 1795497645; bh=LUNt6E21oFVhc9LjhQGtJL+cKBVipiI02oFHHZywdLQ=; b=A
 ZocUD3swCteYl8mFK3Z3QY6Adg7c6sN5gjLIlvjrJEjZNbtpoMp5zAOQqDpHtHSM
 2H1u8e4ppzU3V0wDW9hezV3rAOl/xwHW/IXtu/rGWsNZH1RiMiSyRw/HdGnUjqV9
 p9J0IyaffIgrNtswKmstZSxstS1tLtJxLrlk12weq5+RKeGVRJvgABLMUacxa8pe
 u1auO29Ewe5Xy7NkGCDNiBI9gio81cLcYig5XYFRXJaXUEZUvxub5RFKgcHg3IhV
 x5ShySMY4vPaW58KlPl2WPNyvJj2mwt8sx2efcLlnkjmTej5Ginfx67FXPjeHfkM
 jleew3i89ylK2DAVHmY7g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795411245; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:kW+kMrU37FSL2caQ48jCoDK7++L+LUqGqyUB5whmRojra9L
 QCqWtIFMKk3j9h3+Ola/wTKpbWHKRTBNDsW1vBrHZjeKSHhqjUF4wEulgmC1JuSR
 MfzuJdhMmrwAY7w7YC+7eAh7HaeXKs5vtOYe4OKxnr1DfCBTaCF7qg+PpMnlj5hS
 TF8AtSWRb31pHNbSUVrMkmCtYKeZuKpgXF00QPaFQkkFqIlynMPr0MalhIGDsu0I
 iP8K+R916R8ekxhWIvDOkXjTaK+Dj0BubX3v7SHQBn9Q5JHcuvAoEQ99PGwhLA2X
 q41TdrV+Ih7lzQYrOCOupVqawbuyA2a4XKhDCaw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:w/7mossdS2re+DhsyoIIMWJGGzig62Dkfjws6tEFZEg=:LUNt6E21oFVhc9LjhQGtJL+cKBVipiI02oFHHZywdLQ=;
X-ME-Sender: <xms:LM0Da2sIwCZjpxsUFueUoJAsaB8iM11RxsYVTP3DONqpgi345nGZ9w>
 <xme:LM0Da0YR9JcE7u5lRgRvgdPC1VX92MBwggLBVbwEI-B_W6whuNmaRk0wPcDyzgiNa
 gqAtBS72khv50bU8hXoKEho4bSeK_GSt8-sRYP7CQLtyf4tDawHohbVfg>
X-ME-Received: <xmr:LM0Da9WGMfEwHObuSHZEz1ZplGQlR_upOmJBxMyvm3JFKdlr9zHPyFuAXi9NikFi2B6gNYTw2xZwGbNYeYmmR2TnMtw>
X-ME-Proxy-Cause: dmFkZTFNfohPGUD/7z0YL2rZbWWboKrUEYXHT8RhxM24nqE99ZTrkn/9GJxlNMi+hTlvOx
 5+zs/LmFC29bh6iDXNv2evPT7Ou7mppZL0h2ry/iZAPEouuYiLDkpq5cRE7uFbqcIHjYVT
 bSeMK5inI7FLhgA/mLVIvI7S6B60njSdIbl1u4/S3kgBENfzu8i+Lerfzsv/qGgN1Ka3aN
 5p2TwVIZ78NMSJaa9Y7V/6SUB7NL/XNrHQZJCC2GknWLASJmQw3M0dlOF3g5MHPVUxWKIc
 dfHvdFnqdgmcWsOD+fDv0ThOhZggPsQXkN82B/0b0GRxeYdwN17YVRP8lJMXKXXmAp6ANd
 40LI/Ndqsg8lT7OANGu1+/mXksF7MMtwMznNsRzFy8OhkIFvmKlxvN3TE0cONehTTA8oAr
 o4NZ6Sct70qW7gv2P7fonOxyRTEkcrreczXs0BLvMP4iksSnfQr8mdFBtphBm2PhBN/dAN
 HsvRLnC/f55MgGLBcNV5YJHCpcsDotyOagOV63LLSU/iXHe9ZCnzoE5IMwA9Ig/nUB1yfD
 9Tt+FjFbLWvwT5t78GrboSx9kBecr82a0PYigHR5+GgJiwCq4YJG9YsbVzziDlQtvHbt+e
 3/IDzdDIXehLiuXureKVgAvr9Gi4sU+h+RrEUKQd6/sDSXl3pzxEkj0d6ytQ
X-ME-Proxy: <xmx:LM0DaxQIByvOwoqN_EQMfbZQp63RVHVzGFwdcUIqbDiKTsTg08AdbA>
 <xmx:LM0DazPDc7ahoUojulcnqEV9zNfqQZEixweZgd2D8fDGcnGOHnLtMQ>
 <xmx:LM0Da3Rem8EBflFQx-BMZQyDk-ikHYHT9b1gOVtCIDdko1h9CfsbhA>
 <xmx:LM0Da5g-aRcOn8Q769jATfR0c9lsuBzwaAMmlCON-R4tLfNQGa-DYQ>
 <xmx:Lc0Dawm1B39mkD3ts_fOW91ZtlWoLCj4AlqdW7TSlVIxvT9MDLNTrsQS>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 00:20:42 -0500 (EST)
Message-ID: <b84bd013fd9e2ce479ca083bd4564e5a2b04a197.camel@alistair23.me>
Subject: Re: [PATCH v5 17/26] hw/misc: pfsoc: Honor service notification
 requests
From: Alistair <alistair@alistair23.me>
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley
 <conor@kernel.org>,  Sebastian Huber <sebastian.huber@embedded-brains.de>,
 qemu-riscv@nongnu.org
Date: Mon, 23 Nov 2026 15:20:40 +1000
In-Reply-To: <20261104154207.641511-18-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
 <20261104154207.641511-18-bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.154;
 envelope-from=alistair@alistair23.me; helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-04 at 23:41 +0800, Bin Meng wrote:
> Polling firmware requests system services with REQUEST set and NOTIFY
> clear. Raising PLIC source 96 for those requests leaves an interrupt
> pending that Linux can receive before submitting its first request.
> The mailbox interrupt handler then has no response buffer to fill.
>=20
> Raise the completion interrupt only for requests with NOTIFY set.
> The serial-number service already checks REQUEST before processing a
> command.
>=20
> Fixes: 592f0a9429b9 ("hw/{misc, riscv}: pfsoc: add system controller
> as unimplemented")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>=20
> ---
>=20
> (no changes since v3)
>=20
> Changes in v3:
> - Split the NOTIFY fix from interrupt acknowledgement wiring
>=20
> =C2=A0hw/misc/mchp_pfsoc_ioscb.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
> index 850125c8b4..bde1917c10 100644
> --- a/hw/misc/mchp_pfsoc_ioscb.c
> +++ b/hw/misc/mchp_pfsoc_ioscb.c
> @@ -247,7 +247,9 @@ static void services_cr_write(MchpPfSoCIoscbState
> *s, uint32_t value)
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 s->services_sr =3D status << SERVICES_SR_STATUS_=
SHIFT;
> -=C2=A0=C2=A0=C2=A0 qemu_irq_raise(s->irq);
> +=C2=A0=C2=A0=C2=A0 if (value & SERVICES_CR_NOTIFY) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_irq_raise(s->irq);
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> =C2=A0static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,

