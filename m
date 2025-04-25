Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E57C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HU2-0001Hr-Ml; Fri, 25 Apr 2025 07:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangran@bosc.ac.cn>)
 id 1u8D9R-0000hz-PJ; Fri, 25 Apr 2025 03:07:09 -0400
Received: from out28-121.mail.aliyun.com ([115.124.28.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangran@bosc.ac.cn>)
 id 1u8D9N-000890-63; Fri, 25 Apr 2025 03:07:09 -0400
Received: from 172.38.29.63(mailfrom:wangran@bosc.ac.cn
 fp:SMTPD_---.cWQHKaY_1745564503 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 25 Apr 2025 15:01:44 +0800
Message-ID: <f39a07eb-e63d-4373-ab7a-fd83fab37c68@bosc.ac.cn>
Date: Fri, 25 Apr 2025 15:01:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/riscv: Add BOSC's Xiangshan Kunminghu CPU
To: Alistair Francis <alistair23@gmail.com>, Huang Borong <3543977024@qq.com>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org
References: <20250408022121.173531-1-huangborong@bosc.ac.cn>
 <CAKmqyKOwbLJrRTkVrGO8+Kd-5SAEj1GU7ToytB8b66b_gbADHg@mail.gmail.com>
From: Ran Wang <wangran@bosc.ac.cn>
In-Reply-To: <CAKmqyKOwbLJrRTkVrGO8+Kd-5SAEj1GU7ToytB8b66b_gbADHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.121; envelope-from=wangran@bosc.ac.cn;
 helo=out28-121.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Apr 2025 07:44:38 -0400
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

Hi Alistair

On 2025/4/24 18:49, Alistair Francis wrote:
> On Tue, Apr 8, 2025 at 12:23 PM Huang Borong <huangborong@bosc.ac.cn> wrote:
>>
>> Add a CPU entry for the Xiangshan Kunminghu CPU, an open-source,
>> high-performance RISC-V processor. More details can be found at:

<snip>

>> +    cpu->cfg.ext_ssaia = true;
>> +
>> +    /* RVA23 Profiles */
>> +    cpu->cfg.ext_zicbom = true;
>> +    cpu->cfg.ext_zicbop = true;
>> +    cpu->cfg.ext_zicboz = true;
>> +    cpu->cfg.ext_svade = true;
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
>> +#endif
>> +}
>> +
> 
> Sorry about this, but we just merged a new way of defining CPU types.
> Can you please rebase on
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next to use the
> new macros? It shouldn't be much work, just a little restructuring.
> 
> When sending a new version can you also include a cover letter [1]
> 
> 1: https://www.qemu.org/docs/master/devel/submitting-a-patch.html#include-a-meaningful-cover-letter

Sure, Borong just left BOSC and I will take over his job and send out 
next version patch mail later.

Thanks & Regards,

Ran

> Alistair
> 
>>   #ifdef CONFIG_TCG
>>   static void rv128_base_cpu_init(Object *obj)
>>   {
>> @@ -3261,6 +3331,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
>>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
>>                                                    MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
>> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH,
>> +                                                 MXL_RV64,  rv64_xiangshan_kmh_cpu_init),
>>   #ifdef CONFIG_TCG
>>       DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
>>   #endif /* CONFIG_TCG */
>> --
>> 2.34.1
>>
>>


