Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D23606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBIE-0001mI-MA; Fri, 23 Oct 2026 05:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xKBIB-0001kT-4q; Fri, 23 Oct 2026 05:10:27 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xKBI7-0005Gm-Ls; Fri, 23 Oct 2026 05:10:26 -0400
Received: from [10.213.18.251] (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowADH0kByJNtqEsCBCw--.51266S3;
 Fri, 23 Oct 2026 17:10:11 +0800 (CST)
Message-ID: <28033024-7e39-4a29-8e59-82150130954e@iscas.ac.cn>
Date: Fri, 23 Oct 2026 17:10:10 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] target/riscv: Add support for RISC-V P extension
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Yin Zhang <zhangyin2018@iscas.ac.cn>,
 Dajun Huang <djhuang_1@std.uestc.edu.cn>,
 Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
From: MOLLY CHEN <xiaoou@iscas.ac.cn>
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: rQCowADH0kByJNtqEsCBCw--.51266S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4xur4kWr1kJF17XFy5Arb_yoWfGry3pF
 4fG3yYk398tFWxtw1xJw4kCw15WF4rGa15Aw1xXw10vwsxtryftFnrK3y5KF98JF1kW342
 93ZF9r15uF4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVWxJr0_Gc
 WlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7IU8kwI3UUUUU==
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.81; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.99,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

Gentle ping on the v3 series. Any review or feedback would be much
appreciated.

A quick update on the P extension: the Task Group approved the
Development Milestone on September 28, 2026, and the specification
version has been updated to v0.6. This version includes a minor change
to the semantics of psshlr.*, which I will incorporate into the next
revision of this series.

In the meantime, feedback on the current v3 would be very helpful.

v3: https://lists.nongnu.org/archive/html/qemu-riscv/2026-09/msg00523.html

Thanks!

On 2026/9/16 15:07, Molly Chen wrote:
> This series adds support for the RISC-V Packed SIMD (P) extension for
> RV32 and RV64.
>
> The P extension defines packed-SIMD fixed-point operations intended for
> DSP workloads such as multimedia and signal processing. These
> instructions operate on packed subword elements in general-purpose
> registers, with register-pair forms for wider operands on RV32.
>
> The implementation targets the V0.21 development draft of the RISC-V P
> extension specification:
>
>    https://github.com/riscv/riscv-p-spec
>
> The local riscv-p-spec reference checkout is at commit:
>
>    71b78d2c8d1d41cc01a036d75dc001920b8ac22e
>
> P support is enabled with the experimental x-p CPU property. The series
> includes instruction decoding and translation, helpers, extension-state
> handling, and the specification-defined control of vxsat. The focus
> remains functional correctness and instruction coverage; performance
> optimization is left for future work.
>
> This revision adds in-tree TCG tests for RV32 and RV64 and addresses the
> review feedback on helper reuse, register overlap, shift semantics, and
> code readability. It also fixes additional issues found while testing,
> including zero register-pair handling and RV64 SHLR rounding.
>
> Thanks to Daniel Henrique Barboza, Nutty Liu, Chao Liu, and Max Chou for
> their reviews and suggestions.
>
> Changes in v3:
>
>    - Add descriptive commit messages explaining the purpose and behavior
>      of the patches, and document helper macro definitions, including
>      their interfaces and arithmetic semantics.
>
>    - Add RV32 and RV64 assembly tests under tests/tcg/riscv, with shared
>      test macros and integration into the TCG test Makefiles. Cover
>      arithmetic, shifts, multiplication, narrowing, saturation, register
>      overlap, and zero register-pair operands. The tests are freestanding
>      Linux-user programs and do not require a target libc. Set PSIMD_CC
>      to a P-capable Clang to build them; the assembler options use
>      rv32gp0p21 and rv64gp0p21. Enable previously disabled tests using the
>      P v0.21 mnemonics and update signed saturation immediate operands.
>
>    - Correct register-controlled packed byte and halfword shifts to use
>      the low five bits of rs2. Share the signed saturating/rounding shift
>      implementation between scalar and packed forms: psshar_hs,
>      psshar_ws, and sshar are all generated by GEN_PSIMD_VAR_SSHAR.
>      Return zero for oversized SSHAR/SHAR right shifts, and widen
>      rounding arithmetic before adding the rounding bit.
>
>    - Clamp unsigned rounding right shifts to the element width so that
>      the source MSB still participates in rounding for oversized shifts.
>      Apply this to PSSHLR/SSHLR and RV64 SHLR. Use a wider intermediate
>      for SHLR to preserve the carry when rounding UINT64_MAX right by
>      one bit, and add regression tests for these cases.
>
>    - Fix RV32 register-pair operations when the destination overlaps
>      the scalar source by completing both results before writeback.
>      Treat a zero register-pair selector as {x0, x0}, suppress both
>      destination writes for a zero pair, and preserve vxsat side effects.
>      Use tcg_gen_movi_i64() to initialize a zero source in narrowing
>      translations, with a dedicated regression test.
>
>    - Avoid undefined behavior in helper arithmetic by using unsigned
>      operations where wraparound is intended and wider intermediates
>      where needed. Handle oversized left shifts explicitly and handle
>      zero shifts in SLX/SRX without shifting by the operand width.
>
>    - Correct the RV32 REV encoding, reject unavailable translations
>      instead of accepting them without an operation, and fix lane
>      selection in PMQWACC.H and PMQRWACC.H.
>
>    - Reuse qemu/bitops.h extract64() for lane extraction, correct
>      misleading helper comments, and align macro continuation characters.
>
> Testing:
>
>    The P extension TCG tests were built with LLVM/Clang 24.0.0git
>    (/opt/llvm/bin/clang), llvm-project commit:
>
>      96295a1412f9afbee9d4a3c2701e83f5a529a9cc
>
>    Built qemu-riscv32, qemu-riscv64, qemu-system-riscv32, and
>    qemu-system-riscv64 successfully. Both P extension TCG suites pass
>    with the new regression cases:
>
>      make -C build/tests/tcg/riscv32-linux-user \
>          PSIMD_CC=/opt/llvm/bin/clang run-psimd-rv32
>      make -C build/tests/tcg/riscv64-linux-user \
>          PSIMD_CC=/opt/llvm/bin/clang run-psimd-rv64
>
>    The test targets enable x-p, zmmul, zba, and zbb on the corresponding
>    rv32 or rv64 CPU. The P-aware compiler path is configurable through
>    PSIMD_CC.
>
> Changes in v2:
>
>    - Refactored translation and helper code using macros for common
>      implementation patterns.
>    - Consolidated P extension prerequisite checks in
>      riscv_cpu_validate_p().
>    - Removed the Zbkb dependency to match the specification.
>    - Added the specification-defined vxsat control mechanism.
>
> Previous versions:
>
>    v2: https://lists.nongnu.org/archive/html/qemu-riscv/2026-07/msg00697.html
>    v1: https://lists.nongnu.org/archive/html/qemu-riscv/2026-04/msg00301.html
>
> Feedback on the implementation and tests would be appreciated.
>
> Co-authored-by: Yin Zhang <zhangyin2018@iscas.ac.cn>
> Co-authored-by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
> Co-authored-by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
>
> Molly Chen (19):
>    target/riscv: Add packed SIMD extension state
>    target/riscv: Add packed SIMD helper framework
>    target/riscv: Add packed SIMD arithmetic instructions
>    target/riscv: Add packed SIMD averaging and rounding instructions
>    target/riscv: Add packed SIMD absolute, difference, compare and mask
>      instructions
>    target/riscv: Add packed SIMD shift instructions
>    target/riscv: Add packed SIMD exchange instructions
>    target/riscv: Add packed SIMD horizontal reduction instructions
>    target/riscv: Add packed SIMD pack, merge and count-leading
>      instructions
>    target/riscv: Add packed SIMD pure multiplication instructions
>    target/riscv: Add packed SIMD multiply-accumulate instructions
>    target/riscv: Add packed SIMD Q-format multiplication instructions
>    target/riscv: Add packed SIMD Q-format MAC instructions
>    target/riscv: Add packed SIMD two-way multiply-add/subtract
>      instructions
>    target/riscv: Add packed SIMD four-way multiply-add instructions
>    target/riscv: Add packed SIMD load-replicate instructions
>    target/riscv: Add packed SIMD RV32 only instructions
>    target/riscv: Remove Zbkb dependency from P extension to align with
>      the spec
>    tests/tcg/riscv: Add tests for the P extension
>
>   target/riscv/cpu.c                          |    5 +-
>   target/riscv/cpu.h                          |    8 +
>   target/riscv/cpu_bits.h                     |    2 +
>   target/riscv/helper.h                       |  529 +++
>   target/riscv/insn32.decode                  |  830 +++++
>   target/riscv/machine.c                      |   19 +
>   target/riscv/tcg/csr.c                      |   39 +-
>   target/riscv/tcg/insn_trans/trans_rvb.c.inc |    4 +-
>   target/riscv/tcg/insn_trans/trans_rvp.c.inc | 1439 ++++++++
>   target/riscv/tcg/meson.build                |    3 +-
>   target/riscv/tcg/psimd_helper.c             | 3536 +++++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c                  |   46 +
>   target/riscv/tcg/translate.c                |    6 +
>   tests/tcg/riscv/psimd-common.S              | 1105 ++++++
>   tests/tcg/riscv/psimd-rv32.S                | 1256 +++++++
>   tests/tcg/riscv/psimd-rv64.S                |  578 +++
>   tests/tcg/riscv/psimd-test-macros.inc       |  952 +++++
>   tests/tcg/riscv32/Makefile.target           |   30 +
>   tests/tcg/riscv64/Makefile.target           |   25 +
>   19 files changed, 10406 insertions(+), 6 deletions(-)
>   create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
>   create mode 100644 target/riscv/tcg/psimd_helper.c
>   create mode 100644 tests/tcg/riscv/psimd-common.S
>   create mode 100644 tests/tcg/riscv/psimd-rv32.S
>   create mode 100644 tests/tcg/riscv/psimd-rv64.S
>   create mode 100644 tests/tcg/riscv/psimd-test-macros.inc
>   create mode 100644 tests/tcg/riscv32/Makefile.target
>
>
> base-commit: b23a62773a7856299cbb3782e64968b6a92c792f


