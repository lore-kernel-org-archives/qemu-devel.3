Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72826C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGHV-0003oz-2H; Tue, 21 Jan 2025 10:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taGHO-0003mD-RY
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:35:03 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taGHL-0007VF-Pl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:35:02 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YcrnT5WVyz6M4PV;
 Tue, 21 Jan 2025 23:33:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 05712140A70;
 Tue, 21 Jan 2025 23:34:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 16:34:55 +0100
Date: Tue, 21 Jan 2025 15:34:53 +0000
To: Zhi Wang <zhiw@nvidia.com>
CC: Alejandro Lucero Palau <alucerop@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>, "fan.ni@samsung.com"
 <fan.ni@samsung.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>, "Andy
 Currid" <ACurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>, Surath Mitra
 <smitra@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>, Aniket Agashe
 <aniketa@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, "zhiwang@kernel.org" <zhiwang@kernel.org>
Subject: Re: [PATCH 0/3] Introduce CXL type-2 device emulation
Message-ID: <20250121153453.000062ee@huawei.com>
In-Reply-To: <7c8c7dd1-2e57-4a65-94f3-46ef6482474e@nvidia.com>
References: <20241212130422.69380-1-zhiw@nvidia.com>
 <eb417797-04aa-3572-02cf-5b858866edc7@amd.com>
 <7c8c7dd1-2e57-4a65-94f3-46ef6482474e@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.086, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 12 Dec 2024 18:10:10 +0000
Zhi Wang <zhiw@nvidia.com> wrote:

> On 12/12/2024 18.49, Alejandro Lucero Palau wrote:
> >=20
> > On 12/12/24 13:04, Zhi Wang wrote: =20
> >> Hi folks:
> >>
> >> Per the discussion with Ira/Jonathan in the LPC 2024 and in the CXL
> >> discord channel, we are trying to introduce a CXL type-2 device emulat=
ion
> >> in QEMU, as there are work currently on supporting CXL type-2 device [=
1]
> >> in Linux kernel and CXL type-2 device virtualization [2].
> >>
> >> It provides a bare minimum base for folks who would like to:
> >>
> >> - Contribute and test the CXL type-2 device support in the linux kernel
> >> =A0=A0 and CXL type-2 virtualization without having an actual HW.
> >> - Introduce more emulated features to prototype the kernel CXL type-2
> >> =A0=A0 device features and CXL type-2 virtualization.
> >>
> >> To test this patchset, please refer to steps in [3]. Use this patcheset
> >> with the latest QEMU repo to be the QEMU host. It achieves the same=20
> >> output
> >> as in the demo video [4]: The VFIO CXL core and VFIO CXL sample variant
> >> driver can be attached to the emulated device in the L1 guest and=20
> >> assigned
> >> to the L2 guest. The sample driver in the L2 guest can attach to the
> >> pass-thrued device and create the CXL region.
> >>
> >> Tested on the CXL type-2 virtualization RFC patches [3] with an extra
> >> fix [5].
> >>
> >> [1] https://nam11.safelinks.protection.outlook.com/?=20
> >> url=3Dhttps%3A%2F%2Flore.kernel.org%2Flinux-=20
> >> cxl%2F20241209185429.54054-1-alejandro.lucero-=20
> >> palau%40amd.com%2FT%2F%23t&data=3D05%7C02%7Czhiw%40nvidia.com%7C3a6113=
9bf3554f4f38f408dd1accf1b9%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638=
696189761390919%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA=
uMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat=
a=3D6WziKnwMlZJQ4yxT2jLn7W1So0OfqYss78fOosuLiwA%3D&reserved=3D0
> >> [2] https://nam11.safelinks.protection.outlook.com/?=20
> >> url=3Dhttps%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3De5OW1pR84Zs&data=3D0=
5%7C02%7Czhiw%40nvidia.com%7C3a61139bf3554f4f38f408dd1accf1b9%7C43083d15727=
340c1b7db39efd9ccc17a%7C0%7C0%7C638696189761413039%7CUnknown%7CTWFpbGZsb3d8=
eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI=
sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DhTF%2F1I%2B4fYPQeCz7NhM0uvWd%2FrWfIz=
aKdcteD5%2BrcZ0%3D&reserved=3D0
> >> [3] https://nam11.safelinks.protection.outlook.com/?=20
> >> url=3Dhttps%3A%2F%2Flore.kernel.org%2Fkvm%2F20240920223446.1908673-3-=
=20
> >> zhiw%40nvidia.com%2FT%2F&data=3D05%7C02%7Czhiw%40nvidia.com%7C3a61139b=
f3554f4f38f408dd1accf1b9%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C63869=
6189761425646%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuM=
DAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=
=3DWq3mr0mXZCbG3cXRKlibq%2BksTuwL8RGqiUS9jBFDfDY%3D&reserved=3D0
> >> [4] https://nam11.safelinks.protection.outlook.com/?=20
> >> url=3Dhttps%3A%2F%2Fyoutu.be%2Fzlk_ecX9bxs%3Fsi%3Dpf9CttcGT5KwUgiH&dat=
a=3D05%7C02%7Czhiw%40nvidia.com%7C3a61139bf3554f4f38f408dd1accf1b9%7C43083d=
15727340c1b7db39efd9ccc17a%7C0%7C0%7C638696189761437780%7CUnknown%7CTWFpbGZ=
sb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTW=
FpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DSReTnBUC1bIhBwC%2BvASCXX%2F0ltI=
YcfWAkHXMmi%2FTRRg%3D&reserved=3D0
> >> [5] https://nam11.safelinks.protection.outlook.com/?=20
> >> url=3Dhttps%3A%2F%2Flore.kernel.org%2Flinux-=20
> >> cxl%2F20241212123959.68514-1-=20
> >> zhiw%40nvidia.com%2FT%2F%23u&data=3D05%7C02%7Czhiw%40nvidia.com%7C3a61=
139bf3554f4f38f408dd1accf1b9%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C6=
38696189761449589%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL=
jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sd=
ata=3DpmZ8JNctUlcLFwQLivNMkHj7fMt2PR24e%2BuHY%2Bk7bNA%3D&reserved=3D0
> >>
> >> Zhi Wang (3):
> >> =A0=A0 hw/cxl: factor out cxl_host_addr_to_dpa()
> >> =A0=A0 hw/cxl: introduce cxl_component_update_dvsec()
> >> =A0=A0 hw/cxl: introduce CXL type-2 device emulation
> >>
> >> =A0 MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 1 +
> >> =A0 docs/system/devices/cxl.rst=A0=A0=A0 |=A0 11 ++
> >> =A0 hw/cxl/cxl-component-utils.c=A0=A0 | 103 ++++++++++-
> >> =A0 hw/cxl/cxl-host.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 19 +-
> >> =A0 hw/mem/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0=A0 5 +
> >> =A0 hw/mem/cxl_accel.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 319 +++++=
++++++++++++++++++++++++++++
> >> =A0 hw/mem/cxl_type3.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 61 +--=
----
> >> =A0 hw/mem/meson.build=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> >> =A0 include/hw/cxl/cxl_component.h |=A0=A0 7 +
> >> =A0 include/hw/cxl/cxl_device.h=A0=A0=A0 |=A0 25 +++
> >> =A0 include/hw/pci/pci_ids.h=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> >> =A0 11 files changed, 484 insertions(+), 69 deletions(-)
> >> =A0 create mode 100644 hw/mem/cxl_accel.c
> >> =20
> >=20
> > Hi Zhi,
> >=20
> >=20
> > Thank you for this patchset.
> >=20
> >=20
> > I=A0 have a similar work done for helping in the Type2 support work, bu=
t=20
> > it is all quick-and-dirty changes.
> >=20
> >=20
> > My main concern here is with the optional features for Type2: how to=20
> > create an easy way for configuring Type2 devices using some qemu cxl=20
> > param. I'm afraid I did not work on that so no suggestions at all!
> >  =20
>=20
> Hi Alejandro:
>=20
> No worries. The work is to provide a minimum base for CXL folks and CXL=20
> type-2 folks to start with, e.g. introducing more emulated features. As=20
> the type-3 emulation has been quite complicated and I was thinking maybe=
=20
> having a clean start would help. For re-factoring, I was mostly thinking=
=20
> of a step by step style: E.g. when both emulation of devices are=20
> reaching a point to have the common routines, then we re-factor them or=20
> draw a glue layer.
>=20
> Also, the patchset is good enough for people to test our works.
>=20
> If folks are OK on this minimum emulation, I think the next thing would=20
> be meaningful for us is aligning the plan for what features that we want=
=20
> to plug into this, so that we can share the efforts.
>=20
> The items on my list are:
>=20
> - Locked HDM decoder
> - CDAT and DOE
>=20
> I remembered you were talking about the configuration params, I think it=
=20
> can be very helpful on prototyping different features in the kernel as=20
> well. Feel free to reach out for discussions.
>=20
Rather than try to support every combination under the sun, I'd suggest
a couple of representative choices.   Anyone developing the kernel can
come and tweak if they need other combinations of features.

Typical test cases, so everything on, everything off, a mix or
two of features on.

Trying to make something really configurable via parameters will end
up with nonsense combinations and just revealing bugs in the qemu emulation
rather than what we actually want to test.

If you want to go really general though feel free to pitch it and we'll
see how bad it is.

Jonathan

> Z.
>=20
> >=20
> > Thank you
> >  =20
>=20


