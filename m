Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C86F01814
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQlU-0000fI-KX; Fri, 06 Mar 2026 03:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQlS-0000eZ-EP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:42:30 -0500
Received: from p-west1-cluster4-host6-snip4-6.eps.apple.com ([57.103.65.247]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQlQ-0003iz-81
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:42:30 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-6 (Postfix) with ESMTPS id
 11ECC18001A4; Fri,  6 Mar 2026 08:42:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772786546; x=1775378546;
 bh=zXbcEnpeh1Z4yrvx24iNm/Es0uNeLUJOYge9951eWI4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=cMmkTzkbLGd9Dg18WHq1xS4nURO0BTDJ32pgsRJpZvjUb/gkLRSVKZPSpUuRWHog33rRW0W3E+AKp0id3poBsWFVUVGBiEhOZE8KA4+1Nfcc3Cdu+UWpzd6nohiNs04deCaygoa6KmljnUJ5YS/Yx38nTpSaQNw6UsWAfl5a6fxx9GbjdDcIunIQQe5LjCx2Nnuos2dXLNnPXQbLPSpcMB9cfQcbFkc/xkestO7qsb7/v+gkHZy2DR9E9gmnCjtuscc8dGx86mBbLRCmeFOz7NfQfuoJwT5PCmfwt5zZyfBnefc7qpRWeWa62fnsGpSTQIVK1tXhm8O4j9XEuLKBMQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-6 (Postfix) with ESMTPSA id
 394B018000B3; Fri,  6 Mar 2026 08:42:19 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v14 00/19] HVF: Add support for platform vGIC and nested
 virtualisation
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
Date: Fri, 6 Mar 2026 09:42:06 +0100
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0B1C0A2-DA89-4C00-9C6C-BBEEB2727AB2@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: I7hrLEaiUj1itUwchx7oFIU51tECBVBK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MiBTYWx0ZWRfX398a0tYppht1
 BuW+JvnfyACvKqQv3MET91916dD35Az85A77DTXb4ReQtmnyaRJLA4umta8ooLgbl30JOYbhFSA
 t9VTBlpdHR7tfTUzA+vOrVvW/ylKXJnEM/y5ruLZjSFPAfcn2PFGqESq7LiZXik8nSAdwWo92vQ
 05L2xPy9nohu+IJUWowjksxXhqBxg0Qgf8Mc/GuOUk6dTwSk0OI6P+z9FF81xgTr7uqvuTwhJKW
 3VKeLR3a/L7JPpi1YdFIIeCRlAN+pSGKHEeNYR9hMhci3xPac+IedrBC1pLJNJCchVIg+Dzwknw
 sE1Bfxdw2WgoBoEe6nJmzIhwEu0stpKuyo7GckNmZAbE5mTuCgP6lHauxIbK9s=
X-Proofpoint-GUID: I7hrLEaiUj1itUwchx7oFIU51tECBVBK
X-Authority-Info-Out: v=2.4 cv=TambdBQh c=1 sm=1 tr=0 ts=69aa936f
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=vPj9LedlLUqjr1h06ZwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1030
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060082
Received-SPF: pass client-ip=57.103.65.247;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_PASS=-0.001,
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



> On 6. Mar 2026, at 09:30, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Link to branch: https://github.com/mediouni-m/qemu =
hvf-irqchip-and-nested
> (tag for this submission: hvf-irqchip-and-nested-v13)
>=20
Hello,

Oops, hvf-irqchip-and-nested-v14

> This series adds supports for nested virtualisation when using HVF on =
arm64 Macs.
>=20
> Reviews would be very welcome :-) It's maybe a bit unlikely that this =
will make
> it to QEMU 11.0 I might as well try.
>=20
> Patches pending review:
>=20
> 1, 2, 3, 15, 17, 18
Please have patches 1 to 3 applied before the HVF SME2 patches=E2=80=A6 =
otherwise the Linux build breaks=E2=80=A6
And patch 18 is also not nested virt related as such but merely making =
HVF SME2 support feature reporting functional.

Note: I didn=E2=80=99t test x86 macOS builds but I believe this should =
be enough.

Sorry for sending a bit too many revisions in too short of a time but =
this _should_ be the last one...

>=20
> It has two parts:
> - Apple vGICv3 support and necessary infrastructure changes for it
> - Nested virtualisation support. Note that the nested virtualisation =
implementation
> shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as =
shipped).
>=20
> This series doesn't contain EL2 physical timer emulation, which is
> needed if not leveraging the Apple vGIC. As such, nested virt requires =
kernel-irqchip=3Don.
>=20
> Known issues:
> - when nested virt is enabled, no UI response within EDK2
> and a permanent wait. Workaround: -boot menu=3Don,splash-time=3D0.
>=20
> Apple Feedback Assistant item: FB21649319
>=20
Apple replied to that and said:

Investigation complete - works as currently designed

Which is a bit fair given how timer virt works on NV2 without relying on =
ECV=E2=80=A6

> When the VM is running at EL2 at the very moment the virtual timer =
fires:
> HV_EXIT_REASON_VTIMER_ACTIVATED doesn=E2=80=99t fire (when not using =
the provided vGIC)
> - using a GICv2 doesn=E2=80=99t require having transition notifiers =
which Hypervisor.framework doesn=E2=80=99t have=E2=80=A6)
>=20
> and when using the provided vGIC, the interrupt never gets delivered =
back to the guest
>=20
> Linux as a guest OS is fine with this=E2=80=A6 but the reference =
ArmVirtQemu edk2 build always uses the virtual timer even when running =
EFI at EL2, so it gets broken unless this patch is applied to edk2:
>=20
> diff of ArmVirtPkg/ArmVirt.dsc.inc:
>=20
> -  =
ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerVirtCounterLib/Arm=
GenericTimerVirtCounterLib.inf
> +  =
ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerPhyCounterLib/ArmG=
enericTimerPhyCounterLib.inf^M
>=20
> Changelog:
>=20
> v1->v2:
> Oops. I did a mistake when preparing my patches.
>=20
> - Add hvf_arm_el2_enable(_) call to virt_set_virt
> - Fix nested virt support check to add HVF
>=20
> v2->v3:
> - LORC_EL1 patch was merged separately, remove from this series.
> - fix LPIs when kernel-irqchip disabled and using TCG
> - remove spurious if case in vGIC supported version detection =
(inapplicable now)
> - Add hvf_enabled() check in combination with hvf kernel-irqchip =
checks
> - cleanly fail on attempt to use the platform vGIC together with ITS
>=20
> v3->v4:
> - GIC state save improvements, including saving the opaque =
Apple-specific state
> - Saving HVF system register state when using the vGIC and/or EL2
>=20
> v5:
> - oops, fixed up save/restore to be functional
> - misc changes otherwise
>=20
> v6:
> - Addressing review comments
>=20
> v7:
> - Address review comments, adapt around Qemu changes and bugfixes.
>=20
> v8:
> - Rebase, and misc fixes
>=20
> v9:
> - Misc fixes from WHPX review comments
> - Split enablement commit for EL2 into its own separate commit
>=20
> v10:
>=20
> - A bit of changes across the board
> - move HVF irqchip save/restore into irqchip code
> - block nested virt support when kernel-irqchip=3Doff with a GICv2 as
> we don't implement an emulated physical timer yet.
>=20
> v11:
> - fixups for the save/restore Apple GIC state patch
> - block the same registers as the revert in =
28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
> for "hvf: sync registers used at EL2"
> - drop patch that warns instead of aborts on mismatch
>=20
> v12:
> - Have the SME2 series at the start of this.
> - Adaptation for the SME2 series.
>=20
> v13:
> - include "fix SME capabilities reporting" patch instead of it being =
standalone
> - include "remove hvf_arm.h include" patch at the beginning of the =
series
>=20
> v14:
> - Turns out that the HVF SME2 patches broke the build for pretty much =
anything
> non-macOS, and didn't address that properly in v13
> - Addressed some checkpatch nits
>=20
> Manos Pitsidianakis (2):
>  hvf/arm: handle FEAT_SME2 migration
>  hvf/arm: expose FEAT_SME2 to guest if available
>=20
> Mohamed Mediouni (17):
>  hw/arm: virt: remove hvf_arm.h include
>  target/arm: cpu64: only include hvf_arm.h when HVF is enabled
>  hvf: hvf-all: stop including hvf_arm.h
>  hw/intc: Add hvf vGIC interrupt controller support
>  hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
>  accel, hw/arm, include/system/hvf: infrastructure changes for HVF =
vGIC
>  target/arm: hvf: instantiate GIC early
>  hw/arm, target/arm: nested virtualisation on HVF
>  hvf: only call hvf_sync_vtimer() when running without the platform
>    vGIC
>  hvf: gate ARM_FEATURE_PMU register emulation behind not being at EL2
>  hvf: arm: allow exposing minimal PMU when running with nested virt on
>  target/arm: hvf: add asserts for code paths not leveraged when using
>    the vGIC
>  hvf: sync registers used at EL2
>  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
>  hvf: arm: SME2 availability fixes
>  hvf: arm: fix SME capabilities reporting
>  hvf: enable nested virtualisation support
>=20
> accel/hvf/hvf-all.c                |  52 +-
> accel/stubs/hvf-stub.c             |   2 +
> hw/arm/virt.c                      |  38 +-
> hw/intc/arm_gicv3_common.c         |   4 +
> hw/intc/arm_gicv3_hvf.c            | 822 +++++++++++++++++++++++++++++
> hw/intc/arm_gicv3_hvf_stub.c       |  25 +
> hw/intc/meson.build                |   2 +
> include/hw/intc/arm_gicv3_common.h |   4 +
> include/system/hvf.h               |   8 +
> system/vl.c                        |   2 +
> target/arm/cpu64.c                 |   2 +
> target/arm/hvf/hvf.c               | 468 +++++++++++++++-
> target/arm/hvf/hvf_sme_stubs.h     | 158 ++++++
> target/arm/hvf/sysreg.c.inc        |  52 ++
> target/arm/hvf_arm.h               |  46 ++
> target/arm/machine.c               |   2 +-
> 16 files changed, 1659 insertions(+), 28 deletions(-)
> create mode 100644 hw/intc/arm_gicv3_hvf.c
> create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
> create mode 100644 target/arm/hvf/hvf_sme_stubs.h
>=20
> --=20
> 2.50.1 (Apple Git-155)
>=20


