Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFC8C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 06:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAOCF-0001tV-V4; Fri, 24 May 2024 02:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAOCE-0001sF-3R
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:14:30 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAOC8-00012s-SH
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:14:29 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5b5254f9c32so2762100eaf.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 23:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716531262; x=1717136062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NjkOvgDbjVLbH8iHglbx6OMXoUkh/TvoCmLRRr9I1og=;
 b=dieI3telKxSrzLwkPATeSv/WsN/mEbtT7CrzkYH6Y3UlYIQRg9a5OYG2ke/UHYFHWR
 w50HHmfce84hROoh2DbvaHj8jciVhYMMwH8OMH5wOlQWZHqYOzbj7+RqW26Kx6oVBjQq
 t7n/1ARwMoaJadCROnsFkDa+MKon5J8vORGuEiMHIylkUStYIE07ksamfMvxyatQFydO
 7D2Rit1905QhP7X4ASLr0TxEL8IhHmhXxXCt6VmV2Hvf9KtcHsRv9NgPq47+H016e9pR
 +jAiOIx5s7/GkuQlaJJ3IoscKQZ0rTQ9hMWDHGGlt0uTWv0KYmYmoEeyCuxnWJzPMn08
 kgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716531262; x=1717136062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NjkOvgDbjVLbH8iHglbx6OMXoUkh/TvoCmLRRr9I1og=;
 b=Pw2vgo9Js31NCXFdBZuanx9d1/7dx0sMcdiwc+VL3finym0JJIvzcs35bc9mAFuCcf
 h4OchaVknDNZ+ocJAfkQqhMvtI+w7zCUshBkRO6zQQ/l7jzvW7iPJAH6pnECL0F9czR7
 1Rw5PgHlzOSQZ5n5MkHi8pnRi9FkAu76SSLDMawe3YjqQ+60PH3LGDUfphT61g4M0Ogs
 8BvMVHa636uh0vS0OkYMEey0CDYxBoNwUPXwPgIg61CVPRDDfVigIdxmJdBXqajyTQQn
 +8LPNZSsgxoeR3BPD81v60hhT33fQsEEC1w/vcf+XA0BM1/B7oLTEqaQmJFcEK9Vhx14
 NNNQ==
X-Gm-Message-State: AOJu0YwHklNx7bieHQjv827CUWCoQQ+r0G3MVG7WRcNXbs9Zo0ir2THA
 cXz/XbONyNQskXoe4zkLZFX4DlIN0WHhHh1kqWYWssnqs+XXACMjiSCPzVdKu7qfha8UAsH4Wk6
 ZSj4=
X-Google-Smtp-Source: AGHT+IHYdAu9LEV9SYVhFJpXo/ncrfG/vec/ev1bfgPR1rpJ6+VvkvwTW+gc8eQUSxuyBtf3iaXXug==
X-Received: by 2002:a05:6871:725:b0:245:41f0:ce13 with SMTP id
 586e51a60fabf-24ca11de76amr1505731fac.9.1716531261848; 
 Thu, 23 May 2024 23:14:21 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.31])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcbea487sm516106b3a.107.2024.05.23.23.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 23:14:21 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Haibo1 Xu <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 00/12] Add support for RISC-V ACPI tests
Date: Fri, 24 May 2024 11:43:59 +0530
Message-Id: <20240524061411.341599-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oo1-xc29.google.com
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

Currently, bios-table-test doesn't support RISC-V. This series enables
the framework changes required and basic testing. Things like NUMA
related test cases will be added later.

This needs refactoring/renaming of ARM64 bios table tests. Importantly,
the test cases now look for the expected AML files under
tests/data/acpi/virt/aarch64 path instead of directly under
tests/data/acpi/virt. To keep test cases not to fail because of this
movement, they are updated to look for both paths first.

As part of this effort, it is found that uefi-test-tools is currently
broken to build. So, updated its Makefile as well to use python based
edk2 build script.

The changes are also available at branch
https://gitlab.com/vlsunil/qemu/-/tree/riscv_bios_table_test_v2

Changes since v1:
	1) Addressed feedback from Gerd and Alistair
	2) Rebased and added tags received

Sunil V L (12):
  uefi-test-tools/UefiTestToolsPkg: Add RISC-V support
  uefi-test-tools: Add support for python based build script
  tests/data/uefi-boot-images: Add RISC-V ISO image
  qtest: bios-tables-test: Rename aarch64 tests with aarch64 in them
  tests/qtest/bios-tables-test.c: Add support for arch in path
  tests/data/acpi/virt: Move ACPI tables under aarch64
  meson.build: Add RISC-V to the edk2-target list
  pc-bios/meson.build: Add support for RISC-V in unpack_edk2_blobs
  tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
  tests/qtest/bios-tables-test: Add empty ACPI data files for RISC-V
  tests/qtest/bios-tables-test.c: Enable basic testing for RISC-V
  tests/qtest/bios-tables-test: Add expected ACPI data files for RISC-V

 meson.build                                   |   2 +-
 pc-bios/meson.build                           |   2 +
 tests/data/acpi/rebuild-expected-aml.sh       |   5 +-
 tests/data/acpi/virt/{ => aarch64}/APIC       | Bin
 .../acpi/virt/{ => aarch64}/APIC.acpihmatvirt | Bin
 .../acpi/virt/{ => aarch64}/APIC.topology     | Bin
 tests/data/acpi/virt/{ => aarch64}/DBG2       | Bin
 tests/data/acpi/virt/{ => aarch64}/DSDT       | Bin
 .../acpi/virt/{ => aarch64}/DSDT.acpihmatvirt | Bin
 tests/data/acpi/virt/{ => aarch64}/DSDT.memhp | Bin
 tests/data/acpi/virt/{ => aarch64}/DSDT.pxb   | Bin
 .../acpi/virt/{ => aarch64}/DSDT.topology     | Bin
 tests/data/acpi/virt/{ => aarch64}/FACP       | Bin
 tests/data/acpi/virt/{ => aarch64}/GTDT       | Bin
 .../acpi/virt/{ => aarch64}/HMAT.acpihmatvirt | Bin
 tests/data/acpi/virt/{ => aarch64}/IORT       | Bin
 tests/data/acpi/virt/{ => aarch64}/MCFG       | Bin
 tests/data/acpi/virt/{ => aarch64}/NFIT.memhp | Bin
 tests/data/acpi/virt/{ => aarch64}/PPTT       | Bin
 .../acpi/virt/{ => aarch64}/PPTT.acpihmatvirt | Bin
 .../acpi/virt/{ => aarch64}/PPTT.topology     | Bin
 tests/data/acpi/virt/{ => aarch64}/SLIT.memhp | Bin
 tests/data/acpi/virt/{ => aarch64}/SPCR       | Bin
 .../acpi/virt/{ => aarch64}/SRAT.acpihmatvirt | Bin
 tests/data/acpi/virt/{ => aarch64}/SRAT.memhp | Bin
 .../data/acpi/virt/{ => aarch64}/SRAT.numamem | Bin
 tests/data/acpi/virt/{ => aarch64}/SSDT.memhp | Bin
 tests/data/acpi/virt/{ => aarch64}/VIOT       | Bin
 tests/data/acpi/virt/riscv64/APIC             | Bin 0 -> 116 bytes
 tests/data/acpi/virt/riscv64/DSDT             | Bin 0 -> 3518 bytes
 tests/data/acpi/virt/riscv64/FACP             | Bin 0 -> 276 bytes
 tests/data/acpi/virt/riscv64/MCFG             | Bin 0 -> 60 bytes
 tests/data/acpi/virt/riscv64/RHCT             | Bin 0 -> 314 bytes
 tests/data/acpi/virt/riscv64/SPCR             | Bin 0 -> 80 bytes
 .../bios-tables-test.riscv64.iso.qcow2        | Bin 0 -> 16896 bytes
 tests/qtest/bios-tables-test.c                |  93 ++++++++++++++----
 tests/qtest/meson.build                       |   3 +
 tests/uefi-test-tools/Makefile                |  19 ++--
 .../UefiTestToolsPkg/UefiTestToolsPkg.dsc     |   6 +-
 tests/uefi-test-tools/uefi-test-build.config  |  52 ++++++++++
 40 files changed, 147 insertions(+), 35 deletions(-)
 rename tests/data/acpi/virt/{ => aarch64}/APIC (100%)
 rename tests/data/acpi/virt/{ => aarch64}/APIC.acpihmatvirt (100%)
 rename tests/data/acpi/virt/{ => aarch64}/APIC.topology (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DBG2 (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DSDT (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DSDT.acpihmatvirt (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DSDT.memhp (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DSDT.pxb (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DSDT.topology (100%)
 rename tests/data/acpi/virt/{ => aarch64}/FACP (100%)
 rename tests/data/acpi/virt/{ => aarch64}/GTDT (100%)
 rename tests/data/acpi/virt/{ => aarch64}/HMAT.acpihmatvirt (100%)
 rename tests/data/acpi/virt/{ => aarch64}/IORT (100%)
 rename tests/data/acpi/virt/{ => aarch64}/MCFG (100%)
 rename tests/data/acpi/virt/{ => aarch64}/NFIT.memhp (100%)
 rename tests/data/acpi/virt/{ => aarch64}/PPTT (100%)
 rename tests/data/acpi/virt/{ => aarch64}/PPTT.acpihmatvirt (100%)
 rename tests/data/acpi/virt/{ => aarch64}/PPTT.topology (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SLIT.memhp (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SPCR (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SRAT.acpihmatvirt (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SRAT.memhp (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SRAT.numamem (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SSDT.memhp (100%)
 rename tests/data/acpi/virt/{ => aarch64}/VIOT (100%)
 create mode 100644 tests/data/acpi/virt/riscv64/APIC
 create mode 100644 tests/data/acpi/virt/riscv64/DSDT
 create mode 100644 tests/data/acpi/virt/riscv64/FACP
 create mode 100644 tests/data/acpi/virt/riscv64/MCFG
 create mode 100644 tests/data/acpi/virt/riscv64/RHCT
 create mode 100644 tests/data/acpi/virt/riscv64/SPCR
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2
 create mode 100644 tests/uefi-test-tools/uefi-test-build.config

-- 
2.40.1


