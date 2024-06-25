Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0D8C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4db-000811-5b; Tue, 25 Jun 2024 07:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4dS-0007ye-Jy
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:46:56 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4dQ-0000b8-S9
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:46:54 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so36732215ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719316010; x=1719920810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ciOBe2xr4Dl9EdB4Pmlky5GXrXaVfY4+rZopnsnxCl8=;
 b=JXVBZJKjJDRxapoqJjTU8UEvW8hHT5YEIs4HrU9C+79/qD8cckEwPsg3aio/YU4pDr
 LxNGFwLbOwtHEfrv88XwSvhexix3jXEmmESUdjiqWaAzGkwgiONdUb5MhlX6LwnrpfZI
 Xz6eqFM1OBLPqb0fLRgLnX0ER8KPpfW4rPkB5WWpP6S75zalXvSgEgYVnP9HkCMlUtU9
 wdTJAucyoTnMDk1Taf7MnUe++SFMpFJP7sbF7kmBbLM+wqrWvEtAFz9OG3BIErhXzp1S
 d9/ollR1Hn2VtpQXtdwrvF0XEpgHaLc8HFAsDQRTHmHxIJm38BIM+I/JcQF00vC3to39
 Mutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719316010; x=1719920810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ciOBe2xr4Dl9EdB4Pmlky5GXrXaVfY4+rZopnsnxCl8=;
 b=xHfFFMSjFJPiLIqSV8wVex0qYMRlNQyB42Qm6+fSizz3blkaONIqHql8X+MKH0C+Ii
 EIBweHnSxEXtpwqgooR9DP+p0VevyFm2Xr+TniuUb5P9g6NUwTu7tWSwpD+6yP2KO86W
 1kbSO6iEfAl+O63hiccXfzO9o5vD+yeH/egBCzEUexmPN+cqooCo9cQCYeGYsYdfa8Gb
 yW3jy49cS3zcIUzOg6Nv/PZBJEpNFnJuIw2knLs65WFyJSheV5TK15/ZMLSvNqRRN8BG
 MtEMhnK8/7CLU0xldmlEdd43BZHg2z2nkpsd8TkRhk2+XUH8RFbLDX0oo1/zMYm1Jrlg
 eF+A==
X-Gm-Message-State: AOJu0Yw7wDew3MWiqtDGk8pdJgdFhN/NP05mlXvRt4e5kctsXC4ZsmX5
 NgWjV31tNTFeQBbJfvNIN7i9XAzp8r/THfR1MaKuCHAspUNe+RP8ow/8xJxyMx9ZXMtqR5uhziD
 7shKmRvLNu1JiirJbPpvGiPzDHqK9uR/1JSRC6ywTgpRayG6WVQ+NrQdHFduuMZLtel7Bju3dJU
 RydHERYma5ZNHExGWfxkcMEHznqjevpIityVf44oUNbQBnXUM=
X-Google-Smtp-Source: AGHT+IGpNcKT/hz6ashVvaq1uHmdk5WD0MGYBEjjaEUVN7/ZNj3NN2xWKr75MowyZrlpwe0E0K7y0g==
X-Received: by 2002:a17:903:228a:b0:1f4:8bb9:924f with SMTP id
 d9443c01a7336-1fa5e640661mr44846245ad.1.1719316009583; 
 Tue, 25 Jun 2024 04:46:49 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb321d4esm79472325ad.67.2024.06.25.04.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 04:46:49 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 0/6] Introduce extension implied rules
Date: Tue, 25 Jun 2024 19:46:23 +0800
Message-ID: <20240625114629.27793-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x641.google.com
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

Currently, the implied extensions are enabled and checked in
riscv_cpu_validate_set_extensions(). However, the order of enabling the
implied extensions must follow a strict sequence, which is error-prone.

This patchset introduce extension implied rule helpers to enable the
implied extensions. This also eliminates the old-fashioned ordering
requirement. For example, Zvksg implies Zvks, Zvks implies Zvksed, etc.,
removing the need to check the implied rules of Zvksg before Zvks.

The idea [1] and the implied rules [2] are referenced from LLVM.

[1] https://github.com/llvm/llvm-project/blob/main/llvm/lib/TargetParser/RISCVISAInfo.cpp#L875
[2] https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/RISCV/RISCVFeatures.td

Changelog:

v3:
  - Replace the enabled bitmask of type 'uint64_t' with a dynamic bitmask
    to support more than 64 harts.
  - Ensure that implied rules and hash tables are initialized/created only once.
  - Rename variables to align nomenclature with existing variables:
      - In RISCVCPUImpliedExtsRule structure:
        - 'implied_misas' -> 'implied_misa_exts'
        - 'implied_exts' -> 'implied_multi_exts'
      - 'misa_implied_rules' -> 'misa_ext_implied_rules'
      - 'ext_implied_rules' -> 'multi_ext_implied_rules'
      - 'riscv_misa_implied_rules' -> 'riscv_misa_ext_implied_rules'
      - 'riscv_ext_implied_rules -> 'riscv_multi_ext_implied_rules'

v2:
  - Remove enabled bitmask from user-mode QEMU as there's no good way
    (e.g. mhartid) to distinguish the SMP cores in user-mode QEMU.
  - Use qatomic API to access the enabled bitmask to prevent the
    potential enabled bit from being cleared by another hart.

Frank Chang (6):
  target/riscv: Introduce extension implied rules definition
  target/riscv: Introduce extension implied rule helpers
  target/riscv: Add MISA extension implied rules
  target/riscv: Add multi extension implied rules
  target/riscv: Add Zc extension implied rule
  target/riscv: Remove extension auto-update check statements

 target/riscv/cpu.c         | 396 +++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h         |  23 +++
 target/riscv/tcg/tcg-cpu.c | 274 ++++++++++++++-----------
 3 files changed, 574 insertions(+), 119 deletions(-)

--
2.43.2


