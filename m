Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F0CD26296
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 14:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYxV-0008NW-AV; Wed, 21 Jan 2026 09:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYxL-0008Ho-5m
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 09:13:11 -0500
Received: from ci-2006j-snip4-7.eps.apple.com ([57.103.90.228]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYxH-0006OY-Hf
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 09:13:10 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-13 (Postfix) with ESMTPS id
 D8A631800269; Wed, 21 Jan 2026 14:13:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769004786; x=1771596786;
 bh=KU//UnxobNbpn9aVpSf4stNvv6Nzz1ATHS/yBSzPEUI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=G4CNTZjmA5oH5yJvU4Hdn1SvsbndvyKMxLy9214+vLq/7P8hYeZdrAeaMnP7Cdg7V/ClreiEX+UGZVSAuBA3rmloA/EY98PqUREw2EGNBSyl/o5ywrgn34Ql2PkdKVq40X1cXlejE7FnFt2OQYQ+WKWtn/0zJAyMSdrrVNk9bhtoQ2Z4HzSqJ58poj1SpH02H+lqsLInMOl5SroDOHd6G7bFrGHvf/0lVcnv5XhWRmuvTOFAL9HexG/KRas4HTBPpMkCYiSnM9jfg3z+qv2OLI7F4GSlfxQBk5pneWlilYYTcM3PzZ/9pwlZTJGYbUxW4Bt9F3/qn00VegKzWxZtpQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-13 (Postfix) with ESMTPSA id
 F227F1800905; Wed, 21 Jan 2026 14:09:46 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v8 00/11] HVF: Add support for platform vGIC and nested
 virtualisation
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260121135816.21258-1-mohamed@unpredictable.fr>
Date: Wed, 21 Jan 2026 15:09:35 +0100
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <57B8ED23-569B-4C79-9DC4-C8A02E224367@unpredictable.fr>
References: <20260121135816.21258-1-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: 5S7NFv2xBppThQr8qBhFX8DEunF8dgeu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEyMCBTYWx0ZWRfXz/E33fQVxoh9
 k03ogVCivBSHwhWMppcUAJG9xtsyO8M1As6wVloJLPtQ0YbPbjRf3KgU01UrZFrUl4C0QcU6SM4
 3EgpKCUc/gJ2PktS9kHo+lO2mCXsp3Nj3OoDnLNraI3+Ea8ua6e5LYK511avvPuATJesww+W5Nj
 0Vu29hQK1/+TiW/6aIlliAPJYAF1JtuzRKtiThGzZPMiDAbkxaYzxRdXBd+ktzdBRu+74r/4WbG
 N6qLf8rdBkYkvz/OpyZ2GLuHTeAPPRbyTuuHxv/vwLm4lqiFd/nYRJFEUr1+J2VMeufUIbb9HxA
 YnpJ2x5DRSeom128KGw
X-Authority-Info-Out: v=2.4 cv=EpXfbCcA c=1 sm=1 tr=0 ts=6970deef
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=GaQpPoNlAAAA:8
 a=4ap5Q1dKWWTZuao9jVgA:9 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: 5S7NFv2xBppThQr8qBhFX8DEunF8dgeu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0
 clxscore=1030 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601210120
X-JNJ: AAAAAAABJVDnPpYuae2dax8VhoVXI8b7w7y58FY3nIs4GhqgSatkfsq5el5QUSTeNZSFfEI9yIY9h/61bpYmh78c6uunfVDUdD6ZSJrWO3SBtmKvMy4x9Z9dr7JP/n4IhCr0+83ldh0UjCoSqQzoGtJpt6W3nuuY//2Ci+HEEZzjHgtXEf/2EwBP/lmkv2kJTymaUOq0MQ95AWfx2DM0i+/i5IL5JOESli7pl7uzcmsPOAzIuMiF5us+H04LXZ9dJ/MOZ7Q0ExxorRpHUkUyMQyUDO7385fqax3JG7OhhOzd6zFIIqzqUgEJM/CAwDn6ccVb8uUgfqPfT6FfkKpirchqS75D+YMsHkMWvBbh/6AnDEZXSzerRxBZKSY6OP5hItO4iShEgzwAp6mYlzt+zabp2xTw8ER/o7jxvXrkjY/XOBXdmyE4h3e7CAuKLhgilef1eLcU/5B2t37+tF4d5FgDGvXCAZq4XQ1iOWWehpCo9mYkP0Ix1oZWpalq19u10s/hgKiikqDVrUb++jna5KM/uOKRsYX1tOLU/Zi2PXPJZzeIpyP8liX8xeue/b3Igo2aWnbXV9XH1Q+26xZ3k+/lJYuT1rKyhJjTvtzEpAbeZv+cd4dHQaRWOkz7ncj15SFDDPRUxMYXFDU65TP3j/vaaKucxf3kA7KDY014k9U6K7dYo1fyu8NFAojZwtN5LE1OYpKqEqpnUJeVY9+Yi78Udh9idiVg131kog==
Received-SPF: pass client-ip=57.103.90.228;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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



> On 21. Jan 2026, at 14:58, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Link to branch: https://github.com/mediouni-m/qemu =
hvf-irqchip-and-nested
> (tag for this submission: hvf-irqchip-and-nested-v8)
>=20
> This series adds supports for nested virtualisation when using HVF on =
arm64 Macs.
>=20
> It has two parts:
> - Apple vGICv3 support and necessary infrastructure changes for it
> - Nested virtualisation support. Note that the nested virtualisation =
implementation
> shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as =
shipped).
>=20
> It's rebased on top of the WHPX arm64 series.
>=20
> Known issues:
> - This series doesn't contain EL2 physical timer emulation, which is
> needed if not leveraging the Apple vGIC.
>=20
> - when nested virt is enabled, no UI response within EDK2
> and a permanent wait. Workaround: -boot menu=3Don,splash-time=3D0.
>=20
> Apple Feedback Assistant item: FB21649319
>=20
> When the VM is running at EL2 at the very moment the virtual timer =
fires:
> HV_EXIT_REASON_VTIMER_ACTIVATED doesn=E2=80=99t fire (when not using =
the provided vGIC
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
> diff --git a/ArmVirtPkg/ArmVirt.dsc.inc b/ArmVirtPkg/ArmVirt.dsc.inc
> index 643620371b..1bfe7b67fc 100644
> --- a/ArmVirtPkg/ArmVirt.dsc.inc
> +++ b/ArmVirtPkg/ArmVirt.dsc.inc
> @@ -101,7 +101,7 @@
>   =
CpuExceptionHandlerLib|ArmPkg/Library/ArmExceptionLib/ArmExceptionLib.inf
>   ArmSmcLib|MdePkg/Library/ArmSmcLib/ArmSmcLib.inf
>   ArmHvcLib|ArmPkg/Library/ArmHvcLib/ArmHvcLib.inf
> -  =
ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerVirtCounterLib/Arm=
GenericTimerVirtCounterLib.inf
> +  =
ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerPhyCounterLib/ArmG=
enericTimerPhyCounterLib.inf^M
>=20
>   PlatformPeiLib|ArmVirtPkg/Library/PlatformPeiLib/PlatformPeiLib.inf
>   =
MemoryInitPeiLib|ArmVirtPkg/Library/ArmVirtMemoryInitPeiLib/ArmVirtMemoryI=
nitPeiLib.inf

Oops, looks like patchew recognised this as a patch and failed to apply =
it=E2=80=A6
Hopefully other automation didn=E2=80=99t get broken too...
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
> Based-on: =
https://patchew.org/QEMU/20260121134114.9781-1-mohamed@unpredictable.fr/
>=20
> Mohamed Mediouni (11):
>  hw/intc: Add hvf vGIC interrupt controller support
>  accel, hw/arm, include/system/hvf: infrastructure changes for HVF =
vGIC
>  hvf: save/restore Apple GIC state
>  hw/arm, target/arm: nested virtualisation on HVF
>  hvf: only call hvf_sync_vtimer() when running without the platform
>    vGIC
>  hvf: gate ARM_FEATURE_PMU register emulation behind not being at EL2
>  hvf: arm: allow exposing minimal PMU when running with nested virt on
>  target/arm: hvf: instantiate GIC early
>  target/arm: hvf: add asserts for code paths not leveraged when using
>    the vGIC
>  hvf: sync registers used at EL2
>  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
>=20
> accel/hvf/hvf-all.c                |  51 ++
> accel/stubs/hvf-stub.c             |   2 +
> hw/arm/virt.c                      |  32 +-
> hw/intc/arm_gicv3_common.c         |   3 +
> hw/intc/arm_gicv3_hvf.c            | 742 +++++++++++++++++++++++++++++
> hw/intc/meson.build                |   1 +
> include/hw/intc/arm_gicv3_common.h |   1 +
> include/system/hvf.h               |   8 +
> system/vl.c                        |   2 +
> target/arm/hvf/hvf.c               | 197 +++++++-
> target/arm/hvf/sysreg.c.inc        |  35 ++
> 11 files changed, 1060 insertions(+), 14 deletions(-)
> create mode 100644 hw/intc/arm_gicv3_hvf.c
>=20
> --=20
> 2.50.1 (Apple Git-155)
>=20


