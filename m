Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E231BC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 00:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJied-0000hv-L8; Mon, 26 May 2025 20:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uJieZ-0000he-Od
 for qemu-devel@nongnu.org; Mon, 26 May 2025 20:58:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uJieX-0003Zz-IC
 for qemu-devel@nongnu.org; Mon, 26 May 2025 20:58:51 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx12k_DjVocp39AA--.15487S3;
 Tue, 27 May 2025 08:58:40 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxHcU8DjVoKQ70AA--.38038S3;
 Tue, 27 May 2025 08:58:38 +0800 (CST)
Subject: Re: [PATCH 06/12] target/loongarch: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, Song Gao <gaosong@loongson.cn>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-7-richard.henderson@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <02f59cef-f1f6-3ea5-2d9b-2860e9aa1b33@loongson.cn>
Date: Tue, 27 May 2025 08:57:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250504205714.3432096-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHcU8DjVoKQ70AA--.38038S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrur48Ww1rtF1fGFW3WFW7trc_yoW8JrW3pr
 y7Z3W5KF4kta9xt3ykJa4Yvrn8Xr17Gry29a1xt3sakrs8XF18XF4kta4qyF4kCay8Ww12
 vF4Fk3W5Xa1UtabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.385,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/5/5 上午4:57, Richard Henderson wrote:
> Check va32 state.
> 
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/cpu.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index f7535d1be7..abad84c054 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -334,6 +334,12 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>       }
>       return false;
>   }
> +
> +static vaddr loongarch_pointer_wrap(CPUState *cs, int mmu_idx,
> +                                    vaddr result, vaddr base)
> +{
> +    return is_va32(cpu_env(cs)) ? (uint32_t)result : result;
> +}
>   #endif
>   
>   static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
> @@ -889,6 +895,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
>   
>   #ifndef CONFIG_USER_ONLY
>       .tlb_fill = loongarch_cpu_tlb_fill,
> +    .pointer_wrap = loongarch_pointer_wrap,
>       .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
>       .cpu_exec_halt = loongarch_cpu_has_work,
>       .cpu_exec_reset = cpu_reset,
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


