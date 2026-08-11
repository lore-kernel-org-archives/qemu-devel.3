Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410E4C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtt4v-0005li-JA; Tue, 11 Aug 2026 16:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt4p-0005b9-Tk; Tue, 11 Aug 2026 16:28:01 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt4n-0004eQ-C7; Tue, 11 Aug 2026 16:27:59 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 6565AEC0139;
 Tue, 11 Aug 2026 16:27:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 16:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786480076; x=1786566476; bh=tC6Efwy6vMm8o84tpWy0y8FKEGqnVUAI
 U6HAanvT8j0=; b=R1teJ88B0PyxySiyyUaYs2O+Eq+K5gkZhFaZsxuWlsm7K2JP
 hufslKVW3cWfA7gL38934MIMqnX9PE2BpH4GXW9WakjYigIEKEJt3aL3QT4sKD6s
 JlgrzHnOxC213lpIH/BUY+Ymi2JQwgiJZ0MosvMjDeYBztvD/EqpC957nNcl+FwF
 KNXONwkVn0p5uUeakSa/DnZA8Svrv4D2n+fwTXMS4OGLfa+KGb72KM4jWzLncvZg
 pO+beJiW2pVPIZUW5Hn1W0EZVaJ02TVbp8MJjOh9W80w3NjIKhHMqOm8zLw9a6Lt
 vNf0lfnsmaijVLxGb+HpMjLoW+aDjo4nBjtHFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786480076; x=
 1786566476; bh=tC6Efwy6vMm8o84tpWy0y8FKEGqnVUAIU6HAanvT8j0=; b=J
 RzhOspG4nssxlx2bb5Udd3CC/+iicLaQSbV3xZ7Ah16GyNlKwMaSWCkU9Z9dBztt
 D+1SYsCVGOj7bZMwyvtBY2TEBdLFGnUPO4Ut7CpOcTcDFTkyyDcvspqrOT1u7au7
 YacVmPqg+ZxIf/T+5Eb7OHM9kdh0iaas44o4oaTtrKTjNJx6/8uNPCt5EflxCs6A
 GasDS5OQ6ZCfvAYD02f0ovyl5TpqvtOrJqu2TxPId3gLvjdAVzls37AgzZMI886t
 KHjeq0Y5OBlU2rmAG2ifkQTyiR3T7yBMv1B1wM3hwzXJs8K7H8jgKLlamyNju85j
 0ANBELxVoyLDF5pPXWILw==
X-ME-Sender: <xms:zIV7aun2L-xXxGUM64jnx687sasxV4AQZJ8yFJr-K5RPQErcC-uS3Q>
 <xme:zIV7aqJipfLra9pv7MgfEjTAUchtHasxwGUydTIn7nbhtO9SrSHKYcgm4_fAJEVJE
 wZX7XxKnJv_okInk7B3eEpl4Lp3qZ8ABMQLV1iGvfGYZYxf2kIRdXI>
X-ME-Received: <xmr:zIV7arw99SujTJ3Yf2uOJWRUPCt8UsuZw1XnIiGCkH-kjdhIt8sNv7lK4Rz8ijNOJwBwpw>
X-ME-Proxy-Cause: dmFkZTGjUGzLRt9YOoIfVi9vPX4yoGfoQnYyxR7IFQ4SHcUvWhFxNxXT+GkVoSD19/bXmw
 5O0Dyhzj2TyuOUX2bOaNZB7fqiHT0plD60kpacmEnpmm5gjeTuCdiB89Yazs98ranQOjBt
 U4o8Tp5bbODctlmHPXYLemU9KRN/H6Li7+dPxsfPbEiBrAz9mA4XvNPpGZ9No+DagwB+N1
 YzKMKPzFso3cdSigp6m6M9+1vJYtDqlQXrH5OHR/CQAzCe2merT6sXC9xj72kULZACCp3C
 G9L6chff/RsqzyCr6zon9p1XbCcRVNTGOc+FJvUgzFUv+iha+vYj5IAeOLh1NzQB62UCO4
 Slb19mHS9Iqj/6/kSsmViiJaldsMGw+7CJ7K98qKyeYQBbFh+kMq33DzN6zgZnYnqj1W57
 +vvQhhiu9Guw4Hgi1TiMqXBDrG3Wt0X2zNOAa+6HjvEqWTmfahoVGcAswpFsS56RYL0XDE
 ImFM7fdRqQdFzjSgCIRR8d5ByMQnjk84yvSXfaH3m0dvdaNL90GIJ5L6X3VSRgshhLoS99
 ZFjYtHuuU9w9wiVY9AxLSv8QudFIm4VpSC//NSNJ0jF790L3LaN0OqQuaQGLoCMes0ak7v
 YfX/xkKdQcuTRTDyRV/rEnEf5IIt/egHTjrPLlTxn5UsEektvpRzzeTUuhnQ
X-ME-Proxy: <xmx:zIV7aqsoBLBw341HP8YUpMiZm4snoprD_XigI1q9q2NGlVGaw-iMUw>
 <xmx:zIV7aiv7cKrJHnEixEnfgTDjrSpO9dt9K7IJmwtJwnDAGuW-S7WcEQ>
 <xmx:zIV7avMWMtLbSrlSQ3WwkEfM_VV4vKUBCgghnQCWmwFQqD4x1QjLYw>
 <xmx:zIV7ag2TV8ywh3yQn0c6My6vMIHCeKcWcO3vO4g5vKxpxAp5Bb0w3g>
 <xmx:zIV7aqJTKWCG5eJTpZFBMIn526nfpIAUE6odlm1MLJEgqvO2xLSnUAFT>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:27:56 -0400 (EDT)
Message-ID: <e1ad2bec59f3ad533e1225f4dd841c93665686f8.camel@alistair23.me>
Subject: Re: [PATCH 37/56] disas/riscv: Use rv_codec_illegal for pseudos
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:27:55 +1000
In-Reply-To: <20260809223545.730664-38-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.149;
 envelope-from=alistair@alistair23.me; helo=fout-a6-smtp.messagingengine.com
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
> The codec is never used, since we arrive into pseudos
> from a decoding of another opcode.
> Assert that rv_codec_illegal is never decoded.
> Use rv_codec_none for rv_op_illegal.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 68 +++++++++++++++++++++++++-----------------------=
-
> --
> =C2=A01 file changed, 34 insertions(+), 34 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 37f6440831..fc821355fe 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1599,7 +1599,7 @@ static uint32_t operand_lpl(rv_inst inst)
> =C2=A0/* instruction metadata */
> =C2=A0
> =C2=A0static const rv_opcode_data rvi_opcode_data[] =3D {
> -=C2=A0=C2=A0=C2=A0 { "illegal", rv_codec_illegal, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "illegal", rv_codec_none, rv_fmt_none },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "lui", rv_codec_u, rv_fmt_rd_uimm },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "auipc", rv_codec_u, rv_fmt_rd_uoffset },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "jal", rv_codec_uj, rv_fmt_rd_offset, rvcp_jal=
 },
> @@ -1872,38 +1872,38 @@ static const rv_opcode_data rvi_opcode_data[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.sq", rv_codec_cs_sq, NULL, DECOMP(rv_op_sq)=
 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op=
_lq) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_o=
p_sq) },
> -=C2=A0=C2=A0=C2=A0 { "nop", rv_codec_i, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "mv", rv_codec_i, rv_fmt_rd_rs1, rvcp_mv },
> -=C2=A0=C2=A0=C2=A0 { "not", rv_codec_i, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "neg", rv_codec_r, rv_fmt_rd_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "negw", rv_codec_r, rv_fmt_rd_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sext.w", rv_codec_i, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "seqz", rv_codec_i, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "snez", rv_codec_r, rv_fmt_rd_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sltz", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sgtz", rv_codec_r, rv_fmt_rd_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.s", rv_codec_r, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fabs.s", rv_codec_r, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fneg.s", rv_codec_r, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.d", rv_codec_r, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fabs.d", rv_codec_r, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fneg.d", rv_codec_r, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.q", rv_codec_r, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fabs.q", rv_codec_r, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fneg.q", rv_codec_r, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "beqz", rv_codec_sb, rv_fmt_rs1_offset },
> -=C2=A0=C2=A0=C2=A0 { "bnez", rv_codec_sb, rv_fmt_rs1_offset },
> -=C2=A0=C2=A0=C2=A0 { "blez", rv_codec_sb, rv_fmt_rs2_offset },
> -=C2=A0=C2=A0=C2=A0 { "bgez", rv_codec_sb, rv_fmt_rs1_offset },
> -=C2=A0=C2=A0=C2=A0 { "bltz", rv_codec_sb, rv_fmt_rs1_offset },
> -=C2=A0=C2=A0=C2=A0 { "bgtz", rv_codec_sb, rv_fmt_rs2_offset },
> -=C2=A0=C2=A0=C2=A0 { "jal", rv_codec_none, rv_fmt_offset }, /* rv_op_jal=
_ra */
> -=C2=A0=C2=A0=C2=A0 { "jalr", rv_codec_none, rv_fmt_rs1 }, /* rv_op_jalr_=
ra */
> +=C2=A0=C2=A0=C2=A0 { "nop", rv_codec_illegal, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "mv", rv_codec_illegal, rv_fmt_rd_rs1, rvcp_mv },
> +=C2=A0=C2=A0=C2=A0 { "not", rv_codec_illegal, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "neg", rv_codec_illegal, rv_fmt_rd_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "negw", rv_codec_illegal, rv_fmt_rd_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sext.w", rv_codec_illegal, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "seqz", rv_codec_illegal, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "snez", rv_codec_illegal, rv_fmt_rd_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "sltz", rv_codec_illegal, rv_fmt_rd_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "sgtz", rv_codec_illegal, rv_fmt_rd_rs2 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.s", rv_codec_illegal, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fabs.s", rv_codec_illegal, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fneg.s", rv_codec_illegal, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.d", rv_codec_illegal, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fabs.d", rv_codec_illegal, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fneg.d", rv_codec_illegal, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fmv.q", rv_codec_illegal, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fabs.q", rv_codec_illegal, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "fneg.q", rv_codec_illegal, rv_fmt_frd_frs1 },
> +=C2=A0=C2=A0=C2=A0 { "beqz", rv_codec_illegal, rv_fmt_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "bnez", rv_codec_illegal, rv_fmt_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "blez", rv_codec_illegal, rv_fmt_rs2_offset },
> +=C2=A0=C2=A0=C2=A0 { "bgez", rv_codec_illegal, rv_fmt_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "bltz", rv_codec_illegal, rv_fmt_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { "bgtz", rv_codec_illegal, rv_fmt_rs2_offset },
> +=C2=A0=C2=A0=C2=A0 { "jal", rv_codec_illegal, rv_fmt_offset }, /* rv_op_=
jal_ra */
> +=C2=A0=C2=A0=C2=A0 { "jalr", rv_codec_illegal, rv_fmt_rs1 }, /* rv_op_ja=
lr_ra */
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> -=C2=A0=C2=A0=C2=A0 { "j", rv_codec_uj, rv_fmt_offset },
> -=C2=A0=C2=A0=C2=A0 { "ret", rv_codec_i, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "jr", rv_codec_i, rv_fmt_rs1, rvcp_jr },
> +=C2=A0=C2=A0=C2=A0 { "j", rv_codec_illegal, rv_fmt_offset },
> +=C2=A0=C2=A0=C2=A0 { "ret", rv_codec_illegal, rv_fmt_none },
> +=C2=A0=C2=A0=C2=A0 { "jr", rv_codec_illegal, rv_fmt_rs1, rvcp_jr },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "rdcycle", rv_codec_i_csr, rv_fmt_rd },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "rdtime", rv_codec_i_csr, rv_fmt_rd },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "rdinstret", rv_codec_i_csr, rv_fmt_rd },
> @@ -4551,8 +4551,6 @@ static void decode_inst_operands(rv_decode
> *dec, rv_isa isa,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 switch (op->codec) {
> -=C2=A0=C2=A0=C2=A0 case rv_codec_illegal:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 case rv_codec_none:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->rd =3D dec->rs1 =3D=
 dec->rs2 =3D rv_ireg_zero;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->imm =3D 0;
> @@ -4946,7 +4944,9 @@ static void decode_inst_operands(rv_decode
> *dec, rv_isa isa,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->rs1 =3D dec->rs2 =
=3D operand_crs1(inst);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->imm =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0=C2=A0 };
> +=C2=A0=C2=A0=C2=A0 default:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_not_reached();
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> =C2=A0/* check constraint */

