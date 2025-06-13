Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFC9C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 04:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPwLc-00079j-29; Fri, 13 Jun 2025 00:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uPwLV-00079H-ME
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 00:48:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uPwLT-0006O1-MB
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 00:48:53 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxDGuxrUtoE4MVAQ--.51453S3;
 Fri, 13 Jun 2025 12:48:49 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxLcWurUtoc70YAQ--.7915S3;
 Fri, 13 Jun 2025 12:48:49 +0800 (CST)
Subject: Re: [PATCH V1 2/2] hw/loongarch: add rtc acpi table
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <cover.1749777563.git.lixianglai@loongson.cn>
 <49c55c9e6c49a89ec4438725ebf178e458572229.1749777563.git.lixianglai@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <46ec3865-7ffa-9461-8c4f-5d1dc8dd9bd6@loongson.cn>
Date: Fri, 13 Jun 2025 12:47:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <49c55c9e6c49a89ec4438725ebf178e458572229.1749777563.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxLcWurUtoc70YAQ--.7915S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KryDJr17XF1rZFW7XF43Arc_yoW5Jryrpr
 47Aa4Yyrn0qry3X3sxJa4UWrnxArn5Ca4jvFs2y39YkF1kKw10vr1UGwnrJ3WYyas7JF4D
 uryFgr1xWa1DAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.554,
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



On 2025/6/13 上午9:31, Xianglai Li wrote:
> Add the acpi table to the loongson rtc hardware
> so that the virtual machine kernel can use the
> loongson RTC-related drivers.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
>   hw/loongarch/virt-acpi-build.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index 2cd2d9d842..2cfc5421c5 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -473,6 +473,29 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongArchVirtMachineState *vms)
>   }
>   #endif
>   
> +static void acpi_dsdt_add_rtc(Aml *scope)
> +{
> +    uint32_t rtc_irq = VIRT_RTC_IRQ;
> +    Aml *dev = aml_device("RTC");
> +
> +    aml_append(dev, aml_name_decl("_HID", aml_string("LOON0001")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    Aml *crs = aml_resource_template();
> +    aml_append(crs,
> +        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> +                         AML_NON_CACHEABLE, AML_READ_WRITE,
> +                         0, VIRT_RTC_REG_BASE,
> +                         VIRT_RTC_REG_BASE + VIRT_RTC_LEN - 1,
> +                         0, VIRT_RTC_LEN));
> +    aml_append(crs,
> +               aml_interrupt(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> +                             AML_EXCLUSIVE, &rtc_irq, 1));
> +
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +
The rtc loongson driver drivers/rtc/rtc-loongson.c is bond with acpi pm1 
device since rtc device is wake-up source on physical machine, however 
acpi ged device rather than pm1 device is used on virt machine.

I think firstly we should submit patch to rtc loongson driver 
drivers/rtc/rtc-loongson.c so that it supports non acpi pm1 device, then 
submit rtc acpi dsdt table.

Regards
Bibo Mao
>   /* build DSDT */
>   static void
>   build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> @@ -488,6 +511,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>       for (i = 0; i < VIRT_UART_COUNT; i++) {
>           build_uart_device_aml(dsdt, i);
>       }
> +    acpi_dsdt_add_rtc(dsdt);
>       build_pci_device_aml(dsdt, lvms);
>       build_la_ged_aml(dsdt, machine);
>       build_flash_aml(dsdt, lvms);
> 


