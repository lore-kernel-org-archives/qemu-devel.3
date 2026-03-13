Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE176107BCCA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15at-0001yV-VO; Fri, 13 Mar 2026 12:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15ao-0001wm-FC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:42:30 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15am-00037H-DO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:42:30 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c739e680bebso1060681a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773420145; x=1774024945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BiXLO/cq6wsWFo4Zyle8ekZ9spGpwqXeffegTUcm8Is=;
 b=B9Zh0fizXKdRtnvXToM2i9sPbyeynEu+5vcc3Ih1fzPRHn173t0ikEdyUoefQwgA34
 hrs2mrmWscu4AYc2mHMj2Ta5Pxyenzfb2QslLy1rBwlaGrOvi4aaCLSp0ndyetaG7Ab5
 1H8fGXTV8qOoF8j/yO3XCVMUFeRJHluugjDOCBD4bsHRHPTp0nAi0VdzE1QgFgVHaaZQ
 /dT4XFO1ex5d3TlRR3WrWrZCMCezIGOYxL02CNPcib1ddYlQHSH4031iloP0BflaM4px
 UuypVJiGQYURw4/FAMYCngLRp69dSSEckHzRVUdcZYngwpVRFkROXZQysQynKrxko/8M
 dvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773420145; x=1774024945;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BiXLO/cq6wsWFo4Zyle8ekZ9spGpwqXeffegTUcm8Is=;
 b=P1L0Ak/uNuT1DLWoW1xSz9T/GpNkKxR9EV6J+1XX9Cnc6ssgGacMo5yPgC+b2xNo8H
 JY3Z8VNcqKIUHtYbrJOLGPaz2i8qn8I16RqNMeOYJ8ZAp0c9cKKwsXSr1f9Foef9CjR3
 REuA9OP4uFm0XaQZOrNH0gOyQuR4yanokqQxPTmt6weiutgudjH3YETbsVgM5kevSX57
 lw2p6q+F3j9AHwfK2ACTTmxz5BgG8paMbXBKoeS6gGRwY5phwQaG2BX0UcMTx0UO1Sj7
 zTd68GZ/zNHKy9JUTOpfkfZTwGotx5VPLE0gbfGZ0JU8Xa1zz4K8lckjC7hyNbTQcZ5G
 GFCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDtjPLJvHuK2cxWmv56wv6En1d4X999BJRi6rtToiegoROZENzjyXeHS0qhfuAoyCu11oyoNXelNWw@nongnu.org
X-Gm-Message-State: AOJu0Yw9BGPKxYB4qThy1s9qVz4lFHc/O9We3/Acnti4XcAV1LrJrwj+
 ux7B3EV56OCkqJ45RRyffhRMy3ye1hUcAQjoBZ+6RC8aXbQYqylKT2LCdmmfYvrFcx8=
X-Gm-Gg: ATEYQzw3c88+mPfNiiv2gjQ1J+pR4dsUT1oHX5pulJOWYm+zJtYLWiyeTNM7D3nG4Fk
 rhxRlT741DXN8dos/PyBxp7kGCSi3cgWzkYPNcyfTQ5GNcskoauC2XZf9DiI9WNuaUWNGGr4PkD
 KDtXAFl3hQmmYtDQDTRj1sw2ufxOKl8CWKwEgxFGMI2eSO77e4WBCLNOu1JNIBNZOynmL+mOx/o
 golHeECK9b6W5QqRE7z4ZPgKuITcR1bviYIEEewuea5uPqBxg3IUpBpJPFaXsH85fxX8/Xaf3XU
 Ucw4N734ghTRIiCxt8iyCvCpozvJeHkLbdEnNnouSanGplnFxrQUcSJpYZj4NjpzVBqFK3bmDFw
 0ISJrd4C7onuzNgVPcNppb55JdpdRoI8jKcz4X+U3fvDfb3j8o1t+4+2rEUyOrFA/JlrnC9JMTR
 ZQi9rc8BxpU7j6k3bmuvp1KvXwfKbL3hVkPfOzNOkn9T/MBSWRmt/Ak/QrVb9cn6ul2w8/
X-Received: by 2002:a17:903:2f85:b0:2a7:bbe0:f01f with SMTP id
 d9443c01a7336-2aeca4cbf48mr35692425ad.2.1773420145091; 
 Fri, 13 Mar 2026 09:42:25 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece62c832sm27952085ad.34.2026.03.13.09.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:42:24 -0700 (PDT)
Message-ID: <930278b6-9782-4c91-9e7d-cea6b1938c82@linaro.org>
Date: Fri, 13 Mar 2026 09:42:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/38] target/cpu: Do not include 'exec/cpu-defs.h'
 anymore
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> Pierrick noticed [*] "exec/cpu-defs.h" isn't really used by
> each target "cpu.h". However various source files rely on it
> (or actually a small subset of it: "exec/target_long.h").
> 
> This series first includes the missing headers that were
> indirectly pulled via "cpu.h" -> "exec/cpu-defs.h", then
> remove it for each target "cpu.h".
> 
> As another cleanup we use the full path to target "cpu.h".
> 
> [*] v1: https://lore.kernel.org/qemu-devel/20260312224702.1608408-2-pierrick.bouvier@linaro.org/
> 
> Philippe Mathieu-Daudé (37):
>    target/arm: Remove target_ulong use in hvf_handle_psci_call()
>    target/ppc: Replace TARGET_PAGE_BITS -> qemu_target_page_bits()
>    hw/s390x/vfio: Replace TARGET_PAGE_BITS -> qemu_target_page_bits()
>    monitor/hmp: : Include missing 'exec/target_long.h' header
>    target-info: Include 'exec/cpu-defs.h' explicitly
>    target/xtensa: Restrict inclusion of 'exec/cpu-defs.h' header
>    target/hexagon: Include missing 'exec/target_long.h' header
>    target/hppa: Include missing 'exec/target_long.h' header
>    target/i386: Include missing 'exec/target_long.h' header
>    target/m68k: Include missing 'exec/target_long.h' header
>    target/mips: Include missing 'exec/target_long.h' header
>    target/ppc: Include missing 'exec/target_long.h' header
>    target/riscv: Include missing 'exec/target_long.h' header
>    target/sparc: Include missing 'exec/target_long.h' header
>    system/kvm_xen: Include missing 'exec/target_page.h' header
>    hw/misc/cpc: Include missing 'hw/core/cpu.h' header
>    target/s390x/tcg: Include missing '*cpu.h' headers
>    exec/helper-head: Include missing 'exec/target_long.h' header
>    target/cpu: Do not include 'exec/cpu-defs.h' anymore
>    hw/alpha: Include full path to target 'cpu.h' header
>    hw/arm: Include full path to target 'cpu.h' header
>    hw/avr: Include full path to target 'cpu.h' header
>    hw/hppa: Include full path to target 'cpu.h' header
>    hw/i386: Include full path to target 'cpu.h' header
>    hw/m68k: Include full path to target 'cpu.h' header
>    hw/microblaze: Include full path to target 'cpu.h' header
>    hw/mips: Include full path to target 'cpu.h' header
>    hw/or1k: Include full path to target 'cpu.h' header
>    hw/ppc: Include full path to target 'cpu.h' header
>    hw/riscv: Include full path to target 'cpu.h' header
>    hw/s390x: Include full path to target 'cpu.h' header
>    hw/sh4: Include full path to target 'cpu.h' header
>    hw/sparc: Include full path to target 'cpu.h' header
>    hw/tricore: Include full path to target 'cpu.h' header
>    hw/xtensa: Include full path to target 'cpu.h' header
>    hw/avr: Build as common unit files
>    hw/misc: Build 'mac_via' as common unit file
> 
> Pierrick Bouvier (1):
>    hw/misc/allwinner-cpucfg.c: make compilation unit common
> 
>   hw/avr/boot.h                            |  2 +-
>   hw/s390x/ipl.h                           |  2 +-
>   hw/s390x/s390-hypercall.h                |  2 +-
>   hw/xtensa/xtensa_memory.h                |  2 +-
>   include/hw/arm/digic.h                   |  2 +-
>   include/hw/arm/fsl-imx6.h                |  2 +-
>   include/hw/arm/fsl-imx6ul.h              |  2 +-
>   include/hw/arm/fsl-imx7.h                |  2 +-
>   include/hw/arm/fsl-imx8mp.h              |  2 +-
>   include/hw/i386/apic_internal.h          |  2 +-
>   include/hw/intc/mips_gic.h               |  2 +-
>   include/hw/ppc/pnv.h                     |  2 +-
>   include/hw/ppc/spapr_fadump.h            |  2 +-
>   include/hw/ppc/spapr_ovec.h              |  2 +-
>   include/monitor/hmp-target.h             |  2 +-
>   include/system/kvm_xen.h                 |  2 ++
>   target/alpha/cpu.h                       |  1 -
>   target/arm/cpu.h                         |  1 -
>   target/avr/cpu.h                         |  1 -
>   target/hexagon/cpu.h                     |  3 ++-
>   target/hexagon/mmvec/mmvec.h             |  3 +++
>   target/hppa/cpu.h                        |  2 +-
>   target/i386/cpu.h                        |  2 +-
>   target/loongarch/cpu.h                   |  1 -
>   target/m68k/cpu.h                        |  1 -
>   target/microblaze/cpu.h                  |  1 -
>   target/mips/cpu.h                        |  2 +-
>   target/or1k/cpu.h                        |  1 -
>   target/ppc/cpu.h                         |  2 +-
>   target/riscv/cpu.h                       |  2 +-
>   target/riscv/debug.h                     |  1 +
>   target/riscv/pmp.h                       |  1 +
>   target/rx/cpu.h                          |  1 -
>   target/s390x/cpu.h                       |  1 -
>   target/s390x/tcg/tcg_s390x.h             |  3 +++
>   target/sh4/cpu.h                         |  1 -
>   target/sparc/cpu.h                       |  2 +-
>   target/tricore/cpu.h                     |  1 -
>   target/xtensa/cpu.h                      |  1 -
>   include/exec/helper-head.h.inc           | 15 +++++++--------
>   hw/alpha/dp264.c                         |  2 +-
>   hw/alpha/typhoon.c                       |  2 +-
>   hw/arm/boot.c                            |  2 +-
>   hw/arm/exynos4210.c                      |  2 +-
>   hw/arm/mps3r.c                           |  2 +-
>   hw/arm/omap1.c                           |  2 +-
>   hw/arm/realview.c                        |  2 +-
>   hw/arm/smmuv3.c                          |  2 +-
>   hw/hppa/machine.c                        |  2 +-
>   hw/i386/multiboot.c                      |  2 +-
>   hw/i386/pc_sysfw_ovmf.c                  |  2 +-
>   hw/i386/vmmouse.c                        |  2 +-
>   hw/intc/arm_gicv3_cpuif.c                |  2 +-
>   hw/intc/arm_gicv3_cpuif_common.c         |  2 +-
>   hw/intc/m68k_irqc.c                      |  2 +-
>   hw/intc/sh_intc.c                        |  2 +-
>   hw/isa/lpc_ich9.c                        |  2 +-
>   hw/m68k/an5206.c                         |  2 +-
>   hw/m68k/mcf5206.c                        |  2 +-
>   hw/m68k/mcf5208.c                        |  2 +-
>   hw/m68k/mcf_intc.c                       |  2 +-
>   hw/m68k/q800-glue.c                      |  2 +-
>   hw/m68k/q800.c                           |  2 +-
>   hw/m68k/virt.c                           |  2 +-
>   hw/microblaze/boot.c                     |  2 +-
>   hw/microblaze/petalogix_ml605_mmu.c      |  2 +-
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
>   hw/microblaze/xlnx-zynqmp-pmu.c          |  2 +-
>   hw/mips/bootloader.c                     |  2 +-
>   hw/mips/fuloong2e.c                      |  2 +-
>   hw/mips/jazz.c                           |  2 +-
>   hw/mips/malta.c                          |  2 +-
>   hw/misc/mips_cpc.c                       |  3 ++-
>   hw/misc/riscv_cmgcr.c                    |  3 ++-
>   hw/misc/riscv_cpc.c                      |  3 ++-
>   hw/or1k/boot.c                           |  2 +-
>   hw/or1k/cputimer.c                       |  2 +-
>   hw/or1k/or1k-sim.c                       |  2 +-
>   hw/or1k/virt.c                           |  2 +-
>   hw/ppc/mpc8544_guts.c                    |  2 +-
>   hw/ppc/mpc8544ds.c                       |  2 +-
>   hw/ppc/ppc440_uc.c                       |  2 +-
>   hw/ppc/ppc4xx_devs.c                     |  2 +-
>   hw/ppc/ppc_booke.c                       |  2 +-
>   hw/ppc/prep_systemio.c                   |  2 +-
>   hw/ppc/spapr_vhyp_mmu.c                  |  2 +-
>   hw/ppc/virtex_ml507.c                    |  2 +-
>   hw/riscv/microblaze-v-generic.c          |  2 +-
>   hw/s390x/ap-bridge.c                     |  2 +-
>   hw/s390x/s390-hypercall.c                |  2 +-
>   hw/s390x/s390-pci-vfio.c                 |  3 ++-
>   hw/s390x/s390-stattrib.c                 |  2 +-
>   hw/s390x/tod-tcg.c                       |  2 +-
>   hw/sh4/r2d.c                             |  2 +-
>   hw/sparc/leon3.c                         |  2 +-
>   hw/sparc/sun4m.c                         |  2 +-
>   hw/sparc64/niagara.c                     |  2 +-
>   hw/sparc64/sparc64.c                     |  2 +-
>   hw/sparc64/sun4u.c                       |  2 +-
>   hw/tricore/tricore_testboard.c           |  2 +-
>   hw/xtensa/pic_cpu.c                      |  2 +-
>   hw/xtensa/xtfpga.c                       |  2 +-
>   target-info-stub.c                       |  1 +
>   target/arm/hvf/hvf.c                     |  2 +-
>   target/m68k/m68k-semi.c                  |  2 +-
>   target/ppc/mmu-booke.c                   |  3 ++-
>   target/ppc/mmu-hash64.c                  |  3 ++-
>   target/ppc/mmu-radix64.c                 |  3 ++-
>   target/xtensa/cpu.c                      |  1 +
>   hw/misc/meson.build                      |  6 +++---
>   hw/timer/meson.build                     |  2 +-
>   111 files changed, 120 insertions(+), 113 deletions(-)
> 

Since this series only fixes include, and passes full CI in all 
configurations, I would invite you to pull it for this release, to 
reduce risk of conflicts.

Regards,
Pierrick

