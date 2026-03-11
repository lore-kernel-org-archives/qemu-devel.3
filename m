Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067841125854
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MzP-0005VE-Mo; Wed, 11 Mar 2026 13:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Mxn-0004UI-WD
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:03:24 -0400
Received: from p-west2-cluster3-host7-snip4-10.eps.apple.com ([57.103.69.53]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Mxh-0000m9-AV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:03:13 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 02A261805543; Wed, 11 Mar 2026 17:02:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773248579; x=1775840579;
 bh=HN5oa/vSuvs0pwJUpJFoniLouxOcOCknqZuUiheR/3g=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=WDhC1DWv0Cryd7kwThON3Op3B9bazE7mxBODUFa9BUv5bdLL726ktoCVJI4b8pr4zcjJtL6qQiHR8ObJAaXMIQpasSgHdObHy2FPgEGAUrwwvZcXU/XBoNvwvmH1Jzmjb40HY8Zxx31pRYG1vdi0B3wJErB7YZ4CFDx1MD2YUvL20jbE+T9QTbvgZM+NcjhesoMMam0VbDmQ2UbI7QRN9Vmip7a8zoMEsce6uIu92jbRrIwOB6vqcU80TiW2HohLkff/XjTLHFFuz3Rw8GKe6XCZYEoC15lRkKvaCHUxgMpkvruARObZSLw3pzdi1lrnQf5st9l31PoEMCU+EhP4qQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 CE14F1803CA7; Wed, 11 Mar 2026 17:02:38 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 00/14] Add ARM64 support for MSHV accelerator
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <877brii9wq.fsf@draig.linaro.org>
Date: Wed, 11 Mar 2026 18:02:26 +0100
Cc: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>,
 qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D4583F5-0591-473F-8FFA-1EDF416AF447@unpredictable.fr>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <877brii9wq.fsf@draig.linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE0NCBTYWx0ZWRfX7eQO/SBddX6G
 NQD2W3qSCocrkqXmfrPKAL5Us+XtT/ucE01oR948L30HyuulaCNvabdx55vCeG0SWjXb+sI3ge8
 cX4HYylGh4qkd+B5w6YaZZKo5aHOEzihZm/b/uVjj8PJa5WxppJpvudwAj+ge3F9yKg4oWZ74zK
 ds/In55fZ+FkX7iYEEqqK4McNe33y0srIDG72JnyqAc0SzPPHjiL/8GM3FEj5mRHkKEXKJ0AIhp
 xd+XQPlBB8FQsPx6O94lae0wVPeonx/Vx8uGmNI3CPXSCJLi13oRRPCmTZLX1E6+5AaSO/YgY5g
 jAY5Kealq6Sxh28+qBCshFPkZMFHRlxxiOpm4M8ucdSrPkVQkdPGjfkA9YPXFM=
X-Authority-Info-Out: v=2.4 cv=bPAb4f+Z c=1 sm=1 tr=0 ts=69b1a041
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=tFGNSmrwAAAA:8
 a=Z7IqKGpYxoA3MtDbTJcA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=LpD6Tdepsyerr7eS-Jg7:22
X-Proofpoint-GUID: lvN6qQDXb1pJFLj62qPex90ipCbZW3xg
X-Proofpoint-ORIG-GUID: lvN6qQDXb1pJFLj62qPex90ipCbZW3xg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 clxscore=1030 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110144
X-JNJ: AAAAAAABVkenSRO9CqNF01J/y8MfMGKVz6EbR+rJ4DAegvUcdTNegz8QFgwE/Ia8DwtPh9L/JuILXkm5TpufSprzChIdji9CCXLG4JFEgBg+7eZjJwAjqe5W7aGFYekyo1yQ7qJss/BAnjBfBD7X35WwcM7S0X8pkGfGmsb/XjkuEsMq+cyceZDSfukThv8P6kIBrPmrrTVG+ShFjFkirLwvKP71NZwei8IkaXARB5y5QGCwViOfWxsOws0ruT+e979x2f4JnohGAzbSCCnUIYWOlzHalCPjwwVIav4Z70dpY8KNQvcOYGNsYTrKcvYNxSVPtG/2yCO1vYl53LSgcJV+favc/3RzBzvELtVIitRnceVUYPJezsHY/cmJH1K9bJPwmvZ8wfAaOBqoZ+Zrpst1/K9B9R/FDLCxLdMZSrkxVeJ5dfNT8zec2g0aanmYChDiXXjSp6ExHWxDakp6x8djm9PX5eLyY1/mVe7MHFiB/+GV2FKgXemrwzEK9cj1y3RPH5S6tM/NMYDpynApHA7p5n5HFRVXU4El6pm3V5dD8MAC/S2stJMQznW23t6iYZBm4+LgnhQbXyDmY0b27AJTqySH/QfZoa4qMHgPXmvZcOyIt5dVzgkId9zRjhH8vFlRgwimkh2E1wMd6w+K2OmUrCMIL4maDbQxLDibTaF6keC1V3sOG7kWa4b6XULvOIEgdrb/cI8r6oJ5kHpRaJwFOrgvQm8GQr3meekU3BVTfU7GDn3dxI/96xTOrE4Ya4G66LXwXkuRmhY4mrC0VfxUDSD2
Received-SPF: pass client-ip=57.103.69.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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



> On 11. Mar 2026, at 17:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com> writes:
>=20
>> This series adds ARM64 guest support to the MSHV (Microsoft =
Hypervisor)
>> accelerator, enabling QEMU to run aarch64 VMs on Microsoft's =
hypervisor
>> using the mshv Linux kernel module.
>=20
> Does GitLab (or anything we plug into it) support runners on Arm64 =
with
> HyperV and a Linux Dom0?
>=20
> I looks like we would need a dedicated runner to defend the
> functionality on CI.


The MSHV license doesn=E2=80=99t allow for any use outside of Azure =
Kubernetes Service,
despite MSHV (for x86) being public.

And Dom0 is technically not required as there=E2=80=99s L1VH, but =
that=E2=80=99s even less documented to
the outside and not set up for more local use - but hopefully will make =
its way to Windows=20
client at some point :/

>>=20
>> The first few patches refactor the existing x86 MSHV code to separate
>> arch-specific pieces from common infrastructure: moving MSR handling =
to
>> target/i386, extracting shared register hypercall helpers, =
provisioning
>> host CPU features, and introducing arch-specific init hooks.
>>=20
>> The remaining patches add the ARM64 backend:
>> - vCPU state get/set using hypervisor register hypercalls
>> - -cpu host support by querying ID registers from the hypervisor
>> - vCPU run loop with MMIO emulation via ESR_EL2 syndrome decoding
>> - In-kernel vGICv3 backed by HVCALL_ASSERT_VIRTUAL_INTERRUPT
>> - Interrupt control structure adjustments for arm64
>>=20
>> With this series, a standard aarch64 virt machine can be launched =
with:
>>  qemu-system-aarch64 -accel mshv -cpu host -M virt ...
>>=20
>> Caveats:
>> - Currently only direct kernel is supported. We're still debugging =
edk2
>>  firmware boot.=20
>> - Live migration is not yet supported.
>>=20
>> ---
>> Aastha Rawat (7):
>>      accel/mshv: move msr.c to target/i386
>>      accel/mshv: extract common CPU register helpers
>>      meson, target/arm/mshv: Enable arm64 build & add initial MSHV =
support
>>      target/arm/mshv: implement vcpu state operations for ARM64
>>      target/arm/mshv: implement -cpu host for MSHV
>>      accel/mshv: Add access_vp_regs synthetic proc features
>>      target/arm: cpu: Mark MSHV supporting PSCI 1.3
>>=20
>> Anirudh Rayabharam (Microsoft) (6):
>>      accel/mshv: provision guests with the same features as host
>>      accel/mshv: add arch-specific accelerator init hook
>>      target/arm/mshv: add vCPU run loop
>>      include/hw/hyperv: adjust hv_interrupt_control structure for =
arm64
>>      hw/intc,target/arm/mshv: add MSHV vGICv3 implementation
>>      MAINTAINERS: updates for MSHV arm64 code
>>=20
>> Magnus Kulke (1):
>>      accel/mshv: implement cpu_thread_is_idle() hook
>>=20
>> MAINTAINERS                        |   8 +
>> accel/mshv/irq.c                   |   2 +
>> accel/mshv/meson.build             |   4 +-
>> accel/mshv/mshv-all.c              |  73 +++-
>> accel/mshv/mshv-cpu-common.c       | 151 +++++++++
>> hw/arm/virt.c                      |  11 +-
>> hw/intc/arm_gicv3_common.c         |   3 +
>> hw/intc/arm_gicv3_mshv.c           | 180 ++++++++++
>> hw/intc/meson.build                |   1 +
>> include/hw/hyperv/hvgdk_mini.h     | 130 ++++++++
>> include/hw/hyperv/hvhdk.h          |  97 +++++-
>> include/hw/hyperv/hvhdk_mini.h     |   6 +
>> include/hw/intc/arm_gicv3_common.h |   1 +
>> include/system/hw_accel.h          |   3 +-
>> include/system/mshv.h              |   2 +
>> include/system/mshv_int.h          |   5 +
>> meson.build                        |   7 +-
>> target/arm/cpu.c                   |   7 +-
>> target/arm/cpu64.c                 |  24 +-
>> target/arm/meson.build             |   1 +
>> target/arm/mshv/meson.build        |   7 +
>> target/arm/mshv/mshv-all.c         | 665 =
+++++++++++++++++++++++++++++++++++++
>> target/arm/mshv_arm.h              |  18 +
>> target/i386/mshv/meson.build       |   2 +
>> target/i386/mshv/mshv-all.c        |  85 +++++
>> target/i386/mshv/mshv-cpu.c        | 170 +---------
>> {accel =3D> target/i386}/mshv/msr.c  |   0
>> 27 files changed, 1465 insertions(+), 198 deletions(-)
>> ---
>> base-commit: 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455
>> change-id: 20260311-mshv_accel_arm64_supp-e86b0082aee4
>>=20
>> Best regards,
>=20
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>=20


