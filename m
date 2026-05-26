Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AD5CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 01:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRgQd-0004m1-6g; Mon, 25 May 2026 21:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wRgQa-0004ld-Kj
 for qemu-devel@nongnu.org; Mon, 25 May 2026 21:17:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wRgQW-0003hJ-Ij
 for qemu-devel@nongnu.org; Mon, 25 May 2026 21:17:52 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxdniu9BRqTzsNAA--.13309S3;
 Tue, 26 May 2026 09:17:35 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxysGs9BRqPSuRAA--.10582S3;
 Tue, 26 May 2026 09:17:32 +0800 (CST)
Subject: Re: [PATCH v3 0/4] LoongArch : Add KVM DINTC support
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn
References: <20260525084645.3328690-1-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <7fa7d47f-a3e0-3402-5ca9-56a07e3c8b0a@loongson.cn>
Date: Tue, 26 May 2026 09:14:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260525084645.3328690-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxysGs9BRqPSuRAA--.10582S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw1fZF4DJr4UKFW8tF13GFX_yoW7Ww1xpa
 47Ar15Wr98Gr9xAF1kZ3Waqr48XFs7A3ZF9FyUW3s2krZa9F18u3s29r1kXF9Fy348CFy8
 XF43GryDuF9rZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Hi Song,

There is AI review comments about DMSI about irqchip-in-kernel driver, I 
think it had better be handled before starting new feature.

https://sashiko.dev/#/patchset/20260522064945.614486-1-maobibo%40loongson.cn

This is a pre-existing issue, but looking at dmsintc_inject_irq(), could 
it read uninitialized host stack memory? The local array unsigned long 
vector[4] is declared without initialization. If atomic64_read() returns 
0 for an index, the corresponding vector[i] element is not assigned and 
retains uninitialized stack data:
   arch/loongarch/kvm/intc/dmsintc.c:dmsintc_inject_irq() {
         unsigned long vector[4], old;
         ...
         for (i = 0; i < 4; i++) {
                 old = atomic64_read(&(ds->vector_map[i]));
                 if (old)
                      vector[i] = atomic64_xchg(&(ds->vector_map[i]), 0);
         }
         if (vector[0]) {
                 old = kvm_read_hw_gcsr(LOONGARCH_CSR_ISR0);
                 kvm_write_hw_gcsr(LOONGARCH_CSR_ISR0, vector[0] | old);
         }
         ...
}
If the uninitialized stack memory contains non-zero garbage, it could be
written to the guest's LOONGARCH_CSR_ISRx registers, potentially causing 
a guest-to-host information leak or spurious interrupts.

Regards
Bibo Mao

On 2026/5/25 下午4:46, Song Gao wrote:
> From: gaosong <gaosong@loongson.cn>
> 
> Hi
> 
> This series adds KVM put/get support for msgint CSRs and introduces
> msgint feature checks. It also adds kvm_dintc_realize() when
> kvm_irqchip_in_kernel is enabled, which creates and initializes the DINTC
> device in kernel mode.
> 
> Since the kernel now supports DINTC on the KVM model,
> this series of updates will no longer use the' RFC' header;
> 
> In addition, this series updates the Linux header files to version 7.1-rc4,
> and updates the `update-linux-headers.sh` script to include `typelimits.h`.
> 
> About Testing:
> 1. run script with '-cpu max,msgint=on' and 'virt,dmsi=on.'
> '
> ./build/qemu-system-loongarch64 -accel kvm \
>       -bios /usr/share/edk2/loongarch64/QEMU_EFI-silent-pflash.raw \
>       -cpu max,msgint=on\
>       -smp 4 \
>       -machine virt,dmsi=on,kernel_irqchip=on\
>       -m 16G \
>       -netdev tap,id=net0,ifname=tap0,script=/root/net.sh,downscript=no,vhost=on,queues=4 \
>      -device virtio-net-pci,netdev=net0,mq=on,vectors=128,mac=52:54:00:12:34:56 \
>       -monitor telnet:localhost:4418,server,nowait \
>      -device virtio-gpu-pci \
>      -drive if=none,id=disk0,file=/home/kvm/lns23.qcow2,format=qcow2 \
>      -device virtio-blk-pci,drive=disk0,id=virtio_disk0 \
>      --nographic
> '
> 2  the vm can work well with with net test, such as netperf or iperf test.
> 
> V3:
>     Rebase,add patch4 to disable msgint in KVM model.
> 
> 
> Thanks,
> Song Gao
> 
> Cédric Le Goater (1):
>    linux-headers: Update to Linux v7.1-rc4
> 
> Song Gao (2):
>    target/loongarch: Add kvm support dintc
>    Add dintc kvm_irqchip_in_kernel support
> 
> gaosong (1):
>    targe/loongarch: KVM disable msgint
> 
>   hw/intc/loongarch_dintc.c                     |  13 +
>   hw/intc/loongarch_dintc_kvm.c                 |  48 ++
>   hw/intc/meson.build                           |   2 +
>   include/hw/intc/loongarch_dintc.h             |  10 +
>   include/standard-headers/drm/drm_fourcc.h     |  28 +-
>   include/standard-headers/linux/const.h        |  18 +
>   include/standard-headers/linux/ethtool.h      |  28 +-
>   .../linux/input-event-codes.h                 |  13 +
>   include/standard-headers/linux/pci_regs.h     |  71 ++-
>   include/standard-headers/linux/typelimits.h   |   8 +
>   include/standard-headers/linux/virtio_ring.h  |   5 +-
>   include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
>   include/standard-headers/linux/vmclock-abi.h  |  20 +
>   linux-headers/asm-arm64/kvm.h                 |   1 +
>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>   linux-headers/asm-generic/unistd.h            |   5 +-
>   linux-headers/asm-loongarch/kvm.h             |   5 +
>   linux-headers/asm-loongarch/kvm_para.h        |   1 +
>   linux-headers/asm-loongarch/unistd_64.h       |   2 +
>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>   linux-headers/asm-riscv/kvm.h                 |  11 +-
>   linux-headers/asm-riscv/ptrace.h              |  37 ++
>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>   linux-headers/asm-s390/unistd_32.h            | 446 ------------------
>   linux-headers/asm-s390/unistd_64.h            |   1 +
>   linux-headers/asm-x86/kvm.h                   |  21 +-
>   linux-headers/asm-x86/unistd_32.h             |   1 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/const.h                   |  18 +
>   linux-headers/linux/iommufd.h                 |  48 ++
>   linux-headers/linux/kvm.h                     |  46 +-
>   linux-headers/linux/mshv.h                    |   4 +-
>   linux-headers/linux/psp-sev.h                 |   2 +-
>   linux-headers/linux/stddef.h                  |   4 +
>   linux-headers/linux/vduse.h                   |  85 +++-
>   linux-headers/linux/vfio.h                    |  30 + >   target/loongarch/cpu.c                        |   8 +-
>   target/loongarch/cpu.h                        |   1 +
>   target/loongarch/kvm/kvm.c                    |  74 +++
>   45 files changed, 866 insertions(+), 496 deletions(-)
>   create mode 100644 hw/intc/loongarch_dintc_kvm.c
>   create mode 100644 include/standard-headers/linux/typelimits.h
>   create mode 100644 include/standard-headers/linux/virtio_rtc.h
>   delete mode 100644 linux-headers/asm-s390/unistd_32.h
> 


