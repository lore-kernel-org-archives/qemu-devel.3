Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5B0CA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 08:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuSGc-00032d-98; Fri, 05 Sep 2025 04:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uuSGZ-00031r-5d
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:57:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uuSGQ-0003h4-Mh
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:57:53 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxudEDprpoxQIHAA--.14937S3;
 Fri, 05 Sep 2025 16:57:39 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxXMEAprpo_sl_AA--.22264S3;
 Fri, 05 Sep 2025 16:57:39 +0800 (CST)
Subject: Re: [PATCH v6 05/11] target/loongarch: add msg interrupt CSR registers
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250904121840.2023683-1-gaosong@loongson.cn>
 <20250904121840.2023683-6-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <2495fcdb-2f8c-bc80-028f-8977d804eba3@loongson.cn>
Date: Fri, 5 Sep 2025 16:55:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250904121840.2023683-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxXMEAprpo_sl_AA--.22264S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZFWrGr47Zry3XryxWw1Utwc_yoWrJw4fpr
 nxCFyUKFWxtrZ3u3Z3X345XFsxWr1xGw42va12kryxKFWUGr40grWkt39FvF1rJa4Fgr10
 vF10y34UGa17ZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5r7UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.794,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 2025/9/4 下午8:18, Song Gao wrote:
> include CSR_MSGIS0-3, CSR_MSGIR and CSR_MSGIE.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu-csr.h |  3 +++
>   target/loongarch/cpu.h     | 11 +++++++++++
>   target/loongarch/machine.c | 27 +++++++++++++++++++++++++--
>   3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index 0834e91f30..4792677086 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -186,6 +186,9 @@ FIELD(CSR_MERRCTL, ISMERR, 0, 1)
>   
>   #define LOONGARCH_CSR_CTAG           0x98 /* TagLo + TagHi */
>   
> +#define LOONGARCH_CSR_MSGIS(N)       (0xa0 + N)
> +#define LOONGARCH_CSR_MSGIR               0xa4
> +
>   /* Direct map windows CSRs*/
>   #define LOONGARCH_CSR_DMW(N)         (0x180 + N)
>   FIELD(CSR_DMW, PLV0, 0, 1)
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 56fc4a1459..f083c31bb4 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -233,6 +233,13 @@ FIELD(TLB_MISC, ASID, 1, 10)
>   FIELD(TLB_MISC, VPPN, 13, 35)
>   FIELD(TLB_MISC, PS, 48, 6)
>   
> +/*Msg interrupt registers */
> +#define N_MSGIS                4
> +FIELD(CSR_MSGIS, IS, 0, 63)
> +FIELD(CSR_MSGIR, INTNUM, 0, 8)
> +FIELD(CSR_MSGIR, ACTIVE, 31, 1)
> +FIELD(CSR_MSGIE, PT, 0, 8)
> +
>   #define LSX_LEN    (128)
>   #define LASX_LEN   (256)
>   
> @@ -350,6 +357,10 @@ typedef struct CPUArchState {
>       uint64_t CSR_DBG;
>       uint64_t CSR_DERA;
>       uint64_t CSR_DSAVE;
> +    /* Msg interrupt registers */
> +    uint64_t CSR_MSGIS[N_MSGIS];
> +    uint64_t CSR_MSGIR;
> +    uint64_t CSR_MSGIE;
>       struct {
>           uint64_t guest_addr;
>       } stealtime;
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 4e70f5c879..996fbeb501 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -10,6 +10,7 @@
>   #include "migration/cpu.h"
>   #include "system/tcg.h"
>   #include "vec.h"
> +#include "hw/loongarch/virt.h"
>   
>   static const VMStateDescription vmstate_fpu_reg = {
>       .name = "fpu_reg",
> @@ -45,6 +46,27 @@ static const VMStateDescription vmstate_fpu = {
>       },
>   };
>   
> +static bool msg_needed(void *opaque)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
The avec CSR registers CSR_MSGIR etc is part of CPU, I just think
it will be better to check avec CPU feature rather than board feature.

> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
> +
> +    return virt_has_avecintc(lvms);
It supposes that LoongArch CPU must be together with virt machine :)

> +}
> +
> +static const VMStateDescription vmstate_msg = {
how about rename it as vmstate_avec?  the same with msg_needed.


Regards
Bibo Mao


> +    .name = "cpu/msg",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = msg_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(env.CSR_MSGIS, LoongArchCPU, N_MSGIS),
> +        VMSTATE_UINT64(env.CSR_MSGIR, LoongArchCPU),
> +        VMSTATE_UINT64(env.CSR_MSGIE, LoongArchCPU),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>   static const VMStateDescription vmstate_lsxh_reg = {
>       .name = "lsxh_reg",
>       .version_id = 1,
> @@ -168,8 +190,8 @@ static const VMStateDescription vmstate_tlb = {
>   /* LoongArch CPU state */
>   const VMStateDescription vmstate_loongarch_cpu = {
>       .name = "cpu",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> +    .version_id = 4,
> +    .minimum_version_id = 4,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
>           VMSTATE_UINTTL(env.pc, LoongArchCPU),
> @@ -245,6 +267,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
>           &vmstate_tlb,
>   #endif
>           &vmstate_lbt,
> +        &vmstate_msg,
>           NULL
>       }
>   };
> 


