Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678FDC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfLy-0007OX-Qk; Tue, 16 Jul 2024 06:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTfLx-0007Mo-1m
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTfLv-0007kQ-EN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721125450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MECowqKNmSio+n3bwGcGZF3wa2ua5sJbjpih13BVxIE=;
 b=WBeVcZwc09BThk5xAR9D1eYXJNDZTynTFBJhp4BOSbCx0qxL2VFZj2eaAJrdnJuTEo+nqx
 nO4xFnWjlxPEV8p2/m8j5qd0Ya1EVnVtZOxspyoOvwY65lJTNuDsQXVgefKdTgB27A55Yc
 LnGbYTtPewDCZbtjCYgcH6iB9/yLkDU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-p54o1-YcO823JNj63D-ntA-1; Tue, 16 Jul 2024 06:24:08 -0400
X-MC-Unique: p54o1-YcO823JNj63D-ntA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4265d3bf59dso39232205e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721125448; x=1721730248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MECowqKNmSio+n3bwGcGZF3wa2ua5sJbjpih13BVxIE=;
 b=sR6x8DWCRtf9tySEOa0WEtgemJZmzMCeDEZKS+XoMW4kfJF9VORObl4r+O4am7r/OM
 /EvjA0Y2MLI/FbHbr4YSBVCBEWGRvF4WQOJVVMKkNc41JM3ariwd/wUoe9p21y1Uj0FP
 37KFt4DAH+hwfCIgGxpW4MbzNkLF+PPmlDrRGAjyYFaqWmpcHMFKfa6IbEQ0HT6ezFeY
 WitKy97NX3IGcfKg8SpNchSBTiAIuKZMcspFXErzUldJZIpwA1AYbjBj1ERcvfervD7B
 pAaucJ2JPFPAb6yGpDbiNvdZ/HcWxoEuCOJtTr43zu1iFKudZSFzAqz4a1AwEgp7SA2+
 VJzg==
X-Gm-Message-State: AOJu0YzFPfHGjSzW5MeD/Lz1I22qPTtYbU+Sm5TH7HH94CIdKiBcNTmB
 b6xC3pVUybJ87vq6BO3kZJXfkFTcj+g/sJEN7s9R5y6EbahkKpvZUb8I9CoPRwsCAKMXcNP3lvg
 NmLFhP1QwuE/eXDjIloS1/6vdzvUtNaeEst4P9ri8SWPnf4pNF/PK
X-Received: by 2002:a05:600c:46cb:b0:426:6b85:bafb with SMTP id
 5b1f17b1804b1-427ba6489efmr11993645e9.20.1721125447797; 
 Tue, 16 Jul 2024 03:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmMuIO3XUMESFWrPxEwOTl2nHOpuu/lZec59HfRvW3ZTnOVAR/CE5wfSufWcU2VyDgUh5HBw==
X-Received: by 2002:a05:600c:46cb:b0:426:6b85:bafb with SMTP id
 5b1f17b1804b1-427ba6489efmr11993485e9.20.1721125447460; 
 Tue, 16 Jul 2024 03:24:07 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f23a000sm155383875e9.5.2024.07.16.03.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 03:24:07 -0700 (PDT)
Date: Tue, 16 Jul 2024 12:24:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 1/9] hw/riscv/virt-acpi-build.c: Add namespace
 devices for PLIC and APLIC
Message-ID: <20240716122405.3057913c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240715171129.1168896-2-sunilvl@ventanamicro.com>
References: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
 <20240715171129.1168896-2-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 15 Jul 2024 22:41:21 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> As per the requirement ACPI_080 in the RISC-V Boot and Runtime Services
> (BRS) specification [1],  PLIC and APLIC should be in namespace as well.
> So, add them using the defined HID.
> 
> [1] - https://github.com/riscv-non-isa/riscv-brs/blob/main/acpi.adoc
>       (commit : 241575b3189c5d9e60b5e55e78cf0443092713bf)

in spec links 'See RVI ACPI IDs' and right below it 'additional guidance',
do lead nowhere hence do not clarify anything.

> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 0925528160..5f5082a35b 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -141,6 +141,30 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
>      }
>  }
>  
> +static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
> +                                     uint64_t mmio_base, uint64_t mmio_size,
> +                                     const char *hid)
> +{
> +    uint64_t plic_aplic_addr;
> +    uint32_t gsi_base;
> +    uint8_t  socket;
> +
> +    for (socket = 0; socket < socket_count; socket++) {
> +        plic_aplic_addr = mmio_base + mmio_size * socket;
> +        gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +        Aml *dev = aml_device("IC%.02X", socket);
> +        aml_append(dev, aml_name_decl("_HID", aml_string("%s", hid)));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> +        aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
> +
> +        Aml *crs = aml_resource_template();
> +        aml_append(crs, aml_memory32_fixed(plic_aplic_addr, mmio_size,
> +                                           AML_READ_WRITE));
> +        aml_append(dev, aml_name_decl("_CRS", crs));
> +        aml_append(scope, dev);
> +    }
> +}
> +
>  static void
>  acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>                      uint32_t uart_irq)
> @@ -411,6 +435,14 @@ static void build_dsdt(GArray *table_data,
>  
>      socket_count = riscv_socket_count(ms);
>  
> +    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> +        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_PLIC].base,
> +                                 memmap[VIRT_PLIC].size, "RSCV0001");
> +    } else {
> +        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_APLIC_S].base,
> +                                 memmap[VIRT_APLIC_S].size, "RSCV0002");
> +    }
> +
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
>  
>      if (socket_count == 1) {


