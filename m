Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A59CD6E55
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 02:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUEor-0001DF-Rz; Mon, 01 Jun 2026 22:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wUEok-0001Cg-QT
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 22:25:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wUEoh-0007wm-Vd
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 22:25:22 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cx4eoFPx5qMZMPAA--.43649S3;
 Tue, 02 Jun 2026 10:25:09 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxWeACPx5qZNKYAA--.27958S3;
 Tue, 02 Jun 2026 10:25:09 +0800 (CST)
Subject: Re: [PATCH 00/12] target/loongarch: Move CSR registers to struct
 CPUSysState
To: SignKirigami <prcups@krgm.moe>
Cc: qemu-devel@nongnu.org, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <20260526065023.1639371-1-maobibo@loongson.cn>
 <e922a116-ae19-bb16-8dbb-5ad276430e5b@loongson.cn>
 <b1872865-1748-e89b-f6ad-2f3104496563@loongson.cn>
 <lOb30Y5VTVyDy4BxZJsUCg@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <0427a7d9-7e3f-8938-e06c-2de6ffc333b4@loongson.cn>
Date: Tue, 2 Jun 2026 10:22:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <lOb30Y5VTVyDy4BxZJsUCg@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxWeACPx5qZNKYAA--.27958S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFW3Gw1fGw4fZr43XrWkGrX_yoW5ur43p3
 yxZF1rK3yktFZxJFs2qa45X3Wqqw17Gr47X3Z3try8ua90yryxWF48J3929F1DZ34UWryj
 qF1rC34UZFW0vabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
 xhVjvjDU0xZFpf9x07j0FALUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
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



On 2026/6/2 上午10:02, SignKirigami wrote:
> On 2026年5月26日星期二 中国标准时间 16:28:28，Bibo Mao wrote：
>>
>> On 2026/5/26 下午3:48, gaosong wrote:
>>> 在 2026/5/26 下午2:50, Bibo Mao 写道:
>>>> Here new structure CPUSysState is added in CPULoongArchState, CSR
>>>> registers are move in CPUSysState. In later with LVZ supported, there
>>>> will
>>>> be two copied of CSR registers, so it is simply to add CPUSysState array.
>>>>
>>>> Also new field curState is added which points to CPUSysState at
>>>> beginning, and it can be changed during VM exit/enter entry. There is no
>>>> function change, all is code movement or variable rename.
>>>>
>>>> Bibo Mao (12):
>>>>     target/loongarch: Add new field curState in CPULoongArchState
>>>>     target/loongarch: Use curState in cpu.c when accessing CSR registers
>>>>     target/loongarch: Use curState in cpu_helper.c when accessing CSR
>>>>       registers
>>>>     target/loongarch: Use curState in file arch_dump.c when accessing CSR
>>>>       registers
>>>>     target/loongarch: Use curState in kvm.c when accessing CSR registers
>>>>     target/loongarch: Use curState in tlb_helper.c when accessing CSR
>>>>       registers
>>>>     target/loongarch: Use curState in tcg_cpu.c when accessing CSR
>>>>       registers
>>>>     target/loongarch: Use curState in csr_helper.c when accessing CSR
>>>>       registers
>>>>     target/loongarch: Use curState in op_helper.c when accessing CSR
>>>>       registers
>>>>     target/loongarch: Add default CSRFL_BASIC info with flags field
>>>>     target/loongarch: Add wrapper function get_csr_offset()
>>>>     target/loongarch: Add new structure CPUSysState
>>>>
>>>>    hw/intc/loongarch_dintc.c                     |   4 +-
>>>>    target/loongarch/arch_dump.c                  |   5 +-
>>>>    target/loongarch/cpu-mmu.h                    |   4 +-
>>>>    target/loongarch/cpu.c                        | 120 ++++-----
>>>>    target/loongarch/cpu.h                        |  49 ++--
>>>>    target/loongarch/cpu_helper.c                 |  41 ++--
>>>>    target/loongarch/csr.c                        |  10 +-
>>>>    target/loongarch/csr.h                        |   5 +
>>>>    target/loongarch/gdbstub.c                    |   3 +-
>>>>    target/loongarch/kvm/kvm.c                    | 228 +++++++++---------
>>>>    target/loongarch/machine.c                    | 116 ++++-----
>>>>    target/loongarch/tcg/constant_timer.c         |  10 +-
>>>>    target/loongarch/tcg/csr_helper.c             |  55 +++--
>>>>    .../tcg/insn_trans/trans_extra.c.inc          |  11 +-
>>>>    .../tcg/insn_trans/trans_privileged.c.inc     |  16 +-
>>>>    target/loongarch/tcg/op_helper.c              |  45 ++--
>>>>    target/loongarch/tcg/tcg_cpu.c                | 107 ++++----
>>>>    target/loongarch/tcg/tlb_helper.c             | 137 ++++++-----
>>>>    18 files changed, 531 insertions(+), 435 deletions(-)
>>>>
>>> Hi,
>>> The files in linux-user/loongarch64/* also need to be modified.
>> oops, loongarch-linux-user is missing here. Thanks for the reporting.
>> Will add and test this target.
>>
>> Regards
>> Bibo Mao
> This patch looks good to me. Should I continue lvz support after this
> patch is merged?
Both are ok. You can post it based on existing master baseline rather 
than after this patch is merged. I think you can split LVZ patch into 
more smaller ones, currently I am reviewing MMU virtualization part at 
the same time.

Regards
Bibo Mao
> 
>>>
>>> Thanks.
>>> Song Gao
>>>> base-commit: cbf877d67a812be17a9ce404a589e1bdf722c1f6
>>
>>
> 
> 
> 
> 


