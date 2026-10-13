Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0B1CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY2v-0006kX-N3; Tue, 13 Oct 2026 04:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY2u-0006kI-Cl
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY2s-0007Xu-3d
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so23045355e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880776; x=1792485576; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=08iJGPxMB1D+PTxtSo+T7yz2vpiDl2x2pipwrDOWgog=;
 b=xWupK8gzZ/0Y6zo8HA0sCVeI8xOVGwZNs83VOJRjN9dDQAWMKMa5QUxtNqe17uqxmz
 8N5b79ImofFdHVWamrUJftrMQmpwDAiJJY/a9/a0AVQgs/5e04XlVPTaW7Rk3xhf7Oad
 R0B/gqyKCYnbIycG8sX97x5EqJT6DyAwLEfEHr7vCvfBt1Q1UOVYOt/wAaOi7robU0nf
 aj0MIg2+4pe3zKZg6WB1Vy1EAlzFuzB0e1ReGU/+QqWyGmSM49QaLXowRllwGSrveG7X
 OQrUGQbYz9puJ0BhZoKdIHTZXN3gf1f0Zexlfd5B1C4+NlK4oJDb84YZYKxXl3j3VMzI
 OrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880776; x=1792485576;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=08iJGPxMB1D+PTxtSo+T7yz2vpiDl2x2pipwrDOWgog=;
 b=Qjd1NfdhqR+0rGEp/l+sFtbrZddhkAZcVQ+2YXh6I+mCnQxJkdvOQuYIbQWr7ac9Yt
 qbhQvj6yVjehracxYLnZVd4Fe+FvZVuxUP/qMeXOTANcnZ7qmfN0TigFa/njyeI1kIxG
 0mz6zyEJw33ZiLW67U8kij36bOJjVSSKIvImuo2TLvCefdLhu9b3Ri3o3blYkqF6ZPHO
 GhhKK1ToMeQrzUwHUnckT8jIb9EFX2RQwCphbVJKa32z1740oUp4qzAw9FSCAaCtKH4C
 KQZpbG/vXJ2XIXH4QybeJw7fCxs+q0tnUNVqRNezX35kjlKuK7yxIQ8+DqBjtexowFa1
 Txjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1YfYEYsppF8DZtLDGoSFzUS0v0Gjxe3U1mnmyw6UhEkZI/rlc007KLCaIODXRwm8aOYmxquJkKhCm@nongnu.org
X-Gm-Message-State: AFq9FYIn+xHRQT9l9deYvoSWPcG3MUaaAV3qOpyVcbe3p9vkGosrGKcY
 WeNSMOcNCsi3JhZ5ttZ6EfcdCIcjfYuoIIBgt159cGcZXHrNQzyDhJqUFF+Y4NefdVIDrFbSJkS
 xxqltfOk=
X-Gm-Gg: AYBFou0Q1Rr79s44ys51T5AqUDLa34Wz0AfAkYnzwbgRym9OPXRbmPCCQtuttCfU9I8
 lk837U1jOR56jtoqle6sPEoIdo0q7T7sxx30YvIrSOgmqBLbC9J8s2oBUNNhppzldddiivbmASp
 6UyQcy6f4PTNGb6ZA7Io+zix2R2buMEvTTYPXKaY7K27SJ6uCvoDUVaKtHOI6nNyqDcNek81Moz
 GVoFg8SONvPWIZ2gpfY8NMfLAe5bbIoByr5GFDMfdmQc1DUSN80EAO3DJJtsdmuGBq5xTu/Noz6
 YkVllCK/kURNBoYCXZ+hLpCsd4bGeVglDdm9c3tNA1/xsDOcjzCcXPa19zIUOCv/wAs+YxjvIjd
 k+HyHEo1gdG3k/zVhMpKtYT7ucAxFG24AP0qCdBJ7GjcZQ4jEdlck3I8X5RZrFBx5cZ3BxwEadc
 n5y0xEcryg2t+BH51MiqNSM80o/A2NfdulTpyRUB7q1KVGjiHnzW0p1p2G70dNyg0WYkpRSyLzW
 WULkKkLIh6XmtADiO4jljCpLez03EbHd/kPmdVfTqU1nVD4v6GnLwu8lDFiKP+65u4eM6vCgIWs
 wvw=
X-Received: by 2002:a05:600c:83c6:b0:4a1:7093:40c7 with SMTP id
 5b1f17b1804b1-4a18e493048mr213005625e9.8.1791880776069; 
 Tue, 13 Oct 2026 01:39:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/86] hw/intc/arm_gicv5: Implement virtualization support
Date: Tue, 13 Oct 2026 09:38:07 +0100
Message-ID: <20261013083933.1024405-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset adds virtualization support to our GICv5 model, and lets
the "virt" board use -machine gic-version=x-5,virtualization=on.

Virtualization in the GICv5 is more complicated than it is in GICv3.
This is because in GICv3 virtualization is mostly delegated to software,
and only the CPU interface has hardware virtualization support. In
GICv5 the hardware does a lot more of the work, so virtualization
support is needed in both the CPU interface and the IRS.

I've structured this patchset as:
 * initial preparatory and bug-fixing patches
 * add virt support to the cpu interface
 * add virt support to the IRS
 * remove the check in virt that stops the user enabling virt

The first 11 patches have been on this list already; I've copied
across Reviewed-by tags for those patches which got them.

The current spec for the GICv5 is at
https://support.arm.com/documentation/aes0070/00eac0/

The kernel support for using GICv5 virtualization is not yet in
mainline, but it has landed in the kvmarm/next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
Similarly kvmtool support to run the inner guest is still work
in progress, but the tree at
https://gitlab.arm.com/linux-arm/kvmtool-sb.git gicv5_wip
will work with the kvmarm/next tree.

This series can pass the kernel's vgic_v5 selftest, and boot an
inner guest to userspace with kvmtool.

In an ideal world I'd like to land this for 11.2, but I appreciate
that it's a lot of code to review and only two weeks til softfreeze;
we'll see how it goes.

If you want a git branch of this I've pushed the patchset to
 https://gitlab.com/pm215/qemu.git gicv5-virt

thanks
-- PMM

Peter Maydell (86):
  hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual value, not 0
  hw/intc/arm_gicv5: Ignore low bits in IRS_IST_BASER.ADDR
  hw/intc/arm_gicv5: Ignore low bits in L1_ISTE.L2_ADDR
  hw/intc/arm_gicv5: Regularize spacing in config_readl() switch
  hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state
  hw/intc/arm_gicv5: Free memory in finalize
  target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to set IRQ/FIQ status
  target/arm: Only allow GICv5 on CPUs without AArch32 at EL1..3
  hw/intc/arm_gicv5: Pass CPU index to CPU interface
  hw/intc/arm_gicv5: Pass cpuidx rather than iaffid in gicv5_get_hppi()
  hw/intc/arm_gicv5: Use correct type for value in lpi_cache_get_hppi()
  hw/intc/arm_gicv5: Relax QEMU_GICV5_MIN_LPI_ID_BITS to 0
  target/arm: GICv5 cpuif: Implement ICH_APR_EL2
  target/arm: GICv5 cpuif: Implement ICH_PPI_{ENABLE,PEND,ACTIVE} regs
  target/arm: GICv5 cpuif: Implement ICH_PPI_PRIORITYR<n>_EL2
  target/arm: GICv5 cpuif: Implement ICH_PPI_DVIR<n>_EL2
  target/arm: GICv5 cpuif: Implement ICH_VCTLR_EL2 and ICH_VCMR_EL2
  target/arm: GICv5 cpuif: Implement GIC fine-grained trap registers
  target/arm: GICv5 cpuif: Mark GIC registers for fine-grained traps
  target/arm: GICv5 cpuif: Mark GIC insns for fine-grained traps
  target/arm: GICv5 cpuif: Implement ICC_SRE_ELx
  target/arm: GICv5 cpuif: Implement ICH_PPI_HVIR<n>_EL2
  target/arm: GICv5 cpuif: Implement ICV_APR_EL1
  target/arm: GICv5 cpuif: Implement ICV_CR0_EL1
  target/arm: GICv5 cpuif: Implement ICV_PCR_EL1
  target/arm: GICv5 cpuif: Implement ICV_PPI_ENABLER<n>_EL1
  target/arm: GICv5 cpuif: Implement ICV_PPI_PRIORITYR<n>_EL1
  target/arm: GICv5 cpuif: Add comment about ICV_PPI_HMR<n>_EL1
  target/arm: GICv5 cpuif: Implement ICV_PPI_CACTIVER<n>_EL1,
    ICV_PPI_SACTIVER<n>_EL1
  target/arm: GICv5 cpuif: Implement ICV_PPI_CPENDR<n>_EL1,
    ICV_PPI_SPENDR<n>_EL1
  target/arm: GICv5 cpuif: Calculate current virtual PPI HPPI
  target/arm: GICv5 cpuif: Add virtual support to IRS/cpuif HPPI APIs
  target/arm: GICv5 cpuif: Implement ICV_HPPIR_EL1
  target/arm: GICv5 cpuif: Implement gicv5_update_virq_vfiq()
  target/arm: GICv5 cpuif: Implement ICH_CONTEXTR_EL2
  target/arm: GICv5 cpuif: ask the GIC for the virtual HPPI
  target/arm: GICv5 cpuif: Handle LD/VD insns when setting
    domain/virtual args
  target/arm: GICv5 cpuif: Handle virtual interrupts for GIC CDEOI
  target/arm: GICv5 cpuif: Handle virtual interrupts for GIC CDDI
  target/arm: GICv5 cpuif: Handle virtual interrupts for GICR CDIA,
    CDNMIA
  target/arm: GICv5 cpuif: Handle GIC VDPEND VM argument
  target/arm: GICv5 cpuif: Implement GIC VDnnn insns
  target/arm: GICv5 cpuif: Implement GIC LDnnn insns
  target/arm: GICv5 cpuif: Handle PPI injection in vPPI pending reads
  target/arm: GICv5 cpuif: Handle PPI injection in vPPI pending writes
  target/arm: GICv5 cpuif: Handle injected PPIs in GICR CDIA
  target/arm: GICv5 cpuif: Update on HCR_EL2.{NV,NV1} and SCR_EL3.NS
    changes
  target/arm: GICv5 cpuif: Update VFIQ/VIRQ when direct-injected PPIs
    change
  hw/intc: Move GICv5 register and data definitions into a header
  hw/intc/arm_gicv5: Correct offset for IRS_VMT_STATUSR
  hw/intc/arm_gicv5: Ask CPUs whether IRS needs virtualization support
  hw/intc/arm_gicv5: Indicate virtualization in ID registers
  hw/intc/arm_gicv5: Implement IRS_VMT_BASER and IRS_VMT_STATUSR
  hw/intc/arm_gicv5: IMplement IRS_VMT_CFGR
  hw/intc/arm_gicv5: Implement IRS_VMAP_L2_VMTR
  hw/intc/arm_gicv5: Implement IRS_VMAP_VMR
  hw/intc/arm_gicv5: Factor out code to fill in a GICv5ISTConfig
  hw/intc/arm_gicv5: Cache info about valid VMs in a hashtable
  hw/intc/arm_gicv5: Populate VM cache when VM table becomes valid
  hw/intc/arm_gicv5: Implement IRS_VMAP_VISTR
  hw/intc/arm_gicv5: Factor out "make an L2 IST valid" function
  hw/intc/arm_gicv5: Implement IRS_VMAP_L2_VISTR
  hw/intc/arm_gicv5: Cache VPE table information
  hw/intc/arm_gicv5: Implement IRS_VMAP_VPER
  hw/intc/arm_gicv5: Implement IRS_VPE_SELR and IRS_VPE_STATUSR
  hw/intc/arm_gicv5: Implement IRS_VPE_DBR
  hw/intc/arm_gicv5: Implement IRS_VPE_CR0
  hw/intc/arm_gicv5: Implement gicv5_set_resident()
  hw/intc/arm_gicv5: Take cpuidx for stream commands on virtual
    interrupts
  hw/intc/arm_gicv5: Handle virtual=true in gicv5_set_priority()
  hw/intc/arm_gicv5: Handle virtual=true for setting enabled, pending,
    handling
  hw/intc/arm_gicv5: Handle virtual=true for setting pending
  hw/intc/arm_gicv5: Handle virtual=true in gicv5_set_target()
  hw/intc/arm_gicv5: Handle virtual=true in gicv5_deactivate()
  hw/intc/arm_gicv5: Handle activation of a virtual interrupt
  hw/intc/arm_gicv5: Handle virtual=true in gicv5_request_config()
  hw/intc/arm_gicv5: Implement irs_recalc_vhppi()
  hw/intc/arm_gicv5: Recalculate vHPPIs on VIST and VPE mapping
  hw/intc/arm_gicv5: Add virtual support to gicv5_get_hppi()
  hw/intc/arm_gicv5: Implement IRS_VPE_HPPIR
  hw/intc/arm_gicv5: Implement ringing doorbells for VPEs
  hw/intc/arm_gicv5: Handle vHPPIs when IRS_CR0.IRSEN is toggled
  hw/intc/arm_gicv5: Implement saving virtual interrupt state to guest
    memory
  hw/intc/arm_gicv5: Implement reporting of Quiesced state
  hw/intc/arm_gicv5: Implement no-passthrough IRS_SPI_VMR
  hw/arm/virt: allow virtualization=on with gicv5

 hw/arm/virt.c                      |    5 +-
 hw/intc/arm_gicv5.c                | 2554 +++++++++++++++++++++++-----
 hw/intc/arm_gicv5_common.c         |   30 +-
 hw/intc/trace-events               |   19 +-
 include/hw/intc/arm_gicv5.h        |   18 +
 include/hw/intc/arm_gicv5_common.h |   40 +-
 include/hw/intc/arm_gicv5_regs.h   |  325 ++++
 include/hw/intc/arm_gicv5_stream.h |   81 +-
 target/arm/cpregs.h                |   85 +-
 target/arm/cpu-features.h          |    8 +
 target/arm/cpu.c                   |   72 +-
 target/arm/cpu.h                   |   33 +-
 target/arm/gicv5-stubs.c           |    8 +
 target/arm/helper.c                |   23 +-
 target/arm/internals.h             |   23 +
 target/arm/tcg/gicv5-cpuif.c       | 1390 +++++++++++++--
 target/arm/tcg/trace-events        |   10 +-
 17 files changed, 4089 insertions(+), 635 deletions(-)
 create mode 100644 include/hw/intc/arm_gicv5_regs.h

-- 
2.43.0


