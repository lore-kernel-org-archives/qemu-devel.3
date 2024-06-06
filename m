Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B8BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9ky-0006rx-Vc; Thu, 06 Jun 2024 05:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sF9kx-0006rD-0G
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:50:03 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sF9kv-0001HC-4z
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:50:02 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d1d08c7c8aso383380b6e.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717667400; x=1718272200; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ge740h9oTGUFV/3fywNl79mB256gm21GieHK+4LxWNQ=;
 b=b/nEAMVmDJqErN8+ZDvx3dWT5bZKzmUhdynVfEXGHMjFueiPRtWbODrOWBkvr/LrJc
 tpctv0/GxXGXvz7jKGaKSANTbMZFLftovWbSt1GBmi1qHfUdBZu8YeMvRkXcfKcw5u9K
 ODWG8J15K8tL+x/iEkOjEgHfUErwMzXrBlnVroVhML+TmnqXz+Yc59q06IdzXEJYpjRr
 JGR/F9n+puOtCJGxOaqN0pSN3jSg3gGgRrdRDs37l2AwYx+EamQzQRVKpl322jPFbOZT
 TK0pae0apbriND9cOUEBngrZmGlTEFHFgxv0dSrK56hueZFFVFQBhXzvDbjOy3pDAv3N
 NTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717667400; x=1718272200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ge740h9oTGUFV/3fywNl79mB256gm21GieHK+4LxWNQ=;
 b=FCb2UIVrbBHuOariJb/Qe+96FUKuVZdxuWT91Pux43724oHoRgfauymaCLmeVJNm2N
 n8/xjttGeuB7KqFIXYsK+G7ESaMBj+4aZy6H30WG88KJaoY/j/9Xlg+L2ga5osflPPbr
 tgGYnA3dFJziPv8WBSgcKMCd6zGjRUBWQqFj8OnAPEHe+KoJ3Tz5blKJCkWdkI5RT6P1
 F8tEH00Z0N7Pn/qA0rEXn4bkYjJ4G7cDoSKshsVBpjWI0E/MVdjj5MEvnh+bB4hbIU8e
 cd4soPj8cr4WQE6wa2/dXH7lc+eh01MFgl0+wKvAsCOzWx9AAVSmDwUoTNS187pIBy3o
 N2Ig==
X-Gm-Message-State: AOJu0YzZIKqdsRvcEOqFizwT00J31AZ+KVU+u92TfkagToSbwlbAV4wO
 P4BizzqvAmzddPg1DpR6ut/gHwgT5VerLE4QDJhWUXo5I8HXbrHCdRQyp7gPjOo=
X-Google-Smtp-Source: AGHT+IGvu0dhZRDs/XKdQUCEGrq9ZmI6aDvtOe0H15pAp/7uNjDkxqksA9vJHdK0qeAN3XGTQuM+uQ==
X-Received: by 2002:a05:6870:2481:b0:24f:dbdb:6009 with SMTP id
 586e51a60fabf-25121ed2a52mr5432028fac.32.1717667399647; 
 Thu, 06 Jun 2024 02:49:59 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd500c6asm809905b3a.172.2024.06.06.02.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:49:59 -0700 (PDT)
Date: Thu, 6 Jun 2024 15:19:52 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH 3/3] hw/riscv/virt-acpi-build.c: Update the HID of RISC-V
 UART
Message-ID: <ZmGGQNA7NPAV06Mt@sunil-laptop>
References: <20240528073103.1075812-1-sunilvl@ventanamicro.com>
 <20240528073103.1075812-4-sunilvl@ventanamicro.com>
 <20240605164814.0d79ef99@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605164814.0d79ef99@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Igor,
On Wed, Jun 05, 2024 at 04:48:14PM +0200, Igor Mammedov wrote:
> On Tue, 28 May 2024 13:01:03 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > RISC-V is going to use new HID RSCV0003 for generi UART. So, update the
> > HID.
> 
> where does it come from?
> 
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  hw/riscv/virt-acpi-build.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> > index 47ec78e432..7f80368415 100644
> > --- a/hw/riscv/virt-acpi-build.c
> > +++ b/hw/riscv/virt-acpi-build.c
> > @@ -192,7 +192,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
> >                      uint32_t uart_irq)
> >  {
> >      Aml *dev = aml_device("COM0");
> > -    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
> > +    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
> 
> the only place I've found (that could serve as justification)
>   https://github.com/riscv-non-isa/riscv-brs/blame/main/acpi.adoc
> 
> which mentions _CID and not _HID as it is in this patch
> 
Right, this is the requirement.

Yes, _CID says device is compatible. But different vendors may have
different _HID. For qemu, _CID value is used as _HID since it is not
vendor specific. This is something similar to how ARMH0011 is used (qemu
vs RPi) in ARM world.

I am checking with Andrei to see if we can relax to make it either _HID
or _CID.

Thanks,
Sunil


