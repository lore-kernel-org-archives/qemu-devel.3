Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73FFD6AAF8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8NlE-0000J5-DK; Thu, 02 Apr 2026 15:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Nl8-0000Hk-IF
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:18 -0400
Received: from p-west1-cluster6-host8-snip4-5.eps.apple.com ([57.103.67.118]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Nl5-0008F1-4a
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:16 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPS id
 B7224180016E; Thu, 02 Apr 2026 19:31:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775158273; x=1777750273;
 bh=4MZdFeH85luQyF0HoFUqvHzGFMqGjk1LAhnuW/sLANI=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=DnyJJ9VlCgfWmnsba7EQVF0Rex1hGxYZvL1W0JvSY4iRn8Z80kVykTAvtUbvMb7pXQbW81rwCSlMHB0lYqlafYdgzLQG6vq3oJ2yxyjPS3GeUuzohKelNcsIoOrDMLWG9QzBty6gTU7dP5GFaWEIEdh0o0n9ctNr5FB0qpW8izMWUH8Ly+Lr5BfEkZ7A9gys4lTxGFmB3Vw2hEyc1gqkQ0CXk5FPeMzXxfiQkZH/IcChmcuPjynABuNJHJpAH7k7Jdd8HnDHFKkVgLApQqZNmDjt+TbNvAfj0t83EeI8GGk8jgwBiRLb/3yBCdeyKqaXpO+M5XdzUw6/ypvt2ktSAw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPSA id
 DAD9C1800141; Thu, 02 Apr 2026 19:31:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 0/6] whpx: i386: x2apic emulation for kernel-irqchip=off,
 feature probing
Date: Thu,  2 Apr 2026 21:30:58 +0200
Message-ID: <20260402193104.56331-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ijMofpnfrVfaGhV5zsH9ABqzhw34RRNK
X-Authority-Info-Out: v=2.4 cv=U+OfzOru c=1 sm=1 tr=0 ts=69cec400
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9JnVDWS6rBB4FhcYVvQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE3NSBTYWx0ZWRfX6uoaQtHLLQju
 futB0PRhn3G0XR6U4grvBcxzpdukk+aBhRhzyRtO0e9dH6c3QFeswvSHoFkLry21pT8IaELIHZT
 PvBKfNSXjbvgITKMgYT6q+/PVOogJL36/XWx69URrgEQAA43rtP9wVi1Dne20lgkuxSOPKQ8qyW
 82qYfnWYPNBzYgDwAvuEbml64k2R1/n34z3ODt3WHcuaqQiQVPQHqQcmamijTudXw72jTFbJOh3
 +Zc/xsCX+gEPpUcwp0a8rGIDMsmauD7RuofnkOkIbP+/Fsf68ZEbwgPgpSpO8y6wKBgqFc9usTr
 Ef1VTPuhfFXu4U63QuLmtMYoev7Km20VyB8x9zTz2VHb9Sqtthn/wQjbLTJEgE=
X-Proofpoint-ORIG-GUID: ijMofpnfrVfaGhV5zsH9ABqzhw34RRNK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=474 phishscore=0 clxscore=1030
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020175
Received-SPF: pass client-ip=57.103.67.118;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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

Changes in v2:

- GCC warned when a variable name was re-used within a different (but overlapping)
scope in the same function. It also warned with a -Werror=maybe-uninitialized for
the MSR write case. Address those
- make the in-KVM enlightenments path available on Windows 11 too when -M hyperv=off.

Mohamed Mediouni (6):
  target/i386: emulate: include name of unhandled instruction
  whpx: i386: x2apic emulation
  whpx: i386: wire up feature probing
  whpx: i386: disable TbFlushHypercalls for emulated LAPIC
  whpx: i386: enable x2apic by default for user-mode LAPIC
  whpx: i386: reintroduce enlightenments for Windows 10

 accel/whpx/whpx-common.c       |   2 +
 include/system/whpx-internal.h |   4 +
 target/arm/whpx/whpx-all.c     |   1 +
 target/i386/cpu.c              |  25 ++++
 target/i386/emulate/x86_emu.c  |   4 +-
 target/i386/whpx/whpx-all.c    | 265 ++++++++++++++++++++++++++++++++-
 target/i386/whpx/whpx-i386.h   |   4 +
 7 files changed, 298 insertions(+), 7 deletions(-)
 create mode 100644 target/i386/whpx/whpx-i386.h

-- 
2.50.1 (Apple Git-155)


