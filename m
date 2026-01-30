Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB53E6BF3C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 22:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlx75-00084U-4D; Fri, 30 Jan 2026 17:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlx73-00083k-So
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 17:37:13 -0500
Received: from ci-2003c-snip4-11.eps.apple.com ([57.103.91.161]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlx70-0003A7-Go
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 17:37:13 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-2 (Postfix) with ESMTPS id
 905ED180018F; Fri, 30 Jan 2026 22:37:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769812625; x=1772404625;
 bh=bs89GLfQNRi9ceLgI89OtxqKLSRdLfXYcilA4zeaclc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=gqizxpKeQ563gkRTcuYY95iP6KFhAhVCa9Qt+My8+lETE1yJKsOMjT65ZKDPZZXUAwHR2mATK66A1HDaxWwKEVbCo+/qX+wkIANnFHrUFfWfGNBZi9ZJnWyUZMxfRiUZvdNcrLWwT3uTEyUmVFF0cHdQ3XJKahPr8LcrmQkLktgg5T2eRBdi5inmvCis7c6pLsFCwXfacB+bW3XEi6QjVPJ5bDlPn8yygGJ6eG/cDR2irMhVtfKp461wrvov2aW5Tx2bVKx6obR7hpx+1Qn6RXpWi0798hLPmabKs07oIOHYJRmLrU5YXTUwWTiOc3WW22tIxySyS1ccd4oA+pQlYQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-2 (Postfix) with ESMTPSA id
 115A71800CE3; Fri, 30 Jan 2026 22:37:01 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [RFC PATCH] target/arm: implement FEAT_E2H0
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260130202722.667885-1-alex.bennee@linaro.org>
Date: Fri, 30 Jan 2026 23:36:50 +0100
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE4A097A-DE77-4D7D-B680-99516CB08FB5@unpredictable.fr>
References: <20260130202722.667885-1-alex.bennee@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE4NiBTYWx0ZWRfXwJIcxzdZpOAK
 3mHP6+hQnukHHV90avtbvYzUmwBSYsIQG9UzG3zrHeHesNkWsCGfWF5pWPQwPj/1OfWlV07P8vl
 f56SEOHYx/nlYBqQDuR+MXi0TZhZya9wz6Jwjzs7g5S9yjngYc43N6UMqGZXQ9IiZZSPHHUmJaY
 rikcjhuta0rqDLL2z45qv1siEu0oDrBSmDTwgLRdfp3hFpbBE4ylPWp9WSo6rMez76DVyg356q/
 4COSOESEf4zo2MGUin1RVN5nooH8WYOqkrp2bKkdBXTkDhpoR7T4jc2BYuZd6Z0bIK/Zz4kRTK+
 DpUtPWouH8WsjNErKj7RxydrlEVhxxEBMM21JSwFOwjizos0N9aIunU0fBTLLQ=
X-Proofpoint-GUID: 6OXQBgp7yd7iKaqQ8zzDcqF6-ISKSEiq
X-Authority-Info-Out: v=2.4 cv=XZmEDY55 c=1 sm=1 tr=0 ts=697d3290
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=C09wV-DRWh3JtPgHcNcA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6OXQBgp7yd7iKaqQ8zzDcqF6-ISKSEiq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300186
X-JNJ: AAAAAAABwWPhRP0cjRNAdKgQ+om4bcHnLKqLmqDuJYR4dHBBg8UtHwJgtdf99AhiVLzy6RT80JB+WLxw4OeW7WEdZnKXjLz6HOUB1bjRHKlmwLkXLyERr7XbwQ4ayOffVB1zk9dyDbfXNY0f6Phnjiv7EEloY+k56LwlG7PsfaseTvfZboYL7/fCDALEHyIj4QvhjmQ/pdeiwlyYOV6MqiHj9FISeuMEQ2X2haQt7KgyNADS7GXITgU4bbTFHLHMJo/Vk/Z/Q5isDjObzrrA7JHEv+sNZdZSvo9jX87gFI1ZaXqGEaEZx/vJ8ExJdGq39wjjeeWtVVVwN95j7lOSvQGgTbByffeiKEc7N9rLO5UgR3JwXnEci3BHVQc7c11p1+nLBr/dMRboFHWaA5qcs9RHWQedCIdWkAhqa2pqJOlr7v4FpQaS9HO3qFBEc5a2S3x0FElECjcrubVpI/nlPsEhrR1+Abm8zwyVXWKrIfz8UfH6HbVKx/gxMLWmqgEu3jpyWvWcBTU9v6KHP9XxrkMrZrgmfQZcKsC9MwoFU8FKgEf19A5CTvQLldHNEHPCYf2Lq3d/Z0bgRR6YjymfTk1lRxkglZjZDNmmocowUkxErZO+VxiMwMkHd8P5IZ5nO2Jp2v6x9XeibzvtGnfVz6bgUQ==
Received-SPF: pass client-ip=57.103.91.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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



> On 30. Jan 2026, at 21:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> FEAT_E2H0 is a formalisation of the existing behaviour of HCR_EL2.E2H
> being programmable to switch between EL2 host mode and the
> "traditional" nVHE EL2 mode. This implies at some point we might want
> to model CPUs without FEAT_E2H0 which will always have EL2 host mode
> enabled.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> comment: I've left a fixme? for HCR_EL2.NV1, I await guidance on if
> I'm reading the spec wrong.
> ---
> docs/system/arm/emulation.rst |  1 +
> target/arm/cpu-features.h     |  6 ++++++
> target/arm/helper.c           | 14 +++++++++++++-
> 3 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/system/arm/emulation.rst =
b/docs/system/arm/emulation.rst
> index 3f30ea5a30e..74359f3e844 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -53,6 +53,7 @@ the following architecture extensions:
> - FEAT_DotProd (Advanced SIMD dot product instructions)
> - FEAT_DoubleFault (Double Fault Extension)
> - FEAT_E0PD (Preventing EL0 access to halves of address maps)
> +- FEAT_E2H0 (Programming of HCR_EL2.E2H)
> - FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
> - FEAT_ECV (Enhanced Counter Virtualization)
> - FEAT_EL0 (Support for execution at EL0)
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index a7ca410dcb4..b6ef328fe0a 100644
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
> @@ -1376,6 +1377,11 @@ static inline bool =
isar_feature_aa64_asid2(const ARMISARegisters *id)
>     return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) !=3D 0;
> }
>=20
> +static inline bool isar_feature_aa64_e2h0(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, E2H0) =3D=3D 0;
> +}
> +
> static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
> {
>     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) !=3D 0;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 655ce73ee1b..27b5fb01827 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3773,7 +3773,8 @@ static void do_hcr_write(CPUARMState *env, =
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
> @@ -3797,6 +3798,11 @@ static void do_hcr_write(CPUARMState *env, =
uint64_t value, uint64_t valid_mask)
>         if (cpu_isar_feature(aa64_rme, cpu)) {
>             valid_mask |=3D HCR_GPF;
>         }
> +        /*
> +         * FIXME? HCR_EL2.NV1 is only meant to be RES0 if
> +         * FEAT_E2H0 is not implemented with 0b1110 although the Arm
> +         * ARM doesn't explicitly state it is RES1 with 0b1111.
> +         */
Hello,

=46rom the ID_AA64MMFR4_EL1.E2H0 register description:

0b1111 =3D E2H being RES1.
0b1110 =3D in addition to that, NV1 is RES0.

Looking at KVM:

This test is done in kvm_vcpu_init_nested:

	if (test_bit(KVM_ARM_VCPU_HAS_EL2_E2H0, kvm->arch.vcpu_features) =
&&
	    !cpus_have_final_cap(ARM64_HAS_HCR_NV1))

With ARM64_HAS_HCR_NV1 being a check on ID_AA64MMFR4_EL1.E2H0: =
https://lore.kernel.org/all/20240122181344.258974-7-maz@kernel.org/

If 0b1111, from reading this, an nVHE nested virt guest will still work =
but not an nVHE bare metal hypervisor.


>         if (cpu_isar_feature(aa64_nv, cpu)) {
>             valid_mask |=3D HCR_NV | HCR_NV1 | HCR_AT;
>         }
> @@ -3820,6 +3826,12 @@ static void do_hcr_write(CPUARMState *env, =
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


