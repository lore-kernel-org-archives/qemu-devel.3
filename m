Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73BDC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 05:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf9b6-0002k3-B1; Thu, 02 Jul 2026 01:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wf9b4-0002jp-Kq
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 01:04:22 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wf9b2-0005qn-LI
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 01:04:22 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-37decb6d5e3so164798a91.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 22:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782968657; x=1783573457; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eKcvNlCIHbQ+yWc7wN/aRs+pY/JxaU6fWZHNv76nksw=;
 b=WF2tIqqyr/4NqdPWQ8dGaYpUvorV6thcV9fn0UL62ztlz4uUvce6YYW4vMT+zXLyLG
 OF52spy1ZSkrpv/9gaSiSr8LrVTpPMAFVfoGdBbooSIjgjC0n5eJZggtObMhSwrc9itb
 ybFU4EBTkxfNj5iuARCf3E1LDOOnO4dw67oy/Z06uLb4KEd7YEqhV8+1knVQcdZ9e5/y
 dZQw6nRJHddgdGZU21+jLwXPfovoKkO1TNyKO2U53sT3W5YwyJYv6EV+LeIsmE9zxUYY
 g4kBM5dkVJQDNAdD3W7M8weFrgyoA4gH0UyqZwkSmv10kgkYk7ygC6z+AeQYdys4DSIs
 +3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782968657; x=1783573457;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eKcvNlCIHbQ+yWc7wN/aRs+pY/JxaU6fWZHNv76nksw=;
 b=gQGQWuJez1zqqjxstntk/Ncv9G2c3wSvk58ZOmC7C2QUKmFFnU33wBOX4NGBNyvTrX
 M8c62ofuJnVQlVg5Si6gUyOovH0VKaLQq9NtnEVji0zhi4W0wvc3HKLY9SD1pAx3hSPj
 Ruf24ZS6SaQ4Hkgf0zUgxaQ8DbHRN2/7A1v/rPm+WNJGY0XcfS1+V3qdzqzqHETgT01n
 NaLGiMm0kZB41hM9whzNw7ni8eTRd9zJdBImk4c9kY8ySreork8psFLOcDxcyjaFurEs
 4kE4i9ubNrItWiTZcu4MaXMlfGZHERVrNP5WX/EuyeaTbW2c/jaO3oLsHcI8KPUvSsyr
 37lA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrg23/EisRMfDABtfi3zWdkmX6SKQhcD0n4FlaKZQdF9LpvNqmzkBRdPwoYMTb3hbhWjTdaedfO67bZ@nongnu.org
X-Gm-Message-State: AOJu0YzVsmCVUSkh1fThiUAkt2YqvShY2/0DMvMpbDgz7uTxuUBbyQ5k
 ZJWaTKqfE4+0H2kEG5yAAzEJLteLWcyUh5cE0LzexwSwjABNXZ3XdZya
X-Gm-Gg: AfdE7cmhBaX2oBfwq6zXk91SmrK26UtACwIg2gdmcDMLP2VPbJ0RIz9a2fnU5A3taKT
 WgOZWl9IcrshVxxbcTbsW/6QDEPsnBrq6Vdtnv+cEgCcag7yhVffOUZYW4rbDd2fI8DFOD7H9qE
 rfqkkVEn6Itc63LR2jx2l42Y6HwiWRl3M+bo4UoVhONLOApw8pBeBG3KRXGm1/GDYXiTzpuFs/c
 GJqWxhZOtOVC01F+rx+c/SKokj1IgoLfwEJAP1AibPWyV2nC/JCQtRUliNC+n0EwOnOzg/8p7jG
 4K+CVKS8huUcajSXef5QX+sJLmjoxibMCx5/EdM+MaV/jZ+LpB13n2L5QAUVZ1HJheJZU0NfyYk
 bZ9mNWfTvZuMIZC0t2fKIew24tR42r8W+3B0Jbj2c/n9BRmlTX6nH2wiqLzLHyh6ivNe5fwb50T
 Zvh9aYwY7zLUJ/ezN5je3V1ZY6IZM=
X-Received: by 2002:a17:90b:3502:b0:37e:2053:3489 with SMTP id
 98e67ed59e1d1-380aa1a5f30mr2890745a91.3.1782968656756; 
 Wed, 01 Jul 2026 22:04:16 -0700 (PDT)
Received: from ?IPV6:2001:4490:484d:5747::71? ([2001:4490:484d:5747::71])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-380e1636b3dsm370383a91.2.2026.07.01.22.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 22:04:16 -0700 (PDT)
Message-ID: <7cc5af54-32bc-4749-9072-da52147b4153@gmail.com>
Date: Thu, 2 Jul 2026 10:34:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] vfio/igd: Fix garbled screen on IGD passthrough
 with legacy VBIOS
To: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260701182035.96010-1-tomitamoeko@gmail.com>
Content-Language: en-US
From: K S Maan <kirandeepmaan45@gmail.com>
In-Reply-To: <20260701182035.96010-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=kirandeepmaan45@gmail.com; helo=mail-pj1-x1029.google.com
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

On 7/1/26 11:50 PM, Tomita Moeko wrote:
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
> Tomita Moeko (4):
>    hw/pci: Introduce romfile_fixup hook in PCIDevice
>    vfio/igd: Refactor option ROM patching
>    vfio/igd: Setup romfile_fixup hook
>    vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
>
>   hw/pci/pci.c                |   4 ++
>   hw/vfio/igd-stubs.c         |   5 ++
>   hw/vfio/igd.c               | 128 ++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci-quirks.c        |   5 ++
>   hw/vfio/pci.c               |  30 +--------
>   hw/vfio/pci.h               |   3 +
>   hw/vfio/trace-events        |   1 +
>   include/hw/pci/pci_device.h |   1 +
>   8 files changed, 148 insertions(+), 29 deletions(-)
>

