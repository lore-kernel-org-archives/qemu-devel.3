Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644E0F94CC1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLH-0007sU-Fn; Wed, 22 Apr 2026 17:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLF-0007qz-Jh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:41 -0400
Received: from p-east2-cluster1-host2-snip4-7.eps.apple.com ([57.103.76.40]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLC-0006vM-Uj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:41 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 06D1218006E9; Wed, 22 Apr 2026 21:42:30 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlofHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894154; x=1779486154;
 bh=wEThq2dfzqTlfZKnGhPwgL+9iHFZpwM3gQfdJLwsJ0M=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=djIUge33BiTJ7cNlHcSWJPuhgBSlV+ih9wAg64c8CafPkV5otElCNHd7jr7JZcWHQeS42tPSI4nKtFeTrQarkY0VGSxTYfEfMEhW2xFY3CUk+O19xn+wNG7gdoVFlkquZS1qK4uD7Jf0OIdfJAzQ7Q9AlrkDajXokZIdmASdPUPjyHjf7jv0TgDCUCyPG5m59ccU5GcB/zKaUMG+9p5Vux9G4x/j5sjJaH44APeYAo9JuHltIoG5ijxg/hp0iH2Ja6FP60FOik+dp+8CeS0wSM6ZZTKaryHX1L+h4unX8u5n2o498L4QnEzW+mN3r89BX+c+lFG7XNZoS/Mx6dYD7Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 2D6E91800216; Wed, 22 Apr 2026 21:42:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 00/37] WHPX x86 updates for QEMU 11.1
Date: Wed, 22 Apr 2026 23:41:48 +0200
Message-ID: <20260422214225.2242-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX7rHVWG32ymTg
 9OIR7WW2xoAV7jeRar3RAC3M6Q87NymVyc7mLTRcv9KEA4+UlUp/YCFqNY7n0RGdrsKk/SMiZ1e
 +cDKgrtaB0eUPI/8xN/ri7OI3+yMQYasQ84AQDuofHdyHfsBWopuPCzqfoGGGzx7nHTkJnjMyjr
 75ApCFnovTf5c0rcNrQp70AyPpkY4svbfWcOzkiAI1+tRAEW/OKRpaMyDUxyQua1L2UYWxwR/IH
 bn1ZblgGx7pRTowQQIpwqC0n/fNL+w3oPwOCcyNPHj5BHtX0d9WMtq/U4VUuzOANzZ+3oSB2Y54
 o9XWSuo8YYkRGpAbk4L2M7TUOyYLz6dX3RLjPpOtfX0FY0+/JQIvxuBeqPZo28=
X-Proofpoint-GUID: by-g_CXpbxjrp2KOMlP7sy9SLb1HqVJJ
X-Proofpoint-ORIG-GUID: by-g_CXpbxjrp2KOMlP7sy9SLb1HqVJJ
X-Authority-Info-Out: v=2.4 cv=C4DkCAP+ c=1 sm=1 tr=0 ts=69e940c8
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=bnQU8WpU6WbG6yeDcMYA:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=57.103.76.40;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This rolls over my previous series posted earlier in this mailing list.
..and adds some more.

Git tree: https://github.com/mediouni-m/qemu whpx-i386-202604-4

Some highlights:
1
- user-mode x2APIC emulation (kernel-irqchip=off) for better
performance when it has to be used.
- CPU model emulation on both Windows 10 and 11
- configurable behavior for unknown MSRs and adding a way
to trap on GPFs raised by Hyper-V on MSR acccess
- when -M hyperv=off, report the hypervisor as VMware for
guests to use either the VMware CPUID leaf or the vmport
interface to get the TSC and APIC frequencies.

If the vmware CPUID frequency leaf is disabled, then KVM
is reported.
- xsave save/restore support
- Pause the VM to be able to inspect state on a fatal fault
instead of just exiting
- adding emulation of an oddball idle MSR used by Windows
when kernel-irqchip=off.
- disable kernel-irqchip and Hyper-V enlightenments for
isapc
- for Windows 10, change the default to an emulated x2APIC
(kernel-irqchip=off). The recommended way to use the Hyper-V
LAPIC is not to use -M kernel-irqchip=on, but -M pic=off.

And as the last commit, a documentation update.

Bug reports and patches are welcome.

However, due to reasons, I'll probably step aside
from this all for a bit so don't expect immediate replies.

v1->v2:

- Build fixup for macOS and OpenBSD
- a bit of cleanup

v2->v3:

Unfortunately this rev has quite a bit of changes...

- Some fixes here and there.
- Merging in Windows 10 support into something less separate.
- Move new x86-specific (at least for now) properties into a new
whpx_arch_accel_class_init method.
- Add nested virt settings and separate security domain accelerator
properties.

Magnus Kulke (1):
  target/i386: add de/compaction to xsave_helper

Mohamed Mediouni (36):
  target/i386: emulate: include name of unhandled instruction
  whpx: i386: x2apic emulation
  whpx: i386: wire up feature probing
  whpx: i386: disable TbFlushHypercalls for emulated LAPIC
  whpx: i386: enable x2apic by default for user-mode LAPIC
  whpx: i386: reintroduce enlightenments for Windows 10
  whpx: i386: introduce proper cpuid support
  whpx: i386: kernel-irqchip=off fixes
  whpx: i386: use WHvX64RegisterCr8 only when kernel-irqchip=off
  whpx: i386: disable kernel-irqchip on Windows 10 when PIC enabled
  whpx: i386: IO port fast path cleanup
  whpx: i386: disable enlightenments and LAPIC for isapc
  whpx: i386: interrupt priority support
  hw/intc: apic: disallow APIC reads when disabled
  whpx: i386: fix CPUID[1:EDX].APIC reporting
  whpx: i386: set apicbase value only on success
  whpx: i386: unknown MSR configurability
  whpx: i386: enable GuestIdleReg enlightenment
  whpx: i386: tighten APIC base validity check
  whpx: i386: ignore vpassist when kernel-irqchip=off
  target: i386: HLT type that ignores EFLAGS.IF
  whpx: i386: add HV_X64_MSR_GUEST_IDLE when !kernel-irqchip
  whpx: i386: some x2APIC awareness
  whpx: i386: set WHvX64RegisterInitialApicId
  whpx: i386: Pause VM on fatal exception to be able to inspect state
  target/i386: emulate: use exception_payload for fault address
  target/i386: make xsave_buf present unconditionally
  whpx: xsave support
  whpx: i386: set APIC ID only when APIC present
  whpx: i386: update migration blocker message
  whpx: i386: don't increment eip on MSR access raising GPF
  target/i386: emulate, hvf: rdmsr/wrmsr GPF handling
  whpx: i386: add feature to intercept #GP MSR accesses
  whpx: i386: nested virt settings
  whpx: i386: add SeparateSecurityDomain flag and make default
  whpx: i386: documentation update

 accel/whpx/whpx-common.c           |    8 +
 docs/system/whpx.rst               |   40 +-
 hw/intc/apic.c                     |    9 +
 include/system/whpx-all.h          |    1 +
 include/system/whpx-common.h       |    2 +-
 include/system/whpx-internal.h     |   31 +
 target/arm/whpx/whpx-all.c         |    5 +
 target/i386/cpu.c                  |   27 +-
 target/i386/cpu.h                  |    6 +-
 target/i386/emulate/x86_emu.c      |   14 +-
 target/i386/emulate/x86_emu.h      |    4 +-
 target/i386/emulate/x86_mmu.c      |    3 +-
 target/i386/hvf/hvf-i386.h         |    4 +-
 target/i386/hvf/hvf.c              |    9 +-
 target/i386/whpx/meson.build       |    1 +
 target/i386/whpx/whpx-all.c        | 1489 +++++++++++++++++++++++-----
 target/i386/whpx/whpx-apic.c       |   83 +-
 target/i386/whpx/whpx-cpu-legacy.c |  158 +++
 target/i386/whpx/whpx-i386.h       |   12 +
 target/i386/xsave_helper.c         |  256 +++++
 20 files changed, 1875 insertions(+), 287 deletions(-)
 create mode 100644 target/i386/whpx/whpx-cpu-legacy.c
 create mode 100644 target/i386/whpx/whpx-i386.h

-- 
2.50.1 (Apple Git-155)


