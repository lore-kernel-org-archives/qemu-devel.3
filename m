Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764B6CD98C5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyf1-0000mt-Cx; Tue, 09 Jun 2026 11:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wWyex-0000mV-B3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:46:37 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wWyeu-0005iS-OM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:46:34 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 12C33EC011C;
 Tue,  9 Jun 2026 11:46:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 09 Jun 2026 11:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1781019992;
 x=1781106392; bh=kdVDBYV+UidCgposyXyUTghejeRgGoECwQS90mD2rRg=; b=
 anqf7ohfn/irCn2pY2IyW+ApnqrL+PN3XeWy5k6dWOHU7ZkUVWP/Av+pFXh9/lz2
 kZzUQ9dUemchFCGzIzVWybwffAMoEljGLMwhIvzgOFVa4d5sYjCFScnzga9MRp0c
 qQRpdy2caY88yldWMFUIqKg2pt0nVsOq6W+kNsQjTk8Xci+RBKwWlu8+3yFjZF1u
 km7ObeXxI8baVpTcWuO0Gsm1MSLwHpxZVbZLY11jUrMqjtOXFwvyjKoVxlkWyKCq
 k5jWsqz9nEW4QvymfxAMgKas9p7aVFt1anPgT2dd3OJ3Ai9Z1J3/Bdzvxa38gpKL
 WG1juTeL3zaO303jeRS9bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781019992; x=
 1781106392; bh=kdVDBYV+UidCgposyXyUTghejeRgGoECwQS90mD2rRg=; b=V
 8qe9dSt7V99FIp+HtQgDCigCUkuPqmWi0rjzLJjPaDWVdc/TbnFvzQc1ttFggsJP
 H+hUbBcHovRgiW1XcD0Ho1WbaoWBOpC3b/ZXwAxSz4kIbVEuZyoh/mNpTdDgtnCz
 eB941TtC+s3i5Lki2vW7afr1FJ0DgMn80vqNcC8ZxO/B577GseYGHgbbOOMUOcvm
 N04x8W31IzrDEa0FVcuXP/M2ItSJvjDOayUYABoYs0dWUJsrcU8jC8omwbjLs/BA
 bM7Uf0U+utgnrsXbjT7qMDHlord/8siFTicP4n2PmHHLHR0l11BaPgzPSGrEerIw
 APn8VsNkT4B88Zn5TriZA==
X-ME-Sender: <xms:VzUoaiSE33Eb0N53mGoWIA3cy0e-UUK0dYTC9VsPz1z4CSrtH-0WLg>
 <xme:VzUoagv1D1rVrxj7bokelnj6EOGSQx8yqEtDVY_L-ydBNjCELknGMJUJQeHm9w34Z
 a1OEbvg6Jm4Z_sxgEAMceqgpksEzOYEgkRpyCMUYqcF-jitDxuW1g>
X-ME-Received: <xmr:VzUoarZ_UHUeVmqkAjE61sqffdFiGqgSRHrYWK205_Xm6r9zMZfa8FF22eA>
X-ME-Proxy-Cause: dmFkZTGyncaCRguRlZG9LyaV9/0O0KLFossUPLK2ucsTZWYkincMBs2Dhz8X9M5p9fvb0P
 VN4uF1yTYJgguyhRNU0BhBKY42iUm+GemXjM/COmaFVrq672jBZvZdjmFACH+WbGCFawzY
 VrUDxsM2jdDYxHJEKX5oheXi0y4t0XEPO5TU1X7Ot7yS8gzHOrHGsJOMnRc09fF94gSaKA
 SztFMIlP+wgPzaJTgw+ISLQl8StsCoQEXdlPeT1GrRtdFZSsBHhrNHQ9qY2u86dUwCmIGq
 kaudiWUXysLJkOr9598Fo4OISCBRWiuzsJbF+Yxy9ULOd7IJ9d9cyne3W/YBUS7cm7MxV+
 OdtAld74FJ7OIziKuj/W9qL4AQkMUxGfkfoh2Fbbj1irMFVj+dMP68qsu63CFBUuPfFL2i
 Q5K5pIy9VhWkSRdissL97mnnfpY9cIvjiqx3ZtGSRFWT6ctmCUoMyDcUoaTPeKhZzY7WjD
 hXI0Dpm+EfbinjmDP+NdVtVhPw542oKWyIDBjqoPZ0XHxekajzFtF2WchUKA0mgyFVOM/y
 4UjR/ifVh0m6R5UWuSwi6A5hbvr3NUn44zFgIF/a2B0PyD9J5oDWNF4YfDV4RRVqBFCbq3
 uOnXy158EPPQippwzeIT/gRYzQiFlCcDvUUuaJzTAvivte5e98WALbZ4vfgw
X-ME-Proxy: <xmx:VzUoauElPc2r9XsoMhhETMLvk-ryhJMNo2Oh5iV32ey7JeDuCKj_Lg>
 <xmx:VzUoanyhQKXRj6eBIUdU7Hqk52G9PNgflEJIq8A3Eoc0iPcvYXEsbg>
 <xmx:VzUoaomZ17d6r_q9mk_OQxNpsjQvz3uYHKCtDH2-aGXOSPX9kqa_5A>
 <xmx:VzUoaolEf7ncXpSj8OszePj8HNJQVW_bVMOXFEVChK7cBER7uCMJdg>
 <xmx:WDUoaviuXYyB_oaidk0M5tBFx217yYeB9mcmb78a6fiIXV6IERrI-BvR>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 11:46:31 -0400 (EDT)
Date: Tue, 9 Jun 2026 09:46:30 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH v2 7/7] vfio/igd: Clear saved BDSM in legacy VBIOS ROM
 at load time
Message-ID: <20260609094630.5840f25e@shazbot.org>
In-Reply-To: <20260609093554.534dc9a0@shazbot.org>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
 <20260608134559.23971-8-tomitamoeko@gmail.com>
 <20260609093554.534dc9a0@shazbot.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.151; envelope-from=alex@shazbot.org;
 helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Tue, 9 Jun 2026 09:35:54 -0600
Alex Williamson <alex@shazbot.org> wrote:

> On Mon,  8 Jun 2026 21:45:58 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>=20
> > IGD does not come with a ROM BAR [1], the ROM BAR read by default from
> > kernel is actually the host VBIOS shadow RAM region that contains host
> > modifications on boot. With AI-assisted reverse engineering on VBIOS
> > binaries, it is observed that VBIOS saves BDSM register value on first
> > access and uses saved value if present.
> >=20
> > When the image is executed in guest, since there is already a saved HPA
> > in VBIOS, it keeps using that value instead of the GPA programmed by
> > SeaBIOS in BDSM register in PCI config space, causing VBIOS to program
> > GTT entries with wrong address, resulting in garbled output in BIOS
> > POST and the error below detected by i915 driver.
> >=20
> > i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invali=
d range, dma_addr=3D0x00000000db200000 ((null) [0x00000000baf00000-0x000000=
00beefffff])
> >=20
> > The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
> > mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
> > guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
> > ("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
> > values in MMIO BAR0 and IO BAR4.
> >=20
> > Considering it's unsafe to expose HPA to guest, a ROM quirk clearing
> > the saved value in VBIOS image is introduced. It searches the BDSM
> > accessor routine by matching a 19-byte signature anchored on the unique
> > `mov $0x105e,%ax` instruction, then locate the offset of saved BDSM and
> > clears it. This makes the routine fall through to the PCI config read
> > on the first call inside the guest.
> >=20
> > The quirk is invoked in vfio_pci_load_rom(), and is gated on Gen 6-9
> > IGD devices with VGA access enabled and legacy (non-UEFI) PCIR code
> > type in the ROM header. A new trace event vfio_pci_igd_vbios_patched
> > is also introduced.
> >=20
> > [1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
> >     https://www.intel.com/content/dam/www/public/us/en/documents/datash=
eets/4th-gen-core-family-desktop-vol-2-datasheet.pdf
> >=20
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
> > Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> > Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> > ---
> >  hw/vfio/igd-stubs.c  |   5 ++
> >  hw/vfio/igd.c        | 110 +++++++++++++++++++++++++++++++++++++++++++
> >  hw/vfio/pci-quirks.c |   5 ++
> >  hw/vfio/pci.c        |   2 +
> >  hw/vfio/pci.h        |   3 ++
> >  hw/vfio/trace-events |   1 +
> >  6 files changed, 126 insertions(+)
> >=20
> > diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
> > index f7687d9091..879a8aff56 100644
> > --- a/hw/vfio/igd-stubs.c
> > +++ b/hw/vfio/igd-stubs.c
> > @@ -18,3 +18,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,=
 Error **errp)
> >  {
> >      return true;
> >  }
> > +
> > +void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
> > +{
> > +    return;
> > +}
> > diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> > index 834539affb..4b49038753 100644
> > --- a/hw/vfio/igd.c
> > +++ b/hw/vfio/igd.c
> > @@ -734,3 +734,113 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *v=
dev, Error **errp)
> > =20
> >      return vfio_pci_igd_config_quirk(vdev, errp);
> >  }
> > +
> > +/*
> > + * IGD ROM BAR read from kernel is actually the host VBIOS shadow RAM =
region,
> > + * which contains host modifications. In Gen 6-9 VBIOS, the routine be=
low is
> > + * used to get BDSM value when programming the initial GTT.
> > + *   xx xx xx xx           v: .long ?                  # saved value
> > + *   66 53                    push  %ebx
> > + *   66 2e 83 3e xx xx 00     cmpl  $0x0,%cs:v         # is saved valu=
e empty?
> > + *   74 07                    je    1f                 # if zero, go c=
ompute
> > + *   66 2e a1 xx xx           mov   %cs:v,%eax         # else return s=
aved value
> > + *   eb 0f                    jmp   2f
> > + *   b8 5e 10              1: mov   $0x105e,%ax        # dev 00:02.0, =
offset 5E
> > + *   e8 xx xx                 call  pci_read_cfg_word
> > + *   66 c1 e0 10              shl   $0x10,%eax         # left shift 16=
 bits
> > + *   66 2e a3 xx xx           mov   %eax,%cs:v         # save the resu=
lt
> > + *   66 5b                 2=EF=BC=9Apop   %ebx
> > + *   c3                       ret
> > + * When running the VBIOS in guest, saved value still reflects the hos=
t stolen
> > + * memory base address, which is not correct in guest. So we need to p=
atch the
> > + * VBIOS to clear the saved value.
> > + *
> > + * The unique 19-byte starts at `cmpl $0,%cs:v` and ends at `mov $0x10=
5e,%ax`
> > + * anchors the match to the routine. Both `cs:` displacements must ref=
erence
> > + * the same offset.
> > + */
> > +static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t rom_si=
ze,
> > +                                     uint16_t *bdsm_offset)
> > +{
> > +    static const uint8_t start[] =3D { 0x66, 0x2e, 0x83, 0x3e };
> > +    static const uint8_t middle[] =3D { 0x00, 0x74, 0x07, 0x66, 0x2e, =
0xa1 };
> > +    static const uint8_t end[] =3D { 0xeb, 0x0f, 0xb8, 0x5e, 0x10 };
> > +    uint16_t val;
> > +    size_t i;
> > +    bool found =3D false;
> > +
> > +    if (rom_size < 19) {
> > +        return -ENOENT;
> > +    }
> > +
> > +    for (i =3D 0; i + 19 <=3D rom_size; i++) {
> > +        if (memcmp(rom + i, start, sizeof(start)) !=3D 0 ||
> > +            memcmp(rom + i + 6, middle, sizeof(middle)) !=3D 0 ||
> > +            memcmp(rom + i + 14, end, sizeof(end)) !=3D 0) {
> > +            continue;
> > +        }
> > +
> > +        /* same saved value address? */
> > +        if (rom[i + 4] !=3D rom[i + 12] || rom[i + 5] !=3D rom[i + 13]=
) {
> > +            continue;
> > +        }
> > +
> > +        if (found) {
> > +            return -EEXIST;
> > +        }
> > +
> > +        val =3D rom[i + 4] | ((uint16_t)rom[i + 5] << 8);
> > +        if (val < rom_size) { =20
>=20
> We write sizeof(uint32_t) to this offset, so this should be:
>=20
>         if (val + sizeof(uint32_t) < rom_size) {

Oops, the comparison should have become <=3D.  Thanks,

Alex

