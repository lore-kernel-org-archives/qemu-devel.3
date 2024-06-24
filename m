Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0023C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLq9F-00044S-1L; Mon, 24 Jun 2024 16:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLq9D-00043X-9f
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:18:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLq9B-0003cf-6Z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:18:43 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70679845d69so1256524b3a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719260319; x=1719865119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g76zPzSgQd+0uPDGQrxZD14FtJHUyV+9tTI/67sKPlI=;
 b=S+FflkK8vXl61BFzxuwNHacZqHi0v4c3GRiTVkjdWJSCE3kWk4p/HFKVxjTNzFwcRc
 VWlhDOQdlOkntQ4AlyyLvsN6trHajNy9hcPRP4PJS4wdLXgN/5vMXs0M2WVZhKUPo6TF
 J9tkjPBaBZNCuadpIO7UhiXmSYywBYwfB35bLSiIcKbx3sjJjiIVBKnEWNbQ40WLjmin
 vWFtKmzlFE0liELraSwzFH89dmNti9WhlxubsVpC+Ov2xM77re3XtN38OMqyDTmtRtRx
 De1FIhlZ6mY14StDI3K6bSYD6hvDUSw/R73fEM+2xK39ZOyq6FLuduynaWvKaO+9tO2M
 L9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719260319; x=1719865119;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g76zPzSgQd+0uPDGQrxZD14FtJHUyV+9tTI/67sKPlI=;
 b=R8GNmxFHVdPqJMumyxxxipW2egKtTq+Xnu6YenvYrALu8KjJKv4k4zMa2gG2oSaDHS
 4KLECehpVDt25NBzMF60cxsDlZSqA0XRT4VdDruVrXDTTe/3NWJq2DoQtJXLn1nyd1C5
 ZvCJTwv5p2Gy1S3/zdicie3ASyr4+aRI4uUMcZtpJZqoNKjE0Bu40ILg7U/8NLoQGwZ2
 H2grqJVp3xE0XwfTYMjGgOMLyOXe4/R2D5j3GMLYA4YtRQFprgFP3u/UFVH40u668HCJ
 72qaDYeg4s25Xtom0fidn300AprRECLpUXtlWEAAWMpVKyKZFhVPWNKyS7PiYUwj+/Xs
 OOSA==
X-Gm-Message-State: AOJu0YzZ2il9Y0nzcveauGOrsl8lsTudCfeh8cFQb18gILdIO6Z16/wb
 7SrWLPqtDoky1fX7EWVefupKgtGD0XU2fByaTOsMogBu5nEjJMOERZZgSkmH5GQaXNcXycWBkUz
 n
X-Google-Smtp-Source: AGHT+IELKGTyKiuzD5MyQcYVO7uD7E8OPmq13SUj81zm6zis9KiiKRj937LIBucrqv7Umpmm5lAVlQ==
X-Received: by 2002:a05:6a00:22cb:b0:706:6248:93e with SMTP id
 d2e1a72fcca58-7067455bec8mr6420094b3a.1.1719260318989; 
 Mon, 24 Jun 2024 13:18:38 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70688f2d76bsm1927091b3a.41.2024.06.24.13.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 13:18:38 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com, frank.chang@sifive.com,
 jason.chien@sifive.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 00/14] riscv: QEMU RISC-V IOMMU Support
Date: Mon, 24 Jun 2024 17:18:10 -0300
Message-ID: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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

This new version contains changes based on suggestions made during the
v3 review [1]. Most notable changes:

- read/write locks were added in both ctx_lock and iot_lock. This code
  was picked from Tomasz branch;
- a new riscv_iommu_validate_process_ctx() helper was added to make
  process-context validations. Suggested by Jason Chien;
- a new doc patch was added to document how the IOMMU can be used by the
  'virt' RISC-V board. Suggested by Alistair.

Patches based on alistair/riscv-to-apply.next. It's also applicable on
master.

Patches missing reviews/acks: 3, 9, 14

* How it was tested *

This series was tested using an emulated QEMU RISC-V host booting a QEMU
KVM guest, passing through an emulated e1000 network card from the host
to the guest. 

The Linux kernel used for tests can be found here:

https://github.com/tjeznach/linux/tree/riscv_iommu_v6-rc3


Changes from v3:
- patch 3:
  - added FCTL_BE and FCTL_WSI bits to regs_ro[] mask
  - renamed 'ctx->pasid' to 'ctx->process_id'
  - added device translation cache update lock ctx_lock
  - DC.tc.V == 0 is now checked before riscv_iommu_validate_device_ctx()
  - PC.ta.V == 0 now issues a "PDT entry not valid" error in the end of
    riscv_iommu_validate_device_ctx()
  - added a new riscv_iommu_validate_process_ctx() helper to validate PC
    as section 2.2.4 dictates
- patch 5:
  - added RISCV_PCI_CLASS_SYSTEM_IOMMU macro and use it in k->class_id
- patch 8:
  - added update lock iot_lock
- patch 9:
  - added FSC related checks to riscv_iommu_validate_process_ctx()
  - moved 'if (mode == bare)' check to happen after ctx->process_id ==
    noprocid check 
- patch 14 (new):
  - add riscv-iommu docs for more information on how to use the
    riscv-iommu-pci device
- v3 link: https://lore.kernel.org/qemu-riscv/20240523173955.1940072-1-dbarboza@ventanamicro.com/

[1] https://lore.kernel.org/qemu-riscv/20240523173955.1940072-1-dbarboza@ventanamicro.com/


Andrew Jones (1):
  hw/riscv/riscv-iommu: Add another irq for mrif notifications

Daniel Henrique Barboza (4):
  pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
  test/qtest: add riscv-iommu-pci tests
  qtest/riscv-iommu-test: add init queues test
  docs/specs: add riscv-iommu

Tomasz Jeznach (9):
  exec/memtxattr: add process identifier to the transaction attributes
  hw/riscv: add riscv-iommu-bits.h
  hw/riscv: add RISC-V IOMMU base emulation
  hw/riscv: add riscv-iommu-pci reference device
  hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
  hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
  hw/riscv/riscv-iommu: add s-stage and g-stage support
  hw/riscv/riscv-iommu: add ATS support
  hw/riscv/riscv-iommu: add DBG support

 docs/specs/index.rst             |    1 +
 docs/specs/pci-ids.rst           |    2 +
 docs/specs/riscv-iommu.rst       |   55 +
 docs/system/riscv/virt.rst       |   13 +
 hw/riscv/Kconfig                 |    4 +
 hw/riscv/meson.build             |    1 +
 hw/riscv/riscv-iommu-bits.h      |  419 ++++++
 hw/riscv/riscv-iommu-pci.c       |  178 +++
 hw/riscv/riscv-iommu.c           | 2372 ++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.h           |  148 ++
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
 22 files changed, 3699 insertions(+), 1 deletion(-)
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


