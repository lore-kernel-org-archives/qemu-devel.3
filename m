Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B50EFD0040
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 21:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwS9h-0004C4-BC; Sat, 28 Feb 2026 16:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9c-0004AX-Ki
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:16 -0500
Received: from qs-2005h-snip4-11.eps.apple.com ([57.103.86.211]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9Z-0002TO-UC
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:16 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 283351800106; Sat, 28 Feb 2026 21:47:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772315230; x=1774907230;
 bh=IZX2QJVDnGBoU0QkwO/ek1rKoSoX312+r89tK51ufbE=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=Q35/d2FqbMwGtE/RbWR681ar8dMV+K8QRYa/iqFEha8AKADS7m1rfLpoigksbenSL1upXij8maIH8TyGBUj97IoZlTVEVTI0c5OmqKikamuAE+b3tX2Vme/B3AbQq9SfEdB5PVauGUWER6tAyPr9IJkoCiEBJm1QxFwBZzLL8w/3++ZNwkN99Xa/c/mB6pQA/syynXvX+S4To5VIiSXmtG7sVcvfQsDHgCAXcr3k3xXLlL7xBr1DyOurcflybyR+fT4Du+VUowbNiDrGmCiAomN1l4heguSaVAEPSML9E3+sgA+Xkv5hq71UMErS4Sc+wuWWwzf+gzFbd5p/22kGKA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 48CE9180018D; Sat, 28 Feb 2026 21:47:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 0/8] whpx: i386: even more changes
Date: Sat, 28 Feb 2026 22:46:56 +0100
Message-ID: <20260228214704.19048-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: G-jyiJ65cxUbg7D0XYnXCMvIaxHG7jLj
X-Proofpoint-GUID: G-jyiJ65cxUbg7D0XYnXCMvIaxHG7jLj
X-Authority-Info-Out: v=2.4 cv=NoDcssdJ c=1 sm=1 tr=0 ts=69a3625d
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=GaQpPoNlAAAA:8 a=Eotg4ay_O2_8UUDZPf4A:9 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwMyBTYWx0ZWRfX4g7cByfGZTjo
 hc/TbZH1BPQbYXEdgbRZZf5eqaG4yu6GWc56miDZfct0beRLnDfdbJcEjd4X7csQSc75LodbPp1
 TrlJ8dME9VmecUDeaGDeI137lLRETIPtuYPoziSCTeTzA3tSnkXpmRsrfwgZnWmLcnlH8jaKuAF
 QTGfCTmF7KkGn7dWtRwlUYcXHfk6Ftyg8pu6L0nGniaspbHLeLGI5H7oQaZG+NOGnUuwhyEQ9cG
 4SeTRL/43EDGr2mHGyNbYQxd4KzkO4xkOioZ6SK/PFe2tse6IREQ5NXjVisoKHseDne10S2Dodh
 +eQ3vNqh7NO8uuFD5c2vTsD49lu4NolI1eAziqrn2tAPfpuO1aO9EHNiFtkw2I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 clxscore=1030 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=834 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280203
X-JNJ: AAAAAAABdJk8cjvc63njtbUsGEruseDwGhU2KH+vI174M64UEhg1mz4n7Ll1afu2HrKbVvSvb6aOVg7r1gy+RhI31IOGUCNq+l1OvPAiDA+f11GjKJCmu0wyKVLg6obdtn+1qv7ZiCaTGUC0E6cxCXaIod5pDWDZFjBZF70b0fLfsUbwsdfDbAQkc2IXO1fdkkMoX6LVD1fWl/HrmvA/cL2J9B9Z894IvTygyJyDjPTaC3DQCs+ecs542b6T7sfR51AihunGtnJSoGUUIgPpuBjgDOJ9irV371orMhFLRYSQKUD0cSDemx6ACBHFEcMSU3C7MwQf0univglqodVmqLDgs4fQPkvjAM2jr4xNMf45YsroKErfSMHDFGmDs60iSBg3HtPHPBWvo5DhnNfEmFulcms6WrVXVQvH8MlgWE6NaT3YZF1Op68FWGhFAcwr4wBy0v+bSnBk8xZtFJM5d23R70L6X49kKO1hAnyHGONRFP1W/EQpSMfYbwj9t4JetwVeBJkf5f+r1w/FQ2MbQQswvyWmpGb11SuY4H5IoktlW5cGlDBs4tKCN8mEyYKoSigdbGLqThFT1uc6Ntx+e7mfTCB4RaW5vgV2OH4NEzTsn0RSCbzuOGvRQzxtaNB6axRRC2+srMsw2BBZc8E2CxpJj9E=
Received-SPF: pass client-ip=57.103.86.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722, SPF_HELO_PASS=-0.001,
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

Hello,

I think that'll be it for QEMU 11.0. This one contains some additional set of patches on top of the v1 of "whpx: i386: even more changes".

This is to be applied on top of https://patchew.org/QEMU/20260223233950.96076-1-mohamed@unpredictable.fr/
followed by https://patchew.org/QEMU/20260226181930.53170-1-mohamed@unpredictable.fr/

I think the missing bits now for WHPX on x86 are mainly:

- incomplete and/or sometimes erroneous emulation in target/i386/emulate - it's nowhere near passing the kvm-unit-tests
emulator test but hopefully will be good enough for this release. HVF relied on it for a long time after all :)

- and save/restore is the other big one. This one is missing from the Arm backend too. I won't have that ready in time
for the 11.0 window closing unfortunately. On the x86 side, I'm tempted to wait until it's done for MSHV and then pick
up the pieces from there.

And on that note, the layout returned by WHvGetVirtualProcessorState(WHvVirtualProcessorStateTypeInterruptControllerState2)
is this:

typedef struct _HV_X64_INTERRUPT_CONTROLLER_STATE
{
    UINT32 ApicId;
    UINT32 ApicVersion;
    UINT32 ApicLdr;
    UINT32 ApicDfr;
    UINT32 ApicSpurious;
    UINT32 ApicIsr[8];
    UINT32 ApicTmr[8];
    UINT32 ApicIrr[8];
    UINT32 ApicEsr;
    UINT32 ApicIcrHigh;
    UINT32 ApicIcrLow;
    UINT32 ApicLvtTimer;
    UINT32 ApicLvtThermal;
    UINT32 ApicLvtPerfmon;
    UINT32 ApicLvtLint0;
    UINT32 ApicLvtLint1;
    UINT32 ApicLvtError;
    UINT32 ApicLvtCmci;
    UINT32 ApicErrorStatus;
    UINT32 ApicInitialCount;
    UINT32 ApicCounterValue;
    UINT32 ApicDivideConfiguration;
    UINT32 ApicRemoteRead;

} HV_X64_INTERRUPT_CONTROLLER_STATE, *PHV_X64_INTERRUPT_CONTROLLER_STATE;

which matches the hv_local_interrupt_controller_state structure in the hvgdk_mini.h present for MSHV.

Side note: probably want to add a KVM capability to skip the instruction emulator - and whatever plumbing might be needed
to pass all the instruction fault info given by the hardware. And fallback execution too, which would allow stabilising
the set of instructions supported by the in-KVM emulator going forward once target/x86/emulate is more complete.

Happy hacking :)

This series is pretty small:

- the first patch is a fixup for "whpx: x86: kick out of HLT manually when using the kernel-irqchip"

It can be squashed with it and fixes the "sti; hlt" KVM unit test case.

- enable all supported host features

This enables the nested virt capability too when marked as supported (although without nested virt enlightenments).

- enable synthetic processor features

QEMU assumes that those are a property of the CPU, but Hyper-V needs that info at partition init time, so just
enable them unconditionally for now.

- warn on unsupported MSR accesses

This applies on top of the "whpx: x86 updates (2026-02)" and "whpx: i386: interrupt-related updates" series.

- target/i386/emulate: more 64-bit register handling

- whpx: i386: enable PMU

- whpx: i386: expose HV_X64_MSR_APIC_FREQUENCY for kernel-irqchip=off

Instead of having it be handled as zeroing...

- target/i386: emulate: fix scas

Based-on: <20260223233950.96076-1-mohamed@unpredictable.fr>

Mohamed Mediouni (8):
  whpx: i386: move whpx_vcpu_kick_out_of_hlt() invocation to interrupt
    raise time
  whpx: i386: enable all supported host features
  whpx: i386: enable synthetic processor features
  whpx: i386: warn on unsupported MSR access instead of failing silently
  target/i386: emulate: more 64-bit register handling
  whpx: i386: enable PMU
  whpx: i386: expose HV_X64_MSR_APIC_FREQUENCY when kernel-irqchip=off
  target/i386: emulate: fix scas

 target/i386/emulate/x86_emu.c   |  19 ++++
 target/i386/emulate/x86_flags.c |  47 +++++++++
 target/i386/emulate/x86_flags.h |  20 ++++
 target/i386/whpx/whpx-all.c     | 162 ++++++++++++++++++++++++++------
 4 files changed, 220 insertions(+), 28 deletions(-)

-- 
2.50.1 (Apple Git-155)


