Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C554FC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsx1-0000WA-Ii; Tue, 11 Aug 2026 16:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtswz-0000Vi-Q5; Tue, 11 Aug 2026 16:19:53 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtswy-0003qz-7D; Tue, 11 Aug 2026 16:19:53 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0C81F1400030;
 Tue, 11 Aug 2026 16:19:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 11 Aug 2026 16:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479591; x=1786565991; bh=5lMphWgv8RgBsL+xeg+AjDxl7caZrxiy
 w+2DYy9gefA=; b=Hr2auEZo/3pYgxxdcD8UcJeeEJ1tvD/n6hLkAJoxg6Avwguj
 mndQJ/I4hhv6FIj29mEUumDvajsU5y+Gk0iVi+cQUyGp2i6mJSeX1e33RziMMfPs
 Kg0qpGliUXls+LdwFUUp1TkxV6iJ9DMy4mhquobnjXi7OthPxPNuNivTRiSwkCRq
 Kcn2NuV3C5Pi18hfuR5CwQjuaTX33UZlQf6C6ovrcuyKyEWLu3bPQaEP4wfbOW7H
 wDsjQtI117ePD2D7ZJGEjd2sXydNlVxfm6leeeiygznRPusz77SHQ5Ro2Ha8cfv1
 n6nEb3Al9H9N89Z+rP/dDm2EL8Tf0CZB5aIEoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479591; x=
 1786565991; bh=5lMphWgv8RgBsL+xeg+AjDxl7caZrxiyw+2DYy9gefA=; b=I
 XxJHngCvmQSoKaxXZ7RtJylPq6fAaMW874v1eOfE6GmsICpi5aprl3t553tw6zaK
 UzzvIFmH6AzRL4YQkJv4wzVrUP+f5eWkfDtnXWb/j1+Cz8t/Et0CzB9nC8BvMR3l
 +gCkXADYTSEGe0e/zoEBvB5MkNd88AfI9XUn7OU0YoWGUQknVzEjfLDv8cmGBAd1
 lGArhpfobMIT+UgNqPK4+V3vWLHNbs5kzsGB61z4U71kecitx0DO9uwfzTkcdocM
 i8o11Fm4SijOzeSTJTRe7rThUyUTCo8JMrD5P8+jCQiCklKis31XZfo9XZL8C5FZ
 sEJZkA6L5kNn1Ml16FKWA==
X-ME-Sender: <xms:5oN7aoTIlF7hPRafWib7_8UbqtJhF7Xj15UV-dyXB7QHSxO-EIPKxQ>
 <xme:5oN7aqHjx-BwwiLakCw8QNwZOwD3TzPz5qKpon3xV-IGmfKkHeolTv0KIxHdfiefa
 JOBvoRuwPbdIVJQUhcnBp5SPQb9J6r6kHPhPhzwW_7-CzSj5zXBOA>
X-ME-Received: <xmr:5oN7ak9En51SJBMZxheLQHgTaMeZ9XEyL82KBBDxnK4S0YqFZhR9LXg8w2PaDfLsXBY3FA>
X-ME-Proxy-Cause: dmFkZTEEByZQdtsPsbAxpxfho6kRbmIwIV64yq0RrdqCLWkSKGrCCAvive1S9WyYkFGSW1
 VMqPhNi5VEOc7GP30HXuel9BM7TGVhI49S1qFeYJ6CJENAalGAxqbT8m97hmVu+bFtiAZ5
 ajjrsvzZtyDB59o1wn/kn2cicNrppL0l9Xp93uTdl4fdGXAIYu3xCjjTmADxGveoStNPCg
 KByRSRDOZ+7+DMrZO5y9CttoczNzyLlSAQ00pJGxNW72nqS7Nadc9bpeOFmsvPIKn5CaFR
 WAyFsBdLzNHJ/a5KlM/a12ftyT5IVaOxuaXFX/ePiB/v02ymTBzYP20bSTdyaPz/WUfXHV
 N6pUFMHMM8h9CyrT2wPRCajO1/eZxAO8AYs5aXEKic3y9nkY08/Dd41d6v/Lp1VUN/zesx
 ih8HIxmngc2WMJSGmdjuFAEwF/sP86/eV06gOiRdXxuAZJvfYUhaHxFCPOrab4GHWMNIFr
 JleXWolf4n+krQFexkk0dqwYF+iFggzzhcx6r71ilevZVhqhcD8ntmYJuI1K3tQSuTMBiG
 5QR4MGGk3XSdz5CqaTdeGeLHi+9NlV4MTyPZDeLhjlMACscJc6x+4zX3fScS7JL50hqUwi
 n6HuI9mDiPkwVWENLsANHqZf6ROwGcfAfv8OmHVETrmxZms25IvGb/y0Q7tA
X-ME-Proxy: <xmx:5oN7akIH1WDDkW0jQcQgkY72a7pDK3jTqynCUn-GHRE3gjkTM5cs_Q>
 <xmx:54N7anZrj8BJW0C7IBj4JzNeNRgwD_zGUla5M5OWiZHps4z8zzWjDQ>
 <xmx:54N7auJILyXzxTAG4Gv4k8pj8_JjEUFNyEDB-lxf__Ewf-3SP5ei7Q>
 <xmx:54N7atCPVufQtZhfxL9nm1Ca11ug5dAXyZU5MZt_ERphCeUWgMYhcg>
 <xmx:54N7agXt9Z32P4VmwmRGRPlD5_Hbz54-lQciZpuNqSOxS6UvekaIB_0g>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:19:50 -0400 (EDT)
Message-ID: <4ff619bddb07f1db48a90983858565fcf6f5665e.camel@alistair23.me>
Subject: Re: [PATCH 26/56] disas/riscv: Drop always true branch psudeos
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:19:50 +1000
In-Reply-To: <20260809223545.730664-27-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-27-richard.henderson@linaro.org>
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

On Sun, 2026-08-09 at 15:35 -0700, Richard Henderson wrote:
> The real insns are blt, bge, bltu, bgeu.=C2=A0 Do not include
> psuedos that unconditionally swap operands.=C2=A0 That's fine
> for an assembler but not a disassembler.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 32 ++++++--------------------------
> =C2=A01 file changed, 6 insertions(+), 26 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 2e891f509e..bde1cc6e62 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -326,10 +326,6 @@ typedef enum {
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_bgez =3D 295,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_bltz =3D 296,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_bgtz =3D 297,
> -=C2=A0=C2=A0=C2=A0 rv_op_ble =3D 298,
> -=C2=A0=C2=A0=C2=A0 rv_op_bleu =3D 299,
> -=C2=A0=C2=A0=C2=A0 rv_op_bgt =3D 300,
> -=C2=A0=C2=A0=C2=A0 rv_op_bgtu =3D 301,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_j =3D 302,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_ret =3D 303,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_jr =3D 304,
> @@ -1062,10 +1058,6 @@ static const rvc_constraint rvcc_blez[] =3D {
> rvc_rs1_eq_x0, rvc_end };
> =C2=A0static const rvc_constraint rvcc_bgez[] =3D { rvc_rs2_eq_x0, rvc_en=
d
> };
> =C2=A0static const rvc_constraint rvcc_bltz[] =3D { rvc_rs2_eq_x0, rvc_en=
d
> };
> =C2=A0static const rvc_constraint rvcc_bgtz[] =3D { rvc_rs1_eq_x0, rvc_en=
d
> };
> -static const rvc_constraint rvcc_ble[] =3D { rvc_end };
> -static const rvc_constraint rvcc_bleu[] =3D { rvc_end };
> -static const rvc_constraint rvcc_bgt[] =3D { rvc_end };
> -static const rvc_constraint rvcc_bgtu[] =3D { rvc_end };
> =C2=A0static const rvc_constraint rvcc_j[] =3D { rvc_rd_eq_x0, rvc_end };
> =C2=A0static const rvc_constraint rvcc_ret[] =3D { rvc_rd_eq_x0,
> rvc_rs1_eq_ra,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rvc_end };
> @@ -1123,24 +1115,12 @@ static const rv_comp_data rvcp_bne[] =3D {
> =C2=A0static const rv_comp_data rvcp_blt[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_bltz, rvcc_bltz },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_bgtz, rvcc_bgtz },
> -=C2=A0=C2=A0=C2=A0 { rv_op_bgt, rvcc_bgt },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_bge[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_blez, rvcc_blez },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_bgez, rvcc_bgez },
> -=C2=A0=C2=A0=C2=A0 { rv_op_ble, rvcc_ble },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> -};
> -
> -static const rv_comp_data rvcp_bltu[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_bgtu, rvcc_bgtu },
> -=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> -};
> -
> -static const rv_comp_data rvcp_bgeu[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_bleu, rvcc_bleu },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> =C2=A0};
> =C2=A0
> @@ -1665,8 +1645,8 @@ static const rv_opcode_data rvi_opcode_data[] =3D
> {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "bne", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvc=
p_bne },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "blt", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvc=
p_blt },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "bge", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvc=
p_bge },
> -=C2=A0=C2=A0=C2=A0 { "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bl=
tu },
> -=C2=A0=C2=A0=C2=A0 { "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bg=
eu },
> +=C2=A0=C2=A0=C2=A0 { "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset },
> +=C2=A0=C2=A0=C2=A0 { "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "lb", rv_codec_i, rv_fmt_rd_offset_rs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "lh", rv_codec_i, rv_fmt_rd_offset_rs1 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "lw", rv_codec_i, rv_fmt_rd_offset_rs1 },
> @@ -1954,10 +1934,10 @@ static const rv_opcode_data rvi_opcode_data[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "bgez", rv_codec_sb, rv_fmt_rs1_offset },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "bltz", rv_codec_sb, rv_fmt_rs1_offset },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "bgtz", rv_codec_sb, rv_fmt_rs2_offset },
> -=C2=A0=C2=A0=C2=A0 { "ble", rv_codec_sb, rv_fmt_rs2_rs1_offset },
> -=C2=A0=C2=A0=C2=A0 { "bleu", rv_codec_sb, rv_fmt_rs2_rs1_offset },
> -=C2=A0=C2=A0=C2=A0 { "bgt", rv_codec_sb, rv_fmt_rs2_rs1_offset },
> -=C2=A0=C2=A0=C2=A0 { "bgtu", rv_codec_sb, rv_fmt_rs2_rs1_offset },
> +=C2=A0=C2=A0=C2=A0 { },
> +=C2=A0=C2=A0=C2=A0 { },
> +=C2=A0=C2=A0=C2=A0 { },
> +=C2=A0=C2=A0=C2=A0 { },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "j", rv_codec_uj, rv_fmt_offset },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "ret", rv_codec_i, rv_fmt_none },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "jr", rv_codec_i, rv_fmt_rs1 },

