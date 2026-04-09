Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550F4EA3C55
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAp1F-0006Y4-30; Thu, 09 Apr 2026 09:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wAp0t-0006VM-Sb
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:01:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wAp0p-0000zS-8L
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:01:39 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx36sfo9dp940jAA--.39709S3;
 Thu, 09 Apr 2026 21:01:19 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxvsIYo9dpjIVpAA--.4374S3;
 Thu, 09 Apr 2026 21:01:17 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Add support for dbar hint variants
From: gaosong <gaosong@loongson.cn>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, xianglai li
 <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 yijun@loongson.cn
References: <20260327003206.3749780-1-gaosong@loongson.cn>
 <70916e5a-ec69-fb8f-259e-2ef07e97bc5a@loongson.cn>
 <b3265697-630d-29b0-24ab-24be748d79f5@loongson.cn>
 <8c53d966-a5ab-2ce5-c118-f2fea6c20359@loongson.cn>
 <f7021649-bf98-9899-2efa-2a2adaa34161@loongson.cn>
Message-ID: <f6e3b22e-dfd9-66df-19d1-b3aa092eb9b9@loongson.cn>
Date: Thu, 9 Apr 2026 21:02:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f7021649-bf98-9899-2efa-2a2adaa34161@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxvsIYo9dpjIVpAA--.4374S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3Zr17ZF1rCw4fuFykAFWUAwc_yoW8JF45Jo
 WUKF1fJw4fXr1jgr1DG3yDJFyYy3WrCrnrAryUG347GF40yw1jy3yUG34Fq3y7Gr18Kr17
 GFy8JF1DAFyavr1fl-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
 aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
 1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
 7XTmDUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.135,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

在 2026/4/9 下午3:48, gaosong 写道:
> 在 2026/4/3 上午10:52, Bibo Mao 写道:
>>
>>
>> On 2026/4/2 下午7:23, gaosong wrote:
>>> 在 2026/4/2 上午10:17, Bibo Mao 写道:
>>>>
>>>>
>>>> On 2026/3/27 上午8:32, Song Gao wrote:
>>>>> LoongArch architecture (since LA664) introduces fine-grained dbar
>>>>> hints that allow controlling which memory accesses are ordered by
>>>>> the barrier. Previously, all dbar instructions were treated as a
>>>>> full barrier (TCG_MO_ALL | TCG_BAR_SC).
>>>>>
>>>>> This patch adds support for decoding dbar hints and emitting the
>>>>> appropriate TCG memory barrier flags. For CPUs that do not advertise
>>>>> the DBAR_HINTS feature (cpucfg3.DBAR_HINTS = 0), all dbar hints
>>>>> fall back to a full barrier, preserving compatibility.
>>>>>
>>>>> The hint encoding follows the LoongArch v1.10 specification:
>>>>> - Bit4: 0 = completion barrier, 1 = ordering barrier
>>>>>          (ignored by TCG as TCG only supports ordering barriers)
>>>>> - Bit3: barrier for previous reads (0 = enforce, 1 = relax)
>>>>> - Bit2: barrier for previous writes (0 = enforce, 1 = relax)
>>>>> - Bit1: barrier for succeeding reads (0 = enforce, 1 = relax)
>>>>> - Bit0: barrier for succeeding writes (0 = enforce, 1 = relax)
>>>>>
>>>>> The mapping to TCG memory order flags is as follows:
>>>>> - TCG_MO_LD_LD is set if both previous and succeeding reads are 
>>>>> ordered.
>>>>> - TCG_MO_ST_LD is set if previous write and succeeding read are 
>>>>> ordered.
>>>>> - TCG_MO_LD_ST is set if previous read and succeeding write are 
>>>>> ordered.
>>>>> - TCG_MO_ST_ST is set if both previous and succeeding writes are 
>>>>> ordered.
>>>>>
>>>>> If the resulting flags describe an acquire or release barrier,
>>>>> TCG_BAR_LDAQ or TCG_BAR_STRL is used accordingly; otherwise a
>>>>> full SC barrier (TCG_BAR_SC) is emitted.
>>>>>
>>>>> Special hint handling:
>>>>> - hint 0x700: LL/SC loop barrier, treated as a full barrier as 
>>>>> recommended.
>>>>> - hint 0xf and 0x1f: reserved/no-op, treated as no operation
>>>>>
>>>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>>>> ---
>>>>>   target/loongarch/cpu.c                        |  4 +
>>>>>   .../tcg/insn_trans/trans_memory.c.inc         | 82 
>>>>> ++++++++++++++++++-
>>>>>   target/loongarch/tcg/translate.c              |  1 +
>>>>>   target/loongarch/translate.h                  |  3 +
>>>>>   4 files changed, 88 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>>>>> index e22568c84a..d8d106b07e 100644
>>>>> --- a/target/loongarch/cpu.c
>>>>> +++ b/target/loongarch/cpu.c
>>>>> @@ -455,6 +455,10 @@ static void loongarch_max_initfn(Object *obj)
>>>>>           data = FIELD_DP32(data, CPUCFG2, LLACQ_SCREL, 1);
>>>>>           data = FIELD_DP32(data, CPUCFG2, SCQ, 1);
>>>>>           cpu->env.cpucfg[2] = data;
>>>>> +
>>>>> +        data = cpu->env.cpucfg[3];
>>>>> +        data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
>>>>> +        cpu->env.cpucfg[3] = data;
>>>>>       }
>>>>>   }
>>>>>   diff --git a/target/loongarch/tcg/insn_trans/trans_memory.c.inc 
>>>>> b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
>>>>> index e287d46363..99bc486119 100644
>>>>> --- a/target/loongarch/tcg/insn_trans/trans_memory.c.inc
>>>>> +++ b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
>>>>> @@ -137,11 +137,89 @@ static bool trans_preldx(DisasContext *ctx, 
>>>>> arg_preldx * a)
>>>>>       return true;
>>>>>   }
>>>>>   +/*
>>>>> + * Decode dbar hint and emit appropriate TCG memory barrier.
>>>>> + *
>>>>> + * The hint is a 5-bit field (0-31) encoded in the instruction.
>>>>> + * For hint 0x700 (special LL/SC loop barrier), treat as full 
>>>>> barrier.
>>>>> + *
>>>>> + * See LoongArch Reference Manual v1.10, Section 4.2.2 for details.
>>>>> + */
>>>>>   static bool trans_dbar(DisasContext *ctx, arg_dbar * a)
>>>>>   {
>>>>>       tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
>>>>> -    return true;
>>>>> -}
>>>>> +    int hint = a->imm;
>>>>> +    TCGBar bar_flags = 0;
>>>>> +
>>>>> +    /* Reserved/no-op hints: 0xf and 0x1f */
>>>>> +    if (hint == 0xf || hint == 0x1f) {
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>> +    /* If the CPU does not support fine-grained hints,or for the 
>>>>> special LL/SC
>>>>> +     * loop barrier (0x700), emit a full barrier.
>>>>> +     */
>>>>> +    if (!avail_DBAR_HINT(ctx) || hint == 0x700) {
>>>>> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * Fine-grained hint decoding:
>>>>> +     * Bits 3-0 control which accesses must be ordered.
>>>>> +     *   bit3: barrier previous reads?   (0 = enforce, 1 = relax)
>>>>> +     *   bit2: barrier previous writes?  (0 = enforce, 1 = relax)
>>>>> +     *   bit1: barrier succeeding reads? (0 = enforce, 1 = relax)
>>>>> +     *   bit0: barrier succeeding writes?(0 = enforce, 1 = relax)
>>>>> +     *
>>>>> +     * For each combination, we set the corresponding TCG_MO_* 
>>>>> flag if both
>>>>> +     * sides of the barrier require ordering.
>>>>> +     */
>>>>> +    bool prev_rd = !(hint & 0x08);   /* need barrier for previous 
>>>>> reads */
>>>>> +    bool prev_wr = !(hint & 0x04);   /* need barrier for previous 
>>>>> writes */
>>>>> +    bool succ_rd = !(hint & 0x02);   /* need barrier for 
>>>>> succeeding reads */
>>>>> +    bool succ_wr = !(hint & 0x01);   /* need barrier for 
>>>>> succeeding writes */
>>>>> +
>>>>> +    if (prev_rd && succ_rd) {
>>>>> +        bar_flags |= TCG_MO_LD_LD;
>>>>> +    }
>>>>> +    if (prev_wr && succ_rd) {
>>>>> +        bar_flags |= TCG_MO_ST_LD;
>>>>> +    }
>>>>> +    if (prev_rd && succ_wr) {
>>>>> +        bar_flags |= TCG_MO_LD_ST;
>>>>> +    }
>>>>> +    if (prev_wr && succ_wr) {
>>>>> +        bar_flags |= TCG_MO_ST_ST;
>>>>> +    }
>>>> I do not know the memory order, however it seems that it is 
>>>> different with other architectures with following usage when it is 
>>>> translated to QEMU TCG code. I do now which is right.
>>>>
>>>> __smp_rmb() ---> tcg_gen_mb(TCG_BAR_SC | TCG_MO_LD_LD | TCG_MO_LD_ST)
>>>> __smp_wmb() ---> tcg_gen_mb(TCG_BAR_SC | TCG_MO_ST_ST)
>>>> __smp_mb()  ---> tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL)
>>>>
>>> Do you mean that TCG_BAR_SC might be missing here?
>> not only TCG_BAR_SC, I do not know what the logic converting DBAR 
>> hint bits to TCG memory order bits.
>>
>> However from user usage side, C language API on
>> __smp_rmb()/__smp_wmb()/__smp_mb() --> binary code with different 
>> arch --> TCG middle code
>>
>> The final TCG middle code should be similar, and is not relative with 
>> detailed architectures.
>>
>> The same with rmb()/wmb()/mb() APIs.
>>
> Hi,
>
> [1]https://github.com/torvalds/linux/blob/master/arch/loongarch/include/asm/barrier.h 
>
> After studying the code implementations of other architectures, I 
> believe your statement is correct.
> Based on implementations in other architectures and the definitions in 
> the kernel file [1],
> I believe that for the Loongarch architecture,
> the following mapping relationships exist:
>  hint   api             TCGBar
>   16  //smp_mb        TCG_MO_ALL;
>   21: //smp_rmb       TCG_MO_LD_LD | TCG_MO_LD_ST;
>   26: //smp_wmb       TCG_MO_ST_ST;
>   0   //mb            TCG_MO_ALL;
>   5:  //rmb           TCG_MO_LD_LD;
>  10:  //wmb           TCG_MO_ST_ST;
>  Others:              TCG_MO_ALL;
>
here, the mapping is not really right for LoongArch .
the mapping should be the following
hint bit 0-bit4
                 value 0                    TCGBar
  * Bit4: ordering or completion (0: completion, 1: ordering) ignore
  * Bit3: barrier for previous read (0: true, 1: false)       
TCG_MO_LD_LD | TCG_MO_LD_ST
  * Bit2: barrier for previous write (0: true, 1: false)      
TCG_MO_ST_LD |　TCG_MO_ST_ST
  * Bit1: barrier for succeeding read (0: true, 1: false)   TCG_MO_LD_LD 
|　TCG_MO_ST_LD
  * Bit0: barrier for succeeding write (0: true, 1: false)       
TCG_MO_LD_ST | TCG_MO_ST_ST
Others: TCG_MO_ALL

Thanks.
Song Gao
> The mapping of hint->api is taken from [1]; smp_mb/rmb/wmb refer to 
> the translation of ARM’s trans_DSB_DMB instruction.
> mb/rmb/wmb correspond to x86’s gen_MFENCE/LFENCE/SFENCE.
>
> Furthermore, QEMU’s TCG implementation does not appear to strictly 
> adhere to TCGBar requirements;
> for example, the RISC-V architecture uses uses TCG_MO_ALL.
> For the ARM architecture, the intermediate code generated by APIs such 
> as mb/rmb/wmb appears to be TCG_MO_ALL,
> but for x86, they are TCG_MO_ALL / TCG_MO_LD_LD / TCG_MO_ST_ST.
>
> Please ignore this patch; I will reimplement it.
>
> Thanks.
> Song Gao
>
>> Regards
>> Bibo Malo
>>
>>>
>>> It is actuallyhandled later: for non acquire/release cases we fall 
>>> back to
>>> tcg_gen_mb(bar_flags | TCG_BAR_SC).
>>>
>>> Thanks.
>>> Song Gao
>>>
>>>> Regards
>>>> Bibo Mao
>>>>> +
>>>>> +    /* If no flags were set, this is a no-op barrier */
>>>>> +    if (bar_flags == 0) {
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * Use acquire/release semantics when possible to generate 
>>>>> more efficient
>>>>> +     * code. Otherwise, fall back to a sequential consistency 
>>>>> barrier.
>>>>> +     *
>>>>> +     * Acquire: order loads before loads/stores (LD_LD | LD_ST)
>>>>> +     * Release: order stores before stores/loads (ST_ST | ST_LD)
>>>>> +     */
>>>>> +    if ((bar_flags & (TCG_MO_LD_LD | TCG_MO_LD_ST)) &&
>>>>> +        !(bar_flags & (TCG_MO_ST_ST | TCG_MO_ST_LD))) {
>>>>> +        /* Only acquire flags present */
>>>>> +        tcg_gen_mb(bar_flags | TCG_BAR_LDAQ);
>>>>> +    } else if ((bar_flags & (TCG_MO_ST_ST | TCG_MO_ST_LD)) &&
>>>>> +               !(bar_flags & (TCG_MO_LD_LD | TCG_MO_LD_ST))) {
>>>>> +        /* Only release flags present */
>>>>> +        tcg_gen_mb(bar_flags | TCG_BAR_STRL);
>>>>> +    } else {
>>>>> +        /* Mixed or full barrier */
>>>>> +        tcg_gen_mb(bar_flags | TCG_BAR_SC);
>>>>> +    }
>>>>> +
>>>>> +     return true;
>>>>> + }
>>>>>     static bool trans_ibar(DisasContext *ctx, arg_ibar *a)
>>>>>   {
>>>>> diff --git a/target/loongarch/tcg/translate.c 
>>>>> b/target/loongarch/tcg/translate.c
>>>>> index b9ed13d19c..49280b1dd3 100644
>>>>> --- a/target/loongarch/tcg/translate.c
>>>>> +++ b/target/loongarch/tcg/translate.c
>>>>> @@ -149,6 +149,7 @@ static void 
>>>>> loongarch_tr_init_disas_context(DisasContextBase *dcbase,
>>>>>         ctx->cpucfg1 = env->cpucfg[1];
>>>>>       ctx->cpucfg2 = env->cpucfg[2];
>>>>> +    ctx->cpucfg3 = env->cpucfg[3];
>>>>>   }
>>>>>     static void loongarch_tr_tb_start(DisasContextBase *dcbase, 
>>>>> CPUState *cs)
>>>>> diff --git a/target/loongarch/translate.h 
>>>>> b/target/loongarch/translate.h
>>>>> index ba1c89e57b..8aa8325dc6 100644
>>>>> --- a/target/loongarch/translate.h
>>>>> +++ b/target/loongarch/translate.h
>>>>> @@ -43,6 +43,8 @@
>>>>>   #define avail_LLACQ_SCREL(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, 
>>>>> LLACQ_SCREL))
>>>>>   #define avail_LLACQ_SCREL_64(C) (avail_64(C) && 
>>>>> avail_LLACQ_SCREL(C))
>>>>>   +#define avail_DBAR_HINT(C) (FIELD_EX32((C)->cpucfg3, CPUCFG3, 
>>>>> DBAR_HINTS))
>>>>> +
>>>>>   /*
>>>>>    * If an operation is being performed on less than 
>>>>> TARGET_LONG_BITS,
>>>>>    * it may require the inputs to be sign- or zero-extended; which 
>>>>> will
>>>>> @@ -66,6 +68,7 @@ typedef struct DisasContext {
>>>>>       bool va32; /* 32-bit virtual address */
>>>>>       uint32_t cpucfg1;
>>>>>       uint32_t cpucfg2;
>>>>> +    uint32_t cpucfg3;
>>>>>   } DisasContext;
>>>>>     void generate_exception(DisasContext *ctx, int excp);
>>>>>
>>>
>>
>


