Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0239C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtt66-0006oA-8O; Tue, 11 Aug 2026 16:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt64-0006nq-2e; Tue, 11 Aug 2026 16:29:16 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt62-0004kH-I5; Tue, 11 Aug 2026 16:29:15 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id C5D5FEC0173;
 Tue, 11 Aug 2026 16:29:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 11 Aug 2026 16:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786480153; x=1786566553; bh=YWpkJRjuEgh1OrKNubU7rVv1Ddysr1Uw
 1NG2ohg9sok=; b=Ts7vjIiV4FuhH0W883MjJWx1jhUbABs/t+Toev1DSfM9Csgg
 rH6h0Kjg58zGUZkvYD5u2/7nJaEKEBQCzTrN0Qhg19AfMdsGiLNoreRtdpW7YnnE
 qZb/Vwz56lcKNQjPEEif11S8RjIUAX7/5orDaIUbbFlJEqVyPnbeiF+4l/d+FSvV
 UYIuh8Uxugkc8khbu3RMm9ZPHBR22GnKLnIRClG713epR0tHtgvJ4CZLIxOXyUIX
 F8dQ/JzUdDkSoQlCybSJkCagRwc1zbUlYM1dKJon+gCDC53D0DfrnIqpfegNDySA
 6Zi9mBXIFVYyE4FJUdUREPOUlq1zAtoJzvS6aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786480153; x=
 1786566553; bh=YWpkJRjuEgh1OrKNubU7rVv1Ddysr1Uw1NG2ohg9sok=; b=l
 tZura3FTEz4yVYWNGfPi7Bpg/Vgb1osf5ZJ/JPbVAViBywtAmkGEEIA5/y0Qy/aE
 T5mQ0yWqFKLfimGf5Hw5qlK5gZ3sKKFtNzhH+1CQEYn7dpQCYz4pB5BK7rnx2tpF
 0AirMW4M3cbOyCpzGaTS7WxR1k3WX925CRTOld4ECWUBFnXkigvZlk9D188mGyTp
 WN9uu6ErVT7acNustW6Kqe+kqN+o9mbwy5n/RNWge3xd8E2BxoAqWIFMiX5ChKrW
 q+jtDfiKA9JHAt2skaHtKFG6MKz33emyXV/pD9RcLEpFxsDgdR4TVLZu6VdSpG9x
 lNPPAi1ocKwaOmX6Tafow==
X-ME-Sender: <xms:GYZ7aj_8qJvS6ypRzbPGmPnslJVxKhijAVmf0d5P4kRQXhU4wRtGVA>
 <xme:GYZ7akDsP-OaH0fqunQrzWvxNCo7vSHaPh3Z6qLLpXRfrwXZ57RrnnnqWSJ7hS4a-
 4bPy9yL8f_606Tb3ERYYECbv_n8X1oHIR3y5VqiQm1rw7BKMPnhmKk>
X-ME-Received: <xmr:GYZ7agLKDVfjon3UXvCSHV3nU_TKf0SO9QmGwQ0aTr7O1tDLtBemn3W9xxfcF1xMIkYSmw>
X-ME-Proxy-Cause: dmFkZTGjUGzLRt9YOoIfVi9vPX4yoGfoQnYyxR7IFQ4SHcUvWhFxNxXT+GkVoSD19/bXmw
 5O0Dyhzj2TyuOUX2bOaNZB7fqiHT0plD60kpacmEnpmm5gjeTuCdiB89Yazs98ranQOjBt
 U4o8Tp5bbODctlmHPXYLemU9KRN/H6Li7+dPxsfPbEiBrAz9mA4XvNPpGZ9No+DagwB+N1
 YzKMKPzFso3cdSigp6m6M9+1vJYtDqlQXrH5OHR/CQAzCe2merT6sXC9xj72kULZACCp3C
 G9L6chff/RsqzyCr6zon9p1XbCcRVNTGOc+FJvUgzFUv+iha+vYj5IAeOLh1NzQB62UCQV
 WXmcqQLp2RGna9wT4vf14ukFK/c9mDHkx780NfeJQd8tQAC1mOpvLeDGiimBtdt3hKuaG9
 4NMbchePm3LrnKzS3/AKDPfciCzsDyJ3UVARTfb+1qhILijvyBNnHHeUEs/zW+pXE0Xnfj
 AuAELPcVi+g39dtvCCP6wAX35PXz8v1mE5sVm5qgRiwoBuXT3A8fQ8z7oShuWgt/ti0GBy
 Pc2bQziyPV7aM6I2w6RJZTXDZTmHEvj17x9G3QX6GxO9KL+u0tB2iQmKEO57PYqlD+XeQa
 +LQ/WjMbrgWCMJEJlKwB1B1REzNTcUZ7Cj0Cmo3NeKmyFABVt0ZySc2NfCAA
X-ME-Proxy: <xmx:GYZ7annGBhxYG4VHLhcvLlco6dar3lQH5TrUlEiufsPnqp9QwHy6jw>
 <xmx:GYZ7auE_PR-VihZs2U6npCa7voGZos41O7c03q4f6WCtSvnZ-RhyVA>
 <xmx:GYZ7anHcrj4XYcflAlKND1z2m-dkbSP5WubwfDvuoWBAJLnSsqWdRA>
 <xmx:GYZ7arPdDmtHWF8BX3RQjUCumboERzjfajVj2vTBSXpz2PsG_w8ykQ>
 <xmx:GYZ7alCeBMimyjrYmB0H15A-fDePBoMl7kXnKpPLWQj7fgMuyoPNWU8J>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:29:13 -0400 (EDT)
Message-ID: <6f24bad0457c91714cc0fb1cab307037c4dd5567.camel@alistair23.me>
Subject: Re: [PATCH 38/56] disas/riscv: Simplify some insn decompressions
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:29:13 +1000
In-Reply-To: <20260809223545.730664-39-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-39-richard.henderson@linaro.org>
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
> Route "c.j" to "j" instead of "jal", etc.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 10 +++++-----
> =C2=A01 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index fc821355fe..9a528803e8 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1848,15 +1848,15 @@ static const rv_opcode_data rvi_opcode_data[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and) =
},
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw=
) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw=
) },
> -=C2=A0=C2=A0=C2=A0 { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_jal) },
> -=C2=A0=C2=A0=C2=A0 { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beq) },
> -=C2=A0=C2=A0=C2=A0 { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bne) },
> +=C2=A0=C2=A0=C2=A0 { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_j) },
> +=C2=A0=C2=A0=C2=A0 { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beqz) },
> +=C2=A0=C2=A0=C2=A0 { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bnez) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_=
slli) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_o=
p_fld) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op=
_lw) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_o=
p_flw) },
> -=C2=A0=C2=A0=C2=A0 { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jalr) },
> -=C2=A0=C2=A0=C2=A0 { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_addi) },
> +=C2=A0=C2=A0=C2=A0 { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jr) },
> +=C2=A0=C2=A0=C2=A0 { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_mv) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.ebreak", rv_codec_ci_none, NULL, DECOMP(rv_=
op_ebreak) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op=
_jalr) },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add) =
},

