Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592F0F8D75C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 19:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDofh-0008Kw-GO; Fri, 17 Apr 2026 15:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wDofd-0008Kl-VM; Fri, 17 Apr 2026 15:16:06 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wDofa-0001N6-PO; Fri, 17 Apr 2026 15:16:05 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DF36144594;
 Fri, 17 Apr 2026 19:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE99BC19425;
 Fri, 17 Apr 2026 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776453353;
 bh=aUOEv/28OUb8qU3fqhEMqbIoEZrWwOKG7CMFR3N7jUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tx2sZeXIZapJsYqrbT2bENU1aEMA17XlQcllCQFHJ0wZ4jKsqDOd887zRqOtJMlBx
 VGs3+SjAwvt7oXHD4+zfXbxjVQQgBJpTSm4fBnYCDEr51wgq3LpJ6KSoZuVBLRoa/Z
 PIvf6+R0GlZchYQ/JUvDocKwe3DrrnGPU5B/oSQ9WgPwM5gimigMwpxLPjrXqdz+r1
 hNU+D71oHEhe4IpqVNA+hqo1BbqN9bjhVPrSAZw0kA8XPztfJJTgCY6P1jXhL1w6Q+
 Qj8ubuBJT+rBPzFmXUbejoKb9+bXP6luBglz04S+RrSB1W5HQ7J9SpSsWuchgxpgl3
 9dyacKiwo8Xlw==
Date: Fri, 17 Apr 2026 20:15:48 +0100
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
Message-ID: <20260417-glutton-bunny-d378acda90ae@spud>
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WQ3QWmQFKOzZ3rLB"
Content-Disposition: inline
In-Reply-To: <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=sea.source.kernel.org
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


--WQ3QWmQFKOzZ3rLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 11:11:25PM +0800, Chao Liu wrote:
> From: Chao Liu <chao.liu@zevorn.cn>
>=20
> The C908 processor is based on the RV64GCB[V] instruction
> set, compatible to RVA22 Profile and implements the XIE
> (XuanTie Instruction Extension) technology.
>=20
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor@kernel.org>

Uhh, I don't recall ever giving a r-b tag for this, never mind the fact
that I never provide tags with this email address.
IIRC I just commented about svpbmt being missing or something along
those lines.

--WQ3QWmQFKOzZ3rLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeKG5AAKCRB4tDGHoIJi
0s45AQCUxEFStW3jrnedbaM4jJGfGT84b685pl2xapuNYd/4aAEAhJcWMdS7T/um
T2BUMX4i5eWSLNGd6UnNvx2ZZy1PRAE=
=52fn
-----END PGP SIGNATURE-----

--WQ3QWmQFKOzZ3rLB--

