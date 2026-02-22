Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D8FC636B3
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 19:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuEih-0002Gp-OM; Sun, 22 Feb 2026 14:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuEig-0002GQ-Ak
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 14:02:18 -0500
Received: from ci-2005k-snip4-10.eps.apple.com ([57.103.89.240]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuEid-0003I9-9n
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 14:02:17 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 49FD5180046A; Sun, 22 Feb 2026 19:02:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771786933; x=1774378933;
 bh=vkq7AUeT0bOLmeZxQTMHI6vh+t8CflnWAU9Jr979mJU=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=ZQzS8dUefRfnnN2DNL0+pAI1oEuzXaTRFzyBzICFaw/ZbivZSXLvgfrMM/DtFuVuBmq2vZ/QK0slQmneovtH7NZiCNxh4ZdY0FOkYlWtADVT5WnQnVdkCNwnceO1MkIm1mWTSOZ52q2TlT/c1EX3l9tHeVUqD27q3bSQpDQmv0Zbo4owwmbe/l6TjmCO/vbWl170lth/CK/JDghcRVw+YV1DRW2k+akYjNFGIzVRD0voqT3swIaGRVYwPbJrco3eQpFxxsdqdZqmtCl9lgwn0zXH0wLaAi8CCNdFGMZna3F5sKMOWPrIJ5A7unJVCL/Uu0hpau+q2bMWmeZxid96fw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 75E961800C4B; Sun, 22 Feb 2026 19:02:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <AF1C2C7D-79B7-49F8-9790-4326A208600F@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_70D17415-EA91-4E99-A979-D08245E03933"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v10 00/14] HVF: Add support for platform vGIC and nested
 virtualisation
Date: Sun, 22 Feb 2026 20:01:57 +0100
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>
To: qemu-devel@nongnu.org
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: KHEAQtshM_l6YfWTi7Dr8UYCzSo59kzv
X-Proofpoint-ORIG-GUID: KHEAQtshM_l6YfWTi7Dr8UYCzSo59kzv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE4NCBTYWx0ZWRfX2rvp19zLmPiJ
 peEFTcIy9B3KfBEF6OH4UyOcat1lsVw52TBa9EZpMRNXC2HGQmDzG9CYHVUqlzP3swgg9K/IiFK
 R4mOYZN5rw8GCLNqiCjjOWntJKwU9mvOfiSET9yK7WucwP97OQxmYtkLlmp5naXkZeC8kZioFoe
 TDXRv/Fd/AZx/QztjSWoBjbmGpAX+FQAY8f1bHrPELVHEqiYR9RquNGzsVoU2G4kaPFVFhZCrWa
 3/zDD6oDks85Z6xBU8XSmlu50+E6E2XqJa0bBSnzEyvTUoNQrxvQL79QMEF8fII1ranIYPislCZ
 Ga6LVn+tm7Xk4yI899djXvTVIEbbkwUZFZZsuS5oTl01+E8goTajYnI+mgYT/M=
X-Authority-Info-Out: v=2.4 cv=KK5XzVFo c=1 sm=1 tr=0 ts=699b52b4
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=GaQpPoNlAAAA:8
 a=NEAV23lmAAAA:8 a=4ap5Q1dKWWTZuao9jVgA:9 a=QEXdDO2ut3YA:10
 a=DNcEyBE1SEeqdwRpoMYA:9 a=bICAp185kop9RbZp:21 a=_W_S_7VecoQA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1030
 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220184
X-JNJ: AAAAAAABxe7ybHEJKq9+R0cV97WbNWvo7H2SuqwGrn0DCWOAhkS50VB8yKXFyNb0g0jgWytIoZi/AMG6uBAuj+sIMX1Ih8w8Gyj2+Vz8nUoNJFqPS/EpJBE4ksUg7UKbdRHLQGUqnFcbJLU22TDaj6OakkZZiXaECoTmIqLEurx00iBMpKmWpyUOkd8+UA7TAouAaSnFfaQu0Gt3Ao7hZibMcbLUs/FS+ZWA0IQPkoYJJvnwgZqfTnjfrUQh4Wa9vKwJAAx5ZO0Oww2U0ZIIs5HztDzg6YFiWPRTLz6RCFB33epfQUJpspBKRvSJw2bD3BvTqCJHzuns/wRsDDvvS/5uzYLpTEeb79nDljxiuTVzZZIc+qr6AKzx0vYxBtmDoVRblBm7uOMoA2rm59ZmdAeI16bgpMK4ShnPptCLyPHdo/BPA/KCS5FgG5JOKZilcQFY+V3xFTPoiBt3CqcMCngMYORtKhg3cuY5LE3f1FOXNzU+lxSXTcaANbOf0njupBcgYD3TWsNiuhGUWZpyv+ySE9TK5JBK+iToUa0wl9+Ixmb2mz+t54Z6SmLhbKIrbbMQpqwDAzziQygLSKz+mEPK/zRC+SSSSTqunEktSXKIzBQZHQzwMOQrpeOhyovxgoKlhlCTpdG+h1YIcsawBPFFGJEXUeSis2tdfn1uR5PeN4O7anXUEqA8qsEkfgq8bR8Cu/+c1feqL1N8nc5Wtexq1B9mv8mNhcoT+NUv3GvnCM1mAl+f/Hgnino9FhrYZVY=
Received-SPF: pass client-ip=57.103.89.240;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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


--Apple-Mail=_70D17415-EA91-4E99-A979-D08245E03933
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello,

Ping (for reviews)

Am missing reviews on patches: 1, 2, 3, 4, 5, 6, 8, 9, 11, 13, 14

(Series at =
https://patchew.org/QEMU/20260215112543.4817-1-mohamed@unpredictable.fr/)



> On 15. Feb 2026, at 12:25, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Link to branch: https://github.com/mediouni-m/qemu =
hvf-irqchip-and-nested
> (tag for this submission: hvf-irqchip-and-nested-v10)
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
> Mohamed Mediouni (14):
>  Revert "target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0"
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
>  hvf: arm: warn instead of assert on a write_list_to_cpustate mismatch
>=20
> accel/hvf/hvf-all.c                |  51 ++
> accel/stubs/hvf-stub.c             |   2 +
> hw/arm/virt.c                      |  37 +-
> hw/intc/arm_gicv3_common.c         |   4 +
> hw/intc/arm_gicv3_hvf.c            | 818 +++++++++++++++++++++++++++++
> hw/intc/arm_gicv3_hvf_stub.c       |  25 +
> hw/intc/meson.build                |   2 +
> include/hw/intc/arm_gicv3_common.h |   4 +
> include/system/hvf.h               |   8 +
> system/vl.c                        |   2 +
> target/arm/hvf/hvf.c               | 154 ++++--
> target/arm/hvf/sysreg.c.inc        |  35 ++
> 12 files changed, 1103 insertions(+), 39 deletions(-)
> create mode 100644 hw/intc/arm_gicv3_hvf.c
> create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
>=20
> --=20
> 2.50.1 (Apple Git-155)
>=20


--Apple-Mail=_70D17415-EA91-4E99-A979-D08245E03933
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">Hello,<div><br></div><div>Ping (for =
reviews)</div><div><br></div><div><div>Am missing reviews on patches: 1, =
2, 3, 4, 5, 6, 8, 9, 11, 13, 14</div><div><br></div><div>(Series =
at&nbsp;<a =
href=3D"https://patchew.org/QEMU/20260215112543.4817-1-mohamed@unpredictab=
le.fr/">https://patchew.org/QEMU/20260215112543.4817-1-mohamed@unpredictab=
le.fr/</a>)</div><div><br></div><div><blockquote =
type=3D"cite"></blockquote></div><div><br></div><div><blockquote =
type=3D"cite"><div>On 15. Feb 2026, at 12:25, Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>Link to branch: =
https://github.com/mediouni-m/qemu hvf-irqchip-and-nested<br>(tag for =
this submission: hvf-irqchip-and-nested-v10)<br><br>This series adds =
supports for nested virtualisation when using HVF on arm64 =
Macs.<br><br>It has two parts:<br>- Apple vGICv3 support and necessary =
infrastructure changes for it<br>- Nested virtualisation support. Note =
that the nested virtualisation implementation<br>shipping as of macOS =
26.3 is nVHE only (but it _does_ use VNCR as shipped).<br><br>It's =
rebased on top of the WHPX arm64 series.<br><br>Known issues:<br>- This =
series doesn't contain EL2 physical timer emulation, which is<br>needed =
if not leveraging the Apple vGIC.<br><br>- when nested virt is enabled, =
no UI response within EDK2<br>and a permanent wait. Workaround: -boot =
menu=3Don,splash-time=3D0.<br><br>Apple Feedback Assistant item: =
FB21649319<br><br>When the VM is running at EL2 at the very moment the =
virtual timer fires:<br>HV_EXIT_REASON_VTIMER_ACTIVATED doesn=E2=80=99t =
fire (when not using the provided vGIC)<br>- using a GICv2 doesn=E2=80=99t=
 require having transition notifiers which Hypervisor.framework =
doesn=E2=80=99t have=E2=80=A6)<br><br>and when using the provided vGIC, =
the interrupt never gets delivered back to the guest<br><br>Linux as a =
guest OS is fine with this=E2=80=A6 but the reference ArmVirtQemu edk2 =
build always uses the virtual timer even when running EFI at EL2, so it =
gets broken unless this patch is applied to edk2:<br><br>diff of =
ArmVirtPkg/ArmVirt.dsc.inc:<br><br>- =
&nbsp;ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerVirtCounterL=
ib/ArmGenericTimerVirtCounterLib.inf<br>+ =
&nbsp;ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerPhyCounterLi=
b/ArmGenericTimerPhyCounterLib.inf^M<br><br>Changelog:<br><br>v1-&gt;v2:<b=
r>Oops. I did a mistake when preparing my patches.<br><br>- Add =
hvf_arm_el2_enable(_) call to virt_set_virt<br>- Fix nested virt support =
check to add HVF<br><br>v2-&gt;v3:<br>- LORC_EL1 patch was merged =
separately, remove from this series.<br>- fix LPIs when kernel-irqchip =
disabled and using TCG<br>- remove spurious if case in vGIC supported =
version detection (inapplicable now)<br>- Add hvf_enabled() check in =
combination with hvf kernel-irqchip checks<br>- cleanly fail on attempt =
to use the platform vGIC together with ITS<br><br>v3-&gt;v4:<br>- GIC =
state save improvements, including saving the opaque Apple-specific =
state<br>- Saving HVF system register state when using the vGIC and/or =
EL2<br><br>v5:<br>- oops, fixed up save/restore to be functional<br>- =
misc changes otherwise<br><br>v6:<br>- Addressing review =
comments<br><br>v7:<br>- Address review comments, adapt around Qemu =
changes and bugfixes.<br><br>v8:<br>- Rebase, and misc =
fixes<br><br>v9:<br>- Misc fixes from WHPX review comments<br>- Split =
enablement commit for EL2 into its own separate =
commit<br><br>v10:<br><br>- A bit of changes across the board<br>- move =
HVF irqchip save/restore into irqchip code<br>- block nested virt =
support when kernel-irqchip=3Doff with a GICv2 as<br>we don't implement =
an emulated physical timer yet.<br><br>Mohamed Mediouni (14):<br> =
&nbsp;Revert "target/arm/hvf: Sync CNTV_CTL_EL0 &amp; CNTV_CVAL_EL0"<br> =
&nbsp;hw/intc: Add hvf vGIC interrupt controller support<br> =
&nbsp;hw/intc: arm_gicv3_hvf: save/restore Apple GIC state<br> =
&nbsp;accel, hw/arm, include/system/hvf: infrastructure changes for HVF =
vGIC<br> &nbsp;target/arm: hvf: instantiate GIC early<br> &nbsp;hw/arm, =
target/arm: nested virtualisation on HVF<br> &nbsp;hvf: only call =
hvf_sync_vtimer() when running without the platform<br> =
&nbsp;&nbsp;&nbsp;vGIC<br> &nbsp;hvf: gate ARM_FEATURE_PMU register =
emulation behind not being at EL2<br> &nbsp;hvf: arm: allow exposing =
minimal PMU when running with nested virt on<br> &nbsp;target/arm: hvf: =
add asserts for code paths not leveraged when using<br> =
&nbsp;&nbsp;&nbsp;the vGIC<br> &nbsp;hvf: sync registers used at EL2<br> =
&nbsp;target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1<br> =
&nbsp;hvf: enable nested virtualisation support<br> &nbsp;hvf: arm: warn =
instead of assert on a write_list_to_cpustate mismatch<br><br> =
accel/hvf/hvf-all.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| &nbsp;51 ++<br> accel/stubs/hvf-stub.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;2 +<br> hw/arm/virt.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;37 +-<br> =
hw/intc/arm_gicv3_common.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;4 +<br> =
hw/intc/arm_gicv3_hvf.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 818 =
+++++++++++++++++++++++++++++<br> hw/intc/arm_gicv3_hvf_stub.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;25 +<br> hw/intc/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +<br> include/hw/intc/arm_gicv3_common.h =
| &nbsp;&nbsp;4 +<br> include/system/hvf.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;&nbsp;8 +<br> system/vl.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;2 +<br> target/arm/hvf/hvf.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| 154 ++++--<br> target/arm/hvf/sysreg.c.inc =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;35 ++<br> 12 files =
changed, 1103 insertions(+), 39 deletions(-)<br> create mode 100644 =
hw/intc/arm_gicv3_hvf.c<br> create mode 100644 =
hw/intc/arm_gicv3_hvf_stub.c<br><br>-- <br>2.50.1 (Apple =
Git-155)<br><br></div></div></blockquote></div><br></div></body></html>=

--Apple-Mail=_70D17415-EA91-4E99-A979-D08245E03933--

