Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C42C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 01:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTWd4-0002vv-0s; Mon, 15 Jul 2024 21:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sTWd2-0002vR-6n
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:05:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sTWcx-0002qs-Lr
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:05:15 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Dxs+k+x5VmtdAEAA--.3389S3;
 Tue, 16 Jul 2024 09:05:02 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxWcY7x5VmFIpKAA--.36691S3; 
 Tue, 16 Jul 2024 09:05:01 +0800 (CST)
Subject: Re: [PATCH v2 0/4] Reconstruct loongson ipi driver
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240704033802.3838618-1-maobibo@loongson.cn>
 <682d514b-1d49-4e23-9cb7-a6fd83cbd863@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <d26cf86a-2247-b5d9-3674-64cead2fa816@loongson.cn>
Date: Tue, 16 Jul 2024 09:04:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <682d514b-1d49-4e23-9cb7-a6fd83cbd863@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxWcY7x5VmFIpKAA--.36691S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF4rtw1rGw15CF1xJFWrZwc_yoW8Wr1UpF
 W7C3yYgF4kJrnagr1DAas0gFWDAw13KrZ2gF1FgrZ7urZ8Xr95Xw4FvrWUZa15Cw1xJ3Wj
 va10934UZFWDAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
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
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.467,
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



On 2024/7/15 下午11:17, Philippe Mathieu-Daudé wrote:
> On 4/7/24 05:37, Bibo Mao wrote:
>> Now loongson ipi and loongarch ipi share the same code with different
>> macro, loongson ipi has its separate function such mmio region,
>> loongarch ipi has other requirement such as irqchip in kernel.
>>
>> Interrupt irqchip has strong relationship with architecture, since
>> it sends irq to vcpu and interfaces to get irqchip register is also
>> architecture specific.
>>
>> Here like other architectures, base class TYPE_LOONGSON_IPI_COMMON
>> is added, it comes from loongson ipi mostly. And it defined four abstract
>> interfaces which can be used for MIPS 3A4000 and Loongarch 3A5000 
>> machine,
>> also can be used for 3A5000 irqchip in kernel mode soon.
>>
>> Also Loongarch ipi and loongson ipi device are added here, it inherits
>> from base class TYPE_LOONGSON_IPI_COMMON. Loongarch ipi is tested,
>> loongson ipi device only passes to compile and make check, it is not
>> tested.
>>
>> Bibo Mao (4):
>>    hw/intc/loongson_ipi_common: Add loongson ipi common class
>>    hw/intc/loongarch_ipi: Add loongarch ipi support
>>    hw/loongarch/virt: Replace loongson ipi with loongarch ipi
>>    hw/intc/loongson_ipi: reconstruct driver inherit from common class
> 
> I'll try to respin a clearer v3.
I am ok with it since it solve the problem, and it is suitable for 9.1 
release. Only that in the long time we hope that intc emulation driver 
has common base class + tcg/kvm driver, similar with other architecture.

Regards
Bibo mao


