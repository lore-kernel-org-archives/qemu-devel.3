Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34015CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH2EG-0005TH-9p; Thu, 06 Nov 2025 10:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1vH2EE-0005Sj-Fk; Thu, 06 Nov 2025 10:48:50 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1vH2EC-0007AG-UK; Thu, 06 Nov 2025 10:48:50 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F2894080D;
 Thu,  6 Nov 2025 15:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D65C4CEFB;
 Thu,  6 Nov 2025 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762444117;
 bh=VzM6jNEG5DCPm05kF9VC2zW4y6uzRBlaGistE432Kgk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DnlccOH7OJ45pBL/fnSmIdwj2uMusWZo04ohpMgZOVlDmHWn0oBdOriuQFoqs9LLc
 Xp+qyES/H48q0LYxanKcJpJqQ/hzchK0hazkyGE67AJ210cQkBE6/ZoUh4vlEjgW38
 OeYq4XflupMqH9H+b5JFhIK823gzb90uilLn2HIm9nE9gix37njckMLWLGsW+jTB+t
 MVhr4PIbXuMu3Fk3LyBlL3HE+4tYejj2vCjR+izcK65F6CGsbjZ6syvo1NuiJzXK7L
 EvTM+zUKuSzfUp12q35qubtfYSz2RLGTpkuV3KEAdZo+oJWMB+8NKkmJ+6snhuHjia
 3dl84dVbrgePA==
Date: Thu, 6 Nov 2025 15:48:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Subject: Re: [PATCH 0/2] riscv: riscv,isa fixes + check script
Message-ID: <20251106-napped-haunt-109e9e24ad40@spud>
References: <20251106112044.162617-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2mmnlSxZnq/BKRxE"
Content-Disposition: inline
In-Reply-To: <20251106112044.162617-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--2mmnlSxZnq/BKRxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 08:20:42AM -0300, Daniel Henrique Barboza wrote:
> Hi,
>=20
> We have an array called isa_edata_arr[] in target/riscv/cpu.c which
> needs to be always kept in the RISC-V specification riscv,isa order.
> Easier said that done: as more and more extensions are added we're
> failing to keep up with the array ordering in the review process.
>=20
> I have considered changing how we're retrieving riscv,isa to not rely on
> the array ordering (in fact I have code that does that). We would sort
> the enabled extensions using riscv,is ordering during init time, before
> writing it in the DT, ignoring the current isa_edata_arr ordering. When
> all was said and done that sounded a bit extreme and I think there's
> other stuff we can try first.

FWIW, I have yet to actually see a parser for it in a "real" application
that relied on the ordering. It probably makes a parser more complicated
to write than one where the ordering is ignored. The only time I can really
see ordering mattering is if something has a very simple bit of code and
is looking for "rv##ima" or similar, and using a string comparison
function.
Either way, my point basically is that you shouldn't have to go to any
extreme effort to make sure it is perfect, particularly when it comes to
the multiletter stuff as, at least for devicetree, the binding has never
enforced ordering for multiletter extensions. I know ACPI cites spec
order (and spec definitions, so GL there lol), and there could be relevant
for some ACPI only code where the devicetree parser is not being reused.

--2mmnlSxZnq/BKRxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzDOQAKCRB4tDGHoIJi
0mHiAP4iJvU+Gi5m5pzMZnx2xj8iGN1vmLXutQ7o49Ocv+pl+AD/UeI2jb3vOjs6
XFVcqc65oibKNXVZlWK25aLsYBLkowo=
=vDWC
-----END PGP SIGNATURE-----

--2mmnlSxZnq/BKRxE--

