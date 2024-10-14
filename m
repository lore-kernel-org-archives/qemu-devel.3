Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04FBD18138
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 18:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Pfs-0002QF-O5; Mon, 14 Oct 2024 14:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0Pfn-0002PA-Bd
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:20:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0Pfl-0005Di-7y
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:20:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20cdda5cfb6so14325215ad.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1728929999; x=1729534799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mne/G8bf+gLdMpNrpPoleB2sZqjhOm7PxMIHH7EkWrQ=;
 b=mE6lNFsR7Qb4qai7QIn0UsZTz6sOIhpFXF77gZnwJjqmnoJrrM9ZtBJDFMmbW4SP5Y
 FGU9nY/sRKef4dLggwdRCz9vQlXQ2mdTYxxk+CNrWR8fzuEDmvYB5xVNE2/DmZQOCPB0
 WUauzKXe7CQAxnXuz7RX7HeHogT9oDMCGjFg507xuRNGRTX+o3fNVTBL93m1jmf7Tr1R
 qhE9V8d5UAHZgSC7EoM+5TS0PYONSFW6KrsbeLjMp3q5ufevkyAMmrk+Kk/umpfRQYo0
 k4iv6st/5szov2p/fsYk2eqcGGTeEVTCVQhn722mzAZQpQEu5flSZC9/Qh2Bb8JsWX5g
 zRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728929999; x=1729534799;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mne/G8bf+gLdMpNrpPoleB2sZqjhOm7PxMIHH7EkWrQ=;
 b=Ghv0YFxxaGvv8dwiFft2E5SR292qJvbE9ACjF508v8Ik9WCxoChmJi56JGSbeXVTWr
 MGoRfEFELgUesx8EccZ8hTLt88zp/SLycY2GJmq/k8Y9HTJVJaEwUVjy+AByjWX3IpGT
 Ge1cOtyWbSRyqcvIuurNjoFKUpc/y/9fFi1iT9P5X3NcTVWxw0mhKxOkq/baRzmTsVXE
 3lYiZe7vxW/T5dKPGp2KBn9J6WdiNovEenKxsFH25esZh4eJCeunnbNP50vw1OGVFdD7
 mGTSyhHkBp4zzb27F2yvEVcXt+IIHNR1UR+skwjRAvs/OQPbRF8GTE8f8+g06wVtz+jl
 vDzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9SOVbw5qiCu3KltoZ5zT8F8hSEoWXqjlOw0zivc1LlBpnhzjAkB9bmrYPEM2D2Ho/LqBeltKZH2h3@nongnu.org
X-Gm-Message-State: AOJu0YzYK70CMfkng0CERdCEAMcnk7a8h/EkefjcNjHSV/k8yeTtqxa1
 hAyjahvdWfQYGiwbJ3CENmTCh8kwrmjKP15ScQIXlIxIS/WelA+K6uByVkJg8yg=
X-Google-Smtp-Source: AGHT+IGnDoqVp3b/PZjcfOaqrLRJzltFV5f2GqbmGhkSArBzYb7/BJM2gazKFNKQhmKp5XTMZbw9dw==
X-Received: by 2002:a17:902:db0e:b0:20c:7720:59b8 with SMTP id
 d9443c01a7336-20ca142a448mr178759685ad.6.1728929999400; 
 Mon, 14 Oct 2024 11:19:59 -0700 (PDT)
Received: from fchang-1826.. (1-169-245-242.dynamic-ip.hinet.net.
 [1.169.245.242]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c375d0csm68964525ad.304.2024.10.14.11.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 11:19:58 -0700 (PDT)
From: frank.chang@sifive.com
To: 
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 qemu-devel@nongnu.org (open list:All patches CC here),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 0/5] Add Smrnmi support
Date: Tue, 15 Oct 2024 02:19:43 +0800
Message-Id: <20241014181948.1974405-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x629.google.com
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
[2] https://github.com/sifive/qemu/tree/upstream-smrnmi-v7
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
 target/riscv/cpu_helper.c                     | 79 ++++++++++++++++--
 target/riscv/csr.c                            | 82 +++++++++++++++++++
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 20 +++++
 target/riscv/op_helper.c                      | 45 ++++++++--
 12 files changed, 294 insertions(+), 10 deletions(-)

--
2.34.1


