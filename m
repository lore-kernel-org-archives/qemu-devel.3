Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57927EB104C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 11:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzvHf-0006ej-Ja; Tue, 10 Mar 2026 07:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vzvHY-0006eE-5B; Tue, 10 Mar 2026 07:29:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1vzvHT-0003NH-Sm; Tue, 10 Mar 2026 07:29:47 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxFMGXALBpEX0ZAA--.27873S3;
 Tue, 10 Mar 2026 19:29:28 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxvsKUALBpPRVSAA--.25175S3;
 Tue, 10 Mar 2026 19:29:26 +0800 (CST)
Subject: Re: [PATCH v2 0/2] target/loongarch: Fix NX enforcement for PTW
 helpers
To: "Andrew S. Rightenburg" <andrew@rail5.org>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, qemu-stable@nongnu.org
References: <20260306073355.899858-1-andrew@rail5.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <8d918b85-583f-f74c-9bcf-1c01a5e899c6@loongson.cn>
Date: Tue, 10 Mar 2026 19:30:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260306073355.899858-1-andrew@rail5.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxvsKUALBpPRVSAA--.25175S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF4rGry8tF4UKFyfXrWDGFX_yoW8uFy8pF
 W3Ca1Ykrs8trZrAFsaqw1Fgr15CFs7Ga17XF4ftF9Yy398t34vvr1kt390qa17Aas3Gry2
 qF429r1ruFWUA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.101, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2026/3/6 ÏÂÎç3:33, Andrew S. Rightenburg Ð´µÀ:
> From: rail5 <andrew@rail5.org>
>
> Thanks to Bibo Mao <maobibo@loongson.cn> for the quick review and feedback
> on the original patch.
>
> The LoongArch ISA defines NX at bit 62 in the page table entry. Under TCG,
> NX is checked during translation, but the software page-walk helper (LDPTE)
> was masking the whole PTE value with the PALEN mask. This clears upper
> permission bits (including NX), allowing execution from NX mappings.
>
> Fix this by masking only the PPN/address field and preserving permission bits,
> while also clearing any non-architectural (software) bits via a hardware PTE
> mask.
>
> Once NX is enforced, instruction fetches from NX pages correctly raise PNX,
> but taking PNX could end up looping because loongarch_cpu_do_interrupt() tried
> to fetch the faulting instruction to populate CSR_BADI, which faults with PNX
> again. Treat PNX like other instruction-fetch exceptions and skip the CSR_BADI
> fetch.
>
> Reported at: https://gitlab.com/qemu-project/qemu/-/issues/3319
>
> Tested with a Linux guest by mapping a page RW, writing a single instruction,
> mprotect(PROT_READ) (no exec) and then calling through a function pointer.
> With this series applied the guest receives SIGSEGV instead of executing or
> hanging.
>
> Changes in v2:
> - Patch 1: Touch only helper_ldpte() (leave LDDIR returning a PALEN-masked base addr)
> - Patch 1: Drop hard-coded PPN width (use R_TLBENTRY_{32,64}_PPN_MASK)
> - Patch 1: Clear software/non-architectural PTE bits via env->hw_pte_mask
> - Patch 2: Carry Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>
> rail5 (2):
>    target/loongarch: Preserve PTE permission bits in LDPTE
>    target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch
>
>   target/loongarch/cpu.c            | 11 +++++++++++
>   target/loongarch/cpu.h            |  1 +
>   target/loongarch/tcg/tcg_cpu.c    |  2 +-
>   target/loongarch/tcg/tlb_helper.c | 25 ++++++++++++++++++++++---
>   4 files changed, 35 insertions(+), 4 deletions(-)
>
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


