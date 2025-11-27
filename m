Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E9ECFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 09:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOYVC-0006FL-5l; Thu, 27 Nov 2025 04:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vOYVA-0006En-BE
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 04:41:24 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vOYV7-0002J3-9h
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 04:41:23 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxB9G3HChpqLAoAA--.22367S3;
 Thu, 27 Nov 2025 17:41:11 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxQMKxHChpBORAAQ--.36258S3;
 Thu, 27 Nov 2025 17:41:07 +0800 (CST)
Subject: Re: virtio-crypto: Inquiry about virtio crypto
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 QEMU devel <qemu-devel@nongnu.org>
References: <d4258604-e678-f975-0733-71190cf4067d@loongson.cn>
 <027ff08db97d414da0ccc24a439e75d0@huawei.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <8b902563-4cb6-5409-4339-1afecc26803a@loongson.cn>
Date: Thu, 27 Nov 2025 17:38:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <027ff08db97d414da0ccc24a439e75d0@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxQMKxHChpBORAAQ--.36258S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw4fXFWfZrW3ZFW5KrWUWrX_yoW8WFWfpa
 y3KFWFkrZ8Jr1xCa4vqFy5CFW5ZFZ8Cr13WrZrWry3CrZ8AF92vr1avr1vq3srAF1rCF1D
 Xw40qFy0kr98ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
 1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 WxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
 U1NBMJUUUUU==
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


Hi gonglei,

Sorry to bother you again.

I notice that numa node is supported with virtio-crypto device. Is there 
multiple PCIE root bridges with different numa nodes supported on some 
VM models?

I ask this question because I do not know whether it is possible to 
preallocate virtio_crypto_op_data_req buffer and IV buffer within 
structure virtio_crypto_sym_request. Only that there is no node 
information when virtio_crypto_sym_request is allocated.

Regards
Bibo Mao


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


