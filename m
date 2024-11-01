Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81881E6B27C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6rtC-0003Uy-Tt; Fri, 01 Nov 2024 09:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1t6rsu-0003Hq-Pc
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:40:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1t6rss-0000wj-IH
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:40:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC6AA9E980;
 Fri,  1 Nov 2024 16:39:16 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CD741161EBE;
 Fri,  1 Nov 2024 16:39:59 +0300 (MSK)
Message-ID: <a6fdfd2c-c8e5-4594-88ac-1976cf39537d@tls.msk.ru>
Date: Fri, 1 Nov 2024 16:39:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/50] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Deepak Gupta <debug@rivosinc.com>,
 Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Rob Bradford <rbradford@rivosinc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

31.10.2024 06:52, Alistair Francis wrote:

> ----------------------------------------------------------------
> RISC-V PR for 9.2
> 
> * Fix an access to VXSAT
> * Expose RV32 cpu to RV64 QEMU
> * Don't clear PLIC pending bits on IRQ lowering
> * Make PLIC zeroth priority register read-only
> * Set vtype.vill on CPU reset
> * Check and update APLIC pending when write sourcecfg
> * Avoid dropping charecters with HTIF
> * Apply FIFO backpressure to guests using SiFive UART
> * Support for control flow integrity extensions
> * Support for the IOMMU with the virt machine
> * set 'aia_mode' to default in error path
> * clarify how 'riscv-aia' default works

Is there anything in there which is worth picking up for qemu-stable?
I see numerous "fixes" in there, but I'm not sure which is which and
what is important to have working in 9.1, 9.0, 8.2 (ubuntu lts) or 7.2...
(I've added some CCs)

Thanks,

/mjt

> ----------------------------------------------------------------
> Alistair Francis (2):
>        hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
>        hw/char: sifive_uart: Print uart characters async
> 
> Anton Blanchard (1):
>        target/riscv: Fix vcompress with rvv_ta_all_1s
> 
> Daniel Henrique Barboza (6):
>        pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
>        test/qtest: add riscv-iommu-pci tests
>        qtest/riscv-iommu-test: add init queues test
>        docs/specs: add riscv-iommu
>        target/riscv/kvm: set 'aia_mode' to default in error path
>        target/riscv/kvm: clarify how 'riscv-aia' default works
> 
> Deepak Gupta (20):
>        target/riscv: expose *envcfg csr and priv to qemu-user as well
>        target/riscv: Add zicfilp extension
>        target/riscv: Introduce elp state and enabling controls for zicfilp
>        target/riscv: save and restore elp state on priv transitions
>        target/riscv: additional code information for sw check
>        target/riscv: tracking indirect branches (fcfi) for zicfilp
>        target/riscv: zicfilp `lpad` impl and branch tracking
>        disas/riscv: enable `lpad` disassembly
>        target/riscv: Expose zicfilp extension as a cpu property
>        target/riscv: Add zicfiss extension
>        target/riscv: introduce ssp and enabling controls for zicfiss
>        target/riscv: tb flag for shadow stack instructions
>        target/riscv: mmu changes for zicfiss shadow stack protection
>        target/riscv: AMO operations always raise store/AMO fault
>        target/riscv: update `decode_save_opc` to store extra word2
>        target/riscv: implement zicfiss instructions
>        target/riscv: compressed encodings for sspush and sspopchk
>        disas/riscv: enable disassembly for zicfiss instructions
>        disas/riscv: enable disassembly for compressed sspush/sspopchk
>        target/riscv: Expose zicfiss extension as a cpu property
> 
> Evgenii Prokopiev (1):
>        target/riscv/csr.c: Fix an access to VXSAT
> 
> LIU Zhiwei (2):
>        target/riscv: Add max32 CPU for RV64 QEMU
>        tests/avocado: Boot Linux for RV32 cpu on RV64 QEMU
> 
> Rob Bradford (1):
>        target/riscv: Set vtype.vill on CPU reset
> 
> Sergey Makarov (2):
>        hw/intc: Make zeroth priority register read-only
>        hw/intc: Don't clear pending bits on IRQ lowering
> 
> TANG Tiancheng (6):
>        target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
>        target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
>        target/riscv: Correct SXL return value for RV32 in RV64 QEMU
>        target/riscv: Detect sxl to set bit width for RV32 in RV64
>        target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
>        target/riscv: Enable RV32 CPU support in RV64 QEMU
> 
> Tomasz Jeznach (8):
>        exec/memtxattr: add process identifier to the transaction attributes
>        hw/riscv: add riscv-iommu-bits.h
>        hw/riscv: add RISC-V IOMMU base emulation
>        hw/riscv: add riscv-iommu-pci reference device
>        hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
>        hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
>        hw/riscv/riscv-iommu: add ATS support
>        hw/riscv/riscv-iommu: add DBG support
> 
> Yong-Xuan Wang (1):
>        hw/intc/riscv_aplic: Check and update pending when write sourcecfg



