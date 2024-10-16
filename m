Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161CFD1AD2A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 08:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0zak-0003eH-Is; Wed, 16 Oct 2024 04:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t0zah-0003e7-Gk
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 04:41:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t0zae-0005mM-04
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 04:41:11 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxnmsWfA9nOtEfAA--.46019S3;
 Wed, 16 Oct 2024 16:40:55 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front2 (Coremail) with SMTP id qciowMDxl8UTfA9nkM8vAA--.60459S3;
 Wed, 16 Oct 2024 16:40:53 +0800 (CST)
Subject: Re: [PATCH] linux-headers: loongarch: add kvm_para.h and unistd_64.h
To: maobibo <maobibo@loongson.cn>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20240929072240.251301-1-maobibo@loongson.cn>
 <6d4d65ad-9b35-ea5b-ae3d-0e1234477b66@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <88855d52-6efa-3fff-cded-a58f6b6f8408@loongson.cn>
Date: Wed, 16 Oct 2024 16:41:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6d4d65ad-9b35-ea5b-ae3d-0e1234477b66@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qciowMDxl8UTfA9nkM8vAA--.60459S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF17KFyUGr4kXF15Ww1kCrX_yoW8XF48pr
 ZayFy8Wr9xG3ZYyr42g3W7WrW5JF98G3Z2va40gF92yrWqqw1IqrZ7urn0grWDtayrJa40
 qF4fJw1UuFn7ZrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8czVUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

在 2024/10/16 下午4:13, maobibo 写道:
> ping.
>
> @Song
>
> Could you give some comments since it is LoongArch specific?
>
> Regards
> Bibo Mao
>
> On 2024/9/29 下午3:22, Bibo Mao wrote:
>> KVM LBT supports on LoongArch requires the linux-header kvm_para.h,
>> also unistd_64.h is required by unistd.h on LoongArch since 6.11
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   scripts/update-linux-headers.sh | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
Acked-by: Song Gao <gaosong@loongson.cn>

Could you update the linux-headers togather?

the series[1]  need update kvm.h.

[1]: https://patchew.org/QEMU/20240929070405.235200-1-maobibo@loongson.cn/

Thanks.
Song Gao
>> diff --git a/scripts/update-linux-headers.sh 
>> b/scripts/update-linux-headers.sh
>> index c34ac6454e..3c411f0318 100755
>> --- a/scripts/update-linux-headers.sh
>> +++ b/scripts/update-linux-headers.sh
>> @@ -186,6 +186,10 @@ EOF
>>       if [ $arch = riscv ]; then
>>           cp "$hdrdir/include/asm/ptrace.h" 
>> "$output/linux-headers/asm-riscv/"
>>       fi
>> +    if [ $arch = loongarch ]; then
>> +        cp "$hdrdir/include/asm/kvm_para.h" 
>> "$output/linux-headers/asm-loongarch/"
>> +        cp "$hdrdir/include/asm/unistd_64.h" 
>> "$output/linux-headers/asm-loongarch/"
>> +    fi
>>   done
>>   arch=
>>
>> base-commit: 3b14a767eaca3df5534a162851f04787b363670e
>>


