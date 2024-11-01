Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A717E67498
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 03:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6i8j-0000QG-N8; Thu, 31 Oct 2024 23:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t6i8h-0000Q7-SL
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 23:15:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t6i8e-0001kb-T4
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 23:15:55 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx++HeRyRnGWEjAA--.7003S3;
 Fri, 01 Nov 2024 11:15:42 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAx18DdRyRnbmwwAA--.33943S3;
 Fri, 01 Nov 2024 11:15:41 +0800 (CST)
Subject: Re: [PATCH v3 1/3] linux-headers: Add unistd_64.h
To: Alistair Francis <alistair23@gmail.com>, gaosong <gaosong@loongson.cn>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bmeng.cn@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20241028023809.1554405-1-maobibo@loongson.cn>
 <20241028023809.1554405-2-maobibo@loongson.cn>
 <b5f4a39a-278a-1918-29f2-b9da197ce055@loongson.cn>
 <08fa5950-8ca4-b6fc-fac7-77bc5c16893a@loongson.cn>
 <8b7dfe0f-f4cd-d61a-c850-d92b5aec39e8@loongson.cn>
 <CAKmqyKOGcjOFqUMiySYxtCyx-5_Rbx3=w9BYeUuS8mSrQ0bhxg@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <2c13c998-746c-8119-019b-71e3d6c16b01@loongson.cn>
Date: Fri, 1 Nov 2024 11:15:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOGcjOFqUMiySYxtCyx-5_Rbx3=w9BYeUuS8mSrQ0bhxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx18DdRyRnbmwwAA--.33943S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrZF15KFyxWr4DZr13Jw48Xwc_yoW8Jry5pa
 43AF1qyF4UWr4ftwn2kw1j9FsFvrnrKFW5XFy8Wr97Jas0kr13Xr1xJFZFkrWqv34rJFyU
 u3yakay3ZF15ZrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70Pf
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.257,
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

It passed to compile on riscv machine, and the testbed is riscv qemu VM.

Regards
Bibo Mao

On 2024/10/30 下午12:06, Alistair Francis wrote:
> On Wed, Oct 30, 2024 at 11:47 AM gaosong <gaosong@loongson.cn> wrote:
>>
>> 在 2024/10/28 下午5:55, maobibo 写道:
>>>
>>>
>>> On 2024/10/28 下午3:39, gaosong wrote:
>>>> 在 2024/10/28 上午10:38, Bibo Mao 写道:
>>>>> since 6.11, unistd.h includes header file unistd_64.h directly on
>>>>> some platforms, here add unistd_64.h on these platforms. Affected
>>>>> platforms are ARM64, LoongArch64 and Riscv. Otherwise there will
>>>>> be compiling error such as:
>>>>>
>>>>> linux-headers/asm/unistd.h:3:10: fatal error: asm/unistd_64.h: No
>>>>> such file or directory
>>>>>    #include <asm/unistd_64.h>
>>>> Hi,  Bibo
>>>>
>>>> Could you help tested this patch on ARM machine? I don't have an ARM
>>>> machine.
>>> yeap, I test on arm64 machine, it passes to compile with header files
>>> updated. However there is no riscv machine by hand.
>>>
>> Thank you,
>>
>> @Peter and  @Alistair Francis Could you help tested this patch on RISCV
>> machine?
> 
> I don't have a RISC-V machine either unfortunately.
> 
> You can test it with QEMU though
> 
> Alistair
> 


