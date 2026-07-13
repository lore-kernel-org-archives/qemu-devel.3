Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBFEC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjAHG-0003DQ-G6; Mon, 13 Jul 2026 02:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wjAHA-0003D6-7W
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:36:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wjAH4-0001bR-RQ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:36:23 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Dx8+lUh1RqZvECAA--.2409S3;
 Mon, 13 Jul 2026 14:36:05 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxu8ROh1RqPq4LAA--.1317S2;
 Mon, 13 Jul 2026 14:36:00 +0800 (CST)
Subject: Re: [PATCH v3 1/8] target/loongarch: Define LVZ CSR fields
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1783673526.git.prcups@krgm.moe>
 <cf0a7d35938573b708bcaa68236b139013a542c0.1783673526.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <4de87fcc-9a8e-dc8b-29a1-90f768ae074a@loongson.cn>
Date: Mon, 13 Jul 2026 14:35:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cf0a7d35938573b708bcaa68236b139013a542c0.1783673526.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxu8ROh1RqPq4LAA--.1317S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFyrWrW8Kw4ftFykury5ZFc_yoW5CF4kp3
 48KFZ3CrW8tasak3Z3t3W5J3ZxXr4xA39rWrsrJrZ2yr1jq3y0yrZFgryrtry5Ar95Xr1r
 AFn3A3y5urn8JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhF
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.494,
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



On 2026/7/10 下午5:00, SignKirigami wrote:
> Add LVZ CSR number and bit-field definitions for guest status,
> configuration, interrupt, timer and guest TLB registers, preparing
> the architectural constants needed by later LVZ CPU state, CSR and
> TCG implementation patches.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu-csr.h | 42 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index d860417af2..4b0bb4d2e5 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -180,11 +180,13 @@ FIELD(CSR_TLBREHI_64, VPPN, 13, 35)
>   #define LOONGARCH_CSR_TLBRPRMD       0x8f /* TLB refill mode info */
>   FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
>   FIELD(CSR_TLBRPRMD, PIE, 2, 1)
> +FIELD(CSR_TLBRPRMD, PGM, 3, 1)
>   FIELD(CSR_TLBRPRMD, PWE, 4, 1)
It seems that the bit PGM is not used in the patch set. If it is not 
used now, it had better be removed, and add it when necessary.

>   
>   /* Machine Error CSRs */
>   #define LOONGARCH_CSR_MERRCTL        0x90 /* ERRCTL */
>   FIELD(CSR_MERRCTL, ISMERR, 0, 1)
> +FIELD(CSR_MERRCTL, PGM, 5, 1)
Ditto, it seems that the bit PGM is not used in the patch set.

>   #define LOONGARCH_CSR_MERRINFO1      0x91
>   #define LOONGARCH_CSR_MERRINFO2      0x92
>   #define LOONGARCH_CSR_MERRENTRY      0x93 /* MError exception base */
> @@ -224,4 +226,44 @@ FIELD(CSR_DBG, ECODE, 16, 6)
>   #define LOONGARCH_CSR_DERA           0x501 /* Debug era */
>   #define LOONGARCH_CSR_DSAVE          0x502 /* Debug save */
>   
> +/* LVZ (LoongArch Virtualization) CSRs */
> +#define LOONGARCH_CSR_GSTAT          0x50 /* Guest status */
> +FIELD(CSR_GSTAT, VM, 0, 1)
> +FIELD(CSR_GSTAT, PVM, 1, 1)
> +FIELD(CSR_GSTAT, GIDBIT, 4, 6)
> +FIELD(CSR_GSTAT, GID, 16, 8)
> +
> +#define LOONGARCH_CSR_GCFG           0x51 /* Guest config */
> +FIELD(CSR_GCFG, MATP, 0, 4)
> +FIELD(CSR_GCFG, MATC, 4, 2)
> +FIELD(CSR_GCFG, TOPIP, 6, 1)
> +FIELD(CSR_GCFG, TOPI, 7, 1)
> +FIELD(CSR_GCFG, TOTIP, 8, 1)
> +FIELD(CSR_GCFG, TOTI, 9, 1)
> +FIELD(CSR_GCFG, TOEP, 10, 1)
> +FIELD(CSR_GCFG, TOE, 11, 1)
> +FIELD(CSR_GCFG, TOPP, 12, 1)
> +FIELD(CSR_GCFG, TOP, 13, 1)
> +FIELD(CSR_GCFG, TOHUP, 14, 1)
> +FIELD(CSR_GCFG, TOHU, 15, 1)
> +FIELD(CSR_GCFG, TOCIP, 16, 4)
> +FIELD(CSR_GCFG, TOCI, 20, 2)
> +FIELD(CSR_GCFG, GPMP, 23, 1)
> +FIELD(CSR_GCFG, GPMNUM, 24, 3)
> +
> +#define LOONGARCH_CSR_GINTC          0x52 /* Guest interrupt config */
> +FIELD(CSR_GINTC, HWIS, 0, 8)
> +FIELD(CSR_GINTC, HWIP, 8, 8)
> +FIELD(CSR_GINTC, HWIC, 16, 8)
> +
> +#define LOONGARCH_CSR_GCNTC          0x53 /* Guest counter compensation */
> +
> +#define LOONGARCH_CSR_GTLBC          0x15 /* Guest TLB control */
> +FIELD(CSR_GTLBC, GMTLBSZ, 0, 6)
> +FIELD(CSR_GTLBC, USETGID, 12, 1)
> +FIELD(CSR_GTLBC, TOTI, 13, 1)
> +FIELD(CSR_GTLBC, TGID, 16, 8)
> +
> +#define LOONGARCH_CSR_TRGP           0x16 /* Trapped guest physical address */
CSR register CSR_TRGP is not used in the patch set.

Regards
Bibo Mao
> +
>   #endif /* LOONGARCH_CPU_CSR_H */
> 


