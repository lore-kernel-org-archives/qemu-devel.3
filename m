Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D032C61DE1
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0i0b-000615-E6; Sun, 30 Aug 2026 12:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x0i0Y-00060E-LY
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 12:03:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x0i0W-0007hk-LY
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 12:03:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-851cbd64814so1056328b3a.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788105823; x=1788710623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4/Mt6EYU17EVtqbOmrXe+oIOnepyoTf2cyDH6lrZC1k=;
 b=dG/0lA6uBuotZV+FH4zVPuQNoz8kVWixbzMp7CdaaCF+OMoudGw+FcICL3nmF37u73
 b7SMNqw1GNzGbA364CVj9uQi0hYUOhyCanNlAPsFjEMkCpDkTafWve5mi0tIiobrF3Yd
 c+D/eByurIhozwEa1E4iEM6ua8vnpjlKcT9zHXJ4/dyx+GQ8AKQGCjhIU8aSAPiPs++p
 zyzkV0UGu21LP3l2oQPMPaAHSB6+H/bvMXV1/4QW0tonV/TedNei/jk2BC0QnX2eOpdT
 MrE7gT4duOXQXu13MGg/0eoHgQn21N98NNzDpM1IxWrwIk5EmwGiLMjNmuOZ90Yqd+KQ
 Ac+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788105823; x=1788710623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4/Mt6EYU17EVtqbOmrXe+oIOnepyoTf2cyDH6lrZC1k=;
 b=h5yE8d14VOcMWTOvFGztPJkr2Al+fRnGQjbh9mnnoqB1Zm/JZGN0aR/jf6VX72IAEK
 jXdZeWhF+JOZ9a887C5NO2c5TiNdpArl+/x6Vec+6ty5S3z4QjEmuM8K7hpORdEPWkj1
 WGwlPqSUYjB/Ue5twSIQjUapFqCf8VTSQ36QJIYCZyl9USvipyjD4wyJ/XNvh+8l0ENo
 c1YmvPo6iqUgMre4Cdsagsp+9w/p6QmrDJN52+uVzNhForHx92wwItboYudS3b3CiXkt
 7c2ga80SQi6yowntZUx9NEBqVWGYJ4gMBBVqJhZxS6Xbu5sbjzMLPCPWbEzu+x3tOshA
 JLuQ==
X-Gm-Message-State: AFuF++lK2Il9FqereelkqfBjGRRWU2xinx/u4hCkEpgxBl4suY1Ck0Lj
 V0fLlTjudd4hQ2sVpmjbsCVvqrYtVJ4l1GewGBOKKdewTcXrr1OsUWQaPmKgo2K2kdyF6Lz341b
 qJnJOxFu2fwxmcGjUVt9MYCb8xd3CQVtTBvmLm46jQYyo7kvykjLct4ofHLxKk9Qe1mAd2ZiNdc
 j+Jxxwuu5F2h/wX3mIKl5iX3Rv9wwIod+5oPBhE5AhzA==
X-Gm-Gg: AR+sD13ZHAFFJ3YD6zjxu1LYf/5f+S128LQ8j9FonzBcVTgVxd/u9tnVjjCb9zy2NtM
 vhqL1ZYAylQDrBBSy/FsmVItqMSC3i8tf4ViaTCeUI+HIFAF6LiKgIJLH7F+v0gcxJj3ItOUy7h
 WQEF+WK7xEFd5mSr6DnMZOiBBzMig2w28v2eYNnU9ltDGUbEFBzdfIJLvn6MSjv6LfP7U+OJRRJ
 gHB39VRNCMehzkqMplsAPsJtEoZoqrp+Fh08eMjkWOBPRBqJkpxnkteO2lWrjlqU9xKIfjOpDSF
 oTl+BU0v0V8T4JVBLiz+rN3vKQX1KvqAQy1FUq8nrr0UkUVqK7us0A80NXdTq5tQA4JQynSWCHt
 VSiA0u3qqFcVPdvmotR/1R3A+4bdQfuRVMAoVtK35MWaSYeNq9VXngc4uqY2iBGtZL4eOZCKj+1
 chNsyNqCm5Nr5Q4Bt/cnzaMhVKDg2QD0tQnFb5r4pXWU9U4BIzxBLq6FkjzE1B5M42H2R57YsBQ
 FquUHsnBvaqeVODaPoG5f38lebZrk0vuCM0f4JMTBAONeXEyFTk4l17VIWxAKE=
X-Received: by 2002:a05:6a00:130d:b0:857:73e2:9104 with SMTP id
 d2e1a72fcca58-85773e292ffmr16842355b3a.20.1788105822524; 
 Sun, 30 Aug 2026 09:03:42 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8569ff701d5sm2455900b3a.25.2026.08.30.09.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:03:42 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Chou <max.chou@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v3 0/6] target/riscv: Add SiFive Xsfvqmaccdod/Xsfvqmaccqoq
 int8 matmul extensions
Date: Mon, 31 Aug 2026 00:03:29 +0800
Message-ID: <20260830160335.3441069-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x430.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset adds SiFive's custom int8 matrix-multiply vector
extensions Xsfvqmaccdod and Xsfvqmaccqoq. Each extension provides 4
signedness variants (unsigned/unsigned, signed/signed,
unsigned/signed, signed/unsigned) for a total of 8 instructions:
sf.vqmacc{u,,us,su}.{4x8x4,2x8x2}.

The toolchains support Xsfvqmaccdod/Xsfvqmaccqoq extensions:
 - LLVM 18.1.0
   - llvm/llvm-project#68295, commit d1985e3d1fed, merged 2023-10-20.
   https://github.com/llvm/llvm-project/pull/68295
 - GCC 15
   - commit 139bd3198a73 ("RISC-V: Add the mini support for SiFive extensions"), 2024-11-17.

References:
 - SiFive Int8 Matrix Multiplication Extensions Specification
   https://www.sifive.com/document-file/sifive-int8-matrix-multiplication-extensions-specification

Changes since v2:<20260812174417.2468981-1-max.chou@sifive.com>
 - Rebase to riscv-to-apply.next branch (commit aee18ec)
 - Modified patch 5 to align the new disas flow

Changes since v1:<20260721122034.1567146-1-max.chou@sifive.com>
 - Rebase to master branch (commit 84f0721)
 - Reformat riscv_multi_ext_implied_rules to list one rule per
   line before adding XSFVQMACCDOD_IMPLIED/XSFVQMACCQOQ_IMPLIED, so
   future additions to the array are a pure append instead of
   reflowing whatever line they land on. Split out into its own
   patch. (Thanks for Daniel Henrique Barboza's suggestion)
 - Move the SiFive int8 matmul helper out of the shared
   vector_helper.c and into a new target/riscv/tcg/xsf_helper.c,
   so vendor-specific code no longer lives in common vector-helper
   code. (Thanks for Daniel Henrique Barboza's suggestion)

rnax

Frank Chang (2):
  target/riscv/cpu: Add SiFive custom int8 matmul extension implied
    rules
  target/riscv: rvv: Add SiFive custom int8 matmul instructions

Jason Chien (1):
  disas/riscv: Add disassembler support for Xsfvqmaccdod/Xsfvqmaccqoq

Max Chou (3):
  target/riscv: Add cfg property for SiFive int8 matmul extensions
  target/riscv/cpu: List one implied-ext rule per line
  tests/tcg/riscv64: Add tests for SiFive int8 matmul extensions

 MAINTAINERS                                 |  10 +
 disas/meson.build                           |   3 +-
 disas/riscv-xsf-op.c.inc                    |  11 +
 disas/riscv-xsf.c                           |  49 ++++
 disas/riscv-xsf.h                           |  16 ++
 disas/riscv.c                               |   2 +
 disas/riscv.h                               |   1 +
 target/riscv/cpu.c                          |  80 ++++--
 target/riscv/cpu_cfg.h                      |   5 +
 target/riscv/cpu_cfg_fields.h.inc           |   2 +
 target/riscv/helper.h                       |  10 +
 target/riscv/meson.build                    |   1 +
 target/riscv/tcg/insn_trans/trans_xsf.c.inc |  98 ++++++++
 target/riscv/tcg/meson.build                |   1 +
 target/riscv/tcg/tcg-cpu.c                  |  16 ++
 target/riscv/tcg/translate.c                |   3 +
 target/riscv/tcg/xsf_helper.c               |  87 +++++++
 target/riscv/xsf.decode                     |  30 +++
 tests/tcg/riscv64/Makefile.softmmu-target   |   7 +
 tests/tcg/riscv64/test-xsfvqmacc.S          | 260 ++++++++++++++++++++
 20 files changed, 677 insertions(+), 15 deletions(-)
 create mode 100644 disas/riscv-xsf-op.c.inc
 create mode 100644 disas/riscv-xsf.c
 create mode 100644 disas/riscv-xsf.h
 create mode 100644 target/riscv/tcg/insn_trans/trans_xsf.c.inc
 create mode 100644 target/riscv/tcg/xsf_helper.c
 create mode 100644 target/riscv/xsf.decode
 create mode 100644 tests/tcg/riscv64/test-xsfvqmacc.S

-- 
2.43.0


