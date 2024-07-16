Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B581C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 01:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTX0g-0005Cs-DU; Mon, 15 Jul 2024 21:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sTX0d-0005CH-1x
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:29:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sTX0a-0007x6-H5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:29:38 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cx5On7zJVmw9UEAA--.3496S3;
 Tue, 16 Jul 2024 09:29:32 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxQcT4zJVm5pJKAA--.416S3; 
 Tue, 16 Jul 2024 09:29:30 +0800 (CST)
Subject: Re: [PATCH v2 0/4] Reconstruct loongson ipi driver
From: maobibo <maobibo@loongson.cn>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240704033802.3838618-1-maobibo@loongson.cn>
 <682d514b-1d49-4e23-9cb7-a6fd83cbd863@linaro.org>
 <d26cf86a-2247-b5d9-3674-64cead2fa816@loongson.cn>
Message-ID: <b4a9e1e9-467c-2d50-0d24-174fc9e5c5fe@loongson.cn>
Date: Tue, 16 Jul 2024 09:29:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d26cf86a-2247-b5d9-3674-64cead2fa816@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxQcT4zJVm5pJKAA--.416S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4DZF18KrWDCr4DtryUtwc_yoW8Aw45pF
 Z7CayYgF4DGr1fGr1qyas0gFWqyr13KFZ2gF1Fq348CrZ0gr95Xw4fZrWDuan8Aw1xJ3W0
 vFW09347ZFWDAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
 AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
 Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
 AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
 cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
 8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2L05UUUUU
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



On 2024/7/16 上午9:04, maobibo wrote:
> 
> 
> On 2024/7/15 下午11:17, Philippe Mathieu-Daudé wrote:
>> On 4/7/24 05:37, Bibo Mao wrote:
>>> Now loongson ipi and loongarch ipi share the same code with different
>>> macro, loongson ipi has its separate function such mmio region,
>>> loongarch ipi has other requirement such as irqchip in kernel.
>>>
>>> Interrupt irqchip has strong relationship with architecture, since
>>> it sends irq to vcpu and interfaces to get irqchip register is also
>>> architecture specific.
>>>
>>> Here like other architectures, base class TYPE_LOONGSON_IPI_COMMON
>>> is added, it comes from loongson ipi mostly. And it defined four 
>>> abstract
>>> interfaces which can be used for MIPS 3A4000 and Loongarch 3A5000 
>>> machine,
>>> also can be used for 3A5000 irqchip in kernel mode soon.
>>>
>>> Also Loongarch ipi and loongson ipi device are added here, it inherits
>>> from base class TYPE_LOONGSON_IPI_COMMON. Loongarch ipi is tested,
>>> loongson ipi device only passes to compile and make check, it is not
>>> tested.
>>>
>>> Bibo Mao (4):
>>>    hw/intc/loongson_ipi_common: Add loongson ipi common class
>>>    hw/intc/loongarch_ipi: Add loongarch ipi support
>>>    hw/loongarch/virt: Replace loongson ipi with loongarch ipi
>>>    hw/intc/loongson_ipi: reconstruct driver inherit from common class
>>
>> I'll try to respin a clearer v3.
> I am ok with it since it solve the problem, and it is suitable for 9.1 
> release. Only that in the long time we hope that intc emulation driver 
> has common base class + tcg/kvm driver, similar with other architecture.
> 
Sorry for the confusion, I had thought it was another topic.

Thanks for pointing out the problem and welcome the v3 version.

Regards
Bibo Mao
> Regards
> Bibo mao
> 


