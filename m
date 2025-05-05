Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C219C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBwVf-0006wb-GV; Mon, 05 May 2025 10:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBwVc-0006wN-GF
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:09:29 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBwVZ-0007t7-E4
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:09:27 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1746454163; bh=S+rzvY6EhBf8CYelbqYQfSgXW8IOy6/GHcL8FVeY5gg=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 jKXJNS36EGiSR4CDVQggtErNBH6vgKtUUokD3iCge10TXDOb3ov8GoLb0Ilr+EDhbHtjyJ2c4PCgCQatlqw3DQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1746454163; bh=S+rzvY6EhBf8CYelbqYQfSgXW8IOy6/GHcL8FVeY5gg=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 aPtVul8EY6DHNxRNwI31XZdUn3wAkVR7ExL5zyqPJKx8CF5MfJzq6Q2faxlzuDXNsh0wnicQMZ5CxA767skIXSsDOaoo3NALxV7VqML6VFgEdNO+Xe73CSDVBzYGpEtd4hLyq7Qy2fj1X7D8agju1iFJ4sKK6j0K7A/BRS21E4fzRVXm0uHPOxZPrG4FW58ypYDN5eoS3zBHOTvXh3Nlssm8FO3frFFUjEnvPudoM5JV3wXxUBQs4FRD4409EzQdJ867v33XBLTIlS6Oy8NHz55PMY6EtevBPXB3QMZR+9xuukNwQmmdr+jljEFzuWo2iOlqS37UvQ4UIJsHCNK/zw==
Received: from 172.17.3.7 by netsrv01.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Mon, 05 May 2025 14:09:22 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex14.beckhoff.com
 (172.17.3.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 16:09:21 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Mon, 5 May 2025 16:09:21 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 9/9] vfio/igd: Remove generation limitation for IGD
 passthrough
Thread-Topic: [PATCH 9/9] vfio/igd: Remove generation limitation for IGD
 passthrough
Thread-Index: AQHbuFgiNsa41dzb4UyocwYfDIZDC7PD/F6A
Date: Mon, 5 May 2025 14:09:21 +0000
Message-ID: <884da4da7356c723d8bc4d49944c6cc491077f01.camel@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-10-tomitamoeko@gmail.com>
In-Reply-To: <20250428161004.35613-10-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-18NKrQK1Wxlpeymx6rNn"
MIME-Version: 1.0
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--=-18NKrQK1Wxlpeymx6rNn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-29 at 00:10 +0800, Tomita Moeko wrote:
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
> https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAACrZmEBKRIGeu0=
AAADvIwGqJzMNfJw1SGDaz4T4NOe0pQjgcXIl8aa6EBISsE_mEsZ1x35XrJZk1uUAVgzAGUkZWF=
MG--4B2zOo1pBHv9oVATF-lJkWnY1dOUOHqYlAt4T5EfdMCovIk0M0ZxBIgFBnJEE3wNG6NOh1m=
Pjge5-M1OW80X-Dp9n6iSKirvdFiYnh9VLEHlff9BdoT5IJ8JjnKnoVVAT7iuWwkFDayl2MoMIu=
AKFMrDxfrXsbkPQYuHMP0b_bdAgRcors5TKTBFPsQ1IKC7wICpETvUXKQnqex7TU1gzMwYVj2iE=
C9PKyiY8RBfLgXlCWhE81
> =C2=A0
> [2]
> https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAACrZmEBKRIGetY=
AAACNfuvceS_GGt4XbczrWqbmNztfDneI6ldPTQC3yZpB9711r9-sHzWe45iikAQRMr99rOo7ZX=
_vc6L9JWHxUovjxtqg88ymadBor_RtfcJUH6gTjN4bCIsufZ84hsdPPZ4VCkMbFxROFqERsVxQp=
R_kPhvdqbni1CwWW3rGeBkifKTUC4rH-OmGNSww_6COlh2arRPZR899bXdYf1SFGjDc6zbSFE36=
nMBDW9jc3tBgb2VaMcERYIL-TVSLQoYnRxeybcAqQAE41ZyIoFEH8FHyGaikRWLl0
> =C2=A0
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0docs/igd-assign.txt |=C2=A0 6 +++++
> =C2=A0hw/vfio/igd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 58 ++++++++++++=
++++-----------------------------
> =C2=A02 files changed, 27 insertions(+), 37 deletions(-)
>=20
> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> index fc444503ff..af4e8391fc 100644
> --- a/docs/igd-assign.txt
> +++ b/docs/igd-assign.txt
> @@ -157,6 +157,12 @@ fw_cfg requirements on the VM firmware:
> =C2=A0=C2=A0=C2=A0 it's expected that this fw_cfg file is only relevant t=
o a single PCI
> =C2=A0=C2=A0=C2=A0 class VGA device with Intel vendor ID, appearing at PC=
I bus address
> 00:02.0.
> =C2=A0
> +=C2=A0=C2=A0 Starting from Meteor Lake, IGD devices access stolen memory=
 via its MMIO
> +=C2=A0=C2=A0 BAR2 (LMEMBAR) and removed the BDSM register in config spac=
e. There is
> +=C2=A0=C2=A0 no need for guest firmware to allocate data stolen memory i=
n guest address
> +=C2=A0=C2=A0 space and write it to BDSM register. Value of this fw_cfg f=
ile is 0 in
> +=C2=A0=C2=A0 such case.
> +
> =C2=A0Upstream Seabios has OpRegion and BDSM (pre-Gen11 device only) supp=
ort.
> =C2=A0However, the support is not accepted by upstream EDK2/OVMF. A recom=
mended
> =C2=A0solution is to create a virtual OpRom with following DXE drivers:
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 5d12f753ab..2584861ae6 100644
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
> @@ -458,20 +459,12 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev,=
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
> @@ -518,7 +511,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *=
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
> @@ -535,18 +528,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
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
> >https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAACrZmEBKRIGem=
wAAAAwg
> gXVbgmULncwUjdD3WRW6m3nKghz9vudEZhl9xzeICl7FUK5O-
> hjEdzY8nxw3ASLDUPNCoEiymJZadffJUCslCcwoArfPIlRFLV9huLvwU-
> 6mMTuTItplXGJHszjVRgrc7pHIkf98_n1wyM1=C2=A0);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> -=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 gmch =3D vfio_pci_read_config(&vdev->pdev, IGD_G=
MCH, 4);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /*
> @@ -644,32 +626,34 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
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
> >https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAACrZmEBKRIGem=
wAAAAwg
> gXVbgmULncwUjdD3WRW6m3nKghz9vudEZhl9xzeICl7FUK5O-
> hjEdzY8nxw3ASLDUPNCoEiymJZadffJUCslCcwoArfPIlRFLV9huLvwU-
> 6mMTuTItplXGJHszjVRgrc7pHIkf98_n1wyM1=C2=A0, (gms_size / MiB));
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 return true;

This commit looks good. However, you haven't tested it yet, right? I'm also
unable to test it. It would be good if someone could test this patch before
merging it.

Not sure what upstream thinks about it. From my side:

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>


--=20
Kind regards,
Corvin

--=-18NKrQK1Wxlpeymx6rNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgYxo8ACgkQ2FTaVjFe
Amp/+Q/9FVXvGuJebFkRR8H34FwB3ENxAttTEVvt6yRAAIjJhVpZxo80+8tQ7EVP
ovNhvEcZg6lqtHBHB4PBSE1c8kG6KdCuxk1JtovK+SapH/5HEwrx980ZLqiLou1w
e1R35kwxacbS2BDtz9MdIHiFEUo+M69u4j/U6ixBaBpnYqvzCXtyAteyaZw1Duhh
KwjZQtddFrNmoioQuanWpQvJK7TZ/Lij9jeXaF7LF1wBth6AoevfL1PEiVcEON+T
ExUXUWN+jYqs29EE+gRBjCHVDCcNBKwuENi6gfcGd7BTfGI8jjrekRVDhnqAZUmJ
EkZyXyAf7Bq6mhApzkxtnPE7GPMiIvhIcMHJT0pAh1DE/rQdZKzSb6Ny9bdV+LY1
JMgbx7ccqNwa1gpIBQJCqzRwneHYEt5u53uIsz5R0VuBpcBVMbUm/JoOAKN+km7E
27Y3dZNxCN4MhadzvIco+L52s0yarvw0/eeeNjy5YRu+odUpkyRMLW1X/ZWqTrjl
khDKwVL3rtplrX0ZSkFcu5nQsJi+w2kxKUEVGxrXc6AFb3MZfvBLr+SrDH4QA00/
wkiiUM9a2T3d19w6JXAEwExYkr18smKCc9mv2j4+Y3vUqZ5R+25jJsRzgVOfWbEL
FT2xNFOMAFW8EpgqHnmfMVlHxLASSrp+gmeB+lHhQlWelToN9+4=
=B/Bm
-----END PGP SIGNATURE-----

--=-18NKrQK1Wxlpeymx6rNn--


