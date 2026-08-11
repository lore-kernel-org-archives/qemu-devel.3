Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9054AC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsvE-0007fj-7e; Tue, 11 Aug 2026 16:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsv6-0007WF-BF; Tue, 11 Aug 2026 16:17:57 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsv4-0003jh-BD; Tue, 11 Aug 2026 16:17:56 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 93D3F140010C;
 Tue, 11 Aug 2026 16:17:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 16:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479473; x=1786565873; bh=JcY5kADc6qNbS9/TOafVNpoBIxUYjf4p
 Y+jKZCpc21U=; b=O8xSMDBCgSXtidapuZL4omWH9y/AZ7zrGFuREZ6i0C0N3qLb
 +mUfun2DSJoEFR8ivnfBJl+KxN/afc3G2rFs8TLuT9S5evDXXQ7MXvXchEKUOuLZ
 sNIZOJsqu/Zj0QQGmxXJ/Hq1T3a7FOHSfnRFelVxTe+ar5EyvUfWOVexRRZaXKV6
 GMDCnNtnTdNgJDnN4QdbSutZ5hwXQckoCZK/MB8E7kRQrPUnqSYJHMpTehfibx9S
 VOVke9WVq+DqSV170ShiD+3pz2aa0r814M3ng6Ap3EZuPZ/sQzQRub7FFjqwlOdj
 FAuqHnfYoDlHhxFghcgJOlbIA82PtZ7Anh8+oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479473; x=
 1786565873; bh=JcY5kADc6qNbS9/TOafVNpoBIxUYjf4pY+jKZCpc21U=; b=k
 uvgcoOznfwleoYoyz7jkX/phBbUcefcVLRGOKbUPeA+v5c2JRgE1LPLWGja1cNRa
 DzAGTarn3DlCBgKgpgiSc/vXmI6Gsj2y6fSbC/MOwVK6dR6vu/kvZVMk7NEHm5O2
 FyIGd5EhIIE+Av6J1sNy0HfxLCT7t2VVArJzCHKuEKxlKCawopKmXYcxPvyyTnNd
 ToWp9oE6FtXdXCXO8VDFbBaIpVD1+3UZwJXT6GzAwJDgERekjvEjeVgQTnB+PQb0
 8Y8juXh4XZUGnsWzNEn1Pcr2EAYf/78YjqX1k8q7r85rDOKay3N4kDbGY75NVrFw
 fJb5PumDFh5e6TyWUcE8A==
X-ME-Sender: <xms:cYN7alvAfcSil-qwTVxBaQQOLPc1fbBFHpN60DiKPcFrkCOq2Q7ISg>
 <xme:cYN7aiyU2H9e6ws-7-zb0TfPsBliCVXpDVbmyDXKOODSI9IGhV0Bp0CLDeW9Ph_rg
 25W-WoGpwEPsJ4GHngNMupG_9r3KnKn1AMariKCJWGZ0ft_T_J4lnE>
X-ME-Received: <xmr:cYN7an5Re6DAUggo7moKgSPofOtVenVN6mb2S-rm6yUHSgmMBhqJQYZ1iMkRnM6WkKOZrA>
X-ME-Proxy-Cause: dmFkZTEEByZQdtsPsbAxpxfho6kRbmIwIV64yq0RrdqCLWkSKGrCCAvive1S9WyYkFGSW1
 VMqPhNi5VEOc7GP30HXuel9BM7TGVhI49S1qFeYJ6CJENAalGAxqbT8m97hmVu+bFtiAZ5
 ajjrsvzZtyDB59o1wn/kn2cicNrppL0l9Xp93uTdl4fdGXAIYu3xCjjTmADxGveoStNPCg
 KByRSRDOZ+7+DMrZO5y9CttoczNzyLlSAQ00pJGxNW72nqS7Nadc9bpeOFmsvPIKn5CaFR
 WAyFsBdLzNHJ/a5KlM/a12ftyT5IVaOxuaXFX/ePiB/v02ymTBzYP20bSTdyaPz/WUfXr4
 N9Yv/8Xx6yiIB5Lzy41H5SS6WCH/rYDbeAYm6U+32BDZuiRf6j2Hy0naA7CFAc1LvbypyE
 Alu6c9Hi8EM14XyzAqwVO6HcnPNs7k64ObAXj96keeF0cEs/Nash/x+EF2mtBCrOv5jrJw
 LRSSW1Df6qtu2k9gfkaP+59FHnR4nc1kDigZ47+gn9fsOdxWvk/3qmSTC/g9IwrwJ+5mWz
 JEqniAGMb029HyarG80fEq5XqyE/MH6UTHbomGdaYqE8CFZ3d80jy2pi18Pgi85P5Szog+
 kBCxpwuuwG2vh8akZPz9+zOr+bfJxVHE+WAA+w3078IHDR47PGuvJvij31Xg
X-ME-Proxy: <xmx:cYN7akXesjV-n6fnBFiiE_bjzaEHbbfHutKw5MJTiYDJWsbe21jgoA>
 <xmx:cYN7ar2p9IJ3H_zmvcOOaNH-xkCvb3uQFWoaui5JU_96VpFctuSDAw>
 <xmx:cYN7ah2Xstu0lMHyRZK2PsdJuFvNG8gFsO9cnq6dtmrlMVfe0NENUw>
 <xmx:cYN7au_g692sUAdghBAGNrgrhFSLJslkA4z8XILrEP-5g6JKD0BkLQ>
 <xmx:cYN7arx3z6mmldZuDOiLY5C9mK532x-Pz6iRjjmbw2t5ayUogr6Dbsy_>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:17:53 -0400 (EDT)
Message-ID: <25badecdc770d7f184c6a1dbbb24c1575855f6e1.camel@alistair23.me>
Subject: Re: [PATCH 24/56] disas/riscv: Remove rvcd_imm_nz
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:17:53 +1000
In-Reply-To: <20260809223545.730664-25-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=alistair@alistair23.me; helo=fhigh-a6-smtp.messagingengine.com
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

On Sun, 2026-08-09 at 15:35 -0700, Richard Henderson wrote:
> Remove rvcd_imm_nz and rv_opcode_data.decomp_data as unused.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.h | 5 -----
> =C2=A0disas/riscv.c | 7 +------
> =C2=A02 files changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 31bb0db86c..3909d73dd0 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -186,7 +186,6 @@ typedef struct {
> =C2=A0=C2=A0=C2=A0=C2=A0 short decomp_rv32;
> =C2=A0=C2=A0=C2=A0=C2=A0 short decomp_rv64;
> =C2=A0=C2=A0=C2=A0=C2=A0 short decomp_rv128;
> -=C2=A0=C2=A0=C2=A0 short decomp_data;
> =C2=A0} rv_opcode_data;
> =C2=A0
> =C2=A0typedef struct {
> @@ -217,10 +216,6 @@ enum {
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_illegal =3D 0
> =C2=A0};
> =C2=A0
> -enum {
> -=C2=A0=C2=A0=C2=A0 rvcd_imm_nz =3D 0x1
> -};
> -
> =C2=A0/* instruction formats */
> =C2=A0
> =C2=A0#define rv_fmt_none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "O\t"
> diff --git a/disas/riscv.c b/disas/riscv.c
> index ddc2f73eae..95957506bd 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -5417,12 +5417,7 @@ static const rv_opcode_data
> *decode_inst_decompress(rv_decode *dec, rv_isa isa,
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if (decomp_op !=3D rv_op_illegal) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((op->decomp_data & rvcd_i=
mm_nz) && dec->imm =3D=3D 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->=
opcode_data =3D rvi_opcode_data;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->=
op =3D rv_op_illegal;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->=
op =3D decomp_op;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->op =3D decomp_op;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D &dec->opcode_data=
[decomp_op];
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 return op;

