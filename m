Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C1DF419BA
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0JG-0007D3-GJ; Wed, 15 Apr 2026 09:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JF-0007Co-5J
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:37 -0400
Received: from pv-2002l-snip4-3.eps.apple.com ([57.103.64.164]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JD-00046f-4f
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:36 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 A15C41800113; Wed, 15 Apr 2026 13:29:31 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgDTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRNEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtIAVsHXwNFCEsBVAVdHEUBQARVGlofHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776259773; x=1778851773;
 bh=84oHIDLn+0Y3NvfWJVVZOzRnOnZjeK2S92ay2hJixsw=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=aqO7x+Qe3414Xpf3ku0y9DiyKvacR2GzfEgo43olD+mqmfGoZ0YZfdaAoLnUTtoEiVYea4suaTfUZpDi73mTnw1/k2MsQBGUamVHH3DDQXXamwj66euUVLMpXGQfQlR7+jMHBkcYIoMMlLn0yS3MJQEI6N7ZqBFIV8OnKKsfSSpqODGpoHAQMgmy/Y6sXWUla4YtUIaelZRhJuXo5PLtkZUrFTFukIT+aUgJzXdrSRcimnAiOhgukM1QkqHKcwmPp30ha8Q5r53eOJM+0OgfjGi4mj/tw5O96Q88JfVA7xGbq9Fgwxb4C46wq/dF0mELzch1FICwwTVXgfk2nQnKrw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 8D8CF1800547; Wed, 15 Apr 2026 13:29:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v2 00/10] whpx: i386: Some more changes
Date: Wed, 15 Apr 2026 15:29:16 +0200
Message-ID: <20260415132926.58878-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KcNKJK48B3DRropn4y6V2lKgmZR-1hsv
X-Proofpoint-ORIG-GUID: KcNKJK48B3DRropn4y6V2lKgmZR-1hsv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyNSBTYWx0ZWRfX1wgE39vlIhzd
 jvWPopiZ1+UyHelLtq6Tu1pZ+lwM4Yl1Z/AOSA1cwc+QzdmgOVHNfgFu1gMNYAAmRUgbwYjBopy
 3CtJ5LR9DTVirf+WL2cR9HxfuqFuZFCIcjrlShu6ftzzkosekMAXKF1gUGX2S+am/F9jAUp3vu+
 ps+CxuUH+S/QBn/VHU6ESmoeMSxH5AP0cnABjIk/OfoXb7p8cu4wWoblXFH4y041U+1Qe9s9ybH
 ymoezlGR+CE2De2OLTjE2COXGWRji2B5PPux/dOdhh3rGbG3R5spvo4ZXIjzKYIbTtuw7oanHAd
 wbxwwyi19rMIksrHoUH34P4y761hdbmAPmZN9tk6LqG/Hqu/Hr4FTlmQcA86Os=
X-Authority-Info-Out: v=2.4 cv=G5QR0tk5 c=1 sm=1 tr=0 ts=69df92bc
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=oOLWm9IBL3BG_uuw-oUA:9 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=57.103.64.164;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This applies on top of the "whpx: i386: bug fixes, feature probing and CPUID" series.

"target: i386: HLT type that ignores EFLAGS.IF" is probably the most worthwhile patch
here, and that not-quite-an-HLT might be what's needed to reduce CPU idle on KVM on
recent Windows versions too..

v1 -> v2:

Oops, my v1 had a bug in HV_X64_MSR_GUEST_IDLE emulation, We should not inject interrupts
after it ignoring EFLAGS.IF. That matters just for the wake from HLT.

Trapping one more CPUID for x2APIC system topology, and some more x2APIC awareness. For the
kernel-irqchip=off case, keep the hypervisor aware of the initial APIC ID we're hoosing anyways.

Based-on: <20260413205208.50643-1-mohamed@unpredictable.fr>

Mohamed Mediouni (10):
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

 accel/whpx/whpx-common.c       | 38 +++++++++++++++++
 include/system/whpx-internal.h |  1 +
 target/i386/cpu.c              | 10 +++--
 target/i386/cpu.h              |  2 +
 target/i386/whpx/whpx-all.c    | 77 +++++++++++++++++++++++++++++++---
 target/i386/whpx/whpx-apic.c   | 12 +++++-
 6 files changed, 129 insertions(+), 11 deletions(-)

-- 
2.50.1 (Apple Git-155)


