Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891AEE8783A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHNK-0001w5-2R; Tue, 03 Feb 2026 09:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnHNG-0001ve-Pg
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:27:28 -0500
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnHNF-0004Rd-9l
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:27:26 -0500
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2b81ebac5d6so1833389eec.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 06:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770128842; x=1770733642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LhNgqORnWC5izm/emsuA+eqwGXyXBWpIwmLVxu3NZwg=;
 b=WmkN+0m4I3En30CJiY7NAuk2g2sVmwJQm880/aoryh7JeFJi7ER1diiRTWyWSdnG0W
 BntZ7K2F+L2e+t7HFFnjJ05zivP7RMumLQTTe1MK3XaoMxgws0MOEe6Pz6F51dRcbetX
 X2DfnEwOgK7bpbe+lPOnD9SzDNbmIc/PC/1rT8QfjH7ImN47x18ib2+RUSvma21a9O0d
 61lZDUcM4jHHMDhjeKYda/ocKV9Pwp9Tgh0pUSUu4Z8SXvY3/w8Bslnu+mJ1i7iqkbFY
 rBQb0gPsTlHAkvGqII6g+nVJKRyIY9PgK0Psf6Me5jmE8OX/7qGsLgjA8yOr8cpjp5tS
 zj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770128842; x=1770733642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhNgqORnWC5izm/emsuA+eqwGXyXBWpIwmLVxu3NZwg=;
 b=Ss7KnmVA9ADzpxV4mXIVKJNhxbc9zsZ3nFM5DBQMzhyZuBX0f21Nlm8F3etxxXhE75
 fTGIcICewUPiEVe+QVChxijmlULV7JndZNK/7uYbsSIO7QPHAOBWMh3a+nCuGKcQL7pS
 hNJQirkYY51ACzSY+xxM2hfkhw0kgtX78xfY2Kk6CDuGRkbXCtCOXPBRVOGWNnagD5Er
 wrS2RG88/yAg9lTdeNGf4UtUq/S3nFaGs9YMv4gX6WLi291XkPQ0MrrxsbdzHxzPWgTh
 Tigm2JqYyg2wdGmMeS3B/KFmISI3mo2irzYUNDNwWaKozx0Q85j2OEfY5LD+V4NiHAA/
 Q0rA==
X-Gm-Message-State: AOJu0YzhEY1zeOD/W4UBee0peUzpPfFg4M0thzdqPWca/Zc9POuXVsAb
 BRcJMiq0dRSQXZOYN3SQoxz3hreomwmqKt2v4ErpOKNOFidexO79a6Nm
X-Gm-Gg: AZuq6aJiR36Wm4mms1CjdE0QJCRixf8hVpp6eluPlfAe435NyJWfkGFL2H+cYoj8ZN8
 FA/MdTxxtCsEMEtF13+hv1QU1MSoqO0cFUTtIvhythxx7fji/qvksWGHGcojDKKlu1eFWdpTmRB
 l0sbbu/+vuAD89hpqDbIkdt/hO+BvCVUiEqzwZweyxfW02CTQrH6EZwnsv67qFrH7SK5QMRapVd
 McBP2yg/gml2zNp8m0VUBZFm1OlEPViXVcn1DOos79e+iqfxDPvCLHOgW0yodmr3eOwunPJKiFl
 LafjclGbdoLlgN8QfdJgMErTA8l9vUhYw6GKvlc6pCdY8hGo4ks6FY2BHMNkfWAHi4NxtNiofT/
 IdaopHCIyRn/IH8OmzbSqXKJxb9mos+AHto1tqoER7gfjVXh3iBWG9jrXjWtXYK15rAr9Rluztn
 9ExjppTHu8cNhKW47Y8wiloyW/aHdQIawEBgdUVam5t7gSzRyOs/GlLkjXg03ZdWqakoreGufnP
 ls8CydoCmYTVcYa6Zgz0nWsOQ==
X-Received: by 2002:a05:7301:7c03:b0:2b4:700b:3d8b with SMTP id
 5a478bee46e88-2b7c8940881mr7288505eec.37.1770128842163; 
 Tue, 03 Feb 2026 06:27:22 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a1af898asm24194529eec.33.2026.02.03.06.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 06:27:21 -0800 (PST)
From: chao.liu.zevorn@gmail.com
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v3 0/2] tests/qtest: Add RISC-V IOMMU bare-metal test using
 iommu-testdev
Date: Tue,  3 Feb 2026 22:27:04 +0800
Message-ID: <cover.1770127918.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

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

Changes v2 -> v3
----------------
- Removed duplicate header includes in both patches (Tao)
- Fixed memory leak of state->iommu_dev and state->testdev in
  riscv_iommu_test_setup() in patch 2 (Fabiano)

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
 tests/qtest/iommu-riscv-test.c       | 279 +++++++++++++++++++
 tests/qtest/libqos/meson.build       |   2 +-
 tests/qtest/libqos/qos-riscv-iommu.c | 403 +++++++++++++++++++++++++++
 tests/qtest/libqos/qos-riscv-iommu.h | 164 +++++++++++
 tests/qtest/meson.build              |   5 +-
 6 files changed, 853 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/iommu-riscv-test.c
 create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
 create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h

-- 
2.53.0


