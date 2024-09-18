Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A60CDD54D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 17:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqyG7-0006WC-FQ; Wed, 18 Sep 2024 13:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sqyG5-0006Ul-GB
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:14:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sqyG3-0001qb-Lv
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:14:29 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-205722ba00cso192165ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1726679665; x=1727284465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yctDsWLUV1YXkBVBqtdd55CZU+0Ssgap5cnUJoATZJI=;
 b=inGwfKadAlA3XLYcMG7o8BX0Y3br2hHKBeLP5M/jMLDuYcQW6AlyfAOfJwjtkPNYNe
 IhypwGFlEVEF/yZEXcsZ8iawKpLw5OkKQi/A0pB6hSkUJYhSH8E22tpCCZA0MOxZYDkX
 We/wCEfBahGDj7q0Wscw7EqSQA+ua8m8GeLUSXCpLR0GzTYvzepgt3U8UprpNofQXYPn
 ZpB7mQzfHoOE2UrIuglDuQn5kvBGRUAEBF7xN9hQJ6UG1md2uPaoVwgtZTzVWAgLAfgD
 ZDmBAkJQfXC6MaU9/hvMrSd2Inb3B+31NAL9U3n5bgMBEZKOY9pzped5B4PxeI4tozGm
 PpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726679665; x=1727284465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yctDsWLUV1YXkBVBqtdd55CZU+0Ssgap5cnUJoATZJI=;
 b=N2x1anh15oXPOiHr8aJw+V6ihZQhwdsMP8UYthBdaQrUyjx8dLNvDhPikfRd+FLjqg
 ZsUUZyC3KdUBAjhvNhjWHiu6sStC3QlCYCqroPV1TBxNF3wdLc7Wt/p8ERVQ7bplRbST
 CrC5u0dh4ioU35ZobpNfy1dAjfogzlZVOeKEqqqY++A8n6tNyFIk1+QKZ7AJjW7LK8rd
 lidc78485PZi2DSEJHiTZyFwIIgiGv0jCJdMnmG/aXJL2zZp1xH7g2ec+nCmHHqRel9F
 O5K3swZ5ostLRrXB0eNg4sJOLiv5UO1JfHSe8Zdc/MTUyZdoaIhTc5eeKAUPS/HBkRya
 bEGA==
X-Gm-Message-State: AOJu0Yx+Nz+clMs7jpfFvGg3dBvJgU1E6H1w+aropjTShLpdHRYrhaXK
 J1OcM1DlDPG035sObm/PTjqNPsziIJYaO+VIB/q7459DBbnOSal2RnF1iqv4eS5BSbb3WxNXRtL
 AEyStdngO4yb+xj+m92ZjCnquHb1pJQoclmksOfMj7tupdSpz73zi3s8G/HmG0CbPxeokrX6HCO
 MWIwrO8nZdfUBFVW0YaOuKNgywHSjyCLqUUACInQ==
X-Google-Smtp-Source: AGHT+IGcMebEHXcRaWD1XZN9BXTFDll2xzt8N6DFE2QJ+2eKAbb7jD/IaMChlwpnVVteR1bNUbJJoQ==
X-Received: by 2002:a17:90a:2dc5:b0:2c9:5a85:f8dd with SMTP id
 98e67ed59e1d1-2db9ffee6c4mr26433515a91.18.1726679665017; 
 Wed, 18 Sep 2024 10:14:25 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd608e2318sm1914577a91.32.2024.09.18.10.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 10:14:24 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 negge@google.com, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 0/7] Improve the performance of RISC-V vector
 unit-stride/whole register ld/st instructions
Date: Thu, 19 Sep 2024 01:14:05 +0800
Message-Id: <20240918171412.150107-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x633.google.com
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

Hi,

This version fixes several issues in v5
- The cross page bound checking issue
- The mismatch vl comparison in the early exit checking of vext_ldst_us
- The endian issue when host is big endian

Thank for Richard Henderson's suggestions that this version unrolled the
loop in helper functions of unmasked vector unit-stride load/store
instructions, etc.

And this version also extends the optimizations to the unmasked vector
fault-only-first load instruction.

Some performance result of this version 
1. Test case provided in 
    https://gitlab.com/qemu-project/qemu/-/issues/2137#note_1757501369
    - QEMU user mode (vlen=128):
        - Original:   ~11.8 sec
        - v5:          ~1.3 sec
        - v6:          ~1.2 sec
    - QEMU system mode (vlen=128):
        - Original:   ~29.4 sec
        - v5:          ~1.6 sec
        - v6:          ~1.6 sec
2. SPEC CPU2006 INT (test input)
    - QEMU user mode (vlen=128)
        - Original:  ~459.1 sec
        - v5:        ~300.0 sec
        - v6:        ~280.6 sec
3. SPEC CPU2017 intspeed (test input)
    - QEMU user mode (vlen=128)
        - Original: ~2475.9 sec
        - v5:       ~1702.6 sec
        - v6:       ~1663.4 sec


This version is based on the riscv-to-apply.next branch(commit 90d5d3c).

Changes from v5:
- patch 2
    - Replace the VSTART_CHECK_EARLY_EXIT function by checking the
      correct evl in vext_ldst_us.
- patch 3
    - Unroll the memory load/store loop
    - Fix the bound checking issue in cross page elements
    - Fix the endian issue in GEN_VEXT_LD_ELEM/GEN_VEXT_ST_ELEM
    - Pass in mmu_index for vext_page_ldst_us
    - Reduce the flag & host checking
- patch 4
    - Unroll the memory load/store loop
    - Fix the bound checking issue in cross page elements
- patch 5
    - Extend optimizations to unmasked vector fault-only-first load
      instruction
- patch 6
    - Switch to memcpy only when doing byte load/store
- patch 7
    - Inline the vext_page_ldst_us function

Previous versions:
- v1: https://lore.kernel.org/all/20240215192823.729209-1-max.chou@sifive.com/
- v2: https://lore.kernel.org/all/20240531174504.281461-1-max.chou@sifive.com/
- v3: https://lore.kernel.org/all/20240613141906.1276105-1-max.chou@sifive.com/
- v4: https://lore.kernel.org/all/20240613175122.1299212-1-max.chou@sifive.com/
- v5: https://lore.kernel.org/all/20240717133936.713642-1-max.chou@sifive.com/

Max Chou (7):
  target/riscv: Set vdata.vm field for vector load/store whole register
    instructions
  target/riscv: rvv: Replace VSTART_CHECK_EARLY_EXIT in vext_ldst_us
  target/riscv: rvv: Provide a fast path using direct access to host ram
    for unmasked unit-stride load/store
  target/riscv: rvv: Provide a fast path using direct access to host ram
    for unit-stride whole register load/store
  target/riscv: rvv: Provide a fast path using direct access to host ram
    for unit-stride load-only-first load instructions
  target/riscv: rvv: Provide group continuous ld/st flow for unit-stride
    ld/st instructions
  target/riscv: Inline unit-stride ld/st and corresponding functions for
    performance

 target/riscv/insn_trans/trans_rvv.c.inc |   3 +
 target/riscv/vector_helper.c            | 598 ++++++++++++++++--------
 2 files changed, 400 insertions(+), 201 deletions(-)

-- 
2.34.1


