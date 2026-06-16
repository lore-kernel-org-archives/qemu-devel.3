Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11333CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZme-0006wA-N7; Tue, 16 Jun 2026 15:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wZZma-0006vs-7y; Tue, 16 Jun 2026 15:49:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wZZmX-000615-Jb; Tue, 16 Jun 2026 15:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781639343; bh=FGFXqdK3Y20+vmEqpdkOT1b1Y5Yux5LBSKLRNCTAlQY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SfOnNPUOCigkq+uYS9IXci9eGlUURqVCTThb6FJ9PPHKoHBxAG773pmwtR/1j2My4
 zhbnMOGuItyFfwMSXTnmZg+u3gH3BhP8E9t0U+b5Mig8UlpEe7cYqGpgAI4fOQcuaY
 qL7waAoyKUHoN+RJzferjjnUsPrgchIt/A3pssNQWgskIHY2ZL7bLZGXwynZpX42tI
 gBi3wICE7ZxXHxWfzPTRQ+HkF1xxjiDj8aU2k9bSzvtaerq6cu56qQEbsHJ2/xHXAc
 4+4F2EmSpJuEUh0awa2wJ5I4mCD2XkbnKelMHyzsHFgal40c+N9hZlnPnBu5oe18My
 UHtN+I680J9Gw==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id AA3B01B7FFE;
 Tue, 16 Jun 2026 22:49:03 +0300 (MSK)
Message-ID: <b72bbbc2-2195-44e5-a2b8-359aaba21091@tls.msk.ru>
Date: Tue, 16 Jun 2026 22:49:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/83] riscv-to-apply queue
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 16.06.2026 13:04, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The following changes since commit 2f28d34ea0aead9830478cd1d3d0dd9d9191d82e:
> 
>    Merge tag 'pull-tcg-20260612' of https://gitlab.com/rth7680/qemu into staging (2026-06-13 14:02:34 -0400)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260616
> 
> for you to fetch changes up to e968e487acf082279118667f495a3f4275a59d59:
> 
>    hw/riscv: add create_fdt_socket_cpu_sifive() (2026-06-16 20:01:11 +1000)
> 
> ----------------------------------------------------------------
> RISC-V PR for 11.1
> 
> * Disable svpbmt if satp_mode is less then sv39
> * Fix PMP address alignment
> * Mstatus write bug fixes
> * Add 'cbo' insns to disassembler
> * Do not hide Sstc CSRs from gdbstub
> * Reject Svinval instructions in U-mode
> * Save opcode before zicbo helpers
> * Fault with reserved PTE.PBMT val
> * Allow LOAD_ADDR_MIS promotion to AMO fault
> * Make riscv cpu.h target independent
> * Add PMA access fault
> * Disable svnapot if satp_mode is less then sv39
> * Fix disassembler inst_length calculation
> * Add RISC-V big-endian target support
> * Add the implied rules for G and B extensions
> * Print privilege level and ELP in riscv_cpu_dump_state
> * Improve alignment in riscv_cpu_dump_state
> * Mask vxrm csrw write to the low 2 bits
> * Reorder Smrnmi CPU fields above CPU reset line
> * Supplement cpu topology arguments
> * Don't insert DDT cache in Bare mode
> * Fix 'iommu-map' FDT entry
> * Fix mstatus.FS dirty tracking for FP exception-raising instructions
> * Enable `mnret` disassembly
> * Add support for K230 board
> * FDT creation helpers
> 
> ----------------------------------------------------------------
> Abhigyan Kumar (1):
>        target/riscv: mask vxrm csrw write to the low 2 bits
> 
> Anton Blanchard (2):
>        target/riscv: Print privilege level and ELP in riscv_cpu_dump_state
>        target/riscv: Improve alignment in riscv_cpu_dump_state
> 
> Anton Johansson (27):
>        target/riscv: Fix size of gpr and gprh
>        target/riscv: Fix size of vector CSRs
>        target/riscv: Fix size of pc, load_[val|res]
>        target/riscv: Fix size of frm and fflags
>        target/riscv: Fix size of badaddr and bins
>        target/riscv: Fix size of guest_phys_fault_addr
>        target/riscv: Fix size of priv_ver and vext_ver
>        target/riscv: Fix size of retxh
>        target/riscv: Fix size of ssp
>        target/riscv: Fix size of excp_uw2
>        target/riscv: Fix size of sw_check_code
>        target/riscv: Fix size of priv
>        target/riscv: Fix size of gei fields
>        target/riscv: Fix size of [m|s|vs]iselect fields
>        target/riscv: Fix arguments to board IMSIC emulation callbacks
>        target/riscv: Fix size of irq_overflow_left
>        target/riscv: Indent PMUFixedCtrState correctly
>        target/riscv: Replace target_ulong in riscv_cpu_get_trap_name()
>        target/riscv: Replace target_ulong in riscv_ctr_add_entry()
>        target/riscv: Fix size of trigger data
>        target/riscv: Fix size of mseccfg
>        target/riscv: Move debug.h include away from cpu.h
>        target/riscv: Move CSR declarations to separate csr.h header
>        target/riscv: Introduce externally facing CSR access functions
>        target/riscv: Make pmp.h target_ulong agnostic
>        target/riscv: Pass address as uint64_t in cpu_set_exception_base()
>        target/riscv: Fix pmp.h/cpu.h circular inclusion
> 
> Chao Liu (5):
>        target/riscv: add thead-c908 cpu support
>        hw/riscv: add k230 board initial support
>        hw/watchdog: add k230 watchdog initial support
>        tests/qtest: add test for K230 watchdog
>        docs/system/riscv: add documentation for k230 machine
> 
> Daniel Henrique Barboza (24):
>        target/riscv/tcg: disable svpbmt if satp_mode < sv39
>        target/riscv/csr.c: do not allow mstatus MPV/GVA writes
>        target/riscv/csr.c: fix mstatus.UXL reserved value
>        disas/riscv.c: add 'cbo' insns to disassembler
>        target/riscv/insn_trans/trans_rvzicbo.c.inc: save opcode before helpers
>        target/riscv/cpu_helper.c: fault with reserved PTE.PBMT val
>        target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion to AMO fault
>        target/riscv/cpu_helper.c: add PMA access fault
>        target/riscv/tcg: disable svnapot if satp_mode < sv39
>        disas/riscv.c: fix inst_length()
>        hw/riscv/virt.c: fix 'iommu-map' FDT entry
>        hw/riscv/sifive_u.c: add a FDT phandle to cpu-intc
>        hw/riscv: add fdt-common helper
>        hw/riscv/numa: make numa_enabled() public
>        hw/riscv: add create_fdt_socket_memory() helper
>        hw/riscv/sifive_u.c: add intc_phandles array
>        hw/riscv/spike.c: add intc_phandles array
>        hw/riscv: add create_fdt_clint() helper
>        hw/riscv/sifive_u.c: add cpu-map, cluster and core DTs
>        hw/riscv: add fdt_create_cpu_socket_subnode() helper
>        hw/riscv: add create_fdt_socket_cpus()
>        hw/riscv/spike.c: use create_fdt_socket_cpus()
>        hw/riscv/fdt_common.c: create create_fdt_socket_cpu_internal()
>        hw/riscv: add create_fdt_socket_cpu_sifive()
> 
> Djordje Todorovic (6):
>        target/riscv: Implement runtime data endianness via MSTATUS bits
>        target/riscv: Fix page table walk endianness for big-endian harts
>        target/riscv: Add big-endian CPU configuration field and reset logic
>        hw/riscv/boot: Honour data endianness
>        target/riscv: Expose and document the CPU 'big-endian' property
>        tests/functional: Add RISC-V endianness test
> 
> Frank Chang (2):
>        target/riscv: Add standard B extension implied rule
>        target/riscv: Reorder Smrnmi CPU fields above CPU reset line
> 
> Jay Chang (4):
>        target/riscv: Align pmp size to pmp-granularity
>        target/riscv: Improve PMP address alignment readability
>        hw/riscv: Don't insert DDT cache in Bare mode
>        hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode handling
> 
> Jim Shu (1):
>        target/riscv: Add the implied rule for G extension
> 
> Max Chou (2):
>        target/riscv: Set mstatus.FS dirty when scalar FP raises exceptions
>        target/riscv: rvv: Set mstatus.FS dirty when vector FP raises exceptions
> 
> Philippe Mathieu-Daudé (5):
>        target/riscv: Initialize DisasContext::mo_endian once
>        target/riscv: De-indent some code in get_physical_address()
>        target/riscv: Remove target_ulong use in get_physical_address()
>        hw/riscv/boot: Rewrite setup_rom_reset_vec() using load/store API
>        hw/riscv/boot: Replace cpu_to_le32() -> const_le32()
> 
> Xuemei Liu (1):
>        hw/riscv/numa.c: Supplement cpu topology arguments
> 
> Zephyr Li (2):
>        target/riscv: Do not hide Sstc CSRs from gdbstub
>        target/riscv: Reject Svinval instructions in U-mode
> 
> imaginos (1):
>        disas/riscv: enable `mnret` disassembly

Hi!

Is there anything here worth picking up for the stable series?
The "target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion to
AMO fault" has Cc: stable, so I picked it up.

Thanks,

/mjt

