Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CFCC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtso4-0001yJ-RQ; Tue, 11 Aug 2026 16:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtso3-0001xW-IJ; Tue, 11 Aug 2026 16:10:39 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsny-0002JJ-45; Tue, 11 Aug 2026 16:10:39 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 9FD0DEC0190;
 Tue, 11 Aug 2026 16:10:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 16:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479032; x=1786565432; bh=hlm+eRm6xNpVeGcA7PSlC96dowAEyUDM
 QLjA4cE3v5A=; b=05YmMXyd5nXeJhM84pQwNvbivIU1+qyycznD4LX5qm9DAOcG
 ahGkv5COeoJCa1/ypfiGuz7yo9zSsaMhzJxNGj12hSVgZiWJ6aYuATB5tM1ggps7
 JrRo3Fr6IqK1aetL/ywVDbOiYJicpj8jjnxcYwfnuUY2ASlUmxdhTMKGg4dXa48W
 UA8Xfftxk/cIT0A8PC0qKrT06xEfhImyCTnd+bWkU41+8JSrfd9FWACmqX9Wmh4m
 Fga+Hp1yy8iUszUe9z9IfIIrmIUxaCzmjJ1aOCqqpNmIbaW1Fh3hA9pGFNjGN/kR
 E7+LfWg5tV4qQx3PSygKVpz0AS2L+NP0v5rwlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479032; x=
 1786565432; bh=hlm+eRm6xNpVeGcA7PSlC96dowAEyUDMQLjA4cE3v5A=; b=U
 rDaY6UvIkVht+daMwJlRi08fk8r2jD+ZusZCsLvycYciEZYDnaVOREpyuNRWzv75
 9aSNaTjWHZHb63w+S073kkdDU7cwdcuJudgtccEZQwqq/GdIk28FOuTLXdpqaDQR
 w7uT3Ph2J4JdrJ1+kgPMh9atW0e7/OeqSW1yIAbAwdGsjb9QelL8bIGepFI1MPuI
 Ef4ygmCIzXc0YpsAwmACs4pTdSFERBJ8sYdIbM0I2hjYI+HKVAKkS2/vyF3cdEjZ
 DBo7DwtvtCm7wjMEtpUMSgKMVDhetzS3oJzWU0CKMJZTQgSzO9eBiU8t75yRGvXV
 3IS1AOgaDQ2udLV38Ak1A==
X-ME-Sender: <xms:uIF7as8nGWNOJc-TxmLT4QCdaB1_Rx01yEpC89uxxlgpCf9W6SKPfA>
 <xme:uIF7apDY5Z0BHcaqlG5zbCWX0uLyNj-Kv13vXgwnxNeygCNcP1lhDd9QwCXpP4UC-
 BcDmLFogCe8g2-JbF43TCz4pH63RObEUWn_qMDhE9IhLv3Twswl0Q>
X-ME-Received: <xmr:uIF7ahJIwxuS8cVOl9cLez8kZ_u8IZ0EbFDv4ZGb_176t4YvtbN-payXEVjjlUxOaoZYcA>
X-ME-Proxy-Cause: dmFkZTGn9lv9HGLJWTbLx3GqFlY1jAm/Xw/S8M3QEIRJnzplETSCI5a1uwnOKWhHgxNSvQ
 cgNrjBcZcsH5u2a9RQYkugnIgKmrQDBCRrfI308hfzaOmEFs3ARnA/cdv+FkVso5B0NrUn
 2iIQmtWeVWxc73CktvHqmYVGR3d3wwtuKPyqyYW3EAOKp6rD6OrLwiYi3N3vgyrHTuEqgj
 kwyeaFXW96409KA48wSpdrcH8ItIQYO5YPhHuEn+pWLkWh74PN3flIETMsj6CcVgqphSPz
 AZYlmrq4PWTc/ZWAcWUTzS11LZkyrScTJg2FApXeRJJ8CPwg8wTVASkxiHDqY/VUMDeGpe
 n5sDA8Agc/29M4VAkPoj/3Wk+tDLOd3J4ag0Q3bTT5RbApjvcgnJBfGxIuOZ6/DsNVW6mB
 QhO/h9lu+K84U5UtNQiFHsbEv7/AfbDlNqfqhfhAqq0bSdlsikmxfKInJSc6maKdWhj2Jh
 FGe7scjC00V25Oipow8wOvQe2pIdjzdrvRY2KnaA+zTSyUvpWEZKJX77L/fJK5ACYK556E
 wHLcGkOZRAUoLsTulY2sl/8nPmexhsyK0eBb/HHTe6CUguybSfBX6XB0muIumhsOzso69E
 cd9uEwXJ7FHemU6caUK1YuGwOHC64achNnkyh8gXZc1d5txWso+ZmKft+gvg
X-ME-Proxy: <xmx:uIF7aknTTwOj1JmRoUArw9AX8-3wxLcPCSkN_Ch0C1h7ECsnGAYPiw>
 <xmx:uIF7anGUmmrCnm7jkczpjBgvbmBAOVwRJUj4du3J9wENPz95ohBmCg>
 <xmx:uIF7asE9JQQ-_aQ68rPiw_jSoSwFg46Pmzc-nY87eZnwZTahPmNdKA>
 <xmx:uIF7asMspO9owlX7BeXM_op5fKGqbgNOEMwWlKVQY3pni-jqE7c-EA>
 <xmx:uIF7aiD4xQ5ttNzjcPE4hsU2Q2uy2GtRMrYxfMFaxKVcARsw4uyHHU_2>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:10:32 -0400 (EDT)
Message-ID: <d62a270789938cdf85b947b1ee0f07602e79b08a.camel@alistair23.me>
Subject: Re: [PATCH 15/56] disas/riscv: Drop explicit zero of rv_opcode_data
 fields
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:10:31 +1000
In-Reply-To: <20260809223545.730664-16-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-16-richard.henderson@linaro.org>
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

On Sun, 2026-08-09 at 15:35 -0700, Richard Henderson wrote:
> Mechanical
>=20
> s/, NULL, 0, 0, 0 }/ }/
> s/, 0, 0, 0 }/ }/
> s/, NULL, 0, 0 }/ }/
> s/, NULL, 0 }/ }/
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv-xlrbr.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 18 +-
> =C2=A0disas/riscv-xthead.c=C2=A0=C2=A0 |=C2=A0 210 ++---
> =C2=A0disas/riscv-xventana.c |=C2=A0=C2=A0=C2=A0 6 +-
> =C2=A0disas/riscv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 1826 ++++++++++++++++++++------------------
> --
> =C2=A04 files changed, 1030 insertions(+), 1030 deletions(-)
>=20
> diff --git a/disas/riscv-xlrbr.c b/disas/riscv-xlrbr.c
> index f61028fce9..d0092e9edd 100644
> --- a/disas/riscv-xlrbr.c
> +++ b/disas/riscv-xlrbr.c
> @@ -25,15 +25,15 @@ typedef enum {
> =C2=A0} rv_xlrbr_op;
> =C2=A0
> =C2=A0static const rv_opcode_data xlrbr_opcode_data[] =3D {
> -=C2=A0=C2=A0=C2=A0 { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "crc32.b", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "crc32.h", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "crc32.w", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "crc32.d", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "crc32c.b", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "crc32c.h", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "crc32c.w", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "crc32c.d", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, =
0 },
> +=C2=A0=C2=A0=C2=A0 { "illegal", rv_codec_illegal, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "crc32.b", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "crc32.h", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "crc32.w", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "crc32.d", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "crc32c.b", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "crc32c.h", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "crc32c.w", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "crc32c.d", rv_codec_r, rv_fmt_rd_rs1 },
> =C2=A0};
> =C2=A0
> =C2=A0void decode_xlrbr(rv_decode *dec, rv_isa isa)
> diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
> index 96f80bc8e5..757d6ff39f 100644
> --- a/disas/riscv-xthead.c
> +++ b/disas/riscv-xthead.c
> @@ -128,122 +128,122 @@ typedef enum {
> =C2=A0} rv_xthead_op;
> =C2=A0
> =C2=A0static const rv_opcode_data xthead_opcode_data[] =3D {
> -=C2=A0=C2=A0=C2=A0 { "th.illegal", rv_codec_illegal, rv_fmt_none, NULL, =
0, 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "th.illegal", rv_codec_illegal, rv_fmt_none },
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadBa */
> -=C2=A0=C2=A0=C2=A0 { "th.addsl", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm,=
 NULL, 0,
> 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "th.addsl", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm =
},
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadBb */
> -=C2=A0=C2=A0=C2=A0 { "th.srri", rv_codec_r2_imm6, rv_fmt_rd_rs1_imm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "th.srriw", rv_codec_r2_imm5, rv_fmt_rd_rs1_imm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "th.ext", rv_codec_r2_immhl, rv_fmt_rd_rs1_immh_imm=
l, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.extu", rv_codec_r2_immhl, rv_fmt_rd_rs1_immh_im=
ml, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.ff0", rv_codec_r2, rv_fmt_rd_rs1, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "th.ff1", rv_codec_r2, rv_fmt_rd_rs1, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "th.rev", rv_codec_r2, rv_fmt_rd_rs1, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "th.revw", rv_codec_r2, rv_fmt_rd_rs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "th.tstnbz", rv_codec_r2, rv_fmt_rd_rs1, NULL, 0, 0=
, 0 },
> +=C2=A0=C2=A0=C2=A0 { "th.srri", rv_codec_r2_imm6, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.srriw", rv_codec_r2_imm5, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.ext", rv_codec_r2_immhl, rv_fmt_rd_rs1_immh_imm=
l },
> +=C2=A0=C2=A0=C2=A0 { "th.extu", rv_codec_r2_immhl, rv_fmt_rd_rs1_immh_im=
ml },
> +=C2=A0=C2=A0=C2=A0 { "th.ff0", rv_codec_r2, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.ff1", rv_codec_r2, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.rev", rv_codec_r2, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.revw", rv_codec_r2, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.tstnbz", rv_codec_r2, rv_fmt_rd_rs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadBs */
> -=C2=A0=C2=A0=C2=A0 { "th.tst", rv_codec_r2_imm6, rv_fmt_rd_rs1_imm, NULL=
, 0, 0, 0
> },
> +=C2=A0=C2=A0=C2=A0 { "th.tst", rv_codec_r2_imm6, rv_fmt_rd_rs1_imm },
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadCmo */
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.call", rv_codec_none, rv_fmt_none, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.ciall", rv_codec_none, rv_fmt_none, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.iall", rv_codec_none, rv_fmt_none, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.cpa", rv_codec_r, rv_fmt_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.cipa", rv_codec_r, rv_fmt_rs1, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.ipa", rv_codec_r, rv_fmt_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.cva", rv_codec_r, rv_fmt_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.civa", rv_codec_r, rv_fmt_rs1, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.iva", rv_codec_r, rv_fmt_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.csw", rv_codec_r, rv_fmt_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.cisw", rv_codec_r, rv_fmt_rs1, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.isw", rv_codec_r, rv_fmt_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.cpal1", rv_codec_r, rv_fmt_rs1, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.dcache.cval1", rv_codec_r, rv_fmt_rs1, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.icache.iall", rv_codec_none, rv_fmt_none, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.icache.ialls", rv_codec_none, rv_fmt_none, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "th.icache.ipa", rv_codec_r, rv_fmt_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.icache.iva", rv_codec_r, rv_fmt_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.l2cache.call", rv_codec_none, rv_fmt_none, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "th.l2cache.ciall", rv_codec_none, rv_fmt_none, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "th.l2cache.iall", rv_codec_none, rv_fmt_none, NULL=
, 0, 0, 0
> },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.call", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.ciall", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.iall", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.cpa", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.cipa", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.ipa", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.cva", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.civa", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.iva", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.csw", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.cisw", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.isw", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.cpal1", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.dcache.cval1", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.icache.iall", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "th.icache.ialls", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "th.icache.ipa", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.icache.iva", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.l2cache.call", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "th.l2cache.ciall", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "th.l2cache.iall", rv_codec_none, rv_fmt_none },
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadCondMov */
> -=C2=A0=C2=A0=C2=A0 { "th.mveqz", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.mvnez", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "th.mveqz", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "th.mvnez", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadFMemIdx */
> -=C2=A0=C2=A0=C2=A0 { "th.flrd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.flrw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.flurd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.flurw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.fsrd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.fsrw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.fsurd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.fsurw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm=
, NULL, 0,
> 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "th.flrd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm =
},
> +=C2=A0=C2=A0=C2=A0 { "th.flrw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm =
},
> +=C2=A0=C2=A0=C2=A0 { "th.flurd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm=
 },
> +=C2=A0=C2=A0=C2=A0 { "th.flurw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm=
 },
> +=C2=A0=C2=A0=C2=A0 { "th.fsrd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm =
},
> +=C2=A0=C2=A0=C2=A0 { "th.fsrw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm =
},
> +=C2=A0=C2=A0=C2=A0 { "th.fsurd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm=
 },
> +=C2=A0=C2=A0=C2=A0 { "th.fsurw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm=
 },
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadFmv */
> -=C2=A0=C2=A0=C2=A0 { "th.fmv.hw.x", rv_codec_r, rv_fmt_rd_frs1, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.fmv.x.hw", rv_codec_r, rv_fmt_rd_frs1, NULL, 0,=
 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "th.fmv.hw.x", rv_codec_r, rv_fmt_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "th.fmv.x.hw", rv_codec_r, rv_fmt_rd_frs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadMac */
> -=C2=A0=C2=A0=C2=A0 { "th.mula", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.mulaw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.mulah", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.muls", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.mulsw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.mulsh", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "th.mula", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "th.mulaw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "th.mulah", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "th.muls", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "th.mulsw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "th.mulsh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadMemIdx */
> -=C2=A0=C2=A0=C2=A0 { "th.lbia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml,
> NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lbuia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lbuib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lhia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lhib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lhuia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lhuib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lwia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lwib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lwuia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lwuib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.ldia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.ldib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.sbia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.sbib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.shia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.shib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.swia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.swib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.sdia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.sdib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lrb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lrbu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lrh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lrhu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lrw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lrwu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lrd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.srb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.srh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.srw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.srd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lurb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lurbu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lurh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lurhu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lurw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lurwu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lurd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.surb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.surh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.surw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.surd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, =
NULL, 0, 0,
> 0 },
> +=C2=A0=C2=A0=C2=A0 { "th.lbia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml },
> +=C2=A0=C2=A0=C2=A0 { "th.lbuia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr },
> +=C2=A0=C2=A0=C2=A0 { "th.lbuib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr },
> +=C2=A0=C2=A0=C2=A0 { "th.lhia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.lhib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.lhuia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr },
> +=C2=A0=C2=A0=C2=A0 { "th.lhuib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr },
> +=C2=A0=C2=A0=C2=A0 { "th.lwia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.lwib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.lwuia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr },
> +=C2=A0=C2=A0=C2=A0 { "th.lwuib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr },
> +=C2=A0=C2=A0=C2=A0 { "th.ldia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.ldib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.sbia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.sbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.shia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.shib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.swia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.swib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.sdia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.sdib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> +=C2=A0=C2=A0=C2=A0 { "th.lrb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.lrbu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm }=
,
> +=C2=A0=C2=A0=C2=A0 { "th.lrh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.lrhu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm }=
,
> +=C2=A0=C2=A0=C2=A0 { "th.lrw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.lrwu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm }=
,
> +=C2=A0=C2=A0=C2=A0 { "th.lrd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.srb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.srh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.srw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.srd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.lurb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm }=
,
> +=C2=A0=C2=A0=C2=A0 { "th.lurbu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm =
},
> +=C2=A0=C2=A0=C2=A0 { "th.lurh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm }=
,
> +=C2=A0=C2=A0=C2=A0 { "th.lurhu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm =
},
> +=C2=A0=C2=A0=C2=A0 { "th.lurw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm }=
,
> +=C2=A0=C2=A0=C2=A0 { "th.lurwu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm =
},
> +=C2=A0=C2=A0=C2=A0 { "th.lurd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm }=
,
> +=C2=A0=C2=A0=C2=A0 { "th.surb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm }=
,
> +=C2=A0=C2=A0=C2=A0 { "th.surh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm }=
,
> +=C2=A0=C2=A0=C2=A0 { "th.surw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm }=
,
> +=C2=A0=C2=A0=C2=A0 { "th.surd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm }=
,
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadMemPair */
> -=C2=A0=C2=A0=C2=A0 { "th.ldd", rv_codec_r_imm2, rv_fmt_rd2_imm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lwd", rv_codec_r_imm2, rv_fmt_rd2_imm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.lwud", rv_codec_r_imm2, rv_fmt_rd2_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.sdd", rv_codec_r_imm2, rv_fmt_rd2_imm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.swd", rv_codec_r_imm2, rv_fmt_rd2_imm, NULL, 0,=
 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "th.ldd", rv_codec_r_imm2, rv_fmt_rd2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.lwd", rv_codec_r_imm2, rv_fmt_rd2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.lwud", rv_codec_r_imm2, rv_fmt_rd2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.sdd", rv_codec_r_imm2, rv_fmt_rd2_imm },
> +=C2=A0=C2=A0=C2=A0 { "th.swd", rv_codec_r_imm2, rv_fmt_rd2_imm },
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadSync */
> -=C2=A0=C2=A0=C2=A0 { "th.sfence.vmas", rv_codec_r, rv_fmt_rs1_rs2, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.sync", rv_codec_none, rv_fmt_none, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "th.sync.i", rv_codec_none, rv_fmt_none, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.sync.is", rv_codec_none, rv_fmt_none, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "th.sync.s", rv_codec_none, rv_fmt_none, NULL, 0, 0=
, 0 },
> +=C2=A0=C2=A0=C2=A0 { "th.sfence.vmas", rv_codec_r, rv_fmt_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "th.sync", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "th.sync.i", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "th.sync.is", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "th.sync.s", rv_codec_none, rv_fmt_none },
> =C2=A0};
> =C2=A0
> =C2=A0void decode_xtheadba(rv_decode *dec, rv_isa isa)
> diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
> index 4539173d95..4fb9a29d0b 100644
> --- a/disas/riscv-xventana.c
> +++ b/disas/riscv-xventana.c
> @@ -15,9 +15,9 @@ typedef enum {
> =C2=A0} rv_ventana_op;
> =C2=A0
> =C2=A0static const rv_opcode_data ventana_opcode_data[] =3D {
> -=C2=A0=C2=A0=C2=A0 { "vt.illegal", rv_codec_illegal, rv_fmt_none, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0=
, 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "vt.illegal", rv_codec_illegal, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> =C2=A0};
> =C2=A0
> =C2=A0void decode_xventanacondops(rv_decode *dec, rv_isa isa)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index eb6d132a2c..ec40abb618 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1657,233 +1657,233 @@ static uint32_t operand_lpl(rv_inst inst)
> =C2=A0/* instruction metadata */
> =C2=A0
> =C2=A0static const rv_opcode_data rvi_opcode_data[] =3D {
> -=C2=A0=C2=A0=C2=A0 { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "lui", rv_codec_u, rv_fmt_rd_uimm, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "auipc", rv_codec_u, rv_fmt_rd_uoffset, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "jal", rv_codec_uj, rv_fmt_rd_offset, rvcp_jal, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "jalr", rv_codec_i, rv_fmt_rd_rs1_offset, rvcp_jalr=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "beq", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_beq=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "bne", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bne=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "blt", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_blt=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "bge", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bge=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bl=
tu, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bg=
eu, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "lb", rv_codec_i, rv_fmt_rd_offset_rs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "lh", rv_codec_i, rv_fmt_rd_offset_rs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "lw", rv_codec_i, rv_fmt_rd_offset_rs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "lbu", rv_codec_i, rv_fmt_rd_offset_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "lhu", rv_codec_i, rv_fmt_rd_offset_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sb", rv_codec_s, rv_fmt_rs2_offset_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sh", rv_codec_s, rv_fmt_rs2_offset_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sw", rv_codec_s, rv_fmt_rs2_offset_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "addi", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addi, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "slti", rv_codec_i, rv_fmt_rd_rs1_imm, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "sltiu", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_sltiu,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "xori", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_xori, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "ori", rv_codec_i, rv_fmt_rd_rs1_imm, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "andi", rv_codec_i, rv_fmt_rd_rs1_imm, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "slli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "srli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "srai", rv_codec_i_sh7, rv_fmt_rd_rs1_imm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "add", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "sub", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sub, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sll", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "slt", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_slt, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sltu", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sltu, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "xor", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "srl", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "sra", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "or", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 =
},
> -=C2=A0=C2=A0=C2=A0 { "and", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "fence", rv_codec_r_f, rv_fmt_pred_succ, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fence.i", rv_codec_none, rv_fmt_none, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "lwu", rv_codec_i, rv_fmt_rd_offset_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "ld", rv_codec_i, rv_fmt_rd_offset_rs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "sd", rv_codec_s, rv_fmt_rs2_offset_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "addiw", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addiw,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "slliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "srliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sraiw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "addw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "subw", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_subw, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sllw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "srlw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "sraw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "ldu", rv_codec_i, rv_fmt_rd_offset_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "lq", rv_codec_i, rv_fmt_rd_offset_rs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "sq", rv_codec_s, rv_fmt_rs2_offset_rs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "addid", rv_codec_i, rv_fmt_rd_rs1_imm, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "sllid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "srlid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sraid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "addd", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "subd", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "slld", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "srld", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "srad", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "mul", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "mulh", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "mulhsu", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mulhu", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "div", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "divu", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "rem", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "remu", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "mulw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "divw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "divuw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "remw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "remuw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "muld", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "divd", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "divud", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "remd", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "remud", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "lr.w", rv_codec_r_l, rv_fmt_aqrl_rd_rs1, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sc.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoadd.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoxor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "amoand.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomin.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomax.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amominu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomaxu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "lr.d", rv_codec_r_l, rv_fmt_aqrl_rd_rs1, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sc.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoadd.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoxor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "amoand.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomin.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomax.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amominu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomaxu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "lr.q", rv_codec_r_l, rv_fmt_aqrl_rd_rs1, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sc.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoswap.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoadd.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoxor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "amoand.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomin.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomax.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amominu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomaxu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "ecall", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 =
},
> -=C2=A0=C2=A0=C2=A0 { "ebreak", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "uret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "sret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "hret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "dret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "sfence.vm", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 =
},
> -=C2=A0=C2=A0=C2=A0 { "sfence.vma", rv_codec_r, rv_fmt_rs1_rs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "wfi", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_cs=
rrw, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_cs=
rrs, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm, rvcp_=
csrrwi, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "csrrsi", rv_codec_i_csr, rv_fmt_rd_csr_zimm, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "csrrci", rv_codec_i_csr, rv_fmt_rd_csr_zimm, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "flw", rv_codec_i, rv_fmt_frd_offset_rs1, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsw", rv_codec_s, rv_fmt_frs2_offset_rs1, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fnmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fnmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fadd.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fsub.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fmul.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fdiv.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fsgnj.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_f=
sgnj_s, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjn.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjn_s,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjx.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjx_s,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmin.s", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmax.s", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsqrt.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fle.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "flt.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "feq.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.w.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.wu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.w", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.x.s", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fclass.s", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.s.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.l.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.lu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.l", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fld", rv_codec_i, rv_fmt_frd_offset_rs1, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsd", rv_codec_s, rv_fmt_frs2_offset_rs1, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fnmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fnmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fadd.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fsub.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fmul.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fdiv.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fsgnj.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_f=
sgnj_d, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjn.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjn_d,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjx.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjx_d,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmin.d", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmax.d", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsqrt.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fle.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "flt.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "feq.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.wu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.w", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fclass.d", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.l.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.lu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.x.d", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.l", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.d.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "flq", rv_codec_i, rv_fmt_frd_offset_rs1, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsq", rv_codec_s, rv_fmt_frs2_offset_rs1, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fnmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fnmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fadd.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fsub.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fmul.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fdiv.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fsgnj.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_f=
sgnj_q, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjn.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjn_q,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjx.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjx_q,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmin.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmax.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsqrt.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fle.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "flt.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "feq.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.w.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.wu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.w", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fclass.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.l.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.lu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.l", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, =
0 },
> +=C2=A0=C2=A0=C2=A0 { "illegal", rv_codec_illegal, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "lui", rv_codec_u, rv_fmt_rd_uimm },
> +=C2=A0=C2=A0=C2=A0 { "auipc", rv_codec_u, rv_fmt_rd_uoffset },
> +=C2=A0=C2=A0=C2=A0 { "jal", rv_codec_uj, rv_fmt_rd_offset, rvcp_jal },
> +=C2=A0=C2=A0=C2=A0 { "jalr", rv_codec_i, rv_fmt_rd_rs1_offset, rvcp_jalr=
 },
> +=C2=A0=C2=A0=C2=A0 { "beq", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_beq=
 },
> +=C2=A0=C2=A0=C2=A0 { "bne", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bne=
 },
> +=C2=A0=C2=A0=C2=A0 { "blt", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_blt=
 },
> +=C2=A0=C2=A0=C2=A0 { "bge", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bge=
 },
> +=C2=A0=C2=A0=C2=A0 { "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bl=
tu },
> +=C2=A0=C2=A0=C2=A0 { "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bg=
eu },
> +=C2=A0=C2=A0=C2=A0 { "lb", rv_codec_i, rv_fmt_rd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "lh", rv_codec_i, rv_fmt_rd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "lw", rv_codec_i, rv_fmt_rd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "lbu", rv_codec_i, rv_fmt_rd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "lhu", rv_codec_i, rv_fmt_rd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sb", rv_codec_s, rv_fmt_rs2_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sh", rv_codec_s, rv_fmt_rs2_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sw", rv_codec_s, rv_fmt_rs2_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "addi", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addi },
> +=C2=A0=C2=A0=C2=A0 { "slti", rv_codec_i, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "sltiu", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_sltiu =
},
> +=C2=A0=C2=A0=C2=A0 { "xori", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_xori },
> +=C2=A0=C2=A0=C2=A0 { "ori", rv_codec_i, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "andi", rv_codec_i, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "slli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "srli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "srai", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sub", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sub },
> +=C2=A0=C2=A0=C2=A0 { "sll", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "slt", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_slt },
> +=C2=A0=C2=A0=C2=A0 { "sltu", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sltu },
> +=C2=A0=C2=A0=C2=A0 { "xor", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "srl", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sra", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "or", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "and", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "fence", rv_codec_r_f, rv_fmt_pred_succ },
> +=C2=A0=C2=A0=C2=A0 { "fence.i", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "lwu", rv_codec_i, rv_fmt_rd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "ld", rv_codec_i, rv_fmt_rd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sd", rv_codec_s, rv_fmt_rs2_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "addiw", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addiw =
},
> +=C2=A0=C2=A0=C2=A0 { "slliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "srliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "sraiw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "addw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "subw", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_subw },
> +=C2=A0=C2=A0=C2=A0 { "sllw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "srlw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sraw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "ldu", rv_codec_i, rv_fmt_rd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "lq", rv_codec_i, rv_fmt_rd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sq", rv_codec_s, rv_fmt_rs2_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "addid", rv_codec_i, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "sllid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "srlid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "sraid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "addd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "subd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "slld", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "srld", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "srad", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mul", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mulh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mulhsu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mulhu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "div", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "divu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "rem", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "remu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mulw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "divw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "divuw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "remw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "remuw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "muld", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "divd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "divud", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "remd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "remud", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "lr.w", rv_codec_r_l, rv_fmt_aqrl_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sc.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amoadd.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoxor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoand.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amomin.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amomax.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amominu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amomaxu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "lr.d", rv_codec_r_l, rv_fmt_aqrl_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sc.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amoadd.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoxor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoand.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amomin.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amomax.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amominu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amomaxu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "lr.q", rv_codec_r_l, rv_fmt_aqrl_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sc.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoswap.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amoadd.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoxor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoand.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amomin.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amomax.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amominu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amomaxu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "ecall", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "ebreak", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "uret", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "sret", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "hret", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "mret", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "dret", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "sfence.vm", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sfence.vma", rv_codec_r, rv_fmt_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "wfi", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_cs=
rrw },
> +=C2=A0=C2=A0=C2=A0 { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_cs=
rrs },
> +=C2=A0=C2=A0=C2=A0 { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm, rvcp_=
csrrwi },
> +=C2=A0=C2=A0=C2=A0 { "csrrsi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
> +=C2=A0=C2=A0=C2=A0 { "csrrci", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
> +=C2=A0=C2=A0=C2=A0 { "flw", rv_codec_i, rv_fmt_frd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fsw", rv_codec_s, rv_fmt_frs2_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> +=C2=A0=C2=A0=C2=A0 { "fmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> +=C2=A0=C2=A0=C2=A0 { "fnmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> +=C2=A0=C2=A0=C2=A0 { "fnmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> +=C2=A0=C2=A0=C2=A0 { "fadd.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fsub.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmul.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fdiv.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fsgnj.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_f=
sgnj_s },
> +=C2=A0=C2=A0=C2=A0 { "fsgnjn.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjn_s },
> +=C2=A0=C2=A0=C2=A0 { "fsgnjx.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjx_s },
> +=C2=A0=C2=A0=C2=A0 { "fmin.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmax.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fsqrt.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fle.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "flt.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "feq.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.w.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.wu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.s.w", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.s.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.x.s", rv_codec_r, rv_fmt_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fclass.s", rv_codec_r, rv_fmt_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.s.x", rv_codec_r, rv_fmt_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.l.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.lu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.s.l", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.s.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fld", rv_codec_i, rv_fmt_frd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fsd", rv_codec_s, rv_fmt_frs2_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> +=C2=A0=C2=A0=C2=A0 { "fmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> +=C2=A0=C2=A0=C2=A0 { "fnmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> +=C2=A0=C2=A0=C2=A0 { "fnmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> +=C2=A0=C2=A0=C2=A0 { "fadd.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fsub.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmul.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fdiv.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fsgnj.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_f=
sgnj_d },
> +=C2=A0=C2=A0=C2=A0 { "fsgnjn.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjn_d },
> +=C2=A0=C2=A0=C2=A0 { "fsgnjx.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjx_d },
> +=C2=A0=C2=A0=C2=A0 { "fmin.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmax.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.s.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.d.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fsqrt.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fle.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "flt.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "feq.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.wu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.d.w", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.d.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fclass.d", rv_codec_r, rv_fmt_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.l.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.lu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.x.d", rv_codec_r, rv_fmt_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.d.l", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.d.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.d.x", rv_codec_r, rv_fmt_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "flq", rv_codec_i, rv_fmt_frd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fsq", rv_codec_s, rv_fmt_frs2_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> +=C2=A0=C2=A0=C2=A0 { "fmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> +=C2=A0=C2=A0=C2=A0 { "fnmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> +=C2=A0=C2=A0=C2=A0 { "fnmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> +=C2=A0=C2=A0=C2=A0 { "fadd.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fsub.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmul.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fdiv.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fsgnj.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_f=
sgnj_q },
> +=C2=A0=C2=A0=C2=A0 { "fsgnjn.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjn_q },
> +=C2=A0=C2=A0=C2=A0 { "fsgnjx.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjx_q },
> +=C2=A0=C2=A0=C2=A0 { "fmin.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmax.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.s.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.q.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.d.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.q.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fsqrt.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fle.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "flt.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "feq.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.w.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.wu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.q.w", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.q.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fclass.q", rv_codec_r, rv_fmt_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.l.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.lu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.q.l", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1=
_imm, NULL,
> rv_op_addi,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addi, rv_op_addi, rvcd_imm_nz =
},
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1=
, NULL,
> rv_op_fld,
> @@ -1970,696 +1970,696 @@ static const rv_opcode_data
> rvi_opcode_data[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_r=
s1, NULL, 0, 0,
> rv_op_lq },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset=
_rs1, NULL, 0,
> 0,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sq },
> -=C2=A0=C2=A0=C2=A0 { "nop", rv_codec_i, rv_fmt_none, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mv", rv_codec_i, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "not", rv_codec_i, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "neg", rv_codec_r, rv_fmt_rd_rs2, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "negw", rv_codec_r, rv_fmt_rd_rs2, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sext.w", rv_codec_i, rv_fmt_rd_rs1, NULL, 0, 0, 0 =
},
> -=C2=A0=C2=A0=C2=A0 { "seqz", rv_codec_i, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "snez", rv_codec_r, rv_fmt_rd_rs2, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sltz", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sgtz", rv_codec_r, rv_fmt_rd_rs2, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.s", rv_codec_r, rv_fmt_frd_frs1, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "fabs.s", rv_codec_r, rv_fmt_frd_frs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fneg.s", rv_codec_r, rv_fmt_frd_frs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.d", rv_codec_r, rv_fmt_frd_frs1, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "fabs.d", rv_codec_r, rv_fmt_frd_frs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fneg.d", rv_codec_r, rv_fmt_frd_frs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.q", rv_codec_r, rv_fmt_frd_frs1, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "fabs.q", rv_codec_r, rv_fmt_frd_frs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fneg.q", rv_codec_r, rv_fmt_frd_frs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "beqz", rv_codec_sb, rv_fmt_rs1_offset, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "bnez", rv_codec_sb, rv_fmt_rs1_offset, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "blez", rv_codec_sb, rv_fmt_rs2_offset, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "bgez", rv_codec_sb, rv_fmt_rs1_offset, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "bltz", rv_codec_sb, rv_fmt_rs1_offset, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "bgtz", rv_codec_sb, rv_fmt_rs2_offset, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "ble", rv_codec_sb, rv_fmt_rs2_rs1_offset, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "bleu", rv_codec_sb, rv_fmt_rs2_rs1_offset, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "bgt", rv_codec_sb, rv_fmt_rs2_rs1_offset, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "bgtu", rv_codec_sb, rv_fmt_rs2_rs1_offset, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "j", rv_codec_uj, rv_fmt_offset, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "ret", rv_codec_i, rv_fmt_none, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "jr", rv_codec_i, rv_fmt_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "rdcycle", rv_codec_i_csr, rv_fmt_rd, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "rdtime", rv_codec_i_csr, rv_fmt_rd, NULL, 0, 0, 0 =
},
> -=C2=A0=C2=A0=C2=A0 { "rdinstret", rv_codec_i_csr, rv_fmt_rd, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "rdcycleh", rv_codec_i_csr, rv_fmt_rd, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "rdtimeh", rv_codec_i_csr, rv_fmt_rd, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "rdinstreth", rv_codec_i_csr, rv_fmt_rd, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "frcsr", rv_codec_i_csr, rv_fmt_rd, NULL, 0, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "frrm", rv_codec_i_csr, rv_fmt_rd, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "frflags", rv_codec_i_csr, rv_fmt_rd, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "fscsr", rv_codec_i_csr, rv_fmt_rd_rs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsrm", rv_codec_i_csr, rv_fmt_rd_rs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fsflags", rv_codec_i_csr, rv_fmt_rd_rs1, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsrmi", rv_codec_i_csr, rv_fmt_rd_zimm, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsflagsi", rv_codec_i_csr, rv_fmt_rd_zimm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "bseti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "bclri", rv_codec_i_sh7, rv_fmt_rd_rs1_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "binvi", rv_codec_i_sh7, rv_fmt_rd_rs1_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "bexti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "rori", rv_codec_i_sh7, rv_fmt_rd_rs1_imm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "clz", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "ctz", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "cpop", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sext.h", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 =
},
> -=C2=A0=C2=A0=C2=A0 { "sext.b", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 =
},
> -=C2=A0=C2=A0=C2=A0 { "xnor", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "orn", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "andn", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "rol", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "ror", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "sh1add", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sh2add", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sh3add", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sh1add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sh2add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sh3add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "clmul", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "clmulr", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "clmulh", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "min", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "minu", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "max", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "maxu", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "clzw", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "ctzw", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "cpopw", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "slli.uw", rv_codec_i_sh6, rv_fmt_rd_rs1_imm, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "rolw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "rorw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "rev8", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "zext.h", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 =
},
> -=C2=A0=C2=A0=C2=A0 { "roriw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "orc.b", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "bset", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "bclr", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "binv", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "bext", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "aes32esmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "aes32esi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "aes32dsmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "aes32dsi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "aes64ks1i", rv_codec_k_rnum, rv_fmt_rd_rs1_rnum, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "aes64ks2", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "aes64im", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "aes64esm", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "aes64es", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "aes64dsm", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "aes64ds", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sha256sig0", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "sha256sig1", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "sha256sum0", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "sha256sum1", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0=
 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig0", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig1", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sum0", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sum1", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sum0r", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sum1r", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig0l", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig0h", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig1l", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig1h", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sm3p0", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sm3p1", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sm4ed", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sm4ks", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "brev8", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "pack", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "packh", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "packw", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "unzip", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "zip", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "xperm4", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "xperm8", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 =
},
> -=C2=A0=C2=A0=C2=A0 { "vle8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vle16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vle32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vle64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vse8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vse16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vse32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vse64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vlm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vlse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vlse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vlse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vlse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vluxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vluxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vluxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vluxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vloxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vloxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vloxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vloxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsuxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsuxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsuxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsoxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsoxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsoxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsoxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vle8ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vle16ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vle32ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vle64ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl1re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl1re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl1re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl1re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl2re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl2re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl2re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl2re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl4re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl4re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl4re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl4re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl8re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl8re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl8re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vl8re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vs1r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vs2r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vs4r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vs8r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vrsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vrsub.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwsubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwsubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwaddu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwaddu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwadd.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwsubu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwsubu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwsub.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vand.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vand.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vand.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vxor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vxor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vxor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vnsrl.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnsrl.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vnsra.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnsra.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnsra.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmseq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmseq.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmseq.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsne.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsne.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsltu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsltu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmslt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmslt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsleu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsleu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsleu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsle.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsle.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsgtu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsgtu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsgt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmsgt.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vminu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vminu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmin.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmaxu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmaxu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmax.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmulhu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmulhu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmulhsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmulhsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vdivu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vdivu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vdiv.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vremu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vremu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vrem.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vrem.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwmulu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwmulu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwmulsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vwmulsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnmsac.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmadd.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnmsub.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwmaccu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vwmaccu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwmaccsu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vwmaccsu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vwmaccus.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmv.v.v", rv_codec_v_r, rv_fmt_vd_vs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmv.v.x", rv_codec_v_r, rv_fmt_vd_rs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmv.v.i", rv_codec_v_i, rv_fmt_vd_imm, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmerge.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmerge.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmerge.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsaddu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vssubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vssubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vssub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vssub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vaadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vasub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vasub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vasubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vasubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vssrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vssrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vssrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vssra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vssra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vssra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vnclipu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vnclipu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vnclipu.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vnclip.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnclip.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnclip.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfrsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwadd.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwsub.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfnmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfnmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfsqrt.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfrsqrt7.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfrec7.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfmin.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfmax.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnj.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnj.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnjn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnjn.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnjx.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnjx.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfslide1up.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfslide1down.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmfeq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmfeq.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmfne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmfne.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmflt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmflt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmfle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmfle.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmfgt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmfge.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfclass.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfmerge.vfm", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vl, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfmv.v.f", rv_codec_v_r, rv_fmt_vd_fs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.rtz.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.rtz.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.xu.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.x.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.f.xu.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.f.x.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.rod.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.rtz.xu.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.rtz.x.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vredand.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vredor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vredxor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vredminu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vredmaxu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vwredsumu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vwredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfredusum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfredosum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwredusum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwredosum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmnand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmandn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmxor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmorn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmxnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vcpop.m", rv_codec_v_r, rv_fmt_rd_vs2_vm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfirst.m", rv_codec_v_r, rv_fmt_rd_vs2_vm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmsbf.m", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmsif.m", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmsof.m", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "viota.m", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vid.v", rv_codec_v_r, rv_fmt_vd_vm, NULL, 0, 0, 0 =
},
> -=C2=A0=C2=A0=C2=A0 { "vmv.x.s", rv_codec_v_r, rv_fmt_rd_vs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmv.s.x", rv_codec_v_r, rv_fmt_vd_rs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfmv.f.s", rv_codec_v_r, rv_fmt_fd_vs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfmv.s.f", rv_codec_v_r, rv_fmt_vd_fs1, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vslideup.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vslideup.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_v=
m, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vslide1up.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vslidedown.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vslidedown.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm=
_vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vslide1down.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_v=
m, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vrgather.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vrgatherei16.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_=
vm, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vrgather.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vrgather.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_v=
m, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vcompress.vm", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vmv1r.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmv2r.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmv4r.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "vmv8r.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "vzext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vzext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vzext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsetvli", rv_codec_vsetvli, rv_fmt_vsetvli, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsetivli", rv_codec_vsetivli, rv_fmt_vsetivli, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsetvl", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.zext.b", rv_codec_zcb_ext, rv_fmt_rd, NULL, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.sext.b", rv_codec_zcb_ext, rv_fmt_rd, NULL, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.zext.h", rv_codec_zcb_ext, rv_fmt_rd, NULL, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.sext.h", rv_codec_zcb_ext, rv_fmt_rd, NULL, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.zext.w", rv_codec_zcb_ext, rv_fmt_rd, NULL, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.not", rv_codec_zcb_ext, rv_fmt_rd, NULL, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.mul", rv_codec_zcb_mul, rv_fmt_rd_rs2, NULL, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "c.lbu", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.lhu", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.lh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.sb", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.sh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "cm.push", rv_codec_zcmp_cm_pushpop, rv_fmt_push_rl=
ist, NULL,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "cm.pop", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_rlis=
t, NULL, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "cm.popret", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_r=
list, NULL,
> 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "cm.popretz", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_=
rlist,
> NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "cm.mva01s", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "cm.mvsa01", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "cm.jt", rv_codec_zcmt_jt, rv_fmt_zcmt_index, NULL,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index, NUL=
L, 0 },
> -=C2=A0=C2=A0=C2=A0 { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.bf16.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.bf16", rv_codec_r_m, rv_fmt_rm_frd_frs1, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vfncvtbf16.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvtbf16.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwmaccbf16.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_v=
m, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vfwmaccbf16.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_v=
m, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "flh", rv_codec_i, rv_fmt_frd_offset_rs1, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fsh", rv_codec_s, rv_fmt_frs2_offset_rs1, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.h.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.x.h", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "fli.s", rv_codec_fli, rv_fmt_fli, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fli.d", rv_codec_fli, rv_fmt_fli, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fli.q", rv_codec_fli, rv_fmt_fli, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fli.h", rv_codec_fli, rv_fmt_fli, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fminm.s", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmaxm.s", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fminm.d", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmaxm.d", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fminm.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmaxm.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fminm.h", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmaxm.h", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fround.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "froundnx.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fround.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "froundnx.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fround.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "froundnx.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fround.h", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "froundnx.h", rv_codec_r_m, rv_fmt_rm_frd_frs1, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fcvtmod.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "fmvh.x.d", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmvp.d.x", rv_codec_r, rv_fmt_frd_rs1_rs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmvh.x.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0,=
 0 },
> -=C2=A0=C2=A0=C2=A0 { "fmvp.q.x", rv_codec_r, rv_fmt_frd_rs1_rs2, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fleq.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fltq.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fleq.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fltq.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fleq.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fltq.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fleq.h", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "fltq.h", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaesdf.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaesdf.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaesdm.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaesdm.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaesef.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaesef.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaesem.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaesem.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaeskf1.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaeskf2.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaesz.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vandn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vandn.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vbrev.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vbrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0=
, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vclmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vclmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vclmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vclmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vclz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vcpop.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vctz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vghsh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, =
0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vgmul.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vrol.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vrol.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vror.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vror.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vror.vi", rv_codec_vror_vi, rv_fmt_vd_vs2_uimm_vm,=
 NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsha2ch.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsha2cl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsha2ms.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL=
, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsm3c.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsm3me.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL,=
 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsm4k.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsm4r.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsm4r.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0=
, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.0", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.1", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.2", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.3", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.4", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.5", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.6", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.7", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.8", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.9", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.10", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.11", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.12", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.13", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.14", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.15", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.16", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.17", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.18", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.19", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.20", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.21", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.22", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.23", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.24", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.25", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.26", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.27", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.28", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.29", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.30", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.r.31", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.3", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.4", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.1", rv_codec_ci_none, rv_fmt_none, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.3", rv_codec_ci_none, rv_fmt_none, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.5", rv_codec_ci_none, rv_fmt_none, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.7", rv_codec_ci_none, rv_fmt_none, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.9", rv_codec_ci_none, rv_fmt_none, NULL, 0, =
0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.11", rv_codec_ci_none, rv_fmt_none, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.13", rv_codec_ci_none, rv_fmt_none, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.15", rv_codec_ci_none, rv_fmt_none, NULL, 0,=
 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoswap.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoadd.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoxor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "amoand.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomin.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomax.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amominu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomaxu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoswap.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoadd.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoxor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amoor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NU=
LL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "amoand.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomin.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomax.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amominu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, =
NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, N=
ULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "wrs.sto", rv_codec_none, rv_fmt_none, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "wrs.nto", rv_codec_none, rv_fmt_none, NULL, 0, 0, =
0 },
> -=C2=A0=C2=A0=C2=A0 { "lpad", rv_codec_lp, rv_fmt_imm, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sspush", rv_codec_r, rv_fmt_rs2, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "sspopchk", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 }=
,
> -=C2=A0=C2=A0=C2=A0 { "ssrdp", rv_codec_r, rv_fmt_rd, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1=
, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1=
, NULL, 0,
> 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "nop", rv_codec_i, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "mv", rv_codec_i, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "not", rv_codec_i, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "neg", rv_codec_r, rv_fmt_rd_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "negw", rv_codec_r, rv_fmt_rd_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sext.w", rv_codec_i, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "seqz", rv_codec_i, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "snez", rv_codec_r, rv_fmt_rd_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sltz", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sgtz", rv_codec_r, rv_fmt_rd_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.s", rv_codec_r, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fabs.s", rv_codec_r, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fneg.s", rv_codec_r, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.d", rv_codec_r, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fabs.d", rv_codec_r, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fneg.d", rv_codec_r, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.q", rv_codec_r, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fabs.q", rv_codec_r, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fneg.q", rv_codec_r, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "beqz", rv_codec_sb, rv_fmt_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "bnez", rv_codec_sb, rv_fmt_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "blez", rv_codec_sb, rv_fmt_rs2_offset },
> +=C2=A0=C2=A0=C2=A0 { "bgez", rv_codec_sb, rv_fmt_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "bltz", rv_codec_sb, rv_fmt_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "bgtz", rv_codec_sb, rv_fmt_rs2_offset },
> +=C2=A0=C2=A0=C2=A0 { "ble", rv_codec_sb, rv_fmt_rs2_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "bleu", rv_codec_sb, rv_fmt_rs2_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "bgt", rv_codec_sb, rv_fmt_rs2_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "bgtu", rv_codec_sb, rv_fmt_rs2_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "j", rv_codec_uj, rv_fmt_offset },
> +=C2=A0=C2=A0=C2=A0 { "ret", rv_codec_i, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "jr", rv_codec_i, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "rdcycle", rv_codec_i_csr, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "rdtime", rv_codec_i_csr, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "rdinstret", rv_codec_i_csr, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "rdcycleh", rv_codec_i_csr, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "rdtimeh", rv_codec_i_csr, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "rdinstreth", rv_codec_i_csr, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "frcsr", rv_codec_i_csr, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "frrm", rv_codec_i_csr, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "frflags", rv_codec_i_csr, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "fscsr", rv_codec_i_csr, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fsrm", rv_codec_i_csr, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fsflags", rv_codec_i_csr, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fsrmi", rv_codec_i_csr, rv_fmt_rd_zimm },
> +=C2=A0=C2=A0=C2=A0 { "fsflagsi", rv_codec_i_csr, rv_fmt_rd_zimm },
> +=C2=A0=C2=A0=C2=A0 { "bseti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "bclri", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "binvi", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "bexti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "rori", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "clz", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "ctz", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "cpop", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sext.h", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sext.b", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "xnor", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "orn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "andn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "rol", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "ror", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sh1add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sh2add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sh3add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sh1add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sh2add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sh3add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "clmul", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "clmulr", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "clmulh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "min", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "minu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "max", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "maxu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "clzw", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "ctzw", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "cpopw", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "slli.uw", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "rolw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "rorw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "rev8", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "zext.h", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "roriw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
> +=C2=A0=C2=A0=C2=A0 { "orc.b", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "bset", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "bclr", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "binv", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "bext", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "aes32esmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> +=C2=A0=C2=A0=C2=A0 { "aes32esi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> +=C2=A0=C2=A0=C2=A0 { "aes32dsmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> +=C2=A0=C2=A0=C2=A0 { "aes32dsi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> +=C2=A0=C2=A0=C2=A0 { "aes64ks1i", rv_codec_k_rnum, rv_fmt_rd_rs1_rnum },
> +=C2=A0=C2=A0=C2=A0 { "aes64ks2", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "aes64im", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "aes64esm", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "aes64es", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "aes64dsm", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "aes64ds", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sha256sig0", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sha256sig1", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sha256sum0", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sha256sum1", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sha512sig0", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sha512sig1", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sha512sum0", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sha512sum1", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sha512sum0r", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sha512sum1r", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sha512sig0l", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sha512sig0h", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sha512sig1l", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sha512sig1h", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sm3p0", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sm3p1", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sm4ed", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> +=C2=A0=C2=A0=C2=A0 { "sm4ks", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> +=C2=A0=C2=A0=C2=A0 { "brev8", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "pack", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "packh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "packw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "unzip", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "zip", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "xperm4", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "xperm8", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "vle8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vle16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vle32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vle64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vse8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vse16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vse32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vse64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vlm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vlse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vlse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vlse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vlse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vsse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vsse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vsse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vsse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vluxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m },
> +=C2=A0=C2=A0=C2=A0 { "vluxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vluxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vluxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vloxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m },
> +=C2=A0=C2=A0=C2=A0 { "vloxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vloxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vloxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m },
> +=C2=A0=C2=A0=C2=A0 { "vsuxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vsuxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vsuxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vsoxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m },
> +=C2=A0=C2=A0=C2=A0 { "vsoxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vsoxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vsoxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vle8ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vle16ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vle32ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vle64ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl1re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vl1re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl1re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl1re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl2re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vl2re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl2re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl2re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl4re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vl4re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl4re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl4re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl8re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vl8re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl8re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vl8re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vs1r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vs2r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vs4r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vs8r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vrsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vrsub.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwsubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwsubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwaddu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwaddu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwadd.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwsubu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwsubu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwsub.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
> +=C2=A0=C2=A0=C2=A0 { "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
> +=C2=A0=C2=A0=C2=A0 { "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl },
> +=C2=A0=C2=A0=C2=A0 { "vmadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
> +=C2=A0=C2=A0=C2=A0 { "vmadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
> +=C2=A0=C2=A0=C2=A0 { "vmadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl },
> +=C2=A0=C2=A0=C2=A0 { "vsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
> +=C2=A0=C2=A0=C2=A0 { "vsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
> +=C2=A0=C2=A0=C2=A0 { "vmsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
> +=C2=A0=C2=A0=C2=A0 { "vmsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
> +=C2=A0=C2=A0=C2=A0 { "vand.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vand.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vand.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vxor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vxor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vxor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnsrl.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnsrl.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vnsra.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnsra.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnsra.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vmseq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmseq.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmseq.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsne.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsne.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsltu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsltu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmslt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmslt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsleu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsleu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsleu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsle.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsle.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsgtu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsgtu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsgt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsgt.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vminu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vminu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmin.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmaxu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmaxu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmax.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmulhu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmulhu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmulhsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmulhsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vdivu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vdivu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vdiv.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vremu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vremu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vrem.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vrem.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwmulu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwmulu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwmulsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwmulsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnmsac.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmadd.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnmsub.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwmaccu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwmaccu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwmaccsu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vwmaccsu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vwmaccus.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vmv.v.v", rv_codec_v_r, rv_fmt_vd_vs1 },
> +=C2=A0=C2=A0=C2=A0 { "vmv.v.x", rv_codec_v_r, rv_fmt_vd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "vmv.v.i", rv_codec_v_i, rv_fmt_vd_imm },
> +=C2=A0=C2=A0=C2=A0 { "vmerge.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
> +=C2=A0=C2=A0=C2=A0 { "vmerge.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
> +=C2=A0=C2=A0=C2=A0 { "vmerge.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl },
> +=C2=A0=C2=A0=C2=A0 { "vsaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsaddu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> +=C2=A0=C2=A0=C2=A0 { "vssubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vssubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vssub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vssub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vaadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vasub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vasub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vasubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vasubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vssrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vssrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vssrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vssra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vssra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vssra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vnclipu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnclipu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnclipu.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vnclip.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnclip.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vnclip.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfrsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwadd.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwsub.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfnmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfnmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vfwnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vfwmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vfwnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vfsqrt.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vfrsqrt7.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vfrec7.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vfmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmin.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmax.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfsgnj.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfsgnj.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfsgnjn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfsgnjn.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfsgnjx.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfsgnjx.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfslide1up.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vfslide1down.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vmfeq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmfeq.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmfne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmfne.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmflt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmflt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmfle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmfle.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmfgt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmfge.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfclass.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfmerge.vfm", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vl }=
,
> +=C2=A0=C2=A0=C2=A0 { "vfmv.v.f", rv_codec_v_r, rv_fmt_vd_fs1 },
> +=C2=A0=C2=A0=C2=A0 { "vfcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vfcvt.rtz.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vfwcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwcvt.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfwcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vfwcvt.rtz.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vfncvt.xu.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfncvt.x.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfncvt.f.xu.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfncvt.f.x.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfncvt.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfncvt.rod.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vfncvt.rtz.xu.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vfncvt.rtz.x.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vredand.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vredor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vredxor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vredminu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vredmaxu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwredsumu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vwredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vfredusum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vfredosum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vfredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vfredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vfwredusum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vfwredosum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vmand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmnand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmandn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmxor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmorn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmxnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vcpop.m", rv_codec_v_r, rv_fmt_rd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vfirst.m", rv_codec_v_r, rv_fmt_rd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsbf.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsif.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmsof.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "viota.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vid.v", rv_codec_v_r, rv_fmt_vd_vm },
> +=C2=A0=C2=A0=C2=A0 { "vmv.x.s", rv_codec_v_r, rv_fmt_rd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vmv.s.x", rv_codec_v_r, rv_fmt_vd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "vfmv.f.s", rv_codec_v_r, rv_fmt_fd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vfmv.s.f", rv_codec_v_r, rv_fmt_vd_fs1 },
> +=C2=A0=C2=A0=C2=A0 { "vslideup.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vslideup.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_v=
m },
> +=C2=A0=C2=A0=C2=A0 { "vslide1up.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vslidedown.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm=
 },
> +=C2=A0=C2=A0=C2=A0 { "vslidedown.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm=
_vm },
> +=C2=A0=C2=A0=C2=A0 { "vslide1down.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_v=
m },
> +=C2=A0=C2=A0=C2=A0 { "vrgather.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vrgatherei16.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_=
vm },
> +=C2=A0=C2=A0=C2=A0 { "vrgather.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "vrgather.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_v=
m },
> +=C2=A0=C2=A0=C2=A0 { "vcompress.vm", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> +=C2=A0=C2=A0=C2=A0 { "vmv1r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vmv2r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vmv4r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vmv8r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vzext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vzext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vzext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vsetvli", rv_codec_vsetvli, rv_fmt_vsetvli },
> +=C2=A0=C2=A0=C2=A0 { "vsetivli", rv_codec_vsetivli, rv_fmt_vsetivli },
> +=C2=A0=C2=A0=C2=A0 { "vsetvl", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "c.zext.b", rv_codec_zcb_ext, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "c.sext.b", rv_codec_zcb_ext, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "c.zext.h", rv_codec_zcb_ext, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "c.sext.h", rv_codec_zcb_ext, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "c.zext.w", rv_codec_zcb_ext, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "c.not", rv_codec_zcb_ext, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "c.mul", rv_codec_zcb_mul, rv_fmt_rd_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "c.lbu", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst }=
,
> +=C2=A0=C2=A0=C2=A0 { "c.lhu", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst }=
,
> +=C2=A0=C2=A0=C2=A0 { "c.lh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst },
> +=C2=A0=C2=A0=C2=A0 { "c.sb", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst },
> +=C2=A0=C2=A0=C2=A0 { "c.sh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst },
> +=C2=A0=C2=A0=C2=A0 { "cm.push", rv_codec_zcmp_cm_pushpop, rv_fmt_push_rl=
ist },
> +=C2=A0=C2=A0=C2=A0 { "cm.pop", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_rlis=
t },
> +=C2=A0=C2=A0=C2=A0 { "cm.popret", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_r=
list },
> +=C2=A0=C2=A0=C2=A0 { "cm.popretz", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_=
rlist },
> +=C2=A0=C2=A0=C2=A0 { "cm.mva01s", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "cm.mvsa01", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "cm.jt", rv_codec_zcmt_jt, rv_fmt_zcmt_index },
> +=C2=A0=C2=A0=C2=A0 { "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index },
> +=C2=A0=C2=A0=C2=A0 { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.bf16.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvt.s.bf16", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "vfncvtbf16.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vfwcvtbf16.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vfwmaccbf16.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_v=
m },
> +=C2=A0=C2=A0=C2=A0 { "vfwmaccbf16.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_v=
m },
> +=C2=A0=C2=A0=C2=A0 { "flh", rv_codec_i, rv_fmt_frd_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fsh", rv_codec_s, rv_fmt_frs2_offset_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.h.x", rv_codec_r, rv_fmt_frd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.x.h", rv_codec_r, rv_fmt_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fli.s", rv_codec_fli, rv_fmt_fli },
> +=C2=A0=C2=A0=C2=A0 { "fli.d", rv_codec_fli, rv_fmt_fli },
> +=C2=A0=C2=A0=C2=A0 { "fli.q", rv_codec_fli, rv_fmt_fli },
> +=C2=A0=C2=A0=C2=A0 { "fli.h", rv_codec_fli, rv_fmt_fli },
> +=C2=A0=C2=A0=C2=A0 { "fminm.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmaxm.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fminm.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmaxm.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fminm.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmaxm.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fminm.h", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmaxm.h", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fround.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "froundnx.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fround.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "froundnx.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fround.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "froundnx.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fround.h", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "froundnx.h", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fcvtmod.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmvh.x.d", rv_codec_r, rv_fmt_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmvp.d.x", rv_codec_r, rv_fmt_frd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmvh.x.q", rv_codec_r, rv_fmt_rd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmvp.q.x", rv_codec_r, rv_fmt_frd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "fleq.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fltq.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fleq.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fltq.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fleq.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fltq.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fleq.h", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "fltq.h", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> +=C2=A0=C2=A0=C2=A0 { "vaesdf.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vaesdf.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vaesdm.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vaesdm.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vaesef.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vaesef.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vaesem.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vaesem.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vaeskf1.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
> +=C2=A0=C2=A0=C2=A0 { "vaeskf2.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
> +=C2=A0=C2=A0=C2=A0 { "vaesz.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vandn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vandn.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vbrev.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vbrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vclmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vclmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vclmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vclmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vclz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vcpop.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vctz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vghsh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> +=C2=A0=C2=A0=C2=A0 { "vgmul.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> +=C2=A0=C2=A0=C2=A0 { "vrol.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vrol.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vror.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vror.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vror.vi", rv_codec_vror_vi, rv_fmt_vd_vs2_uimm_vm =
},
> +=C2=A0=C2=A0=C2=A0 { "vsha2ch.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> +=C2=A0=C2=A0=C2=A0 { "vsha2cl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> +=C2=A0=C2=A0=C2=A0 { "vsha2ms.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> +=C2=A0=C2=A0=C2=A0 { "vsm3c.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
> +=C2=A0=C2=A0=C2=A0 { "vsm3me.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> +=C2=A0=C2=A0=C2=A0 { "vsm4k.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
> +=C2=A0=C2=A0=C2=A0 { "vsm4r.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vsm4r.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> +=C2=A0=C2=A0=C2=A0 { "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> +=C2=A0=C2=A0=C2=A0 { "vwsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm }=
,
> +=C2=A0=C2=A0=C2=A0 { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.0", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.1", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.2", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.3", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.4", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.5", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.6", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.7", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.8", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.9", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.10", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.11", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.12", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.13", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.14", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.15", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.16", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.17", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.18", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.19", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.20", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.21", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.22", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.23", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.24", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.25", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.26", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.27", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.28", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.29", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.30", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.r.31", rv_codec_r, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mop.rr.3", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mop.rr.4", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "c.mop.1", rv_codec_ci_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "c.mop.3", rv_codec_ci_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "c.mop.5", rv_codec_ci_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "c.mop.7", rv_codec_ci_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "c.mop.9", rv_codec_ci_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "c.mop.11", rv_codec_ci_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "c.mop.13", rv_codec_ci_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "c.mop.15", rv_codec_ci_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "amoswap.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amoadd.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoxor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoand.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amomin.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amomax.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amominu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amomaxu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amoswap.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amoadd.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoxor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amoand.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amomin.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amomax.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amominu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> +=C2=A0=C2=A0=C2=A0 { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "wrs.sto", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "wrs.nto", rv_codec_none, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "lpad", rv_codec_lp, rv_fmt_imm },
> +=C2=A0=C2=A0=C2=A0 { "sspush", rv_codec_r, rv_fmt_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sspopchk", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "ssrdp", rv_codec_r, rv_fmt_rd },
> +=C2=A0=C2=A0=C2=A0 { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1=
 },
> +=C2=A0=C2=A0=C2=A0 { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1=
 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL=
, rv_op_sspush,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sspush, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NU=
LL,
> rv_op_sspopchk,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sspopchk, 0 },
> -=C2=A0=C2=A0 { "cbo.inval", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0 { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0 { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0 { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> -=C2=A0=C2=A0 { "mnret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
> +=C2=A0=C2=A0 { "cbo.inval", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0 { "cbo.clean", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0 { "cbo.flush", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0 { "cbo.zero", rv_codec_r, rv_fmt_rs1 },
> +=C2=A0=C2=A0 { "mnret", rv_codec_none, rv_fmt_none },
> =C2=A0};
> =C2=A0
> =C2=A0/* CSR names */

