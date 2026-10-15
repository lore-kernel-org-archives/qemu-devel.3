Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E3BCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIJW-0002xr-0C; Thu, 15 Oct 2026 06:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xHIJT-0002xg-0R
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:03:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xHIJQ-0000lk-9a
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:03:50 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxrtL3pNBqoRQWAA--.64482S3;
 Thu, 15 Oct 2026 18:03:35 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxlMz0pNBqlZ8sAA--.1036S2;
 Thu, 15 Oct 2026 18:03:34 +0800 (CST)
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Fix clock property name typo and
 order
From: Bibo Mao <maobibo@loongson.cn>
To: pillow <waysorrypub@gmail.com>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, lixianglai@loongson.cn, jiaxun.yang@flygoat.com,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com
References: <cover.1791803914.git.waysorrypub@gmail.com>
 <8e36ee3baff3e6abef94cda37d564aeb690b161b.1791803914.git.waysorrypub@gmail.com>
 <7a2c2a6c-7ece-7e94-7216-6918558cda74@loongson.cn>
Message-ID: <3c7bb90f-7b94-5d88-4f92-1b0d99c3d0e6@loongson.cn>
Date: Thu, 15 Oct 2026 18:04:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7a2c2a6c-7ece-7e94-7216-6918558cda74@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxlMz0pNBqlZ8sAA--.1036S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar45Xw1kArWDZryfWF45Jwc_yoW8ZF15pr
 sYyrWjyryDWr97J34UJ3W5GryYyr1DAw4jqw12yFyUZ347Gr1jqFyjvrsFgry7Aw4rA398
 ArnYgFyv9FyUArcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn
 UUUUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.783,
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



On 2026/10/15 下午2:57, Bibo Mao wrote:
> 
> 
> On 2026/10/12 下午7:39, pillow wrote:
>> The original code had a typo in the clock preperty name, and the
>> property name and frequency value were in reversed order.
>> According to the _DSD format rules, the property name string comes
>> first, followed by the property value:
>> https://github.com/UEFI/DSD-Guide/blob/main/src/dsd-guide.adoc#data-format-definition 
>>
>>
>> Signed-off-by: pillow <waysorrypub@gmail.com>
>> ---
>>   hw/loongarch/virt-acpi-build.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/loongarch/virt-acpi-build.c 
>> b/hw/loongarch/virt-acpi-build.c
>> index 54965f0..4081730 100644
>> --- a/hw/loongarch/virt-acpi-build.c
>> +++ b/hw/loongarch/virt-acpi-build.c
>> @@ -336,8 +336,8 @@ static void build_uart_device_aml(Aml *table, int 
>> index)
>>                                     AML_SHARED, &uart_irq, 1));
>>       aml_append(dev, aml_name_decl("_CRS", crs));
>>       pkg0 = aml_package(0x2);
>> +    aml_append(pkg0, aml_string("clock-frequency"));
>>       aml_append(pkg0, aml_int(0x05F5E100));
>> -    aml_append(pkg0, aml_string("clock-frenquency"));
>>       pkg1 = aml_package(0x1);
>>       aml_append(pkg1, pkg0);
>>       pkg2 = aml_package(0x2);
>>
> Hi,
> 
> yes, there is spelling issue with LoongArch virt machine UART acpi 
> table. It seems that clock-frequency is not used by serial port. is it 
> possible to remove pkg0/pkg1/pkg2 property like ISA serial acpi table 
> defined in function serial_isa_build_aml()?
> 
> Also "_CCA" property should be removed since the emulated serial port 
> does not support DMA, and add "_STA" property.
Also maybe property clock-frequency of uart fdt table in 
fdt_add_uart_node() can be removed.

Regards
Bibo Mao
> 
> Regards
> Bibo Mao


