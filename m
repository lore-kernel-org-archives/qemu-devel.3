Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF3EF99C98
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEEK-0005zI-Bo; Sat, 18 Apr 2026 18:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEI-0005xT-4m
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:33:34 -0400
Received: from p-east2-cluster5-host6-snip4-10.eps.apple.com ([57.103.79.103]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEF-0004nY-EH
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:33:33 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 523481800216; Sat, 18 Apr 2026 22:33:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551610; x=1779143610;
 bh=B3E3+Qpf9RMxvAk900SymXwSsDFxy7HOMIprGgY42rI=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=GLE+ZfhodHgdXtHqZeLhz+L9SUjKoaGPFC4mYCCAB4UyKDRmmGlNbs+xE79RdXZSo6Y/RytDWhQ2Kb/8+2hRcUIF1o/BQsChZyT9T+NUMkONDF56tVMm+H6z1NZiBZfoDolwl7FvmNaTIhTqUB4EYbiFxjZvXnJSwwpcY802W5nqn1YZG/oLn3sd3xNyR+3fGQPT7XSgYngH8dUXiLGKAllE+QHJC7Vn5tWmP/oQs3NPkjEhkNwaByQ8uqG4DBi4wh91q/6Hbr1AB0tw5EuATftaQuw/+0iJq3WjPG6hzkxyfZvUx4ukvw2n7Rxi0SIfwJSxgKvK1zXxFXujuvb2zQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 94B701800219; Sat, 18 Apr 2026 22:33:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 00/38] WHPX x86 updates for QEMU 11.1
Date: Sun, 19 Apr 2026 00:32:42 +0200
Message-ID: <20260418223320.51330-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I7F2R-QcAAUnyDuvEpRwi61OXCs7MmPq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfXzDMT+M1WOCk7
 zwHHmLIvs6a1ckbjvaadTOYBC/tuCBgJ0INuNY2DGAU0wKndFD1vBXGg6DAVLIX0ciV0rVGLUmU
 So2aiX8jHZoyANVSg6h9gj6FkTytV/3B7bvgHKPIr2Xpz4+lH9Y0QFiL64++JuAYetrpr9BK0Im
 2RSMTAptS/Frn2S02/7/PUOf1mEoF+6g4wHORzq5DbLTs6wQ0dHq1yFT7lT2X+fPVBmMVHlAfQX
 qwWqB2NFiVAAJn9Az9erdfopM9FpcnnJTJdNJYP+GMDLXB6CEbXVSPazLybs7cfeM/idkhQb3DB
 AN34f/y9T5IFu6SPfB5ENxW44MiZAUOMDhtCcA4arPD0w30aWdpZcR/qhmVHS0=
X-Proofpoint-ORIG-GUID: I7F2R-QcAAUnyDuvEpRwi61OXCs7MmPq
X-Authority-Info-Out: v=2.4 cv=GP0F0+NK c=1 sm=1 tr=0 ts=69e406b8
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=k3UGef2UMelxMxAvkqcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=596 clxscore=1030
 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.79.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Magnus Kulke (1):
  target/i386: add de/compaction to xsave_helper

Mohamed Mediouni (37):
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
  whpx: i386: one more CPUID
  whpx: i386: some x2APIC awareness
  whpx: i386: set WHvX64RegisterInitialApicId
  whpx: i386: Pause VM on fatal exception to be able to inspect state
  target/i386: emulate: use exception_payload for fault address
  whpx: i386: CPU features support for Windows 10
  target/i386: make xsave_buf present unconditionally
  whpx: xsave support
  whpx: i386: set APIC ID only when APIC present
  whpx: i386: update migration blocker message
  whpx: i386: don't increment eip on MSR access raising GPF
  target/i386: emulate, hvf: rdmsr/wrmsr GPF handling
  whpx: i386: add feature to intercept #GP MSR accesses
  whpx: i386: intercept CPUID 0xD too
  whpx: i386: documentation update

 accel/whpx/whpx-common.c           |   78 ++
 docs/system/whpx.rst               |   30 +-
 hw/intc/apic.c                     |    9 +
 include/system/whpx-common.h       |    2 +-
 include/system/whpx-internal.h     |   28 +
 target/arm/whpx/whpx-all.c         |    1 +
 target/i386/cpu.c                  |   25 +-
 target/i386/cpu.h                  |    6 +-
 target/i386/emulate/x86_emu.c      |   14 +-
 target/i386/emulate/x86_emu.h      |    4 +-
 target/i386/emulate/x86_mmu.c      |    3 +-
 target/i386/hvf/hvf.c              |    9 +-
 target/i386/whpx/meson.build       |    1 +
 target/i386/whpx/whpx-all.c        | 1244 ++++++++++++++++++++++------
 target/i386/whpx/whpx-apic.c       |   83 +-
 target/i386/whpx/whpx-cpu-legacy.c |  171 ++++
 target/i386/whpx/whpx-i386.h       |   11 +
 target/i386/xsave_helper.c         |  255 ++++++
 18 files changed, 1692 insertions(+), 282 deletions(-)
 create mode 100644 target/i386/whpx/whpx-cpu-legacy.c
 create mode 100644 target/i386/whpx/whpx-i386.h

-- 
2.50.1 (Apple Git-155)


