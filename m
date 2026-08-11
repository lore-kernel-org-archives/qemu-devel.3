Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D236BC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtt1l-0003tX-Nh; Tue, 11 Aug 2026 16:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt1j-0003t7-Tq; Tue, 11 Aug 2026 16:24:48 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt1h-0004Im-NU; Tue, 11 Aug 2026 16:24:47 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 489B0EC01C6;
 Tue, 11 Aug 2026 16:24:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 16:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479884; x=1786566284; bh=gB4V0vhqLk07U5HR4IIIxn7U9JqhmP+U
 U8inFzHVObM=; b=m6nEIUw1EV0um11Owfdtxwfa7DVKbbNNbjIUZLfWTUc7By7l
 hxgCUeSIum+b6CD2bTY3C3K2taKNDBNWDx515tPEMvlYt99X0khh/Fw6Au5sGaJW
 ZBE+eiKvvJ1AKJNPNy8WiKadUJaoKeCGlxtoAF6Np3UDB+M3QmqqDKj4xsTyKsQy
 l5bhneFhcqQpRPU44SslwhGY3LsfCzGRuvvxhqi0WdyJ4F2WJbbc2QyI29J9B+aw
 a13fCPRtCTwZSyxQrXcsYN6lmSN6t8xuoJwdFJ/xDJrhWhSYnQW0mWAtC9rXuo9e
 8VwYzGgJDLd4f1t91stfSLetngW5tbEyKgzFcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479884; x=
 1786566284; bh=gB4V0vhqLk07U5HR4IIIxn7U9JqhmP+UU8inFzHVObM=; b=F
 DdgMgdK+cQgq5V5fV4lMRbXaEREkFtKN4BMm6mnvzEQLB2lCYbgf71EmlDNAAgGN
 yPGYixzCEegq0Z9rg8PrISoczoMsloE7g3fDaoYj3LBXOZOnpLYXbLZ5D/C8mi9Y
 mJAV4iyoLB9HWc9eM51+UtsXnpWgzyzSAAZ5nDw6rZ29qe2monhTT9C17rfWw/Yz
 a5Vnlq6ewfsLSRAfBuH1MM6UvQv+EXfhV8D28g6hWZHwDi9SHlognDcR1JbOTc2K
 Vx6srfTwFsuEFR5GM8xJkdgKN69LbFf+GSaDh+Cb+jVg57MNAjyWltlvel9Br7gA
 yHZ1l4BYQ5q7EKWBVNBxg==
X-ME-Sender: <xms:DIV7ausRVz72W6kMvf3q3MNblqjglwRqamHmZn-mWL4rcpkX0lTZzg>
 <xme:DIV7anyuZ7GR_gtkkEo20LkUnm3Ru9XhpJ-6uOROskrDAu_U7h-etvQf4iXwOQxCz
 46WR_1N6Od7qQthf_tTumB263DEyQ6oi3lWINktoycWwpFCdmYdqw>
X-ME-Received: <xmr:DIV7ao5lze0M3_BF_0oNO4l6d-zZ9X6ehqF6xpidjbJ2a5rtWpJOec_8lQ8k5KgVNaauGw>
X-ME-Proxy-Cause: dmFkZTEe44bzU318ZKGPPkmI//vzCNdVcYTYrqRtyU+DALhpzqDIrDJwcBKSHZMm4wnCMf
 9PUVrK5o6AhiUSiuSHL+1pFOddNIyiumPnXWByRYWCiPKoMD7LpIxSXTPbQLcCCeUi2Ayl
 lZhv0amE+njS/NQ6fBOmBDx+m0qvsBnHoW/t9sg/Z1H8bHw4jmKj5CgcDmj+xNoBXMcCsB
 VunOEWHMKShnBk/h7Ljnrzisg4XMruYntxk0fJHDFNQ4GaUuSnP7WZIf61sh4YmvNs4ksS
 qLV4eLP9GUxwdWyxSb7FXaax/mli1hOteEtTMY4L052hQLPg6p0x5fRGFTYIR45pG4W+EC
 DSs394pmXRIom2Ee7+jjCHG3uahfczsFx6kppaxXV6nvTRWTLOKYQ4Et956BRZk3t8otVP
 RAvsF8MOs/Y79gXOyvXyy2gaon9aR3Wci1dp4WO7Te8WybRM1vd21At6zFuD7HemVeJaoz
 SuaIBG2MfRtELyO7SQ6LcsAlgdQLn24J7Lv6eeu1pAM64vAK90yrAQk7V9tP8G6cudc6rO
 2R59fKngPeDjKMybAt6XKhUgiR7jHoS9lDKRwIs0RrPMC+G2GagxnMTsfbYGsUbk+s0A3d
 /I8z8UQb2kFMdGLzlO2+cikStdCnQ13NBouLyl3BBvJ7uAmIy981wI6JzmaA
X-ME-Proxy: <xmx:DIV7ahXJaz5UVz3um3Iw7lR-NGXQ535KB6BuWeJ9Pnd6HSAkzkyU0w>
 <xmx:DIV7ak2EZzTyslwRBM553j64eOZ7kgq9lyljk6wkox3eF_6GctX_Gw>
 <xmx:DIV7am0Gt_YdXxlGvKf4CTnMr0z8eQ5DzuirWbjeokAi04-G6QFIeA>
 <xmx:DIV7av8lkVjjj-7W441iTRLrxrsEB2bLJ90W3gPqvpU16rSMryyRug>
 <xmx:DIV7aqxqfyzYUG5YXbAcZFBODeq0MYql37HyQ4aQLITiTQQlOlp8vapa>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:24:43 -0400 (EDT)
Message-ID: <a2fa3157ab7666a2d9c4a48f602b14c83a2aab72.camel@alistair23.me>
Subject: Re: [PATCH 32/56] disas/riscv: Handle decompression via
 decode_inst_lift_pseudo
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:24:43 +1000
In-Reply-To: <20260809223545.730664-33-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-33-richard.henderson@linaro.org>
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
> Introduce a DECOMP macro that expands an rv_comp_data
> that always succeeds.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.h |=C2=A0=C2=A0 1 -
> =C2=A0disas/riscv.c | 113 +++++++++++++++++++++++------------------------=
-
> --
> =C2=A02 files changed, 51 insertions(+), 63 deletions(-)
>=20
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 3bbcbf10fb..ea7141d3b5 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -174,7 +174,6 @@ typedef struct {
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_codec codec;
> =C2=A0=C2=A0=C2=A0=C2=A0 const char *format;
> =C2=A0=C2=A0=C2=A0=C2=A0 const rv_comp_data *pseudo;
> -=C2=A0=C2=A0=C2=A0 rv_opcode decomp;
> =C2=A0} rv_opcode_data;
> =C2=A0
> =C2=A0typedef struct {
> diff --git a/disas/riscv.c b/disas/riscv.c
> index b8e5b124a5..129e545c6e 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1065,6 +1065,7 @@ static const rvc_constraint rvcc_ret[] =3D {
> rvc_rd_eq_x0, rvc_rs1_eq_ra,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rvc_end };
> =C2=A0static const rvc_constraint rvcc_jr[] =3D { rvc_rd_eq_x0,
> rvc_imm_eq_zero,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rvc_end };
> +static const rvc_constraint rvcc_true[] =3D { rvc_end };
> =C2=A0
> =C2=A0/* pseudo-instruction metadata */
> =C2=A0
> @@ -1190,6 +1191,9 @@ static const rv_comp_data rvcp_fsgnjx_q[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> =C2=A0};
> =C2=A0
> +/* Convert compressed insns into normal insns via pseudo expansion.
> */
> +#define DECOMP(X) (static const rv_comp_data[1]){ { X, rvcc_true } }
> +
> =C2=A0/* operand extractors */
> =C2=A0
> =C2=A0static uint32_t operand_rd(rv_inst inst)
> @@ -1815,52 +1819,52 @@ static const rv_opcode_data rvi_opcode_data[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 }=
,
> =C2=A0=C2=A0=C2=A0=C2=A0 { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm,=
 NULL,
> rv_op_addi },
> -=C2=A0=C2=A0=C2=A0 { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NUL=
L,
> rv_op_fld },
> -=C2=A0=C2=A0=C2=A0 { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL,=
 rv_op_lw
> },
> -=C2=A0=C2=A0=C2=A0 { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, NUL=
L,
> rv_op_flw },
> -=C2=A0=C2=A0=C2=A0 { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, NU=
LL,
> rv_op_fsd },
> -=C2=A0=C2=A0=C2=A0 { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL=
, rv_op_sw
> },
> -=C2=A0=C2=A0=C2=A0 { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NU=
LL,
> rv_op_fsw },
> +=C2=A0=C2=A0=C2=A0 { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_addi) },
> +=C2=A0=C2=A0=C2=A0 { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1,
> DECOMP(rv_op_fld) },
> +=C2=A0=C2=A0=C2=A0 { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, DECOM=
P(rv_op_lw)
> },
> +=C2=A0=C2=A0=C2=A0 { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1,
> DECOMP(rv_op_flw) },
> +=C2=A0=C2=A0=C2=A0 { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1,
> DECOMP(rv_op_fsd) },
> +=C2=A0=C2=A0=C2=A0 { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sw) },
> +=C2=A0=C2=A0=C2=A0 { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1,
> DECOMP(rv_op_fsw) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> -=C2=A0=C2=A0=C2=A0 { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_=
op_addi },
> -=C2=A0=C2=A0=C2=A0 { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, r=
v_op_jal },
> -=C2=A0=C2=A0=C2=A0 { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv=
_op_addi },
> -=C2=A0=C2=A0=C2=A0 { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, =
NULL,
> rv_op_addi },
> -=C2=A0=C2=A0=C2=A0 { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_=
op_lui },
> -=C2=A0=C2=A0=C2=A0 { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL,=
 rv_op_srli
> },
> -=C2=A0=C2=A0=C2=A0 { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL,=
 rv_op_srai
> },
> -=C2=A0=C2=A0=C2=A0 { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL,=
 rv_op_andi
> },
> -=C2=A0=C2=A0=C2=A0 { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_sub },
> -=C2=A0=C2=A0=C2=A0 { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_xor },
> -=C2=A0=C2=A0=C2=A0 { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op=
_or },
> -=C2=A0=C2=A0=C2=A0 { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_and },
> -=C2=A0=C2=A0=C2=A0 { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_=
op_subw },
> -=C2=A0=C2=A0=C2=A0 { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_=
op_addw },
> -=C2=A0=C2=A0=C2=A0 { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_j=
al },
> -=C2=A0=C2=A0=C2=A0 { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL,=
 rv_op_beq
> },
> -=C2=A0=C2=A0=C2=A0 { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL,=
 rv_op_bne
> },
> -=C2=A0=C2=A0=C2=A0 { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL,=
 rv_op_slli
> },
> -=C2=A0=C2=A0=C2=A0 { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1,=
 NULL,
> rv_op_fld },
> -=C2=A0=C2=A0=C2=A0 { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, N=
ULL,
> rv_op_lw },
> -=C2=A0=C2=A0=C2=A0 { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1,=
 NULL,
> rv_op_flw },
> -=C2=A0=C2=A0=C2=A0 { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, NULL,=
 rv_op_jalr
> },
> -=C2=A0=C2=A0=C2=A0 { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, NULL, rv=
_op_addi },
> -=C2=A0=C2=A0=C2=A0 { "c.ebreak", rv_codec_ci_none, rv_fmt_none, NULL, rv=
_op_ebreak
> },
> -=C2=A0=C2=A0=C2=A0 { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, N=
ULL,
> rv_op_jalr },
> -=C2=A0=C2=A0=C2=A0 { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_add },
> -=C2=A0=C2=A0=C2=A0 { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs=
1, NULL,
> rv_op_fsd },
> -=C2=A0=C2=A0=C2=A0 { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1,=
 NULL,
> rv_op_sw },
> -=C2=A0=C2=A0=C2=A0 { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs=
1, NULL,
> rv_op_fsw },
> -=C2=A0=C2=A0=C2=A0 { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, NULL,=
 rv_op_ld
> },
> -=C2=A0=C2=A0=C2=A0 { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, NULL=
,=C2=A0 rv_op_sd
> },
> -=C2=A0=C2=A0=C2=A0 { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv=
_op_addiw
> },
> -=C2=A0=C2=A0=C2=A0 { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, N=
ULL,
> rv_op_ld },
> -=C2=A0=C2=A0=C2=A0 { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1,=
 NULL,
> rv_op_sd },
> -=C2=A0=C2=A0=C2=A0 { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, NULL,=
 rv_op_lq
> },
> -=C2=A0=C2=A0=C2=A0 { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1, NULL=
, rv_op_sq
> },
> -=C2=A0=C2=A0=C2=A0 { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1, N=
ULL,
> rv_op_lq },
> -=C2=A0=C2=A0=C2=A0 { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1,=
 NULL,
> rv_op_sq },
> +=C2=A0=C2=A0=C2=A0 { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, DECOMP(rv=
_op_addi)
> },
> +=C2=A0=C2=A0=C2=A0 { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, DECOMP(=
rv_op_jal)
> },
> +=C2=A0=C2=A0=C2=A0 { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, DECOMP(r=
v_op_addi)
> },
> +=C2=A0=C2=A0=C2=A0 { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_addi) },
> +=C2=A0=C2=A0=C2=A0 { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, DECOMP(rv=
_op_lui) },
> +=C2=A0=C2=A0=C2=A0 { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_srli) },
> +=C2=A0=C2=A0=C2=A0 { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_srai) },
> +=C2=A0=C2=A0=C2=A0 { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_andi) },
> +=C2=A0=C2=A0=C2=A0 { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_=
op_sub) },
> +=C2=A0=C2=A0=C2=A0 { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_=
op_xor) },
> +=C2=A0=C2=A0=C2=A0 { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_o=
p_or) },
> +=C2=A0=C2=A0=C2=A0 { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_=
op_and) },
> +=C2=A0=C2=A0=C2=A0 { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv=
_op_subw)
> },
> +=C2=A0=C2=A0=C2=A0 { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv=
_op_addw)
> },
> +=C2=A0=C2=A0=C2=A0 { "c.j", rv_codec_cj, rv_fmt_rd_offset, DECOMP(rv_op_=
jal) },
> +=C2=A0=C2=A0=C2=A0 { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset,
> DECOMP(rv_op_beq) },
> +=C2=A0=C2=A0=C2=A0 { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset,
> DECOMP(rv_op_bne) },
> +=C2=A0=C2=A0=C2=A0 { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_slli) },
> +=C2=A0=C2=A0=C2=A0 { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1,
> DECOMP(rv_op_fld) },
> +=C2=A0=C2=A0=C2=A0 { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1,
> DECOMP(rv_op_lw) },
> +=C2=A0=C2=A0=C2=A0 { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1,
> DECOMP(rv_op_flw) },
> +=C2=A0=C2=A0=C2=A0 { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset,
> DECOMP(rv_op_jalr) },
> +=C2=A0=C2=A0=C2=A0 { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, DECOMP(r=
v_op_addi)
> },
> +=C2=A0=C2=A0=C2=A0 { "c.ebreak", rv_codec_ci_none, rv_fmt_none,
> DECOMP(rv_op_ebreak) },
> +=C2=A0=C2=A0=C2=A0 { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset,
> DECOMP(rv_op_jalr) },
> +=C2=A0=C2=A0=C2=A0 { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, DECOMP(rv_=
op_add) },
> +=C2=A0=C2=A0=C2=A0 { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs=
1,
> DECOMP(rv_op_fsd) },
> +=C2=A0=C2=A0=C2=A0 { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sw) },
> +=C2=A0=C2=A0=C2=A0 { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs=
1,
> DECOMP(rv_op_fsw) },
> +=C2=A0=C2=A0=C2=A0 { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, DECOM=
P(rv_op_ld)
> },
> +=C2=A0=C2=A0=C2=A0 { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sd) },
> +=C2=A0=C2=A0=C2=A0 { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, DECOMP(r=
v_op_addiw)
> },
> +=C2=A0=C2=A0=C2=A0 { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1,
> DECOMP(rv_op_ld) },
> +=C2=A0=C2=A0=C2=A0 { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sd) },
> +=C2=A0=C2=A0=C2=A0 { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, DECOM=
P(rv_op_lq)
> },
> +=C2=A0=C2=A0=C2=A0 { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sq) },
> +=C2=A0=C2=A0=C2=A0 { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1,
> DECOMP(rv_op_lq) },
> +=C2=A0=C2=A0=C2=A0 { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sq) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "nop", rv_codec_i, rv_fmt_none },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "mv", rv_codec_i, rv_fmt_rd_rs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "not", rv_codec_i, rv_fmt_rd_rs1 },
> @@ -2542,8 +2546,8 @@ static const rv_opcode_data rvi_opcode_data[] =3D
> {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "ssrdp", rv_codec_r, rv_fmt_rd },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs=
2_rs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs=
2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL, rv_=
op_sspush
> },
> -=C2=A0=C2=A0=C2=A0 { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL,
> rv_op_sspopchk },
> +=C2=A0=C2=A0=C2=A0 { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, DECOMP(rv=
_op_sspush)
> },
> +=C2=A0=C2=A0=C2=A0 { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1,
> DECOMP(rv_op_sspopchk) },
> =C2=A0=C2=A0=C2=A0 { "cbo.inval", rv_codec_r, rv_fmt_rs1 },
> =C2=A0=C2=A0=C2=A0 { "cbo.clean", rv_codec_r, rv_fmt_rs1 },
> =C2=A0=C2=A0=C2=A0 { "cbo.flush", rv_codec_r, rv_fmt_rs1 },
> @@ -5269,20 +5273,6 @@ static const rv_opcode_data
> *decode_inst_lift_pseudo(rv_decode *dec,
> =C2=A0=C2=A0=C2=A0=C2=A0 return op;
> =C2=A0}
> =C2=A0
> -/* decompress instruction */
> -
> -static const rv_opcode_data *decode_inst_decompress(rv_decode *dec,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 const
> rv_opcode_data *op)
> -{
> -=C2=A0=C2=A0=C2=A0 int decomp_op =3D op->decomp;
> -
> -=C2=A0=C2=A0=C2=A0 if (decomp_op !=3D rv_op_illegal) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->op =3D decomp_op;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D &dec->opcode_data[deco=
mp_op];
> -=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 return op;
> -}
> -
> =C2=A0/* disassemble instruction */
> =C2=A0
> =C2=A0static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
> @@ -5333,7 +5323,6 @@ static GString *disasm_inst(rv_isa isa,
> uint64_t pc, rv_inst inst,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 op =3D &dec.opcode_data[dec.op];
> =C2=A0=C2=A0=C2=A0=C2=A0 decode_inst_operands(&dec, isa, op);
> -=C2=A0=C2=A0=C2=A0 op =3D decode_inst_decompress(&dec, op);
> =C2=A0=C2=A0=C2=A0=C2=A0 op =3D decode_inst_lift_pseudo(&dec, op);
> =C2=A0=C2=A0=C2=A0=C2=A0 return format_inst(24, &dec, op);
> =C2=A0}

