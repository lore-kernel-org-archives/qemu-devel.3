Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BBFCD5BAE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 12:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smBcn-0003KI-Uu; Thu, 05 Sep 2024 08:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1smBci-0003HZ-0T
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 08:30:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1smBcd-0003iC-3x
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 08:30:01 -0400
Received: from loongson.cn (unknown [10.20.42.17])
 by gateway (Coremail) with SMTP id _____8CxrptCpNlmGWIrAA--.57501S3;
 Thu, 05 Sep 2024 20:29:54 +0800 (CST)
Received: from [10.20.42.17] (unknown [10.20.42.17])
 by front1 (Coremail) with SMTP id qMiowMCxfNw+pNlmiAcFAA--.22272S3;
 Thu, 05 Sep 2024 20:29:52 +0800 (CST)
Subject: Re: [PATCH 1/5] target/loongarch: Add a new cpu_type la664
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, maobibo@loongson.cn
References: <20240729013939.1807982-1-gaosong@loongson.cn>
 <20240729013939.1807982-2-gaosong@loongson.cn>
 <297a595b-bbfa-47f8-a958-04d0140579af@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <b6b1aa4c-e9cb-3160-a1d2-0f7f0df68991@loongson.cn>
Date: Thu, 5 Sep 2024 20:29:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <297a595b-bbfa-47f8-a958-04d0140579af@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxfNw+pNlmiAcFAA--.22272S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWxGr17uryUKw17WF4kAFc_yoW8Wry7pF
 n2yFZIqFWUXrn7Ww4aqr98WF98Ar4xJ3ZrXF4Sq3W8Jr4DZr92gw1UXr4qgFyDJ3y8XF17
 Zry0q39xuF17JrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.9,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


在 2024/9/5 下午6:32, Philippe Mathieu-Daudé 写道:
> Hi,
>
> On 29/7/24 03:39, Song Gao wrote:
>> Add a new LoongArch cpu type la664. The la664 has many new features,
>> such as new atomic instructions, hardware page table walk, etc.
>> We will implement them later.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/cpu.c | 48 +++++++++++++++++++++++++++++++-----------
>>   1 file changed, 36 insertions(+), 12 deletions(-)
>
>
>> +static void loongarch_la664_initfn(Object *obj)
>> +{
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>> +    CPULoongArchState *env = &cpu->env;
>> +    int i;
>> +
>> +    for (i = 0; i < 21; i++) {
>
> In order to remove the '21' magic value, can we use:
>
>       for (unsigned i = 0; i < ARRAY_SIZE(env->cpucfg); i++) {
Thank you,   I will correct it on v2.

Thanks.
Song Gao
>
>> +        env->cpucfg[i] = 0x0;
>> +    }
>> +
>> +    cpu->dtb_compatible = "loongarch,Loongson-3A6000";
>> +    env->cpucfg[0] = 0x14d000; /* PRID */
>> +
>> +    loongarch_common_initfn(env, obj);
>> +}
>> +
>> +static void loongarch_la464_initfn(Object *obj)
>> +{
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>> +    CPULoongArchState *env = &cpu->env;
>> +    int i;
>> +
>> +    for (i = 0; i < 21; i++) {
>
> Ditto.
>
>> +        env->cpucfg[i] = 0x0;
>> +    }
>> +
>> +    cpu->dtb_compatible = "loongarch,Loongson-3A5000";
>> +    env->cpucfg[0] = 0x14c010;  /* PRID */
>> +
>> +    loongarch_common_initfn(env, obj);
>> +}


