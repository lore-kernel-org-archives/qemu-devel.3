Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D12C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmqee-0008Bs-1J; Tue, 25 Feb 2025 03:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tmqec-0008Bj-44
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:51:02 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tmqeZ-0008OY-Ay
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:51:01 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxmnFshL1njPOBAA--.26125S3;
 Tue, 25 Feb 2025 16:50:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxb8dkhL1nOqYnAA--.17083S3;
 Tue, 25 Feb 2025 16:50:46 +0800 (CST)
Subject: Re: [PATCH v2 0/9] target/loongarch: LoongArch32 fixes 1
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <3fd27fd1-b976-2705-7093-aecc6ffa0438@loongson.cn>
Date: Tue, 25 Feb 2025 16:50:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8dkhL1nOqYnAA--.17083S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFy3uF15Jw1rCr1xWry7CFX_yoW8Zr1DpF
 W7urs8KFW8trZ7JFs3Xa4aqas8XrnrGw42q3Z3try8Cw4ayry7ZF1kt39FgF1UZa4UGry0
 qFnak3WUZF4UXacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.847,
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



On 2025/2/25 上午8:40, Jiaxun Yang wrote:
> Hi all,
> 
> This series is a collection of small fixes I made to TCG for
> LoongArch32.
> 
> There are still many thing broken, especially on CSRs. More
> series following. However this is sufficient to boot 32bit
> kernel.
Is there any product introduction about LoongArch32 board? such as MMU 
type, memory type(DDR or SRAM), interrupt controller type.

Regards
Bibo Mao
> 
> Thanks for revivewing!
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Changes in v2:
> - Addressing minor review comments
> - Don't create 32bit vairant, simply allow 32bit CPU on qemu-loongarch64
> - Link to v1: https://lore.kernel.org/r/20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com
> 
> ---
> Jiaxun Yang (9):
>        target/loongarch: Enable rotr.w/rotri.w for LoongArch32
>        target/loongarch: Fix address generation for gen_sc
>        target/loongarch: Fix PGD CSR for LoongArch32
>        target/loongarch: Perform sign extension for IOCSR reads
>        target/loongarch: Use target_ulong for iocsrrd helper results
>        target/loongarch: Fix some modifiers for log formatting
>        target/loongarch: Use target_ulong for CSR helpers
>        target/loongarch: Fix load type for gen_ll
>        target/loongarch: Introduce max32 CPU type
> 
>   target/loongarch/cpu.c                             | 152 +++++++++++++++++----
>   target/loongarch/helper.h                          |  22 +--
>   target/loongarch/tcg/csr_helper.c                  |   2 +-
>   target/loongarch/tcg/insn_trans/trans_atomic.c.inc |   8 +-
>   target/loongarch/tcg/insn_trans/trans_shift.c.inc  |   4 +-
>   target/loongarch/tcg/iocsr_helper.c                |  20 +--
>   target/loongarch/tcg/op_helper.c                   |   4 +-
>   target/loongarch/tcg/tlb_helper.c                  |   2 +-
>   target/loongarch/tcg/translate.c                   |   5 +-
>   9 files changed, 155 insertions(+), 64 deletions(-)
> ---
> base-commit: 65cb7129f4160c7e07a0da107f888ec73ae96776
> change-id: 20241222-la32-fixes1-368cc14d0986
> 
> Best regards,
> 


