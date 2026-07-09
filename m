Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C27C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whntX-0002pU-0l; Thu, 09 Jul 2026 08:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1whntV-0002ox-De
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 08:30:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1whntS-0000WE-U4
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 08:30:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-847852f9bdcso240361b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 05:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783600217; x=1784205017; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e4YMqGOWQ61/CCerKBrMD1SqbKZnL4H6tgzk5lv2eW8=;
 b=mNetZpqzjZy4uMRviMeiXlUF5FwrW1CCkcEGY76iU/KPV9FP8t4djEF3QryvQiQ18H
 FdYD8wDl1hQLXjJLOCypm67I5jV6pICkvT2+QOrcFawaPV5sML2MWplRQDNK/r5+y91g
 q5/A8Uz033agcjQTQRWK/DsNo43FtNuX0RJVxAmBrGtF/gzfVu4+8mRprysrzy0vrORr
 nV211GhipTsA9Ze/AWhAif1hSZ2oOITyaDU9QZi/NGzHsIsXreZMpCiE7OSuvt3A9bKz
 PG07C9nZOK/q3y9K0rJ9fi2LCSYzi31N3YSC2vzfIzWT8jJc3tNX0cLTY5O0ScX94ld0
 eQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783600217; x=1784205017;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e4YMqGOWQ61/CCerKBrMD1SqbKZnL4H6tgzk5lv2eW8=;
 b=QlSts816epTCUSThtUteRofLEFvbw8duwfarSbC2FHfJo2kkHhc4Jr8pT+jQK4Gtrm
 mLagnVuRERE57UMM+sScNuswIKinvA7CVM0yCsC/2gcXXjOaxcoFj10CKjPolXV9OEzW
 7fOs5NDD7zbU3SgpG46oElxRUb4G7huqREqN46qLl1XSjzV4kJEdQFAh1g3P3//I9bzJ
 i6MRqPG1LDU7EUeGvIgh7bho0b1ol9XJke3hMxXqpllkAURTOQnOkpsRTFGtlIR3vJiq
 K96E6oZE80qWHC+sWeb6tlilCQtSG7dA8mAx3cAW49rwKQdv0W1X0enQKCc+06IVJj+B
 Rghg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpArhE5fTq99wmzM/onY5iGFZC/MqWViS6avrALsEORDmjiqzt5Lnb1mXRm+1if4Q2kHXJwBbz9TaWY@nongnu.org
X-Gm-Message-State: AOJu0YzKIwUSaKJvFYqSVGgYg5h+lRedBEDsEB0Pgt1STea0kumjHSQT
 VK7cpM6p7oQd6bTrfuSTxEldggts7vT3rl0zGGtTU0s+5+1OYZd/wnD1
X-Gm-Gg: AfdE7cmH13GylD4wJrhljtH/9W819KImrs7pWxL3i6cudOgNuGDPdTf/Z16k3XSGnGK
 QWsANMtf+OI17be4vWJu6z+tEcLHwYzgLEbnKOo/Fvcm73Vgtv+5ixmcpKZVz+UY/SqAPODKyzT
 KxgT49ZiR7EC+3AIECEvOUfE8CC2fVlZNf5JF7UYZQuh8JoAfWyx6jSygFwsKXOLQxg6ZSamRJm
 HpgXM1h1FVsnCT656D5uGn9ISAqzkjHvhX+mjtY+t2u8xNsmIiNDX2HCjbMNPXM1mLynDYIqdvm
 3UnelQnW1XncYtERy7qdBiNG9W0cBShtuExlUMyM1qXorj//TzPEk2al6HdwxKgkFAgt5Ir4Ozr
 t7MwZ3ZfL7AC921/ma/28An76+XTjxjHvYdopYEsCLE/jLZyiumb65o0FFLkOguwwIY/ax/VWPS
 /1rBbsNjqg41Zpykru0IP4M42cDoc=
X-Received: by 2002:aa7:8890:0:b0:842:5a15:6fa6 with SMTP id
 d2e1a72fcca58-84842fce3admr5963199b3a.3.1783600216403; 
 Thu, 09 Jul 2026 05:30:16 -0700 (PDT)
Received: from ?IPV6:2001:4490:484d:b4eb::71? ([2001:4490:484d:b4eb::71])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8484f0acb85sm1754569b3a.50.2026.07.09.05.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 05:30:15 -0700 (PDT)
Message-ID: <ba025e3c-d7ea-46ea-9860-a73a6b84525f@gmail.com>
Date: Thu, 9 Jul 2026 18:00:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load
 time
To: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-stable@nongnu.org
References: <20260708103100.23127-1-tomitamoeko@gmail.com>
Content-Language: en-US
From: K S Maan <kirandeepmaan45@gmail.com>
In-Reply-To: <20260708103100.23127-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=kirandeepmaan45@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Tested-by: K S Maan <kirandeepmaan45@gmail.com>

On 7/8/26 4:01 PM, Tomita Moeko wrote:
> IGD does not come with a ROM BAR [1], the ROM BAR read by default from
> kernel is actually the host VBIOS shadow RAM region that contains host
> modifications on boot. With AI-assisted reverse engineering on VBIOS
> binaries, it is observed that VBIOS saves BDSM register value on first
> access and uses saved value if present.
>
> When the image is executed in guest, since there is already a saved HPA
> in VBIOS, it keeps using that value instead of the GPA programmed by
> SeaBIOS in BDSM register in PCI config space, causing VBIOS to program
> GTT entries with wrong address, resulting in garbled output in BIOS
> POST and the error below detected by i915 driver.
>
> i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])
>
> The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
> mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
> guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
> ("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
> values in MMIO BAR0 and IO BAR4.
>
> Since it was a value latched into the VBIOS that breaks virtualization
> (QEMU does not map the GTT at the same address in the VM), a ROM quirk
> clearing the saved value in VBIOS image is introduced. It searches the
> BDSM accessor routine by matching a 19-byte signature anchored on the
> unique `mov $0x105e,%ax` instruction, then locates the offset of saved
> BDSM and clears it. This makes the routine fall through to the PCI
> config read on the first call inside the guest.
>
> [1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
>      https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf
>
> Fixes: 5aed8b0f0be2 ("vfio/igd: Remove GTT write quirk in IO BAR 4")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> Changelog:
> v6:
> * Make it a self-contained regression fix for the ROM read through vfio
>    path only reported in the gitlab issue, per v5 comment from Alex.
> * Reword the commit message.
> * Cc stable as this is now a regression fix for QEMU 10.0+.
> Link: https://lore.kernel.org/all/20260707083550.25765-1-tomitamoeko@gmail.com/t
>
> v5:
> * Keep the current ID and checksum patching logic in vfio_pci_load_rom()
>    since it is not IGD-specific, as pointed out by Alex. The IGD-specific
>    quirk is now invoked after the generic patching. The ID and checksum
>    patching is duplicated in vfio_igd_legacy_rom_quirk() to handle the
>    romfile path, since the generic patching is not invoked on romfile.
> * Picked up the Michael's Acked-by on patch 1.
> * Reduced from 4 to 3 patches.
> Link: https://lore.kernel.org/all/20260701182035.96010-1-tomitamoeko@gmail.com/t
>
> v4:
> * Reworked per review feedback to keep IGD-specific workarounds out of
>    the generic PCI code. Instead of recalculating the checksum in
>    hw/pci/pci.c, a single generic romfile_fixup hook is added for device-
>    specific ROM patching. Now both kernel ROM BAR and romfile paths share
>    the same quirk, so the saved BDSM in user-provided romfile will also
>    get cleared.
> * Reduced from 7 to 4 patches.
> Link: https://lore.kernel.org/all/20260617100646.28326-1-tomitamoeko@gmail.com/t
>
> v3:
> * Refactor ROM checksum calculation and patching logic as Alex's comment
> * Fix boundary checks as comments in v2.
> Link: https://lore.kernel.org/all/20260608134559.23971-1-tomitamoeko@gmail.com/t
>
> v2:
> * New patch 2/7 to fix regression with EFI option ROMs
> * Refine logic in ROM ID and checksum patching
> * Reorder patch 4 and 5 for cleaner bisection
> * Address comments from v1
> Link: https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t
>
>   hw/vfio/igd-stubs.c  |   5 ++
>   hw/vfio/igd.c        | 115 +++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci-quirks.c |   5 ++
>   hw/vfio/pci.c        |   2 +
>   hw/vfio/pci.h        |   3 ++
>   hw/vfio/trace-events |   1 +
>   6 files changed, 131 insertions(+)
>
> diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
> index f7687d9091..5f60b24c8b 100644
> --- a/hw/vfio/igd-stubs.c
> +++ b/hw/vfio/igd-stubs.c
> @@ -18,3 +18,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>   {
>       return true;
>   }
> +
> +void vfio_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
> +{
> +    return;
> +}
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e091f21b6a..413a49aae9 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -724,3 +724,118 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>   
>       return vfio_pci_igd_config_quirk(vdev, errp);
>   }
> +
> +/*
> + * IGD ROM BAR read from kernel is actually the host VBIOS shadow RAM region,
> + * which contains host modifications. In Gen 6-9 VBIOS, the routine below is
> + * used to get BDSM value when programming the initial GTT.
> + *   xx xx xx xx           v: .long ?                  # saved value
> + *   66 53                    push  %ebx
> + *   66 2e 83 3e xx xx 00     cmpl  $0x0,%cs:v         # is saved value empty?
> + *   74 07                    je    1f                 # if zero, go compute
> + *   66 2e a1 xx xx           mov   %cs:v,%eax         # else return saved value
> + *   eb 0f                    jmp   2f
> + *   b8 5e 10              1: mov   $0x105e,%ax        # dev 00:02.0, offset 5E
> + *   e8 xx xx                 call  pci_read_cfg_word
> + *   66 c1 e0 10              shl   $0x10,%eax         # left shift 16 bits
> + *   66 2e a3 xx xx           mov   %eax,%cs:v         # save the result
> + *   66 5b                 2: pop   %ebx
> + *   c3                       ret
> + * When running the VBIOS in guest, saved value still reflects the host stolen
> + * memory base address, which is not correct in guest. So we need to patch the
> + * VBIOS to clear the saved value.
> + *
> + * The unique 19-byte starts at `cmpl $0,%cs:v` and ends at `mov $0x105e,%ax`
> + * anchors the match to the routine. Both `cs:` displacements must reference
> + * the same offset.
> + */
> +static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t rom_size,
> +                                     uint16_t *bdsm_offset)
> +{
> +    static const uint8_t start[] = { 0x66, 0x2e, 0x83, 0x3e };
> +    static const uint8_t middle[] = { 0x00, 0x74, 0x07, 0x66, 0x2e, 0xa1 };
> +    static const uint8_t end[] = { 0xeb, 0x0f, 0xb8, 0x5e, 0x10 };
> +    uint16_t val;
> +    size_t i;
> +    bool found = false;
> +
> +    if (rom_size < 19) {
> +        return -ENOENT;
> +    }
> +
> +    for (i = 0; i + 19 <= rom_size; i++) {
> +        if (memcmp(rom + i, start, sizeof(start)) != 0 ||
> +            memcmp(rom + i + 6, middle, sizeof(middle)) != 0 ||
> +            memcmp(rom + i + 14, end, sizeof(end)) != 0) {
> +            continue;
> +        }
> +
> +        /* same saved value address? */
> +        if (rom[i + 4] != rom[i + 12] || rom[i + 5] != rom[i + 13]) {
> +            continue;
> +        }
> +
> +        if (found) {
> +            return -EEXIST;
> +        }
> +
> +        val = rom[i + 4] | ((uint16_t)rom[i + 5] << 8);
> +        if (val + sizeof(uint32_t) <= rom_size) {
> +            *bdsm_offset = val;
> +            found = true;
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
> +void vfio_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
> +{
> +    uint8_t *rom = vdev->rom;
> +    int gen;
> +    uint16_t pcir_offset;
> +    uint16_t bdsm_offset = 0;
> +    uint8_t checksum = 0;
> +    uint32_t i;
> +
> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> +        !vfio_is_vga(vdev) || !vdev->vga) {
> +        return;
> +    }
> +
> +    /* Only Gen 6~9 devices have legacy VBIOS as Option ROM */
> +    gen = igd_gen(vdev);
> +    if (gen < 6 || gen > 9) {
> +        return;
> +    }
> +
> +    if (pci_get_word(rom) != 0xaa55) {
> +        return;
> +    }
> +
> +    /* Must be a legacy ROM */
> +    pcir_offset = pci_get_word(rom + 0x18);
> +    if (pcir_offset + 0x14 >= vdev->rom_size ||
> +        memcmp(rom + pcir_offset, "PCIR", 4) ||
> +        pci_get_byte(rom + pcir_offset + 0x14) != 0x00) {
> +        return;
> +    }
> +
> +    /* Search and clear the saved BDSM value */
> +    if (igd_vbios_find_saved_bdsm(rom, vdev->rom_size, &bdsm_offset)) {
> +        return;
> +    }
> +    memset(rom + bdsm_offset, 0, sizeof(uint32_t));
> +
> +    /* Recalculate checksum and patch it. */
> +    for (i = 0; i < vdev->rom_size; i++) {
> +        checksum += rom[i];
> +    }
> +    rom[6] -= checksum;
> +
> +    trace_vfio_pci_igd_vbios_patched(vdev->vbasedev.name);
> +}
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index bccf31751f..c5b4f9091d 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1592,3 +1592,8 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
>   
>       return true;
>   }
> +
> +void vfio_rom_quirk_setup(VFIOPCIDevice *vdev)
> +{
> +    vfio_igd_legacy_rom_quirk(vdev);
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c204706e63..dcfc92aae1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1119,6 +1119,8 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev, Error **errp)
>           }
>       }
>   
> +    vfio_rom_quirk_setup(vdev);
> +
>       return true;
>   }
>   
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index fe52e9df6e..c9ab949870 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -252,10 +252,13 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
>   void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
>   void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
>   bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
>   void vfio_quirk_reset(VFIOPCIDevice *vdev);
>   VFIOQuirk *vfio_quirk_alloc(int nr_mem);
> +
>   void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
>   bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_igd_legacy_rom_quirk(VFIOPCIDevice *vdev);
>   
>   extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
>   
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index f71d0bbc0a..bfdaf229e4 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -90,6 +90,7 @@ vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_
>   vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
>   vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
>   vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
> +vfio_pci_igd_vbios_patched(const char *name) "%s"
>   
>   # listener.c
>   vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64

