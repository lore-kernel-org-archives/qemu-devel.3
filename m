Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D84CA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 02:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGSXo-00046a-29; Mon, 12 Oct 2026 22:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1xGSXH-0003x1-3x
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 22:46:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1xGSXA-0000EK-DN
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 22:46:38 -0400
Received: from loongson.cn (unknown [10.20.42.166])
 by gateway (Coremail) with SMTP id _____8CxKvCBm81q+TMVAA--.61437S3;
 Tue, 13 Oct 2026 10:46:25 +0800 (CST)
Received: from [10.20.42.166] (unknown [10.20.42.166])
 by front1 (Coremail) with SMTP id qMiowJDxxMyBm81qgKorAA--.65082S2;
 Tue, 13 Oct 2026 10:46:25 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Remove TLB entry in vmstate
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: qemu-devel@nongnu.org
References: <20260929034252.712482-1-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <86643633-9761-7489-e245-af0eca8636ae@loongson.cn>
Date: Tue, 13 Oct 2026 10:44:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260929034252.712482-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxxMyBm81qgKorAA--.65082S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KryfXw1kKr17Zw4rGr4rWFX_yoW8ur45pw
 nxZF17KF97Kr92q3Z7Jw1YgFs8Wr1UGayUtF4UKw4rWas7Cw4Fgrs7t392yFZxAa4Yqr12
 vF10yry5JF4UArgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wNVDUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.591,
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

Hi Bibo Mao:
> The content of TLB entry may change if LVZ is added, TLB table can
> re-establish from empty state after VM migration. There will be
> compatible issue if TLB entry is removed in vmstate, however it is
> only affect TCG mode.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/machine.c | 35 -----------------------------------
>   1 file changed, 35 deletions(-)
>
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 931a5ca5ba..952c5497af 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -175,38 +175,6 @@ static const VMStateDescription vmstate_pmu = {
>       },
>   };
>   
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> -static bool tlb_needed(void *opaque)
> -{
> -    return tcg_enabled();
> -}
> -
> -/* TLB state */
> -static const VMStateDescription vmstate_tlb_entry = {
> -    .name = "cpu/tlb_entry",
> -    .version_id = 0,
> -    .minimum_version_id = 0,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_UINT64(tlb_misc, LoongArchTLB),
> -        VMSTATE_UINT64(tlb_entry0, LoongArchTLB),
> -        VMSTATE_UINT64(tlb_entry1, LoongArchTLB),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static const VMStateDescription vmstate_tlb = {
> -    .name = "cpu/tlb",
> -    .version_id = 0,
> -    .minimum_version_id = 0,
> -    .needed = tlb_needed,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
> -                             0, vmstate_tlb_entry, LoongArchTLB),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -#endif
> -
>   /* LoongArch CPU state */
>   const VMStateDescription vmstate_loongarch_cpu = {
>       .name = "cpu",
> @@ -283,9 +251,6 @@ const VMStateDescription vmstate_loongarch_cpu = {
>           &vmstate_fpu,
>           &vmstate_lsx,
>           &vmstate_lasx,
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> -        &vmstate_tlb,
> -#endif
>           &vmstate_lbt,
>           &vmstate_msgint,
>           &vmstate_pmu,
>
> base-commit: 81ce3a87737aa50716c42db8886082d12783e0a1
Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>


