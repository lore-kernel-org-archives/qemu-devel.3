Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C67C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0ylo-0007kF-Vj; Sun, 28 Apr 2024 03:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s0yll-0007jK-7s
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:16:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s0ylg-0000D0-N0
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:16:16 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxCuqx9y1m8UcEAA--.3470S3;
 Sun, 28 Apr 2024 15:16:02 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxc1at9y1mExIIAA--.5617S3; 
 Sun, 28 Apr 2024 15:15:59 +0800 (CST)
Subject: Re: [PATCH v7 03/17] hw/loongarch: Add slave cpu boot_code
To: maobibo <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 philmd@linaro.org, zltjiangshi@gmail.com
References: <20240426091551.2397867-1-gaosong@loongson.cn>
 <20240426091551.2397867-4-gaosong@loongson.cn>
 <1585a9b4-57e1-6f18-34c5-de4bba582c49@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3b141051-7b8b-15e8-4628-3b629f4df882@loongson.cn>
Date: Sun, 28 Apr 2024 15:15:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1585a9b4-57e1-6f18-34c5-de4bba582c49@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dxc1at9y1mExIIAA--.5617S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr4DKFW7KF15XrWxKFW3urX_yoW7GFW8pF
 18JFW5AryUJrn5JrsrJF15XFy5JF10g3WDJF1xWF1Utw13Xr1jgr1UWr9FgF1DJr48Xr17
 Zr17XrnxZFsrtrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.307,
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

在 2024/4/28 上午9:15, maobibo 写道:
>
>
> On 2024/4/26 下午5:15, Song Gao wrote:
>
> Message text is missing here :(
>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Message-Id: <20240307164835.300412-4-gaosong@loongson.cn>
> It is strange that there is "Message-Id:" string. Is it required here?
>
Message_ID helps to find the original email and see more comments.

Here we can not add it, but it is required in QEMU PR.

Thanks.
Song Gao
> The others look good to me, especially when bootrom for AP is put at 
> BIOS flash area.
>
> Regards
> Bibo Mao
>
>> ---
>>   hw/loongarch/boot.c | 62 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 61 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index a9522d6912..d1a8434127 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -15,6 +15,54 @@
>>   #include "sysemu/reset.h"
>>   #include "sysemu/qtest.h"
>>   +static const unsigned int slave_boot_code[] = {
>> +                  /* Configure reset ebase. */
>> +    0x0400302c,   /* csrwr      $t0, LOONGARCH_CSR_EENTRY */
>> +
>> +                  /* Disable interrupt. */
>> +    0x0380100c,   /* ori        $t0, $zero,0x4 */
>> +    0x04000180,   /* csrxchg    $zero, $t0, LOONGARCH_CSR_CRMD */
>> +
>> +                  /* Clear mailbox. */
>> +    0x1400002d,   /* lu12i.w    $t1, 1(0x1) */
>> +    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20  */
>> +    0x06481da0,   /* iocsrwr.d  $zero, $t1 */
>> +
>> +                  /* Enable IPI interrupt. */
>> +    0x1400002c,   /* lu12i.w    $t0, 1(0x1) */
>> +    0x0400118c,   /* csrxchg    $t0, $t0, LOONGARCH_CSR_ECFG */
>> +    0x02fffc0c,   /* addi.d     $t0, $r0,-1(0xfff) */
>> +    0x1400002d,   /* lu12i.w    $t1, 1(0x1) */
>> +    0x038011ad,   /* ori        $t1, $t1, CORE_EN_OFF */
>> +    0x064819ac,   /* iocsrwr.w  $t0, $t1 */
>> +    0x1400002d,   /* lu12i.w    $t1, 1(0x1) */
>> +    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20 */
>> +
>> +                  /* Wait for wakeup <.L11>:                  */
>> +    0x06488000,   /* idle       0x0 */
>> +    0x03400000,   /* andi       $zero, $zero, 0x0 */
>> +    0x064809ac,   /* iocsrrd.w  $t0, $t1 */
>> +    0x43fff59f,   /* beqz       $t0, -12(0x7ffff4) # 48 <.L11> */
>> +
>> +                  /* Read and clear IPI interrupt. */
>> +    0x1400002d,   /* lu12i.w    $t1, 1(0x1) */
>> +    0x064809ac,   /* iocsrrd.w  $t0, $t1 */
>> +    0x1400002d,   /* lu12i.w    $t1, 1(0x1) */
>> +    0x038031ad,   /* ori        $t1, $t1, CORE_CLEAR_OFF */
>> +    0x064819ac,   /* iocsrwr.w  $t0, $t1 */
>> +
>> +                  /* Disable  IPI interrupt. */
>> +    0x1400002c,   /* lu12i.w    $t0, 1(0x1) */
>> +    0x04001180,   /* csrxchg    $zero, $t0, LOONGARCH_CSR_ECFG */
>> +
>> +                  /* Read mail buf and jump to specified entry */
>> +    0x1400002d,   /* lu12i.w    $t1, 1(0x1) */
>> +    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20 */
>> +    0x06480dac,   /* iocsrrd.d  $t0, $t1 */
>> +    0x00150181,   /* move       $ra, $t0 */
>> +    0x4c000020,   /* jirl       $zero, $ra,0 */
>> +};
>> +
>>   static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t 
>> addr)
>>   {
>>       return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
>> @@ -126,11 +174,23 @@ static void loongarch_direct_kernel_boot(struct 
>> loongarch_boot_info *info)
>>           }
>>       }
>>   +    /* Load slave boot code at pflash0 . */
>> +    void *boot_code = g_malloc0(VIRT_FLASH0_SIZE);
>> +    memcpy(boot_code, &slave_boot_code, sizeof(slave_boot_code));
>> +    rom_add_blob_fixed("boot_code", boot_code, VIRT_FLASH0_SIZE, 
>> VIRT_FLASH0_BASE);
>> +
>>       CPU_FOREACH(cs) {
>>           lacpu = LOONGARCH_CPU(cs);
>>           lacpu->env.load_elf = true;
>> -        lacpu->env.elf_address = kernel_addr;
>> +        if (cs == first_cpu) {
>> +            lacpu->env.elf_address = kernel_addr;
>> +        } else {
>> +            lacpu->env.elf_address = VIRT_FLASH0_BASE;
>> +        }
>> +        lacpu->env.boot_info = info;
>>       }
>> +
>> +    g_free(boot_code);
>>   }
>>     void loongarch_load_kernel(MachineState *ms, struct 
>> loongarch_boot_info *info)
>>


