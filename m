Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABCAC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 01:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weNcL-0004tW-W4; Mon, 29 Jun 2026 21:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1weNcI-0004tN-BZ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 21:50:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1weNcF-00083R-St
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 21:50:26 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxnOnVIENqC3UZAA--.62794S3;
 Tue, 30 Jun 2026 09:50:13 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCx98DRIENqdHK4AA--.8117S3;
 Tue, 30 Jun 2026 09:50:12 +0800 (CST)
Subject: Re: [PATCH v2 0/4] target/loongarch/kvm: cpucfg and device attr fixes
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>,
 xianglai li <lixianglai@loongson.cn>
References: <20260626052742.810726-1-cui.tao@linux.dev>
From: gaosong <gaosong@loongson.cn>
Message-ID: <a7206ddb-c1dd-2ec9-fd74-ac577f88d07a@loongson.cn>
Date: Tue, 30 Jun 2026 09:52:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260626052742.810726-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCx98DRIENqdHK4AA--.8117S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFW7uF4UKw18ur4DuFW7trc_yoW8ZF4fpr
 9xCwn0grWkKrZFg3Waqas5WF909r1xGr43X34ft34fCr13Ar17JFyv9395WFZ8C34kWa48
 tF4093s8uFyUJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.97, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2026/6/26 ÏÂÎç1:27, Tao Cui Ð´µÀ:
> From: Tao Cui <cuitao@kylinos.cn>
>
> A few small robustness fixes around cpucfg register sync and kvm device
> attribute handling in the LoongArch KVM target.
>
>    1/4: kvm_check_cpucfg2() discarded the return value of
>         KVM_GET_DEVICE_ATTR and used an uninitialized val to mask
>         cpucfg[2]; check the return value, warn and skip the mask on a GET
>         failure (best-effort negotiation), and initialize val.
>
>    2/4: kvm_get_stealtime(), kvm_set_stealtime() and kvm_set_pv_features()
>         pass a struct kvm_device_attr by value to the variadic
>         kvm_vcpu_ioctl(), which expects a pointer. Pass &attr.
>
>    3/4: drop the redundant trace_kvm_failed_get/put_cpucfg() calls and
>         their now-unused trace events; kvm_get/set_one_reg() already trace
>         on failure.
>
>    4/4: kvm_loongarch_get/put_cpucfg() overwrite ret on each iteration, so
>         only the last register's result is returned and earlier failures
>         are lost; on a failed read, get_cpucfg() also stores a stale val.
>         Accumulate errors with ret |= and only store on a successful read.
>
> Compiled and boot-tested on a loongarch64 KVM host.
>
> Tao Cui (4):
>    target/loongarch/kvm: fix uninitialized val and unchecked GET in
>      cpucfg2 check
>    target/loongarch/kvm: pass device attr by reference to kvm_vcpu_ioctl
>    target/loongarch/kvm: remove redundant cpucfg failure traces
>    target/loongarch/kvm: fix cpucfg sync error handling
>
>   target/loongarch/kvm/kvm.c    | 46 ++++++++++++++++++++---------------
>   target/loongarch/trace-events |  2 --
>   2 files changed, 26 insertions(+), 22 deletions(-)
>
> ---
Applied to loongarch-next.

Thanks.
Song Gao
> Changes in v2:
>    - 1/4: on KVM_GET_DEVICE_ATTR failure, warn and skip the cpucfg2 mask
>      instead of failing the register sync; the &= mask is best-effort, and a
>      GET failure after a successful HAS is most likely a copy_{from,to}_user
>      issue. Switched the report from error_report() to warn_report().
>


