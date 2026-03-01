Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5E8FD0049
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 01:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwVhT-0000uh-Ut; Sat, 28 Feb 2026 20:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwVhQ-0000u0-6Y
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 20:34:24 -0500
Received: from p-west1-cluster2-host6-snip4-10.eps.apple.com ([57.103.64.231]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwVhM-0001ZB-UC
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 20:34:23 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-3 (Postfix) with ESMTPS id
 D3CDE1800708; Sun,  1 Mar 2026 01:34:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772328857; x=1774920857;
 bh=+YcRW6M95UxfeAGDoEPNom9P2JDCT89Cve2qcpFB0u0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=E6ghk5NyEs3KWnz2EEwJz+Sd1Jv9RT+9LHQ5hQI4adKc8MxrqTmz1yqpumE3ncpVpZP4IvXM4SXuvqTqsbl+0BiE1zselT0xV8iOMJexOU5OiHsrbnVVFszWUKFboJYZMXGR1l9g7AR2G4Ca1L3Tpk323WW5/NkOderMLec3fsqt4DQpkS1Kg+WZqXjA+AVyqdry3B0bPkSPj/SI7H/EcgZ4nFFG9Pfd0daaDb5aCki9oA4LZ32E4x6HtMU6cvPp/gYCzXj2grMUpsBzIYlsLTci9Dq4eBkXbm8jWFYv4EZnAgTgJhcHdJdpwtrTTYeYekFODxMXy7qSCgTKlYMgPQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-3 (Postfix) with ESMTPSA id
 7478518000B0; Sun,  1 Mar 2026 01:34:13 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v11 00/12] HVF: Add support for platform vGIC and nested
 virtualisation
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260228220837.35275-1-mohamed@unpredictable.fr>
Date: Sun, 1 Mar 2026 02:34:01 +0100
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BFFD4B5-6B69-4F75-B329-5C429E65532C@unpredictable.fr>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: RlHAq1IxHavVlS9tAQBypMcKGTWAUoqo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDAxMiBTYWx0ZWRfX9YfaEiz+T1Hx
 YlreLsdYbKV9Tc5I4LP75Sztle1eL8k76xr0+MlNWVWU+rUK1kcX/04+AFJf0PN1EQnmZxKi7As
 Hg2WxM37moXlR1WGT8N4qQmN136wBLmIjnNqzBvzdlDftMJFkXvsMIZ3u0IlFpMDZY3jMYoW+UP
 En1eDzxCDlHP3DNOyuav8i7RzyrAf+C3KFjUyfqjCwCPDFCZCWWHfvoGWS2wRkfgDN2bCbSVsNK
 oTPRKhHHVg2sClicaHev1DwE+/vjq3eZGsS3utUMxB+NQQ7WZVZtAdcEKDM4OGdqbxEcxZWc1g3
 pnH72qvlL+lhxz9Oe3vQfC6+4lJrdJXL9jKgL+Y+FcfDxkcgF541wPXDrSincM=
X-Authority-Info-Out: v=2.4 cv=H7/WAuYi c=1 sm=1 tr=0 ts=69a39798
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=m7eK2limkqFRwMpkuqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RlHAq1IxHavVlS9tAQBypMcKGTWAUoqo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1030 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603010012
X-JNJ: AAAAAAAB5WvGaJLOBJ8byUe3JddGRk8v6dvoRTIccVhPYNhF+uwhtadG5dQDqE7bFQzPZvmAUGVZQIDU/qzm37+dCOtwS9KLZHeXwq1bHSQb/sDHWSUcGByENtjgotrKJeV/Bpo1X5aeG2MTRXPjIx3e0JZGRRREhirujba/KzaSwaEadcSbCa8INn5DRFaB+q3WJNxyviE1Jh4wk5HmC75D+8d5T+JpVK/j2xyQTTZTBXmsrNqjbAMY00Bcf9qMoKQBlqpLqsqCDWe9bTyS7dND+NDXNuwrIapTphqdWmoO3RZkqbW6utwzX884f/8SRJudj7UIoSoaxLFUVaA+RulzjYp+C5Xs+BSKDALVRXZJSAxR7Jo0wx4MUqI5RjIPFq8NVUUk6hkIu2DqqRRL2xbMIREkPkbZsZtyWqEbKhfkKPzyQriYQRI5bcv4/LyZqYhf1vLLxkqj3D5n0S41y9vktopQHnYnU9aTzjNcFJ+YKKGuyK/41Hi2DntFkY1JkR4N5ZTIvwWIOO17HixSd/zgvh7QsSJqIyIePFsIK56YU6VuBBWq3oE6iO4oAdH2DKJK87Do3xdBbHqXC8NDkdLa7rBGdMfZliRpqcMMFoH/TejhmYW3GboA91vkemudTKiqkFAORil4gDM69dm7hVvTxAKk1rZyMU3LvSgBmFDXAmBpOjhNFG4AvGQsyDFHB170IWrGHAnflJFb7EafzHXIkbJDkP3lRExsT2TpBpEx279ApNj8A1n4rlUmrYI=
Received-SPF: pass client-ip=57.103.64.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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


> On 28. Feb 2026, at 23:08, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Link to branch: https://github.com/mediouni-m/qemu =
hvf-irqchip-and-nested
> (tag for this submission: hvf-irqchip-and-nested-v11)
>=20
> This series adds supports for nested virtualisation when using HVF on =
arm64 Macs.
>=20
> Reviews would be very welcome :-) It's maybe a bit unlikely that this =
will make
> it to QEMU 11.0 I might as well try.
>=20

The patches remaining for review:

1, 2, 3, 4, 5, 8, 10, 12

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

For reference this is a platform bug pending resolution an OS update.
Would it be good to add a specific warning about it? (In a separate =
commit)

> Apple Feedback Assistant item: FB21649319
>=20
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
> Mohamed Mediouni (12):
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
>  hvf: enable nested virtualisation support
>=20
> accel/hvf/hvf-all.c                |  51 ++
> accel/stubs/hvf-stub.c             |   2 +
> hw/arm/virt.c                      |  37 +-
> hw/intc/arm_gicv3_common.c         |   4 +
> hw/intc/arm_gicv3_hvf.c            | 822 +++++++++++++++++++++++++++++
> hw/intc/arm_gicv3_hvf_stub.c       |  25 +
> hw/intc/meson.build                |   2 +
> include/hw/intc/arm_gicv3_common.h |   4 +
> include/system/hvf.h               |   8 +
> system/vl.c                        |   2 +
> target/arm/hvf/hvf.c               | 124 ++++-
> target/arm/hvf/sysreg.c.inc        |  45 ++
> 12 files changed, 1112 insertions(+), 14 deletions(-)
> create mode 100644 hw/intc/arm_gicv3_hvf.c
> create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
>=20
> --=20
> 2.50.1 (Apple Git-155)
>=20
>=20


