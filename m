Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ACDC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 08:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSZ3x-0007J0-DO; Wed, 24 Jan 2024 03:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rSZ3u-0007Is-Jl
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 03:56:46 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rSZ3s-0006a6-58
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 03:56:46 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxHOvE0LBl9KcEAA--.8315S3;
 Wed, 24 Jan 2024 16:56:37 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxLs_B0LBlCYMWAA--.33620S3; 
 Wed, 24 Jan 2024 16:56:35 +0800 (CST)
Subject: Re: [NOTFORMERGE PATCH 2/2] gitlab: Add Loongarch64 KVM-only build
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-3-philmd@linaro.org>
 <dbc7f2c6-15c0-4d5a-abf7-8946ff2d03cb@redhat.com>
 <4cc9ab90-c1bc-03d3-d82e-a763199fa029@loongson.cn>
 <96bdddb5-e15c-469f-b74b-7e82049888f1@redhat.com>
 <3766d853-8dc5-f455-e0ea-dd970c65a6c5@loongson.cn>
 <6f17d2f1-6876-4f1c-beb5-c6a4e89340d8@redhat.com>
 <94b84fa3-4a10-3fef-0415-6b87f2aa255b@loongson.cn>
 <0964ddb6-f403-4bec-8f90-23f8b9b0dfd6@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <102fd8fe-fb9c-9374-1ab7-1daccfad0064@loongson.cn>
Date: Wed, 24 Jan 2024 16:56:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0964ddb6-f403-4bec-8f90-23f8b9b0dfd6@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxLs_B0LBlCYMWAA--.33620S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWxZrWfGryxJF45WF4xZrc_yoW8Wr1xpF
 yfAFWjqw4kJ395Kas3Kw1DuFnIyrWSvayIga1kCa4UW34DAr9Yqr48Jrs09a40q3s7Ww12
 vF4avasxXF98A3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9
 N3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.17,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

在 2024/1/11 下午7:26, Philippe Mathieu-Daudé 写道:
> On 11/1/24 10:51, gaosong wrote:
>> 在 2024/1/11 下午5:04, Thomas Huth 写道:
>>> On 11/01/2024 09.50, gaosong wrote:
>>>> 在 2024/1/11 下午4:20, Thomas Huth 写道:
>>>>> On 11/01/2024 08.37, gaosong wrote:
>
>>>> LoongArch no support these cmds  or some problems .
>>>> -    "gva2gpa 0",
>>>> -    "memsave 0 4096 \"/dev/null\"",
>>>> -    "x /8i 0x100",
>>>> -    "xp /16x 0",
>>>>
>>>> Could we disable these 4 cmds or the test_temp check?
>>>> After we fix the cmds problems, we can enable them.
>>>
>>> Even if loongarch does not support one of these commands, it should 
>>> not crash QEMU. So please fix the crashes first before considering 
>>> to enable the KVM-only test in the CI.
>>>
>>
>> Sure,  we will fix the cmds problems first.
>
> The issue might be missing get_phys_page_attrs_debug() implementation.

We use  '--enable-kvm --disable-tcg ',
the get_phys_page_debug()  is NULL,  so the test-hmp failed.

target/loongarch/cpu.c
...
#ifndef CONFIG_USER_ONLY
#include "hw/core/sysemu-cpu-ops.h"

static const struct SysemuCPUOps loongarch_sysemu_ops = {
#ifdef CONFIG_TCG
     .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
#endif
};
...

I see the other architectures  only implement 
get_phys_page_attrs_debug() or  get_phys_page_debug()
and not only build these functions on tcg mode.

Should we need implement  get_phys_page_attrs_debug() ?  or just use 
get_phys_page_debug()

Thanks.
Song Gao


