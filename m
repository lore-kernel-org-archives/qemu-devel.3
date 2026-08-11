Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5280DC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsch-0004d4-QY; Tue, 11 Aug 2026 15:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtscX-0004Uy-Hx; Tue, 11 Aug 2026 15:58:45 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtscV-0000EN-4z; Tue, 11 Aug 2026 15:58:45 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6E25B140012C;
 Tue, 11 Aug 2026 15:58:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 11 Aug 2026 15:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478322; x=1786564722; bh=pGRfHPBvIDseRc6tl4IExso5Qn6mTOzF
 t2clITjtBAY=; b=jkBGVS24QfUtWpgaqUZtQJmZT9J8tMphn9hWyEEIje9SYTDO
 /TCvQBOu/ReGLerk2Y8PBvenoMwXtxtnivfP6k4FUQBN7Uns70Jm+mIJv6FaZJvB
 mWwLWjS/hKiMKic3dsSKCikLv007kvwAnQ9woSjU5mnlxZLNYbwkfGtXOgWuW1Vs
 1Je3ynVkSNDd+HU7AnGheOxIyrGPYBbKdem7671efqgDAqMH9oCiOo8lEgXzzIJe
 SL2aZV+J0FXWC25BttgCr0TwqOyJ65Gx1DsuxGcdIiPYXSlF5KrOnNdCFQvdjQuw
 pQeku/NB+84xe0YbOVt+K91GCBqGhzN5o+YWCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478322; x=
 1786564722; bh=pGRfHPBvIDseRc6tl4IExso5Qn6mTOzFt2clITjtBAY=; b=U
 P1VKD2WcWQ7pifERASZLptzAKF818mTMPM5QkFZ7yPZH2lFfeIGieqFxvsbP0HWu
 aFFDyMI9UNodyp0BvNhkNdzal5+77VwN+GST8MtZf0PH9cPIVHUnv/NRz6y2I1Ix
 7gPWkU9OM8C9K/biofy+BwcAFusU69ibWxbAwWK3K+wAZxpLdyKyT3/WmioWgbL3
 aUWx3ofRaYa1ML2TS6CR89XgNKd0949Z2rNMjDM7e7+TVUgFSdRjBgqqRxEWd3D5
 JxpjaMustRVRoxMeZtr2+aNZvhFzfaJEL78s4Ui1Vm/Lu/reMXyxDACpL0lUwCTh
 20pTxC97P62Fsyp9UXY8g==
X-ME-Sender: <xms:8n57agroV23xXEwd8-davYEyzPeLYhghbYjlk_FHkwiyNmlmteSXKQ>
 <xme:8n57aoLyv6PiyYBVHyWbrbC8eODHb3IpjTX6LB2_DZV1i3UnHzxTvbd9RpuVi1xJ5
 7rS3s8M5bMQptroasC3s7zfiIZ5TUP2QkmFuhMFk5G0Buvb43BjNbw>
X-ME-Received: <xmr:8n57alTKiK0gUPqkU7m8JkTfuhTdSMIBJpLxi-qgeZqsOBijNwwfMenNRdxwC__8jnh2lg>
X-ME-Proxy-Cause: dmFkZTGBNhJMEONeF1V7rti1z8/lXN3MKspy3c+ew3Kte/ivpwEKq68c/cZW5HM7DPGp4e
 c5H164NnJLPHewZTW+QmRr4P9vOWCG6Mi1TO8Y3nWxAUvACM0JleLsyKboy1BHQy2BoRr+
 zu+A1iljAQw98JSaI1R1YAgx6ibrg5v7bVN08d9Xo6ac5FRltLEIywCpbHUEA73QKZy+bj
 TXiZA9sHIungXdubfyAzjagCPXVv1FycsMUY82dmon1Txcu42F3qodFdTeqibSHr+vNBSP
 RMiv4XHSCR5gApZp+VazOknQHeSIrxZfz1wEGdrUp97Tty2JnQil3TccE1BCemIoDfoqVq
 opn2DYckg/wG3oCXRyI1/p43/103KJ5Qh5Ox4MYgeCowO/zxS43Dx9GXq5hooqI/bMHigp
 7JqaP5yna24iMe4wbZZAOs5j5h/u0oAU/iComz7yox3F/eKXLCgXGZnX//zWQNee/eVR7A
 583RQVEkQI3ic0v3pLjXfY4SkzDiaI8mCyzQCQlKZ2qgqxvId17eEG6U8MZjO4A42OfVxs
 SOGBnnxZajod/HVHYf2H2YiXcartWiKQi+4iFh2g2UHxhmBfYlibcb+/juwJz5j2G64rxx
 15IleWQVv+m+Zj7LcUv741GHXFT0eUPhrWfTijB5x2/Cj0ldqyZEy+z9xBLA
X-ME-Proxy: <xmx:8n57anv3cSoN_3pm6re1yJimDTLmeyGIZ7K_GPtWqlgzd_wtjUDvdA>
 <xmx:8n57amYpfJx72KgwiNYk-owDEYK9Yfu2TheimrlaDlCst-psaTTlWg>
 <xmx:8n57atGFiMP91Dx2PIcNYpq-I22C11z_M8yrvW-K95dWUkgPBEu0mQ>
 <xmx:8n57aqwayswdTJyTZwtwTt2ta4xFvEhiVuvUuisu3zhBIb3n0SUE9g>
 <xmx:8n57ajbLk0vZQ4CQAhgCmMGStkv0EG6VqPCz60AclyvWUvjX4z69k-xD>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:58:42 -0400 (EDT)
Message-ID: <d7ddde0569dba7ba79c23f86673be7923ac2ddac.camel@alistair23.me>
Subject: Re: [PATCH 05/56] disas/riscv: Use extract helpers for operand fields
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>
Date: Wed, 12 Aug 2026 05:58:41 +1000
In-Reply-To: <20260809223545.730664-6-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-6-richard.henderson@linaro.org>
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

On Sun, 2026-08-09 at 15:34 -0700, Richard Henderson wrote:
> From: TANG Tiancheng <lyndra@linux.alibaba.com>
>=20
> Replace shift-based operand extraction with extract32() and
> sextract32().
> For signed immediates, use sextract32() on the field that carries the
> sign
> bit and combine it with the remaining extract32() fields.
>=20
> The RISC-V disassembler currently follows target/riscv/internals.h:
> insn_len() and decodes only 16-bit or 32-bit instruction lengths, so
> the
> converted fields are all in the low 32 bits of rv_inst.
>=20
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Message-Id:
> <20260703-b4-disas-xthead-fix-riscv-next-v4-5-84c566330bc7@linux.alib
> aba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 214 +++++++++++++++++++++++++----------------------=
-
> --
> =C2=A01 file changed, 107 insertions(+), 107 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 82b962dc71..2ba0a6a73a 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4202,82 +4202,82 @@ static void decode_inst_opcode(rv_decode
> *dec, rv_isa isa)
> =C2=A0
> =C2=A0static uint32_t operand_rd(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 52) >> 59;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_rs1(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 44) >> 59;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 15, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_rs2(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 39) >> 59;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_rs3(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 32) >> 59;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 27, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_aq(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 37) >> 63;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 26, 1);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_rl(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 38) >> 63;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 25, 1);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_pred(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 36) >> 60;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 24, 4);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_succ(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 40) >> 60;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 4);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_rm(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 49) >> 61;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 3);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_shamt5(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 39) >> 59;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_shamt6(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 38) >> 58;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 6);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_shamt7(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 37) >> 57;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 7);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_crdq(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 59) >> 61;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 3);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_crs1q(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 54) >> 61;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 3);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_crs1rdq(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 54) >> 61;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 3);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_crs2q(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 59) >> 61;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 3);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t calculate_xreg(uint32_t sreg)
> @@ -4287,80 +4287,80 @@ static uint32_t calculate_xreg(uint32_t sreg)
> =C2=A0
> =C2=A0static uint32_t operand_sreg1(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return calculate_xreg((inst << 54) >> 61);
> +=C2=A0=C2=A0=C2=A0 return calculate_xreg(extract32(inst, 7, 3));
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_sreg2(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return calculate_xreg((inst << 59) >> 61);
> +=C2=A0=C2=A0=C2=A0 return calculate_xreg(extract32(inst, 2, 3));
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_crd(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 52) >> 59;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_crs1(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 52) >> 59;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_crs1rd(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 52) >> 59;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 7, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_crs2(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 57) >> 59;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimmsh5(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 57) >> 59;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_csr12(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 32) >> 52;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 12);
> =C2=A0}
> =C2=A0
> =C2=A0static int32_t operand_imm12(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((int64_t)inst << 32) >> 52;
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 20, 12);
> =C2=A0}
> =C2=A0
> =C2=A0static int32_t operand_imm20(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (((int64_t)inst << 32) >> 44) << 12;
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 20) << 12;
> =C2=A0}
> =C2=A0
> =C2=A0static int32_t operand_jimm20(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (((int64_t)inst << 32) >> 63) << 20 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 33) >> 54) << 1 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 43) >> 63) << 11 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 44) >> 56) << 12;
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 31, 1) << 20 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 21, 10) << 1 =
|
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 20, 1) << 11 =
|
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 12, 8) << 12;
> =C2=A0}
> =C2=A0
> =C2=A0static int32_t operand_simm12(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (((int64_t)inst << 32) >> 57) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (inst << 52) >> 59;
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 25, 7) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static int32_t operand_sbimm12(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (((int64_t)inst << 32) >> 63) << 12 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 33) >> 58) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 52) >> 60) << 1 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 56) >> 63) << 11;
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 31, 1) << 12 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 25, 6) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 8, 4) << 1 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 1) << 11;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimmshl6(rv_inst inst, rv_isa isa)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 int imm =3D ((inst << 51) >> 63) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (inst << 57) >> 59;
> +=C2=A0=C2=A0=C2=A0 int imm =3D extract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (isa =3D=3D rv128) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D imm ? imm : 64;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -4369,8 +4369,8 @@ static uint32_t operand_cimmshl6(rv_inst inst,
> rv_isa isa)
> =C2=A0
> =C2=A0static uint32_t operand_cimmshr6(rv_inst inst, rv_isa isa)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 int imm =3D ((inst << 51) >> 63) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (inst << 57) >> 59;
> +=C2=A0=C2=A0=C2=A0 int imm =3D extract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (isa =3D=3D rv128) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D imm | (imm & 32)=
 << 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D imm ? imm : 64;
> @@ -4380,116 +4380,116 @@ static uint32_t operand_cimmshr6(rv_inst
> inst, rv_isa isa)
> =C2=A0
> =C2=A0static int32_t operand_cimmi(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (((int64_t)inst << 51) >> 63) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (inst << 57) >> 59;
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static int32_t operand_cimmui(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (((int64_t)inst << 51) >> 63) << 17 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 59) << 12;
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 17 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 5) << 12;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimmlwsp(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 51) >> 63) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 61) << 2 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 60) >> 62) << 6;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 4, 3) << 2 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 2) << 6;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimmldsp(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 51) >> 63) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 62) << 3 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 59) >> 61) << 6;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 3 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 3) << 6;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimmlqsp(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 51) >> 63) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 63) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 58) >> 60) << 6;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 4) << 6;
> =C2=A0}
> =C2=A0
> =C2=A0static int32_t operand_cimm16sp(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (((int64_t)inst << 51) >> 63) << 9 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 63) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 58) >> 63) << 6 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 59) >> 62) << 7 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 61) >> 63) << 5;
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 9 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 1) << 6 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 3, 2) << 7 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 1) << 5;
> =C2=A0}
> =C2=A0
> =C2=A0static int32_t operand_cimmj(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (((int64_t)inst << 51) >> 63) << 11 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 52) >> 63) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 53) >> 62) << 8 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 55) >> 63) << 10 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 56) >> 63) << 6 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 63) << 7 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 58) >> 61) << 1 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 61) >> 63) << 5;
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 11 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 11, 1) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 9, 2) << 8 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 8, 1) << 10 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 1) << 6 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 7 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 3, 3) << 1 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 1) << 5;
> =C2=A0}
> =C2=A0
> =C2=A0static int32_t operand_cimmb(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (((int64_t)inst << 51) >> 63) << 8 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 52) >> 62) << 3 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 62) << 6 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 59) >> 62) << 1 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 61) >> 63) << 5;
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 12, 1) << 8 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 10, 2) << 3 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 6 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 3, 2) << 1 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 2, 1) << 5;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimmswsp(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 51) >> 60) << 2 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 55) >> 62) << 6;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 9, 4) << 2 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 2) << 6;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimmsdsp(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 51) >> 61) << 3 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 54) >> 61) << 6;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 10, 3) << 3 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 3) << 6;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimmsqsp(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 51) >> 62) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 53) >> 60) << 6;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 11, 2) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 4) << 6;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimm4spn(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 51) >> 62) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 53) >> 60) << 6 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 63) << 2 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 58) >> 63) << 3;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 11, 2) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 7, 4) << 6 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 2 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 1) << 3;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimmw(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 51) >> 61) << 3 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 63) << 2 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 58) >> 63) << 6;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 10, 3) << 3 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1) << 2 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 1) << 6;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimmd(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 51) >> 61) << 3 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 62) << 6;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 10, 3) << 3 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 6;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_cimmq(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 51) >> 62) << 4 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 53) >> 63) << 8 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 62) << 6;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 11, 2) << 4 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 10, 1) << 8 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 5, 2) << 6;
> =C2=A0}
> =C2=A0
> =C2=A0static int32_t operand_vimm(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (int64_t)(inst << 44) >> 59;
> +=C2=A0=C2=A0=C2=A0 return sextract32(inst, 15, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_vuimm(rv_inst inst)
> @@ -4499,54 +4499,54 @@ static uint32_t operand_vuimm(rv_inst inst)
> =C2=A0
> =C2=A0static uint32_t operand_vzimm11(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 33) >> 53;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 11);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_vzimm10(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 34) >> 54;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 10);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_vzimm6(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 37) >> 63) << 5 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 44) >> 59);
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 26, 1) << 5 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 15, 5);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_bs(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 32) >> 62;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 30, 2);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_rnum(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 40) >> 60;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 4);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_vm(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 38) >> 63;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 25, 1);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_uimm_c_lb(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (((inst << 58) >> 63) << 1) |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 63);
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 5, 1) << 1 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extract32(inst, 6, 1);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_uimm_c_lh(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (((inst << 58) >> 63) << 1);
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 5, 1) << 1;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_zcmp_spimm(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 60) >> 62) << 4;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 2) << 4;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_zcmp_rlist(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 56) >> 60);
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 4, 4);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_imm6(rv_inst inst)
> @@ -4556,17 +4556,17 @@ static uint32_t operand_imm6(rv_inst inst)
> =C2=A0
> =C2=A0static uint32_t operand_imm2(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 37) >> 62;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 25, 2);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_immh(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 32) >> 58;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 26, 6);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_imml(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 38) >> 58;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 6);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t calculate_stack_adj(rv_isa isa, uint32_t rlist,
> uint32_t spimm)
> @@ -4585,12 +4585,12 @@ static uint32_t
> operand_zcmp_stack_adj(rv_inst inst, rv_isa isa)
> =C2=A0
> =C2=A0static uint32_t operand_tbl_index(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return ((inst << 54) >> 56);
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 2, 8);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_lpl(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return inst >> 12;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 12, 20);
> =C2=A0}
> =C2=A0
> =C2=A0/* decode operands */

