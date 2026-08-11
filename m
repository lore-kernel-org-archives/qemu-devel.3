Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC03C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtt2Y-0004P6-6w; Tue, 11 Aug 2026 16:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt2S-0004LS-Tf; Tue, 11 Aug 2026 16:25:32 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt2Q-0004X4-IR; Tue, 11 Aug 2026 16:25:32 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id A0FF7EC009B;
 Tue, 11 Aug 2026 16:25:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 11 Aug 2026 16:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479929; x=1786566329; bh=9WYSQ+voOLjwIFjowZV4sPUwf4znersa
 qtlYGb4sqWs=; b=YhV4Q7DgeEyMetD4Us0e2Jaa/TS4Abh95L08Vs9V24PpgZnT
 JR/Zcel2Vz0Kx5SAdaMQlnlBMxMPy1K/DQD9xZ3nQD6RMw11M177ni+0rlzkc2KF
 CfbhJLcUIo7l4hYc4lQHPnVk2udN5xu5Dmeo8bjKzFfAaLHtbGHMPARV3hYS9/JB
 9oqr1+jSa6cGDhE9uI+dkt22kN4ZiGkR7na8cQQZfN0MnxQLjvsHHcG8Rl6P6Zjg
 R5eNDi01GCnkHTnOZMTdDdqC3K5UIoxqRFYfkmsnNDYw9Jc+Bu6QhPoKNQr2ECIk
 A5NNA5WbCUJUQjje15HwL4v/xVFvVAQ0UOF31g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479929; x=
 1786566329; bh=9WYSQ+voOLjwIFjowZV4sPUwf4znersaqtlYGb4sqWs=; b=b
 JH7KJFHcuOtHdJxoLKUvBZl9N7R8oWrcH2u78hi68ZQdg1n6izyjGxMDPWPU0D++
 DqN9ITaoqkAmJxjdLBsF4B4xv6BHfSDj5AeopvWm3euseDdZM5QPeRjQwE6Tu7xg
 0dnU5S1qE0PVqan05HRWEpjfHEfnmPBobnzIzu/Rj3fqZv9AQRMZ6UNlPs1w9Zto
 PcGf2KGmd/DW4c8cFq4ZIQZOd+5HYYxmwZ63NhynBHlKs2KMcUJe8B5pSmKuv8+m
 lElpk2/1R9+3Ybsj79WyvYVxtIJq87l3rscvGIh/MMUu1APZmfXc0139t5f1x7Gh
 wZRx2DBgqTbaFuti6owxg==
X-ME-Sender: <xms:OYV7au3qpZ4Wuv-dsGBySbc5KcgLdb7kBy0x1VJ98X3st7Ph_X-X0g>
 <xme:OYV7albgyVNghJQ2RATNIpdDu69XpCtq7SShmzbRrLeXyjox7BxDLNCK9dc2ya1TR
 7WUhSS5Y8RWzDdG5lP2Fz6IrzVquzUF4djTreQK91Ed0XpralFpmw>
X-ME-Received: <xmr:OYV7amB7XksiQxs_p0Ly5HQXPCvwRPPjULW9JvM6dHY6YevUJBKhzA4fgckSD8DOBBPK4A>
X-ME-Proxy-Cause: dmFkZTEe44bzU318ZKGPPkmI//vzCNdVcYTYrqRtyU+DALhpzqDIrDJwcBKSHZMm4wnCMf
 9PUVrK5o6AhiUSiuSHL+1pFOddNIyiumPnXWByRYWCiPKoMD7LpIxSXTPbQLcCCeUi2Ayl
 lZhv0amE+njS/NQ6fBOmBDx+m0qvsBnHoW/t9sg/Z1H8bHw4jmKj5CgcDmj+xNoBXMcCsB
 VunOEWHMKShnBk/h7Ljnrzisg4XMruYntxk0fJHDFNQ4GaUuSnP7WZIf61sh4YmvNs4ksS
 qLV4eLP9GUxwdWyxSb7FXaax/mli1hOteEtTMY4L052hQLPg6p0x5fRGFTYIR45pG4W+RF
 snQagp8TXofoA+PLGDo7IBhUK36cU4ZeI3A9wmEO0MSeAMJ7qPB4rwXKFAvfkzT5ijzbaN
 xijPUHVeiBVND74nFeBO99ZLB1TVMvj3TQKdLVPGK04442JZx3rk31dvbkcbMvzUcWSWpI
 ndu21ySb0KMRw+a8+Vlwhwu7iVvt1rGdWwPbhJ5TS7rLL+cgOnk9TtYzEwon542nO4qmje
 wXkzSKZoYMIcp/WOZIfkdpU0ojj0ZvxgBiHEbaJSZSGHqfi/5EzKXZU5HAE4QTZ7LzxBqs
 u1Ech0ftCPmdGXd/g0l9ZIaeJ+KhQZJ/iB1DwVmPDlZrwfqcC94vQuLpHuwQ
X-ME-Proxy: <xmx:OYV7an-_ZKinPr8Oy9HCMKeco7UeivZIFmHolfvjV-3sFA1zVNPr1g>
 <xmx:OYV7am-rgxYPAyASb__zp-nQ2X0ydLd-NC6gvIYCxxMXUPR7KP4hbg>
 <xmx:OYV7auc7NBdlOwIjAQuyJsHXxkuTkf5UkedKysI1tTV6NV3Mx4pHkg>
 <xmx:OYV7avGGZMTnW824Xtg1b4CEOeT0FIF9NMDtIIAx8zkzQKB5uohTZA>
 <xmx:OYV7arY3DDNS__py4y0XYF2kRDQUvAggagwv5BuP4NJ-tIbsZLlaJmhL>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:25:29 -0400 (EDT)
Message-ID: <7bec74dae9d51c1dfe936febaa0027668a745991.camel@alistair23.me>
Subject: Re: [PATCH 33/56] disas/riscv: Drop format from DECOMP insns
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:25:29 +1000
In-Reply-To: <20260809223545.730664-34-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-34-richard.henderson@linaro.org>
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
> The format for these will never be used -- we will use
> the format from the decompressed insn.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 94 +++++++++++++++++++++++++-----------------------=
-
> --
> =C2=A01 file changed, 47 insertions(+), 47 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 129e545c6e..9904b4db03 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1819,52 +1819,52 @@ static const rv_opcode_data rvi_opcode_data[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 }=
,
> =C2=A0=C2=A0=C2=A0=C2=A0 { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_addi) },
> -=C2=A0=C2=A0=C2=A0 { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1,
> DECOMP(rv_op_fld) },
> -=C2=A0=C2=A0=C2=A0 { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, DECOM=
P(rv_op_lw)
> },
> -=C2=A0=C2=A0=C2=A0 { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1,
> DECOMP(rv_op_flw) },
> -=C2=A0=C2=A0=C2=A0 { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1,
> DECOMP(rv_op_fsd) },
> -=C2=A0=C2=A0=C2=A0 { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sw) },
> -=C2=A0=C2=A0=C2=A0 { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1,
> DECOMP(rv_op_fsw) },
> +=C2=A0=C2=A0=C2=A0 { "c.addi4spn", rv_codec_ciw_4spn, NULL, DECOMP(rv_op=
_addi) },
> +=C2=A0=C2=A0=C2=A0 { "c.fld", rv_codec_cl_ld, NULL, DECOMP(rv_op_fld) },
> +=C2=A0=C2=A0=C2=A0 { "c.lw", rv_codec_cl_lw, NULL, DECOMP(rv_op_lw) },
> +=C2=A0=C2=A0=C2=A0 { "c.flw", rv_codec_cl_lw, NULL, DECOMP(rv_op_flw) },
> +=C2=A0=C2=A0=C2=A0 { "c.fsd", rv_codec_cs_sd, NULL, DECOMP(rv_op_fsd) },
> +=C2=A0=C2=A0=C2=A0 { "c.sw", rv_codec_cs_sw, NULL, DECOMP(rv_op_sw) },
> +=C2=A0=C2=A0=C2=A0 { "c.fsw", rv_codec_cs_sw, NULL, DECOMP(rv_op_fsw) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> -=C2=A0=C2=A0=C2=A0 { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, DECOMP(rv=
_op_addi)
> },
> -=C2=A0=C2=A0=C2=A0 { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, DECOMP(=
rv_op_jal)
> },
> -=C2=A0=C2=A0=C2=A0 { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, DECOMP(r=
v_op_addi)
> },
> -=C2=A0=C2=A0=C2=A0 { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_addi) },
> -=C2=A0=C2=A0=C2=A0 { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, DECOMP(rv=
_op_lui) },
> -=C2=A0=C2=A0=C2=A0 { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_srli) },
> -=C2=A0=C2=A0=C2=A0 { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_srai) },
> -=C2=A0=C2=A0=C2=A0 { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_andi) },
> -=C2=A0=C2=A0=C2=A0 { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_=
op_sub) },
> -=C2=A0=C2=A0=C2=A0 { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_=
op_xor) },
> -=C2=A0=C2=A0=C2=A0 { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_o=
p_or) },
> -=C2=A0=C2=A0=C2=A0 { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_=
op_and) },
> -=C2=A0=C2=A0=C2=A0 { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv=
_op_subw)
> },
> -=C2=A0=C2=A0=C2=A0 { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv=
_op_addw)
> },
> -=C2=A0=C2=A0=C2=A0 { "c.j", rv_codec_cj, rv_fmt_rd_offset, DECOMP(rv_op_=
jal) },
> -=C2=A0=C2=A0=C2=A0 { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset,
> DECOMP(rv_op_beq) },
> -=C2=A0=C2=A0=C2=A0 { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset,
> DECOMP(rv_op_bne) },
> -=C2=A0=C2=A0=C2=A0 { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm,
> DECOMP(rv_op_slli) },
> -=C2=A0=C2=A0=C2=A0 { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1,
> DECOMP(rv_op_fld) },
> -=C2=A0=C2=A0=C2=A0 { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1,
> DECOMP(rv_op_lw) },
> -=C2=A0=C2=A0=C2=A0 { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1,
> DECOMP(rv_op_flw) },
> -=C2=A0=C2=A0=C2=A0 { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset,
> DECOMP(rv_op_jalr) },
> -=C2=A0=C2=A0=C2=A0 { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, DECOMP(r=
v_op_addi)
> },
> -=C2=A0=C2=A0=C2=A0 { "c.ebreak", rv_codec_ci_none, rv_fmt_none,
> DECOMP(rv_op_ebreak) },
> -=C2=A0=C2=A0=C2=A0 { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset,
> DECOMP(rv_op_jalr) },
> -=C2=A0=C2=A0=C2=A0 { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, DECOMP(rv_=
op_add) },
> -=C2=A0=C2=A0=C2=A0 { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs=
1,
> DECOMP(rv_op_fsd) },
> -=C2=A0=C2=A0=C2=A0 { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sw) },
> -=C2=A0=C2=A0=C2=A0 { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs=
1,
> DECOMP(rv_op_fsw) },
> -=C2=A0=C2=A0=C2=A0 { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, DECOM=
P(rv_op_ld)
> },
> -=C2=A0=C2=A0=C2=A0 { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sd) },
> -=C2=A0=C2=A0=C2=A0 { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, DECOMP(r=
v_op_addiw)
> },
> -=C2=A0=C2=A0=C2=A0 { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1,
> DECOMP(rv_op_ld) },
> -=C2=A0=C2=A0=C2=A0 { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sd) },
> -=C2=A0=C2=A0=C2=A0 { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, DECOM=
P(rv_op_lq)
> },
> -=C2=A0=C2=A0=C2=A0 { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sq) },
> -=C2=A0=C2=A0=C2=A0 { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1,
> DECOMP(rv_op_lq) },
> -=C2=A0=C2=A0=C2=A0 { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1,
> DECOMP(rv_op_sq) },
> +=C2=A0=C2=A0=C2=A0 { "c.addi", rv_codec_ci, NULL, DECOMP(rv_op_addi) },
> +=C2=A0=C2=A0=C2=A0 { "c.jal", rv_codec_cj_jal, NULL, DECOMP(rv_op_jal) }=
,
> +=C2=A0=C2=A0=C2=A0 { "c.li", rv_codec_ci_li, NULL, DECOMP(rv_op_addi) },
> +=C2=A0=C2=A0=C2=A0 { "c.addi16sp", rv_codec_ci_16sp, NULL, DECOMP(rv_op_=
addi) },
> +=C2=A0=C2=A0=C2=A0 { "c.lui", rv_codec_ci_lui, NULL, DECOMP(rv_op_lui) }=
,
> +=C2=A0=C2=A0=C2=A0 { "c.srli", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srli)=
 },
> +=C2=A0=C2=A0=C2=A0 { "c.srai", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srai)=
 },
> +=C2=A0=C2=A0=C2=A0 { "c.andi", rv_codec_cb_imm, NULL, DECOMP(rv_op_andi)=
 },
> +=C2=A0=C2=A0=C2=A0 { "c.sub", rv_codec_cs, NULL, DECOMP(rv_op_sub) },
> +=C2=A0=C2=A0=C2=A0 { "c.xor", rv_codec_cs, NULL, DECOMP(rv_op_xor) },
> +=C2=A0=C2=A0=C2=A0 { "c.or", rv_codec_cs, NULL, DECOMP(rv_op_or) },
> +=C2=A0=C2=A0=C2=A0 { "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and) },
> +=C2=A0=C2=A0=C2=A0 { "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw) },
> +=C2=A0=C2=A0=C2=A0 { "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw) },
> +=C2=A0=C2=A0=C2=A0 { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_jal) },
> +=C2=A0=C2=A0=C2=A0 { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beq) },
> +=C2=A0=C2=A0=C2=A0 { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bne) },
> +=C2=A0=C2=A0=C2=A0 { "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_slli)=
 },
> +=C2=A0=C2=A0=C2=A0 { "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_fld=
) },
> +=C2=A0=C2=A0=C2=A0 { "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_lw) =
},
> +=C2=A0=C2=A0=C2=A0 { "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_flw=
) },
> +=C2=A0=C2=A0=C2=A0 { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jalr) },
> +=C2=A0=C2=A0=C2=A0 { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_addi) },
> +=C2=A0=C2=A0=C2=A0 { "c.ebreak", rv_codec_ci_none, NULL, DECOMP(rv_op_eb=
reak) },
> +=C2=A0=C2=A0=C2=A0 { "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op_jalr=
) },
> +=C2=A0=C2=A0=C2=A0 { "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add) },
> +=C2=A0=C2=A0=C2=A0 { "c.fsdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_fs=
d) },
> +=C2=A0=C2=A0=C2=A0 { "c.swsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_sw)=
 },
> +=C2=A0=C2=A0=C2=A0 { "c.fswsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_fs=
w) },
> +=C2=A0=C2=A0=C2=A0 { "c.ld", rv_codec_cl_ld, NULL, DECOMP(rv_op_ld) },
> +=C2=A0=C2=A0=C2=A0 { "c.sd", rv_codec_cs_sd, NULL, DECOMP(rv_op_sd) },
> +=C2=A0=C2=A0=C2=A0 { "c.addiw", rv_codec_ci, NULL, DECOMP(rv_op_addiw) }=
,
> +=C2=A0=C2=A0=C2=A0 { "c.ldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_ld) =
},
> +=C2=A0=C2=A0=C2=A0 { "c.sdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_sd)=
 },
> +=C2=A0=C2=A0=C2=A0 { "c.lq", rv_codec_cl_lq, NULL, DECOMP(rv_op_lq) },
> +=C2=A0=C2=A0=C2=A0 { "c.sq", rv_codec_cs_sq, NULL, DECOMP(rv_op_sq) },
> +=C2=A0=C2=A0=C2=A0 { "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq) =
},
> +=C2=A0=C2=A0=C2=A0 { "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq)=
 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "nop", rv_codec_i, rv_fmt_none },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "mv", rv_codec_i, rv_fmt_rd_rs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "not", rv_codec_i, rv_fmt_rd_rs1 },
> @@ -2546,8 +2546,8 @@ static const rv_opcode_data rvi_opcode_data[] =3D
> {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "ssrdp", rv_codec_r, rv_fmt_rd },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs=
2_rs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs=
2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, DECOMP(rv=
_op_sspush)
> },
> -=C2=A0=C2=A0=C2=A0 { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1,
> DECOMP(rv_op_sspopchk) },
> +=C2=A0=C2=A0=C2=A0 { "c.sspush", rv_codec_cmop_ss, NULL, DECOMP(rv_op_ss=
push) },
> +=C2=A0=C2=A0=C2=A0 { "c.sspopchk", rv_codec_cmop_ss, NULL, DECOMP(rv_op_=
sspopchk)
> },
> =C2=A0=C2=A0=C2=A0 { "cbo.inval", rv_codec_r, rv_fmt_rs1 },
> =C2=A0=C2=A0=C2=A0 { "cbo.clean", rv_codec_r, rv_fmt_rs1 },
> =C2=A0=C2=A0=C2=A0 { "cbo.flush", rv_codec_r, rv_fmt_rs1 },

