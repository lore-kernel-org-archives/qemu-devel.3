Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86F4C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 01:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhJPu-0005HT-95; Mon, 04 Mar 2024 20:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rhJPo-0005HA-Ek
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 20:16:20 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rhJPk-0001Zx-19
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 20:16:20 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8CxWOhWcuZlNHkUAA--.31777S3;
 Tue, 05 Mar 2024 09:16:07 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxHs9TcuZl3TROAA--.11193S3; 
 Tue, 05 Mar 2024 09:16:05 +0800 (CST)
Subject: Re: [PATCH v2] target/loongarch: Add TCG macro in structure
 CPUArchState
To: Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240304021844.1449164-1-maobibo@loongson.cn>
 <a6fa3bf6-2e5f-4068-82ec-44720e4be34a@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <09bce0ed-ca25-ec0a-872d-693c4f33d3ba@loongson.cn>
Date: Tue, 5 Mar 2024 09:16:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a6fa3bf6-2e5f-4068-82ec-44720e4be34a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxHs9TcuZl3TROAA--.11193S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF1xWFWUXrW5WFy5Ww13KFX_yoW8Wr1xp3
 97JFW5CFWUJrs5X347J3s0gFy5Jr4UJ3srZr1kXFyUAF4xAr4Y9ryjqrZIgFyDArWrXr1U
 ZF48ArnxuF4UXFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.098,
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



On 2024/3/5 上午12:53, Richard Henderson wrote:
> On 3/3/24 16:18, Bibo Mao wrote:
>> @@ -696,11 +700,15 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE 
>> *f, int flags)
>>   {
>>       LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>>       CPULoongArchState *env = &cpu->env;
>> -    int i;
>> +    int i, fp_status;
>> +#ifdef CONFIG_TCG
>> +    fp_status = get_float_exception_flags(&env->fp_status);
>> +#else
>> +    fp_status = 0;
>> +#endif
>>       qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
>> -    qemu_fprintf(f, " FCSR0 0x%08x  fp_status 0x%02x\n", env->fcsr0,
>> -                 get_float_exception_flags(&env->fp_status));
>> +    qemu_fprintf(f, " FCSR0 0x%08x  fp_status 0x%02x\n", env->fcsr0, 
>> fp_status);
> 
> fp_status, I think, is unnecessary to print all of the time.
> 
> In update_fcsr0_mask, we ensure that fcsr0 is updated and 
> fp_status.exception_flags is 0. So I would expect this field to be 0 all 
> of the time -- anything else is a bug.
> 
yes, fp_status is temporary status during float instruction translation, 
it will clear to 0 when fp instruction translation is done.

Will remove print sentence.

>> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>> +static bool tlb_needed(void *opaque)
>> +{
>> +    if (kvm_enabled()) {
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
> 
> Better as return tcg_enabled();
Will return as tcg_enabled(), it is more simpler.

Regards
Bibo Mao
> 
> 
> r~


