Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDC3EEB57C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 17:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbMdz-0002Xq-OE; Thu, 01 Jan 2026 12:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vbMdO-0002Sn-J4
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 12:38:59 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vbMdI-0005Y9-9T
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 12:38:50 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477770019e4so97236705e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jan 2026 09:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767289118; x=1767893918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eXTeWbvFGcK3I3F6QbEeWDS2W9GrykkT7vbfVmHkXY=;
 b=fn6YS+gs5Qoksf5dYA1L2qUlClt4laM9U78sMUYEkn06TMhR0iFzpn7G64zvaXm9rb
 RN71iBIxBMcD3mw+cWL2x9ESvY953Iik00b3pCrsStypxboL/eLKE/QsRm2SfiJ2eVHg
 z8guA8390GlVpSVPU7GHSPhl8TGYrNEWZB109CnwjISLZjVZMQMd7RFZrqUkZznLReVi
 wZGFHJHRCsFpOyGqtpbbEBYCHcrGnKjR3FWF0VefJKw6rVMw4yrZrc7RzMM4kslLn+kW
 N5V+J7H2fOp5eHrKaW1UxRXRMeL1pQDMiz0DXpm6aJ6UMIrhvQL4W9gxHoDhkudejbMK
 bxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767289118; x=1767893918;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4eXTeWbvFGcK3I3F6QbEeWDS2W9GrykkT7vbfVmHkXY=;
 b=LOcuvjrEbkacePWRYfA1vXnTK8wKZb0Em/x5SxKUV4gkqZQAOoX8ZL1WXxBzZB3djl
 /9haDaEfMvitpejZRAHlmas7Xzj9fkbOKGs3nb+0TJP3NTaPPJ5ZE2bH02pwke8/SlSf
 JJhhGUfjL72vOXvCutYMsdypsNY97rAVC9MNpiNQ+xJBNLF55ThOco2EijzSU14Vz4fS
 2dJvsC01L6/kLYfnN886YHbjssCPcnSA/se/uFXWL6dvKfOHYJorGWWcCuwzkxUD5yQw
 FzJzXfTlTXI4bi/WP9QEncYRHhd+hz1J8NB2F6hyOn/yRhbYXbSOPHPP3Rk24Eui/R9Y
 SVQQ==
X-Gm-Message-State: AOJu0YxtPFf3JEtEQcF1+V9O8fjuejrUfa2YuVCf15y9gnxWQ1Z6cX+U
 gTr2yfiYTgvarsk2Bbs8iSJUDbapfjaHWGe8GIjuqDKumkWspy0knZUxiRLrgg==
X-Gm-Gg: AY/fxX5u74ABkLMi+NrTtqiyGWZ1WBlNntDf5nc1B0UqsAzLHGhLgQOdttmS5U06gPS
 JnL1W9XgnLVDNunyFm8tpIstXHeIa0ZA8HIyItrRN8ELB3y94AhF4i2Y0yUlnK2ZXS2No9EHUKR
 KoG5vtYp6KJDeDH5k5nP1W80yNnCTSjqub6p0u4+VCztEytSMWM2ibed4LZz+2Wqre9FAv4mnbE
 ++Omm9Pjq6OwmHnk4fsO59TXzmZBWlH/YVYJ8Nie0FvXk4DhveY31yNGSnlwdySyioMuWWIwXxn
 VRZevhVcSRVNzu1vAjDDzO05C3njp1ZxVkQHbwf0+tz7Oxu13nB2ZOilpZL5sw8oLXMeUGHmcdJ
 4SB7MSfWnPS9k0uXORygr4WxarLszsRDGpcJNmwP/7YmJjHo8FbXTxmMqTEps3N32/uV8moMCw/
 7DSSqB8r7k8vUidWZCqfn1gkILJdDMfBuZHI36oha6or9gCSQ6qHgGe2ohGIf2Ncoe2/4cv6UWg
 setUSmaZpp9oi7DHQjgN2h34g/s++20W+4=
X-Google-Smtp-Source: AGHT+IE6DWY5bKivZDcY27wGC2bTbNGcXTUwFIb5pCUIIH1qjuenBSLrxzUDlCMxmurLreuZ6bfP/g==
X-Received: by 2002:a05:6402:520d:b0:643:e2d:1d6c with SMTP id
 4fb4d7f45d1cf-64b8ea61109mr36256270a12.4.1767282409336; 
 Thu, 01 Jan 2026 07:46:49 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-1ca9-3100-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:1ca9:3100:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91599721sm40748723a12.26.2026.01.01.07.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jan 2026 07:46:47 -0800 (PST)
Date: Thu, 01 Jan 2026 15:46:45 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
CC: Yanan Wang <wangyanan55@huawei.com>,
 =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cameron Esfahani <dirty@apple.com>, 
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v13 00/28] WHPX support for Arm
In-Reply-To: <b833265e-0a90-4696-803f-d98a7c1e3456@linaro.org>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
 <b833265e-0a90-4696-803f-d98a7c1e3456@linaro.org>
Message-ID: <9A2E2173-6CF4-4DDE-8D8F-8FFC008F9F2F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 30=2E Dezember 2025 03:47:20 UTC schrieb Pierrick Bouvier <pierrick=2Eb=
ouvier@linaro=2Eorg>:
>On 12/29/25 4:03 PM, Mohamed Mediouni wrote:
>> Link to branch: https://github=2Ecom/mediouni-m/qemu whpx (tag for this=
 submission: whpx-v13)
>>=20
>> Missing features:
>> - VM save-restore: interrupt controller state notably
>> - SVE register sync: I didn't have the time to test this on pre-release=
 hardware with SVE2 support yet=2E
>> So SVE2 is currently masked for VMs when running this=2E
>>=20
>> Known bugs:
>> - U-Boot still doesn't work (hangs when trying to parse firmware) but E=
DK2 does=2E
>>=20
>> Note:
>>=20
>> "target/arm/kvm: add constants for new PSCI versions" taken from the ma=
iling list=2E
>>=20
>> "accel/system: Introduce hwaccel_enabled() helper" taken from the maili=
ng list, added here
>> as part of this series to make it compilable as a whole=2E
>>=20
>> "hw/arm: virt: add GICv2m for the case when ITS is not available" prese=
nt in both the HVF
>> vGIC and this series=2E
>>=20
>> "hw: arm: virt-acpi-build: add temporary hack to match existing behavio=
r" is
>> for ACPI stability but what is the right approach to follow there?
>>=20
>> And another note:
>>=20
>> Seems that unlike HVF there isn't direct correspondence between WHv reg=
isters and the actual register layout,
>> so didn't do changes there to a sysreg=2Einc=2E
>>=20
>> Updates since v12:
>> - Address review comments and make sure that checkpatch shows no errors=
, make test also ran
>> - Tested the Windows x86_64 build too in addition to Windows arm64 and =
macOS arm64
>> - Hopefully the last revision, should be ready to merge=2E
>>=20
>> Updates since v11:
>> - Address review comments
>> - Rebase up to latest staging
>> - Switch to assuming Qemu 11=2E0 as the newest machine model
>>=20
>> Updates since v10:
>> - Bring forward to latest Qemu
>> - Fix a typo in the GICv3+GICv2m PR
>>=20
>> Updates since v9:
>> - Adding partition reset on the reboot side of things=2E=2E=2E
>>=20
>> Updates since v8:
>> - v9 and v8 were not submitted properly because of my MTA not behaving,=
 sorry for that=2E
>> - v10 introduces a new argument, -M msi=3D, to handle MSI-X configurati=
on more granularly=2E
>> - That surfaced what I think is a bug (?), with vms->its=3D1 on GICv2 c=
onfigurations=2E=2E=2E or I did understand everything wrong=2E
>> - Oopsie due to email provider ratelimiting=2E
>>=20
>> Updates since v7:
>> - Oops, fixing bug in "hw/arm: virt: cleanly fail on attempt to use the=
 platform vGIC together with ITS"=2E
>> Other commits are unchanged=2E
>>=20
>> Updates since v6:
>> - Rebasing
>> - Fixing a bug in the GICv3+GICv2m case for ACPI table generation
>> - getting rid of the slots infrastructure for memory management
>> - Place the docs commit right after the "cleanly fail on attempt to run=
 GICv3+GICv2m on an unsupported config" one
>> as that's what switches ITS to a tristate=2E
>> - Fixing a build issue when getting rid of the arch-specific arm64 hvf-=
stub=2E
>>=20
>> Updates since v5:
>> - Rebasing
>> - Address review comments
>> - Rework ITS enablement to a tristate
>> - On x86: move away from deprecated APIs to get/set APIC state
>>=20
>> Updates since v4:
>> - Taking into account review comments
>> - Add migration blocker in the vGICv3 code due to missing interrupt con=
troller save/restore
>> - Debug register sync
>>=20
>> Updates since v3:
>> - Disabling SVE on WHPX
>> - Taking into account review comments incl:
>>=20
>> - fixing x86 support
>> - reduce the amount of __x86_64__ checks in common code to the minimum =
(winhvemulation)
>> which can be reduced even further down the road=2E
>> - generalize get_physical_address_range into something common between h=
vf and whpx
>>=20
>> Updates since v2:
>> - Fixed up a rebase screwup for whpx-internal=2Eh
>> - Fixed ID_AA64ISAR1_EL1 and ID_AA64ISAR2_EL1 feature probe for -cpu ho=
st
>> - Switched to ID_AA64PFR1_EL1/ID_AA64DFR0_EL1 instead of their non-AA64=
 variant
>>=20
>> Updates since v1:
>> - Shutdowns and reboots
>> - MPIDR_EL1 register sync
>> - Fixing GICD_TYPER_LPIS value
>> - IPA size clamping
>> - -cpu host now implemented
>>=20
>> Mohamed Mediouni (26):
>>    qtest: hw/arm: virt: skip ACPI test for ITS off
>>    hw/arm: virt: add GICv2m for the case when ITS is not available
>>    tests: data: update AArch64 ACPI tables
>>    hw/arm: virt: cleanly fail on attempt to use the platform vGIC
>>      together with ITS
>>    hw: arm: virt: rework MSI-X configuration
>>    hw: arm: virt-acpi-build: add temporary hack to match existing
>>      behavior
>>    docs: arm: update virt machine model description
>>    whpx: Move around files before introducing AArch64 support
>>    whpx: reshuffle common code
>>    whpx: ifdef out winhvemulation on non-x86_64
>>    whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
>>    hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
>>    whpx: interrupt controller support
>>    whpx: add arm64 support
>>    whpx: change memory management logic
>>    target/arm: cpu: mark WHPX as supporting PSCI 1=2E3
>>    whpx: arm64: clamp down IPA size
>>    hw/arm, accel/hvf, whpx: unify get_physical_address_range between WH=
PX
>>      and HVF
>>    whpx: arm64: implement -cpu host
>>    target/arm: whpx: instantiate GIC early
>>    whpx: arm64: gicv3: add migration blocker
>>    whpx: enable arm64 builds
>>    whpx: apic: use non-deprecated APIs to control interrupt controller
>>      state
>>    whpx: arm64: check for physical address width after WHPX availabilit=
y
>>    whpx: arm64: add partition-wide reset on the reboot path
>>    MAINTAINERS: update the list of maintained files for WHPX
>>=20
>> Philippe Mathieu-Daud=C3=A9 (1):
>>    accel/system: Introduce hwaccel_enabled() helper
>>=20
>> Sebastian Ott (1):
>>    target/arm/kvm: add constants for new PSCI versions
>>=20
>>   MAINTAINERS                                   |    6 +
>>   accel/hvf/hvf-all=2Ec                           |    7 +-
>>   accel/meson=2Ebuild                             |    1 +
>>   accel/stubs/whpx-stub=2Ec                       |    1 +
>>   accel/whpx/meson=2Ebuild                        |    7 +
>>   {target/i386 =3D> accel}/whpx/whpx-accel-ops=2Ec  |    6 +-
>>   accel/whpx/whpx-common=2Ec                      |  536 +++++++++
>>   docs/system/arm/virt=2Erst                      |   13 +-
>>   hw/arm/virt-acpi-build=2Ec                      |   16 +-
>>   hw/arm/virt=2Ec                                 |  140 ++-
>>   hw/i386/x86-cpu=2Ec                             |    4 +-
>>   hw/intc/arm_gicv3_common=2Ec                    |    3 +
>>   hw/intc/arm_gicv3_whpx=2Ec                      |  249 ++++
>>   hw/intc/meson=2Ebuild                           |    1 +
>>   include/hw/arm/virt=2Eh                         |    8 +-
>>   include/hw/core/boards=2Eh                      |    3 +-
>>   include/hw/intc/arm_gicv3_common=2Eh            |    3 +
>>   include/system/hvf_int=2Eh                      |    5 +
>>   include/system/hw_accel=2Eh                     |   13 +
>>   =2E=2E=2E/whpx =3D> include/system}/whpx-accel-ops=2Eh  |    4 +-
>>   include/system/whpx-all=2Eh                     |   20 +
>>   include/system/whpx-common=2Eh                  |   26 +
>>   =2E=2E=2E/whpx =3D> include/system}/whpx-internal=2Eh   |   25 +-
>>   include/system/whpx=2Eh                         |    5 +-
>>   meson=2Ebuild                                   |   20 +-
>>   target/arm/cpu=2Ec                              |    3 +
>>   target/arm/cpu64=2Ec                            |   17 +-
>>   target/arm/hvf-stub=2Ec                         |   20 -
>>   target/arm/hvf/hvf=2Ec                          |    6 +-
>>   target/arm/hvf_arm=2Eh                          |    3 -
>>   target/arm/kvm-consts=2Eh                       |    2 +
>>   target/arm/meson=2Ebuild                        |    2 +-
>>   target/arm/whpx/meson=2Ebuild                   |    5 +
>>   target/arm/whpx/whpx-all=2Ec                    | 1020 ++++++++++++++=
+++
>>   target/arm/whpx/whpx-stub=2Ec                   |   15 +
>>   target/arm/whpx_arm=2Eh                         |   17 +
>>   target/i386/cpu-apic=2Ec                        |    2 +-
>>   target/i386/hvf/hvf=2Ec                         |   11 +
>>   target/i386/whpx/meson=2Ebuild                  |    1 -
>>   target/i386/whpx/whpx-all=2Ec                   |  569 +--------
>>   target/i386/whpx/whpx-apic=2Ec                  |   48 +-
>>   tests/data/acpi/aarch64/virt/APIC=2Eits_off     |  Bin 164 -> 188 byt=
es
>>   42 files changed, 2215 insertions(+), 648 deletions(-)
>>   create mode 100644 accel/whpx/meson=2Ebuild
>>   rename {target/i386 =3D> accel}/whpx/whpx-accel-ops=2Ec (96%)
>>   create mode 100644 accel/whpx/whpx-common=2Ec
>>   create mode 100644 hw/intc/arm_gicv3_whpx=2Ec
>>   rename {target/i386/whpx =3D> include/system}/whpx-accel-ops=2Eh (92%=
)
>>   create mode 100644 include/system/whpx-all=2Eh
>>   create mode 100644 include/system/whpx-common=2Eh
>>   rename {target/i386/whpx =3D> include/system}/whpx-internal=2Eh (88%)
>>   delete mode 100644 target/arm/hvf-stub=2Ec
>>   create mode 100644 target/arm/whpx/meson=2Ebuild
>>   create mode 100644 target/arm/whpx/whpx-all=2Ec
>>   create mode 100644 target/arm/whpx/whpx-stub=2Ec
>>   create mode 100644 target/arm/whpx_arm=2Eh
>>=20
>
>Thanks Mohamed=2E
>Looks all good to me, and all checks are passing=2E
>I hope it can be pulled quickly by a maintainer, before this series confl=
icts with any other changes on this area=2E

Hi,

I still need to revert "whpx: apic: use non-deprecated APIs to control int=
errupt controller" for QEMU not to crash, see:
- https://lore=2Ekernel=2Eorg/qemu-devel/4F98A2AD-02A7-4A7F-91B8-269E9EC8E=
5B1@gmail=2Ecom/
- https://lore=2Ekernel=2Eorg/qemu-devel/D7E4B026-EF2F-4075-B424-06427346E=
97B@gmail=2Ecom/

The problem can be reproduced by running "qemu-system-x86_64 -accel whpx"=
=2E Let me know if you need some further details=2E

Best regards,
Bernhard

>
>Regards,
>Pierrick
>

