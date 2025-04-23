Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327B1C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UXF-0000x8-Mk; Wed, 23 Apr 2025 03:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1u7UX3-0000fU-TX
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:28:35 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1u7UX1-000230-C7
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:28:33 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1745392989; bh=yKAeqy1oKhouQhqxFgnAHACHkexvqQO1W2iEHXZH+Tc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 YT+i9HO4UBQnYhDhQ43FA4zyOdWg4QZN6nPxzIUcXb7FbCiJ+dRx4kb512mxA7h9dCLd6ioRlOiHeawxkEL4CA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1745392989; bh=yKAeqy1oKhouQhqxFgnAHACHkexvqQO1W2iEHXZH+Tc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 eLMbrcyH4Ip0BmtL/rlDFGyQMZxX+y+vLaP8Ly0YE8vJTduiZYWGCI+IUtvK+UyCGWLbVBv0HDOYs2UdcmcAg9XSs8/yTImxRqTNKtT1oQ+IDrwxKja+UwgM6775AsohF5UH/CcRgMKck8yfvepg5a7Wpwy3AWPiPQttlatFmfQbzMsPXkjiZzCC8KTFt1vO9E8y5HyzWI1vdXeK+B5AUK7EhgzmorzBoqhmNm+lmOfxiSsVNlspVgyrzfvr6ympTweUU7svtWSl3+tVhuqv1FJ7PoZTjUd0+RgTk/8SBbvATxcwDWjWMqGGn2lDgCoDeoQX8eOMy6Cth9taNPx7JQ==
Received: from 172.17.6.19 by netsrv01.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Wed, 23 Apr 2025 07:23:07 GMT
Received: from ex07.beckhoff.com (172.17.5.172) by ex13.beckhoff.com
 (172.17.6.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 23 Apr
 2025 09:19:37 +0200
Received: from ex04.beckhoff.com (172.17.5.170) by ex07.beckhoff.com
 (172.17.5.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 09:19:36 +0200
Received: from ex04.beckhoff.com ([fe80::d02e:4c24:89d8:a7a3]) by
 ex04.beckhoff.com ([fe80::d02e:4c24:89d8:a7a3%6]) with mapi id
 15.01.2507.039; Wed, 23 Apr 2025 09:19:36 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 10/11] vfio/igd: Remove generation limitation for IGD
 passthrough
Thread-Topic: [PATCH 10/11] vfio/igd: Remove generation limitation for IGD
 passthrough
Thread-Index: AQHbstr/+QVCHUP7tk+H4lN4aCkOz7OwuOMA
Date: Wed, 23 Apr 2025 07:19:36 +0000
Message-ID: <b0aacab43cc76ef559a704b3066e52484bb901c4.camel@beckhoff.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
 <20250421163112.21316-11-tomitamoeko@gmail.com>
In-Reply-To: <20250421163112.21316-11-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-6TSNo/pxZrPKc3Nt+iUr"
MIME-Version: 1.0
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--=-6TSNo/pxZrPKc3Nt+iUr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-22 at 00:31 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> Starting from Intel Core Ultra Series (Meteor Lake), Data Stolen Memory
> has became a part of LMEMBAR (MMIO BAR2) [1][2], meaning that BDSM and
> GGC register quirks are no longer needed on these platforms.
>=20
> To support Meteor/Arrow/Lunar Lake and future IGD devices, remove the
> generation limitation in IGD passthrough, and apply BDSM and GGC quirks
> only to known Gen6-12 devices.
>=20
> [1]
> https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAABHhgBhwX01GO0=
AAACNi-GgHiUI4sV0qRTHkaBvP5PrY5DqqTz9YhuTNO_iXQUZlCVu442aEFUtFJIN9H4QuJJwNJ=
h5ry3XO19WptfEahlpGX9F7Nq8Xpv-GQ9_LZd6niU0I-kMcs9DxxlKk8E802ILvUeF86QyZP4D7=
A7AEaoUDo15UvzlwHlTOoUj4fzKJYvykniL_MlVr8H8FS2ySMcVqfE6IFb5Aiwhkq7hrpL53XHU=
YCVoK_y89PCzSWC-Y0fS5-Xo-SxRDOtI140aTd7KpmA39tf447LtBR1YQP8ccM8PjukqvroMpZt=
V3cDQcgya3EsmP0Fgrmc1
> =C2=A0
> [2]
> https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAABHhgBhwX01GNY=
AAAAtMYPOda9hw4SLBezXYKaYHKRl05pN8tzXcVl9njzCJlE1HkXUG-mljVszTJQKhcQYQTJNcu=
CekCys_GWgxsVTyOaS_NHFmHSUCZG_K4lK67xtRF6gmeuH6VTzSH0evGV976t_N2r5ADGfofxEA=
3bNt0iJmL1IzjhRilkRiNe-EmvdQ7DLMn1nAV9ZQCkPM5bCjIyd7MIjXMAlwhK4CraFMv1xw33w=
-ZnR0YrP4VIGHwKE7vUKp7-BjGZzyrgtwQ5m2SKD0zkEOs3dls5l351dSvNfqp740
> =C2=A0
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 58 +++++++++++++++++++-----------------------------=
---
> =C2=A01 file changed, 21 insertions(+), 37 deletions(-)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index bc4c79837d..5b888616f0 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -103,6 +103,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
> =C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Unfortunately, Intel changes it's specif=
ication quite often. This
> makes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it impossible to use a suitable default =
value for unknown devices.
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Return -1 for not applying any generation-spe=
cific quirks.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> =C2=A0}
> @@ -434,20 +435,12 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev,=
 int
> nr)
> =C2=A0=C2=A0=C2=A0=C2=A0 VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
> =C2=A0=C2=A0=C2=A0=C2=A0 int gen;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /*
> -=C2=A0=C2=A0=C2=A0=C2=A0 * This must be an Intel VGA device at address 0=
0:02.0 for us to even
> -=C2=A0=C2=A0=C2=A0=C2=A0 * consider enabling legacy mode. Some driver ha=
ve dependencies on the
> PCI
> -=C2=A0=C2=A0=C2=A0=C2=A0 * bus address.
> -=C2=A0=C2=A0=C2=A0=C2=A0 */

Same goes for this comment. It's not really correct as UEFI GOP and OS driv=
er
depend on address 0:2.0 too but I'd keep and improve it to make it more cle=
ar
for future reader.

> =C2=A0=C2=A0=C2=A0=C2=A0 if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_=
ANY_ID) ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !vfio_is_vga(vdev) || nr=
 !=3D 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /*
> -=C2=A0=C2=A0=C2=A0=C2=A0 * Only on IGD devices of gen 11 and above, the =
BDSM register is mirrored
> -=C2=A0=C2=A0=C2=A0=C2=A0 * into MMIO space and read from MMIO space by t=
he Windows driver.
> -=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 /* Only on IGD Gen6-12 device needs quirks in BAR 0 *=
/
> =C2=A0=C2=A0=C2=A0=C2=A0 gen =3D igd_gen(vdev);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (gen < 6) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> @@ -494,7 +487,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *=
vdev,
> Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 g_autofree struct vfio_region_info *opregion =3D=
 NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret, gen;
> -=C2=A0=C2=A0=C2=A0 uint64_t gms_size;
> +=C2=A0=C2=A0=C2=A0 uint64_t gms_size =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t *bdsm_size;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t gmch;
> =C2=A0=C2=A0=C2=A0=C2=A0 bool legacy_mode_enabled =3D false;
> @@ -514,18 +507,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
> *vdev, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 info_report("OpRegion detected on Intel display =
%x.", vdev->device_id);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /*
> -=C2=A0=C2=A0=C2=A0=C2=A0 * IGD is not a standard, they like to change th=
eir specs often.=C2=A0 We
> -=C2=A0=C2=A0=C2=A0=C2=A0 * only attempt to support back to SandBridge an=
d we hope that newer
> -=C2=A0=C2=A0=C2=A0=C2=A0 * devices maintain compatibility with generatio=
n 8.
> -=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 gen =3D igd_gen(vdev);
> -=C2=A0=C2=A0=C2=A0 if (gen =3D=3D -1) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("IGD device %s i=
s unsupported in legacy mode, "
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "try SandyBridge or newer"=
, vdev-
> >https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAABHhgBhwX01GG=
wAAADNE
> nn7fAHvEAN3EJV6Ng4dOzKc7MR7f3e317FXOTfRW-ZxuzGFRyquEjUjSeP-
> 6ByDI2TtwvI3jwlJBjQdXL-V9t40AFbX3wSV_K-
> M0j4dDCcdYxjOhLKhEroDvVJ0XE20BM2QEteRk67iEFo1=C2=A0);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> -=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 gmch =3D vfio_pci_read_config(&vdev->pdev, IGD_G=
MCH, 4);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /*
> @@ -624,32 +606,34 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
> *vdev, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 gms_size =3D igd_stolen_memory_size(gen, gmch);
> +=C2=A0=C2=A0=C2=A0 if (gen > 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gms_size =3D igd_stolen_memor=
y_size(gen, gmch);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* BDSM is read-write, emulat=
ed. BIOS needs to be able to write it */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gen < 11) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_s=
et_long(vdev->pdev.config + IGD_BDSM, 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_s=
et_long(vdev->pdev.wmask + IGD_BDSM, ~0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_s=
et_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_s=
et_quad(vdev->pdev.config + IGD_BDSM_GEN11, 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_s=
et_quad(vdev->pdev.wmask + IGD_BDSM_GEN11, ~0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_s=
et_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Request reserved memory for stolen memor=
y via fw_cfg.=C2=A0 VM firmware
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * must allocate a 1MB aligned reserved mem=
ory region below 4GB with
> -=C2=A0=C2=A0=C2=A0=C2=A0 * the requested size (in bytes) for use by the =
Intel PCI class VGA
> -=C2=A0=C2=A0=C2=A0=C2=A0 * device at VM address 00:02.0.=C2=A0 The base =
address of this reserved
> -=C2=A0=C2=A0=C2=A0=C2=A0 * memory region must be written to the device B=
DSM register at PCI
> -=C2=A0=C2=A0=C2=A0=C2=A0 * config offset 0x5C.
> +=C2=A0=C2=A0=C2=A0=C2=A0 * the requested size (in bytes) for use by the =
IGD device. The base
> +=C2=A0=C2=A0=C2=A0=C2=A0 * address of this reserved memory region must b=
e written to the
> +=C2=A0=C2=A0=C2=A0=C2=A0 * device BDSM register.
> +=C2=A0=C2=A0=C2=A0=C2=A0 * For newer device without BDSM register, this =
fw_cfg item is 0.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 bdsm_size =3D g_malloc(sizeof(*bdsm_size));
> =C2=A0=C2=A0=C2=A0=C2=A0 *bdsm_size =3D cpu_to_le64(gms_size);
> =C2=A0=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-siz=
e",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdsm_size, sizeof(*bdsm_si=
ze));
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /* BDSM is read-write, emulated.=C2=A0 The BIOS needs=
 to be able to write it
> */
> -=C2=A0=C2=A0=C2=A0 if (gen < 11) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_long(vdev->pdev.confi=
g + IGD_BDSM, 0);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_long(vdev->pdev.wmask=
 + IGD_BDSM, ~0);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_long(vdev->emulated_c=
onfig_bits + IGD_BDSM, ~0);
> -=C2=A0=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_quad(vdev->pdev.confi=
g + IGD_BDSM_GEN11, 0);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_quad(vdev->pdev.wmask=
 + IGD_BDSM_GEN11, ~0);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_quad(vdev->emulated_c=
onfig_bits + IGD_BDSM_GEN11, ~0);
> -=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 trace_vfio_pci_igd_bdsm_enabled(vdev-
> >https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAABHhgBhwX01GG=
wAAADNE
> nn7fAHvEAN3EJV6Ng4dOzKc7MR7f3e317FXOTfRW-ZxuzGFRyquEjUjSeP-
> 6ByDI2TtwvI3jwlJBjQdXL-V9t40AFbX3wSV_K-
> M0j4dDCcdYxjOhLKhEroDvVJ0XE20BM2QEteRk67iEFo1=C2=A0, (gms_size / MiB));
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 return true;

--=20
Kind regards,
Corvin

--=-6TSNo/pxZrPKc3Nt+iUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgIlIYACgkQ2FTaVjFe
AmoLdg/9Efg2141C1NQZQmzUS0BbWoCl1y4COv06YFbdwEQfJAxukfoQYdorlJPn
YYB8M2HWNEwBut6l0T1Xet7mr6CCDHbA2MBn1q+ZCP8IDp90o5SWn4wsRLBIY3vZ
8Ralcg+Ai7VjSmQDliYwatYxBlhwKRYcHkrw+gUyNCKaWVpI0sL9Zo74k+SCvpj2
F10TSlmjHGLVM3a0DidzA32tOD1nBWV45mQ4+ldgjkJqr8c22muHQOZ61KQFQogk
giiETbZyxCwOiOqvXYB9E1p8uFsHTkjKNsgW3K3Ue4qOFumuFRGQoVqejeq7SA9s
NcBJJkAVWGTtFobVa8kb/73ARrk5sxcSdNZsJXAQFKRdkDha2QKBc4YaYLHgZzWy
469DPMQYW26haLEHVU+H6mBSR9xx6gOccWbqTJA9EV7o3JXisCJFWP6417Sk5rBJ
EBMbGysU5NWyXqyD+aA/ajfGDvXcMVk++/ZRy5PbC6AeZ4ODDFq66RkBRsVuKeOZ
09Po1CPJqqaF7k21q0tFJtkSP2XHBl9zSKZPOPUVfSnU+ZhsbQ3jVwtLfn758p5g
b7umbQ+z0OnyN+d/AJdeucCU0DR19dTTz8BMTTgTiPuIpgB4Cv3WUoUBnTR1KQjg
aib4F0kEaZPBhBdqZKIykKHkppj7W2f3bYH04BVFIPpJ46Yn9GM=
=r7YN
-----END PGP SIGNATURE-----

--=-6TSNo/pxZrPKc3Nt+iUr--


