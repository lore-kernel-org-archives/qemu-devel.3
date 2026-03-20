Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64826108B8E9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WqP-0003mQ-CL; Fri, 20 Mar 2026 06:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1w3WqM-0003lr-J2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:12:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1w3WqJ-0004rc-Rx
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:12:38 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8AxgsCIHb1pygEdAA--.24485S3;
 Fri, 20 Mar 2026 18:12:24 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJCxOMGHHb1pJ1dZAA--.25750S3;
 Fri, 20 Mar 2026 18:12:23 +0800 (CST)
Subject: Re: [PATCH V3 1/2] hw/loongarch: add rtc acpi table
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <zltjiangshi@gmail.com>
References: <cover.1773911364.git.lixianglai@loongson.cn>
 <c11b8bb41d36b5317171641f8f8bd4faab3ee101.1773911364.git.lixianglai@loongson.cn>
 <20260320093659.00006061@huawei.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <26af369b-8284-91b8-ec2c-321bcbf84514@loongson.cn>
Date: Fri, 20 Mar 2026 18:05:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260320093659.00006061@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxOMGHHb1pJ1dZAA--.25750S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrWrWry3CF43JryxXw48Xwc_yoW8Kw48pa
 9rC3WYyr1DXFy3X343X3y5WFnxJrykGa42v3Z2vry0kFyvkr1kJr1UCr9rta4Yy3W8GF4j
 vryDKa47Wa1DAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.101,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Hi Jonathan Cameron :
> On Fri, 20 Mar 2026 08:36:52 +0800
> Xianglai Li <lixianglai@loongson.cn> wrote:
>
>> Add the acpi table to the loongson rtc hardware so that the virtual machine
>> kernel can use the loongson RTC-related drivers.
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Hi
>
> No data updates for
>
> tests/dta/acpi/loongarch64/virt?
Oh! I missed it. I will fix it in the next patch.

Thanks!
Xianglai.

>> ---
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Cc: Huacai Chen <zltjiangshi@gmail.com>
>>
>>   hw/loongarch/virt-acpi-build.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
>> index 3e34bedcd6..42820001d7 100644
>> --- a/hw/loongarch/virt-acpi-build.c
>> +++ b/hw/loongarch/virt-acpi-build.c
>> @@ -460,6 +460,30 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongArchVirtMachineState *vms)
>>   }
>>   #endif
>>   
>> +static void acpi_dsdt_add_rtc(Aml *scope)
>> +{
>> +    Aml *dev = aml_device("RTC");
>> +
>> +    aml_append(dev, aml_name_decl("_HID", aml_string("LOON0001")));
>> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>> +
>> +    Aml *crs = aml_resource_template();
>> +    aml_append(crs,
>> +        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
>> +                         AML_NON_CACHEABLE, AML_READ_WRITE,
>> +                         0, VIRT_RTC_REG_BASE,
>> +                         VIRT_RTC_REG_BASE + VIRT_RTC_LEN - 1,
>> +                         0, VIRT_RTC_LEN));
>> +    /*
>> +     * The virtual machine model does not support suspend and wake-up,
>> +     * and rtc is no longer the wake-up source. Therefore, the current
>> +     * rtc table no longer provides the rtc alarm interrupt number to
>> +     * avoid the software initializing alarm.
>> +     */
>> +    aml_append(dev, aml_name_decl("_CRS", crs));
>> +    aml_append(scope, dev);
>> +}
>> +
>>   /* build DSDT */
>>   static void
>>   build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>> @@ -475,6 +499,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>       for (i = 0; i < VIRT_UART_COUNT; i++) {
>>           build_uart_device_aml(dsdt, i);
>>       }
>> +    acpi_dsdt_add_rtc(dsdt);
>>       build_pci_device_aml(dsdt, lvms);
>>       build_la_ged_aml(dsdt, machine);
>>       build_flash_aml(dsdt, lvms);


