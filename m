Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBFCCD98C7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyUq-0004q5-75; Tue, 09 Jun 2026 11:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wWyUm-0004pc-Fe
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:36:04 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wWyUi-00014d-Ln
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:36:03 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 275C5EC021E;
 Tue,  9 Jun 2026 11:35:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 11:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1781019357;
 x=1781105757; bh=UtTC19+3UZwKKZpStW5lRtwD9MnsBuy+I5Mlj0LMKos=; b=
 izlzuJ3VHgjujxvZSf0YFRhphs8RfVxG72do3p8WkkiPgTHvHXf1PCYJhqfQW/3u
 hFcXBgUOE3Vtt0glwePVNEvNoKVc0vWjmH7KjH0fh/CKjGgUmTosVZ/0OssRGqYz
 lWuo5wIoS/SDjpZHw0zBqz8pR/oBWnaY7w3Kk7+20+pEeH+nHp9zYziweIRl3fZk
 Peq1q5C2nlBRByU1pjTpVxPW7uIfsv5Aj7Ip7h++QrF13TwH61OVUGQ0I4+XmGwu
 GMXnyNicqvA2NVL3Y6TEsJFYDmIQzdRoP3bPV4ESHo7Np3NCBCXwgdgjvSij9JBV
 CtAiv/ZWI5LhuNePvrSSCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781019357; x=
 1781105757; bh=UtTC19+3UZwKKZpStW5lRtwD9MnsBuy+I5Mlj0LMKos=; b=L
 dlnFfuYKJb/7+XlkcUuhcd2YVAzXbb7tvfRA1I13GDuWVv+hcwwr/vJlTW6x6YoC
 iyOfT1cziBsumD8r1hUdwVpKw10Oi53cBApbtaJPhSfG47ZlQQ1Sk1EY7ERBmXEK
 34udMiBO72FqR5lW5pBulSWRENRoiydlAjy/Qt3CCokreRWey3MLaN2GdC6F2D0m
 3U4xjnKUomZ26Y5JY49NiNhiX57cl8QVKMBskK9FR05UbC+J+xfBeEAVHN1mvtcR
 UGZM3x5c3tK/NANu1rmkOISVoxmolH/UPeMQ/W32uERo+MSndk/mReDszB+TfNr1
 g96V5jujSSFOWyfEKXYog==
X-ME-Sender: <xms:3DIoaicpWmrS3z51CSqfl2xe8BymyLQUwWFoo_pVyiiNJw40BldvTQ>
 <xme:3DIoalLpTA9NkTPb2RA-gpDWfez7auTF9Od1j4y5U8D5LlQi2LZGlz9q_7no-HXhu
 FbaOCtmQn4qBWKwAseyL9uerGGFh9q_nZXvdyUs6gmc0yPcZrPxRg>
X-ME-Received: <xmr:3DIoavFLMCdX5zQdYZJp-lw0HUexVz0TfAY1vgbqiopOWwWbu-FE52zIli4>
X-ME-Proxy-Cause: dmFkZTFRpZRJOfQQzUY6vfAqZZBViRgKALOQtFrLJNvtWpFVGPY5DrtnrKjxkndlamJnjK
 7bwVgF+0VQ/M0qSRiIZQ8foAcIEbYKz/Npdkk3kNTKbFfild0wP9xpSOp7N5lk56sqGt6/
 PTbWZDAObX18stWd+Weina/pZ6ApYVYbZtwX6CiEXl9C57KKCHa/KyvyggYtcXjN3OgpZG
 ZuNWnUZVCo63gdgio/UnWGNtd0WhlrfrENyNSIMc9cBmpQIM57vlA8PDKJ4T1BZjSqWu4H
 jdIhOUpNNIa9TcMS7Qgj4HXnk9LLgIXOxZYEwfrtlnLCdAEHFIKInJVMuFgpn4CyE2ThOS
 jIbIXuIhUhTsnLmmqCgoR3p/9Nu/w/LzjTlskBYzXcEinis4tkdT4RQ0/LPy58/yJxtJ46
 NRqCcOV9fGELEjs67M35L9ymjQoiYtCKUPqYJnV0GZrBgGaVe7kZ4z/1YCdeaMSvW4Gf8f
 yAeefshIXoczAUyh/MgS+xeyJOmg6T2OzYp1r1WKHJ5wvUilXZYrxC8qLBI7XTBWXGqfcO
 +eYEF0mf3O6y2i+t3Lz8wDfDgrQcL/aA5EhTgaT7k/an+cW+L+Af7pZ6BaC4LabZc7r4oa
 IzKsdXiEmHh3nP7AHHIm0yOpF68JO1QwB7sCWKlPfu7vZu+k984UFqo7MAew
X-ME-Proxy: <xmx:3DIoagAdaAtYkf34IZ8dR1_0fV59kSdE25ewBhcjYL-i9h2TCnjGtg>
 <xmx:3DIoaq-zJWo0YJJbUd7-oKIF16S8rj1Guh66csthca9BHetuky7wOA>
 <xmx:3DIoakArvlwJbeJqx4q0hIVBS3vWtV5idRvTA9oG-snocj0AkMpkzQ>
 <xmx:3DIoanS5SR2INbhSpiPCSq5g_OKDRSsVWz9BzqFHXgyi3dBavqhLVw>
 <xmx:3TIoaqcM_VjLahOtfV4PHEPVqqaV6K_8gqK2l8IqVJXeix-9XQB81qDe>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 11:35:56 -0400 (EDT)
Date: Tue, 9 Jun 2026 09:35:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH v2 7/7] vfio/igd: Clear saved BDSM in legacy VBIOS ROM
 at load time
Message-ID: <20260609093554.534dc9a0@shazbot.org>
In-Reply-To: <20260608134559.23971-8-tomitamoeko@gmail.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
 <20260608134559.23971-8-tomitamoeko@gmail.com>
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

On Mon,  8 Jun 2026 21:45:58 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> IGD does not come with a ROM BAR [1], the ROM BAR read by default from
> kernel is actually the host VBIOS shadow RAM region that contains host
> modifications on boot. With AI-assisted reverse engineering on VBIOS
> binaries, it is observed that VBIOS saves BDSM register value on first
> access and uses saved value if present.
>=20
> When the image is executed in guest, since there is already a saved HPA
> in VBIOS, it keeps using that value instead of the GPA programmed by
> SeaBIOS in BDSM register in PCI config space, causing VBIOS to program
> GTT entries with wrong address, resulting in garbled output in BIOS
> POST and the error below detected by i915 driver.
>=20
> i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid =
range, dma_addr=3D0x00000000db200000 ((null) [0x00000000baf00000-0x00000000=
beefffff])
>=20
> The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
> mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
> guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
> ("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
> values in MMIO BAR0 and IO BAR4.
>=20
> Considering it's unsafe to expose HPA to guest, a ROM quirk clearing
> the saved value in VBIOS image is introduced. It searches the BDSM
> accessor routine by matching a 19-byte signature anchored on the unique
> `mov $0x105e,%ax` instruction, then locate the offset of saved BDSM and
> clears it. This makes the routine fall through to the PCI config read
> on the first call inside the guest.
>=20
> The quirk is invoked in vfio_pci_load_rom(), and is gated on Gen 6-9
> IGD devices with VGA access enabled and legacy (non-UEFI) PCIR code
> type in the ROM header. A new trace event vfio_pci_igd_vbios_patched
> is also introduced.
>=20
> [1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
>     https://www.intel.com/content/dam/www/public/us/en/documents/datashee=
ts/4th-gen-core-family-desktop-vol-2-datasheet.pdf
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd-stubs.c  |   5 ++
>  hw/vfio/igd.c        | 110 +++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci-quirks.c |   5 ++
>  hw/vfio/pci.c        |   2 +
>  hw/vfio/pci.h        |   3 ++
>  hw/vfio/trace-events |   1 +
>  6 files changed, 126 insertions(+)
>=20
> diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
> index f7687d9091..879a8aff56 100644
> --- a/hw/vfio/igd-stubs.c
> +++ b/hw/vfio/igd-stubs.c
> @@ -18,3 +18,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, E=
rror **errp)
>  {
>      return true;
>  }
> +
> +void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
> +{
> +    return;
> +}
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 834539affb..4b49038753 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -734,3 +734,113 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vde=
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
> +static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t rom_size,
> +                                     uint16_t *bdsm_offset)
> +{
> +    static const uint8_t start[] =3D { 0x66, 0x2e, 0x83, 0x3e };
> +    static const uint8_t middle[] =3D { 0x00, 0x74, 0x07, 0x66, 0x2e, 0x=
a1 };
> +    static const uint8_t end[] =3D { 0xeb, 0x0f, 0xb8, 0x5e, 0x10 };
> +    uint16_t val;
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
> +        val =3D rom[i + 4] | ((uint16_t)rom[i + 5] << 8);
> +        if (val < rom_size) {

We write sizeof(uint32_t) to this offset, so this should be:

        if (val + sizeof(uint32_t) < rom_size) {

> +            *bdsm_offset =3D val;
> +            found =3D true;
> +        }
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
> +    if (pcir_offset + 0x14 >=3D vdev->rom_size ||
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
> +    ((uint8_t *)vdev->rom)[6] =3D (uint8_t)-checksum;

This gets updated to:

    ((uint8_t *)vdev->rom)[6] -=3D checksum;

if we take the earlier suggestion.  Thanks,

Alex

> +
> +    trace_vfio_pci_igd_vbios_patched(vdev->vbasedev.name);
> +}
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index bccf31751f..45db968681 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1592,3 +1592,8 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error =
**errp)
> =20
>      return true;
>  }
> +
> +void vfio_rom_quirk_setup(VFIOPCIDevice *vdev)
> +{
> +    vfio_probe_igd_legacy_rom_quirk(vdev);
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6cbd65126e..66d6315e6f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1088,6 +1088,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>      if (pdev->rom_need_patch_id) {
>          pci_rom_patch_ids(pdev, vdev->rom, vdev->rom_size);
>      }
> +
> +    vfio_rom_quirk_setup(vdev);
>  }
> =20
>  /* "Raw" read of underlying config space. */
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c3a1f53d35..d8d6c09632 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -251,10 +251,13 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int n=
r);
>  void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
>  void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
>  bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
>  void vfio_quirk_reset(VFIOPCIDevice *vdev);
>  VFIOQuirk *vfio_quirk_alloc(int nr_mem);
> +
>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
>  bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev);
> =20
>  extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
> =20
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 2049159015..7dc334ccb3 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -90,6 +90,7 @@ vfio_pci_igd_bar4_write(const char *name, uint32_t inde=
x, uint32_t data, uint32_
>  vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
>  vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
>  vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
> +vfio_pci_igd_vbios_patched(const char *name) "%s"
> =20
>  # listener.c
>  vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova=
_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64


