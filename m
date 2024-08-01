Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC600C52D54
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXy5-0006Ls-Bf; Thu, 01 Aug 2024 11:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZXxx-0006Hr-MM
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:43:47 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZXxv-0004up-Ba
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:43:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70eb73a9f14so5346567b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722527021; x=1723131821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z4eXq8oEdUXQrhLUHBWnxm31duZG6qEdQtX+afbt/hw=;
 b=LaqLLB/0Osa7mTKRtRFaP0FyZiCYmNqnCirgbiioZkM8kx/DaxOvPcTri7gtXYhTZg
 90+QCgJnAeFAH1XleLJYRQY8XgICtDbbHKGXXhJiWZfijYMpEocQKpM1MEWjX4pDkO3H
 OpMX+xQifvvioth4u9T7EuXgctOKccGI6b1y7+s8gDQM4qYNger/AvYZBHuvTK4ukqvt
 KS1VbAB/zqmBZx4NBa/F7qCLITCRQliF663e+WMlV5ZZKo965JHWpVdMQ0DzdRRr7wqv
 m8sqKauShTbZeRME+7nkIV3QhORYrUVfHkkg1KFsqjkdT4R890fGJxugnbyFeNfzF8cG
 Uaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722527021; x=1723131821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z4eXq8oEdUXQrhLUHBWnxm31duZG6qEdQtX+afbt/hw=;
 b=O5/pWLmzuJPedQeGVp4B/82A4AFtAuPgvD5yRYmXwH0ABMPXrjO14QZNNrJxyGMEv1
 FaNFk+zD6FyGO/Uj/7qA8U77f3/Kz1IIkFmj63bBjam0a0rXGNkudd0XfnAFmbPv2kxH
 0K8TKIheBBYXBk8a3CkSS6S1DtD3fvQkwDHUdOQMkxsbv5Mantx0KuGxSmTrPTF4HhS2
 ZOfFIqfcOXv43afzBX/2s26WvnYZbhscbCuoXNYnUARsAx8kt+EMeqjahgUvf60LR+rT
 +SOM/whCF5F2mwR+BsQN48qWywx8fOA3OeRuW3xKUXS2K4sRaBwBj1H6FJ9tx8dpMfEc
 B+ug==
X-Gm-Message-State: AOJu0YzPC9UlxSpRowjbqLiRnJzLgw5t1lo+X/VfRO32lTZmAmxCmHkf
 w9VQNDlBd89575U3AOC/EUy6WTcfGv/jh2ienyv+D2q8G2HCVAGHLdtEtd8Hg70AuFpzcKWXF8Z
 h
X-Google-Smtp-Source: AGHT+IGFntwRqLdom6EBVR6T/u+hqt8M7IKN7JdQEWm0A5GGoyGDCwwtuHSckDwYmlLEX8jGM8vOXw==
X-Received: by 2002:a05:6a00:4b11:b0:70d:2b95:d9c0 with SMTP id
 d2e1a72fcca58-7106cfd2249mr820269b3a.14.1722527021270; 
 Thu, 01 Aug 2024 08:43:41 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.197.107.101])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b762e9c650sm17183a12.16.2024.08.01.08.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:43:40 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 jason.chien@sifive.com, frank.chang@sifive.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.2 v6 00/12] riscv: QEMU RISC-V IOMMU Support
Date: Thu,  1 Aug 2024 12:43:21 -0300
Message-ID: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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

Hi,

In this new version the most notable change is how we're dealing with
ICVEC updates. Instead of hardcoding the vectors being used in
riscv-iommu-pci, a new interface was created to allow IOMMU devices to
receive ICVEC updates and act accordingly.

riscv-iommu-pci will receive this notification, mark any existing MSIX
vectors as 'unused' and use the new ones provided by ICVEC.

Series based on master. 

Patches missing acks/reviews: 3, 12

Changes from v5:
- patch 11: dropped
- patch 2:
  - align RISCV_IOMMU_REG_SIZE
- patch 3:
  - RISCV_IOMMU_REG_IVEC renamed to RISCV_IOMMU_REG_ICVEC to match the
    reg name used in the specification
  - created riscv_iommu_process_icvec_update() to process updates done
    in ICVEC (via riscv_iommu_mmio_write())
  - created a new 'icvec_update' interface to allow devices to receive
    new ICVEC vectors
  - added riscv_iommu_mrif_notification trace at the end of
    riscv_iommu_msi_write()
- patch 5:
  - added a new icvec_vectors[] RISCVIOMMUStatePci property
  - created a new riscv_iommu_pci_icvec_update() function that
    implements the new 'icvec_update' IOMMU interface. This function
    will update all MSIX vector usage based on the current CIV, FIV,
    PMIV and PIV values
- patch 12 (former 13):
  - added more details on what to expect when adding a riscv-iommu-pci
    device in the 'virt' machine
- v5 link: https://lore.kernel.org/qemu-riscv/20240708173501.426225-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (4):
  pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
  test/qtest: add riscv-iommu-pci tests
  qtest/riscv-iommu-test: add init queues test
  docs/specs: add riscv-iommu

Tomasz Jeznach (8):
  exec/memtxattr: add process identifier to the transaction attributes
  hw/riscv: add riscv-iommu-bits.h
  hw/riscv: add RISC-V IOMMU base emulation
  hw/riscv: add riscv-iommu-pci reference device
  hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
  hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
  hw/riscv/riscv-iommu: add ATS support
  hw/riscv/riscv-iommu: add DBG support

 docs/specs/index.rst             |    1 +
 docs/specs/pci-ids.rst           |    2 +
 docs/specs/riscv-iommu.rst       |   80 +
 docs/system/riscv/virt.rst       |   13 +
 hw/riscv/Kconfig                 |    4 +
 hw/riscv/meson.build             |    1 +
 hw/riscv/riscv-iommu-bits.h      |  417 ++++++
 hw/riscv/riscv-iommu-pci.c       |  208 +++
 hw/riscv/riscv-iommu.c           | 2392 ++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.h           |  152 ++
 hw/riscv/trace-events            |   15 +
 hw/riscv/trace.h                 |    1 +
 hw/riscv/virt.c                  |   33 +-
 include/exec/memattrs.h          |    5 +
 include/hw/pci/pci.h             |    1 +
 include/hw/riscv/iommu.h         |   36 +
 meson.build                      |    1 +
 tests/qtest/libqos/meson.build   |    4 +
 tests/qtest/libqos/riscv-iommu.c |   76 +
 tests/qtest/libqos/riscv-iommu.h |  100 ++
 tests/qtest/meson.build          |    1 +
 tests/qtest/riscv-iommu-test.c   |  234 +++
 22 files changed, 3776 insertions(+), 1 deletion(-)
 create mode 100644 docs/specs/riscv-iommu.rst
 create mode 100644 hw/riscv/riscv-iommu-bits.h
 create mode 100644 hw/riscv/riscv-iommu-pci.c
 create mode 100644 hw/riscv/riscv-iommu.c
 create mode 100644 hw/riscv/riscv-iommu.h
 create mode 100644 hw/riscv/trace-events
 create mode 100644 hw/riscv/trace.h
 create mode 100644 include/hw/riscv/iommu.h
 create mode 100644 tests/qtest/libqos/riscv-iommu.c
 create mode 100644 tests/qtest/libqos/riscv-iommu.h
 create mode 100644 tests/qtest/riscv-iommu-test.c

-- 
2.45.2


