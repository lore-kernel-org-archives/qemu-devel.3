Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746E2C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnzr-0004ZT-0G; Mon, 06 Jul 2026 14:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wgnzo-0004Z8-QS
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 14:24:44 -0400
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wgnzm-0002YB-H1
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 14:24:44 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 1402F1D000D4;
 Mon,  6 Jul 2026 14:24:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 14:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1783362280;
 x=1783448680; bh=WRteh1NGjnS1iIoZoZcs+DbqHRmQlf8Sk5iv/vBTIyE=; b=
 SLzys99jylatb4K/BQgnZjjntOfk66TTCvy8r9xeWQB7OjctLrtk092XyVQ76Oj2
 AmMLefqre0yyAdZKkTiNjzOY38trSpTpOoUIXBAZP0ULx8OcXpD2JfdhCNEVod0t
 0fyYwbHZ1n2zjAkkVxIIhitrAUVJmQDa37VO/q/jA9kB7HT0n/d7IuN4oT6j9HVN
 QQXZ1GQjF2VgINnFXy5DTuq8uzNoLlKQATsEgRp3J4I6mM8pFjbhtdF24qX6LLvS
 JnVzt3TgE3KfzlJL9oEDF9OuHcmyRdO9SwWGlJh2yUswSaf3maTzy5+cPeqynusp
 tQfeRo18RfTA9fwA4J+4pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783362280; x=
 1783448680; bh=WRteh1NGjnS1iIoZoZcs+DbqHRmQlf8Sk5iv/vBTIyE=; b=f
 +sXANcb7HjtJIaBoTdQVXZbauwCMJRJwZtSkwM4KZIxinE1/Undoic1JgJnaA6fM
 AKV/b/rK1m0Ck/MJxtymlsCFvmqSqw1HgkB79BHb+3013V5S5Rh8Q01l+Xhg8Faj
 c4YQvunseQ3B2ZGfK0rDo2E1VGyTT2PFLBhxoUjxudI11iUxf2Pwli8csKXOBgoI
 dDbpsvzBOQy0qPn/73UTjiYHUwWInHl4hwbUDgNfcQbVzqr/Xydks2JK3ojSXxEs
 OgQ9ldwxriMs1Npe6IdRfnd3blouMHNW6VRW08yA+XU9BJ32Fg6IpwDj/zJ5sFi4
 Bl2+LntPGM29OwM3hw0YA==
X-ME-Sender: <xms:6PJLauImNc4Mjb2YzGdl4uS-e6aRvqote_c5IF48DXZcBgLRxibSdg>
 <xme:6PJLavHz5GVOKyw0vS2ZD8FRQg-etxPYmtve0GX20tpUV-9cqLSqvy2jEOMoIstSX
 bBDyQ0tMihH2-C7IjZeS46Ix5VggA3bHFDnHE1MkS1egjBikej1JQ>
X-ME-Received: <xmr:6PJLaqSrC0xUXGE1CfhsKYWsn5VkcPurXuBn1LYCW-maCyWEraCuKEyLLaY>
X-ME-Proxy-Cause: dmFkZTGLZfkLRWW3EhVX1lWLGvkyG4uO4CU7g8Mgs7iBSG24ZY1MtdfYXOdS9uZWXLOKKS
 LPwOk14+8xmPo65R+6mfIF7lhYeSCyVw0iTiDqSvNQWcL3oCVhAbzcVZEVqKJH4252PqQP
 H7P7YSSItYc/i742EGKwQQ8vKWLhxKvFeedbO9gNSO9S46BwjZppX3cp4YRinjnBDaUBCV
 nHv7xF83qCUm6WMaln/g5q/deqdK//trNalc7hZk20TqohyoJDYUbcE0APEjcP2NJy4z6t
 ruj/61NuYVg5F7umokdnebKyG3YG6boG6YYkg7moUzqx3JzphBDTF3b7xdWdRob/5s2lO/
 AhniitLqzEggHehdQCVAyT5HX/jnxed+OPygthoDwmsIdvAGsCAQDgi/uNYeV6YdpRXit7
 eUHvLwE2o0HZ+KQKdEDq7X6NFfxPXPsNl+u2yjstDG3T1E3LNduDnHczwP0Vw3+kSM4kUs
 /VcQaDr1edtYwjgJ1OOYmDww7ZMRJKDr25IXyGAMtxs0i9P9Ep+dnANF4v4MbyvIdKPA9B
 HiNlCyfDDHmwH03OZh5/kcdMO6jrI92wE4zx5bwXBWBz9LnVDUHT3AIRXBvyQ4NjyfquwQ
 WiYSvmHtShTYA60PNxgdcaXPIQg99txHsUgZBRSMWJizLEWpf8BMJMScyOqA
X-ME-Proxy: <xmx:6PJLajeuzkf0uF0MjWnI6Jd0HAc5UATg9jy96Z8O91wJaYjC-3KMEg>
 <xmx:6PJLahry_NgMZOh5WdHXadi6ly5DfYZ-eY05aZ50lQGhgpBD6h1sgg>
 <xmx:6PJLas_gG0UluBcvi3y8h_VcwcMoMTUSpPTFIczChEYiCn_g8Hs5bQ>
 <xmx:6PJLaleBIqDpOkiwavqddEzRsabTDTrBTaL0eQz_cMEBZ2lpZgzyZw>
 <xmx:6PJLau6WV89iI5DXZNnDCIuxuMzzctLrTxKuVVgn3Ah8jWjIIuY59fNe>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 14:24:40 -0400 (EDT)
Date: Mon, 6 Jul 2026 12:24:38 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH v4 2/4] vfio/igd: Refactor option ROM patching
Message-ID: <20260706122438.1aea45c9@shazbot.org>
In-Reply-To: <20260701182035.96010-3-tomitamoeko@gmail.com>
References: <20260701182035.96010-1-tomitamoeko@gmail.com>
 <20260701182035.96010-3-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.148; envelope-from=alex@shazbot.org;
 helo=fout-b5-smtp.messagingengine.com
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

On Thu,  2 Jul 2026 02:20:33 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Currently the IGD-specific option ROM patching logic is embedded in
> vfio_pci_load_rom() rather than igd.c where IGD-specific code lives.
> Move this logic into a dedicated vfio_igd_legacy_rom_quirk() in igd.c.
> The refactored quirk patches the device ID and checksum on Gen 6~9
> devices with legacy VBIOS as option ROM. A new trace event
> vfio_pci_igd_vbios_patched is also introduced.
> 
> Arguments of vfio_igd_legacy_rom_quirk() are aligned with romfile_fixup
> of PCIDevice so that same logic can be reused on romfile later.

The patching in vfio_pci_load_rom() is mis-characterized as
IGD-specific.  It certainly has an IGD use case, but it's intentionally
generic and handles all cases where the device ID in the ROM doesn't
match the device ID in config space, such as through use of the
x-pci-device-id option.  This change MAKES that code IGD specific and
changes the behavior for all other devices that might have relied on
it, a clear behavioral change.  Nak.  Thanks,

Alex
 
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd-stubs.c  |  5 +++++
>  hw/vfio/igd.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci-quirks.c |  5 +++++
>  hw/vfio/pci.c        | 30 +--------------------------
>  hw/vfio/pci.h        |  3 +++
>  hw/vfio/trace-events |  1 +
>  6 files changed, 63 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
> index f7687d9091..29110f7568 100644
> --- a/hw/vfio/igd-stubs.c
> +++ b/hw/vfio/igd-stubs.c
> @@ -18,3 +18,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>  {
>      return true;
>  }
> +
> +void vfio_igd_legacy_rom_quirk(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
> +{
> +    return;
> +}
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e091f21b6a..f597218164 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -724,3 +724,51 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>  
>      return vfio_pci_igd_config_quirk(vdev, errp);
>  }
> +
> +void vfio_igd_legacy_rom_quirk(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
> +{
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
> +    int gen;
> +    uint16_t pcir_offset;
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
> +    if (pci_get_word(ptr) != 0xaa55) {
> +        return;
> +    }
> +
> +    /* Must be a legacy ROM */
> +    pcir_offset = pci_get_word(ptr + 0x18);
> +    if (pcir_offset + 0x14 >= size || memcmp(ptr + pcir_offset, "PCIR", 4) ||
> +        pci_get_byte(ptr + pcir_offset + 0x14) != 0x00) {
> +        return;
> +    }
> +
> +    /*
> +     * Patch device ID as multiple IGD devices share the same rom with possible
> +     * non-matching IDs.
> +     */
> +    pci_set_word(ptr + pcir_offset + 6, vdev->device_id);
> +
> +    /*
> +     * IGD roms are known to have bogus checksums. No matter we changed the
> +     * device ID or not, we need to recalculate the checksum and patch it.
> +     */
> +    for (i = 0; i < size; i++) {
> +        checksum += ptr[i];
> +    }
> +    ((uint8_t *)ptr)[6] -= checksum;
> +
> +    trace_vfio_pci_igd_vbios_patched(vdev->vbasedev.name);
> +}
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index bccf31751f..496a79a3ca 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1592,3 +1592,8 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
>  
>      return true;
>  }
> +
> +void vfio_rom_quirk_setup(VFIOPCIDevice *vdev)
> +{
> +    vfio_igd_legacy_rom_quirk(PCI_DEVICE(vdev), vdev->rom, vdev->rom_size);
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9c06b25e63..d321e6160a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1084,35 +1084,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>          }
>      }
>  
> -    /*
> -     * Test the ROM signature against our device, if the vendor is correct
> -     * but the device ID doesn't match, store the correct device ID and
> -     * recompute the checksum.  Intel IGD devices need this and are known
> -     * to have bogus checksums so we can't simply adjust the checksum.
> -     */
> -    if (pci_get_word(vdev->rom) == 0xaa55 &&
> -        pci_get_word(vdev->rom + 0x18) + 8 < vdev->rom_size &&
> -        !memcmp(vdev->rom + pci_get_word(vdev->rom + 0x18), "PCIR", 4)) {
> -        uint16_t vid, did;
> -
> -        vid = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 4);
> -        did = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6);
> -
> -        if (vid == vdev->vendor_id && did != vdev->device_id) {
> -            int i;
> -            uint8_t csum, *data = vdev->rom;
> -
> -            pci_set_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6,
> -                         vdev->device_id);
> -            data[6] = 0;
> -
> -            for (csum = 0, i = 0; i < vdev->rom_size; i++) {
> -                csum += data[i];
> -            }
> -
> -            data[6] = -csum;
> -        }
> -    }
> +    vfio_rom_quirk_setup(vdev);
>  }
>  
>  /* "Raw" read of underlying config space. */
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c3a1f53d35..620baddda2 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -251,10 +251,13 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
>  void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
>  void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
>  bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
>  void vfio_quirk_reset(VFIOPCIDevice *vdev);
>  VFIOQuirk *vfio_quirk_alloc(int nr_mem);
> +
>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
>  bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_igd_legacy_rom_quirk(PCIDevice *pdev, uint8_t *ptr, uint32_t size);
>  
>  extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
>  
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 2049159015..7dc334ccb3 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -90,6 +90,7 @@ vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_
>  vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
>  vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
>  vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
> +vfio_pci_igd_vbios_patched(const char *name) "%s"
>  
>  # listener.c
>  vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64


