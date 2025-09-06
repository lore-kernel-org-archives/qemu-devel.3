Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5B6CA0FED
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 01:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuhts-0006Vj-IW; Fri, 05 Sep 2025 21:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uuhtm-0006Uk-Om
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 21:39:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uuhtX-00076I-Df
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 21:39:23 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cx6tGzkLtoGkwHAA--.15645S3;
 Sat, 06 Sep 2025 09:38:59 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxXMGwkLtoyyuBAA--.27145S3;
 Sat, 06 Sep 2025 09:38:58 +0800 (CST)
Subject: Re: [PATCH v6 03/11] hw/loongarch: add misc register supoort avecintc
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250904121840.2023683-1-gaosong@loongson.cn>
 <20250904121840.2023683-4-gaosong@loongson.cn>
 <f84a1c1b-ddfe-bfe7-b40f-bbc10b5e6434@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <038b07e2-2d37-2980-af71-547612cfd692@loongson.cn>
Date: Sat, 6 Sep 2025 09:42:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f84a1c1b-ddfe-bfe7-b40f-bbc10b5e6434@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxXMGwkLtoyyuBAA--.27145S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr13uFW8Xr1xtry7XFyfXwc_yoW5XF18pr
 1kJryUGryUGr1kJr1UGr1UXryUJr1Dt3Wqqr1UJFyUJr4UJr1jvr1UXryqgryUAw48Jr1U
 Jr1UJr17ZF1UXrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.794,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

在 2025/9/5 下午4:40, Bibo Mao 写道:
>
>
> On 2025/9/4 下午8:18, Song Gao wrote:
>> Add feature register and misc register for avecintc feature checking and
>> setting
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/loongarch/virt.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 1a2aa92c25..124f96af03 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -560,6 +560,10 @@ static MemTxResult virt_iocsr_misc_write(void 
>> *opaque, hwaddr addr,
>>               return MEMTX_OK;
>>           }
>>   +        if (val & BIT(IOCSRM_AVEC_EN)) {
>> +            lvms->misc_status |= BIT(IOCSRM_AVEC_EN);
>> +        }
>> +
> how about adding virt_has_avecintc(lvms) here, such as
>            if (virt_has_avecintc(lvms) && val & BIT(IOCSRM_AVEC_EN)) {
>                lvms->misc_status |= BIT(IOCSRM_AVEC_EN);
>            }
>
Got it , I will correct it on v7.

Thanks.
Song Gao
> Otherwise looks good to me.
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>
>
> Regards
> Bibo Mao
>
>>           features = address_space_ldl(&lvms->as_iocsr,
>>                                        EXTIOI_VIRT_BASE + 
>> EXTIOI_VIRT_CONFIG,
>>                                        attrs, NULL);
>> @@ -595,6 +599,9 @@ static MemTxResult virt_iocsr_misc_read(void 
>> *opaque, hwaddr addr,
>>           break;
>>       case FEATURE_REG:
>>           ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | 
>> BIT(IOCSRF_CSRIPI);
>> +        if (virt_has_avecintc(lvms)) {
>> +            ret |= BIT(IOCSRF_AVEC);
>> +        }
>>           if (kvm_enabled()) {
>>               ret |= BIT(IOCSRF_VM);
>>           }
>> @@ -624,6 +631,10 @@ static MemTxResult virt_iocsr_misc_read(void 
>> *opaque, hwaddr addr,
>>           if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
>>               ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
>>           }
>> +        if (virt_has_avecintc(lvms) &&
>> +            (lvms->misc_status & BIT(IOCSRM_AVEC_EN))) {
>> +            ret |= BIT_ULL(IOCSRM_AVEC_EN);
>> +        }
>>           break;
>>       default:
>>           g_assert_not_reached();
>>


