Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC97C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8QE-00005V-4s; Wed, 12 Aug 2026 08:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8QC-0008VD-5g; Wed, 12 Aug 2026 08:51:04 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8Q9-00010e-FN; Wed, 12 Aug 2026 08:51:03 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 376DEEC01ED;
 Wed, 12 Aug 2026 08:50:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 08:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786539057; x=1786625457; bh=Ong4D2NWyGJa2MjofI7aKvRzhuNzzdqe
 5ZzWgiCUlE4=; b=MzY4np/MbOZUT1Q4u8DlnnJq5duIXkHxicnUcPtQOHx4i7Rx
 fq1JH87IQYGcResX/dO/HQdOOIJkmRfMwmTkZStCpp9QFsvwsDuhA2rGXfkL7s/d
 44BZO1VQduUGCp6zurXNn2ichvrlf+kxQnC2hxVATOu7R+8QmbeDOgZHoRoI6LU7
 /ztHAIr0quGnsPr6iYTO2va6bw3R10vMk76/gb0zzm7gVMdC4qpylFdiviG/GCnH
 Uv+nWbTKm+TyXacITFEuCdlVjB/hQLcr5QK0+R5F4HXqo6pUfVJ3Kg6UAqzopwiz
 E6pbeGWAfNuIzNp9lfNpHYxTZsGNY3Nqerh65Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786539057; x=
 1786625457; bh=Ong4D2NWyGJa2MjofI7aKvRzhuNzzdqe5ZzWgiCUlE4=; b=X
 Aue1yKN5DYTXKzvVrmu4Al7PMjfs/8cOJLfpRizM7tWaFV6Ym4U+fB8mrM/O+IV9
 //qXhq0IFlQBIAnRxvr25mF8CkoeLf7Bu93y69ZH6yJ7WD1cQqkq6S6OR5JcGfvf
 uwmI5MfKecNyXtfePlKvZ+Yxf58k6vOd1Lcb0EMGuSv1iHVq/VUGm78Cjk5ZXIFQ
 eMjTbSGgQ4kvAGFCnxRrx6Gl5OjFiH8AfQQ/8zVHQ4cYS0VpHG1hE2SXVBxW2eZ+
 MlhrjVd9X8ADcUdNmsMY9LfFfiIaX11laqrcNdV4ur1XRi+P7VPp79CWlxe+XXIx
 6sSt1vzbig25kmI5R7JMg==
X-ME-Sender: <xms:MWx8atiwQJTFRODdZcocTSW88fhSnk1g6p2GpzJJ6zqh1ALfx2tSiw>
 <xme:MWx8aiLdHqB6hj6VIkWBFFdbAuUFk129c_skmWGjPi3FVuYoUqJtNz9FzAoIPdF2i
 YK9J6GS-S7fLqdOLTfkU87OeVYYeEwdcsFa3VlVcLejTndAO2LDmdW9>
X-ME-Received: <xmr:MWx8alC9-6zGmqEZVwVQwAxa8FsrwysB88JiPiWUymLZwnu1iIKkvUECDk9oJng0HQgRYg>
X-ME-Proxy-Cause: dmFkZTE2elvziyd9WUgbaOUmNMom465/J0MimGPvt4pN1S+QK8bubjtU/aNKa6zQYXMfv4
 GMV7jxszaU0z+fhKkCNYuefptoWd9AUiRC4zXw2HhKtLj+rMxoGqs8+21s++e2I74PdlIz
 8C9xJOfBbpxQbwkbSN4BJFFQOJTEeEUHHB1H3NKi9kejIrn6wwkuIuRloKO2IDvb4Jioaa
 10U+ko4WO5sidUiP+1ltDK/eWDuA/mZe4elfZB3j7qwqbmgkSHrgeDf6L3bM/bVBXIBG+v
 Av4385bG2taPn7mYbu+c2IesDhtZd1zRGyTOFPeFqSLQaiscI8kR+ZlIs7kl5ORC9D8WbI
 3HF6VZPBKVRZtqv3K6ua+5gtAmvqtizgji/R5kfSp3HDFYjfuX0vi5NcaCPaXVdPSURtk8
 3b8fk8CDe7OOo0CwXaYGR9lkqMhiPa+en0chhUqwmVSJYx1dakNq/ijUz3w+yAF0PbwWVX
 0VVRsH/89laNsf1ezyrzqRw8rxnDoKohUEWmmxCP11S+b5/zuysiPgSlCnnk6FMQgGvQd9
 iKcvkV/LdnICzHfZmH2fB+Iz5ppg2GtDQtTrkEjy/GLTX38Ppj0MYDX92gb2wSTpMg1hxN
 vvwE1RkcUUEDsZilinem3kokHs4W9u+WzePrAUO+yjoBg7cU2/JPT7zw/V1A
X-ME-Proxy: <xmx:MWx8aqg7NByhWzhE5l1LBdWVtlObHZDjDnqxXMgdm1Kt5i0IGpbrEg>
 <xmx:MWx8allkoAyqeQKpqPn-EJsOtWJkZ4n1XOdMc02Sm9Gc1HMl3ISxow>
 <xmx:MWx8auq9ngOrt6wbV6oUaA7YqTEWMZpdHlb_8C9DdJ6el8frd5G0oA>
 <xmx:MWx8amFOMNZR5YUxzYrh_9Cu88V9ernF99VzHavwfWFiogAD8xCf5w>
 <xmx:MWx8al48IYVzpGY-h5cMtmMyoDlSCYB-c0dmnxtLMZ2W_kJ4YrtyqcBf>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:50:56 -0400 (EDT)
Message-ID: <9c263d50b8aca6a7522d2a53282dce1463786d57.camel@alistair23.me>
Subject: Re: [PATCH 44/56] disas/riscv: Fix typo in th.lbib format
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-stable@nongnu.org
Date: Wed, 12 Aug 2026 22:50:56 +1000
In-Reply-To: <20260809223545.730664-45-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-45-richard.henderson@linaro.org>
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

On Sun, 2026-08-09 at 15:35 -0700, Richard Henderson wrote:
> th.lbib should format the same as th.lbia, and the other
> increment insns, with the address register in parenthesis.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 318df7238b9 ("disas/riscv: Add support for XThead*
> instructions")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv-xthead.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
> index 428a6380e9..fbc96631fd 100644
> --- a/disas/riscv-xthead.c
> +++ b/disas/riscv-xthead.c
> @@ -189,7 +189,7 @@ static const rv_opcode_data xthead_opcode_data[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "th.mulsh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> =C2=A0=C2=A0=C2=A0=C2=A0 /* XTheadMemIdx */
> =C2=A0=C2=A0=C2=A0=C2=A0 { "th.lbia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs=
1_immh_imml_addr
> },
> -=C2=A0=C2=A0=C2=A0 { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml },
> +=C2=A0=C2=A0=C2=A0 { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_imm=
h_imml_addr
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "th.lbuia", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "th.lbuib", rv_codec_r2_imm2_imm5,
> rv_fmt_rd_rs1_immh_imml_addr },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "th.lhia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs=
1_immh_imml_addr
> },

