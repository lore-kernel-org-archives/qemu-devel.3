Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F36CCD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 10:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ0UK-0004oH-NL; Thu, 21 May 2026 06:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wQ0UH-0004mz-Nf
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:18:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wQ0UF-0007uu-76
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:18:45 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxT+r32w5qWvULAA--.34371S3;
 Thu, 21 May 2026 18:18:32 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxD8P02w5q2uqKAA--.1385S3;
 Thu, 21 May 2026 18:18:31 +0800 (CST)
Subject: Re: [PATCH 0/4] target/loongarch: add LVZ support for TCG
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1779171125.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <63c13a79-39fa-4f0c-a69b-80845ebdb8af@loongson.cn>
Date: Thu, 21 May 2026 18:15:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1779171125.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxD8P02w5q2uqKAA--.1385S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF43uFyxurWDKw1DGFy3GFX_yoW8ZF1kpr
 yxur15Kay8KrZ7Arn3X34Yqw1DXr1xGw42va1ft348Cw4aqry8ZF1kt3929F1UJa48WryI
 qF1Fkr1UuF47X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
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



On 2026/5/19 下午2:30, SignKirigami wrote:
> This patch implements Loongson VirtualiZation (LVZ) extension support for LoongArch's TCG target. With this patch, it is now possible to start a nested KVM-accelerated virtual machine on a TCG-emulated virtual machine.

Hi SignKirigami,

I suggest minimal support with LVZ at beginning, such as no PTW, no 
machine state save/restore etc. Just CPU virtualization and simple 
memory virtualization is enough.

Regards
Bibo Mao
> 
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: xianglai li <lixianglai@loongson.cn>
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> 
> SignKirigami (4):
>    target/loongarch: add LVZ CPU state and CSR metadata
>    target/loongarch: add LVZ guest runtime support
>    target/loongarch: translate LVZ CSR and trap instructions
>    target/loongarch: virtualize guest TLB and address translation
> 
>   target/loongarch/cpu-csr.h                    |  42 ++
>   target/loongarch/cpu-mmu.h                    |  37 +-
>   target/loongarch/cpu.c                        | 132 ++++
>   target/loongarch/cpu.h                        | 125 +++-
>   target/loongarch/cpu_helper.c                 | 119 ++--
>   target/loongarch/csr.c                        | 122 ++++
>   target/loongarch/csr.h                        |   3 +
>   target/loongarch/disas.c                      |  10 +
>   target/loongarch/insns.decode                 |  17 +
>   target/loongarch/internals.h                  |   8 +-
>   target/loongarch/kvm/kvm.c                    |   1 +
>   target/loongarch/machine.c                    | 249 ++++---
>   target/loongarch/tcg/constant_timer.c         |  62 +-
>   target/loongarch/tcg/csr_helper.c             | 127 +++-
>   target/loongarch/tcg/helper.h                 |  30 +-
>   .../tcg/insn_trans/trans_privileged.c.inc     | 353 +++++++++-
>   target/loongarch/tcg/op_helper.c              |  83 ++-
>   target/loongarch/tcg/tcg_cpu.c                | 182 +++--
>   target/loongarch/tcg/tcg_loongarch.h          |   6 +-
>   target/loongarch/tcg/tlb_helper.c             | 629 +++++++++++++-----
>   target/loongarch/tcg/translate.c              |   6 +-
>   target/loongarch/translate.h                  |   2 +
>   22 files changed, 1909 insertions(+), 436 deletions(-)
> 


