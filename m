Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A07CCD18D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 12:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8eL5-00020r-BX; Tue, 14 Oct 2025 08:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v8eL2-0001zo-3l; Tue, 14 Oct 2025 08:41:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1v8eKp-0002qV-CQ; Tue, 14 Oct 2025 08:41:11 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axjr_KRO5owAIWAA--.45451S3;
 Tue, 14 Oct 2025 20:40:42 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxzsHFRO5odZjhAA--.11589S3;
 Tue, 14 Oct 2025 20:40:39 +0800 (CST)
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org>
 <46AA9C03-CA7E-4C4B-AD05-A9053666BA52@gmail.com>
 <20251013070945-mutt-send-email-mst@kernel.org> <aOzm2ukHfkPF-zhT@redhat.com>
 <CAFEAcA9p51aPGhHgUPishEJ9TE60dm83ofKr5Wa-qM_1SqJ67w@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <3689544a-86d9-2df0-32ad-50eb8493c31a@loongson.cn>
Date: Tue, 14 Oct 2025 20:38:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9p51aPGhHgUPishEJ9TE60dm83ofKr5Wa-qM_1SqJ67w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxzsHFRO5odZjhAA--.11589S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFWfXryUtF1xWw45CFWkZrc_yoW8ZFyfpr
 4rua1YkryrJFn3A34qgw1SgF1Yvr9xK3W29Fnagw4rCFykGr45JF4Syw4Fv3WkJws5tw1F
 vrsFy3ZrX3WDZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
 x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
 McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
 I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
 x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
 0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.712,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/10/14 下午8:20, Peter Maydell wrote:
> On Mon, 13 Oct 2025 at 12:47, Daniel P. Berrangé <berrange@redhat.com> wrote:
>> With a very minimal wording tweak our current defined policy could
>> avoid being a blocker for enabling KVM in imx8mp-evk. In
>>
>>    https://www.qemu.org/docs/master/system/security.html
>>
>> where it describes the "virtualization use case", we could simply
>> tweak it to always require a versioned machine type
>>
>> Change
>>
>>    "These use cases rely on hardware virtualization extensions
>>     to execute guest code safely on the physical CPU at close-
>>     to-native speed."
>>
>> To say
>>
>>    "These use cases apply to versioned machine types when used
>>     in combination with hardware virtualization extensions
>>     to execute guest code safely on the physical CPU at close-
>>     to-native speed"
> 
> With the suggested changes listed elsewhere in this
> thread, my current manually curated list of machines is:
> 
> aarch64
>    ``virt``
> i386, x86_64
>    ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``
> s390x
>    ``s390-ccw-virtio``
> loongarch64:
>    ``virt``
> ppc64:
>    ``pseries``
> riscv32, riscv64:
>    ``virt``
> 
> If we say "versioned machine type", that puts these machines
> outside the "supported" boundary:
> 
> i386, x86_64
>    ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``
> loongarch64:
>    ``virt``
> riscv32, riscv64:
>    ``virt``
> 
> I can certainly see the argument for loongarch64
> and maybe even riscv[*] still being "not supported for
> production security-boundary stuff", but do we really
> want to say that the Xen machine types and microvm
> aren't suitable for VM use ?
> 
> [*] Could somebody from riscv or loongarch maintainers
> say whether they think these machines should be on the
> "security supported" list or not yet ?
yes, loongarch virt machine with kvm accel should be security supported. 
Also in next version we consider to add versioned machine type with 
loongarch architecture.

Regards
Bibo Mao
> 
> thanks
> -- PMM
> 


