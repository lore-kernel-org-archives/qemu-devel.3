Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B529C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsd2-0005AU-7A; Tue, 11 Aug 2026 15:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsd0-00058M-PI; Tue, 11 Aug 2026 15:59:14 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtscx-0000GO-R7; Tue, 11 Aug 2026 15:59:14 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id ECF45EC009E;
 Tue, 11 Aug 2026 15:59:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 15:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478350; x=1786564750; bh=qWaBC6lEgkbVOzFqE/dzgOhUJnpop9ud
 tlKyvZ0rya4=; b=z61E88lvOkaqXqI2rs1t1kF+aPNtD7VekuVJHZJ3MfQ20HRV
 3Ajt+gT34Uxif8LFctsEqhYqlK8ucFYfIUT6+irVXetVVYHOm3InbHTohJuRkvsM
 tHQTMKtZmrXBb1y3aUxsqfORxVEQ6hsb5DgUprMqzI6p8hUGsLBRmjgHUh3VA4Ao
 1GPlH3vae53Ccx2dyox9yRDxzQQd6EWxkN/0e5YznLMvTf0V+bS7HaLkjedulT5n
 K8gIUsaZQ7zOklUeyrZ8BjpfgSqu8htr76aLUD6KZ8TGsVg6WjL1uTZte/cG6zh8
 1+GYruSfdxWNkFERek0MHe9rNG0uz3l4OBDkKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478350; x=
 1786564750; bh=qWaBC6lEgkbVOzFqE/dzgOhUJnpop9udtlKyvZ0rya4=; b=O
 iTefB/+Cz6G0PByFG7sY5kqLqHdbDbHxPngQPJqumY8aLjAjtgLIdDPaBOJuOdUb
 HKeUQYd1YrNMTW/2e2c3ckEzDiDwAOw3c1kKDlLjnBKxJmIBU2yWaMZIaaCIc593
 7yCIYPGhK275+xealV7Ny2YoSim+2jcCMP/Kyo3lQ1l32cH7FN+Ji0WvBnIL7yK8
 TID/hN069ZBVjTIh/20g4PaQTB22PGlXoT3mQ9z19wtTKEU1bnUWpo15g1XcZ577
 x/5rms3Eo54H/DKNrnKllL6SwvMFW154YYE73mbN/ObHONFdDMmvtc/lekjdB8nT
 bd0JY7OPx1TkvDFMOuP1Q==
X-ME-Sender: <xms:Dn97aq_zFDGztLyD-Iz6fbYVThOW9mqc7PhsvJO9OQKtGTtbSrl4Gw>
 <xme:Dn97avDmxr3iAC7PmePidnvDxpodsM0Osh8PkrymnbhF_P8dQ0QWoNMmNbVJIlRmx
 9ed867hi2pOp-qxt0bHtq1cVF_xIAsUqgKHYXradqT5WPtau5muoA>
X-ME-Received: <xmr:Dn97avKmAGKbB5lgmmlhGKM2wbyYWDC2__kEe82FAhpNkzwjjhzxAbBFTmyCxPD_VGcXCA>
X-ME-Proxy-Cause: dmFkZTG022mVQphzI7AWPJwf5iH2zrR/m6qBn9XfRmKRpHDMJFydYTJQKVsM1QV+rwV6La
 5lrePzwx4fvDAbuWGvHeRfj/XXR7cRigp+VFqRksAUG14iVvyA71KFanGk670lEqM8JVu4
 s34RyOYIIjP0W8WBcm0e1tPVBp/pNSsHcdVX1Ks29W2b9Vr5JvJeEXiSndrwW6yXxb4+J4
 eZfRbt29FtMtF3dLgjNB6mepufrYu6ZS9dF46cYmkr7C0VornlkrAZTNc8V+Abmi0Y7yME
 8S+ZxumAgsgCiVLwzI8RB5uG9SF/jOVVCcorsE69lSTOl6wZGe9l8hpUAF/XNdPBWsb4of
 wi0EIaQfbyro91PuxjifIy6AllOkkrbsPiiXVUpgR4G2HU0EJ1BHLNxozjTjhbbE2tbQX9
 j9fFwdkKMl2lEc0ZJcblYcbBlY0dxqKZilj5WsyOqbXih3fPUV/n5XLnZaqOVFXmsqYYFE
 4SqJyv5UUdmhE8O/SEIgIRaM8iIh6vdY8sFUOdUb5fo33uIZnORtPeL/MZLDiFUwsbbH2D
 a84rnaXTrjAbD0GK1wgLrP0nc0PD4cyiFweLaJsCTAo96RXTKv7xZQtOVCrZe/6IjcImJC
 sAEV0SZS+W0EKbj1S6CCUE0FzHBYrfI0V+UVqULmpj900OcNYCrdhIgCYeyA
X-ME-Proxy: <xmx:Dn97aql4LsVgAISkXxJfZs1DKFBG8j6ntA8V3paVUxbe71kCzH8Siw>
 <xmx:Dn97alE-e7OKWklJWQlc2Mt5MHYbIqDpNEm8wRAw2CMDXT3PcIOwnQ>
 <xmx:Dn97aiHS7L59l2xwYSeedLtlgVAj-JS3XjoW_8uGQs-NZUOCSO_gng>
 <xmx:Dn97aqOZbM4seyXDa-eacRlT1WdtO8mAiHWr_iBhhtIsUdCOTn3fTg>
 <xmx:Dn97aoDzZ1KmbsFR5pRjitlI07AdfhX8mNXVAuETaQR8QrxpsnLfllhS>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:59:10 -0400 (EDT)
Message-ID: <966cc97e039f72787090e8c3c9d89a3a7a602508.camel@alistair23.me>
Subject: Re: [PATCH 06/56] disas/riscv: Move operand extractors earlier in file
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 05:59:10 +1000
In-Reply-To: <20260809223545.730664-7-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-7-richard.henderson@linaro.org>
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
> =C2=A0disas/riscv.c | 790 +++++++++++++++++++++++++----------------------=
-
> --
> =C2=A01 file changed, 395 insertions(+), 395 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 2ba0a6a73a..e3fbc26626 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1259,6 +1259,401 @@ static const rv_comp_data rvcp_fsgnjx_q[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> =C2=A0};
> =C2=A0
> +/* operand extractors */
> +
> +static uint32_t operand_rd(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> +}
> +
> +static uint32_t operand_rs1(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 15, 5);
> +}
> +
> +static uint32_t operand_rs2(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 5);
> +}
> +
> +static uint32_t operand_rs3(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 27, 5);
> +}
> +
> +static uint32_t operand_aq(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 26, 1);
> +}
> +
> +static uint32_t operand_rl(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 25, 1);
> +}
> +
> +static uint32_t operand_pred(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 24, 4);
> +}
> +
> +static uint32_t operand_succ(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 4);
> +}
> +
> +static uint32_t operand_rm(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 3);
> +}
> +
> +static uint32_t operand_shamt5(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 5);
> +}
> +
> +static uint32_t operand_shamt6(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 6);
> +}
> +
> +static uint32_t operand_shamt7(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 7);
> +}
> +
> +static uint32_t operand_crdq(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 3);
> +}
> +
> +static uint32_t operand_crs1q(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 3);
> +}
> +
> +static uint32_t operand_crs1rdq(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 3);
> +}
> +
> +static uint32_t operand_crs2q(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 3);
> +}
> +
> +static uint32_t calculate_xreg(uint32_t sreg)
> +{
> +=C2=A0=C2=A0=C2=A0 return sreg < 2 ? sreg + 8 : sreg + 16;
> +}
> +
> +static uint32_t operand_sreg1(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return calculate_xreg(extract32(inst, 7, 3));
> +}
> +
> +static uint32_t operand_sreg2(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return calculate_xreg(extract32(inst, 2, 3));
> +}
> +
> +static uint32_t operand_crd(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> +}
> +
> +static uint32_t operand_crs1(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> +}
> +
> +static uint32_t operand_crs1rd(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> +}
> +
> +static uint32_t operand_crs2(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 5);
> +}
> +
> +static uint32_t operand_cimmsh5(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 5);
> +}
> +
> +static uint32_t operand_csr12(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 12);
> +}
> +
> +static int32_t operand_imm12(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 20, 12);
> +}
> +
> +static int32_t operand_imm20(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 20) << 12;
> +}
> +
> +static int32_t operand_jimm20(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 31, 1) << 20 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 21, 10) << 1 =
|
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 20, 1) << 11 =
|
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 12, 8) << 12;
> +}
> +
> +static int32_t operand_simm12(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 25, 7) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 5);
> +}
> +
> +static int32_t operand_sbimm12(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 31, 1) << 12 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 25, 6) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 8, 4) << 1 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 1) << 11;
> +}
> +
> +static uint32_t operand_cimmshl6(rv_inst inst, rv_isa isa)
> +{
> +=C2=A0=C2=A0=C2=A0 int imm =3D extract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5);
> +=C2=A0=C2=A0=C2=A0 if (isa =3D=3D rv128) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D imm ? imm : 64;
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 return imm;
> +}
> +
> +static uint32_t operand_cimmshr6(rv_inst inst, rv_isa isa)
> +{
> +=C2=A0=C2=A0=C2=A0 int imm =3D extract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5);
> +=C2=A0=C2=A0=C2=A0 if (isa =3D=3D rv128) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D imm | (imm & 32) << 1=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D imm ? imm : 64;
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 return imm;
> +}
> +
> +static int32_t operand_cimmi(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5);
> +}
> +
> +static int32_t operand_cimmui(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 17 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5) << 12;
> +}
> +
> +static uint32_t operand_cimmlwsp(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 4, 3) << 2 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 2) << 6;
> +}
> +
> +static uint32_t operand_cimmldsp(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 3 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 3) << 6;
> +}
> +
> +static uint32_t operand_cimmlqsp(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 4) << 6;
> +}
> +
> +static int32_t operand_cimm16sp(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 9 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 1) << 6 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 3, 2) << 7 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 1) << 5;
> +}
> +
> +static int32_t operand_cimmj(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 11 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 11, 1) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 9, 2) << 8 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 8, 1) << 10 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 1) << 6 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 7 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 3, 3) << 1 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 1) << 5;
> +}
> +
> +static int32_t operand_cimmb(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 8 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 10, 2) << 3 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 6 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 3, 2) << 1 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 1) << 5;
> +}
> +
> +static uint32_t operand_cimmswsp(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 9, 4) << 2 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 2) << 6;
> +}
> +
> +static uint32_t operand_cimmsdsp(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 10, 3) << 3 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 3) << 6;
> +}
> +
> +static uint32_t operand_cimmsqsp(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 11, 2) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 4) << 6;
> +}
> +
> +static uint32_t operand_cimm4spn(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 11, 2) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 4) << 6 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 2 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 1) << 3;
> +}
> +
> +static uint32_t operand_cimmw(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 10, 3) << 3 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 2 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 1) << 6;
> +}
> +
> +static uint32_t operand_cimmd(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 10, 3) << 3 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 6;
> +}
> +
> +static uint32_t operand_cimmq(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 11, 2) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 10, 1) << 8 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 6;
> +}
> +
> +static int32_t operand_vimm(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 15, 5);
> +}
> +
> +static uint32_t operand_vuimm(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 15, 5);
> +}
> +
> +static uint32_t operand_vzimm11(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 11);
> +}
> +
> +static uint32_t operand_vzimm10(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 10);
> +}
> +
> +static uint32_t operand_vzimm6(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 26, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 15, 5);
> +}
> +
> +static uint32_t operand_bs(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 30, 2);
> +}
> +
> +static uint32_t operand_rnum(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 4);
> +}
> +
> +static uint32_t operand_vm(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 25, 1);
> +}
> +
> +static uint32_t operand_uimm_c_lb(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 5, 1) << 1 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1);
> +}
> +
> +static uint32_t operand_uimm_c_lh(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 5, 1) << 1;
> +}
> +
> +static uint32_t operand_zcmp_spimm(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 2) << 4;
> +}
> +
> +static uint32_t operand_zcmp_rlist(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 4, 4);
> +}
> +
> +static uint32_t operand_imm6(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 6);
> +}
> +
> +static uint32_t operand_imm2(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 25, 2);
> +}
> +
> +static uint32_t operand_immh(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 26, 6);
> +}
> +
> +static uint32_t operand_imml(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 6);
> +}
> +
> +static uint32_t calculate_stack_adj(rv_isa isa, uint32_t rlist,
> uint32_t spimm)
> +{
> +=C2=A0=C2=A0=C2=A0 int xlen_bytes_log2 =3D isa =3D=3D rv64 ? 3 : 2;
> +=C2=A0=C2=A0=C2=A0 int regs =3D rlist =3D=3D 15 ? 13 : rlist - 3;
> +=C2=A0=C2=A0=C2=A0 uint32_t stack_adj_base =3D ROUND_UP(regs << xlen_byt=
es_log2, 16);
> +=C2=A0=C2=A0=C2=A0 return stack_adj_base + spimm;
> +}
> +
> +static uint32_t operand_zcmp_stack_adj(rv_inst inst, rv_isa isa)
> +{
> +=C2=A0=C2=A0=C2=A0 return calculate_stack_adj(isa, operand_zcmp_rlist(in=
st),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 operand_zcmp_spimm(inst));
> +}
> +
> +static uint32_t operand_tbl_index(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 8);
> +}
> +
> +static uint32_t operand_lpl(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 20);
> +}
> +
> =C2=A0/* instruction metadata */
> =C2=A0
> =C2=A0const rv_opcode_data rvi_opcode_data[] =3D {
> @@ -4198,401 +4593,6 @@ static void decode_inst_opcode(rv_decode
> *dec, rv_isa isa)
> =C2=A0=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> =C2=A0}
> =C2=A0
> -/* operand extractors */
> -
> -static uint32_t operand_rd(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> -}
> -
> -static uint32_t operand_rs1(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 15, 5);
> -}
> -
> -static uint32_t operand_rs2(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 5);
> -}
> -
> -static uint32_t operand_rs3(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 27, 5);
> -}
> -
> -static uint32_t operand_aq(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 26, 1);
> -}
> -
> -static uint32_t operand_rl(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 25, 1);
> -}
> -
> -static uint32_t operand_pred(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 24, 4);
> -}
> -
> -static uint32_t operand_succ(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 4);
> -}
> -
> -static uint32_t operand_rm(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 3);
> -}
> -
> -static uint32_t operand_shamt5(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 5);
> -}
> -
> -static uint32_t operand_shamt6(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 6);
> -}
> -
> -static uint32_t operand_shamt7(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 7);
> -}
> -
> -static uint32_t operand_crdq(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 3);
> -}
> -
> -static uint32_t operand_crs1q(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 3);
> -}
> -
> -static uint32_t operand_crs1rdq(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 3);
> -}
> -
> -static uint32_t operand_crs2q(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 3);
> -}
> -
> -static uint32_t calculate_xreg(uint32_t sreg)
> -{
> -=C2=A0=C2=A0=C2=A0 return sreg < 2 ? sreg + 8 : sreg + 16;
> -}
> -
> -static uint32_t operand_sreg1(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return calculate_xreg(extract32(inst, 7, 3));
> -}
> -
> -static uint32_t operand_sreg2(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return calculate_xreg(extract32(inst, 2, 3));
> -}
> -
> -static uint32_t operand_crd(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> -}
> -
> -static uint32_t operand_crs1(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> -}
> -
> -static uint32_t operand_crs1rd(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> -}
> -
> -static uint32_t operand_crs2(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 5);
> -}
> -
> -static uint32_t operand_cimmsh5(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 5);
> -}
> -
> -static uint32_t operand_csr12(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 12);
> -}
> -
> -static int32_t operand_imm12(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return sextract32(inst, 20, 12);
> -}
> -
> -static int32_t operand_imm20(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 20) << 12;
> -}
> -
> -static int32_t operand_jimm20(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return sextract32(inst, 31, 1) << 20 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 21, 10) << 1 =
|
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 20, 1) << 11 =
|
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 12, 8) << 12;
> -}
> -
> -static int32_t operand_simm12(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return sextract32(inst, 25, 7) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 5);
> -}
> -
> -static int32_t operand_sbimm12(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return sextract32(inst, 31, 1) << 12 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 25, 6) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 8, 4) << 1 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 1) << 11;
> -}
> -
> -static uint32_t operand_cimmshl6(rv_inst inst, rv_isa isa)
> -{
> -=C2=A0=C2=A0=C2=A0 int imm =3D extract32(inst, 12, 1) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5);
> -=C2=A0=C2=A0=C2=A0 if (isa =3D=3D rv128) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D imm ? imm : 64;
> -=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 return imm;
> -}
> -
> -static uint32_t operand_cimmshr6(rv_inst inst, rv_isa isa)
> -{
> -=C2=A0=C2=A0=C2=A0 int imm =3D extract32(inst, 12, 1) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5);
> -=C2=A0=C2=A0=C2=A0 if (isa =3D=3D rv128) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D imm | (imm & 32) << 1=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D imm ? imm : 64;
> -=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 return imm;
> -}
> -
> -static int32_t operand_cimmi(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5);
> -}
> -
> -static int32_t operand_cimmui(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 17 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5) << 12;
> -}
> -
> -static uint32_t operand_cimmlwsp(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 1) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 4, 3) << 2 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 2) << 6;
> -}
> -
> -static uint32_t operand_cimmldsp(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 1) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 3 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 3) << 6;
> -}
> -
> -static uint32_t operand_cimmlqsp(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 1) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 4) << 6;
> -}
> -
> -static int32_t operand_cimm16sp(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 9 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 1) << 6 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 3, 2) << 7 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 1) << 5;
> -}
> -
> -static int32_t operand_cimmj(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 11 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 11, 1) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 9, 2) << 8 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 8, 1) << 10 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 1) << 6 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 7 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 3, 3) << 1 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 1) << 5;
> -}
> -
> -static int32_t operand_cimmb(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 8 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 10, 2) << 3 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 6 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 3, 2) << 1 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 1) << 5;
> -}
> -
> -static uint32_t operand_cimmswsp(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 9, 4) << 2 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 2) << 6;
> -}
> -
> -static uint32_t operand_cimmsdsp(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 10, 3) << 3 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 3) << 6;
> -}
> -
> -static uint32_t operand_cimmsqsp(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 11, 2) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 4) << 6;
> -}
> -
> -static uint32_t operand_cimm4spn(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 11, 2) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 4) << 6 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 2 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 1) << 3;
> -}
> -
> -static uint32_t operand_cimmw(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 10, 3) << 3 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 2 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 1) << 6;
> -}
> -
> -static uint32_t operand_cimmd(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 10, 3) << 3 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 6;
> -}
> -
> -static uint32_t operand_cimmq(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 11, 2) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 10, 1) << 8 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 6;
> -}
> -
> -static int32_t operand_vimm(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return sextract32(inst, 15, 5);
> -}
> -
> -static uint32_t operand_vuimm(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 15, 5);
> -}
> -
> -static uint32_t operand_vzimm11(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 11);
> -}
> -
> -static uint32_t operand_vzimm10(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 10);
> -}
> -
> -static uint32_t operand_vzimm6(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 26, 1) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 15, 5);
> -}
> -
> -static uint32_t operand_bs(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 30, 2);
> -}
> -
> -static uint32_t operand_rnum(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 4);
> -}
> -
> -static uint32_t operand_vm(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 25, 1);
> -}
> -
> -static uint32_t operand_uimm_c_lb(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 5, 1) << 1 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1);
> -}
> -
> -static uint32_t operand_uimm_c_lh(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 5, 1) << 1;
> -}
> -
> -static uint32_t operand_zcmp_spimm(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 2) << 4;
> -}
> -
> -static uint32_t operand_zcmp_rlist(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 4, 4);
> -}
> -
> -static uint32_t operand_imm6(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 6);
> -}
> -
> -static uint32_t operand_imm2(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 25, 2);
> -}
> -
> -static uint32_t operand_immh(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 26, 6);
> -}
> -
> -static uint32_t operand_imml(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 6);
> -}
> -
> -static uint32_t calculate_stack_adj(rv_isa isa, uint32_t rlist,
> uint32_t spimm)
> -{
> -=C2=A0=C2=A0=C2=A0 int xlen_bytes_log2 =3D isa =3D=3D rv64 ? 3 : 2;
> -=C2=A0=C2=A0=C2=A0 int regs =3D rlist =3D=3D 15 ? 13 : rlist - 3;
> -=C2=A0=C2=A0=C2=A0 uint32_t stack_adj_base =3D ROUND_UP(regs << xlen_byt=
es_log2, 16);
> -=C2=A0=C2=A0=C2=A0 return stack_adj_base + spimm;
> -}
> -
> -static uint32_t operand_zcmp_stack_adj(rv_inst inst, rv_isa isa)
> -{
> -=C2=A0=C2=A0=C2=A0 return calculate_stack_adj(isa, operand_zcmp_rlist(in=
st),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 operand_zcmp_spimm(inst));
> -}
> -
> -static uint32_t operand_tbl_index(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 8);
> -}
> -
> -static uint32_t operand_lpl(rv_inst inst)
> -{
> -=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 20);
> -}
> -
> =C2=A0/* decode operands */
> =C2=A0
> =C2=A0static void decode_inst_operands(rv_decode *dec, rv_isa isa)

