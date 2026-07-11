Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAFAC44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiRGn-00081m-Lg; Sat, 11 Jul 2026 02:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiRGl-00081H-MX; Sat, 11 Jul 2026 02:32:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiRGi-00067l-VT; Sat, 11 Jul 2026 02:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783751554; bh=k5ep+H2PNQsks8+RzDzUuJRXIcNxDyXh01gSuuRxwVg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oRSdbNR9K4WdWCd7VCoq19JRgUGNCDLKkMuIhISJ4Xt9TVj6oqhygy4f5RB/n2oDn
 8rH9GtDUDJhm93P6rF+3Eq8go/6A7oqQKNJcR63yucLii0NRD6gzAWAcsQQHniFhbU
 sSBLOdzSGngFxXtNiTkaSywoodnytXQ/TsxzjYswu1b/lQlQPzMmwQdVBDPKtmh/9u
 4aee3t5vyZ+XjcbFG9MnwnP8PJrCgSWRdP391MT+NMaIwqz7oske0Y//FxqP2LKdOA
 niWXYdtGXrWPPG5p2tBLIEmQDXinMbOzKXTTZSHaRj32JfxZyx7h/WOP718WthKy60
 iLq5mS0qGAbPg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0D15A1C06DB;
 Sat, 11 Jul 2026 09:32:34 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 451063EAA31;
 Sat, 11 Jul 2026 09:32:42 +0300 (MSK)
Message-ID: <76408ad0-1950-438f-92ab-62b20f0fa03e@tls.msk.ru>
Date: Sat, 11 Jul 2026 09:32:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/40] riscv-to-apply queue
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
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

On 7/10/26 05:54, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>

> RISC-V PR for 11.1
> 
> * Fix IOMMU fault type for spa_fetch() faults
> * Check IOMMU for reserved PTE bits
> * Fault when IOMMU !PTE_U and no priv access
> * Fault IOMMU for non-user PTE in G_STAGE
> * Check IOMMU reserved MSI PTE basic bits
> * Record fault on IOMMU-generated MSI write
> * Move RISC-V TCG files and fix --disable-tcg
> * Check for misaligned IOMMU IOHGATP_PPN
> * Update IOMMU ioval2 when faulting in spa_fetch()
> * Forbid IOMMU GATE/SADE if caps.AMO_HWADD is zero
> * Set IOMMU ftype and iova in riscv_iommu_ctx()
> * Check PCIe DOE mailbox length for overflows
> * Add extensions after v7.1-rc4 update
> * Remove job building OpenSBI firmware binaries
> * Correct ACPI field sequence in SPCR table

Is it the same as usual for riscv pull requests, -- everything with
Fixes: or Resolves: tag should be picked up for the current qemu stable
releases?

(Cc'ing Daniel too since he has largest share of contributions here).

Thanks,

/mjt

> ----------------------------------------------------------------
> Alistair Francis (1):
>        hw/pci/pcie_doe: Check mailbox length for overflows
> 
> Bin Meng (1):
>        gitlab-ci: Remove job building OpenSBI firmware binaries
> 
> Daniel Henrique Barboza (32):
>        hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults
>        hw/riscv/riscv-iommu.c: check for reserved PTE bits
>        hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access
>        hw/riscv/riscv-iommu.c: fault for non-user PTE in G_STAGE
>        hw/riscv/riscv-iommu.c: check reserved MSI PTE basic bits
>        hw/riscv/riscv-iommu-sys.c: record fault on IOMMU-generated MSI write
>        target/riscv: move valid_vm_* satp arrays to cpu.c
>        hw/riscv, target/riscv: move pmu fdt function to fdt-common.c
>        target/riscv: move TCG only files to tcg subdir
>        target/riscv/machine.c: do not migrate pmp state with kvm
>        target/riscv: move pmp files to tcg subdir
>        target/riscv: tidy up riscv_sysemu_ops
>        target/riscv: move debug.h to tcg subdir
>        target/riscv: remove csr.h from kvm-cpu.c
>        target/riscv: move csr.h to tcg subdir
>        target/riscv: move custom_csrs logic to tcg-cpu.c
>        target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
>        target/riscv: move some irq helpers to cpu.c
>        target/riscv: move riscv_cpu_claim_interrupts to cpu.c
>        target/riscv/cpu.c: handle TCG bits of riscv_cpu_dump_state
>        target/riscv: gate riscv_cpu_update_mip with tcg_enabled()
>        target/riscv/cpu.c: filter TCG only bits in riscv_cpu_reset_hold()
>        hw/riscv/riscv_hart.c isolate tcg only bits
>        target/riscv/gdbstub.c: isolate TCG only checks
>        target/riscv: move riscv_cpu_set_rdtime_fn to riscv_aclint
>        target/riscv/tcg: remove unused riscv_cpu_get_geilen()
>        target/riscv: move riscv_cpu_set_geilen() to riscv-imsic
>        target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb() to riscv_imsic
>        hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
>        hw/riscv/riscv-iommu.c: update ioval2 when faulting in spa_fetch()
>        hw/riscv/riscv-iommu: forbid GATE/SADE if caps.AMO_HWADD is zero
>        hw/riscv/riscv-iommu.c: set ftype and iova in riscv_iommu_ctx()
> 
> Heinrich Schuchardt (3):
>        tests: allow differences in SPCR
>        hw/acpi: correct field sequence in SPCR table
>        tests: update SPCR loongarch64 and riscv64 test data
> 
> Wang Yechao (1):
>        target/riscv/kvm: add extensions after v7.1-rc4 update
> 
> Zephyr Li (2):
>        target/riscv: Remove unused tcg/tcg.h include
>        gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job


