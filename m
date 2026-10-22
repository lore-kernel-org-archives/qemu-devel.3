Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16339606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 03:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJjPm-0003SF-Il; Wed, 21 Oct 2026 23:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1xJjPl-0003S6-Hr
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 23:24:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1xJjPi-0000A1-Rm
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 23:24:24 -0400
Received: from loongson.cn (unknown [10.20.42.166])
 by gateway (Coremail) with SMTP id _____8Bx69HjgdlqLEYYAA--.4883S3;
 Thu, 22 Oct 2026 11:24:19 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxFs3hgdlqZQ0vAA--.41201S2;
 Thu, 22 Oct 2026 11:24:19 +0800 (CST)
Subject: Re: [PATCH 1/3] target/loongarch: Replace address_space_ldq_le() ->
 cpu_ldq_le_data_ra()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>
References: <20261013032841.2482079-1-maobibo@loongson.cn>
 <20261013032841.2482079-2-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <62688ccc-177f-ec35-2e78-6dd636d06a3c@loongson.cn>
Date: Thu, 22 Oct 2026 11:22:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013032841.2482079-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxFs3hgdlqZQ0vAA--.41201S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr15XrWfJr1DKFy3WF1fXwc_yoW5Jw4DpF
 Z3Cw4xtFWrtrZ5J3ZrGayYvF1UJ3s8G3y3WF4SkrySywn8tr1xur4Ut39FgF18Jan3Ww4U
 ZrnxZ3WUZFWxZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.689,
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>

> With LDDIR/LDPTE instruction, it accesses page table entry with physical
> address, so it can only be used in DA mode. Replace API
> address_space_ldq_le() with cpu_ldq_le_data_ra(), since there is QEMU
> CPU TLB with the latter. And in future if LVZ is supported, the latter API
> will call the second MMU page table walk.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 40cc076424..b6381f7cd3 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -21,7 +21,6 @@
>   #include "exec/log.h"
>   #include "cpu-csr.h"
>   #include "tcg/tcg_loongarch.h"
> -#include "system/memory.h"
>   
>   typedef bool (*tlb_match)(bool global, int asid, int tlb_asid);
>   
> @@ -721,7 +720,6 @@ static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
>   target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>                             uint32_t level, uint32_t mem_idx)
>   {
> -    CPUState *cs = env_cpu(env);
>       uint64_t badvaddr;
>       hwaddr index, phys;
>       uint64_t palen_mask = loongarch_palen_mask(env);
> @@ -754,7 +752,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>       get_dir_base_width(env, &dir_base, &dir_width, level);
>       index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
>       phys = base | index << 3;
> -    val = address_space_ldq_le(cs->as, phys, MEMTXATTRS_UNSPECIFIED, NULL);
> +    val = cpu_ldq_le_data_ra(env, phys, GETPC());
>   
>       return val & palen_mask;
>   }
> @@ -762,7 +760,6 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>   void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>                     uint32_t mem_idx)
>   {
> -    CPUState *cs = env_cpu(env);
>       hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
>       CPUSysState *sys = env_sys(env);
>       uint64_t pte_raw;
> @@ -823,8 +820,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>           ptoffset0 = ptindex << 3;
>           ptoffset1 = (ptindex + 1) << 3;
>           phys = base | (odd ? ptoffset1 : ptoffset0);
> -        pte_raw = address_space_ldq_le(cs->as, phys,
> -                                       MEMTXATTRS_UNSPECIFIED, NULL);
> +        pte_raw = cpu_ldq_le_data_ra(env, phys, GETPC());
>           tmp0 = loongarch_sanitize_hw_pte(env, pte_raw);
>           ps = ptbase;
>       }


