Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4458C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtfc-0002QP-AV; Thu, 11 Jul 2024 09:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRtfa-0002KE-Gm
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRtfX-00052w-Hi
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720703825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qR7+dq4RntKn/Wt+dvu7fOma5iUOEeYDbWxxMKTjZcM=;
 b=iDs4U+UwYgjSV21VehvPcb+pP706X6IhyQ1NHRmDFaFkvfYqqR/Wlf9xTBdm6aW3VLomrY
 LB/bIUw1DolQHlWqnhq+CVWesET6WUpT92lcoJIXhlKrjTpPxsL5yagqVMW1Z6aWLiYQv3
 4IVP0Hr7ty+h2UQNyQY7c+11n4XNwmc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-aI1aZSjBOuuJSnk-jGwUlQ-1; Thu, 11 Jul 2024 09:17:04 -0400
X-MC-Unique: aI1aZSjBOuuJSnk-jGwUlQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ee97349a5fso8637291fa.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703822; x=1721308622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qR7+dq4RntKn/Wt+dvu7fOma5iUOEeYDbWxxMKTjZcM=;
 b=WZnPWbyrjjoD35nQ6XUz1rtzr8HG6GIU5wOQQ66Gg7C1lehWfq7JpHYrGNlQ7L+m8n
 pDvjjDxklayT1yph6lX4R+gE3LJ5i3TmGlzjQSslB0CFqraEKdrxGuiR2we8IFNDr2Fa
 WpP8yLM/DrBcR5+Ysj4cY8kErsOdEXftkFJLis70ushqTqJF4VaI0gDUX31wlLjgDQ8h
 TL7kIw/UXVkYURLBgU93JxNkGbHCi1wf8hS4sOgLFajVAaa/TMFwuxCU8E/0cFFMSmQ4
 6LXwearF8c0AeZLpnj6UZxZYSkRaFUG+dyWGp9gi8a982wBEyqlOLshWUDfyary/Tue6
 phfA==
X-Gm-Message-State: AOJu0YwX8KMrWGJDK6gQhV29XXLT+ZnWBFNhQZq1Nsnw0xx4++LbKXF/
 yCF/KHlX2SOf+5MlqO1bh+M/OtrwARC8RdCxPJiC3D5edQM7aXrc+i0KxB9ioHncYw155gjqvFk
 gqNT9I7dGuKPaIvDmSRHSsplzJ8ygeFlgwIsT1q4Zvy0f7MUZs6/nbBCQW8nn
X-Received: by 2002:a2e:a582:0:b0:2ec:5964:9c0d with SMTP id
 38308e7fff4ca-2eeb304bbdamr78774571fa.0.1720703822457; 
 Thu, 11 Jul 2024 06:17:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZKV/YliEzyWRXDvSMj1CZz9/z/mPUW/fFJRQErRT9XG89dYK83lCtvqWHB/CgHTCrzmnfyw==
X-Received: by 2002:a2e:a582:0:b0:2ec:5964:9c0d with SMTP id
 38308e7fff4ca-2eeb304bbdamr78774301fa.0.1720703822045; 
 Thu, 11 Jul 2024 06:17:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42797100f55sm46398045e9.1.2024.07.11.06.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:17:01 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:17:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 1/9] hw/riscv/virt-acpi-build.c: Add namespace
 devices for PLIC and APLIC
Message-ID: <20240711151700.59f32bb3@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240708114741.3499585-2-sunilvl@ventanamicro.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240708114741.3499585-2-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon,  8 Jul 2024 17:17:33 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> PLIC and APLIC should be in namespace as well. So, add them using the
> defined HID.

defined where? REader shouldn't be forced to go over all web to find
source. Cite it here.

> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt-acpi-build.c | 47 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 0925528160..87fe882af0 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -141,6 +141,52 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
>      }
>  }
>  
> +static void acpi_dsdt_add_plic_aplic(Aml *scope, RISCVVirtState *s)
> +{
> +    MachineState *ms = MACHINE(s);
> +    uint64_t plic_aplic_addr;
> +    uint32_t gsi_base;
> +    uint8_t  socket;
> +
> +    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> +        /* PLICs */
> +        for (socket = 0; socket < riscv_socket_count(ms); socket++) {
> +            plic_aplic_addr = s->memmap[VIRT_PLIC].base +
> +                         s->memmap[VIRT_PLIC].size * socket;
> +            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            Aml *dev = aml_device("IC%.02X", socket);
> +            aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0001")));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> +            aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
> +
> +            Aml *crs = aml_resource_template();
> +            aml_append(crs, aml_memory32_fixed(plic_aplic_addr,
> +                                               s->memmap[VIRT_PLIC].size,
> +                                               AML_READ_WRITE));
> +            aml_append(dev, aml_name_decl("_CRS", crs));
> +            aml_append(scope, dev);
> +        }
> +    } else {
> +        /* APLICs */
> +        for (socket = 0; socket < riscv_socket_count(ms); socket++) {
> +            plic_aplic_addr = s->memmap[VIRT_APLIC_S].base +
> +                             s->memmap[VIRT_APLIC_S].size * socket;
> +            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            Aml *dev = aml_device("IC%.02X", socket);
> +            aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0002")));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> +            aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
> +
> +            Aml *crs = aml_resource_template();
> +            aml_append(crs, aml_memory32_fixed(plic_aplic_addr,
> +                                               s->memmap[VIRT_APLIC_S].size,
> +                                               AML_READ_WRITE));
> +            aml_append(dev, aml_name_decl("_CRS", crs));
> +            aml_append(scope, dev);
> +        }
> +    }
> +}
> +
>  static void
>  acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>                      uint32_t uart_irq)
> @@ -411,6 +457,7 @@ static void build_dsdt(GArray *table_data,
>  
>      socket_count = riscv_socket_count(ms);
>  
> +    acpi_dsdt_add_plic_aplic(scope, s);
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
>  
>      if (socket_count == 1) {


