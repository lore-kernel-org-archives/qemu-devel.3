Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26763C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrck-0004HQ-8w; Wed, 02 Jul 2025 03:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uWrcj-0004HG-2h
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:11:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uWrcd-0003BZ-Fm
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:11:16 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxDeOM22Rouw4hAQ--.36488S3;
 Wed, 02 Jul 2025 15:11:08 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxocKI22RokWYGAA--.36276S3;
 Wed, 02 Jul 2025 15:11:07 +0800 (CST)
Subject: Re: [PATCH v3 4/9] target/loongarch: add msg interrupt CSR registers
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250627030138.2482055-1-gaosong@loongson.cn>
 <20250627030138.2482055-5-gaosong@loongson.cn>
 <790ff1fb-1dc7-9566-1fd5-697a4719a257@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <0f9c8cd8-a414-e0df-47c1-5b10949a316c@loongson.cn>
Date: Wed, 2 Jul 2025 15:13:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <790ff1fb-1dc7-9566-1fd5-697a4719a257@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxocKI22RokWYGAA--.36276S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKF17WFy5Cw4DCF45Xry8Xrc_yoW7Xr48pr
 n7AFWUJrW8GrZ7J3WxJ345XF9xXr18GanrXw4IqFy7KF47Jr1vgrW0qrZFgF15Aw4rKr10
 vr1UZry7ZF47XrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwMKuUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.077,
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

在 2025/7/2 上午10:24, Bibo Mao 写道:
>
>
> On 2025/6/27 上午11:01, Song Gao wrote:
>> include CSR_MSGIS0-3, CSR_MSGIR and CSR_MSGIE.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/cpu-csr.h |  3 +++
>>   target/loongarch/cpu.c     |  7 +++++++
>>   target/loongarch/cpu.h     | 10 ++++++++++
>>   target/loongarch/machine.c | 25 +++++++++++++++++++++++--
>>   4 files changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
>> index 0834e91f30..4792677086 100644
>> --- a/target/loongarch/cpu-csr.h
>> +++ b/target/loongarch/cpu-csr.h
>> @@ -186,6 +186,9 @@ FIELD(CSR_MERRCTL, ISMERR, 0, 1)
>>     #define LOONGARCH_CSR_CTAG           0x98 /* TagLo + TagHi */
>>   +#define LOONGARCH_CSR_MSGIS(N)       (0xa0 + N)
>> +#define LOONGARCH_CSR_MSGIR               0xa4
>> +
>>   /* Direct map windows CSRs*/
>>   #define LOONGARCH_CSR_DMW(N)         (0x180 + N)
>>   FIELD(CSR_DMW, PLV0, 0, 1)
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index abad84c054..bde9f917fc 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -523,6 +523,13 @@ static void loongarch_la464_initfn(Object *obj)
>>       env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, 
>> STLB_WAYS, 7);
>>       env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, 
>> STLB_SETS, 8);
>>   +    env->CSR_MSGIS[0] = 0;
>> +    env->CSR_MSGIS[1] = 0;
>> +    env->CSR_MSGIS[2] = 0;
>> +    env->CSR_MSGIS[3] = 0;
>> +    env->CSR_MSGIR = 0;
>> +    env->CSR_MSGIE = 0;
>> +
> The default value should zero for CSR register, I think it can be 
> removed here.
>
yes.
>>       loongarch_la464_init_csr(obj);
>>       loongarch_cpu_post_init(obj);
>>   }
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index 56fc4a1459..208d3e0cd3 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -233,6 +233,12 @@ FIELD(TLB_MISC, ASID, 1, 10)
>>   FIELD(TLB_MISC, VPPN, 13, 35)
>>   FIELD(TLB_MISC, PS, 48, 6)
>>   +/*Msg interrupt registers */
>> +FIELD(CSR_MSGIS, IS, 0, 63)
>> +FIELD(CSR_MSGIR, INTNUM, 0, 8)
>> +FIELD(CSR_MSGIR, ACTIVE, 31, 1)
>> +FIELD(CSR_MSGIE, PT, 0, 8)
>> +
>>   #define LSX_LEN    (128)
>>   #define LASX_LEN   (256)
>>   @@ -350,6 +356,10 @@ typedef struct CPUArchState {
>>       uint64_t CSR_DBG;
>>       uint64_t CSR_DERA;
>>       uint64_t CSR_DSAVE;
>> +    /* Msg interrupt registers */
>> +    uint64_t CSR_MSGIS[4];
>> +    uint64_t CSR_MSGIR;
>> +    uint64_t CSR_MSGIE;
>>       struct {
>>           uint64_t guest_addr;
>>       } stealtime;
>> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
>> index 4e70f5c879..1e276c08ac 100644
>> --- a/target/loongarch/machine.c
>> +++ b/target/loongarch/machine.c
>> @@ -45,6 +45,26 @@ static const VMStateDescription vmstate_fpu = {
>>       },
>>   };
>>   +static bool msg_needed(void *opaque)
>> +{
>> +    LoongArchCPU *cpu = opaque;
>> +
>> +    return FIELD_EX64(cpu->env.cpucfg[1], CPUCFG1, MSG_INT);
> For AVEC capability, there is bit MSG_INT in register cpucfg1 and bit 
> IOCSRF_AVEC in IOCSR FEATURE_REG register. Which should be used by 
> real hardware?
>
they use IOCSR bit, so  I will correct on v3 .
Thanks.
Song Gao
> Regards
> Bibo Mao
>> +}
>> +
>> +static const VMStateDescription vmstate_msg = {
>> +    .name = "cpu/msg",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = msg_needed,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT64_ARRAY(env.CSR_MSGIS, LoongArchCPU, 4),
>> +        VMSTATE_UINT64(env.CSR_MSGIR, LoongArchCPU),
>> +        VMSTATE_UINT64(env.CSR_MSGIE, LoongArchCPU),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>   static const VMStateDescription vmstate_lsxh_reg = {
>>       .name = "lsxh_reg",
>>       .version_id = 1,
>> @@ -168,8 +188,8 @@ static const VMStateDescription vmstate_tlb = {
>>   /* LoongArch CPU state */
>>   const VMStateDescription vmstate_loongarch_cpu = {
>>       .name = "cpu",
>> -    .version_id = 3,
>> -    .minimum_version_id = 3,
>> +    .version_id = 4,
>> +    .minimum_version_id = 4,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
>>           VMSTATE_UINTTL(env.pc, LoongArchCPU),
>> @@ -245,6 +265,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
>>           &vmstate_tlb,
>>   #endif
>>           &vmstate_lbt,
>> +        &vmstate_msg,
>>           NULL
>>       }
>>   };
>>


