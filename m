Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F215EED630
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 19:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbOVL-0005y2-AT; Thu, 01 Jan 2026 14:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vbOVK-0005xj-0y
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 14:38:38 -0500
Received: from ci-2004j-snip4-11.eps.apple.com ([57.103.89.103]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vbOVG-0007Eo-6x
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 14:38:37 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-11 (Postfix) with ESMTPS id
 7AA75180014B; Thu,  1 Jan 2026 19:38:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=so/AalvRcbwCB5NrZyy9X2eT8bMqgYJkM4kj+T/4zSA=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=BvM4xNxL08ghqCnMHgjOzRWG0JvCpQJZQoplJX0PZ5WKNF8yZK409kPpljCTqV5/uOMdLa6qs0xsNM+RwaKwWxmjATUGIgUU+CQSg68C+3QFUhFK0jhxELIuZ0pAfORfLksDIYsyZeiJ/1s4ksWsTndd2xrzRO16jBvpYo9bP4lM3OyOxV3Dab6cbncrtFU+GiWQyBPOPDBv7tJxA/M/E709juHQC3XSORWHciMljymHGxWyqrdmxHun3IeBO+akTFrUc3Hx2aTBMxU3MV/YcsAhqYim2Sh7LX8KNfsdudDf3JMCJRi1Sx1oiWGb7itJiyIP5pAzMFDU64oHSyiprw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-11 (Postfix) with ESMTPSA id
 3C1BA18000BF; Thu,  1 Jan 2026 19:38:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <E1B9F0D9-17AD-4791-8E4C-3E6B07D54D23@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_D07DCC4C-1BCF-4DD2-8952-0086D1DE4B32"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v13 00/28] WHPX support for Arm
Date: Thu, 1 Jan 2026 20:38:13 +0100
In-Reply-To: <0F349673-AF6F-4015-8C19-6B6A7AD9BC45@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
 <b833265e-0a90-4696-803f-d98a7c1e3456@linaro.org>
 <9A2E2173-6CF4-4DDE-8D8F-8FFC008F9F2F@gmail.com>
 <0F349673-AF6F-4015-8C19-6B6A7AD9BC45@unpredictable.fr>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Authority-Info: v=2.4 cv=TdibdBQh c=1 sm=1 tr=0 ts=6956cd37 cx=c_apl:c_pps
 a=2G65uMN5HjSv0sBfM2Yj2w==:117 a=2G65uMN5HjSv0sBfM2Yj2w==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=6WtKYOgf9lwWC377DlUA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10 a=VQNnbj1nYAcKpd74NCAA:9 a=apNLZOEVaA86F-dc:21
 a=_W_S_7VecoQA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4tGQYqg5yifA_7eZcQ4k_NQH13zp6Uec
X-Proofpoint-ORIG-GUID: 4tGQYqg5yifA_7eZcQ4k_NQH13zp6Uec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAxMDE3OCBTYWx0ZWRfXw9RPuN/W0qS4
 jik9773vuCgW1JGg292uiHWHihGIjhVfHgAruwaWGM0XhAN/H40wWYuRA1teG+XptjzgGuPaW4Y
 Gdr8bHhVpbiagdyzUEx3L+eMeGKcjcw+REgcXEwxwq59Fw46z62Bhv/bfIio7+MbQ2w4WE6CyuY
 j2PXDkPeYOHEd9m5tA1NeewmLvprSRlXLv+Qgc0xaEtSAzoYSCB2WTLy3FRxnSLZrioOUVRhwrA
 LSAmK2ou/wK3gfk4VrxbshlApXqYJBj/Vm5eRyc0Y7HzIP22T4RTwhBUowz+Wl0XsvxP+8EMH/x
 4ENy0e0sMLszfri2IrJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1030 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601010178
X-JNJ: AAAAAAABQ/sFKCcLEj7ISfcxgV9a8d6z/UA2nmVKOO59dKLU9dJUHclGytza2+b0abVunpzSLOb1Jny9tdoi9VArs3PqkoOkD8HqmYixGc9PjnOhqp4+2uS1hn7aEC7MDXCaL+VndOFVtgfl1WORtonfEijXrYUHmt/PCOwFHAxkiRydbNAtHQb+O6/yweq9JxPyEFn5/l1lAbpq5nLVU+1wOJbvFUFlRo7LTueQQKOiH5FRnn/iCqFeC/RSep2xU6W0OFbP5quUPxsRknfiRIjZlynMdqzhATQoN3AghUT4zwY4S5hOzkpfjg5ZpykPmmADDoi+n8KkyK1D8qg/3Scln+b+tBSfifXjUKqXFbkkx+UeQ7OKnQ6tvz57l8vmh4FB4bVqvUF/VdZo5ODHWS2FXU9y+Agz1GxL8XK/3lMbK7hgl7zME+ZTJpNTLvJdstQze/yfH0mX/mg+TZMbWjm7keRk1C5GmlEau5sLx0wRe9ZaF3ocsHg+gStsBDNw0rpxSYpUE1lKMMOsZw5eLriwEPJ3jdHYPRNc0Q068AZEfLfIjiheO6gfY2JC93xmMTIlhHXyLfhy4XtO14fnLXIc8E9vHjd5/LjZuekcwMlI3tARraQf9c3o+/LQElhJFfOGoxTcB5XvAO4s1acO4zIPbltPxXrYjA8wvlkd2RzveAoUSU37yXnZPU67UEcn3N+MjozXEzUuMsQnmzq1tFLmejaWFfakcGoUjz9mo1G0keu+LE5UxB+WAmfLdLYwNDDuMcC1OVq4QkYlKV/BZMNwt+K4MJd+WTEvlu9+XTtKUSNPfMsflIs3omrp/GUG/CdD5jBbH6XFkTdq8mYxN2oJngieYPBzAtP3qOwyiKr9Oc/qWnOMYl8BuiIoK7ixP9hkJI0xT+P4PpPNpm5q7tSg9ysqGEaa3LweObo5DkLBs2XSkv7RU3vOqn5iSDoJHMV9TB3zL3v2gcFhA3aGH6tIa87HtQ=
 =
Received-SPF: pass client-ip=57.103.89.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--Apple-Mail=_D07DCC4C-1BCF-4DD2-8952-0086D1DE4B32
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 1. Jan 2026, at 20:26, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
>=20
>=20
>> On 1. Jan 2026, at 16:46, Bernhard Beschow <shentey@gmail.com> wrote:
>>=20
>>=20
>>=20
>> Am 30. Dezember 2025 03:47:20 UTC schrieb Pierrick Bouvier =
<pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org>>:
>>> On 12/29/25 4:03 PM, Mohamed Mediouni wrote:
>>>> Link to branch: https://github.com/mediouni-m/qemu whpx (tag for =
this submission: whpx-v13)
>>>>=20
>>>> Missing features:
>>>> - VM save-restore: interrupt controller state notably
>>>> - SVE register sync: I didn't have the time to test this on =
pre-release hardware with SVE2 support yet.
>>>> So SVE2 is currently masked for VMs when running this.
>>>>=20
>>>> Known bugs:
>>>> - U-Boot still doesn't work (hangs when trying to parse firmware) =
but EDK2 does.
>>>>=20
>>>> Note:
>>>>=20
>>>> "target/arm/kvm: add constants for new PSCI versions" taken from =
the mailing list.
>>>>=20
>>>> "accel/system: Introduce hwaccel_enabled() helper" taken from the =
mailing list, added here
>>>> as part of this series to make it compilable as a whole.
>>>>=20
>>>> "hw/arm: virt: add GICv2m for the case when ITS is not available" =
present in both the HVF
>>>> vGIC and this series.
>>>>=20
>>>> "hw: arm: virt-acpi-build: add temporary hack to match existing =
behavior" is
>>>> for ACPI stability but what is the right approach to follow there?
>>>>=20
>>>> And another note:
>>>>=20
>>>> Seems that unlike HVF there isn't direct correspondence between WHv =
registers and the actual register layout,
>>>> so didn't do changes there to a sysreg.inc.
>>>>=20
>>>> Updates since v12:
>>>> - Address review comments and make sure that checkpatch shows no =
errors, make test also ran
>>>> - Tested the Windows x86_64 build too in addition to Windows arm64 =
and macOS arm64
>>>> - Hopefully the last revision, should be ready to merge.
>>>>=20
>>>> Updates since v11:
>>>> - Address review comments
>>>> - Rebase up to latest staging
>>>> - Switch to assuming Qemu 11.0 as the newest machine model
>>>>=20
>>>> Updates since v10:
>>>> - Bring forward to latest Qemu
>>>> - Fix a typo in the GICv3+GICv2m PR
>>>>=20
>>>> Updates since v9:
>>>> - Adding partition reset on the reboot side of things...
>>>>=20
>>>> Updates since v8:
>>>> - v9 and v8 were not submitted properly because of my MTA not =
behaving, sorry for that.
>>>> - v10 introduces a new argument, -M msi=3D, to handle MSI-X =
configuration more granularly.
>>>> - That surfaced what I think is a bug (?), with vms->its=3D1 on =
GICv2 configurations... or I did understand everything wrong.
>>>> - Oopsie due to email provider ratelimiting.
>>>>=20
>>>> Updates since v7:
>>>> - Oops, fixing bug in "hw/arm: virt: cleanly fail on attempt to use =
the platform vGIC together with ITS".
>>>> Other commits are unchanged.
>>>>=20
>>>> Updates since v6:
>>>> - Rebasing
>>>> - Fixing a bug in the GICv3+GICv2m case for ACPI table generation
>>>> - getting rid of the slots infrastructure for memory management
>>>> - Place the docs commit right after the "cleanly fail on attempt to =
run GICv3+GICv2m on an unsupported config" one
>>>> as that's what switches ITS to a tristate.
>>>> - Fixing a build issue when getting rid of the arch-specific arm64 =
hvf-stub.
>>>>=20
>>>> Updates since v5:
>>>> - Rebasing
>>>> - Address review comments
>>>> - Rework ITS enablement to a tristate
>>>> - On x86: move away from deprecated APIs to get/set APIC state
>>>>=20
>>>> Updates since v4:
>>>> - Taking into account review comments
>>>> - Add migration blocker in the vGICv3 code due to missing interrupt =
controller save/restore
>>>> - Debug register sync
>>>>=20
>>>> Updates since v3:
>>>> - Disabling SVE on WHPX
>>>> - Taking into account review comments incl:
>>>>=20
>>>> - fixing x86 support
>>>> - reduce the amount of __x86_64__ checks in common code to the =
minimum (winhvemulation)
>>>> which can be reduced even further down the road.
>>>> - generalize get_physical_address_range into something common =
between hvf and whpx
>>>>=20
>>>> Updates since v2:
>>>> - Fixed up a rebase screwup for whpx-internal.h
>>>> - Fixed ID_AA64ISAR1_EL1 and ID_AA64ISAR2_EL1 feature probe for =
-cpu host
>>>> - Switched to ID_AA64PFR1_EL1/ID_AA64DFR0_EL1 instead of their =
non-AA64 variant
>>>>=20
>>>> Updates since v1:
>>>> - Shutdowns and reboots
>>>> - MPIDR_EL1 register sync
>>>> - Fixing GICD_TYPER_LPIS value
>>>> - IPA size clamping
>>>> - -cpu host now implemented
>>>>=20
>>>> Mohamed Mediouni (26):
>>>>   qtest: hw/arm: virt: skip ACPI test for ITS off
>>>>   hw/arm: virt: add GICv2m for the case when ITS is not available
>>>>   tests: data: update AArch64 ACPI tables
>>>>   hw/arm: virt: cleanly fail on attempt to use the platform vGIC
>>>>     together with ITS
>>>>   hw: arm: virt: rework MSI-X configuration
>>>>   hw: arm: virt-acpi-build: add temporary hack to match existing
>>>>     behavior
>>>>   docs: arm: update virt machine model description
>>>>   whpx: Move around files before introducing AArch64 support
>>>>   whpx: reshuffle common code
>>>>   whpx: ifdef out winhvemulation on non-x86_64
>>>>   whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
>>>>   hw, target, accel: whpx: change apic_in_platform to =
kernel_irqchip
>>>>   whpx: interrupt controller support
>>>>   whpx: add arm64 support
>>>>   whpx: change memory management logic
>>>>   target/arm: cpu: mark WHPX as supporting PSCI 1.3
>>>>   whpx: arm64: clamp down IPA size
>>>>   hw/arm, accel/hvf, whpx: unify get_physical_address_range between =
WHPX
>>>>     and HVF
>>>>   whpx: arm64: implement -cpu host
>>>>   target/arm: whpx: instantiate GIC early
>>>>   whpx: arm64: gicv3: add migration blocker
>>>>   whpx: enable arm64 builds
>>>>   whpx: apic: use non-deprecated APIs to control interrupt =
controller
>>>>     state
>>>>   whpx: arm64: check for physical address width after WHPX =
availability
>>>>   whpx: arm64: add partition-wide reset on the reboot path
>>>>   MAINTAINERS: update the list of maintained files for WHPX
>>>>=20
>>>> Philippe Mathieu-Daud=C3=A9 (1):
>>>>   accel/system: Introduce hwaccel_enabled() helper
>>>>=20
>>>> Sebastian Ott (1):
>>>>   target/arm/kvm: add constants for new PSCI versions
>>>>=20
>>>>  MAINTAINERS                                   |    6 +
>>>>  accel/hvf/hvf-all.c                           |    7 +-
>>>>  accel/meson.build                             |    1 +
>>>>  accel/stubs/whpx-stub.c                       |    1 +
>>>>  accel/whpx/meson.build                        |    7 +
>>>>  {target/i386 =3D> accel}/whpx/whpx-accel-ops.c  |    6 +-
>>>>  accel/whpx/whpx-common.c                      |  536 +++++++++
>>>>  docs/system/arm/virt.rst                      |   13 +-
>>>>  hw/arm/virt-acpi-build.c                      |   16 +-
>>>>  hw/arm/virt.c                                 |  140 ++-
>>>>  hw/i386/x86-cpu.c                             |    4 +-
>>>>  hw/intc/arm_gicv3_common.c                    |    3 +
>>>>  hw/intc/arm_gicv3_whpx.c                      |  249 ++++
>>>>  hw/intc/meson.build                           |    1 +
>>>>  include/hw/arm/virt.h                         |    8 +-
>>>>  include/hw/core/boards.h                      |    3 +-
>>>>  include/hw/intc/arm_gicv3_common.h            |    3 +
>>>>  include/system/hvf_int.h                      |    5 +
>>>>  include/system/hw_accel.h                     |   13 +
>>>>  .../whpx =3D> include/system}/whpx-accel-ops.h  |    4 +-
>>>>  include/system/whpx-all.h                     |   20 +
>>>>  include/system/whpx-common.h                  |   26 +
>>>>  .../whpx =3D> include/system}/whpx-internal.h   |   25 +-
>>>>  include/system/whpx.h                         |    5 +-
>>>>  meson.build                                   |   20 +-
>>>>  target/arm/cpu.c                              |    3 +
>>>>  target/arm/cpu64.c                            |   17 +-
>>>>  target/arm/hvf-stub.c                         |   20 -
>>>>  target/arm/hvf/hvf.c                          |    6 +-
>>>>  target/arm/hvf_arm.h                          |    3 -
>>>>  target/arm/kvm-consts.h                       |    2 +
>>>>  target/arm/meson.build                        |    2 +-
>>>>  target/arm/whpx/meson.build                   |    5 +
>>>>  target/arm/whpx/whpx-all.c                    | 1020 =
+++++++++++++++++
>>>>  target/arm/whpx/whpx-stub.c                   |   15 +
>>>>  target/arm/whpx_arm.h                         |   17 +
>>>>  target/i386/cpu-apic.c                        |    2 +-
>>>>  target/i386/hvf/hvf.c                         |   11 +
>>>>  target/i386/whpx/meson.build                  |    1 -
>>>>  target/i386/whpx/whpx-all.c                   |  569 +--------
>>>>  target/i386/whpx/whpx-apic.c                  |   48 +-
>>>>  tests/data/acpi/aarch64/virt/APIC.its_off     |  Bin 164 -> 188 =
bytes
>>>>  42 files changed, 2215 insertions(+), 648 deletions(-)
>>>>  create mode 100644 accel/whpx/meson.build
>>>>  rename {target/i386 =3D> accel}/whpx/whpx-accel-ops.c (96%)
>>>>  create mode 100644 accel/whpx/whpx-common.c
>>>>  create mode 100644 hw/intc/arm_gicv3_whpx.c
>>>>  rename {target/i386/whpx =3D> include/system}/whpx-accel-ops.h =
(92%)
>>>>  create mode 100644 include/system/whpx-all.h
>>>>  create mode 100644 include/system/whpx-common.h
>>>>  rename {target/i386/whpx =3D> include/system}/whpx-internal.h =
(88%)
>>>>  delete mode 100644 target/arm/hvf-stub.c
>>>>  create mode 100644 target/arm/whpx/meson.build
>>>>  create mode 100644 target/arm/whpx/whpx-all.c
>>>>  create mode 100644 target/arm/whpx/whpx-stub.c
>>>>  create mode 100644 target/arm/whpx_arm.h
>>>>=20
>>>=20
>>> Thanks Mohamed.
>>> Looks all good to me, and all checks are passing.
>>> I hope it can be pulled quickly by a maintainer, before this series =
conflicts with any other changes on this area.
>>=20
>> Hi,
>>=20
>> I still need to revert "whpx: apic: use non-deprecated APIs to =
control interrupt controller" for QEMU not to crash, see:
>> - =
https://lore.kernel.org/qemu-devel/4F98A2AD-02A7-4A7F-91B8-269E9EC8E5B1@gm=
ail.com/
>> - =
https://lore.kernel.org/qemu-devel/D7E4B026-EF2F-4075-B424-06427346E97B@gm=
ail.com/
>>=20
>> The problem can be reproduced by running "qemu-system-x86_64 -accel =
whpx". Let me know if you need some further details.
>>=20
>> Best regards,
>> Bernhard
>=20
> Hello,
>=20
> Will be useful to know which platform you saw this on, and that patch =
is safe to drop on its own.
> Will send the pull request (if needed to send one) without it pending =
more investigation.
>=20
> Thank you,
> -Mohamed

Nevermind I can reproduce locally on Windows 11 version 25H2.
Looking further later=E2=80=A6

>>>=20
>>> Regards,
>>> Pierrick
>=20


--Apple-Mail=_D07DCC4C-1BCF-4DD2-8952-0086D1DE4B32
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 1. Jan 2026, at 20:26, Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta http-equiv=3D"content-type"=
 content=3D"text/html; charset=3Dutf-8"><div style=3D"overflow-wrap: =
break-word; -webkit-nbsp-mode: space; line-break: =
after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 1. Jan 2026, at 16:46, Bernhard Beschow =
&lt;shentey@gmail.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Am 30. Dezember 2025 03:47:20 UTC schrieb =
Pierrick Bouvier &lt;</span><a href=3D"mailto:pierrick.bouvier@linaro.org"=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">pierrick.bouvier@linaro.org</a><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt;:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: solid;">On =
12/29/25 4:03 PM, Mohamed Mediouni wrote:<br><blockquote =
type=3D"cite">Link to branch: https://github.com/mediouni-m/qemu whpx =
(tag for this submission: whpx-v13)<br><br>Missing features:<br>- VM =
save-restore: interrupt controller state notably<br>- SVE register sync: =
I didn't have the time to test this on pre-release hardware with SVE2 =
support yet.<br>So SVE2 is currently masked for VMs when running =
this.<br><br>Known bugs:<br>- U-Boot still doesn't work (hangs when =
trying to parse firmware) but EDK2 =
does.<br><br>Note:<br><br>"target/arm/kvm: add constants for new PSCI =
versions" taken from the mailing list.<br><br>"accel/system: Introduce =
hwaccel_enabled() helper" taken from the mailing list, added here<br>as =
part of this series to make it compilable as a whole.<br><br>"hw/arm: =
virt: add GICv2m for the case when ITS is not available" present in both =
the HVF<br>vGIC and this series.<br><br>"hw: arm: virt-acpi-build: add =
temporary hack to match existing behavior" is<br>for ACPI stability but =
what is the right approach to follow there?<br><br>And another =
note:<br><br>Seems that unlike HVF there isn't direct correspondence =
between WHv registers and the actual register layout,<br>so didn't do =
changes there to a sysreg.inc.<br><br>Updates since v12:<br>- Address =
review comments and make sure that checkpatch shows no errors, make test =
also ran<br>- Tested the Windows x86_64 build too in addition to Windows =
arm64 and macOS arm64<br>- Hopefully the last revision, should be ready =
to merge.<br><br>Updates since v11:<br>- Address review comments<br>- =
Rebase up to latest staging<br>- Switch to assuming Qemu 11.0 as the =
newest machine model<br><br>Updates since v10:<br>- Bring forward to =
latest Qemu<br>- Fix a typo in the GICv3+GICv2m PR<br><br>Updates since =
v9:<br>- Adding partition reset on the reboot side of =
things...<br><br>Updates since v8:<br>- v9 and v8 were not submitted =
properly because of my MTA not behaving, sorry for that.<br>- v10 =
introduces a new argument, -M msi=3D, to handle MSI-X configuration more =
granularly.<br>- That surfaced what I think is a bug (?), with =
vms-&gt;its=3D1 on GICv2 configurations... or I did understand =
everything wrong.<br>- Oopsie due to email provider =
ratelimiting.<br><br>Updates since v7:<br>- Oops, fixing bug in "hw/arm: =
virt: cleanly fail on attempt to use the platform vGIC together with =
ITS".<br>Other commits are unchanged.<br><br>Updates since v6:<br>- =
Rebasing<br>- Fixing a bug in the GICv3+GICv2m case for ACPI table =
generation<br>- getting rid of the slots infrastructure for memory =
management<br>- Place the docs commit right after the "cleanly fail on =
attempt to run GICv3+GICv2m on an unsupported config" one<br>as that's =
what switches ITS to a tristate.<br>- Fixing a build issue when getting =
rid of the arch-specific arm64 hvf-stub.<br><br>Updates since v5:<br>- =
Rebasing<br>- Address review comments<br>- Rework ITS enablement to a =
tristate<br>- On x86: move away from deprecated APIs to get/set APIC =
state<br><br>Updates since v4:<br>- Taking into account review =
comments<br>- Add migration blocker in the vGICv3 code due to missing =
interrupt controller save/restore<br>- Debug register =
sync<br><br>Updates since v3:<br>- Disabling SVE on WHPX<br>- Taking =
into account review comments incl:<br><br>- fixing x86 support<br>- =
reduce the amount of __x86_64__ checks in common code to the minimum =
(winhvemulation)<br>which can be reduced even further down the =
road.<br>- generalize get_physical_address_range into something common =
between hvf and whpx<br><br>Updates since v2:<br>- Fixed up a rebase =
screwup for whpx-internal.h<br>- Fixed ID_AA64ISAR1_EL1 and =
ID_AA64ISAR2_EL1 feature probe for -cpu host<br>- Switched to =
ID_AA64PFR1_EL1/ID_AA64DFR0_EL1 instead of their non-AA64 =
variant<br><br>Updates since v1:<br>- Shutdowns and reboots<br>- =
MPIDR_EL1 register sync<br>- Fixing GICD_TYPER_LPIS value<br>- IPA size =
clamping<br>- -cpu host now implemented<br><br>Mohamed Mediouni =
(26):<br>&nbsp;&nbsp;qtest: hw/arm: virt: skip ACPI test for ITS =
off<br>&nbsp;&nbsp;hw/arm: virt: add GICv2m for the case when ITS is not =
available<br>&nbsp;&nbsp;tests: data: update AArch64 ACPI =
tables<br>&nbsp;&nbsp;hw/arm: virt: cleanly fail on attempt to use the =
platform vGIC<br>&nbsp;&nbsp;&nbsp;&nbsp;together with =
ITS<br>&nbsp;&nbsp;hw: arm: virt: rework MSI-X =
configuration<br>&nbsp;&nbsp;hw: arm: virt-acpi-build: add temporary =
hack to match =
existing<br>&nbsp;&nbsp;&nbsp;&nbsp;behavior<br>&nbsp;&nbsp;docs: arm: =
update virt machine model description<br>&nbsp;&nbsp;whpx: Move around =
files before introducing AArch64 support<br>&nbsp;&nbsp;whpx: reshuffle =
common code<br>&nbsp;&nbsp;whpx: ifdef out winhvemulation on =
non-x86_64<br>&nbsp;&nbsp;whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS =
define<br>&nbsp;&nbsp;hw, target, accel: whpx: change apic_in_platform =
to kernel_irqchip<br>&nbsp;&nbsp;whpx: interrupt controller =
support<br>&nbsp;&nbsp;whpx: add arm64 support<br>&nbsp;&nbsp;whpx: =
change memory management logic<br>&nbsp;&nbsp;target/arm: cpu: mark WHPX =
as supporting PSCI 1.3<br>&nbsp;&nbsp;whpx: arm64: clamp down IPA =
size<br>&nbsp;&nbsp;hw/arm, accel/hvf, whpx: unify =
get_physical_address_range between WHPX<br>&nbsp;&nbsp;&nbsp;&nbsp;and =
HVF<br>&nbsp;&nbsp;whpx: arm64: implement -cpu =
host<br>&nbsp;&nbsp;target/arm: whpx: instantiate GIC =
early<br>&nbsp;&nbsp;whpx: arm64: gicv3: add migration =
blocker<br>&nbsp;&nbsp;whpx: enable arm64 builds<br>&nbsp;&nbsp;whpx: =
apic: use non-deprecated APIs to control interrupt =
controller<br>&nbsp;&nbsp;&nbsp;&nbsp;state<br>&nbsp;&nbsp;whpx: arm64: =
check for physical address width after WHPX =
availability<br>&nbsp;&nbsp;whpx: arm64: add partition-wide reset on the =
reboot path<br>&nbsp;&nbsp;MAINTAINERS: update the list of maintained =
files for WHPX<br><br>Philippe Mathieu-Daud=C3=A9 =
(1):<br>&nbsp;&nbsp;accel/system: Introduce hwaccel_enabled() =
helper<br><br>Sebastian Ott (1):<br>&nbsp;&nbsp;target/arm/kvm: add =
constants for new PSCI versions<br><br>&nbsp;MAINTAINERS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;6 +<br>&nbsp;accel/hvf/hvf-all.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;| &nbsp;&nbsp;&nbsp;7 +-<br>&nbsp;accel/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;1 =
+<br>&nbsp;accel/stubs/whpx-stub.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;1 +<br>&nbsp;accel/whpx/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;7 +<br>&nbsp;{target/i386 =3D&gt; =
accel}/whpx/whpx-accel-ops.c &nbsp;| &nbsp;&nbsp;&nbsp;6 =
+-<br>&nbsp;accel/whpx/whpx-common.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;536 =
+++++++++<br>&nbsp;docs/system/arm/virt.rst =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;13 =
+-<br>&nbsp;hw/arm/virt-acpi-build.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;16 =
+-<br>&nbsp;hw/arm/virt.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;140 =
++-<br>&nbsp;hw/i386/x86-cpu.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;4 =
+-<br>&nbsp;hw/intc/arm_gicv3_common.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;3 =
+<br>&nbsp;hw/intc/arm_gicv3_whpx.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;249 =
++++<br>&nbsp;hw/intc/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;| &nbsp;&nbsp;&nbsp;1 +<br>&nbsp;include/hw/arm/virt.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;8 +-<br>&nbsp;include/hw/core/boards.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;3 +-<br>&nbsp;include/hw/intc/arm_gicv3_common.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;3 +<br>&nbsp;include/system/hvf_int.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;5 +<br>&nbsp;include/system/hw_accel.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;13 =
+<br>&nbsp;.../whpx =3D&gt; include/system}/whpx-accel-ops.h &nbsp;| =
&nbsp;&nbsp;&nbsp;4 +-<br>&nbsp;include/system/whpx-all.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;20 =
+<br>&nbsp;include/system/whpx-common.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;26 +<br>&nbsp;.../whpx =3D&gt; =
include/system}/whpx-internal.h &nbsp;&nbsp;| &nbsp;&nbsp;25 =
+-<br>&nbsp;include/system/whpx.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;5 +-<br>&nbsp;meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;20 =
+-<br>&nbsp;target/arm/cpu.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;3 =
+<br>&nbsp;target/arm/cpu64.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;| &nbsp;&nbsp;17 +-<br>&nbsp;target/arm/hvf-stub.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;20 -<br>&nbsp;target/arm/hvf/hvf.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;| &nbsp;&nbsp;&nbsp;6 +-<br>&nbsp;target/arm/hvf_arm.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;| &nbsp;&nbsp;&nbsp;3 -<br>&nbsp;target/arm/kvm-consts.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;2 +<br>&nbsp;target/arm/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;2 +-<br>&nbsp;target/arm/whpx/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;5 =
+<br>&nbsp;target/arm/whpx/whpx-all.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 1020 =
+++++++++++++++++<br>&nbsp;target/arm/whpx/whpx-stub.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;15 =
+<br>&nbsp;target/arm/whpx_arm.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;17 +<br>&nbsp;target/i386/cpu-apic.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;2 +-<br>&nbsp;target/i386/hvf/hvf.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;11 +<br>&nbsp;target/i386/whpx/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;1 =
-<br>&nbsp;target/i386/whpx/whpx-all.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;569 =
+--------<br>&nbsp;target/i386/whpx/whpx-apic.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;48 =
+-<br>&nbsp;tests/data/acpi/aarch64/virt/APIC.its_off =
&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;Bin 164 -&gt; 188 bytes<br>&nbsp;42 =
files changed, 2215 insertions(+), 648 deletions(-)<br>&nbsp;create mode =
100644 accel/whpx/meson.build<br>&nbsp;rename {target/i386 =3D&gt; =
accel}/whpx/whpx-accel-ops.c (96%)<br>&nbsp;create mode 100644 =
accel/whpx/whpx-common.c<br>&nbsp;create mode 100644 =
hw/intc/arm_gicv3_whpx.c<br>&nbsp;rename {target/i386/whpx =3D&gt; =
include/system}/whpx-accel-ops.h (92%)<br>&nbsp;create mode 100644 =
include/system/whpx-all.h<br>&nbsp;create mode 100644 =
include/system/whpx-common.h<br>&nbsp;rename {target/i386/whpx =3D&gt; =
include/system}/whpx-internal.h (88%)<br>&nbsp;delete mode 100644 =
target/arm/hvf-stub.c<br>&nbsp;create mode 100644 =
target/arm/whpx/meson.build<br>&nbsp;create mode 100644 =
target/arm/whpx/whpx-all.c<br>&nbsp;create mode 100644 =
target/arm/whpx/whpx-stub.c<br>&nbsp;create mode 100644 =
target/arm/whpx_arm.h<br><br></blockquote><br>Thanks Mohamed.<br>Looks =
all good to me, and all checks are passing.<br>I hope it can be pulled =
quickly by a maintainer, before this series conflicts with any other =
changes on this area.<br></blockquote><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Hi,</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">I still need to revert "whpx: apic: use =
non-deprecated APIs to control interrupt controller" for QEMU not to =
crash, see:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">-<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://lore.kernel.org/qemu-devel/4F98A2AD-02A7-4A7F-91B8-269E9EC=
8E5B1@gmail.com/" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: =
0px;">https://lore.kernel.org/qemu-devel/4F98A2AD-02A7-4A7F-91B8-269E9EC8E=
5B1@gmail.com/</a><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">-<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://lore.kernel.org/qemu-devel/D7E4B026-EF2F-4075-B424-0642734=
6E97B@gmail.com/" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: =
0px;">https://lore.kernel.org/qemu-devel/D7E4B026-EF2F-4075-B424-06427346E=
97B@gmail.com/</a><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">The problem can be reproduced by running =
"qemu-system-x86_64 -accel whpx". Let me know if you need some further =
details.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Best regards,</span><br style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Bernhard</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote><div><br></div>Hello,</div><div><br></div><div>=
Will be useful to know which platform you saw this on, and that patch is =
safe to drop on its own.</div><div>Will send the pull request (if needed =
to send one) without it pending more =
investigation.</div><div><br></div><div>Thank =
you,</div><div>-Mohamed</div></div></div></blockquote><div><br></div>Never=
mind I can reproduce locally on Windows 11 version =
25H2.</div><div>Looking further later=E2=80=A6</div><div><br><blockquote =
type=3D"cite"><div><div style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><div><blockquote type=3D"cite"><div><blockquote =
type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><br>Regards,<br>Pierrick</blockquote></div></blockquote></div><br>=
</div></div></blockquote></div><br></body></html>=

--Apple-Mail=_D07DCC4C-1BCF-4DD2-8952-0086D1DE4B32--

