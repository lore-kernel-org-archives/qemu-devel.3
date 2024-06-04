Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82560C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 23:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEdHU-000141-Po; Tue, 04 Jun 2024 19:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdHS-00013h-Da; Tue, 04 Jun 2024 19:09:26 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdHQ-0003Jz-BD; Tue, 04 Jun 2024 19:09:26 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57a677d3d79so557287a12.1; 
 Tue, 04 Jun 2024 16:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717542562; x=1718147362; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khhHDbkr9jnGUfgdHG000CJi2KQFxKz1Q2IzqMtO9o8=;
 b=lLo8DrZk0PYrBb9WGQzhM1a5x7/7nWPeltRon0apkNRCEy8JK7YaPnpatiwzUIyuyt
 HwbHKgUwXGnY4bwJzyv0MN6oK7WrPc+Mdu4P+2uf3AXn1Ry0rgdTV7pRvoo2ef9seU68
 NQ4b8R5QI5DFTlWEMQouTaGNADT//BN8JNbOF3mFwzD5upI3640Q9y1Bt49TvsNiWx6F
 EscaE8qGjZsyJCf4wc9bi/hCSFqADHhOaxphExBD29Iwv/saDGcNMIwCD5ZHiw4gL4cD
 o/3tXuh+GkdoS0N+sufNvReGdTtGBD2EI19LH6dO/uhNiIL4s+ZhRtPjjDDVYsIgufuL
 68pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717542562; x=1718147362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khhHDbkr9jnGUfgdHG000CJi2KQFxKz1Q2IzqMtO9o8=;
 b=Ro5GzvIpaQ/j0m5S8xVFJmjZSwUZ7QufU7ZeWsaIJ9JgxeQO0ycPcSsxcMMtMg9Gxz
 AgxIrQDIUunDHADHiOo2OdK29VzpyVNpb0FnSrNoRhBgFLWxBP85qU82bXFIzHVm7ltu
 gvlUnqKPx3ALM9Dm6V4l4NNbrIa8BxLB6CuI4pbZLILWLi4naU3E0lZoOcv4IdNG+BvI
 XyhLHYPcHSlesK6oISB2VcUBoBMVNaD8b9qoRjYT7/op1oQXFrzzJ6zkAiQrBMOjew3E
 w5HPpFtrbZhoOnIgmf7f/t5zOeUblmHSR/hJNmXlO/PP1e+b7gWBIfmTtArJbHSiB+Ws
 q/fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMyXjndTyFgv9HavzIrD8aKwbfyU3eTY/TGKqrXQxPUomkhn/qpttM6PAz++Nl2g6r2uajEf58UCzRzrAFfCNLEGUVKQo=
X-Gm-Message-State: AOJu0YyLBs7XEL9H0chdoWTFlfW/0rrCNId1sG/hZ9MfjaIWZM78MtBF
 3w0Dg8ls2XVe+gApS8JTCbxvjq1VOTldraBJaApy5LBPoHGZg9g7tR0Y0b5gplGq360dNSCxVyq
 SINFDaUotqc/5C/1zaQkMp8yqp2I=
X-Google-Smtp-Source: AGHT+IHffY3fTSX+GpXoB7kJz3BhfnRCsZrDWF9IzakPs1xsGbpbdRcVkA71Bz5JLo7uvAMTo032HC49PUyKbf8CVDk=
X-Received: by 2002:a50:c055:0:b0:573:1e9e:2d71 with SMTP id
 4fb4d7f45d1cf-57a8bccb3b9mr697786a12.19.1717542561775; Tue, 04 Jun 2024
 16:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240528073103.1075812-1-sunilvl@ventanamicro.com>
 <20240528073103.1075812-3-sunilvl@ventanamicro.com>
In-Reply-To: <20240528073103.1075812-3-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 09:08:53 +1000
Message-ID: <CAKmqyKOsm9BLdzUw_vG4Uc5OqO=dA9zVyuKj7ZAknb750kukXw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/riscv/virt-acpi-build.c: Add namespace devices for
 PLIC and APLIC
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 28, 2024 at 5:32=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> PLIC and APLIC should be in namespace as well. So, add them using the
> defined HID.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt-acpi-build.c | 47 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 832a3acb8d..47ec78e432 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -141,6 +141,52 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirt=
State *s)
>      }
>  }
>
> +static void acpi_dsdt_add_plic_aplic(Aml *scope, RISCVVirtState *s)
> +{
> +    MachineState *ms =3D MACHINE(s);
> +    uint64_t plic_aplic_addr;
> +    uint32_t gsi_base;
> +    uint8_t  socket;
> +
> +    if (s->aia_type =3D=3D VIRT_AIA_TYPE_NONE) {
> +        /* PLICs */
> +        for (socket =3D 0; socket < riscv_socket_count(ms); socket++) {
> +            plic_aplic_addr =3D s->memmap[VIRT_PLIC].base +
> +                         s->memmap[VIRT_PLIC].size * socket;
> +            gsi_base =3D VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            Aml *dev =3D aml_device("IC%.02X", socket);
> +            aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0001")=
));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> +            aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
> +
> +            Aml *crs =3D aml_resource_template();
> +            aml_append(crs, aml_memory32_fixed(plic_aplic_addr,
> +                                               s->memmap[VIRT_PLIC].size=
,
> +                                               AML_READ_WRITE));
> +            aml_append(dev, aml_name_decl("_CRS", crs));
> +            aml_append(scope, dev);
> +        }
> +    } else {
> +        /* APLICs */
> +        for (socket =3D 0; socket < riscv_socket_count(ms); socket++) {
> +            plic_aplic_addr =3D s->memmap[VIRT_APLIC_S].base +
> +                             s->memmap[VIRT_APLIC_S].size * socket;
> +            gsi_base =3D VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            Aml *dev =3D aml_device("IC%.02X", socket);
> +            aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0002")=
));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> +            aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
> +
> +            Aml *crs =3D aml_resource_template();
> +            aml_append(crs, aml_memory32_fixed(plic_aplic_addr,
> +                                               s->memmap[VIRT_APLIC_S].s=
ize,
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
>      socket_count =3D riscv_socket_count(ms);
>
> +    acpi_dsdt_add_plic_aplic(scope, s);
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
>
>      if (socket_count =3D=3D 1) {
> --
> 2.40.1
>
>

