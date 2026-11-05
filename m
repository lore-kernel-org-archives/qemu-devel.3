Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8015606A32C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrEY-0005Ai-9C; Thu, 05 Nov 2026 01:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1xOrEW-0005AP-Kk
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:46:00 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1xOrEU-000050-Hl
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:46:00 -0500
Received: from loongson.cn (unknown [10.20.42.166])
 by gateway (Coremail) with SMTP id _____8DxytEjJuxq9I4cAA--.16794S3;
 Thu, 05 Nov 2026 14:45:55 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxX88jJuxquoEyAA--.38062S2;
 Thu, 05 Nov 2026 14:45:55 +0800 (CST)
Subject: Re: [PATCH 2/2] target/loongarch: Check CPU msgint feature with
 cpu_has_msgint()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: qemu-devel@nongnu.org
References: <20261029085654.78806-1-maobibo@loongson.cn>
 <20261029085654.78806-3-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <396ae863-8d0a-708d-f84f-127013f33fb1@loongson.cn>
Date: Thu, 5 Nov 2026 14:44:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029085654.78806-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxX88jJuxquoEyAA--.38062S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyUXrW7CF4UCr4UCFW5CFX_yoW8Kryxpr
 W7AFWj9FyUKFZIvanIqas0qryDGr17GF429a98Ary8CF43Jr1rXw1xA34DKF1qk348JrWx
 XF1ruF15ZF4UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU84x
 RDUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.724,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>

> There are two ways to check the CPU msgint feature. One is to call
> cpu_has_msgint(); the other is to check CPULoongArchState::msgint, which
> has type OnOffAuto. A problem arises if msgint is set to ON_OFF_AUTO_AUTO
> in KVM mode: QEMU checks the host feature and sets its actual value in
> cpucfg1, which is read by cpu_has_msgint(). However, the msgint field
> remains ON_OFF_AUTO_AUTO.
>
> Therefore, in KVM mode cpu_has_msgint() is more accurate than checking
> the OnOffAuto-typed msgint field.
>
> A problem occurs when booting a VM with the max CPU type on an LA464 host
> that does not support msgint. cpu_has_msgint() returns false, but the
> msgint field remains ON_OFF_AUTO_AUTO, so the expression
> cpu->msgint != ON_OFF_AUTO_OFF evaluates to true.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt.c    | 4 ++--
>   target/loongarch/cpu.c | 4 +++-
>   2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 9c5371af9d..1aa9e5dbd5 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -910,12 +910,12 @@ static void virt_check_dmsi(MachineState *machine)
>   
>       cpu = LOONGARCH_CPU(first_cpu);
>       if (lvms->dmsi == ON_OFF_AUTO_AUTO) {
> -        if (cpu->msgint != ON_OFF_AUTO_OFF) {
> +        if (cpu_has_msgint(&cpu->env)) {
>               lvms->misc_feature = BIT(IOCSRF_DMSI);
>           }
>       }
>   
> -    if (lvms->dmsi == ON_OFF_AUTO_ON && cpu->msgint == ON_OFF_AUTO_OFF) {
> +    if (lvms->dmsi == ON_OFF_AUTO_ON && !cpu_has_msgint(&cpu->env)) {
>           error_report("Fail to enable dmsi , cpu msgint is off "
>                        "pleass add cpu feature mesgint=on.");
>           exit(EXIT_FAILURE);
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index dd70beca18..1f3022265a 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -232,7 +232,9 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
>   
>   static bool loongarch_get_msgint(Object *obj, Error **errp)
>   {
> -    return LOONGARCH_CPU(obj)->msgint != ON_OFF_AUTO_OFF;
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +
> +    return cpu_has_msgint(&cpu->env);
>   }
>   
>   static void loongarch_set_msgint(Object *obj, bool value, Error **errp)


