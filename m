Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8255CD735E4
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 00:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHB8K-00079U-E7; Fri, 29 Nov 2024 19:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tHB8H-000792-BE; Fri, 29 Nov 2024 19:14:45 -0500
Received: from out203-205-221-153.mail.qq.com ([203.205.221.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tHB8D-0002xU-Kq; Fri, 29 Nov 2024 19:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1732925649; bh=ER5pIegvlpZLk+d+vPNMrBTU83T1dELzHMtnQ33VELc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=x8stGMlbL2osqKDiImXYVrqZNpET7ddVk6jk5tkAJQhmX5s/nbthAANmicfQoqtRX
 DOrKSut8YuHpjIxekU5W/GNoZDQ85NTzYiMmnq3cD4PoVItWRb1gTT6rtGyaZ4QBZ+
 cqllTzSNz1dgAFBdzbMj8UFDBqEDgmqqF7aBYhuA=
Received: from [192.168.1.13] ([220.167.31.77])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id 387B90B6; Sat, 30 Nov 2024 08:14:07 +0800
X-QQ-mid: xmsmtpt1732925647tzdse6i7p
Message-ID: <tencent_AADD9A1292CD7CB89F16999E7BDD03895406@qq.com>
X-QQ-XMAILINFO: NsEIGfsQmVV+LfzZuP+f31ynLVv3aiE4XmE7GUIBTNFptEIqSyEmr95KWX5hWC
 TyCKMpE8vlDb/3sS2o7Hth7kH9hwuxvgLWUaIrQCOlMB1OKok8C3lRRaoWKuIc99Zr6/+2XvOsTf
 9poMYoT1vDlUsuIoFZytiRginQHZtWAgOtRR9ZJKi54Pp+120xrwy+tfrR9yKDoIkr1+yRvK3FBC
 tdFa+a59Mg9AC37/Fof8wiwdbJZtUKBes4//yIo1k0LPh+gxPjUQbzzeWE4sDCMrCyqoGU95Kgcu
 M9+Q+8CGEU1Ic1SGxwxE8Qe2rqvuAeuiIgbzD+HS+cJo9a3W3jo5EHZxaO3NA88bI6PXIy90SItZ
 cc35ASnsajPqSLuV14o9x5jSlD5Wh/nEe5g8hCszXH66W4mDYLShsQxsWLjIkq2bVxZ2gsO97xvs
 SaU1cUS0PUNKW9vZUG4TUGPHf3QvIt7CpBLsRn7c72uxDFSDCaKIxs1LUN+ZxgYNHugxTu2R+njL
 ywWjga5cXDoroylE+U0btI68fM5KiNNrjDLJDi/2slEkGvvYfNTIyhZvYJx0zZo8GvKGGbtrWsym
 i7LabCDszu6aw9d8OBNwTZa1kLhPqQKQR/G6bXdjQEwbU5vyUZPfb8j8lE/lbZqd+K7PQgp1pgt3
 1/kHecMRJ1RPF3T+zyp695kM62IPAiCBKDet47yDOZY8GjW42OWIw3826gwynLxnUZridXy0RInm
 4LoVksKIc2z7DPYPtKix12g76aMo7unpzfwvvIUSNbRrc+rGRfK6vZ0DjmDCLNkF8lFzdC3dKrC0
 40sb7T6WUJaskeHiyypxP64R9wcGB81Qog1L/4LHzWXW1NPGuksWg0+xNo/tmVAudW8s5o+5ghyT
 hiMldqvYKYRyuwqOw1UY+39kX7Dw2lQcWdBUl5fGvQkifxA5SOoodA8tBxhp7Fr2gzjHhC7D+gO9
 nDbhSmgoBmKQiBRAJ7iHioE41QRru/
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <f5c9906651aaf0ef084bef152651e1d556b7a9f0.camel@qq.com>
Subject: Re: [PATCH v2] riscv/gdb: add virt mode debug interface
From: Yanfeng Liu <yfliu2008@qq.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
Date: Sat, 30 Nov 2024 08:14:07 +0800
In-Reply-To: <87r06ufjiz.fsf@draig.linaro.org>
References: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
 <8734jbh21e.fsf@draig.linaro.org>
 <tencent_CA6E4D0C897F3ED0EF988CCE5DF541442A05@qq.com>
 <87r06ufjiz.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.205.221.153; envelope-from=yfliu2008@qq.com;
 helo=out203-205-221-153.mail.qq.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.93, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
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

On Fri, 2024-11-29 at 09:59 +0000, Alex Benn=C3=A9e wrote:
> Yanfeng <yfliu2008@qq.com> writes:
>=20
> > On Thu, 2024-11-28 at 14:21 +0000, Alex Benn=C3=A9e wrote:
> > > Yanfeng Liu <yfliu2008@qq.com> writes:
> > >=20
> > > > This adds `virt` virtual register on debug interface so that users
> > > > can access current virtualization mode for debugging purposes.
> > > >=20
> > > > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > > > ---
> > > > =C2=A0gdb-xml/riscv-32bit-virtual.xml |=C2=A0 1 +
> > > > =C2=A0gdb-xml/riscv-64bit-virtual.xml |=C2=A0 1 +
> > > > =C2=A0target/riscv/gdbstub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 18 ++++++++++++------
> > > > =C2=A03 files changed, 14 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32bit-
> > > > virtual.xml
> > > > index 905f1c555d..d44b6ca2dc 100644
> > > > --- a/gdb-xml/riscv-32bit-virtual.xml
> > > > +++ b/gdb-xml/riscv-32bit-virtual.xml
> > > > @@ -8,4 +8,5 @@
> > > > =C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > > > =C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
> > > > =C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"32"/>
> > > > +=C2=A0 <reg name=3D"virt" bitsize=3D"32"/>
> > > > =C2=A0</feature>
> > > > diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64bit-
> > > > virtual.xml
> > > > index 62d86c237b..7c9b63d5b6 100644
> > > > --- a/gdb-xml/riscv-64bit-virtual.xml
> > > > +++ b/gdb-xml/riscv-64bit-virtual.xml
> > > > @@ -8,4 +8,5 @@
> > > > =C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > > > =C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
> > > > =C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"64"/>
> > > > +=C2=A0 <reg name=3D"virt" bitsize=3D"64"/>
> > > > =C2=A0</feature>
> > >=20
> > > I assume these are mirrored in gdb not a QEMU only extension?
> >=20
> > So far I think it is a QEMU extension and the `gdb-multiarch` doesn't t=
reat
> > is
> > specially. My tests shows it basically works:
> >=20
> > ```
> > (gdb) ir virt
> > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:3 [Machine]
> > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > (gdb) set $priv =3D 2
> > (gdb) ir virt
> > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > (gdb) set $virt =3D 1
> > (gdb) ir virt
> > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01
> > (gdb) set $virt =3D 0
> > (gdb) ir virt
> > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > (gdb) set $virt =3D 1
> > (gdb) ir virt
> > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
> > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01
> > (gdb) set $priv =3D 3
> > (gdb) ir virt
> > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:3 [Machine]
> > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > ```
>=20
> A gdbstub test case would be useful for this although I don't know if
> the RiscV check-tcg tests switch mode at all.
>=20
> >=20
> > As I am rather new to QEMU, please teach how we can add it as a QEMU on=
ly
> > extension.
>=20
> You don't need to extend the XML from GDB, you can build a specific one
> for QEMU extensions. For example:
>=20
> =C2=A0=C2=A0=C2=A0 gdb_feature_builder_init(&param.builder,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &cpu->dyn_sysreg_feature.desc,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "org.qemu.gdb.arm.sys.regs",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "system-registers.xml",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 base_reg);
>=20
> This exports all the system registers QEMU knows about and GDB can
> access generically. Note the id is org.qemu..., indicating its our
> schema not gdbs.
Thanks for teaching, I need time to digest. I guess more feature builder AP=
Is
are needed (like append_reg) and the getter/setter callbacks might be at a
different place.

BTW, compared to adding virtual register `virt`, how do you think if we sha=
re
the V bit as part of existing `priv` register?

Or maybe we shall talk to GDB community to get their opinions? If they agre=
e to
add a few words about V bit here
https://sourceware.org/gdb/current/onlinedocs/gdb.html/RISC_002dV-Features.=
html,
then it saves us a lot.=20

>=20







