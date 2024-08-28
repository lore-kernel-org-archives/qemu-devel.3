Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC40DC54FC6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIhB-0005gh-Gp; Wed, 28 Aug 2024 09:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjG6a-0003QM-R2
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 06:40:48 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjG6X-0006to-Fl
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 06:40:48 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5becfd14353so7108736a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 03:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724841638; x=1725446438; darn=nongnu.org;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jtZk81QzXpKxhj7DNWTSfcJvXx1ZjjA/Vl+OopJm0EI=;
 b=g9ETw7+9JE5GZUS6Pm7nunJKB+h36kVU/77Jg7mAIerpaJ0lBPut3D/g94UvwF0E3q
 uh7huNYBpFE2NUFGFy/lMbR/0qIoIUFH+gB8po4oac/aScffamisgSaHgwJPrnS+ZM7A
 vZWfu3C1aGmBWbZsLNYkXVgLLhWyhJgdKYvrwpFpYfZYRQ/dxKCi/YrEMVkbmKtcMHV8
 YsDKeA1WjWqIKguUToL76f9ulWjQ3F9mQVcwGLoy4TMs1WOajPFfMIZrzbtAZpjwD9Y9
 SydVH8Itzj2mNSJrQiwQUZm4qZeish3BflwMUwKwhhUGHf5Ogv8tAtQEeSWBRuxO0cuF
 JVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724841638; x=1725446438;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtZk81QzXpKxhj7DNWTSfcJvXx1ZjjA/Vl+OopJm0EI=;
 b=GSdtOAGyJXKDHuGauh6MJFkIeiArEag+GmZ8cbGm95EtTBG/46jcwNaTJuV0P4dzWD
 HE0GHCKSjVV8oCmUukSsm9ME7HCnk92hAG0e/0uduNWyBctosD8tNoDDPWGyWVZSbXO0
 uhXqp1qW6G88d2iDeoo6Dj7sbDtfCrCVAPgdl60yll2euImVZxPp0eHVru1XCGaWTqg3
 VZxgDVVSXT6OfIiO4Z99B2pln1rOHIpr3OCSi7cob/xRM2LzEle2grgQD+wf70n/k/fT
 LmNTPLNhz0VIeO6NTVVoHMNwqAHQRI6Itwt/utNT+8Ci9pVWpAZR2PtZT5yfLxSWWAke
 nRRg==
X-Gm-Message-State: AOJu0YyowBmsc/irH/aCpVcf1il9SWrI0Faoeua3dALY22hIGRICJ3cG
 jIHu4ZSk95hSDDMUtK3WJMoFg7fxZBw9OTTGb2tmejx6dG3lQpnKe4vBbg==
X-Google-Smtp-Source: AGHT+IEJ5LYNjU4GwgFMYOfMnR9Aag++7eiZuDWrgvWkzp7Lih/I6SbjEOZHGWXIhGGVLwsc8oBanw==
X-Received: by 2002:a05:6402:27ca:b0:5c0:a8ba:3c41 with SMTP id
 4fb4d7f45d1cf-5c0a8ba3c76mr6512725a12.8.1724841637924; 
 Wed, 28 Aug 2024 03:40:37 -0700 (PDT)
Received: from [172.21.179.178] ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb20b35asm2078329a12.45.2024.08.28.03.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 03:40:37 -0700 (PDT)
Message-ID: <216d3028301937887bc684ac905c7088272930ab.camel@gmail.com>
Subject: Re: [PATCH 4/7] vfio/igd: add new bar0 quirk to emulate BDSM mirror
From: Corvin =?ISO-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Date: Wed, 28 Aug 2024 12:40:36 +0200
In-Reply-To: <20240826103513.082360bd.alex.williamson@redhat.com>
References: <20240822111819.34306-1-c.koehne@beckhoff.com>
 <20240822111819.34306-5-c.koehne@beckhoff.com>
 <20240826103513.082360bd.alex.williamson@redhat.com>
Autocrypt: addr=corvin.koehne@gmail.com; prefer-encrypt=mutual;
 keydata=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
 LwksVmgc9s79+9pSpeP5DbIeMzhrIK
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-QgRas4Q8LHuay5lnfNuH"
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 Aug 2024 09:26:40 -0400
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


--=-QgRas4Q8LHuay5lnfNuH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-08-26 at 10:35 -0600, Alex Williamson wrote:
> CAUTION: External Email!!
> On Thu, 22 Aug 2024 13:08:29 +0200
> Corvin K=C3=B6hne <c.koehne@beckhoff.com> wrote:
>=20
> > =EF=BB=BFThe BDSM register is mirrored into MMIO space at least for gen=
 11
> > and
> > later devices. Unfortunately, the Windows driver reads the register
> > value from MMIO space instead of PCI config space for those devices
> > [1].
> > Therefore, we either have to keep a 1:1 mapping for the host and
> > guest
> > address or we have to emulate the MMIO register too. Using the igd
> > in
> > legacy mode is already hard due to it's many constraints. Keeping a
> > 1:1
> > mapping may not work in all cases and makes it even harder to use.
> > An
> > MMIO emulation has to trap the whole MMIO page. This makes accesses
> > to
> > this page slower compared to using second level address
> > translation.
> > Nevertheless, it doesn't have any constraints and I haven't noticed
> > any
> > performance degradation yet making it a better solution.
> >=20
> > [1]
> > https://github.com/projectacrn/acrn-hypervisor/blob/5c351bee0f6ae46250e=
efc07f44b4a31e770f3cf/devicemodel/hw/pci/passthrough.c#L650-L653
> >=20
> > Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> > ---
> > =C2=A0hw/vfio/igd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 97
> > ++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0hw/vfio/pci-quirks.c |=C2=A0 1 +
> > =C2=A0hw/vfio/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1=
 +
> > =C2=A03 files changed, 99 insertions(+)
> >=20
> > diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> > index 0b6533bbf7..863b58565e 100644
> > --- a/hw/vfio/igd.c
> > +++ b/hw/vfio/igd.c
> > @@ -374,6 +374,103 @@ static const MemoryRegionOps
> > vfio_igd_index_quirk =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
> > =C2=A0};
> > =C2=A0
> > +#define IGD_BDSM_MMIO_OFFSET 0x1080C0
> > +
> > +static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr addr, unsigned
> > size)
> > +{
> > +=C2=A0=C2=A0=C2=A0 VFIOPCIDevice *vdev =3D opaque;
> > +=C2=A0=C2=A0=C2=A0 uint64_t offset;
> > +
> > +=C2=A0=C2=A0=C2=A0 offset =3D IGD_BDSM_GEN11 + addr;
> > +
> > +=C2=A0=C2=A0=C2=A0 switch (size) {
> > +=C2=A0=C2=A0=C2=A0 case 1:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pci_get_byte(vdev->p=
dev.config + offset);
> > +=C2=A0=C2=A0=C2=A0 case 2:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return le16_to_cpu(pci_get_=
word(vdev->pdev.config +
> > offset));
> > +=C2=A0=C2=A0=C2=A0 case 4:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return le32_to_cpu(pci_get_=
long(vdev->pdev.config +
> > offset));
> > +=C2=A0=C2=A0=C2=A0 case 8:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return le64_to_cpu(pci_get_=
quad(vdev->pdev.config +
> > offset));
> > +=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw_error("igd: unsupported =
read size, %u bytes", size);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > +static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 uint64_t data, unsigned
> > size)
> > +{
> > +=C2=A0=C2=A0=C2=A0 VFIOPCIDevice *vdev =3D opaque;
> > +=C2=A0=C2=A0=C2=A0 uint64_t offset;
> > +
> > +=C2=A0=C2=A0=C2=A0 offset =3D IGD_BDSM_GEN11 + addr;
> > +
> > +=C2=A0=C2=A0=C2=A0 switch (size) {
> > +=C2=A0=C2=A0=C2=A0 case 1:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_byte(vdev->pdev.con=
fig + offset, data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0 case 2:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_word(vdev->pdev.con=
fig + offset, data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0 case 4:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_long(vdev->pdev.con=
fig + offset, data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0 case 8:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_quad(vdev->pdev.con=
fig + offset, data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw_error("igd: unsupported =
read size, %u bytes", size);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
>=20
> If we have the leXX_to_cpu() in the read path, don't we need
> cpu_to_leXX() in the write path?=C2=A0 Maybe we should in fact just get
> rid
> of all of them since we're quirking a device that's specific to a
> little endian architecture and we're defining the memory region as
> little endian, but minimally we should be consistent.
>=20

Will drop leXX_to_cpu in the read path.

> > +
> > +static const MemoryRegionOps vfio_igd_bdsm_quirk =3D {
> > +=C2=A0=C2=A0=C2=A0 .read =3D vfio_igd_quirk_bdsm_read,
> > +=C2=A0=C2=A0=C2=A0 .write =3D vfio_igd_quirk_bdsm_write,
> > +=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +};
> > +
> > +void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
> > +{
> > +=C2=A0=C2=A0=C2=A0 VFIOQuirk *quirk;
> > +=C2=A0=C2=A0=C2=A0 int gen;
> > +
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * This must be an Intel VGA device at address=
 00:02.0 for us
> > to even
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * consider enabling legacy mode. Some driver =
have
> > dependencies on the PCI
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * bus address.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY=
_ID) ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !vfio_is_vga(vdev) || nr !=
=3D 0 ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &vdev->pdev !=3D pci_find_d=
evice(pci_device_root_bus(&vdev-
> > >pdev),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0, PCI_DEVFN(0x2, 0))) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * Only on IGD devices of gen 11 and above, th=
e BDSM register
> > is mirrored
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * into MMIO space and read from MMIO space by=
 the Windows
> > driver.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 gen =3D igd_gen(vdev);
> > +=C2=A0=C2=A0=C2=A0 if (gen < 11) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 quirk =3D vfio_quirk_alloc(1);
> > +=C2=A0=C2=A0=C2=A0 quirk->data =3D vdev;
> > +
> > +=C2=A0=C2=A0=C2=A0 memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
> > &vfio_igd_bdsm_quirk,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vdev, "vfio-igd-bdsm-quirk", 8);
> > +=C2=A0=C2=A0=C2=A0 memory_region_add_subregion_overlap(vdev->bars[0].r=
egion.mem,
> > 0x1080C0,
>=20
> Use your macro here, IGD_BDSM_MMIO_OFFSET.=C2=A0 Thanks,
>=20

Thanks for catching.

> Alex
>=20
> PS - please drop the confidential email warning signature when
> posting
> to public lists.
>=20

Sry for the noise. I can't drop it, so I'm going to use another mail
address to post my patches.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 &quirk->mem[0], 1);
> > +
> > +=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, ne=
xt);
> > +}
> > +
> > =C2=A0void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0 g_autofree struct vfio_region_info *rom =3D NU=
LL;
> > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > index 39dae72497..d37f722cce 100644
> > --- a/hw/vfio/pci-quirks.c
> > +++ b/hw/vfio/pci-quirks.c
> > @@ -1259,6 +1259,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice
> > *vdev, int nr)
> > =C2=A0=C2=A0=C2=A0=C2=A0 vfio_probe_nvidia_bar0_quirk(vdev, nr);
> > =C2=A0=C2=A0=C2=A0=C2=A0 vfio_probe_rtl8168_bar2_quirk(vdev, nr);
> > =C2=A0#ifdef CONFIG_VFIO_IGD
> > +=C2=A0=C2=A0=C2=A0 vfio_probe_igd_bar0_quirk(vdev, nr);
> > =C2=A0=C2=A0=C2=A0=C2=A0 vfio_probe_igd_bar4_quirk(vdev, nr);
> > =C2=A0#endif
> > =C2=A0}
> > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > index bf67df2fbc..5ad090a229 100644
> > --- a/hw/vfio/pci.h
> > +++ b/hw/vfio/pci.h
> > @@ -215,6 +215,7 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice
> > *vdev);
> > =C2=A0bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
> > =C2=A0void vfio_quirk_reset(VFIOPCIDevice *vdev);
> > =C2=A0VFIOQuirk *vfio_quirk_alloc(int nr_mem);
> > +void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
> > =C2=A0void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
> > =C2=A0
> > =C2=A0extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
>=20
>=20

--=20
Thanks,
Corvin

--=-QgRas4Q8LHuay5lnfNuH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJMBAABCAA2FiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmbO/qQYHGNvcnZpbi5r
b2VobmVAZ21haWwuY29tAAoJENhU2lYxXgJq6aIP/A1CQbn9Q3rCKaJ53lMcpKYY
ff/Dw22Lp8VqJmqMLb3Hbl86X8AYCI6TM15UVnD+qOR3HPqgvtaEoTeIW5LVk3db
ebTKTd0nniff8tlPpSFXxpH4TO3NwAdW0OC1Pr244Y9vAMej9bU5DoKr+eO9r7zb
GZtwZh8DMhQIjH9uTCxMm4rPbf+vXMVzd2r+Qc7jgm99++dZ6AjVUKW9liMR9hnS
IvXD+LmbEinpHJiRkRnTT8+VlmQzR0hFaUEdXndVyJBB5r6PALOcUkzH4MjJgav5
FhvqJqWI4yf0icTN2BSQIojmfWnBoOT/zNNv/logAsE5f5MMLn2sUPcWbkOgA5cq
veffDg6LyYgGaLD87PN487veS44sGH6zMr0wOK4zwQRmZDdhevgIfCNZXki0DvwY
bhrzakild4+Ohz7ciuZiRiEGBHbA/F3+lV61f/5QtEDLGXT98OPx/YEOhHGvFozQ
GZQO3KcQzUQOgEap0d7IsGWxoMAwMPMuLjwqNKoFjk+SHQPBqdm3gfYdaKJ6K4/t
qFMN6mJHNH53mOHLdF9o/PKP5OBZrA9vbw2S1CTCjTwcHpvrqQnxjx1tM0tC3ubz
SJxWpFKFNTi50+OLbnGhfM2RBjBviwR61cmxfkPEJ91XzPyRbWxBOI8KgNGz+M7N
Ff0X1xkagTFUNmFaHeDo
=zaHB
-----END PGP SIGNATURE-----

--=-QgRas4Q8LHuay5lnfNuH--

