Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE77CCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5N-0003Un-CK; Wed, 29 Oct 2025 13:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5C-0003P0-OJ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:39 -0400
Received: from p-east2-cluster4-host4-snip4-9.eps.apple.com ([57.103.78.150]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA50-0003FQ-CN
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:38 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 24674180B91A; Wed, 29 Oct 2025 17:35:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=7q2ijxWjCFFby1pjxNXj6G9Q6h+XG4Y7cWTMB6vtAiI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=KrhETs0X0KbIAKWmYFKm2atDQ2EFeUFANtQXno+ThW8I+VqKAtUX12NOYizNpB7I51tM4BHQYWSSBDbVeqOdWbg8Sch7OxCECx2Dbre3NiBTxorGISOgIYMhOUUtNJHQhDOkYriv7oV6PgvWMDOyl7o+yPGGLQ41N+HYfi0rzuiP+aTyYRXxqAE3irzF4GtDtMnkcXZYv+jga3r93Cmw3x5Pfd/teKnQSeiCtYtJq5aHebfX6fUjo1I+tyIiLd9z4vVPnADSSGMmZlmmSJdR7B5eEf2QJwmHo3IWvAQO6SzBdTgjKXTKhQZx81pTxOfH4o2/e6a0bjIwwnL+7wfa4g==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 A551F1857C11; Wed, 29 Oct 2025 16:55:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 00/28] WHPX support for Arm
Date: Wed, 29 Oct 2025 17:54:42 +0100
Message-ID: <20251029165510.45824-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HTDdtFdUvAeJ_f7lAzLyXGTZ156jQEco
X-Proofpoint-GUID: HTDdtFdUvAeJ_f7lAzLyXGTZ156jQEco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX1YuBRqh9KpvY
 2NfZmAKnwDPW65UvcDyY/HesGJ8CneC2HPFnA9ImqirbcN4nCZSEYuOjwpxQOEemkOyA15pw88A
 83ccL/0ePHRTx3ohyoe6//GX2alsxvvNt/If0VLJjR/qg058E0d1WdlKkDTrCExpSu1R/DoxNqe
 wMO0AblDKZNItzdRfdqIQ2v4DVjg3/RHVXOEvhe1JpWwM11Y2HLNygi3tb6bpC5OjMecRGqMgqI
 hTqVPFjdrrgr2XVXJQDnexlA4KZ96rD54FWEAbOm8VyzSh2shaHvc4UC8TrWlZKBxPlq2mHzM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1030 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABv3l3oDHJjkok4LbE9K6/z5J4aog9O8hntMAPjGRGnK0kvPiup3iXOhuAQlTuJZ2fVWtP7fQ/UKR2m32GpM+ArqPnicIvoNh0jDZkT3qCe2vF6FyVOvT2L5m79MTHzpip0TAMFo7XMldpX4FTWnhCoiacQF3VSepmhK/2t/c/JRqqeReW5nxEbeoIYhqklXnPtDIclneDGkOef1Ev/dpkOpcWREX92JOiZ4s6OEXLxGfiklvzhozluuonnl8G43Y7aNofYMZ110K/SNasej9curBP448eTsi5gb0WytZciTutCFGC1Ks8JVeEuhO3F/g84wumDZDPwFUsSt0K+4e5JeI6oJw+lCcunhctgnNgXHm/iv+lv2X7wwP4GAO52IMYSw4LZt9Uz00gwWiliwt3twDucCZFUBK56de7OiRAe0ebn4+DBTTIq4atO9vK4FZQ40XtqHcIW1ileodLKCHdExP5C6EUkY3n3b2X6CHjMcAKDgU0F7anZLR8oWd5TFRK8EWNpRmLz0tliGzyDxgU2FG8NqTcL6i6qBfNcam3irHKmDesICC6uuJUfyBX8VRKWfQ8k5Vy/TK3DGrIHjyoN5mEKzJoUPltAde6IV1FV09AAbqcNfwb8d3U8JCKUKgFExA0nnMJzOAp6G+UrJOpoiEzzIw80UIU5xl+wIeAmTKaTPBOh3ytaKxV/wab5bkDB+AJumNHBKcjoZnEySk+rJJK6tpdk7oeXLSQZ3WB2VNdD7v4/3NfEDnTU8pxbEmnNIo=
Received-SPF: pass client-ip=57.103.78.150;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v10)

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

And another note:
Seems that unlike HVF there isn't direct correspondence between WHv registers and the actual register layout,
so didn't do changes there to a sysreg.inc.

And yet another note:
On build 26200 on Snapdragon X, I often observe CLOCK_WATCHDOG_TIMEOUT BSoDs _on the host_ when using WHPX qemu. This is currently
being looked at. This also affects prior revisions of this patch series.

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
  MAINTAINERS: update maintainers for WHPX
  whpx: apic: use non-deprecated APIs to control interrupt controller
    state
  whpx: arm64: check for physical address width after WHPX availability
  whpx: arm64: add partition-wide reset on the reboot path

Philippe Mathieu-Daudé (1):
  accel/system: Introduce hwaccel_enabled() helper

Sebastian Ott (1):
  target/arm/kvm: add constants for new PSCI versions

 MAINTAINERS                                   |   11 +-
 accel/hvf/hvf-all.c                           |    7 +-
 accel/meson.build                             |    1 +
 accel/whpx/meson.build                        |    7 +
 {target/i386 => accel}/whpx/whpx-accel-ops.c  |    6 +-
 accel/whpx/whpx-common.c                      |  548 +++++++++
 docs/system/arm/virt.rst                      |   10 +-
 hw/arm/virt-acpi-build.c                      |   16 +-
 hw/arm/virt.c                                 |  132 ++-
 hw/i386/x86-cpu.c                             |    4 +-
 hw/intc/arm_gicv3_common.c                    |    3 +
 hw/intc/arm_gicv3_whpx.c                      |  249 ++++
 hw/intc/meson.build                           |    1 +
 include/hw/arm/virt.h                         |    8 +-
 include/hw/boards.h                           |    3 +-
 include/hw/intc/arm_gicv3_common.h            |    3 +
 include/system/hvf_int.h                      |    2 +
 include/system/hw_accel.h                     |   13 +
 .../whpx => include/system}/whpx-accel-ops.h  |    4 +-
 include/system/whpx-all.h                     |   20 +
 include/system/whpx-common.h                  |   26 +
 .../whpx => include/system}/whpx-internal.h   |   25 +-
 include/system/whpx.h                         |    4 +-
 meson.build                                   |   20 +-
 target/arm/cpu.c                              |    3 +
 target/arm/cpu64.c                            |   19 +-
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
 41 files changed, 2216 insertions(+), 650 deletions(-)
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


