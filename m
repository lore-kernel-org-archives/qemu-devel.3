Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE1AEDE996
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 03:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snrFb-0002sM-Lu; Mon, 09 Sep 2024 23:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snrFZ-0002rH-Nd; Mon, 09 Sep 2024 23:09:05 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snrFX-00016t-Iq; Mon, 09 Sep 2024 23:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725937738; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=FU78brwN0Z6JbM+LtaN4oA11Nf22v9pADMDv7FlC9lk=;
 b=dF45iKEl78Q49flM5TFxPZlghOQhsjk6B3OJC2zudOHk8EOSIkjretdbQw8UqQLFO+erok9J1UY0QaIBFWngPBU3UcIzQd5UqlwuoOJr5DuH7wrp0Mh/vFaECpc1q9VRA/3XWs+bVEnq/BV06R5fpuwJ3b3Kp6UvpksOj9fkE/s=
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEikjkE_1725937737) by smtp.aliyun-inc.com;
 Tue, 10 Sep 2024 11:08:58 +0800
Message-ID: <df5cc742-4d9f-4531-b92a-ca9abcf7f390@linux.alibaba.com>
Date: Tue, 10 Sep 2024 11:08:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] Add support for vector
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com,
 bmeng.cn@gmail.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <CAKmqyKNerLvtkWFCP=VR=86Ewcg+iPUMTVfgtzYDYGopyEFHfQ@mail.gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <CAKmqyKNerLvtkWFCP=VR=86Ewcg+iPUMTVfgtzYDYGopyEFHfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/9/6 7:46, Alistair Francis wrote:
> On Thu, Sep 5, 2024 at 12:29 AM LIU Zhiwei <zhiwei_liu@linux.alibaba.com> wrote:
>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Can you please mention RISC-V in the cover letter title. Otherwise
> it's not obvious that this is RISC-V specific
Sorry. I miss it.

Thanks,
Zhiwei

>
> Alistair
>
>> This patch set introduces support for the RISC-V vector extension
>> in TCG backend for RISC-V targets.
>>
>> v3:
>>    1. Use the .insn form in cpuinfo probing.
>>
>>    2. Use reserved_regs to constrain the register group index instead of using constrain.
>>
>>    3. Avoid using macros to implement functions whenever possible.
>>
>>    4. Rename vtypei to vtype.
>>
>>    5. Move the __thread prev_vtype variable to TCGContext.
>>
>>    6. Support fractional LMUL setting, but since MF2 has a minimum ELEN of 32,
>>      restrict fractional LMUL to cases where SEW < 64.
>>
>>    7. Handle vector load/store imm12 split in a different function.
>>
>>    8. Remove compare vx and implement INDEX_op_cmpsel_vec for INDEX_op_cmp_vec in a more concise way.
>>
>>    9. Move the implementation of shi_vec from tcg_expand_vec_op to tcg_out_vec_op.
>>
>>    10. Address some formatting issues.
>>
>> v2:
>>    https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00679.html
>>
>> v1:
>>    https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00205.html
>>
>> Swung0x48 (1):
>>    tcg/riscv: Add basic support for vector
>>
>> TANG Tiancheng (13):
>>    tcg/op-gvec: Fix iteration step in 32-bit operation
>>    util: Add RISC-V vector extension probe in cpuinfo
>>    tcg/riscv: Add riscv vset{i}vli support
>>    tcg/riscv: Implement vector load/store
>>    tcg/riscv: Implement vector mov/dup{m/i}
>>    tcg/riscv: Add support for basic vector opcodes
>>    tcg/riscv: Implement vector cmp ops
>>    tcg/riscv: Implement vector neg ops
>>    tcg/riscv: Implement vector sat/mul ops
>>    tcg/riscv: Implement vector min/max ops
>>    tcg/riscv: Implement vector shs/v ops
>>    tcg/riscv: Implement vector roti/v/x shi ops
>>    tcg/riscv: Enable native vector support for TCG host
>>
>>   host/include/riscv/host/cpuinfo.h |    3 +
>>   include/tcg/tcg.h                 |    3 +
>>   tcg/riscv/tcg-target-con-set.h    |    7 +
>>   tcg/riscv/tcg-target-con-str.h    |    3 +
>>   tcg/riscv/tcg-target.c.inc        | 1047 ++++++++++++++++++++++++++---
>>   tcg/riscv/tcg-target.h            |   80 ++-
>>   tcg/riscv/tcg-target.opc.h        |   12 +
>>   tcg/tcg-internal.h                |    2 +
>>   tcg/tcg-op-gvec.c                 |    2 +-
>>   tcg/tcg-op-vec.c                  |    2 +-
>>   util/cpuinfo-riscv.c              |   26 +-
>>   11 files changed, 1062 insertions(+), 125 deletions(-)
>>   create mode 100644 tcg/riscv/tcg-target.opc.h
>>
>> --
>> 2.43.0
>>
>>

