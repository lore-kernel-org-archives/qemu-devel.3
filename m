Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA02CD343F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 01:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMy07-0007cR-P3; Tue, 12 May 2026 21:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wMy06-0007cI-6j
 for qemu-devel@nongnu.org; Tue, 12 May 2026 21:03:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wMy02-0005Ep-Pm
 for qemu-devel@nongnu.org; Tue, 12 May 2026 21:03:01 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxFem4zQNqeFUJAA--.22530S3;
 Wed, 13 May 2026 09:02:49 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBx68GzzQNqErKAAA--.45714S3;
 Wed, 13 May 2026 09:02:45 +0800 (CST)
Subject: Re: [PATCH v2 2/4] linux-headers: Update to Linux v7.1-rc1
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn,
 Avihai Horon <avihaih@nvidia.com>
References: <20260507092358.2479135-1-gaosong@loongson.cn>
 <20260507092358.2479135-3-gaosong@loongson.cn>
 <eb2f2af0-a510-4f0e-be00-9ed6bf7b4dca@redhat.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3f989e89-9833-593c-7879-5f0575c358b5@loongson.cn>
Date: Wed, 13 May 2026 09:04:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eb2f2af0-a510-4f0e-be00-9ed6bf7b4dca@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBx68GzzQNqErKAAA--.45714S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr1UZFy8AF1DAF47AFy5Awc_yoWrAr1Upw
 1kJr15Gry5Gwn5Jr4UGF17try8XF45J3WjqryUZasrCrWYyr1jqr1Du34vgr1DJr48AF1U
 Xr1xJr1DuFy7ArgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

在 2026/5/13 上午5:30, Cédric Le Goater 写道:
> Hello,
>
>
> On 5/7/26 11:23, Song Gao wrote:
>> From: Avihai Horon<avihaih@nvidia.com>
>>
>> Update Linux headers to get VFIO_PRECOPY_INFO_REINIT feature of VFIO
>> migration uAPI.
>>
>> The update was done by running `update-linux-headers.sh` on commit
>> 254f49634ee1 ("Linux 7.1-rc1") in the Linux tree.
>>
>> Signed-off-by: Avihai Horon<avihaih@nvidia.com>
>> Reviewed-by: Cédric Le Goater<clg@redhat.com>
>> ---
>>   include/standard-headers/drm/drm_fourcc.h     |  28 +-
>>   include/standard-headers/linux/const.h        |  18 +
>>   include/standard-headers/linux/ethtool.h      |  28 +-
>>   .../linux/input-event-codes.h                 |  13 +
>>   include/standard-headers/linux/pci_regs.h     |  71 ++-
>>   include/standard-headers/linux/typelimits.h   |   8 +
>>   include/standard-headers/linux/virtio_ring.h  |   3 +-
>>   include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
>>   include/standard-headers/linux/vmclock-abi.h  |  20 +
>>   linux-headers/asm-arm64/kvm.h                 |   1 +
>>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>>   linux-headers/asm-generic/unistd.h            |   5 +-
>>   linux-headers/asm-loongarch/kvm.h             |   5 +
>>   linux-headers/asm-loongarch/kvm_para.h        |   1 +
>>   linux-headers/asm-loongarch/unistd_64.h       |   2 +
>>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>>   linux-headers/asm-riscv/kvm.h                 |  11 +-
>>   linux-headers/asm-riscv/ptrace.h              |  37 ++
>>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>>   linux-headers/asm-s390/unistd_32.h            | 446 ------------------
>>   linux-headers/asm-s390/unistd_64.h            |   1 +
>>   linux-headers/asm-x86/kvm.h                   |  21 +-
>>   linux-headers/asm-x86/unistd_32.h             |   1 +
>>   linux-headers/asm-x86/unistd_64.h             |   1 +
>>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>>   linux-headers/linux/const.h                   |  18 +
>>   linux-headers/linux/iommufd.h                 |  48 ++
>>   linux-headers/linux/kvm.h                     |  46 +-
>>   linux-headers/linux/mshv.h                    |   4 +-
>>   linux-headers/linux/psp-sev.h                 |   2 +-
>>   linux-headers/linux/stddef.h                  |   4 +
>>   linux-headers/linux/vduse.h                   |  85 +++-
>>   linux-headers/linux/vfio.h                    |  30 +-
>>   38 files changed, 711 insertions(+), 493 deletions(-)
>>   create mode 100644 include/standard-headers/linux/typelimits.h
>>   create mode 100644 include/standard-headers/linux/virtio_rtc.h
>>   delete mode 100644 linux-headers/asm-s390/unistd_32.h
>
> The linux headers update needs to be regenerated with this fix :
>
> https://lore.kernel.org/qemu-devel/20260511111913.3327672-1-clg@redhat.com/
>
Got it , we will add this patch.

Thanks.
Song Gao
> Thanks,
>
> C.


