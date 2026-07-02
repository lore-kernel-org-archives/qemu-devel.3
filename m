Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E91C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfF4Y-0000pO-Qm; Thu, 02 Jul 2026 06:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wfF4U-0000lA-ER; Thu, 02 Jul 2026 06:55:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wfF4R-0001kK-W1; Thu, 02 Jul 2026 06:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782989669; bh=ZxaJzgKaugTPg8e+q+KLSdxU9QFThRhrwKlojWX4ZPI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SMV3oJLGjBHH9sLOjMrDMllYF7peSOW1/JAQ6yc0ZzA5nJAOBqP9SBcL2AklbxpoG
 128C+qAfZt9V3sn0Q0yuLL2kpTt8I3ZyIiflQp/YrGyQwH/+PhOYa6EORWYDGpRFWF
 h0meuRvB32FJDcwDZ1w+nb7n2rDDinD6R3pGVw36A10kx5+vwwXd8a+gmVjNlcc30K
 H5sKg+mNWK162+DjZaQjoHenmHL1Df/Ibrcq6sKT+UP43EHg3PIcaEgbpUuNacMYHX
 V9N8AtQNCOIga1+0rC1XpiVQBT9XkfQ6jM6JtJvnIg7IrQCK5emyb/UpXzHLDaGbk4
 rEvD+4TJ88FRw==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 1FFF31BD669;
 Thu, 02 Jul 2026 13:54:29 +0300 (MSK)
Message-ID: <edd19559-f4ba-46eb-b979-700f5491981f@tls.msk.ru>
Date: Thu, 2 Jul 2026 13:54:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/39] riscv-to-apply queue
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
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

On 01.07.2026 13:17, alistair23@gmail.com wrote:
...
> RISC-V PR for 11.1
> 
> * Fix IMSIC CSR write and add tests
> * Parametrise debug trigger number
> * Add 'svbare' satp-mode
> * Fix RINTC PLIC context ID for KVM
> * Avoid abort when reading vtype before env->xl is set
> * Skip reset for KVM irqchip
> * Skip FP/Vector sync on KVM_PUT_RUNTIME_STATE
> * More FDT cleanups (PLIC)
> * Make FCTL.BE in IOMMU read only 0
> * Check DC.TC reserved bits in IOMMU
> * Apply UXL WARL handling to vsstatus
> * Set cmd_ill IOFENCE.C if rsvp bits are set in IOMMU
> * Set RISCV_IOMMU_FQ_HDR_PV appropriately
> * Fix MSI MRIF IOMMU interrupt-pending offset
> * Report QEMU CPU archid as 42
> * Check PMP before updating PTE
> * Add the Tenstorrent Atlantis machine
> 
> ----------------------------------------------------------------
> Alistair Francis (1):
>        hw/riscv/atlantis: Ensure OpenSBI has a non-zero next_addr
> 
> Charlie Jenkins (1):
>        target/riscv: Report QEMU CPU archid as 42
> 
> Chris Rauer (1):
>        hw/i2c: Add DesignWare I2C Controller
> 
> Daniel Henrique Barboza (16):
>        target/riscv/cpu: add CPU unrealize callback
>        target/riscv: dynamic alloc of debug trigger arrays
>        target/riscv: add 'num-triggers' debug property
>        target/riscv/cpu.c: add 'svbare' satp-mode
>        hw/riscv/sifive_u.c: remove unneeded qemu_fdt_get_phandle() call
>        hw/riscv/sifive_u.c: use intc_phandle in plic creation
>        hw/riscv/sifive_u: add #address-cells in PLIC FDT
>        hw/riscv/virt.c: change 'plic' nodename to 'interrupt-controller'
>        hw/riscv: add create_fdt_plic() helper
>        hw/riscv/riscv-iommu: rename regs_rw to regs
>        hw/riscv/riscv-iommu.c: make FCTL.BE read only 0
>        hw/riscv/riscv-iommu: check DC.TC reserved bits
>        hw/riscv/riscv-iommu: set cmd_ill IOFENCE.C rsvp bits are set
>        hw/riscv/riscv-iommu.c: set RISCV_IOMMU_FQ_HDR_PV appropriately
>        hw/riscv/riscv-iommu.c: fix MSI MRIF interrupt-pending offset
>        hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
> 
> Inochi Amaoto (1):
>        target/riscv: Check PMP before updating PTE
> 
> Joel Stanley (9):
>        target/riscv: Avoid NULL deref in IMSIC CSR write
>        tests/functional/riscv64: Use newer kernel for tuxrun boot
>        tests/functional/riscv64: Add virt machine AIA boot test
>        hw/riscv/virt: Move AIA initialisation to helper file
>        hw/riscv/aia: Provide number of irq sources
>        hw/riscv/aia: Configure stride for the M-mode IMSIC
>        hw/riscv: Add Tenstorrent Atlantis machine
>        hw/riscv/atlantis: Integrate i2c controllers
>        hw/riscv/atlantis: Add some i2c peripherals
> 
> Meng Zhuo (1):
>        target/riscv/kvm: skip FP/Vector sync on KVM_PUT_RUNTIME_STATE
> 
> Nicholas Piggin (4):
>        hw/riscv/boot: Describe discontiguous memory in boot_info
>        hw/riscv/boot: Account for discontiguous memory when loading firmware
>        target/riscv: tt-ascalon: Enable Zkr extension
>        tests/functional/riscv64: Add tt-atlantis tests
> 
> Qingwei Hu (3):
>        hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for KVM
>        hw/intc: riscv_aplic: Skip reset for KVM irqchip
>        hw/intc: riscv_imsic: Skip reset for KVM irqchip
> 
> SeungJu Cheon (1):
>        target/riscv: Apply UXL WARL handling to vsstatus
> 
> ZhengXiang Qin (1):
>        target/riscv: avoid abort when reading vtype before env->xl is set


Hi!

Is there anything here worth picking up for the stable series
(besides "target/riscv: Check PMP before updating PTE")?

For example,

  46d96da130 target/riscv: avoid abort when reading vtype before env->xl 
is set
  5a3fd18f4f hw/riscv/riscv-iommu.c: make FCTL.BE read only 0
  13c2fc34f1 hw/riscv/riscv-iommu: check DC.TC reserved bits
  6ed77682d5 hw/riscv/riscv-iommu: set cmd_ill IOFENCE.C rsvp bits are set
  887d2d75b1 hw/riscv/riscv-iommu.c: set RISCV_IOMMU_FQ_HDR_PV appropriately
  3cee183ff9 hw/riscv/riscv-iommu.c: fix MSI MRIF interrupt-pending offset
  64ce9ac187 hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0

resolves various bugs from the qemu issue/work-items tracker.

Thanks,

/mjt

