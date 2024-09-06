Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB89CE7AA5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 01:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smNU0-0007X3-4q; Thu, 05 Sep 2024 21:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1smNTx-0007WR-7x
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 21:09:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1smNTt-0007Ks-RP
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 21:09:48 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxHJtNVtpmCfIrAA--.47989S3;
 Fri, 06 Sep 2024 09:09:34 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front2 (Coremail) with SMTP id qciowMDx_8dNVtpmfEQHAA--.22932S3;
 Fri, 06 Sep 2024 09:09:33 +0800 (CST)
Subject: Re: qemu direct kernel boot on LoongArch
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
 loongarch@lists.linux.dev, qemu-devel@nongnu.org, xry111@xry111.site
References: <1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de>
 <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
 <ZtkhtxcJUK-JediY@zx2c4.com>
 <f50c4868-7c2e-1ede-ab19-c67ea0acaab3@loongson.cn>
 <CAHmME9rRJjJ5tHf_xtprkHtWz-ButOOZXVo=E9y8qSyQ-qu6ew@mail.gmail.com>
 <ccc7db47-d065-4e78-bf67-c4e8855c9be4@t-8ch.de>
 <95da2e9e-0905-ad61-6bf9-c2636f2cc5f1@loongson.cn>
 <ZtnGMdFRpTAVPnym@zx2c4.com> <ZtnS9_xoPrXCWWln@zx2c4.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <8382893e-b990-24cf-5411-005f1251143a@loongson.cn>
Date: Fri, 6 Sep 2024 09:09:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZtnS9_xoPrXCWWln@zx2c4.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMDx_8dNVtpmfEQHAA--.22932S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFW8Xry3XFyDAry7Xry3WrX_yoW8WrWfpF
 yjkFWqkrsYqrWDAF9agw1jkFyFywsrtw4rXw18Ar98WwsIyryavF12grW7Ca45Kw1xJF1j
 vFnrX347X3yUJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
 twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
 Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
 AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
 cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
 8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
 6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjWlkUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.9,
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



On 2024/9/5 下午11:49, Jason A. Donenfeld wrote:
> On Thu, Sep 05, 2024 at 04:54:41PM +0200, Jason A. Donenfeld wrote:
>> On Thu, Sep 05, 2024 at 02:11:32PM +0800, maobibo wrote:
>>>
>>>
>>> On 2024/9/5 下午1:25, Thomas Weißschuh wrote:
>>>> On 2024-09-05 06:04:12+0000, Jason A. Donenfeld wrote:
>>>>> On Thu, Sep 5, 2024 at 5:45 AM maobibo <maobibo@loongson.cn> wrote:
>>>>>>
>>>>>> Jason,
>>>>>>
>>>>>> With the latest qemu 9.1 version, elf format booting is supported.
>>>>>
>>>>> Thanks, I just figured this out too, about 4 minutes ago. Excellent.
>>>>> And the 1G minimum ram limit is gone too.
>>>>>
>>>>> Now working on how to trigger resets.
>>>>
>>>> With "reset" do you mean normal (non-panic) system shutdown/poweroff?
>>>> Since QEMU 9.1 and a recent kernel you can use the pvpanic device for
>>>> that in a cross-architecture way.
>>> LoongArch uses acpi GED device to reboot machine. Now there is no FDT
>>> table description and FDT driver for acpi GED device :(
>>
>> So you mean that QEMU exposes it via ACPI, but not via FDT, and the
>> kernel doesn't know how to recognize it, even with ACPI?
> 
> Ahh, it looks like QEMU exposes it via ACPI, but ACPI is broken (?) when
> booting directly from ELF. So it needs to be exposed via FDT instead? Or
> ACPI needs to be fixed with direct ELF boot?
We plant to expose ACPI GED via FDT interface with syscon method, and 
the reboot driver in linux kernel side is
drivers/power/reset/syscon-reboot.c.

The only difference is that ACPI GED register is accessed with 
byte-mode, it seems that it works well with draft version.

Regards
Bibo Mao
> 


