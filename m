Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F81C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtt07-0002sz-UG; Tue, 11 Aug 2026 16:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt05-0002sh-Sa; Tue, 11 Aug 2026 16:23:05 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt04-0004Bp-AY; Tue, 11 Aug 2026 16:23:05 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 93A7B14000B8;
 Tue, 11 Aug 2026 16:23:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 16:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479783; x=1786566183; bh=ke0S2K30SunoZQf+EvRHqCSJlMczgEoo
 QJKm1mnVrM4=; b=V3Z5Ygtxy7MCEWSxqeMU80sWazdlmHOnIGOScHVVuu1sZUSS
 DmNnRQW2jlARWg9N8QqhkaNDsQbqJG74V3vbeVOy388m9BqGtYUeLxgn2YUb+PI+
 2zAPUSxzkfwPVlw25AqhLt2ESCdXGjywVlGX4VzP65BLJELljWZFWGKsFJaxRO2r
 f2ncfVZRl5/Cg6qQPg4D6/E+Z0NqsFOD8MXFffqiyVuUAH3vdnHwuZzlYBH/lZbr
 tPYzNUDt1SKgliUZ5sVWugvH9+nS39kmuaB7YUF9QQBuTNnnoBK9AN12H2av9vTm
 HiKnnc/NfnSTICsoOjeW+Fw3lsR6FQCvkWWjkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479783; x=
 1786566183; bh=ke0S2K30SunoZQf+EvRHqCSJlMczgEooQJKm1mnVrM4=; b=H
 /+aK0+a3zcaml6QI0zV54xATJ6RoBuTq0jG0nCaTtsRJtzvV9rWP3SCAw3dQQbWp
 vI0ILXcpNSp3G+oSdeGT5S/CsgosL90qVpo/09c5OTLhRxEaORtL+ZELok8hL9TM
 cxXdMOv6YdhQg57X5Qr8v56IyC8KCHfpLlwdydu/oE9/dr8PO4nJxq2Ei+oIqTpG
 lMDCvCC67h6hXL47v+Tx/GyTE0m7njtxq9njrVQHJNwGK1vgrEhJMdOdCdQnL6I9
 d1pve5LAuSJJmlmBaIqcKMjLfRMxyOR4rq1fOnoYOVpqPJadd1MC2UVaQwsu2xle
 3UwREoUJFgTg1+XARZO7Q==
X-ME-Sender: <xms:p4R7aszgVKfKafCwR9EzHTh90GzdQoxeKXSqVi3nHJ2hpGMwuw7xaQ>
 <xme:p4R7aknqwkKEYmT_EbFsmB0R9FCHf_-FrxJMqFBKx0ECogJZ2U4CnBZbV0cuv3iCX
 v-wv-krphohwX_elqiiE1ki5H2u5zTPzvQrMruiI2vOM-J1pKrU6Q>
X-ME-Received: <xmr:p4R7atcJXLArqml2Dk9Cq00ndsbXJOcPgn632B5NgLD_HEWt--EQLKa7VBIxAGLMrxKcmA>
X-ME-Proxy-Cause: dmFkZTEe44bzU318ZKGPPkmI//vzCNdVcYTYrqRtyU+DALhpzqDIrDJwcBKSHZMm4wnCMf
 9PUVrK5o6AhiUSiuSHL+1pFOddNIyiumPnXWByRYWCiPKoMD7LpIxSXTPbQLcCCeUi2Ayl
 lZhv0amE+njS/NQ6fBOmBDx+m0qvsBnHoW/t9sg/Z1H8bHw4jmKj5CgcDmj+xNoBXMcCsB
 VunOEWHMKShnBk/h7Ljnrzisg4XMruYntxk0fJHDFNQ4GaUuSnP7WZIf61sh4YmvNs4ksS
 qLV4eLP9GUxwdWyxSb7FXaax/mli1hOteEtTMY4L052hQLPg6p0x5fRGFTYIR45pG4W+Xb
 YrOxKMSxvYbF8wARLFHIVH3zN3NlaaqYl31Y9lCkrE1G5gtrT9IUv2aCAtNKlxPZGCXkq2
 u+cAmuoCuNJx4joCGwyWjB9y0kxGQ9aeRj4d1J8Gc0BzEuNS1rfMhj+p3EVO2+d/oJ/FZ/
 KR1FTB1BHT/p5aor9sB7peK62uzmdLuxK0LMvf7W1o/7v0PGIcXnIBJcytoW+1Whjasa7r
 ag1FgWMmA49NVUgWL+N9FV1iKmj9bppQcAv1ouW/lhDfvusf3UEVm7OuRyqq3UIlBTjiDp
 DjI61FTNN5U9pS+GnzJdmE5MMXneJHgg2vgXXUrRMiFZD83NAAlqKj5zmvxw
X-ME-Proxy: <xmx:p4R7aipSDf4z17-2v_QQujiRTgozj3qVn-lcFehVH8G_6NU870enxw>
 <xmx:p4R7aj7As4KFFmN1kKt2UkvU110FAi5rfEt1f8PSnTFELQd3bzJ8Dw>
 <xmx:p4R7agoSMwvabLKRsLKfgZA7Ck16TzIAViChX5Klmx6_4BlrXeYDdQ>
 <xmx:p4R7atgljV55iLm6p3GQ-YXyDexa0-R_k-TWCS30tkJQQG47fyikPQ>
 <xmx:p4R7ahG9gAA-wBOE_Tm1WtqU1aYZUw4pM1o2XTF7CvZBYVl2hmve1y1D>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:23:03 -0400 (EDT)
Message-ID: <b0d8328b32d9c2723ec11026fdbe21318d092d02.camel@alistair23.me>
Subject: Re: [PATCH 30/56] disas/riscv: Break pseudo loop for jal and jalr
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:23:03 +1000
In-Reply-To: <20260809223545.730664-31-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-31-richard.henderson@linaro.org>
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
> These were clearly intending to simplify
> 	jal	ra, foo
> to
> 	jal	foo
> and similarly for jalr, but the pseudo expansion looped
> back to the original jal/jalr with the full format.
>=20
> Add new opcode expansions dropping the implied ra.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 16 +++++++++-------
> =C2=A01 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index d3cbfb86ac..fe503b6cae 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -326,6 +326,8 @@ typedef enum {
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_bgez =3D 295,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_bltz =3D 296,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_bgtz =3D 297,
> +=C2=A0=C2=A0=C2=A0 rv_op_jal_ra =3D 298,
> +=C2=A0=C2=A0=C2=A0 rv_op_jalr_ra =3D 299,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_j =3D 302,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_ret =3D 303,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_jr =3D 304,
> @@ -1029,9 +1031,9 @@ static const char rv_fli_name_const[32][9] =3D
> =C2=A0
> =C2=A0/* pseudo-instruction constraints */
> =C2=A0
> -static const rvc_constraint rvcc_jal[] =3D { rvc_rd_eq_ra, rvc_end };
> -static const rvc_constraint rvcc_jalr[] =3D { rvc_rd_eq_ra,
> rvc_imm_eq_zero,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rvc_end };
> +static const rvc_constraint rvcc_jal_ra[] =3D { rvc_rd_eq_ra, rvc_end
> };
> +static const rvc_constraint rvcc_jalr_ra[] =3D { rvc_rd_eq_ra,
> rvc_imm_eq_zero,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rvc_end };
> =C2=A0static const rvc_constraint rvcc_nop[] =3D { rvc_rd_eq_x0,
> rvc_rs1_eq_x0,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rvc_imm_eq_zero, rvc_end
> };
> =C2=A0static const rvc_constraint rvcc_mv[] =3D { rvc_imm_eq_zero, rvc_en=
d
> };
> @@ -1068,14 +1070,14 @@ static const rvc_constraint rvcc_jr[] =3D {
> rvc_rd_eq_x0, rvc_imm_eq_zero,
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_jal[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_j, rvcc_j },
> -=C2=A0=C2=A0=C2=A0 { rv_op_jal, rvcc_jal },
> +=C2=A0=C2=A0=C2=A0 { rv_op_jal_ra, rvcc_jal_ra },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_jalr[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_ret, rvcc_ret },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_jr, rvcc_jr },
> -=C2=A0=C2=A0=C2=A0 { rv_op_jalr, rvcc_jalr },
> +=C2=A0=C2=A0=C2=A0 { rv_op_jalr_ra, rvcc_jalr_ra },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_illegal, NULL }
> =C2=A0};
> =C2=A0
> @@ -1884,8 +1886,8 @@ static const rv_opcode_data rvi_opcode_data[] =3D
> {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "bgez", rv_codec_sb, rv_fmt_rs1_offset },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "bltz", rv_codec_sb, rv_fmt_rs1_offset },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "bgtz", rv_codec_sb, rv_fmt_rs2_offset },
> -=C2=A0=C2=A0=C2=A0 { },
> -=C2=A0=C2=A0=C2=A0 { },
> +=C2=A0=C2=A0=C2=A0 { "jal", rv_codec_none, rv_fmt_offset }, /* rv_op_jal=
_ra */
> +=C2=A0=C2=A0=C2=A0 { "jalr", rv_codec_none, rv_fmt_rs1 }, /* rv_op_jalr_=
ra */
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "j", rv_codec_uj, rv_fmt_offset },

