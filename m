Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAFE606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qWfugJm5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRBEJ-0005kJ-I9; Wed, 11 Nov 2026 11:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xRBEH-0005iD-9D
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:31:21 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xRBEF-0006Vp-3R
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:31:20 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so2258101f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 08:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794414676; x=1795019476; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WMnclwZe90oplSv6x1hSoXpkZmkX6ayWatS21n0+tc8=;
 b=qWfugJm5mwGO5n5eu4ABfxuA4XwkUPvvbp/+G1GKUbt6VsU0ZOc/hr3L0aZrqN2csh
 I5hPAPKv220jMaRMPfy2lsCA98sBvvxd0nB7MHHNJ4vlhNbhuLkGY45jmpH+k8+6ID/z
 +wN+Ii+xXq2S/dw9UlPdduWH2SMYvTk7aNbbKoEn3mXTmFBLx5MkJsd+G+OC7GCLy2pv
 1wasjXIdeuTfJAQUz2T1FeQpyQcoOSjyAvb7sUASxXEkmdXf0g8pQ8BfY+H4UQUzSB4R
 bIZlgpOgIbP605o2D/01jgfscsxn/DPhv2PjSZ0NxVKackhNl3Voy/SeGCTlTYC2Mqoy
 AYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794414676; x=1795019476;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WMnclwZe90oplSv6x1hSoXpkZmkX6ayWatS21n0+tc8=;
 b=UZrrBR8SM6FW54Q9hVouhVmD7PNOhZpH/yMiE+RhseJoCOiOzZHukPJElIOI7kqVnS
 zuhtLSl7cPkDCnhr0DZA98Z7Lqcxcw4SVNUXWPGp6X8kobyBWrsJQS9GJM6qhsaZzg/m
 7aQu2mN9uKaXE7xu73jIRclPEu2eS0hSl3jqBEemElGHPIF/J5iVW0FTFr7fR3Y/+LKr
 F5AW+KcTWKQciLQBcFKhn7aEqAtrSISEqngXPKGraeiSg7KWCxV4GFbMJwXdtb7VfUir
 tOXFBKjzFpv02dn7ClL1z8PwbQnjV4v64WUv6p6IL5vN1RCSVBMGgFZVs11NGfH09L9Q
 8Cmw==
X-Gm-Message-State: APuU4Z9pBk6Hw8mJovg73gqTKZryO/FPi3GbArythJCWPDnq94pKOAW/
 XF5DbbMnhDmFcEz2RAZ7F6Um8YZEPop0wCMCMEucpwi0W1YIrdemns0t0deLDrAyWIg=
X-Gm-Gg: AYBFou2Z0km0o3NtD7g+W3Tb8oZdbaRaHdWrAvI1i56LGGQGJ6pINf7L861MBQ8vF+P
 D716aZPqiy/TaqRZo1DnwH02E7nXa7c/6hQV0NOMXuoh1TSqL/QH30an8+hUuOeLY9fpXdZSaE8
 Q0dsm7WIA8NpYIJgSXfp4+wN65b4zHGstqJhP+V5p/6L3o8Jj3JxqVhmq/n50k+7psY3jCC5I0i
 AXlQzMNJqaHFkvo858yKJSL44n99F9maClNq6F7ckNVOraAxsOEyn20Pf4KPQLjjW6H+6L3QwZS
 whnrHJ3NMqQ4OBG+Cw6pXN7cFmMz7EtRvBbtEvR9MKYbgygnJ8KFamt7YOGCWj4z3VdHrkgf+bR
 Kahf6e3bcdCeegX4Y5Ky8JFVp9LjxsO86UJXkOLvQk2KHsdK3nVlBCFlxN9Golaa89+LFz99oZ/
 igXeWF5PbWim37uTqtIah/Bm5dkoIwtdW86aIejfA7cgkkFDm70sa0Rkhn95JOXVw+9Yx3SeB3+
 iiJxlOpBWtIWb1xo3Xs81xrpr8K4VuLTKiGwNJGWuVSlggvtaXLjIz8tI6rS3JB8IXB5hgCj1yT
 LBUxk57gT3qnp/qFvHdoDKsjUgL4D9dG
X-Received: by 2002:a05:6000:2612:b0:488:8bc1:a2eb with SMTP id
 ffacd0b85a97d-499c84b6fe2mr4634343f8f.39.1794414676440; 
 Wed, 11 Nov 2026 08:31:16 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:81bc:371c:5725:cc4d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498357648f0sm12465201f8f.12.2026.11.11.08.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:31:15 -0800 (PST)
Date: Wed, 11 Nov 2026 16:31:13 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Gustavo Romero <gromero@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] hw/arm/sbsa-ref.c: Increase SMMU space for Root
 registers
Message-ID: <avSYUeEmFFBdVePq@linaro.org>
References: <20261016-jmac-smmu-root-registers-v1-0-e78e8879d347@linaro.org>
 <20261016-jmac-smmu-root-registers-v1-2-e78e8879d347@linaro.org>
 <dxrwkmt76n62imxwycc6j2mcjihdhqmhukzc3ypojuepkprzsp@dm4yqcp75wrt>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dxrwkmt76n62imxwycc6j2mcjihdhqmhukzc3ypojuepkprzsp@dm4yqcp75wrt>
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 11:21:12PM +0100, Gustavo Romero wrote:
> Hi Jim,
> 
> On Fri, Oct 16, 2026 at 10:40:52AM +0100, Jim MacArthur wrote:
> > In our implementation, SMMU Root registers are directly after the
> > non-optional SMMU registers. Realms registers will be added above the
> > root registers later.
> 
> nit: Root registers

Noted.

> 
> 
> > 
> > Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> > ---
> >  hw/arm/sbsa-ref.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index 158b461eb4..0747f5ca9f 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -129,7 +129,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
> >      [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
> >      [SBSA_SECURE_UART] =        { 0x60030000, 0x00001000 },
> >      [SBSA_SECURE_UART_MM] =     { 0x60040000, 0x00001000 },
> > -    [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
> > +    [SBSA_SMMU] =               { 0x60050000, 0x00040000 },
> 
> Why +0x20000 bytes here instead of +0x10000 bytes (1 x 64K page)?

Ultimately the plan is to add the Realm registers in here as well, and
those have to be at a 128K-aligned offset from the SMMU base, so per the
original plan they would have started at 0x40000. Now that you mention it
though, it makes more sense to slot the Realm registers in at offset 0x20000
and move the Root registers to 0x40000 when we do so - which means we still
have space in the memory map for a second SMMU. So for now, I'll trim
this back to +0x10000.

> 
> Most importantly, incresing the size of the SBSA_SMMU index is not enough, we
> need to increase also the size of the "arm-smmuv3" container (memory region).
> 
> With this change applied I still see:
> 
> 0000000060050000-000000006006ffff (prio 0, i/o): arm-smmuv3

Thanks, I hadn't spotted that the actual allocation was specified separately;
I'll fix that in the next version.

> 
> on (qemu) info mtree.
> 
> 2 x 64K pages: Page 0 and Page 1. Rather we should see a range to fit 3 x 64K:
> 
> 0000000060050000-000000006007ffff (prio 0, i/o): arm-smmuv3
> 
> Another issue, afaics, is that the Root register page will be added to
> every machine that uses the SMMUv3 device, right? Because we're not gating the
> addition of Root registers based on the presence of RME.
> 
> So I think we should add one boolean "x-root" property (flag) to the SMMUv3
> device that will be used to increase the size of the "arm-smmuv3" if it's set
> and let it by default set to "false".
> 
> This "x-root" property would be set at the machine level, so via
> object_property_set_bool() in create_smmu. For example:
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 0747f5ca9f..36b0164510 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -630,6 +630,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
>                               &error_abort);
>      object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
>                               &error_abort);
> +    object_property_set_bool(OBJECT(dev), "x-root", true, &error_abort);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>      for (i = 0; i < NUM_SMMU_IRQS; i++) {
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 9d9bc2601b..9912fbf920 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2267,6 +2267,7 @@ static void smmu_realize(DeviceState *d, Error **errp)
>      SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
>      SysBusDevice *dev = SYS_BUS_DEVICE(d);
>      Error *local_err = NULL;
> +    uint64_t size = SMMUV3_REGS_SIZE;
>  
>      if (!smmu_validate_property(s, errp)) {
>          return;
> @@ -2291,8 +2292,12 @@ static void smmu_realize(DeviceState *d, Error **errp)
>  
>      qemu_mutex_init(&s->mutex);
>  
> +    if (s->has_root) {
> +        size += SMMUV3_ROOT_PAGE_SIZE;
> +    }
> +
>      memory_region_init_io(&sys->iomem, OBJECT(s),
> -                          &smmu_mem_ops, sys, TYPE_ARM_SMMUV3, 0x20000);
> +                          &smmu_mem_ops, sys, TYPE_ARM_SMMUV3, size);
>  
>      sys->mrtypename = TYPE_SMMUV3_IOMMU_MEMORY_REGION;
>  
> @@ -2382,6 +2387,7 @@ static const Property smmuv3_properties[] = {
>      /* Identifier used for ACPI IORT SMMUv3 (and DSDT for CMDQV) generation */
>      DEFINE_PROP_UINT8("identifier", SMMUv3State, identifier, 0),
>      DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
> +    DEFINE_PROP_BOOL("x-root", SMMUv3State, has_root, false),
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /*
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index a538334066..5d1cb759c3 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -411,7 +411,10 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
>  
>  #define A_IDREGS           0xfd0
>  
> -#define SMMU_ROOT_REG_START 0x20000
> +#define SMMUV3_PAGE_SIZE        0x10000
> +#define SMMUV3_REGS_SIZE        (2 * SMMUV3_PAGE_SIZE) /* Page 0 and Page 1 */
> +#define SMMUV3_ROOT_REG_OFFSET  0x20000
> +#define SMMUV3_ROOT_PAGE_SIZE   SMMUV3_PAGE_SIZE
>  
>  REG32(ROOT_IDR0,            0x0)
>      FIELD(ROOT_IDR0, ROOT_IMPL,   0,  1)
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index e2708e13fe..a8b354438c 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -92,6 +92,7 @@ struct SMMUv3State {
>      OnOffAuto cmdqv;
>  
>      Notifier machine_done;
> +    bool has_root;
>      SMMUv3RootRegBank root;
>  };
> 
> 
> Cheers,
> Gustavo

Thank you for doing this. The only complication is that we'll probably want
an x-realms flag as well later, and if we do the rearrangement of the map
as above then SMMUV3_ROOT_REG_OFFSET will have to be variable. I'll handle
that when we get to the Realm part.

Jim

