Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4743EC27C77
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 05:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHzJz-0004WW-0b; Fri, 14 Jun 2024 01:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sHzJx-0004WA-8N
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 01:17:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sHzJu-0000VV-Cj
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 01:17:53 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxW+p30mtmpMgGAA--.27452S3;
 Fri, 14 Jun 2024 13:17:43 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxssRz0mtmnMofAA--.953S3; 
 Fri, 14 Jun 2024 13:17:42 +0800 (CST)
Subject: Re: [PATCH 0/3] S3 and S4 sleep for loongarch/virt & microvm
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel
 <qemu-devel@nongnu.org>, Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
 <002b6625-9fed-beeb-700c-93438023d873@loongson.cn>
 <ac2dbd67-97f7-4748-b545-3d05cb1d9a36@app.fastmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <b1aacf5a-382f-99fc-9901-fdbce07c8381@loongson.cn>
Date: Fri, 14 Jun 2024 13:17:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ac2dbd67-97f7-4748-b545-3d05cb1d9a36@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxssRz0mtmnMofAA--.953S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF4xJFWUCw15Aw4xtry3KFX_yoW8AFy7pa
 yj9F15KF1xJryxCanIqwnaqFyYqrWkGw12qFnxCry8Grs0vF1rA3WvkrnYgF98Z34xGF1S
 vr1jga9rWF4DArXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
 daVFxhVjvjDU0xZFpf9x07j0sjUUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.395,
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



On 2024/6/14 下午12:27, Jiaxun Yang wrote:
> 
> 
> 在2024年6月14日六月 上午4:32，maobibo写道：
>> It is interesting.
>>
>> How to wakeup VM if it sleeps in S3/S4, from emulated keyboard or
>> ethernet magic packet or qemu monitor command in background?
> 
> Hi Bibo,
> 
> The best way to wake the guest is system_wakeup command in monitor.
Ok, I see.

It is useful and it can be used to test S3/S4 in TCG mode at least.

Can we add feature capability, enabled in TCG mode, disabled in KVM mode 
by default? If vm deploys in cloud, users in general help it is power-on 
always.

Regards
Bibo Mao
> 
> Thanks
> - Jiaxun
> 
>>
>> Regards
>> Bibo Mao
>>
>>
>> On 2024/6/14 上午1:30, Jiaxun Yang wrote:
>>> Hi all,
>>>
>>> This series implemented S3 and S4 sleep for loongarch virt machine
>>> and microvm.
>>>
>>> For loongarch/virt a kernel patch is requried [1].
>>>
>>> [1]: https://lore.kernel.org/loongarch/20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com/
>>>
>>> Please review.
>>> Thanks
>>>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>> Jiaxun Yang (3):
>>>         acpi/ged: Implement S3 and S4 sleep
>>>         hw/loongarch/virt: Wire up S3 and S4 sleep
>>>         hw/i386/microvm: Wire up S3 and S4 sleep
>>>
>>>    hw/acpi/generic_event_device.c         | 70 ++++++++++++++++++++++++++++++----
>>>    hw/i386/acpi-microvm.c                 | 18 +++++++++
>>>    hw/i386/microvm.c                      |  3 ++
>>>    hw/loongarch/acpi-build.c              | 18 +++++++++
>>>    hw/loongarch/virt.c                    |  3 ++
>>>    include/hw/acpi/generic_event_device.h | 12 +++++-
>>>    6 files changed, 115 insertions(+), 9 deletions(-)
>>> ---
>>> base-commit: f3e8cc47de2bc537d4991e883a85208e4e1c0f98
>>> change-id: 20240613-loongarch64-sleep-37b2466b8d76
>>>
>>> Best regards,
>>>
> 


