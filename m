Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B621ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 17:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRZLg-0004OE-Oc; Mon, 25 May 2026 13:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wRZL0-0004MQ-Dp; Mon, 25 May 2026 13:43:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wRZKv-0003DB-0n; Mon, 25 May 2026 13:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779731005; bh=8h8O4rS+nJV4Ap42No+yCeDiobIHVyou6BuXvIxCkS8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=eDyxlYtlGOTTFWewU4ml7/n4cab8Pa2Uhx6yR6pv4XPXHSQjyxF9zJfZqH/lSFm08
 cVMjxC5NNan8UuDhfHXRZp/i3a0OwlDGMVuVAn93ZP7x4GT1G/Xzscy82bbnp5srSv
 tCy1g6Mju0Lp3Jq/a1Rce8pmeE7Rkk5duA75WwmcP3wfxjNmv7GqRHqdhXTBs8o2kl
 XtkZa0GmlKbSB9hZbRptInzhEzcxHGiaE85C1IbGc0ppp5LbUhRigDYfqSRTnC1S7r
 KZRV3/OJnA/qdsrcpTPkD28V4SKJO5vZ0gWQ80u00TdCCgU6+pWwRtM6CbG5egIwMZ
 AXPuzqwZpkLIA==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 915E51B0748;
 Mon, 25 May 2026 20:43:25 +0300 (MSK)
Message-ID: <76440da5-9f2a-4536-babc-082359812713@tls.msk.ru>
Date: Mon, 25 May 2026 20:43:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/48] riscv-to-apply queue
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 22.05.2026 03:02, alistair23@gmail.com wrote:

> RISC-V PR for 11.1.
> 
> * Remove spike as default machine
> * Deprecate the shakti_c machine
> * Set MISA.[C|X] based on the selected extensions
> * Update Maintainers for OpenSBI Firmware
> * Update OpenSBI to v1.8.1
> * Avoid RISCVCPU copy in PMU FDT setup
> * A collection of specification compliance improvements
> * Fix Svnapot 64KB pages
> * Handle source overlap of vector widening reduction instructions
> * Check interrupt in SiFive UART after txctrl register is written
> * Fix medeleg[11] read-only zero bit for M-mode ECALL
> * Fix tail handling for vmv.s.x and vfmv.s.f
> * Update the local AIA interrupt mask
> * Add KVM support for Zicbop and BFloat16 extensions
> * Fix the IOMMU FSC SV32 capability check
> * Avoid caching PCI device IDs in the IOMMU
> * Implement Microchip mpfs ioscb PLLs and sysreg clock dividers
> * Remove the internal CPU riscv_cpu_* arrays
> * Fix IOCOUNTINH.CY toggle detection
> * Fix the read of pmpaddr(0-63) CSRs
> * Make hpmcounterh return the upper 32-bits
> * Minor fixes and enhancements of RISC-V AIA devices
> * Re-process IOMMU command queue after clearing CMD_ILL
> 
> ----------------------------------------------------------------
> Abhigyan Kumar (1):
>        target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECALL
> 
> Alistair Francis (4):
>        target/riscv: Remove spike as default machine
>        target/riscv: Deprecate the shakti_c machine
>        MAINTAINERS: Maintain OpenSBI Firmware
>        target/riscv: Update the local interrupt mask
> 
> Andrew Jones (1):
>        hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
> 
> Anton Blanchard (1):
>        target/riscv: rvv: Handle source overlap of vector widening reduction instructions
> 
> Chengbo Gao (1):
>        hw/riscv/riscv-iommu: Avoid caching PCI device IDs
> 
> Daniel Henrique Barboza (16):
>        roms/opensbi: Update to v1.8.1
>        target/riscv/cpu.c: add xlrbr isa_edata_arr[] entry
>        target/riscv/cpu.c: fix smctr/ssctr isa_edata_arr[] order
>        target/riscv: make riscv-qmp-cmds use isa_data_arr[]
>        target/riscv/tcg: treat all exts equally in cpu_disable_priv_spec_isa_exts
>        target/riscv/tcg: use only isa_edata_arr[] in cpu_cfg_ext_get_name()
>        target/riscv/cpu.c: remove riscv_cpu_enable_named_feat()
>        target/riscv: remove riscv_cpu_named_features[]
>        target/riscv/tcg: use isa_edata_arr[] in riscv_cpu_update_misa_x()
>        target/riscv/kvm: use isa_edata_arr[] for unavailable props
>        target/riscv/tcg: use isa_edata_arr[] to enable max exts
>        target/riscv/tcg: use cfg_offset as cpu_set_multi_ext cb opaque
>        target/riscv: do not set defaults in cpu prop callback
>        target/riscv/tcg: use isa_edata_arr[] to create user props
>        target/riscv/cpu: remove riscv_cpu_* arrays
>        target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs
> 
> Fangyu Yu (1):
>        hw/riscv/riscv-iommu: Fix IOCOUNTINH.CY toggle detection
> 
> Frank Chang (3):
>        target/riscv: Update MISA.C for Zc* extensions
>        target/riscv: Update MISA.X for non-standard extensions
>        hw/char: Check interrupt after txctrl register is written
> 
> Guenter Roeck (1):
>        hw: misc: Implement Microchip mpfs ioscb PLLs and sysreg clock dividers
> 
> Jay Chang (1):
>        hw/riscv: riscv-iommu: Re-process command queue after clearing CMD_ILL
> 
> Jim Shu (4):
>        hw/intc: riscv_aplic: Fix level trigger IRQ in direct delivery mode
>        hw/intc: riscv_aplic: Add reset API to APLIC
>        hw/intc: riscv_imsic: Add reset API to IMSIC
>        hw/intc: riscv_aplic: add trace events of APLIC read/write function
> 
> Mohamed Ayman (1):
>        riscv: virt: avoid RISCVCPU copy in PMU FDT setup
> 
> Portia Stephens (1):
>        target/riscv: Make hpmcounterh return the upper 32-bits
> 
> Zishun Yi (9):
>        target/riscv: Allow mseccfg access based on ext_zicfilp
>        target/riscv: add Zvknha as an implied extension for Zvknhb
>        target/riscv: Remove unconditional MENVCFG_CDE from mask
>        target/riscv: Fix missing CDE check for scountinhibit
>        target/riscv/pmp: Fix integer overflow in TOR and NA4 address computation
>        target/riscv: Add mseccfg to VMStateDescription
>        target/riscv: clear mseccfg on reset for all dependent extensions
>        hw/riscv/riscv-iommu: fix FSC SV32 capability check
>        hw/riscv/virt-acpi-build: Fix off-by-one error in RIMT ID mapping
> 
> Zongmin Zhou (2):
>        target/riscv/kvm: add KVM support for Zicbop extension
>        target/riscv/kvm: Add BFloat16 extensions support
> 
> chen.zhongyao@zte.com.cn (1):
>        target/riscv: Fix tail handling for vmv.s.x and vfmv.s.f

It looks like this pull request includes quite a number of patches which
are qemu-stable material, some small and/or unimportant, some more
visible.  Examples:

  target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECALL
  target/riscv: Update the local interrupt mask

but knowing nothing about riscv, I don't have expertise to choose which
of them to pick up.  Should we pick sometihng to currently active stable
branches, which are 10.0 (lts), 10.2 and 11.0?

Thanks,

/mjt

