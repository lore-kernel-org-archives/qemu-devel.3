Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771DDD2C546
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3EAG-0004D8-9L; Tue, 22 Oct 2024 08:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t3EA6-0004BP-N6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:39:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t3EA4-0001US-OZ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:38:58 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxPuPdnBdnHTQFAA--.12035S3;
 Tue, 22 Oct 2024 20:38:53 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxuOLcnBdnRdEHAA--.46579S3;
 Tue, 22 Oct 2024 20:38:53 +0800 (CST)
Subject: Re: [PATCH v2 0/2] linux-headers: loongarch: Add kvm_para.h and
 unistd_64.h
To: Bibo Mao <maobibo@loongson.cn>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20241017020708.1728620-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <4fdc1f58-4893-e056-8e1f-5944b5f4587e@loongson.cn>
Date: Tue, 22 Oct 2024 20:39:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241017020708.1728620-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxuOLcnBdnRdEHAA--.46579S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFWxZFW8tF45WF1rWF4DAwc_yoW8ur1kp3
 srAr15Wr9xGasxJFnrZF4aqrs5XF4kA3ZI9Fy7X3s2krWY93W8u3s7Cr1kWrsFy348AFy8
 XF43JryDuF97ArgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhF
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.475, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2024/10/17 ÉÏÎç10:07, Bibo Mao Ð´µÀ:
> linux-headers/asm/unistd.h:3:10: fatal error: asm/unistd_64.h: No such file or directory
>   #include <asm/unistd_64.h>
>
> Also update linux-headers to v6.12-rc3
>
> ---
> v1 ... v2:
>    1. update header files in directory linux-headers to v6.12-rc3
> ---
> Bibo Mao (2):
>    linux-headers: loongarch: Add kvm_para.h and unistd_64.h
>    linux-headers: Update to Linux v6.12-rc3
>
>   include/standard-headers/drm/drm_fourcc.h     |  43 +++
>   include/standard-headers/linux/const.h        |  17 +
>   include/standard-headers/linux/ethtool.h      | 226 +++++++++++++
>   include/standard-headers/linux/fuse.h         |  22 +-
>   .../linux/input-event-codes.h                 |   2 +
>   include/standard-headers/linux/pci_regs.h     |  41 ++-
>   .../standard-headers/linux/virtio_balloon.h   |  16 +-
>   include/standard-headers/linux/virtio_gpu.h   |   1 +
>   linux-headers/asm-arm64/mman.h                |   9 +
>   linux-headers/asm-arm64/unistd.h              |  25 +-
>   linux-headers/asm-generic/unistd.h            |   6 +-
>   linux-headers/asm-loongarch/kvm.h             |  24 ++
>   linux-headers/asm-loongarch/kvm_para.h        |  21 ++
>   linux-headers/asm-loongarch/unistd.h          |   4 +-
>   linux-headers/asm-loongarch/unistd_64.h       | 320 ++++++++++++++++++
>   linux-headers/asm-riscv/kvm.h                 |   7 +
>   linux-headers/asm-riscv/unistd.h              |  41 +--
>   linux-headers/asm-x86/kvm.h                   |   2 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/bits.h                    |   3 +
>   linux-headers/linux/const.h                   |  17 +
>   linux-headers/linux/iommufd.h                 | 143 ++++++--
>   linux-headers/linux/kvm.h                     |  23 +-
>   linux-headers/linux/mman.h                    |   1 +
>   linux-headers/linux/psp-sev.h                 |  28 ++
>   scripts/update-linux-headers.sh               |   4 +
>   27 files changed, 955 insertions(+), 93 deletions(-)
>   create mode 100644 linux-headers/asm-loongarch/kvm_para.h
>   create mode 100644 linux-headers/asm-loongarch/unistd_64.h
>
>
> base-commit: 7e3b6d8063f245d27eecce5aabe624b5785f2a77
Acked-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


