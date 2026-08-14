Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DF2C5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutih-00065G-Jx; Fri, 14 Aug 2026 11:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wutif-00064h-Nf; Fri, 14 Aug 2026 11:21:17 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wutie-0003dQ-8f; Fri, 14 Aug 2026 11:21:17 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 13D1EEC01E1;
 Fri, 14 Aug 2026 11:21:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 14 Aug 2026 11:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786720875; x=1786807275; bh=mBUiGSn0upWmKzONd+0BsNt+Rt5jbWeL
 yX8PSaP2pmo=; b=P0w3jSKnhwS3aYROX7b+ManqU8Far4ZxFGhBe3MVhXYeDfZ7
 eCpI1kVC0cFsyWYRysXZVUomROzPW1NEmcM7veBSuHY28+PYXL7iLWpBaBDA2J2A
 SF3kI3kxCIII2YIcTrXNvGur3+IXX+icmOlAwY+K1xpPyOJLvad+BPVumaX+kCR6
 tTBTdcXfl2GXfsSDNAL82kIVS21dsNOvXDzVYOuu9SMIJ/cICrBntYodUhUZPpKJ
 g7EvHHz6ngauioTEGfebbU0J+cShJVDFYFW59IqcMdIewdT9WWH7LP2jMDEGCAZe
 smD1Wwz4MP1fnp7oWQ7Agp/qPm114odel9OJ3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786720875; x=
 1786807275; bh=mBUiGSn0upWmKzONd+0BsNt+Rt5jbWeLyX8PSaP2pmo=; b=Y
 Mf0UvptVn0aJ1YJTSaxkO9AzHqL0k6SKdRNmzkfRqUbOrQPClRu6UBKtmFBLRUGD
 3eAuxOPHwCB3Nzhy/Unr6S+En8aTh26IMIoAqQVT2NX+sCpOOEnwh8EpDL40sBDv
 jk8am9IM7g3dv9zNUfc/8Uo6l0I+8WQxe64fyIn/hAf6esA0MMpw9Mluy91M2Ox0
 GfG9xW3wiafwN7nufVV55IWpgnXQ5ovrcAc/ABCv2ZnLN5UA1yOtehxSO6Hh+cPy
 oXINY6Kx8O6qBH0PzJAu6HLYjDnetFP6jS0tJz3qC22gs1Tk5dmxNTT1WlA9ahRS
 RG400tRIYh99Nwd4rVQJw==
X-ME-Sender: <xms:ajJ_ah2ILOFXa20WfUeAwtncYkwqlqAkn46KYa281DQFMqHpg9Qteg>
 <xme:ajJ_aoODjY2UuODtAT2csdBw_LN91UuTGE1jHS_gicpka2WYn3pxQr5ANV8UvCpIc
 zjkcB3t-E_B82YUu6a30DuUzs-I9bm1AYyDoii3aIpYRLoWRgVy>
X-ME-Received: <xmr:ajJ_ap26_63sbdbEDGLz5nDYVMVOFAqiEQQIBpH7oo2JxlWOcvm8UIXunOxaiALqEwhhUA>
X-ME-Proxy-Cause: dmFkZTGrlzGbxj4AdusKlxs6uD0gJ03aCLgpyapxcNs4iGe4MWqrMAC1exCHZsMzw5Gqck
 hlgSxQRqvrs6g9eggc2BBQrGRttimZ1jUP1JmWnGE8+2WRhk6Dj41fliXLxc056nlfaSLX
 b2m0km5XjDL2Vzu+OTWB9AFOlw1enZVRB7I85737kkEOC41Rm5tBH4ULitoaKDmrsXqLDm
 Sx8Dley5MBrvKa+SAuL2K67vmTFUTdwDhj+R/FMKpmw/4KnZWISQc15+HWmUNPWhiI6QkW
 8iDNNiFlp23GomAPTAW9/Q8IJ064uM3akyQDGB6UKPHR2S7nrNoS3EnjGm2THe+7S9ucjl
 19rEsi7rB79VqNUPgl6HJ2A7Zn7T76cVqFx15ysmlxjcZOrXfUB0b9Qd5VLfPLTZNrCcpH
 qJAmETpBjiM6C7kErMQCp55rLU+AXY7MnuoNPsCzKcTx3VjiLrhx0/uHlIKybC3P/mfT+R
 XGNk+G3RwJIqX1RZ/7c+oDhHQ06FBMkdfOLJnPD8CT99MwfUv5ZoPOzgFzADa5CiTFT9uK
 1cdZgIh1m8VFYMRNupmI60TSLGeTeDzOPE6wj9M2SvV4lnZJQ0bHZKJ8bTqmkCxOwE4lzd
 e7ymSL/eiPl3JU1O5IU589A04Vdl8io9OUlzUtSk6z9YIDmOrpQqxA3TaxrQ
X-ME-Proxy: <xmx:ajJ_anFDdmlT2GnAamZcT-w4b0D5KF6s9mcL6Ch1eAnnj_WQSmKL3g>
 <xmx:ajJ_au5KCMD8iuc_5YM7YVrnw42r5YTuNndtcg5B3LIbP1St6_i-jQ>
 <xmx:ajJ_alvJYYcRWN5_QSF3sYx1IaEP1IAYx_gZEHdeKVmDOLyL2Knm-g>
 <xmx:ajJ_an6zr7Zo__gFvMEvTgcJ8IpVRN3DFwP6h2rJ0UUni0bQ5RurPw>
 <xmx:azJ_asevK1NQFzRgp7SWaJ68Ru7ha3xzkqeRfyianCMq4tBeYGQaYQFR>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 11:21:14 -0400 (EDT)
Message-ID: <aa75ae349c5c92d1f232dc85989f1ce563b216c8.camel@alistair23.me>
Subject: Re: [PATCH v2 36/52] disas/riscv: Skip post-processing of illegal
 insns
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com
Date: Sat, 15 Aug 2026 01:21:14 +1000
In-Reply-To: <20260812223142.349142-37-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
 <20260812223142.349142-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=alistair@alistair23.me; helo=fout-a2-smtp.messagingengine.com
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

On Wed, 2026-08-12 at 15:31 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 8 +++++---
> =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index bc86cb866a..75c2fa11e6 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -5321,12 +5321,14 @@ static GString *disasm_inst(rv_isa isa,
> uint64_t pc, rv_inst inst,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 if (!op) {
> +
> +=C2=A0=C2=A0=C2=A0 if (op) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decode_inst_operands(&dec, is=
a, op);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D decode_inst_lift_pseud=
o(&dec, op);
> +=C2=A0=C2=A0=C2=A0 } else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D &rvi_opcode_data[=
rv_op_illegal];
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 decode_inst_operands(&dec, isa, op);
> -=C2=A0=C2=A0=C2=A0 op =3D decode_inst_lift_pseudo(&dec, op);
> =C2=A0=C2=A0=C2=A0=C2=A0 return format_inst(24, &dec, op);
> =C2=A0}
> =C2=A0

