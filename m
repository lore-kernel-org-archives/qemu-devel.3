Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B3DE74AC1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIVW7-0000rN-Tu; Tue, 03 Dec 2024 11:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVW5-0000rA-NB
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:12:49 -0500
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVW3-0005x2-Ga
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:12:49 -0500
Received: from 172.17.2.168 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Tue, 03 Dec 2024 16:12:45 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733242365; bh=xiCVXNdkcZXlGTRX5QUGGsypLWopq4QvsUN7pQlWAeI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 IhH/ofAaSYluP25VjHPfvNOGdmYKhaIUcb5CxhzqPOyffDgNa5gxq94PQaT+cmU2724ZRybha9ZaCHs+TWqbBQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733242365; bh=xiCVXNdkcZXlGTRX5QUGGsypLWopq4QvsUN7pQlWAeI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 TEh32gfpdI5ABYFGrCXAjso+HK4t69dSVqEw6oLPs6uj+11T7fGB6a8SJ372wu06aXaAq6k6drg2mhUqcoaVX57fZJPir3uwG9gMVOXgJq1N8xLI1f/+hmUQTFiJl3eaawIO36sy/8IRFHCe7Lc2k+O93zxaeEWRj3ygEkJQRCcmgNnsmiJWqJ7GbsOXCAgKu5+/25ADttLPrYwDPfYqU1myItR4iS9sPtsrAKuiTCvd1IUlFo4mmZU/Kziv9kJ2G9Qh/bH08QDabEoVzO0qBEF3F8Gpl4nR70C3gzjquCfA94lxpMB5ZxNyLFVL1qwsu7ExsRvvTvVCdaU7qekD5A==
Received: from ex04.beckhoff.com (172.17.5.170) by ex01.beckhoff.com
 (172.17.2.168) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Dec
 2024 17:12:44 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Tue, 3 Dec 2024 17:12:44 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@redhat.com" <clg@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 3/9] vfio/igd: canonicalize memory size calculations
Thread-Topic: [PATCH v2 3/9] vfio/igd: canonicalize memory size calculations
Thread-Index: AQHbRYhVhUyJmVKTBkmf18qLyO73TbLUoIoA
Date: Tue, 3 Dec 2024 16:12:44 +0000
Message-ID: <61ee6c4f27b62891a9d045b07821d03a8659f35e.camel@beckhoff.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-4-tomitamoeko@gmail.com>
In-Reply-To: <20241203133548.38252-4-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.130.158]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-wCinDl9dXiFn8Om5V1Pu"
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

--=-wCinDl9dXiFn8Om5V1Pu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-12-03 at 21:35 +0800, Tomita Moeko wrote:
> =EF=BB=BFCAUTION: External Email!!
> Add helper functions igd_gtt_memory_size() and igd_stolen_size() for
> calculating GTT stolen memory and Data stolen memory size in bytes,
> and use macros to replace the hardware-related magic numbers for
> better readability.
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0hw/vfio/igd.c | 99 ++++++++++++++++++++++++++++--------------------=
---
> =C2=A01 file changed, 55 insertions(+), 44 deletions(-)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 2ede72d243..b5bfdc6580 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -106,6 +106,51 @@ typedef struct VFIOIGDQuirk {
> =C2=A0#define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
> =C2=A0#define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11=
 and later
> */
> =C2=A0
> +#define IGD_GMCH_GEN6_GMS_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0 3=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* SNB_GMCH in i915 */
> +#define IGD_GMCH_GEN6_GMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1f
> +#define IGD_GMCH_GEN6_GGMS_SHIFT=C2=A0=C2=A0=C2=A0 8
> +#define IGD_GMCH_GEN6_GGMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0 0x3
> +#define IGD_GMCH_GEN8_GMS_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0 8=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* BDW_GMCH in i915 */
> +#define IGD_GMCH_GEN8_GMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xff
> +#define IGD_GMCH_GEN8_GGMS_SHIFT=C2=A0=C2=A0=C2=A0 6
> +#define IGD_GMCH_GEN8_GGMS_MASK=C2=A0=C2=A0=C2=A0=C2=A0 0x3
> +
> +static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
> +{
> +=C2=A0=C2=A0=C2=A0 uint64_t ggms;
> +
> +=C2=A0=C2=A0=C2=A0 if (gen < 8) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D (gmch >> IGD_GMCH_GE=
N6_GGMS_SHIFT) & IGD_GMCH_GEN6_GGMS_MASK;
> +=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D (gmch >> IGD_GMCH_GE=
N8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms *=3D 2;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return ggms * MiB;
> +}
> +
> +static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
> +{
> +=C2=A0=C2=A0=C2=A0 uint64_t gms;
> +
> +=C2=A0=C2=A0=C2=A0 if (gen < 8) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gms =3D (gmch >> IGD_GMCH_GEN=
6_GMS_SHIFT) & IGD_GMCH_GEN6_GMS_MASK;
> +=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gms =3D (gmch >> IGD_GMCH_GEN=
8_GMS_SHIFT) & IGD_GMCH_GEN8_GMS_MASK;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 if (gen < 9) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n gms * 32 * MiB;
> +=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gms < 0xf0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n gms * 32 * MiB;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n (gms - 0xf0 + 1) * 4 * MiB;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return 0;
> +}
> =C2=A0
> =C2=A0/*
> =C2=A0 * The rather short list of registers that we copy from the host de=
vices.
> @@ -254,17 +299,10 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vde=
v,
> =C2=A0static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t gmch =3D vfio_pci_read_config(&vdev->pd=
ev, IGD_GMCH,
> sizeof(gmch));
> -=C2=A0=C2=A0=C2=A0 int ggms, gen =3D igd_gen(vdev);
> -
> -=C2=A0=C2=A0=C2=A0 gmch =3D vfio_pci_read_config(&vdev->pdev, IGD_GMCH, =
sizeof(gmch));
> -=C2=A0=C2=A0=C2=A0 ggms =3D (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -=C2=A0=C2=A0=C2=A0 if (gen >=3D 8) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms =3D 1 << ggms;
> -=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0 ggms *=3D MiB;
> +=C2=A0=C2=A0=C2=A0 int gen =3D igd_gen(vdev);
> +=C2=A0=C2=A0=C2=A0 uint64_t ggms_size =3D igd_gtt_memory_size(gen, gmch)=
;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 return (ggms / (4 * KiB)) * (gen < 8 ? 4 : 8);
> +=C2=A0=C2=A0=C2=A0 return (ggms_size / (4 * KiB)) * (gen < 8 ? 4 : 8);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -471,30 +509,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, =
int
> nr)
> =C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk,=
 next);
> =C2=A0}
> =C2=A0
> -static int igd_get_stolen_mb(int gen, uint32_t gmch)
> -{
> -=C2=A0=C2=A0=C2=A0 int gms;
> -
> -=C2=A0=C2=A0=C2=A0 if (gen < 8) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gms =3D (gmch >> 3) & 0x1f;
> -=C2=A0=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gms =3D (gmch >> 8) & 0xff;
> -=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0 if (gen < 9) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gms > 0x10) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error=
_report("Unsupported IGD GMS value 0x%x", gms);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n 0;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gms * 32;
> -=C2=A0=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gms < 0xf0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n gms * 32;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n (gms - 0xf0) * 4 + 4;
> -=C2=A0=C2=A0=C2=A0 }
> -}
> -
> =C2=A0void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 g_autofree struct vfio_region_info *rom =3D NULL=
;
> @@ -504,7 +518,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, i=
nt
> nr)
> =C2=A0=C2=A0=C2=A0=C2=A0 VFIOQuirk *quirk;
> =C2=A0=C2=A0=C2=A0=C2=A0 VFIOIGDQuirk *igd;
> =C2=A0=C2=A0=C2=A0=C2=A0 PCIDevice *lpc_bridge;
> -=C2=A0=C2=A0=C2=A0 int i, ret, ggms_mb, gms_mb =3D 0, gen;
> +=C2=A0=C2=A0=C2=A0 int i, ret, gen;
> +=C2=A0=C2=A0=C2=A0 uint64_t ggms_size, gms_size;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t *bdsm_size;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t gmch;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint16_t cmd_orig, cmd;
> @@ -666,13 +681,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, =
int
> nr)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk,=
 next);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /* Determine the size of stolen memory needed for GTT=
 */
> -=C2=A0=C2=A0=C2=A0 ggms_mb =3D (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -=C2=A0=C2=A0=C2=A0 if (gen >=3D 8) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ggms_mb =3D 1 << ggms_mb;
> -=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0 gms_mb =3D igd_get_stolen_mb(gen, gmch);
> +=C2=A0=C2=A0=C2=A0 ggms_size =3D igd_gtt_memory_size(gen, gmch);
> +=C2=A0=C2=A0=C2=A0 gms_size =3D igd_stolen_memory_size(gen, gmch);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Request reserved memory for stolen memor=
y via fw_cfg.=C2=A0 VM firmware
> @@ -683,7 +693,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, i=
nt
> nr)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * config offset 0x5C.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 bdsm_size =3D g_malloc(sizeof(*bdsm_size));
> -=C2=A0=C2=A0=C2=A0 *bdsm_size =3D cpu_to_le64((ggms_mb + gms_mb) * MiB);
> +=C2=A0=C2=A0=C2=A0 *bdsm_size =3D cpu_to_le64(ggms_size + gms_size);
> =C2=A0=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-siz=
e",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdsm_size, sizeof(*bdsm_si=
ze));
> =C2=A0
> @@ -734,5 +744,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, i=
nt
> nr)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev-
> >https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAAADIUcZasZ36m=
wAAABM0
> 01Yig6LNmON7mS202pDuIRRNT-
> tIucgsQHKYe8WitBfoANcxBM2L6i4Sg4fLLMkXL_LDVUSEswEqsunuGsAr4DjgOogXtNMivhs=
yeaj9
> xYl9AgydV4QqrKMV29P7y3uAuqQcYz1GacVJRg1=C2=A0);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 trace_vfio_pci_igd_bdsm_enabled(vdev-
> >https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAAADIUcZasZ36m=
wAAABM0
> 01Yig6LNmON7mS202pDuIRRNT-
> tIucgsQHKYe8WitBfoANcxBM2L6i4Sg4fLLMkXL_LDVUSEswEqsunuGsAr4DjgOogXtNMivhs=
yeaj9
> xYl9AgydV4QqrKMV29P7y3uAuqQcYz1GacVJRg1=C2=A0, ggms_mb + gms_mb);
> +=C2=A0=C2=A0=C2=A0 trace_vfio_pci_igd_bdsm_enabled(vdev-
> >https://nospamproxywebp.beckhoff.com/enQsig/link?id=3DBAgAAAADIUcZasZ36m=
wAAABM0
> 01Yig6LNmON7mS202pDuIRRNT-
> tIucgsQHKYe8WitBfoANcxBM2L6i4Sg4fLLMkXL_LDVUSEswEqsunuGsAr4DjgOogXtNMivhs=
yeaj9
> xYl9AgydV4QqrKMV29P7y3uAuqQcYz1GacVJRg1=C2=A0,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ggms_size =
+ gms_size) / MiB);
> =C2=A0}

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>

--=-wCinDl9dXiFn8Om5V1Pu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdPLfwACgkQ2FTaVjFe
Ampp0hAAnLugjwWevet0A232uyrluTbkbt7+yCtajLw20IMyRb59LoMs1BVBTzeP
eebjsQirDvNOdAgszOmyi2WM70t6ZVLM+T+mO0Z9dpGd/GdZgNgqy2BDeI3as2xC
piRJqqMi2zCYP6rZY+m/inwpDSssKpeFzzbL8+U3rUBx26tdLzyo973yQTq92xhL
Nzh9WtMEtFuB0jmhpAPKgcJeZ5/W18CZBYdNXSisTsDusXf0ad8numcawwjFq10q
+MN3mwf+o2lAXUvxZsp/eCxbVXKr3LLmsUkWHcD6S8yua8h2CaMfL/rzBAVlx21z
byZxUiWc61Z1EfFwxVeqLJzVOJrmYVFJQ6rVXB0WI3bZySaFxCHrnhS7FJBo7ZNu
kne0UdeYpLmUUjtS/+05NU5lPEWGKBmCr1yd22HQQdzqNIGjmgN5ZtbVh2Kwm2ln
+D1T7oigwFYRmyAbs+pLszA+SCfCDT3rcTez9XLwsHVGenMWE8xKKgMJ6/Kn+sHf
bvymWtuVDjwbrc3c53f057vJPHH3wboT7TULwZZeanDP7sJXH70TLjKSIkQ9Di+B
UkjWglzNX1uP24G/SAdjqncyzh4J5/HDKuShNGJlvYjEIZZHNczQrPrcTBELNBV/
KDRk6cT7chcsq7QNyh+mw+PAsFUoepp8HiP+KTr4aYNNQgVIZS8=
=KWFb
-----END PGP SIGNATURE-----

--=-wCinDl9dXiFn8Om5V1Pu--


