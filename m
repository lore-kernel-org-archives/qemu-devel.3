Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B81D2F7D7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 01:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1FAD-0000cm-Od; Wed, 16 Oct 2024 21:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t1FAB-0000ca-SO
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 21:18:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t1FA9-0000GF-A6
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 21:18:51 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cx74vnZRBneM4hAA--.48669S3;
 Thu, 17 Oct 2024 09:18:32 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxD9bjZRBnhOctAA--.34474S3;
 Thu, 17 Oct 2024 09:18:29 +0800 (CST)
Subject: Re: [PATCH] linux-headers: loongarch: add kvm_para.h and unistd_64.h
To: gaosong <gaosong@loongson.cn>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20240929072240.251301-1-maobibo@loongson.cn>
 <6d4d65ad-9b35-ea5b-ae3d-0e1234477b66@loongson.cn>
 <88855d52-6efa-3fff-cded-a58f6b6f8408@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <ed1de5ad-7c1f-3276-ec8d-cf409fb0974b@loongson.cn>
Date: Thu, 17 Oct 2024 09:18:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <88855d52-6efa-3fff-cded-a58f6b6f8408@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxD9bjZRBnhOctAA--.34474S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF18Gw1rKryfKF1Uur13WrX_yoW8WFWfp3
 9ayF18G3sxJ3ZYyr12g3W7GrW5tFZ8G3Z2v3W8KF92qrWqqw1IgrZ7urn0grWqqayrJFyj
 qF4fJ34UuFnxZrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.75,
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



On 2024/10/16 下午4:41, gaosong wrote:
> 在 2024/10/16 下午4:13, maobibo 写道:
>> ping.
>>
>> @Song
>>
>> Could you give some comments since it is LoongArch specific?
>>
>> Regards
>> Bibo Mao
>>
>> On 2024/9/29 下午3:22, Bibo Mao wrote:
>>> KVM LBT supports on LoongArch requires the linux-header kvm_para.h,
>>> also unistd_64.h is required by unistd.h on LoongArch since 6.11
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   scripts/update-linux-headers.sh | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
> Acked-by: Song Gao <gaosong@loongson.cn>
> 
> Could you update the linux-headers togather?
Sure, will do in next version.

Regards
Bibo Mao
> 
> the series[1]  need update kvm.h.
> 
> [1]: https://patchew.org/QEMU/20240929070405.235200-1-maobibo@loongson.cn/
> 
> Thanks.
> Song Gao
>>> diff --git a/scripts/update-linux-headers.sh 
>>> b/scripts/update-linux-headers.sh
>>> index c34ac6454e..3c411f0318 100755
>>> --- a/scripts/update-linux-headers.sh
>>> +++ b/scripts/update-linux-headers.sh
>>> @@ -186,6 +186,10 @@ EOF
>>>       if [ $arch = riscv ]; then
>>>           cp "$hdrdir/include/asm/ptrace.h" 
>>> "$output/linux-headers/asm-riscv/"
>>>       fi
>>> +    if [ $arch = loongarch ]; then
>>> +        cp "$hdrdir/include/asm/kvm_para.h" 
>>> "$output/linux-headers/asm-loongarch/"
>>> +        cp "$hdrdir/include/asm/unistd_64.h" 
>>> "$output/linux-headers/asm-loongarch/"
>>> +    fi
>>>   done
>>>   arch=
>>>
>>> base-commit: 3b14a767eaca3df5534a162851f04787b363670e
>>>
> 


