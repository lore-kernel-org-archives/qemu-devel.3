Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0FAFEFB47
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxOX-0002FS-9E; Fri, 27 Feb 2026 07:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1vvxOW-0002F2-0E; Fri, 27 Feb 2026 07:56:36 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1vvxOT-0002sv-EQ; Fri, 27 Feb 2026 07:56:35 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F95B437C6;
 Fri, 27 Feb 2026 12:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2186BC2BC9E;
 Fri, 27 Feb 2026 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772196991;
 bh=dMIdCGLMjW1mH7Ui/T93D0llAw6sJxNHz+M3HNpSRxI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ojvxTqjbwaVyiWGaEuUD/igIRrX9pzPoUwjgvqBh1cMvbFp8zQJUjO/OnRVfAoTNd
 g9MZmjlv1nRVLKKC5UhpQ1dKY+lTR2w8gfCTWH2JWOlP1y/Wy0B+wfGdE56wLdzFT5
 sg9YDln2FPsEnbXo4gWqO+lYVUyqkBgQscHayHVWOZ2Eejb4QJyj6Zr6wG7ks7Y8wt
 8wQRmMeCt2kUbErUEosydHryNfxeiO+htVnZkuhsLaf/w0uCHMSUaMvrz/aCsajTCw
 zXe1Hx4Ty6WVcgW7VO0QzvYsYnP/lQnl56JotSllwGipROrnjmVlwWaelMVb0Ylfvj
 vMNWvWZ1+4yjg==
Date: Fri, 27 Feb 2026 12:56:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v2 00/16] Add RISC-V big-endian target support
Message-ID: <20260227-dandruff-chemicals-4b3d22ca6354@spud>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <A02120BF-779D-4B2C-B29D-A9CB044EA895@unpredictable.fr>
 <CAKmqyKO6ioRt+h_tZrudbriv-QDVsOG1LNJ+GFQJ3ZO-fEhjiA@mail.gmail.com>
 <20260226-hangout-satin-fd7913f18f2b@spud>
 <CAKmqyKNST9ExmpcFE3iejmzZZRtMNSiVXkzfUK4GhhcketrCEw@mail.gmail.com>
 <de767b4f-93f2-47b1-8813-d1c063a30759@htecgroup.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4h5M8rZycvRQ+rzv"
Content-Disposition: inline
In-Reply-To: <de767b4f-93f2-47b1-8813-d1c063a30759@htecgroup.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=conor@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--4h5M8rZycvRQ+rzv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 12:42:21PM +0000, Djordje Todorovic wrote:
>=20
> On 2/27/26 01:56, Alistair Francis wrote:
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you recognize the sender and know t=
he content is safe.
> >
> >
> > On Fri, Feb 27, 2026 at 9:47=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> >> On Fri, Feb 27, 2026 at 09:30:00AM +1000, Alistair Francis wrote:
> >>> On Wed, Feb 25, 2026 at 9:39=E2=80=AFPM Mohamed Mediouni
> >>> <mohamed@unpredictable.fr> wrote:
> >>>>
> >>>>
> >>>>> On 25. Feb 2026, at 11:20, Djordje Todorovic <Djordje.Todorovic@hte=
cgroup.com> wrote:
> >>>>>
> >>>>> This series adds big-endian (BE) RISC-V target support to QEMU,
> >>>>> covering both softmmu and linux-user emulation for riscv32be and
> >>>>> riscv64be.
> >>>> Hello,
> >>>>
> >>>> There=E2=80=99s no Linux RISC-V big endian. Maybe the right thing to=
 do is to not
> >>>> support it unless we=E2=80=99re sure that it can get to Linux upstre=
am (for the linux-user mode)?
> >>> Agreed. We really need upstream Linux support before user mode
> >> On that front, Ben posted patches for it and Linus was really really n=
ot
> >> enthused when he became aware of it:
> >> https://lore.kernel.org/linux-riscv/066d70c7-b0a7-45e5-9337-17901bc956=
64@codethink.co.uk
> >> Even without Linus' take, I feel like there's absolutely no chance of
> >> upstream support without meaningful shipping hardware that requires
> >> big endian support, because basically everyone else was also opposed to
> >> adding it...
> > Yeah... I saw that.
> >
> > A few thoughts, just because Linus doesn't like it doesn't mean QEMU
> > can't support it. But I am hesitant to support BE considering the lack
> > of ecosystem support everywhere else.
>=20
>=20
> Please be aware that MIPS will ship hardware based on riscv BE
>=20
> soon:=C2=A0https://mips.com/products/hardware/i8500/

Not the meaning of "hardware" I was using, as this appears to be a core
complex IP rather than physical hardware? Do you know of any devices,
outside of a MIPS test chip or w/e, that are going to use this IP?

On the linux support front, the devils advocate take would be that
people should just run this core in LE mode, but that's a bridge to be
crossed when someone produces an SoC using that core complex and on
another mailing list!

--4h5M8rZycvRQ+rzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaGUdwAKCRB4tDGHoIJi
0jmAAP99PMmN6qoj+F4Yu32cK3ksL4cgiIhJ85W2IsAYg6qkzQD/XJDPylQU15Hj
W/0CQ1gyEN2mpT61GzZDqZqUwReqngw=
=cyXL
-----END PGP SIGNATURE-----

--4h5M8rZycvRQ+rzv--

