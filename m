Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C28C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsg7-0006hH-55; Tue, 11 Aug 2026 16:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsg5-0006gx-TP; Tue, 11 Aug 2026 16:02:25 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsg4-0000d6-Gt; Tue, 11 Aug 2026 16:02:25 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id A813CEC010B;
 Tue, 11 Aug 2026 16:02:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 16:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478543; x=1786564943; bh=19BktR0GNGXo8wIndCI95hSTYzF4n9dz
 bP/hl5A1F3A=; b=JzxykNW0TywO8GFkv5Pht0H2SkY0EWNj2hmOOAOpFbAmQLob
 9tp9weHhhj8e3dck07sHeO0kax0Y/X+Qw9evz5hC1usFPq+EDUDYnaFPVhNx53Vr
 OI5RzvA3uMsWEFR0U7hFipD6oGEE1iSwJFQSPU8HRz86JIP80RVXRTFMCwkkNdFQ
 11YwzmkfucmeZ+Tla81VgTjBFlsetQe5CaeaPrNcLtA8cP/YkauAH8a6l3m4eePG
 VaXxl6BcJB3EbyN8FGdsoSo5PPf+1y/k1M/txWVvL5GVNb9haFUbaO2CN69qgmfZ
 CVQgrSQfNMbEgWgQdY+eXpvvNJ5U5mIi+P4fbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478543; x=
 1786564943; bh=19BktR0GNGXo8wIndCI95hSTYzF4n9dzbP/hl5A1F3A=; b=h
 DQzyb4ufbZmcBLkvfRkGrxkkM5Rs4ADoHSjCDe62U44wsFJiVmYUsSel+PuAYcWW
 N4Ce2U15Cfr3pmvuvTf8r7b68QsD7II7++WHb3YDuvfrSq1LKhLB8XRYMVoQVhpP
 dIH0urFgSMJ9Qkmekpmc/c8v+ejo/HkC3F2NAqt2Fgk2FRZu0Ty2mwyAbj9l8YrR
 MuseLfX/zkF40hV+fStn0DTXDJGAEs3fhpYJ1n3b6CpRDkL+hnCx5kXWSAHyRxYy
 JTjlK04ZPagWI7kHaqgRLTVM/mAALZaH9HTfqfGHv9YPuc++Yxwc8wOY8xYOnHo6
 J8sSdFzrFr3Dxa4D2Pe1Q==
X-ME-Sender: <xms:z397alIxGxLgVMxezkM_wMLpUn7ea8PlOHe5_hktuAqCOOgb2eYiYw>
 <xme:z397aleXE1UkvCgtbQhk-hS5xNbmH280IN06ziH46_FXlswg7VEbiKUepJwk23VQd
 5oZhTxEJjRNnZtnrkI8ENSsqRA8GDmeBIjUmeHlaOFoJ8XX-u57nmE>
X-ME-Received: <xmr:z397as1MGKXo8eVRo5tqoCTJ26ePg97Kp_RvAWi9vgXGLMsc6L2azONgUrXlA3pni_Cv_Q>
X-ME-Proxy-Cause: dmFkZTGo2QrkfpFVuH7S4IBNCTeomJ8QhEtBvgfnL3QDxFj7ruf2huTSiTBYpg0p9zZT8E
 X0oQyXn2IvY9JI9QL6wQ9VVBPMPTCdzJkfAFbnVOcaYVJXeWoQ6c4uwS+d40kNjjosnVck
 SpyBnEMNSBhuOH6TxVEsaKVDNyfNFu0olX9PeT3RiN6K+KUTCcOdyqT1zoD6e+hkpFMH0A
 rvZ9lHEOYKL0qwMXtKLxoGAgWVrW+ut03mHMzj7FaksvbsjWEZTezwSEZCFfuyLCuxtL5p
 ddPNVfUF+PPvYdQk8jY4CcBTn9Fg9fwOBg6mZNMU3PqNcCvVg0reAUbAR9mC9zcLRCtaRt
 4aiYzB2CNeVIEtMg6+ipNwausOO0NXgdI0Mudpw1ZmYteULrRdGHr4XJ7WE/LGBAm5nwne
 dM/ZJgGgIE9+YZl+Wn2B0QJhDTTfEManyfS8H6syzaqtqno3pHOCXygxfjl8TMpAk2cZuM
 dmc3RCx5j5c2y7o9IyJpoUi7UfIKQWQ1eqGFl8/ue826KW0B7BGvw9qAnnVjUyVPTlCRfX
 tUhrV8a2nRSz6XLn4frgzzPOXBZKJUriWEmb+/5xre3/KHOj/juDHkeYgTQwa8KAbIkeRr
 kw2bWZTSK7QHm8i76rn6B6w1o3dtuA2aWNapwP3NPjX6kGNeHdZ9yEVvKlnA
X-ME-Proxy: <xmx:z397aujYJmWKqxavt-StE-l0MK0ewYwuUhwiISYsYndSoXZ-fRj1nw>
 <xmx:z397aiTTyFJ7TND23JnQKQg4iRVSrMbtaHEoeyakDiLB1FQwtAVd5w>
 <xmx:z397avjBLnOSyOSqVEzoRy3EnJ-YaBkmR148LQcVMM92DDoLTy9U7A>
 <xmx:z397ai7iLlhaSGRRAmvGLgMebK2I0fPMJg1Ls5W6cMe9vhdCK96AQw>
 <xmx:z397aq__c7RaiDmhgRoj2LxNbC6zqZuB_2FxPOKXv7WA2CANkBTAgfrY>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:02:23 -0400 (EDT)
Message-ID: <931e9fdba0589005ea20464734b46b5620bd4c83.camel@alistair23.me>
Subject: Re: [PATCH 09/56] disas/riscv: Pass rv_opcode_data pointer to
 decode_inst_operands
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:02:23 +1000
In-Reply-To: <20260809223545.730664-10-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=alistair@alistair23.me; helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, 2026-08-09 at 15:34 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 12 ++++++++----
> =C2=A01 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 986dc6b752..af43940732 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4595,11 +4595,12 @@ static void decode_inst_opcode(rv_decode
> *dec, rv_isa isa)
> =C2=A0
> =C2=A0/* decode operands */
> =C2=A0
> -static void decode_inst_operands(rv_decode *dec, rv_isa isa)
> +static void decode_inst_operands(rv_decode *dec, rv_isa isa,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const rv_opcode_data *op)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 const rv_opcode_data *opcode_data =3D dec->opcode_dat=
a;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> -=C2=A0=C2=A0=C2=A0 dec->codec =3D opcode_data[dec->op].codec;
> +
> +=C2=A0=C2=A0=C2=A0 dec->codec =3D op->codec;
> =C2=A0=C2=A0=C2=A0=C2=A0 switch (dec->codec) {
> =C2=A0=C2=A0=C2=A0=C2=A0 case rv_codec_none:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->rd =3D dec->rs1 =3D=
 dec->rs2 =3D rv_ireg_zero;
> @@ -5468,6 +5469,8 @@ static GString *disasm_inst(rv_isa isa,
> uint64_t pc, rv_inst inst,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { has_xlrbr_p, rv_xlrbr_=
opcode_data, decode_xlrbr },
> =C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 const rv_opcode_data *op;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 for (size_t i =3D 0; i < ARRAY_SIZE(decoders); i=
++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool (*guard_func)(const=
 RISCVCPUConfig *) =3D
> decoders[i].guard_func;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const rv_opcode_data *op=
code_data =3D decoders[i].opcode_data;
> @@ -5486,7 +5489,8 @@ static GString *disasm_inst(rv_isa isa,
> uint64_t pc, rv_inst inst,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec.opcode_data =3D rvi_=
opcode_data;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 decode_inst_operands(&dec, isa);
> +=C2=A0=C2=A0=C2=A0 op =3D &dec.opcode_data[dec.op];
> +=C2=A0=C2=A0=C2=A0 decode_inst_operands(&dec, isa, op);
> =C2=A0=C2=A0=C2=A0=C2=A0 decode_inst_decompress(&dec, isa);
> =C2=A0=C2=A0=C2=A0=C2=A0 decode_inst_lift_pseudo(&dec);
> =C2=A0=C2=A0=C2=A0=C2=A0 return format_inst(24, &dec);

