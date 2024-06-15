Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961F7C27C6E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2024 01:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIIUU-0002QH-RL; Fri, 14 Jun 2024 21:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sIIUT-0002Q8-34
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 21:46:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sIIUQ-0005K9-4I
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 21:46:00 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxzOpO8mxmmBAHAA--.28631S3;
 Sat, 15 Jun 2024 09:45:50 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx28ZM8mxm30whAA--.15932S3; 
 Sat, 15 Jun 2024 09:45:50 +0800 (CST)
Subject: Re: [PATCH 0/3] S3 and S4 sleep for loongarch/virt & microvm
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel
 <qemu-devel@nongnu.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
 <002b6625-9fed-beeb-700c-93438023d873@loongson.cn>
 <ac2dbd67-97f7-4748-b545-3d05cb1d9a36@app.fastmail.com>
 <b1aacf5a-382f-99fc-9901-fdbce07c8381@loongson.cn>
 <ZmxNx81Hr9u53_Hs@redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <d331a79a-0b4e-4146-ea9c-16e3a36e55cf@loongson.cn>
Date: Sat, 15 Jun 2024 09:45:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZmxNx81Hr9u53_Hs@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx28ZM8mxm30whAA--.15932S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF1kXF47CF47tFy8Xr4DWrX_yoWkXFXEyr
 s7ZrnYyFs8Xay7K3yktFWfXr9xWw4jgws5J348X342kwn2y397Cr4vgrZ2v3409FyxArZx
 Crn8ua4Sy343AosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
 JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-UUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.018,
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



On 2024/6/14 下午10:03, Daniel P. Berrangé wrote:
> On Fri, Jun 14, 2024 at 01:17:39PM +0800, maobibo wrote:
>>
>>
>> On 2024/6/14 下午12:27, Jiaxun Yang wrote:
>>>
>>>
>>> 在2024年6月14日六月 上午4:32，maobibo写道：
>>>> It is interesting.
>>>>
>>>> How to wakeup VM if it sleeps in S3/S4, from emulated keyboard or
>>>> ethernet magic packet or qemu monitor command in background?
>>>
>>> Hi Bibo,
>>>
>>> The best way to wake the guest is system_wakeup command in monitor.
>> Ok, I see.
>>
>> It is useful and it can be used to test S3/S4 in TCG mode at least.
>>
>> Can we add feature capability, enabled in TCG mode, disabled in KVM mode by
>> default? If vm deploys in cloud, users in general help it is power-on
>> always.
> 
> Please avoid creating differing defaults between TCG and KVM where
> practical.
There is bad experience for me, remote VM suddenly freezes and all 
network connection are lost if virt-machine does not support S3/S4 on 
LoongArch machines.

However it does not happen on x86 machine, how does x86 KVM VM machine 
stop this?

Regards
Bibo Mao
> 
> With regards,
> Daniel
> 


