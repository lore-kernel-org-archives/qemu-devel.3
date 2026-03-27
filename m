Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A07110ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Bc-0006LO-Se; Fri, 27 Mar 2026 07:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Ba-0006K7-FV
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:06 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65BX-0007TQ-Te
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:06 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439bc14dcf4so2270946f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610222; x=1775215022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uNK/Y4oPAGACBCyys8A7cyrjHHfrPsHlYL1LG59HEDk=;
 b=sTzTn0kdQC6+OTJTNL/zIHeYqREJHda69d8tZMc49HZRdAh1KSWQpYFdTRZdwXgb88
 q+DfvvH7zkZ+FxsXjnc+c+M8i113tvzOfWooSGUWMN6z7IzgX4zh5se7dFuRxDTj74+Z
 AXHdCXKHazdl9zz8lPlQ7EITDeE9Psz/ePSMjQqEJ7LMt/85qqbBsjF9e3AmXf4sPhoW
 2QtwUwwkwGaaZMVob+8NjS+GyWRjF4yiJss/UfdNPMTkhemEywCxeyL7Q+lgGqxVqyQF
 8Ry1mvkPFntP/JpYjkoM6Obc4ZcDlYzSqbdK1IWzdvZORHEY/aTbRa/EK2wdHFnVHFp5
 nsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610222; x=1775215022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNK/Y4oPAGACBCyys8A7cyrjHHfrPsHlYL1LG59HEDk=;
 b=gykrofVLkbPHoc0HIDfaMQSda5IzcOO3LHXQyNcArkWulyCAl30Kx6caOC4ibh5cpp
 ohr90FKz8EVps+qkYZFhZyIZ/LXpaF/kKmuugWnV+W1zEfW7lZhGCX+a0OrZD41HX2u/
 MN5jPyCK7DJAEUjOZaOIhoAR4ZK+sugLNZfeq39Tu3Eo8CbvhdK2NKmqN/wH/oWxfmH/
 k+P8qiXzVzpCHOARNYldx1dAZ9DcPrx7p2HF4c2xXKgRkUoxzFl2VcIxuxAva6w5RDQw
 AOAW9SAwWryvhEnhFu/KO56H/G/HtChJrQEy2g2xtC9SABASLdIuqiB5irFrs0C7q50B
 afNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcMDJJGjxTwJcX4CznkFAUsGtzModieDZ/v8JwqueL+VsV0/KhGqcCtk6WcfK/9EuUopaUp3psxzYi@nongnu.org
X-Gm-Message-State: AOJu0YyXMlmerqxwmqNxd/pgfxJdsSykQrX0SnzR1QgI6zIADzM+x6Yl
 eS8gZIB6spvZOlmlRxa3JruGL1r8L6ZtiW+hJ4h5Ybh8IUzWTlGdA1RcWbRdWGqKCBo=
X-Gm-Gg: ATEYQzwzTVl/VUNAw+omxp/pV5KpW7VY0W661gYr9GIDbR1+18kiaYx+B9r+qFGjPQD
 fd+1EtVMSphmjrckUGMpWtjueb1ZclEGpJMg95hYSisY6wu21JYRbtFifq2paHIwRXj1yhl3WCo
 BGKqNpAEYCIcbQkTaAJU9sqcRJ/uC8Ndrcs9zzw4F7k7tsRwTB4PmJvN97FSbwcv5VYvQIJxV+y
 rbLhIE/oFgDiD0ajH0cOQCvk4cgUiYaUOx2CNrHf39ADkj3stK1wErQC9yNu7a+Ng069o9P+B+V
 XDKBq35a9xtqNWCKGVgss+47M+X834cowpu6FbfIynPkpLvrClzd6U8uHDn59F4tn8bQcQxyUWF
 bjoodiXp2H9CXTnLkQ9Xa7jU5zw/XVqXSEOtOfNbUdonuolbt9aBAukq9FY4AQaww3X9WcDDXVE
 acDR70h3589bmy0B91QhXuljjnrkn20bI3x0s1S6+72J/b2abWZJF9Rj+rbjcOGFOijALLcp2u4
 gAGA3OJF+TN3RFKfVUL4aPnL6G2qi4=
X-Received: by 2002:a05:6000:410a:b0:43b:97d8:9a40 with SMTP id
 ffacd0b85a97d-43b97d8a581mr8410487f8f.17.1774610221927; 
 Fri, 27 Mar 2026 04:17:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 00/65] arm: Implement an emulation of GICv5 interrupt
 controller
Date: Fri, 27 Mar 2026 11:15:55 +0000
Message-ID: <20260327111700.795099-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

This patchset implements initial support of emulation of Arm's new
interrupt controller architecture, GICv5.

I've incorporated the review feedback from v1, so I figured I
might as well send this out, though obviously there's no huge
rush to review given we're in freeze.

Patches still needing review: 10 24 25 32

Changes v1->v2:
 * minor tidyups to line wrap, etc, in various patches
 * patch 1 is split into 2 patches but otherwise unchanged
 * 3: define FRAME_OP_ENTRY macro to avoid duplication in writing
   out entries of the config_frame_ops[] array
 * 9: fixed IRS_IDR0 PA_RANGE field length
 * 10: also zero IDR0 VIRT_ONE_N field for the EL3 domain
 * 18, 21, 24, 25, 47, 50: use switch on IRQ type instead of if()
   in gicv5_set_priority() and similar functions
 * old 55 ("hw/arm/virt: Update error message for bad gic-version
   option") is now upstream, so dropped from v2


(Everything below here is the same as from v1's cover letter;
repeated for context.)

The most recent version of the GICv5 spec (currently 00EAC0) is at:
https://developer.arm.com/documentation/aes0070/latest/

The emulation is at an "experimental" level, both because the GICv5
specification is still at an early-access level and minor changes are
possible, and also because this emulation is missing some
functionality which I plan to add later but which would have made this
initial patchset even larger and later. To quote the docs patch:

    - guest-visible behaviour may change when the final version of
      the specification is released and QEMU implements it
    - migration support is not yet implemented
    - the GICv5 is not exposed to the guest via ACPI tables, only via DTB
    - the way the interrupt controller is exposed to the guest and the
      command line syntax for enabling it may change

    The current implementation supports only an EL1 guest (no EL2 or
    EL3 and no Realm support), and does not implement the ITS (no
    MSI support).

The GICv5 is supported by the "virt" board, and can be enabled with
"-machine gic-version=x-5" (the 'x' standing for "experimental").

Like the GICv3/v4, the GICv5 has both a system component part (the
Interrupt Routing Service, IRS), and a part in the CPU itself (the CPU
interface). Our GICv3 model puts both of these into code in hw/intc/,
and has the cpuif part install itself into an existing CPU object by
adding new system registers there. This works, but in retrospect I
feel that it's a bit awkward and we would have done better to make our
design a bit closer to the hardware setup, where the CPU interface is
really part of the CPU and talks to the system component over an
architected protocol. So for GICv5 I have taken that route: the IRS is
in hw/intc/arm_gicv5.c, and the CPU interface is in
target/arm/tcg/gicv5-cpuif.c. They communicate via a set of functions
which loosely match the "stream protocol" defined in the GICv5
architecture spec (with some simplifications that result from QEMU
being strictly synchronous because we always hold the BQL when
executing any GICv5 emulation code; the hardware has to handle the IRS
and the CPU executing in parallel and the communications channel not
being instantaneous transmission).

Although the EL2/EL3/Realm functionality is not present in this
patchset, I have implemented some of the foundations for it where I
thought it made sense, to avoid having to refactor it later.
Similarly, the class structure makes the usual "common baseclass + TCG
subclass" split, as we are going to want a KVM subclass when we add
KVM support.

In a few places I have noted possible opportunities for performance
optimisation; these are probably best left until we've done some
analysis that shows them to be necessary.

This patchset is sufficient to be able to boot a Linux guest at EL1
(directly via -kernel): all the kernel support for GICv5 is upstream
as of Linux 6.19.

thanks
-- PMM

Peter Maydell (65):
  qom/object: Add object_resolve_and_typecheck()
  hw/core: Permit devices to define an array of link properties
  hw/intc: Skeleton of GICv5 IRS classes
  hw/arm/Kconfig: select ARM_GICV5 for ARM_VIRT board
  hw/intc/arm_gicv5: Implement skeleton code for IRS register frames
  hw/intc/arm_gicv5: Add migration blocker
  hw/intc/arm_gicv5: Create and validate QOM properties
  hw/intc/arm_gicv5: Create inbound GPIO lines for SPIs
  hw/intc/arm_gicv5: Define macros for config frame registers
  hw/intc/arm_gicv5: Implement IRS ID regs
  hw/intc/arm_gicv5: Add link property for MemoryRegion for DMA
  hw/intc/arm_gicv5: Implement gicv5_class_name()
  hw/intc/arm_gicv5: Add defines for GICv5 architected PPIs
  target/arm: GICv5 cpuif: Initial skeleton and GSB barrier insns
  target/arm: Set up pointer to GICv5 in each CPU
  hw/intc/arm_gicv5: Implement IRS_IST_{BASER, STATUSR, CFGR}
  hw/intc/arm_gicv5: Cache LPI IST config in a struct
  hw/intc/arm_gicv5: Implement gicv5_set_priority()
  target/arm: GICv5 cpuif: Implement the GIC CDPRI instruction
  hw/intc/arm_gicv5: Implement IRS_MAP_L2_ISTR
  hw/intc/arm_gicv5: Implement remaining set-config functions
  target/arm: GICv5 cpuif: Implement GIC CD* insns for setting config
  hw/intc/arm_gicv5: Create backing state for SPIs
  hw/intc/arm_gicv5: Make gicv5_set_* update SPI state
  hw/intc/arm_gicv5: Implement gicv5_request_config()
  target/arm: GICv5 cpuif: Implement GIC CDRCFG and ICC_ICSR_EL1
  hw/intc/arm_gicv5: Implement IRS_SPI_{SELR,STATUSR,CFGR,DOMAINR}
  hw/intc/arm_gicv5: Update SPI state for CLEAR/SET events
  hw/intc/arm_gicv5: Implement IRS_CR0 and IRS_CR1
  hw/intc/arm_gicv5: Implement IRS_SYNCR and IRS_SYNC_STATUSR
  hw/intc/arm_gicv5: Implement IRS_PE_{CR0,SELR,STATUSR}
  hw/intc/arm_gicv5: Implement CoreSight ID registers
  hw/intc/arm_gicv5: Cache pending LPIs in a hash table
  target/arm: GICv5 cpuif: Implement ICC_IAFFIDR_EL1
  target/arm: GICv5 cpuif: Implement ICC_IDR0_EL1
  target/arm: GICv5 cpuif: Implement GICv5 PPI active set/clear
    registers
  target/arm: GICv5 cpuif: Implement PPI handling mode register
  target/arm: GICv5 cpuif: Implement PPI pending status registers
  target/arm: GICv5 cpuif: Implement PPI enable register
  target/arm: GICv5 cpuif: Implement PPI priority registers
  target/arm: GICv5 cpuif: Implement ICC_APR_EL1 and ICC_HAPR_EL1
  target/arm: GICv5 cpuif: Calculate the highest priority PPI
  hw/intc/arm_gicv5: Calculate HPPI in the IRS
  target/arm: GICv5 cpuif: Implement ICC_CR0_EL1
  target/arm: GICv5 cpuif: Implement ICC_PCR_EL1
  target/arm: GICv5 cpuif: Implement ICC_HPPIR_EL1
  hw/intc/arm_gicv5: Implement Activate command
  target/arm: GICv5 cpuif: Implement GICR CDIA command
  target/arm: GICv5 cpuif: Implement GIC CDEOI
  hw/intc/arm_gicv5: Implement Deactivate command
  target/arm: GICv5 cpuif: Implement GIC CDDI
  target/arm: GICv5 cpuif: Signal IRQ or FIQ
  target/arm: Connect internal interrupt sources up as GICv5 PPIs
  target/arm: Add has_gcie property to enable FEAT_GCIE
  hw/intc/arm_gicv3_cpuif: Don't allow GICv3 if CPU has GICv5 cpuif
  hw/arm/virt: Remember CPU phandles rather than looking them up by name
  hw/arm/virt: Move MSI controller creation out of create_gic()
  hw/arm/virt: Pull "wire CPU interrupts" out of create_gic()
  hw/arm/virt: Split GICv2 and GICv3/4 creation
  hw/arm/virt: Create and connect GICv5
  hw/arm/virt: Advertise GICv5 in the DTB
  hw/arm/virt: Handle GICv5 in interrupt bindings for PPIs
  hw/arm/virt: Use correct interrupt type for GICv5 SPIs in the DTB
  hw/arm/virt: Enable GICv5 CPU interface when using GICv5
  hw/arm/virt: Allow user to select GICv5

 docs/system/arm/virt.rst           |   19 +
 hw/arm/Kconfig                     |    1 +
 hw/arm/virt.c                      |  525 ++++++--
 hw/core/qdev-properties.c          |   78 ++
 hw/intc/Kconfig                    |    4 +
 hw/intc/arm_gicv3.c                |    2 +-
 hw/intc/arm_gicv3_cpuif.c          |   14 +-
 hw/intc/arm_gicv5.c                | 1962 ++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  227 ++++
 hw/intc/gicv3_internal.h           |    2 +-
 hw/intc/meson.build                |    4 +
 hw/intc/trace-events               |   23 +
 include/hw/arm/fdt.h               |   10 +
 include/hw/arm/virt.h              |   15 +
 include/hw/core/qdev-properties.h  |   41 +
 include/hw/intc/arm_gicv5.h        |   51 +
 include/hw/intc/arm_gicv5_common.h |  236 ++++
 include/hw/intc/arm_gicv5_stream.h |  228 ++++
 include/hw/intc/arm_gicv5_types.h  |  110 ++
 include/qom/object.h               |   17 +
 meson.build                        |    1 +
 qom/object.c                       |   41 +-
 target/arm/cpregs-pmu.c            |    9 +-
 target/arm/cpu-features.h          |   11 +
 target/arm/cpu.c                   |   62 +
 target/arm/cpu.h                   |   28 +
 target/arm/helper.c                |   21 +
 target/arm/internals.h             |    9 +
 target/arm/tcg/gicv5-cpuif.c       |  952 ++++++++++++++
 target/arm/tcg/meson.build         |    1 +
 target/arm/tcg/trace-events        |   11 +
 target/arm/tcg/trace.h             |    1 +
 32 files changed, 4559 insertions(+), 157 deletions(-)
 create mode 100644 hw/intc/arm_gicv5.c
 create mode 100644 hw/intc/arm_gicv5_common.c
 create mode 100644 include/hw/intc/arm_gicv5.h
 create mode 100644 include/hw/intc/arm_gicv5_common.h
 create mode 100644 include/hw/intc/arm_gicv5_stream.h
 create mode 100644 include/hw/intc/arm_gicv5_types.h
 create mode 100644 target/arm/tcg/gicv5-cpuif.c
 create mode 100644 target/arm/tcg/trace-events
 create mode 100644 target/arm/tcg/trace.h

-- 
2.43.0


