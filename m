Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7114AD358EC
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 09:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlOW6-0004oc-DW; Thu, 29 Jan 2026 04:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlOW4-0004nm-O9
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 04:40:44 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlOW3-0003YR-1z
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 04:40:44 -0500
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-3530e7b3dc2so558841a91.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 01:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769679641; x=1770284441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d11P5odMi2PPU8b2iY2QkvZyI7ohVdkAvPbjBsjFl6s=;
 b=hr4l1pv3sbrLIMqxzf6cDUBHKZqXhIxskiq+EaAIpZgUzJ1CEe4/sOvG56zUNqo2Zd
 6A8fwHkOqEAdcHcKZwdYh61tpx+xaHJB0wVi8kcRRuyULyBOxzV1lv0JaCEI1pAWh1Zs
 Eq+AzXCe95zxJetfCZ8MyHeHsRrwDqYGFWnOCD57bAQAywUvNaZUdrEhl54N6NOb3zo9
 SRb4+US4vmlcuv2ZDTkBL6Gn/BzWaZyOMU2H+ythmmM7475HQ3egLRctdvPN9Oj05I0+
 57uMHoNVp9IW7g6Ek44iTxOKr+Pd5xI9IpOqFpFbPtFGg07UdNG8LfEVEDgwoI4hoyRz
 GkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769679641; x=1770284441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d11P5odMi2PPU8b2iY2QkvZyI7ohVdkAvPbjBsjFl6s=;
 b=WVjw+e9Blo77hpJ4/xA8CkSfNjRQkmW5XuIluzVP0uBlFvtUAnQzkFUj1bm4pqhR9b
 JXxjB+Yn4EqRUuJYfKC5EvXXARZgDT+ym6kFc/RkWoi8o3Z1JkhLo8bZxyFM/xVs4iQ7
 /PTzteavJwgDEagyQEDQeuIR3NWF7hSKiJiCVrwxD8F4F2XNRvsoBEk9cwzmagZqxy4B
 sLZPTTZs2Hw4DdregQIeuol90MgNPIeFkXYMFI/DRKNvPkq3JH65iRpafAK/TQhxe1d/
 NV+QuWP9+mt6Fwizj07YfJZSeFvC5TkVh55uCt+h5lLJtD3xJprKAI6hLtcAuYovSkl9
 L5sg==
X-Gm-Message-State: AOJu0YyRs/FbJpZnS1n/wCKGvM2o5TZQ/Sap9gCqmlJPl80XTW4MQMHB
 mBnzUUIm81lEvyKt8TY6kZmE9Goa8WvB3TsSoXGfDgf4Wl2AT0Gxg2ki
X-Gm-Gg: AZuq6aID2fZn2Wh+AVp9eouRgQVRSd7hhToKoOrdPnwPLgNtLi1dEAZHDfG8MQpQY0i
 M+kX6Z017D9sy1XyMS4cqYhDL+p8qW0Mo+gVsEEsU/hxC7RM7fWj5JcQJvhtuqhW1MwRjbm5KQH
 avsxSN+KKbBw3H3K8M9GEq1nUXWVaw1bmYCcmUTDboq5LLNN/kDExij3WuutsDdSZ6Mrp1jhQ8i
 GszcN9vozi/s9nZJdw2QkJaiE4gvJPtbO0tcHp+D1ETazdpW/okZh1DyAJlBwZc8VSS7Xbf9Mur
 5Voc2NFMdcP9foRa3xyipNFUkDR7d+uzy2rsKd1XPWo8HmEgRyB2NhHs2Ad0+9C0wv933pZDDXQ
 2mC6/A6JnuF5qbrH0HNfHirZU9qB+hmUT3s0K5UBYeOvxCS8zHblx00C+HPV465kKE2PgAFS3nM
 BeFbjkFGNVI0GIOu8f6/ip6G14+4/5kj3ixJhhouOc+eY/ePCXw6cPBWD2
X-Received: by 2002:a17:90b:2ccd:b0:34a:4cc0:9e38 with SMTP id
 98e67ed59e1d1-353fece37a0mr6773410a91.10.1769679641402; 
 Thu, 29 Jan 2026 01:40:41 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.20.6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3540f3cc7c6sm4871990a91.10.2026.01.29.01.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 01:40:41 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v2 0/2] tests/qtest: Add RISC-V IOMMU bare-metal test
 using iommu-testdev
Date: Thu, 29 Jan 2026 17:39:49 +0800
Message-ID: <cover.1769678103.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj1-x1042.google.com
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

This patch series adds a bare-metal qtest for the RISC-V IOMMU using the
iommu-testdev framework. The test exercises address translation paths
without requiring a full guest OS boot.

Motivation
----------

The existing RISC-V IOMMU qtest (riscv-iommu-test.c) focuses on PCI device
enumeration and register-level validation:
- PCI configuration space verification (vendor/device ID)
- Register reset value checks
- Queue initialization procedures (CQ/FQ/PQ)

However, it does not test the actual address translation functionality.
This new test fills that gap by using iommu-testdev to trigger DMA
transactions and validate the IOMMU's translation logic.

Comparison with Existing Test
-----------------------------

| Feature               | riscv-iommu-test.c | iommu-riscv-test.c (new) |
|-----------------------|--------------------|--------------------------|
| PCI config            | Yes                | No                       |
| Register reset        | Yes                | No                       |
| Queue init            | Yes                | Yes (via helper)         |
| Bare translation      | No                 | Yes                      |
| S-stage (SV39)        | No                 | Yes                      |
| G-stage (SV39x4)      | No                 | Yes                      |
| Nested translation    | No                 | Yes                      |
| DMA verification      | No                 | Yes                      |
| Uses iommu-testdev    | No                 | Yes                      |

The new test provides:
- Device context (DC) configuration and validation
- SV39 page table walks for S-stage translation
- SV39x4 page table walks for G-stage translation
- Nested translation combining both stages
- FCTL register constraint validation
- End-to-end DMA verification

Note: The current implementation only supports SV39/SV39x4. Support for
SV48/SV48x4/SV57/SV57x4 can be added in future patches.

Testing
-------

QTEST_QEMU_BINARY=./build/qemu-system-riscv64 \
  ./build/tests/qtest/iommu-riscv-test --tap -k

Changes v1 -> v2
----------------
- Removed unused 'mode' parameter from qriommu_get_pte_attrs() function
- Simplified PTE mask definitions in header file by using direct hex
  values instead of individual bit defines (removed QRIOMMU_PTE_V/R/W/X
  /U/G/A/D macros), added comment referencing target/riscv/cpu_bits.h
- Cleaned up variable declarations in qriommu_setup_translation_tables()
  to follow C99 style (declare at point of use)
- Minor code style improvements


Thanks,
Chao

Chao Liu (2):
  tests/qtest/libqos: Add RISC-V IOMMU helper library
  tests/qtest: Add RISC-V IOMMU bare-metal test

 MAINTAINERS                          |   2 +
 tests/qtest/iommu-riscv-test.c       | 279 ++++++++++++++++++
 tests/qtest/libqos/meson.build       |   2 +-
 tests/qtest/libqos/qos-riscv-iommu.c | 405 +++++++++++++++++++++++++++
 tests/qtest/libqos/qos-riscv-iommu.h | 164 +++++++++++
 tests/qtest/meson.build              |   5 +-
 6 files changed, 855 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/iommu-riscv-test.c
 create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
 create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h

-- 
2.52.0


