Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0396C369B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 01:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4VOu-0006kb-I7; Mon, 14 Apr 2025 21:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u4VOq-0006jw-KU
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 21:47:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u4VOn-0008CF-Vj
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 21:47:44 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxdXCwuv1nwy+9AA--.52641S3;
 Tue, 15 Apr 2025 09:47:28 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxu8Squv1nZOOBAA--.55459S3;
 Tue, 15 Apr 2025 09:47:25 +0800 (CST)
Subject: Re: [PATCH 4/5] target/loongarch: Set function
 loongarch_map_address() with common code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20250414012528.4075447-1-maobibo@loongson.cn>
 <20250414012528.4075447-5-maobibo@loongson.cn>
 <24b30fec-026c-452d-9d2b-bf8fd5f4c944@linaro.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <df70cc0a-74f2-1eba-3451-f7f6db482432@loongson.cn>
Date: Tue, 15 Apr 2025 09:46:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <24b30fec-026c-452d-9d2b-bf8fd5f4c944@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxu8Squv1nZOOBAA--.55459S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF1UKr13Zw1xXF17JF1DArc_yoW5WF43pr
 97Ar4Utry8Jr95JF1kJ345XFyUJr47Jw1jq3WUtFy0kr4UJr1jvF1UXw1jgF1UJw48Jr10
 qr18AF1UuFyUXrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.283,
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


On 2025/4/14 下午6:51, Philippe Mathieu-Daudé wrote:
> On 14/4/25 03:25, Bibo Mao wrote:
>> Function loongarch_map_address is to get physical address from virtual
>> address, it is used by qmp commands to dump memeory from virtual
> 
> Typo "memory",
Will fix in next version.
> 
>> address.
>>
>> It is used by kvm mode also, here move function loongarch_map_address()
>> out of macro CONFIG_TCG. And it is common code, the similiar with
> 
> "similar".
Will fix in next version.
> 
>> function loongarch_page_table_walker().
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/cpu_helper.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/target/loongarch/cpu_helper.c 
>> b/target/loongarch/cpu_helper.c
>> index 6736a9a330..7a56482282 100644
>> --- a/target/loongarch/cpu_helper.c
>> +++ b/target/loongarch/cpu_helper.c
>> @@ -155,6 +155,14 @@ static int 
>> loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
>>       return TLBRET_NOMATCH;
>>   }
>> +#else
>> +static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr 
>> *physical,
>> +                                       int *prot, target_ulong address,
>> +                                       MMUAccessType access_type, int 
>> mmu_idx)
>> +{
>> +    return TLBRET_NOMATCH;
>> +}
>> +#endif
>>   void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>>                           uint64_t *dir_width, target_ulong level)
>> @@ -283,15 +291,6 @@ static int 
>> loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>>       return TLBRET_NOMATCH;
>>   }
>> -#else
>> -static int loongarch_map_address(CPULoongArchState *env, hwaddr 
>> *physical,
>> -                                 int *prot, target_ulong address,
>> -                                 MMUAccessType access_type, int mmu_idx,
>> -                                 int is_debug)
>> -{
>> -    return TLBRET_NOMATCH;
>> -}
>> -#endif
> 
> The change seems incomplete but fixed in the next patch. Maybe rebase 
> issue?
Here removes CONFIG_TCG maro with loongarch_map_address() function, so 
that it can be used with KVM only mode.

Maybe it should be split into two patches so that it is easier to 
understand, one is to add stub function loongarch_get_addr_from_tlb() 
without CONFIG_TCG defined, the other is to remove stub 
loongarch_map_address() and make it common for KVM only mode.

Regards
Bibo Mao


