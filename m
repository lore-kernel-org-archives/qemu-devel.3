Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5718C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8RJ-0000kX-Kw; Wed, 12 Aug 2026 08:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8R9-0000ia-Vx; Wed, 12 Aug 2026 08:52:04 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8R5-0001Gx-9k; Wed, 12 Aug 2026 08:52:01 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 495FF140014A;
 Wed, 12 Aug 2026 08:51:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 08:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786539118; x=1786625518; bh=WPiaPV515koozghiMv9ndYVkhQuEO+tk
 M2p0d/yTKHU=; b=nryTGyPbxLIe4KLQqH838WtWxS2ULxi4r8IACN86cYHVVL4G
 Jau6lnxRkDGEV1MF0SqoeyCMx+xJnuIeGjica68pe8pBg4AGmAkKMupD4FrNC9cp
 blUJ5JlPxY/xr5BvwzGFujjnY9qD/TtU0P1y+kSitd5RisW+jI7kPfl/ym6QYDfn
 JBzeaLjAwzFaAYDtWKf8CkTMxaYskBicGis699CChPImpZaiZiJKnaKMiv4CM8uN
 4K74hAzhhkHrzwqYM7zQ8Kz3qrTA+utnuN+Oc6n5TLnZn1WOkdawZtFKzAxTw6tz
 cCVUgEqHXbhg6yDTx94r1t9iIehaTj7CzuwRvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786539118; x=
 1786625518; bh=WPiaPV515koozghiMv9ndYVkhQuEO+tkM2p0d/yTKHU=; b=g
 kGjl+iggkDvt1UAEOVaKmJSwGCYmaq6oryehXaQCe0REga8db/WIuyb6cTALXPYr
 wfjCeOVTGMcE+Y4zWSzHq99x+c9W0KFnvgVp90YSJdN67tYWgo5iwGkyuKvP3p4C
 X0nz/xz8PHw4fKY3lrn1903GnTz2AENkVWZkyNn7VO6v+0KpirSkgl9YsSb2kKpH
 gU3HuzhV8nze1qsDWbzJ+YiMeiMC3eAUJflQbTYNRcw4s1XwIH2INTWljy6rFkV+
 C4qMQ9kWn2pT+/WZSzHygDHvterMLrWBcP6dPELb3dC9RV+4Phs5xjuVTMhA8Z3n
 6CR75YtWNf03xXbHPYR9A==
X-ME-Sender: <xms:bmx8auh1QEyZQR6poiUUKCztREmToF8_eKV9zpfcey87qV9xDwBk0A>
 <xme:bmx8ajWP2OC-B8DjjIdw6a5h59_X2vwSrUpwJtRB8K07bSnUxG_ibYwIA9faGK641
 -tLqpLefGs3LXgRgmpBBdbIZunf2hWxl0ZjjzZCUQu_IHo0jkP5pFzI>
X-ME-Received: <xmr:bmx8alNKTyNorjWrhb6MmGHsYmRbFWUF0H8HqbMnIMGy8kNvAyPq1ZzySmO0rE3ymSVKSg>
X-ME-Proxy-Cause: dmFkZTFBl8NfP07YVm2uEj56aKFTjJ5PpdZmd1UCTIPFKX5NUa/2gqY4/xBVLKw0nNGzLb
 KjqAAr20ASfj07WNPGAOVDB/bQS3vGh1LEG6Jzfk63lG2qhdTHTFDngWd/WvFd+c4JFxq/
 0hPHgSkFgdDQ6ZUO5wTwyBLrtevOTWi6jdSSiG8IxRz/3xTHjpJ/zei2QEDas+X2tw4SL4
 bbyeIlKQJ01TQTlXyddau2VfhIAVstTMm79qOEyIDNCGYzKdAjdu7q1maKARN2lGu8Qi/V
 E065oEYqd1/GrmZSxyQU4GA90m/qeFg3lFo4yhw4XEgWv9UsYHcZge6g4NNqFJ2Ay7V/De
 2yHldhFblJORDpdTpsWt1E5FtcB5D4a5tRJHRRKxK3JAr0B1lnZG8vWBEnRt6x2y+15uc1
 o+8N70i+LzKCV6KWc9UpOu3uFIj/kIzrixTaF3JMQBspQ8I3Hbm7vdIDyqM0iqiCOVWran
 QgkvAXd1v+gnntgcqPwHVODO8gwQ0J9gHvPWObT9W6fxni+KBHwudDskGMCrZQVoLMxb6n
 CDsjsrt8A5INmXpfCdYMXF31aNVpmBXNfWbSLXJbOP+HG49jCd9qbHfI4VndaM/TdN0yJ0
 DBfl76Uveof9kNZygUyy82cK4+y0W++0k+PUYqYSOKEsFwX0ryQ5/49mzI1w
X-ME-Proxy: <xmx:bmx8avYu33Ufj-tPkR0VYmaBX_yRC_O6C3ERDCmsSkf8U-f-XzQMQA>
 <xmx:bmx8ahoLfodgoFk8uW9FH_ebs8p9uH-V6T-E67uMPH0bkn5E0i-deg>
 <xmx:bmx8araZZp95NBl7c2H-E4JZzMgq6n_7vVqdiYY9p3HwExHcHaUWNw>
 <xmx:bmx8ahRy8v55aprI489g6DzGavC77sEH8sVb6ilCTDE2kWvWRqv-6g>
 <xmx:bmx8ap2GtmVUQZiCoZ7ZkefmkBwABoZwGllY59GKgU8dyuG8TbEN_9Wx>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:51:57 -0400 (EDT)
Message-ID: <8dc5f699c1529a1c7da3744ae3e9e8bdbe3a052f.camel@alistair23.me>
Subject: Re: [PATCH 45/56] disas/riscv: Split ventana_opcode_data
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 22:51:57 +1000
In-Reply-To: <20260809223545.730664-46-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=alistair@alistair23.me; helo=fhigh-a3-smtp.messagingengine.com
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
> Move the table to riscv-xventana-op.c.inc and massage
> the lines into OP() form.=C2=A0 Drop vt.illegal as unused.
> Return pointers to objects directly.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv-xventana.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
21 ++++++---------------
> =C2=A0disas/riscv-xventana-op.c.inc |=C2=A0 2 ++
> =C2=A02 files changed, 8 insertions(+), 15 deletions(-)
> =C2=A0create mode 100644 disas/riscv-xventana-op.c.inc
>=20
> diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
> index a4e59312d0..5d2e07865f 100644
> --- a/disas/riscv-xventana.c
> +++ b/disas/riscv-xventana.c
> @@ -8,35 +8,26 @@
> =C2=A0#include "disas/riscv.h"
> =C2=A0#include "disas/riscv-xventana.h"
> =C2=A0
> -typedef enum {
> -=C2=A0=C2=A0=C2=A0 /* 0 is reserved for rv_op_illegal. */
> -=C2=A0=C2=A0=C2=A0 ventana_op_vt_maskc =3D 1,
> -=C2=A0=C2=A0=C2=A0 ventana_op_vt_maskcn =3D 2,
> -} rv_ventana_op;
> -
> -static const rv_opcode_data ventana_opcode_data[] =3D {
> -=C2=A0=C2=A0=C2=A0 { "vt.illegal", rv_codec_illegal, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -};
> +#define OP(N, ...) static const rv_opcode_data op_##N =3D {
> __VA_ARGS__ };
> +#include "riscv-xventana-op.c.inc"
> +#undef OP
> =C2=A0
> =C2=A0const rv_opcode_data *decode_xventanacondops(rv_decode *dec, rv_isa
> isa)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec->inst;
> -=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 switch (((inst >> 0) & 0b11)) {
> =C2=A0=C2=A0=C2=A0=C2=A0 case 3:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (((inst >> 2) & 0=
b11111)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 30:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) &
> 0b0000000111)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case =
6: op =3D ventana_op_vt_maskc; break;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case =
7: op =3D ventana_op_vt_maskcn; break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case =
6: return &op_vt_maskc;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case =
7: return &op_vt_maskcn;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 return op =3D=3D rv_op_illegal ? NULL : &ventana_opco=
de_data[op];
> +=C2=A0=C2=A0=C2=A0 return NULL;
> =C2=A0}
> diff --git a/disas/riscv-xventana-op.c.inc b/disas/riscv-xventana-
> op.c.inc
> new file mode 100644
> index 0000000000..0fe4666aee
> --- /dev/null
> +++ b/disas/riscv-xventana-op.c.inc
> @@ -0,0 +1,2 @@
> +OP(vt_maskc, "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(vt_maskcn, "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2)

