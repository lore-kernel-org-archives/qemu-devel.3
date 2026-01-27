Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BE4D2F011
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 13:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkiw9-00079Q-MR; Tue, 27 Jan 2026 08:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkivt-000762-I7
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:37 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkivr-0004Zg-L3
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:37 -0500
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-bde0f62464cso1744316a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 05:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769519794; x=1770124594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dZYGTnzRLGmIfUvRgkhix0OnFZFD2aWZ1ZiXl9EQRms=;
 b=WB9pmC78tz7NlxfV9GSIlaF+0Xbup/2RZ4JpBZXdk9sqiceMbepjOtc+LLlpcl82Mz
 0Pdtz8lTnNWscAmn8vjQiQwIRiVquzlofEnU9Cko63yQyOnEGl+GxhtulrvkGxfok0VI
 T08AWv1uQk+jtMDfIIainZyQrqXF7br+YuT2X+3KeqGuRCuszApwICvdjlnYbKexyVlh
 1B+2TWCpU7K+qLEU140cVJv4QuIc2er4Iemj6peMIqm3Ga0POCK9T6rA39Z28NY76mzx
 ITg4lZ0Xjfc36yVt8VtQ4V2HnIpa9RTpjyaLKJn9v0bj5GQRRClqgTpGAmwWKh45vkfZ
 a8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769519794; x=1770124594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZYGTnzRLGmIfUvRgkhix0OnFZFD2aWZ1ZiXl9EQRms=;
 b=lIgSFLm0NAgzMEUo+RxB833PvmOhTKqed35uHCZfawznawsulNamWbLhZC+MxFWk8e
 VWCJbdmOVZsTxZQSIzZdcaR5bMgENC7eFAIFF3rIYPpT5f7M9UllkMPrmcuC9dzdHJz/
 5G7vWZIt0YNnV2GMGoyv5PNRCmQ2b0vg6AALelyG/1J/cyYIUZPjJar+WkfEvj8rOIVz
 qyBAVZHCQINzY8vR7rfCXbRBgW8/Rbj9TpQEQbA185Ei/ADZKZyOAAFGhpMac0szJEsx
 Jyvko6B3rEHlUsuW7mFQ9oNeg47+fi4ujbvbW6NohvqHCoA79ZXPJRKKjcRjx1JW8p7U
 HshA==
X-Gm-Message-State: AOJu0YwviFgqrDLonTvGjQ1yRiRxBYahNWG5iXxFWT7IVvtW2wE6yvXq
 4R4wGcaUWfM4A51wcn7p/S8ltIkmIVUksOWOdW5rE/lv5M9YVg3FVosV
X-Gm-Gg: AZuq6aI9lZH8yvq4zZGXXV5u8kS/BlqjHiy4bRTuUoNg6e7egLXIz3zPFYfRHwHwL8o
 Rxos8OXCfU0Lql9rsR8Ybn4+o1I2tEuinb/+o0nmFORiNc6DnpJQaLUw2k1H2q40p5nEkQ3mD6E
 jXFJN5PUo5Rev17UAYX4sPgOoBlKTNSvgwEoQqETP3HFc6dseFuryS9DeJnjts82iUTHwNcGAiz
 ruIRCsE+6LArWV2k3izTrmJyxXb8yu1vFglqEh37uMiUjuBuL2M4Vf/g8daR8ss2d6UXyafB6EA
 IFVaZV/MBWn0+KSwdQqWldfp7tmboiDfOH4ZtFSeMZdbsCjC6Z3qggqqpjYe2L9iW12q/F2D23I
 c1cQ71azfK/G46mGZ3lFqKYdk7s6Dk4qJ9gkR5iWEohFU1YM6+0RlHu9wGlu49TKNUXJP/ysGqc
 yWfpQHDJrSWpS1+l2x3BJE2FGTIoJxHcukoJ+FoQFX5e+ZCuqsnJYJoqmB3FA=
X-Received: by 2002:a17:903:1a2b:b0:295:9cb5:ae07 with SMTP id
 d9443c01a7336-2a870e34aaemr17130035ad.38.1769519793781; 
 Tue, 27 Jan 2026 05:16:33 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.23.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fb03b4sm117164345ad.82.2026.01.27.05.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 05:16:33 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v3 0/7] riscv: add initial sdext support
Date: Tue, 27 Jan 2026 21:15:44 +0800
Message-ID: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x544.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

Per Daniel's review feedback, this v3 series is based on Alistair's
riscv-to-apply.next branch [3]. It depends on Max Chou's patch
"target/riscv: Use the tb->cs_bqse as the extend tb flags."
(not included in this series; apply it first) [2].

It is based on RISC-V Debug Specification 1.0 [1].

It introduces the sdext/sdtrig config bits, DCSR/DPC/DSCRATCH state,
Debug Mode enter/leave helpers, DRET, EBREAK entry, single-step, and
trigger action=debug mode.

To reduce review load, this series focuses on the Sdext features first.
The Debug Module (DM) and related flows will follow in a later series.

Changes in v3:
- Rebase onto Alistair's riscv-to-apply.next branch.
- Depend on Max Chou's patch "target/riscv: Use the tb->cs_bqse as
  the extend tb flags." (not included; apply it first) [2].
- Patch 2: default sdext to false in riscv_cpu_extensions[].

Changes in v2:
- Drop the RHCT expected AML update from this series.
- Replace the split sdext/sdtrig config bits patch with deprecating the
  'debug' CPU property.
- Rebase and update patch subjects to target/riscv prefix.

Changes in v1:
- Debug Mode entry/exit updates DCSR/DPC and restores execution via DRET.
- EBREAK honors DCSR ebreak bits and enters Debug Mode when enabled.
- Single-step uses DCSR.STEP with a TB flag and a helper at TB exit.
  It references Max Chou's patch "target/riscv: Use the tb->cs_bqse as
  the extend tb flags." [2].
- Sdtrig supports action=debug mode for mcontrol/mcontrol6 and reports
  inst-count triggers in tinfo.

Differences vs Debug Spec (known gaps):
- No Debug Module (no DMI, dmcontrol/dmstatus, haltreq/resumereq).
- No debug ROM, program buffer, abstract commands, or SBA.
- Resume is modeled by leaving Debug Mode at cpu_exec_enter.
- Step/exception ordering is simplified: if the stepped instruction
  traps, the normal exception is taken and Debug Mode is not forced.
- Several DCSR fields are not fully modeled (stopcount/stoptime, etc).

Roadmap (next stage, DM focus):
1) Add a DM core with DMI access and hart state tracking.
2) Implement halt/resume handshake and move Debug Mode transitions
   under DM control.
3) Add debug ROM, program buffer, and abstract commands for GPR/CSR
   and memory access.
4) Add SBA if required by tooling.
5) Tighten ordering rules for step/exception/trigger priorities.


References:
[1] https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
[2] https://lore.kernel.org/qemu-devel/20260108132631.9429-6-max.chou@sifive.com/
[3] https://github.com/alistair23/qemu/tree/riscv-to-apply.next


Thanks,
Chao


Chao Liu (6):
  target/riscv: add sdext debug CSRs state
  target/riscv: add sdext Debug Mode helpers
  target/riscv: add dret instruction
  target/riscv: add sdext enter Debug Mode on ebreak
  target/riscv: add sdext single-step support
  target/riscv: add sdtrig trigger action=debug mode

Daniel Henrique Barboza (1):
  target/riscv: deprecate 'debug' CPU property

 docs/about/deprecated.rst                     |   7 +
 include/exec/translation-block.h              |   4 +-
 target/riscv/cpu.c                            |  61 ++++++++-
 target/riscv/cpu.h                            |   9 ++
 target/riscv/cpu_bits.h                       |  33 +++++
 target/riscv/cpu_cfg_fields.h.inc             |   3 +-
 target/riscv/cpu_helper.c                     |  93 +++++++++++++
 target/riscv/csr.c                            | 128 +++++++++++++++++-
 target/riscv/debug.c                          |  58 +++++++-
 target/riscv/helper.h                         |   3 +
 target/riscv/insn32.decode                    |   1 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  24 +++-
 target/riscv/machine.c                        |  44 ++++--
 target/riscv/op_helper.c                      |  72 ++++++++++
 target/riscv/tcg/tcg-cpu.c                    |  21 ++-
 target/riscv/translate.c                      |  15 +-
 16 files changed, 548 insertions(+), 28 deletions(-)

-- 
2.52.0


