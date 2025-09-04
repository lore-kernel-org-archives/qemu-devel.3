Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EC8CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 11:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu8bX-0001y4-Hp; Thu, 04 Sep 2025 07:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uu8bT-0001xF-Qb
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 07:58:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uu8bK-0007Zs-06
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 07:58:11 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxP_DAfrlomKYGAA--.13996S3;
 Thu, 04 Sep 2025 19:57:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxpeS9frloW+99AA--.4356S3;
 Thu, 04 Sep 2025 19:57:52 +0800 (CST)
Subject: Re: [PATCH v3 3/3] hw/loongarch/virt: Register reset interface with
 CPU object
To: Igor Mammedov <imammedo@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20250903023556.3082693-1-maobibo@loongson.cn>
 <20250903023556.3082693-4-maobibo@loongson.cn>
 <20250904101347.0599daab@fedora>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5be0c9ed-d572-42e0-e6aa-607483410bea@loongson.cn>
Date: Thu, 4 Sep 2025 19:55:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250904101347.0599daab@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpeS9frloW+99AA--.4356S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1rtr4fKFyfCFykAFyxWFX_yoW5Aw13pr
 W3CF1YkF4ktr1DX3y2qas8CF1DXr1xKF43ZF4ftFySyws8Jryjqr10qa9I9FyUA34FgF1F
 qrnYyw1ava1UJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU82-e7UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.794,
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



On 2025/9/4 下午4:13, Igor Mammedov wrote:
> On Wed,  3 Sep 2025 10:35:56 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> With cpu hotplug is implemented on LoongArch virt machine, reset
>> interface with hot-added CPU should be registered. Otherwise there
>> will be problem if system reboots after cpu is hot-added.
>>
>> Now register reset interface with CPU object is realized and remove
>> the reset interface with CPU object unrealizd.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/boot.c    | 13 -------------
>>   target/loongarch/cpu.c |  4 ++++
>>   2 files changed, 4 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index 5799b4c75c..a516415822 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -350,13 +350,6 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>>       return kernel_entry;
>>   }
>>   
>> -static void reset_load_elf(void *opaque)
>> -{
>> -    LoongArchCPU *cpu = opaque;
>> -
>> -    cpu_reset(CPU(cpu));
>> -}
>> -
>>   static void fw_cfg_add_kernel_info(struct loongarch_boot_info *info,
>>                                      FWCfgState *fw_cfg)
>>   {
>> @@ -439,12 +432,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
>>   void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
>>   {
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
>> -    int i;
>> -
>> -    /* register reset function */
>> -    for (i = 0; i < ms->smp.cpus; i++) {
>> -        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cpu(i)));
>> -    }
>>   
>>       info->kernel_filename = ms->kernel_filename;
>>       info->kernel_cmdline = ms->kernel_cmdline;
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index 3a7621c0ea..9edb8ebc4d 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -668,6 +668,9 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>>   
>>       qemu_init_vcpu(cs);
>>       cpu_reset(cs);
>> + #ifndef CONFIG_USER_ONLY
>> +    qemu_register_resettable(OBJECT(dev));
>> + #endif
> 
> I'd put this in virt_cpu_plug() as last step, which should work both for
> cold and hotpluged cpus. And drop CONFIG_USER_ONLY while at it.
With symmetry is the same with qemu_unregister_resettable() 
Symmetrically, to put it in virt_cpu_unplug()?

If there are many boards in future, the boards do not need to care about 
registering cpu reset interface, which is done in CPU object already.

Regards
Bibo Mao
> 
> with that
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> PS:
> the rest of the patches are very arch specific so I won't review them.
> 
>>   
>>       lacc->parent_realize(dev, errp);
>>   }
>> @@ -678,6 +681,7 @@ static void loongarch_cpu_unrealizefn(DeviceState *dev)
>>   
>>   #ifndef CONFIG_USER_ONLY
>>       cpu_remove_sync(CPU(dev));
>> +    qemu_unregister_resettable(OBJECT(dev));
>>   #endif
>>   
>>       lacc->parent_unrealize(dev);
> 


