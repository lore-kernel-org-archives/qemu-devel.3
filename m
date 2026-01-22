Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73963D3EE95
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 17:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viyG6-0005hu-1x; Thu, 22 Jan 2026 12:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viyG4-0005go-9q
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 12:14:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viyG1-0005A6-G8
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 12:14:12 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxnhM6jjDzHnGgq;
 Fri, 23 Jan 2026 01:13:23 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 02F8040584;
 Fri, 23 Jan 2026 01:14:00 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 17:13:59 +0000
Date: Thu, 22 Jan 2026 17:13:57 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Jonathan Cameron via qemu development <qemu-devel@nongnu.org>, "Michael S
 Tsirkin" <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 Igor Mammedov
 <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>, John Snow
 <jsnow@redhat.com>, <linux-cxl@vger.kernel.org>, John Groves
 <jgroves@micron.com>
Subject: Re: [PATCH 02/13] scripts/qmp_helper: add missing CXL UEFI GUID
Message-ID: <20260122171357.00000747@huawei.com>
In-Reply-To: <20260122160809.0a3acbb8@localhost>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <f229d756fe76c34e6dfa48a98f1ee46f4325fc76.1768993993.git.mchehab+huawei@kernel.org>
 <20260121122604.00001609@huawei.com> <aXDx_N3YRACBmC4I@foz.lan>
 <20260122105214.00001cca@huawei.com>
 <20260122160809.0a3acbb8@localhost>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 22 Jan 2026 16:08:09 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> On Thu, 22 Jan 2026 10:52:14 +0000
> Jonathan Cameron via qemu development <qemu-devel@nongnu.org> wrote:
>=20
> > On Wed, 21 Jan 2026 16:45:58 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >  =20
> > > On Wed, Jan 21, 2026 at 12:26:04PM +0000, Jonathan Cameron wrote:   =
=20
> > > > On Wed, 21 Jan 2026 12:25:10 +0100
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > >      =20
> > > > > The UEFI 2.11 - N.2.14. CXL Component Events Section states that
> > > > > XL events are described at CXL specification 3.2:     =20
> > > > CXL
> > > >      =20
> > > > >         8.2.10.2.1 Event Records
> > > > >=20
> > > > > Add the GUIDs defined here to fuzzy logic error injection code.  =
   =20
> > > >=20
> > > > +CC linux-cxl as more folk there who will be familiar with this
> > > > stuff.
> > > >=20
> > > > Some of these won't be seen on a host. The same event
> > > > infrastructure is used for reporting on out of band interfaces
> > > > and some in band ones, but not ones that will turn up on the
> > > > mailboxes that firmware will be using to get info.     =20
> > >=20
> > > Good to know, but UEFI 2.11 still mentions all of them as
> > > possible GUIDs:
> > >=20
> > >     https://uefi.org/specs/UEFI/2.11/Apx_N_Common_Platform_Error_Reco=
rd.html#cxl-component-events-section
> > >=20
> > > So, the UEFI 2.11 doesn't explicitly state they won't de delivered
> > > to OSPM. Quite contrary, they're listed as valid values for CPER,
> > > even if, in practice, they won't.
> > >=20
> > > This is just a small set of variables, that won't bring any major
> > > impact on the code. So, I prefer to keep them in sync with the spec.
> > > If they end removing the unused ones, we can update it in the future.
> > >=20
> > > If you want, I can add a note at the next version with your
> > > comments about them.
> > >    =20
> > A note works for me.
> >=20
> > As I understand it CPER records are getting adopted in other specs
> > so it may make sense to document them, even if they  aren't a possibili=
ty
> > via ACPI.
> >=20
> > However I'm not seeing them in the spec link you point at. =20
> > All I'm seeing is a cross reference the CXL spec Events Record Format. =
=20
>=20
> Heh, true, I got confused with another field. Yet, at CXL spec 3.2,
> it is said that:
>=20
>=20
> 	8.2.10.2 Events
> 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 	This section defines the standard event record format that all CXL devic=
es shall use
> 	when reporting events to the host.
>=20
> 	...
>=20
> 	Table 8-55. Common Event Record Format (Sheet 1 of 2)
>=20
> 	------	--------	--------------------------------------------------------=
--------------------
> 	Byte	Length		Description
> 	Offset	in Bytes
> 	------	--------	--------------------------------------------------------=
--------------------
> 	00h	10h		Event Record Identifier: UUID representing the specific Event R=
ecord format.
> 				The following UUIDs are defined in this spec:
> 				=E2=80=A2 fbcd0a77-c260-417f-85a9-088b1621eba6 =E2=80=93 General Medi=
a Event Record
> 				  (see Table 8-57)
> 				=E2=80=A2 601dcbb3-9c06-4eab-b8af-4e9bfb5c9624 =E2=80=93 DRAM Event R=
ecord (see
> 				  Table 8-58)
> 				=E2=80=A2 fe927475-dd59-4339-a586-79bab113b774 =E2=80=93 Memory Modul=
e Event Record
> 				  (see Table 8-59)
> 				=E2=80=A2 e71f3a40-2d29-4092-8a39-4d1c966c7c65 - Memory Sparing Event=
 Record
> 				  (see Table 8-60)
> 				=E2=80=A2 77cf9271-9c02-470b-9fe4-bc7b75f2da97 =E2=80=93 Physical Swi=
tch Event Record
> 				  (see Table 7-77)
> 				=E2=80=A2 40d26425-3396-4c4d-a5da-3d47263af425 =E2=80=93 Virtual Swit=
ch Event Record
> 				  (see Table 7-78)
> 				=E2=80=A2 8dc44363-0c96-4710-b7bf-04bb99534c3f =E2=80=93 MLD Port Eve=
nt Record (see
> 				  Table 7-79)
> 				=E2=80=A2 ca95afa7-f183-4018-8c2f-95268e101a2a - Dynamic Capacity Eve=
nt Record
> 				  (see Table 8-62)
> 	------	--------	--------------------------------------------------------=
--------------------
>=20
> 	...
>=20
> So, CXL specs say they'll arrive at the host, and UEFI doesn't tell
> they can't arrive the OSPM.
>=20

Fair point. Some of those we shouldn't see at a host. Something to tidy up
in the spec.

+CC John Groves to make it his problem ;)

Dynamic Capacity events go to the host (well some of the them anyway),
but never to firmware, so there is  blurry boundary.
Some values of the Event type for those state they are not sent to the host.
"This event shall only be reported to the FM".

J
> In any case, it is easier to just pick the entire set with 8 GUIDs
> and keep the scripts in sync with the specs than filtering what=20
> shouldn't belong there and why, with the risk of eventually miss
> something.
>=20
> I'll append the diff below to the relevant patches on this patchset.
>=20
> Regards,
> Mauro
>=20
> ---
>=20
> diff --git a/scripts/ghes_decode.py b/scripts/ghes_decode.py
> index 6c7fdfe84e3a..7bac7dbd6b3a 100644
> --- a/scripts/ghes_decode.py
> +++ b/scripts/ghes_decode.py
> @@ -935,6 +935,10 @@ class DecodeCXLCompEvent():
>      """
> =20
>      # GUIDs, as defined at CXL specification 3.2: 8.2.10.2.1 Event Recor=
ds
> +    # on Table 8-55. Common Event Record Format
> +    #
> +    # Please notice that, in practice, not all those events will be pass=
ed
> +    # to OSPM. Some may be handled internally.
>      guids =3D [
>          ("General Media",              "fbcd0a77-c260-417f-85a9-088b1621=
eba6"),
>          ("DRAM",                       "601dcbb3-9c06-4eab-b8af-4e9bfb5c=
9624"),
> diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> index 32baca17ce10..583f898f04ef 100755
> --- a/scripts/qmp_helper.py
> +++ b/scripts/qmp_helper.py
> @@ -778,10 +778,14 @@ class cper_guid:
>                           [0xA6, 0xA6, 0x88, 0xB7,
>                            0x28, 0xCF, 0x75, 0xD7])
> =20
> +    # CXL GUIDs, as defined at CXL specification 3.2: 8.2.10.2.1 Event R=
ecords
> +    # on Table 8-55. Common Event Record Format
> +    #
> +    # Please notice that, in practice, not all those events will be pass=
ed
> +    # to OSPM. Some may be consumed internally
>      CPER_CXL_PROT_ERR =3D guid(0x80B9EFB4, 0x52B5, 0x4DE3,
>                               [0xA7, 0x77, 0x68, 0x78,
>                                0x4B, 0x77, 0x10, 0x48])
> -
>      CPER_CXL_EVT_GEN_MEDIA =3D guid(0xFBCD0A77, 0xC260, 0x417F,
>                                    [0x85, 0xA9, 0x08, 0x8B,
>                                     0x16, 0x21, 0xEB, 0xA6])
>=20
>=20
>=20


