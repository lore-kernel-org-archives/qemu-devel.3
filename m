Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF65C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8Nr-00068A-V8; Wed, 12 Aug 2026 08:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8Nq-00067c-Kr; Wed, 12 Aug 2026 08:48:38 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8No-000059-3b; Wed, 12 Aug 2026 08:48:38 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 76BD9EC01ED;
 Wed, 12 Aug 2026 08:48:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 08:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786538913; x=1786625313; bh=CtgFoGpoj9lx449O7X1m0IMJPkPPIi9m
 8EXsCbhqCMk=; b=Mc0+h9/nNASbWhfLY/arYiBdSm/mvepbrImpqK+W5G7NFjhF
 ZxkFuu7SgSOWaSPc0boIygDEQoNU9bMFlQiXao/MHKl2jWSyC0f2Y7/0BmTGcTM2
 hfEnOLFU8yReZe0OwRAa3S5TttCUeIRVBMpk6u2/GixSoKIrbLO7kKGqZnuFWlXF
 vUF21JsXt/NqDzI1LCcgb4xuVwjf2HEv/KTQmRTswt+jyDshebG1JnwjPlG4q3LG
 wvBdWRkIueUK/v2jvLsFLLcfGBWj1K7ZZ591qB6QKTn70oCsCvVSpPaTQLDfL7ke
 g0zzEblsU929fDDgRfIV1PLZAgplZam1Do4sZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786538913; x=
 1786625313; bh=CtgFoGpoj9lx449O7X1m0IMJPkPPIi9m8EXsCbhqCMk=; b=I
 FA8lUYfB/2Z3D9IztcBPbwaLH3c8thjedrG3C5HsYk7a6VXp5IImYCqfmm8hLtpT
 hzPUwYrfxokbBm4Hegjuss4IYrw0oyiXExBifCD3t0CxO2226OluV8xoKyHheDSN
 06idmh3KKrYtTOsYEJt0HzJ62a607oGdfbaBMJwp2ZVXf5T1jtBPdbBuUZNe6Iuq
 zngKETW0c/+b3k8w1AgCB9KWds46jWUfPlYZRRehykaCQJ9ap6MGRiXfrr8cK8PL
 1/rCQjjDlYyii7+L7sQvuDKSVkLLi3COaefYUo2znhgul37SXQVNc+ozYDZrLbwx
 ku2jZCB7R8UnFV9MpciDg==
X-ME-Sender: <xms:oWt8ahQ4ldxKIRDQ4AJh8WVDahMEc3E7mEcml750ziPDU6KIjo8FwQ>
 <xme:oWt8avHD8qMmbDY0OTD1CTn-7kWWc78-_yGkxzQIaksjWDLFyc6iwjQMGCUJBfr9n
 -TRGFJuP9cszKs79GizhROXiyGLrsZbfPVLW3-kDEjn8_d7JQWnc5k>
X-ME-Received: <xmr:oWt8al-mKGbARBQJevNeXfYAzZNl22SFyxw5hTGpsky1Q7PQjkxZUGZeNYOE-QtkMoHw7g>
X-ME-Proxy-Cause: dmFkZTE2elvziyd9WUgbaOUmNMom465/J0MimGPvt4pN1S+QK8bubjtU/aNKa6zQYXMfv4
 GMV7jxszaU0z+fhKkCNYuefptoWd9AUiRC4zXw2HhKtLj+rMxoGqs8+21s++e2I74PdlIz
 8C9xJOfBbpxQbwkbSN4BJFFQOJTEeEUHHB1H3NKi9kejIrn6wwkuIuRloKO2IDvb4Jioaa
 10U+ko4WO5sidUiP+1ltDK/eWDuA/mZe4elfZB3j7qwqbmgkSHrgeDf6L3bM/bVBXIBG+v
 Av4385bG2taPn7mYbu+c2IesDhtZd1zRGyTOFPeFqSLQaiscI8kR+ZlIs7kl5ORC9D8WEo
 LJirxeNePy7TAruNmQ2iXce51NV18OlTph4YwKrW0d1kez/ulveZu8JzElNd3BrQ+ACBPc
 UCn67koHID9hwZr52qvFSdXmuXZixqDR/n7W9BUZTtfI+OQTgQu9QbCOc6HeVEbBDs1UUr
 DdSkM0qteM8rGlHz0ZSeB4Jt9zrID8UYZhz2Smz32UXuF+SWWOKBhcYXkgNHOuWLDGkiCa
 DyV7RSHZiP/NJxbMRjQGBqWnfgECOUm4BX/7YEetWRqmkU94aqvYVr+DL2SAtczCQt5jLF
 fTlBFh0YfpI/d4YA41WlhOUXy5dZbM67Je1eSMSgZ8ISZIH3evjCSOwZc+FQ
X-ME-Proxy: <xmx:oWt8ahIoLnjXW4Gzulm1rTuElVFoTmOIkvTf0xSGUBA4Wx57du3f4Q>
 <xmx:oWt8agZEvWR-AYHejYkBVzfOJozcJkb5WxkfzUYhc2N3ODafcP4XEg>
 <xmx:oWt8ajLeBcIPxtnFwhY077Y4uHH9E9VArN21BKpdSJvDMXzRtO1MeQ>
 <xmx:oWt8auACmn7besikTuhofJ5RPqagksgSFqT5bc04RdC-GdAlpF3AHw>
 <xmx:oWt8anmxdgl_vUXSbiQbvOvu4xhDECz0s7pfJKGHQ0Elcl_MrYlQsMYR>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:48:33 -0400 (EDT)
Message-ID: <50a0bdb0e9027f28695ca41d57e154a5ef07cd2b.camel@alistair23.me>
Subject: Re: [PATCH 40/56] disas/riscv: Return rv_opcode_data pointer from
 decoders
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 22:48:32 +1000
In-Reply-To: <20260809223545.730664-41-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-41-richard.henderson@linaro.org>
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
> Rather than putting array + index into rv_decode,
> return the pointer to the object directly.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv-xlrbr.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0disas/riscv-xthead.h=C2=A0=C2=A0 | 22 ++++++++---------
> =C2=A0disas/riscv-xventana.h |=C2=A0 2 +-
> =C2=A0disas/riscv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 2 --
> =C2=A0disas/riscv-xlrbr.c=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++--
> =C2=A0disas/riscv-xthead.c=C2=A0=C2=A0 | 55 +++++++++++++++++------------=
-----------
> --
> =C2=A0disas/riscv-xventana.c |=C2=A0 5 ++--
> =C2=A0disas/riscv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 23 +++++++-----------
> =C2=A08 files changed, 48 insertions(+), 68 deletions(-)
>=20
> diff --git a/disas/riscv-xlrbr.h b/disas/riscv-xlrbr.h
> index ebf3d4c133..da14f1b340 100644
> --- a/disas/riscv-xlrbr.h
> +++ b/disas/riscv-xlrbr.h
> @@ -12,6 +12,6 @@
> =C2=A0
> =C2=A0#include "disas/riscv.h"
> =C2=A0
> -void decode_xlrbr(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xlrbr(rv_decode *, rv_isa);
> =C2=A0
> =C2=A0#endif /* DISAS_RISCV_XLRBR_H */
> diff --git a/disas/riscv-xthead.h b/disas/riscv-xthead.h
> index 0c65c8e0af..f2160be8a4 100644
> --- a/disas/riscv-xthead.h
> +++ b/disas/riscv-xthead.h
> @@ -11,16 +11,16 @@
> =C2=A0
> =C2=A0#include "disas/riscv.h"
> =C2=A0
> -void decode_xtheadba(rv_decode *, rv_isa);
> -void decode_xtheadbb(rv_decode *, rv_isa);
> -void decode_xtheadbs(rv_decode *, rv_isa);
> -void decode_xtheadcmo(rv_decode *, rv_isa);
> -void decode_xtheadcondmov(rv_decode *, rv_isa);
> -void decode_xtheadfmemidx(rv_decode *, rv_isa);
> -void decode_xtheadfmv(rv_decode *, rv_isa);
> -void decode_xtheadmac(rv_decode *, rv_isa);
> -void decode_xtheadmemidx(rv_decode *, rv_isa);
> -void decode_xtheadmempair(rv_decode *, rv_isa);
> -void decode_xtheadsync(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xtheadba(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xtheadbb(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xtheadbs(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xtheadcmo(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xtheadcondmov(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xtheadfmemidx(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xtheadfmv(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xtheadmac(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xtheadmemidx(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xtheadmempair(rv_decode *, rv_isa);
> +const rv_opcode_data *decode_xtheadsync(rv_decode *, rv_isa);
> =C2=A0
> =C2=A0#endif /* DISAS_RISCV_XTHEAD_H */
> diff --git a/disas/riscv-xventana.h b/disas/riscv-xventana.h
> index 1006c3be00..d28e84c7e4 100644
> --- a/disas/riscv-xventana.h
> +++ b/disas/riscv-xventana.h
> @@ -11,6 +11,6 @@
> =C2=A0
> =C2=A0#include "disas/riscv.h"
> =C2=A0
> -void decode_xventanacondops(rv_decode*, rv_isa);
> +const rv_opcode_data *decode_xventanacondops(rv_decode*, rv_isa);
> =C2=A0
> =C2=A0#endif /* DISAS_RISCV_XVENTANA_H */
> diff --git a/disas/riscv.h b/disas/riscv.h
> index ab62c0db94..241dd47d7f 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -182,10 +182,8 @@ typedef struct {
> =C2=A0=C2=A0=C2=A0=C2=A0 const RISCVCPUConfig *cfg;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0 pc;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0 inst;
> -=C2=A0=C2=A0=C2=A0 const rv_opcode_data *opcode_data;
> =C2=A0=C2=A0=C2=A0=C2=A0 int32_t=C2=A0=C2=A0 imm;
> =C2=A0=C2=A0=C2=A0=C2=A0 int32_t=C2=A0=C2=A0 imm1;
> -=C2=A0=C2=A0=C2=A0 uint16_t=C2=A0 op;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0 rd;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0 rs1;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0 rs2;
> diff --git a/disas/riscv-xlrbr.c b/disas/riscv-xlrbr.c
> index d0092e9edd..b12916c9da 100644
> --- a/disas/riscv-xlrbr.c
> +++ b/disas/riscv-xlrbr.c
> @@ -36,7 +36,7 @@ static const rv_opcode_data xlrbr_opcode_data[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "crc32c.d", rv_codec_r, rv_fmt_rd_rs1 },
> =C2=A0};
> =C2=A0
> -void decode_xlrbr(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xlrbr(rv_decode *dec, rv_isa isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -76,6 +76,5 @@ void decode_xlrbr(rv_decode *dec, rv_isa isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xlrbr_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xlrbr_opcode=
_data[op];
> =C2=A0}
> diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
> index 757d6ff39f..428a6380e9 100644
> --- a/disas/riscv-xthead.c
> +++ b/disas/riscv-xthead.c
> @@ -246,7 +246,7 @@ static const rv_opcode_data xthead_opcode_data[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "th.sync.s", rv_codec_none, rv_fmt_none },
> =C2=A0};
> =C2=A0
> -void decode_xtheadba(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xtheadba(rv_decode *dec, rv_isa isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -272,11 +272,10 @@ void decode_xtheadba(rv_decode *dec, rv_isa
> isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xthead_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xthead_opcod=
e_data[op];
> =C2=A0}
> =C2=A0
> -void decode_xtheadbb(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xtheadbb(rv_decode *dec, rv_isa isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -331,11 +330,10 @@ void decode_xtheadbb(rv_decode *dec, rv_isa
> isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xthead_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xthead_opcod=
e_data[op];
> =C2=A0}
> =C2=A0
> -void decode_xtheadbs(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xtheadbs(rv_decode *dec, rv_isa isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -358,11 +356,10 @@ void decode_xtheadbs(rv_decode *dec, rv_isa
> isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xthead_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xthead_opcod=
e_data[op];
> =C2=A0}
> =C2=A0
> -void decode_xtheadcmo(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xtheadcmo(rv_decode *dec, rv_isa isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -437,11 +434,10 @@ void decode_xtheadcmo(rv_decode *dec, rv_isa
> isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xthead_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xthead_opcod=
e_data[op];
> =C2=A0}
> =C2=A0
> -void decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xtheadcondmov(rv_decode *dec, rv_isa
> isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -465,11 +461,10 @@ void decode_xtheadcondmov(rv_decode *dec,
> rv_isa isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xthead_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xthead_opcod=
e_data[op];
> =C2=A0}
> =C2=A0
> -void decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xtheadfmemidx(rv_decode *dec, rv_isa
> isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -503,11 +498,10 @@ void decode_xtheadfmemidx(rv_decode *dec,
> rv_isa isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xthead_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xthead_opcod=
e_data[op];
> =C2=A0}
> =C2=A0
> -void decode_xtheadfmv(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xtheadfmv(rv_decode *dec, rv_isa isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -539,11 +533,10 @@ void decode_xtheadfmv(rv_decode *dec, rv_isa
> isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xthead_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xthead_opcod=
e_data[op];
> =C2=A0}
> =C2=A0
> -void decode_xtheadmac(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xtheadmac(rv_decode *dec, rv_isa isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -571,11 +564,10 @@ void decode_xtheadmac(rv_decode *dec, rv_isa
> isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xthead_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xthead_opcod=
e_data[op];
> =C2=A0}
> =C2=A0
> -void decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xtheadmemidx(rv_decode *dec, rv_isa
> isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -646,11 +638,10 @@ void decode_xtheadmemidx(rv_decode *dec, rv_isa
> isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xthead_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xthead_opcod=
e_data[op];
> =C2=A0}
> =C2=A0
> -void decode_xtheadmempair(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xtheadmempair(rv_decode *dec, rv_isa
> isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -681,11 +672,10 @@ void decode_xtheadmempair(rv_decode *dec,
> rv_isa isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xthead_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xthead_opcod=
e_data[op];
> =C2=A0}
> =C2=A0
> -void decode_xtheadsync(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xtheadsync(rv_decode *dec, rv_isa isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -716,6 +706,5 @@ void decode_xtheadsync(rv_decode *dec, rv_isa
> isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D xthead_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &xthead_opcod=
e_data[op];
> =C2=A0}
> diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
> index 4fb9a29d0b..a4e59312d0 100644
> --- a/disas/riscv-xventana.c
> +++ b/disas/riscv-xventana.c
> @@ -20,7 +20,7 @@ static const rv_opcode_data ventana_opcode_data[] =3D
> {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> =C2=A0};
> =C2=A0
> -void decode_xventanacondops(rv_decode *dec, rv_isa isa)
> +const rv_opcode_data *decode_xventanacondops(rv_decode *dec, rv_isa
> isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -38,6 +38,5 @@ void decode_xventanacondops(rv_decode *dec, rv_isa
> isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D ventana_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &ventana_opco=
de_data[op];
> =C2=A0}
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 171c60238f..c4b8ee7d07 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2846,7 +2846,7 @@ static const char *csr_name(int csrno)
> =C2=A0
> =C2=A0/* decode opcode */
> =C2=A0
> -static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
> +static const rv_opcode_data *decode_inst_opcode(rv_decode *dec,
> rv_isa isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> @@ -4541,8 +4541,7 @@ static void decode_inst_opcode(rv_decode *dec,
> rv_isa isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dec->opcode_data =3D rvi_opcode_data;
> -=C2=A0=C2=A0=C2=A0 dec->op =3D op;
> +=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &rvi_opcode_d=
ata[op];
> =C2=A0}
> =C2=A0
> =C2=A0/* decode operands */
> @@ -5291,14 +5290,12 @@ static GString *disasm_inst(rv_isa isa,
> uint64_t pc, rv_inst inst,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .inst =3D inst,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfg =3D cfg,
> =C2=A0=C2=A0=C2=A0=C2=A0 };
> -=C2=A0=C2=A0=C2=A0 const rv_opcode_data *op;
> +=C2=A0=C2=A0=C2=A0 const rv_opcode_data *op =3D decode_inst_opcode(&dec,=
 isa);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 decode_inst_opcode(&dec, isa);
> -
> -=C2=A0=C2=A0=C2=A0 if (dec.op =3D=3D rv_op_illegal && cfg) {
> +=C2=A0=C2=A0=C2=A0 if (!op && cfg) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static const struct {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
bool (*guard_func)(const RISCVCPUConfig *);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void =
(*decode_func)(rv_decode *, rv_isa);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const=
 rv_opcode_data *(*decode_func)(rv_decode *,
> rv_isa);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } decoders[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
{ has_xtheadba_p, decode_xtheadba },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
{ has_xtheadbb_p, decode_xtheadbb },
> @@ -5317,19 +5314,17 @@ static GString *disasm_inst(rv_isa isa,
> uint64_t pc, rv_inst inst,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (size_t i =3D 0; i <=
 ARRAY_SIZE(decoders); i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (decoders[i].guard_func(cfg)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 decoders[i].decode_func(&dec, isa);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (dec.op !=3D rv_op_illegal) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 op =3D decoders[i].decode_func(&dec, isa);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (op) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0 if (dec.op =3D=3D rv_op_illegal) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec.opcode_data =3D rvi_opcod=
e_data;
> +=C2=A0=C2=A0=C2=A0 if (!op) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D &rvi_opcode_data[rv_op=
_illegal];
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 op =3D &dec.opcode_data[dec.op];
> =C2=A0=C2=A0=C2=A0=C2=A0 decode_inst_operands(&dec, isa, op);
> =C2=A0=C2=A0=C2=A0=C2=A0 op =3D decode_inst_lift_pseudo(&dec, op);
> =C2=A0=C2=A0=C2=A0=C2=A0 return format_inst(24, &dec, op);

