Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F8606A32A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DqZqXSCF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EWtSCPZl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXvU-0006z6-VD; Mon, 09 Nov 2026 17:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQXvM-0006kF-Ii
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:33:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQXvK-00042u-9G
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794263589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nTheVlU2uNx8gWcy5SRyibC+5QxVg3f/0j2k4PbbQLA=;
 b=DqZqXSCFclPyt7ezCypPigEC+O/7n+GzmhaPz8fc+RgXaFC7jYXUWmlgCkH+eM8l6YdbJo
 F6tVkzOzU8BR+bCo3zbgARw/knjprs1xEM0WJZW7U5nn80jZosTj3n2OA9vymB9l3I1FYo
 ohPzjWhOir4MkdtBli0epMeRFU0+JCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-amD2p61wOsumvINwE-ts5Q-1; Mon, 09 Nov 2026 17:33:07 -0500
X-MC-Unique: amD2p61wOsumvINwE-ts5Q-1
X-Mimecast-MFC-AGG-ID: amD2p61wOsumvINwE-ts5Q_1794263586
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso10312515e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794263586; x=1794868386; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nTheVlU2uNx8gWcy5SRyibC+5QxVg3f/0j2k4PbbQLA=;
 b=EWtSCPZlkGiqfcokHBvRfL/DlyHSCayCgAadFzPWCzhcppcyiQfzM/EylVSeWxiDBl
 PEZNZuuVHGB74DMH8ocLjYMwJ8Gvggw5pUj/zpyeKH2QfUbkN2AgzHo08kgXNj8aAmEW
 ekNZRhmPCb75OpMVeNmsrAIAYu3Ez3C9xk6PTCM2MVj8gNpMUouGj6xe/Spt5+HdjPxP
 LJhwNtQEEIQSlgS7bNxMviq50bOUpM6EP/rBgeK2H6eyY+3mq3XSSJvra3OnfaNdP3o8
 4z5PfHT1NV0cPxRRAm0YpT5l14smlFUh0c3TRrs1yd5hbiEMtWEQtqVBV+JB/+5hypx0
 9fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263586; x=1794868386;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nTheVlU2uNx8gWcy5SRyibC+5QxVg3f/0j2k4PbbQLA=;
 b=UzJwxHeWG0gzzkNpnAeLT1xogoQVc5/YwVlWuqAYA+5O9YSTMy2+ZnpL9IU/6Tns83
 0+B6ryrH4e0ozU20CDPKbais+SIN0ceTHkw/iMeXOzZ/X1WqaNbUYnb1z/0OjFVipYSf
 xbHW81b80rGZalRknGJR6y8K45agurGeAHmG0ECIcNgF0wcz6N6jF5qPf9V4eBWrt7il
 B7gdkqovGZkJGKHQ5di0yb1ShVWXn4By5xjlcWTAhx8KUQOCGZzqLtWaPf5RqkBe/spS
 N1F6gHxjpaRhgucI1RFvr667FQynS23uLiA8UavPEYeK9fJTbDJg4o39lVGe7rj9bRy1
 TdhA==
X-Forwarded-Encrypted: i=1;
 AL+hErFX77BxnX3Gz4xhZ7/RwaX/6UL2a35MS2AaT+aYMtGmLsP0EFaCneV4TcYYAq36PUR2sBa+mnVwUj2b@nongnu.org
X-Gm-Message-State: APuU4Z9Cbqo4zh/8ggPZSlrwVejRK+MRYNvLNceXOXuimvwRSF+Exqbn
 POLeJbUrF1iBmvehcymFPO2lrcC9XgmQX8Lf8XBYbFiaQL8GeX9x6TfYcCeOFRfpppy+rS91x07
 afJrCHYng7uIZ+GKlMlcFHoXiQGqsERUvH4YIk+7BRVM1xxyB8Qah6jYi
X-Gm-Gg: AYBFou0/OQw6MNy47HBmERgae0HmFp0Y7CoZs/kkIgHEDV+A3XzIiurNiMvAeEryk3p
 gyv7Q25FdDEl/d/95Osbqkx1yzfMKhbZv3VmgBwIwzDs4XQM9CqkSO2lC8eiNbNqYskbWVdDhNK
 ogcWLDziYI0uOAJCXXdwfBb7DfH/01bZ7ED1Wh33HuaEsgzIPFndCXxJcDEsnQXhGhIqabf8pyU
 U242RVIcIjxkyy2NTLRgZl5MhcKULCprClycv+Q0NMcuWTu/n8Jm3L5x5ebDVGEj1aw47f6QiYT
 oT2r0DhUZhfqcj4Ol/CCjoG34hczWS2ySO1ZCiqN0FbQp5gO/aA/7H1xxPTvAPeUBz35Bx7PHXy
 RPNRDuPbzawNR+RNYwt3cUuz5hRlxqmPT
X-Received: by 2002:a05:600c:4f4a:b0:4a1:7e76:d02f with SMTP id
 5b1f17b1804b1-4ba0233cb70mr12248895e9.14.1794263586482; 
 Mon, 09 Nov 2026 14:33:06 -0800 (PST)
X-Received: by 2002:a05:600c:4f4a:b0:4a1:7e76:d02f with SMTP id
 5b1f17b1804b1-4ba0233cb70mr12248565e9.14.1794263586063; 
 Mon, 09 Nov 2026 14:33:06 -0800 (PST)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0204784esm22593765e9.10.2026.11.09.14.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:33:05 -0800 (PST)
Date: Mon, 9 Nov 2026 23:33:02 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 00/86] hw/intc/arm_gicv5: Implement virtualization support
Message-ID: <z45u3asa2mt2qj7yiura5gcgq7jnr2r2by45pry7i2plmnsrvb@atuzttjt5cxq>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

On Tue, Oct 13, 2026 at 09:38:07AM +0100, Peter Maydell wrote:
> This patchset adds virtualization support to our GICv5 model, and lets
> the "virt" board use -machine gic-version=x-5,virtualization=on.
> 
> Virtualization in the GICv5 is more complicated than it is in GICv3.
> This is because in GICv3 virtualization is mostly delegated to software,
> and only the CPU interface has hardware virtualization support. In
> GICv5 the hardware does a lot more of the work, so virtualization
> support is needed in both the CPU interface and the IRS.
> 
> I've structured this patchset as:
>  * initial preparatory and bug-fixing patches
>  * add virt support to the cpu interface
>  * add virt support to the IRS
>  * remove the check in virt that stops the user enabling virt
> 
> The first 11 patches have been on this list already; I've copied
> across Reviewed-by tags for those patches which got them.
> 
> The current spec for the GICv5 is at
> https://support.arm.com/documentation/aes0070/00eac0/
> 
> The kernel support for using GICv5 virtualization is not yet in
> mainline, but it has landed in the kvmarm/next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
> Similarly kvmtool support to run the inner guest is still work
> in progress, but the tree at
> https://gitlab.arm.com/linux-arm/kvmtool-sb.git gicv5_wip
> will work with the kvmarm/next tree.
> 
> This series can pass the kernel's vgic_v5 selftest, and boot an
> inner guest to userspace with kvmtool.
> 
> In an ideal world I'd like to land this for 11.2, but I appreciate
> that it's a lot of code to review and only two weeks til softfreeze;
> we'll see how it goes.
> 
> If you want a git branch of this I've pushed the patchset to
>  https://gitlab.com/pm215/qemu.git gicv5-virt
> 
> thanks
> -- PMM
> 
> Peter Maydell (86):
>   hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual value, not 0
>   hw/intc/arm_gicv5: Ignore low bits in IRS_IST_BASER.ADDR
>   hw/intc/arm_gicv5: Ignore low bits in L1_ISTE.L2_ADDR
>   hw/intc/arm_gicv5: Regularize spacing in config_readl() switch
>   hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state
>   hw/intc/arm_gicv5: Free memory in finalize
>   target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to set IRQ/FIQ status
>   target/arm: Only allow GICv5 on CPUs without AArch32 at EL1..3
>   hw/intc/arm_gicv5: Pass CPU index to CPU interface
>   hw/intc/arm_gicv5: Pass cpuidx rather than iaffid in gicv5_get_hppi()
>   hw/intc/arm_gicv5: Use correct type for value in lpi_cache_get_hppi()
>   hw/intc/arm_gicv5: Relax QEMU_GICV5_MIN_LPI_ID_BITS to 0
>   target/arm: GICv5 cpuif: Implement ICH_APR_EL2
>   target/arm: GICv5 cpuif: Implement ICH_PPI_{ENABLE,PEND,ACTIVE} regs
>   target/arm: GICv5 cpuif: Implement ICH_PPI_PRIORITYR<n>_EL2
>   target/arm: GICv5 cpuif: Implement ICH_PPI_DVIR<n>_EL2
>   target/arm: GICv5 cpuif: Implement ICH_VCTLR_EL2 and ICH_VCMR_EL2
>   target/arm: GICv5 cpuif: Implement GIC fine-grained trap registers
>   target/arm: GICv5 cpuif: Mark GIC registers for fine-grained traps
>   target/arm: GICv5 cpuif: Mark GIC insns for fine-grained traps
>   target/arm: GICv5 cpuif: Implement ICC_SRE_ELx
>   target/arm: GICv5 cpuif: Implement ICH_PPI_HVIR<n>_EL2
>   target/arm: GICv5 cpuif: Implement ICV_APR_EL1
>   target/arm: GICv5 cpuif: Implement ICV_CR0_EL1
>   target/arm: GICv5 cpuif: Implement ICV_PCR_EL1
>   target/arm: GICv5 cpuif: Implement ICV_PPI_ENABLER<n>_EL1
>   target/arm: GICv5 cpuif: Implement ICV_PPI_PRIORITYR<n>_EL1
>   target/arm: GICv5 cpuif: Add comment about ICV_PPI_HMR<n>_EL1
>   target/arm: GICv5 cpuif: Implement ICV_PPI_CACTIVER<n>_EL1,
>     ICV_PPI_SACTIVER<n>_EL1
>   target/arm: GICv5 cpuif: Implement ICV_PPI_CPENDR<n>_EL1,
>     ICV_PPI_SPENDR<n>_EL1
>   target/arm: GICv5 cpuif: Calculate current virtual PPI HPPI
>   target/arm: GICv5 cpuif: Add virtual support to IRS/cpuif HPPI APIs
>   target/arm: GICv5 cpuif: Implement ICV_HPPIR_EL1
>   target/arm: GICv5 cpuif: Implement gicv5_update_virq_vfiq()
>   target/arm: GICv5 cpuif: Implement ICH_CONTEXTR_EL2
>   target/arm: GICv5 cpuif: ask the GIC for the virtual HPPI
>   target/arm: GICv5 cpuif: Handle LD/VD insns when setting
>     domain/virtual args
>   target/arm: GICv5 cpuif: Handle virtual interrupts for GIC CDEOI
>   target/arm: GICv5 cpuif: Handle virtual interrupts for GIC CDDI
>   target/arm: GICv5 cpuif: Handle virtual interrupts for GICR CDIA,
>     CDNMIA
>   target/arm: GICv5 cpuif: Handle GIC VDPEND VM argument
>   target/arm: GICv5 cpuif: Implement GIC VDnnn insns
>   target/arm: GICv5 cpuif: Implement GIC LDnnn insns
>   target/arm: GICv5 cpuif: Handle PPI injection in vPPI pending reads
>   target/arm: GICv5 cpuif: Handle PPI injection in vPPI pending writes
>   target/arm: GICv5 cpuif: Handle injected PPIs in GICR CDIA
>   target/arm: GICv5 cpuif: Update on HCR_EL2.{NV,NV1} and SCR_EL3.NS
>     changes
>   target/arm: GICv5 cpuif: Update VFIQ/VIRQ when direct-injected PPIs
>     change
>   hw/intc: Move GICv5 register and data definitions into a header
>   hw/intc/arm_gicv5: Correct offset for IRS_VMT_STATUSR
>   hw/intc/arm_gicv5: Ask CPUs whether IRS needs virtualization support
>   hw/intc/arm_gicv5: Indicate virtualization in ID registers
>   hw/intc/arm_gicv5: Implement IRS_VMT_BASER and IRS_VMT_STATUSR
>   hw/intc/arm_gicv5: IMplement IRS_VMT_CFGR
>   hw/intc/arm_gicv5: Implement IRS_VMAP_L2_VMTR
>   hw/intc/arm_gicv5: Implement IRS_VMAP_VMR
>   hw/intc/arm_gicv5: Factor out code to fill in a GICv5ISTConfig
>   hw/intc/arm_gicv5: Cache info about valid VMs in a hashtable
>   hw/intc/arm_gicv5: Populate VM cache when VM table becomes valid
>   hw/intc/arm_gicv5: Implement IRS_VMAP_VISTR
>   hw/intc/arm_gicv5: Factor out "make an L2 IST valid" function
>   hw/intc/arm_gicv5: Implement IRS_VMAP_L2_VISTR
>   hw/intc/arm_gicv5: Cache VPE table information
>   hw/intc/arm_gicv5: Implement IRS_VMAP_VPER
>   hw/intc/arm_gicv5: Implement IRS_VPE_SELR and IRS_VPE_STATUSR
>   hw/intc/arm_gicv5: Implement IRS_VPE_DBR
>   hw/intc/arm_gicv5: Implement IRS_VPE_CR0
>   hw/intc/arm_gicv5: Implement gicv5_set_resident()
>   hw/intc/arm_gicv5: Take cpuidx for stream commands on virtual
>     interrupts
>   hw/intc/arm_gicv5: Handle virtual=true in gicv5_set_priority()
>   hw/intc/arm_gicv5: Handle virtual=true for setting enabled, pending,
>     handling
>   hw/intc/arm_gicv5: Handle virtual=true for setting pending
>   hw/intc/arm_gicv5: Handle virtual=true in gicv5_set_target()
>   hw/intc/arm_gicv5: Handle virtual=true in gicv5_deactivate()
>   hw/intc/arm_gicv5: Handle activation of a virtual interrupt
>   hw/intc/arm_gicv5: Handle virtual=true in gicv5_request_config()
>   hw/intc/arm_gicv5: Implement irs_recalc_vhppi()
>   hw/intc/arm_gicv5: Recalculate vHPPIs on VIST and VPE mapping
>   hw/intc/arm_gicv5: Add virtual support to gicv5_get_hppi()
>   hw/intc/arm_gicv5: Implement IRS_VPE_HPPIR
>   hw/intc/arm_gicv5: Implement ringing doorbells for VPEs
>   hw/intc/arm_gicv5: Handle vHPPIs when IRS_CR0.IRSEN is toggled
>   hw/intc/arm_gicv5: Implement saving virtual interrupt state to guest
>     memory
>   hw/intc/arm_gicv5: Implement reporting of Quiesced state
>   hw/intc/arm_gicv5: Implement no-passthrough IRS_SPI_VMR
>   hw/arm/virt: allow virtualization=on with gicv5
> 
>  hw/arm/virt.c                      |    5 +-
>  hw/intc/arm_gicv5.c                | 2554 +++++++++++++++++++++++-----
>  hw/intc/arm_gicv5_common.c         |   30 +-
>  hw/intc/trace-events               |   19 +-
>  include/hw/intc/arm_gicv5.h        |   18 +
>  include/hw/intc/arm_gicv5_common.h |   40 +-
>  include/hw/intc/arm_gicv5_regs.h   |  325 ++++
>  include/hw/intc/arm_gicv5_stream.h |   81 +-
>  target/arm/cpregs.h                |   85 +-
>  target/arm/cpu-features.h          |    8 +
>  target/arm/cpu.c                   |   72 +-
>  target/arm/cpu.h                   |   33 +-
>  target/arm/gicv5-stubs.c           |    8 +
>  target/arm/helper.c                |   23 +-
>  target/arm/internals.h             |   23 +
>  target/arm/tcg/gicv5-cpuif.c       | 1390 +++++++++++++--
>  target/arm/tcg/trace-events        |   10 +-
>  17 files changed, 4089 insertions(+), 635 deletions(-)
>  create mode 100644 include/hw/intc/arm_gicv5_regs.h
> 
> -- 
> 2.43.0
> 
> 

Tested-by: Gustavo Romero <gromero@redhat.com>


Cheers,
Gustavo


