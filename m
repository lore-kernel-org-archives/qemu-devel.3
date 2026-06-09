Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A50CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWuVc-0004vR-Ih; Tue, 09 Jun 2026 07:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wWuVb-0004vF-6E
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:20:39 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wWuVZ-0007UV-81
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:20:38 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36bc065c298so493296a91.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781004033; x=1781608833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ok5AatqngA5VD4rkDebfgDulasmHvU7igTqm2S0Z+aY=;
 b=St8O8wF/f3GDP5K2me5oBsCdOWSDm4g37HsTtab0+5aF8lWPJObiwW6JBhMb1jw5h5
 QZ/+1yZ6XHd+sIIuKT4upzj5pTT2eJWd+Nb/p4vDaWnjo2CHqf4J8JpeqyryFW9FNF/M
 2KLB9tzrQSQlJh+6I5qs6Jz1zNVhoeOf51bg79ItcLHF2/w7JMkoiwENBe5LPNmp6qyv
 u/EaFbVvRRoJNLlDWO8RcEyDf2TVjLWHNLE6tLpkEdAd5x8ZHqYk4TU5qOrR5ObIz3SK
 +kQBK5iDm91jGwemnmLkPvT5jgbYiw84LS3viattbGTo/SA7Is6OIqplMNsDUz9H2WTp
 ZcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781004033; x=1781608833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ok5AatqngA5VD4rkDebfgDulasmHvU7igTqm2S0Z+aY=;
 b=MoRRxqnS73fp/qtltBpHyJuLAim6FGqpt06kQfJgWS7BTA6BTEcaa5U+dOB8eX0tq7
 kLPjznqQdIXJ+LL0/kYdqx62kmjEnhAWQmZWkph7j77mpys6WqqoZ4ozBFiLx5dC2CE3
 l++HRvksJnwjSAZg0KbvdNMgQp0iYkEk5H+v9i/4cSjAJHgH1bPPTTPZiR9DGvsBrFjR
 lwWfP2f62Ur2cgCCIADgE3Rk4PURG3qIlPPeoatnNBPHrtJW84UMG9f4p0+N6vJ/iXNi
 flO5bSLUPcXq3e2Kj3X1TJv1SYt+dYs/eTTvseqIJOXA3t5zFpjrVPqYmpIoklsDoSAe
 FaHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oZYi0NeMQcTZte1KgGv1svVjI734pl+hOBGQIFLg2FwBp+QOYKAVndUvnbcgodyL5A+SQVYRQ8p6M@nongnu.org
X-Gm-Message-State: AOJu0YzIpfhir2BzpDZR/xkGo8bhEXRGZkWGMIMgnQ6PiwVoiP8to5JE
 5pllghT2p2tzrTdexvmBODe6a2ngSMdZFxzn1FjUn02EvyKWp6tHBmp7
X-Gm-Gg: Acq92OHG0YE+boSci7EcIfME90t0mj0PVbXaEhcjNljAA2+Sz6Hr0NDcdQykwdU/9CK
 YwTW/uLTsBGPHt5MjA1uLATX8jt46WGxMn5ZXyxF6hoDwP+prxE9HblF2Kfgg6ENZ4KP0yeVfrK
 HAzeEp0gsE4FZk2T4NvH9jCRDDmO+3fo+pzZSCot02DPeSHghIvgOeoU1dl8XhJT9MOnDGuRoUZ
 b7YElc0TPSTSOsfFXTreBUbVEj9Axm1vXIq7XDJhtgtYUuOFOdGxUrk78xRqM48k1i4Tbr1kSw2
 wvqORJyVoSpxjIwSXC68UyvhZNfRgVQ0DhNQfex2SOQJR9VUXVnAk+feF7+whxXalb57JqW0R39
 ZreZlbqzvRJV+4ErcuE+L3QruqSbYRWf1bTCtL+i8BzEgWUNGoiSCKw981h/63KS84ZLC6cFK0r
 qoF2bVUlrm/iz0Qfsqvfeb2tHGwatvrG6ncwNIwmj0B/v6rfMluPjQ1oYxK1zpbHFMs0p0lGRs5
 nuNgoZoDRNQZWWSvF0MXxkJaCuL0A==
X-Received: by 2002:a17:90b:38d2:b0:35f:bf50:b4b6 with SMTP id
 98e67ed59e1d1-3751ff2302bmr1323213a91.1.1781004033415; 
 Tue, 09 Jun 2026 04:20:33 -0700 (PDT)
Received: from ?IPV6:2001:4490:484d:703a:9adb:4176:bfa1:c709?
 ([2001:4490:484d:703a:9adb:4176:bfa1:c709])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6bf830b2sm17591792a91.4.2026.06.09.04.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 04:20:32 -0700 (PDT)
Message-ID: <4aa2e582-4f32-4acc-b098-fb44741e737b@gmail.com>
Date: Tue, 9 Jun 2026 16:50:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] vfio/igd: Fix garbled screen on IGD passthrough
 with legacy VBIOS
To: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
Content-Language: en-US
From: K S Maan <kirandeepmaan45@gmail.com>
In-Reply-To: <20260608134559.23971-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=kirandeepmaan45@gmail.com; helo=mail-pj1-x1033.google.com
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

On 6/8/26 7:15 PM, Tomita Moeko wrote:
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
> v2:
> * New patch 2/7 to fix regression with EFI option ROMs
> * Refine logic in ROM ID and checksum patching
> * Reorder patch 4 and 5 for cleaner bisection
> * Address comments from v1
> Link: https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t
>
> Tomita Moeko (7):
>    hw/pci: Recalculate option ROM checksum before patching ID
>    hw/pci: Skip EFI option ROM in pci_patch_ids()
>    hw/pci: Introduce rom_need_patch_id flag in PCIDevice
>    hw/pci: Promote pci_patch_ids() to public pci_rom_patch_ids()
>    vfio/igd: Toggle rom_need_patch_id flag on IGD devices
>    vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID patching
>    vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
>
>   hw/pci/pci.c                |  58 ++++++++++------
>   hw/vfio/igd-stubs.c         |   5 ++
>   hw/vfio/igd.c               | 132 ++++++++++++++++++++++++++++++++++--
>   hw/vfio/pci-quirks.c        |   5 ++
>   hw/vfio/pci.c               |  33 ++-------
>   hw/vfio/pci.h               |   3 +
>   hw/vfio/trace-events        |   1 +
>   include/hw/pci/pci.h        |   3 +
>   include/hw/pci/pci_device.h |   1 +
>   9 files changed, 188 insertions(+), 53 deletions(-)
>

