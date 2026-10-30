Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC6B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tYQ/RORs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrlg-0006r9-H2; Fri, 30 Oct 2026 14:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrle-0006qj-0S
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:55:58 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlc-0004my-2r
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:55:57 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ae8607e8afso8575317b3.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386554; x=1793991354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b+dyZh3nWhn3PzXeoVoq/od08oqffbGETGqByB6O6I0=;
 b=tYQ/RORsjrcXNgFc0krv1Ro9l9/Es8Fe/H2/4Tu4Ve4ozDKb8CbfjtpnHBnnlUXAEh
 w9omnZ2uFlEC6VZOppDkERJdew3OlWX6BSxcQp3a2qtlyvzVylyQCYPKnhJa2V2EqxWx
 hwVnmuYNCK4JYOl3aVmgnO7nSG//kr5LR+j3dQfGsHEIgNMzN8dDEv2PunDAHzW34nYt
 3UVSqUWXAq5gJTfTpe8KZq9MPiEcH15ipv65I1h/Up2GkBBlkjfx/UXO0QyeIeHCE+e/
 ZbNP/Z5GWK9GlD139RAnHWcaEiJU9zDB1tc1Qj0/47D9lUA1XKzPLk/OFIp92HLacEvM
 1GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386554; x=1793991354;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b+dyZh3nWhn3PzXeoVoq/od08oqffbGETGqByB6O6I0=;
 b=k93cSFJT7/m72G0gRjTqw+5OFGwNOXDzx+GgIWIGXp4vbbNd/hcV2DgBEOeEkPN/LW
 o94Eu62Y58+Ye7IjKx86mLhGLP5+E8d0pFUySa4Qd2ue47paEZXMm3hdHihAvdFBvJ3e
 hl8yQOweYg9J+dDDEjI7lVBZ8teqx9Qf2OWE5u4PE3kWGofIDB4YTmq0UO9hhOUUIaex
 hU6wM2nG++9rUphK8HBOvox6RnyhlTiLOWaB7ds45GkPz3Pqsx4UElm2mgsSBsfH6Iho
 xuAqaPxQZ4YWm/by5Ntovb0fDmcndJkzaZzl17Urj6TWxY7EjEqvUy86eZnuY5lJekWI
 xhsg==
X-Gm-Message-State: AFq9FYJpOS+tncukiDaiaCOwWz/opdF1sCWARoPlrzv+mzvJCVSaCbgr
 I2Cl+fDkBQeS3IROU/BOCncrbhZVV1AwF2G7jpfBH9zOAazQnIdee8kLBPZ5Zew+SgI1mEX2Pzn
 h1onU
X-Gm-Gg: AYBFou26iIMQLm7PWyu2WUYSYKmuztBEkBCF4mc7h77fCPwraM5i70W4G5bvzgDY3Ja
 8JR0zOtZl2Cvh+tJAgRqdb6pDIz3MBPWj3c/6C80RpuyeG9hP+oo3pFhyMcJ9E98SL8r3Tuq3AA
 0zkLZVaoLOBlO7ZRf7jfl0G4YGqzOgU1XfztxVF6XfFV1zF1VO095x5JTc3ELfXOJQUWXsv3xv5
 IpJ5LMRz07k5sD8gEUA7H5MYyiq41ewNH2QnTZVF7juQp8ZCEQL+S0/GRhLyH0Sr4Kb1ZwRScwy
 5LU5jxEHTFPbfzLtE6F59VwKjAGtzBsH15DnWgicD+JA+ybrT8BeonDmr1pt5flsBkRu72v7HkZ
 wWxTNQHGgvEVIff0iOAtTR/Xe1q9CREQ12KxlPcbOHDWvfqSP+4rT6hx+IHJ+we/kzSaNc6uVuo
 FiEj3hvsunttwx5Un/aKL/BMqx2T0sZQzWlmNKWZA+3zVMQMHxQUn+gZQ5XEZDIm7+luakT8lds
 0epls8AigMKquKIhNfNVvgLBlcYKmqpmE69JE2CPBIx3MtZRQthFJaME5Ys3Y/GQblAT9NAtHh+
 wkw4HLp/W+oVlcmBY2K2rW6n/aUJcn+9qxY=
X-Received: by 2002:a05:690c:698a:b0:8ab:3dc2:a4d7 with SMTP id
 00721157ae682-8b2b66da14dmr18438497b3.22.1793386554126; 
 Fri, 30 Oct 2026 11:55:54 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:55:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 00/14] accel/tcg: cut per-block dispatch overhead (parts
 4-6)
Date: Fri, 30 Oct 2026 13:55:37 -0500
Message-ID: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Splitting Matt's larger patch set:

> 4  tcg: add tcg_gen_goto_jc_{i32,i64,tl}()
>
>    Preparation. A second dispatch interface alongside
>    tcg_gen_lookup_and_goto_ptr(), which is unchanged. The caller passes
>    the destination PC and thereby states that the CPU state is already
>    the destination's, which is what an inline lookup needs and what the
>    existing interface cannot promise. --enable-debug-tcg checks that
>    claim at runtime. Five targets are migrated; every other target and
>    every unmigrated call site is untouched.
>
> 5  accel/tcg: add CF_NO_GOTO_JC, set while a breakpoint is present
>
>    Preparation. The one thing an inline jump cache probe cannot check is
>    breakpoints, and it does not have to: the probe compares cflags, so a
>    cflag set while cpu->breakpoints is non-empty keeps such blocks both
>    from dispatching inline and from being reached by a block that does.
>    Nothing reads it yet.
>
> 6  RFC: tcg: probe the TB jump cache inline instead of calling a helper
>
>    95.8% of those 8.4 billion helper_lookup_tb_ptr() calls hit the jump
>    cache. Emit the probe inline (hash, four guarded loads, goto_ptr) and
>    call the helper only on a miss.                   -34.67%, -25.94% wall

Changes for v7:
  * All prerequisites merged.
  * Use the current TB data for complex comparisons, when possible.

  x86_64 sample:

	49 3b 5c 24 18           cmpq     0x18(%r12), %rbx
	75 25                    jne      1f
	4d 8b 64 24 10           movq     0x10(%r12), %r12
	4d 85 e4                 testq    %r12, %r12
	74 1b                    je       1f
	49 83 7c 24 08 00        cmpq     $0, 8(%r12)
	75 13                    jne      1f
	49 8b 44 24 10           movq     0x10(%r12), %rax
	48 3b 05 3f fe ff ff     cmpq     -0x1c1(%rip), %rax	# tb->flags
	75 05                    jne      1f
	41 ff 64 24 18           jmpq     *0x18(%r12)
    1:

  aarch64 sample:
	a94142b5  ldp      x21, x16, [x21, #0x10]
	f10002bf  cmp      x21, #0
	fa541200  ccmp     x16, x20, #0, ne
	54000101  b.ne     1f
	a940c6b0  ldp      x16, x17, [x21, #8]
	f9400eb5  ldr      x21, [x21, #0x18]
	58fff41e  ldr      x30, 0xe4c32c000210	# tb->flags
	eb1e023f  cmp      x17, x30
	fa400a00  ccmp     x16, #0, #0, eq
	54000041  b.ne     1f
	d61f02a0  br       x21
    1:

  s390x sample:

	eb12 c010 0004  lmg      %r1, %r2, 0x10(%r12)
	ec2d 0012 6064  cgrjlh   %r2, %r13, 1f
	ec18 000f 007c  cgije    %r1, 0, 1f
	eb02 1008 0004  lmg      %r0, %r2, 8(%r1)
	ec06 0009 007c  cgijlh   %r0, 0, 1f
	c618 ffff fef6  cgrl     %r1, 0x3ff18000310	# tb->flags
	a764 0003       jlh      1f
	07f2            br       %r2
    1:


Changes for v6:
  * Split target patches from infrastructure patches.

  * Use tcg-op.c rewrite infrastructure.

  * Add tcg_gen_goto_jc3_*, for the guest to pass all 3 values.

  * Fix bugs in target/

    - alpha: Missed several system-mode points at which
      we cannot use goto_jc (mtpr ps, mtpr fen, halt), and one
      where we cannot use goto_jc, but can use goto_jc3 (call_pal).

    - loongarch: Only use goto_jc for branches.  There are several
      other corner cases lurking in the priviledged insns, and
      they can't be as important as branches.

    - mips: Droped everything.  I expect that this could be made
      to work using goto_jc3, but all of the tb->flags frobbing
      related to delayed branches needs some thought.

    - s390x: Only use jc for branches.  There are several other
      corner cases with SACF and SAM insns.  EX emulation requires
      special treatment: always use goto_jc3 so that we only look
      for TBs with ex_value == 0.

  * Use tcg_gen_lea in gen_jc_probe.

  * Add goto_jc opcode.


r~


Matt Turner (5):
  tcg: add tcg_gen_goto_jc{3}_{i32,i64,tl}
  target/loongarch: Use tcg_gen_goto_jc_tl for JIRL
  target/ppc: Use tcg_gen_goto_jc_tl
  accel/tcg: add CF_NO_GOTO_JC, set while a breakpoint is present
  tcg: Probe the TB jump cache inline instead of calling a helper

Richard Henderson (9):
  target/alpha: Use tcg_gen_goto_jc{3}_i64
  target/s390x/tcg: Remove DISAS_PC_UPDATED
  target/s390x/tcg: Use tcg_gen_goto_jc3_i64 for branches
  include/exec: Move tc within TranslationBlock
  tcg: Add INDEX_op_goto_jc
  tcg/x86_64: Implement INDEX_op_goto_jc
  tcg/aarch64: Implement INDEX_op_goto_jc
  tcg/s390x: Implement INDEX_op_goto_jc
  accel/tcg: Move tb_jmp_cache to CPUNegativeOffsetState

 docs/devel/tcg-ops.rst                        |  11 ++
 accel/tcg/tcg-runtime.h                       |   4 +
 include/exec/translation-block.h              |   9 +-
 include/hw/core/cpu.h                         |   4 +-
 include/tcg/tcg-op-common.h                   |  29 +++
 include/tcg/tcg-op.h                          |   4 +
 include/tcg/tcg-opc.h                         |   1 +
 tcg/aarch64/tcg-target-con-set.h              |   1 +
 tcg/s390x/tcg-target-con-set.h                |   1 +
 tcg/s390x/tcg-target-con-str.h                |   1 +
 tcg/tcg-internal.h                            |  10 ++
 include/tcg/tcg-op-def.h.inc                  |   2 +
 accel/tcg/cpu-exec-common.c                   |  13 +-
 accel/tcg/cpu-exec.c                          |  37 +++-
 accel/tcg/cputlb.c                            |   2 +-
 accel/tcg/tb-maint.c                          |   2 +-
 accel/tcg/translate-all.c                     |   2 +-
 cpu-common.c                                  |  27 ++-
 target/alpha/translate.c                      |  60 ++++---
 target/loongarch/tcg/translate.c              |   2 +-
 target/ppc/translate.c                        |   4 +-
 target/s390x/tcg/translate.c                  |  32 ++--
 tcg/tcg-op.c                                  | 167 +++++++++++++++++-
 tcg/tcg.c                                     |  23 +++
 .../tcg/insn_trans/trans_branch.c.inc         |   2 +-
 tcg/aarch64/tcg-target.c.inc                  | 131 +++++++++++++-
 tcg/loongarch64/tcg-target.c.inc              |   4 +
 tcg/ppc64/tcg-target.c.inc                    |   4 +
 tcg/riscv64/tcg-target.c.inc                  |   4 +
 tcg/s390x/tcg-target.c.inc                    |  62 +++++++
 tcg/sparc64/tcg-target.c.inc                  |   4 +
 tcg/tci/tcg-target.c.inc                      |   4 +
 tcg/x86_64/tcg-target.c.inc                   |  79 +++++++++
 33 files changed, 667 insertions(+), 75 deletions(-)

-- 
2.53.0


