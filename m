Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24279C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 02:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wheFm-0003nj-5Z; Wed, 08 Jul 2026 22:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wheFj-0003nI-AA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:12:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wheFg-0002WO-EO
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:12:39 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx1+qHA09qa7ABAA--.7139S3;
 Thu, 09 Jul 2026 10:12:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxb8eGA09qRFwGAA--.11153S2;
 Thu, 09 Jul 2026 10:12:22 +0800 (CST)
Subject: Re: [PATCH v2 0/4] target/loongarch: add LVZ support for TCG
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1782194683.git.prcups@krgm.moe>
 <FlLMXq5RQ6axxIAn2ivsvQ@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <964c2e79-6225-44c8-a77d-1ff8efff8131@loongson.cn>
Date: Thu, 9 Jul 2026 10:12:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <FlLMXq5RQ6axxIAn2ivsvQ@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxb8eGA09qRFwGAA--.11153S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CryUGr4UWw1rXw4kZry3Jrc_yoW8tw1rpw
 1xur1rKay8CrZFyrn3Xa4Yqwn8Xrn7Gw4Iq3Wftry8Cw4Yqry7ZF1kt3929F1UJa4UGryI
 qF1Fk34UuF48ZacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xuctUU
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



On 2026/7/7 下午12:40, SignKirigami wrote:
> On 2026年6月23日星期二 中国标准时间 14:16:11，SignKirigami wrote：
>> This patch implements Loongson VirtualiZation (LVZ) extension support for LoongArch's TCG target. With this patch, it is now possible to start a nested KVM-accelerated virtual machine on a TCG-emulated virtual machine.
>>
>> Signed-off-by: SignKirigami <prcups@krgm.moe>
>> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
>>
>> SignKirigami (4):
>>    target/loongarch: Add LVZ feature definitions and CPU structures
>>    target/loongarch: Add guest CSR table and VM-level CSR infrastructure
>>    target/loongarch: Add LVZ MMU, TCG infrastructure and guest support
>>    target/loongarch: Add LVZ instruction decode, translation and
>>      disassembly
>>
>>   target/loongarch/arch_dump.c                  |   6 +-
>>   target/loongarch/cpu-csr.h                    |  42 ++
>>   target/loongarch/cpu-mmu.h                    |  39 +-
>>   target/loongarch/cpu.c                        | 279 ++++++---
>>   target/loongarch/cpu.h                        |  62 +-
>>   target/loongarch/cpu_helper.c                 |  87 ++-
>>   target/loongarch/csr.c                        | 124 +++-
>>   target/loongarch/csr.h                        |  12 +-
>>   target/loongarch/disas.c                      |  16 +
>>   target/loongarch/insns.decode                 |  14 +
>>   target/loongarch/internals.h                  |   8 +-
>>   target/loongarch/machine.c                    | 125 +++-
>>   target/loongarch/tcg/constant_timer.c         |  74 ++-
>>   target/loongarch/tcg/csr_helper.c             | 136 ++++-
>>   target/loongarch/tcg/helper.h                 |  30 +-
>>   .../tcg/insn_trans/trans_extra.c.inc          |   2 +-
>>   .../tcg/insn_trans/trans_privileged.c.inc     | 353 ++++++++++-
>>   target/loongarch/tcg/op_helper.c              |  45 +-
>>   target/loongarch/tcg/tcg_cpu.c                |  65 +-
>>   target/loongarch/tcg/tcg_loongarch.h          |   3 +-
>>   target/loongarch/tcg/tlb_helper.c             | 577 +++++++++++++-----
>>   target/loongarch/tcg/translate.c              |   6 +-
>>   target/loongarch/translate.h                  |   2 +
>>   23 files changed, 1747 insertions(+), 360 deletions(-)
>>
>>
> I 'm sorry for not wrapping this cover message, and will fix it on next version.
> Is there any progress on this patch serie?
I suggest that split this patch into smaller patches, so that almost 
every patch is easy to review. It is really hard to review carefully 
with big patch :(

Regards
Bibo Mao
> 
> Regards
> SignKirigami
> 
> 
> 


