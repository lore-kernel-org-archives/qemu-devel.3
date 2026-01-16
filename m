Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF95C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 16:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgmWl-0000qp-Bi; Fri, 16 Jan 2026 11:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgmW8-0000iA-Ja; Fri, 16 Jan 2026 11:17:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgmW3-00055Q-JK; Fri, 16 Jan 2026 11:17:43 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60GGGint010611
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 17 Jan 2026 01:17:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=wenR3gMhAR/7Wei1xWklK/JuHv8V33VyiGnNxWdvrlE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1768580232; v=1;
 b=N8XZCSD7reOxnOeH3bLbJUL/aH9RXX/t8oLkiNEqBRvialmKU7HbBplVs/+bK7rQ
 6sLi4axiY23Vpo4Cd8a2Is4dc6FIMzexlfxby5NxdToo7oISoKOjQnqteLT89qq4
 otsZT7xPuN7/sbLcRnXYFvda7OJFBuipdvRciUht5WLHcrTiyeK6IVp3tSrbMTtH
 VKQWC+qwM4RyTjpzXE7erTcUayJJZDlDFUXWQejJiYQt190wObM3FivpkBB5nkc5
 obOFKjCmuFj6JfH1Cu+qgrbSB322jXdpU94P5KEflI0i0pNxR10LGB7sG3P/snF4
 3+e50vbJ1rZwbks9ta1cDg==
Message-ID: <b001888c-25bb-4122-a501-026485a360b9@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 17 Jan 2026 01:16:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/26] WHPX support for Arm
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/01/16 22:52, Mohamed Mediouni wrote:
> Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v17)
> 
> Missing features:
> - VM save-restore: interrupt controller state notably
> - SVE register sync: I didn't have the time to test this on pre-release hardware with SVE2 support yet.
> So SVE2 is currently masked for VMs when running this.
> 
> Known bugs:
> - U-Boot still doesn't work (hangs when trying to parse firmware) but EDK2 does.
> 
> Note:
> 
> "target/arm/kvm: add constants for new PSCI versions" taken from the mailing list.
> 
> "accel/system: Introduce hwaccel_enabled() helper" taken from the mailing list, added here
> as part of this series to make it compilable as a whole.
> 
> And another note:
> 
> Seems that unlike HVF there isn't direct correspondence between WHv registers and the actual register layout,
> so didn't do changes there to a sysreg.inc.
> 
> Updates since v16:
> - Address some last review comments
> - Rebase with the latest origin/staging

I see no bugs with this version. For the whole series:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Thank you for your continuous effort on this.

Regards,
Akihiko Odaki

> 
> Updates since v15:
> - Some last tiny changes addressed.
> 
> Updates since v14:
> - Working around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87950
> 
> It turns out that we can't avoid default: in case with an enum on GCC without warnings,
> although Clang allows that behavior.
> 
> Updates since v13:
> - Addressing review comments from Akihiko Odaki
> - Squash GICv2 ACPI workaround patch and have it documented as a separate function
> - Rebase with current origin/staging
> 
> Updates since v12:
> - Address review comments and make sure that checkpatch shows no errors, make test also ran
> - Tested the Windows x86_64 build too in addition to Windows arm64 and macOS arm64
> - Hopefully the last revision, should be ready to merge.
> 
> Updates since v11:
> - Address review comments
> - Rebase up to latest staging
> - Switch to assuming Qemu 11.0 as the newest machine model
> 
> Updates since v10:
> - Bring forward to latest Qemu
> - Fix a typo in the GICv3+GICv2m PR
> 
> Updates since v9:
> - Adding partition reset on the reboot side of things...
> 
> Updates since v8:
> - v9 and v8 were not submitted properly because of my MTA not behaving, sorry for that.
> - v10 introduces a new argument, -M msi=, to handle MSI-X configuration more granularly.
> - That surfaced what I think is a bug (?), with vms->its=1 on GICv2 configurations... or I did understand everything wrong.
> - Oopsie due to email provider ratelimiting.
> 
> Updates since v7:
> - Oops, fixing bug in "hw/arm: virt: cleanly fail on attempt to use the platform vGIC together with ITS".
> Other commits are unchanged.
> 
> Updates since v6:
> - Rebasing
> - Fixing a bug in the GICv3+GICv2m case for ACPI table generation
> - getting rid of the slots infrastructure for memory management
> - Place the docs commit right after the "cleanly fail on attempt to run GICv3+GICv2m on an unsupported config" one
> as that's what switches ITS to a tristate.
> - Fixing a build issue when getting rid of the arch-specific arm64 hvf-stub.
> 
> Updates since v5:
> - Rebasing
> - Address review comments
> - Rework ITS enablement to a tristate
> - On x86: move away from deprecated APIs to get/set APIC state
> 
> Updates since v4:
> - Taking into account review comments
> - Add migration blocker in the vGICv3 code due to missing interrupt controller save/restore
> - Debug register sync
> 
> Updates since v3:
> - Disabling SVE on WHPX
> - Taking into account review comments incl:
> 
> - fixing x86 support
> - reduce the amount of __x86_64__ checks in common code to the minimum (winhvemulation)
> which can be reduced even further down the road.
> - generalize get_physical_address_range into something common between hvf and whpx
> 
> Updates since v2:
> - Fixed up a rebase screwup for whpx-internal.h
> - Fixed ID_AA64ISAR1_EL1 and ID_AA64ISAR2_EL1 feature probe for -cpu host
> - Switched to ID_AA64PFR1_EL1/ID_AA64DFR0_EL1 instead of their non-AA64 variant
> 
> Updates since v1:
> - Shutdowns and reboots
> - MPIDR_EL1 register sync
> - Fixing GICD_TYPER_LPIS value
> - IPA size clamping
> - -cpu host now implemented
> 
> Mohamed Mediouni (24):
>    qtest: hw/arm: virt: skip ACPI test for ITS off
>    hw/arm: virt: add GICv2m for the case when ITS is not available
>    tests: data: update AArch64 ACPI tables
>    hw/arm: virt: cleanly fail on attempt to use the platform vGIC
>      together with ITS
>    hw: arm: virt: rework MSI-X configuration
>    docs: arm: update virt machine model description
>    whpx: Move around files before introducing AArch64 support
>    whpx: reshuffle common code
>    whpx: ifdef out winhvemulation on non-x86_64
>    whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
>    hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
>    whpx: interrupt controller support
>    whpx: add arm64 support
>    whpx: change memory management logic
>    target/arm: cpu: mark WHPX as supporting PSCI 1.3
>    whpx: arm64: clamp down IPA size
>    hw/arm, accel/hvf, whpx: unify get_physical_address_range between WHPX
>      and HVF
>    whpx: arm64: implement -cpu host
>    target/arm: whpx: instantiate GIC early
>    whpx: arm64: gicv3: add migration blocker
>    whpx: enable arm64 builds
>    whpx: arm64: check for physical address width after WHPX availability
>    whpx: arm64: add partition-wide reset on the reboot path
>    MAINTAINERS: update the list of maintained files for WHPX
> 
> Philippe Mathieu-Daudé (1):
>    accel/system: Introduce hwaccel_enabled() helper
> 
> Sebastian Ott (1):
>    target/arm/kvm: add constants for new PSCI versions
> 
>   MAINTAINERS                                   |   6 +
>   accel/hvf/hvf-all.c                           |   7 +-
>   accel/meson.build                             |   1 +
>   accel/stubs/whpx-stub.c                       |   1 +
>   accel/whpx/meson.build                        |   7 +
>   {target/i386 => accel}/whpx/whpx-accel-ops.c  |   6 +-
>   accel/whpx/whpx-common.c                      | 536 ++++++++++
>   docs/system/arm/virt.rst                      |  13 +-
>   hw/arm/virt-acpi-build.c                      |  27 +-
>   hw/arm/virt.c                                 | 140 ++-
>   hw/i386/x86-cpu.c                             |   4 +-
>   hw/intc/arm_gicv3_common.c                    |   3 +
>   hw/intc/arm_gicv3_whpx.c                      | 248 +++++
>   hw/intc/meson.build                           |   1 +
>   include/hw/arm/virt.h                         |   8 +-
>   include/hw/core/boards.h                      |   3 +-
>   include/hw/intc/arm_gicv3_common.h            |   3 +
>   include/system/hvf_int.h                      |   4 +
>   include/system/hw_accel.h                     |  13 +
>   .../whpx => include/system}/whpx-accel-ops.h  |   4 +-
>   include/system/whpx-all.h                     |  20 +
>   include/system/whpx-common.h                  |  26 +
>   .../whpx => include/system}/whpx-internal.h   |  16 +-
>   include/system/whpx.h                         |   5 +-
>   meson.build                                   |  20 +-
>   target/arm/cpu.c                              |   3 +
>   target/arm/cpu64.c                            |  17 +-
>   target/arm/hvf-stub.c                         |  20 -
>   target/arm/hvf/hvf.c                          |   6 +-
>   target/arm/hvf_arm.h                          |   3 -
>   target/arm/kvm-consts.h                       |   2 +
>   target/arm/meson.build                        |   2 +-
>   target/arm/whpx/meson.build                   |   5 +
>   target/arm/whpx/whpx-all.c                    | 985 ++++++++++++++++++
>   target/arm/whpx/whpx-stub.c                   |  15 +
>   target/arm/whpx_arm.h                         |  17 +
>   target/i386/cpu-apic.c                        |   2 +-
>   target/i386/hvf/hvf.c                         |  11 +
>   target/i386/whpx/meson.build                  |   1 -
>   target/i386/whpx/whpx-all.c                   | 569 +---------
>   target/i386/whpx/whpx-apic.c                  |   2 +-
>   tests/data/acpi/aarch64/virt/APIC.its_off     | Bin 164 -> 188 bytes
>   42 files changed, 2146 insertions(+), 636 deletions(-)
>   create mode 100644 accel/whpx/meson.build
>   rename {target/i386 => accel}/whpx/whpx-accel-ops.c (96%)
>   create mode 100644 accel/whpx/whpx-common.c
>   create mode 100644 hw/intc/arm_gicv3_whpx.c
>   rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
>   create mode 100644 include/system/whpx-all.h
>   create mode 100644 include/system/whpx-common.h
>   rename {target/i386/whpx => include/system}/whpx-internal.h (95%)
>   delete mode 100644 target/arm/hvf-stub.c
>   create mode 100644 target/arm/whpx/meson.build
>   create mode 100644 target/arm/whpx/whpx-all.c
>   create mode 100644 target/arm/whpx/whpx-stub.c
>   create mode 100644 target/arm/whpx_arm.h
> 


