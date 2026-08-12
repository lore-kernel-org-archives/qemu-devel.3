Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B1EC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCli-00011K-DS; Wed, 12 Aug 2026 13:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuCla-00010c-L8; Wed, 12 Aug 2026 13:29:26 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuClX-0003St-FF; Wed, 12 Aug 2026 13:29:26 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id A92B9EC016E;
 Wed, 12 Aug 2026 13:29:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 13:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1786555761;
 x=1786642161; bh=f3Q2tPLisSIip/VXa4uarXBoPWsE93xkMP87bhz4JsU=; b=
 PrZJ+dFe/IOjp9WaDQm4BiX1LGgTGehCQIt7aJTDmkFoAE/hjBIwypIMKKLm2RSu
 rFS9BN32C7AViPqexsajfvIN4+JtE2wCMgoxEyBJZlUeVQxp4azZEIXHz3nzL2Kh
 O3ngto6YHbk+gT4CnW1xgyMK76rd7TB+9fr1AMOeQSrlDTnKxieNmAxpfn6Tz8cA
 +JcJuT3cXW1FjYayx9e8MOl++z8Ude1z2VEiB6A7S13LrRSBcbrBgkWfPsqwiBNw
 Rp57ap2T3PsLvcgdzbaqJMAbiUc1FR2FarsicffGqwQy1y5WoXSxDSSPgjI2/3jF
 /KBLdAUwt6Izd3Fx00HNug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786555761; x=1786642161; bh=f
 3Q2tPLisSIip/VXa4uarXBoPWsE93xkMP87bhz4JsU=; b=DL1YEiYERQaXh1KAI
 9A91rK37fZT+6vIk1v4rmaGDOe4mbNWBnNtOnIrGpHSCWCVhVdfbNVXbuilW+rUo
 sA8knXUmJaihcKmPWs7llKhw/qRLRF82lgq15xPy8/rrWvAvhWn4pCYr3jDIIkaC
 BPWYNIvP6IVaf5s60QFMZfVJ+oFxDzDnfSRg4H37J1uzbZyeZL+4ij06PX5mDkiX
 ftiasZotcqSj+7UPmxyiu0vElPrV1grfAXPKBefk9/2XnuxaXeI9IEoG38vX3DVN
 jiyjZBqBeR/flaRLB3BFO0//NoKA8hBjjDebnIBMYPZ7ghgDiX/GXFxP+SuVrIUf
 tx4ww==
X-ME-Sender: <xms:cK18arNd6DWdikoTrN19pFi75N12-5fCHZ1pG5GjNcMI7HhMCWAVHg>
 <xme:cK18agnnotQt0LNsufE0JWXtxxZGmVpM6i-2o8a_KentqmqKg5YNJw8b33ULR8GIu
 VRN1sZ2s30DYzcjRNBJq8LayDCNdqB_Dboc1SeyPy27z7PufP5hShE>
X-ME-Received: <xmr:cK18agQr3MD0Kfb46sK-d-wtyx1uUq-YQLfYzWJ9bWIhFaFXOQpPOEL8VDCzNTLRVW1row>
X-ME-Proxy-Cause: dmFkZTELsO78tHFkr7A2XPPNS5Hft19u/4iT4VjqVIThKuqsSVdLgXgfg6sOJTZm7zV4Jc
 rWBMpHXlFzii4vuICBr+ORKKaA0XSdOXwel9FSf0YwCz/BIM4OqPjcj7zenK5ZxdQYSPsh
 J+nrbnVKx/tZ5q7Ck9lAksSWrvVhN9tAKT8fbNDOiQDVwllxzFC40O6scwoK+U9MMdY/kc
 Pn7L4plR8fw/IpKHUiX4LrZxJV5mvyew4Rx1kUYVCVftW2zzr/bwRZsQK4X5DHF96+P1mR
 4TAwcJc5h8iDNqv8JV2mi/0s0L4RifPw1UKQYKtZKHaSGx849dM62SyJ96IcP7nI8Fpgjw
 UD1m3kBWwIJddFKCYwb+9Ry15G1OenHGRwFPfUdCMp75u0BkKHODoP11VVcbOcE4HNOE5O
 7vG4qn1/EkwYy4npVaKn7BaUJoXVLpbUQE/WamVK5aTxqghaFby0V7L3z0KWJHzWprOwoQ
 MWQP02jKtI8+h30+BP0kxdQm4cmBCiRQPwAw1qrdwSyM/sw3g2S3iZdwpMMT8P3ExLOY61
 nfoy/oKETarIk3nwuBb8V8n1Sa9mvZ7li+9003LyUjBjU3hSFwGhl63UmBLEUrjwUxpZqe
 tUz+a/aeQ6tKd/ZURrMA/YEn+On+IPn2YzTwyCDTU6O+IkwH5cpERydRlMZw
X-ME-Proxy: <xmx:cK18avXkGtX3lL7SaSDWSpZQ1TbdLw42MxCF0VspBt435VPFtM-o0Q>
 <xmx:cK18akKBz-VCG7osQacDZcDMBOki3rp77XKF7hXpOlGoBxwRasGqHg>
 <xmx:cK18av2N-R8nHHNhlLhh5ta1N5p8uyWWGVxlYHtC8zRKqXpNtiwZAg>
 <xmx:cK18ahLEg0485To2Q2wuB47rjUs025TyqH5ASzVfb_yRGZ8aodP5IA>
 <xmx:ca18auA0mc10Sxzcv8O4Rv3GPu_MPy3O9q-AQ3NI7t0dKOcOadP1go0K>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:29:20 -0400 (EDT)
Message-ID: <fb7b27db1d6cd91f8f22ef5836d2f0e2c45b5add.camel@alistair23.me>
Subject: Re: [PATCH 1/2] target/riscv: Fix sstatus update in rv128
From: Alistair <alistair@alistair23.me>
To: frederic.petrot@univ-grenoble-alpes.fr, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, 	qemu-devel@nongnu.org
Date: Thu, 13 Aug 2026 03:29:10 +1000
In-Reply-To: <20260729083941.103646-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20260729083941.103646-1-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=alistair@alistair23.me; helo=fout-a1-smtp.messagingengine.com
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

On Wed, 2026-07-29 at 10:39 +0200,
frederic.petrot@univ-grenoble-alpes.fr wrote:
> From: Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-grenoble-alpes=
.fr>
>=20
> The sstatus register assignment was performed before the write
> mask was fully constructed, leading to an incomplete update of
> sstatus fields on the experimental rv128 target.
>=20
> Move the sstatus write after the mask completion so the full
> write mask is applied correctly.
>=20
> Signed-off-by: Fr=C3=A9d=C3=A9ric P=C3=A9trot
> <frederic.petrot@univ-grenoble-alpes.fr>

Thanks for the patches.

Can you please include a cover letter for a multi-patch series. It
makes much easier to use the QEMU tooling to apply the patches

Alistair

> ---
> =C2=A0target/riscv/tcg/csr.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc5..d834b77714 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -3984,7 +3984,7 @@ static RISCVException
> read_sstatus_i128(CPURISCVState *env, int csrno,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Int128 *val)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t mask =3D sstatus_v1_10_mask;
> -=C2=A0=C2=A0=C2=A0 uint64_t sstatus =3D env->mstatus & mask;
> +=C2=A0=C2=A0=C2=A0 uint64_t sstatus;
> =C2=A0=C2=A0=C2=A0=C2=A0 if (env->xl !=3D MXL_RV32 || env->debugger) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D SSTATUS64_UXL;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -3995,7 +3995,7 @@ static RISCVException
> read_sstatus_i128(CPURISCVState *env, int csrno,
> =C2=A0=C2=A0=C2=A0=C2=A0 if (env_archcpu(env)->cfg.ext_zicfilp) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D SSTATUS_SPELP;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> +=C2=A0=C2=A0=C2=A0 sstatus =3D env->mstatus & mask;
> =C2=A0=C2=A0=C2=A0=C2=A0 *val =3D int128_make128(sstatus, add_status_sd(M=
XL_RV128,
> sstatus));
> =C2=A0=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
> =C2=A0}

