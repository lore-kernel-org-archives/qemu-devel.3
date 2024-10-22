Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CFFD2C546
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3E8q-00030a-0l; Tue, 22 Oct 2024 08:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t3E8b-0002yn-Qn
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:37:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t3E8X-0001G7-OM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:37:23 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxGeB+nBdnJTMFAA--.12545S3;
 Tue, 22 Oct 2024 20:37:18 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMDx2OJ+nBdnt88HAA--.46405S3;
 Tue, 22 Oct 2024 20:37:18 +0800 (CST)
Subject: Re: [PATCH v5 0/2] target/loongarch: Add loongson binary translation
 feature
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, qemu-devel@nongnu.org
References: <20240929070405.235200-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <88b6f12f-96fe-7794-040a-3525988de286@loongson.cn>
Date: Tue, 22 Oct 2024 20:38:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240929070405.235200-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMDx2OJ+nBdnt88HAA--.46405S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr4UuFy5tr1DurWrZr4UJrc_yoW8Zr48pa
 y7AF1FyFWkJrZ7Aa1fZrW5Wr4Sqr4xGrW2q3W3A34rGF4Yk3s2vr40yasaqFyDJ34xWryI
 ga1qkw1UuFn0ywbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTm
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.475, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

ÔÚ 2024/9/29 ÏÂÎç3:04, Bibo Mao Ð´µÀ:
> Loongson Binary Translation (LBT) is used to accelerate binary
> translation. LBT feature is added in kvm mode, not supported in TCG
> mode since it is not emulated.
>
> Here lbt=on/off property is added to parse command line to
> enable/disable lbt feature. Also fix registers relative lbt are saved
> and restored during migration.
>
> ---
> v4 ... v5:
>    1. Define structure element eflags in structure LoongArchBT as
>       uint32_t; in kernel eflags is defined as u64, however with
>       ptrace and gdb interface it is defined u32, here defined as
>       uint32_t to keep consistent from user view.
>    2. sync patch with latest qemu version.
>
> v3 ... v4:
>    1. Verify and enable LBT feature in function kvm_arch_init_vcpu()
>       rather than loongarch_cpu_post_init(), since LBT feature is only
>       effective in kvm mode and function kvm_feature_supported() can be
>       defined as static.
>    2. Define structure element ftop in structure LoongArchBT as uint32_t
>       to keep consist with kernel and real HW.
>
> v2 ... v3:
>    1. Property lbt is added only if kvm is enabled
>    2. Use feature variable lbt with OnOffAuto type, rather than feature
>       bitmap flags default_features and forced_features
>
> v1 ... v2:
>    1. Add LBT register saving and restoring in vmstate
>    2. Add two pseudo feature flags: default_features and forced_features
> ---
> Bibo Mao (2):
>    target/loongarch: Add loongson binary translation feature
>    target/loongarch: Implement lbt registers save/restore function
>
>   target/loongarch/cpu.c                |  24 ++++++
>   target/loongarch/cpu.h                |  18 ++++
>   target/loongarch/kvm/kvm.c            | 119 +++++++++++++++++++++++++-
>   target/loongarch/loongarch-qmp-cmds.c |   2 +-
>   target/loongarch/machine.c            |  24 ++++++
>   5 files changed, 185 insertions(+), 2 deletions(-)
>
>
> base-commit: 3b14a767eaca3df5534a162851f04787b363670e
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


