Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671F0C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrZ3-0006ic-Vc; Tue, 11 Aug 2026 14:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrZ3-0006iA-99; Tue, 11 Aug 2026 14:51:05 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrZ1-0006II-8q; Tue, 11 Aug 2026 14:51:05 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ED8931400147;
 Tue, 11 Aug 2026 14:51:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 14:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786474261; x=1786560661; bh=aGADaT92hQ56p9H5vfc2Dyl8OQeV/+WN
 LkaRfzVEs48=; b=SzFNBOduT465rd9mecSvdVFgwMstQ/KsmAKjUdXzydpzR8f0
 kCDu1bpojr+JDdsBQIwjpXfPP/KiMRIyRc4u8L7ukEtSsjiPMoQ65vib8ubbRbTe
 h0tRweepp2rxIq7IsSC4QOLSIpN6S74Kxpemkn2qn16JZaR6HJtPCmLalHScWCkL
 +HaX2Y/i7JrfBWw4EXLoHPkVgRFLvEO/Zj/uXXlu7ip9t6WvDHw09KMB8IzOhVWd
 r+Zvj3QF4eixY7vphNTTw4ApIAYXFs+zsE354zHyqMGp60beSLFufA1SuAR3Y+1D
 RfqZJ5ddobW53tJW21UGEuGglIHF+A91A4d8+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786474261; x=
 1786560661; bh=aGADaT92hQ56p9H5vfc2Dyl8OQeV/+WNLkaRfzVEs48=; b=W
 b6c0sLY172fqiusLSziOJrHjD4Fdpy74RG6scpURMDfoSQZf/O0Ye/lQgA4o+R9e
 5xOAz7xLM1PeRlqSvoyGbuH1sUniSXe0F8XOirJgbL4z27XyFx0qU6CFIwq4elB8
 8pDtUSoit/RVNaLzz6IJJgx3rYDhUf0hFyTMtANF5bTBHB/rZg4pGg9w3+wleHzG
 f2lg8OCJUD4lPBjBz9nHQiAdNLwtDoeqogjsQZdN8LphPYENZSd7FqNR19xFtZHs
 SmTDBKQOdEvGvsRKdYuh4EvLfCHkZ3xy0PzTaE1Wc3fC5LSMDQli9Lq1TKnd99iw
 RhVek46Pe4CSR1FK0W8+Q==
X-ME-Sender: <xms:FW97aozf1MESbkqHLtnemofO3vN-UTTNySfAUPXN-2iBiz2Q5ynhyQ>
 <xme:FW97avX3_3XqkP06AT5ZDxKzSgWHym-VzvY8dDGBtctKdyriw8al5ykBoUYXXUEBv
 pr_vxiodOjW2v_9cArS45UjFxb1HVJUGnvJX8ibSdjXFoA0tY9_yw>
X-ME-Received: <xmr:FW97ak-JvJ4j0piLUK9x5EKSEjTc6KbZDYvlWbKKhmSVq5zNmFZqiVW4SQMK2CwO0VvDlw>
X-ME-Proxy-Cause: dmFkZTF1EJc3BzQjMcZHcgzchWhNmwyrXr4+qH65UNCSR6tNuFPj+F2sx7NY3LOwicPHRL
 aRvCi/2dtQX1IpxUDlOuKvgNdjMkvC9urKYHBh3syQbtQjFYHvkW1IuZgNstcqiX9e49h3
 PAkI/oSurQsAoaAH/cs6M6FkIg6WZ9CpqSMeiqIQmBi7rgvnrKGwglBrwZy8Ziu0q8Oy98
 jzF7qKvaYh4Y9ZvPVfX7c4GsB9P/j6/RwN07Kc7hyNm16PJOWEzki3nKaHzEF4DAqAjw+d
 QKZ8lzIeK4K+T55vGHKMuf0Xarjl8SKN0IcE/99ZgIl03MVSvSBnsY9LVPPlB8JW1xkyiI
 6xa5NnOJno/teVXvJToRc0UbS1tGmQEWQFEyW2fp4Mw8+3vLE3tjpeU30Ua0GhvjAYu044
 nDyETjxtxEmec/8q1YIZ7E8rxU/so/3ivfonWQJVojwEGh76OzQepZuAdovSEfnRH/WwDp
 JGZaRXI2F67y3fcdDzylAT/p0JWSG0jUPQnGug4+662oHlcms7O+zVRpFzJEL2eofsjGOT
 2LDlTom1ahFfNS3LF91EXw0YE3IWhZfe7AqV7C3gaBJuhXG4A/49G2YmcXG9p5QO7PX9aS
 +a66u+0dd37yUSsae2jYp3K5D+Vu+Z//pSfzKOaj/dnxVi70aZM8G+kwKzMw
X-ME-Proxy: <xmx:FW97aivoeekwiC1XqjEIqyRXs5Km2WcYyyYKC2YHCZEvCSQXfHsMnA>
 <xmx:FW97ak3l4tTh4BntnYycG5GsMBxgGlHC3cwP09yf0irydGtLtQMRMA>
 <xmx:FW97anTgDGoOOJBWvigcBbbf__N5lG7T3srIr5MBHpaB-bbZ6tt9eQ>
 <xmx:FW97aoeLjsVTt6xHuYjckVQzZ8snoInNo5TNQ2NSvLrgz34aILR6Bg>
 <xmx:FW97ap8ZORtQWjq4m7Ba8_hhqddF02K2Vr-zFDHLvhaS4PR5wcKNV5He>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 14:51:00 -0400 (EDT)
Message-ID: <01ee5ad4f592c2b36eb5efb5f66c479bf0b4155b.camel@alistair23.me>
Subject: Re: [PATCH] target/riscv: Fix PC sync in trans_sspopchk for CFI
 exception handling
From: Alistair <alistair@alistair23.me>
To: A-Shehab <ahshehab24@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Max Chou <max.chou@sifive.com>, Palmer Dabbelt	
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Weiwei
 Li	 <liwei1518@gmail.com>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu@processmission.com>
Date: Wed, 12 Aug 2026 04:51:00 +1000
In-Reply-To: <20260730181852.1622-1-ahshehab24@gmail.com>
References: <20260730181852.1622-1-ahshehab24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=alistair@alistair23.me; helo=fhigh-a5-smtp.messagingengine.com
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

On Thu, 2026-07-30 at 21:18 +0300, A-Shehab wrote:
> From: Max Chou <max.chou@sifive.com>
>=20
> Move gen_update_pc call before conditional logic to ensure consistent
> PC state regardless of execution path.
>=20
> Previously, the host instructions generated to update the cpu_pc were
> only executed in the failure path when shadow stack validation
> failed.
> This created inconsistent PC synchronization.
>=20
> This inconsistency caused issues in CF_PCREL mode where subsequent
> instructions calculated wrong relative offsets from stale pc_save
> values, and could lead to incorrect exception return addresses.
>=20
> This fix ensures PC is always synchronized before any helper that
> might raise an exception, maintaining consistent translator state
> across all execution paths.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4118
> Signed-off-by: Max Chou <max.chou@sifive.com>
> [ahshehab: rebased on current master; file moved to
> =C2=A0target/riscv/tcg/insn_trans/ and the ssp load is now 64-bit wide]
> Tested-by: A-Shehab <ahshehab24@gmail.com>
> Signed-off-by: A-Shehab <ahshehab24@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> This is a repost of Max Chou's patch from 2025-11-05 [1], which did
> not
> receive any review. Rebased onto current master: the file moved to
> target/riscv/tcg/insn_trans/ and the ssp load is now a 64-bit load,
> so
> the original patch no longer applies.
>=20
> I opened a GitLab issue (#4118) with a minimal, self-contained bare-
> metal
> reproducer for this bug. It runs an sspopchk that matches the shadow
> stack
> (the common case) followed by an auipc in the same translation block;
> on
> current master the auipc returns an address 4 bytes too low (exit 42)
> and
> with this patch it is correct (exit 0). The reproducer is included in
> the
> issue.
>=20
> [1]
> https://lore.kernel.org/qemu-devel/20251105134331.2865581-1-max.chou@sifi=
ve.com/
>=20
> =C2=A0target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> index a813232887..d47a9f9c7d 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> @@ -32,6 +32,7 @@ static bool trans_sspopchk(DisasContext *ctx,
> arg_sspopchk *a)
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGLabel *skip =3D gen_new_label();
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t tmp =3D (get_xl(ctx) =3D=3D MXL_RV64) ?=
 8 : 4;
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv data =3D tcg_temp_new();
> +=C2=A0=C2=A0=C2=A0 gen_update_pc(ctx, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv_i64 wide_addr =3D tcg_temp_new_i64();
> =C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPUR=
ISCVState,
> ssp));
> =C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_trunc_i64_tl(addr, wide_addr);
> @@ -42,7 +43,6 @@ static bool trans_sspopchk(DisasContext *ctx,
> arg_sspopchk *a)
> =C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
> =C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_C=
HECK_BCFI_TVAL),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_env, offsetof(CPURISCV=
State,
> sw_check_code));
> -=C2=A0=C2=A0=C2=A0 gen_update_pc(ctx, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_raise_exception(tcg_env,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_constant_i32(RISCV_EXCP_SW_CHECK))=
;
> =C2=A0=C2=A0=C2=A0=C2=A0 gen_set_label(skip);

