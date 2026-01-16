Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95269C2A07F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkFs-0002sW-0A; Fri, 16 Jan 2026 08:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkFq-0002s8-3R
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:46 -0500
Received: from ci-2003b-snip4-2.eps.apple.com ([57.103.91.143]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkFn-00023J-U3
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:45 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 4CB20180022B; Fri, 16 Jan 2026 13:52:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=qoI1nyihHUC8avK3BVeMI3/h+rUmC+3nBJWMH83LPqk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=TUhOgSbno8/WmcXJ2jFJ9l+KNjpZTtaCfxUm5GVK0RCZiZwkkZfaEK/dUBTf741DAY66cP/qPuq+9hCmZ9jlsg3qNSXxh4xpo4CmbF4EwZcy19xrzIw6DEGTophXrLJ2ZopY6lnpYEfWW+aPM5ZmgUWzU1gSN9aqK2JK6ZTH9RlkS0wJn1Z3p9DArhDeHfZLVtSDb98u/JpRKvflCfuviHzipJ8qIpYJUi3s33az+CfvVuOka6+dS95iEU/iOxLD8+3uIEszl/Dtq0wr5ITB28geMBSi76AGcn/0SFE7ej8MI9B1sBqAr8W2lL8eryZjz2o7zHJCixwybQfj9C0IMQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 CD3B9180011E; Fri, 16 Jan 2026 13:52:37 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v16 00/26] WHPX support for Arm
Date: Fri, 16 Jan 2026 14:52:09 +0100
Message-ID: <20260116135235.38092-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX6KY4hkFQZkgQ
 /4vpCR/WCmqvFq7AVrp//a07Sip1pQ6qHUp/sXR/ESVgIli9GbTr8ImHSxVXjlVdCMPTqdypUkQ
 GnRKABBe23QuoqmjjzLx+0FvVkdfvSHePhh9W07IGp0kPSMeC94iNFQz1Mjs9ghdl01BBCwKbHq
 46leiLX6RSn0y9RqvDkk4Ls2ywINqGZvZXliazmCpv+B2fwbfwTDoMH8J/wsWDaUgt+MWaP3+XZ
 oVY/xBKd/jCmjicE0T0qIc32unnMMA6B06guQDASPRNcdn/CKvcRTX2exGiwKxJTu1v8L+oErn2
 5YkKrxP+/wlBo+fBrlA
X-Proofpoint-ORIG-GUID: uB8eYJ_OEPSPLvSXDeIUwY9qJWOY1CXu
X-Authority-Info: v=2.4 cv=ZOTaWH7b c=1 sm=1 tr=0 ts=696a42a9
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=mDV3o1hIAAAA:8
 a=2CSUmbMKgiS_FIm3Z54A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uB8eYJ_OEPSPLvSXDeIUwY9qJWOY1CXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 clxscore=1030 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABHG3z8m2PlDCBKh1wR88g5bndzy1a7TB6592bKove8PR670VcRm9zc6o99AqSud+sVfobh5e7yNuYw6zNEb/QwTv6uM0TH5CS4YnBRmVDjuEEi0+ZB+v+3CtNN4h8fK7V16FwTUnCGcRRUczqDji/ie0Wm8ynaz6in6Y+NVCxUT2G1mNERR/od9cHy1lg3GhQpnKatP2njWTfrCSC6BDxcUBY3F31lX5+gkhMHHWnC1vx+iGryddfddQy9RLQYVXdiyvHB1WlNbpqP+2bJdNBDCReUPF009FmuhkuYEN9WYBrOnwAMOH9MuTUyiAupmLs3sR/hpOloavr2x6KZJ9l1oNP+uU8KBrt5G73u/IVTHbvHttGGJjYvYTVsM9ic6yapg0cR10pNn+aN1Qty7qfRBkmNvJ8QvxEPlgli+aJPuafsX0wN5KKpLCzT1on0k4hg4b9Ke19ABI3NO/NjwUIclHAO8FGaw3cQ7b/ZoGPbbuzYJOkOv/5vV5g3+jtq/8TOym47Z5eMd14pr3ZoaBSYjzU+HEphv4XY0NaT54LP5dY8Js6B7FqJ5vZ9tpGQxujkLkVdsx4R2JVxusMuvHp051kSm3sX7WRGS2pi4IHu0a+5vXwQLV60ZJkJEbatU6OOLZFGxXD9qagk654/Cez6LFjeeQ8J8bJs+hXscLOzThB7Lw3rQQHvL7rpohY2s+Rop8baL8SZFzjut1n23//AsHacOmUvKnBL7EJIuKy5hb3b18uNK20UpEf2wF6ZxnAu778EneRp5NjH2UgPjLhiqyuo48=
Received-SPF: pass client-ip=57.103.91.143;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v17)

Missing features:
- VM save-restore: interrupt controller state notably
- SVE register sync: I didn't have the time to test this on pre-release hardware with SVE2 support yet.
So SVE2 is currently masked for VMs when running this.

Known bugs:
- U-Boot still doesn't work (hangs when trying to parse firmware) but EDK2 does.

Note:

"target/arm/kvm: add constants for new PSCI versions" taken from the mailing list.

"accel/system: Introduce hwaccel_enabled() helper" taken from the mailing list, added here
as part of this series to make it compilable as a whole.

And another note:

Seems that unlike HVF there isn't direct correspondence between WHv registers and the actual register layout,
so didn't do changes there to a sysreg.inc.

Updates since v16:
- Address some last review comments
- Rebase with the latest origin/staging

Updates since v15:
- Some last tiny changes addressed.

Updates since v14:
- Working around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87950

It turns out that we can't avoid default: in case with an enum on GCC without warnings,
although Clang allows that behavior.

Updates since v13:
- Addressing review comments from Akihiko Odaki
- Squash GICv2 ACPI workaround patch and have it documented as a separate function
- Rebase with current origin/staging

Updates since v12:
- Address review comments and make sure that checkpatch shows no errors, make test also ran
- Tested the Windows x86_64 build too in addition to Windows arm64 and macOS arm64
- Hopefully the last revision, should be ready to merge.

Updates since v11:
- Address review comments
- Rebase up to latest staging
- Switch to assuming Qemu 11.0 as the newest machine model

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

Mohamed Mediouni (24):
  qtest: hw/arm: virt: skip ACPI test for ITS off
  hw/arm: virt: add GICv2m for the case when ITS is not available
  tests: data: update AArch64 ACPI tables
  hw/arm: virt: cleanly fail on attempt to use the platform vGIC
    together with ITS
  hw: arm: virt: rework MSI-X configuration
  docs: arm: update virt machine model description
  whpx: Move around files before introducing AArch64 support
  whpx: reshuffle common code
  whpx: ifdef out winhvemulation on non-x86_64
  whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
  hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
  whpx: interrupt controller support
  whpx: add arm64 support
  whpx: change memory management logic
  target/arm: cpu: mark WHPX as supporting PSCI 1.3
  whpx: arm64: clamp down IPA size
  hw/arm, accel/hvf, whpx: unify get_physical_address_range between WHPX
    and HVF
  whpx: arm64: implement -cpu host
  target/arm: whpx: instantiate GIC early
  whpx: arm64: gicv3: add migration blocker
  whpx: enable arm64 builds
  whpx: arm64: check for physical address width after WHPX availability
  whpx: arm64: add partition-wide reset on the reboot path
  MAINTAINERS: update the list of maintained files for WHPX

Philippe Mathieu-Daudé (1):
  accel/system: Introduce hwaccel_enabled() helper

Sebastian Ott (1):
  target/arm/kvm: add constants for new PSCI versions

 MAINTAINERS                                   |   6 +
 accel/hvf/hvf-all.c                           |   7 +-
 accel/meson.build                             |   1 +
 accel/stubs/whpx-stub.c                       |   1 +
 accel/whpx/meson.build                        |   7 +
 {target/i386 => accel}/whpx/whpx-accel-ops.c  |   6 +-
 accel/whpx/whpx-common.c                      | 536 ++++++++++
 docs/system/arm/virt.rst                      |  13 +-
 hw/arm/virt-acpi-build.c                      |  27 +-
 hw/arm/virt.c                                 | 140 ++-
 hw/i386/x86-cpu.c                             |   4 +-
 hw/intc/arm_gicv3_common.c                    |   3 +
 hw/intc/arm_gicv3_whpx.c                      | 248 +++++
 hw/intc/meson.build                           |   1 +
 include/hw/arm/virt.h                         |   8 +-
 include/hw/core/boards.h                      |   3 +-
 include/hw/intc/arm_gicv3_common.h            |   3 +
 include/system/hvf_int.h                      |   4 +
 include/system/hw_accel.h                     |  13 +
 .../whpx => include/system}/whpx-accel-ops.h  |   4 +-
 include/system/whpx-all.h                     |  20 +
 include/system/whpx-common.h                  |  26 +
 .../whpx => include/system}/whpx-internal.h   |  16 +-
 include/system/whpx.h                         |   5 +-
 meson.build                                   |  20 +-
 target/arm/cpu.c                              |   3 +
 target/arm/cpu64.c                            |  17 +-
 target/arm/hvf-stub.c                         |  20 -
 target/arm/hvf/hvf.c                          |   6 +-
 target/arm/hvf_arm.h                          |   3 -
 target/arm/kvm-consts.h                       |   2 +
 target/arm/meson.build                        |   2 +-
 target/arm/whpx/meson.build                   |   5 +
 target/arm/whpx/whpx-all.c                    | 985 ++++++++++++++++++
 target/arm/whpx/whpx-stub.c                   |  15 +
 target/arm/whpx_arm.h                         |  17 +
 target/i386/cpu-apic.c                        |   2 +-
 target/i386/hvf/hvf.c                         |  11 +
 target/i386/whpx/meson.build                  |   1 -
 target/i386/whpx/whpx-all.c                   | 569 +---------
 target/i386/whpx/whpx-apic.c                  |   2 +-
 tests/data/acpi/aarch64/virt/APIC.its_off     | Bin 164 -> 188 bytes
 42 files changed, 2146 insertions(+), 636 deletions(-)
 create mode 100644 accel/whpx/meson.build
 rename {target/i386 => accel}/whpx/whpx-accel-ops.c (96%)
 create mode 100644 accel/whpx/whpx-common.c
 create mode 100644 hw/intc/arm_gicv3_whpx.c
 rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
 create mode 100644 include/system/whpx-all.h
 create mode 100644 include/system/whpx-common.h
 rename {target/i386/whpx => include/system}/whpx-internal.h (95%)
 delete mode 100644 target/arm/hvf-stub.c
 create mode 100644 target/arm/whpx/meson.build
 create mode 100644 target/arm/whpx/whpx-all.c
 create mode 100644 target/arm/whpx/whpx-stub.c
 create mode 100644 target/arm/whpx_arm.h

-- 
2.50.1 (Apple Git-155)


