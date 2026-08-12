Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C8DC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8MY-0005bZ-L3; Wed, 12 Aug 2026 08:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8MW-0005at-W0; Wed, 12 Aug 2026 08:47:17 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8MU-0008HB-K8; Wed, 12 Aug 2026 08:47:16 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 085ED14000C2;
 Wed, 12 Aug 2026 08:47:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 12 Aug 2026 08:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786538833; x=1786625233; bh=WS3GH/WlpppxTgb+PnyLr2dWD+WM6284
 IzR9frNEhF0=; b=LM2teBBViLRa+RP58mtAaE+UfMc2vspWscJ1vZE+t7FDptk8
 7fbRXedNd7i1qtAh//aXIIAJode6oI4evCF8EhdoPGsWqolnFfNfglOHmN9jH19y
 ILT2O28sWhFQWgMz37mdGXuCvnj41BSzKzaKZeF1qGy7Ca0U7e+VKAKAMhJTZ8p4
 PbvFv+mhC0gUchVVOF1MBs+/+/i/RbYOPp4iKFwyyEg3WR6dt21GhChoE98xAHMb
 i2Pr2a7kLMhagn7kYZ9C1xQFowcSyOXu6zzCFX+Zv1fblvclkv9GDL514J/wT4Gn
 J8Wi2JDu89Sn0ESCSJkEWpU3GGZaBTebSEfBBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786538833; x=
 1786625233; bh=WS3GH/WlpppxTgb+PnyLr2dWD+WM6284IzR9frNEhF0=; b=j
 QKF7ApIvaf8FXyJEdtwkF45p/qy5IbBEh27slNSAe2K5+SnB6RSXme8V+5e5+ox1
 pzeKJuw4u+wvbEVOFCheNfRcj6/ygtl+BM4o/DksuPzftSPQt9jldGwYm9mOA9Gt
 olCKmXK35O86lJoE6EgXmv53a7HWi0LF2Lfcqh2BWGNTx4DVcWewC219S4rLeOMl
 ytT/EqTaqfAzMaeiDquX5ejOZ8LeGcQT6qVbrSsQbMnmKhfEhcCXX0/Yk3RpFEYL
 TQOnbdWz4n9T166855z+E4L5zQyB9wzkt3L3I2RbrFV/xl84tixrifME8Xik92fe
 xW7M4s6xZ3F1G3DprdjvA==
X-ME-Sender: <xms:UGt8aiUeAiZULfqe54LRYe-D3R8at59TkZ2Iv7lCxlDq48nLwSLGGw>
 <xme:UGt8ai7_r5Nyn-6VeUfzn6JqpEouUtjx8-FqWRVUc5V2vRldXvPWhY056k8aKl_2M
 5o1E6idp1cyiE07wH6y3teQi0WNtEcD54l2Wvfswfj6_fcqTwx18Q>
X-ME-Received: <xmr:UGt8alitL_-uemFoCO8VrAKIhiHiomw-uzZ6PGeNRLSgfHYeDEEoltZOoc2-GP0siYc2PA>
X-ME-Proxy-Cause: dmFkZTEKNC1XWpXKgbcrIIcGvGvMtroCzhMnCfh6zfBsURB7R7VX9EPMY4jYzbojoVl0Xo
 mYAsnG4H4rw7nE30ideLJWEcti7Uj38kwimPMGRddBl+zFI9orYZ+Jg0eSl5eRokNk8y76
 oV0b4HeZv+uJgkv4FsiMyviXxJKQvnLcwek/iCuOVwTLw8PHDJ5P5wxUoVmpYfCZa68GLJ
 syUHElSZpk8x2ht7eC6njuvPyrkzuI8xixrZV22EGkK6qXszU71IRIy9OqxE91MUA7lxcI
 M6hiTgPiQmDwc4QiHsE9NzzpNYPgI9vsiSr7XPxQQtkoftyUR1XQlxqcRNeLcYJLQIg0R6
 OCxvjI3asbGAHsrnIQQ1W+6NbMsw+9C0N6+TSjOsk2BEwouqswapkoB9/YeyH8SVziy5GS
 xXaF7SoaLlTZn3gRHS6HBoyiUoB+VxlL2Uf2ytzSnujxwu6CntMzd7iyP5OfClO+ilxPGc
 5+ctiZNpdJmyX/f06n1TKzhV+l0Fpx2WMmCrgaDbVACq7qpkYoxTYZe5eLozzjBtbk7MjF
 0wJUXVlazaM7Jf6HkIxlv0GNF8J/XDvXTvbp/Rh+f+O0bjhdbw664ltLhBRYlWpfn9gPxs
 BjcFY2lDHo5MYgGTdTlvPpzed8QhAQjvDzOoo2poe0oEsrKTALGYdO3pCnrQ
X-ME-Proxy: <xmx:UGt8ahfW-0vgnTfthIouns08iqe7fjX2eYms9OMlWMrsoPe0lq7aig>
 <xmx:UGt8aifaRCCzlHUXjfGQ-Qn_qVIfPtaWVDUOtue4uORXJhf4WLLAXA>
 <xmx:UGt8aj9wDnCvp7Tm2_Ys_3A8QEyyO5Ol6M1ANMUbQl3vMFNtNGNb4A>
 <xmx:UGt8amngczWIzTm0ZCKW4zIvFGzEqs_qKLquMMOmG1pgAhAleI5VNw>
 <xmx:UWt8as73mAByuPvXNRuc2RlQeGIPc1DoIPt42qpBwrl1CKcHF46fo5TO>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:47:12 -0400 (EDT)
Message-ID: <12959a5aca4118263c0e494317c7057a750fbfc1.camel@alistair23.me>
Subject: Re: [PATCH 39/56] disas/riscv: Store op pointer in rv_comp_data
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 22:47:12 +1000
In-Reply-To: <20260809223545.730664-40-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=alistair@alistair23.me; helo=fhigh-a3-smtp.messagingengine.com
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
> Store a pointer instead of an array index.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.h |=C2=A0 8 +++---
> =C2=A0disas/riscv.c | 69 ++++++++++++++++++++++++++----------------------=
-
> --
> =C2=A02 files changed, 40 insertions(+), 37 deletions(-)
>=20
> diff --git a/disas/riscv.h b/disas/riscv.h
> index ea7141d3b5..ab62c0db94 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -164,17 +164,19 @@ typedef enum {
> =C2=A0
> =C2=A0/* structures */
> =C2=A0
> +typedef struct rv_opcode_data rv_opcode_data;
> +
> =C2=A0typedef struct {
> -=C2=A0=C2=A0=C2=A0 int op;
> +=C2=A0=C2=A0=C2=A0 const rv_opcode_data *op;
> =C2=A0=C2=A0=C2=A0=C2=A0 const rvc_constraint *constraints;
> =C2=A0} rv_comp_data;
> =C2=A0
> -typedef struct {
> +struct rv_opcode_data {
> =C2=A0=C2=A0=C2=A0=C2=A0 const char *name;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_codec codec;
> =C2=A0=C2=A0=C2=A0=C2=A0 const char *format;
> =C2=A0=C2=A0=C2=A0=C2=A0 const rv_comp_data *pseudo;
> -} rv_opcode_data;
> +};
> =C2=A0
> =C2=A0typedef struct {
> =C2=A0=C2=A0=C2=A0=C2=A0 const RISCVCPUConfig *cfg;
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 9a528803e8..171c60238f 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1068,138 +1068,140 @@ static const rvc_constraint rvcc_true[] =3D {
> rvc_end };
> =C2=A0
> =C2=A0/* pseudo-instruction metadata */
> =C2=A0
> +static const rv_opcode_data rvi_opcode_data[];
> +
> =C2=A0static const rv_comp_data rvcp_jal[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_j, rvcc_j },
> -=C2=A0=C2=A0=C2=A0 { rv_op_jal_ra, rvcc_jal_ra },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_j], rvcc_j },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_jal_ra], rvcc_jal_ra },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_jalr[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_jr, rvcc_jr },
> -=C2=A0=C2=A0=C2=A0 { rv_op_jalr_ra, rvcc_jalr_ra },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_jr], rvcc_jr },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_jalr_ra], rvcc_jalr_ra },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_jr[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_ret, rvcc_ret },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_ret], rvcc_ret },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_beq[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_beqz, rvcc_beqz },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_beqz], rvcc_beqz },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_bne[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_bnez, rvcc_bnez },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_bnez], rvcc_bnez },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_blt[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_bltz, rvcc_bltz },
> -=C2=A0=C2=A0=C2=A0 { rv_op_bgtz, rvcc_bgtz },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_bltz], rvcc_bltz },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_bgtz], rvcc_bgtz },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_bge[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_blez, rvcc_blez },
> -=C2=A0=C2=A0=C2=A0 { rv_op_bgez, rvcc_bgez },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_blez], rvcc_blez },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_bgez], rvcc_bgez },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_addi[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_mv, rvcc_mv },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_mv], rvcc_mv },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_mv[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_nop, rvcc_nop },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_nop], rvcc_nop },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_sltiu[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_seqz, rvcc_seqz },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_seqz], rvcc_seqz },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_xori[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_not, rvcc_not },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_not], rvcc_not },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_sub[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_neg, rvcc_neg },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_neg], rvcc_neg },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_slt[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_sltz, rvcc_sltz },
> -=C2=A0=C2=A0=C2=A0 { rv_op_sgtz, rvcc_sgtz },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_sltz], rvcc_sltz },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_sgtz], rvcc_sgtz },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_sltu[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_snez, rvcc_snez },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_snez], rvcc_snez },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_addiw[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_sext_w, rvcc_sext_w },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_sext_w], rvcc_sext_w },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_subw[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_negw, rvcc_negw },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_negw], rvcc_negw },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnj_s[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_fmv_s, rvcc_fmv_s },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_fmv_s], rvcc_fmv_s },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjn_s[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_fneg_s, rvcc_fneg_s },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_fneg_s], rvcc_fneg_s },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjx_s[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_fabs_s, rvcc_fabs_s },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_fabs_s], rvcc_fabs_s },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnj_d[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_fmv_d, rvcc_fmv_d },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_fmv_d], rvcc_fmv_d },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjn_d[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_fneg_d, rvcc_fneg_d },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_fneg_d], rvcc_fneg_d },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjx_d[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_fabs_d, rvcc_fabs_d },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_fabs_d], rvcc_fabs_d },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnj_q[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_fmv_q, rvcc_fmv_q },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_fmv_q], rvcc_fmv_q },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjn_q[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_fneg_q, rvcc_fneg_q },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_fneg_q], rvcc_fneg_q },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_fsgnjx_q[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_fabs_q, rvcc_fabs_q },
> +=C2=A0=C2=A0=C2=A0 { &rvi_opcode_data[rv_op_fabs_q], rvcc_fabs_q },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> =C2=A0/* Convert compressed insns into normal insns via pseudo expansion.
> */
> -#define DECOMP(X) (static const rv_comp_data[1]){ { X, rvcc_true } }
> +#define DECOMP(X) (static const rv_comp_data[1]){ {
> &rvi_opcode_data[X], rvcc_true } }
> =C2=A0
> =C2=A0/* operand extractors */
> =C2=A0
> @@ -5270,9 +5272,8 @@ static const rv_opcode_data
> *decode_inst_lift_pseudo(rv_decode *dec,
> =C2=A0=C2=A0=C2=A0=C2=A0 if (comp_data) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (comp_data->constr=
aints) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (check_constraints(dec, comp_data->constraints)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 const rv_opcode_data *new_op =3D &dec-
> >opcode_data[comp_data->op];
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 assert(new_op !=3D op);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return decode_inst_lift_pseudo(dec, new_op);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 assert(op !=3D comp_data->op);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return decode_inst_lift_pseudo(dec, comp_data->op);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
comp_data++;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

