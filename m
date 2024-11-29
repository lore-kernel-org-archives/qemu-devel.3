Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A444ED70E02
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 02:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGqUZ-0007Q2-0v; Thu, 28 Nov 2024 21:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGqUR-0007PH-Sk; Thu, 28 Nov 2024 21:12:16 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGqUA-0007kM-EW; Thu, 28 Nov 2024 21:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1732846284; bh=Sft/TtXcxXncjIHXesJa1zuFB1b6mUYiiyfkKeGhOls=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=xBnGxDTwTYNZwkU7xZSqjASZOi0Tki95DKkhhSGBsvlOBhq9ausUafmXsuoOrU2s4
 l7mIi9nXG2axkvZtbsiGaBODL0RrGe8pL2M0fcFtQCNCW/cgMJUoinQrY4Tb7U8YtH
 olpaU119LojruToxEj077mOJU5Atso1oHRvZlLqo=
Received: from [192.168.1.13] ([61.139.23.214])
 by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
 id 2D6BF2C7; Fri, 29 Nov 2024 10:11:22 +0800
X-QQ-mid: xmsmtpt1732846282t9fjudsy8
Message-ID: <tencent_CA6E4D0C897F3ED0EF988CCE5DF541442A05@qq.com>
X-QQ-XMAILINFO: NGX5+lQVxpC+ql2AUZRL7hgY6F4pTFvJidUPfgGgbPF5oy7MStkV98P8leuG+j
 Gt+Zt219dARoXn/3re3r9S+OBx8X3nhUx/LoypX0Zj7Xblnrhbc7y72m5M/RtnyfL2O/8SMXxnRt
 gy9yoAaCpNEDK4V5lEdFIv7F0o7eOS+PQ8iblTPKSUqzOyTplOLfJJMiqJRRNYGOfGYqr3bkKLp2
 9UGR1BWWKc8GFEKu7EmCS2GuqNzmWJTug8q1zR5+u1i29UFqtGOjauTxgx9ZSMhbqzfzwuKH4cCh
 mWCPFs6hOcGErGYIu52EgvJLGjyoj3ny7/kkcfqXXHLbOt3TA/mLfPezS3haDw9dtnQtfnEVAqSu
 LacP2hQp2wNOldu28oaDuGHO0eGBjLxrsaL9nHH79mptB1V/KrFUPC5i4J1CX/4gn6CRbMz7LsLh
 1x++fiaHZOPm6eap3mgiUh9SXsfIRCVnDw7c+0CyxybJ24BU2CaV7AC8mS8GX+jsBg2HQt9TnYvm
 keMe9vxDCFRd/prXDON25U15h+8pv5CyNmm6WsvDQfXYmJB89QwsqqqBXxqZXeA/cWJ5nci2B88m
 PaUR6hUeCoZ8VHgvFFphlEsVbaa+XyEJrHR++ZZkAUe8HJPwsypqil3Yh1rJpBowcqqmbiglrSmD
 cpQXX2xWZES20FDpV/yCOrHKipNdFckaQYHHrvFgHIt6JmjVE7C9mdCPYxSW05F7qKOunN3ii3aF
 ODUC/R+yxNhXdmtISGsrHVSxqLeL/ZTJ3YqpM7x86Ad2EZfzyqLmVxBF3FM3uywJ/Za7Brz4hTSY
 jn78WjaIgMgaM7ikgR2WCYvxSq/iWP7hVHM3u7reCvLHXZak3tgG4UNhJSCP2c+j7EU3Xj57V2u9
 OWVgpXKK03rKGSreWZ0DCZ54qZTlZ8REG9cjO4r4w3l2iKG8iOd2FsAyCXBjxU1Q==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-OQ-MSGID: <3449aedb1f62485ad3ee9690c1cb39a6967d3d1f.camel@qq.com>
Subject: Re: [PATCH v2] riscv/gdb: add virt mode debug interface
From: Yanfeng <yfliu2008@qq.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
Date: Fri, 29 Nov 2024 10:11:22 +0800
In-Reply-To: <8734jbh21e.fsf@draig.linaro.org>
References: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
 <8734jbh21e.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=43.163.128.47; envelope-from=yfliu2008@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 2024-11-28 at 14:21 +0000, Alex Benn=C3=A9e wrote:
> Yanfeng Liu <yfliu2008@qq.com> writes:
>=20
> > This adds `virt` virtual register on debug interface so that users
> > can access current virtualization mode for debugging purposes.
> >=20
> > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > ---
> > =C2=A0gdb-xml/riscv-32bit-virtual.xml |=C2=A0 1 +
> > =C2=A0gdb-xml/riscv-64bit-virtual.xml |=C2=A0 1 +
> > =C2=A0target/riscv/gdbstub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 18 ++++++++++++------
> > =C2=A03 files changed, 14 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32bit-
> > virtual.xml
> > index 905f1c555d..d44b6ca2dc 100644
> > --- a/gdb-xml/riscv-32bit-virtual.xml
> > +++ b/gdb-xml/riscv-32bit-virtual.xml
> > @@ -8,4 +8,5 @@
> > =C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > =C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
> > =C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"32"/>
> > +=C2=A0 <reg name=3D"virt" bitsize=3D"32"/>
> > =C2=A0</feature>
> > diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64bit-
> > virtual.xml
> > index 62d86c237b..7c9b63d5b6 100644
> > --- a/gdb-xml/riscv-64bit-virtual.xml
> > +++ b/gdb-xml/riscv-64bit-virtual.xml
> > @@ -8,4 +8,5 @@
> > =C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > =C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
> > =C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"64"/>
> > +=C2=A0 <reg name=3D"virt" bitsize=3D"64"/>
> > =C2=A0</feature>
>=20
> I assume these are mirrored in gdb not a QEMU only extension?

So far I think it is a QEMU extension and the `gdb-multiarch` doesn't treat=
 is
specially. My tests shows it basically works:

```
(gdb) ir virt
priv           0x3	prv:3 [Machine]
virt           0x0	0
(gdb) set $priv =3D 2
(gdb) ir virt
priv           0x1	prv:1 [Supervisor]
virt           0x0	0
(gdb) set $virt =3D 1
(gdb) ir virt
priv           0x1	prv:1 [Supervisor]
virt           0x1	1
(gdb) set $virt =3D 0
(gdb) ir virt
priv           0x1	prv:1 [Supervisor]
virt           0x0	0
(gdb) set $virt =3D 1
(gdb) ir virt
priv           0x1	prv:1 [Supervisor]
virt           0x1	1
(gdb) set $priv =3D 3
(gdb) ir virt
priv           0x3	prv:3 [Machine]
virt           0x0	0
```

As I am rather new to QEMU, please teach how we can add it as a QEMU only
extension.

>=20
> > diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> > index c07df972f1..7399003e04 100644
> > --- a/target/riscv/gdbstub.c
> > +++ b/target/riscv/gdbstub.c
> > @@ -206,14 +206,14 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_=
t
> > *mem_buf, int n)
> > =C2=A0
> > =C2=A0static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, i=
nt n)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0 if (n =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0 if (n >=3D 0 && n <=3D 1) {
> > =C2=A0#ifdef CONFIG_USER_ONLY
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get_regl(bu=
f, 0);
> > =C2=A0#else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RISCVCPU *cpu =3D RISC=
V_CPU(cs);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPURISCVState *env =3D=
 &cpu->env;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get_regl(buf, en=
v->priv);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get_regl(buf, n =
? env->virt_enabled : env->priv);
>=20
> The range checking of n and ternary op are a bit magical here. Whats
> wrong with a good old fashioned switch/case statement?
thanks, I can rewrite with switch statement.
>=20
> > =C2=A0#endif
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > @@ -221,14 +221,20 @@ static int riscv_gdb_get_virtual(CPUState *cs,
> > GByteArray *buf, int n)
> > =C2=A0
> > =C2=A0static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, =
int n)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0 if (n =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0 if (n >=3D 0 && n <=3D 1) {
> > =C2=A0#ifndef CONFIG_USER_ONLY
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RISCVCPU *cpu =3D RISC=
V_CPU(cs);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPURISCVState *env =3D=
 &cpu->env;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->priv =3D ldtul_p(mem_b=
uf) & 0x3;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->priv =3D=3D PRV_RE=
SERVED) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->priv =3D PRV_S;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (n =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->priv =3D ldtul_p(mem_buf) & 0x3;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(env->priv =3D=3D PRV_RESERVED) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env->priv =3D PRV_S;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(env->priv !=3D PRV_M) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env->virt_enabled =3D ldtul_p(mem_buf) & 0x1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> ditto here.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0#endif
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sizeof(target_u=
long);
>=20


