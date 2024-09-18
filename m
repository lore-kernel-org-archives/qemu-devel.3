Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E574ACAC5B2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 00:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqiy9-0005KX-J9; Tue, 17 Sep 2024 20:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sqiy2-0005JP-UZ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:54:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sqixy-00031e-H1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:54:50 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxOOnMJOpmL1wKAA--.22404S3;
 Wed, 18 Sep 2024 08:54:36 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDx_9fLJOpmhjwJAA--.53184S3;
 Wed, 18 Sep 2024 08:54:35 +0800 (CST)
Subject: Re: [PATCH v2 1/2] acpi: ged: Add macro for acpi sleep control
 register
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, "Jason A . Donenfeld"
 <Jason@zx2c4.com>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
 qemu-devel@nongnu.org
References: <20240911030922.877259-1-maobibo@loongson.cn>
 <20240911030922.877259-2-maobibo@loongson.cn>
 <20240913144104.643c1e89@imammedo.users.ipa.redhat.com>
 <4e3f67e1-f06a-070e-6b45-89afd1be2884@loongson.cn>
 <20240917094416.7a9c965c@imammedo.users.ipa.redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <399a61a3-331e-4774-bd51-cf69711b8b69@loongson.cn>
Date: Wed, 18 Sep 2024 08:54:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240917094416.7a9c965c@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_9fLJOpmhjwJAA--.53184S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF1fur1xtr4kKFWkurW3Jwc_yoW7Arykpr
 Z09Fy2yr47Kry2q3yYvwn8JFy0qr1jkr9xuFW8t340v3ZI9r1fGF10vr4jkryrZwn3Xa1U
 Z3yqgr93WFy5ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.085,
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



On 2024/9/17 下午3:44, Igor Mammedov wrote:
> On Sat, 14 Sep 2024 10:25:45 +0800
> maobibo <maobibo@loongson.cn> wrote:
> 
>> On 2024/9/13 下午8:41, Igor Mammedov wrote:
>>> On Wed, 11 Sep 2024 11:09:21 +0800
>>> Bibo Mao <maobibo@loongson.cn> wrote:
>>>    
>>>> Macro definition is added for acpi sleep control register, so that
>>>> ged emulation driver can use this, also it can be used in FDT table if
>>>> ged is exposed with FDT table.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>    hw/acpi/generic_event_device.c         | 6 +++---
>>>>    hw/i386/acpi-microvm.c                 | 2 +-
>>>>    hw/loongarch/acpi-build.c              | 2 +-
>>>>    include/hw/acpi/generic_event_device.h | 9 +++++++--
>>>>    4 files changed, 12 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>>>> index 15b4c3ebbf..94992e6119 100644
>>>> --- a/hw/acpi/generic_event_device.c
>>>> +++ b/hw/acpi/generic_event_device.c
>>>> @@ -201,9 +201,9 @@ static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
>>>>    
>>>>        switch (addr) {
>>>>        case ACPI_GED_REG_SLEEP_CTL:
>>>> -        slp_typ = (data >> 2) & 0x07;
>>>> -        slp_en  = (data >> 5) & 0x01;
>>>> -        if (slp_en && slp_typ == 5) {
>>>> +        slp_typ = (data & ACPI_GED_SLP_TYPx_MASK) >> ACPI_GED_SLP_TYPx_POS;
>>> this makes a bit more complex expression once macros are expanded,
>>> but doesn't really helps to clarity.
>>>
>>> If I have to touch/share this code, I'd replace magic numbers above
>>> with corresponding simple numeric macro but keep the same expressions.
>> That sounds reasonable, it is better to keep the same expression such as:
>>       slp_typ = (data >> ACPI_GED_SLP_TYPx_POS) & ACPI_GED_SLP_TYPx_MASK;
>>
>> However what about for this sentence?
>>       slp_en  = (data >> 5) & 0x01;
>> I think the modification like this is better
>>       slp_en  = !!(data & ACPI_GED_SLP_EN);
> 
> then one has to got and check what ACPI_GED_SLP_EN is
> and why it's that specific value.
> while keeping it as is would be consistent with slp_typ
> line right above it.
> But it's stylistic, I don't really care wrt it.
>   
>>
>>>    
>>>> +        slp_en  = !!(data & ACPI_GED_SLP_EN);
>>>> +        if (slp_en && slp_typ == ACPI_GED_SLP_TYPx_S5) {
>>>>                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>>>>            }
>>>>            return;
>>>> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
>>>> index 279da6b4aa..1e424076d2 100644
>>>> --- a/hw/i386/acpi-microvm.c
>>>> +++ b/hw/i386/acpi-microvm.c
>>>> @@ -131,7 +131,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
>>>>        /* ACPI 5.0: Table 7-209 System State Package */
>>>>        scope = aml_scope("\\");
>>>>        pkg = aml_package(4);
>>>> -    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
>>>> +    aml_append(pkg, aml_int(ACPI_GED_SLP_TYPx_S5));
>>>
>>> what's the point of renaming this?
>> ACPI spec set name with SLP_TYPx. I am ok with both, it seems less
>> modification is better.
> 
> I'd avoid renaming, if one need to reference spec we usually add
> a comment about field/value that points to earliest spec where it
> was introduced and chapter in it. Also for fields we also add
> a comment with _verbatim_ field name from spec, so that one
> can copy/past/search it in spec when needed.
Got it, thanks for your detailed explanation.
Will refresh it in the next patch.

Regards
Bibo Mao
> 
> 
>>
>> Regards
>> Bibo Mao
>>>    
>>>>        aml_append(pkg, aml_int(0)); /* ignored */
>>>>        aml_append(pkg, aml_int(0)); /* reserved */
>>>>        aml_append(pkg, aml_int(0)); /* reserved */
>>>> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
>>>> index 2638f87434..974519a347 100644
>>>> --- a/hw/loongarch/acpi-build.c
>>>> +++ b/hw/loongarch/acpi-build.c
>>>> @@ -418,7 +418,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>>>        /* System State Package */
>>>>        scope = aml_scope("\\");
>>>>        pkg = aml_package(4);
>>>> -    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
>>>> +    aml_append(pkg, aml_int(ACPI_GED_SLP_TYPx_S5));
>>>>        aml_append(pkg, aml_int(0)); /* ignored */
>>>>        aml_append(pkg, aml_int(0)); /* reserved */
>>>>        aml_append(pkg, aml_int(0)); /* reserved */
>>>> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
>>>> index 40af3550b5..41741e94ea 100644
>>>> --- a/include/hw/acpi/generic_event_device.h
>>>> +++ b/include/hw/acpi/generic_event_device.h
>>>> @@ -81,8 +81,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>>>>    /* ACPI_GED_REG_RESET value for reset*/
>>>>    #define ACPI_GED_RESET_VALUE       0x42
>>>>    
>>>> -/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
>>>> -#define ACPI_GED_SLP_TYP_S5        0x05
>>>> +/* [ACPI 5.0+ FADT] Sleep Control Register */
>>>> +/* 3-bit field defines the type of hardware sleep state */
>>>> +#define ACPI_GED_SLP_TYPx_POS      0x2
>>>> +#define ACPI_GED_SLP_TYPx_MASK     (0x07 << ACPI_GED_SLP_TYPx_POS)
>>>> +#define ACPI_GED_SLP_TYPx_S5       0x05  /* System \_S5 State (Soft Off) */
>>>> +/* Write-only, Set this bit causes system to enter SLP_TYPx sleeping state */
>>>> +#define ACPI_GED_SLP_EN            0x20
>>>>    
>>>>    #define GED_DEVICE      "GED"
>>>>    #define AML_GED_EVT_REG "EREG"
>>>    
>>


