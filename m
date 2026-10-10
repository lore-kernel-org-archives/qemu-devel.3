Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49522CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 08:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFSTV-0000ql-2B; Sat, 10 Oct 2026 04:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xFSTF-0000gx-0l
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 04:30:27 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xFSTC-0000FW-9F
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 04:30:19 -0400
Message-ID: <0fe42d81618fc6e7a229c9c3efcbf9310987f89d.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1791621007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cSkXk3kF81GRdS/pcArbC+c54Jy/Bf6hKdphUw/vZ8Q=;
 b=LCXN0A9nOkd1HCKb0XQXzL74e324lApDrPsqoSdS+OO09gchL/gN20pZGsyWyu9/P58a2l
 gCXGs6++qLEV/NLoiM57im//ff8RGLK2onh+m87wEYk/kG3PH/9YpcID504U2VJ75azWrj
 Z9gr0TRCRa+aJouQSXzMclCMHSzNh/E=
Subject: Re: [RFC] target/sparc: crypto instructions for Linux kernel testing
From: Stian Halseth <stian@itx.no>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Eric Biggers <ebiggers@kernel.org>
Date: Sat, 10 Oct 2026 10:30:02 +0200
In-Reply-To: <764a9ecd-6856-4309-9ae3-8f878a9b1d8a@linaro.org>
References: <63d84da88caec4176900e535116d64b1c4cffffb.camel@itx.no>
 <764a9ecd-6856-4309-9ae3-8f878a9b1d8a@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-uEtGwWdR/kam5/vm0+lC"
MIME-Version: 1.0
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


--=-uEtGwWdR/kam5/vm0+lC
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Sat, 2026-10-10 at 09:30 +0200, Richard Henderson wrote:
>=20
> When I implemented the VIS{3,4} stuff a couple of years ago, I tried
> to add a newer cpu (though I forget which model).=A0 I couldn't get a
> kernel to boot with that and sun4u, so in the end I left the cpu out
> and left the extensions as plain cpu features.
>=20
> The biggest problem with sun4v is that it's incomplete.=A0 It has the
> most promise as an emulation platform because it is explicitly a
> hyper<v<isor platform.=A0 In the ideal case, QEMU would not faithfully
> model the hardware, but would instead model the hypervisor
> interface.=A0 Which would make lots of stuff far easier and quicker to
> emulate -- most notably the TLB.


I agree. I looked into the sun4v hypervisor first, as that sounded like
the ideal approach. I did however come to realize, as you say, that it
would be a lot of work. Also there is the requirement for bundling the
OpenSPARC firmware and building a boot image (no -kernel), which is a
bit overkill for kernel testing.=20

Based on that reasoning I've already done some experimenting, by
writing the crypto code for sun4u. Much of the code would be shared
either way, so if the sun4u approach was rejected, I would still be
able to use much of it.
I've managed to get it working well enough to exercise the crypto
tests. It's not in a upstreamable state yet, still work in progress. I
took some shortcuts just to get to a proof of concept, and I wasn't
sure it would every be finished with this approach.

>=20
> But it's a big packet of work and no one has done it.
>=20

Indeed, and much more than what is needed to achieve the goal of
getting the crypto tests running, so would be out of scope for me, at
least.

If you would be willing to accept a contribution based on my described
sun4u approach, I could spend some time cleaning it up and run more
thorough tests to iron out any remaining issues (which I'm sure there
are).

Mark, for this to work Linux needs a hwcap-list property on the cpu
node before it uses the instructions. =A0What are your thougts about QEMU
passing the list in a fw_cfg file, with OpenBIOS adding the property in
cpu_generic_init()?=A0

/Stian

--=-uEtGwWdR/kam5/vm0+lC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCasn3igAKCRDoeAEuJe36
VpH8APwJmC/gE0t1Lp3Y9wx71G7EXVzYFtaFlj4PC3zgpWqc9wEAjMEdJtgaq3HD
F1/GWv0DsL85OsrNTxfa4beaNC7YUAo=
=AvUP
-----END PGP SIGNATURE-----

--=-uEtGwWdR/kam5/vm0+lC--

