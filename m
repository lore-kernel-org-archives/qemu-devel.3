Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD61606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUEyI-0002w5-U4; Thu, 19 Nov 2026 22:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xUEy8-0002vS-1c
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:07:21 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xUEy1-0006bO-Q8
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:07:16 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxrtJbuf9qfGchAA--.30614S3;
 Fri, 20 Nov 2026 11:07:07 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxX89auf9qRhI2AA--.42537S2;
 Fri, 20 Nov 2026 11:07:07 +0800 (CST)
Subject: Re: [PATCH v2 13/16] target/loongarch: Add fine-grained write masks
 for CSRs
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20261120012356.2656317-1-maobibo@loongson.cn>
 <20261120012356.2656317-14-maobibo@loongson.cn>
Message-ID: <16f25a5d-42f4-5358-5b00-2724b619c72f@loongson.cn>
Date: Fri, 20 Nov 2026 11:08:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261120012356.2656317-14-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxX89auf9qRhI2AA--.42537S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXrWrArWDAw1UZw4kWw1UXFc_yoWrKrWkpr
 sxZFy5KrW8trZ7Cwn3X3W5u3Z0qws7Gw42qa1xJ3s7JrW5tFW8Wayvk342yFZ5Xr1rXr1I
 9F1FyryIqF4xtagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wN
 VDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
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



On 2026/11/20 上午9:23, Bibo Mao wrote:
> Introduce set_csr_wrmask() and clear_csr_wrmask() to adjust the
> per-CSR write mask at initialization time. This allows describing
> CSRs whose writable bits are not a single contiguous range: a
> read-only bit between writable bits can be cleared from the mask,
> and writable bits for newly emulated features can be added without
> touching the default mask of the whole register.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c                        |  4 ++
>   target/loongarch/csr.c                        | 26 +++++++++++++
>   target/loongarch/csr.h                        |  4 +-
>   .../tcg/insn_trans/trans_privileged.c.inc     | 37 +++++++++++++++++++
>   4 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 020eb88f49..5ff0407dee 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -153,6 +153,10 @@ static void loongarch_la464_init_csr(DeviceState *dev)
>               set_csr_flag(LOONGARCH_CSR_PERFCTRL(i), CSRFL_UNUSED);
>               set_csr_flag(LOONGARCH_CSR_PERFCNTR(i), CSRFL_UNUSED);
>           }
> +
> +        if (tcg_enabled() && cpu_has_ptw(env)) {
> +            set_csr_wrmask(LOONGARCH_CSR_PWCH, R_CSR_PWCH_HPTW_EN_MASK);
> +        }
>       }
>   #endif
>   }
> diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
> index 3e7e2ed971..78db13a268 100644
> --- a/target/loongarch/csr.c
> +++ b/target/loongarch/csr.c
> @@ -157,3 +157,29 @@ bool set_csr_flag(unsigned int csr_num, int flag)
>       csr->flags |= flag;
>       return true;
>   }
> +
> +bool clear_csr_wrmask(unsigned int csr_num, uint64_t wrmask)
> +{
> +    CSRInfo *csr;
> +
> +    csr = get_csr(csr_num);
> +    if (!csr) {
> +        return false;
> +    }
> +
> +    csr->wrmask &= ~wrmask;
> +    return true;
> +}
> +
> +bool set_csr_wrmask(unsigned int csr_num, uint64_t wrmask)
> +{
> +    CSRInfo *csr;
> +
> +    csr = get_csr(csr_num);
> +    if (!csr) {
> +        return false;
> +    }
> +
> +    csr->wrmask |= wrmask;
> +    return true;
> +}
> diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
> index 323da26080..414c42cf6e 100644
> --- a/target/loongarch/csr.h
> +++ b/target/loongarch/csr.h
> @@ -25,15 +25,17 @@ enum {
>   
>   typedef struct {
>       const char *name;
> -    uint64_t wrmask;
>       int offset;
>       int flags;
>       GenCSRFunc readfn;
>       GenCSRFunc writefn;
> +    uint64_t wrmask;
>   } CSRInfo;
This is not necessary :(

>   
>   CSRInfo *get_csr(unsigned int csr_num);
>   bool set_csr_flag(unsigned int csr_num, int flag);
> +bool clear_csr_wrmask(unsigned int csr_num, uint64_t wrmask);
> +bool set_csr_wrmask(unsigned int csr_num, uint64_t wrmask);
>   static inline unsigned int get_csr_offset(const CSRInfo *csr, int vm_level)
>   {
>       return csr->offset + offsetof(CPULoongArchState, sys_states[vm_level]);
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 024fd9073a..0a67fe146d 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -69,6 +69,42 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
>       return true;
>   }
>   
> +static void init_csr_wrmask(void)
> +{
> +    int i;
> +    uint64_t romask;
> +
> +    romask = BIT_ULL(4) | BIT_ULL(8);
> +    clear_csr_wrmask(LOONGARCH_CSR_MISC, romask);
> +
> +    romask = MAKE_64BIT_MASK(13, 3);
> +    clear_csr_wrmask(LOONGARCH_CSR_ECFG, romask);
> +
> +    /* 2048 TLB entries */
> +    romask = MAKE_64BIT_MASK(12, 12) | BIT_ULL(30);
> +    clear_csr_wrmask(LOONGARCH_CSR_TLBIDX, romask);
> +
> +    romask = MAKE_64BIT_MASK(7, 5) | MAKE_64BIT_MASK(48, 13);
> +    clear_csr_wrmask(LOONGARCH_CSR_TLBELO0, romask);
> +    clear_csr_wrmask(LOONGARCH_CSR_TLBELO1, romask);
> +    clear_csr_wrmask(LOONGARCH_CSR_TLBRELO0, romask);
> +    clear_csr_wrmask(LOONGARCH_CSR_TLBRELO1, romask);
> +
> +    romask = BIT_ULL(1);
> +    clear_csr_wrmask(LOONGARCH_CSR_TLBRERA, romask);
> +
> +    romask = MAKE_64BIT_MASK(6, 7);
> +    clear_csr_wrmask(LOONGARCH_CSR_TLBREHI, romask);
> +
> +    romask = BIT_ULL(3);
> +    clear_csr_wrmask(LOONGARCH_CSR_TLBRPRMD, romask);
> +
> +    romask = MAKE_64BIT_MASK(10, 6);
> +    for (i = 0; i < MAX_PERF_EVENTS; i++) {
> +        clear_csr_wrmask(LOONGARCH_CSR_PERFCTRL(i), romask);
> +    }
> +}
> +
>   #define SET_CSR_FUNC(NAME, read, write)                 \
>           set_csr_trans_func(LOONGARCH_CSR_##NAME, read, write)
>   
> @@ -84,6 +120,7 @@ void loongarch_csr_translate_init(void)
>       SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
>       SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
>       SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
> +    init_csr_wrmask();
>   }
>   #undef SET_CSR_FUNC
>   
> 


