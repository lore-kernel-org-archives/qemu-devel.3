Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BCEC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsw3-0008TW-GO; Tue, 11 Aug 2026 16:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsw1-0008T0-Iz; Tue, 11 Aug 2026 16:18:53 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsvz-0003o3-CD; Tue, 11 Aug 2026 16:18:53 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id A2D60EC01DC;
 Tue, 11 Aug 2026 16:18:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 11 Aug 2026 16:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479530; x=1786565930; bh=I5UEeajUvuMXNUAtCiXSlxzcv/psAVwA
 /fwmzSptaJw=; b=udsOs0Id4eui4sO3nJ/oIlMYgrwOASWdgXqChJF8RSC+tAY3
 OJF6imwmOOseE2AzHVlPdYbfVgyALqLxgru+sD9oi/kXU7VV1JkaDcNmocJ7Mb21
 AbH3xrETD0KML7X1Wv6aQZbhYBqUyUmCLuHa3UYidTRjguRyw9vJa9MmuoWodxFC
 T3WA/LFdJ4LbM2ZARlBzih/w90ILdCia+ELodqYo2JsIlE8FDQBFsgq+wkXemlLm
 ay8Xdbp6oqBsFSSp43LZ6sE9Y1O+iQ72ouB7PBygpfpqobtg72gymVW0kz7huTb4
 eMbNrj9u9m7/QB4pggaWV/mUmHGqCxyvwJ8EkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479530; x=
 1786565930; bh=I5UEeajUvuMXNUAtCiXSlxzcv/psAVwA/fwmzSptaJw=; b=B
 e7hoVWdIOWMwhOi4poTkSDtYb18Y7ET4EBE9lgQQnnqnwy72O9mQLZMgCWbd0WUv
 kx7hlb5n1mujML5g3j+8Mx9eOD2Q7riY5T8hBdMOq57r94Fq2Z4Aak+/uR+Z/CHy
 kYvosWpCBa2DkbS533GouIwAicfRRN2weB8bQzglkD95nZabD5BsmWq6pCTso+7K
 7Q098bwHW8u90IlQE6xYTPQBdGLjJZbB56Yi93Mj7bbYk0EecDJTZLZL+FEfve5r
 Luc82/6JwMHCJcxd23FxYPKTTAG5SKVZYcratU/AmXwj801w/MBaRIMoMQjze9R2
 jSVJxK6CDQzGEc8Ntnmlg==
X-ME-Sender: <xms:qoN7aqhoE6zU1mvcuV-nh8dM42pibE0gqQzz3akKhxEAG8k6DJDJLA>
 <xme:qoN7avVqwnwYnAWf6a_HFIFyS4wbzQyJjpRnqyoHCSWylf0_htaBEtRLnAs1vzL3E
 ai_fvlZMnRyAboGMhN48DK1rdlh9lAc6O02exXfN5fEajKgicoPZg>
X-ME-Received: <xmr:qoN7ahNbULa9x6i-m85gzTzwdaXzHvdfMO_6kJ-QmZ1cJ0F60VK0jN9DfvPUJZpHOV6APQ>
X-ME-Proxy-Cause: dmFkZTEU6TKLlbeakMvmnbZfC6/1BDHfd10ALQ/aZgi3R3rhwrhMrwPUmgs9P2s1wa1z7g
 eEs/upfz85BE/ow17MBNADGxyFol6iBEncC62pPCXd0HRmJ+/4LWMP7Ewq/ySferhfQ8/Y
 ttPgOR8yjPLMcHdKdQhSwYUsOUR9Ckc+O0mGn5zcFS/FTMBkeIa6Vtf0vRZcjWQz/qARxO
 UySdpOyGFs70R3fgTf1KDH0RECJQ2G0rv5/PvDgqx3oxxf0Za9ivi3y+HS9FnS/ADFIa7O
 PP8Aa+ZWOOBv6H2FIuN4ppy6VZoZ1D3B5YUzJHdF6X9fI4XmlkHsa5tDifRRMMM5OtOzfO
 1CbnLutY41VR7Rj4UEHbIRU1A1w8t+OrncbN0itXVPYxVS7x3CU85qIZ8BNC6V3MMSrS9C
 nr3p/svFIrS9PVmbVjbR0Ri5HGVpiYf2ef+Zk9xYjPuZm6kcsjzg7v560YqB6d944c+KhS
 0Q4W8njSu6oUgHIss79sC69bP4/IVFXx7mi9iReVUd4h0a4mbazeTx3nOVmTTgovbqCuh1
 ePBbVZLoN3uMOzGNIHHJttAfvKktvrdOw7Yux8h8QZKdR9HkHJFSqCvzMVsuRZlgwDyxbC
 LkP45rHuY+AaC4icn1Gh+iXlDSMm3FfApmnXQ4dUamNI0xMAbZ7EngUgzl9Q
X-ME-Proxy: <xmx:qoN7arbQX_OiN7t0iPDAQTF4pfgs4wsuLlZtkxusTKS3tjoZYqc6Pw>
 <xmx:qoN7atpplSXNxTyR-Oa2RZpoXWuSf2BRG11UmQ2aAiaRo_m-VRvtUQ>
 <xmx:qoN7anZxescqxGrsvIfaFEbtNpGbHRceKdT2IioOHFGJx-nZ4YTxwA>
 <xmx:qoN7atTOO0iMAshB9kzpivpwPAiCMV1duaj5uc2ZiA-opT6Z3Wm-Sg>
 <xmx:qoN7al1E2-DoekZmdP_tEGSBjl-kfc2JjUzUpcds_C_BNJYcz70FDuIP>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:18:50 -0400 (EDT)
Message-ID: <abaeb45abe24e9e59e8a0ce0eb3445cb31db4637.camel@alistair23.me>
Subject: Re: [PATCH 25/56] disas/riscv: Unify decomp_rv{32,64,128}
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:18:50 +1000
In-Reply-To: <20260809223545.730664-26-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-26-richard.henderson@linaro.org>
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
> We now distinguish compressed opcodes by isa during decode.
> Therefore we don't need 3 copies of decomp_*.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.h |=C2=A0=C2=A0 4 +-
> =C2=A0disas/riscv.c | 155 ++++++++++++++++-------------------------------=
-
> --
> =C2=A02 files changed, 51 insertions(+), 108 deletions(-)
>=20
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 3909d73dd0..900363c603 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -183,9 +183,7 @@ typedef struct {
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_codec codec;
> =C2=A0=C2=A0=C2=A0=C2=A0 const char *format;
> =C2=A0=C2=A0=C2=A0=C2=A0 const rv_comp_data *pseudo;
> -=C2=A0=C2=A0=C2=A0 short decomp_rv32;
> -=C2=A0=C2=A0=C2=A0 short decomp_rv64;
> -=C2=A0=C2=A0=C2=A0 short decomp_rv128;
> +=C2=A0=C2=A0=C2=A0 rv_opcode decomp;
> =C2=A0} rv_opcode_data;
> =C2=A0
> =C2=A0typedef struct {
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 95957506bd..2e891f509e 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1883,91 +1883,52 @@ static const rv_opcode_data rvi_opcode_data[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 }=
,
> =C2=A0=C2=A0=C2=A0=C2=A0 { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm,=
 NULL,
> rv_op_addi,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addi, rv_op_addi },
> -=C2=A0=C2=A0=C2=A0 { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NUL=
L,
> rv_op_fld,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_fld, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL,=
 rv_op_lw,
> rv_op_lw,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_lw },
> -=C2=A0=C2=A0=C2=A0 { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, NUL=
L,
> rv_op_flw, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, NU=
LL,
> rv_op_fsd,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_fsd, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL=
, rv_op_sw,
> rv_op_sw,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sw },
> -=C2=A0=C2=A0=C2=A0 { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NU=
LL,
> rv_op_fsw, 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm,=
 NULL,
> rv_op_addi },
> +=C2=A0=C2=A0=C2=A0 { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NUL=
L,
> rv_op_fld },
> +=C2=A0=C2=A0=C2=A0 { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL,=
 rv_op_lw
> },
> +=C2=A0=C2=A0=C2=A0 { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, NUL=
L,
> rv_op_flw },
> +=C2=A0=C2=A0=C2=A0 { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, NU=
LL,
> rv_op_fsd },
> +=C2=A0=C2=A0=C2=A0 { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL=
, rv_op_sw
> },
> +=C2=A0=C2=A0=C2=A0 { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NU=
LL,
> rv_op_fsw },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> -=C2=A0=C2=A0=C2=A0 { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_=
op_addi,
> rv_op_addi,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addi },
> -=C2=A0=C2=A0=C2=A0 { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, r=
v_op_jal,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv=
_op_addi,
> rv_op_addi,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addi },
> -=C2=A0=C2=A0=C2=A0 { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, =
NULL,
> rv_op_addi,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addi, rv_op_addi },
> -=C2=A0=C2=A0=C2=A0 { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_=
op_lui,
> rv_op_lui,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_lui },
> -=C2=A0=C2=A0=C2=A0 { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL,
> rv_op_srli,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_srli, rv_op_srli },
> -=C2=A0=C2=A0=C2=A0 { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL,
> rv_op_srai,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_srai, rv_op_srai },
> -=C2=A0=C2=A0=C2=A0 { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL,
> rv_op_andi,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_andi, rv_op_andi },
> -=C2=A0=C2=A0=C2=A0 { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_sub,
> rv_op_sub,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sub },
> -=C2=A0=C2=A0=C2=A0 { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_xor,
> rv_op_xor,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_xor },
> -=C2=A0=C2=A0=C2=A0 { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op=
_or,
> rv_op_or,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_or },
> -=C2=A0=C2=A0=C2=A0 { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_and,
> rv_op_and,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_and },
> -=C2=A0=C2=A0=C2=A0 { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_=
op_subw,
> rv_op_subw,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_subw },
> -=C2=A0=C2=A0=C2=A0 { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_=
op_addw,
> rv_op_addw,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addw },
> -=C2=A0=C2=A0=C2=A0 { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_j=
al,
> rv_op_jal,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_jal },
> -=C2=A0=C2=A0=C2=A0 { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL,=
 rv_op_beq,
> rv_op_beq,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_beq },
> -=C2=A0=C2=A0=C2=A0 { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL,=
 rv_op_bne,
> rv_op_bne,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_bne },
> -=C2=A0=C2=A0=C2=A0 { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL,
> rv_op_slli,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_slli, rv_op_slli },
> -=C2=A0=C2=A0=C2=A0 { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1,=
 NULL,
> rv_op_fld,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_fld, rv_op_fld },
> -=C2=A0=C2=A0=C2=A0 { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, N=
ULL,
> rv_op_lw,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_lw, rv_op_lw },
> -=C2=A0=C2=A0=C2=A0 { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1,=
 NULL,
> rv_op_flw, 0,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, NULL,
> rv_op_jalr,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_jalr, rv_op_jalr },
> -=C2=A0=C2=A0=C2=A0 { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, NULL, rv=
_op_addi,
> rv_op_addi,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addi },
> -=C2=A0=C2=A0=C2=A0 { "c.ebreak", rv_codec_ci_none, rv_fmt_none, NULL, rv=
_op_ebreak,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_ebreak, rv_op_ebreak },
> -=C2=A0=C2=A0=C2=A0 { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, N=
ULL,
> rv_op_jalr,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_jalr, rv_op_jalr },
> -=C2=A0=C2=A0=C2=A0 { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_add,
> rv_op_add,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_add },
> -=C2=A0=C2=A0=C2=A0 { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs=
1, NULL,
> rv_op_fsd,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_fsd, rv_op_fsd },
> -=C2=A0=C2=A0=C2=A0 { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1,=
 NULL,
> rv_op_sw,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sw, rv_op_sw },
> -=C2=A0=C2=A0=C2=A0 { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs=
1, NULL,
> rv_op_fsw, 0,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, NULL,=
 0,
> rv_op_ld,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_ld },
> -=C2=A0=C2=A0=C2=A0 { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, NULL=
, 0,
> rv_op_sd,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sd },
> -=C2=A0=C2=A0=C2=A0 { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, 0,
> rv_op_addiw,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_addiw },
> -=C2=A0=C2=A0=C2=A0 { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, N=
ULL, 0,
> rv_op_ld,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_ld },
> -=C2=A0=C2=A0=C2=A0 { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1,=
 NULL, 0,
> rv_op_sd,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sd },
> -=C2=A0=C2=A0=C2=A0 { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, NULL,=
 0, 0,
> rv_op_lq },
> -=C2=A0=C2=A0=C2=A0 { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1, NULL=
, 0, 0,
> rv_op_sq },
> -=C2=A0=C2=A0=C2=A0 { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1, N=
ULL, 0, 0,
> rv_op_lq },
> -=C2=A0=C2=A0=C2=A0 { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1,=
 NULL, 0,
> 0,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sq },
> +=C2=A0=C2=A0=C2=A0 { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_=
op_addi },
> +=C2=A0=C2=A0=C2=A0 { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, r=
v_op_jal },
> +=C2=A0=C2=A0=C2=A0 { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv=
_op_addi },
> +=C2=A0=C2=A0=C2=A0 { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, =
NULL,
> rv_op_addi },
> +=C2=A0=C2=A0=C2=A0 { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_=
op_lui },
> +=C2=A0=C2=A0=C2=A0 { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL,=
 rv_op_srli
> },
> +=C2=A0=C2=A0=C2=A0 { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL,=
 rv_op_srai
> },
> +=C2=A0=C2=A0=C2=A0 { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL,=
 rv_op_andi
> },
> +=C2=A0=C2=A0=C2=A0 { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_sub },
> +=C2=A0=C2=A0=C2=A0 { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_xor },
> +=C2=A0=C2=A0=C2=A0 { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op=
_or },
> +=C2=A0=C2=A0=C2=A0 { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_and },
> +=C2=A0=C2=A0=C2=A0 { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_=
op_subw },
> +=C2=A0=C2=A0=C2=A0 { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_=
op_addw },
> +=C2=A0=C2=A0=C2=A0 { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_j=
al },
> +=C2=A0=C2=A0=C2=A0 { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL,=
 rv_op_beq
> },
> +=C2=A0=C2=A0=C2=A0 { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL,=
 rv_op_bne
> },
> +=C2=A0=C2=A0=C2=A0 { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL,=
 rv_op_slli
> },
> +=C2=A0=C2=A0=C2=A0 { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1,=
 NULL,
> rv_op_fld },
> +=C2=A0=C2=A0=C2=A0 { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, N=
ULL,
> rv_op_lw },
> +=C2=A0=C2=A0=C2=A0 { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1,=
 NULL,
> rv_op_flw },
> +=C2=A0=C2=A0=C2=A0 { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, NULL,=
 rv_op_jalr
> },
> +=C2=A0=C2=A0=C2=A0 { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, NULL, rv=
_op_addi },
> +=C2=A0=C2=A0=C2=A0 { "c.ebreak", rv_codec_ci_none, rv_fmt_none, NULL, rv=
_op_ebreak
> },
> +=C2=A0=C2=A0=C2=A0 { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, N=
ULL,
> rv_op_jalr },
> +=C2=A0=C2=A0=C2=A0 { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, NULL, rv_o=
p_add },
> +=C2=A0=C2=A0=C2=A0 { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs=
1, NULL,
> rv_op_fsd },
> +=C2=A0=C2=A0=C2=A0 { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1,=
 NULL,
> rv_op_sw },
> +=C2=A0=C2=A0=C2=A0 { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs=
1, NULL,
> rv_op_fsw },
> +=C2=A0=C2=A0=C2=A0 { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, NULL,=
 rv_op_ld
> },
> +=C2=A0=C2=A0=C2=A0 { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, NULL=
,=C2=A0 rv_op_sd
> },
> +=C2=A0=C2=A0=C2=A0 { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv=
_op_addiw
> },
> +=C2=A0=C2=A0=C2=A0 { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, N=
ULL,
> rv_op_ld },
> +=C2=A0=C2=A0=C2=A0 { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1,=
 NULL,
> rv_op_sd },
> +=C2=A0=C2=A0=C2=A0 { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, NULL,=
 rv_op_lq
> },
> +=C2=A0=C2=A0=C2=A0 { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1, NULL=
, rv_op_sq
> },
> +=C2=A0=C2=A0=C2=A0 { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1, N=
ULL,
> rv_op_lq },
> +=C2=A0=C2=A0=C2=A0 { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1,=
 NULL,
> rv_op_sq },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "nop", rv_codec_i, rv_fmt_none },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "mv", rv_codec_i, rv_fmt_rd_rs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "not", rv_codec_i, rv_fmt_rd_rs1 },
> @@ -2649,10 +2610,8 @@ static const rv_opcode_data rvi_opcode_data[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "ssrdp", rv_codec_r, rv_fmt_rd },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs=
2_rs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs=
2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL, rv_=
op_sspush,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sspush, 0 },
> -=C2=A0=C2=A0=C2=A0 { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL,
> rv_op_sspopchk,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_op_sspopchk, 0 },
> +=C2=A0=C2=A0=C2=A0 { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL, rv_=
op_sspush
> },
> +=C2=A0=C2=A0=C2=A0 { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL,
> rv_op_sspopchk },
> =C2=A0=C2=A0=C2=A0 { "cbo.inval", rv_codec_r, rv_fmt_rs1 },
> =C2=A0=C2=A0=C2=A0 { "cbo.clean", rv_codec_r, rv_fmt_rs1 },
> =C2=A0=C2=A0=C2=A0 { "cbo.flush", rv_codec_r, rv_fmt_rs1 },
> @@ -5397,24 +5356,10 @@ static const rv_opcode_data
> *decode_inst_lift_pseudo(rv_decode *dec,
> =C2=A0
> =C2=A0/* decompress instruction */
> =C2=A0
> -static const rv_opcode_data *decode_inst_decompress(rv_decode *dec,
> rv_isa isa,
> +static const rv_opcode_data *decode_inst_decompress(rv_decode *dec,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 const
> rv_opcode_data *op)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 int decomp_op;
> -
> -=C2=A0=C2=A0=C2=A0 switch (isa) {
> -=C2=A0=C2=A0=C2=A0 case rv32:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decomp_op =3D op->decomp_rv32=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0=C2=A0 case rv64:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decomp_op =3D op->decomp_rv64=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0=C2=A0 case rv128:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decomp_op =3D op->decomp_rv12=
8;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0=C2=A0 default:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_not_reached();
> -=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 int decomp_op =3D op->decomp;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if (decomp_op !=3D rv_op_illegal) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->op =3D decomp_op;
> @@ -5473,7 +5418,7 @@ static GString *disasm_inst(rv_isa isa,
> uint64_t pc, rv_inst inst,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 op =3D &dec.opcode_data[dec.op];
> =C2=A0=C2=A0=C2=A0=C2=A0 decode_inst_operands(&dec, isa, op);
> -=C2=A0=C2=A0=C2=A0 op =3D decode_inst_decompress(&dec, isa, op);
> +=C2=A0=C2=A0=C2=A0 op =3D decode_inst_decompress(&dec, op);
> =C2=A0=C2=A0=C2=A0=C2=A0 op =3D decode_inst_lift_pseudo(&dec, op);
> =C2=A0=C2=A0=C2=A0=C2=A0 return format_inst(24, &dec, op);
> =C2=A0}

