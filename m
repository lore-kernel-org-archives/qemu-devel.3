Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D17C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfn7-0005mu-C0; Fri, 17 Jul 2026 06:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wkfn5-0005mP-Ox; Fri, 17 Jul 2026 06:27:35 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wkfn3-0000OK-S9; Fri, 17 Jul 2026 06:27:35 -0400
Received: from localhost (unknown [131.107.159.8])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1702C20B7169;
 Fri, 17 Jul 2026 03:27:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1702C20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1784284041;
 bh=SVvtAXzKcVSKJSbrKo1DGG2/S/V5GVh5jAlqyExG/1s=;
 h=From:Subject:Date:To:Cc:From;
 b=a6YpaiXvjq5X2tsHZV3dCUWd1ObPZbbSjtxqkW0GQRuQNzxBaaFGqxPwfhoTPN6Ad
 gO9WQMRBPunlsWsXplv+Z2qnhYmEtxsJYIY0tPLaySEYVTNWs1pcEBSa6sobzbsLPC
 tAa5o/V0XzGhnNU6xyjr4tomv5Eu1FoU/R5Bo0d0=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Subject: [PATCH v5 00/13] Add ARM64 support for MSHV accelerator
Date: Fri, 17 Jul 2026 10:27:15 +0000
Message-Id: <20260717-mshv_accel_arm64_supp-v5-0-ef07d4c6b337@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIQDWmoC/4XNQQ7CIBCF4asY1tJAi7R15T2MaQAHmcSWBiypa
 Xp3sS5cGZf/S+abhUQICJEcdwsJkDCiH3Ic9jtinBpuQPGam5SslKzinPbRpU4ZA/dOhV6KLk7
 jSKGRmrGmVACC5NsxgMV5c8+X3A7jw4fn9ibx9/pPTJwyaiou21bX2nB7UgOG6eqCLozvyVtN1
 VcS5U+pypKQrT0IUdeNVqc7DtNc9GiCj94+Pt66ri/osrsuDgEAAA==
X-Change-ID: 20260311-mshv_accel_arm64_supp-e86b0082aee4
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, 
 =?utf-8?q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

This series adds ARM64 guest support to the MSHV (Microsoft Hypervisor)
accelerator, enabling QEMU to run aarch64 VMs on Microsoft's hypervisor
using the mshv Linux kernel module.

The first few patches refactor the existing x86 MSHV code to separate
arch-specific pieces from common infrastructure: moving MSR handling to
target/i386, extracting shared register hypercall helpers, provisioning
host CPU features, and introducing arch-specific init hooks.

The remaining patches add the ARM64 backend:
 - vCPU state get/set using hypervisor register hypercalls
 - -cpu host support by querying ID registers from the hypervisor
 - vCPU run loop with MMIO emulation via ESR_EL2 syndrome decoding
 - In-kernel vGICv3 backed by HVCALL_ASSERT_VIRTUAL_INTERRUPT
 - Interrupt control structure adjustments for arm64

With this series, a standard aarch64 virt machine can be launched with:
  qemu-system-aarch64 -accel mshv -cpu host -M virt ...

Caveats:
- Live migration is not yet supported.

---
Changes in v2:
- Removed PATCH: "accel/mshv: provision guests with the same features as host".
- Extracted common MMIO emulation logic for hvf, whpx and mshv to a
  common place.
- Fixed checkpatch errors/warnings.
- Picked up reviewed-by tags.
- Link to v1: https://lore.kernel.org/qemu-devel/20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com

---
Changes in v3:
- Handled GPA Intercept in vCPU run loop to fix EDK2 firmware boot.
- Updated the cover letter: removed caveat about EDK2 firmware boot as
  it is now fixed.
- Link to v2: https://lore.kernel.org/qemu-devel/20260402-mshv_accel_arm64_supp-v2-0-754895c15e9e@linux.microsoft.com/

---
Changes in v4:
- Split "target/arm: convert host CPU features ifdef ladder to runtime
  checks" out of the -cpu host patch to separate the refactoring.
- Refactored MMIO emulation helper (arm_emulate_mmio) to use callback
  ops for per-register access avoiding full CPU state sync for single
  register MMIo operations for HVF & WHPX.
- Reordered patches: moved "arch-specific accelerator init hook" earlier
  (patch 3), before the arm64 build enablenment.
- Updated cpu_thread_is_idle() comment to be arch-neutral.
- Link to v3: https://lore.kernel.org/qemu-devel/20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com

---
Changes in v5:
- Rebased onto v11.1.0 rc0.
- Dropped "accel/mshv: implement cpu_thread_is_idle() hook" as it has been
  merged upstream and is now part of the base.
- Dropped "accel/mshv: move msr.c to target/i386" for the same reason (msr.c
  now lives in target/i386/mshv/ upstream).
- Adapted the arm64 code to MSHV API changes already present in the new base:
   - * follow the mshv_arch_put_registers() -> mshv_arch_load_vcpu_state() /
       mshv_arch_store_vcpu_state() rename;
   - * add an arm64 stub for the new mshv_arch_disable_partition_proc_features()
       hook and guard the x86-only xsave handling in create_partition() with
       `#if defined(__x86_64__)`.
- Made the arm64 register helpers file-local static (load_regs(), store_regs(),
  get_standard_regs()).
- Link to v4: https://lore.kernel.org/qemu-devel/20260527-mshv_accel_arm64_supp-v4-0-66d871dcdc53@linux.microsoft.com

---
Aastha Rawat (8):
      accel/mshv: extract common CPU register helpers
      meson, target/arm/mshv: Enable arm64 build & add initial MSHV support
      target/arm/mshv: implement vcpu state operations for ARM64
      target/arm: convert host CPU feature ifdef ladder to runtime checks
      target/arm/mshv: implement -cpu host for MSHV
      accel/mshv: Add access_vp_regs synthetic proc features
      target/arm: cpu: Mark MSHV supporting PSCI 1.3
      target/arm: extract MMIO emulation logic for HVF & WHPX

Anirudh Rayabharam (Microsoft) (5):
      accel/mshv: add arch-specific accelerator init hook
      target/arm/mshv: add vCPU run loop
      include/hw/hyperv: adjust hv_interrupt_control structure for arm64
      hw/intc,target/arm/mshv: add MSHV vGICv3 implementation
      MAINTAINERS: updates for MSHV arm64 code

 MAINTAINERS                        |   8 +
 accel/mshv/irq.c                   |   2 +
 accel/mshv/meson.build             |   3 +-
 accel/mshv/mshv-all.c              |  21 +-
 accel/mshv/mshv-cpu-common.c       | 151 ++++++++++
 hw/arm/virt.c                      |  11 +-
 hw/intc/arm_gicv3_common.c         |   3 +
 hw/intc/arm_gicv3_mshv.c           | 181 ++++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/hyperv/hvgdk_mini.h     | 129 +++++++++
 include/hw/hyperv/hvhdk.h          |  91 +++++-
 include/hw/hyperv/hvhdk_mini.h     |   6 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 include/system/hw_accel.h          |   3 +-
 include/system/mshv.h              |   2 +
 include/system/mshv_int.h          |   3 +
 meson.build                        |   8 +-
 target/arm/cpu.c                   |   8 +-
 target/arm/cpu64.c                 |  27 +-
 target/arm/helper.c                |  62 ++++
 target/arm/helper.h                |  16 ++
 target/arm/hvf/hvf.c               |  57 ++--
 target/arm/meson.build             |   1 +
 target/arm/mshv/meson.build        |   7 +
 target/arm/mshv/mshv-all.c         | 576 +++++++++++++++++++++++++++++++++++++
 target/arm/mshv_arm.h              |  18 ++
 target/arm/syndrome.h              |  47 +++
 target/arm/whpx/whpx-all.c         |  45 ++-
 target/i386/mshv/meson.build       |   1 +
 target/i386/mshv/mshv-all.c        |  85 ++++++
 target/i386/mshv/mshv-cpu.c        | 165 +----------
 31 files changed, 1491 insertions(+), 248 deletions(-)
---
base-commit: eca2c16212ef9dcb0871de39bb9d1c2efebe76be
change-id: 20260311-mshv_accel_arm64_supp-e86b0082aee4

Best regards,
--  
Aastha Rawat <aastharawat@linux.microsoft.com>


