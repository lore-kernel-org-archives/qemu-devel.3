Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA19C54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 01:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri2gH-0000kh-6s; Wed, 06 Mar 2024 20:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1ri2gC-0000kV-V3
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 20:36:17 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1ri2gA-0003eS-8T
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 20:36:16 -0500
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8DxqegJGullmnsVAA--.33879S3;
 Thu, 07 Mar 2024 09:36:09 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxb88GGullybBPAA--.12142S2; 
 Thu, 07 Mar 2024 09:36:08 +0800 (CST)
Subject: Re: [PULL v2 1/1] loongarch: Change the UEFI loading mode to loongarch
To: chen huacai <zltjiangshi@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, Andrea Bolognani <abologna@redhat.com>,
 maobibo@loongson.cn, zhaotianrui@loongson.cn
References: <20240229113842.619738-1-gaosong@loongson.cn>
 <20240229113842.619738-2-gaosong@loongson.cn>
 <168d29d9-b82e-4dd5-abdd-93759037033c@linaro.org>
 <5e2419ec-6c1f-e21c-2105-fadb5971239c@loongson.cn>
 <CABDp7VqyOL9OdxRohru74CyhQzR7W6MwKcg8WCvOVWJz1echMA@mail.gmail.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <9b241933-f172-6a2d-75eb-0cbd15b0d28a@loongson.cn>
Date: Thu, 7 Mar 2024 09:36:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABDp7VqyOL9OdxRohru74CyhQzR7W6MwKcg8WCvOVWJz1echMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxb88GGullybBPAA--.12142S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy5tw1DGr17CFW3Wry8JFc_yoW5JrWfpF
 W7C3WYkF4DJrW7ArnIvayIgrZIvrZ5KF97XF4Svry8Cw1DAwn5Xr1rKr1kAFyxXa4xG3Wj
 vrW8KFyUWan8ArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.194,
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

Hi huacai:

> Hi, Xianglai,
>
> How to pass the BIOS file to qemu after this patch? With the old
> cmdline I get an RCU stall and freeze the kvm host.

The bios also has the corresponding code modification,

you can update the code from the UEFI community to recompile UEFI,

or you can directly obtain the compiled bios from the link below:

https://github.com/lixianglai/LoongarchVirtFirmware

Thanks,

Xianglai.


> Huacai
>
> On Sat, Mar 2, 2024 at 12:14 PM lixianglai <lixianglai@loongson.cn> wrote:
>> Hi Philippe:
>>
>> On 29/2/24 12:38, Song Gao wrote:
>>
>> From: Xianglai Li <lixianglai@loongson.cn>
>>
>> The UEFI loading mode in loongarch is very different
>> from that in other architectures:loongarch's UEFI code
>> is in rom, while other architectures' UEFI code is in flash.
>>
>> loongarch UEFI can be loaded as follows:
>> -machine virt,pflash=pflash0-format
>> -bios ./QEMU_EFI.fd
>>
>> Other architectures load UEFI using the following methods:
>> -machine virt,pflash0=pflash0-format,pflash1=pflash1-format
>>
>> loongarch's UEFI loading method makes qemu and libvirt incompatible
>> when using NVRAM, and the cost of loongarch's current loading method
>> far outweighs the benefits, so we decided to use the same UEFI loading
>> scheme as other architectures.
>>
>>
>> FYI I'm still trying to find a way to avoid that, planning to discuss
>> more with libvirt folks. Well, maybe it is a waste of my time and I
>> should just stop worrying / caring about this long standing issue.
>>
>> Thank you so much for your attention to this issue
>>
>> and your long-standing contributions to the community!!:-)
>>
>> Best regards,
>>
>> Xianglai.
>>
>>
>> Cc: Andrea Bolognani <abologna@redhat.com>
>> Cc: maobibo@loongson.cn
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: zhaotianrui@loongson.cn
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> Tested-by: Andrea Bolognani <abologna@redhat.com>
>> Reviewed-by: Song Gao <gaosong@loongson.cn>
>> Message-Id: <0bd892aa9b88e0f4cc904cb70efd0251fc1cde29.1708336919.git.lixianglai@loongson.cn>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>    hw/loongarch/acpi-build.c   |  29 +++++++++--
>>    hw/loongarch/virt.c         | 101 ++++++++++++++++++++++++++----------
>>    include/hw/loongarch/virt.h |  10 ++--
>>    3 files changed, 107 insertions(+), 33 deletions(-)
>>
>>
>


