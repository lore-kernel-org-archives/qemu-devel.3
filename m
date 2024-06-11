Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A981C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGxKQ-0002d5-6N; Tue, 11 Jun 2024 04:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1sGxKN-0002cf-Bc; Tue, 11 Jun 2024 04:58:03 -0400
Received: from dev.gentoo.org ([2001:470:ea4a:1:5054:ff:fec7:86e4]
 helo=smtp.gentoo.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1sGxKK-0001RS-Qc; Tue, 11 Jun 2024 04:58:03 -0400
From: "Andreas K. Huettel" <dilfridge@gentoo.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 LIU Zhiwei <baxiantai@gmail.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: qemu-riscv32 usermode still broken?
Date: Tue, 11 Jun 2024 10:57:37 +0200
Message-ID: <4038765.Mh6RI2rZIc@pinacolada>
Organization: Gentoo Linux
In-Reply-To: <CAKmqyKMRpSis8uaQVs_FTawtC-nwsFj8t7AVjrTNM4DQr-5pYw@mail.gmail.com>
References: <10817413.NyiUUSuA9g@pinacolada> <5239676.BddDVKsqQX@pinacolada>
 <CAKmqyKMRpSis8uaQVs_FTawtC-nwsFj8t7AVjrTNM4DQr-5pYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5471991.R56niFO833";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Received-SPF: pass client-ip=2001:470:ea4a:1:5054:ff:fec7:86e4;
 envelope-from=dilfridge@gentoo.org; helo=smtp.gentoo.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--nextPart5471991.R56niFO833
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: "Andreas K. Huettel" <dilfridge@gentoo.org>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: qemu-riscv32 usermode still broken?
Date: Tue, 11 Jun 2024 10:57:37 +0200
Message-ID: <4038765.Mh6RI2rZIc@pinacolada>
Organization: Gentoo Linux
MIME-Version: 1.0

Hi Alistair,=20

>=20
> Ok!
>=20
> So on my x86 machine I see this
>=20
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D285545,
> si_uid=3D1000, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
> wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) =3D=3D 0}],
> WNOHANG|WSTOPPED|WCONTINUED, NULL) =3D 285545
> wait4(-1, 0x7ffe3eeb8210, WNOHANG|WSTOPPED|WCONTINUED, NULL) =3D 0
> rt_sigreturn({mask=3D[INT]})              =3D 0
> close(3)                                =3D 0
>=20
> It all looks ok.

This was fixed in the meantime (hooray!), sorry I didn't think anyone
would still look at the old thread. The commit is given below.

Since then we've been able to build riscv32 stages for Gentoo just fine
using qemu-user, see
https://www.gentoo.org/downloads/#riscv

Cheers,
Andreas

commit f0907ff4cae743f1a4ef3d0a55a047029eed06ff
Author:     Richard Henderson <richard.henderson@linaro.org>
AuthorDate: Fri Apr 5 11:58:14 2024 -1000
Commit:     Richard Henderson <richard.henderson@linaro.org>
CommitDate: Tue Apr 9 07:43:11 2024 -1000

    linux-user: Fix waitid return of siginfo_t and rusage
   =20
    The copy back to siginfo_t should be conditional only on arg3,
    not the specific values that might have been written.
    The copy back to rusage was missing entirely.
   =20
    Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2262
    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
    Tested-by: Alex Fan <alex.fan.q@gmail.com>
    Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>



>=20
> Maybe the host_to_target_siginfo() function in QEMU is the issue?
> Something in here?
> https://github.com/qemu/qemu/blob/master/linux-user/signal.c#L335
>=20
> Nothing jumps out with a quick look though
>=20
> Alistair
>=20
> >
> >
> >
> > --
> > Andreas K. H=FCttel
> > dilfridge@gentoo.org
> > Gentoo Linux developer
> > (council, toolchain, base-system, perl, libreoffice)
>=20


=2D-=20
Andreas K. H=FCttel
dilfridge@gentoo.org
Gentoo Linux developer
(council, toolchain, base-system, perl, libreoffice)
--nextPart5471991.R56niFO833
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQKTBAABCgB9FiEE/Rnm0xsZLuTcY+rT3CsWIV7VQSoFAmZoEYFfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEZE
MTlFNkQzMUIxOTJFRTREQzYzRUFEM0RDMkIxNjIxNUVENTQxMkEACgkQ3CsWIV7V
QSr7Ug/+JedTyiXKUdMnVtDB7wGQB1tysRevlKHd3hYSTGQO4mxMC9lKRg8DneCM
TQjYl8a/WhkVKqQj/m6LnzKIgP6f1zT5KXqdSGwF+crQEe4JRWtSVHa7iKkPlGm9
3DiJCvWqtEM6eraOzkziF51zfamaWsbOopnwIN3YEqSCKff/otn5sRsSPJndtHJy
NkfQ3bVj9WWllSobDmcAq8ri5lMKnPJOnaDzNNJ5F8B1iIukfTatYBcpp2HyXU6/
+sAglZNF5JVM6cjtZeg6fooNcFiylCFSPjg2qr4pHUJMIDRk8uyRhh/AyEZH0wle
8L0l92PxZ99oXq4PCt6betkDyX2tXrR+zGF/H8xp90Y6cMLFILQh95lxhUTtDLWX
peycwWVBVVEepUHGsNYkuy/J1PQHeZPWhlU8maAfTlf4Ns4NSbNax2JptJUHSsZr
I2D6t9sK1S7lIp+lsdPpFmIh5i4+qCnSEZ4ZK8GGxvdh7TdRgX3iZM6m+ZQ+6ZCk
1iYHybiKkg0+bigDwGa8gLwrP/hUFcXUUORoY1TFN3LqWSSEoSMeZELQkbF9hFQp
pFCoFkTK5t8t5gt/IE3nmdUg3vYNHeWdhl8ps4u4fHyZ/LbAKM/aNQgjKmP1KbW1
nKgNyCVUlo5s+l+esFiTjFoBDhQXUqv/GnkWjlMGsQKR5vSCSVE=
=agI0
-----END PGP SIGNATURE-----

--nextPart5471991.R56niFO833--




