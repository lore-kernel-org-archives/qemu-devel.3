Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08FCD6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 23:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8RlE-0004G3-0J; Thu, 02 Apr 2026 19:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8RlB-0004Fe-Ln
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 19:47:37 -0400
Received: from p-west2-cluster6-host12-snip4-10.eps.apple.com ([57.103.70.123]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Rl9-00042K-KK
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 19:47:37 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPS id
 3D55D18000A5; Thu, 02 Apr 2026 23:47:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775173649; x=1777765649;
 bh=D6L229f0EObaJTmRUCouEl3joahXTR7CkBSJojRSYjg=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=C2dePvxq4DocMXgRY4X9fwYMmZD6l/f99Ix3iCSDfA+1kCz5z9dx8wquIDxbMD9dgpdZ8gUAauiXoR7TjxkESxx055juigJJoa2cAKmt/nqv9fX8wY/S/a5VfkLAfdwNd/A/wTfRVSdBhhTb5aJ0f+LJDrc/Bm3+iX3SGneoHrOmOrjSOszZxeRJHm57T9w67AHssEKFr6pTVdpmQP1cY/v9DL2f9WBXnpCNZIckZr9Ot6DMvpFK0ahClH1QGRyO64rspG4FgcomVdkS6p9V2JN8twSPei95w6vva5KIuFbrENR0haKhmtXqAhooLlrdJ3IMT62ybCeYvkEnKX21Mg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPSA id
 1DF711800138; Thu, 02 Apr 2026 23:47:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 0/7] whpx: i386: x2apic emulation for kernel-irqchip=off,
 feature probing
Date: Fri,  3 Apr 2026 01:47:17 +0200
Message-ID: <20260402234724.88276-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxMiBTYWx0ZWRfX/+U8kn51zDDQ
 9w9RW9VyHlXClsMOCLMMfka/ntyLhz1qxBuf5DLkdx14NSy+8UiEg+EWb/w8LSDsn726UMWfdcs
 3rh8/lJWNr49h2F/nFF6zDPQ4rCFxEkApElROkJM1QYiKmJ7DqYDnyoXtVw5u68eFe3b4uCmwmZ
 FM0CR8NEN8K9/2u00Qz9XDtgvavdcaJtM9cKJdMQLBYntkGZtmVloyAbijpwYsQBHTlRJ+wBnDy
 9u+L9CQ523+YXHDvBlrOeCzVMG/MAO9F/qW43O6MID5dfqRjk0xbx/cirUjaknhxEF7fsvNlwFO
 SB5K0hdqZH/iZ0ul9DLLG9+Vmp2Bd2qN1472EQWbD9EURv9ZyrRrlfxIMKED3M=
X-Proofpoint-GUID: VT0gJVnWtJTpIK5VRnCvD99i3ykwHX0W
X-Proofpoint-ORIG-GUID: VT0gJVnWtJTpIK5VRnCvD99i3ykwHX0W
X-Authority-Info-Out: v=2.4 cv=UOnQ3Sfy c=1 sm=1 tr=0 ts=69cf0011
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=H6DntnHRh2LvQRP9VsEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1030 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=413 adultscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604020212
Received-SPF: pass client-ip=57.103.70.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

"whpx: i386: disable TbFlushHypercalls for emulated LAPIC" is a
bugfix, and "target/i386: emulate: include name of unhandled instruction"
is a debugging aid.

"whpx: i386: x2apic emulation" makes things slightly better for Windows
10 users. But I strongly recommend *not* relying on it when possible and
using kernel-irqchip=on instead. On Windows 10 however that's more murky
because PIC interrupt injection is broken (interrupts don't wake the vCPU
from HLT) in that case.

"whpx: i386: wire up feature probing" is yet another commit adding a code path
not used on Windows 10. It'll tell the user today which CPU features they set
are incompatible with the hardware but it does not sync that to the CPUID view
that the guest has.

And then another commit to enable x2apic emulation by default even for
kernel-irqchip=off + re-introducing provided by QEMU enlightenments in a more
functional form to signal that the x2apic can be used. I'm not aware of the
actual vmware freq leaf being used though.

"whpx: x2apic emulation for kernel-irqchip=off follow-up" is rolled into this series.

And then at the end but dependent on this series, CPUID intercepts finally...
However that's only supported starting from Windows 11/Server 2022.

Some performance (or lack thereof...) numbers:

On a Ryzen 7 8700GE with a Windows 10 VM running with KVM in nested virt, with
kernel-irqchip=off for the virt Alpine Linux x86_64 ISO (3.23.3) with -smp cores=2,
boot times as reported through dmesg:

- QEMU 10.2: 83 seconds
- QEMU 10.2 with a single core: 18.1 seconds
- as of this series, x2apic forced off: 29 seconds
- as of this series, out of the box: 18 seconds
- and with 1 core instead of two: 12.6 seconds

And with this series on a Windows 11 VM on the same hardware:
- kernel-irqchip=on: 6.5 seconds
- kernel-irqchip=on, x2apic forced off: 7.6 seconds
- kernel-irqchip=off: 8.3 seconds
- hyperv=off,kernel-irqchip=off: 7.6 seconds... which is faster,
so the absence of enlightenment support on Windows 10 doesn't explain things...

With kernel-irqchip=on on Windows 10, when booting with SeaBIOS, it gets stuck in
syslinux due to PIC interrupt injection being broken there. That can be counted
as an infinite boot time (?).

Changes in v3:

- Fixing CPUID intercepts so that QEMU CPU models work fine now, instead
of the partial intercept that was present in QEMU 10.2
- cleanups

Changes in v2:

- GCC warned when a variable name was re-used within a different (but overlapping)
scope in the same function. It also warned with a -Werror=maybe-uninitialized for
the MSR write case. Address those
- make the in-KVM enlightenments path available on Windows 11 too when -M hyperv=off.

Mohamed Mediouni (7):
  target/i386: emulate: include name of unhandled instruction
  whpx: i386: x2apic emulation
  whpx: i386: wire up feature probing
  whpx: i386: disable TbFlushHypercalls for emulated LAPIC
  whpx: i386: enable x2apic by default for user-mode LAPIC
  whpx: i386: reintroduce enlightenments for Windows 10
  whpx: i386: introduce proper cpuid support

 accel/whpx/whpx-common.c       |   2 +
 include/system/whpx-internal.h |   4 +
 target/arm/whpx/whpx-all.c     |   1 +
 target/i386/cpu.c              |  25 +++
 target/i386/emulate/x86_emu.c  |   4 +-
 target/i386/whpx/whpx-all.c    | 289 ++++++++++++++++++++++++++++++++-
 target/i386/whpx/whpx-i386.h   |   4 +
 7 files changed, 322 insertions(+), 7 deletions(-)
 create mode 100644 target/i386/whpx/whpx-i386.h

-- 
2.50.1 (Apple Git-155)


