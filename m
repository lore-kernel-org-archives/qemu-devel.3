Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367F3C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuC1i-0003zD-A1; Wed, 12 Aug 2026 12:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuC1g-0003z2-7a; Wed, 12 Aug 2026 12:42:01 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuC1e-0006qb-EE; Wed, 12 Aug 2026 12:41:59 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A26291400045;
 Wed, 12 Aug 2026 12:41:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 12:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786552916; x=1786639316; bh=JMoJ66msCCw7TE4+ZZbwdj3px1Pgc0Ur
 wUpbDD7YSDw=; b=jFmRx3WDzgDBYOXDkXC+VJMqVEEL8Ke6VX4bPTy+769rgMoR
 uOfz79qaPgMf2R145ACtTMbt+I4YPHoG9vMTck+D1yg5QR9Ft0rG7hQadl0lihT9
 0jSE0Q2DQxma+lb5bRh8DLzrJxUVtADpTJGBBDo2UJFw9oXdSNmeymK5+dfVzHIv
 +IjBzYxDEXJp49uqv4TIv0/mQci/tJ7hMHsxlfgS49TLyPQ5oEV37twNpnhJgErM
 RXpC+0vkqh2+zDCcSGjNiwsGm76+q/J3BRbIaY211f7I+lSVrbMEym91bGbP4dR4
 NHDyYGT3WrZ560KPnDN1eiwpV/ffoouRKuAutg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786552916; x=
 1786639316; bh=JMoJ66msCCw7TE4+ZZbwdj3px1Pgc0UrwUpbDD7YSDw=; b=T
 9ud3N/JEcFpGlfG1FcvnFTzM7OfjaJrcRIA+iIVKZhg7wHXxAUfVmpo1GfFA2Yu5
 3b4C67qbVu8A3rKoKKCZNtJIcRTGDTUFyGEi6euWPUxhqjKIPDCXYOw/3c00nEbK
 ZRYvvYNYRGBleYK9T5GO+sOrabRP9Iw4S577+qB8bbzfMAw5nquaNlHCV+QycIIz
 UQIZ8j4y6BdwRTL9TBSMFbyhoZVYR3QWiItWyvm60RsFY1xi6ENkzzgDQPfCDkTc
 voMVDgwUVRXby4FR276d8tNay+mVGm0UR8vKR1rAlzH5eukfi5f5Fa7uMIEoj8DT
 SBVlSmhIrXKva6uRt8ujg==
X-ME-Sender: <xms:U6J8anTgjJ11i4MPgBj6mOJ4H38A1CpbLyUgsHbggKQrC9EtfOUOEA>
 <xme:U6J8aqTzNK9apymMkTnhBW0ffvldG6KaNCQAXBywWrfyIOzsS0AleyBqwSgnuAzes
 3k9I48rQ717bW1K08jeyA_MFgomx6DkvyMFxaz4Kb7Mca1UfpB34Dfo>
X-ME-Received: <xmr:U6J8as7RtjTwy4PoXG16Dbk3wPBqCYPwfJ7XJeaSStHOwdBUbg4--u6P2RBmnch2xBomQw>
X-ME-Proxy-Cause: dmFkZTEpZlKt9LLslbpY4viMGc+OBio+UBDT/BZi7wcWy0grcRDu6UkaDD3E8ph81x7BwS
 65Q0rprAtS6RYbaFuBKn056dlkH3s+il7F+nwLF8y+Cr7YhnKgRxgDXhLaFtym12DXN1dl
 u+Stx/tlR3a9FLwje/tBgA4LRSGTqpWVX2jg6sLw4pflHNXVAo21qMiXK+zlwt9xRgUAsi
 1B7DRLUC2ZRdNWFzyRhQDUMIciKZr06rWvlnxLK2NSVSI++Hh4oP5UK2Ie6fhgC9EPDPQv
 9dKJQQ3aaGN2sZpUQdRXEYQRZrAvx6LKnG7s7PPU93Iwcd/n5wSHdwUb7tFh8pmsbzC7Pa
 /Q8m7MXyEUW2sXaj6P3Rx/RIhXSnTVb5eNilSpgoqij+kaZkcTbrlXMyWfrVQ14PQnSJFm
 3KiommCGJ0OQl4Pvjfw87T8i+dXqMgzS1o4TfEgz1Y7xDxDaEltFTQ7j1tRB9vWDXnf64V
 HWquIlodVUPt5fiixFoWPuF2HxVw2UDotUa5RPfFHuBwf7yh2Kz8dmSxICIJyPPGEJkaQ8
 58Ayb+ItywswSr8ImjNizNQwksislNIBTfa43CFq3sIdqxsQpJndvcji6EoW1PNQKxqufn
 rMiwOnzyuUrmXtv0FWg0leK9BxPjgmZbfPvv/oT4BBtEx75PVb0c6eNxnPlw
X-ME-Proxy: <xmx:U6J8am3COsSm8AVEBoPrBhZjROP5Zo6psyRJ73WHxk6HcHQnDrXdMA>
 <xmx:U6J8anD-Z3A4q389OE9H9ATLKZYRgYZXla8OurynU05rtZ_IoyMtug>
 <xmx:U6J8ahM3kfEuZ9g1PBGJUwoUb11KtkH6h-G4R_iAyaWMQMefHK1w8Q>
 <xmx:U6J8asbfltrduQgqxTLM0YzYDy9jLHTIkUoN4GlN4tPIEes_WehL2g>
 <xmx:VKJ8aiinsA0EiYTE8CXG1tZ_ftClYta223GO6ePUhsspdXi1UIQaVg7m>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:41:55 -0400 (EDT)
Message-ID: <ae336dc61541b41ab95630f6d4267f5f9d63699c.camel@alistair23.me>
Subject: Re: [PATCH 2/4] target/riscv: reject FMV.X.W/FMV.W.X under Zfinx
From: Alistair <alistair@alistair23.me>
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: Thu, 13 Aug 2026 02:41:55 +1000
In-Reply-To: <a417fdc4ee2d4c4c9760786a4104d051@wangyang25.otcaix.iscas.ac.cn>
References: SENT
 0001-target-riscv--honor-zicbo--envcfg-gating-in-linux-user-mode.patch
 Subject: [PATCH 1/4] target/riscv: honor zicbo* envcfg gating in linux-user
 mode Message-ID:
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
 <a417fdc4ee2d4c4c9760786a4104d051@wangyang25.otcaix.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=alistair@alistair23.me; helo=fhigh-a2-smtp.messagingengine.com
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

On Tue, 2026-08-11 at 09:14 +0800, wangyang wrote:
> Zfinx explicitly excludes the FMV transfer instructions, but
> trans_fmv_x_w/trans_fmv_w_x used REQUIRE_ZFINX_OR_F so a Zfinx-only
> CPU accepted them.=C2=A0 Require RVF instead so the transfers trap with
> an illegal instruction when only Zfinx is present.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4108
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/riscv/tcg/insn_trans/trans_rvf.c.inc
> b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
> index e935523c93c..305f545b494 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
> @@ -428,7 +428,8 @@ static bool trans_fmv_x_w(DisasContext *ctx,
> arg_fmv_x_w *a)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 /* NOTE: This was FMV.X.S in an earlier version =
of the ISA spec!
> */
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_FPU;
> -=C2=A0=C2=A0=C2=A0 REQUIRE_ZFINX_OR_F(ctx);
> +=C2=A0=C2=A0=C2=A0 /* Zfinx explicitly excludes the FMV transfer instruc=
tions. */
> +=C2=A0=C2=A0=C2=A0 REQUIRE_EXT(ctx, RVF);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv dest =3D dest_gpr(ctx, a->rd);
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv_i64 src1 =3D get_fpr_hs(ctx, a->rs1);
> @@ -531,7 +532,8 @@ static bool trans_fmv_w_x(DisasContext *ctx,
> arg_fmv_w_x *a)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 /* NOTE: This was FMV.S.X in an earlier version =
of the ISA spec!
> */
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_FPU;
> -=C2=A0=C2=A0=C2=A0 REQUIRE_ZFINX_OR_F(ctx);
> +=C2=A0=C2=A0=C2=A0 /* Zfinx explicitly excludes the FMV transfer instruc=
tions. */
> +=C2=A0=C2=A0=C2=A0 REQUIRE_EXT(ctx, RVF);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv_i64 dest =3D dest_fpr(ctx, a->rd);
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv src =3D get_gpr(ctx, a->rs1, EXT_ZERO);

