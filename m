Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF99CFA761
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNzD-0004cY-Q7; Fri, 21 Nov 2025 05:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNz1-0004YJ-62
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:16 -0500
Received: from p-east3-cluster7-host3-snip4-1.eps.apple.com ([57.103.84.152]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNyr-0007r1-A0
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:12 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 0F09B18010F7; Fri, 21 Nov 2025 10:02:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=2GlcpTFUnAykMiNzuU+cfcjanMa///PqnJXf6NeucUM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=eVwieVccvTo0AvySnOvAx8TnPdxCO1OcQpLX46T4VXmYnIiM8BybkGM/kro18fW+CdjGzOBeOoaiwaWREQBrhsQsDbVW3/LDQaDObAWyMZhrqvQUO1d0aNXUnxQi+ijNcyuvwnCrgUI+cSCXz3fmp5WwGVSr745yZkfpz/JmAEuOy8mjLKiPW350ftmIQgQROHiIPmhCQUr3ylW9lct1DynPpxDdAzuNWScrj+482yb+xPYQR8dH0KrrEQoj1fjDnDdrF09QUguu/HzWGdeg75xtdrkj+mnTGhDSuheBHTz+Mt0aycwiCBmAExUB0ty/fviWBUx1XBMo9XZPqc33YQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 C32C518010EA; Fri, 21 Nov 2025 10:02:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v11 00/28] WHPX support for Arm
Date: Fri, 21 Nov 2025 11:02:12 +0100
Message-ID: <20251121100240.89117-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX9386my9YkSoR
 7UfJDo2MG/lr8pTU8EDUBZirotqLbiZQvqidMwT5vs54ZKR4AN/UezdTPa5wsggLsOdXlVvFzWV
 OtNIFyxBQ2HY3c4MFm4Swf3jo8/MeFZ+3iZCWUpF8cOSjQHLNjUmWKI5hR1N+0X2D5V2s9KW0bE
 JJLzzyZztJmIZho//7RP4KtGkGR3OHZidey/HI4iMuyDSufASyP+6qKj1B7W2VoCDEFPBNzUbso
 ry7abmekbe6A3nYVj4AdK7V3WvCa6Y58yHI3ZCZBSipeaieP2FSDlPsnOHFzPbR4FdVfDfS6DHZ
 bAXZihrV2hp+yhpsWsp
X-Proofpoint-ORIG-GUID: NX-wIQu7hcnWiYYMgUjavDWsOv_-mpw-
X-Proofpoint-GUID: NX-wIQu7hcnWiYYMgUjavDWsOv_-mpw-
X-Authority-Info: v=2.4 cv=Vuouwu2n c=1 sm=1 tr=0 ts=692038c5 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=2CSUmbMKgiS_FIm3Z54A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABYyDhEqUEWwMgAXeBua1c3YIv4gSMEXJi4DDQKngkLQsb0O9V3ZRqHmGMNbpOOlSD6To9Trf7lSKjTfvBdveLAG+iyK6KUHXei0bW3E/qMFZfxq956fdSoYDPfRPmyw0vOUosGNGtAM830CxK64fq1xJJspaXIdsHDiF3rzxlhsHJ/IjmQ8LaCPGfwF3ohK5skE4UUVHkuDgKUjFmDXIlDe1Nt1sukKcprI8xV4m+Bh1d1tw9EdC4Hom+pmkUmmKmdys5Z5v1yZnTeIm2e3I1Aiaj66BeVaVa7qI3Gda4sAj3BM1J/g4dkXo8v+/C+ffzOjiifWiqTFhQAxG9dkeBpsDzeNchcYlfOyow0g9aej+Df/Dbd19cic0JKWGwtHfPBiUhPS+ePXYctbbQjrh0+COgwuvsceHU6qxvqhG2Uwfnnrmt5ftVAum/EHMhBXpEgtnrK+7uYBVuOgC56XEYryArckP4KK2c70X2kmvGeDdNYJRNqtPzfCO0UjB3iz77C3YEFyMAQXYfqOE6P1HX9Zr5Gc3KXBzaZ1Ho+6WqOVXqT52P4P7/faT8ZsYBcpD0m9TwhzHi431cRX3zZaEdVPHSqbTWjNwGiW+0OaT5tvxk8V+AxS6Na24WJUW7KBTskusPpvcrI3ah+mIYJkt36X12hlXQKaRdhQbLJYDJrUkaWXRIOxDrzFCBsv95roM/jANQXqz96mzyX4g6UNoBSP0fG4K2m43ZEFooYE0ifjgzbiFhaJXEBVJ88Q==
Received-SPF: pass client-ip=57.103.84.152;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v11)

Missing features:
- PSCI state sync with Hyper-V for VM save/restore (which isn't supported because of the second item)
- Interrupt controller save-restore: As such, save/restore of VM state is currently blocked.
- SVE register sync: I didn't have the time to test this on pre-release hardware with SVE2 support yet.

Known bugs:
- U-Boot still doesn't work (hangs when trying to parse firmware) but EDK2 does.

Note:

"target/arm/kvm: add constants for new PSCI versions" taken from the mailing list.

"accel/system: Introduce hwaccel_enabled() helper" taken from the mailing list, added here
as part of this series to make it compilable as a whole.

"hw/arm: virt: add GICv2m for the case when ITS is not available" present in both the HVF
vGIC and this series.

"hw: arm: virt-acpi-build: add hack" is not proper, but it's just for keeping the current
state of things... What should we do for older VMs to retain the same ACPI tables? Or is
that not a concern?

And another note:

Seems that unlike HVF there isn't direct correspondence between WHv registers and the actual register layout,
so didn't do changes there to a sysreg.inc.

Updates since v10:
- Bring forward to latest Qemu
- Fix a typo in the GICv3+GICv2m PR

Updates since v9:
- Adding partition reset on the reboot side of things...

Updates since v8:
- v9 and v8 were not submitted properly because of my MTA not behaving, sorry for that.
- v10 introduces a new argument, -M msi=, to handle MSI-X configuration more granularly.
- That surfaced what I think is a bug (?), with vms->its=1 on GICv2 configurations... or I did understand everything wrong.
- Oopsie due to email provider ratelimiting.

Updates since v7:
- Oops, fixing bug in "hw/arm: virt: cleanly fail on attempt to use the platform vGIC together with ITS".
Other commits are unchanged.

Updates since v6:
- Rebasing
- Fixing a bug in the GICv3+GICv2m case for ACPI table generation
- getting rid of the slots infrastructure for memory management
- Place the docs commit right after the "cleanly fail on attempt to run GICv3+GICv2m on an unsupported config" one
as that's what switches ITS to a tristate.
- Fixing a build issue when getting rid of the arch-specific arm64 hvf-stub.

Updates since v5:
- Rebasing
- Address review comments
- Rework ITS enablement to a tristate
- On x86: move away from deprecated APIs to get/set APIC state

Updates since v4:
- Taking into account review comments
- Add migration blocker in the vGICv3 code due to missing interrupt controller save/restore
- Debug register sync

Updates since v3:
- Disabling SVE on WHPX
- Taking into account review comments incl:

- fixing x86 support
- reduce the amount of __x86_64__ checks in common code to the minimum (winhvemulation)
which can be reduced even further down the road.
- generalize get_physical_address_range into something common between hvf and whpx

Updates since v2:
- Fixed up a rebase screwup for whpx-internal.h
- Fixed ID_AA64ISAR1_EL1 and ID_AA64ISAR2_EL1 feature probe for -cpu host
- Switched to ID_AA64PFR1_EL1/ID_AA64DFR0_EL1 instead of their non-AA64 variant

Updates since v1:
- Shutdowns and reboots
- MPIDR_EL1 register sync
- Fixing GICD_TYPER_LPIS value
- IPA size clamping
- -cpu host now implemented

Mohamed Mediouni (26):
  qtest: hw/arm: virt: skip ACPI test for ITS off
  hw/arm: virt: add GICv2m for the case when ITS is not available
  tests: data: update AArch64 ACPI tables
  whpx: Move around files before introducing AArch64 support
  whpx: reshuffle common code
  whpx: ifdef out winhvemulation on non-x86_64
  whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
  hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
  whpx: switch irqchip in kernel to a bool outside the struct
  whpx: interrupt controller support
  whpx: add arm64 support
  whpx: change memory management logic
  target/arm: cpu: mark WHPX as supporting PSCI 1.3
  hw/arm: virt: cleanly fail on attempt to use the platform vGIC
    together with ITS
  hw: arm: virt: rework MSI-X configuration
  hw: arm: virt-acpi-build: add hack
  docs: arm: update virt machine model description
  whpx: arm64: clamp down IPA size
  hw/arm, accel/hvf, whpx: unify get_physical_address_range between WHPX
    and HVF
  whpx: arm64: implement -cpu host
  target/arm: whpx: instantiate GIC early
  whpx: arm64: gicv3: add migration blocker
  whpx: enable arm64 builds
  whpx: apic: use non-deprecated APIs to control interrupt controller
    state
  whpx: arm64: check for physical address width after WHPX availability
  whpx: arm64: add partition-wide reset on the reboot path

Philippe Mathieu-Daudé (1):
  accel/system: Introduce hwaccel_enabled() helper

Sebastian Ott (1):
  target/arm/kvm: add constants for new PSCI versions

 MAINTAINERS                                   |    4 +
 accel/hvf/hvf-all.c                           |    7 +-
 accel/meson.build                             |    1 +
 accel/stubs/whpx-stub.c                       |    1 +
 accel/whpx/meson.build                        |    7 +
 {target/i386 => accel}/whpx/whpx-accel-ops.c  |    6 +-
 accel/whpx/whpx-common.c                      |  540 +++++++++
 docs/system/arm/virt.rst                      |   10 +-
 hw/arm/virt-acpi-build.c                      |   16 +-
 hw/arm/virt.c                                 |  131 ++-
 hw/i386/x86-cpu.c                             |    4 +-
 hw/intc/arm_gicv3_common.c                    |    3 +
 hw/intc/arm_gicv3_whpx.c                      |  249 ++++
 hw/intc/meson.build                           |    1 +
 include/hw/arm/virt.h                         |    8 +-
 include/hw/boards.h                           |    3 +-
 include/hw/intc/arm_gicv3_common.h            |    3 +
 include/system/hvf_int.h                      |    5 +
 include/system/hw_accel.h                     |   13 +
 .../whpx => include/system}/whpx-accel-ops.h  |    4 +-
 include/system/whpx-all.h                     |   20 +
 include/system/whpx-common.h                  |   26 +
 .../whpx => include/system}/whpx-internal.h   |   24 +-
 include/system/whpx.h                         |    5 +-
 meson.build                                   |   20 +-
 target/arm/cpu.c                              |    3 +
 target/arm/cpu64.c                            |   17 +-
 target/arm/hvf-stub.c                         |   20 -
 target/arm/hvf/hvf.c                          |    6 +-
 target/arm/hvf_arm.h                          |    3 -
 target/arm/kvm-consts.h                       |    2 +
 target/arm/meson.build                        |    2 +-
 target/arm/whpx/meson.build                   |    5 +
 target/arm/whpx/whpx-all.c                    | 1020 +++++++++++++++++
 target/arm/whpx/whpx-stub.c                   |   15 +
 target/arm/whpx_arm.h                         |   17 +
 target/i386/cpu-apic.c                        |    2 +-
 target/i386/hvf/hvf.c                         |   11 +
 target/i386/whpx/meson.build                  |    1 -
 target/i386/whpx/whpx-all.c                   |  569 +--------
 target/i386/whpx/whpx-apic.c                  |   48 +-
 tests/data/acpi/aarch64/virt/APIC.its_off     |  Bin 164 -> 188 bytes
 42 files changed, 2205 insertions(+), 647 deletions(-)
 create mode 100644 accel/whpx/meson.build
 rename {target/i386 => accel}/whpx/whpx-accel-ops.c (96%)
 create mode 100644 accel/whpx/whpx-common.c
 create mode 100644 hw/intc/arm_gicv3_whpx.c
 rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
 create mode 100644 include/system/whpx-all.h
 create mode 100644 include/system/whpx-common.h
 rename {target/i386/whpx => include/system}/whpx-internal.h (88%)
 delete mode 100644 target/arm/hvf-stub.c
 create mode 100644 target/arm/whpx/meson.build
 create mode 100644 target/arm/whpx/whpx-all.c
 create mode 100644 target/arm/whpx/whpx-stub.c
 create mode 100644 target/arm/whpx_arm.h

-- 
2.50.1 (Apple Git-155)


