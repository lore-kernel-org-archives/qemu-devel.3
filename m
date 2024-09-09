Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8CDCD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 01:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snTTv-0001hV-Qu; Sun, 08 Sep 2024 21:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1snTTt-0001gu-R5
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 21:46:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1snTTq-0007OJ-QI
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 21:46:17 -0400
Received: from loongson.cn (unknown [10.20.42.17])
 by gateway (Coremail) with SMTP id _____8DxF+lkU95mZl4CAA--.4414S3;
 Mon, 09 Sep 2024 09:46:12 +0800 (CST)
Received: from [10.20.42.17] (unknown [10.20.42.17])
 by front1 (Coremail) with SMTP id qMiowMCxLeRhU95mNQQCAA--.12265S3;
 Mon, 09 Sep 2024 09:46:11 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Add compatible support about VM reboot
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240827035807.3326293-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <99140ee4-0369-e0f0-e9b4-14225512b0f7@loongson.cn>
Date: Mon, 9 Sep 2024 09:46:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240827035807.3326293-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxLeRhU95mNQQCAA--.12265S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrWrtw4ftrykuw1UCr17Jwc_yoW8Ww1rpw
 nYkFWUArWrJrZrAa13Aa4Ygr9rXF1xtr4I9a9xGFyrC390qw48XF40gr98KFy7A34rAr40
 vF12vrWY9F48AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8CztU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.046, SPF_HELO_NONE=0.001,
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



ÔÚ 2024/8/27 ÉÏÎç11:58, Bibo Mao Ð´µÀ:
> With edk2-stable202408 LoongArch UEFI bios, CSR PGD register is set only
> if its value is equal to zero for boot cpu, it causes reboot issue. Since
> CSR PGD register is changed with linux kernel, UEFI BIOS cannot use it.
> 
> Add workaround to clear CSR registers relative with TLB in function
> loongarch_cpu_reset_hold(), so that VM can reboot with edk2-stable202408
> UEFI bios.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 

Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks
Song Gao
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 5e85b9dbef..2f4d635d03 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -549,6 +549,20 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>       env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
>       env->CSR_MERRCTL = FIELD_DP64(env->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
>       env->CSR_TID = cs->cpu_index;
> +    /*
> +     * Workaround for edk2-stable202408, CSR PGD register is set only if
> +     * its value is equal to zero for boot cpu, it causes reboot issue.
> +     *
> +     * Here clear CSR registers relative with TLB.
> +     */
> +    env->CSR_PGDH = 0;
> +    env->CSR_PGDL = 0;
> +    env->CSR_PWCL = 0;
> +    env->CSR_PWCH = 0;
> +    env->CSR_STLBPS = 0;
> +    env->CSR_EENTRY = 0;
> +    env->CSR_TLBRENTRY = 0;
> +    env->CSR_MERRENTRY = 0;
>   
>       for (n = 0; n < 4; n++) {
>           env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV0, 0);
> 
> base-commit: f259e4cb8a8b4ef5463326fc214a7d8d7703d5de
> 


