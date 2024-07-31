Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C20C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 16:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZCXU-0006RW-LP; Wed, 31 Jul 2024 12:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sZCXT-0006Qa-Le
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:50:59 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sZCXR-0003mL-ON
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:50:59 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52f04b3cb33so13263383e87.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722444656; x=1723049456; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Oxj6cKW3l7RyCCn1nkATs5t6W7LBzcT0OUZC+QA/TY8=;
 b=ZNmIYXbpp3ovBYHxcWeMKE+xUMeHhPMqHP7daouwmijgeqM9ipOgHcjW8bTwhKNDWp
 ezz+xIzJ3YUc3lxzztROxPSZxx75UeYs0T3bivG8EBg/q/zBJlOWMXsRJixgIWa6q7XR
 eKD374FIwvF0MzsmFHqX0jeq55124xbWa5ml152UdxwBqXh/YlB6ScACsbct0FudiMzu
 BCjD1tmtjJw/Zauspfjbwro1ftW1X3ztRw+BCbvh/u8ZEOreYz6OG32NIfTf8Oz21HVA
 /NtYkQlN6H9klwP2H4+HHybrzoKFWw0U+LNUVSWwe6DBMEGz9G/LuQQPfqBrb/3MPMrV
 Q2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722444656; x=1723049456;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oxj6cKW3l7RyCCn1nkATs5t6W7LBzcT0OUZC+QA/TY8=;
 b=SMor16v3xxgJs/6Ko9VabA3kPtj7WXzGntyDl6jlKOO82F5bnyuBGNQmHOhNRhNke2
 O65QXS7jw5ChvGFVCy3WFQ5kIKmJwQArN+FO+6J/7mZdgTd3YOx+/24p/0m5OJ3H+dRz
 jRNK6TeOJNg24IebRWFQcfQ+kulU786HQ6KCuYuf83RpINONFKz0DsaHvGX7ouKQHLYp
 OZ/m1i6eiuRUi0r9cAGZ0umSyiQ/Jz1A1elQ0xQUz0J8PoMQ5H4yxkEUPxxaVo6tVYsq
 DYEfs/ZhQDJDhIQfV/3xTY2Rh9TJclSKeXN15c1g7tzhI/J6+ixYI5oEqOU9gWgS/yn8
 EOVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIjswIHpXZRWxpHrQVbTApc7Gb426ERBM+CeLhVKooEK/F+1rQ5qwnAxW7dDJBCV4uHSmNq2l85dVbP1wznX6l+NSSVGA=
X-Gm-Message-State: AOJu0YyuvMtFmKLxaj3ydNtUJQCqYMLxP5n1494ZSpDV7WpJht99zFZW
 TmEe4/SKDe16jcaIJWGQxsfb5onEVeZ3QD09IbmuZW0uG6TxO6GOwX9fI0Fv7fg=
X-Google-Smtp-Source: AGHT+IHXFu30NQDQ2tNyjfzL5YnsV7w9ElawzOfW0q6h+Xpi3y3ErPJQ0RokcZPgqP4iuPwxVCnmpA==
X-Received: by 2002:a2e:3311:0:b0:2ef:2677:7b74 with SMTP id
 38308e7fff4ca-2f12ee62638mr128342691fa.41.1722444655297; 
 Wed, 31 Jul 2024 09:50:55 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4e161sm786153066b.65.2024.07.31.09.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 09:50:54 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:50:53 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, frank.chang@sifive.com, 
 tjeznach@rivosinc.com
Subject: Re: [PATCH v5 11/13] hw/riscv/riscv-iommu: Add another irq for mrif
 notifications
Message-ID: <20240731-30c03698cd1c889a4485e2b0@orel>
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
 <20240708173501.426225-12-dbarboza@ventanamicro.com>
 <8e54f48e-379b-42b8-8017-886ead154415@sifive.com>
 <49fe48d5-42d0-46fc-899e-50960941c3a2@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49fe48d5-42d0-46fc-899e-50960941c3a2@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=ajones@ventanamicro.com; helo=mail-lf1-x131.google.com
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

On Wed, Jul 31, 2024 at 01:27:09PM GMT, Daniel Henrique Barboza wrote:
> Hi Jason,
> 
> 
> On 7/23/24 12:25 PM, Jason Chien wrote:
> > Hi Daniel,
> > 
> > On 2024/7/9 上午 01:34, Daniel Henrique Barboza wrote:
> > > From: Andrew Jones <ajones@ventanamicro.com>
> > > 
> > > And add mrif notification trace.
> > > 
> > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > > ---
> > >   hw/riscv/riscv-iommu-pci.c | 2 +-
> > >   hw/riscv/riscv-iommu.c     | 1 +
> > >   hw/riscv/trace-events      | 1 +
> > >   3 files changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> > > index 7b82ce0645..d7e5f20885 100644
> > > --- a/hw/riscv/riscv-iommu-pci.c
> > > +++ b/hw/riscv/riscv-iommu-pci.c
> > > @@ -81,7 +81,7 @@ static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
> > >       pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
> > >                        PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
> > > -    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT,
> > > +    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT + 1,
> > The new interrupt is not marked as used with msix_vector_use().
> 
> I took at look at what this patch is actually doing and, at least in the MRIF setup
> I have, it's not doing much because we're not hitting the MRIF path inside the
> emulation. So we're not hitting the trace and this extra MSI isn't being used.
> 
> Drew is taking a look into it in the kernel side. Until we get a better idea on what's
> happening I'll remove this patch from the series. We can re-introduce it again later
> in this series or in the follow-up.

I recommend adding the trace to whatever patch introduces the MRIF path in
this series since we'll want the trace for testing regardless. If we need
another fix to this series for MRIFs then I'll post that separately on
top.

Thanks,
drew

