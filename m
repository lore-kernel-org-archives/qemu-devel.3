Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011B3C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 07:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9gpt-0005fg-Js; Wed, 22 May 2024 03:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9gps-0005ey-A6
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:56:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9gpq-0006BR-Ec
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:56:31 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Axz64rpU1mGZYCAA--.1970S3;
 Wed, 22 May 2024 15:56:27 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxNMUqpU1m7EUFAA--.4544S3; 
 Wed, 22 May 2024 15:56:26 +0800 (CST)
Subject: Re: [PATCH v3 5/6] hw/loongarch: Remove minimum and default memory
 size
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240515093927.3453674-1-maobibo@loongson.cn>
 <20240515093927.3453674-6-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <dac2fefb-e906-8388-7a49-b1ca7f9d5836@loongson.cn>
Date: Wed, 22 May 2024 15:56:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240515093927.3453674-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxNMUqpU1m7EUFAA--.4544S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Xw4xKw4fZr4xWFWxur18CrX_yoW8JrWkpr
 97AF1kuF47tr9rJF9rXa4DXr1DJrn7AF9FgF12yFWqkrs0v34kWr4rA34kKFW2ya1kXFZ2
 vwn5CF43Xa1Fv3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5
 WrAUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.405, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2024/5/15 ÏÂÎç5:39, Bibo Mao Ð´µÀ:
> Some qtest test cases such as numa use default memory size of generic
> machine class, which is 128M by fault.
>
> Here generic default memory size is used, and also remove minimum memory
> size which is 1G originally.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   hw/loongarch/virt.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index ac980aec8e..7d3d1d1689 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -984,10 +984,6 @@ static void virt_init(MachineState *machine)
>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
>       }
>   
> -    if (ram_size < 1 * GiB) {
> -        error_report("ram_size must be greater than 1G.");
> -        exit(1);
> -    }
>       create_fdt(lvms);
>   
>       /* Create IOCSR space */
> @@ -1273,7 +1269,6 @@ static void virt_class_init(ObjectClass *oc, void *data)
>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>   
>       mc->init = virt_init;
> -    mc->default_ram_size = 1 * GiB;
>       mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
>       mc->default_ram_id = "loongarch.ram";
>       mc->max_cpus = LOONGARCH_MAX_CPUS;


