Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9AAD3C92F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 03:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2iiK-0004yy-Hr; Sun, 20 Oct 2024 23:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t2iiI-0004yO-Lk
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 23:04:10 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t2iiG-00074K-9x
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 23:04:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso34932465ad.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 20:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1729479846; x=1730084646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pyUTLQMOJqvJ/1N82Aa9U8f7yiqvRAf4+5QUW6gIySY=;
 b=nU7V7KLV5TftPM8hVxm+4/6oSJXYQyJjkcWp38WA07ZFFjxLT5TEC4OgUgdEPlO+9x
 HOu5ikClFZU2deYsL3R0M4AEXmh/Pju+XqX39d3/S4e52KhdUx80hb+3fMMQK8bzoP7s
 PRwVLepAPe3Wbe5/5H73w3xyv57LuPO/of9zE1NAh500iP6cQJ9hwou64/yckuCHcqO7
 k6jvCeBMxrK2dSHxVFjqmhf0+Vk+B44IM001+w4AffF8mAgb8jHinSrcdapuJoSWHHT6
 BI+nztOk0GOz40dBmeyKLbLhzkZ307ZDWUHK9nlqkWcLcNDsHj06DOucWz8m/6HhODGX
 qZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729479846; x=1730084646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pyUTLQMOJqvJ/1N82Aa9U8f7yiqvRAf4+5QUW6gIySY=;
 b=AJgXZ98DrmAcp3+hLORLV+37k03y38jqc5KA6QaUXwIRkjYn5xmd1Acu5ioPm/kWor
 EhmBa85ru5mQ9gSp39rJbe8+ag/ffw4sZV0LHYecUPLykuTLuyu/pyN3Ag/+oTKjFsCs
 QxhMqSmPEvLAbQORnYpkOJqiJ8OReNpDePVSps0jmHy2mUz05FFPKS4ZX16tYdLzBeCM
 ZUo+xQY43ZJYtJTbpCECtxJHjeoxh0SHUvYtOMRtbvrczZhVAiac6mahSKcfN7WUYInS
 TxbbBbshaRTABs/lfNzh3Tp+pM5MexkIsLZJeo4T6EHCYt1Z15uRsIpSf+k4TVtKA/ZP
 /2Fw==
X-Gm-Message-State: AOJu0YxMv1FiDhZ7LzNg5DzrCaKlz4buOqZfPP6FI8/bZddWJm313Cp3
 zCAgLezy3+7U+dRtUB86mvI5VWm9elFZJFVK40yYXDsz/X6DXV3dfvRJwqMlWoy44QKjSQo6chj
 HnpJuiFKt6hf2tgf17uAfArKt/9Nh+2CypAWRoa6O2Z0rDH+br5AbEHjAMmIfHw29LJbZNV5Vou
 BCmitmzrc2o3BKi3wfMCkgBsncQlMqK5/Oo264jUo=
X-Google-Smtp-Source: AGHT+IHBV/kLyGCN/AKZhaoz2k4YWDEDd/063dLtc0DFgBSjQlNrjrJFKQ37aYunYBEXlXN/98bUnw==
X-Received: by 2002:a17:902:e5c8:b0:20c:7be3:2816 with SMTP id
 d9443c01a7336-20e5a8fb16amr114040345ad.40.1729479845544; 
 Sun, 20 Oct 2024 20:04:05 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad368b25sm2348846a91.24.2024.10.20.20.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 20:04:04 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 0/5] Add Smrnmi support
Date: Mon, 21 Oct 2024 11:03:53 +0800
Message-ID: <20241021030358.12454-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62c.google.com
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

Tommy Wu (5):
  target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
  target/riscv: Handle Smrnmi interrupt and exception
  target/riscv: Add Smrnmi CSRs
  target/riscv: Add Smrnmi mnret instruction
  target/riscv: Add Smrnmi cpu extension

 hw/riscv/riscv_hart.c                         | 18 ++++
 include/hw/riscv/riscv_hart.h                 |  4 +
 target/riscv/cpu.c                            | 18 ++++
 target/riscv/cpu.h                            | 10 +++
 target/riscv/cpu_bits.h                       | 23 ++++++
 target/riscv/cpu_cfg.h                        |  1 +
 target/riscv/cpu_helper.c                     | 82 +++++++++++++++++--
 target/riscv/csr.c                            | 82 +++++++++++++++++++
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 20 +++++
 target/riscv/op_helper.c                      | 45 ++++++++--
 12 files changed, 297 insertions(+), 10 deletions(-)

--
2.43.2


