Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751C1F417EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbwa-0003fy-VH; Mon, 09 Mar 2026 10:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbw4-00035O-Fq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:23 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbw2-0005dT-DG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so1722606f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067815; x=1773672615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0qjmN/GSCfBhS2MBsDn29yYp3Vfa3VAKsY/7iWyDeDQ=;
 b=n9n0d8fAMObCpFLQmAm/m5nQV8gwrGD53rOAwFII0ukstDo2XWjsXebMGsRxYlU94c
 F38rXZHoj6FMQMksUZAd6fFLeo9kmUZ+sn+6p/zU2Rz/Qv92P6x0YfKpupHi1zTsExp1
 4iuiwiwo3/TIjwh0zP8SzH1iP9sr4VV7KeLobblJS7dNgU0J7Hog0LbHmFfjPn76e2cP
 YD6P96tiNIIwj5sSfKEhtJybmgSmvecK06WRjj/R+uQe8lGmdSR3C9QaFv2L/VqSqhrb
 iKLn/mUkeFLYRc9QYZy/yjoKRNTuRr/W8TntEIjoAKcDOe8FLGuoo0ab9aHSVyMeksR9
 /aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067815; x=1773672615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qjmN/GSCfBhS2MBsDn29yYp3Vfa3VAKsY/7iWyDeDQ=;
 b=Uvj3n1vwUs+IrVWFq68NNdSbtYbnYQdKQCeNHRp2CVRXWZUoJTWI59+NRHS4I9zGfL
 JHq1GPygih1espffkwZxl45txTZRKQKhN/ALqTNtfI+7LtbKjl4LTCRpEV842oMnZVvF
 peXsGitt4m+/X6JI3+rC37FUCPXB2phT22douMh/5ZD8fUlL7B2aUFg8tvTxWbmbNPwk
 peunwB581laoo6H4wBhKc3TV+lMlOaiZvxroseK5O1R7EUqTn5xdfywU8O/EPjjQZCUq
 0WClgiAfwFh4Ly9TSWiVsqWQrI1opcjfdhCtxtjnblxekcjmjH72oaNydgEpaqPdOJ3p
 8IWA==
X-Gm-Message-State: AOJu0YykZ3Q8fQrp8ZQNGIC4NXb+9vKkyiOQM4vWPptuX47tTPOkrBRw
 JFneFeMGYgre2oOGuV0dm8iOzUKjdxMRaI2bWGncSLDiYvJErKxZIIKlfjalxF8LjRPiD5POy37
 SxVKYn3U=
X-Gm-Gg: ATEYQzw/yzaqg1CFXkQHxCSIOUEO/1hMZ9uDDtS57WFxTou0cnejCy4F+jfjHarFuuI
 wGJn+SaGiKsatUJvFOveiUcFs0FwGGxFpdv9QOzSJ8HS255DEQArkr/dz8bL0fWk5vhxxDt4rKi
 267W5x4hB4gcYrXTQwA5cBFtDGWXPM+kgMiDQS/iUzcGv5X0KgLflcUqXTCGc+xpeYeuSaPlqET
 8BIJD9x25kxt4n+lmNi3S+lTSPEGGUkQrzoPPOlrY79JrFpn/8ZAE6w8CVWbf5GQVNWIQNmRwn8
 /KedWdulatuJSyDdKw1179CrIOWwOxO3dxVFIZ+QHHzFp0OLEsFtvWjPq7wOo45mcl/k5T8QlsF
 js1E6WgRXG2rtkSa6ME9aeh6gfeK/R4qCNKfsKp/Uj3zsUG9FyTlMl01i8NGcejyZd8VLzuYXZv
 CUrrZQYe/joX8iPRqxjeCr4tW0pGrUB/x5Vl1oH8S81J1dt8wrMgL7siC08Oa1Jpk0jhxbfWIBa
 0yZzA==
X-Received: by 2002:a05:6000:290d:b0:439:d74f:da94 with SMTP id
 ffacd0b85a97d-439da354a39mr20166357f8f.5.1773067814942; 
 Mon, 09 Mar 2026 07:50:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d840sm30093897f8f.8.2026.03.09.07.50.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 07:50:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/10] hw/i386/pc: Remove deprecated 3.1 machines
Date: Mon,  9 Mar 2026 15:50:02 +0100
Message-ID: <20260309145013.44327-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

1 y.o. dust Thomas asked me to rebase & post:

The versioned 'pc' and 'q35' machines up to 3.1 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

v2: Remove xenfv-3.1 in patch #1

Philippe Mathieu-Daudé (10):
  hw/i386/pc: Remove deprecated pc-q35/pc-i440fx/xenfv 3.1 machines
  hw/i386/pc: Remove PCMachineClass::pvh_enabled field
  hw/i386/x86: Remove @pvh_enabled argument in x86_load_linux()
  hw/core/boards: Remove MachineClass::smbus_no_migration_support field
  hw/i386/pc: Remove pc_compat_3_1[] array
  hw/i386/iommu: Remove IntelIOMMUState::dma_drain field
  target/i386/cpu: Remove X86CPU::intel_pt_auto_level field
  hw/core/machine: Remove the hw_compat_3_1[] array
  hw/pci-bridge/pcie_rp: Remove PCIESlot::disable_acs field
  hw/tpm: Remove CRBState::ppi_enabled field

 hw/tpm/tpm_tis.h               |  1 -
 include/hw/core/boards.h       |  4 ----
 include/hw/i2c/pm_smbus.h      |  7 -------
 include/hw/i386/intel_iommu.h  |  1 -
 include/hw/i386/microvm.h      |  2 +-
 include/hw/i386/pc.h           |  6 ------
 include/hw/i386/x86.h          |  3 +--
 include/hw/pci/pcie_port.h     |  3 ---
 target/i386/cpu.h              |  3 ---
 hw/acpi/piix4.c                |  8 +-------
 hw/acpi/tpm.c                  |  4 ----
 hw/core/machine.c              | 17 -----------------
 hw/i2c/pm_smbus.c              |  7 -------
 hw/i2c/smbus_eeprom.c          |  4 +---
 hw/i2c/smbus_ich9.c            | 10 ++--------
 hw/i386/acpi-build.c           |  2 +-
 hw/i386/intel_iommu.c          | 11 +----------
 hw/i386/microvm.c              |  2 +-
 hw/i386/nitro_enclave.c        |  2 +-
 hw/i386/pc.c                   | 31 ++-----------------------------
 hw/i386/pc_piix.c              | 25 -------------------------
 hw/i386/pc_q35.c               | 14 --------------
 hw/i386/x86-common.c           |  6 ++----
 hw/pci-bridge/pcie_root_port.c |  3 +--
 hw/tpm/tpm_crb.c               | 12 +++---------
 hw/tpm/tpm_tis_common.c        |  4 +---
 hw/tpm/tpm_tis_isa.c           |  7 ++-----
 target/i386/cpu.c              | 10 +---------
 28 files changed, 22 insertions(+), 187 deletions(-)

-- 
2.53.0


