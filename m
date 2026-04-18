Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9573F99C7C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 12:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wE4de-0004Xx-Rk; Sat, 18 Apr 2026 08:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wE4dc-0004XM-Aj; Sat, 18 Apr 2026 08:19:04 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wE4da-0003yZ-DP; Sat, 18 Apr 2026 08:19:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E965860138;
 Sat, 18 Apr 2026 12:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B285EC19424;
 Sat, 18 Apr 2026 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776514739;
 bh=fb2qs8xXXSdVoi0H7npXnCsZqOhbnesjI8vD/+6Rahc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uiNq4pEhornA6isV66wur/y9/vmPO6IAPUO9ce92nj4cFED4MpFDpgaEB7pEgE/f+
 eukJ4tXtWu8xh63e/wuxKCTJfLleVqxHvH3isdLLtEloN48wM/YFiQLTsa3QhSRxL0
 FhNdURk5w6TkSj8T+ks1hjjvTbqCmstyS1O/0cEz6F2Vx5uQIovMkZQT/Y7E7Ha58Y
 M1IMxug3whhFpjd8kRCFs9MtBI/fEvBvBUTqbxo6PziVer4cMyDFHzBCqU2bTORm8V
 m4dUt5axBwmVo5akb+Q0fabY80wyenlr5a0vrbKBt2cKC+PnJ0UC1jzc9a0JW0jvr2
 U8D0UlqQSKF9A==
Date: Sat, 18 Apr 2026 13:18:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@zevorn.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peng Jiang <3160104094@zju.edu.cn>
Subject: Re: [PATCH v6 1/5] target/riscv: add thead-c908 cpu support
Message-ID: <20260418-tidal-algorithm-52c79c2d303e@spud>
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
 <20260417-glutton-bunny-d378acda90ae@spud>
 <aeK7rD8KAe9nbsFm@ZEVORN-PC.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y0ueahuTR47zRhEF"
Content-Disposition: inline
In-Reply-To: <aeK7rD8KAe9nbsFm@ZEVORN-PC.localdomain>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Y0ueahuTR47zRhEF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 07:02:42AM +0800, Chao Liu wrote:
> Hi Conor,
> On Fri, Apr 17, 2026 at 08:15:48PM +0100, Conor Dooley wrote:
> > On Fri, Apr 17, 2026 at 11:11:25PM +0800, Chao Liu wrote:
> > > From: Chao Liu <chao.liu@zevorn.cn>
> > >=20
> > > The C908 processor is based on the RV64GCB[V] instruction
> > > set, compatible to RVA22 Profile and implements the XIE
> > > (XuanTie Instruction Extension) technology.
> > >=20
> > > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > > Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> > > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > Reviewed-by: Conor Dooley <conor@kernel.org>
> >=20
> > Uhh, I don't recall ever giving a r-b tag for this, never mind the fact
> > that I never provide tags with this email address.
> > IIRC I just commented about svpbmt being missing or something along
> > those lines.
>=20
> Thanks for catching it, that tag shouldn't have been there.
> I've dropped it locally and will leave it out next version.

And go double check that the other one is real too.
This isn't the sort of thing that you can get wrong by accident,
since you'll only ever be copy-pasting tags from a mail or using
something like b4 to update them.

--Y0ueahuTR47zRhEF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeN2qgAKCRB4tDGHoIJi
0tHCAQCyzH0gi9EIMUKe+YPNARs9fMvD0j4VYQAl1yuTmg/k8gD/SJOjgnzRYJYb
4ow9/UV9wktNa/xcnSQI3+G16JuN6Q8=
=+OBk
-----END PGP SIGNATURE-----

--Y0ueahuTR47zRhEF--

