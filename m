Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6BECD6E7E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 22:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVcce-0000wJ-4J; Fri, 05 Jun 2026 18:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wVccY-0000kZ-OO
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:02:30 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wVccW-0000pd-VB
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:02:30 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7EA5C1400144;
 Fri,  5 Jun 2026 18:02:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 05 Jun 2026 18:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1780696946;
 x=1780783346; bh=GoHKUNfkXqSLWbuSdK76tUylOPnCNLXAmYDahGa/Pa4=; b=
 fvbrg1h0m1ZTcpKXCetRK60hUHY8tXZVh75BP5Pl5/VhjMYKEOenBNfGY8/0dlBo
 SljHpalYgx5NY3PivQXSIlWW+bo4ShAA3zI3FNarJUsT1BJcxh6OdVS5gjGBbzjy
 gN+cdgU9UfMAG7WumIcw0h1DAEwimgEdNwP7xajwoCjFgBtiZ6WKJIa/RVNR8QLh
 PMlCGxYu2HbQzywAdiwqCnXsUbjgWRpDP9kBs+gcj4MaOWgW2WcLdssO8DIYS1s7
 tWSsU9xwYxQOYyqTuCYJBl3ITcAOY1tpWfKPGuWjB7NaOhVz2xfYYc07bQdSX7z6
 eDGW9BVq0Y7Bzm5sK3oeEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780696946; x=
 1780783346; bh=GoHKUNfkXqSLWbuSdK76tUylOPnCNLXAmYDahGa/Pa4=; b=Q
 gMjr1PIbGIsuQqglR0JoW80VGRHj8OVDFbbUr9IHOkVUHbIRrjkp98eHoTQVPyI8
 9qdvaHDDdSq3qN0+O1MgBpVsoLLtTnPvOSwQpMp7I3c1+weSUJxvqwi/k1oc6Xjo
 ULE9LEqZvdIK1vuFlQgV8Chgl3Wm9jNwCjoTn3LRJi43HMfxvodNfJj72q/rQ0Tt
 rKKkwURtbOBZ6KceXiE16Y+1M+L8CeJVdYHdldEkWfr76v493+8tqqS1AmvynfJC
 0zlrQaYFMT4XJjgblye/vSCEFIUtYivG8Z0Y/OO9gpGCCEgZnHExDXhairiS7ghP
 VCoTng930R79/hxfO5bwQ==
X-ME-Sender: <xms:ckcjaplHn54hZqRo_uN9fbw_MmfRwECAPeM9fq8kwAUQZrfQ8Ry-RA>
 <xme:ckcjatxLLVeVPdpmB37eYiaOmqaqGdRtvNLFvO_S6YIaxQh1HUXrsKpSVJ84qutrN
 s97lmvhH_dsrc3fdxxlziWcZ7zMhJcn8tU3f61ILE735vTyAeBXnA>
X-ME-Received: <xmr:ckcjarM8et1p0EIG31xkl6HN3TedEFrDGiVp3IEea6jdtKR6glTXfglDQ90>
X-ME-Proxy-Cause: dmFkZTFEBADKa0mg92+XbiQG+GdJ2DleML41YMhxyLjVIr28T13FuOoxrC/gdKYoz+4kt2
 5M1tZtE0CxP2MZBfhLukknaOpafK84IKW17Tu4lSJBZ4gchwDuA2ZXms80qij0N4BGlM3t
 GPfeVcFGaEJo9DjndAMjPgiDXkB3cOVPyrvijrqbURR2n4caJyZTTPZBV1PulwOKkkbWp8
 FoLsC6m325eyKUFxI4B8wArGp/iD4iLEvkz0BK1Je7jap1fbI9Q8JUC5pfMhdL/d7V/DeA
 tQTNn015H+aL3N+DNCcYs4nU6a6ekNz23V/f89BYbrjk/2qlFPXsbagG+dxJGXTObxZ6Zu
 vxX6++A+eP4NKYLMwvV6eTE3IJGxYA9jauzrZA4DSl8sMxzLYoVNRYCM5Mb8KTBK8InLT5
 R2CXE+bSWOYlb8mebFKVK5j41v9s1jbjvDJzk7swtEyxNzL8BoMKrlsYWZ/HRcxYZOEdWM
 XJw/pK3hNmV2RDvUoiyjvo3fKgELgiHTkb5yZmHczHCkGC26AVXFRcK4AdBjMAT3nUUmTw
 apex4UY9j8syyb8inyX7TtuOelAqsDmYnwxUEiYXAK3+rRHfRDmYIbYKqGYlwpv5jJl5xT
 wOu9AuFThGxLzFQ7tCMOkbAIegbtWlbwexAKjYp4DlBghqMfJqFgjlLMBJEg
X-ME-Proxy: <xmx:ckcjaprrCUZXG0494ETUxVDT4tlIIOhaK6-ZDhiMBPfICmlA330PPA>
 <xmx:ckcjakEHocLA3qwNAnwtYE5Cg7so5BqNHnka-YSgjnipCMF9TllbWQ>
 <xmx:ckcjamrs7XwOWkx_l33a0qjqazZMSbCrM8UjCCOCclo4B6jv5v3PAQ>
 <xmx:ckcjala04jf-r_K7aZKIHDeeoOHoaF8cLsEA-ia28KxRjr6Xah5PNg>
 <xmx:ckcjaqEURJ8TQ4yF5OMwV7Q11F1WG_FpwWqnYtYzniJSRTQZ8a-yRxx->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 18:02:25 -0400 (EDT)
Date: Fri, 5 Jun 2026 16:02:24 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH 6/6] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at
 load time
Message-ID: <20260605160224.32405a42@shazbot.org>
In-Reply-To: <20260603173355.36121-7-tomitamoeko@gmail.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
 <20260603173355.36121-7-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.153; envelope-from=alex@shazbot.org;
 helo=fhigh-a2-smtp.messagingengine.com
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

On Thu,  4 Jun 2026 01:33:54 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 17437ae18d..e00f6f8315 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -739,3 +739,109 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vde=
v, Error **errp)
> =20
>      return vfio_pci_igd_config_quirk(vdev, errp);
>  }
> +
> +/*
> + * IGD ROM BAR read from kernel is actually the host VBIOS shadow RAM re=
gion,
> + * which contains host modifications. In Gen 6-9 VBIOS, the routine belo=
w is
> + * used to get BDSM value when programming the initial GTT.
> + *   xx xx xx xx           v: .long ?                  # saved value
> + *   66 53                    push  %ebx
> + *   66 2e 83 3e xx xx 00     cmpl  $0x0,%cs:v         # is saved value =
empty?
> + *   74 07                    je    1f                 # if zero, go com=
pute
> + *   66 2e a1 xx xx           mov   %cs:v,%eax         # else return sav=
ed value
> + *   eb 0f                    jmp   2f
> + *   b8 5e 10              1: mov   $0x105e,%ax        # dev 00:02.0, of=
fset 5E
> + *   e8 xx xx                 call  pci_read_cfg_word
> + *   66 c1 e0 10              shl   $0x10,%eax         # left shift 16 b=
its
> + *   66 2e a3 xx xx           mov   %eax,%cs:v         # save the result
> + *   66 5b                 2=EF=BC=9Apop   %ebx
> + *   c3                       ret
> + * When running the VBIOS in guest, saved value still reflects the host =
stolen
> + * memory base address, which is not correct in guest. So we need to pat=
ch the
> + * VBIOS to clear the saved value.
> + *
> + * The unique 19-byte starts at `cmpl $0,%cs:v` and ends at `mov $0x105e=
,%ax`
> + * anchors the match to the routine. Both `cs:` displacements must refer=
ence
> + * the same offset.
> + */

Neat, cool quirk.

> +static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t rom_size,
> +                                     uint16_t *bdsm_offset)
> +{
> +    static const uint8_t start[] =3D { 0x66, 0x2e, 0x83, 0x3e };
> +    static const uint8_t middle[] =3D { 0x00, 0x74, 0x07, 0x66, 0x2e, 0x=
a1 };
> +    static const uint8_t end[] =3D { 0xeb, 0x0f, 0xb8, 0x5e, 0x10 };
> +    size_t i;
> +    bool found =3D false;
> +
> +    if (rom_size < 19) {
> +        return -ENOENT;
> +    }
> +
> +    for (i =3D 0; i + 19 <=3D rom_size; i++) {
> +        if (memcmp(rom + i, start, sizeof(start)) !=3D 0 ||
> +            memcmp(rom + i + 6, middle, sizeof(middle)) !=3D 0 ||
> +            memcmp(rom + i + 14, end, sizeof(end)) !=3D 0) {
> +            continue;
> +        }
> +
> +        /* same saved value address? */
> +        if (rom[i + 4] !=3D rom[i + 12] || rom[i + 5] !=3D rom[i + 13]) {
> +            continue;
> +        }
> +
> +        if (found) {
> +            return -EEXIST;
> +        }
> +
> +        *bdsm_offset =3D rom[i + 4] | ((uint16_t)rom[i + 5] << 8);

This needs a bounds check to make sure it's still within the ROM,
either here or before the memset().

> +        found =3D true;
> +    }
> +
> +    if (!found) {
> +        return -ENOENT;
> +    }
> +
> +    return 0;
> +}
> +
> +void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
> +{
> +    int ret, gen;
> +    uint16_t pcir_offset, bdsm_offset =3D 0;
> +    uint8_t checksum;
> +
> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> +        !vfio_is_vga(vdev) || !vdev->vga) {
> +        return;
> +    }
> +
> +    /* Only Gen 6~9 devices have legacy VBIOS as Option ROM */
> +    gen =3D igd_gen(vdev);
> +    if (gen < 6 || gen > 9) {
> +        return;
> +    }
> +
> +    if (pci_get_word(vdev->rom) !=3D 0xaa55) {
> +        return;
> +    }
> +
> +    /* Must be a legacy ROM */
> +    pcir_offset =3D pci_get_word(vdev->rom + 0x18);
> +    if (pcir_offset >=3D vdev->rom_size ||

This gates the below test to pcir_offset + 0x14, so should be:

       if (pcir_offset + 0x14 >=3D vdev->rom_size ||

> +        memcmp(vdev->rom + pcir_offset, "PCIR", 4) ||
> +        pci_get_byte(vdev->rom + pcir_offset + 0x14) !=3D 0x00) {
> +        return;
> +    }
> +
> +    ret =3D igd_vbios_find_saved_bdsm(vdev->rom, vdev->rom_size, &bdsm_o=
ffset);
> +    if (ret < 0) {
> +        return;
> +    }
> +
> +    memset(vdev->rom + bdsm_offset, 0, sizeof(uint32_t));
> +
> +    checksum =3D pci_rom_calculate_checksum(vdev->rom, vdev->rom_size);
> +    ((uint8_t *)vdev->rom)[6] =3D checksum;

If updated per previous recommendation, this becomes:

	((uint8_t *)vdev->rom)[6] -=3D checksum;

Thanks,
Alex

