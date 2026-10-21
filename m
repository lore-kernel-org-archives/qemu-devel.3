Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D61606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQ8Z-0002Sg-JI; Wed, 21 Oct 2026 02:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xJQ8W-0002ST-Or
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:49:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xJQ8T-0005wt-PP
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:49:20 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxn9FoYNhqoPEXAA--.3671S3;
 Wed, 21 Oct 2026 14:49:12 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBxpMxmYNhqkLsuAA--.5726S2;
 Wed, 21 Oct 2026 14:49:10 +0800 (CST)
Subject: Re: [PATCH] linux-user/loongarch64: In extframe_alloc, align before
 subtracting sctx_info size
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Song Gao <17746591750@163.com>, Xianglai Li <lixianglai@loongson.cn>
References: <20261020142310.3860421-1-peter.maydell@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <baa59027-6b6f-53ba-4bfd-fd539d5d34af@loongson.cn>
Date: Wed, 21 Oct 2026 14:50:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020142310.3860421-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpMxmYNhqkLsuAA--.5726S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur13tw17trWfCFWfuryrKrX_yoW5ZFy7pr
 y5ArnIkrWrXr15Xr97t348Za4fWw1UuF47GFZ3K348Gry5AFy8urn7Kry2vF1Uu3WkCFWY
 vryUta1UKFWDJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
 6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.387,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/10/20 下午10:23, Peter Maydell wrote:
> In extframe_alloc() we allocate space on the guest stack for a
> context struct, which consists of a target_sctx_info plus a more
> specific struct such as target_lasx_context.  The specific struct may
> have a higher alignment requirement than the basic target_sctx_info.
> 
> The Linux kernel code for this is in arch/loongarch/kernel/signal.c
> in extframe_alloc():
> 
>         unsigned long new_base = base - size;
> 
>         new_base = round_down(new_base, (align < 16 ? 16 : align));
>         new_base -= sizeof(struct sctx_info);
> 
> and it first adjusts the base (SP) address down by the size of the
> specific struct, then rounds that down to provide the required
> alignment, and finally subtracts the size of the sctx_info.
> 
> QEMU's version does this in the wrong order, subtracting both the
> specific struct size and the sctx_info size before rounding down for
> alignment.  This means that for the target_lasx_context which needs
> 32-alignment, we instead give the start of sctx_info 32-alignment,
> which (since that is 16 bytes long) means that the
> target_lasx_context is only 16-aligned.
> 
> This manifests as a failure in the TCG tests such as
> loongarch64-linux-user-signals.test if you build with the clang
> sanitizers enabled:
> 
> ../../linux-user/loongarch64/signal.c:182:13: runtime error: member access within misaligned address 0x7dc793950b90 for type 'struct target_lasx_context', which requires 32 byte alignment
> 0x7dc793950b90: note: pointer points here
>   00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00
>                ^
>      #0 0x57216113d881 in setup_sigframe /home/pm215/qemu/build/clang/../../linux-user/loongarch64/signal.c:182:13
>      #1 0x57216113d881 in setup_rt_frame /home/pm215/qemu/build/clang/../../linux-user/loongarch64/signal.c:389:5
>      #2 0x5721612a5041 in handle_pending_signal /home/pm215/qemu/build/clang/../../linux-user/signal.c:1349:9
>      #3 0x5721612a46ef in process_pending_signals /home/pm215/qemu/build/clang/../../linux-user/signal.c:1401:17
>      #4 0x57216113baa3 in cpu_loop /home/pm215/qemu/build/clang/../../linux-user/loongarch64/cpu_loop.c:121:9
> 
> Correct setup_extcontext() to match the order the kernel does it.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9d5cd6587a70d613 ("linux-user: Add LoongArch signal support")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/loongarch64/signal.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
> index eff75bcdc86..04015e06fda 100644
> --- a/linux-user/loongarch64/signal.c
> +++ b/linux-user/loongarch64/signal.c
> @@ -111,9 +111,10 @@ static abi_ptr extframe_alloc(struct extctx_layout *extctx,
>   {
>       abi_ptr sp = orig_sp;
>   
> -    sp -= sizeof(struct target_sctx_info) + size;
> +    sp -= size;
>       align = MAX(align, CONTEXT_INFO_ALIGN);
>       sp = ROUND_DOWN(sp, align);
> +    sp -= sizeof(struct target_sctx_info);
>       sctx->gaddr = sp;
>   
>       size = orig_sp - sp;
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


