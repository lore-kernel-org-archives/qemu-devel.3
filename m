Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906FCE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 19:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTncL-0000Wh-2l; Fri, 03 Jan 2025 14:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tTnc6-0000Ut-Ix
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 14:45:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tTnc2-0001CE-4S
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 14:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735933536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRrh/OeTJgdvzObuyX0QT7y1xm/EYazEn3nkO7edXPU=;
 b=IRJJS0eKUIfabUD8fwfFY/Mzzz9m2Gghdokrm735IgowmtZTfozNnXHvZ37l0E4HXl09+2
 RYSkKh54VQAcyYDJHi2ojJk+oJXhU+b2/z5U6/yIyRYc/t6JdaEyocz1cUfl2uOXaeF/Mc
 4wsxTSee6iFivTtLCOjtpFYsmxdzpGg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-FNEclf9HO2-nVy-gdSQVhw-1; Fri, 03 Jan 2025 14:45:35 -0500
X-MC-Unique: FNEclf9HO2-nVy-gdSQVhw-1
X-Mimecast-MFC-AGG-ID: FNEclf9HO2-nVy-gdSQVhw
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-844e5d2d07dso50956939f.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 11:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735933534; x=1736538334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRrh/OeTJgdvzObuyX0QT7y1xm/EYazEn3nkO7edXPU=;
 b=ZHd4VYcEIoBwlJ3ank/NgrWNZpPNxXO6KTq61zN5K0iaIoDrtCN16PndRwAnMg2bgB
 sFFs2/F6s8X1AhYseC/Loooe47bBN/6EZXFzpaZ0iOsAp0d5pWXnSYFHC0Qtvl386b6B
 LMJqA/+2dkgPaeMtfcm9+CGZmBVgR8jezmB1gzG2+gKBGp1pzC2kT/fPtEr2gPx9yCY3
 i0pxQE2UBhqXIMe0zyZ6W6d/PyS0Q1lFUsrX23rLWirFdwtQr0b38suII6w2u/bjs2kC
 UKi31HppuKwtGjMLbkn+xX1XWHua6G5MlYES9KKc8cLCH+2J+7mnO7VBzeEKTm3Q6kZM
 KYBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoEMSlx3Eu/UkC9e8fdGu4JreetoHl8z+bxT0mX/mAE9tjy0HXKvBQyDbxT5yRyrY3S94OdehwjHGC@nongnu.org
X-Gm-Message-State: AOJu0Yy9JDlS6c14WU79TGZHgbOs1l0dRNLiUyWyv+xFu5ExDViKF3tY
 UcxV7YgNnh98JyI4sALEvqDVkEO1jTyhCROYGrBe+CWy12/BppYdSQHK7bb3LBOG9Wp2K52AcuJ
 jgQkPG0wJn8Ti99Dmgi1zUUDLq3gv4ltCecAX8yJGTdfl1412IJMC
X-Gm-Gg: ASbGncuHcDndCNXR8jVztus+ru6PZYpG9CGz3gBTjMbhl+6oJK00AbGGPvjIZkDLG/Q
 S0J3in6YpcPDMF+/dwZpFVDNKvrmmbuJH02mYNYuN0UJSGuS6T1xxm1NtPhK/BT/qcuE++gZOVS
 wPsB/eP0nWIIRX0qDz0YTMV/LqpBTqWhqrvo/pb7YhUlQenUxm7LP/+3nrCK/wsJ+vESHgybM9c
 0v7ChIU8OeyMbUVa9dwwmaScS7liL+QsvKHbNG7tu04uOjMfsB3aO4PeyyZ
X-Received: by 2002:a05:6e02:20cb:b0:3a7:c5bd:a5f4 with SMTP id
 e9e14a558f8ab-3c2cc756f7bmr113786005ab.0.1735933534440; 
 Fri, 03 Jan 2025 11:45:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsNewWKWThDDqsTaVsBzHsgkimq8GfFyypBUhGnepfM0yu2XYSXgPXaDlVoFxnxG+eU94NBw==
X-Received: by 2002:a05:6e02:20cb:b0:3a7:c5bd:a5f4 with SMTP id
 e9e14a558f8ab-3c2cc756f7bmr113785965ab.0.1735933534089; 
 Fri, 03 Jan 2025 11:45:34 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c199abbsm7811368173.90.2025.01.03.11.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 11:45:33 -0800 (PST)
Date: Fri, 3 Jan 2025 12:04:56 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] vfio/igd: use VFIOConfigMirrorQuirk for mirrored
 registers
Message-ID: <20250103120456.7420c20b.alex.williamson@redhat.com>
In-Reply-To: <20241231151953.59992-4-tomitamoeko@gmail.com>
References: <20241231151953.59992-1-tomitamoeko@gmail.com>
 <20241231151953.59992-4-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 31 Dec 2024 23:19:53 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> With the introduction of config_offset field, VFIOConfigMirrorQuirk can
> now be used for those mirrored register in igd bar0. This eliminates
> the need for the macro intoduced in 1a2623b5c9e7 ("vfio/igd: add macro
> for declaring mirrored registers").
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 128 ++++++++++++++------------------------------------
>  1 file changed, 36 insertions(+), 92 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index f5414b0f8d..28a1d17f01 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -18,6 +18,7 @@
>  #include "hw/hw.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "pci.h"
> +#include "pci-quirks.h"
>  #include "trace.h"
>  
>  /*
> @@ -422,84 +423,21 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> -static uint64_t vfio_igd_pci_config_read(VFIOPCIDevice *vdev, uint64_t offset,
> -                                         unsigned size)
> -{
> -    switch (size) {
> -    case 1:
> -        return pci_get_byte(vdev->pdev.config + offset);
> -    case 2:
> -        return pci_get_word(vdev->pdev.config + offset);
> -    case 4:
> -        return pci_get_long(vdev->pdev.config + offset);
> -    case 8:
> -        return pci_get_quad(vdev->pdev.config + offset);
> -    default:
> -        hw_error("igd: unsupported pci config read at %"PRIx64", size %u",
> -                 offset, size);
> -        break;
> -    }
> -
> -    return 0;
> -}
> -
> -static void vfio_igd_pci_config_write(VFIOPCIDevice *vdev, uint64_t offset,
> -                                      uint64_t data, unsigned size)
> -{
> -    switch (size) {
> -    case 1:
> -        pci_set_byte(vdev->pdev.config + offset, data);
> -        break;
> -    case 2:
> -        pci_set_word(vdev->pdev.config + offset, data);
> -        break;
> -    case 4:
> -        pci_set_long(vdev->pdev.config + offset, data);
> -        break;
> -    case 8:
> -        pci_set_quad(vdev->pdev.config + offset, data);
> -        break;
> -    default:
> -        hw_error("igd: unsupported pci config write at %"PRIx64", size %u",
> -                 offset, size);
> -        break;
> -    }
> -}
> -
> -#define VFIO_IGD_QUIRK_MIRROR_REG(reg, name)                            \
> -static uint64_t vfio_igd_quirk_read_##name(void *opaque,                \
> -                                           hwaddr addr, unsigned size)  \
> -{                                                                       \
> -    VFIOPCIDevice *vdev = opaque;                                       \
> -                                                                        \
> -    return vfio_igd_pci_config_read(vdev, reg + addr, size);            \
> -}                                                                       \
> -                                                                        \
> -static void vfio_igd_quirk_write_##name(void *opaque, hwaddr addr,      \
> -                                        uint64_t data, unsigned size)   \
> -{                                                                       \
> -    VFIOPCIDevice *vdev = opaque;                                       \
> -                                                                        \
> -    vfio_igd_pci_config_write(vdev, reg + addr, data, size);            \
> -}                                                                       \
> -                                                                        \
> -static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
> -    .read = vfio_igd_quirk_read_##name,                                 \
> -    .write = vfio_igd_quirk_write_##name,                               \
> -    .endianness = DEVICE_LITTLE_ENDIAN,                                 \
> -};
> -
> -VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
> -VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM, bdsm)
> -VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm64)
> -
>  #define IGD_GGC_MMIO_OFFSET     0x108040
>  #define IGD_BDSM_MMIO_OFFSET    0x1080C0
>  
> +typedef struct VFIOIGDBAR0Quirk {
> +    VFIOConfigMirrorQuirk ggc_mirror;
> +    VFIOConfigMirrorQuirk bdsm_mirror;
> +} VFIOIGDBAR0Quirk;
> +

I don't understand why this needs to exist.  There's really no reason
that the ggc and bdsm mirrors need to be tied to the same quirk, just
do something like vfio_probe_nvidia_bar0_quirk() where we allocate a
quirk with a single memory region, setup the mirror, init the region,
add the overlap, insert into the quirk list, then repeat for the other.

>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>  {
>      VFIOQuirk *quirk;
> +    VFIOIGDBAR0Quirk *bar0;
> +    VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
>      int gen;
> +    uint32_t bdsm_reg_size;
>  
>      /*
>       * This must be an Intel VGA device at address 00:02.0 for us to even
> @@ -523,30 +461,36 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      }
>  
>      quirk = vfio_quirk_alloc(2);
> -    quirk->data = vdev;
> -
> -    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
> -                          &vfio_igd_quirk_mirror_ggc, vdev,
> +    bar0 = quirk->data = g_malloc0(sizeof(*bar0));
> +
> +    ggc_mirror = &bar0->ggc_mirror;
> +    ggc_mirror->vdev = vdev;
> +    ggc_mirror->mem = &quirk->mem[0];
> +    ggc_mirror->bar = nr;
> +    ggc_mirror->offset = IGD_GGC_MMIO_OFFSET;
> +    ggc_mirror->config_offset = IGD_GMCH;
> +
> +    bdsm_mirror = &bar0->bdsm_mirror;
> +    bdsm_mirror->mem = &quirk->mem[1];
> +    bdsm_mirror->vdev = vdev;
> +    bdsm_mirror->offset = IGD_BDSM_MMIO_OFFSET;
> +    bdsm_mirror->config_offset = (gen < 11) ? IGD_BDSM : IGD_BDSM_GEN11;
> +    bdsm_mirror->bar = nr;
> +    bdsm_reg_size = (gen < 11) ? 4 : 8;

This looks like it could just be calculated inline when the region is
initialized.  Thanks,

Alex

> +
> +    memory_region_init_io(ggc_mirror->mem, OBJECT(vdev),
> +                          &vfio_generic_mirror_quirk, ggc_mirror,
>                            "vfio-igd-ggc-quirk", 2);
> -    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
> -                                        IGD_GGC_MMIO_OFFSET, &quirk->mem[0],
> +    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
> +                                        ggc_mirror->offset, ggc_mirror->mem,
>                                          1);
>  
> -    if (gen < 11) {
> -        memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
> -                              &vfio_igd_quirk_mirror_bdsm, vdev,
> -                              "vfio-igd-bdsm-quirk", 4);
> -        memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
> -                                            IGD_BDSM_MMIO_OFFSET,
> -                                            &quirk->mem[1], 1);
> -    } else {
> -        memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
> -                              &vfio_igd_quirk_mirror_bdsm64, vdev,
> -                              "vfio-igd-bdsm-quirk", 8);
> -        memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
> -                                            IGD_BDSM_MMIO_OFFSET,
> -                                            &quirk->mem[1], 1);
> -    }
> +    memory_region_init_io(bdsm_mirror->mem, OBJECT(vdev),
> +                          &vfio_generic_mirror_quirk, bdsm_mirror,
> +                          "vfio-igd-bdsm-quirk", bdsm_reg_size);
> +    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
> +                                        bdsm_mirror->offset, bdsm_mirror->mem,
> +                                        1);
>  
>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>  }


