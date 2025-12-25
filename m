Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C98E784BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 02:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYaxg-0007pR-Bd; Wed, 24 Dec 2025 21:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vYaxc-0007pC-Oj
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 21:20:16 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vYaxN-0000F5-1z
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 21:20:08 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxAfFEn0xpOwEDAA--.10136S3;
 Thu, 25 Dec 2025 10:19:48 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxzsI+n0xpH4wEAA--.13434S3;
 Thu, 25 Dec 2025 10:19:44 +0800 (CST)
Subject: Re: [PATCH 0/8] target/loongarch: Use explicit little-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20251224161456.89707-1-philmd@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <cf98f635-b1d9-942e-bdef-be8c260f764d@loongson.cn>
Date: Thu, 25 Dec 2025 10:17:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251224161456.89707-1-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxzsI+n0xpH4wEAA--.13434S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF18Jw4UJry8Xr1UGr1Utwc_yoW8ArWfpr
 17CF47KFWrtrZxJr4fZa9xXr1jgrs7Ga12q3Wftr95uF4aqryxZF48J392gFyUJ34DXryj
 qFnYk3WUWayUXacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.053,
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



On 2025/12/25 上午12:14, Philippe Mathieu-Daudé wrote:
> LoongArch is little-endian. Use the explicit 'little'
> endianness instead of the 'native' one.
> Remove some target_ulong uses. Forbid further uses of
> legacy APIs.
> 
> tag: https://gitlab.com/philmd/qemu/-/tags/endian_loongarch-v1
> CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066
> 
> Philippe Mathieu-Daudé (8):
>    hw/loongarch: Use explicit little-endian LD/ST API
>    target/loongarch: Replace target_ulong -> uint64_t for DMW and
>      TLBRBADV
>    target/loongarch: Use hwaddr type for physical addresses
>    target/loongarch: Replace MO_TE -> MO_LE
>    target/loongarch: Inline cpu_ldl_code() call in cpu_do_interrupt()
>    target/loongarch: Use explicit little-endian LD/ST API
>    target/loongarch: Inline translator_ldl()
>    configs/targets: Forbid LoongArch to use legacy native endianness APIs
> 
>   configs/targets/loongarch64-linux-user.mak    |  1 +
>   configs/targets/loongarch64-softmmu.mak       |  1 +
>   hw/loongarch/virt.c                           | 18 ++---
>   target/loongarch/cpu_helper.c                 | 12 +--
>   target/loongarch/tcg/iocsr_helper.c           | 24 +++---
>   target/loongarch/tcg/tcg_cpu.c                |  4 +-
>   target/loongarch/tcg/tlb_helper.c             | 10 ++-
>   target/loongarch/tcg/translate.c              |  3 +-
>   .../tcg/insn_trans/trans_atomic.c.inc         | 80 +++++++++----------
>   .../tcg/insn_trans/trans_fmemory.c.inc        | 32 ++++----
>   .../tcg/insn_trans/trans_memory.c.inc         | 64 +++++++--------
>   .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++--
>   12 files changed, 136 insertions(+), 129 deletions(-)
> 
Thanks for doing this on LoongArch, this series looks good to me.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>


