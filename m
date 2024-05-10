Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E114BC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 11:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5OCg-0000T6-Ta; Fri, 10 May 2024 07:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s5OCc-0000SS-Ur
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:14:15 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s5OCb-0008Oo-Af
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:14:14 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34c8592b8dbso1475596f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715339648; x=1715944448; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dj0fmvl2LzirKBq021Nrm9lmZvGCZXXeaLvowAXwpGM=;
 b=UucsMOGiu+lqtAbFF1+u0bXjs3Xa5wWsU0KKPKpKQMmgp33T0XHSfNb5CEUvJYj20O
 ALLCGCIG/l/oj7065rZq7oZfTglmaH5FB2pMuHsdn94LRzf0CpbkV+dAk+dhXfP/tWFP
 O7e8TFIkjib1EWc9V6OxY4QjQQmfqGbqeVEu5boE63p3KdbGwtDogTGYREJ6Vf4QSEfw
 lp/1bNFz4ZS1RvfTAroM+J+KUOJdwHC8qbkzdvS2g+O+HkEsWCnpWfbZmlwa0wLGvAfl
 t3OsiHhmjmdfQtp2zdOux8wlnCA2OmG+xyWMrarxdivwbe2pCX+GaplJRTWo2XSer4VY
 kj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715339648; x=1715944448;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dj0fmvl2LzirKBq021Nrm9lmZvGCZXXeaLvowAXwpGM=;
 b=MbHXD1RxJGXw0dj9bdLSkXhBi2o/lgLxkFoMZ122QtjUY7tvAoQOkypkp98g+qTRPX
 cuh5Kfd0JpJUbo9HdaJiRZbGEC+lxko16YDOZmh/cbQz4iV7A4GGTLLDtRsgdNaf8ehA
 06QXC9GlRIYzfjlCcJseOmuZ7Po4GY0kKe0Z1Q/b5cTL4sMsdSh3gHCfd3led5BEhN82
 boeElu89kim8XY/FY4asLg1PGH8oNFQeT/bXQbs0W1bKkAh7OA3onHrj0HS3kTSIb+Pp
 1Y13gLSqDLbvEwY8hMp15VNaX8Xt3p42/HPgp7tIxUkqbwDuiCZbJ2VTkddegGZXlF+6
 zCVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiuqeW6oREnRPdgePGRx+gcL8AbHDQLew8OD4glS0HYv4jRSu604UM9imSLbL2UufVUlOXtRUzC3suWXa9dZJkMZGL1xo=
X-Gm-Message-State: AOJu0YwqGtip3NswHTigEfFu63Git7v0DvmTnWRMtIk+GERbjGjkspd1
 e8r4uavNzhRjjaehvPT7gG83Sdticr9tQpDh2cuC9v7fBUpnNVSLhwNrGperjzI=
X-Google-Smtp-Source: AGHT+IFyfpwkSvmlK2Wrx7k+b/Y0Bx9kiqbt4sTzwCPA74LKXLwa5dEUix5etxTCu4eNlUOtd7vVNA==
X-Received: by 2002:adf:f287:0:b0:34d:87bc:e79c with SMTP id
 ffacd0b85a97d-3504a633178mr1966771f8f.6.1715339648443; 
 Fri, 10 May 2024 04:14:08 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacff4sm4295163f8f.79.2024.05.10.04.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 04:14:08 -0700 (PDT)
Date: Fri, 10 May 2024 13:14:06 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Frank Chang <frank.chang@sifive.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, tjeznach@rivosinc.com
Subject: Re: [PATCH v2 09/15] hw/riscv/riscv-iommu: add s-stage and g-stage
 support
Message-ID: <20240510-dbedfaea5903daa73f461e2b@orel>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-10-dbarboza@ventanamicro.com>
 <CANzO1D1Rk6S9RKqVkuFoHrK4tswvr61z0584s+unokcmRdmiog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANzO1D1Rk6S9RKqVkuFoHrK4tswvr61z0584s+unokcmRdmiog@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 10, 2024 at 06:36:51PM GMT, Frank Chang wrote:
...
> >  static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> > -    IOMMUTLBEntry *iotlb)
> > +    IOMMUTLBEntry *iotlb, bool gpa)
> >  {
> > +    dma_addr_t addr, base;
> > +    uint64_t satp, gatp, pte;
> > +    bool en_s, en_g;
> > +    struct {
> > +        unsigned char step;
> > +        unsigned char levels;
> > +        unsigned char ptidxbits;
> > +        unsigned char ptesize;
> > +    } sc[2];
> > +    /* Translation stage phase */
> > +    enum {
> > +        S_STAGE = 0,
> > +        G_STAGE = 1,
> > +    } pass;
> > +
> > +    satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
> > +    gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> > +
> > +    en_s = satp != RISCV_IOMMU_DC_FSC_MODE_BARE && !gpa;
> > +    en_g = gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
> > +
> >      /* Early check for MSI address match when IOVA == GPA */
> > -    if (iotlb->perm & IOMMU_WO &&
> > +    if (!en_s && (iotlb->perm & IOMMU_WO) &&
> 
> I'm wondering do we need to check "en_s" for MSI writes?
> 
> IOMMU spec Section 2.3.3. Process to translate addresses of MSIs says:
> "Determine if the address A is an access to a virtual interrupt file
> as specified in Section 2.1.3.6."
> 
> and Section 2.1.3.6 says:
> 
> "An incoming memory access made by a device is recognized as
> an access to a virtual interrupt file if the destination guest physical page
> matches the supplied address pattern in all bit positions that are zeros
> in the supplied address mask. In detail, a memory access to
> guest physical address A is recognized as an access to a virtual
> interrupt file’s
> memory-mapped page if:
> (A >> 12) & ~msi_addr_mask = (msi_addr_pattern & ~msi_addr_mask)"
> 
> Is checking the address pattern sufficient enough to determine
> the address is an MSI to a virtual interrupt file?
>

I think so. In fact, I've removed that en_s check on our internal build in
order to get things working for my irqbypass work, as we can do device
assignment with VFIO with only S-stage enabled.

Thanks,
drew

