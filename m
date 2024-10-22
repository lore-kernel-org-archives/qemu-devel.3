Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D61D1CDAB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 07:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t38rs-0001jh-T6; Tue, 22 Oct 2024 02:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t38rr-0001jV-Dc; Tue, 22 Oct 2024 02:59:47 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t38ro-0007JW-5v; Tue, 22 Oct 2024 02:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1729580374; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=4P8/jW3SmUCITBWuBmIjQDpHdv8x+04EpjpL0HeYeGI=;
 b=kfbf5rTCG6cn8QVB/TwHvbTM9lqfY9SI03uboIDbeYms2Y35ngKMt5u4mLtYIrwOovbVBN6NB6pNP4HO+BidsybpcYdqj0rQ6om9qOeSrLX4010EDVcCGRe8AZf7RGJu/50bcQOdYIZv0WCHc8yxALqe7VIZ58hexqj5NhmL2Cg=
Received: from 30.166.64.99(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WHgrigO_1729580373 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 22 Oct 2024 14:59:34 +0800
Message-ID: <8a35ee80-f1b1-49e7-95d6-0daa14ef49e7@linux.alibaba.com>
Date: Tue, 22 Oct 2024 14:59:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] tcg/riscv: Add support for vector
To: Alistair Francis <alistair23@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
 <CAKmqyKOVZ36gHjk=oMQMB77Lmv=iuwSWvQogzNbUOe04ZwY7Rw@mail.gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <CAKmqyKOVZ36gHjk=oMQMB77Lmv=iuwSWvQogzNbUOe04ZwY7Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 2024/10/21 09:42, Alistair Francis wrote:
> On Thu, Oct 17, 2024 at 5:33 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Introduce support for the RISC-V vector extension in the TCG backend.
>>
>> v5: https://lore.kernel.org/qemu-devel/20241007025700.47259-1-zhiwei_liu@linux.alibaba.com/
>>
>> Changes for v6:
>>    - Fix problem with TB overflow restart wrt the constant pool.
>>    - Fix vsetivli disassembly.
>>    - Change set_vtype to precompute all instructions.
>>    - Extract one element before comparison in tcg_out_dupi_vec.
>>    - Extract one element before comparison in tcg_target_const_match.
>>    - Drop 'vm' parameter from most tcg_out_opc_* functions.
>>    - Add tcg_out_opc_vv_vi and accept K constants for operations
>>      which have .v.i instructions.
>>    - Do not expand cmp_vec early.
>>    - Fix expansion of rotls_vec.
>>
>> I've tested this on cfarm95, a banana pi bpi-f3 with 256-bit rvv-1.0,
>> with qemu-aarch64 and some vectorized test cases.
>>
>> Barring further comment, I plan to include this in a PR at the
>> end of the week.
>>
>>
>> r~
>>
>>
>> Huang Shiyuan (1):
>>    tcg/riscv: Add basic support for vector
>>
>> Richard Henderson (3):
>>    tcg: Reset data_gen_ptr correctly
>>    disas/riscv: Fix vsetivli disassembly
>>    tcg/riscv: Accept constant first argument to sub_vec
>>
>> TANG Tiancheng (10):
>>    util: Add RISC-V vector extension probe in cpuinfo
>>    tcg/riscv: Implement vector mov/dup{m/i}
>>    tcg/riscv: Add support for basic vector opcodes
>>    tcg/riscv: Implement vector cmp/cmpsel ops
>>    tcg/riscv: Implement vector neg ops
>>    tcg/riscv: Implement vector sat/mul ops
>>    tcg/riscv: Implement vector min/max ops
>>    tcg/riscv: Implement vector shi/s/v ops
>>    tcg/riscv: Implement vector roti/v/x ops
>>    tcg/riscv: Enable native vector support for TCG host
> Thanks!
>
> Applied to riscv-to-apply.next
>
> I have removed the Swung0x48 Signed-off-by line.

I think we should use this tag as pointed here[1]:

Signed-off-by: Huang Shiyuan <swung0x48@outlook.com>

[1]: https://mail.gnu.org/archive/html/qemu-riscv/2024-09/msg00526.html

Thanks,
Zhiwei

>
> Alistair
>
>>   disas/riscv.h                     |   2 +-
>>   host/include/riscv/host/cpuinfo.h |   2 +
>>   include/tcg/tcg.h                 |   6 +
>>   tcg/riscv/tcg-target-con-set.h    |   9 +
>>   tcg/riscv/tcg-target-con-str.h    |   3 +
>>   tcg/riscv/tcg-target.h            |  78 ++-
>>   tcg/riscv/tcg-target.opc.h        |  12 +
>>   disas/riscv.c                     |   2 +-
>>   tcg/tcg.c                         |   2 +-
>>   util/cpuinfo-riscv.c              |  24 +-
>>   tcg/riscv/tcg-target.c.inc        | 994 +++++++++++++++++++++++++++---
>>   11 files changed, 1011 insertions(+), 123 deletions(-)
>>   create mode 100644 tcg/riscv/tcg-target.opc.h
>>
>> --
>> 2.43.0
>>
>>

