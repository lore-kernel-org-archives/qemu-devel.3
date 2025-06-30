Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7E4C8302F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 12:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWDfi-0006qz-0e; Mon, 30 Jun 2025 08:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWDfG-0006mh-3v; Mon, 30 Jun 2025 08:31:14 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWDfD-0005yf-6m; Mon, 30 Jun 2025 08:31:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bW59N00yJz6L5Zy;
 Mon, 30 Jun 2025 20:30:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 719BF1402EC;
 Mon, 30 Jun 2025 20:31:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Jun
 2025 14:31:06 +0200
Date: Mon, 30 Jun 2025 13:31:05 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 19/32] tests/qtest/bios-tables-test: Update ARM DSDT
 reference blobs
Message-ID: <20250630133105.00002f43@huawei.com>
In-Reply-To: <f502c91e-ffea-4b39-bedf-9503fc45e568@redhat.com>
References: <20250627095620.3300028-1-eric.auger@redhat.com>
 <20250627095620.3300028-20-eric.auger@redhat.com>
 <f502c91e-ffea-4b39-bedf-9503fc45e568@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 27 Jun 2025 12:00:51 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi,
>=20
> On 6/27/25 11:55 AM, Eric Auger wrote:
> > Changes relate to the introduction of pieces related to
> > acpi-index static support along with root ports with no hotplug.
> >
> > +
> > +    Scope (\_SB.PCI0)
> > +    {
> > +        Method (EDSM, 5, Serialized)
> > +        {
> > +            If ((Arg2 =3D=3D Zero))
> > +            {
> > +                Local0 =3D Buffer (One)
> > +                    {
> > +                         0x00                                         =
    // .
> > +                    }
> > +                If ((Arg0 !=3D ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19=
c3434d") /* Device Labeling Interface */))
> > +                {
> > +                    Return (Local0)
> > +                }
> > +
> > +                If ((Arg1 < 0x02))
> > +                {
> > +                    Return (Local0)
> > +                }
> > +
> > +                Local0 [Zero] =3D 0x81
> > +                Return (Local0)
> > +            }
> > +
> > +            If ((Arg2 =3D=3D 0x07))
> > +            {
> > +                Local0 =3D Package (0x02)
> > +                    {
> > +                        Zero,
> > +                        ""
> > +                    }
> > +                Local1 =3D DerefOf (Arg4 [Zero])
> > +                Local0 [Zero] =3D Local1
> > +                Return (Local0)
> > +            }
> > +        }
> > +
> > +        Device (S00)
> > +        {
> > +            Name (_ADR, Zero)  // _ADR: Address
> > +        }
> > +
> > +        Device (S08)
> > +        {
> > +            Name (_ADR, 0x00010000)  // _ADR: Address
> > +        }
> > +
> > +        Device (S10)
> > +        {
> > +            Name (_ADR, 0x00020000)  // _ADR: Address
> > +        }
> > +    } =20
> after regenerating the blobs using
>=20
> ../tests/data/acpi/rebuild-expected-aml.sh
>=20
> I still get an error :
> Using expected file 'tests/data/acpi/aarch64/virt/DSDT'
> acpi-test: Warning! DSDT binary file mismatch. Actual
> [aml:/tmp/aml-2YB972], Expected [aml:tests/data/acpi/aarch64/virt/DSDT].
> See source file tests/qtest/bios-tables-test.c for instructions on how
> to update expected files.
> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-O0B972.dsl,
> aml:/tmp/aml-2YB972], Expected [asl:/tmp/asl-NO6872.dsl,
> aml:tests/data/acpi/aarch64/virt/DSDT].
>=20
> ../..
>=20
> -
> -=A0=A0=A0=A0=A0=A0=A0 Device (S10)
> -=A0=A0=A0=A0=A0=A0=A0 {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Name (_ADR, 0x00020000)=A0 // _ADR: Ad=
dress
> -=A0=A0=A0=A0=A0=A0=A0 }
> =A0=A0=A0=A0 }
> =A0}
> =A0
> **
> ERROR:../tests/qtest/bios-tables-test.c:554:test_acpi_asl: assertion
> failed: (all_tables_match)
>=20
> (test program exited with status code -6)
>=20
>=20
> I don't get what is wrong.
>=20
> Thoughts?

I've hit so many problems over time with regenerating these I tend
to just blow away the build directory whenever this sort of
issue happens to make sure it's building a clean set.

Otherwise, no idea!

Jonathan

>=20
> Eric
> >  }
> >
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >
> > ---
> >
> > above changes are reported after running make check V=3D2
> > then I launched ../tests/data/acpi/rebuild-expected-aml.sh from the
> > build directory and it putput those reference blobs.
> >
> > But I run make check V=3D2 after committing those changes I get and err=
or
> > which looks totally unexpected to me:
> >
> > acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-LZS=
L82], Expected [aml:tests/data/acpi/aarch64/virt/DSDT].
> > See source file tests/qtest/bios-tables-test.c for instructions on how =
to update expected files.
> > acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-FTSL82.dsl, aml=
:/tmp/aml-LZSL82], Expected [asl:/tmp/asl-ZAWL82.dsl, aml:tests/data/acpi/a=
arch64/virt/DSDT].
> > --- /tmp/asl-ZAWL82.dsl	2025-06-27 03:34:45.518848387 -0400
> > +++ /tmp/asl-FTSL82.dsl	2025-06-27 03:34:45.514848036 -0400
> > @@ -1,30 +1,30 @@
> >  /*
> >   * Intel ACPI Component Architecture
> >   * AML/ASL+ Disassembler version 20210604 (64-bit version)
> >   * Copyright (c) 2000 - 2021 Intel Corporation
> >   *
> >   * Disassembling to symbolic ASL+ operators
> >   *
> > - * Disassembly of tests/data/acpi/aarch64/virt/DSDT, Fri Jun 27 03:34:=
45 2025
> > + * Disassembly of /tmp/aml-LZSL82, Fri Jun 27 03:34:45 2025
> >   *
> >   * Original Table Header:
> >   *     Signature        "DSDT"
> > - *     Length           0x000014BE (5310)
> > + *     Length           0x000014AD (5293)
> >   *     Revision         0x02
> > - *     Checksum         0x8C
> > + *     Checksum         0xEA
> >   *     OEM ID           "BOCHS "
> >   *     OEM Table ID     "BXPC    "
> >   *     OEM Revision     0x00000001 (1)
> >   *     Compiler ID      "BXPC"
> >   *     Compiler Version 0x00000001 (1)
> >   */
> >  DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
> >  {
> >      Scope (\_SB)
> >      {
> >          Device (C000)
> >          {
> >              Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: H=
ardware ID
> >              Name (_UID, Zero)  // _UID: Unique ID
> >          }
> >
> > @@ -1929,24 +1929,19 @@
> >                      }
> >                  Local1 =3D DerefOf (Arg4 [Zero])
> >                  Local0 [Zero] =3D Local1
> >                  Return (Local0)
> >              }
> >          }
> >
> >          Device (S00)
> >          {
> >              Name (_ADR, Zero)  // _ADR: Address
> >          }
> >
> >          Device (S08)
> >          {
> >              Name (_ADR, 0x00010000)  // _ADR: Address
> >          }
> > -
> > -        Device (S10)
> > -        {
> > -            Name (_ADR, 0x00020000)  // _ADR: Address
> > -        }
> >      }
> >  }
> > ---
> >  tests/qtest/bios-tables-test-allowed-diff.h   |   5 -----
> >  tests/data/acpi/aarch64/virt/DSDT             | Bin 5158 -> 5310 bytes
> >  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5244 -> 5379 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6519 -> 6654 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7603 -> 7768 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5360 -> 5495 bytes
> >  6 files changed, 5 deletions(-)
> >
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/=
bios-tables-test-allowed-diff.h
> > index abe00ad4ee..dfb8523c8b 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1,6 +1 @@
> >  /* List of comma-separated changed AML files to ignore */
> > -"tests/data/acpi/aarch64/virt/DSDT",
> > -"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> > -"tests/data/acpi/aarch64/virt/DSDT.memhp",
> > -"tests/data/acpi/aarch64/virt/DSDT.pxb",
> > -"tests/data/acpi/aarch64/virt/DSDT.topology",
> > diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch6=
4/virt/DSDT
> > index acab6e65febbc210158d4c39be0680bbb90250f5..b897d667971500da4732000=
091a6f0828d05d89e 100644
> > GIT binary patch
> > delta 173
> > zcmZ3cu}_oBCD<iop9lj3Q_n^&8IgJccg`5S_+Y2_0B27F5pPykmtbGs1!j}87zzZL
> > z85t55NKKlYAt=3DlxaKZfK(_qso--+U{d?gP%`z}dXz&<sTi)l$h0as&30t3U6gatB_
> > zv$)s`gjksvco`B3nmckB7!nH-A(GKe+`$G0@f`7vE<p^@P5i+I7V#YMl8!DxJPZts
> > OU=3Dc&8G!Fv<69WJ)j4yfs
> >
> > delta 19
> > acmdm|xlDu0CD<iIO@x7g>C8qh84&<COa$Tp
> >
> > diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/dat=
a/acpi/aarch64/virt/DSDT.acpihmatvirt
> > index 54c27e7d95b4956ed1b5dee0d299ccb08dc2a73e..2cef095bcc1bb404f8cd9ec=
77a879ed81c191875 100644
> > GIT binary patch
> > delta 156
> > zcmeyP(X7Sg66_MfEXu&Zv}_|+kx0FO8%K;@e6Uk|fU~E8h&QXNORz8R0<+0k3<ZMB
> > zj0_12q$W+y5ESMTxL|(rX|QRP??mxezLJNXeU~IGV4s@F#k3@$fUB`1fq`L3!UCDe
> > zSzPP|Laa;-ybK8i%^f)m42cDa5XtB!?qCChc#e2Smmr4dCjMXpi+GNB4o8<D9tH+R
> > F1_1j$EA9XQ
> >
> > delta 19
> > acmZqH`lG?+66_LEBf`MI)VYzXNCW^oYz1ck
> >
> > diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/=
aarch64/virt/DSDT.memhp
> > index 4330bc97cba0950191c45ac833533db7a190db81..372ca3d7fb1e2927c7c12f9=
7eec406d597f294ab 100644
> > GIT binary patch
> > delta 156
> > zcmexv^v{^fCD<k8pCkhV6Zb~0T*-O?H;x#+_+Y2_0B27F5pPykmtbGs1!j}87zzZL
> > z85t55NKKlYAt=3DlxaKZfK(_qso--+U{d?gP%`z}dXz&<sTi)l$h0as&30t3U6gatB_
> > zv$)s`gjksvco`B3nmckB7!nH-A(GKe+`$G0@f`7vE<p^@P5i+I7V#YM9F8tQJPZts =20
> > F3;>E4EZYD8 =20
> >
> > delta 19
> > acmexo{N0GlCD<jTT#|u->Fq|YTuA^&WCm0K
> >
> > diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aa=
rch64/virt/DSDT.pxb
> > index 7fdbc03e2bf9fb7d35704779253de36e362f0bf9..c2779882494e16920787b8a=
b7b4cb3c3b70f224b 100644
> > GIT binary patch
> > delta 168
> > zcmdmNeZz*!CD<h-LXLrf$!jCmN?BzA7p@q+_+Y2_0B27F5pPykmtbGs1!j}87zzZL
> > z85t55NKKl&K}IZRNx}m5shM0%OA-pW8aomg7?va~keQst#a<x9%EZ9SkWkRvk;A}{
> > uSda*jjBer%HZX|ih<9`eVu)^%2{y2RaCjIP7#YxH`GXCiN_iL<m>2+L6)WZd
> >
> > delta 19
> > acmca%v)P)<CD<iovn&Gx)9sC1D`f#g-Uey_
> >
> > diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/ac=
pi/aarch64/virt/DSDT.topology
> > index 969b4f6560d3ae39f5b7e0064b7122905476fce8..ebbeedc1ed30d811315c350=
f4cb42f8aa265af73 100644
> > GIT binary patch
> > delta 156
> > zcmeyM`CW_4CD<jTT$F)<>HJ2nXCn0iZX7Xs@xe~<0nVNVBHpa7F2TOM3(O{GF%$?g
> > zGcqJBkeW0(Lr|DY;DY(dr@^LGz7xe?`AQyk_Fa;&fPHEv7t@l20<Ol61O|pB2@7N< =20
> > zXK}F?2(dCT@G>M6G<W1MFeDZvLL{S`xPuK0;yL0SU4j^*oA`qbEaExhIUHSrco-NM =20
> > F8359@EocA$
> >
> > delta 19
> > acmeya^+A)%CD<k8g9rly)25AF&qM%8i3Z^S
> > =20
>=20
>=20


