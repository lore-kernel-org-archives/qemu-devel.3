Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2E1C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthJy-00086N-V3; Tue, 11 Aug 2026 03:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wthJv-000869-UX; Tue, 11 Aug 2026 03:54:47 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wthJs-0001v6-24; Tue, 11 Aug 2026 03:54:47 -0400
Received: from [10.213.18.251] (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3TPA51Xpq4qbrBA--.44664S3;
 Tue, 11 Aug 2026 15:54:33 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------xdSDnJiNy0lJNpbkrVjkFeSb"
Message-ID: <738d4121-1841-4b08-adab-94d4fbfec0fa@iscas.ac.cn>
Date: Tue, 11 Aug 2026 15:54:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] target/riscv: Add support for RISC-V P
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, nutty.liu@hotmail.com
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <amnHq8A14gOpHcg0@ChaodeMacBook-Pro.local>
 <946b40dd-a2b9-4d10-97f0-8dad261e0570@oss.qualcomm.com>
From: MOLLY CHEN <xiaoou@iscas.ac.cn>
In-Reply-To: <946b40dd-a2b9-4d10-97f0-8dad261e0570@oss.qualcomm.com>
X-CM-TRANSID: qwCowAB3TPA51Xpq4qbrBA--.44664S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF45ZryfGryDCF1rAF4ktFb_yoWxWF47pr
 4rG3yYyryUJryxGw1xJw4DJry5GF4rGw45JwnrX3W8ta13tF4aqFnFvw4j9FnrJF48Gw1j
 9F1qyr1UZF4UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487McIj6xIIjxv2
 0xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8Jw
 ACjcxG0xvEwIxGrwCjr7xvwVCIw2I0I7xG6c02F41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUGVWUWw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07b1AwsUUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.581,
 HK_RANDOM_FROM=0.999, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------xdSDnJiNy0lJNpbkrVjkFeSb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks Daniel，Chao and Nutty for the review.

I’ll address these issues in v3 by:

  * adding a descriptive commit body to each patch and comments
    for functions that need further explanation;
  * aligning the continuation backslashes in the helper macros;
  * reusing the existing |EXTRACT*|definitions in patch 02/18 instead of
    introducing duplicate definitions; and
  * investigating the addition of P-extension test cases to the QEMU TCG
    test suite, depending on the available toolchain support.

I’ll also document these changes in the v3 cover letter.

Best regards,
Molly

在 2026/8/6 2:36, Daniel Henrique Barboza 写道:
>
>
> On 7/29/2026 6:32 AM, Chao Liu wrote:
>> On Fri, Jul 17, 2026 at 10:06:53AM +0800, Molly Chen wrote:
>>> This series adds support for the RISC-V Packed SIMD (P) extension.
>>>
>>> The P extension defines packed-SIMD fixed-point operations intended
>>> for DSP-style workloads such as multimedia and signal processing.
>>> These instructions operate on packed subword elements within
>>> general-purpose registers (GPRs).
>>>
>>> The implementation follows the current development draft of the
>>> specification (v0.20):
>>>
>>> https://github.com/riscv/riscv-p-spec/
>>>    or
>>> https://www.jhauser.us/RISCV/ext-P/
>>>
>>> Compared with v1, this version reduces implementation boilerplate by
>>> defining and reusing helper macros for common patterns in
>>> trans_rvp.c.inc and psimd_helper.c. It also consolidates the P
>>> extension prerequisite validation in riscv_cpu_validate_p().
>>>
>>> The Zbkb dependency has been removed to align the implementation with
>>> the current specification. This version also implements the
>>> specification-defined control of vxsat, which was missing from v1.
>>>
>>> All instructions have been functionally tested using the following
>>> test suite:
>>>
>>> https://github.com/mollybuild/qemu-riscv-test-uart
>>>
>>> The implementation focuses on functional correctness and ISA
>>> coverage. Performance optimizations were not considered at this
>>> stage.
>>>
>>> Feedback on the implementation details would be highly appreciated.
>>>
>>> Tested with:
>>>
>>>    - ninja -C build test
>>>    - make -C build check-qtest-riscv32
>>>    - make -C build check-qtest-riscv64
>>>    - Functional tests for all P extension instructions using
>>>      qemu-riscv-test-uart
>>>
>>> No regressions or test failures were observed.
>>>
>>> ---
>>> Changes in v2:
>>>
>>>    - Refactored trans_rvp.c.inc and psimd_helper.c by defining and
>>>      reusing helper macros for common implementation patterns, reducing
>>>      boilerplate and overall code size.
>>>    - Moved the P extension prerequisite checks into
>>>      riscv_cpu_validate_p().
>>>    - Removed the Zbkb dependency to align with the current
>>>      specification.
>>>    - Added the specification-defined vxsat control mechanism, which was
>>>      missing from v1.
>>>
>> This patch set is a significant improvement over v1. I think there 
>> are still
>> a few common issues we can address together:
>
> v2 is a huge improvement indeed.  v1 had 11k lines, v2 cut those by 
> half due to
> the smart use of helpers.
>
>>
>> 1. The line break characters '\' in the helper macros we defined need 
>> to be space-aligned.
>> 2. Every patch is currently missing a commit body.
>>
>> I think these changes are quite necessary.
>
> Yeah, having a commit message allows us to make fewer guesses when 
> reviewing code.
> E.g. the usage of __int128t__ macros and the choice of some rounding 
> formulas.  We
> can make review  assumptions and hope all is fine, but it's not ideal.
>
> And, as Chao mentioned in his other reply, having test cases will be 
> helpful to
> assert that everything being added here is sane.  In particular with 
> the amount
> of lines we're adding here.
>
>
> Cheers,
> Daniel
>
>>
>> Thanks,
>> Chao
>>> v1:
>>> https://lists.nongnu.org/archive/html/qemu-riscv/2026-04/msg00301.html
>>>
>>> Molly Chen (18):
>>>    target/riscv: Add packed SIMD extension state
>>>    target/riscv: Add packed SIMD helper framework
>>>    target/riscv: Add packed SIMD arithmetic instructions
>>>    target/riscv: Add packed SIMD averaging and rounding instructions
>>>    target/riscv: Add packed SIMD absolute, difference, compare and mask
>>>      instructions
>>>    target/riscv: Add packed SIMD shift instructions
>>>    target/riscv: Add packed SIMD exchange instructions
>>>    target/riscv: Add packed SIMD horizontal reduction instructions
>>>    target/riscv: Add packed SIMD pack, merge and count-leading
>>>      instructions
>>>    target/riscv: Add packed SIMD multiplication instructions
>>>    target/riscv: Add packed SIMD multiply-accumulate instructions
>>>    target/riscv: Add packed SIMD Q-format multiplication instructions
>>>    target/riscv: Add packed SIMD Q-format MAC instructions
>>>    target/riscv: Add packed SIMD two-way MAC instructions
>>>    target/riscv: Add packed SIMD four-way MAC instructions
>>>    target/riscv: Add packed SIMD load-replicate instructions
>>>    target/riscv: Add packed SIMD RV32 only instructions
>>>    target/riscv: Remove Zbkb dependency from P extension to align with
>>>      the spec
>>>
>>>   target/riscv/cpu.c                          |    5 +-
>>>   target/riscv/cpu.h                          |    8 +
>>>   target/riscv/cpu_bits.h                     |    2 +
>>>   target/riscv/helper.h                       |  529 ++++
>>>   target/riscv/insn32.decode                  |  829 +++++
>>>   target/riscv/machine.c                      |   19 +
>>>   target/riscv/tcg/csr.c                      |   39 +-
>>>   target/riscv/tcg/insn_trans/trans_rvb.c.inc |    4 +-
>>>   target/riscv/tcg/insn_trans/trans_rvp.c.inc | 1389 ++++++++
>>>   target/riscv/tcg/meson.build                |    3 +-
>>>   target/riscv/tcg/psimd_helper.c             | 3165 
>>> +++++++++++++++++++
>>>   target/riscv/tcg/tcg-cpu.c                  |   46 +
>>>   target/riscv/tcg/translate.c                |    6 +
>>>   13 files changed, 6038 insertions(+), 6 deletions(-)
>>>   create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
>>>   create mode 100644 target/riscv/tcg/psimd_helper.c
>>>
>>>
>>> base-commit: 8fb307591625731060d399aca42373c02c7cb040
>>> -- 
>>> 2.34.1
>>>
--------------xdSDnJiNy0lJNpbkrVjkFeSb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p class="isSelectedEnd"><font face="Arial"><span>Thanks Daniel，</span><span>Chao
          and Nutty</span><span> for the review.</span></font></p>
    <p class="isSelectedEnd"><font face="Arial"><span>I’ll address these
          issues in v3 by:</span></font></p>
    <ul data-spread="false">
      <li><font face="Arial"><span>adding a descriptive commit body to
            each patch and comments for functions that need further
            explanation;</span></font></li>
      <li><font face="Arial"><span>aligning the continuation backslashes
            in the helper macros;</span></font></li>
      <li><font face="Arial"><span>reusing the existing </span><code
            dir="ltr"><span>EXTRACT*</span></code><span> definitions in
            patch 02/18 instead of introducing duplicate definitions;
            and</span></font></li>
      <li><font face="Arial"><span>investigating the addition of
            P-extension test cases to the QEMU TCG test suite, depending
            on the available toolchain support.</span></font></li>
    </ul>
    <p class="isSelectedEnd"><font face="Arial"><span>I’ll also document
          these changes in the v3 cover letter.</span></font></p>
    <p><font face="Arial"><span>Best regards,</span><br>
        <span>Molly</span></font></p>
    <div class="moz-cite-prefix">在 2026/8/6 2:36, Daniel Henrique
      Barboza 写道:<br>
    </div>
    <blockquote type="cite"
      cite="mid:946b40dd-a2b9-4d10-97f0-8dad261e0570@oss.qualcomm.com">
      <br>
      <br>
      On 7/29/2026 6:32 AM, Chao Liu wrote:
      <br>
      <blockquote type="cite">On Fri, Jul 17, 2026 at 10:06:53AM +0800,
        Molly Chen wrote:
        <br>
        <blockquote type="cite">This series adds support for the RISC-V
          Packed SIMD (P) extension.
          <br>
          <br>
          The P extension defines packed-SIMD fixed-point operations
          intended
          <br>
          for DSP-style workloads such as multimedia and signal
          processing.
          <br>
          These instructions operate on packed subword elements within
          <br>
          general-purpose registers (GPRs).
          <br>
          <br>
          The implementation follows the current development draft of
          the
          <br>
          specification (v0.20):
          <br>
          <br>
             <a class="moz-txt-link-freetext" href="https://github.com/riscv/riscv-p-spec/">https://github.com/riscv/riscv-p-spec/</a>
          <br>
             or
          <br>
             <a class="moz-txt-link-freetext" href="https://www.jhauser.us/RISCV/ext-P/">https://www.jhauser.us/RISCV/ext-P/</a>
          <br>
          <br>
          Compared with v1, this version reduces implementation
          boilerplate by
          <br>
          defining and reusing helper macros for common patterns in
          <br>
          trans_rvp.c.inc and psimd_helper.c. It also consolidates the P
          <br>
          extension prerequisite validation in riscv_cpu_validate_p().
          <br>
          <br>
          The Zbkb dependency has been removed to align the
          implementation with
          <br>
          the current specification. This version also implements the
          <br>
          specification-defined control of vxsat, which was missing from
          v1.
          <br>
          <br>
          All instructions have been functionally tested using the
          following
          <br>
          test suite:
          <br>
          <br>
             <a class="moz-txt-link-freetext" href="https://github.com/mollybuild/qemu-riscv-test-uart">https://github.com/mollybuild/qemu-riscv-test-uart</a>
          <br>
          <br>
          The implementation focuses on functional correctness and ISA
          <br>
          coverage. Performance optimizations were not considered at
          this
          <br>
          stage.
          <br>
          <br>
          Feedback on the implementation details would be highly
          appreciated.
          <br>
          <br>
          Tested with:
          <br>
          <br>
             - ninja -C build test
          <br>
             - make -C build check-qtest-riscv32
          <br>
             - make -C build check-qtest-riscv64
          <br>
             - Functional tests for all P extension instructions using
          <br>
               qemu-riscv-test-uart
          <br>
          <br>
          No regressions or test failures were observed.
          <br>
          <br>
          ---
          <br>
          Changes in v2:
          <br>
          <br>
             - Refactored trans_rvp.c.inc and psimd_helper.c by defining
          and
          <br>
               reusing helper macros for common implementation patterns,
          reducing
          <br>
               boilerplate and overall code size.
          <br>
             - Moved the P extension prerequisite checks into
          <br>
               riscv_cpu_validate_p().
          <br>
             - Removed the Zbkb dependency to align with the current
          <br>
               specification.
          <br>
             - Added the specification-defined vxsat control mechanism,
          which was
          <br>
               missing from v1.
          <br>
          <br>
        </blockquote>
        This patch set is a significant improvement over v1. I think
        there are still
        <br>
        a few common issues we can address together:
        <br>
      </blockquote>
      <br>
      v2 is a huge improvement indeed.  v1 had 11k lines, v2 cut those
      by half due to
      <br>
      the smart use of helpers.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        1. The line break characters '\' in the helper macros we defined
        need to be space-aligned.
        <br>
        2. Every patch is currently missing a commit body.
        <br>
        <br>
        I think these changes are quite necessary.
        <br>
      </blockquote>
      <br>
      Yeah, having a commit message allows us to make fewer guesses when
      reviewing code.
      <br>
      E.g. the usage of __int128t__ macros and the choice of some
      rounding formulas.  We
      <br>
      can make review  assumptions and hope all is fine, but it's not
      ideal.
      <br>
      <br>
      And, as Chao mentioned in his other reply, having test cases will
      be helpful to
      <br>
      assert that everything being added here is sane.  In particular
      with the amount
      <br>
      of lines we're adding here.
      <br>
      <br>
      <br>
      Cheers,
      <br>
      Daniel
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Thanks,
        <br>
        Chao
        <br>
        <blockquote type="cite">v1:
          <br>
            
          <a class="moz-txt-link-freetext" href="https://lists.nongnu.org/archive/html/qemu-riscv/2026-04/msg00301.html">https://lists.nongnu.org/archive/html/qemu-riscv/2026-04/msg00301.html</a>
          <br>
          <br>
          Molly Chen (18):
          <br>
             target/riscv: Add packed SIMD extension state
          <br>
             target/riscv: Add packed SIMD helper framework
          <br>
             target/riscv: Add packed SIMD arithmetic instructions
          <br>
             target/riscv: Add packed SIMD averaging and rounding
          instructions
          <br>
             target/riscv: Add packed SIMD absolute, difference, compare
          and mask
          <br>
               instructions
          <br>
             target/riscv: Add packed SIMD shift instructions
          <br>
             target/riscv: Add packed SIMD exchange instructions
          <br>
             target/riscv: Add packed SIMD horizontal reduction
          instructions
          <br>
             target/riscv: Add packed SIMD pack, merge and count-leading
          <br>
               instructions
          <br>
             target/riscv: Add packed SIMD multiplication instructions
          <br>
             target/riscv: Add packed SIMD multiply-accumulate
          instructions
          <br>
             target/riscv: Add packed SIMD Q-format multiplication
          instructions
          <br>
             target/riscv: Add packed SIMD Q-format MAC instructions
          <br>
             target/riscv: Add packed SIMD two-way MAC instructions
          <br>
             target/riscv: Add packed SIMD four-way MAC instructions
          <br>
             target/riscv: Add packed SIMD load-replicate instructions
          <br>
             target/riscv: Add packed SIMD RV32 only instructions
          <br>
             target/riscv: Remove Zbkb dependency from P extension to
          align with
          <br>
               the spec
          <br>
          <br>
            target/riscv/cpu.c                          |    5 +-
          <br>
            target/riscv/cpu.h                          |    8 +
          <br>
            target/riscv/cpu_bits.h                     |    2 +
          <br>
            target/riscv/helper.h                       |  529 ++++
          <br>
            target/riscv/insn32.decode                  |  829 +++++
          <br>
            target/riscv/machine.c                      |   19 +
          <br>
            target/riscv/tcg/csr.c                      |   39 +-
          <br>
            target/riscv/tcg/insn_trans/trans_rvb.c.inc |    4 +-
          <br>
            target/riscv/tcg/insn_trans/trans_rvp.c.inc | 1389 ++++++++
          <br>
            target/riscv/tcg/meson.build                |    3 +-
          <br>
            target/riscv/tcg/psimd_helper.c             | 3165
          +++++++++++++++++++
          <br>
            target/riscv/tcg/tcg-cpu.c                  |   46 +
          <br>
            target/riscv/tcg/translate.c                |    6 +
          <br>
            13 files changed, 6038 insertions(+), 6 deletions(-)
          <br>
            create mode 100644
          target/riscv/tcg/insn_trans/trans_rvp.c.inc
          <br>
            create mode 100644 target/riscv/tcg/psimd_helper.c
          <br>
          <br>
          <br>
          base-commit: 8fb307591625731060d399aca42373c02c7cb040
          <br>
          -- <br>
          2.34.1
          <br>
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------xdSDnJiNy0lJNpbkrVjkFeSb--


