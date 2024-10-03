Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC05DCF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLw1-0003Gt-KB; Thu, 03 Oct 2024 09:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1swLvx-00031c-PG
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:31:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1swLvs-0006Np-Ss
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:31:57 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37cd5016d98so751594f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727962308; x=1728567108; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F9cOXpNhSmBifNEyV/bBsyxBMVGRUf/psW3BKjgVN30=;
 b=Oz1+mYa91cYyx4WqyrR2Ayc4ChITEm0Bw2eUeuQtqlTmKZ7xv8jE70JnyR0WCyDXbL
 5yhedo7jZ1KAqO+5dZysTZZ1m7MjQK2QnF2Hh6VrZKCImZQdinYzvDSCKA1XJFdkTPLW
 y1h7Ta1b89DhDnvezlaZMZHpcJEYSe5VxxFuVOoTk4eHMwThk14dd3DHvTKI2xVas426
 nLgXWmrLXvEcGrykYFAyHpyosTrfY93nnER7LP0xZj+XBDUjAxvcf1KA4TU/1patOayy
 hzPiTF5nuyAokDU4e9+elvd4Fyxp3uBvPjzDjC67UHuSHUXi3p1aZJeM3/ej5bDaq3hj
 CAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727962308; x=1728567108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9cOXpNhSmBifNEyV/bBsyxBMVGRUf/psW3BKjgVN30=;
 b=InfINo1F49IusKNTJLaauZn1+1InMahOn7MQKyLNo79B4BY5YL4UkKaLH9En8pODJm
 jxVK2Etmv4wcxHMIkpx+C56zG/dHIBF7hW1GojkZ4fiYjq9woxQjpJ01fsEC8+VH335A
 AKX+zAKhkNpu/qxEtx5u533LS0n+XIeGu99lTdN0k8CaIZy3Oj0PkoL3I9ARts+1yHAB
 jIK48DvQVtF55pXumLTX8mAMPYlFqQqNwI+QxRj0iBEcvmCQ9YRpU5sztnxdOOaHBY0T
 kRqdZBBG4HodD4ln8cQ6UihUMONGGFGmASndvWxfAQznTJExERI5QEDFBi/Uzm7bQIJ+
 Hnrw==
X-Gm-Message-State: AOJu0YyXTq6H9nLQVpvsln4+bYpFYTOPJJDDV+6E+VyZ7odx1pFXDJ14
 MXUA6Qf4dN9JMcOCcpONTZ9iOrbNFHANEsP6j6G0Izjrpt6/SXiBSwfsMBRV9R0=
X-Google-Smtp-Source: AGHT+IGJmAISL+dKwgLSNoTCm5TjYgEQYsuTea/TcfdXlz6huTi7P2+8RHZ3GwjvxHq7KKUij2mmxg==
X-Received: by 2002:adf:a791:0:b0:37c:ccdf:a2e3 with SMTP id
 ffacd0b85a97d-37cfb9d0f43mr3607978f8f.33.1727962307705; 
 Thu, 03 Oct 2024 06:31:47 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082e6f35sm1270467f8f.113.2024.10.03.06.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 06:31:47 -0700 (PDT)
Date: Thu, 3 Oct 2024 15:31:46 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, peter.maydell@linaro.org,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Sebastien Boeuf <seb@rivosinc.com>
Subject: Re: [PATCH v8 03/12] hw/riscv: add RISC-V IOMMU base emulation
Message-ID: <20241003-bd98395898af6d83eeef0be4@orel>
References: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
 <20241002010314.1928515-4-dbarboza@ventanamicro.com>
 <20241003-c10c27e0855533db764a1490@orel>
 <7c5f0fce-fc66-4fca-90be-aa2d4f7a4b04@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5f0fce-fc66-4fca-90be-aa2d4f7a4b04@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x432.google.com
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

On Thu, Oct 03, 2024 at 10:06:11AM GMT, Daniel Henrique Barboza wrote:
> 
> 
> On 10/3/24 6:26 AM, Andrew Jones wrote:
> > On Tue, Oct 01, 2024 at 10:02:58PM GMT, Daniel Henrique Barboza wrote:
> > ...
> > > +/*
> > > + * RISCV IOMMU Address Translation Lookup - Page Table Walk
> > > + *
> > > + * Note: Code is based on get_physical_address() from target/riscv/cpu_helper.c
> > > + * Both implementation can be merged into single helper function in future.
> > > + * Keeping them separate for now, as error reporting and flow specifics are
> > > + * sufficiently different for separate implementation.
> > > + *
> > > + * @s        : IOMMU Device State
> > > + * @ctx      : Translation context for device id and process address space id.
> > > + * @iotlb    : translation data: physical address and access mode.
> > > + * @return   : success or fault cause code.
> > > + */
> > > +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> > > +    IOMMUTLBEntry *iotlb)
> > > +{
> > > +    dma_addr_t addr, base;
> > > +    uint64_t satp, gatp, pte;
> > > +    bool en_s, en_g;
> > > +    struct {
> > > +        unsigned char step;
> > > +        unsigned char levels;
> > > +        unsigned char ptidxbits;
> > > +        unsigned char ptesize;
> > > +    } sc[2];
> > > +    /* Translation stage phase */
> > > +    enum {
> > > +        S_STAGE = 0,
> > > +        G_STAGE = 1,
> > > +    } pass;
> > > +    MemTxResult ret;
> > > +
> > > +    satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
> > > +    gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> > > +
> > > +    en_s = satp != RISCV_IOMMU_DC_FSC_MODE_BARE;
> > > +    en_g = gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
> > > +
> > > +    /*
> > > +     * Early check for MSI address match when IOVA == GPA. This check
> > > +     * is required to ensure MSI translation is applied in case
> > > +     * first-stage translation is set to BARE mode. In this case IOVA
> > > +     * provided is a valid GPA. Running translation through page walk
> > > +     * second stage translation will incorrectly try to translate GPA
> > > +     * to host physical page, likely hitting IOPF.
> > > +     */
> > 
> > Why was this comment expanded from the simple
> > 
> > "Early check for MSI address match when IOVA == GPA."
> > 
> > The comment is now incorrect since the check is required even when
> > first-stage translation is not BARE. I just skimmed the spec again trying
> > to figure out if the removal of '!en_s' is a hack or a fix, and I'm
> > inclined to say "fix", but it's an incomplete fix. I found a sentence that
> > says
> > 
> > "If the virtual memory scheme selected for first-stage is Bare but the
> > scheme for the second-stage is not Bare then the IOVA is a GPA."
> > 
> > which, in a way, defines a GPA to only be a GPA when second-stage is used
> > (and all MSI translation specifications refer to GPAs). However, maybe I
> > missed it, but I couldn't find any actual reason that the MSI table can't
> > be used when first-stage is not BARE and second-stage is (and, of course,
> > it makes no difference for single-stage translations to call IOVAs GPAs
> > or not).
> > 
> > Now, I also see
> > 
> > "If the virtual memory scheme selected for neither stage is Bare then the
> > IOVA is a VA. Two-stage address translation is in effect. The first-stage
> > translates the VA to a GPA and the second-stage translates the GPA to a
> > SPA."
> > 
> > in the spec, which means we should probably change the removal of '!en_s'
> > to '!(en_s && en_g)'. VFIO+irqbypass would still work with that and, when
> > Linux learns to support two-stage translation, we wouldn't incorrectly try
> > to check for a GVA in the MSI table.
> 
> Ok. It seems to me that we can't rely on the riscv-iommu spec alone to let
> us know how to detect if IOVA == GPA, given that one of the main usages
> we have ATM (VFIO irqbypass) will use GPAs with S-stage enabled.
> 
> (Note: shouldn't we open a bug against the riscv-iommu spec?)
> 

I can try writing a sentence or two for the spec to clarify this and send
a PR.

> I like the idea of ruling out the case where IOVA == VA since that is clear
> in the spec. We also know that MSI entries will always contains GPAs.
> 
> This is the change I'm going to make in v9:
> 
> 
>     /*
>      * Early check for MSI address match when IOVA == GPA to
>      * support VFIO+irqbypass. The riscv-iommu spec doesn't
>      * consider the case where a GPA can be produced by S-stage
>      * only, but we have real life examples like Linux VFIO that
>      * work that way. The spec alone does not provide a reliable
>      * way of detecting if IOVA == GPA.
>      *
>      * The spec is clear about what is a VA: "If the virtual
>      * memory scheme selected for neither stage is Bare then
>      * the IOVA is a VA", in our case "(en_s && en_g)". We also
>      * know that MSI tables will always hold GPAs.
>      *
>      * Thus the check consists of ruling out VAs and checking
>      * the MSI table.
>      */
>     if (!(en_s && en_g) && (iotlb->perm & IOMMU_WO) &&
>         riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
>         iotlb->target_as = &s->trap_as;
>         iotlb->translated_addr = iotlb->iova;
>         iotlb->addr_mask = ~TARGET_PAGE_MASK;
>         return 0;
>     }

LGTM

Thanks,
drew

> 
> Tomasz, let me know if you have any opinions against it. I intend to send
> the v9 start of next week.
> 
> 
> Thanks,
> 
> 
> Daniel
> 
> 
> > 
> > Thanks,
> > drew

