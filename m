Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20EEFCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXpp-00043k-0R; Fri, 06 Mar 2026 11:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXpl-00042H-0k
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:25 -0500
Received: from p-west3-cluster1-host8-snip4-10.eps.apple.com ([57.103.73.211]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXpi-000746-9R
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:24 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 7E61F18007A5; Fri,  6 Mar 2026 16:15:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813720; x=1775405720;
 bh=PtCpnOWyBcGI0oaLCWAfEFWFhaqT2Ba0/TrtlGHI55k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=ArJfm/sQTYIN++SvnO76MBqZvOUBKcI0RIx5nNxeIFk/srSwpcGVLMOVBaRlVcb+kaawCAHYIA2g6990w19RsxKNE8MqoU5pCfzSGsFd76RnPhsBVehcUzeIz7FzSY3bIaJXHhscV0jDUmmNTGLkLMkGcFkWiXXCBAVjysRIKWyQZ99dnR3gMT6VaAJ7cUXIYqKqyf2NwqQfE3OemtHmRoQR01nkJv0ag4AzpgMGGS/SqAyXDd+5Vn1O06Hq31hIZccj0SPz0AIvNGeYUdb5t88CN+vdsJECXw8L7bsR9QK0JesY+F6MfvtiHsUbeeQiaqIYbb5F7ntaWbqYG18Xyg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 83311180012D; Fri,  6 Mar 2026 16:15:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 00/17] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Fri,  6 Mar 2026 17:14:52 +0100
Message-ID: <20260306161509.79712-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1R0VoOaEa3wPS7x-0t-V5E_30TvX_5cW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfX+Oq/MG9X2QMM
 VUT/CTvkQ4kxTXt37074vkBUEIzfLKdw9OzOpu0V5YFUy7hOZQfpJa2d5JPL65LNI8vMJzjteTM
 c6cp0ueE7NitYHsjBygNWOrsDwPdHacpyQmTGokAS+RqMm8bhqhbePyl2mgIbmbb4RGurJ1wF+C
 uUS9DvUXEBFFrE2QqpL/1PnNeBder7dUuoxuY2SZ6DP5l4bMsG6uUCrPQccNCex2MPnYFdQKQwM
 O+SlHHecX4bx4Of3lrVumuXnIDGXJsCagsIZjiBxxMVqAe5V76Snp1XqTZz+dCYYv1iHypMRcpj
 msJ/EbpLGDNTpQkrulWGzy4yjgY3G0DUPIsXjvt2mDpJDznnzbhJHShB4DJppI=
X-Authority-Info-Out: v=2.4 cv=RKC+3oi+ c=1 sm=1 tr=0 ts=69aafd95
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=jwI92-NncrociDarPsAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1R0VoOaEa3wPS7x-0t-V5E_30TvX_5cW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAABt4WI++Cfm693QqeXokU2aeaOPgE1yBUI4+ChPb+aSMAIocZyat8EJUm13fkvz0D4bMjsteFmlEKZJ1EQNEkTkObKbJeEFm8GU6VPRExsMwmrsp5JHgl/pe6gCK/0m/hapq87dTHUiMOaBV10Cjko8ATnXJHRyii1PBcdDPpX3EcVFUZ8Q5i+oW2rzFxe6myv5OUFtYbjYS4TKvLAGbtjtoEBKElHytTO1p++A5r+Cf2ifLerLCa7uJMp7CLmYf5Jx76im9ER7FY4MpGnw/eIMJdQbhq6IClpnAtP8OhKglUk4kecMjad00qPIODnpkFToZtfE0eOucvwHV7IkBNG233lxrYH8a2JUmWkVw4SsKoLev1WJskF2vraFpSyuIRRJOQsPshKDcx+G1Gtf3VZOUIojwaH+4vS0G1yeKD1+IVndgseuyyjMJYcV4KNfgjVM66Ji9IhiSiQJu+2x76Vn9spgC2XqxHZl2f+xRsGUhforItRlV4G3184UM02Qk2Hp+MFx65MIV6tifuJXxMJ4asVaPN1DIX8IYRX9gQzCZSiJaYM1lePW4GgiwywokH/5gUANIWCRjDJrLCXT/k5E6GHlrJVlH0Ckue36DRp99Gmd7jUQD7PhpZNyZEN6KwwF1pw2RZzzbRk3obdvJlCECVfvlLr/L1+hpsywJw4Ky3u92v8rV+51eMYPT8/m9A5979pnwSLGFAAbvViN+yUtuhTrrfoe44r+hMQ/OQXyADGj72rikRzCWCETB/z3QqzNS8LZXvQvF1Qf2/YIOY87le10b0PW1iAfNjbBJto660=
Received-SPF: pass client-ip=57.103.73.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
(tag for this submission: hvf-irqchip-and-nested-v15)

This series adds supports for nested virtualisation when using HVF on arm64 Macs.

Reviews would be very welcome :-) It's maybe a bit unlikely that this will make
it to QEMU 11.0 I might as well try.

The first two patches are from the SME enablement series and are present for the
series to be buildable on its own.

It has two parts:
- Apple vGICv3 support and necessary infrastructure changes for it
- Nested virtualisation support. Note that the nested virtualisation implementation
shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as shipped).

This series doesn't contain EL2 physical timer emulation, which is
needed if not leveraging the Apple vGIC. As such, nested virt requires kernel-irqchip=on.

Known issues:
- when nested virt is enabled, no UI response within EDK2
and a permanent wait. Workaround: -boot menu=on,splash-time=0.

Apple Feedback Assistant item: FB21649319

When the VM is running at EL2 at the very moment the virtual timer fires:
HV_EXIT_REASON_VTIMER_ACTIVATED doesn’t fire (when not using the provided vGIC)
- using a GICv2 doesn’t require having transition notifiers which Hypervisor.framework doesn’t have…)

and when using the provided vGIC, the interrupt never gets delivered back to the guest

Linux as a guest OS is fine with this… but the reference ArmVirtQemu edk2 build always uses the virtual timer even when running EFI at EL2, so it gets broken unless this patch is applied to edk2:

diff of ArmVirtPkg/ArmVirt.dsc.inc:

-  ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerVirtCounterLib/ArmGenericTimerVirtCounterLib.inf
+  ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerPhyCounterLib/ArmGenericTimerPhyCounterLib.inf^M

Changelog:

v1->v2:
Oops. I did a mistake when preparing my patches.

- Add hvf_arm_el2_enable(_) call to virt_set_virt
- Fix nested virt support check to add HVF

v2->v3:
- LORC_EL1 patch was merged separately, remove from this series.
- fix LPIs when kernel-irqchip disabled and using TCG
- remove spurious if case in vGIC supported version detection (inapplicable now)
- Add hvf_enabled() check in combination with hvf kernel-irqchip checks
- cleanly fail on attempt to use the platform vGIC together with ITS

v3->v4:
- GIC state save improvements, including saving the opaque Apple-specific state
- Saving HVF system register state when using the vGIC and/or EL2

v5:
- oops, fixed up save/restore to be functional
- misc changes otherwise

v6:
- Addressing review comments

v7:
- Address review comments, adapt around Qemu changes and bugfixes.

v8:
- Rebase, and misc fixes

v9:
- Misc fixes from WHPX review comments
- Split enablement commit for EL2 into its own separate commit

v10:

- A bit of changes across the board
- move HVF irqchip save/restore into irqchip code
- block nested virt support when kernel-irqchip=off with a GICv2 as
we don't implement an emulated physical timer yet.

v11:
- fixups for the save/restore Apple GIC state patch
- block the same registers as the revert in 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
for "hvf: sync registers used at EL2"
- drop patch that warns instead of aborts on mismatch

v12:
- Have the SME2 series at the start of this.
- Adaptation for the SME2 series.

v13:
- include "fix SME capabilities reporting" patch instead of it being standalone
- include "remove hvf_arm.h include" patch at the beginning of the series

v14:
- Turns out that the HVF SME2 patches broke the build for pretty much anything
non-macOS, and didn't address that properly in v13
- Addressed some checkpatch nits

v15:
- Pick new revision of SME2 patches
- separate disable nested virt when SME on patch

v17:
- Availability checks as needed except for the vGIC code, where they're
just skipped instead as availability is checked elsewhere.

Manos Pitsidianakis (2):
  hvf/arm: handle FEAT_SME2 migration
  hvf/arm: expose FEAT_SME2 to guest if available

Mohamed Mediouni (15):
  hw/arm: virt: remove hvf_arm.h include
  hvf: hvf-all: stop including hvf_arm.h
  hw/intc: Add hvf vGIC interrupt controller support
  hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
  accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
  target/arm: hvf: instantiate GIC early
  hw/arm, target/arm: nested virtualisation on HVF
  hvf: only call hvf_sync_vtimer() when running without the platform
    vGIC
  hvf: gate ARM_FEATURE_PMU register emulation behind not being at EL2
  hvf: arm: allow exposing minimal PMU when running with nested virt on
  target/arm: hvf: add asserts for code paths not leveraged when using
    the vGIC
  hvf: sync registers used at EL2
  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
  hvf: arm: disable SME when nested virt is active
  hvf: enable nested virtualisation support

 accel/hvf/hvf-all.c                |  52 +-
 accel/stubs/hvf-stub.c             |   2 +
 hw/arm/virt.c                      |  38 +-
 hw/intc/arm_gicv3_common.c         |   4 +
 hw/intc/arm_gicv3_hvf.c            | 828 +++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_hvf_stub.c       |  25 +
 hw/intc/meson.build                |   2 +
 include/hw/intc/arm_gicv3_common.h |   4 +
 include/system/hvf.h               |   8 +
 system/vl.c                        |   2 +
 target/arm/hvf/hvf.c               | 482 ++++++++++++++++-
 target/arm/hvf/hvf_sme_stubs.h     | 172 ++++++
 target/arm/hvf/sysreg.c.inc        |  52 ++
 target/arm/hvf_arm.h               |  46 ++
 target/arm/machine.c               |   2 +-
 15 files changed, 1691 insertions(+), 28 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
 create mode 100644 target/arm/hvf/hvf_sme_stubs.h

-- 
2.50.1 (Apple Git-155)


