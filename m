Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5071CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 05:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS8Vr-0004lW-Lg; Fri, 12 Jul 2024 01:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sS8Vo-0004jT-Ae
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 01:08:04 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sS8Vm-0003dc-9O
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 01:08:03 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7044c085338so874364a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 22:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720760880; x=1721365680; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Eo4/pOks6x4YOrGtiNR/xb/yIFp9QPjvitzbZ9kpOnE=;
 b=eO6bYfT4RhIXKoN1HijXFdJPmEM/O9UEB88F3czxGVuq0XF9G9E3gkEoi7oE3k3uAV
 9PmXV/CoRCSgQ2C1soWd5bEADHaCSNYrNB1K+EON1AP2GAAFD8WyG3IbPp7UP/vdPl6a
 R+wlMH0llPXn0eyUr/YS/oEsWcixEQJGsekk1E/a2cgg7St6foyq0OKEnTc/r7+KAQBR
 K5rrqVM8zTP/OWvaH3KCgQekR/4Je1up7KiA0Qq6fkvF05OaPyjg3F1u+P2umfPT+pbn
 +MRti88xD4oSiAVnSiOTMDxXYaHFh8lfZSCb5+pdflAn3VsGBgdSdHsVxGjq5Af3180A
 TYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720760880; x=1721365680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eo4/pOks6x4YOrGtiNR/xb/yIFp9QPjvitzbZ9kpOnE=;
 b=LUvQRmCg81MLHD9boj/yHWBNzzHyeiqii57nbvJcMTjQq9/zvh9sNp4Pbg5z3uj54d
 n+N+NACz41pV3zcVRvjY5wQyzpGdJm0ffMpYwlQ0IjvhGgvuJurdz05qdMLenx1uqpCv
 ynxRIGzQDvmd/hSxqLfcFPo/BIwywCcbX27Am5Gdo4+rDDTu6xBB1InXhfmD0zUcwUTK
 ihRZb+TfICpSWaMOabSn0CN3xyWyCESFhaKQcfFC10on7HJZi33JI5PHpr3lKQNlCb15
 Li5yjR3mzcxJRM4XzniHGBx4XUWReBiiY0ZYAAuRgPgDyH3f1kOeqB0oY5va6z5j+ki1
 j+Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP6ftuNocqzBK0zxX3gYop3uy71l/QenrmdPpgwxwUYqChNUqWt6Zy/VZfXHfZzoscee02uNacbLTo4PbpwiH4pMuNhb8=
X-Gm-Message-State: AOJu0Yxgk7eMuzx57qV8VLkOOGeYTkL3Quae54wbbfyXRwCSuka8gwX+
 9jja4jUmDxW5jgZxmERQ0R98ijj7a39Mp9AIuJM/upkGLtGkybrb0LV7hAZ145o=
X-Google-Smtp-Source: AGHT+IGX4vcTfQwDxcMuBk7ymSma2CmbMcGrYntunCpwen144lsY3MZbV1WWXL7hh0vQvdNT+EAKIw==
X-Received: by 2002:a9d:748e:0:b0:703:fdda:fe2b with SMTP id
 46e09a7af769-703fddaffecmr11341618a34.11.1720760880414; 
 Thu, 11 Jul 2024 22:08:00 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70374f6e2e1sm1466772a34.13.2024.07.11.22.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 22:07:59 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:37:49 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 2/9] hw/riscv/virt-acpi-build.c: Update the HID of
 RISC-V UART
Message-ID: <ZpC6JWfv2FPxHwqn@sunil-laptop>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240708114741.3499585-3-sunilvl@ventanamicro.com>
 <20240711152512.5e2fac36@imammedo.users.ipa.redhat.com>
 <20240711104031-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711104031-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-ot1-x330.google.com
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

On Thu, Jul 11, 2024 at 10:41:35AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 11, 2024 at 03:25:12PM +0200, Igor Mammedov wrote:
> > On Mon,  8 Jul 2024 17:17:34 +0530
> > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > 
> > > The RISC-V BRS specification [1] requires NS16550 compatible UART to
> > > have the HID RSCV0003. So, update the HID for the UART.
> > > 
> > > [1] - https://github.com/riscv-non-isa/riscv-brs
> > 
> > it point's repo with a bunch of files,
> > please make it easier for reader to find
> > aka point to concrete document + title (for when link goes stale)
> > and chapter. (similar to what we do for when documenting ACPI code)
> > 
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  hw/riscv/virt-acpi-build.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> > > index 87fe882af0..939f951e45 100644
> > > --- a/hw/riscv/virt-acpi-build.c
> > > +++ b/hw/riscv/virt-acpi-build.c
> > > @@ -192,7 +192,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
> > >                      uint32_t uart_irq)
> > >  {
> > >      Aml *dev = aml_device("COM0");
> > > -    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
> > > +    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
> > >      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> 
> 
> In fact, adding the link to the document here would be best.
> Pls link to the earliest version that lists this id,
> cite version and chapter in the document.
> Thanks!
> 
Thanks Michael and Igor!. I will address your comments on the series and
send next version.

Thanks,
Sunil

