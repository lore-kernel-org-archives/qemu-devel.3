Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEEFCD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 09:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKucG-0007Ms-QU; Thu, 07 May 2026 05:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wKucD-0007Mj-Pf
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:01:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wKucA-0002r8-Qt
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:01:53 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxAuv1VPxpP20HAA--.24067S3;
 Thu, 07 May 2026 17:01:42 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCx_8LzVPxpgy18AA--.39533S3;
 Thu, 07 May 2026 17:01:39 +0800 (CST)
Subject: Re: [PATCH 1/4] update-linux-headers.sh: add typelimits.h to portable
 header list
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
Cc: maobibo@loongson.cn, qemu-devel@nongnu.org, lixianglai@loongson.cn,
 chenhuacai@loongson.cn, pbonzini@redhat.com, cohuck@redhat.com,
 thuth@redhat.com, mst@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org,
 Avihai Horon <avihaih@nvidia.com>
References: <20260427070029.1059386-1-gaosong@loongson.cn>
 <20260427070029.1059386-2-gaosong@loongson.cn>
 <0a95025f-7234-ae8f-641d-cf605c5742ce@loongson.cn>
 <c36929a0-f6a0-4db8-85fb-733853171893@redhat.com>
 <161dc86d-dcb5-731a-f5d4-2a4cc3321b88@loongson.cn>
 <7fe94a3b-92b3-41d4-87d0-0171cfca13be@redhat.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <e8841523-cc65-0217-7279-b06f52bf5b18@loongson.cn>
Date: Thu, 7 May 2026 17:03:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7fe94a3b-92b3-41d4-87d0-0171cfca13be@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCx_8LzVPxpgy18AA--.39533S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF4DWr45Cr1kZFWDAr13GFX_yoW5JFykpF
 4kCFyUAry3Jw1xJw12qFyIkFyYqw45J3ZFgryUGFy0yFWqgr1Igr47Zrn09ryDJw48Ca1j
 qr43J347urn2yrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2J5rDU
 UUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.736,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

在 2026/5/7 下午3:49, Cédric Le Goater 写道:
> On 5/7/26 09:45, gaosong wrote:
>> 在 2026/5/7 下午2:58, Cédric Le Goater 写道:
>>> On 5/7/26 08:23, gaosong wrote:
>>>> Ping~
>>>>
>>>> 在 2026/4/27 下午3:00, Song Gao 写道:
>>>>> Linux kernel introduced a new UAPI header file typelimits.h in the 
>>>>> 7.1
>>>>> development cycle (commit merged in Jan 2026). This file is 
>>>>> required by
>>>>> ethtool.h and other headers that include it.
>>>>>
>>>>> Since QEMU's update script only copies headers explicitly listed 
>>>>> in the
>>>>> for loop, typelimits.h was missing after updating to newer kernel
>>>>> versions, causing compilation errors like:
>>>>>
>>>>>    fatal error: standard-headers/linux/typelimits.h: No such file 
>>>>> or directory
>>>>>
>>>>> Add typelimits.h to the list of headers processed by cp_portable() to
>>>>> ensure it is properly copied and sanitized into the QEMU source tree
>>>>>
>>>>> Cc: clg@redhat.com
>>>>> Cc: pbonzini@redhat.com
>>>>> Cc: cohuck@redhat.com
>>>>> Cc: thuth@redhat.com
>>>>> Cc: mst@redhat.com
>>>>> Cc: peter.maydell@linaro.org
>>>>> Cc: richard.henderson@linaro.org
>>>>> Cc: philmd@linaro.org
>>>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>>>> ---
>>>>>   scripts/update-linux-headers.sh | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/scripts/update-linux-headers.sh 
>>>>> b/scripts/update-linux-headers.sh
>>>>> index 386d7a38e7..471f9cc71e 100755
>>>>> --- a/scripts/update-linux-headers.sh
>>>>> +++ b/scripts/update-linux-headers.sh
>>>>> @@ -255,6 +255,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
>>>>>            "$hdrdir/include/linux/vhost_types.h" \
>>>>>            "$hdrdir/include/linux/vmclock-abi.h" \
>>>>>            "$hdrdir/include/linux/nitro_enclaves.h" \
>>>>> +         "$hdrdir/include/linux/typelimits.h" \
>>>>>            "$hdrdir/include/linux/sysinfo.h"; do
>>>>>       cp_portable "$i" "$output/include/standard-headers/linux"
>>>>>   done
>>>>
>>>
>>> There is one issue with this patch. The headers should be sanitized.
>>>
>>> See :
>>>
>>> https://lore.kernel.org/qemu-devel/20260505081423.28326-2-avihaih@nvidia.com 
>>>
>>>
>> OK, I will correct it .
>
> No need. We can take the first 2 patches of Avihai's series.
>
OK.

Thanks.
Song Gao
> Thanks,
>
> C.


