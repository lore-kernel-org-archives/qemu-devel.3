Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CE0C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5DD-0002yC-2n; Tue, 07 Jul 2026 08:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wh5DB-0002xq-Nq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:47:41 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wh5D9-00078M-Rt
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:47:41 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-49429feeceeso199472b6e.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783428458; x=1784033258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OAO2KlMUFe29/27kcDLA8ucNkWQuVs/d+14OSwsOxyI=;
 b=igQr4r3j1D+XdLCqrabUtXAVEO3y6DgIiIKdLUS4Zk5/PmvB+roCOwZWevQl/mDlQX
 SK4gA46DWMCOpAcbhKVBMAP/zAvCkigq02r14RVM1AF2EMbqFKwG6hsS26/iRqvzvclR
 JK4Sm6z9O8jKNx9BInCOxKdEsg2ELB8FnzFzRw1NP2WgJa3Gu2yf3aXI9Bwlw/LRYWy4
 4rut7rs2ULi81awXFYzaNje/hlMFqBMqPE0VWHKp5X8BGwCgAaifU9kz4+hvfDt+OBe/
 bV2ZgQh8kMecm2yhsrdaOVa5+ApeEWzPJ0Tuan1Usnk9NRIUlozC1tSqwrq+dGogN0ix
 EsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783428458; x=1784033258;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OAO2KlMUFe29/27kcDLA8ucNkWQuVs/d+14OSwsOxyI=;
 b=UeBSAuviKjUMSiKmgw4Erq+1JviejIUs6BOX5qafRrsnTpmxIHXZgtM5FCNvC5fMU5
 GIdcsWSVI0YJbs6/AN580GjPFoTFCWpu1g2EaK5uaOaplRk53QNiJu0zCh5FSlnDzKDF
 3uD/SffzyY9/30TCRol0e7ekS01B8zFLTEF9Gke/tZoL0YF9Gr9pesP1Xg89sXIXf1Yt
 9ShM9aaz8EznRvoW1I37VuoMLdiYgkRE8P7CXgcC+XZ5ILjQnnekOV6yHkSS4kcwQgUO
 pgXTHBEF3efVKAQCMzx4QadAMuVJLIVnXCnjgPaXaVvY15JKOSEaH7sZ1K0glHARllsA
 FPSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ99/T64WXazNcg00cjnnyT2+phuOfWy+8LXwnZe5D0ioSgWCYaaTVved6wzMlAJ7n6N8hxhGRI/v+sr@nongnu.org
X-Gm-Message-State: AOJu0YzJ+xXUAzC2+0TRhQTqCA37nrnf2y3RAFi3FHDq8Kc6Q4ppHsy8
 bqTWKqqUzp8TG1uw20OfPHL6sP2AQ2dOQ6AJdf9PZ6G2lRqW717sji3vRtLaF3GS
X-Gm-Gg: AfdE7cmSqfmmuqNrczD+98DCx34jJ9Lc5TSrYE4KX8DLojSLuCEoJg3T8Lr2xXnzUoI
 MtNB0QBcyFL3SV5jQL+fHSkDy47ahQlgl8lXRl8QoHByZFA2lyZ5Q2wEkkMUb49XbDLP+JdLimq
 R1C4xUDiZgDQQellJNXQLaHIdzlnEbWbECxbMHIwVRnrQfOTgfnhwCaQ16slvUL6c1MF/kDJv51
 DWodzjDjDn6F4/0J1PYukrC+rAVijJBzkRwZ+L+C1ZQFSLh8rRscgzTc5RC1oD0dwWgoGGVIL4j
 xpksFn+28PO1vt492HijSCcbP9jiSY/e4VV61gYYkw/JVp10oaW9FStB6DWuiLaWV5hxRx45yq2
 f0XuFhmHklsLJMPc1hCyTjtMJBJfghyd535d+r3JlmiJkNWFLmQ50y5Iryvii5FXdIcp9Qw1OCl
 w2PM2T5aPtLv31VL+Sf9yr2GvY/FA=
X-Received: by 2002:a05:6808:3305:b0:46a:7ab9:c338 with SMTP id
 5614622812f47-4a07094e3d5mr1689068b6e.4.1783428457874; 
 Tue, 07 Jul 2026 05:47:37 -0700 (PDT)
Received: from ?IPV6:2001:4490:484d:eedc::71? ([2001:4490:484d:eedc::71])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d17d328bsm12034815b6e.4.2026.07.07.05.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 05:47:37 -0700 (PDT)
Message-ID: <acf6af67-7e27-4da9-a6bb-3a6cd7d435bf@gmail.com>
Date: Tue, 7 Jul 2026 18:17:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] vfio/igd: Fix garbled screen on IGD passthrough
 with legacy VBIOS
To: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260707083550.25765-1-tomitamoeko@gmail.com>
Content-Language: en-US
From: K S Maan <kirandeepmaan45@gmail.com>
In-Reply-To: <20260707083550.25765-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=kirandeepmaan45@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Tested-by: K S Maan <kirandeepmaan45@gmail.com>

On 7/7/26 2:05 PM, Tomita Moeko wrote:
> This series fixes the regression that on IGD passthrough with legacy
> BIOS boot and VBIOS, the screen is garbled during BIOS POST and GRUB
> (which uses standard VGA output routines), starting from QEMU 10.0.
> Though the kernel i915 driver still works, it reports an error about
> the initial GTT programmed by VBIOS is using invalid address.
>
> i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])
>
> With the help of AI disassembling the VBIOS image dumped from host, it
> is found that the VBIOS itself implements a routine like:
>
>      uint32_t get_BDSM() {
>          static uint32_t saved = 0;
>          if (saved != 0) {
>              return saved;
>          }
>          return read_pci_config(BDSM_REG);
>      }
>
> And the saved value is not cleared after initialization. Given that IGD
> devices don't have a real ROM BAR, the VBIOS image read by default from
> host is actually the VBIOS shadow RAM region, containing host-side
> modifications like the saved BDSM value above during POST. When the
> image is executed in guest, it still uses the saved host BDSM (HPA)
> instead of the value programmed by SeaBIOS in config space (GPA). This
> address mismatch leads to the garbled screen and i915 error.
>
> The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
> mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
> guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
> ("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
> values in MMIO BAR0 and IO BAR4. Considering it's unsafe to expose HPA
> to guest, a ROM quirk clearing the saved value in VBIOS image is
> introduced to fix the issue.
>
> During debugging, it is also found that IGD VBIOS ROM doesn't always
> match the actual IGD device ID, due to the fact that IGD of the same
> CPU family has multiple device IDs but shares the same ROM image.
> However, SeaBIOS checks the device ID strictly and refuses to run if
> IDs does not match. Currently only the default path, reading ROM from
> kernel patches the device ID, but the romfile path doesn't. So the ROM
> ID patching logic is also refactored in this patch series to also handle
> the romfile path.
>
> These changes are tested on Haswell platform with legacy BIOS boot, by
> K S Maan. Thanks to K S Maan for continuous help on locating and testing
> the issue!
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
>
> Changelog:
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
> Tomita Moeko (3):
>    hw/pci: Introduce romfile_fixup hook in PCIDevice
>    vfio/igd: Patch device ID for romfile-provided VBIOS
>    vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
>
>   hw/pci/pci.c                |   4 ++
>   hw/vfio/igd-stubs.c         |   5 ++
>   hw/vfio/igd.c               | 129 ++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci-quirks.c        |   5 ++
>   hw/vfio/pci.c               |   2 +
>   hw/vfio/pci.h               |   3 +
>   hw/vfio/trace-events        |   1 +
>   include/hw/pci/pci_device.h |   1 +
>   8 files changed, 150 insertions(+)
>

