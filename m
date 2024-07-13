Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53F8C3DA42
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 18:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sShwB-0004bp-AY; Sat, 13 Jul 2024 14:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1sShwA-0004at-Em; Sat, 13 Jul 2024 14:57:38 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1sShw8-0001cd-Qo; Sat, 13 Jul 2024 14:57:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 41E6F60AC9;
 Sat, 13 Jul 2024 18:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA41DC32781;
 Sat, 13 Jul 2024 18:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720897044;
 bh=sxkTQKhKJZkxaA9+SahGtwPnweSHl9Wseh7YPQtVl+0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s/WZOjlddIQmxmf29lyn08qGeSZeYqwRRGj/0T3JCmQFnhYySVXYL86Qj/hW0UsIh
 Of6BB514koTIH3RLVxJTNAkMINn/U5qmsaBwpDPn6YRKhMgkADFD61HIv4TQWzU8Mv
 ZnqJqoi5oqtNZscYDB4vQPd/m4DF1S4ywEDZBoxdoR7WynU2+i22B88XpxWK01+L9s
 HpIXlmqgYY6N86WoXSQAlb7LADfHgnfv46efTI8S0yi/1gI0FNLvAuzmiicuDmDprS
 Hr8wX6/AOfNZfGJILeRb9GwaOj47lB/ygLlb4SEOVEobHxLWl/OYkkmGHq5N1MdBHg
 i9HqUSsB5Hvfw==
Date: Sat, 13 Jul 2024 19:57:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH] hw/riscv/virt.c: re-insert and deprecate 'riscv, delegate'
Message-ID: <20240713-wreckage-humid-79c9acd37542@spud>
References: <20240713174325.107685-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vPxhV5sTL/Svjn3I"
Content-Disposition: inline
In-Reply-To: <20240713174325.107685-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=conor@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--vPxhV5sTL/Svjn3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 02:43:25PM -0300, Daniel Henrique Barboza wrote:
> Commit b1f1e9dcfa renamed 'riscv,delegate' to 'riscv,delegation' since
> it is the correct name as per dt-bindings, and the absence of the
> correct name will result in validation fails when dumping the dtb and
> using dt-validate.
>=20
> But this change has a side-effect: every other firmware available that
> is AIA capable is using 'riscv,delegate', and it will fault/misbehave if
> this property isn't present. The property was added back in QEMU 7.0,
> meaning we have 2 years of firmware development using the wrong
> property.
>=20
> Re-introducing 'riscv,delegate' while keeping 'riscv,delegation' will
> make current firmwares to keep booting with the 'virt' machine and
> dt-validate won't complain about it since we're still using the expected
> property 'riscv,delegation'. 'riscv,delegate' is then marked for future
> deprecation and its use is being discouraged.

dt-validate /should/ complain about it - does yours not? It's probably a
bug if it doesn't. Whether dt-validate complains or not here I don't
think is relevant though, only the impact on firmware of removing it.


--vPxhV5sTL/Svjn3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpLOEAAKCRB4tDGHoIJi
0iPUAQCaQSKdKXmHJBVuukCRlxy7xTGbdMorMWTjSqTOAuvqvQEAzzCBlRSvxqFY
pQads1ldLWix/eVQ1vprDzknufVS4g4=
=jeVf
-----END PGP SIGNATURE-----

--vPxhV5sTL/Svjn3I--

