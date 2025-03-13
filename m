Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D642C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 11:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsgN3-0001dj-Vv; Thu, 13 Mar 2025 07:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tsgN1-0001dY-2O
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:04:59 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tsgMw-0007WD-Lb
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:04:58 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso3462123a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741863890; x=1742468690; darn=nongnu.org;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=80uuVr/twNONkVPn9j+HLg6nW77EYH5url6mJ88SBCY=;
 b=aRM3MdJ7hR2pJugvxsRKJwx2kfx9IInT4MUly6SqTurzAoAK1mXbZx2xk8beXw0GPt
 Vtw1zAzWQPQ1JkmujRouJBU1Z9XFyBMkQeFNmWDFOKio8xLwiABUpFxgxYDjidLKlkK3
 kKeCIcm6Lt9gn92XOLUelXMSOCGNW5zjWoEdEycVAPZUVCl4LIdP1QyjlL98jFRVaLKD
 81L8SYQpNY1N878SyHhpsVg9pv60XmPcB+oawqeT5iuq4OSCjRXFzf/10/hswwovnygd
 7lfIBHPgfy/JWFkcYSufM1C76yDbV33j2rx6NPg3aWu3h+v5UzdwCXLbcbgsHqdoA+tZ
 B1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741863890; x=1742468690;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=80uuVr/twNONkVPn9j+HLg6nW77EYH5url6mJ88SBCY=;
 b=l23leqImxtdYWEgxfo4cwz2hXR4pFbd3Gq0sq3uK5haiWsevzoR/iQSRv0iEQgw7bE
 CHkL72ANHQOWP82OFXdewMs73XKoKU+lpl2MnoN0eYRBd9DLu62Hhx7jOUIWUOLrgYVS
 6fZ43hKeVQvXU7vKlR7hnpdzCtC2Va8/WrcvnD5eNYMuYHDgHBQsm6WQAW+XBzKS/R0Y
 7GPpQ9OLaw3znWxS6f9qzj/lL3l8mhQDSx16j2+1d4P8MPqUQM2+UMnbtL6GymHS5Sh6
 O0JBIIXldNpMTxwnjiPcO1EwoZkJ27UcapD13G56jR/ufgcOClGmG+l+Z1mtATPxfpGe
 pd8g==
X-Gm-Message-State: AOJu0Yx/beDTeWppqPPZ/irfPOLx4fIFa09fXJG19JKSQHKWgP+nSHNU
 8BP0Z2tWsAUTU4Ww0hVcDdVRZxiyWJHwzNYAh/G9YGFZFtoxe3C2ZIM9pg==
X-Gm-Gg: ASbGncswGHYvfGSwc0lKXGzeCF06Dl2Rl0PDtpOVvnmh1I5hiJRhKg4Hkz/daWaIdaj
 iYJW+xph7jT1i+rQMnmgJEDHM8gt13kgCH3nuw+tYea461gjDKWhUZeFpNJITy4IBlWS2B+DY1l
 lYlf4MbK7Cj/dYuNMimQugTN8dUG7vu5wAh+HACtgYNlkvTHgD+R4C3SdzqLydpIKgwuU5o7YVf
 ZRvhxEK7Fwg5QVPi3P3GSrmUuoudsHxapdSiEcOz2uk1sFvkZuWsv0nREdkcdCdw6jh5djABfdG
 U1IHuVq7nw0ZJgwo45yfbore9rLajdlxO+FD2kO/cmSYVrCRDsLUK+hTXA==
X-Google-Smtp-Source: AGHT+IGxCNraXqIPkrGTgN2KkEmjz8md0ryOxrEPcVXPqf1WBYb5GlJN1uBCyMws+xVLioZlalQqxQ==
X-Received: by 2002:a05:6402:84f:b0:5e0:7fc9:8605 with SMTP id
 4fb4d7f45d1cf-5e814da701bmr2182219a12.6.1741863889314; 
 Thu, 13 Mar 2025 04:04:49 -0700 (PDT)
Received: from [172.21.179.223] ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e816ad3d53sm593893a12.52.2025.03.13.04.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 04:04:48 -0700 (PDT)
Message-ID: <5adeeffe96e8a8dba816c8fc8e6f908474ac8c87.camel@gmail.com>
Subject: Re: [PATCH] vfio/igd: Update IGD passthrough docoumentation
From: Corvin =?ISO-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
To: Tomita Moeko <tomitamoeko@gmail.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Date: Thu, 13 Mar 2025 12:04:47 +0100
In-Reply-To: <20250312155002.286841-1-tomitamoeko@gmail.com>
References: <20250312155002.286841-1-tomitamoeko@gmail.com>
Autocrypt: addr=corvin.koehne@gmail.com; prefer-encrypt=mutual;
 keydata=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
 LwksVmgc9s79+9pSpeP5DbIeMzhrIK
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-PSkJBPMMZdm+WN4A8rtf"
User-Agent: Evolution 3.54.3 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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


--=-PSkJBPMMZdm+WN4A8rtf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-03-12 at 23:50 +0800, Tomita Moeko wrote:
> A previous change made the OpRegion and LPC quirks independent of the
> exising legacy mode, update the docoumentation accordingly. More related
> topics, like creating EFI Option ROM of IGD for OVMF, how to solve the
> VFIO_DMA_MAP Invalid Argument warning, as well as details on IGD memory
> internals, are also added.
>=20
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> =C2=A0docs/igd-assign.txt | 262 ++++++++++++++++++++++++++++++++---------=
---
> =C2=A01 file changed, 193 insertions(+), 69 deletions(-)
>=20
> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> index e17bb50789..c7c4565906 100644
> --- a/docs/igd-assign.txt
> +++ b/docs/igd-assign.txt
> @@ -1,44 +1,69 @@
> =C2=A0Intel Graphics Device (IGD) assignment with vfio-pci
> =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> =C2=A0
> -IGD has two different modes for assignment using vfio-pci:
> -
> -1) Universal Pass-Through (UPT) mode:
> -
> -=C2=A0=C2=A0 In this mode the IGD device is added as a *secondary* (ie. =
non-primary)
> -=C2=A0=C2=A0 graphics device in combination with an emulated primary gra=
phics device.
> -=C2=A0=C2=A0 This mode *requires* guest driver support to remove the ext=
ernal
> -=C2=A0=C2=A0 dependencies generally associated with IGD (see below).=C2=
=A0 Those guest
> -=C2=A0=C2=A0 drivers only support this mode for Broadwell and newer IGD,=
 according to
> -=C2=A0=C2=A0 Intel.=C2=A0 Additionally, this mode by default, and as off=
icially supported
> -=C2=A0=C2=A0 by Intel, does not support direct video output.=C2=A0 The i=
ntention is to use
> -=C2=A0=C2=A0 this mode either to provide hardware acceleration to the em=
ulated graphics
> -=C2=A0=C2=A0 or to use this mode in combination with guest-based remote =
access
> software,
> -=C2=A0=C2=A0 for example VNC (see below for optional output support).=C2=
=A0 This mode
> -=C2=A0=C2=A0 theoretically has no device specific handling dependencies =
on vfio-pci or
> -=C2=A0=C2=A0 the VM firmware.
> -
> -2) "Legacy" mode:
> -
> -=C2=A0=C2=A0 In this mode the IGD device is intended to be the primary a=
nd exclusive
> -=C2=A0=C2=A0 graphics device in the VM[1], as such QEMU does not facilit=
ate any sort
> -=C2=A0=C2=A0 of remote graphics to the VM in this mode.=C2=A0 A connecte=
d physical monitor
> -=C2=A0=C2=A0 is the intended output device for IGD.=C2=A0 This mode incl=
udes several
> -=C2=A0=C2=A0 requirements and restrictions:
> -
> -=C2=A0=C2=A0=C2=A0 * IGD must be given address 02.0 on the PCI root bus =
in the VM
> -=C2=A0=C2=A0=C2=A0 * The host kernel must support vfio extensions for IG=
D (v4.6)
> -=C2=A0=C2=A0=C2=A0 * vfio VGA support very likely needs to be enabled in=
 the host kernel
> -=C2=A0=C2=A0=C2=A0 * The VM firmware must support specific fw_cfg enable=
rs for IGD
> -=C2=A0=C2=A0=C2=A0 * The VM machine type must support a PCI host bridge =
at 00.0 (standard)
> -=C2=A0=C2=A0=C2=A0 * The VM machine type must provide or allow to be cre=
ated a special
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISA/LPC bridge device (vfio-pci-igd-lpc-b=
ridge) on the root bus at
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI address 1f.0.
> -=C2=A0=C2=A0=C2=A0 * The IGD device must have a VGA ROM, either provided=
 via the romfile
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 option or loaded automatically through vf=
io (standard).=C2=A0 rombar=3D0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will disable legacy mode support.
> -=C2=A0=C2=A0=C2=A0 * Hotplug of the IGD device is not supported.
> -=C2=A0=C2=A0=C2=A0 * The IGD device must be a SandyBridge or newer model=
 device.
> +Using vfio-pci, we can passthrough Intel Graphics Device (IGD) to guest,
> either
> +serve as primary and exclusive graphics adapter, or used in combination =
with
> an
> +emulated primary graphics device, depending on the config and guest driv=
er
> +support. However, IGD devices are not "clean" PCI devices, they use extr=
a
> +memory regions other than BARs. Special handling is required to make the=
m
> work
> +properly, including:
> +
> +* OpRegion for accessing Virtual BIOS Table (VBT) that contains display
> output
> +=C2=A0 information.
> +* Data Stolen Memory (DSM) region used as VRAM at early stage (BIOS/UEFI=
)
> +
> +Certain guest software also depends on following conditions to work:
> +(*-Required by)
> +
> +| Condition=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Lin=
ux | Windows | VBIOS | EFI
> GOP |
> +|---------------------------------------------|-------|---------|-------=
|----
> -----|
> +| #1 IGD has a valid OpRegion containing VBT=C2=A0 |=C2=A0 * ^1 |=C2=A0=
=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 *=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0
> *=C2=A0=C2=A0=C2=A0 |
> +| #2 VID/DID of LPC bridge at 00:1f.0 matches |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 *=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0
> *=C2=A0=C2=A0=C2=A0 |
> +| #3 IGD is assigned to BDF 00:02.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 *=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0
> *=C2=A0=C2=A0=C2=A0 |
> +| #4 IGD has VGA controller device class=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 *=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0
> *=C2=A0=C2=A0=C2=A0 |
> +| #5 Host's VGA ranges are mapped to IGD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 *=C2=A0=C2=A0
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +| #6 Guest has valid VBIOS or UEFI Option ROM |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 *=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0
> *=C2=A0=C2=A0=C2=A0 |
> +
> +^1 Though i915 driver is able to mock a OpRegion, it is still recommende=
d to
> +=C2=A0=C2=A0 use the VBT copied from host OpRegion to prevent incorrect =
configuration.
> +
> +For #1, the "x-igd-opregion=3Don" option exposes a copy of host IGD OpRe=
gion to
> +guest via fw_cfg, where guest firmware can set up guest OpRegion with it=
.
> +
> +For #2, "x-igd-lpc=3Don" option copies the IDs of host LPC bridge and ho=
st
> bridge
> +to guest. Currently this is only supported on i440fx machines as there i=
s
> +already an ICH9 LPC bridge present on q35 machines, overwriting its IDs =
may
> +lead to unexpected behavior.
> +
> +For #3, "addr=3D2.0" assigns IGD to 00:02.0.
> +
> +For #4, the primary display must be set to IGD in host BIOS.
> +
> +For #5, "x-vga=3Don" enables guest access to standard VGA IO/MMIO ranges=
.
> +
> +For #6, ROM either provided via the ROM BAR or romfile=3D option is need=
ed,
> this
> +Intel document [1] shows how to dump VBIOS to file. For UEFI Option ROM,=
 see
> +"Guest firmware" section.
> +
> +QEMU also provides a "Legacy" mode that implicitly enables full function=
ality
> +on IGD, it is automatically enabled when
> +* Machine type is i440fx
> +* IGD is assigned to guest BDF 00:02.0
> +* ROM BAR or romfile is present
> +
> +In "Legacy" mode, QEMU will automatically setup OpRegion, LPC bridge IDs=
 and
> +VGA range access, which is equivalent to:
> +=C2=A0 x-igd-opregion=3Don,x-igd-lpc=3Don,x-vga=3Don
> +
> +By default, "Legacy" mode won't fail, it continues on error. User can se=
t
> +"x-igd-legacy-mode=3Don" to force enabling legacy mode, this also checks=
 if the
> +conditions above for legacy mode is met, and if any error occurs, QEMU w=
ill
> +fail immediately. Users can also set "x-igd-legacy-mode=3Doff" to disabl=
e
> legacy
> +mode.
> +
> +In legacy mode, as the guest VGA ranges are assigned to IGD device, all =
other
> +graphics devices should be removed, this can be done using "-nographic" =
or
> +"-vga none" or "-nodefaults", along with adding the device using vfio-pc=
i.
> =C2=A0
> =C2=A0For either mode, depending on the host kernel, the i915 driver in t=
he host
> =C2=A0may generate faults and errors upon re-binding to an IGD device aft=
er it
> @@ -73,31 +98,39 @@ DVI, or DisplayPort) may be unsupported in some use
> cases.=C2=A0 In the author's
> =C2=A0experience, even DP to VGA adapters can be troublesome while adapte=
rs between
> =C2=A0digital formats work well.
> =C2=A0
> -Usage
> -=3D=3D=3D=3D=3D
> -The intention is for IGD assignment to be transparent for users and thus=
 for
> -management tools like libvirt.=C2=A0 To make use of legacy mode, simply =
remove all
> -other graphics options and use "-nographic" and either "-vga none" or
> -"-nodefaults", along with adding the device using vfio-pci:
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 -device vfio-pci,host=3D00:02.0,id=3Dhostdev0,bus=3Dp=
ci.0,addr=3D0x2
> +Options
> +=3D=3D=3D=3D=3D=3D=3D
> +* x-igd-opregion=3D[on|*off*]
> +=C2=A0 Copy host IGD OpRegion and expose it to guest with fw_cfg
> +
> +* x-igd-lpc=3D[on|*off*]
> +=C2=A0 Creates a dummy LPC bridge at 00:1f:0 with host VID/DID (i440fx o=
nly)
> +
> +* x-igd-legacy-mode=3D[on|off|*auto*]
> +=C2=A0 Enable/Disable legacy mode
> +
> +* x-igd-gms=3D[hex, default 0]
> +=C2=A0 Overriding DSM region size in GGC register, 0 means uses host val=
ue.
> +=C2=A0 Use this only when the DSM size cannot be changed through the
> +=C2=A0 'DVMT Pre-Allocated' option in host BIOS.
> =C2=A0
> -For UPT mode, retain the default emulated graphics and simply add the vf=
io-
> pci
> -device making use of any other bus address other than 02.0.=C2=A0 libvir=
t will
> -default to assigning the device a UPT compatible address while legacy mo=
de
> -users will need to manually edit the XML if using a tool like virt-manag=
er
> -where the VM device address is not expressly specified.
> =C2=A0
> -An experimental vfio-pci option also exists to enable OpRegion, and thus
> -external monitor support, for UPT mode.=C2=A0 This can be enabled by add=
ing
> -"x-igd-opregion=3Don" to the vfio-pci device options for the IGD device.=
=C2=A0 As
> -with legacy mode, this requires the host to support features introduced =
in
> -the v4.6 kernel.=C2=A0 If Intel chooses to embrace this support, the opt=
ion may
> -be made non-experimental in the future, opening it to libvirt support.
> +Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +* Adding IGD with automatically legacy mode support
> +=C2=A0 -device vfio-pci,host=3D00:02.0,id=3Dhostdev0,addr=3D2.0
> =C2=A0
> -Developer ABI
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Legacy mode IGD support imposes two fw_cfg requirements on the VM firmwa=
re:
> +* Adding IGD with OpRegion and LPC ID hack, but without VGA ranges
> +=C2=A0 (For UEFI guests)
> +=C2=A0 -device vfio-pci,host=3D00:02.0,id=3Dhostdev0,addr=3D2.0,x-igd-le=
gacy-mode=3Doff,x-
> igd-opregion=3Don,x-igd-lpc=3Don,romfile=3Defi_oprom.rom
> +
> +
> +Guest firmware
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Guest firmware is responsible for setting up OpRegion and Base of Data S=
tolen
> +Memory (BDSM) in guest address space. IGD passthrough support imposes tw=
o
> +fw_cfg requirements on the VM firmware:
> =C2=A0
> =C2=A01) "etc/igd-opregion"
> =C2=A0
> @@ -117,17 +150,108 @@ Legacy mode IGD support imposes two fw_cfg require=
ments
> on the VM firmware:
> =C2=A0=C2=A0=C2=A0 Firmware must allocate a reserved memory below 4GB wit=
h required 1MB
> =C2=A0=C2=A0=C2=A0 alignment equal to this size.=C2=A0 Additionally the b=
ase address of this
> =C2=A0=C2=A0=C2=A0 reserved region must be written to the dword BDSM regi=
ster in PCI config
> -=C2=A0=C2=A0 space of the IGD device at offset 0x5C.=C2=A0 As this suppo=
rt is related to
> -=C2=A0=C2=A0 running the IGD ROM, which has other dependencies on the de=
vice appearing
> -=C2=A0=C2=A0 at guest address 00:02.0, it's expected that this fw_cfg fi=
le is only
> -=C2=A0=C2=A0 relevant to a single PCI class VGA device with Intel vendor=
 ID, appearing
> -=C2=A0=C2=A0 at PCI bus address 00:02.0.
> +=C2=A0=C2=A0 space of the IGD device at offset 0x5C (or 0xC0 for Gen 11+=
 devices using
> +=C2=A0=C2=A0 64-bit BDSM).=C2=A0 As this support is related to running t=
he IGD ROM, which
> +=C2=A0=C2=A0 has other dependencies on the device appearing at guest add=
ress 00:02.0,
> +=C2=A0=C2=A0 it's expected that this fw_cfg file is only relevant to a s=
ingle PCI
> +=C2=A0=C2=A0 class VGA device with Intel vendor ID, appearing at PCI bus=
 address
> 00:02.0.
> +
> +Upstream Seabios has OpRegion and BDSM (pre-Gen11 device only) support.
> +However, the support is not accepted by upstream EDK2/OVMF. A recommende=
d
> +solution is to create a virtual OpRom with following DXE drivers:
> +
> +* IgdAssignmentDxe: Set up OpRegion and BDSM according to fw_cfg (must)
> +* IntelGopDriver: Closed-source Intel GOP driver
> +* PlatformGopPolicy: Protocol required by IntelGopDriver
> +
> +IntelGopDriver and PlatformGopPolicy is only required when enabling GOP =
on
> IGD.
> +
> +The original IgdAssignmentDxe can be found at [3]. A Intel maintained ve=
rsion
> +with PlatformGopPolicy for industrial computing is at [4]. There is also=
 an
> +unofficially maintained version with newer Gen11+ device support at [5].
> +You need to build them with EDK2.
> +
> +For the IntelGopDriver, Intel never released it to public. You may conta=
ct
> +Intel support to get one as [4] said, if you are an Intel primer custome=
r,
> +or you can try extract it from your host firmware using "UEFI BIOS
> Updater"[6].
> +
> +Once you got all the required DXE drivers, a Option ROM can be generated=
 with
> +EfiRom utility in EDK2, using
> +=C2=A0 EfiRom -f 0x8086 -i <Device ID of your IGD> -o output.rom \
> +=C2=A0 -e IgdAssignmentDxe.efi PlatformGOPPolicy.efi IntelGopDriver.efi
> +
> +
> +Known issues
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +When using OVMF as guest firmware, you may encounter the following warni=
ng:
> +warning: vfio_container_dma_map(0x55fab36ce610, 0x380010000000, 0x108000=
,
> 0x7fd336000000) =3D -22 (Invalid argument)
> +Solution:
> +Set the host physical address bits to IOMMU address width using
> +=C2=A0 -cpu host,host-phys-bits-limit=3D<IOMMU address width>
> +Or in libvirt XML with
> +=C2=A0 <cpu>
> +=C2=A0=C2=A0=C2=A0 <maxphysaddr mode=3D'passthrough' limit=3D'<IOMMU add=
ress width>'/>
> +=C2=A0 </cpu>
> +The IOMMU address width can be determined with
> +echo $(( ((0x$(cat /sys/devices/virtual/iommu/dmar0/intel-iommu/cap) &
> 0x3F0000) >> 16) + 1 ))
> +Refer https://edk2.groups.io/g/devel/topic/patch_v1/102359124=C2=A0for m=
ore
> details
> +
> +
> +Memory View
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +IGD has it own address space. To use system RAM as VRAM, a single-level =
page
> +table named Graphics Translation Table (GTT) is used for the address
> +translation. Each page table entry points a 4KB page. The translation fl=
ow
> is:
> +
> +(PTE size 8)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 +-------------+---+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 Address=C2=A0=C2=A0 | V |=C2=A0 V: Valid Bit
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-=
------------+---+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> +IGD:0x01ae9010=C2=A0=C2=A0=C2=A0=C2=A0 0xd740| 0x70ffc000=C2=A0 | 1 |=C2=
=A0 Mem:0x42ba3e010^
> +-----------------> 0xd748| 0x42ba3e000 | 1 +------------------>
> +(addr << 12) * 8=C2=A0=C2=A0 0xd750| 0x42ba3f000 | 1 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-=
------------+---+
> +^ The address may be remapped by IOMMU
> +
> +The memory region store GTT is called GTT Stolen Memory (GSM), it is loc=
ated
> +right below the Data Stolen Memory (DSM). Accessing this region directly=
 is
> +not allowed, any access will immediately freeze the whole system. The on=
ly
> way
> +to access it is through the second half of MMIO BAR0.
> +
> +The Data Stolen Memory is reserved by firmware, and acts as the VRAM in =
pre-
> OS
> +environments. In QEMU, guest firmware (Seabios/OVMF) is responsible for
> +reserving a continuous region and program its base address to BDSM regis=
ter,
> +then let VBIOS/GOP driver initializing this region. Illustration below s=
hows
> +how DSM is mapped.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IGD Addr Space=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Host Addr Space=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Guest Addr
> Space
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-=
------------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------=
-+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Data Stolen |=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Data Stolen |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 (Gu=
est)=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 (Guest)=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 +------------>+------------=
-+<------->+-------------
> +<--Guest BDSM
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 | Passthrough |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | EPT=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
> |=C2=A0=C2=A0 Emulated by QEMU
> +DSMSIZE+-------------+=C2=A0 | with IOMMU=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Mapping |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> |=C2=A0=C2=A0 Programmed by guest FW
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0+-------------+--+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------=
------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Data S=
tolen |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 (Host)=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------=
----->+-------------+<--Host BDSM
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Non-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 "real" on=
e in HW
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Passthrough |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 Programmed by host FW
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 +-------------+
> =C2=A0
> =C2=A0Footnotes
> =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -[1] Nothing precludes adding additional emulated or assigned graphics de=
vices
> -=C2=A0=C2=A0=C2=A0 as non-primary, other than the combination typically =
not working.=C2=A0 I only
> -=C2=A0=C2=A0=C2=A0 intend to set user expectations, others are welcome t=
o find working
> -=C2=A0=C2=A0=C2=A0 combinations or fix whatever issues prevent this from=
 working in the
> common
> -=C2=A0=C2=A0=C2=A0 case.
> +[1]
> https://www.intel.com/content/www/us/en/docs/graphics-for-linux/developer=
-reference/1-0/dump-video-bios.html
> =C2=A0[2] # echo "vfio-pci" > /sys/bus/pci/devices/0000:00:02.0/driver_ov=
erride
> +[3]
> https://web.archive.org/web/20240827012422/https://bugzilla.tianocore.org=
/show_bug.cgi?id=3D935
> +=C2=A0=C2=A0=C2=A0 Tianocore bugzilla was down since Jan 2025 :(
> +[4] https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html, Patch
> 0001-0004
> +[5] https://github.com/tomitamoeko/VfioIgdPkg
> +[6]
> https://winraid.level1techs.com/t/tool-guide-news-uefi-bios-updater-ubu/3=
0357

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>

--=-PSkJBPMMZdm+WN4A8rtf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmfSu88ACgkQ2FTaVjFe
AmpFTQ//ffOnhuGGsMN5x8ARXRdTWe1Npd4SX8MfJ2eySelCaiqJXs79liUIpywC
wvBLuSd3dGZzJDCa6Je/DsYRNv40d8xtofUqKebiwkdQyIBaghH+8iMzYzGS37zH
2EwctKInsSIIKoTjMYzNvkQGk5i39APZY3I6QkqZAKPr2WJe5jrdXgV1XvzPwf8K
mBuTTeFBVAdWQV2PRegselR7bu2mD1X8QSL8FUJOqx54qlH05FqFNmmGknXqNlHn
ELT9/57T7MK92L+y8zWT2m5iSzt0ZCqD3+9p5qGWqYjnup7Bty4FoBgHSH1kXf20
tTPTo7vBeVPBrInOxl0THmieBBpLVDk4l0AvstsSFKpZTCPUa+6OiEYNGoc7aYXD
itTs4jR89BkBRIQV4szOzwaoS3HnATvuP8ywUInzu3Sgt9EKdgqnZPfL8+2rn7mJ
lHT8EMSekzNJEc5qqjVrr+QC2BjdInnhjGeY55qjnMU1PmmxpT7F0dOtUljqlZOP
KmyU0e5gRTejhNryFiinNUhRJpgg7g/FfUKci0qwoTlm81C5eL/3rxv3OAcodqTL
Vs61mdXzc3pGfdkCfvFdT8Hxmpolk2pKyr+Xh59aRgyw1bhY4MR+izIJFUkkvTkh
xlYZ7nlnlNmitHI3SZLgfOiaEKgaP1AVkdSzHIAodN67ka3Nz+c=
=HKKT
-----END PGP SIGNATURE-----

--=-PSkJBPMMZdm+WN4A8rtf--

