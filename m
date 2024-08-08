Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A302C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 04:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbuhP-0007pX-VU; Thu, 08 Aug 2024 00:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbuhN-0007oB-TX; Thu, 08 Aug 2024 00:24:25 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbuhM-0003zS-0s; Thu, 08 Aug 2024 00:24:25 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-822cf222888so187329241.1; 
 Wed, 07 Aug 2024 21:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723091062; x=1723695862; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrPJ7QlujYMdhrP3Kck1+Af5WNq2BzMkv8y9lDONoxg=;
 b=mdXMT98joPbT5wLICWofrO5pZMz83s1nUICyMa4aGJ77Tg9ZRUzTZ16C2SlX9xrTAK
 RxBDKhhHP+5AM7moFLMCdPcSysfG0IuwaXiYypPJOW84P6wxsPRftwp6QGcBIEXV8TUQ
 KxBpY0y7e5stg/VwV8NuG9wh7lBJIGzooaugm+eoyLY1Bm8otugWBUf9BZDt8UUOcBv1
 0Rmgz9la8j1sl8htxRu5c/hzRz/5O6oYJOUdXfFmddcbpEQdnc6hkeWXtyGA48Lz9mrQ
 r6ObYKYxkRC8XmbRb9XZ1mL27IL5YwdkspwiW6A/mBbMFOlgYMws0t5n3cnzpLIlHloc
 Lazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723091062; x=1723695862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QrPJ7QlujYMdhrP3Kck1+Af5WNq2BzMkv8y9lDONoxg=;
 b=Iok3sOMjFDKsdOVVVL+2DaWUWkOUmF3CDD19FQVGKaV8LBZjenUZqtiDNbk9LBT/HL
 3GzqS42Vg4k0V/aHQ36u0HpeoS7FpaWRR9hL2CDpv4Le1Y8FkJTWno8QVUc3/43axrnH
 nOSimEQKPS92Uf/TUuefevaZyiiK9+eP6mvdPk6NpE7wR03OmogqeMm0Xoy/L6vRKls5
 VchCeYwBWxIWrTuUSpTRdJmsRcdXl04oe3PBOIq4c4XYsFR5eP7i3KIOe4EFkcufggb1
 xZJXLQA1N68q/lRJkAQxRT+rw9l/IW1L5uct9aHRu3JRH35f2mfzQkpNn5l6h9Jfdj2s
 Rlpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl37uhLPAogi5dOqMdhAWPkwPowVANcb9XEmQlMeVyhwouRBq8FfRQFbcL7XkkfS6bPBK3+RcP900ceE7qyka7FmgE040=
X-Gm-Message-State: AOJu0Ywe2W+RTCwawJoQePzOBwMqqN5lbhtyzxD6Rtw94nQMOvgUoDIR
 QYFeUjH0licffYHDkLeJkRYx/TY+PE+ZNh1EtQOw3EHiY8ZX81mxxKL8Otpaa1H+yAvkHKgkneF
 xWNXXP0/s9VSi4ubJylXfUv2/o4w=
X-Google-Smtp-Source: AGHT+IE8b+iNtkfqAhX49iHM/DsI2Pu0bnEruQyVwnLX7vMdJuaewCFwjxsgqClUwwyXE+9pNV1iAU4MDtyv060kWPU=
X-Received: by 2002:a05:6102:1621:b0:48f:df86:dba with SMTP id
 ada2fe7eead31-495c5b38e5cmr1041851137.5.1723091062580; Wed, 07 Aug 2024
 21:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715101228.1247759-1-ethan84@andestech.com>
In-Reply-To: <20240715101228.1247759-1-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Aug 2024 14:23:56 +1000
Message-ID: <CAKmqyKN-YavB364d4wmwBBSi7TpsE1Y5CebvUCSi=CzfjWsJDQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] hw/misc/riscv_iopmp: Add API to set up IOPMP
 protection for system memory
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Mon, Jul 15, 2024 at 8:13=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> To enable system memory transactions through the IOPMP, memory regions mu=
st
> be moved to the IOPMP downstream and then replaced with IOMMUs for IOPMP
> translation.
>
> The iopmp_setup_system_memory() function copies subregions of system memo=
ry
> to create the IOPMP downstream and then replaces the specified memory
> regions in system memory with the IOMMU regions of the IOPMP. It also
> adds entries to a protection map that records the relationship between
> physical address regions and the IOPMP, which is used by the IOPMP DMA
> API to send transaction information.
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>  hw/misc/riscv_iopmp.c         | 61 +++++++++++++++++++++++++++++++++++
>  include/hw/misc/riscv_iopmp.h |  3 ++
>  2 files changed, 64 insertions(+)
>
> diff --git a/hw/misc/riscv_iopmp.c b/hw/misc/riscv_iopmp.c
> index db43e3c73f..e62ac57437 100644
> --- a/hw/misc/riscv_iopmp.c
> +++ b/hw/misc/riscv_iopmp.c
> @@ -1151,4 +1151,65 @@ iopmp_register_types(void)
>      type_register_static(&iopmp_iommu_memory_region_info);
>  }
>
> +/*
> + * Copies subregions from the source memory region to the destination me=
mory
> + * region
> + */
> +static void copy_memory_subregions(MemoryRegion *src_mr, MemoryRegion *d=
st_mr)
> +{
> +    int32_t priority;
> +    hwaddr addr;
> +    MemoryRegion *alias, *subregion;
> +    QTAILQ_FOREACH(subregion, &src_mr->subregions, subregions_link) {
> +        priority =3D subregion->priority;
> +        addr =3D subregion->addr;
> +        alias =3D g_malloc0(sizeof(MemoryRegion));
> +        memory_region_init_alias(alias, NULL, subregion->name, subregion=
, 0,
> +                                 memory_region_size(subregion));
> +        memory_region_add_subregion_overlap(dst_mr, addr, alias, priorit=
y);
> +    }
> +}

This seems strange. Do we really need to do this?

I haven't looked at the memory_region stuff for awhile, but this seems
clunky and prone to breakage.

We already link s->iommu with the system memory

Alistair

> +
> +/*
> + * Create downstream of system memory for IOPMP, and overlap memory regi=
on
> + * specified in memmap with IOPMP translator. Make sure subregions are a=
dded to
> + * system memory before call this function. It also add entry to
> + * iopmp_protection_memmaps for recording the relationship between physi=
cal
> + * address regions and IOPMP.
> + */
> +void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memm=
ap,
> +                               uint32_t map_entry_num)
> +{
> +    IopmpState *s =3D IOPMP(dev);
> +    uint32_t i;
> +    MemoryRegion *iommu_alias;
> +    MemoryRegion *target_mr =3D get_system_memory();
> +    MemoryRegion *downstream =3D g_malloc0(sizeof(MemoryRegion));
> +    memory_region_init(downstream, NULL, "iopmp_downstream",
> +                       memory_region_size(target_mr));
> +    /* Copy subregions of target to downstream */
> +    copy_memory_subregions(target_mr, downstream);
> +
> +    iopmp_protection_memmap *map;
> +    for (i =3D 0; i < map_entry_num; i++) {
> +        /* Memory access to protected regions of target are through IOPM=
P */
> +        iommu_alias =3D g_new(MemoryRegion, 1);
> +        memory_region_init_alias(iommu_alias, NULL, "iommu_alias",
> +                                 MEMORY_REGION(&s->iommu), memmap[i].bas=
e,
> +                                 memmap[i].size);
> +        memory_region_add_subregion_overlap(target_mr, memmap[i].base,
> +                                            iommu_alias, 1);
> +        /* Record which IOPMP is responsible for the region */
> +        map =3D g_new0(iopmp_protection_memmap, 1);
> +        map->iopmp_s =3D s;
> +        map->entry.base =3D memmap[i].base;
> +        map->entry.size =3D memmap[i].size;
> +        QLIST_INSERT_HEAD(&iopmp_protection_memmaps, map, list);
> +    }
> +    s->downstream =3D downstream;
> +    address_space_init(&s->downstream_as, s->downstream,
> +                       "iopmp-downstream-as");
> +}
> +
> +
>  type_init(iopmp_register_types);
> diff --git a/include/hw/misc/riscv_iopmp.h b/include/hw/misc/riscv_iopmp.=
h
> index b8fe479108..ebe9c4bc4a 100644
> --- a/include/hw/misc/riscv_iopmp.h
> +++ b/include/hw/misc/riscv_iopmp.h
> @@ -165,4 +165,7 @@ typedef struct IopmpState {
>      uint32_t fabricated_v;
>  } IopmpState;
>
> +void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memm=
ap,
> +                               uint32_t mapentry_num);
> +
>  #endif
> --
> 2.34.1
>
>

