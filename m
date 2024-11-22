Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FE3E65D1A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 03:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEKFe-0005Ul-HY; Thu, 21 Nov 2024 22:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tEKFc-0005Tj-Mx
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 22:22:32 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tEKFZ-0003wD-Su
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 22:22:32 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2127d4140bbso16632785ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 19:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732245747; x=1732850547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EqGUZFMKnXg48isQyCiYKdw06RIckx04IVJaXazND74=;
 b=KUcQA6U+VL0a2R9idVNCYa+BFO4QLpegczsDU8el/NrU21VYq+bVz6WzAacJyFkSTM
 CtuRfoN/8o66UCpI47MBwXWbQDoWxa2n+ZSfnb9bQQQBoRVJIB+GzusjnSVRLa1wFvtO
 /K+7Szb78GfYIv+OKXVyDpGn/mjloJY6dQnZJAWsZMAKrHH2C3XAE+IIZQKdz3VihjRi
 sU620GWiK2Ik77hIMBtHI8ZqrA0zrO1JGtxQi5nYAMmqE1qaARkxvsNNwjZgAZmD0kQK
 zu6/QetBOk09wZygxKrBg1I8I6dM0ohM45YOP/McEi9Olb2YE1rFwCLfCyg4eRlghs+l
 A/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732245747; x=1732850547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EqGUZFMKnXg48isQyCiYKdw06RIckx04IVJaXazND74=;
 b=lYLVd3sw0OuHM6Odrzx2huVT6MWibvA6uv/6FBpTdXoUTur0MR6dSq9RtV2n35rkLs
 BJVvAPtktQx88sN3mtlUayPAPydflwLHXUgKvrEZEzkpVKutdZK3r9h8FBr+0aWHbTva
 muvXnR1D40y1xb4k1/QtAk8KNV5HyOOUlQvFIOzWM60Dd7ui9j6WsJTJ2v8gD3of97O9
 3goV4z8CpIZGzGQr0aaoUDmIdluSsA8atl9nx6yr3dL/gn93U7SVuwL8M0Q7rfdTDRu5
 K5uy5v7XSy5wF4YqC+90cwgrQcSfw6p6xp4KJn9kchdUnWz46KWIrmuTSqygRRsW9j6Q
 0E7g==
X-Gm-Message-State: AOJu0YzyE9z+qBWVMzeG7uZXl6+X57TGmUKidIk0DsJNVXaZ5zpMnd7X
 ecB+9hhClpFMaFCknrNTS8vCtZHCtO+r17jsAvOe5BThcLqwpRoB9PxuRcSgUh9crzyyn4WZCNt
 Z7WhKge7NSbPF1+oo/pOp3862v5CmaoACmOGQt0Vah94xfUqSDBTwWXN67+Rmt1Yd4lxjbOvWb6
 WPdCVj3FzQcB7VPx6dle7aI6vx5AXtbXiByENAjXcPE7BDJ8Q=
X-Gm-Gg: ASbGncuEUatXwWITn6gEZw84xaO3BlHrB2aGqFdioAceyc+AQKxOqOiXfFj4XcOWEnZ
 Y08CSgHTt8M/gj4j8vu17++bkACySQ5tIffMWAssaBj1BWvNxEZx//42tRuwABq1LB6T0wBGlpb
 kyacJbs/U0SlNF2xxkIBDPhfJpdLgccZzpxjTfDVHCQzm2BJLeSmss0RJuhW1zb0nyhENsKiqL7
 9Ev+mpJ644q2PQ51L+Ld/BaJGSDgAFcA79Bw/5UNFnBwkl+xWVKvaECnW/bZBVTm0Yg/O17NPUS
 /L6xVw==
X-Google-Smtp-Source: AGHT+IG6SudNZuhLg/Q5+si52StkfH8YKeMLS49GYTq7AspHcLFCxfbMYo5IXkUsHxdJofXlcvz3Jw==
X-Received: by 2002:a17:902:cecd:b0:212:6011:5967 with SMTP id
 d9443c01a7336-2129f2208c9mr17405305ad.3.1732245746890; 
 Thu, 21 Nov 2024 19:22:26 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([136.226.240.187])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc157f3sm5506905ad.203.2024.11.21.19.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 19:22:26 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v9 0/6] Add Smrnmi support
Date: Fri, 22 Nov 2024 11:22:11 +0800
Message-Id: <20241122032217.3816540-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

This patchset added support for Smrnmi Extension in RISC-V.

There are four new CSRs and one new instruction added to allow NMI to be
resumable in RISC-V, which are:

=============================================================
  * mnscratch (0x740)
  * mnepc     (0x741)
  * mncause   (0x742)
  * mnstatus  (0x744)
=============================================================
  * mnret: To return from RNMI interrupt/exception handler.
=============================================================

RNMI also has higher priority than any other interrupts or exceptions
and cannot be disabled by software.

RNMI may be used to route to other devices such as Bus Error Unit or
Watchdog Timer in the future.

The interrupt/exception trap handler addresses of RNMI are
implementation defined.

If anyone wants to test the patches, we can use the customized OpenSBI[1],
and the customized QEMU[2].

We implemented a PoC RNMI trap handler in the customized OpenSBI.
In the customized QEMU, we use the Smrnmi patches and the patch from
Damien Hedde[3]. The patch from Damien Hedde can be used to inject
the RNMI signal with the qmp command.

[1] https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/twu/master
[2] https://github.com/sifive/qemu/tree/upstream-smrnmi-v8
[3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html

Test commands :
$ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=true,
rnmi-interrupt-vector={Offset of the RNMI handler in the customized
OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
-bios fw_jump.elf -kernel Image -initrd rootfs.cpio
-qmp unix:/tmp/qmp-sock,server,wait=off

Use qmp command to inject the RNMI.

Assert RNMI:
$ ./scripts/qmp/qmp-shell /tmp/qmp-sock
(QEMU) gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi number=0 value=true

De-assert RNMI:
(QEMU) gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi number=0 value=false

Changelog:

v9
  * Add Zicfilp support for Smrnmi.
  * Change the existence checks for 'rnmi-interrupt-vector' and
    'rnmi-exception-vector' to use 'num_rnmi_irqvec' and 'num_rnmi_excpvec'.
  * Add warn_once messages for cases where the user sets
    'rnmi-interrupt-vector' or 'rnmi-exception-vector' property without
    enabling Smrnmi.

v8
  * Set virt to false when trapping to M-mode by RNMI.
  (Thanks to Clément for the suggestions.)

v7
  * Rename 'nmi_execp' to 'nnmi_excep' and refactor RNMI exception
    checking codes.
  (Thanks to Clément for the suggestions.)
  * Add the missing REQUIRE_SMRNMI() check and remove the redundant
    check in 'helper_mnret'.
  * Rebase to riscv-to-apply.next.
  (Thanks to Alistair for the suggestions.)

v6
  * Delete the redundant code in 'riscv_cpu_do_interrupt'.
  (Thank Alvin for the suggestion.)
  * Split the shared code in 'helper_mret' and 'helper_mnret' into a
    helper function 'check_ret_from_m_mode'.
  (Thank Alistair for the suggestion.)

v5
  * Move the patch that adds the Smrnmi extension to the last patch.
  (Thank Alistair for the suggestion.)
  * Implement an M-mode software PoC for this with implemented handlers.
  (Thank Andrew Jones for the suggestion.)
  * Add a commit message to all patches of the series.
  (Thank Andrew Jones for the suggestion.)

v4
  * Fix some coding style issues.
  (Thank Daniel for the suggestions.)

v3
  * Update to the newest version of Smrnmi extension specification.

v2
  * split up the series into more commits for convenience of review.
  * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.

Frank Chang (1):
  target/riscv: Add Zicfilp support for Smrnmi

Tommy Wu (5):
  target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
  target/riscv: Add Smrnmi CSRs
  target/riscv: Handle Smrnmi interrupt and exception
  target/riscv: Add Smrnmi mnret instruction
  target/riscv: Add Smrnmi cpu extension

 hw/riscv/riscv_hart.c                         | 40 ++++++++
 include/hw/riscv/riscv_hart.h                 |  4 +
 target/riscv/cpu.c                            | 18 ++++
 target/riscv/cpu.h                            | 10 ++
 target/riscv/cpu_bits.h                       | 24 +++++
 target/riscv/cpu_cfg.h                        |  1 +
 target/riscv/cpu_helper.c                     | 96 +++++++++++++++++--
 target/riscv/csr.c                            | 82 ++++++++++++++++
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 20 ++++
 target/riscv/op_helper.c                      | 54 ++++++++++-
 12 files changed, 342 insertions(+), 11 deletions(-)

--
2.34.1


