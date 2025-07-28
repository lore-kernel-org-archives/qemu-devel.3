Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDECFC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 06:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugH3C-0007j7-Br; Mon, 28 Jul 2025 02:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ugH1I-0005GV-OD
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 02:07:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ugH1B-0000oi-Sp
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 02:07:28 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxnOKSE4dovjYzAQ--.1838S3;
 Mon, 28 Jul 2025 14:07:15 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxT+aPE4do2I4pAA--.14133S3;
 Mon, 28 Jul 2025 14:07:13 +0800 (CST)
Subject: Re: [PATCH v3 13/17] target/loongarch: Use correct address when flush
 tlb
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-14-maobibo@loongson.cn>
 <c75d79ab-97b8-464b-9774-a51de03a8e31@linaro.org>
 <b6d7747c-c37c-206e-6f44-535e5410ec14@loongson.cn>
 <7e06bf78-e9a5-47da-b0d6-7b1af5b20a10@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <52129508-496e-58c8-2f05-35d7c1a816e6@loongson.cn>
Date: Mon, 28 Jul 2025 14:05:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7e06bf78-e9a5-47da-b0d6-7b1af5b20a10@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxT+aPE4do2I4pAA--.14133S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKFy8uF18Gw17Cry8KF1kXrc_yoWfXrb_Zw
 srCr1xZFnrGrWFqrnakw48Z3ZrGr40yr13J3W8Xrsak3s3AFs3JF9xWr97Ga1UGFWrW3ZI
 k3sF9a47Ca43uosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1MK
 ZJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.134,
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



On 2025/7/28 下午1:09, Richard Henderson wrote:
> On 7/27/25 17:22, Bibo Mao wrote:
>>>> +static inline target_ulong __vaddr(target_ulong addr)
>>>> +{
>>>> +    target_ulong high;
>>>> +
>>>> +    high = -(addr >> (TARGET_VIRT_ADDR_SPACE_BITS - 1));
>>>> +    return addr + (high << TARGET_VIRT_ADDR_SPACE_BITS);
>>>> +}
>>>
>>> Don't use __ symbols.
>>> Also, this function is
>>>
>>>      sextract64(addr, 0, TARGET_VIRT_ADDR_SPACE_BITS - 1)
>> yeap, sextract64 is simpler and effective. How about 
>> loongarch_vppn_to_vaddr compared with __vaddr about function name?
> 
> There was one use of __vaddr in this patch.  Do you need a separate 
> helper function at all?  Just use sextract64 directly within 
> invalidate_tlb_entry.
ok, will remove it directly.
And thanks for your kindly guidance.

Regards
Bibo Mao
> 
> 
> r~


