Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E47CEE642E
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 12:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vav6l-0007b7-0x; Wed, 31 Dec 2025 07:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1vav6i-0007aB-Hr
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 07:15:17 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1vav6f-0001SV-4D
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 07:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=zyqYspTk4ShPlAwubOTQ0hR1Yr0yrJQULxTIexZJ4ro=; b=0eP5iuvRjzsqulRKnymZ0Wog7c
 jESNrHkxTXgqJS39/nr/UQ71RMwj2OMU/CPNQnqVFt/LSDLNgIhSLgbubKbHuRxHrlWgi+YY4HU37
 N1NfwHS9hFoLB1MCDhDegaxA6pwqDzYEjGjrfpJG9kK5vs4nz8xhfBjGPb4OxGMXaWVprpDO7J+O+
 JAgsdJfd5uuH89ordbzbtQT5CjNBUmVY1i6pwPK++LzPLsR+2fNxVxIP612q6/Dq3EfpLGHCIjSLc
 nG5K77nCScmXSI62SjrGvD52RpmBXIBEtSZXDgmvWooA52bbmCTVVla23JBXnFQXStidjI0+KP2io
 27gPYfgw==;
Received: from [2a01:e34:ec5d:a742:6075:34ff:c68a:2cc7] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1vav6S-00000005jaz-3cXJ;
 Wed, 31 Dec 2025 13:15:00 +0100
Date: Wed, 31 Dec 2025 13:15:00 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Rob Landley <rob@landley.net>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Thorsten Glaser <tg@debian.org>, Michael Tokarev <mjt@tls.msk.ru>,
 security@debian.org,
 Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>,
 debian-superh@lists.debian.org
Subject: Re: qemu-system-sh4eb build has something hinky in the ethernet
Message-ID: <aVUTxBo4kXakotuC@aurel32.net>
Mail-Followup-To: Rob Landley <rob@landley.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Thorsten Glaser <tg@debian.org>, Michael Tokarev <mjt@tls.msk.ru>,
 security@debian.org,
 Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>,
 debian-superh@lists.debian.org
References: <aKi6IWVX2uIlGKnw@seger.debian.org>
 <Pine.BSM.4.64L.2508230023030.21591@herc.mirbsd.org>
 <6abe2750-5e2c-43a1-be57-1dc2ccabdd91@tls.msk.ru>
 <119d5858-52f4-ce1b-9ee7-9615ce2054b9@debian.org>
 <79f14fef-123f-4938-b069-10f07e7d0405@landley.net>
 <CAMuHMdXZNroJF=s8gXj_vguGPGjUvgLu7w2PZxQg9tcHtSkNyg@mail.gmail.com>
 <351ebd4d-8ec6-43fe-b308-a0e54801a33b@linaro.org>
 <6b3fdecb-739b-4149-8736-2fb6bd209d10@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6b3fdecb-739b-4149-8736-2fb6bd209d10@landley.net>
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Hi,

This discussion is specific to the SuperH port, therefore please avoid=20
mailing debian-ports@lists.debian.org, which targets all ports. I have=20
already adjusted the address in Cc: to debian-superh@lists.debian.org.

Thanks
Aurelien

On 2025-12-31 02:04, Rob Landley wrote:
> On 11/24/25 01:18, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 1/9/25 09:47, Geert Uytterhoeven wrote:
> >=20
> > > On Sun, 24 Aug 2025 at 20:40, Rob Landley <rob@landley.net> wrote:
> > > > Anyway, this works fine on little endian, but the qemu-system-sh4eb
> > > > build has something hinky in the ethernet, I haven't tackled it mys=
elf
> > > > because I don't know whether the device emulation or the driver is
> > > > what's missing an endian swap. (I don't want to fix it the "wrong w=
ay",
> > >=20
> > > That is using sh_eth, right?
> > >=20
> > > Last time I tried booting a big-endian ARM kernel on R-Car M2-W,
> > > the Linux kernel booted fine, except for Ethernet.=C2=A0 So sh_eth is
> > > definitely
> > > not big-endian clean.
> >=20
> > qemu-system-sh4{eb} only emulates the R2D+ board, which AFAIK
> > provides ethernet via a RTL8139 over PCI. While old, RTL8139
> > is very tested and expected to have endianness well handled.
>=20
> Expected, sure. In reality? Compare the sh4 vs sh4eb tarballs in
> https://landley.net/bin/mkroot/0.8.13/ (in each case extract and
> ./run-qemu.sh should get you a shell prompt).
>=20
> The sh4 one has working ethernet, the sh4eb one always reports link down =
and
> it doesn't seem to probe the mac address right. Built from almost the same
> configs, the only difference is:
>=20
> https://github.com/landley/toybox/blob/0.8.13/mkroot/mkroot.sh#L297
>=20
> Line 305 adds:
>     [ "$CROSS" =3D=3D sh4eb ] && KCONF+=3D,CPU_BIG_ENDIAN
>=20
> When I tried to track it down, I didn't know if the kernel or qemu was wh=
at
> had it backwards, so it went back on the todo heap and composted...
>=20
> > > [*] I didn't have a big-endian userspace.
>=20
> That script builds one, the resulting binary tarball is at
> https://landley.net/bin/mkroot/0.8.13/sh2eb.tgz and the toolchain I used =
is
> at
> https://landley.net/bin/toolchains/25-03-2024/sh4eb-linux-musl-cross.tar.=
xz
> which was built with https://landley.net/toybox/faq.html#cross2
>=20
> There might also be something wrong with -hda block device support, I'd h=
ave
> to check my notes. But I can work around lack of -hda with nbd-server, ki=
nda
> hard to do it the other way...
>=20
> Rob
>=20
>=20

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

