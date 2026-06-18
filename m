Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CEDCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9sp-0001nk-SN; Thu, 18 Jun 2026 06:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wa9so-0001nQ-0A
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:22:02 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wa9sl-0001gk-6r
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:22:01 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8423f52cd57so32787b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781778118; x=1782382918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=10sfdLeNg6broVWtLROU21h0Xf5IRkwKrkVsyL0FxsU=;
 b=gWb3LCF47aBLu1qnQC+MEnYsHYDy27hGCBS6w5s0UCXE0qoU0iu72XDY/417B+WV5m
 xXtNfd2dddyQAnEAhcKei7B5CjT8HcnZP44yu4thjCY9UqQ0fUOOBuwrb0k2nZh2ZOrA
 6po2L/HbtVaaJiFM2/SS6+frnvlELvKwmOFD5L7zaEzR12HqCOdN8C63JDd3LbdYjE5T
 dMCftAYGzvKEzCT+1a/YmmIhkblfD2T0+UknlveIFvrGw6hcx7mJKMdP/RFUP3/l3g39
 AXSfrNTiCfxhIO5bTulkGc9kU3Ab+GrbPfiPzolq+PttmciDBkDGuUkl/0NRuWPgLLp+
 uAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781778118; x=1782382918;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10sfdLeNg6broVWtLROU21h0Xf5IRkwKrkVsyL0FxsU=;
 b=QstJ0//x2/z3WzJ13R/Zt3RKZhlyMOvjBQVdYRGyrP99OV+WkMs9xyQSO2WXk2nFJn
 2wxh9rvNcdKQC6dPNyxUe4GHFzFyu2Nw0EYfWGMTy2AFjDl0puoBex23lQpt1w8u6242
 a5cNboxnFFwnJtusGC8FGVSW6mPYUIIIbYsGhnymkvUlVAvjyZ3T+ZbdvDIzz41iO8Vn
 GrgorQSJVxbc1eybtShHpcNzmmxdhjWHnbjs30OptKlXex2DjyS1zyzgnXByDxMauQo+
 ku5vWAETNKknfniymYypfZXI+VYc9fKMQFhCejLO7y4ZH7WsY2ERYmQpRqRGyIdOVOzV
 ywJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4NDT/vr/KCf6KMpVwDupF1xqWFc8S07jbam6x28ASBm849w62XqFWz9kknUL8YZ682LXTKuP7q4YR@nongnu.org
X-Gm-Message-State: AOJu0YxHGolQ9mWAxY0RwRM+DfMfQHHsNip7kX3Xj10H4CNZVwGoiVfo
 DsrI8WWrauR23q7p5MEHQOSxRnwVE6bC1nbOkQIV28qPSGlP4fulSjCt
X-Gm-Gg: AfdE7cm4ggaOEKdVxHD0qkq5ZVqBEbFTYHWDhT+E9XZyh2ooIhxyvqMGXM9t22LTh9g
 RzlfZjdKIw64DIvXPWQ0evaZbciY06CtixbjcUoLR12BSKEcZQnESyKwn3XtQ7O/pOR+6Iea2tA
 fO8BnpLiPHUlOVIhZDlgYcEPRd6Aw5R6epmnB2mIJugSAnwaOE2KYNKGJR2glL6RPn9+JacS078
 kFgtnhGrqgJ+MfrLbHeQZIfq1qrrkpI4qMkdZDcAje6tcKd1JsDMawVm4tK08BL0k55qUvldrre
 TAizRbIjkjb5a+mLzpj9TmXMAxqRffS3gQIXdZjUdSxx9o7b2FAAsBO2NVU5vRPmaxTHGusP22E
 LAV1FzOO96b/6C/Udgfk6242SmgC7u9XH+A4+dnB3ch9kH+C7//24ryPUykZhZvdrOTkVue9fEA
 LFtQcnsTWaNUGnRW8ZArBa1JoedG4=
X-Received: by 2002:a05:6a00:244b:b0:82c:20ec:6589 with SMTP id
 d2e1a72fcca58-8453b1f5462mr1617505b3a.3.1781778117584; 
 Thu, 18 Jun 2026 03:21:57 -0700 (PDT)
Received: from ?IPV6:2001:4490:484d:b979::71? ([2001:4490:484d:b979::71])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434a934a97sm19226467b3a.0.2026.06.18.03.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:21:57 -0700 (PDT)
Message-ID: <de7a10d2-7f33-468b-af3b-7e0af3887a9d@gmail.com>
Date: Thu, 18 Jun 2026 15:51:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] vfio/igd: Fix garbled screen on IGD passthrough
 with legacy VBIOS
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
 <9268e0d9-c62b-4b9e-9d7b-d15bb4ecbdde@gmail.com>
 <e4c5461f-3bc6-4796-a142-ac4a2ce7f719@redhat.com>
Content-Language: en-US
From: K S Maan <kirandeepmaan45@gmail.com>
In-Reply-To: <e4c5461f-3bc6-4796-a142-ac4a2ce7f719@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=kirandeepmaan45@gmail.com; helo=mail-pf1-x42d.google.com
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

Hi,

Yes these patches fix garbled screen issue for :
   https://gitlab.com/qemu-project/qemu/-/work_items/3093

While following issue is unrelated and canbe close due to mismatch 
firmware between host and guest create other problems :
   https://gitlab.com/qemu-project/qemu/-/work_items/3535

Thanks,
K S Maan

On 6/18/26 2:04 PM, Cédric Le Goater wrote:
> On 6/18/26 09:02, K S Maan wrote:
>> Tested-by: K S Maan<kirandeepmaan45@gmail.com>
>
>
> Thanks,
>
>
> Shouldn't this series include a Resolves trailer for :
>
>   https://gitlab.com/qemu-project/qemu/-/work_items/3093
>
>
>
> What about :
>
>   https://gitlab.com/qemu-project/qemu/-/work_items/3535
>
> Should it be closed ?
>
> C.
>
>>
>> On 6/17/26 3:36 PM, Tomita Moeko wrote:
>>> This series fixes the regression that on IGD passthrough with legacy
>>> BIOS boot and VBIOS, the screen is garbled during BIOS POST and GRUB
>>> (which uses standard VGA output routines), starting from QEMU 10.0.
>>> Though the kernel i915 driver still works, it reports an error about
>>> the initial GTT programmed by VBIOS is using invalid address.
>>>
>>> i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using 
>>> invalid range, dma_addr=0x00000000db200000 ((null) 
>>> [0x00000000baf00000-0x00000000beefffff])
>>>
>>> With the help of AI disassembling the VBIOS image dumped from host, it
>>> is found that the VBIOS itself implements a routine like:
>>>
>>>      uint32_t get_BDSM() {
>>>          static uint32_t saved = 0;
>>>          if (saved != 0) {
>>>              return saved;
>>>          }
>>>          return read_pci_config(BDSM_REG);
>>>      }
>>>
>>> And the saved value is not cleared after initialization. Given that IGD
>>> devices don't have a real ROM BAR, the VBIOS image read by default from
>>> host is actually the VBIOS shadow RAM region, containing host-side
>>> modifications like the saved BDSM value above during POST. When the
>>> image is executed in guest, it still uses the saved host BDSM (HPA)
>>> instead of the value programmed by SeaBIOS in config space (GPA). This
>>> address mismatch leads to the garbled screen and i915 error.
>>>
>>> The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
>>> mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
>>> guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
>>> ("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
>>> values in MMIO BAR0 and IO BAR4. Considering it's unsafe to expose HPA
>>> to guest, a ROM quirk clearing the saved value in VBIOS image is
>>> introduced to fix the issue.
>>>
>>> During debugging, it is also found that IGD VBIOS ROM doesn't always
>>> match the actual IGD device ID, due to the fact that IGD of the same
>>> CPU family has multiple device IDs but shares the same ROM image.
>>> However, SeaBIOS checks the device ID strictly and refuses to run if
>>> IDs does not match. Currently only the default path, reading ROM from
>>> kernel patches the device ID, but the romfile path doesn't. So the ROM
>>> ID patching logic is also refactored in this patch series to also 
>>> handle
>>> the romfile path.
>>>
>>> These changes are tested on Haswell platform with legacy BIOS boot, by
>>> K S Maan. Thanks to K S Maan for continuous help on locating and 
>>> testing
>>> the issue!
>>>
>>> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/3093
>>> Reported-by: K S Maan<kirandeepmaan45@gmail.com>
>>>
>>> Changelog:
>>> v3:
>>> * Refactor ROM checksum calculation and patching logic as Alex's 
>>> comment
>>> * Fix boundary checks as comments in v2.
>>> Link:https://lore.kernel.org/all/20260608134559.23971-1-tomitamoeko@gmail.com/t 
>>>
>>>
>>> v2:
>>> * New patch 2/7 to fix regression with EFI option ROMs
>>> * Refine logic in ROM ID and checksum patching
>>> * Reorder patch 4 and 5 for cleaner bisection
>>> * Address comments from v1
>>> Link:https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t 
>>>
>>>
>>> Tomita Moeko (7):
>>>    hw/pci: Recalculate option ROM checksum before patching ID
>>>    hw/pci: Skip EFI option ROM in pci_patch_ids()
>>>    hw/pci: Introduce rom_need_patch_id flag in PCIDevice
>>>    hw/pci: Promote pci_patch_ids() to public pci_rom_patch_ids()
>>>    vfio/igd: Toggle rom_need_patch_id flag on IGD devices
>>>    vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID patching
>>>    vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
>>>
>>>   hw/pci/pci.c                |  57 ++++++++++------
>>>   hw/vfio/igd-stubs.c         |   5 ++
>>>   hw/vfio/igd.c               | 132 
>>> ++++++++++++++++++++++++++++++++++--
>>>   hw/vfio/pci-quirks.c        |   5 ++
>>>   hw/vfio/pci.c               |  33 ++-------
>>>   hw/vfio/pci.h               |   3 +
>>>   hw/vfio/trace-events        |   1 +
>>>   include/hw/pci/pci.h        |   3 +
>>>   include/hw/pci/pci_device.h |   1 +
>>>   9 files changed, 186 insertions(+), 54 deletions(-)
>>>
>
>

