Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DC7D74953
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5xW1-0003mn-W0; Tue, 29 Oct 2024 21:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t5xVy-0003mR-6x
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:28:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t5xVu-0008KR-V0
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:28:49 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxaeHGiyFnSUAdAA--.60675S3;
 Wed, 30 Oct 2024 09:28:38 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxreDEiyFnTjIoAA--.2240S3;
 Wed, 30 Oct 2024 09:28:36 +0800 (CST)
Subject: Re: [PATCH 1/1] hw/loongarch/boot: Use warn_report when no kernel
 filename
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 jiaxun.yang@flygoat.com, maobibo@loongson.cn, pbonzini@redhat.com,
 armbru@redhat.com, lixianglai@loongson.cn
References: <20241029093501.3980927-1-gaosong@loongson.cn>
 <5232854c-c3d7-44c0-ab1d-ed46d8a7b1c9@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <b735cbe2-e048-9208-557d-998b18b61415@loongson.cn>
Date: Wed, 30 Oct 2024 09:29:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5232854c-c3d7-44c0-ab1d-ed46d8a7b1c9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxreDEiyFnTjIoAA--.2240S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWxurWxKF45ArW7Gr4DGFX_yoW8Ar18pr
 n7ZryDJrZ5JF1kWw1UJ347WFyDJr4UKa1agFnrXa48J3yUXr1jqr18Xr9F9FyUtw4rKF1j
 vr15J34avF1UJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.804,
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

在 2024/10/30 上午3:48, Philippe Mathieu-Daudé 写道:
> On 29/10/24 06:35, Song Gao wrote:
>> When we run “qemu-system-loongarch64 -qmp stdio -vnc none -S”,
>> we get an error message “Need kernel filename” and then we can't use 
>> qmp cmd to query some information.
>> So, we just throw a warning and then the cpus starts running from 
>> address VIRT_FLASH0_BASE.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/loongarch/boot.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index cb668703bd..9c37abed3a 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -278,7 +278,7 @@ static void init_boot_rom(struct 
>> loongarch_boot_info *info, void *p)
>>   static void loongarch_direct_kernel_boot(struct loongarch_boot_info 
>> *info)
>>   {
>>       void *p, *bp;
>> -    int64_t kernel_addr = 0;
>> +    int64_t kernel_addr = VIRT_FLASH0_BASE;
>>       LoongArchCPU *lacpu;
>>       CPUState *cs;
>>   @@ -286,8 +286,7 @@ static void loongarch_direct_kernel_boot(struct 
>> loongarch_boot_info *info)
>>           kernel_addr = load_kernel_info(info);
>>       } else {
>>           if(!qtest_enabled()) {
>> -            error_report("Need kernel filename\n");
>> -            exit(1);
>> +            warn_report("Need kernel filename\n");
>
> Either nothing or "No kernel provided, booting from flash drive"?
>
I will change the message.

Thanks.
Song Gao
>>           }
>>       }


