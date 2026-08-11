Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836C6C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsrV-0004FG-4W; Tue, 11 Aug 2026 16:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsrM-0004Df-PT; Tue, 11 Aug 2026 16:14:09 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsrL-0002yS-9I; Tue, 11 Aug 2026 16:14:04 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 817B9EC01CE;
 Tue, 11 Aug 2026 16:14:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 16:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479240; x=1786565640; bh=46QVBeWBEM3IQEHApv4Bcn9UA5knMgnq
 PVWR3zKR1zs=; b=RMCQl6CQ/3Zo/bK/5v/5MbVT9PpSOou0R0+U/xQLxGwIAX7S
 jyM/od3F4McxCfNi+A32eMEda9Pl0+XRDWkoYe76XbM2nEcaeFDyIyM2OdzmwdoJ
 ykZ+kGCvuhZXga/8jr2bChQub21/UhWxhjjghMAMFeinrvOUyhYFkz9lPPPMErwT
 HJ1f4jJTWKf/I8H3m3gsop78wn3aU6SX8aBqvz2eisPxI+xHRVriL0ANY4KZGfK6
 SQ7iiIgbJxqlB8E7IMVqIyHl4RUPZeh1uvmqa8jRuxTerqloZySyhGXjRII+cnaX
 0xbyp2aMQw8Ib0kZ4jIiz/Up4CjRFyBT7F2TBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479240; x=
 1786565640; bh=46QVBeWBEM3IQEHApv4Bcn9UA5knMgnqPVWR3zKR1zs=; b=I
 ZHgWoAJANBDKR/yu35nXJK873bPaCVK53mkCplOOhynTTiG67MFbl7bNibdBBLR1
 XoRpA1bVSRc8A93q+KVlOpfL9aWooYiUZ+uBzQgfcHD25a+zAElG9g9nf4r/UoUR
 GebW4GSLH62IYA2rmeVvySvpqWf/UDYYQNWAZMOU78K6RnU0p/r2ZbtlXcH+wXMn
 p9u+z6Z5syyWn6P0ZBfncGlq5XVZKDl51Q+7TG7oSqrtX5iYCZEcHqbQeT/7INKJ
 Q9QdvghJPWL95CmSN1BFRmnDshdQxZQNpzMn9Zm/6Ei+kIr+pmaUvV3J/s06kGR5
 dzKDtBLb0LmrmWO7Fw40Q==
X-ME-Sender: <xms:iIJ7au4s_ii_4iIyzyAeVNCevc-Lzot0jTffHAV6GvzlGERWtz-ykQ>
 <xme:iIJ7asPglj1V3W8MBJIqGkk2-64TvsaWwul_EBlnJOlVFidCYWMr4jlB77bGK0kJf
 dtJ1CIwgHSTdhuVDUabLW9YRmc1_mRQ70Pcl2Oow9WTBIO31iqU6w>
X-ME-Received: <xmr:iIJ7asmXhfAR56dXYaHixRY7_sjoBZrNzd7aMl7wKPi1Kxb44-2VchWJKdTFzqCInukMYg>
X-ME-Proxy-Cause: dmFkZTFmzoB37enw+G5Jj89yBAskoL3QjmCbpuwf6axCPPT5+/BgeDXBwVDcGfdR7neByN
 VqgTWbmquFFH4mFQ93nDU+4RNa4bqy9l5zjDCB/GjqXdgjBNJ/kKAttKQUeziRzpQKqBhB
 nKJGn6wu9yop5EHgwiwiOEYGfQkGJokUWJwwipPqf/2FOKcM/WnIBH2Fle0yc7amE+7nxR
 ObUvQTqmG8iBhOpxkuLEzQgeqeex1NYE2A1EPdrqg7OPX95076lbURDAC22PCgqkeB8ixy
 Bd9IbZ1WCk670GXLkwiU9Rutal124mabZ6C8kAdVKJKNIEMMjUM8oZmBVI7uw0kUY7vlLZ
 Nc1AJZjNI9sO6oRvJhM6NAo4LsyapQsoIqYiis4ZEnfsd8w4VVUcATI0FLvYIrljUos7rD
 AGyZGRDSBtuE7s5zYvsi8bAVMAjGejU0a7yy+7vUYGXICmG5WZ1gilpFH3qnt39Sn6b1u7
 Zwd1NhJR0MtU7pouFqvNh8tAI81KXexBQ4Zmcoyerxc533lJQfxnemIpJ492K2mVp+T0wj
 L1dpFkrul83G+FOaD5ZSsuT6jtVAmKwfQeQMbnzsbjAOLIgzsVfp6Zwdh9tKHMozweEw2G
 eQR0xQi5/Aj9ucILw5ysLbDeYrUoSwGXiOuy69Sv3x+Npv8g6oNyEm0xLjBA
X-ME-Proxy: <xmx:iIJ7ajQuXlwle1oiZxN29DSAions3XFrch294PH-O_xcK6MqvUaktA>
 <xmx:iIJ7aoBsCtZiwRuN_J9toAFScsorlUnREl8TYChzX6Az8DplDCr4Ag>
 <xmx:iIJ7aiS2tW6Yd4BbpvRJmKbVIoPu9wiKw48VoJZdgX_cqnh2QHiavw>
 <xmx:iIJ7aupglPA9ewcdGUMdmtfl4YzQsk7L70OyklZAOCDZY9AGlGWl9w>
 <xmx:iIJ7arvJ0nRHJmTt97a__8AIxboF3D5inQrWtYpStOeZoAoUC09WzlRN>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:14:00 -0400 (EDT)
Message-ID: <54fd125ddfbf7b720738b3cf6ab6c9df476586ba.camel@alistair23.me>
Subject: Re: [PATCH 19/56] disas/riscv: Simplify c.addi
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:14:00 +1000
In-Reply-To: <20260809223545.730664-20-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-20-richard.henderson@linaro.org>
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
> While c.addi with imm =3D=3D 0 and rd =3D=3D 0 is c.nop,
> other c.addi with imm =3D=3D 0 and rd !=3D 0 are not illegal,
> but are reserved as HINTs.=C2=A0 Go ahead and disassemble as
> c.addi rather than falling back to invalid.
>=20
> Further, there's no reason to differentiate c.nop, since we have
> =C2=A0 c.addi -> addi -> nop
> vs
> =C2=A0 c.nop -> addi -> nop
> via decompress and pseudo translation steps.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 11 +++--------
> =C2=A01 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 8a957e6a1e..7978ffb378 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -263,7 +263,6 @@ typedef enum {
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_c_fsd =3D 231,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_c_sw =3D 232,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_c_fsw =3D 233,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_nop =3D 234,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_c_addi =3D 235,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_c_jal =3D 236,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_c_li =3D 237,
> @@ -1896,10 +1895,9 @@ static const rv_opcode_data rvi_opcode_data[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1,=
 NULL, rv_op_sw,
> rv_op_sw,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sw },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs=
1, NULL,
> rv_op_fsw, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.nop", rv_codec_ci_none, rv_fmt_none, NULL, rv_op=
_addi,
> rv_op_addi,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addi },
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL=
, rv_op_addi,
> rv_op_addi,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addi, rvcd_imm_nz },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addi },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NU=
LL, rv_op_jal,
> 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NUL=
L, rv_op_addi,
> rv_op_addi,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addi },
> @@ -3010,10 +3008,7 @@ static void decode_inst_opcode(rv_decode *dec,
> rv_isa isa)
> =C2=A0=C2=A0=C2=A0=C2=A0 case 1:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch ((inst >> 13) & 0=
b111) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switc=
h ((inst >> 2) & 0b11111111111) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case =
0: op =3D rv_op_c_nop; break;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defau=
lt: op =3D rv_op_c_addi; break;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =
=3D rv_op_c_addi; /* or unspecified HINT */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 1:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (isa =3D=3D rv32) {

