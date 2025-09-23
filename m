Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74B2CAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0t0z-0002Pl-A3; Mon, 22 Sep 2025 22:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v0t0v-0002L0-JR
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:44:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v0t0n-0004B2-Bk
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:44:21 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx3tJxCdJoRHwNAA--.28947S3;
 Tue, 23 Sep 2025 10:44:02 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxZORtCdJo6vymAA--.5439S3;
 Tue, 23 Sep 2025 10:44:00 +0800 (CST)
Subject: Re: [PATCH 3/5] target/loongarch: Set file tcg_cpu.c separate from
 cpu.c
To: Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250922073400.1308169-1-maobibo@loongson.cn>
 <20250922073400.1308169-4-maobibo@loongson.cn>
 <e30ee507-9e75-44e6-a901-fa9562b1697e@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <448d8711-0fca-a10f-475e-4c556f1f1b37@loongson.cn>
Date: Tue, 23 Sep 2025 10:41:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e30ee507-9e75-44e6-a901-fa9562b1697e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxZORtCdJo6vymAA--.5439S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFyxWF17Aw1xXF4xGF13Jrc_yoWrGryxpF
 Z7uFyUtFW8KrWkJ34kX34aqF1DXr1DGw12vayaga4Ikr43Xr10qw4vq3yqgF18Ga18Gr1I
 gFnayr1rZF4jqabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9U
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.559,
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



On 2025/9/22 下午10:29, Richard Henderson wrote:
> On 9/22/25 00:33, Bibo Mao wrote:
>> Remove inline included with file tcg_cpu.c, and set it separate
>> with file target/loongarch/cpu.c
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/cpu.c               |  9 ---------
>>   target/loongarch/tcg/meson.build     |  1 +
>>   target/loongarch/tcg/tcg_cpu.c       | 13 ++++++++++++-
>>   target/loongarch/tcg/tcg_loongarch.h |  1 +
>>   4 files changed, 14 insertions(+), 10 deletions(-)
> 
> I think this should be squashed with patch 1.
> The intermediate #include of tcg/tcg_cpu.c was odd.
yes, it is actually odd. It is just for code review to do so.
Will squashed this with patch 1.

Regards
Bibo Mao
> 
> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 
>>
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index 6eb8c3214a..b449ede56d 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -28,11 +28,6 @@
>>   #ifdef CONFIG_KVM
>>   #include <linux/kvm.h>
>>   #endif
>> -#ifdef CONFIG_TCG
>> -#include "accel/tcg/cpu-ldst.h"
>> -#include "accel/tcg/cpu-ops.h"
>> -#include "tcg/tcg.h"
>> -#endif
>>   #include "tcg/tcg_loongarch.h"
>>   const char * const regnames[32] = {
>> @@ -653,10 +648,6 @@ static void loongarch_cpu_dump_state(CPUState 
>> *cs, FILE *f, int flags)
>>       }
>>   }
>> -#ifdef CONFIG_TCG
>> -#include "tcg/tcg_cpu.c"
>> -#endif /* CONFIG_TCG */
>> -
>>   #ifndef CONFIG_USER_ONLY
>>   #include "hw/core/sysemu-cpu-ops.h"
>> diff --git a/target/loongarch/tcg/meson.build 
>> b/target/loongarch/tcg/meson.build
>> index bdf34f9673..b7adfe46f1 100644
>> --- a/target/loongarch/tcg/meson.build
>> +++ b/target/loongarch/tcg/meson.build
>> @@ -7,6 +7,7 @@ loongarch_ss.add([zlib, gen])
>>   loongarch_ss.add(files(
>>     'fpu_helper.c',
>>     'op_helper.c',
>> +  'tcg_cpu.c',
>>     'translate.c',
>>     'vec_helper.c',
>>   ))
>> diff --git a/target/loongarch/tcg/tcg_cpu.c 
>> b/target/loongarch/tcg/tcg_cpu.c
>> index f09a695968..c7f49838e3 100644
>> --- a/target/loongarch/tcg/tcg_cpu.c
>> +++ b/target/loongarch/tcg/tcg_cpu.c
>> @@ -4,6 +4,17 @@
>>    *
>>    * Copyright (c) 2025 Loongson Technology Corporation Limited
>>    */
>> +#include "qemu/osdep.h"
>> +#include "qemu/accel.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/log.h"
>> +#include "accel/accel-cpu-target.h"
>> +#include "accel/tcg/cpu-ldst.h"
>> +#include "accel/tcg/cpu-ops.h"
>> +#include "exec/translation-block.h"
>> +#include "exec/target_page.h"
>> +#include "tcg_loongarch.h"
>> +#include "internals.h"
>>   #ifndef CONFIG_USER_ONLY
>>   static void loongarch_cpu_do_interrupt(CPUState *cs)
>> @@ -232,7 +243,7 @@ static int loongarch_cpu_mmu_index(CPUState *cs, 
>> bool ifetch)
>>       return MMU_DA_IDX;
>>   }
>> -static const TCGCPUOps loongarch_tcg_ops = {
>> +const TCGCPUOps loongarch_tcg_ops = {
>>       .guest_default_memory_order = 0,
>>       .mttcg_supported = true,
>> diff --git a/target/loongarch/tcg/tcg_loongarch.h 
>> b/target/loongarch/tcg/tcg_loongarch.h
>> index 47702893e3..7fb627f2d6 100644
>> --- a/target/loongarch/tcg/tcg_loongarch.h
>> +++ b/target/loongarch/tcg/tcg_loongarch.h
>> @@ -9,6 +9,7 @@
>>   #include "cpu.h"
>>   #include "cpu-mmu.h"
>> +extern const TCGCPUOps loongarch_tcg_ops;
>>   void loongarch_csr_translate_init(void);
>>   bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> 


