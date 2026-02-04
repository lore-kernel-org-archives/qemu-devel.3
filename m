Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF94E9D407
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 15:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnfEp-0007qq-Qr; Wed, 04 Feb 2026 10:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnfEo-0007qQ-Lg
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 10:56:18 -0500
Received: from p-west1-cluster5-host5-snip4-2.eps.apple.com ([57.103.66.133]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnfEm-0001os-AK
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 10:56:18 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPS id
 49A0C18002E9; Wed,  4 Feb 2026 15:56:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770220572; x=1772812572;
 bh=P+H0HaAzK35j+sFAQWcjappE0gHuM2R5Eo987/PjfdI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=CtF5YsM8SdiDx47gOMvs5wsXqF8XT36bP2xk86qmJTzf8tQxekrZrBXMVNWBorOHWZ0WRd8sSEGW+C7Lt4dz0DvC2DDAfTEmfIAXfk6PXvXPF+rm0B55KuE2cVYzM2UqUuwfzDgrFH8g+MY58Fkk6idtiJ1Bl1MpNpRidhX+uUePvKj2Cho8sbCqWoUgjus1fpFgY95e3DdOFxlvtkzI8b1KfF24RF1p3BfDAAK2j0C9w5zisp2/GP8cEzOUx4en1qRPTtMprCkL3SzsdHdkARTls9fpNQyBYlzKTc5NZ5HqRgQPV6JVTqbge1ZtSjQ9t5VZUno2qmhMxPodGCLQtw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPSA id
 059E71800A8F; Wed,  4 Feb 2026 15:56:06 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2] target/arm: implement FEAT_E2H0
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260204131353.2977855-1-alex.bennee@linaro.org>
Date: Wed, 4 Feb 2026 16:55:54 +0100
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7585A291-F924-4A75-BA2A-D55A3B62319F@unpredictable.fr>
References: <20260204131353.2977855-1-alex.bennee@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: jcUJb6LdnJJ8MsRPFj8g-01VbwAKZgT7
X-Proofpoint-ORIG-GUID: jcUJb6LdnJJ8MsRPFj8g-01VbwAKZgT7
X-Authority-Info-Out: v=2.4 cv=adlsXBot c=1 sm=1 tr=0 ts=69836c1a
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=Y1okbNz4jf-ho67gAakA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDExOSBTYWx0ZWRfXxwmmiPrh26Hk
 s1yMX5o3QvkgFz6JszvyKCVMV9VFddR0vqbL4SbpRAwCWiWqZSMyjn6ejhjVzSdi3R+pQ5sm5dK
 WlgXOQ7lRnZ6HMZvZKMJZ0tziWM/+dkjc+c9F1Mzfk09JX5nTFl4PiEupRUPo7g7g0N51DPQpXK
 A/Q5A8iRdamEXbSSAslhGWhFsJ8cL3pY/ys/YCNgJ88EB/QJ0gmIOeRRTycijlgiJ1ZvNA5mr7i
 qwttKpkcQ4lRYwEcEp5++d5jfnryPVs1cliUMEiosg8qQBGSd1NI8ajRQPfTdxzT8Xs0zJ4ASj8
 r2NSWPSyAFTVr7XcKMEVJ7GxEt9skcW7s2yhICEFslZ2VuyrBfHFr0u16iKpeQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040119
X-JNJ: AAAAAAABFVTrJn+uIh1K5NrOunOID4AqnrHaYhDNiUfgXBrXCqzNq9iL8YC8L8lPaG6QzJYIc1YXWiKNiPkSzjdo3Nf9AiyUIuEtMRvq6+sJr4mIwaoeSlORLVi6RQGkY6iEl91x/NuyN+ItBogPhMRGmxer8ixPjDjMdDX+viDvuBOyrzfrRrB+vIcHgNCWJwE673JilcRk86Lg+6ywXea2Nd6Vdh0eJYbYyyk8WV3an6PaOfQhN1KKWeJUoSpLuCdqa0EEGPywa1HH5KVrnk+xh73q0EGIN79sLiL4ZZ4+Uh4610KpXMAb93AhQHy/rrYZArm8fiikR7cd7VXiU0y4X0s8J5Z2TKeATASgT0AbQmdMbmNIi7Z15UDVeQ1s8JwuolgiIY0ynfrrQWLTqqXBg3qkte85nEjkEhTfmw3b/PhZnszPqYbHBf8WhU5fiMP5n8mdZY0k62IZWFiTynRucZnRajiKFDhQgSLaAS7+eLEoyxqm+FTXoxorKvA2UUeV/8EG0nSJmmZ9QnQohMKYBVmhD5yYnGfuFl0G//2v05NijyLbhSC9FVwqLbsrps1gMwZU+oTaO1J57vycAXxjbwVG1jBo+ESZuKbivLD9fSYfZ7fkyK/xwvjlhg==
Received-SPF: pass client-ip=57.103.66.133;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 4. Feb 2026, at 14:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> FEAT_E2H0 is a formalisation of the existing behaviour of HCR_EL2.E2H
> being programmable to switch between EL2 host mode and the
> "traditional" nVHE EL2 mode. This implies at some point we might want
> to model CPUs without FEAT_E2H0 which will always have EL2 host mode
> enabled.
>=20
> There are two values to represent no E2H0 systems of which 0b1110 will
> make HCR_EL2.NV1 RES0 for FEAT_NV systems.
Hello,

That part looks good.

> For FEAT_NV2 the NV1 bit is
> always valid.

At section A2.2.5 of the Arm ARM:

> If FEAT_NV2 is implemented, then FEAT_NV is implemented.

My reading of the spec is that 0b1110 is allowed on a system that =
implements FEAT_NV2 as those always implement FEAT_NV - even if the trap =
mode is gone because of using NV_frac to represent nested virtualisation =
support.

As the code looks fine,

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>=20
> Message-ID: <20260130181648.628364-1-alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>  - new helper and properly handling NV1
> ---
> docs/system/arm/emulation.rst |  1 +
> target/arm/cpu-features.h     | 12 ++++++++++++
> target/arm/helper.c           | 16 +++++++++++++---
> 3 files changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/docs/system/arm/emulation.rst =
b/docs/system/arm/emulation.rst
> index e0d5f9886e1..7787691853e 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -54,6 +54,7 @@ the following architecture extensions:
> - FEAT_DotProd (Advanced SIMD dot product instructions)
> - FEAT_DoubleFault (Double Fault Extension)
> - FEAT_E0PD (Preventing EL0 access to halves of address maps)
> +- FEAT_E2H0 (Programming of HCR_EL2.E2H)
> - FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
> - FEAT_ECV (Enhanced Counter Virtualization)
> - FEAT_EL0 (Support for execution at EL0)
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index e0b7a45b7bd..78ff761ae06 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -347,6 +347,7 @@ FIELD(ID_AA64MMFR3, ADERR, 56, 4)
> FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
>=20
> FIELD(ID_AA64MMFR4, ASID2, 8, 4)
> +FIELD(ID_AA64MMFR4, E2H0, 24, 4)
>=20
> FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
> FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
> @@ -1378,6 +1379,17 @@ static inline bool =
isar_feature_aa64_asid2(const ARMISARegisters *id)
>     return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) !=3D 0;
> }
>=20
> +static inline bool isar_feature_aa64_e2h0(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, E2H0) =3D=3D 0;
> +}
> +
> +static inline bool isar_feature_aa64_noe2h0_and_nv1_res0(const =
ARMISARegisters *id)
> +{
> +    /* 0b1110 is not permitted unless we have FEAT_NV */
> +    return isar_feature_aa64_nv(id) && FIELD_EX64_IDREG(id, =
ID_AA64MMFR4, E2H0) =3D=3D 0b1110;
> +}
> +
> static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
> {
>     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) !=3D 0;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 390ea32c218..c3f4054a0b0 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3776,7 +3776,8 @@ static void do_hcr_write(CPUARMState *env, =
uint64_t value, uint64_t valid_mask)
>     }
>=20
>     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
> -        if (cpu_isar_feature(aa64_vh, cpu)) {
> +        if (cpu_isar_feature(aa64_vh, cpu) &&
> +            cpu_isar_feature(aa64_e2h0, cpu)) {
>             valid_mask |=3D HCR_E2H;
>         }
>         if (cpu_isar_feature(aa64_ras, cpu)) {
> @@ -3801,10 +3802,13 @@ static void do_hcr_write(CPUARMState *env, =
uint64_t value, uint64_t valid_mask)
>             valid_mask |=3D HCR_GPF;
>         }
>         if (cpu_isar_feature(aa64_nv, cpu)) {
> -            valid_mask |=3D HCR_NV | HCR_NV1 | HCR_AT;
> +            valid_mask |=3D HCR_NV | HCR_AT;
> +            if (!cpu_isar_feature(aa64_noe2h0_and_nv1_res0, cpu)) {
> +                valid_mask |=3D HCR_NV1;
> +            }
>         }
>         if (cpu_isar_feature(aa64_nv2, cpu)) {
> -            valid_mask |=3D HCR_NV2;
> +            valid_mask |=3D HCR_NV1 | HCR_NV2;
>         }
>     }
>=20
> @@ -3823,6 +3827,12 @@ static void do_hcr_write(CPUARMState *env, =
uint64_t value, uint64_t valid_mask)
>         value |=3D HCR_RW;
>     }
>=20
> +    /* Strictly E2H is RES1 unless FEAT_E2H0 relaxes the requirement =
*/
> +    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
> +        !cpu_isar_feature(aa64_e2h0, cpu)) {
> +        value |=3D HCR_E2H;
> +    }
> +
>     /*
>      * These bits change the MMU setup:
>      * HCR_VM enables stage 2 translation
> --=20
> 2.47.3
>=20
>=20


