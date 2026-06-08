Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3426CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWXuU-0004N1-8l; Mon, 08 Jun 2026 07:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWXuO-0004LB-6u
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:12:44 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWXuL-000285-Rw
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:12:43 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-304cf518c9dso4959011eec.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780917160; x=1781521960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AMGXuZq1XrEE7TxWq2iNWackTwqj3wTLjlWXT0CzDc=;
 b=Bapvg5LbIoUts08HWYFRiuaLUcJ9t0EfmMbsWsqbxqc73BiAq9ZFn9FqWBvBk+dq33
 xfYiS6Yhp1UvMExgkU1dfl2z6fBM4achsgp/qQh8YUtU/l0QKCiM1u6LgBvTNiVkua1h
 qqnEuzg1Ibs92yzaDQcqYWFdfnWCDeJV+dzB4xc6sS6+ep+VyCa9oxXsRR07sKMpJqUH
 KPdqa4XzR+Ia+413xEJShJVIoenYiI7E3+WEERC0axJBojngUQK+uEay9fE6l1ye3bDr
 w8G5zsJ4CC8hCiRTNqU0JHHylNAwbXko6x72l8iK+YHN3vjsUmLxNDu2kgEn7kFaTuzp
 893A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780917160; x=1781521960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5AMGXuZq1XrEE7TxWq2iNWackTwqj3wTLjlWXT0CzDc=;
 b=mvUJdNHlubrT5bF3ss7lbx/KJKylmtBiqAKLxaNW6nuBMKRQy0ykyaGOxOpzg+Tk6X
 rhYFBHfLwsCo3qKeXBqoUoNYr0ZKFsIHwJLouAEbrciWkfcxnocq8Yp15ojZcQTfrdcn
 OsrgdigI792DOs4XF/3hZAEwi+DujumLSTvWSEtkxbnGktMLST+R0ciCC1MrCH7u2D5i
 rrVdGTFChEJFDNkSDtOmj/y9qig2CXODwcwH9EdRxpsuYppGgpjxnF52zTGaAF0Lb7oG
 3yWBcDDANurjlR2MiDlcIv4anxwBVa3s1E3hSJi9T4TT2wB+czavqk7+TTf7FDUhGCoV
 6c8Q==
X-Gm-Message-State: AOJu0Yzb9VIPgmIoBcwNXkyk0Q2VAb8oBMoBaKzoiry57kDY734l6EV9
 ea9tS+QproeZkrEs2hHZ1uYfrRntNb9WPnz4TgjKlxqMEjtp1UNXuM4lAwdFeoM=
X-Gm-Gg: Acq92OH58yCJ26AVnfi1npJxiCjvxJ0hLmZcXwUPdDEy9cy/Uga9NRFFCQ0XiG5yM1s
 uFfIn0nVI2O4TDEwJmQ3Bv7VTNRAUF+BBoH1uH//uW9sP/CV9ZayrUsrnPrYeWiYtiZLy4oMhLx
 tmIo09fC42mcHwo/9PsvbCfoDgmromRIjkQjXGhuXBULLakswjVp6V0xWwLZZkEMroBdzhnrNq0
 Ha8M6lVqRd1Bsvg1Ygy9ZHXxkyyAQvscXW0MXOPDP5BHjWvM/mLzgUH3Y8XvxqOa2SPr4jAHmxS
 IczRafWLGiNPvbdSEwpz8w0FH10ARQCFbnIIN0C1BQzqSbdthQxColIOJ6jFNgEta8wB17bCycK
 iJhO8Hy+hYLPhnTbV1eN+2Dy/wLG6LHfRvVjP5lYxBUWkonujHnLq1HS9JauDKi1VKpLGOcVO5R
 az290kylVzvTLYbhpbY3NQU8U0WPILcP3/CgUm1Q1/rvca49LCmw==
X-Received: by 2002:a05:693c:834d:b0:307:934e:da79 with SMTP id
 5a478bee46e88-307934ee0e8mr3242337eec.34.1780917159552; 
 Mon, 08 Jun 2026 04:12:39 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffd:b5b0::2ae? ([2408:820c:8ffd:b5b0::2ae])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db560d7sm23356013eec.5.2026.06.08.04.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 04:12:38 -0700 (PDT)
Message-ID: <d8ace728-2934-4bfc-a2dd-c15814a1a5a2@gmail.com>
Date: Mon, 8 Jun 2026 19:12:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at
 load time
To: Kirandeep Maan <kirandeepmaan45@gmail.com>,
 Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
 <20260603173355.36121-7-tomitamoeko@gmail.com>
 <20260605160224.32405a42@shazbot.org>
 <CAPd5Pt6RVJ72EOpjyzO4aFNaWF9Lcuavs7UHK3R6ORJCeyQHsQ@mail.gmail.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <CAPd5Pt6RVJ72EOpjyzO4aFNaWF9Lcuavs7UHK3R6ORJCeyQHsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Found the root cause is the vendor/device id fixup in option rom
header. EFI requires the signature in ROM header at 0x04 being
0x00000ef1, the new pci_patch_ids() breaks it as it overwrites
checksum at 0x06. Given that EFI does not require either the IDs
in header nor the checksum, will skip the fixup for EFI roms in
v2.

Thanks,
Moeko

On 2026-06-08 10:17, Kirandeep Maan wrote:
> Hi, as these patches fixes legacy mode grabled=C2=A0grub screen they ad=
d regression to UEFI guest where monitor won't woke up until grub timeout=
=2E
>=20
> CMD used : -device vfio-pci,host=3D00:02.0,id=3Digpu,addr=3D2.0,x-igd-l=
egacy-mode=3Doff,x-igd-lpc=3Don,romfile=3D/home/maan/QemuVMs/MyGopRomfile=
s/InteligdGopHD4600.rom=C2=A0
>=20
> romfile is patched with intelgopdriver.efi=C2=A0from=C2=A0VfioIgdPkg=C2=
=A0repo.
>=20
> Here is what i915 logs say in guest with patched qemu :
> [ =C2=A0 10.823656] i915 0000:00:02.0: [drm] Found haswell (device ID 0=
412) integrated display version 7.00 stepping N/A
> [ =C2=A0 10.824300] i915 0000:00:02.0: [drm] VT-d active for gfx access=

> [ =C2=A0 10.824763] i915 0000:00:02.0: vgaarb: deactivate vga console
> [ =C2=A0 10.824867] i915 0000:00:02.0: [drm] Using Transparent Hugepage=
s
> [ =C2=A0 10.824871] i915 0000:00:02.0: [drm] DMAR active, disabling use=
 of stolen memory
> [ =C2=A0 10.832111] i915 0000:00:02.0: Invalid PCI ROM header signature=
: expecting 0xaa55, got 0x0000
> [ =C2=A0 10.832118] i915 0000:00:02.0: [drm] Failed to find VBIOS table=
s (VBT)
> [ =C2=A0 10.832154] i915 0000:00:02.0: vgaarb: VGA decodes changed: old=
decodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
> [ =C2=A0 10.842837] i915 0000:00:02.0: [drm] Registered 3 planes with d=
rm panic
> [ =C2=A0 10.850377] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on mi=
nor 0
> [ =C2=A0 11.678013] fbcon: i915drmfb (fb0) is primary device
> [ =C2=A0 11.748610] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffe=
r device
>=20
> So look like VBT table is not expose to guest.
>=20
> These are the logs of stock qemu with working grub and all :
> [ =C2=A0 28.945622] i915 0000:00:02.0: [drm] Found haswell (device ID 0=
412) integrated display version 7.00 stepping N/A
> [ =C2=A0 28.946393] i915 0000:00:02.0: [drm] VT-d active for gfx access=

> [ =C2=A0 28.961770] i915 0000:00:02.0: vgaarb: deactivate vga console
> [ =C2=A0 28.961830] i915 0000:00:02.0: [drm] Using Transparent Hugepage=
s
> [ =C2=A0 28.961833] i915 0000:00:02.0: [drm] DMAR active, disabling use=
 of stolen memory
> [ =C2=A0 29.016673] i915 0000:00:02.0: vgaarb: VGA decodes changed: old=
decodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
> [ =C2=A0 29.051910] i915 0000:00:02.0: [drm] Registered 3 planes with d=
rm panic
> [ =C2=A0 29.055360] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on mi=
nor 1
> [ =C2=A0 29.903202] fbcon: i915drmfb (fb0) is primary device
> [ =C2=A0 29.990056] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffe=
r device
>=20
> Regards,
> K S Maan
>=20
> On Sat, 6 Jun 2026 at 03:32, Alex Williamson <alex@shazbot.org <mailto:=
alex@shazbot.org>> wrote:
>=20
>     On Thu,=C2=A0 4 Jun 2026 01:33:54 +0800
>     Tomita Moeko <tomitamoeko@gmail.com <mailto:tomitamoeko@gmail.com>>=
 wrote:
>     > diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>     > index 17437ae18d..e00f6f8315 100644
>     > --- a/hw/vfio/igd.c
>     > +++ b/hw/vfio/igd.c
>     > @@ -739,3 +739,109 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDev=
ice *vdev, Error **errp)
>     >=C2=A0
>     >=C2=A0 =C2=A0 =C2=A0 return vfio_pci_igd_config_quirk(vdev, errp);=

>     >=C2=A0 }
>     > +
>     > +/*
>     > + * IGD ROM BAR read from kernel is actually the host VBIOS shado=
w RAM region,
>     > + * which contains host modifications. In Gen 6-9 VBIOS, the rout=
ine below is
>     > + * used to get BDSM value when programming the initial GTT.
>     > + *=C2=A0 =C2=A0xx xx xx xx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0v: .long ?=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # saved value
>     > + *=C2=A0 =C2=A066 53=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 push=C2=A0 %ebx
>     > + *=C2=A0 =C2=A066 2e 83 3e xx xx 00=C2=A0 =C2=A0 =C2=A0cmpl=C2=A0=
 $0x0,%cs:v=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# is saved value empty?
>     > + *=C2=A0 =C2=A074 07=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 je=C2=A0 =C2=A0 1f=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# if zero, go compute
>     > + *=C2=A0 =C2=A066 2e a1 xx xx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0mov=C2=A0 =C2=A0%cs:v,%eax=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# else =
return saved value
>     > + *=C2=A0 =C2=A0eb 0f=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 jmp=C2=A0 =C2=A02f
>     > + *=C2=A0 =C2=A0b8 5e 10=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 1: mov=C2=A0 =C2=A0$0x105e,%ax=C2=A0 =C2=A0 =C2=A0 =C2=A0 # dev 0=
0:02.0, offset 5E
>     > + *=C2=A0 =C2=A0e8 xx xx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0call=C2=A0 pci_read_cfg_word
>     > + *=C2=A0 =C2=A066 c1 e0 10=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 shl=C2=A0 =C2=A0$0x10,%eax=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# =
left shift 16 bits
>     > + *=C2=A0 =C2=A066 2e a3 xx xx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0mov=C2=A0 =C2=A0%eax,%cs:v=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# save =
the result
>     > + *=C2=A0 =C2=A066 5b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02=EF=BC=9Apop=C2=A0 =C2=A0%ebx
>     > + *=C2=A0 =C2=A0c3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret
>     > + * When running the VBIOS in guest, saved value still reflects t=
he host stolen
>     > + * memory base address, which is not correct in guest. So we nee=
d to patch the
>     > + * VBIOS to clear the saved value.
>     > + *
>     > + * The unique 19-byte starts at `cmpl $0,%cs:v` and ends at `mov=
 $0x105e,%ax`
>     > + * anchors the match to the routine. Both `cs:` displacements mu=
st reference
>     > + * the same offset.
>     > + */
>=20
>     Neat, cool quirk.
>=20
>     > +static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t =
rom_size,
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_=
t *bdsm_offset)
>     > +{
>     > +=C2=A0 =C2=A0 static const uint8_t start[] =3D { 0x66, 0x2e, 0x8=
3, 0x3e };
>     > +=C2=A0 =C2=A0 static const uint8_t middle[] =3D { 0x00, 0x74, 0x=
07, 0x66, 0x2e, 0xa1 };
>     > +=C2=A0 =C2=A0 static const uint8_t end[] =3D { 0xeb, 0x0f, 0xb8,=
 0x5e, 0x10 };
>     > +=C2=A0 =C2=A0 size_t i;
>     > +=C2=A0 =C2=A0 bool found =3D false;
>     > +
>     > +=C2=A0 =C2=A0 if (rom_size < 19) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOENT;
>     > +=C2=A0 =C2=A0 }
>     > +
>     > +=C2=A0 =C2=A0 for (i =3D 0; i + 19 <=3D rom_size; i++) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (memcmp(rom + i, start, sizeof(st=
art)) !=3D 0 ||
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcmp(rom + i + 6, mi=
ddle, sizeof(middle)) !=3D 0 ||
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcmp(rom + i + 14, e=
nd, sizeof(end)) !=3D 0) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     > +
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* same saved value address? */
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rom[i + 4] !=3D rom[i + 12] || r=
om[i + 5] !=3D rom[i + 13]) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     > +
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (found) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EEXIST;
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     > +
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *bdsm_offset =3D rom[i + 4] | ((uint=
16_t)rom[i + 5] << 8);
>=20
>     This needs a bounds check to make sure it's still within the ROM,
>     either here or before the memset().
>=20
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 found =3D true;
>     > +=C2=A0 =C2=A0 }
>     > +
>     > +=C2=A0 =C2=A0 if (!found) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOENT;
>     > +=C2=A0 =C2=A0 }
>     > +
>     > +=C2=A0 =C2=A0 return 0;
>     > +}
>     > +
>     > +void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
>     > +{
>     > +=C2=A0 =C2=A0 int ret, gen;
>     > +=C2=A0 =C2=A0 uint16_t pcir_offset, bdsm_offset =3D 0;
>     > +=C2=A0 =C2=A0 uint8_t checksum;
>     > +
>     > +=C2=A0 =C2=A0 if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_AN=
Y_ID) ||
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !vfio_is_vga(vdev) || !vdev->vga) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     > +=C2=A0 =C2=A0 }
>     > +
>     > +=C2=A0 =C2=A0 /* Only Gen 6~9 devices have legacy VBIOS as Optio=
n ROM */
>     > +=C2=A0 =C2=A0 gen =3D igd_gen(vdev);
>     > +=C2=A0 =C2=A0 if (gen < 6 || gen > 9) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     > +=C2=A0 =C2=A0 }
>     > +
>     > +=C2=A0 =C2=A0 if (pci_get_word(vdev->rom) !=3D 0xaa55) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     > +=C2=A0 =C2=A0 }
>     > +
>     > +=C2=A0 =C2=A0 /* Must be a legacy ROM */
>     > +=C2=A0 =C2=A0 pcir_offset =3D pci_get_word(vdev->rom + 0x18);
>     > +=C2=A0 =C2=A0 if (pcir_offset >=3D vdev->rom_size ||
>=20
>     This gates the below test to pcir_offset + 0x14, so should be:
>=20
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pcir_offset + 0x14 >=3D vdev->rom_si=
ze ||
>=20
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcmp(vdev->rom + pcir_offset, "PCI=
R", 4) ||
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_get_byte(vdev->rom + pcir_offset=
 + 0x14) !=3D 0x00) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     > +=C2=A0 =C2=A0 }
>     > +
>     > +=C2=A0 =C2=A0 ret =3D igd_vbios_find_saved_bdsm(vdev->rom, vdev-=
>rom_size, &bdsm_offset);
>     > +=C2=A0 =C2=A0 if (ret < 0) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     > +=C2=A0 =C2=A0 }
>     > +
>     > +=C2=A0 =C2=A0 memset(vdev->rom + bdsm_offset, 0, sizeof(uint32_t=
));
>     > +
>     > +=C2=A0 =C2=A0 checksum =3D pci_rom_calculate_checksum(vdev->rom,=
 vdev->rom_size);
>     > +=C2=A0 =C2=A0 ((uint8_t *)vdev->rom)[6] =3D checksum;
>=20
>     If updated per previous recommendation, this becomes:
>=20
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((uint8_t *)vdev->rom)[6] -=3D checksum=
;
>=20
>     Thanks,
>     Alex
>=20


