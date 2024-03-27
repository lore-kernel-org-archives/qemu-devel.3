Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B11DCD1283
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 11:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpRJq-0007fM-0U; Wed, 27 Mar 2024 07:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rpRJm-0007eT-UF; Wed, 27 Mar 2024 07:19:43 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rpRJk-0005pk-UZ; Wed, 27 Mar 2024 07:19:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5237161505;
 Wed, 27 Mar 2024 11:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6AFC43399;
 Wed, 27 Mar 2024 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711538371;
 bh=hpYMPCMSZ0AeL/zkjNKXlOYlaTMtA4U1a/RTpBTUC0g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qz1EXefDCf5HKfFlUW1L3wgcSuYcr3HtxTgTfspHaBXI37JDDunyzmJvkat0Ebvjr
 l7U6eaZ2YwAjAHXBNmAgwZWmnQLsl8749oGFm8trhA2Ctyzzrr01FJboHLvOHZImoo
 C+TTHIxh7zxwV4oWNcSoDBpYzVd0xmy7qdgb6kltqO/02Jb3/oK2rYbCKOpFeFPHJI
 rFaAy7iLbOsnMuG47f/L+ZrTcEPz9A+yQx1Ocegle8WUXSZrMDXSFjiKXnlQHupd1e
 ot9DDPnhC9LFUxTady/YmOLP5OGY3WEVfHSDl9VQrg4jmkXmtKM3hSZzzE8EtuNy63
 H0WZd/6g8lAbw==
Date: Wed, 27 Mar 2024 11:19:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Alistair.Francis@wdc.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, qemu-riscv@nongnu.org, bjorn@kernel.org,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: Re: [PATCH v2 2/2] target/riscv: Support xtheadmaee for thead-c906
Message-ID: <20240327-overrun-outcast-795708a30e8c@spud>
References: <20240204054228.651-1-zhiwei_liu@linux.alibaba.com>
 <20240204054228.651-3-zhiwei_liu@linux.alibaba.com>
 <CAKmqyKNGMjLg+JjJZAp+EsmfaWAyT7XiHZzBXZxeghS0hv6REg@mail.gmail.com>
 <CAEg0e7i6zaEhyfhRFKcTYjkCqRCzJ5eB+0EHUDVA6t-ypL78eg@mail.gmail.com>
 <CAKmqyKPgAQ4JaSNRmFfR-=w3daDkag-ORz0Ckn7r1JNmf8X2oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OGEGKiDEjtufCwoP"
Content-Disposition: inline
In-Reply-To: <CAKmqyKPgAQ4JaSNRmFfR-=w3daDkag-ORz0Ckn7r1JNmf8X2oA@mail.gmail.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=conor@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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


--OGEGKiDEjtufCwoP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Christoph linked here on his submission to Linux of a fix for this, so I
am reviving this to leave a couple comments :)

On Thu, Feb 15, 2024 at 02:24:02PM +1000, Alistair Francis wrote:
> On Mon, Feb 5, 2024 at 6:37=E2=80=AFPM Christoph M=C3=BCllner
> <christoph.muellner@vrull.eu> wrote:
> > On Mon, Feb 5, 2024 at 3:42=E2=80=AFAM Alistair Francis <alistair23@gma=
il.com> wrote:
> > > On Sun, Feb 4, 2024 at 3:44=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.a=
libaba.com> wrote:

> > > >              ppn =3D (pte & (target_ulong)PTE_PPN_MASK) >> PTE_PPN_=
SHIFT;
> > >
> > > Unfortunately we won't be able to take this upstream. This is core
> > > QEMU RISC-V code that is now being changed against the spec. I think
> > > adding the CSR is fine, but we can't take this core change.
> > >
> > > A fix that works for everyone should be supporting the th_mxstatus
> > > CSR, but don't support setting the TH_MXSTATUS_MAEE bit. That way
> > > guests can detect that the bit isn't set and not use the reserved bits
> > > in the PTE. From my understanding the extra PTE bits are related to
> > > cache control in the hardware, which we don't need here
> >
> > Sounds good! Let me recap the overall plan:
> > * QEMU does not emulate MAEE, but signals that MAEE is not available
> > by setting TH_MXSTATUS_MAEE to 0.
>=20
> Yep!
>=20
> > * Consequence: The c906 emulation does not enable any page-base memory
> > attribute mechanism.
>=20
> Exactly
>=20
> > * OpenSBI tests the TH_MXSTATUS_MAEE bit (M-mode only) and provides
> > that information to user-space (e.g. DTB).
>=20
> To the kernel, but yep!
>=20
> > * The current Linux errata code will be enhanced to not assume MAEE
> > for each core with T-Head vendor ID, but also query the MAEE bit and
> > ensure it is set.
>=20
> I feel like it should already do that :)

It doesn't quite do this right now. It only makes the assumption for
CPUs where marchid and mvendorid are zero. The c908, and I think Guo Ren
confirmed it will be the case going forward, sets these to non-zero
values. We should have always required a dt property be set, rather than
using m*id, but we can't go back on that for these devices. Going
forward, if there are more CPUs that want to use this e.g. C908 in MAEE
mode (it can do svpbmt too) I'm gonna require it is explicitly set in
DT.

> > * Booting on a QEMU c906 will not enable MAEE, but will still boot.
>=20
> That's the hope
>=20
> >
> > We never had a complete MAEE implementation upstream, because that's no=
t needed.
> > But until recently we could mess with reserved bits how we want.
> > Now that QEMU is more restrictive about reserved bits in the PTEs, we
> > need to address this in the kernel.
> >
> > The downside is, that the kernel now sees a c906 CPU without MAEE and
> > such a CPU does not exist.
>=20
> Yeah, that is the downside. But in reality a CPU could exist that
> doesn't allow seeing MAEE, so I don't think it's that insane.

Aye, and the case of a new CPU disabling it but not setting m*id will be
a pain.

> > But that's fine, because this does not require extra code to handle thi=
s case.
> > Also, the additional check for the MAEE bit in the kernel errata
> > probing code is likely needed anyway for future T-Head CPUs.
>=20
> Exactly

I don't really want to have extension detection side channels like this
in Linux if it can be at all avoided, I'd rather get this information from
DT or ACPI. The marchid =3D=3D mvendorid =3D=3D 0x0 case has a pretty high =
chance
of needing some special handling in the future though, so something
targeting those cases when there's some demonstrable problem seems fair
to me.

Cheers,
Conor.

--OGEGKiDEjtufCwoP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgQAvgAKCRB4tDGHoIJi
0g6zAQDr2e63E2zIUHZChzpArReUVEUVK9tj42YPk1PtIt0J7QD9G9GvoPCzBD7v
vJBNSplSRr02BZA2M485+RYt06EDDgE=
=uras
-----END PGP SIGNATURE-----

--OGEGKiDEjtufCwoP--

