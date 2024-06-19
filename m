Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E533AC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJxDc-0005SI-Jo; Wed, 19 Jun 2024 11:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sJxDa-0005Ry-Vk
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:27:27 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sJxDY-0005re-PR
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:27:26 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so7350665ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718810843; x=1719415643;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sus7CiSY0l8USAW7BqYctyH1APOzJeOoR1y4/wiJ0wU=;
 b=wV8d0NqG4MEkODs42no515vCqgHJFILZ9+keEAgih6tZE/fd8+ejIG/y9t7RA8adpG
 C/TrdnGc2HB5dVpn5QoDC33EVG0STSMn5XeUWUrtcrHQ7X7VmVFzk+R50il6FUhewdOT
 Xoz7yb8eLKAIHX5HDZaKIifWP2C1odBE5Vzd77ecYIKCZn4+LFo/7hnfGSLDjiQeU+FJ
 wcC97MypWQCwnvkd467NFvUBmRPziILhBDZU2sRUvC4alEzTnJkJhRQw4sEbDV6Vqnpm
 99YIfb/H0kzcbuDeyYIQzAzmaql73Qvm4yMtPGJmlnlQkNazELF+Ilm8JhVevgNFagUY
 0XxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718810843; x=1719415643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sus7CiSY0l8USAW7BqYctyH1APOzJeOoR1y4/wiJ0wU=;
 b=htQLwNbz/y+OUb+i2mq9+zpvuCIn7RJoTj5MamsnrmOyc0uGy9v/5yck+G9nyaCehd
 fmhhgacZ9RddfLYvEAq8ntUSycpb39YQHLJQAuLxtMEJ6lXzam+LiMSZu6fohwuC4oxv
 FbB6YS4HXaIRkFySr6xfOGya9hvmetjaVK1qHM66JQ9LyWrR9NtscAVZ2yhZbovo5OAB
 BFaF1eaqmeJ0sYYxEthPqW5Js+FQv2R5z/z7PuXf1L6axYreA5Tr9ssLHcGfunxxRuu+
 LQ5GfDxUljPPkQQVXibkDLiaBg1YNlrI5E1bHMs5MgI7d9n05ML+kV6rQoXf1n7Qklwm
 xlJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDzxica7OEtR3TtNMgRzpzWcl6Sp1MPHmQrldp/WaV7e1NzvYy956muRhR7cXRMfEaQa0QG+vq/ycCY3cl1HhlTUJLVHk=
X-Gm-Message-State: AOJu0YxrZLjPCXm+Jk3fktw1YMXw2Iq7wMCE4olvsGcMFIm6GwAGcOH/
 BztQrkrVLtjSY8CWLaIoebuUYIvPxCkqa+GRRhcqQqzXLtjyU9J9lLukoLhfy8Q3b4b03ODCc5F
 H
X-Google-Smtp-Source: AGHT+IFXhbgBX6DnrLUvhx8irtEG77EaZ9XOA6WTVO+dioTZsKqXY5S/a5gd7Zn1V4lTArCxoYBcnA==
X-Received: by 2002:a17:902:e752:b0:1f8:62a1:b6af with SMTP id
 d9443c01a7336-1f9a8e945eamr45693875ad.21.1718810842634; 
 Wed, 19 Jun 2024 08:27:22 -0700 (PDT)
Received: from localhost.localdomain ([51.52.155.79])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9afada50dsm15956865ad.166.2024.06.19.08.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 08:27:22 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org,
 jason.chien@sifive.com
Subject: [PATCH v2 0/6] target/riscv: Add support for Control Transfer Records
 Ext.
Date: Wed, 19 Jun 2024 16:27:02 +0100
Message-Id: <20240619152708.135991-1-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=rkanwal@rivosinc.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series enables Control Transfer Records extension support on riscv
platform. This extension is similar to Arch LBR in x86 and BRBE in ARM.
The Extension has been stable and the latest release can be found here [0]

CTR extension depends on couple of other extensions:

1. S[m|s]csrind : The indirect CSR extension [1] which defines additional
   ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation of
   RISC-V CSR address space. CTR access ctrsource, ctrtartget and ctrdata
   CSRs using sscsrind extension.

2. Smstateen: The mstateen bit[54] controls the access to the CTR ext to
   S-mode.

3. Sscofpmf: Counter overflow and privilege mode filtering. [2]

The series is based on Smcdeleg/Ssccfg counter delegation extension [3]
patches. CTR itself doesn't depend on counter delegation support. This
rebase is basically to include the Smcsrind patches.

Due to the dependency of these extensions, the following extensions must be
enabled to use the control transfer records feature.

"smstateen=true,sscofpmf=true,smcsrind=true,sscsrind=true,smctr=true,ssctr=true"

Here is the link to a quick guide [5] to setup and run a basic perf demo on
Linux to use CTR Ext.

The Qemu patches can be found here:
https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream_v2

The opensbi patch can be found here:
https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2

The Linux kernel patches can be found here:
https://github.com/rajnesh-kanwal/linux/tree/ctr_upstream_v2

[0]: https://github.com/riscv/riscv-control-transfer-records/release
[1]: https://github.com/riscv/riscv-indirect-csr-access
[2]: https://github.com/riscvarchive/riscv-count-overflow/tree/main
[3]: https://github.com/riscv/riscv-smcdeleg-ssccfg
[4]: https://lore.kernel.org/all/20240217000134.3634191-1-atishp@rivosinc.com/
[5]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine

Changelog:

v2: Lots of improvements based on Jason Chien's feedback including:
  - Added CTR recording for cm.jalt, cm.jt, cm.popret, cm.popretz.
  - Fixed and added more CTR extension enable checks.
  - Fixed CTR CSR predicate functions.
  - Fixed external trap xTE bit checks.
  - One fix in freeze function for VS-mode.
  - Lots of minor code improvements.
  - Added checks in sctrclr instruction helper.

v1:
  - https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream


Rajnesh Kanwal (6):
  target/riscv: Remove obsolete sfence.vm instruction
  target/riscv: Add Control Transfer Records CSR definitions.
  target/riscv: Add support for Control Transfer Records extension CSRs.
  target/riscv: Add support to record CTR entries.
  target/riscv: Add CTR sctrclr instruction.
  target/riscv: Add support to access ctrsource, ctrtarget, ctrdata
    regs.

 target/riscv/cpu.c                            |   4 +
 target/riscv/cpu.h                            |  14 +
 target/riscv/cpu_bits.h                       | 154 ++++++++++
 target/riscv/cpu_cfg.h                        |   2 +
 target/riscv/cpu_helper.c                     | 265 +++++++++++++++++
 target/riscv/csr.c                            | 276 +++++++++++++++++-
 target/riscv/helper.h                         |   9 +-
 target/riscv/insn32.decode                    |   2 +-
 .../riscv/insn_trans/trans_privileged.c.inc   |  21 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |  31 ++
 target/riscv/insn_trans/trans_rvzce.c.inc     |  20 ++
 target/riscv/op_helper.c                      | 159 +++++++++-
 target/riscv/tcg/tcg-cpu.c                    |   6 +
 target/riscv/translate.c                      |  10 +
 14 files changed, 960 insertions(+), 13 deletions(-)

-- 
2.34.1


