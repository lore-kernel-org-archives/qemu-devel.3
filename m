Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAF5F327CD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF7Xu-0008WO-Ag; Tue, 21 Apr 2026 05:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Xq-0008VQ-9A
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:26 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Xo-0007qF-KH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:26 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so3758201b3a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776764242; x=1777369042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+2Z9FaiCk46VlVG9ywRB+kf8xp8oDbDRE+mOXIB+O20=;
 b=XVZ/RDs5K/56ZeeJjGkSDd2PgQe9xOG8BxcrXKHOv68YTFZ4w4Mseo4X/Aa/F4sO7A
 3ceJFL7V2Kx0fgOcudhn93YuysByMxW/i7asvRHtnhbIasIhI06oAEmwOdIuvoKCfW3c
 k31OhMZAHg/nDSn8gPhLO7joUBWCrTFmW67OuIzA7d7Jm4lDXv2n6zuJ5eO4bshsaUR+
 xuibnA75Fv+SecmVziTuPVPB45N3haoTRM/eYKgn73rkkLS27S1xgvbaLgSnkdsYNwfb
 CTqRxsBUEHncjS3drGZrtMbuU7nklw2U7i5ZhOlLS1i3f4UH3HnGSU/nxlrmHX07HCwz
 wG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776764242; x=1777369042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2Z9FaiCk46VlVG9ywRB+kf8xp8oDbDRE+mOXIB+O20=;
 b=UpeBQq8lCKT9hJnIeO4rajMeCO8zUDlQ/17hORxMKhAeFduzp9KC7MoaDaHLqO7slH
 9vN4SnVy73P/ywJqWQSxMBkBHeLBvR9uyiZ9v1qj/61Kft6aIcYpTxfpzwY3VpqmbNdQ
 6JrkTgfNSM7t90AU7ZW/ZTTOBIau+iejLvq3E+BLbX2fd32+scL51HINXR+dBK/ig1JM
 sNUeYvLiSNiEcnBolZFIhAqSOUwqKFbqJDW0IbtiVlyFUefCQNJ16IHo/cMgjc9TFd2c
 9Cuw2uYiV/rsT8hnsDvAsfLZELIY5xNXRwSE5UVyVig4sOfCnpBUC+OrWBMPOPoGTHPn
 C/Tw==
X-Gm-Message-State: AOJu0Yw2TTRbRx98cRjFz9UlfPg6VwpkUjm8atcN5mDzTflLEu7rB0zv
 ab3DVPQL+wBpUm6oOK+F+JGCwVG52aOOC1v4p2KLbPBFqklToNKhJFUn8ysuTy4n6Y+n4A9q3q7
 vfBFpdMhHdoLrVtY+fikl2ocqxFg4X9ky1NMxkSyEEfU8OWFExqD+v+GCqGTaaN6arKSWPWTyUk
 G1R3wZmPx0FoLmXW4OKbtWEA/677KeHnvSQKlj24C/8Msz+8Aj
X-Gm-Gg: AeBDietJk86pirlgB5enJ/7U9is5q6PulkhC7dF+/j4fU0dMyJNd5WPhv/PqGstXzuy
 mJb0ep8+QHNA48U1KLX9+NNYo0LDinzd1W/EOV++oQTyZ5aEN0jjozfL73hYF4DxuyRPB3G1WXE
 dN7AF7lDp6M1ix7xkI+TFsKillhDqE8gfyVhQ1n+ApFcijXjEDgeNc4yoADtZVmNBKUj97jc6As
 hmMEsg/yyeA4vyjQgXOIlcsqZ1gxmXC/Kx8n9Edfg1Vo2zGDkbgLm7tOlKTgNTfmbOPraLPrOgy
 C9lI+Nlshe/i7bIvAH6cHJDyw96Y5U4cmsRh/8+d5M4RKioaSsUUTxhjFcKiNvInE86inVZ8p6m
 R5XCbWkBoizGOWNPLxoIMkJD7l3PYU71f0SKwEIkFPSSSe25WWjcdYlnYufxGCUeyN8eIrwrxqM
 6kD4sLaOLdHD2bkm9CGo8M4QJAm1QfgtQUc/Z+zp5mqCUCxh7xR+TKnDEYCltU
X-Received: by 2002:a05:6a00:3028:b0:82a:6461:6d15 with SMTP id
 d2e1a72fcca58-82f8c94c5fbmr18841416b3a.46.1776764242088; 
 Tue, 21 Apr 2026 02:37:22 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981be6sm15904589b3a.9.2026.04.21.02.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 02:37:21 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 0/6] Fix Zjpm implementation
Date: Tue, 21 Apr 2026 17:37:09 +0800
Message-ID: <20260421093715.2995067-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42b.google.com
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

From: Frank Chang <frank.chang@sifive.com>

The current Zjpm implementation has the following issues:

1. The address is shifted before obtaining the correct PMLEN value.
2. riscv_pm_get_pmm() does not handle effective privilege mode correctly.
3. mstatus.MPRV does not affect virtual-machine load/store instructions.
4. Sign extension for virtual-machine load/store instructions (HLV.* and
   HSV.*) must be performed when vsatp.MODE != Bare.

This patchset fixes the above issues and also renames
riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm(), as the helper
is only used when checking the PMM configuration for virtual-machine
load/store instructions, rather than for VS/VU modes.

Changelog:

v4:
  * Rebase to the latest to-apply.next branch.

v3:
  * Move riscv_cpu_eff_priv() to the header file and declare it as a
    static inline function.
  * Fix the MXR check bugs pointed out by Radim Krčmář.

v2:
  * Check effective privilege mode in riscv_pm_get_pmm().
  * Fix pointer masking for virtual-machine load/store instructions
    (HLV.* and HSV.*).
  * Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm().

Frank Chang (5):
  target/riscv: Add a helper to return the current effective priv mode
  target/riscv: Fix pointer masking PMM field selection logic
  target/riscv: Fix pointer masking for virtual-machine load/store insns
  target/riscv: Rename riscv_pm_get_virt_pmm() to
    riscv_pm_get_vm_ldst_pmm()
  target/riscv: Fix pointer masking translation mode check bug

Yong-Xuan Wang (1):
  target/riscv: fix address masking

 target/riscv/cpu.h         |  41 +++++++++++++-
 target/riscv/cpu_helper.c  | 110 +++++++++++++++++++++++++++----------
 target/riscv/internals.h   |   8 +--
 target/riscv/tcg/tcg-cpu.c |   4 +-
 4 files changed, 124 insertions(+), 39 deletions(-)

--
2.43.0


