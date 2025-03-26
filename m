Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F81FC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 06:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txK3b-0003oP-Jh; Wed, 26 Mar 2025 02:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1txK3Z-0003ns-Go
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:16:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1txK3V-0002Zv-AS
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:16:05 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxLGuXm+Nn9r6mAA--.17206S3;
 Wed, 26 Mar 2025 14:15:51 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxzMSPm+Nn_QphAA--.25136S3;
 Wed, 26 Mar 2025 14:15:50 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/boot: Adjust the loading position of the
 initrd
To: lixianglai <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <20250319083216.438159-1-lixianglai@loongson.cn>
 <7eb54b16-84ad-8b3e-fe5f-bc7435917fe3@loongson.cn>
 <607fcf63-1d51-c2f8-593d-7e59702406e9@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <1bd8704f-a102-14ea-2cfe-f069438ad4ad@loongson.cn>
Date: Wed, 26 Mar 2025 14:15:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <607fcf63-1d51-c2f8-593d-7e59702406e9@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzMSPm+Nn_QphAA--.25136S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw13ZF4xJr1fXFyxWr18CrX_yoW3CrW3pr
 s7JFy5Jr98Arn5Jr1xKF1UWry7Aw18G3W5Xr1xXFy8Jrsrtr1jgr1UXryvgryDJw48JF1U
 Xr1UXrnrZF13JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.031,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/3/26 上午10:51, lixianglai wrote:
> 
> 
> Hi bibo mao:
>> Xianglai,
>>
>> Thanks for your patch, some comments inline.
>>
>> On 2025/3/19 下午4:32, Xianglai Li wrote:
>>> When only the -kernel parameter is used to load the elf kernel,
>>> the initrd is loaded in the ram. If the initrd size is too large,
>>> the loading fails, resulting in a VM startup failure.
>>> This patch first loads initrd near the kernel.
>>> When the nearby memory space of the kernel is insufficient,
>>> it tries to load it to the starting position of high-end memory.
>>> If there is still not enough, qemu will report an error
>>> and ask the user to increase the memory space for the
>>> virtual machine to boot.
>>>
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> ---
>>> Cc: Bibo Mao <maobibo@loongson.cn>
>>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Cc: Song Gao <gaosong@loongson.cn>
>>> Cc: Xianglai Li <lixianglai@loongson.cn>
>>>
>>>   hw/loongarch/boot.c         | 66 ++++++++++++++++++++++++++++++++-----
>>>   hw/loongarch/virt.c         |  1 +
>>>   include/hw/loongarch/boot.h |  1 +
>>>   3 files changed, 59 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>>> index 354cf458c8..3f094ebb39 100644
>>> --- a/hw/loongarch/boot.c
>>> +++ b/hw/loongarch/boot.c
>>> @@ -235,6 +235,61 @@ static int64_t load_loongarch_linux_image(const 
>>> char *filename,
>>>       return size;
>>>   }
>>>   +static void find_initrd_loadoffset(struct loongarch_boot_info *info,
>>> +                uint64_t kernel_high, ssize_t kernel_size)
>>> +{
>>> +    hwaddr base, size, gap;
>>> +    ram_addr_t initrd_end, initrd_start;
>>> +    int nb_numa_nodes;
>>> +    NodeInfo *numa_info;
>>> +
>>> +    base = VIRT_LOWMEM_BASE;
>>> +    gap = VIRT_LOWMEM_SIZE;
>>> +    nb_numa_nodes = info->numa_state->num_nodes;
>>> +    numa_info = info->numa_state->nodes;
>>> +    initrd_start = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
>>> +    initrd_end = initrd_start + initrd_size;
>>> +
>>> +    if (nb_numa_nodes) {
>>> +        size = numa_info[0].node_mem;
>> why is memory size of the node0 calculated here?
>> initrd memory can be put at these places:
>> 1) near kernel at low memory region.
>> 2) start from high memory region located at VIRT_HIGHMEM_BASE
>>
>> It seems that it irrelative with numa memory
> 
> When the initrd cannot be loaded in the low memory,
> we plan to load the initrd to the starting address of the high memory,
> so we need to determine whether the high memory has enough space to put 
> the initrd.
> Meanwhile, we hope that the initrd can be loaded on node0 as much as 
> possible
> and avoid crossing memory nodes as much as possible.
> 
> When qemu specifies the node0 memory size and when no node0 memory size 
> is specified,
> the calculation method of the node0 memory size is different,
> so we introduce the calculation of the node0 memory here.
> 
> If the memory size of node 0 is completely unable to load initrd,
> we will ask users to increase the memory size of node 0,
It is a little too strict requirement. I think we should assure that it 
can work at first, and then work better to put it in node0.

Just for example, there two 256MB memory in node0(low memory) and 
node1(high memory), user may think that the total memory size is enough 
for initrd loading.

Regards
Bibo Mao
> and do not consider loading initrd to other memory nodes,
> so as to simplify the calculation process
> 
>>> +    } else {
>>> +        size = info->ram_size;
>>> +    }
>>> +    /*
>>> +     * Try to load the initrd near the kernel image
>>> +     */
>>> +    if (size <= gap) {
>>> +        if (initrd_end <= (base + gap)) {
>>> +            initrd_offset = initrd_start;
>>> +            return ;
>>> +        }
>> no else here. otherwise the sentence as following "size -= gap;" will 
>> be negative.
> 
> Yes,This is a bug, I will fix it!
>>> +    }
>>> +
>>> +    /*
>>> +     * Try to load initrd in the high memory of node0
>>> +     */
>>> +    size -= gap;
>>> +    base = VIRT_HIGHMEM_BASE;
>>> +    initrd_start = ROUND_UP(base, 64 * KiB);
>>> +    initrd_end = initrd_start + initrd_size;
>>> +    if (initrd_end <= (base + size)) {
>> it is a little complicated,  just the following will be ok
>>    if (initrd_size <= size) {
>>        initrd_offset = base;
>>         return;
>>    }
>>
> Ok!!
> 
> Thanks!
> Xianglai.
> 
>> Regards
>> Bibo Mao
>>> +        initrd_offset = initrd_start;
>>> +        return ;
>>> +    }
>>> +
>>> +    if (nb_numa_nodes == 0) {
>>> +        error_report("memory too small for initial ram disk '%s',"
>>> +             "You need to expand the memory space",
>>> +             info->initrd_filename);
>>> +    } else {
>>> +        error_report("memory too small for initial ram disk '%s',"
>>> +            "You need to expand the memory space of node0",
>>> +            info->initrd_filename);
>>> +
>>> +    }
>>> +    exit(1);
>>> +}
>>> +
>>>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>>>   {
>>>       uint64_t kernel_entry, kernel_low, kernel_high;
>>> @@ -261,16 +316,9 @@ static int64_t load_kernel_info(struct 
>>> loongarch_boot_info *info)
>>>       if (info->initrd_filename) {
>>>           initrd_size = get_image_size(info->initrd_filename);
>>>           if (initrd_size > 0) {
>>> -            initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 
>>> 64 * KiB);
>>> -
>>> -            if (initrd_offset + initrd_size > info->ram_size) {
>>> -                error_report("memory too small for initial ram disk 
>>> '%s'",
>>> -                             info->initrd_filename);
>>> -                exit(1);
>>> -            }
>>> -
>>> +            find_initrd_loadoffset(info, kernel_high, kernel_size);
>>>               initrd_size = 
>>> load_image_targphys(info->initrd_filename, initrd_offset,
>>> -                                              info->ram_size - 
>>> initrd_offset);
>>> +                                              initrd_size);
>>>           }
>>>             if (initrd_size == (target_ulong)-1) {
>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>> index a5840ff968..eb62abec0e 100644
>>> --- a/hw/loongarch/virt.c
>>> +++ b/hw/loongarch/virt.c
>>> @@ -750,6 +750,7 @@ static void virt_init(MachineState *machine)
>>> qemu_register_powerdown_notifier(&lvms->powerdown_notifier);
>>>         lvms->bootinfo.ram_size = ram_size;
>>> +    lvms->bootinfo.numa_state = machine->numa_state;
>>>       loongarch_load_kernel(machine, &lvms->bootinfo);
>>>   }
>>>   diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
>>> index b3b870df1f..e3887d7cc6 100644
>>> --- a/include/hw/loongarch/boot.h
>>> +++ b/include/hw/loongarch/boot.h
>>> @@ -98,6 +98,7 @@ struct efi_initrd {
>>>     struct loongarch_boot_info {
>>>       uint64_t ram_size;
>>> +    struct NumaState *numa_state;
>>>       const char *kernel_filename;
>>>       const char *kernel_cmdline;
>>>       const char *initrd_filename;
>>>
> 


