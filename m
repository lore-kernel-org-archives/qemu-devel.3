Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80625C61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rl3-0003yZ-9b; Sun, 30 Aug 2026 22:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x0rl1-0003yQ-34
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:28:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x0rkx-0000jz-GK
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:28:22 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxntK45pRqGL4GAA--.18825S3;
 Mon, 31 Aug 2026 10:28:08 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxxMy35pRq8fcXAA--.23094S2;
 Mon, 31 Aug 2026 10:28:07 +0800 (CST)
Subject: Re: [PATCH v4 01/14] target/loongarch: Define LVZ CSR fields
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1787739852.git.prcups@krgm.moe>
 <4e393c8c6f5d7d42ede6fa65fc94753bd8b14c17.1787739852.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <1deae93a-e9f0-3d33-ac78-872cf56d7e87@loongson.cn>
Date: Mon, 31 Aug 2026 10:27:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4e393c8c6f5d7d42ede6fa65fc94753bd8b14c17.1787739852.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxxMy35pRq8fcXAA--.23094S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww43Wr1rGF1Utw1ktFy7urX_yoW8KFyxp3
 48KFZ3CrW8Ka4SkF93t3W5G3ZxXr48AwsrursrJrWxtr1jq3y0yrZrt348try5Ar95Xr15
 AFnay3y5CFn8JwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2ID7
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.789,
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



On 2026/8/26 下午6:30, SignKirigami wrote:
> Add LVZ CSR number and bit-field definitions for guest status,
> configuration, interrupt, timer and guest TLB registers, preparing
> the architectural constants needed by later LVZ CPU state, CSR and TCG
> implementation patches.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu-csr.h | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index d860417af2..438da43a79 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -224,4 +224,42 @@ FIELD(CSR_DBG, ECODE, 16, 6)
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
CSR register LOONGARCH_CSR_GTLBC had better to put ahead of 
LOONGARCH_CSR_GSTAT by CSR index order. The others looks good to me.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>   #endif /* LOONGARCH_CPU_CSR_H */
> 


