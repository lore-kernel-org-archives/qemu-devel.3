Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17338C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6k5v-00020D-63; Wed, 16 Sep 2026 03:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1x6k5l-0001vs-AH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:30:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1x6k5h-00030h-Ih
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:30:05 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8AxS_B3RapqlIcMAA--.36631S3;
 Wed, 16 Sep 2026 15:29:59 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJCx9cx2Rapqa1UhAA--.44014S2;
 Wed, 16 Sep 2026 15:29:59 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Remove CSR registers relative MERR
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: qemu-devel@nongnu.org
References: <20260902020102.2345093-1-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <e2601cf0-c5f9-d831-fe4f-bcec111a4970@loongson.cn>
Date: Wed, 16 Sep 2026 15:28:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260902020102.2345093-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCx9cx2Rapqa1UhAA--.44014S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww4kXr15tr15GFWUtryktFc_yoW5JF48pr
 ZrurWDKF48XrWDu3WfXas0934DXr17G3y2qa1Syry0yrZxJ34qgF48K34kWFyrZw45JFWj
 vF4kurn2vF4xJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwMKu
 UUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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


> Registers relative with MERR are used for HW error handling, such as CPU
> cache etc now both KVM and TCG do not support MERR. Remove these CSR
> registers, vmstate keeps unchanged for compatibility.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c   | 6 ------
>   target/loongarch/csr.c   | 6 ------
>   target/loongarch/disas.c | 6 ------
>   3 files changed, 18 deletions(-)
>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 84a130956d..9d51a0297c 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -140,12 +140,6 @@ static void loongarch_la464_init_csr(DeviceState *dev)
>           }
>           set_csr_flag(LOONGARCH_CSR_IMPCTL1, CSRFL_UNUSED);
>           set_csr_flag(LOONGARCH_CSR_IMPCTL2, CSRFL_UNUSED);
> -        set_csr_flag(LOONGARCH_CSR_MERRCTL, CSRFL_UNUSED);
> -        set_csr_flag(LOONGARCH_CSR_MERRINFO1, CSRFL_UNUSED);
> -        set_csr_flag(LOONGARCH_CSR_MERRINFO2, CSRFL_UNUSED);
> -        set_csr_flag(LOONGARCH_CSR_MERRENTRY, CSRFL_UNUSED);
> -        set_csr_flag(LOONGARCH_CSR_MERRERA, CSRFL_UNUSED);
> -        set_csr_flag(LOONGARCH_CSR_MERRSAVE, CSRFL_UNUSED);
>           set_csr_flag(LOONGARCH_CSR_CTAG, CSRFL_UNUSED);
>   
>           for (i = env->perf_event_num; i < MAX_PERF_EVENTS; i++) {
> diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
> index 309b826ca9..d2ac39dee9 100644
> --- a/target/loongarch/csr.c
> +++ b/target/loongarch/csr.c
> @@ -82,12 +82,6 @@ static CSRInfo csr_info[] = {
>       CSR_OFF(TLBRELO1),
>       CSR_OFF(TLBREHI),
>       CSR_OFF(TLBRPRMD),
> -    CSR_OFF(MERRCTL),
> -    CSR_OFF(MERRINFO1),
> -    CSR_OFF(MERRINFO2),
> -    CSR_OFF(MERRENTRY),
> -    CSR_OFF(MERRERA),
> -    CSR_OFF(MERRSAVE),
>       CSR_OFF(CTAG),
>       CSR_OFF_ARRAY(DMW, 0),
>       CSR_OFF_ARRAY(DMW, 1),
> diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
> index 3249ab7ac6..928b8b94c2 100644
> --- a/target/loongarch/disas.c
> +++ b/target/loongarch/disas.c
> @@ -98,12 +98,6 @@ static const char * const csr_names[] = {
>       CSR_NAME(TLBRELO1),
>       CSR_NAME(TLBREHI),
>       CSR_NAME(TLBRPRMD),
> -    CSR_NAME(MERRCTL),
> -    CSR_NAME(MERRINFO1),
> -    CSR_NAME(MERRINFO2),
> -    CSR_NAME(MERRENTRY),
> -    CSR_NAME(MERRERA),
> -    CSR_NAME(MERRSAVE),
>       CSR_NAME(CTAG),
>       CSR_NAME(DMW(0)),
>       CSR_NAME(DMW(1)),
>
> base-commit: eb710c255642cd7dc947f25c9a06c9fc8191e98d

  Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>


