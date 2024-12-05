Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8251CE7716F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 01:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ0gf-0002CJ-Nl; Wed, 04 Dec 2024 20:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tJ0ga-0002Bc-LM; Wed, 04 Dec 2024 20:29:48 -0500
Received: from out203-205-221-202.mail.qq.com ([203.205.221.202])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tJ0gW-0006Hh-Ik; Wed, 04 Dec 2024 20:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1733362164; bh=PqkeBW++Fi5v3xZvkkG3037EffRFu1AH4/4OoViL66Y=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=rEaAot+JWLItQrd1iInHZLhmskYcn8ty9GpNlU+gmNTMrPO/Yqf6yYerXSXoh6G8m
 oA8G+KmNyyNn3weB8/OUiKLRu64Tdstp+CWVWrUwZoIQNx+A8Ml9CRj+JKJZTuXiCd
 jtnZdWxI2BRUv2xP1vxI4s1d/KOWZdAwR0s2J+Gk=
Received: from [192.168.1.13] ([61.139.23.192])
 by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
 id 7562045A; Thu, 05 Dec 2024 09:29:22 +0800
X-QQ-mid: xmsmtpt1733362162tsfpi2lzv
Message-ID: <tencent_06871EF8A4ECD65A90D4E769FC60C972DC09@qq.com>
X-QQ-XMAILINFO: NWcoOllJpLjiKKEdfhn9mnsi6eoA+TB4drLWE/6NjVk4Fs9RSqI+EVlctDsm7v
 8OCfBhvqiKb654ZTTPbOapEPGiVLtHWjmKt1q/h5SlYeh02t+ZiQqalhwnNI/dN/opbsLKST1W2p
 69SzK4DXP5YgI5x+B8Ktq54afgXiFBY/LkYY2UddYr1D9Ar590b1N9IuWWrvQgK9a1h9rFm9KoKR
 foKg6w/335ZcNgjcwA9JHLOMRKQaNxm5GbUHY+qGcwJTLyFSjQAIR2iv3kO3A5buwnMMvSXrY6Cx
 QuOwyPpRoZE8LiJTOWoTxhS/qgzXWII5glj5xFofbzg6shTRcUQwxEUzyF/FEStozY0N40AEkaoU
 jjhXwtRzy9gHG908s4huPQskPzNZ1vdzDl/vaJxEolNYKJnpzVFesCZUb3irdHOUTbCczQLVpE4z
 MSM4dT1lKf2Eqd6GAU3rpN/bsqDtBXy5uoUaTXUNVPWsX1Za1Z7xzCmAR/TxXSQlTKjm5yw1fQdI
 WZQvevURaz791cyK0miwo4bxjERtJ9HC+VhtCACjRy7tdTkjJnXDrJP6mCdJ22nT5M4H9RYk+Xty
 g1siurdIsqp0K7vUTcSkW0ha9V+h3/t/CWW+RzMRSsQVZP+WiUQfNfkC3+sQtZwx3Th3zN5LRkYP
 Glil+pvfL/a9JneMpLpdtvTkeT/KP1nD9cA/tB4RUmpUF7DuMM9wizChmMkyDqvyHC4vwLwcLfiC
 Y+oZFRpL90PL71LjwRKSzOzpha7uyMeCr/o7BbUQytYaXDvUiLUhtyjmOZJP21j3M1YlIcvkgbno
 9/OxSE0/1DfcmBCa+B7CsFbPS/9bPQFNM3LSVjQxVr8mddaZMAzaGSeKFQdgebuCawiuh4ukGBfS
 y2u2nhFAz+dPvwhM7iv1flP/NpUGP895lOphnD64hSuhRPKzgA4gKmBH8g/GtjYyAevDt7qACo
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <221f3eb6636e2778d6a942e95ff97688a5ff60fb.camel@qq.com>
Subject: Re: [PATCH v2] riscv/gdb: add virt mode debug interface
From: Yanfeng Liu <yfliu2008@qq.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
Date: Thu, 05 Dec 2024 09:29:22 +0800
In-Reply-To: <0516feb0-ba9a-4ac0-a2bd-1bf97ca9694e@lauterbach.com>
References: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
 <8734jbh21e.fsf@draig.linaro.org>
 <tencent_CA6E4D0C897F3ED0EF988CCE5DF541442A05@qq.com>
 <87r06ufjiz.fsf@draig.linaro.org>
 <tencent_AADD9A1292CD7CB89F16999E7BDD03895406@qq.com>
 <0516feb0-ba9a-4ac0-a2bd-1bf97ca9694e@lauterbach.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.205.221.202; envelope-from=yfliu2008@qq.com;
 helo=out203-205-221-202.mail.qq.com
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

On Wed, 2024-12-04 at 17:03 +0100, Mario Fleischmann wrote:
> Hi everyone,
>=20
> I'd like to chime in here because we are sitting on a similar patch=20
> which I wanted to send to the mailing list as soon as riscv-debug-spec=
=20
> v1.0.0 becomes ratified.
>=20
> For hypervisor support, `(qemu) info registers` isn't enough. We need to=
=20
> have both read and write access to the V-bit.
>=20
> On 04.12.2024 14:43, Yanfeng Liu wrote:
> > On Fri, 2024-11-29 at 09:59 +0000, Alex Benn=C3=A9e wrote:
> > > Yanfeng <yfliu2008@qq.com> writes:
> > >=20
> > > > On Thu, 2024-11-28 at 14:21 +0000, Alex Benn=C3=A9e wrote:
> > > > > Yanfeng Liu <yfliu2008@qq.com> writes:
> > > > >=20
> > > > > > This adds `virt` virtual register on debug interface so that us=
ers
> > > > > > can access current virtualization mode for debugging purposes.
> > > > > >=20
> > > > > > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > > > > > ---
> > > > > > =C2=A0=C2=A0gdb-xml/riscv-32bit-virtual.xml |=C2=A0 1 +
> > > > > > =C2=A0=C2=A0gdb-xml/riscv-64bit-virtual.xml |=C2=A0 1 +
> > > > > > =C2=A0=C2=A0target/riscv/gdbstub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++++++++++------
> > > > > > =C2=A0=C2=A03 files changed, 14 insertions(+), 6 deletions(-)
> > > > > >=20
> > > > > > diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32=
bit-
> > > > > > virtual.xml
> > > > > > index 905f1c555d..d44b6ca2dc 100644
> > > > > > --- a/gdb-xml/riscv-32bit-virtual.xml
> > > > > > +++ b/gdb-xml/riscv-32bit-virtual.xml
> > > > > > @@ -8,4 +8,5 @@
> > > > > > =C2=A0=C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > > > > > =C2=A0=C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
> > > > > > =C2=A0=C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"32"/>
> > > > > > +=C2=A0 <reg name=3D"virt" bitsize=3D"32"/>
> > > > > > =C2=A0=C2=A0</feature>
> > > > > > diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64=
bit-
> > > > > > virtual.xml
> > > > > > index 62d86c237b..7c9b63d5b6 100644
> > > > > > --- a/gdb-xml/riscv-64bit-virtual.xml
> > > > > > +++ b/gdb-xml/riscv-64bit-virtual.xml
> > > > > > @@ -8,4 +8,5 @@
> > > > > > =C2=A0=C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > > > > > =C2=A0=C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
> > > > > > =C2=A0=C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"64"/>
> > > > > > +=C2=A0 <reg name=3D"virt" bitsize=3D"64"/>
> > > > > > =C2=A0=C2=A0</feature>
> > > > >=20
> > > > > I assume these are mirrored in gdb not a QEMU only extension?
> > > >=20
> > > > So far I think it is a QEMU extension and the `gdb-multiarch` doesn=
't
> > > > treat
> > > > is
> > > > specially. My tests shows it basically works:
> > > >=20
> > > > ```
> > > > (gdb) ir virt
> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:3 [Machine]
> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > > > (gdb) set $priv =3D 2
> > > > (gdb) ir virt
> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > > > (gdb) set $virt =3D 1
> > > > (gdb) ir virt
> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01
> > > > (gdb) set $virt =3D 0
> > > > (gdb) ir virt
> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > > > (gdb) set $virt =3D 1
> > > > (gdb) ir virt
> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01
> > > > (gdb) set $priv =3D 3
> > > > (gdb) ir virt
> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:3 [Machine]
> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > > > ```
> > >=20
> > > A gdbstub test case would be useful for this although I don't know if
> > > the RiscV check-tcg tests switch mode at all.
> > >=20
> > > >=20
> > > > As I am rather new to QEMU, please teach how we can add it as a QEM=
U
> > > > only
> > > > extension.
> > >=20
> > > You don't need to extend the XML from GDB, you can build a specific o=
ne
> > > for QEMU extensions. For example:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 gdb_feature_builder_init(&param.builder,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cpu->dyn_sysreg_feature.desc,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "org.qemu.gdb.arm.sys.regs",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "system-registers.xml",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base_reg);
> > >=20
> > > This exports all the system registers QEMU knows about and GDB can
> > > access generically. Note the id is org.qemu..., indicating its our
> > > schema not gdbs.
> > Thanks for teaching, I need time to digest. I guess more feature builde=
r
> > APIs
> > are needed (like append_reg) and the getter/setter callbacks might be a=
t a
> > different place.
> >=20
> > BTW, compared to adding virtual register `virt`, how do you think if we
> > share
> > the V bit as part of existing `priv` register?
>=20
> IMHO this is a very good idea since the latest release candidate of=20
> riscv-debug-spec also includes the V bit in priv:2.
>=20

Thanks for this information, I noticed the bit(2) of `priv` register is for=
 the
V bit as per section 4.10.1.

> > Or maybe we shall talk to GDB community to get their opinions? If they =
agree
> > to
> > add a few words about V bit here
> > https://sourceware.org/gdb/current/onlinedocs/gdb.html/RISC_002dV-Featu=
res.html
> > ,
> > then it saves us a lot.
>=20
> Except being currently not supported by GDB
>=20
> (gdb) info register $priv
> priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x5=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:5 [INVALID]
>=20
> are there any reasons from QEMU's side that would speak against=20
> including V in priv?
>=20

My v1 patch used `bit(8)` to avoid seeing the `[INVALID]` thing at GDB side=
,
though that is due to GDB isn't in line with its own manual (i.e. use the t=
wo
lowest bits only).

Without a doc or specification. we felt people may not know `bit(8)` in v1 =
patch
was for the V bit, so I drafted patch v2 as Alistair suggested. However, as=
 Alex
pointed out, directly adding `virt` register in "org.gnu.gdb.riscv.virtual"=
 XML
is improper. I also wanted to raise this in GDB side but my application to =
join
the mail list is still pending.

Alex and Alistair, now I am wondering if we can follow the RiscV debug
specification to use `bit(2)` of `priv` virtual register?=C2=A0My test show=
s except
for the `[INVALID]` label, both set/get access seems working.=20


Regards,
yf


