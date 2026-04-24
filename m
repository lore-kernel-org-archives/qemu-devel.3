Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B575FDEE5E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 03:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG6pU-0005ld-2Q; Thu, 23 Apr 2026 23:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wG6pJ-0005kb-EN; Thu, 23 Apr 2026 23:03:33 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wG6pF-0002ih-Bn; Thu, 23 Apr 2026 23:03:32 -0400
Received: from [10.213.20.8] (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowAAXqAtz3eppsp9wDg--.51203S3;
 Fri, 24 Apr 2026 11:03:16 +0800 (CST)
Message-ID: <21320385-a9a5-44a9-a630-b7d975cceedc@iscas.ac.cn>
Date: Fri, 24 Apr 2026 11:03:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] target/riscv: add support for RISC-V P extension
 (v0.20 draft)
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
 <688effc1-9ea4-4bb2-b282-fd7f290d319f@oss.qualcomm.com>
From: Molly Chen <xiaoou@iscas.ac.cn>
In-Reply-To: <688effc1-9ea4-4bb2-b282-fd7f290d319f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAXqAtz3eppsp9wDg--.51203S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45Ar13KryftF4rXFW3GFg_yoWrKF4xpr
 4kG3yYk3y5Cr97Aw1xtr4DAry5JF4rGw45J3WkJa48tF45JFyjqrnFqw4jgF9rJF48Gr1j
 gF1jyr43Zr17ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jrF4iUUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.25; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.999,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thank you for your very specific feedback. I fully understand your point 
about eliminating code repetition — not only to reduce lines of code, 
but also to have fewer points of logic to take care of. I will review 
and revise the code according to your suggestions, reusing code where 
possible to minimize redundancy. These changes will be reflected in v2.

Thanks again!

Best regards,
Molly

在 2026/4/22 20:44, Daniel Henrique Barboza 写道:
> Hi,
>
> On 4/17/2026 7:46 AM, Molly Chen wrote:
>> This series adds support for the RISC-V Packed SIMD (P) extension.
>>
>> The P extension defines packed-SIMD fixed-point operations intended
>> for DSP-style workloads such as multimedia and signal processing.
>> These instructions operate on packed subword elements within
>> general-purpose registers (GPRs).
>
> Thanks for the work in putting all this together.
>
> I did a review in patch 2 that I believe applies to all other patches:
> we should strive to code re-use and avoid any code duplication as we can.
> This would be a good goal for a version 2.
>
>>
>> The implementation follows the current development draft of the
>> specification (v0.20):
>>
>>    https://www.jhauser.us/RISCV/ext-P/
>>
>> All instructions defined prior to the v0.20 update were verified
>> using a simple instruction coverage test suite:
>>
>>    https://github.com/mollybuild/qemu-riscv-test-uart
>
> A testsuite is greatly appreciated, in particular due to the amount of
> code included in this work.
>
>>
>> Instructions newly introduced in v0.20 were not tested yet because
>> toolchain support for generating them is still under development.
>
> This is fine.  You're adding experimental support so it's ok if it's not
> fully tested/completed, as long as we take care to document the 
> limitations
> and caveats of the existing emulation.
>
>
> Also, I talked with RVI.  I got told that this spec can move from 'draft'
> to 'frozen' later this year (Q3, maybe Q4).  Depending on the 
> time-frame of
> the spec status change, and the amount of progress we can make in the 
> review
> process, the spec might move to 'frozen' and we can drop the experimental
> tag and upstream it as a regular extension.  Let's see how we do.
>
>
> Thanks,
> Daniel
>
>>
>> The implementation focuses on functional correctness and ISA coverage.
>> Performance optimizations were not considered at this stage.
>>
>> Feedback on implementation details would be highly appreciated.
>>
>> Co-Authored by: Yin Zhang <zhangyin2018@iscas.ac.cn>
>> Co-Authored by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
>> Co-Authored by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
>>
>> Molly Chen (14):
>>    target/riscv: rvp: Add option defines and dependency check for packed
>>      simd extension
>>    target/riscv: rvp: add arithmetic instructions,including saturating
>>      and non-saturating operations
>>    target/riscv: rvp: add averaging operations
>>    target/riscv: rvp: add absolute value and difference,comparison and
>>      mask generation operations
>>    target/riscv: rvp: add shift operations
>>    target/riscv: rvp: add exchange operations
>>    target/riscv: rvp: add horizontal reduction, pack, merge and cout
>>      leading operations
>>    target/riscv: rvp: add pure multiplication operations
>>    target/riscv: rvp: add multiply-accumulate operations
>>    target/riscv: rvp: add Q-format multiplication operations
>>    target/riscv: rvp: add two-way and four-way multiply and accumulate
>>      operations
>>    target/riscv: rvp: add load and replicate instructions.
>>    target/riscv: rvp: add rv32-only register-pair instructions
>>    target/riscv: rvp: update to v020, add SHL and PNCLIP[U]P.*
>>      instructions
>>
>>   target/riscv/cpu.c                      |    5 +-
>>   target/riscv/cpu.h                      |    1 +
>>   target/riscv/helper.h                   |  531 ++
>>   target/riscv/insn32.decode              |  829 ++
>>   target/riscv/insn_trans/trans_rvp.c.inc | 1691 ++++
>>   target/riscv/meson.build                |    3 +-
>>   target/riscv/psimd_helper.c             | 9452 +++++++++++++++++++++++
>>   target/riscv/tcg/tcg-cpu.c              |   16 +
>>   target/riscv/translate.c                |    3 +
>>   9 files changed, 12528 insertions(+), 3 deletions(-)
>>   create mode 100644 target/riscv/insn_trans/trans_rvp.c.inc
>>   create mode 100644 target/riscv/psimd_helper.c
>>


