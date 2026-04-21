Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB500F327AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF4xJ-0003WZ-0R; Tue, 21 Apr 2026 02:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wF4xG-0003Vy-A9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:51:30 -0400
Received: from ci-2001e-snip4-2.eps.apple.com ([57.103.91.35]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wF4xD-0008Ob-Ky
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:51:30 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPS id
 2D3C11800181; Tue, 21 Apr 2026 06:51:21 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJB01fDl4fBBdGGVUERx5dVlAEGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVIdlwHWXM1e1UEXA5dH0QATgtAdVsDRhRJBVUAUnc2CTwDXgMrRx5JClYJXghGEVsUVkNRGQxQTQFDCAoIRwNNF14yUwRfEVAW
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776754285; x=1779346285;
 bh=3XthME9dBU3g1tLdThMwSV0+O7ZUauHCiKnoTwCOISI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=PYPOqDmhfigFVz3jdh/mUzH2dMM1Zl5YRDj/RaGiBxntfeAvfVdra/2U9QnqQvyAZ+AABfTmKP23a9y+l9Plby2GEIbXmnh+upyab249ILEO5oKLH/srg8iv1Zr+9VCX0dZjd6S30YXOBZQro3EoJsqkiPROoqbjHtfHB/ziK3ZkF8qo5nByKiSNzmKmZNkJKIH2sc6n2ajAR8fw3SYRRScwZYmu8Iy9iQIf8f39aZOnG08Z6PJfEeTKZoHJvil5m8k19tDWBLSHaQbAVJITIW72jO7lA5DL0/2GHM2NQq5z6h9ViMwoLkJzk66NLKOvd3tUIRHDxI6r3IGzZyBQ+g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPSA id
 947F9180012F; Tue, 21 Apr 2026 06:51:19 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v3 10/14] target/arm: extract MMIO emulation logic for HVF
 & WHPX
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260421-mshv_accel_arm64_supp-v3-10-469f544778ba@linux.microsoft.com>
Date: Tue, 21 Apr 2026 08:51:07 +0200
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E102AEB-7196-4968-B016-16879EF0D034@unpredictable.fr>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-10-469f544778ba@linux.microsoft.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA2NSBTYWx0ZWRfX0k4yYwFCzll4
 hepL60nEQpkz9G1Y5f6f83CW5e7KhQRnEww65h7nEf/sqLOd7Ido/tvMqdz/UDVoobYDekDIoal
 mO5NHvasM/3fiU0saB2Zbc6Mi0TdrOCN/uT+P6nUKhIzTTeuVc3No/pP2jXtPjoqblF9gXUr9kN
 3//jfvULfTMeEMT93PlCVPKreecYe1M7aVgF76EKUt8fqDwV/M4SHl98brtMkjkg4NxCiZsWwbA
 QHLYnwMYqbyK1Y9t5Hi1KSREuUsF5QnZhPL/r9SjRfBSOTEtTh0bJB6OqI6yzGk+3RSz6DC14fL
 RZVn+MMEZF7K56cWL8z/m2udjaaPsYpyUE2DrpgOr3LrmtEAOZKKTFeRZONl9c=
X-Proofpoint-GUID: Zoaeis1s--mCtOigi7GPAo_LV13P3CyK
X-Authority-Info-Out: v=2.4 cv=LuGfC3dc c=1 sm=1 tr=0 ts=69e71e6c
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=dJ-s-Lo7nvDzl-0enaAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Zoaeis1s--mCtOigi7GPAo_LV13P3CyK
Received-SPF: pass client-ip=57.103.91.35;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 21. Apr 2026, at 07:21, Aastha Rawat =
<aastharawat@linux.microsoft.com> wrote:
>=20
> - Move common MMIO emulation code from HVF and WHPX backend to
>  arm_emulate_mmio() in helper.c.
> - Update HVF and WHPX to use the new helper and shared types.

Hi,

This one is a bit interesting and not sure if it=E2=80=99s ok in this =
form.

That=E2=80=99s for one reason: it causes a slowdown on WHP and HVF by =
fetching
state (and sometimes setting) outside of their respective shared =
register pages.

In both of those APIs, the existence of the shared register page is =
opaque/hidden
away, but if you aren=E2=80=99t careful about what you fetch you=E2=80=99r=
e going to hit the slow
path very easily.

On x86 WHPX, we have a state level abstraction with a FAST_RUNTIME_STATE
that only fetches a (sub)set accessible that is readable using only =
information
from the shared register page - and that is supposed to be enough for =
the vast
majority of MMIO - that doesn=E2=80=99t touch the FP/MMX/SSE register =
files.

And another possibility is putting it in a target/arm/emulate with =
mimicking
the x86_emul_ops interface with adding register callbacks to that so =
that state
is fetched/set dynamically.


>=20
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
> target/arm/helper.c        | 60 =
+++++++++++++++++++++++++++++++++++++++++++
> target/arm/helper.h        |  5 ++++
> target/arm/hvf/hvf.c       | 64 =
++++++++++++++++++++++++----------------------
> target/arm/syndrome.h      | 37 +++++++++++++++++++++++++++
> target/arm/whpx/whpx-all.c | 62 =
+++++++++++---------------------------------
> 5 files changed, 150 insertions(+), 78 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7389f2988c..c9457c8384 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -34,6 +34,8 @@
> #endif
> #include "cpregs.h"
> #include "target/arm/gtimer.h"
> +#include "target/arm/helper.h"
> +#include "target/arm/syndrome.h"
> #include "qemu/plugin.h"
>=20
> static void switch_mode(CPUARMState *env, int mode);
> @@ -9130,6 +9132,64 @@ static void =
arm_cpu_do_interrupt_aarch32(CPUState *cs)
>     take_aarch32_exception(env, new_mode, mask, offset, addr);
> }
>=20
> +/*
> + * Emulate a data abort syndrome for MMIO/guest memory access
> + */
> +int arm_emulate_mmio(CPUState *cpu, EsrEl2 syndrome, uint64_t gpa)
> +{
> +    CPUARMState *env =3D &ARM_CPU(cpu)->env;
> +    int ret;
> +    IssDataAbort iss =3D { 0 };
> +    iss.raw =3D syndrome.iss;
> +
> +    if (!(syndrome.ec =3D=3D data_abort_lower || syndrome.ec =3D=3D =
data_abort)) {
> +        error_report("Unknown exception class 0x%x", syndrome.ec);
> +        return -1;
> +    }
> +
> +    if (!iss.isv) {
> +        error_report("Cannot emulate MMIO. ISS not valid.");
> +        return -1;
> +    }
> +
> +    AddressSpace *as =3D cpu_get_address_space(cpu, ARMASIdx_NS);
> +    uint64_t len =3D 1ULL << iss.sas;
> +    bool sign_extend =3D iss.sse;
> +    uint64_t reg_index =3D iss.srt;
> +
> +    if (iss.wnr) {
> +        uint8_t data[8];
> +        uint64_t val =3D reg_index < 31 ? env->xregs[reg_index] : =
0ULL;
> +        val =3D cpu_to_le64(val);
> +        memcpy(data, &val, sizeof(val));
> +        ret =3D address_space_write(as, gpa, MEMTXATTRS_UNSPECIFIED, =
data, len);
> +        if (ret !=3D MEMTX_OK) {
> +            error_report("Failed to write guest memory");
> +            return -1;
> +        }
> +    } else {
> +        uint8_t data[8] =3D { 0 };
> +        ret =3D address_space_read(as, gpa, MEMTXATTRS_UNSPECIFIED, =
data, len);
> +        if (ret !=3D MEMTX_OK) {
> +            error_report("Failed to read guest memory");
> +            return -1;
> +        }
> +        uint64_t val;
> +        memcpy(&val, data, sizeof(val));
> +        val =3D le64_to_cpu(val);
> +        if (sign_extend) {
> +            uint64_t shift =3D 64 - (len * 8);
> +            val =3D (((int64_t)val << shift) >> shift);
> +        }
> +        if (!iss.sf) {
> +            val &=3D 0xffffffff;
> +        }
> +        env->xregs[reg_index] =3D val;
> +    }
> +
> +    return 0;
> +}
> +
> static int aarch64_regnum(CPUARMState *env, int aarch32_reg)
> {
>     /*
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index b1c26c180e..3bc22595fd 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -3,8 +3,13 @@
> #ifndef HELPER__H
> #define HELPER__H
>=20
> +#include <stdint.h>
> +#include <stdbool.h>
> #include "exec/helper-proto-common.h"
> #include "exec/helper-gen-common.h"
> +#include "target/arm/syndrome.h"
> +
> +int arm_emulate_mmio(CPUState *cpu, EsrEl2 syndrome, uint64_t gpa);
>=20
> #define HELPER_H "tcg/helper-defs.h"
> #include "exec/helper-proto.h.inc"
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 5fc8f6bbbd..9ecad6c222 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -13,6 +13,7 @@
> #include "qemu/error-report.h"
> #include "qemu/log.h"
>=20
> +#include "syndrome.h"
> #include "system/runstate.h"
> #include "system/hvf.h"
> #include "system/hvf_int.h"
> @@ -35,6 +36,7 @@
> #include "target/arm/multiprocessing.h"
> #include "target/arm/gtimer.h"
> #include "target/arm/trace.h"
> +#include "target/arm/helper.h"
> #include "trace.h"
> #include "migration/vmstate.h"
>=20
> @@ -2072,12 +2074,15 @@ static int hvf_handle_exception(CPUState *cpu, =
hv_vcpu_exit_exception_t *excp)
> {
>     CPUARMState *env =3D cpu_env(cpu);
>     ARMCPU *arm_cpu =3D env_archcpu(env);
> -    uint64_t syndrome =3D excp->syndrome;
> -    uint32_t ec =3D syn_get_ec(syndrome);
> +    uint64_t syndrome;
> +    uint32_t ec;
>     bool advance_pc =3D false;
>     hv_return_t r;
>     int ret =3D 0;
>=20
> +    syndrome =3D excp->syndrome;
> +    ec =3D syn_get_ec(syndrome);
> +
>     switch (ec) {
>     case EC_SOFTWARESTEP: {
>         ret =3D EXCP_DEBUG;
> @@ -2123,29 +2128,22 @@ static int hvf_handle_exception(CPUState *cpu, =
hv_vcpu_exit_exception_t *excp)
>         break;
>     }
>     case EC_DATAABORT: {
> -        bool isv =3D syndrome & ARM_EL_ISV;
> -        bool iswrite =3D (syndrome >> 6) & 1;
> -        bool s1ptw =3D (syndrome >> 7) & 1;
> -        bool sse =3D (syndrome >> 21) & 1;
> -        uint32_t sas =3D (syndrome >> 22) & 3;
> -        uint32_t len =3D 1 << sas;
> -        uint32_t srt =3D (syndrome >> 16) & 0x1f;
> -        uint32_t cm =3D (syndrome >> 8) & 0x1;
> -        uint64_t val =3D 0;
> +        EsrEl2 esr_el2 =3D { .raw =3D syndrome };
> +        IssDataAbort iss =3D { .raw =3D esr_el2.iss };
>         uint64_t ipa =3D excp->physical_address;
>         AddressSpace *as =3D cpu_get_address_space(cpu, ARMASIdx_NS);
>=20
> -        trace_hvf_data_abort(excp->virtual_address, ipa, isv,
> -                             iswrite, s1ptw, len, srt);
> +        trace_hvf_data_abort(excp->virtual_address, ipa, iss.isv,
> +                             iss.wnr, iss.s1ptw, 1ULL << iss.sas, =
iss.srt);
>=20
> -        if (cm) {
> +        if (iss.cm) {
>             /* We don't cache MMIO regions */
>             advance_pc =3D true;
>             break;
>         }
>=20
>         /* Handle dirty page logging for ram. */
> -        if (iswrite) {
> +        if (iss.wnr) {
>             hwaddr xlat;
>             MemoryRegion *mr =3D address_space_translate(as, ipa, =
&xlat,
>                                                        NULL, true,
> @@ -2172,27 +2170,31 @@ static int hvf_handle_exception(CPUState *cpu, =
hv_vcpu_exit_exception_t *excp)
>          * TODO: If s1ptw, this is an error in the guest os page =
tables.
>          * Inject the exception into the guest.
>          */
> -        assert(!s1ptw);
> -
> -        /*
> -         * TODO: ISV will be 0 for SIMD or SVE accesses.
> -         * Inject the exception into the guest.
> -         */
> -        assert(isv);
> +        assert(!iss.s1ptw);
>=20
>         /*
>          * Emulate MMIO.
>          * TODO: Inject faults for errors.
>          */
> -        if (iswrite) {
> -            val =3D hvf_get_reg(cpu, srt);
> -            address_space_write(as, ipa, MEMTXATTRS_UNSPECIFIED, =
&val, len);
> -        } else {
> -            address_space_read(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, =
len);
> -            if (sse) {
> -                val =3D sextract64(val, 0, len * 8);
> -            }
> -            hvf_set_reg(cpu, srt, val);
> +        ret =3D hvf_arch_get_registers(cpu);
> +        if (ret < 0) {
> +            error_report("Failed to get registers for MMIO");
> +                         esr_el2.raw, ipa);
> +            return -1;
> +        }
> +
> +        ret =3D arm_emulate_mmio(cpu, esr_el2, ipa);
> +        if (ret < 0) {
> +            error_report("Failed to emulate MMIO, syndrome=3D0x%llx, =
gpa=3D0x%llx",
> +                         esr_el2.raw, ipa);
> +            return -1;
> +        }
> +
> +        ret =3D hvf_arch_put_registers(cpu);
> +        if (ret < 0) {
> +            error_report("Failed to set registers after MMIO =
emulation");
> +                         esr_el2.raw, ipa);
> +            return -1;
>         }
>         advance_pc =3D true;
>         break;
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index bff61f052c..777d4fb975 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -101,6 +101,43 @@ typedef enum {
>     GCS_IT_GCSPOPX =3D 9,
> } GCSInstructionType;
>=20
> +typedef union {
> +    uint64_t raw;
> +    struct {
> +        uint32_t iss:25;
> +        uint32_t il:1;
> +        uint32_t ec:6;
> +        uint32_t iss2:5;
> +        uint32_t _rsvd:27;
> +    } QEMU_PACKED;
> +} EsrEl2;
> +
> +typedef union {
> +    uint32_t raw;
> +    struct {
> +        uint32_t dfsc:6;
> +        uint32_t wnr:1;
> +        uint32_t s1ptw:1;
> +        uint32_t cm:1;
> +        uint32_t ea:1;
> +        uint32_t fnv:1;
> +        uint32_t set:2;
> +        uint32_t vncr:1;
> +        uint32_t ar:1;
> +        uint32_t sf:1;
> +        uint32_t srt:5;
> +        uint32_t sse:1;
> +        uint32_t sas:2;
> +        uint32_t isv:1;
> +        uint32_t _unused:7;
> +    } QEMU_PACKED;
> +} IssDataAbort;
> +
> +typedef enum {
> +    data_abort_lower =3D 36,
> +    data_abort =3D 37,
> +} ExceptionClass;
> +
> #define ARM_EL_EC_LENGTH 6
> #define ARM_EL_EC_SHIFT 26
> #define ARM_EL_IL_SHIFT 25
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 513551bec1..b4daeaff4d 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -28,6 +28,8 @@
>=20
> #include "syndrome.h"
> #include "target/arm/cpregs.h"
> +#include "target/arm/helper.h"
> +#include "target/arm/syndrome.h"
> #include "internals.h"
>=20
> #include "system/whpx-internal.h"
> @@ -330,59 +332,25 @@ static void =
whpx_set_global_reg(WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
>     }
> }
>=20
> -static uint64_t whpx_get_gp_reg(CPUState *cpu, int rt)
> -{
> -    assert(rt <=3D 31);
> -    if (rt =3D=3D 31) {
> -        return 0;
> -    }
> -    WHV_REGISTER_NAME reg =3D WHvArm64RegisterX0 + rt;
> -    WHV_REGISTER_VALUE val;
> -    whpx_get_reg(cpu, reg, &val);
> -
> -    return val.Reg64;
> -}
> -
> -static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
> -{
> -    assert(rt < 31);
> -    WHV_REGISTER_NAME reg =3D WHvArm64RegisterX0 + rt;
> -    WHV_REGISTER_VALUE reg_val =3D {.Reg64 =3D val};
> -
> -    whpx_set_reg(cpu, reg, reg_val);
> -}
> -
> static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT =
*ctx)
> {
> -    uint64_t syndrome =3D ctx->Syndrome;
> -
> -    bool isv =3D syndrome & ARM_EL_ISV;
> -    bool iswrite =3D (syndrome >> 6) & 1;
> -    bool sse =3D (syndrome >> 21) & 1;
> -    uint32_t sas =3D (syndrome >> 22) & 3;
> -    uint32_t len =3D 1 << sas;
> -    uint32_t srt =3D (syndrome >> 16) & 0x1f;
> -    uint32_t cm =3D (syndrome >> 8) & 0x1;
> -    uint64_t val =3D 0;
> +    int ret =3D 0;
> +    EsrEl2 esr =3D { .raw =3D ctx->Syndrome };
> +    uint32_t cm =3D (esr.iss >> 8) & 0x1;
>=20
>     assert(!cm);
> -    assert(isv);
> -
> -    if (iswrite) {
> -        val =3D whpx_get_gp_reg(cpu, srt);
> -        address_space_write(&address_space_memory,
> -                            ctx->Gpa,
> -                            MEMTXATTRS_UNSPECIFIED, &val, len);
> -    } else {
> -        address_space_read(&address_space_memory,
> -                           ctx->Gpa,
> -                           MEMTXATTRS_UNSPECIFIED, &val, len);
> -        if (sse) {
> -            val =3D sextract64(val, 0, len * 8);
> -        }
> -        whpx_set_gp_reg(cpu, srt, val);
> +
> +    whpx_get_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
> +
> +    ret =3D arm_emulate_mmio(cpu, esr, ctx->Gpa);
> +    if (ret < 0) {
> +        error_report("WHPX: Failed to handle MMIO, syndrome=3D0x%llx, =
gpa=3D0x%llx",
> +                     esr.raw, ctx->Gpa);
> +        return -1;
>     }
>=20
> +    whpx_set_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
> +
>     return 0;
> }
>=20
>=20
> --=20
> 2.45.4
>=20
>=20


