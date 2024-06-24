Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D3DC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 11:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLhmn-0006uK-4a; Mon, 24 Jun 2024 07:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1sLhmk-0006uA-Io
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:22:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1sLhmg-0006Nv-99
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:22:57 -0400
Received: from loongson.cn (unknown [10.20.42.22])
 by gateway (Coremail) with SMTP id _____8Ax3eoEV3lmUYEJAA--.38408S3;
 Mon, 24 Jun 2024 19:22:44 +0800 (CST)
Received: from [10.20.42.22] (unknown [10.20.42.22])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxNMUAV3lmPBgvAA--.36246S3; 
 Mon, 24 Jun 2024 19:22:43 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch: Modify flash block size to 256K
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20240624033319.999631-1-lixianglai@loongson.cn>
 <63937d18-e330-442d-ba91-7841171ddc55@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <0ae51497-cb6f-29d1-d868-862d72877d6f@loongson.cn>
Date: Mon, 24 Jun 2024 19:22:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <63937d18-e330-442d-ba91-7841171ddc55@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxNMUAV3lmPBgvAA--.36246S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF17WrWUur43JryUWr47ZFc_yoW8ur48pF
 WkAF1rWrWkGrn7GasrX3W7Wry8JwsrG3W7XF1xuFy8A3ZxW3WvqrWvqws09Fy8Xr48JFyI
 qryktrZrZFs8ZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.232,
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

Hi Philippe:
> Hi Xianglai,
>
> On 24/6/24 05:33, Xianglai Li wrote:
>> loongarch added a common library for edk2 to
>> parse flash base addresses through fdt.
>> For compatibility with other architectures,
>> the flash block size in qemu is now changed to 256k.
>
> Why is that an issue / concern?
>

The patch submitted in edk2 is as follows:
https://edk2.groups.io/g/devel/message/118988
The commit ID is:
cac1ea6c2a6eac1772556e718154a00fcb093b88

+
+#include <Protocol/FdtClient.h>
+#include <stdbool.h>
+
+#define QEMU_NOR_BLOCK_SIZE  SIZE_256KB

In this patch, only the flash base address is resolved from the fdt,
and there is no flash block size information.
The default flash block size of the old implementation is 256K.
In order to be compatible with the flash block size used by the existing
architecture to achieve the purpose of minimum modification,
The default flash block size in this patch is 256K.

The subsequent bios of loongarch will also use the lib library provided by this patch,
so the flash block size needs to be changed to 256K。

Thanks,
Xianglai.

>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Cc: Song Gao <gaosong@loongson.cn>
>>
>>   include/hw/loongarch/virt.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>> index 8fdfacf268..603c1cebdb 100644
>> --- a/include/hw/loongarch/virt.h
>> +++ b/include/hw/loongarch/virt.h
>> @@ -20,7 +20,7 @@
>>   #define VIRT_FWCFG_BASE         0x1e020000UL
>>   #define VIRT_BIOS_BASE          0x1c000000UL
>>   #define VIRT_BIOS_SIZE          (16 * MiB)
>> -#define VIRT_FLASH_SECTOR_SIZE  (128 * KiB)
>> +#define VIRT_FLASH_SECTOR_SIZE  (256 * KiB)
>>   #define VIRT_FLASH0_BASE        VIRT_BIOS_BASE
>>   #define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE
>>   #define VIRT_FLASH1_BASE        0x1d000000UL
>


