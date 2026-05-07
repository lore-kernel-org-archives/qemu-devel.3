Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162AACD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKtOI-00059E-PH; Thu, 07 May 2026 03:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wKtOA-00056A-J6
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:43:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wKtO8-0007ib-7n
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:43:18 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cx9OiQQvxppWcHAA--.18170S3;
 Thu, 07 May 2026 15:43:12 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxGOCMQvxpYyR8AA--.39343S3;
 Thu, 07 May 2026 15:43:09 +0800 (CST)
Subject: Re: [PATCH 1/4] update-linux-headers.sh: add typelimits.h to portable
 header list
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
Cc: maobibo@loongson.cn, qemu-devel@nongnu.org, lixianglai@loongson.cn,
 chenhuacai@loongson.cn, pbonzini@redhat.com, cohuck@redhat.com,
 thuth@redhat.com, mst@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org
References: <20260427070029.1059386-1-gaosong@loongson.cn>
 <20260427070029.1059386-2-gaosong@loongson.cn>
 <0a95025f-7234-ae8f-641d-cf605c5742ce@loongson.cn>
 <c36929a0-f6a0-4db8-85fb-733853171893@redhat.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <161dc86d-dcb5-731a-f5d4-2a4cc3321b88@loongson.cn>
Date: Thu, 7 May 2026 15:45:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c36929a0-f6a0-4db8-85fb-733853171893@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxGOCMQvxpYyR8AA--.39343S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF4fXw43tFyxXFykXrW8GrX_yoW8tr4DpF
 4kCFyUCry3A3Z7Jw12qF1Ika4Yqr4rJ3ZFgryUWFy0yFZ0gr1Igr47Zrn09ryDJr48Ca1j
 qr43Ga4Uu3Z7Z3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
 daVFxhVjvjDU0xZFpf9x07UiiSdUUUUU=
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

在 2026/5/7 下午2:58, Cédric Le Goater 写道:
> On 5/7/26 08:23, gaosong wrote:
>> Ping~
>>
>> 在 2026/4/27 下午3:00, Song Gao 写道:
>>> Linux kernel introduced a new UAPI header file typelimits.h in the 7.1
>>> development cycle (commit merged in Jan 2026). This file is required by
>>> ethtool.h and other headers that include it.
>>>
>>> Since QEMU's update script only copies headers explicitly listed in the
>>> for loop, typelimits.h was missing after updating to newer kernel
>>> versions, causing compilation errors like:
>>>
>>>    fatal error: standard-headers/linux/typelimits.h: No such file or 
>>> directory
>>>
>>> Add typelimits.h to the list of headers processed by cp_portable() to
>>> ensure it is properly copied and sanitized into the QEMU source tree
>>>
>>> Cc: clg@redhat.com
>>> Cc: pbonzini@redhat.com
>>> Cc: cohuck@redhat.com
>>> Cc: thuth@redhat.com
>>> Cc: mst@redhat.com
>>> Cc: peter.maydell@linaro.org
>>> Cc: richard.henderson@linaro.org
>>> Cc: philmd@linaro.org
>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>> ---
>>>   scripts/update-linux-headers.sh | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/scripts/update-linux-headers.sh 
>>> b/scripts/update-linux-headers.sh
>>> index 386d7a38e7..471f9cc71e 100755
>>> --- a/scripts/update-linux-headers.sh
>>> +++ b/scripts/update-linux-headers.sh
>>> @@ -255,6 +255,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
>>>            "$hdrdir/include/linux/vhost_types.h" \
>>>            "$hdrdir/include/linux/vmclock-abi.h" \
>>>            "$hdrdir/include/linux/nitro_enclaves.h" \
>>> +         "$hdrdir/include/linux/typelimits.h" \
>>>            "$hdrdir/include/linux/sysinfo.h"; do
>>>       cp_portable "$i" "$output/include/standard-headers/linux"
>>>   done
>>
>
> There is one issue with this patch. The headers should be sanitized.
>
> See :
>
> https://lore.kernel.org/qemu-devel/20260505081423.28326-2-avihaih@nvidia.com 
>
>
OK, I will correct it .

Thanks.
Song Gao
>
> Thanks,
>
> C.


