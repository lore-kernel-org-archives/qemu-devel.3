Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C3BC30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 01:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPYBK-0007KX-9G; Thu, 04 Jul 2024 21:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sPYBH-0007AU-TT
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 21:56:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sPYBF-0001qc-9D
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 21:56:11 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxH_GzUodmMSIBAA--.3879S3;
 Fri, 05 Jul 2024 09:56:04 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxWcaxUodm2sQ7AA--.7174S3; 
 Fri, 05 Jul 2024 09:56:03 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Set CSR_PRCFG1 and CSR_PRCFG2 values
To: maobibo <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org
References: <20240704111218.712654-1-gaosong@loongson.cn>
 <5d7ff632-4d78-bb81-0969-a1ab656e22bc@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <fc16786a-3186-997d-2789-0c1efed91952@loongson.cn>
Date: Fri, 5 Jul 2024 09:56:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5d7ff632-4d78-bb81-0969-a1ab656e22bc@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxWcaxUodm2sQ7AA--.7174S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww4DZF4xur1kGr4xur4xZrc_yoW8tF4kpr
 4vyrZ0v398JF4kA34xAw1Yq343Xr4Ik3Z7Aa48Cas2krZ8Xr9aqFWvgFsFgF17A3yFyr42
 vF12yFyUZFsrZFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.243,
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

在 2024/7/4 下午8:47, maobibo 写道:
>
>
> On 2024/7/4 下午7:12, Song Gao wrote:
>> We set the value of register CSR_PRCFG3, but left out CSR_PRCFG1
>> and CSR_PRCFG2. Set CSR_PRCFG1 and CSR_PRCFG2 according to the
>> default values of the physical machine.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/cpu.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index 270f711f11..ad40750701 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -538,6 +538,12 @@ static void loongarch_cpu_reset_hold(Object 
>> *obj, ResetType type)
>>       env->CSR_MERRCTL = FIELD_DP64(env->CSR_MERRCTL, CSR_MERRCTL, 
>> ISMERR, 0);
>>       env->CSR_TID = cs->cpu_index;
>>   +    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, 
>> SAVE_NUM, 8);
>> +    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, 
>> TIMER_BITS, 0x2f);
>> +    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 
>> 7);
>> +
>> +    env->CSR_PRCFG2 = 0x3ffff000;
>> +
>>       env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, 
>> TLB_TYPE, 2);
>>       env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, 
>> MTLB_ENTRY, 63);
>>       env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, 
>> STLB_WAYS, 7);
>>
> For the function, it looks good to me. There are some nits:
> For PRCFG1-PRCFG3, it is constant. I thinks it had better be put at 
> cpu instance_init() or instance_finalize().
You are right, we should put them in instance_init().
>
> Also it is strange that most of cpu_state should be cleared with 0 
> besides cpucfg/prcfg etc, such as end_reset_fields marker in other 
> architectures.
>
> Maybe it will better if there is double check with cpu state change 
> callback such as init/reset etc :)
>
The CSRs that need to be reset are from chapter 6, section 4 of the 
manual, and they are not always reset to 0.
I think maybe that's why end_reset_fields was not used at the time. We 
should add some comments to loongarch_cpu_reset_hold().

Thanks.
Song Gao
> Regards
> Bibo Mao


