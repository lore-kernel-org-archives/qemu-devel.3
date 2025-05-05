Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D33DC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBriA-0001Nd-Iy; Mon, 05 May 2025 05:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBri9-0001NK-2e
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBri7-0005Fi-Bo
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746435721;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yR6kVtS71Z7PVlx0saAzGxN64k/CZfIettgANMqxvOI=;
 b=X5fd+YPdc6LgQW6348bVuIviARkW9yR5ufyutmzyOJYaZWTBiE9kbo1ZNf8weahbBshSLx
 qGEufdBa1Nq7yPoZM5yqsNX8Etr7+GJWZRSQAyTIzDkMiMcWE+8WsX+rjdj+NhH8X9Zug0
 BEUnZRYq8DOz8+JoyzJ1cHBWVQVtPyM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-mF74B_IXOXm8kbF-BTtyfw-1; Mon, 05 May 2025 05:01:58 -0400
X-MC-Unique: mF74B_IXOXm8kbF-BTtyfw-1
X-Mimecast-MFC-AGG-ID: mF74B_IXOXm8kbF-BTtyfw_1746435717
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so22028415e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746435717; x=1747040517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yR6kVtS71Z7PVlx0saAzGxN64k/CZfIettgANMqxvOI=;
 b=HE0/Qt6ClUkletkqNV4mg18vv6RZ/wLRRZh2aOePnmv+OcudqTklt5334zedbckCxu
 +8ZwlI2XVhGfEBLu+96tAZ/d8XI+Co3fNW5snu5VE0ogNe8oDpCFHiDx4wCcobcOOpfV
 NWwpACEg+hA4nEdY4+bADjgiRPHEv0lZQW5CYl2n1E6d182/QGftn8r24XLNiNZBvbD/
 NBtK8gpwfXZ4n7+ZYVJqF8up8LYt+lCX0FVxUmSevv1scWg4rnJ1PvTxN+lXvdqj79FY
 lyQNSYTygVwxpikhhJ4c0e6hzbSgggPuf99dufWvWlrJgfw9u7gTvBvXMEhlAxSH1/L5
 wW/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV47F08LD/OKMA7VYqkTXUNpSgaQJ6SB5FLOkAxcCzbIKmweBa7T9vKIuqT2MaOd4wkcfJfKzSikoF4@nongnu.org
X-Gm-Message-State: AOJu0YxzPXW5sk1xgJXQ5b0Eh+lHQZWZRvRUT2bm7E6JaffO3UpnXMAW
 DZ4j1O+JiyVvESFimEuIAVYWv0Z5XcFzSMs7vBi0YGc0bHoygy0+JrbA0BNwVuLYSzQyq8UzECH
 R6M5Tg14Afz/xVWjauiijH5DCC9vf16SKvLng3CizkKSeyladST5f
X-Gm-Gg: ASbGncuTSyRqR1r2naErb4Uu1aL9j3cqk9dzh5yCbTbYGRgBhKmCOhOUr5o27gsanEf
 zMj2ZArg05qDdR5KnieYiJ8IYGDJj5ptU8oWb9umhcquOHky1aUnppsJsF4i4jTzBAbEe5gRvHB
 i0ftqo2vZrjnBaCycTo5sg4Hqf1IFViif5moDF2Ojik0TrQHx7RLXsyh806UwItsfl5hx0wpi9z
 0jQDLh1FE9fASa8pr0pd2/1ImHY7AWoW+MXb/bDKo2ECA0WE7DVWQsuufbqZ9ggL4Xf2GliMwcL
 8NjPSD9gHjW3XiWZKfrILuei98NiwfJhQgNsqEpeogVQzafM6wF5W+KEElY=
X-Received: by 2002:a05:6000:290a:b0:391:2f15:c1f4 with SMTP id
 ffacd0b85a97d-3a09fde6142mr5030961f8f.55.1746435716923; 
 Mon, 05 May 2025 02:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdyP/+1Np8HRjw6fLpv+ZlqrWpG/BMwt4tD1iFb2UGrMPVxrkixd2P6qf8aBzqIwPipQLCRQ==
X-Received: by 2002:a05:6000:290a:b0:391:2f15:c1f4 with SMTP id
 ffacd0b85a97d-3a09fde6142mr5030924f8f.55.1746435716452; 
 Mon, 05 May 2025 02:01:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7b45sm9586575f8f.46.2025.05.05.02.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:01:55 -0700 (PDT)
Message-ID: <fd53570b-7e2c-47db-9d31-93a9d2327f2f@redhat.com>
Date: Mon, 5 May 2025 11:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/arm/virt: Factor out common SMMUV3 dt bindings
 code
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-4-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250502102707.110516-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 5/2/25 12:27 PM, Shameer Kolothum wrote:
> No functional changes intended. This will be useful when we
> add support for user-creatable smmuv3 device.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt.c | 54 +++++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 25 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index dd355f4454..464e84ae67 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1418,19 +1418,43 @@ static void create_pcie_irq_map(const MachineState *ms,
>                             0x7           /* PCI irq */);
>  }
>  
> +static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
> +                                      hwaddr size, int irq)
> +{
> +    char *node;
> +    const char compat[] = "arm,smmu-v3";
> +    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
> +    MachineState *ms = MACHINE(vms);
> +
> +    node = g_strdup_printf("/smmuv3@%" PRIx64, base);
> +    qemu_fdt_add_subnode(ms->fdt, node);
> +    qemu_fdt_setprop(ms->fdt, node, "compatible", compat, sizeof(compat));
> +    qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
> +
> +    qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
> +            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
> +            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
> +            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
> +            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
> +
> +    qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
> +                     sizeof(irq_names));
> +
> +    qemu_fdt_setprop(ms->fdt, node, "dma-coherent", NULL, 0);
> +    qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
> +    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
> +    g_free(node);
> +}
> +
>  static void create_smmu(const VirtMachineState *vms,
>                          PCIBus *bus)
>  {
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> -    char *node;
> -    const char compat[] = "arm,smmu-v3";
>      int irq =  vms->irqmap[VIRT_SMMU];
>      int i;
>      hwaddr base = vms->memmap[VIRT_SMMU].base;
>      hwaddr size = vms->memmap[VIRT_SMMU].size;
> -    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
>      DeviceState *dev;
> -    MachineState *ms = MACHINE(vms);
>  
>      if (vms->iommu != VIRT_IOMMU_SMMUV3 || !vms->iommu_phandle) {
>          return;
> @@ -1449,27 +1473,7 @@ static void create_smmu(const VirtMachineState *vms,
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>                             qdev_get_gpio_in(vms->gic, irq + i));
>      }
> -
> -    node = g_strdup_printf("/smmuv3@%" PRIx64, base);
> -    qemu_fdt_add_subnode(ms->fdt, node);
> -    qemu_fdt_setprop(ms->fdt, node, "compatible", compat, sizeof(compat));
> -    qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
> -
> -    qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
> -            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
> -            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
> -            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
> -            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
> -
> -    qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
> -                     sizeof(irq_names));
> -
> -    qemu_fdt_setprop(ms->fdt, node, "dma-coherent", NULL, 0);
> -
> -    qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
> -
> -    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
> -    g_free(node);
> +    create_smmuv3_dt_bindings(vms, base, size, irq);
>  }
>  
>  static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
Reviewed-by: Eric Auger <eric.auger@redhat.com>

nothing to do with that patch but I just noticed we omitted to support the

bypass_iommu=true along with DT mode. I don't see the iommu-map property set accordingly.

Something to further consolidate?

Eric


Eric


