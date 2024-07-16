Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D54C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTh4k-0007md-Pu; Tue, 16 Jul 2024 08:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTh4i-0007lJ-Lg
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:14:32 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTh4g-0005AI-L8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:14:32 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c6661bca43so2601919eaf.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721132069; x=1721736869; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/Tggox4RdI7d6bUKw+7ERaVYQ6HLn2fdjceqxumTiU4=;
 b=lMMDXmwwgVRS+Ph3VikrfWCO3KL7+BmqNtCeGGtFm/Vk7YGajqOpSTXUhvbQS18Ka0
 K1AMBJwKPm/MLCt7ecFy2AxPKnTphRgiF6rqe7ILeiQcLIQV4H/55dtLpig1U0FRr9tG
 Ewb4BCHIuI7kT/KOT5DqxGajNenG8QHDqJcoHkEXfSzMuphECkbHuiYHlxZwj0CeJMzf
 y3aBuWrpFqR50wGUliydTkruAhf5MZVXERsFk0ghh/x05TCFqNVWgI8BIxRfcW5s9Pxt
 NA3InTl9OMZMqWUJZBOZu5DwWAvcbFXax/yghNCd+sFINxbTpmdWSdPP9PL1dxQMrxWd
 TXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721132069; x=1721736869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Tggox4RdI7d6bUKw+7ERaVYQ6HLn2fdjceqxumTiU4=;
 b=LmgQg6Xro0o+UGZsVwETo+jCSd6l7B6sxDCaiteBwkTJ62Nkd6Q9mnDR0p0xtHdTyp
 szQe6JRqOCR6NeBg7m8vmxK1sNXHh7SEOZNKGksRjRZhGdWrVt/2fEgFKpX7JCh6YTRf
 PcrYxWd19cLrcQTlV+78i9BlO9PO3bnwX8G/+C0Juqm/2rtphD1cRUFZ4abYrXkpUuqp
 51tKQCBgTTSHyidpg7H7kck55zS+L/1EvAXJJsKbNTsdkR6glkheyzzRN1oIwhpvSU1b
 mV5sKsgB9Xg2Pl0nfVu2Df1Bs3GH5/w7aKpBNNkJPb/pmeKE/PRXpVJhrAVRKcnn7fzU
 IKmQ==
X-Gm-Message-State: AOJu0Yyw5zkn4pC1e6GgJ4Jb3W4a1WTvdeM8wwIfSc5vWpCFNkKrZAvo
 i2xobJ7iPP9CvW4fbNzcqpCS1TKvkH+NCM1B40bLBZZqW0NPZYa37Te5GrMYrG8=
X-Google-Smtp-Source: AGHT+IHis4KoGb/Usco8bZ+NtZHbo8CjA+KH8V0mZ5wZqbLQ6limCjFW7xWmhotpk5DXCUY3x9SxjQ==
X-Received: by 2002:a05:6820:2714:b0:5c6:9320:53a3 with SMTP id
 006d021491bc7-5d28931fcaemr2481633eaf.4.1721132068911; 
 Tue, 16 Jul 2024 05:14:28 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ce757ab0ddsm1090819eaf.19.2024.07.16.05.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 05:14:28 -0700 (PDT)
Date: Tue, 16 Jul 2024 17:44:19 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 1/9] hw/riscv/virt-acpi-build.c: Add namespace devices
 for PLIC and APLIC
Message-ID: <ZpZkGz8mvJH8RstD@sunil-laptop>
References: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
 <20240715171129.1168896-2-sunilvl@ventanamicro.com>
 <20240716122405.3057913c@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716122405.3057913c@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Jul 16, 2024 at 12:24:05PM +0200, Igor Mammedov wrote:
> On Mon, 15 Jul 2024 22:41:21 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > As per the requirement ACPI_080 in the RISC-V Boot and Runtime Services
> > (BRS) specification [1],  PLIC and APLIC should be in namespace as well.
> > So, add them using the defined HID.
> > 
> > [1] - https://github.com/riscv-non-isa/riscv-brs/blob/main/acpi.adoc
> >       (commit : 241575b3189c5d9e60b5e55e78cf0443092713bf)
> 
> in spec links 'See RVI ACPI IDs' and right below it 'additional guidance',
> do lead nowhere hence do not clarify anything.
> 
Thanks Igor. I didn't realize links work only in the final PDF generated
from the sources. Let me point to the PDF itself where these
requirements were documented first.

Thanks,
Sunil
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> 
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> 
> > ---
> >  hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> > index 0925528160..5f5082a35b 100644
> > --- a/hw/riscv/virt-acpi-build.c
> > +++ b/hw/riscv/virt-acpi-build.c
> > @@ -141,6 +141,30 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
> >      }
> >  }
> >  
> > +static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
> > +                                     uint64_t mmio_base, uint64_t mmio_size,
> > +                                     const char *hid)
> > +{
> > +    uint64_t plic_aplic_addr;
> > +    uint32_t gsi_base;
> > +    uint8_t  socket;
> > +
> > +    for (socket = 0; socket < socket_count; socket++) {
> > +        plic_aplic_addr = mmio_base + mmio_size * socket;
> > +        gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> > +        Aml *dev = aml_device("IC%.02X", socket);
> > +        aml_append(dev, aml_name_decl("_HID", aml_string("%s", hid)));
> > +        aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> > +        aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
> > +
> > +        Aml *crs = aml_resource_template();
> > +        aml_append(crs, aml_memory32_fixed(plic_aplic_addr, mmio_size,
> > +                                           AML_READ_WRITE));
> > +        aml_append(dev, aml_name_decl("_CRS", crs));
> > +        aml_append(scope, dev);
> > +    }
> > +}
> > +
> >  static void
> >  acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
> >                      uint32_t uart_irq)
> > @@ -411,6 +435,14 @@ static void build_dsdt(GArray *table_data,
> >  
> >      socket_count = riscv_socket_count(ms);
> >  
> > +    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> > +        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_PLIC].base,
> > +                                 memmap[VIRT_PLIC].size, "RSCV0001");
> > +    } else {
> > +        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_APLIC_S].base,
> > +                                 memmap[VIRT_APLIC_S].size, "RSCV0002");
> > +    }
> > +
> >      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
> >  
> >      if (socket_count == 1) {
> 

