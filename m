Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798F1C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 02:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDxt5-0001pA-V4; Sun, 02 Jun 2024 22:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <niugen@loongson.cn>)
 id 1sDxt2-0000sk-3O
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 22:57:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <niugen@loongson.cn>) id 1sDwra-0004yH-T9
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 21:51:57 -0400
Received: from loongson.cn (unknown [10.90.50.36])
 by gateway (Coremail) with SMTP id _____8AxnOqvIV1mQMMCAA--.11808S3;
 Mon, 03 Jun 2024 09:51:43 +0800 (CST)
Received: from [10.90.50.36] (unknown [10.90.50.36])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axx8WvIV1mgxYSAA--.3884S2; 
 Mon, 03 Jun 2024 09:51:43 +0800 (CST)
Message-ID: <67ecebc0-6e2c-4359-a778-3b22c019706f@loongson.cn>
Date: Mon, 3 Jun 2024 09:51:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: nochain should disable goto_ptr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240531101744.1683192-1-niugen@loongson.cn>
 <044af09d-4856-40f0-ae27-df6522e4dbb4@linaro.org>
 <042b0650-1fef-4730-a80a-abb7361cce29@loongson.cn>
 <59f7895c-5975-4ca0-98fd-1600495e24bd@linaro.org>
Content-Language: en-US
From: niugen <niugen@loongson.cn>
In-Reply-To: <59f7895c-5975-4ca0-98fd-1600495e24bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axx8WvIV1mgxYSAA--.3884S2
X-CM-SenderInfo: 5qlxwv3q6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF4kuryDJry3WF1kCw47ZFc_yoW8trWxpr
 4kGF1Utayqqrn5Janrtr12qa4Yqr98Aay7X3WUZa4vyrn3WFnaqw4jganF9rW8Cw4IyrW7
 Zrn0vryfur1YyFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr4
 1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
 67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
 8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
 wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
 v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=niugen@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/6/1 21:36, Richard Henderson wrote:
> On 6/1/24 00:57, niugen wrote:
>> on 2024/6/1 01:32, Richard Henderson wrote:
>>> On 5/31/24 03:17, NiuGenen wrote:
>>>> Signed-off-by: NiuGenen <niugen@loongson.cn>
>>>> ---
>>>>   accel/tcg/cpu-exec.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>>>> index 2972f75b96..084fa645c7 100644
>>>> --- a/accel/tcg/cpu-exec.c
>>>> +++ b/accel/tcg/cpu-exec.c
>>>> @@ -173,7 +173,7 @@ uint32_t curr_cflags(CPUState *cpu)
>>>>       } else if (qatomic_read(&one_insn_per_tb)) {
>>>>           cflags |= CF_NO_GOTO_TB | 1;
>>>>       } else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
>>>> -        cflags |= CF_NO_GOTO_TB;
>>>> +        cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR;
>>>>       }
>>>>         return cflags;
>>>
>>> Why?
>>>
>>> The original intent of nochain was so that -d exec would log all 
>>> blocks, which requires excluding goto_tb.  There is exec logging in 
>>> helper_lookup_goto_ptr, so there is no need to avoid goto_ptr.
>>>
>>> You must provide a rationale, at minimum.
>>>
>>>
>>> r~
>>
>>
>> Sorry, my mistake. I thought nochain will disable all kinds of 
>> branches, including direct branch and indirect branch, but I found 
>> that indirect branch still call helper_lookup_tb_ptr to continue 
>> executing TB instead of epilogue-tblookup-prologue.
>>
>> Maybe the exec logging can be removed from helper_lookup_tb_ptr and 
>> nochain can disable all the chaining of TB?
>
> Why?  You still haven't provided a rationale.
>
>
> r~


Currently, nochain is actually no-direct-chaining(i.e. no-goto-tb). And 
it works fine with -d exec because of the helper_lookup_tb_ptr generates 
the exec logging too. Other optimizations for indirect branch (eg. 
shadow-stack, inlined CPUJumpCache lookup, maybe developed in the 
future) that use goto_ptr will need to generate the exec logging too.

It makes the codes more clear if nochain is no-any-chaining. Any logging 
or other mechanism that needs to operate per TB's execution can be done 
in cpu_tb_exec only.


