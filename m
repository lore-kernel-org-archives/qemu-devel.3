Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA72CD2ED11
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi72G-0005Bf-3m; Tue, 20 Jan 2026 03:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi72D-00057k-QT
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:24:21 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi72C-00032Z-3F
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:24:21 -0500
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-350fe1f8ea3so2433924a91.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768897459; x=1769502259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g/a+J8K4fw4eMhHfX9kIgNdCCzTQgWhpwOE7++Ek8XI=;
 b=J7UDEC8g6a6RrWpdudXtem9gPsKEpahwpWzD8lZvnHiDU0QPMWg5yuxDVkX8f3qXBF
 V53G6Z2izLOwu1Ye7phYxVTKH8Q36Gz2yITGqXF0pw1tOiFqgN6Fl1eGK2hQ7yDtPP/M
 8Ng2gDKtVt5txuYpY6ghh2FcASvNORHP8IV/al3y1tehMBDm+LGWc39aZHG5X1OqBXsg
 agRTB6De4arUw2aj2IMkv638NPLXTczD6NJP3znSuu+IamXYPFTP6pLF2vZKkgRiv+Jz
 QknyJcx3+YTpH9487l5ZczhqMhsqfd9180MKh3WIjD4vkHcX7m/+AKtymVlrM99bzil1
 toSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768897459; x=1769502259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/a+J8K4fw4eMhHfX9kIgNdCCzTQgWhpwOE7++Ek8XI=;
 b=Su8Jmioi2biLA67xF/hRcjLmZh1bpYtXaLEaoi8D1pEKFaf6mDyPVE+ck+Aq1JXtQT
 +KYP0+NLNPwYWjdhzoGhg4F+PwFL2MZwCJXqYIy5GN5IYOJqXUkQhNOBQ6ufC6Yi3yPe
 00vxMAc/k6l1OygGjwjJsdOqZn2LagEAuRqYkIg9x1YjBHK29Xbfd3oFBvf24KR20b/N
 aDTKKZQsxezAfeOvrWcafxNB+sja+b4jiyoqfAu09nsntyCZKVGFhdGzKlhVKNehEWxm
 ponKoCod8d6YRMA4bfOF2vHYfp45Z0rb24kTTy1X8FTWhzODiOLmeJUOESiL0CyKGuFt
 Lc1g==
X-Gm-Message-State: AOJu0YwUR9oYuxDaa9rUpncy+xqUFEZs3P14ZRMVgYpSqhn/Yq+xH1S4
 4Qx4SRHEALDO3BtRsLarQv03IsnJ63h1cnwVCNBkBND4gSrSZ+/nwqFT
X-Gm-Gg: AZuq6aJ7ZOAR4nG5kECamGYkHkEqFpsJcyFgELEK1C1u33O07YATttlf/zMPOEUJBuk
 p07RWeVWBrrjlObtX4NQPRDuU7ZaOlvud03OgQTT/z5x8T+EEZQNCXmm6TxDw/mHCfSUHFxFCSH
 E8rYKCRpbVc5BxrVwERIadAEY9hj5tJ5vyqloYRO+I3TlFxkS+SWnt907aOUPQGbXbSH9DYaZjk
 9e1gs1Cb2g3u3+z4jc3Lav91D0Of1t/xDyGIhxF5tZqgtW1ctB2+jXQRcUj9RrUkqB47xeMe/XU
 f75cPmmoyZULnygVL7uwrybJNZBTAc09zx0hkl8q+P3Cmp+AzhV6nxhJITiihWbMA1crnfpd1bx
 pN4xhc4J7fdy/OXhKF9eXHmdcy4vy+nnOfJICNd3tz8qkbC261oo6Na4NHh0F7IHp+Dh2u36jjB
 CqargY2xKkAX673y7WJ8YAV6HF4yEuuw0B8uuc6z+Y5ZXa0SLNfMeZruHdEd7kwMrzbKl3
X-Received: by 2002:a17:90b:1c01:b0:340:c261:f9f3 with SMTP id
 98e67ed59e1d1-35272f1a478mr11029835a91.14.1768897458523; 
 Tue, 20 Jan 2026 00:24:18 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.21.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35274573a7esm4273592a91.11.2026.01.20.00.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 00:24:18 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v2 0/7] riscv: add initial sdext support
Date: Tue, 20 Jan 2026 16:23:56 +0800
Message-ID: <cover.1768892407.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj1-x1041.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

Per Daniel's review feedback, this v2 series focuses only on the Sdext
implementation in RISC-V QEMU.

It is based on RISC-V Debug Specification 1.0:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

It introduces the sdext/sdtrig config bits, DCSR/DPC/DSCRATCH state,
Debug Mode enter/leave helpers, DRET, EBREAK entry, single-step, and
trigger action=debug mode.

To reduce review load, this series focuses on the Sdext features first.
The Debug Module (DM) and related flows will follow in a later series.

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
  the extend tb flags.":
  https://lore.kernel.org/qemu-devel/20260108132631.9429-6-max.chou@sifive.com/
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
 target/riscv/cpu.c                            |  60 +++++++-
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
 16 files changed, 547 insertions(+), 28 deletions(-)

-- 
2.52.0

