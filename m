Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8796EA71A4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Zu-00085I-Ne; Tue, 21 Apr 2026 01:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wF3Yc-0007Yg-C5; Tue, 21 Apr 2026 01:21:58 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wF3YY-0000cn-Sf; Tue, 21 Apr 2026 01:21:56 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id 71DAB20B6F01;
 Mon, 20 Apr 2026 22:21:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71DAB20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776748911;
 bh=W96UW654sJD1pJOpxh90zNKS/HrnEn60G7p7PwpBCPw=;
 h=From:Subject:Date:To:Cc:From;
 b=IbuY1vymbO9yrtgtZ0q9h7IqYkgpQ08yf4e+9+3EWUGA7ChzPIxYieRjP0x3HJ/sq
 SuHgDZIQsGHPKSQp6X1zVykA/TQTiXiwUhna7sCUFBo73Lqh99kK0TmyFOCbf7g2Yq
 HeHXdo30wJ1Y42LQ+CHSzYeTCWGSIXWkIBBw0zdE=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Subject: [PATCH v3 00/14] Add ARM64 support for MSHV accelerator
Date: Tue, 21 Apr 2026 05:21:45 +0000
Message-Id: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGkJ52kC/4WNQQ6CMBBFr0JmbU0LpIIr72EIactgJxFoptJoC
 He3cgGX7yX//Q0iMmGEa7EBY6JIy5yhOhXgvJkfKGjIDKUstayUElP0qTfO4bM3POm6j2sIAht
 tpWxKg1hD3gbGkd5H995l9hRfC3+Om6R+9l8xKSGFq5RuW3uxTo03MxOvg2d7dssE3b7vX4BSC
 fi+AAAA
X-Change-ID: 20260311-mshv_accel_arm64_supp-e86b0082aee4
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, 
 Magnus Kulke <magnus.kulke@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Aastha Rawat (8):
      accel/mshv: move msr.c to target/i386
      accel/mshv: extract common CPU register helpers
      meson, target/arm/mshv: Enable arm64 build & add initial MSHV support
      target/arm/mshv: implement vcpu state operations for ARM64
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

Magnus Kulke (1):
      accel/mshv: implement cpu_thread_is_idle() hook

 MAINTAINERS                        |   8 +
 accel/mshv/irq.c                   |   2 +
 accel/mshv/meson.build             |   4 +-
 accel/mshv/mshv-all.c              |  26 +-
 accel/mshv/mshv-cpu-common.c       | 151 ++++++++++
 hw/arm/virt.c                      |  11 +-
 hw/intc/arm_gicv3_common.c         |   3 +
 hw/intc/arm_gicv3_mshv.c           | 181 ++++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/hyperv/hvgdk_mini.h     | 130 +++++++++
 include/hw/hyperv/hvhdk.h          | 101 ++++++-
 include/hw/hyperv/hvhdk_mini.h     |   6 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 include/system/hw_accel.h          |   3 +-
 include/system/mshv.h              |   2 +
 include/system/mshv_int.h          |   5 +
 meson.build                        |   7 +-
 target/arm/cpu.c                   |   8 +-
 target/arm/cpu64.c                 |  24 +-
 target/arm/helper.c                |  60 ++++
 target/arm/helper.h                |   5 +
 target/arm/hvf/hvf.c               |  64 +++--
 target/arm/meson.build             |   1 +
 target/arm/mshv/meson.build        |   7 +
 target/arm/mshv/mshv-all.c         | 567 +++++++++++++++++++++++++++++++++++++
 target/arm/mshv_arm.h              |  18 ++
 target/arm/syndrome.h              |  37 +++
 target/arm/whpx/whpx-all.c         |  62 +---
 target/i386/mshv/meson.build       |   2 +
 target/i386/mshv/mshv-all.c        |  85 ++++++
 target/i386/mshv/mshv-cpu.c        | 170 +----------
 {accel => target/i386}/mshv/msr.c  |   0
 32 files changed, 1480 insertions(+), 272 deletions(-)
---
base-commit: f429c4276c8349f2cc94fb4e46a2a7918bec95c3
change-id: 20260311-mshv_accel_arm64_supp-e86b0082aee4

Best regards,
--  
Aastha Rawat <aastharawat@linux.microsoft.com>


