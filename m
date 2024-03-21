Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D84FC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 03:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn9Qo-0006iu-1G; Wed, 20 Mar 2024 23:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rn9Ql-0006im-Ve
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 23:49:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rn9Qg-0000qN-Ax
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 23:49:27 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxaOg8rvtlNqkbAA--.46233S3;
 Thu, 21 Mar 2024 11:49:16 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxPs86rvtlxmZfAA--.53595S3; 
 Thu, 21 Mar 2024 11:49:16 +0800 (CST)
Subject: Re: [PATCH v1] target/loongarch: Fix qemu-system-loongarch64 assert
 failed with the option '-d int'
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn
References: <20240321021155.1696910-1-gaosong@loongson.cn>
 <aa8ebf98-6b7f-4a5b-9ef3-4257a1bfdd1a@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <894fcc4b-c4b2-87e3-8cb1-f1ac8eeae425@loongson.cn>
Date: Thu, 21 Mar 2024 11:49:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <aa8ebf98-6b7f-4a5b-9ef3-4257a1bfdd1a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxPs86rvtlxmZfAA--.53595S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GFy5GFyUGrW5Ww4DKF1ruFX_yoW7XrykpF
 s7C39rGFyUAw1kZr1UJw4YkFy5Gr4UXa1UJr18Xa45trsayr1qgr1vqFWqgF13Gr4xGr1U
 ZF4UZr9rZ3W5CrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.399,
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

在 2024/3/21 上午10:50, Richard Henderson 写道:
> On 3/20/24 16:11, Song Gao wrote:
>> qemu-system-loongarch64 assert failed with the option '-d int',
>> the helper_idle() raise an exception EXCP_HLT, but the exception name 
>> is undefined.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/cpu.c | 75 ++++++++++++++++++++++++++----------------
>>   1 file changed, 46 insertions(+), 29 deletions(-)
>>
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index f6ffb3aadb..17a923de02 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -45,33 +45,46 @@ const char * const fregnames[32] = {
>>       "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",
>>   };
>>   -static const char * const excp_names[] = {
>> -    [EXCCODE_INT] = "Interrupt",
>> -    [EXCCODE_PIL] = "Page invalid exception for load",
>> -    [EXCCODE_PIS] = "Page invalid exception for store",
>> -    [EXCCODE_PIF] = "Page invalid exception for fetch",
>> -    [EXCCODE_PME] = "Page modified exception",
>> -    [EXCCODE_PNR] = "Page Not Readable exception",
>> -    [EXCCODE_PNX] = "Page Not Executable exception",
>> -    [EXCCODE_PPI] = "Page Privilege error",
>> -    [EXCCODE_ADEF] = "Address error for instruction fetch",
>> -    [EXCCODE_ADEM] = "Address error for Memory access",
>> -    [EXCCODE_SYS] = "Syscall",
>> -    [EXCCODE_BRK] = "Break",
>> -    [EXCCODE_INE] = "Instruction Non-Existent",
>> -    [EXCCODE_IPE] = "Instruction privilege error",
>> -    [EXCCODE_FPD] = "Floating Point Disabled",
>> -    [EXCCODE_FPE] = "Floating Point Exception",
>> -    [EXCCODE_DBP] = "Debug breakpoint",
>> -    [EXCCODE_BCE] = "Bound Check Exception",
>> -    [EXCCODE_SXD] = "128 bit vector instructions Disable exception",
>> -    [EXCCODE_ASXD] = "256 bit vector instructions Disable exception",
>> +struct TypeExcp {
>> +    int32_t exccode;
>> +    const char *name;
>> +};
>> +
>> +static const struct TypeExcp excp_names[] = {
>> +    {EXCCODE_INT, "Interrupt"},
>> +    {EXCCODE_PIL, "Page invalid exception for load"},
>> +    {EXCCODE_PIS, "Page invalid exception for store"},
>> +    {EXCCODE_PIF, "Page invalid exception for fetch"},
>> +    {EXCCODE_PME, "Page modified exception"},
>> +    {EXCCODE_PNR, "Page Not Readable exception"},
>> +    {EXCCODE_PNX, "Page Not Executable exception"},
>> +    {EXCCODE_PPI, "Page Privilege error"},
>> +    {EXCCODE_ADEF, "Address error for instruction fetch"},
>> +    {EXCCODE_ADEM, "Address error for Memory access"},
>> +    {EXCCODE_SYS, "Syscall"},
>> +    {EXCCODE_BRK, "Break"},
>> +    {EXCCODE_INE, "Instruction Non-Existent"},
>> +    {EXCCODE_IPE, "Instruction privilege error"},
>> +    {EXCCODE_FPD, "Floating Point Disabled"},
>> +    {EXCCODE_FPE, "Floating Point Exception"},
>> +    {EXCCODE_DBP, "Debug breakpoint"},
>> +    {EXCCODE_BCE, "Bound Check Exception"},
>> +    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
>> +    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
>>   };
>>     const char *loongarch_exception_name(int32_t exception)
>>   {
>> -    assert(excp_names[exception]);
>> -    return excp_names[exception];
>> +    int i;
>> +    const char *name = "unknown";
>> +
>> +    for (i = 0; i < ARRAY_SIZE(excp_names); i++) {
>> +        if (excp_names[i].exccode == exception) {
>> +            name = excp_names[i].name;
>> +            break;
>> +        }
>> +    }
>> +    return name;
>>   }
>
> I think you should return null for unknown, and then...
>
>>     void G_NORETURN do_raise_exception(CPULoongArchState *env,
>> @@ -79,11 +92,17 @@ void G_NORETURN 
>> do_raise_exception(CPULoongArchState *env,
>>                                      uintptr_t pc)
>>   {
>>       CPUState *cs = env_cpu(env);
>> +    const char *name;
>>   +    if (exception == EXCP_HLT) {
>> +        name = "EXCP_HLT";
>> +    } else {
>> +        name = loongarch_exception_name(exception);
>> +    }
>>       qemu_log_mask(CPU_LOG_INT, "%s: %d (%s)\n",
>>                     __func__,
>>                     exception,
>> -                  loongarch_exception_name(exception));
>> +                  name);
>
> ... use two different printfs, one of which prints the exception number.
> Why would you special case HLT here instead of putting it in the table?
>
Hmm,  put HLT in the table no problem.  I will correct it.

I considered HLT not a real exception to the LoongAarh architecture, so 
I didn't put it in the table.

Thanks.
Song Gao
>
> r~


