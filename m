Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FD7CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 02:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZwQ-0004M2-U9; Wed, 24 Jun 2026 22:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wcZwO-0004LC-Pu
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 22:35:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wcZwM-0008TR-0k
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 22:35:44 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxJenzkzxq06oXAA--.54650S3;
 Thu, 25 Jun 2026 10:35:31 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxysHwkzxqTkqyAA--.8323S3;
 Thu, 25 Jun 2026 10:35:30 +0800 (CST)
Subject: Re: [PATCH 2/4] target/loongarch/kvm: pass device attr by reference
 to kvm_vcpu_ioctl
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
References: <20260625015835.678819-1-cui.tao@linux.dev>
 <20260625015835.678819-3-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <986abdbc-2de6-63e3-35ba-5cd265862bec@loongson.cn>
Date: Thu, 25 Jun 2026 10:32:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260625015835.678819-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxysHwkzxqTkqyAA--.8323S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFW3XF13ur1kCF1xtF13trc_yoW8KFy5pF
 43GF92qFWrJrWDK3Zaq34vga4UZw17Grs7W3y5Jw1fCr4UKr4YyFySkwsruryUA340ga1I
 qr15CFZ8Z3WjqwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
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



On 2026/6/25 上午9:58, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> kvm_vcpu_ioctl() is variadic and reads its argument as a pointer, but
> kvm_get_stealtime(), kvm_set_stealtime() and kvm_set_pv_features() pass
> the local struct kvm_device_attr by value. It currently works because of
> how the calling convention passes large structs; pass &attr so the
> argument is passed as intended.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   target/loongarch/kvm/kvm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index b7176ce53a..fffb2d431a 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -46,12 +46,12 @@ static int kvm_get_stealtime(CPUState *cs)
>           .addr = (uint64_t)&env->stealtime.guest_addr,
>       };
>   
> -    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
> +    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
>       if (err) {
>           return 0;
>       }
>   
> -    err = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, attr);
> +    err = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
>       if (err) {
>           error_report("PVTIME: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
>           return err;
> @@ -70,12 +70,12 @@ static int kvm_set_stealtime(CPUState *cs)
>           .addr = (uint64_t)&env->stealtime.guest_addr,
>       };
>   
> -    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
> +    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
>       if (err) {
>           return 0;
>       }
>   
> -    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
> +    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, &attr);
>       if (err) {
>           error_report("PVTIME: KVM_SET_DEVICE_ATTR %s with gpa "TARGET_FMT_lx,
>                         strerror(errno), env->stealtime.guest_addr);
> @@ -96,13 +96,13 @@ static int kvm_set_pv_features(CPUState *cs)
>           .addr = (uint64_t)&val,
>       };
>   
> -    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
> +    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
>       if (err) {
>           return 0;
>       }
>   
>       val = env->pv_features;
> -    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
> +    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, &attr);
>       if (err) {
>           error_report("Fail to set pv feature "TARGET_FMT_lx " with error %s",
>                         val, strerror(errno));
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


