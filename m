Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B1AF34C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJ8m-0005ai-H4; Mon, 13 Apr 2026 11:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8U-0005Tn-4n
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:23:39 -0400
Received: from qs-2001a-snip4-7.eps.apple.com ([57.103.87.10]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8Q-0000RV-9B
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:23:37 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 E61A3180010E; Mon, 13 Apr 2026 15:23:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776093812; x=1778685812;
 bh=VcQbQQfZCPKyOeMxphf10bRBZbvYKbSjds7zUGaLjiI=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=MkKXiUunaLBUFOEf1WBS9ip3tgmkuvDr3Wl+l9U0cUxyAW8IkL6tfnVUiyw1MswJdYaGw7zc71VCOFALjbtIe6J77zS81bSfEHWP9oqC00zHevIOfTo04n85fBaB8cuzJKwf3plA88ZQk5BhpyrVbUGuQBVKm5tx7cl8tIai1jh9tRjRpB5GlWeJ2MHL51GSxjr/4MLVXybz8VYSkNnXPYU+eIpJj10mXSmE8ja2LlCe1AkXiRGxfgxIldmrKYBorwFXs9zqYWw/qMTtxgqrlpJou6Yp/zO5NnvLPWzyJOfHFG9Lb+qYCzmUlIwo6X9cS9wBwOVTDE1rHc/ETiAnTA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 39D57180016D; Mon, 13 Apr 2026 15:23:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v10 00/14] whpx: i386: bug fixes, feature probing and CPUID
Date: Mon, 13 Apr 2026 17:23:12 +0200
Message-ID: <20260413152326.63738-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=PZPyRyhd c=1 sm=1 tr=0 ts=69dd0a73
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1DGgg3L7_nY_qRTbWDsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6CvUZnD_MAqNWsi6crcVnyp7GjjNq0MG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MSBTYWx0ZWRfX+KqTULXZe2xG
 DjcO+pgDvKWXcQ15fgjLN6QhsHWMp4gZTFOsqzaas0aRt9nhk/Z0g9aCMlQ6rgjBtLNLyoq96pf
 4f0arfSmjgF4HNR3txcCd+WNH61lT/PoZyzJeZp2lJZS0EgA3lbangNbzFOwlTVW8pVW5AlaZgy
 ZGt34JFrFGSta4vcepICB/LM3WwiukNGW5VPI7z77RTN7MyQ3epr759UukB5W/pAuRTRvB/j5W/
 WB4mNtzMa21LtOd9V57WlOmBGTf6mImrNsKGO40qgZ8ZpKeocNd6MzW91wKCCa6u0vTCMWzz6bs
 S046hWVd2v1DscMZH/8gmYh+BB3Jqqzdc3Wza/QvT5Lo6eW2UnBFpOmHJ4aQEw=
X-Proofpoint-GUID: 6CvUZnD_MAqNWsi6crcVnyp7GjjNq0MG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=976
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1030
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130151
Received-SPF: pass client-ip=57.103.87.10;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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

This is a supplemental update that includes
"whpx: i386: x2apic emulation for kernel-irqchip=off, feature probing"
v4 unmodified.

This might be too big for QEMU 11.0 at this point though...

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

"whpx: i386: reintroduce enlightenments for Windows 10" is a bugfix to make
x2APIC work as intended on Windows 10 without emulating an IOMMU.
*And* a massive improvement for Windows 10 hosts in performance for Linux guests
due to using the right clocksource instead of HPET.

And dependent on this series so included, CPUID intercepts finally...
However that's only supported starting from Windows 11/Server 2022.

Also ended up switching over Windows 10 to kernel-irqchip=off
by default due to PIC interrupt injection being broken.

Old performance (or lack thereof...) numbers:

On a Ryzen 7 8700GE with a Windows 10 VM running with KVM in nested virt, with
kernel-irqchip=off for the virt Alpine Linux x86_64 ISO (3.23.3) with -smp cores=2,
boot times as reported through dmesg:

- QEMU 10.2: 83 seconds
- QEMU 10.2 with a single core: 18.1 seconds
- as of v6 of this series, x2apic forced off: 29 seconds
- as of v6 this series, out of the box: 18 seconds
- v6 with kernel-irqchip=on and EDK2: 16.5 seconds
- v6 with kernel-irqchip=off and EDK2: 9.5 seconds
- v6, and with 1 core instead of two: 12.6 seconds

In v7, the Windows 10 numbers are pretty much at parity with Windows 11 now.

And with this series on a Windows 11 VM on the same hardware:
- kernel-irqchip=on: 6.5 seconds
- kernel-irqchip=on, x2apic forced off: 7.6 seconds
- kernel-irqchip=off: 8.3 seconds
- hyperv=off,kernel-irqchip=off: 7.6 seconds... which is faster,
so the absence of enlightenment support on Windows 10 doesn't explain things...

With kernel-irqchip=on on Windows 10, when booting with SeaBIOS, it gets stuck in
syslinux due to PIC interrupt injection being broken there. That can be counted
as an infinite boot time (?).

checkpatch false positives:

ERROR: spaces required around that '*' (ctx:WxV)
+         UINT32 Ecx, WHV_CPUID_OUTPUT *CpuidOutput))

Not a multiplication but a pointer reference.

ERROR: space prohibited after that '&' (ctx:ExW)
+                    & CPUID_7_0_EDX_CET_IBT) {
                     ^

ERROR: space prohibited after that '&' (ctx:ExW)
+                    & CPUID_7_0_ECX_CET_SHSTK) {
                     ^

Because it's multiline.

Changes in v10:
- disallow APIC reads when the APIC is disabled
- fix CPUID[1:EDX].APIC reporting

Changes in v9:

- Oops,  "if (irr == -1)" change (and cleanup)
to avoid an abort(). And think that I understand this a bit better now.

Changes in v8:

- Interrupt priority changes are back.
- Some CPUID fixes
- disable enlightenments and LAPIC for isapc

Changes in v7:

- Exposing VMware hypervisor identification when not
using Hyper-V enlightenments and when the VMware frequency
CPUID leaf isn't explictly disabled.

- Remove the interrupt priority logic as it has issues with
PIC interrupts. Can be reintroduced later.

- -cpu max passing through CPUID info from Hyper-V
- fill xsave info

- OSXSAVE CPUID leaf reporting fix.

Changes in v6:

- kernel-irqchip=off fix: re-registering the interrupt window
when the existing one has too low of a TPR value.

Folded into "whpx: i386: kernel-irqchip=off fixes".

- I/O port access fast path cleanup commit added at the end

The path relied on a side effect of whpx_get_reg instead of
something cleaner.

- Use the CR8 register provided by the hypervisor only when
kernel-irqchip=off. Rely on the APIC state synchronisation
otherwise.

This fixes some register sync errors that surfaced when setting
the TPR values properly.

Changes in v5/v1 with rename:

- kernel-irqchip=off fixes, notably making 64-bit Windows bootable
- switching over Windows 10 to kernel-irqchip=off by default

Changes in v4:

- Ugh for a revision sent quickly, unbreaking the arm64 build...
- and making checkpatch happier to some extent

Changes in v3:

- Fixing CPUID intercepts so that QEMU CPU models work fine now, instead
of the partial intercept that was present in QEMU 10.2
- cleanups

Changes in v2:

- GCC warned when a variable name was re-used within a different (but overlapping)
scope in the same function. It also warned with a -Werror=maybe-uninitialized for
the MSR write case. Address those
- make the in-KVM enlightenments path available on Windows 11 too when -M hyperv=off.

Mohamed Mediouni (14):
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

 accel/whpx/whpx-common.c       |   2 +
 hw/intc/apic.c                 |   9 +
 include/system/whpx-common.h   |   2 +-
 include/system/whpx-internal.h |  10 +
 target/arm/whpx/whpx-all.c     |   1 +
 target/i386/cpu.c              |  25 ++
 target/i386/whpx/whpx-all.c    | 601 +++++++++++++++++++++++++++------
 target/i386/whpx/whpx-apic.c   |  71 +++-
 target/i386/whpx/whpx-i386.h   |   4 +
 9 files changed, 613 insertions(+), 112 deletions(-)
 create mode 100644 target/i386/whpx/whpx-i386.h

-- 
2.50.1 (Apple Git-155)


