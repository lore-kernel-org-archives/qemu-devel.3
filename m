Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3916CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 07:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNR4v-0004P1-G5; Mon, 24 Nov 2025 02:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1vNR4h-0004NV-IM
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:33:29 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1vNR4c-0007PD-7V
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
 Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=CXWZ7eHX/uVsdXQKAmkDPy7ISULZLvTWwTXUhR/MDWM=; t=1763969602;
 x=1764574402; b=Qk/g0xHCJoqMDKfV7ZyfMoxYT+HIgEatdXmFufEvn2XYQQdVx11j/tIreBtyj
 CM8UHBU6hTsqMCsU1ZDjWCFursD5YK9Zv76uWjvpZI6EmrNZOIJ9BVQgDvpScHGIS+1vo+axZnMkA
 16D+nIQm17BQOA75YFZE7b4ChjY4T4rGU7jP/os4KjaQHdsow7FwuktnYk428s+tGy0ol07jFsfRR
 PjTZSuuGom2mxVQPDLghv4s7Xa/wUVTchZHqdmVOcM0SSTS2ulz+7cvIiwF0C8MaAamAtILijchuw
 +TWR1nMwEgyjolzY4lRZmvX4ubTzxKkcPnZFAfWUP1QSK6MKLQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.99) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1vNR4S-00000001k4q-0REM; Mon, 24 Nov 2025 08:33:12 +0100
Received: from dynamic-077-011-209-238.77.11.pool.telefonica.de
 ([77.11.209.238] helo=[192.168.178.50])
 by inpost2.zedat.fu-berlin.de (Exim 4.99) with esmtpsa (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1vNR4R-00000003YlD-3fpx; Mon, 24 Nov 2025 08:33:12 +0100
Message-ID: <91b74af52f69c360a27269ab3145eeb377ef816a.camel@physik.fu-berlin.de>
Subject: Re: 64mb limitation of qemu-system-sh4 board
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Rob
 Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>, Michael Tokarev
 <mjt@tls.msk.ru>,  QEMU Developers <qemu-devel@nongnu.org>
Cc: security@debian.org, Debian QEMU Team	
 <pkg-qemu-devel@lists.alioth.debian.org>, debian-ports@lists.debian.org, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org
Date: Mon, 24 Nov 2025 08:33:11 +0100
In-Reply-To: <b42433a7-e102-43f7-a7fa-1c9417a21146@linaro.org>
References: <aKi6IWVX2uIlGKnw@seger.debian.org>
 <Pine.BSM.4.64L.2508230023030.21591@herc.mirbsd.org>
 <6abe2750-5e2c-43a1-be57-1dc2ccabdd91@tls.msk.ru>
 <119d5858-52f4-ce1b-9ee7-9615ce2054b9@debian.org>
 <79f14fef-123f-4938-b069-10f07e7d0405@landley.net>
 <b42433a7-e102-43f7-a7fa-1c9417a21146@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.11.209.238
X-ZEDAT-Hint: PO
Received-SPF: pass client-ip=130.133.4.66;
 envelope-from=glaubitz@zedat.fu-berlin.de; helo=outpost1.zedat.fu-berlin.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Philippe,

On Mon, 2025-11-24 at 08:31 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> On 24/8/25 20:07, Rob Landley wrote:
> > On 8/23/25 09:19, Thorsten Glaser wrote:
> > > > There are no alternatives - qemu is unique in this regard.=C2=A0 An=
d
> > > > it has never been designed for this usage.=C2=A0 What we had for 15=
+
> > > > years, unnoticed, is like `chmod u+s /bin/sh`, which is never
> > > > supposed to be used like this.
> > >=20
> > > Perhaps, but there=E2=80=99s shades in between.
> >=20
> > I find qemu system emulation a LOT less problematic.
> >=20
> > For sh4 I boot qemu-system-sh4 and then use a network block device to=
=20
> > provide swap (so the 64mb limitation of the board isn't a limiting=20
> > factor).
>=20
> The R2D+ board uses a SH7751 SoC, which memory controller can access
> 7 external banks. This board has its boot flash on CS#0, a FPGA on CS#1,
> 64MB of SDRAM on CS#3, a SM501 display on CS#4 and some ISA bus on CS#5;
> leaving CS#2, and CS#6 available. CS#2 can have SDRAM, while CS#6 only
> SRAM (not really a difference in emulation).
>=20
>  From QEMU side, we could fill these empty slots with 2*64MB of RAM, so
> the machine could use up to 192MB. But then it is up to the guest to
> use it.
>=20
> Looking at Linux i.e. it seems to hardcode the RAM base/size in
> arch/sh/include/asm/page.h, so we'd need changes there to use more
> memory, which seems unlikely to get for a such old board...

I'm the upstream kernel maintainer for arch/sh and I would be happy to make
the necessary changes to get the Linux kernel support more than 64 MB in
QEMU.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

