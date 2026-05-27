Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A236CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKdd-00062M-TW; Wed, 27 May 2026 16:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKdY-00061L-Fp
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:13:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKdV-00052h-91
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:13:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so25752565e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912831; x=1780517631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8G9c8wRGou6KDpPdZGIpyix00Ld4OWP7+GlBI62bb34=;
 b=lisJq1T0/8x9HgAsvfH6BGJUTlkEIXBwwVWoy/u5UmoH3hArRc4SePK8BIa+mgWIVG
 NcrDogGxYEO4JxiwwlTTl9eTzxiNMn6ej7Vfd5v2+ZhMaMtmLpOKgALEYWrbsR+AaEkD
 QmHp7u7SzboTttwSZI8KYZqKrMcG3w1fRroM8HVZv6U8fkP7jJzV1NtQfcSwifn9fX8g
 rRfx5d2DDTTbiV390GXz0o5kbF0gxGqDMO3Uhx+XQJdxH/KfuwoEB+dRj8JfaEyCPWRK
 F/Hz8uOWSJhud/FKfVtSI28CvGipX+9ikI1NxnxmdqKSz1aO1bR+0UFj3CHsv+Ey7yI+
 WKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912831; x=1780517631;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8G9c8wRGou6KDpPdZGIpyix00Ld4OWP7+GlBI62bb34=;
 b=BdD15YMiPH2s/1CdbdPZP82ZvXt7uLPu3PUbWNhlmN5UAgJkMGNaKL2hVz+FDwaeZD
 PkVcyKRKSUXNTd9XuEpOqIjK/82/X5r4s85f23UnFUQO+1pTrmVmnaKgacpJT9B1lMwF
 C8/lLx5/aPkmrwvhwBzZDIe1gIG4YA5fAXY44KUI25pyMbTSF2tBg/PkGcSmYOfNAg8O
 DKNzyDHAAkCI5o5zXjip1oYedoiolLryy7eX8e9VlzxMlTTh5qac5UrzezrRVHs3Ionp
 nXPckx+dLFAO69prqslDIvyF/k90GVnlMFoSQRcXrtHYuGSW2RDgH+Okwk0Z3qb8s2iQ
 /zqQ==
X-Gm-Message-State: AOJu0YywJckXisrOodr8w2tobQJa0gYCe9wFjS3gEKQJT0MPS42qOK7k
 i2nsKDRUeJrG9sydOQPSSJGXn44nLNjNMAhBNb3AzI+WKJHRFfvV9ddrH5xPwoNrbSLotJlU5ba
 l4YUnNdnUIQ==
X-Gm-Gg: Acq92OFRcxIs8pkjf2wAMfaBK/nRy5zd1qO2rrWDPP/gocfco2FC5uWLNZdWm0XMUWo
 Lqnpisov1FVC8QKeFgkR2IXTwHNkvkCnzTuoGKMZoiR22SLOzvUq8pCgBVoq/4gHRPDULekJaZt
 QmpKnIo9Q5wTfcQKmyf923kJ3Mcr4AYd6Gvv2GiLG3zdYi+kPIo2b2J32RGzhhSEgY0/oz0/bVc
 I5bkeNeR9mXdoW0DxANuFmVmEy4d5XWL7wV3by6HZkA6cy5SVY7tuB5HQS/DqtvjGLK59tEvWQX
 WktjTO5ZxUcwPcORZcVq8Pqh55THaMCawYSMktlMeTjma0AMuT+Twva1kcxAIrf+Rh4+3g0hNLm
 3kiPdqiepzQjfoD0BjnAMMqdesULVtBtm5sIJKJx86qlA3o4RVQMF/lJnRYBlx+A0KijrNn6k4p
 X4mewzGqYWkBZ6ab6+kQ6Tks7a33H8qWwR6jzDuJsqB879LkgzFxmQlRJpgiYbk3dIRQ==
X-Received: by 2002:a05:600c:3511:b0:490:6e1a:8a45 with SMTP id
 5b1f17b1804b1-4906e1a8ad5mr185323905e9.25.1779912831384; 
 Wed, 27 May 2026 13:13:51 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5584b8sm8116578f8f.11.2026.05.27.13.13.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:13:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 00/12] Add RISC-V big-endian target support
Date: Wed, 27 May 2026 22:13:36 +0200
Message-ID: <20260527201348.29511-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

v11:
- rewrite some patches while reviewing for mainstream integration

v10 cover from Djordje:

Hi all,

This series adds big-endian data support for RISC-V system emulation.

Following the discussion on previous versions, this series models
fixed-endian harts, not a mixed-endian implementation where software can
toggle MBE/SBE/UBE at runtime. The reset value of MBE/SBE/UBE is selected
from the CPU configuration. These bits remain outside the
mstatus/mstatush/sstatus writable masks, so they are effectively hardwired
to 0 for the default little-endian CPUs and to 1 when `big-endian=on`.

The user-visible `big-endian` CPU property is exposed only after the data
path, boot path, and page-table walk support are in place, so the series
remains bisectable.

Djordje Todorovic (6):
  target/riscv: Implement runtime data endianness via MSTATUS bits
  target/riscv: Fix page table walk endianness for big-endian harts
  target/riscv: Add big-endian CPU configuration field and reset logic
  hw/riscv/boot: Honour data endianness
  target/riscv: Expose and document the CPU 'big-endian' property
  tests/functional: Add RISC-V endianness test

Philippe Mathieu-Daudé (6):
  target/riscv: Initialize DisasContext::mo_endian once
  target/riscv: Assert PTE.N/PBMT bits are not expected on RV32
  target/riscv: De-indent some code in get_physical_address()
  target/riscv: Remove target_ulong use in get_physical_address()
  hw/riscv/boot: Rewrite setup_rom_reset_vec() using load/store API
  hw/riscv/boot: Replace cpu_to_le32() -> const_le32()

 docs/system/target-riscv.rst                  | 29 ++++++
 target/riscv/cpu.h                            |  1 +
 target/riscv/internals.h                      | 29 ++++--
 target/riscv/cpu_cfg_fields.h.inc             |  1 +
 hw/riscv/boot.c                               | 93 ++++++++++---------
 target/riscv/cpu.c                            | 15 ++-
 target/riscv/cpu_helper.c                     | 44 +++++----
 target/riscv/tcg/tcg-cpu.c                    |  2 +
 target/riscv/translate.c                      | 22 ++---
 target/riscv/insn_trans/trans_rva.c.inc       |  4 +-
 target/riscv/insn_trans/trans_rvd.c.inc       |  4 +-
 target/riscv/insn_trans/trans_rvf.c.inc       |  4 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |  8 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 +-
 target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 +-
 target/riscv/insn_trans/trans_rvzce.c.inc     |  4 +-
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 +-
 target/riscv/insn_trans/trans_xmips.c.inc     |  8 +-
 target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++--
 target/riscv/insn_trans/trans_zilsd.c.inc     |  4 +-
 tests/functional/riscv64/meson.build          |  1 +
 tests/functional/riscv64/test_endianness.py   | 57 ++++++++++++
 23 files changed, 240 insertions(+), 122 deletions(-)
 create mode 100644 tests/functional/riscv64/test_endianness.py

-- 
2.53.0


