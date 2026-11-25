Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4903E606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdac.in header.i=@cdac.in header.a=rsa-sha256 header.s=default header.b=KqEeg4QS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW5QC-0005LY-W2; Wed, 25 Nov 2026 00:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xW5QA-0005Kj-7S; Wed, 25 Nov 2026 00:19:54 -0500
Received: from mailsender.cdac.in ([196.1.113.117]
 helo=mailsender-core1.pune.cdac.in)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xW5Q6-00062p-7X; Wed, 25 Nov 2026 00:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
 t=1795583974; bh=ztiWZA7m853OxS4NZ6HX1aYuI5MQbDCrYYipM+g8Km4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=KqEeg4QSdM2qiwxP17EJ/Lp72OSNggDOX3mDdVQCHM95xOal56Kwi8PPsVrnkbhfZ
 p2kQmVKG1bCEI00y9x28DqoG2N01u+Jmj4qsqyfwX7nj0b2xFPwjYV6WE694yjek8A
 TIQkvxK611KU6SYvjuNyNLqoPD6DTt+RkagWzvGE=
Received: from mscr-int2.pune.cdac.in (mscr-int2.pune.cdac.in [10.208.193.12])
 by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 6AP5JXF0426099; Wed, 25 Nov 2026 10:49:33 +0530
Received: from mailgw-cip.pune.cdac.in (mscr-haproxy.pune.cdac.in
 [10.208.193.46])
 by mscr-int2.pune.cdac.in (Postfix) with ESMTP id 6F1BE10093553;
 Wed, 25 Nov 2026 10:48:42 +0530 (IST)
Received: from webmail2 (unknown [10.208.193.8])
 by mailgw-cip.pune.cdac.in (Postfix) with ESMTPS id 904C214E01D9;
 Wed, 25 Nov 2026 10:48:37 +0530 (IST)
Date: Wed, 25 Nov 2026 10:48:19 +0530 (IST)
From: Karthika B <karthika.b@cdac.in>
To: Alistair <alistair@alistair23.me>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Message-ID: <638251604.134327.1795583900339@webmail2.cdac.in>
In-Reply-To: <54fb26d98d3072005b7d0ada3a39e30be7579c78.camel@alistair23.me>
References: <385625713.441366.1761727810206@webmail2.cdac.in>
 <20261016080709.17331-1-karthika.b@cdac.in>
 <efc72269be92a118b39a7190003aa167fbbae579.camel@alistair23.me>
 <1877215787.132651.1795579446420@webmail2.cdac.in>
 <54fb26d98d3072005b7d0ada3a39e30be7579c78.camel@alistair23.me>
Subject: Re: [PATCH 0/7] RISC-V: Add CDAC VEGA machine support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.4-Rev30
X-Originating-Client: open-xchange-appsuite
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more
 information
X-CDAC-PUNE-MailScanner-ID: 6F1BE10093553.A09C4
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-1, required 6, ALL_TRUSTED -1.00)
X-CDAC-PUNE-MailScanner-From: karthika.b@cdac.in
Received-SPF: pass client-ip=196.1.113.117; envelope-from=karthika.b@cdac.in;
 helo=mailsender-core1.pune.cdac.in
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alistair,

Thanks for the reply. Just to clarify one thing on 23 October, we sent a
detailed response addressing each of your original points (maintainership
status, the PLIC/CLINT register layout, BBL vs OpenSBI, and the AI usage
question), along with two follow-up patches, as a reply in this thread
rather than a separate v2:

https://lore.kernel.org/qemu-riscv/?q=3Dvega

I want to check whether that reply reached you, since your latest message
only quotes from my message today. If you did see it, no need to revisit
anything. I just want to make sure nothing was missed on our end.

Thanks,
Karthika

> On 11/25/2026 10:15 AM Alistair <alistair@alistair23.me> wrote:
>=20
>=20=20
> On Wed, 2026-11-25 at 09:34 +0530, Karthika B wrote:
> >=20
> > Hi Alistair,
> >=20
> > Checking in on this thread. Wanted to ask whether the patches are
> > still under consideration, or if anything further is needed from our
> > side. In particular, I'd like to confirm whether the follow-up
>=20
> They are not under consideration. I left some comments and I don't see
> a v2 that addresses those.
>=20
> > patches (the CPU fix and the OpenSBI test) looked correct, and
> > whether our response on the AI-policy question was sufficient, or if
> > there's anything there you'd like us to clarify or change.
>=20
> The code breaks QEMU's current AI policy, so can not be merged. The
> policy seems to be changing soon, so it's possible it could be merged
> in the future, but that isn't for certain.
>=20
> Alistair
>=20
> >=20
> > Happy to provide any further detail.
> >=20
> > > On 10/19/2026 7:11 AM Alistair <alistair@alistair23.me> wrote:
> > >=20
> > > =C2=A0
> > > On Fri, 2026-10-16 at 13:37 +0530, Karthika B wrote:
> > > > This series adds QEMU machine support for VEGA, a RISC-V SoC
> > > > family
> > > > developed by C-DAC (Centre for Development of Advanced Computing,
> > > > India) as part of the DIR-V processor program.
> > > > VEGA series of microprocessors are developed as part of the
> > > > Microprocessor Development Programme, initiated and funded by
> > > > MeitY
> > > > (Ministry of Electronics and Information Technology, Government
> > > > of
> > > > India), with the mission objective to design and develop
> > > > indigenously a family of microprocessors, related IPs, and the
> > > > complete ecosystem to enable fully indigenous product development
> > > > catering to various requirements in the strategic, industrial,
> > > > and
> > > > commercial sectors. VEGA is developed at C-DAC,
> > > > Thiruvananthapuram.
> > > >=20
> > > > Background
> > > > ----------
> > > > VEGA is a series of 32-bit and 64-bit single/multi-core RISC-V
> > > > processors (Thejas32 and Thejas64) developed under the DIR-V
> > > > program,
> > > > integrated with multi-level caches, an MMU, and a coherent
> > > > interconnect on real silicon. This series adds a QEMU 'vega'
> > > > machine
> > > > model supporting both the Thejas32 (RV32) and Thejas64 (RV64)
> > > > variants, modelled on real silicon behaviour rather than a
> > > > synthetic/virtual platform.
> > >=20
> > > Thanks for the series. It's cool to see some more RISC-V designs.
> > >=20
> > > Thank you for submitting the patches.
> > >=20
> > > For some context, we already have support for a Shakti machine, and
> > > that is being deprecated and removed as it hasn't been maintained
> > > by
> > > the original submitter.
> > >=20
> > > I also noticed that you listed yourself as "Odd Fixes" in the
> > > maintainers file, so this won't be accepted.
> > >=20
> > > We don't have the resource to maintain your custom board and
> > > reviewers
> > > are stretched very thin to look at your patches. If you don't want
> > > to
> > > maintain it, we aren't going to be able to either.
> > >=20
> > > >=20
> > > > More details on the VEGA processor series:
> > > > =C2=A0 https://vegaprocessors.in/
> > > > VEGA documentation:
> > > > =C2=A0 https://cdac-vega.gitlab.io/
> > > >=20
> > > > The model has been validated against Aries boards (Thejas32) and
> > > > Thejas64 SoCs, booting:
> > > > =C2=A0 - bare-metal ELF payloads via -bios (no DTB, fixed UART
> > > > framing),
> > > > =C2=A0=C2=A0=C2=A0 for both RV32 and RV64, using the VEGA SDK's exa=
mple UART
> > > > =C2=A0=C2=A0=C2=A0 "hello world" application
> > > > =C2=A0 - Linux via BBL with a user-supplied -dtb describing the SoC
> > > > (RV64)
> > >=20
> > > No BBL, please use OpenSBI or an equivalent
> > >=20
> > > >=20
> > > > What's included
> > > > ----------------
> > > > =C2=A0- hw/riscv/vega.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 - machine model, device creation,
> > > > boot
> > > > flow.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Note: VEGA does not gen=
erate its
> > > > device
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tree internally; -dtb is
> > > > required
> > > > for any
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -kernel boot (see note =
below)
> > > > =C2=A0- hw/intc/vega_plic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - CDAC PLIC variant (register
> > > > layout
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 differs from the generic
> > > > riscv,plic0;
> > >=20
> > > Why?
> > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 see patch N/N for detai=
ls)
> > > > =C2=A0- hw/intc/vega_aclint.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ACLIN=
T MSWI/SSWI/MTIMER, with the
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STIMECMP handling VEGA'=
s boot
> > > > ROM /
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BBL relies on
> > > > =C2=A0- target/riscv/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - adds TYPE_RISCV_CPU_VEGA32 and
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_RISCV_CPU_VEGA64, =
CPU
> > > > subtypes
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 baking in VEGA's fixed =
baseline
> > > > (IMA
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S/U + Zicsr/Zifencei +
> > > > SV32/SV39),
> > > > so
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -M vega boots on either
> > > > architecture
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 without a manual -cpu s=
tring;
> > > > see
> > > > note
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 below on why both are p=
arented
> > > > on
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sifive-u rather than th=
e generic
> > > > base
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU type
> > > > =C2=A0- docs/system/riscv/vega.rst - user-facing documentation
> > > > =C2=A0- tests/functional/riscv32/test_vega.py,
> > > > =C2=A0=C2=A0 tests/functional/riscv64/test_vega.py
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - functional tests booting -M vega
> > > > on
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 both architectures (bar=
e-metal
> > > > on
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 both; bare-metal + Linu=
x/BBL on
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv64), fetching smal=
l test
> > > > binaries
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from a stable, checksum=
med
> > > > external
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asset repository
> > > > =C2=A0- MAINTAINERS entry
> > > >=20
> > > > Notable hardware characteristics reviewers should know up front
> > >=20
> > > Have you read QEMU's AI policy?
> > >=20
> > > https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai=
-generated-content
> > >=20
> > > > -----------------------------------------------------------------
> > > > =C2=A0- The PLIC and CLINT/ACLINT are co-located at the same base
> > > > address
> > > > =C2=A0=C2=A0 on real VEGA silicon (0x20010000). This is not a QEMU
> > > > modelling
> > > > =C2=A0=C2=A0 error; it reflects the actual SoC memory map.
> > >=20
> > > What? Why?
> > >=20
> > > > =C2=A0- The PLIC aperture is 0x400 bytes, sized for the current
> > > > maximum
> > > > =C2=A0=C2=A0 hart count on this SoC family; it is not the generic u=
pstream
> > > > PLIC
> > > > =C2=A0=C2=A0 aperture size.
> > > > =C2=A0- UART register framing differs between boot modes: bare-metal
> > > > always
> > > > =C2=A0=C2=A0 uses shift=3D2/io-width=3D4 (fixed 32-bit stride), whi=
le Linux
> > > > boot
> > > > =C2=A0=C2=A0 reads reg-shift from the DTB serial node, since the tw=
o boot
> > > > paths
> > > > =C2=A0=C2=A0 exercise the hardware through different firmware layer=
s.
> > > > =C2=A0- TYPE_RISCV_CPU_VEGA32/VEGA64 are parented on
> > > > TYPE_RISCV_CPU_SIFIVE_U
> > > > =C2=A0=C2=A0 rather than TYPE_RISCV_CPU_BASE or TYPE_RISCV_BARE_CPU.
> > > > =C2=A0=C2=A0 TYPE_RISCV_CPU_BASE's default misa_ext includes RVH, a=
nd the
> > > > =C2=A0=C2=A0 class-level misa_ext merge is OR-only (a subtype canno=
t clear
> > > > a
> > > > bit
> > > > =C2=A0=C2=A0 its parent already set), so RVH could not be disabled =
from a
> > > > =C2=A0=C2=A0 TYPE_RISCV_CPU_BASE-derived subtype. TYPE_RISCV_BARE_C=
PU
> > > > avoids
> > > > =C2=A0=C2=A0 that, but unconditionally forces max_satp_mode to 'bar=
e' for
> > > > any
> > > > =C2=A0=C2=A0 CPU in its lineage regardless of what the subtype conf=
igures,
> > > > which
> > > > =C2=A0=C2=A0 breaks paging. TYPE_RISCV_CPU_SIFIVE_U has neither iss=
ue, but
> > > > =C2=A0=C2=A0 silently sets priv_spec to PRIV_VERSION_1_10_0 (an old=
er RISC-
> > > > V
> > > > =C2=A0=C2=A0 privileged spec version) rather than the current one. =
This
> > > > surfaced
> > > > =C2=A0=C2=A0 as a real boot hang against production BBL/DTB pairs (=
BBL's
> > > > =C2=A0=C2=A0 delegate_traps() mideleg assertion failed) that was not
> > > > visible in
> > > > =C2=A0=C2=A0 simpler test boots, since the hang depends on firmware=
 built
> > > > =C2=A0=C2=A0 against a newer priv spec than 1.10.0. Both VEGA CPU s=
ubtypes
> > > > =C2=A0=C2=A0 explicitly override priv_spec back to PRIV_VERSION_LAT=
EST to
> > > > fix
> > > > =C2=A0=C2=A0 this; anyone deriving a new CPU subtype from a SiFive-=
family
> > > > parent
> > > > =C2=A0=C2=A0 should be aware this default does not propagate the wa=
y ISA
> > > > =C2=A0=C2=A0 extension bits might be assumed to.
> > > > =C2=A0- VEGA does not generate a device tree internally. -dtb is
> > > > required
> > > > =C2=A0=C2=A0 for any -kernel (Linux/BBL) boot; the machine errors o=
ut
> > > > clearly
> > > > if
> > > > =C2=A0=C2=A0 a kernel is given without -dtb and without -bios firmw=
are. A
> > > > bare
> > > > =C2=A0=C2=A0 "-M vega" with no boot arguments at all (e.g. qtest's =
generic
> > > > =C2=A0=C2=A0 smoke tests) is a valid, inert state and does not erro=
r. This
> > > > keeps
> > > > =C2=A0=C2=A0 the initial series scoped to what has been directly te=
sted;
> > > > =C2=A0=C2=A0 internal FDT generation may follow as a later series.
> > > > =C2=A0- PLIC and CLINT compatible strings are "cdac,plic-1.0.0" and
> > > > =C2=A0=C2=A0 "riscv,clint0" respectively. CDAC's own Buildroot-based
> > > > BBL/Linux
> > > > =C2=A0=C2=A0 builds use a CDAC-specific PLIC driver matched against=
 the
> > > > former,
> > > > =C2=A0=C2=A0 and use the generic CLINT compatible string directly (=
no
> > > > =C2=A0=C2=A0 CDAC-specific CLINT driver exists in any current VEGA =
firmware
> > > > =C2=A0=C2=A0 variant). A DTB intended to boot stock, unmodified ris=
cv-
> > > > pk/BBL
> > > > =C2=A0=C2=A0 (which only recognises "riscv,plic0" verbatim) will ne=
ed to
> > > > =C2=A0=C2=A0 additionally advertise that generic string for the PLI=
C node.
> > > >=20
> > > > What is NOT included / deliberately left out
> > > > ---------------------------------------------
> > > > =C2=A0- No AIA/APLIC/IMSIC support: current VEGA silicon does not
> > > > implement
> > > > =C2=A0=C2=A0 AIA, so that code path (present in earlier internal re=
visions)
> > > > has
> > > > =C2=A0=C2=A0 been removed rather than left as dead code.
> > >=20
> > > Again, please read the AI code policy
> > >=20
> > > https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai=
-generated-content
> > >=20
> > > Alistair
> > >=20
> > > > =C2=A0- No internal device-tree generation: see note above; -dtb is
> > > > =C2=A0=C2=A0 required for -kernel boots in this series.
> > > > =C2=A0- No SDHCI, SPI, I2C functional models yet: exposed as
> > > > =C2=A0=C2=A0 unimplemented-device stubs matching the real address r=
anges,
> > > > so
> > > > =C2=A0=C2=A0 guest software can probe them safely; functional model=
s may
> > > > follow
> > > > =C2=A0=C2=A0 in later series.
> > > > =C2=A0- No RV32 Linux boot test yet: the functional test suite cove=
rs
> > > > =C2=A0=C2=A0 bare-metal on both architectures and a full Linux/BBL =
boot on
> > > > =C2=A0=C2=A0 riscv64 only, since an RV32 (Thejas32) Linux/BBL boot =
has not
> > > > yet
> > > > =C2=A0=C2=A0 been verified; this may follow in a later series once
> > > > available.
> > > >=20
> > > > Testing
> > > > -------
> > > > =C2=A0- riscv32-softmmu and riscv64-softmmu builds, `make check` cl=
ean
> > > > on
> > > > =C2=A0=C2=A0 both
> > > > =C2=A0- checkpatch.pl clean across the series
> > > > =C2=A0- Functional tests added under
> > > > tests/functional/riscv32/test_vega.py
> > > > =C2=A0=C2=A0 and tests/functional/riscv64/test_vega.py, passing via=
 both
> > > > direct
> > > > =C2=A0=C2=A0 invocation and `meson test` on both architectures:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 - bare-metal "hello world" boot (RV32 and =
RV64)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 - full Linux boot via BBL to a login promp=
t (RV64)
> > > > =C2=A0- Manual testing additionally covered: virtio-net networking,
> > > > and an
> > > > =C2=A0=C2=A0 extended stress-ng run (CPU, matrix, VM, filesystem, d=
evice-
> > > > access
> > > > =C2=A0=C2=A0 stressors) under Linux on -M vega
> > > >=20
> > > > We previously posted an early version of VEGA machine support
> > > > (Message-ID: <385625713.441366.1761727810206@webmail2.cdac.in>)
> > > > without a proper cover letter, MAINTAINERS entry, documentation,
> > > > or
> > > > tests, and sent via a webmail client rather than git send-email,
> > > > which likely affected formatting. This series is a corrected
> > > > resubmission addressing all of that: it is sent via git send-
> > > > email,
> > > > and adds the documentation, MAINTAINERS entry, and functional
> > > > tests
> > > > that were missing before. We've since read and followed
> > > > docs/devel/submitting-a-patch.rst in full. Feedback on process as
> > > > well as code is very welcome.
> > > >=20
> > > > Karthika B (7):
> > > > =C2=A0 hw/intc: Add CDAC VEGA PLIC device model
> > > > =C2=A0 hw/intc: Add CDAC VEGA ACLINT device model
> > > > =C2=A0 target/riscv: Add VEGA32 and VEGA64 CPU types
> > > > =C2=A0 hw/riscv: Add CDAC VEGA machine model
> > > > =C2=A0 docs/system/riscv: Add VEGA machine documentation
> > > > =C2=A0 tests/functional: Add VEGA machine functional tests
> > > > =C2=A0 MAINTAINERS: Add entry for VEGA machine
> > > >=20
> > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 14 +
> > > > =C2=A0configs/devices/riscv64-softmmu/default.mak |=C2=A0=C2=A0 1 +
> > > > =C2=A0docs/system/riscv/vega.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 219=
 +++++++
> > > > =C2=A0docs/system/target-riscv.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0hw/intc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> > > > =C2=A0hw/intc/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > > =C2=A0hw/intc/vega_aclint.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 668
> > > > ++++++++++++++++++++
> > > > =C2=A0hw/intc/vega_plic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 517
> > > > +++++++++++++++
> > > > =C2=A0hw/riscv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +
> > > > =C2=A0hw/riscv/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0hw/riscv/vega.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 502
> > > > +++++++++++++++
> > > > =C2=A0include/hw/intc/vega_aclint.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 84 +++
> > > > =C2=A0include/hw/intc/vega_plic.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 87 =
+++
> > > > =C2=A0include/hw/riscv/vega.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 136 ++++
> > > > =C2=A0target/riscv/cpu-qom.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > > =C2=A0target/riscv/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 25 +
> > > > =C2=A0tests/functional/riscv32/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0tests/functional/riscv32/test_vega.py=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 32 +
> > > > =C2=A0tests/functional/riscv64/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0tests/functional/riscv64/test_vega.py=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 63 ++
> > > > =C2=A020 files changed, 2374 insertions(+)
> > > > =C2=A0create mode 100644 docs/system/riscv/vega.rst
> > > > =C2=A0create mode 100644 hw/intc/vega_aclint.c
> > > > =C2=A0create mode 100644 hw/intc/vega_plic.c
> > > > =C2=A0create mode 100644 hw/riscv/vega.c
> > > > =C2=A0create mode 100644 include/hw/intc/vega_aclint.h
> > > > =C2=A0create mode 100644 include/hw/intc/vega_plic.h
> > > > =C2=A0create mode 100644 include/hw/riscv/vega.h
> > > > =C2=A0create mode 100644 tests/functional/riscv32/test_vega.py
> > > > =C2=A0create mode 100644 tests/functional/riscv64/test_vega.py
> >=20
> > With Regards,
> > Karthika B
> > Project Engineer
> > HDG
> >=20
> > ---------------------------------------------------------------------
> > ---------------------------------------
> > [ C-DAC is on Social-Media too. Kindly follow us at:
> > Facebook: https://www.facebook.com/CDACINDIA=C2=A0& Twitter: @cdacindia=
 ]
> >=20
> > This e-mail is for the sole use of the intended recipient(s) and may
> > contain confidential and privileged information. If you are not the
> > intended recipient, please contact the sender by reply e-mail and
> > destroy
> > all copies and the original message. Any unauthorized review, use,
> > disclosure, dissemination, forwarding, printing or copying of this
> > email
> > is strictly prohibited and appropriate legal action will be taken.
> > ---------------------------------------------------------------------
> > ---------------------------------------

With Regards,
Karthika B
Project Engineer
HDG

---------------------------------------------------------------------------=
---------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
---------------------------------------------------------------------------=
---------------------------------


