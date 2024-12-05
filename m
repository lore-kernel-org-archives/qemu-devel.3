Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197A3E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 09:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ7yT-00046C-OV; Thu, 05 Dec 2024 04:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tJ7y2-00041j-Ef; Thu, 05 Dec 2024 04:16:15 -0500
Received: from out203-205-221-240.mail.qq.com ([203.205.221.240])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tJ7xw-0002Cu-NE; Thu, 05 Dec 2024 04:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1733390142; bh=cjaFaFIL2MOS5uhZWZK6z/qrdjbzGOuA3/XNMmw4US8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=kKrNawvodNCE8w7nwbSvReSRQaEn8dRQ12u16Ap9viVrQMARmwvymRU6GuksUiciN
 tH2t2uB6+W732iJ7BPl6mG++zGLqH6kUWIF/WLCNAycnf1zOAGaK6/TIWiuPxz9mdk
 gsvSbxVvJ4+aEtvxGwGiD7UAfUOIZyXSHNdGRPLQ=
Received: from [192.168.1.13] ([61.139.23.192])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id 3E897ADF; Thu, 05 Dec 2024 17:15:40 +0800
X-QQ-mid: xmsmtpt1733390140t512nmrrh
Message-ID: <tencent_F33CF7D60707A9F1B567A493F92CBF77B207@qq.com>
X-QQ-XMAILINFO: Ncpnai4dwVTHkxhcUgPEBin0x8i3m99m4oRib1JrRZOlxum/mumByM7mRKQXNk
 20w5nupJYi8mMfue9F6hr2N8lr2LORBytkHfdUoIpKBLDC7RNrlQCLax+ZC5t1tnPqbrbWKBroPP
 mGkD/s/38XLJZ6LMf2BLR1xKKwHekAdaGso3uxCiRIIPABEagAUhfv8TpELg1mqmBH7aYSmWPa7Q
 u8DHj6V8CwUsc+366u3VxDAZ4I+2kmDch8D+W0lcq5gdQ3B3fz6pphvQ7o0P8YResZD9DICBgUdU
 PlIsCgFy6ayLbESTpFs8lcLxab5GOz1TSeihqIIKu0d6yT0zOgXbBS2NNy7im13ReH53VufCAYus
 +x/avOYNy/UkSavo6HOEjJBdSoVdCeDNfhiYMR0gid/0/dMjRAzvf64Th1hEJYt/AOPpsrIJAoG9
 So6wdOdFxERgTtfajAfDbq3nTq498tZE9bKZTblyvuQJtPJieU996zgLMSnf2Eq3aMZvyJOGWThX
 SInqMFGBjGDIDjo/yrNby3UoEjny6XNMZ0czj3coubBCAmRnMeEE9VnlmBOKIH1ObYPMsyrdH4MY
 iFCek4aJHB1xNn/80OZRXalb1d49eRiKRFRMZMwxTOza4EBTAdZuvxF2KwHPFdaZl5T4eu4wxa0u
 IXNNUHoKblW2Mdjk/6v5hE9cr3WfaIvAPXim4AQKRHu2+nMGR1SaXzt73BeBMO8lypNWrlUAhOhS
 HRP3ymBzPT79wWgVUB3yPfRohDd953gZPQBUIeBetooj9n+J206WkeeSAUvkLiail+FWbKYwh9qe
 1cx9qG8oILtP+L6OEYj58LU+bW7pfT7DzNzea30hdhWJ4kXV+vRZ2rNgwOiKo6P/Ed0beXFXAf/S
 Gnv8fWNXw9slK2VNds3zmGgABxh4hidx/etF6NXM0tYUmTIephZqx/vLzGbZO9mHFmKaLIDU8qK2
 NuMFbbMLaC99nNkxwC3Q==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <64785b208d569472c9e6d6e0d058318f3f8e321f.camel@qq.com>
Subject: Re: [PATCH v2] riscv/gdb: add virt mode debug interface
From: Yanfeng Liu <yfliu2008@qq.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Mario Fleischmann <mario.fleischmann@lauterbach.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
Date: Thu, 05 Dec 2024 17:15:40 +0800
In-Reply-To: <874j3ibldp.fsf@draig.linaro.org>
References: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
 <8734jbh21e.fsf@draig.linaro.org>
 <tencent_CA6E4D0C897F3ED0EF988CCE5DF541442A05@qq.com>
 <87r06ufjiz.fsf@draig.linaro.org>
 <tencent_AADD9A1292CD7CB89F16999E7BDD03895406@qq.com>
 <0516feb0-ba9a-4ac0-a2bd-1bf97ca9694e@lauterbach.com>
 <tencent_06871EF8A4ECD65A90D4E769FC60C972DC09@qq.com>
 <874j3ibldp.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.205.221.240; envelope-from=yfliu2008@qq.com;
 helo=out203-205-221-240.mail.qq.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 2024-12-05 at 08:10 +0000, Alex Benn=C3=A9e wrote:
> Yanfeng Liu <yfliu2008@qq.com> writes:
>=20
> > On Wed, 2024-12-04 at 17:03 +0100, Mario Fleischmann wrote:
> > > Hi everyone,
> > >=20
> > > I'd like to chime in here because we are sitting on a similar patch=
=20
> > > which I wanted to send to the mailing list as soon as riscv-debug-spe=
c=20
> > > v1.0.0 becomes ratified.
> > >=20
> > > For hypervisor support, `(qemu) info registers` isn't enough. We need=
 to=20
> > > have both read and write access to the V-bit.
> > >=20
> > > On 04.12.2024 14:43, Yanfeng Liu wrote:
> > > > On Fri, 2024-11-29 at 09:59 +0000, Alex Benn=C3=A9e wrote:
> > > > > Yanfeng <yfliu2008@qq.com> writes:
> > > > >=20
> > > > > > On Thu, 2024-11-28 at 14:21 +0000, Alex Benn=C3=A9e wrote:
> > > > > > > Yanfeng Liu <yfliu2008@qq.com> writes:
> > > > > > >=20
> > > > > > > > This adds `virt` virtual register on debug interface so tha=
t
> > > > > > > > users
> > > > > > > > can access current virtualization mode for debugging purpos=
es.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > > > > > > > ---
> > > > > > > > =C2=A0=C2=A0gdb-xml/riscv-32bit-virtual.xml |=C2=A0 1 +
> > > > > > > > =C2=A0=C2=A0gdb-xml/riscv-64bit-virtual.xml |=C2=A0 1 +
> > > > > > > > =C2=A0=C2=A0target/riscv/gdbstub.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++++++++++------
> > > > > > > > =C2=A0=C2=A03 files changed, 14 insertions(+), 6 deletions(=
-)
> > > > > > > >=20
> > > > > > > > diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/risc=
v-
> > > > > > > > 32bit-
> > > > > > > > virtual.xml
> > > > > > > > index 905f1c555d..d44b6ca2dc 100644
> > > > > > > > --- a/gdb-xml/riscv-32bit-virtual.xml
> > > > > > > > +++ b/gdb-xml/riscv-32bit-virtual.xml
> > > > > > > > @@ -8,4 +8,5 @@
> > > > > > > > =C2=A0=C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > > > > > > > =C2=A0=C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
> > > > > > > > =C2=A0=C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"32"/>
> > > > > > > > +=C2=A0 <reg name=3D"virt" bitsize=3D"32"/>
> > > > > > > > =C2=A0=C2=A0</feature>
> > > > > > > > diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/risc=
v-
> > > > > > > > 64bit-
> > > > > > > > virtual.xml
> > > > > > > > index 62d86c237b..7c9b63d5b6 100644
> > > > > > > > --- a/gdb-xml/riscv-64bit-virtual.xml
> > > > > > > > +++ b/gdb-xml/riscv-64bit-virtual.xml
> > > > > > > > @@ -8,4 +8,5 @@
> > > > > > > > =C2=A0=C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > > > > > > > =C2=A0=C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
> > > > > > > > =C2=A0=C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"64"/>
> > > > > > > > +=C2=A0 <reg name=3D"virt" bitsize=3D"64"/>
> > > > > > > > =C2=A0=C2=A0</feature>
> > > > > > >=20
> > > > > > > I assume these are mirrored in gdb not a QEMU only extension?
> > > > > >=20
> > > > > > So far I think it is a QEMU extension and the `gdb-multiarch`
> > > > > > doesn't
> > > > > > treat
> > > > > > is
> > > > > > specially. My tests shows it basically works:
> > > > > >=20
> > > > > > ```
> > > > > > (gdb) ir virt
> > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:3 [Machine]
> > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > > > > > (gdb) set $priv =3D 2
> > > > > > (gdb) ir virt
> > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > > > > > (gdb) set $virt =3D 1
> > > > > > (gdb) ir virt
> > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01
> > > > > > (gdb) set $virt =3D 0
> > > > > > (gdb) ir virt
> > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > > > > > (gdb) set $virt =3D 1
> > > > > > (gdb) ir virt
> > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01
> > > > > > (gdb) set $priv =3D 3
> > > > > > (gdb) ir virt
> > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:3 [Machine]
> > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > > > > > ```
> > > > >=20
> > > > > A gdbstub test case would be useful for this although I don't kno=
w if
> > > > > the RiscV check-tcg tests switch mode at all.
> > > > >=20
> > > > > >=20
> > > > > > As I am rather new to QEMU, please teach how we can add it as a=
 QEMU
> > > > > > only
> > > > > > extension.
> > > > >=20
> > > > > You don't need to extend the XML from GDB, you can build a specif=
ic
> > > > > one
> > > > > for QEMU extensions. For example:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 gdb_feature_builder_init(&param.builder,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cpu->dyn_sysreg_feature.desc,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "org.qemu.gdb.arm.sys.regs",
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "system-registers.xml",
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base_reg);
> > > > >=20
> > > > > This exports all the system registers QEMU knows about and GDB ca=
n
> > > > > access generically. Note the id is org.qemu..., indicating its ou=
r
> > > > > schema not gdbs.
> > > > Thanks for teaching, I need time to digest. I guess more feature bu=
ilder
> > > > APIs
> > > > are needed (like append_reg) and the getter/setter callbacks might =
be at
> > > > a
> > > > different place.
> > > >=20
> > > > BTW, compared to adding virtual register `virt`, how do you think i=
f we
> > > > share
> > > > the V bit as part of existing `priv` register?
> > >=20
> > > IMHO this is a very good idea since the latest release candidate of=
=20
> > > riscv-debug-spec also includes the V bit in priv:2.
> > >=20
> >=20
> > Thanks for this information, I noticed the bit(2) of `priv` register is=
 for
> > the
> > V bit as per section 4.10.1.
> >=20
> > > > Or maybe we shall talk to GDB community to get their opinions? If t=
hey
> > > > agree
> > > > to
> > > > add a few words about V bit here
> > > > https://sourceware.org/gdb/current/onlinedocs/gdb.html/RISC_002dV-F=
eatures.html
> > > > ,
> > > > then it saves us a lot.
> > >=20
> > > Except being currently not supported by GDB
> > >=20
> > > (gdb) info register $priv
> > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x5=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:5 [INVALID]
> > >=20
> > > are there any reasons from QEMU's side that would speak against=20
> > > including V in priv?
> > >=20
> >=20
> > My v1 patch used `bit(8)` to avoid seeing the `[INVALID]` thing at GDB =
side,
> > though that is due to GDB isn't in line with its own manual (i.e. use t=
he
> > two
> > lowest bits only).
> >=20
> > Without a doc or specification. we felt people may not know `bit(8)` in=
 v1
> > patch
> > was for the V bit, so I drafted patch v2 as Alistair suggested. However=
, as
> > Alex
> > pointed out, directly adding `virt` register in "org.gnu.gdb.riscv.virt=
ual"
> > XML
> > is improper. I also wanted to raise this in GDB side but my application=
 to
> > join
> > the mail list is still pending.
> >=20
> > Alex and Alistair, now I am wondering if we can follow the RiscV debug
> > specification to use `bit(2)` of `priv` virtual register?=C2=A0My test =
shows
> > except
> > for the `[INVALID]` label, both set/get access seems working.
>=20
> I guess the INVALID just means gdb needs teaching about the format of
> the register.

Yes, GDB currently uses mask `0xff`(instead of `0x3`) to get the mode value=
 when
adding the string label, this violates its own manual:

1303           else if (regnum =3D=3D RISCV_PRIV_REGNUM)
1304             {
1305               LONGEST d;
1306               uint8_t priv;
1307=20
1308               d =3D value_as_long (val);
1309               priv =3D d & 0xff;
1310=20
1311               if (priv < 4)
1312                 {
1313                   static const char * const sprv[] =3D
1314                     {
1315                       "User/Application",
1316                       "Supervisor",
1317                       "Hypervisor",
1318                       "Machine"
1319                     };
1320                   gdb_printf (file, "\tprv:%d [%s]",
1321                               priv, sprv[priv]);
1322                 }
1323               else
1324                 gdb_printf (file, "\tprv:%d [INVALID]", priv);
1325             }


I am wondering if we can go ahead to follow RiscV debug specification and s=
ync
with GDB later?

>=20
> >=20
> >=20
> > Regards,
> > yf
>=20


