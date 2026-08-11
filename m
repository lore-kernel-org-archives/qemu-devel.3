Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621CBC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrbH-0007KM-4M; Tue, 11 Aug 2026 14:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrbF-0007K5-Lr; Tue, 11 Aug 2026 14:53:21 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrbD-0006Uj-Lm; Tue, 11 Aug 2026 14:53:21 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id A2A73EC0283;
 Tue, 11 Aug 2026 14:53:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 11 Aug 2026 14:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786474398; x=1786560798; bh=nNlT1CK/CnB1QSe6CQSq0CZ2+Bxg8m7p
 /OSGXU0dQBo=; b=xAKFXNfeNhZjduNoJ7KQDWx/Qghi1ivIY8RWwi7xUeIZk39w
 Hj1V2LDGDLNBhAWMfV9sK40KFZg8VCV7Av4tZIVLFQMcPIUE2DMsA4jg9zGHeZxb
 HKLYtzhhOsR4NeOa5zdaRDEtsMPZWzjo2jZ5KeHPMDQqoF4QKqKMwpAsW1to+Nan
 f5z7apwvLKzrPN7lF47KH8kADnANB2rr33l2u9KwJ8DF0yShsuvyq7rpasrl0/s+
 OaIZrQ4ALzwvBtj7aLp7SmuBT2kENZyh5kmYQYYpQKNp/eeIHzCdnuSIz6cIm0Xv
 tmTxXgqgdIfpfPtbfVJsIXMPGc5rzJ0GtUKAsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786474398; x=
 1786560798; bh=nNlT1CK/CnB1QSe6CQSq0CZ2+Bxg8m7p/OSGXU0dQBo=; b=X
 RgYAcORL1VWBDwKl+5n6RGIvH6z648YOQ4N7Qkrgysn3uYFzZ5lA0TKZmwoQ66yt
 pF7/v98ccD/KE1uYPJh8VRIYqda0Tx2r/RLRlUGCaX1PbIsUsYzkNWPLHDZkQdI0
 c9LQ9lOE+Q7KmSOb/03VdvEhj6xu9wYf8kLthnL8WyScqq4Q5QQbknVWJOLsgaNj
 Qyjbiin9TlkvUIBaC76qaHIZUN4GLx1Sb1yALf7ax+lWZuPxOFAv0wK3NEoGB7aF
 cOf9M/Vo6OExs1f50dI+4xfANQS7rPyTFPOHj1Izo6M06nLjjBmqKtpeXMHt6B3K
 fdbPKfkqtxMf0ay7MStAg==
X-ME-Sender: <xms:nm97amMYKwSL0AwvsE--TR4RpLIISUgAnoWpVrqm-XN4ktMoTB2WlQ>
 <xme:nm97ap4JE-E6uc5C4hklX-5JvL-RxTADsgAoFUcZQa6h204JhV9S5Pw-DLdPmIim5
 RJmfAlxDmDEjaWFaYMn0XWgUS5TDskNBjxyCYhmj79Rz-aQFnaQaA>
X-ME-Received: <xmr:nm97ahg851Ioz5PbAUogxE-BXtvIrzL9s8innKMOS2ksFEjqW9CmT8GFW9QGirFBzb17LA>
X-ME-Proxy-Cause: dmFkZTGWPPP044+VHInvhqzUr3Igu7L7nQ5Eupb0f5svTt4r1+r7N2AuAB0AAAtw04zRrP
 7M6YVzNAp38tLDkofbw5VEDT3ndLM1p5UZ+r/FAUf3zExQufsxwvzw7jA/Pb9y74JWtEkl
 mwaQSAGSkHe6RiaHClZaAzmJyTX1W0ftg3emKfaMJg+0r44dai6MtTN3NDzQdgmEMo+RFi
 7LUU5Df1hEVv5Ov6sDXGwqL2iVjFU7rvuaQV5LzBb5Wt8G1xxOec8YpanCeJK2401CxFBx
 J18ZoIBEdbp2fN0i/dfQMuACbVPHZx/OM/2Str/++vAm3fiFFesgnmFfj91qP5Vi18VVBT
 r+Ft8yZV7IfgtPlfxAspVaQWMZAUhOx0NGPAyVnRnjJvKKGcVpHRWi9oUhFn4mHapbqOfh
 SQbJKdgM5gNJeR9haP7lxJeh0apBVVZiGVvjQ9SBJiJ2YOpAHXRRmal9plhvzWOeDa5VFC
 ONUVPa75fy46tYBGUwmC0A2zUt/fa5NWmV0mt9WoaHu9k/rHqIJR9ot8RVEMctxc3a2PmX
 V5844BvYUeG+Das1CwW40f/XojyELbZHf4xo5HdLJukXN15jbkmBs4k7vhYBYUxlKUzIqI
 QYJi+vvRnGyn15puCLlQAvLZFlXolvVOT1MCDTLfgTVACN6/RZzffhzthHaw
X-ME-Proxy: <xmx:nm97amfcM1QM0eyMg1Yj48anaRLt_KybG8QA7wjPpkF0CZ7yFxLGYg>
 <xmx:nm97ahxeFLzMFoXWBGmSLpLTCZCG9G4vp8xpVANH95qb2j_HCwU6sQ>
 <xmx:nm97at0g1eJQjuzv1eRcUgOFJJjo1iMZobP80UEdhJJ3dBg7bmqXrg>
 <xmx:nm97avzEp3UyNQjc5ocIDwmsOiVny2mQv4acc--zetocXb0x_jotHw>
 <xmx:nm97akNq60xZ0U-0zOHLkbnRPD-IHDemz9m2eIJvW38QnWK836bf7Bbc>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 14:53:18 -0400 (EDT)
Message-ID: <8932bead1796ffa1fcf45301782199f739f781d4.camel@alistair23.me>
Subject: Re: [PATCH v2] target/riscv: use SXL instead of MXL for read_sstatus
From: Alistair <alistair@alistair23.me>
To: Abhigyan Kumar <314abh@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Palmer Dabbelt	 <palmer@dabbelt.com>
Date: Wed, 12 Aug 2026 04:53:17 +1000
In-Reply-To: <20260723142254.1683113-1-314abh@gmail.com>
References: <20260723142254.1683113-1-314abh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=alistair@alistair23.me; helo=fout-a7-smtp.messagingengine.com
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

On Thu, 2026-07-23 at 19:52 +0530, Abhigyan Kumar wrote:
> According to the RISC-V spec, a 64-bit system can have M-mode in 64-
> bit
> with S-mode being 32-bit (SXL bits or mstatus[35:34] being 1). In
> this
> case, read_sstatus should use SXL.
>=20
> QEMU doesn't allow changing the SXL bits in mstatus in M-mode. This
> was
> because of the missing MSTATUS64_SXL mask in write_mstatus. Now, both
> the SXL field in mstatus can be safely modified in M-mode and
> read_sstatus correctly uses SXL not MXL.
>=20
> Fixes: b550f89457 ("target/riscv: Compute mstatus.sd on demand")
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> =C2=A0target/riscv/tcg/csr.c | 9 +++++++--
> =C2=A01 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc..a90449b87 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2067,6 +2067,11 @@ static RISCVException
> write_mstatus(CPURISCVState *env, int csrno,
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if (xl !=3D MXL_RV32 || env->debugger) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((val & MSTATUS64_SXL) !=
=3D 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =
|=3D MSTATUS64_SXL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =
=3D riscv_write_uxl(env, val, MSTATUS64_SXL);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((val & MSTATUS64_UXL=
) !=3D 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
mask |=3D MSTATUS64_UXL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
val =3D riscv_write_uxl(env, val, MSTATUS64_UXL);
> @@ -4014,8 +4019,8 @@ static RISCVException
> read_sstatus(CPURISCVState *env, int csrno,
> =C2=A0=C2=A0=C2=A0=C2=A0 if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D SSTATUS_SDT;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 /* TODO: Use SXL not MXL. */
> -=C2=A0=C2=A0=C2=A0 *val =3D add_status_sd(riscv_cpu_mxl(env), env->mstat=
us & mask);
> +
> +=C2=A0=C2=A0=C2=A0 *val =3D add_status_sd(riscv_cpu_sxl(env), env->mstat=
us & mask);
> =C2=A0=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
> =C2=A0}
> =C2=A0

