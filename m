Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8ABFD9E25
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 23:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvl52-0005M3-Dx; Thu, 26 Feb 2026 18:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1vvl50-0005L9-Dr; Thu, 26 Feb 2026 18:47:38 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1vvl4y-0001Kr-NF; Thu, 26 Feb 2026 18:47:38 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C4BDC40BC0;
 Thu, 26 Feb 2026 23:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84520C116C6;
 Thu, 26 Feb 2026 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772149647;
 bh=15U8hmjslEr68ZVePfrtt+D9OYlKyEjaOnHf5YLq6Q0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=crl7YuZCM59O58UYyRD9s51t4df1NBjl8po7GttwpdNP6l9niFYpI2hre07F5YQKj
 JNag+pooFLOZuKnGJH2kTuvzLjBkSN3zi3YVxVFfRUqREpjFyAjyse/jx0cStjAHAf
 9ohJmwMfxCQYSRYzf1nomXalcudfuBAuYIcZRn9nUnJEPYUsk67a4WB79/kghJ5+Wm
 dnNLTdyV89ETxQHg//l7bJLwNufNBjiMNnv58v4vaC/yQL5+j4vf0jI8YRbkFUuPix
 hGfNKcMW4mO6pPa6kYWE8dDInhNkSfnVkJOQBPdlbXPu4yXJN2eeExAiOAXiQR95e4
 8JoUiLOh+tW2A==
Date: Thu, 26 Feb 2026 23:47:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v2 00/16] Add RISC-V big-endian target support
Message-ID: <20260226-hangout-satin-fd7913f18f2b@spud>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <A02120BF-779D-4B2C-B29D-A9CB044EA895@unpredictable.fr>
 <CAKmqyKO6ioRt+h_tZrudbriv-QDVsOG1LNJ+GFQJ3ZO-fEhjiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gZj+Ic+ZnnOAMniy"
Content-Disposition: inline
In-Reply-To: <CAKmqyKO6ioRt+h_tZrudbriv-QDVsOG1LNJ+GFQJ3ZO-fEhjiA@mail.gmail.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--gZj+Ic+ZnnOAMniy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 09:30:00AM +1000, Alistair Francis wrote:
> On Wed, Feb 25, 2026 at 9:39=E2=80=AFPM Mohamed Mediouni
> <mohamed@unpredictable.fr> wrote:
> >
> >
> >
> > > On 25. Feb 2026, at 11:20, Djordje Todorovic <Djordje.Todorovic@htecg=
roup.com> wrote:
> > >
> > > This series adds big-endian (BE) RISC-V target support to QEMU,
> > > covering both softmmu and linux-user emulation for riscv32be and
> > > riscv64be.
> > Hello,
> >
> > There=E2=80=99s no Linux RISC-V big endian. Maybe the right thing to do=
 is to not
> > support it unless we=E2=80=99re sure that it can get to Linux upstream =
(for the linux-user mode)?
>=20
> Agreed. We really need upstream Linux support before user mode

On that front, Ben posted patches for it and Linus was really really not
enthused when he became aware of it:
https://lore.kernel.org/linux-riscv/066d70c7-b0a7-45e5-9337-17901bc95664@co=
dethink.co.uk
Even without Linus' take, I feel like there's absolutely no chance of
upstream support without meaningful shipping hardware that requires
big endian support, because basically everyone else was also opposed to
adding it...

--gZj+Ic+ZnnOAMniy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaDbiwAKCRB4tDGHoIJi
0rINAP9yG8+9ECZE+UfxszdFsgCbYk3J6AhWNYdYrb7I7UNFCQEArD5Xh4tZavn3
LJlgm53gyMVCkZWCo85Mr5dRVezulgY=
=CmFQ
-----END PGP SIGNATURE-----

--gZj+Ic+ZnnOAMniy--

