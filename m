Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07E1C55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrW8u-0003ZL-CY; Wed, 05 Aug 2026 03:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1wrW8s-0003Yv-Qo
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 03:34:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1wrW8q-0003uT-Qg
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 03:34:22 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8Cxqutz53JqSpEKAA--.34346S3;
 Wed, 05 Aug 2026 15:34:12 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJBxngdx53JqnnQkAA--.6541S3;
 Wed, 05 Aug 2026 15:34:11 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Set timer tick value even if disabled
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: qemu-devel@nongnu.org
References: <20260714025517.429426-1-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <c00935db-f33b-5628-fa4c-987f4c4e02f6@loongson.cn>
Date: Wed, 5 Aug 2026 15:33:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260714025517.429426-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxngdx53JqnnQkAA--.6541S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar4xZF1rtw4rKw18Zw48KrX_yoW5Jr18pw
 4Ikr9rKr1YyrWDuFyrtan8XFn8Xr47W3WI9ayfAF48C3Z8Xwn7W348W3srKFy3ZFyrurWa
 vFWrXa1qgF47C3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtx
 DUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.999,
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

Hi Bibo Mao :
> If constant timer is enabled, its tick value is remained value from
> the next expired time. However if timer is not enabled, its value
> should be CONSTANT_TIMER_TICK_MASK or zero.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/constant_timer.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/target/loongarch/tcg/constant_timer.c b/target/loongarch/tcg/constant_timer.c
> index f56e76d482..b91ad1de69 100644
> --- a/target/loongarch/tcg/constant_timer.c
> +++ b/target/loongarch/tcg/constant_timer.c
> @@ -22,12 +22,18 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu)
>   
>   uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu)
>   {
> +    CPULoongArchState *env = &cpu->env;
> +    CPUSysState *sys = env_sys(env);
>       uint64_t now, expire;
>   
> -    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    expire = timer_expire_time_ns(&cpu->timer);
> +    if ((sys->CSR_TCFG & CONSTANT_TIMER_ENABLE) &&
> +        (sys->CSR_TVAL < sys->CSR_TCFG)) {
> +        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        expire = timer_expire_time_ns(&cpu->timer);
> +        sys->CSR_TVAL = (expire - now) / TIMER_PERIOD;
> +    }
>   
> -    return (expire - now) / TIMER_PERIOD;
> +    return sys->CSR_TVAL;
>   }
>   
>   void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
> @@ -42,8 +48,10 @@ void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
>           now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>           next = now + (value & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
>           timer_mod(&cpu->timer, next);
> +        sys->CSR_TVAL = sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK;
>       } else {
>           timer_del(&cpu->timer);
> +        sys->CSR_TVAL = 0;
>       }
>   }
>   
> @@ -58,8 +66,9 @@ void loongarch_constant_timer_cb(void *opaque)
>           now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>           next = now + (sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
>           timer_mod(&cpu->timer, next);
> +        sys->CSR_TVAL = sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK;
>       } else {
> -        sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
> +        sys->CSR_TVAL = CONSTANT_TIMER_TICK_MASK;
>       }
>   
>       loongarch_cpu_set_irq(opaque, IRQ_TIMER, 1);
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
> base-commit: a759542a2c62f0fd3b65f5a66ad9868201014669


