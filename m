Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F06C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjAgt-0007Mr-PO; Mon, 13 Jul 2026 03:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wjAgh-0007MB-Gl
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:02:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wjAge-0005Wy-0y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:02:47 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxuvCEjVRqJvMCAA--.11927S3;
 Mon, 13 Jul 2026 15:02:28 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxb8eBjVRqALMLAA--.55056S2;
 Mon, 13 Jul 2026 15:02:27 +0800 (CST)
Subject: Re: [PATCH v3 5/8] target/loongarch: Dump host CSRs with LVZ state
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1783673526.git.prcups@krgm.moe>
 <647e3a352d4b0fc41e983d674ab599898275cd07.1783673526.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <f2289e1b-6692-9a78-9f65-f92351976797@loongson.cn>
Date: Mon, 13 Jul 2026 15:02:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <647e3a352d4b0fc41e983d674ab599898275cd07.1783673526.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxb8eBjVRqALMLAA--.55056S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urykGF1xGw43XFy8WryDArc_yoW8Cw1fpr
 W8u3yj9F1xGrZ2ya92qan8XFyDXF1xG3429ayFkryIyr45Xry3uF1kK34aqF4kJ34agw1r
 Xan3uF1UZa10vacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5
 r7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.494,
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



On 2026/7/10 下午5:00, SignKirigami wrote:
> Update LoongArch ELF note generation to read ERA and BADV from the host
> CSR bank directly, avoiding dependence on the currently selected system
> state once LVZ adds a separate guest CSR bank.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/arch_dump.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
> index 9d84faef96..13472188ae 100644
> --- a/target/loongarch/arch_dump.c
> +++ b/target/loongarch/arch_dump.c
> @@ -116,7 +116,7 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>   {
>       struct loongarch_note note;
>       CPULoongArchState *env = &LOONGARCH_CPU(cs)->env;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
It will be better if there is wrapped function such as get_sys_state(),
static inline CPUSysState get_sys_state(CPULoongArchState *env, int vm)
{
     return &env->sys_states[vm];
}

     CPUSysState *sys = get_sys_state(env, LOONGARCH_VM_LEVEL_HOST);

Regards
Bibo Mao

>       int ret, i;
>   
>       loongarch_note_init(&note, s, "CORE", 5, NT_PRSTATUS,
> @@ -127,8 +127,8 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>       for (i = 0; i < 32; ++i) {
>           note.prstatus.pr_reg.gpr[i] = cpu_to_dump64(s, env->gpr[i]);
>       }
> -    note.prstatus.pr_reg.csr_era  = cpu_to_dump64(s, sys->CSR_ERA);
> -    note.prstatus.pr_reg.csr_badv = cpu_to_dump64(s, sys->CSR_BADV);
> +    note.prstatus.pr_reg.csr_era  = cpu_to_dump64(s, host->CSR_ERA);
> +    note.prstatus.pr_reg.csr_badv = cpu_to_dump64(s, host->CSR_BADV);
>       ret = f(&note, LOONGARCH_PRSTATUS_NOTE_SIZE, s);
>       if (ret < 0) {
>           return -1;
> 


