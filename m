Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B694CC6B01
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8AgU-0002Oz-VN; Thu, 02 Apr 2026 01:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8AgR-0002Kd-UL
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:33:35 -0400
Received: from qs-2007c-snip4-6.eps.apple.com ([57.103.84.157]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8AgP-0004u9-T6
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:33:35 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPS id
 B4E341800170; Thu, 02 Apr 2026 05:33:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775108012; x=1777700012;
 bh=VypUKrw6p0u5yBCdpLo/PDJLTMFGPp3eu3O/rEJ9dPU=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=eIkUIz5XE/Lg+R4PtR5WN8DcXBj87nu0ER1mAsPiFqTxJ6mOvW6es5V6+RXaaonvXr3rTwlyQyGLS/grzSTyOtSSqHRrcJ9l4nVetoMmklSQ4kj7J3Mvjzc3c98jgNk34nkp7Y7Oz3FbyoJLdZGO8ig6qdQK3bgMKNMjB/wvUL5yPZjj1JPK2ne9XZboAqDZ7M7rfNDydo/ld+ROhs+1J5ZpB4LeQjdzTPNDZFfq0nicZ02Cy4RoReIwlnKgqXdWxzDK8C+DI+kfx+w6DlJyHC0AZPIv7a0RuwzCawYw+2N0fT+vt7FEvabfLZtKcUjY/6NLXAkt/K5XZb0PrkYVig==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPSA id
 38A181800356; Thu, 02 Apr 2026 05:33:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 0/4] whpx: i386: x2apic emulation for kernel-irqchip=off,
 feature probing
Date: Thu,  2 Apr 2026 07:33:22 +0200
Message-ID: <20260402053326.23402-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0NyBTYWx0ZWRfXzbXVTQQYq3j6
 vY/caOlM1K59GJwFFIPWW+Fx2ZO4H9uhdd2u6SAO4+ns1yNeyh2iPC5UFxwQ7udiNIPFjp+d+rZ
 WDzyo+7sUeMpT1gMT6bOvOV/xZAFArM5gf2/5z+WVYi6YEbSODVWVlU5r3qp7ipnmHkiADQd6x5
 oXoC0sT//ix3m2/M9S19XiPTCucRInGy6YQuJSc6VtI097Z+OWgUVRBaKTUlwD2oZ7sZ28D1aPO
 815PgLdLY49a8VcQhSGfQ9ky3KuIT1tBqevF+oNWCeLTRibf9T0PkC7NJNIr1Xd+bNFx1nnS8Wa
 8Nsk2gBFgbynnNoPYLnbVHq4F9tLH3Ge4IWPn0iko72MmGqtIpOafvq/aXiZ98=
X-Authority-Info-Out: v=2.4 cv=Vb/6/Vp9 c=1 sm=1 tr=0 ts=69cdffab
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=cqXy_Kte1r4GVz_6oMIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kgxEBFwE2FhmUlKElGfHN9YADicpL8sg
X-Proofpoint-ORIG-GUID: kgxEBFwE2FhmUlKElGfHN9YADicpL8sg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=249
 clxscore=1030 adultscore=0 malwarescore=0
 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020047
Received-SPF: pass client-ip=57.103.84.157;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mohamed Mediouni (4):
  target/i386: emulate: include name of unhandled instruction
  whpx: i386: x2apic emulation
  whpx: i386: wire up feature probing
  whpx: i386: disable TbFlushHypercalls for emulated LAPIC

 include/system/whpx-internal.h |   3 +
 target/i386/cpu.c              |  25 +++++
 target/i386/emulate/x86_emu.c  |   4 +-
 target/i386/whpx/whpx-all.c    | 200 ++++++++++++++++++++++++++++++++-
 target/i386/whpx/whpx-i386.h   |   4 +
 5 files changed, 229 insertions(+), 7 deletions(-)
 create mode 100644 target/i386/whpx/whpx-i386.h

-- 
2.50.1 (Apple Git-155)


