Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9EEC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 09:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtiWA-0000Dm-RG; Tue, 11 Aug 2026 05:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wtiW9-0000D2-0V
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 05:11:29 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wtiW5-00040D-M1
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 05:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:To:From:Message-ID:Date:MIME-Version:
 Content-Type; bh=NDCoKzNPLkyCH8elTvs20cnH0ST8ZEx8g0oWbKKAaKU=;
 b=iKidxrG8sQj3J6N4YLy2Hy84RXWdRSvmcI0M0olz1aJRmMzjppAF+yAbrD9hGf
 Le5MBVfS55bbdyQ2VskmUT2J72q+zJ3b4wQ7G7pGnCnQ/Q8zQi0P68vLGU+7bTX8
 czgOew13PBqDM+f2VKgs/2txnazuZpXXl6RAKEutEIm+4=
Received: from [10.2.10.30] (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wDXH_Eo53pqS7hUOQ--.24690S2; 
 Tue, 11 Aug 2026 17:11:05 +0800 (CST)
Subject: Re: [PATCH] hw/intc/loongarch_dintc: Add
 loongarch_dintc_cpu_by_arch_id() function
To: Bibo Mao <maobibo@loongson.cn>
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260811084331.23526-1-maobibo@loongson.cn>
From: Song Gao <17746591750@163.com>
Message-ID: <27b9d9e3-b762-9472-984e-a14b1abba13c@163.com>
Date: Tue, 11 Aug 2026 17:11:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260811084331.23526-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _____wDXH_Eo53pqS7hUOQ--.24690S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWDXr43Zw1DJFyDGFy5CFg_yoW5ZrWfpF
 Wxurn0gr1UA39rXa9xXa4rZF4fCrn3u3W2q3WakF92yF4kAr15Xr48GrWUZF92ka4jgr4j
 vw1xG3WUuF17JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRbdb8UUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprxlkywvzilivq6il2tof0z/xtbC8gk9Rmp65ymixQAA35
Received-SPF: pass client-ip=117.135.210.5; envelope-from=17746591750@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, NICE_REPLY_A=-1.998, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


在 2026/8/11 下午4:43, Bibo Mao 写道:
> Similar with IPI, add function loongarch_dintc_cpu_by_arch_id() for
> dintc driver. It searches dintc device from physical CPUID, also it
> used binary search method, rather than one by one with common API
> cpu_by_arch_id().
>
> And use this newly added API in loongarch_dintc_get_cpu() and
> loongarch_dintc_mem_write().
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_dintc.c | 49 +++++++++++++++++++++++----------------
>   1 file changed, 29 insertions(+), 20 deletions(-)
  Reviewed-by:  Song Gao <17746591750@163.com>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
> index e40292887c..68c1cfce43 100644
> --- a/hw/intc/loongarch_dintc.c
> +++ b/hw/intc/loongarch_dintc.c
> @@ -26,6 +26,25 @@ FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
>   FIELD(MSG_ADDR, CPU_NUM, 12, 8)
>   FIELD(MSG_ADDR, FIX, 28, 12)
>   
> +static int loongarch_dintc_cmp(const void *a, const void *b)
> +{
> +    DINTCCore *dintc_a = (DINTCCore *)a;
> +    DINTCCore *dintc_b = (DINTCCore *)b;
> +
> +    return dintc_a->arch_id - dintc_b->arch_id;
> +}
> +
> +static DINTCCore *loongarch_dintc_cpu_by_arch_id(LoongArchDINTCState *s,
> +                                                 int64_t arch_id)
> +{
> +    DINTCCore dintc, *found;
> +
> +    dintc.arch_id = arch_id;
> +    found = bsearch(&dintc, s->cpu, s->num_cpu, sizeof(DINTCCore),
> +                    loongarch_dintc_cmp);
> +    return found;
> +}
> +
>   static uint64_t loongarch_dintc_mem_read(void *opaque,
>                                           hwaddr addr, unsigned size)
>   {
> @@ -49,23 +68,20 @@ static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
>   {
>       int irq_num, cpu_num = 0;
>       LoongArchDINTCState *s = LOONGARCH_DINTC(opaque);
> -    uint64_t msg_addr = addr + VIRT_DINTC_BASE;
> +    uint64_t msg_addr = addr + VIRT_DINTC_BASE, arch_id;
> +    DINTCCore *core;
>       CPUState *cs;
>   
> -    cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
> -
> -    /* Validate cpu_num against the configured number of CPUs */
> -    if (cpu_num >= s->num_cpu) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "loongarch-dintc: invalid cpu number%d\n", cpu_num);
> -        return;
> -    }
> -    cs = cpu_by_arch_id(cpu_num);
> -    if (!cs) {
> +    arch_id = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
> +    core = loongarch_dintc_cpu_by_arch_id(s, arch_id);
> +    if (!core || !core->cpu) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> -                      "loongarch-dintc: no CPU for arch_id %d\n", cpu_num);
> +                      "loongarch-dintc: no CPU for arch_id %"PRId64"\n",
> +                      arch_id);
>           return;
>       }
> +    cpu_num = core - s->cpu;
> +    cs = core->cpu;
>       irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
>   
>       async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
> @@ -135,15 +151,8 @@ static DINTCCore *loongarch_dintc_get_cpu(LoongArchDINTCState *s,
>   {
>       CPUClass *k = CPU_GET_CLASS(dev);
>       uint64_t arch_id = k->get_arch_id(CPU(dev));
> -    int i;
> -
> -    for (i = 0; i < s->num_cpu; i++) {
> -        if (s->cpu[i].arch_id == arch_id) {
> -            return &s->cpu[i];
> -        }
> -    }
>   
> -    return NULL;
> +    return loongarch_dintc_cpu_by_arch_id(s, arch_id);
>   }
>   
>   static void loongarch_dintc_cpu_plug(HotplugHandler *hotplug_dev,
>
> base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22


