Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8303CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 08:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPFgN-0004ah-UC; Tue, 19 May 2026 04:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wPFgJ-0004ZB-7E
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:20:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wPFgG-0004rb-8B
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:20:02 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxhuknHQxquCcLAA--.33052S3;
 Tue, 19 May 2026 16:19:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxSeAiHQxq3y6IAA--.61858S3;
 Tue, 19 May 2026 16:19:48 +0800 (CST)
Subject: Re: [PATCH 0/4] target/loongarch: add LVZ support for TCG
To: qemu-devel@nongnu.org
References: <cover.1779171125.git.prcups@krgm.moe>
 <CE549524-76AA-4ACD-BA9A-89A288FECD27@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <088d6c07-9aa8-5863-e0df-aa4f569d9f66@loongson.cn>
Date: Tue, 19 May 2026 16:16:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CE549524-76AA-4ACD-BA9A-89A288FECD27@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxSeAiHQxq3y6IAA--.61858S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw1kAF1fZryfGr13ZF15KFX_yoW5uF48pF
 4xur13KFW0krZ7Jrn7Xa45Xas8Zr1xGw42van3t348Cw4Yqry0vF18t3929F1UAa4UGF1j
 qF1rCF1jvFW2qacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUJVWUXw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqW
 UUUUU
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



On 2026/5/19 下午4:09, SignKirigami wrote:
> Please disregard my previous patch series[1][2][3][4][5][6]. This was my 
> first time using git send-email and my provider messed up the threads 
> (the cover letter also accidentally reused a previous Message-ID, 
> causing it to be grouped into the wrong thread[7]).
you can send the patchset to you only in order to test git send-mail 
command, or git send-mail --dry-run.

It is not enough to spit into 4 patches still, I guess it will take 
several months to merge this huge patch. Just be patient and not be such 
a hurry :), otherwise there will be lost of problems, code cleanup or 
bugfix.

Regards
Bibo Mao
> 
> I sincerely apologize for the noise and confusion.
> 
> ....
> 
> [1]: 
> https://lore.kernel.org/qemu-devel/734d561d-4a8c-4235-b55d-1387020f8a62@mtasv.net/T/#t
> [2]: 
> https://lore.kernel.org/qemu-devel/ff838e8c-8f44-446d-915d-cfb2ce869a5c@mtasv.net/T/#u
> [3]: 
> https://lore.kernel.org/qemu-devel/ac715039-55b0-400d-bd78-32ff7ec889c8@mtasv.net/T/#t
> [4]: 
> https://lore.kernel.org/qemu-devel/75d2c4d9-aa2e-4660-9a47-1cf0f8a23f7b@mtasv.net/T/#u
> [5]: 
> https://lore.kernel.org/qemu-devel/28e575ca-c2bc-4ff5-b686-0459f743ec65@mtasv.net/T/#u
> [6]: 
> https://lore.kernel.org/qemu-devel/f9750959-4b07-45b5-a834-89c4f825184b@mtasv.net/T/#t
> [7]: 
> https://lore.kernel.org/qemu-devel/cover.1779171125.git.prcups@krgm.moe/T/#t
> 
> 
> 于 2026年5月19日 GMT+08:00 14:30:39，SignKirigami <prcups@krgm.moe> 写道：
> 
>     This patch implements Loongson VirtualiZation (LVZ) extension
>     support for LoongArch's TCG target. With this patch, it is now
>     possible to start a nested KVM-accelerated virtual machine on a
>     TCG-emulated virtual machine.
> 
>     Cc: Bibo Mao <maobibo@loongson.cn>
>     Cc: xianglai li <lixianglai@loongson.cn>
>     Signed-off-by: SignKirigami <prcups@krgm.moe>
>     Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> 
>     SignKirigami (4):
>     target/loongarch: add LVZ CPU state and CSR metadata
>     target/loongarch: add LVZ guest runtime support
>     target/loongarch: translate LVZ CSR and trap instructions
>     target/loongarch: virtualize guest TLB and address translation
> 
>     target/loongarch/cpu-csr.h | 42 ++
>     target/loongarch/cpu-mmu.h | 37 +-
>     target/loongarch/cpu.c | 132 ++++
>     target/loongarch/cpu.h | 125 +++-
>     target/loongarch/cpu_helper.c | 119 ++--
>     target/loongarch/csr.c | 122 ++++
>     target/loongarch/csr.h | 3 +
>     target/loongarch/disas.c | 10 +
>     target/loongarch/insns.decode | 17 +
>     target/loongarch/internals.h | 8 +-
>     target/loongarch/kvm/kvm.c | 1 +
>     target/loongarch/machine.c | 249 ++++---
>     target/loongarch/tcg/constant_timer.c | 62 +-
>     target/loongarch/tcg/csr_helper.c | 127 +++-
>     target/loongarch/tcg/helper.h | 30 +-
>     .../tcg/insn_trans/trans_privileged.c.inc | 353 +++++++++-
>     target/loongarch/tcg/op_helper.c | 83 ++-
>     target/loongarch/tcg/tcg_cpu.c | 182 +++--
>     target/loongarch/tcg/tcg_loongarch.h | 6 +-
>     target/loongarch/tcg/tlb_helper.c | 629 +++++++++++++-----
>     target/loongarch/tcg/translate.c | 6 +-
>     target/loongarch/translate.h | 2 +
>     22 files changed, 1909 insertions(+), 436 deletions(-)
> 


