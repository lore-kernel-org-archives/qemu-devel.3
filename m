Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDE4E674A7
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 06:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6l4I-0006cT-9R; Fri, 01 Nov 2024 02:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t6l4B-0006bw-9q
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 02:23:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t6l47-0004DH-Qe
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 02:23:26 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Axjq_QcyRnPMsjAA--.49610S3;
 Fri, 01 Nov 2024 14:23:12 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxDuHNcyRnt+kwAA--.12824S3;
 Fri, 01 Nov 2024 14:23:12 +0800 (CST)
Subject: Re: [PATCH v3 0/3] linux-headers: Update to Linux v6.12-rc5
To: Bibo Mao <maobibo@loongson.cn>, "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20241028023809.1554405-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <37889235-1351-8702-5a6a-f6cb7ece55fd@loongson.cn>
Date: Fri, 1 Nov 2024 14:24:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241028023809.1554405-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxDuHNcyRnt+kwAA--.12824S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur45Wr1kAry7GF43uF15GFX_yoW5GFWfp3
 srCr15Wr98GF9xJFsIvF12qrs5XF4kC3ZI9Fy7X3s2krWY93W8Xwn7C3WkWrsrt34UAFy8
 XFsxJryDCF97ArgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.257, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2024/10/28 ÉÏÎç10:38, Bibo Mao Ð´µÀ:
> Add unistd_64.h on arm64,loongarch and riscv platform, and update
> linux headers to Linux v6.12-rc5.
>
> Pass to compile on aarch64, arm, loongarch64, x86_64, i386, riscv64,
> riscv32 softmmu and linux-user.
>
> ---
> v2 ... v3:
>    1. Add unistd_64.h on arm64 and riscv platform also
>    2. Update header files to Linux v6.12-rc5
>
> v1 ... v2:
>    1. update header files in directory linux-headers to v6.12-rc3
> ---
>
> Bibo Mao (3):
>    linux-headers: Add unistd_64.h
>    linux-headers: loongarch: Add kvm_para.h
>    linux-headers: Update to Linux v6.12-rc5
>
>   include/standard-headers/drm/drm_fourcc.h     |  43 +++
>   include/standard-headers/linux/const.h        |  17 +
>   include/standard-headers/linux/ethtool.h      | 226 ++++++++++++
>   include/standard-headers/linux/fuse.h         |  22 +-
>   .../linux/input-event-codes.h                 |   2 +
>   include/standard-headers/linux/pci_regs.h     |  41 ++-
>   .../standard-headers/linux/virtio_balloon.h   |  16 +-
>   include/standard-headers/linux/virtio_gpu.h   |   1 +
>   linux-headers/asm-arm64/mman.h                |   9 +
>   linux-headers/asm-arm64/unistd.h              |  25 +-
>   linux-headers/asm-arm64/unistd_64.h           | 324 +++++++++++++++++
>   linux-headers/asm-generic/unistd.h            |   6 +-
>   linux-headers/asm-loongarch/kvm.h             |  24 ++
>   linux-headers/asm-loongarch/kvm_para.h        |  21 ++
>   linux-headers/asm-loongarch/unistd.h          |   4 +-
>   linux-headers/asm-loongarch/unistd_64.h       | 320 +++++++++++++++++
>   linux-headers/asm-riscv/kvm.h                 |   7 +
>   linux-headers/asm-riscv/unistd.h              |  41 +--
>   linux-headers/asm-riscv/unistd_32.h           | 315 +++++++++++++++++
>   linux-headers/asm-riscv/unistd_64.h           | 325 ++++++++++++++++++
>   linux-headers/asm-x86/kvm.h                   |   2 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/bits.h                    |   3 +
>   linux-headers/linux/const.h                   |  17 +
>   linux-headers/linux/iommufd.h                 | 143 +++++++-
>   linux-headers/linux/kvm.h                     |  23 +-
>   linux-headers/linux/mman.h                    |   1 +
>   linux-headers/linux/psp-sev.h                 |  28 ++
>   scripts/update-linux-headers.sh               |   7 +
>   30 files changed, 1922 insertions(+), 93 deletions(-)
>   create mode 100644 linux-headers/asm-arm64/unistd_64.h
>   create mode 100644 linux-headers/asm-loongarch/kvm_para.h
>   create mode 100644 linux-headers/asm-loongarch/unistd_64.h
>   create mode 100644 linux-headers/asm-riscv/unistd_32.h
>   create mode 100644 linux-headers/asm-riscv/unistd_64.h
>
>
> base-commit: cea8ac78545a83e1f01c94d89d6f5a3f6b5c05d2
Acked-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


