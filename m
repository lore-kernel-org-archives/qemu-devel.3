Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A134BE77184
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 00:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNiGq-0007hB-KF; Tue, 17 Dec 2024 19:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tNiGo-0007gt-2T; Tue, 17 Dec 2024 19:50:34 -0500
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tNiGi-0005lJ-2p; Tue, 17 Dec 2024 19:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1734483015; bh=3OwnRdR57hfmzLJRKizaJnAfCmbxmlWvAkN/WFLhVzk=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=F97xOeo9G2V4JShs+QhdzdjS3W6CWGrt2gtL9r/7Q3Ho4LXStNjlfSgoXvgY8lnM+
 3L97T3X8DU5afXWukvLzDz4gTVkxC5cNi14wH8ab4QKfTxz7pvpTML7WinaZuq6zBX
 dhy4z79rjYYnvMcBuKxbKxKLqi8AO+wFTFVLcbgI=
Received: from [192.168.1.13] ([171.213.183.116])
 by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
 id C75B60B3; Wed, 18 Dec 2024 08:49:53 +0800
X-QQ-mid: xmsmtpt1734482993tbfxpyz42
Message-ID: <tencent_957F3C1C4BF5ADE520ADCCDFFBD990D5B80A@qq.com>
X-QQ-XMAILINFO: OOWntbL6xj16jVTOPNwoNfLLFo3CZ0MY8UCzE4MHJyTA28jHlKcdnYae5a0r+m
 3EY1b0Xx5laSIzHNzTKTD1WIhH58ZGsL4we12h2lMf6PMsHZD5WuQlyL5tfYaeVyR4l6+zb5mzG4
 Hk7MuFuVK3sA+7kr5m/KqY/W3OWuNI0Pp/fhmX20ogWadkbmzM6pM1s2xi3zI5yQOK++dXb1ezCt
 YxQNMe9TQx3I4f9yyf1ulLl83Nm52xrouNcWncL4xFN+Ysh1MPTeaddY6/Iq6PH4IlmUKat+CtpO
 +S9Pd4viy7W+8z5tc+9NKLX3cxG/Kixl99ZptCK0D0VFkS7vyt3a+WJMeQEP/puw6GI9Pj3QQN+4
 6xmAkpachSf5/Zd3oRkfww4cUzDCO/o7SXphNzDZVXKoko8QdYdRIDKZLVCqUjjE/vafwwHQCTWS
 PG5s6S0iz4HHyVc1oHiuGqF2GCiNLoYW1T37y4dA9XbEzbIuN0jxpDm4cIZwUI93zgDm4AB0081r
 C9AlsbJKA/uYdAnyMToFoXliVzaqgFtjmrDbsqebbUK74qlu342e40aFmwn1kIk04UxNBR9cmggV
 2XQd8Ry1zo6HZ5KTnletZqSFErJcuVqNGaOJMdfb/FVLLzqzkDVPFmklrUR3hTBGJRiphBhClqUn
 x5ru8U5ulxgD6TRq2Ma3Q+beIo+dVJa1Y6aqCvUIiKX0IjATcFBVxhS1H2QC6tEFJOkDodbhA+Q1
 iVcS63YYlaibn+z7Tl6lEtsAkmClKZ6uPWR/sbemsjur94EEUtP7tD+17kvwe4218OlTnn61XOLe
 tcRnu3j6iidDNHhtKxkKg8aMfoJlm6kw4HA+8lcEaCWLiXtWwZsGnm5fcbLO6UZ3IdQ08L4z5Gb/
 7z21LTs3CPIq8ko5l9g6qQDp3ViDN8UFJRQdp0YnnSRA1vHllrG5bovOYa/SucOk1x8M7aKxl6o+
 Ul4PneIqI=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <616fcd51810da5d86c492bc3e0b3c973502ec512.camel@qq.com>
Subject: Re: [PATCH v2] riscv/gdb: add virt mode debug interface
From: Yanfeng Liu <yfliu2008@qq.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Mario
 Fleischmann <mario.fleischmann@lauterbach.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,  alistair.francis@wdc.com
Date: Wed, 18 Dec 2024 08:49:53 +0800
In-Reply-To: <CAKmqyKNzYM=BvXETpkuPJDd66C7NNUFTFZqacPJJeXwbMyKdFg@mail.gmail.com>
References: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
 <8734jbh21e.fsf@draig.linaro.org>
 <tencent_CA6E4D0C897F3ED0EF988CCE5DF541442A05@qq.com>
 <87r06ufjiz.fsf@draig.linaro.org>
 <tencent_AADD9A1292CD7CB89F16999E7BDD03895406@qq.com>
 <0516feb0-ba9a-4ac0-a2bd-1bf97ca9694e@lauterbach.com>
 <tencent_06871EF8A4ECD65A90D4E769FC60C972DC09@qq.com>
 <874j3ibldp.fsf@draig.linaro.org>
 <tencent_F33CF7D60707A9F1B567A493F92CBF77B207@qq.com>
 <CAKmqyKNzYM=BvXETpkuPJDd66C7NNUFTFZqacPJJeXwbMyKdFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=162.62.57.87; envelope-from=yfliu2008@qq.com;
 helo=out162-62-57-87.mail.qq.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1.116, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
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

On Mon, 2024-12-16 at 15:33 +1000, Alistair Francis wrote:
> On Thu, Dec 5, 2024 at 7:17=E2=80=AFPM Yanfeng Liu <yfliu2008@qq.com> wro=
te:
> >=20
> > On Thu, 2024-12-05 at 08:10 +0000, Alex Benn=C3=A9e wrote:
> > > Yanfeng Liu <yfliu2008@qq.com> writes:
> > >=20
> > > > On Wed, 2024-12-04 at 17:03 +0100, Mario Fleischmann wrote:
> > > > > Hi everyone,
> > > > >=20
> > > > > I'd like to chime in here because we are sitting on a similar pat=
ch
> > > > > which I wanted to send to the mailing list as soon as riscv-debug=
-spec
> > > > > v1.0.0 becomes ratified.
> > > > >=20
> > > > > For hypervisor support, `(qemu) info registers` isn't enough. We =
need
> > > > > to
> > > > > have both read and write access to the V-bit.
> > > > >=20
> > > > > On 04.12.2024 14:43, Yanfeng Liu wrote:
> > > > > > On Fri, 2024-11-29 at 09:59 +0000, Alex Benn=C3=A9e wrote:
> > > > > > > Yanfeng <yfliu2008@qq.com> writes:
> > > > > > >=20
> > > > > > > > On Thu, 2024-11-28 at 14:21 +0000, Alex Benn=C3=A9e wrote:
> > > > > > > > > Yanfeng Liu <yfliu2008@qq.com> writes:
> > > > > > > > >=20
> > > > > > > > > > This adds `virt` virtual register on debug interface so=
 that
> > > > > > > > > > users
> > > > > > > > > > can access current virtualization mode for debugging
> > > > > > > > > > purposes.
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > > > > > > > > > ---
> > > > > > > > > > =C2=A0 gdb-xml/riscv-32bit-virtual.xml |=C2=A0 1 +
> > > > > > > > > > =C2=A0 gdb-xml/riscv-64bit-virtual.xml |=C2=A0 1 +
> > > > > > > > > > =C2=A0 target/riscv/gdbstub.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++++++++++------
> > > > > > > > > > =C2=A0 3 files changed, 14 insertions(+), 6 deletions(-=
)
> > > > > > > > > >=20
> > > > > > > > > > diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-
> > > > > > > > > > xml/riscv-
> > > > > > > > > > 32bit-
> > > > > > > > > > virtual.xml
> > > > > > > > > > index 905f1c555d..d44b6ca2dc 100644
> > > > > > > > > > --- a/gdb-xml/riscv-32bit-virtual.xml
> > > > > > > > > > +++ b/gdb-xml/riscv-32bit-virtual.xml
> > > > > > > > > > @@ -8,4 +8,5 @@
> > > > > > > > > > =C2=A0 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > > > > > > > > > =C2=A0 <feature name=3D"org.gnu.gdb.riscv.virtual">
> > > > > > > > > > =C2=A0=C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"32"/>
> > > > > > > > > > +=C2=A0 <reg name=3D"virt" bitsize=3D"32"/>
> > > > > > > > > > =C2=A0 </feature>
> > > > > > > > > > diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-
> > > > > > > > > > xml/riscv-
> > > > > > > > > > 64bit-
> > > > > > > > > > virtual.xml
> > > > > > > > > > index 62d86c237b..7c9b63d5b6 100644
> > > > > > > > > > --- a/gdb-xml/riscv-64bit-virtual.xml
> > > > > > > > > > +++ b/gdb-xml/riscv-64bit-virtual.xml
> > > > > > > > > > @@ -8,4 +8,5 @@
> > > > > > > > > > =C2=A0 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > > > > > > > > > =C2=A0 <feature name=3D"org.gnu.gdb.riscv.virtual">
> > > > > > > > > > =C2=A0=C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"64"/>
> > > > > > > > > > +=C2=A0 <reg name=3D"virt" bitsize=3D"64"/>
> > > > > > > > > > =C2=A0 </feature>
> > > > > > > > >=20
> > > > > > > > > I assume these are mirrored in gdb not a QEMU only extens=
ion?
> > > > > > > >=20
> > > > > > > > So far I think it is a QEMU extension and the `gdb-multiarc=
h`
> > > > > > > > doesn't
> > > > > > > > treat
> > > > > > > > is
> > > > > > > > specially. My tests shows it basically works:
> > > > > > > >=20
> > > > > > > > ```
> > > > > > > > (gdb) ir virt
> > > > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:3 [Machine]
> > > > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > > > > > > (gdb) set $priv =3D 2
> > > > > > > > (gdb) ir virt
> > > > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:1 [Supervisor]
> > > > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > > > > > > (gdb) set $virt =3D 1
> > > > > > > > (gdb) ir virt
> > > > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:1 [Supervisor]
> > > > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
> > > > > > > > (gdb) set $virt =3D 0
> > > > > > > > (gdb) ir virt
> > > > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:1 [Supervisor]
> > > > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > > > > > > (gdb) set $virt =3D 1
> > > > > > > > (gdb) ir virt
> > > > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:1 [Supervisor]
> > > > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
> > > > > > > > (gdb) set $priv =3D 3
> > > > > > > > (gdb) ir virt
> > > > > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:3 [Machine]
> > > > > > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > > > > > > ```
> > > > > > >=20
> > > > > > > A gdbstub test case would be useful for this although I don't=
 know
> > > > > > > if
> > > > > > > the RiscV check-tcg tests switch mode at all.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > As I am rather new to QEMU, please teach how we can add it =
as a
> > > > > > > > QEMU
> > > > > > > > only
> > > > > > > > extension.
> > > > > > >=20
> > > > > > > You don't need to extend the XML from GDB, you can build a
> > > > > > > specific
> > > > > > > one
> > > > > > > for QEMU extensions. For example:
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 gdb_feature_builder_init(&param.buil=
der,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cpu->dyn_sysreg_feature.desc,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "org.qemu.gdb.arm.sys.regs",
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "system-registers.xml",
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base_reg);
> > > > > > >=20
> > > > > > > This exports all the system registers QEMU knows about and GD=
B can
> > > > > > > access generically. Note the id is org.qemu..., indicating it=
s our
> > > > > > > schema not gdbs.
> > > > > > Thanks for teaching, I need time to digest. I guess more featur=
e
> > > > > > builder
> > > > > > APIs
> > > > > > are needed (like append_reg) and the getter/setter callbacks mi=
ght
> > > > > > be at
> > > > > > a
> > > > > > different place.
> > > > > >=20
> > > > > > BTW, compared to adding virtual register `virt`, how do you thi=
nk if
> > > > > > we
> > > > > > share
> > > > > > the V bit as part of existing `priv` register?
> > > > >=20
> > > > > IMHO this is a very good idea since the latest release candidate =
of
> > > > > riscv-debug-spec also includes the V bit in priv:2.
> > > > >=20
> > > >=20
> > > > Thanks for this information, I noticed the bit(2) of `priv` registe=
r is
> > > > for
> > > > the
> > > > V bit as per section 4.10.1.
> > > >=20
> > > > > > Or maybe we shall talk to GDB community to get their opinions? =
If
> > > > > > they
> > > > > > agree
> > > > > > to
> > > > > > add a few words about V bit here
> > > > > > https://sourceware.org/gdb/current/onlinedocs/gdb.html/RISC_002=
dV-Features.html
> > > > > > ,
> > > > > > then it saves us a lot.
> > > > >=20
> > > > > Except being currently not supported by GDB
> > > > >=20
> > > > > (gdb) info register $priv
> > > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0x5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:5 [INVALID]
> > > > >=20
> > > > > are there any reasons from QEMU's side that would speak against
> > > > > including V in priv?
> > > > >=20
> > > >=20
> > > > My v1 patch used `bit(8)` to avoid seeing the `[INVALID]` thing at =
GDB
> > > > side,
> > > > though that is due to GDB isn't in line with its own manual (i.e. u=
se
> > > > the
> > > > two
> > > > lowest bits only).
> > > >=20
> > > > Without a doc or specification. we felt people may not know `bit(8)=
` in
> > > > v1
> > > > patch
> > > > was for the V bit, so I drafted patch v2 as Alistair suggested. How=
ever,
> > > > as
> > > > Alex
> > > > pointed out, directly adding `virt` register in
> > > > "org.gnu.gdb.riscv.virtual"
> > > > XML
> > > > is improper. I also wanted to raise this in GDB side but my applica=
tion
> > > > to
> > > > join
> > > > the mail list is still pending.
> > > >=20
> > > > Alex and Alistair, now I am wondering if we can follow the RiscV de=
bug
> > > > specification to use `bit(2)` of `priv` virtual register? My test s=
hows
> > > > except
> > > > for the `[INVALID]` label, both set/get access seems working.
> > >=20
> > > I guess the INVALID just means gdb needs teaching about the format of
> > > the register.
> >=20
> > Yes, GDB currently uses mask `0xff`(instead of `0x3`) to get the mode v=
alue
> > when
> > adding the string label, this violates its own manual:
> >=20
> > 1303=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else i=
f (regnum =3D=3D RISCV_PRIV_REGNUM)
> > 1304=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 {
> > 1305=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LONGEST d;
> > 1306=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint8_t priv;
> > 1307
> > 1308=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 d =3D value_as_long (val);
> > 1309=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 priv =3D d & 0xff;
> > 1310
> > 1311=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (priv < 4)
> > 1312=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> > 1313=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static const char * const sprv[]=
 =3D
> > 1314=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> > 1315=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "User/Ap=
plication",
> > 1316=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Supervi=
sor",
> > 1317=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Hypervi=
sor",
> > 1318=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Machine=
"
> > 1319=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > 1320=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_printf (file, "\tprv:%d [%s]=
",
> > 1321=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv, sprv[priv]);
> > 1322=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > 1323=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 else
> > 1324=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_printf (file, "\tprv:%d [INVALID]", priv=
);
> > 1325=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> >=20
> >=20
> > I am wondering if we can go ahead to follow RiscV debug specification a=
nd
> > sync
> > with GDB later?
>=20
> If there is a spec then that is the way to go. Just link to it when
> submitting the patch.
>=20
> We also at least want to be sending a patch to GDB to fix it,
> otherwise we are going to break people.
>=20
Thanks for the suggestion, a patch was sent to GDB:
https://sourceware.org/pipermail/gdb-patches/2024-December/214221.html

> Alistair

Regards,
yf



