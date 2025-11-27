Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881D0D116F2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 03:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOSQe-0006AX-7J; Wed, 26 Nov 2025 22:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vOSQc-0006AM-6M
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 22:12:18 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vOSQZ-0001rY-70
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 22:12:17 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxmdGGwSdpzpcoAA--.22149S3;
 Thu, 27 Nov 2025 11:12:06 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxaMCBwSdpGJ9AAQ--.19477S3;
 Thu, 27 Nov 2025 11:12:04 +0800 (CST)
Subject: Re: virtio-crypto: Inquiry about virtio crypto
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 QEMU devel <qemu-devel@nongnu.org>
References: <d4258604-e678-f975-0733-71190cf4067d@loongson.cn>
 <027ff08db97d414da0ccc24a439e75d0@huawei.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <42d33127-59dc-5f82-8fa8-6b154cde6dc6@loongson.cn>
Date: Thu, 27 Nov 2025 11:09:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <027ff08db97d414da0ccc24a439e75d0@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxaMCBwSdpGJ9AAQ--.19477S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr1xCr1fuw4xGr4DAF4fWFX_yoW8Gr1xpF
 93GFWFkayDGr1fCa4ktFy3CFW5Xa98CF13GrZrX348Gr98Cry8Kr12vr1jq3sxJF1rKF1q
 qw4IgF10kr98ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5
 r7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.604,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/11/27 上午10:56, Gonglei (Arei) wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Bibo Mao <maobibo@loongson.cn>
>> Sent: Thursday, November 27, 2025 9:43 AM
>> To: Gonglei (Arei) <arei.gonglei@huawei.com>
>> Cc: linux-crypto@vger.kernel.org; virtualization@lists.linux.dev; linux-kernel
>> <linux-kernel@vger.kernel.org>; QEMU devel <qemu-devel@nongnu.org>
>> Subject: virtio-crypto: Inquiry about virtio crypto
>>
>> Hi gonglei,
>>
>>      I am investigating how to use HW crypto accelerator in VM. It seems that
>> virtio-crypto is one option, however only aes skcipher algo is supported and
> 
> Actually akcipher service had been supported by virtio-crypto in 2022.
I am studying virtio-crypto and want to add sm4 algo with skcipher on 
it. Hope to get some guidances and work together on it in future :)

Regards
Bibo Mao
> 
>> virtio-crypto device is not suggested by RHEL 10.
>>
>> https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html
>> /configuring_and_managing_linux_virtual_machines/feature-support-and-limit
>> ations-in-rhel-10-virtualization
>>
>>     I want to know what is the potential issued with virtio-crypto.
>>
> 
> This question is too big, maybe you'd better ask RHEL guys. :(
> 
> Regards,
> -Gonglei
> 
>> Regards
>> Bibo Mao
> 
> 


