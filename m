Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507E6606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 01:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJhVx-0002AY-CU; Wed, 21 Oct 2026 21:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xJhVq-00024X-V1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 21:22:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xJhVl-0006gj-F9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 21:22:33 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxW_BOZdlqKj8YAA--.5174S3;
 Thu, 22 Oct 2026 09:22:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBxpMxNZdlqbgUvAA--.6189S2;
 Thu, 22 Oct 2026 09:22:21 +0800 (CST)
Subject: Re: [PATCH v3 2/3] hw/loongarch/virt: Drop UART _DSD/_CCA and add _STA
To: pillow <waysorrypub@gmail.com>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, lixianglai@loongson.cn, jiaxun.yang@flygoat.com,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com
References: <20261021135322.473781-1-waysorrypub@gmail.com>
 <20261021135322.473781-3-waysorrypub@gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <48483527-13dd-bf40-bb90-bef7aacf5bb9@loongson.cn>
Date: Thu, 22 Oct 2026 09:23:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021135322.473781-3-waysorrypub@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpMxNZdlqbgUvAA--.6189S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF1UuFWfXF4kWrW5XF1UArc_yoW5Cry3pr
 W2yF4vyw1qqFyxW3y5Aa1fWF1Yyw1kJ3y2v347Ary09a9agr48trW0yrZagr15Aas3ZFWj
 vrZYgw1kCF48ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.689,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/10/21 下午9:53, pillow wrote:
> The UART _DSD contains only a clock property, which has a typo
> ("clock-frenquency") and the key/value order is reversed. The declared
> 100 MHz also does not match the current QEMU model.
> 
> The Linux PNP serial driver uses uartclk = 1843200 Hz by default, and
> the QEMU UART uses baudbase = 115200. These correspond as
> uartclk / 16 = baudbase (1843200 / 16 = 115200), so the Linux default
baudrate = uartclk / 16 / divider, the default divider is 12, so the 
default baudrate is 9600. It can be referenced in function serial_reset():
     /* Default to 9600 baud, 1 start bit, 8 data bits */
     s->divider = 0x0C;

The clock freq in FDT table should be changed with 1843200 rather than 
100000000, however it may be another issue.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

> clock is consistent with the QEMU model. Since the clock property is
> the only content of the _DSD, remove the entire _DSD rather than
> keeping an empty one. The QEMU x86 ISA serial ACPI description also
> does not provide a clock property, which is consistent with this
> change.
> 
> Also drop _CCA because the emulated UART does not support DMA, and add
> _STA = 0x0f to indicate the device is present, enable, should be
> shown and functioning properly.
> 
> Signed-off-by: pillow <waysorrypub@gmail.com>
> ---
>   hw/loongarch/virt-acpi-build.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index 54965f0..55c7641 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -314,7 +314,6 @@ static void build_uart_device_aml(Aml *table, int index)
>   {
>       Aml *dev;
>       Aml *crs;
> -    Aml *pkg0, *pkg1, *pkg2;
>       Aml *scope;
>       uint32_t uart_irq;
>       uint64_t base;
> @@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, int index)
>       dev = aml_device("COM%d", index);
>       aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
>       aml_append(dev, aml_name_decl("_UID", aml_int(index)));
> -    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0x0f)));
>       crs = aml_resource_template();
>       aml_append(crs,
>           aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> @@ -335,15 +334,6 @@ static void build_uart_device_aml(Aml *table, int index)
>       aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
>                                     AML_SHARED, &uart_irq, 1));
>       aml_append(dev, aml_name_decl("_CRS", crs));
> -    pkg0 = aml_package(0x2);
> -    aml_append(pkg0, aml_int(0x05F5E100));
> -    aml_append(pkg0, aml_string("clock-frenquency"));
> -    pkg1 = aml_package(0x1);
> -    aml_append(pkg1, pkg0);
> -    pkg2 = aml_package(0x2);
> -    aml_append(pkg2, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
> -    aml_append(pkg2, pkg1);
> -    aml_append(dev, aml_name_decl("_DSD", pkg2)); >       aml_append(scope, dev);
>       aml_append(table, scope);
>   }
> 


