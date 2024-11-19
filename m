Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4CBD60D09
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 01:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDDAm-0000yC-Aw; Mon, 18 Nov 2024 20:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tDDAk-0000xo-99
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 20:36:54 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tDDAh-0005bJ-AG
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 20:36:54 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxeeCm6ztnuvBBAA--.63610S3;
 Tue, 19 Nov 2024 09:36:38 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxdcCk6ztnVqBcAA--.25940S3;
 Tue, 19 Nov 2024 09:36:37 +0800 (CST)
Subject: Re: [PULL 6/7] hw/loongarch: virt: pass random seed to fdt
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
References: <20240912125132.268802-1-gaosong@loongson.cn>
 <20240912125132.268802-7-gaosong@loongson.cn> <ZzucOBWZJYeUVi3V@redhat.com>
From: mao bibo <maobibo@loongson.cn>
Message-ID: <0d8dd9b3-83a9-e71c-606a-8b6c70114ed8@loongson.cn>
Date: Tue, 19 Nov 2024 09:36:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZzucOBWZJYeUVi3V@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxdcCk6ztnVqBcAA--.25940S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF1DJw45JF4xCrWxuF15Awc_yoW5KrW7pF
 WxCa1YyF4UJFykJws7W34YvF1YkwsxJrWjq3Wagr10yFn8WFn3WFs293yjka48Z3yvgF40
 vrn7GrWaqFnrZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.492,
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

Hi Daniel,

Thanks for reporting the problem. I can reproduce this problem with my 
local environment, we will investigate this issue ASAP.

Regards
Bibo Mao

On 2024/11/19 上午3:57, Daniel P. Berrangé wrote:
> Hi Song / Jason,
> 
> We're seeing non-deterministic hangs in our functional test
> suite 'tests/functional/test_loongarch64_virt.py' and my
> attempt at git bisect is blaming this commit.
> 
> With this applied, perhaps 1 time in 10, the test case hangs,
> with zero serial port output from EDK2 emitted
> 
>    https://gitlab.com/qemu-project/qemu/-/issues/2686
> 
> I'm not seeing an obvious flaw in this commit's code, so I'm
> wondering if it has accidentally tickled some other subtle
> pre-existing bug elsewhere. Some general problem with FDT
> handling on loongarch64 perhaps ?
> 
> On Thu, Sep 12, 2024 at 08:51:31PM +0800, Song Gao wrote:
>> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
>>
>> If the FDT contains /chosen/rng-seed, then the Linux RNG will use it to
>> initialize early. Set this using the usual guest random number
>> generation function.
>>
>> This is the same procedure that's done in b91b6b5a2c ("hw/microblaze:
>> pass random seed to fdt"), e4b4f0b71c ("hw/riscv: virt: pass random seed
>> to fdt"), c6fe3e6b4c ("hw/openrisc: virt: pass random seed to fdt"),
>> 67f7e426e5 ("hw/i386: pass RNG seed via setup_data entry"), c287941a4d
>> ("hw/rx: pass random seed to fdt"), 5e19cc68fb ("hw/mips: boston: pass
>> random seed to fdt"), 6b23a67916 ("hw/nios2: virt: pass random seed to fdt")
>> c4b075318e ("hw/ppc: pass random seed to fdt"), and 5242876f37
>> ("hw/arm/virt: dt: add rng-seed property").
>>
>> These earlier commits later were amended to rerandomize the RNG seed on
>> snapshot load, but the LoongArch code somehow already does that, despite
>> not having this patch here, presumably due to some lucky copy and
>> pasting.
>>
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> Reviewed-by: Song Gao <gaosong@loongson.cn>
>> Message-Id: <20240905153316.2038769-1-Jason@zx2c4.com>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/loongarch/virt.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 76dd29a391..81b1f9486f 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -48,6 +48,7 @@
>>   #include "hw/block/flash.h"
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/guest-random.h"
>>   
>>   static bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>>   {
>> @@ -303,6 +304,7 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
>>   static void create_fdt(LoongArchVirtMachineState *lvms)
>>   {
>>       MachineState *ms = MACHINE(lvms);
>> +    uint8_t rng_seed[32];
>>   
>>       ms->fdt = create_device_tree(&lvms->fdt_size);
>>       if (!ms->fdt) {
>> @@ -316,6 +318,10 @@ static void create_fdt(LoongArchVirtMachineState *lvms)
>>       qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
>>       qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
>>       qemu_fdt_add_subnode(ms->fdt, "/chosen");
>> +
>> +    /* Pass seed to RNG */
>> +    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
>> +    qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
>>   }
>>   
>>   static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
>> -- 
>> 2.34.1
>>
>>
> 
> With regards,
> Daniel
> 


