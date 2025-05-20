Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6259AC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKmz-0006ZY-Jf; Tue, 20 May 2025 07:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKmx-0006YC-G6
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKmv-0002yr-KP
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F/IHqHeQSPs0xLbiwFrGhlfgQpdXt/rKlioayxv+ryA=;
 b=OvzBqbgH7znHF2Wgr+KccfXFWNlt0nj/JsIJeZATHpxsPCJ1l2oVSQHhU9wVMyY8P+/lc/
 ujjhGAJ16NL8A/0ISRw3YGAFWiArvncGqNlY5Y0u3VdWzoLkrPqZkiirPB4TuVHAfQhN/I
 xv7VoAMTGuIVzAzrgjn9EQ0Xk/Qtxmc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-V9Jp0-BOPlyTX9fbfJr2Ng-1; Tue, 20 May 2025 07:05:35 -0400
X-MC-Unique: V9Jp0-BOPlyTX9fbfJr2Ng-1
X-Mimecast-MFC-AGG-ID: V9Jp0-BOPlyTX9fbfJr2Ng_1747739134
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac6ce5fe9bfso552152066b.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739133; x=1748343933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F/IHqHeQSPs0xLbiwFrGhlfgQpdXt/rKlioayxv+ryA=;
 b=OzYEiMlzYNnky3314L00cfPiTzxfOGRvYNQJMpmSTq1b0bYmR8WB909LAzP92w8rEV
 ZCm5+WxBLIm04RlellsxurcWTaQeDQm3lmNAhAweLGT02B0/+6TjjRLuxpziUrih4Sb5
 uSvofH9B7gXA7jTP9h07fGg6R+FIXthXhrAOGehP1Izoc8mUr4KxaB9YZ8nxQ08Erjg+
 5f+e8UQsVMlUUig4S3dorqGGU19EfoT7gL0xIMh/s953xly1i+OTwRkBl1Aa+VOesQDW
 l4YoTMvT0bjcGKbQBzkqB+Kr4JrHKsUeZzo9YWksANsb8ycZRGLnv2/EQQLUojP2/qVG
 7Tqw==
X-Gm-Message-State: AOJu0YxCD1r+NiX0DeDAYJgJLb5ghTc57FNJehp0W/6jeAjkMDQdXAHQ
 rLycaFQwU1WE0Lu8VpLocpeOuGkLLlV3V95I9RlQcrRwbielbKCAT7JtElP6NgKLyzK673FThZD
 GvGeZtOHB5OC8qQcquBvKWetntmZhxTgew/tYejbe4L3a6qzqzuXFAnNnKf0PgUrlTWZ8nBKIeq
 /BYHXFlZSjC+ET2IMmLeEuqTG/OxTiE3b0GHgLpgb0
X-Gm-Gg: ASbGnctMrCPIgfh8DAooytHAvQhFD5pEKozVQ+RVfVOYo1FkwNYGN3q/5Nkb/oYnKiK
 AUONVBE2nlXzH+QKwINO7tO5QvEu9IkprSzU08Q4q4KLnFGlLailuuAN8Sj1IJx/MC2AygpCZIC
 oxx9mCg9KXTwtfL0Ht7NTcBxhfzvzrEm3rA+CjVbvqGoe52PIEj66sq4l/PHg2tHhxGt6Yr6n/b
 /IZIDYTDzVWZzX4Azfy5q5XlmK7cy0bra4u5Zt2ZA3EkEXKhtQvKSc0B6w6uv+Vgds/zs60Ho8z
 EdhtCsOICuV6lQ==
X-Received: by 2002:a17:907:7f16:b0:ad5:5210:749c with SMTP id
 a640c23a62f3a-ad5521075fbmr934619066b.22.1747739133489; 
 Tue, 20 May 2025 04:05:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB4Y9T3BtwTY4R6E5G+pSpnhIriHFvtVgXLmFiQBENpOdUxho4ljhvhWf4afMLWxKasWhnVw==
X-Received: by 2002:a17:907:7f16:b0:ad5:5210:749c with SMTP id
 a640c23a62f3a-ad5521075fbmr934605166b.22.1747739131582; 
 Tue, 20 May 2025 04:05:31 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6004d501e0esm7312122a12.24.2025.05.20.04.05.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/35] RISCV, i386, endianness fixes for 2025-05-20
Date: Tue, 20 May 2025 13:04:55 +0200
Message-ID: <20250520110530.366202-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 2af4a82ab2cce3412ffc92cd4c96bd870e33bc8e:

  Merge tag 'pull-riscv-to-apply-20250519' of https://github.com/alistair23/qemu into staging (2025-05-19 14:00:54 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 220c739903cec99df032219ac94c45b5269a0ab5:

  qom: reverse order of instance_post_init calls (2025-05-20 08:18:53 +0200)

----------------------------------------------------------------
* target/riscv: clean up supported MMU modes, declarative CPU definitions,
  remove .instance_post_init (reviewed by Alistair)
* qom: reverse order of instance_post_init calls
* qapi/misc-target: doc and standard improvements for SGX
* hw/pci-host/gt64120: Fix endianness handling
* i386/hvf: Make CPUID_HT supported
* i386/tcg: Make CPUID_HT and CPUID_EXT3_CMP_LEG supported

----------------------------------------------------------------
Paolo Bonzini (27):
      hw/riscv: acpi: only create RHCT MMU entry for supported types
      target/riscv: assert argument to set_satp_mode_max_supported is valid
      target/riscv: cpu: store max SATP mode as a single integer
      target/riscv: update max_satp_mode based on QOM properties
      target/riscv: remove supported from RISCVSATPMap
      target/riscv: move satp_mode.{map,init} out of CPUConfig
      target/riscv: introduce RISCVCPUDef
      target/riscv: store RISCVCPUDef struct directly in the class
      target/riscv: merge riscv_cpu_class_init with the class_base function
      target/riscv: move RISCVCPUConfig fields to a header file
      target/riscv: include default value in cpu_cfg_fields.h.inc
      target/riscv: add more RISCVCPUDef fields
      target/riscv: convert abstract CPU classes to RISCVCPUDef
      target/riscv: convert profile CPU models to RISCVCPUDef
      target/riscv: convert bare CPU models to RISCVCPUDef
      target/riscv: convert dynamic CPU models to RISCVCPUDef
      target/riscv: convert SiFive E CPU models to RISCVCPUDef
      target/riscv: convert ibex CPU models to RISCVCPUDef
      target/riscv: convert SiFive U models to RISCVCPUDef
      target/riscv: th: make CSR insertion test a bit more intuitive
      target/riscv: generalize custom CSR functionality
      target/riscv: convert THead C906 to RISCVCPUDef
      target/riscv: convert TT Ascalon to RISCVCPUDef
      target/riscv: convert Ventana V1 to RISCVCPUDef
      target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
      target/riscv: remove .instance_post_init
      qom: reverse order of instance_post_init calls

Rakesh Jeyasingh (2):
      hw/pci-host/gt64120: Fix endianness handling
      hw/pci-host: Remove unused pci_host_data_be_ops

Xiaoyao Li (2):
      i386/tcg: Make CPUID_HT and CPUID_EXT3_CMP_LEG supported
      i386/hvf: Make CPUID_HT supported

Zhao Liu (4):
      qapi/misc-target: Rename SGXEPCSection to SgxEpcSection
      qapi/misc-target: Rename SGXInfo to SgxInfo
      qapi/misc-target: Fix the doc related SGXEPCSection
      qapi/misc-target: Fix the doc to distinguish query-sgx and query-sgx-capabilities

 qapi/misc-target.json             |   26 +-
 include/hw/pci-host/dino.h        |    4 -
 include/hw/pci/pci_host.h         |    1 -
 include/qom/object.h              |    3 +-
 target/riscv/cpu-qom.h            |    2 +
 target/riscv/cpu.h                |   42 +-
 target/riscv/cpu_cfg.h            |  178 +------
 target/riscv/cpu_cfg_fields.h.inc |  170 +++++++
 hw/i386/sgx-stub.c                |    4 +-
 hw/i386/sgx.c                     |   32 +-
 hw/pci-host/gt64120.c             |   82 +--
 hw/pci/pci_host.c                 |    6 -
 hw/riscv/boot.c                   |    2 +-
 hw/riscv/virt-acpi-build.c        |   15 +-
 hw/riscv/virt.c                   |    5 +-
 qom/object.c                      |    8 +-
 target/i386/cpu.c                 |    8 +-
 target/i386/hvf/x86_cpuid.c       |    2 +-
 target/riscv/cpu.c                | 1014 +++++++++++++++++--------------------
 target/riscv/csr.c                |   11 +-
 target/riscv/gdbstub.c            |    6 +-
 target/riscv/kvm/kvm-cpu.c        |   27 +-
 target/riscv/machine.c            |    2 +-
 target/riscv/tcg/tcg-cpu.c        |   13 +-
 target/riscv/th_csr.c             |   30 +-
 target/riscv/translate.c          |    2 +-
 26 files changed, 821 insertions(+), 874 deletions(-)
 create mode 100644 target/riscv/cpu_cfg_fields.h.inc
-- 
2.49.0


