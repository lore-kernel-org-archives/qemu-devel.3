Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B01F513ED
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytB1-0006UF-1G; Sat, 07 Mar 2026 10:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyt9u-0005iI-3i
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:01:43 -0500
Received: from p-west1-cluster2-host8-snip4-1.eps.apple.com ([57.103.64.202]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyt9o-000571-T7
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:01:36 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-7 (Postfix) with ESMTPS id
 19B201800215; Sat,  7 Mar 2026 15:01:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772895688; x=1775487688;
 bh=FxDjNm/2quGgkn/WgUpRBwpf4xG7+uf5Iw7NLZc9Hbg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=WpwdRcJSRaOEdRGUA7t6UqCAMHUBJYvRngu1YfGvYPPbjkETXVeP6shE88EIYoIl/JkUh8iRDjUxU8Avd8T1cFnA1YqqUGDHZ63uUT33c0sZdBqVB8la4nHyb4z7z+pcB1zFTQqgE0uDRXIliBfa/gy4MmEQb8vIi7pFwsVerHmrtU9Khl+h9qtNpDQVkD85Khn4a9TaFSSEqinE2Yr9QtwSVCoL99GosqILAN7ucO7oEkYjNjzHc9eDYfeVUo3oxAoe/qCtYREDw/sp6Qx8V431oya6GP74dyp3c5LASrb9TsZE1LcIhIIi58j1A1oiCJjEOLlj83DqPDdWJtbR5A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-7 (Postfix) with ESMTPSA id
 5205818001B8; Sat,  7 Mar 2026 15:01:18 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v17 14/14] hvf: arm: move SME2 registers to common
 hvf_sreg structure
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260307090606.95300-15-mohamed@unpredictable.fr>
Date: Sat, 7 Mar 2026 16:01:06 +0100
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C12B38DB-B707-4DCF-AFEA-8BF283CE5654@unpredictable.fr>
References: <20260307090606.95300-1-mohamed@unpredictable.fr>
 <20260307090606.95300-15-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=aZhsXBot c=1 sm=1 tr=0 ts=69ac3dc6
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=osJ17xdEAtvT97lCEQUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FX-WeqBlOLXYNaax-MWdP7Q2SgQavjJs
X-Proofpoint-ORIG-GUID: FX-WeqBlOLXYNaax-MWdP7Q2SgQavjJs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0MyBTYWx0ZWRfXwOZnvU5/FzcZ
 dGeA1LtMpcxNHZhnb2L2bVDbLYib92KeK5cMlXGXNazco8kNa62tMydSLsl5wK4zPDrJefYQUoD
 Jii3BReB4ptDvcW81PTAMnGYeOysH9jhVQ6lVIkxqNznHuli3W9+rlqNDH+yXiIBvS6Gwg84Fm9
 F3Qf0MS/sFu5UOBEYl1JNHRIxdC+zxriI5SkSB7D0culXMIKgK/nK8TxuU3BLmlY49J/aqFbF9A
 W2A382cPM5vR3H0+7+Po8hEnyOXbYPS6HimgML30KtdsrGkDViYUYFYpxs1pG3T1swTmPAfRCQL
 m/rDYKoMXgxI/wu/UGG4Mbt1flE6xBZ+MenEyegeX8l9pDoIfBckU+A5wqHtbc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 clxscore=1030 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603070143
Received-SPF: pass client-ip=57.103.64.202;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Going to resend the series=E2=80=A6 again=E2=80=A6 without this commit =
because the SDK in the CI is the macOS 15.1 one instead of 15.2.

> On 7. Mar 2026, at 10:06, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/arm/hvf/hvf.c        | 77 +++++++++++--------------------------
> target/arm/hvf/sysreg.c.inc | 14 +++----
> 2 files changed, 29 insertions(+), 62 deletions(-)
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 2cb4c4aa4e..4630d76930 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -481,7 +481,9 @@ static const struct hvf_reg_match =
hvf_sme2_preg_match[] =3D {
>=20
> #define DEF_SYSREG(HVF_ID, ...) \
>   QEMU_BUILD_BUG_ON(HVF_ID !=3D =
KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
> -#define DEF_SYSREG_15_02(...)
> +
> +#define DEF_SYSREG_SME2(HVF_ID, ...) \
> +  QEMU_BUILD_BUG_ON(HVF_ID !=3D =
KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
>=20
> #define DEF_SYSREG_EL2(HVF_ID, ...) \
>   QEMU_BUILD_BUG_ON(HVF_ID !=3D =
KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
> @@ -495,13 +497,13 @@ static const struct hvf_reg_match =
hvf_sme2_preg_match[] =3D {
> #include "sysreg.c.inc"
>=20
> #undef DEF_SYSREG
> -#undef DEF_SYSREG_15_02
> +#undef DEF_SYSREG_SME2
> #undef DEF_SYSREG_EL2
> #undef DEF_SYSREG_VGIC
> #undef DEF_SYSREG_VGIC_EL2
>=20
> #define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID},
> -#define DEF_SYSREG_15_02(...)
> +#define DEF_SYSREG_SME2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, =
.sme2 =3D true},
> #define DEF_SYSREG_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .el2 =
=3D true},
> #define DEF_SYSREG_VGIC(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, =
.vgic =3D true},
> #define DEF_SYSREG_VGIC_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, =
true, true},
> @@ -510,6 +512,7 @@ struct hvf_sreg {
>     hv_sys_reg_t sreg;
>     bool vgic;
>     bool el2;
> +    bool sme2;
> };
>=20
> static struct hvf_sreg hvf_sreg_list[] =3D {
> @@ -517,30 +520,13 @@ static struct hvf_sreg hvf_sreg_list[] =3D {
> };
>=20
> #undef DEF_SYSREG
> -#undef DEF_SYSREG_15_02
> +#undef DEF_SYSREG_SME2
> #undef DEF_SYSREG_EL2
> #undef DEF_SYSREG_VGIC
> #undef DEF_SYSREG_VGIC_EL2
>=20
> #pragma clang diagnostic pop
>=20
> -#define DEF_SYSREG(...)
> -#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) {HVF_ID},
> -#define DEF_SYSREG_EL2(...)
> -#define DEF_SYSREG_VGIC(...)
> -#define DEF_SYSREG_VGIC_EL2(...)
> -
> -API_AVAILABLE(macos(15.2))
> -static struct hvf_sreg hvf_sreg_list_sme2[] =3D {
> -#include "sysreg.c.inc"
> -};
> -
> -#undef DEF_SYSREG
> -#undef DEF_SYSREG_15_02
> -#undef DEF_SYSREG_EL2
> -#undef DEF_SYSREG_VGIC
> -#undef DEF_SYSREG_VGIC_EL2
> -
> /*
>  * For FEAT_SME2 migration, we need to store PSTATE.{SM,ZA} bits which =
are
>  * accessible with the SVCR pseudo-register. However, in the HVF API =
this is
> @@ -1357,23 +1343,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>     hv_return_t ret;
>     int i;
>=20
> -    if (__builtin_available(macOS 15.2, *)) {
> -        if (hvf_arm_sme2_supported()) {
> -            sregs_match_len +=3D ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
> -        }
> -
> -#define DEF_SYSREG_15_02(HVF_ID, ...) \
> -        g_assert(HVF_ID =3D=3D =
KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
> -#define DEF_SYSREG(...)
> -#define DEF_SYSREG_EL2(...)
> -#define DEF_SYSREG_VGIC(...)
> -#define DEF_SYSREG_VGIC_EL2(...)
> -
> -#include "sysreg.c.inc"
> -
> -#undef DEF_SYSREG
> -#undef DEF_SYSREG_15_02
> +    if (hvf_arm_sme2_supported()) {
> +        /* SVCR will be added at the end. */
> +        sregs_match_len +=3D 1;
>     }
> +
>     env->aarch64 =3D true;
>=20
>     /* system count frequency sanity check */
> @@ -1408,31 +1382,24 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>             continue;
>         }
>=20
> +        if (hvf_sreg_list[i].sme2 && !hvf_arm_sme2_supported()) {
> +            continue;
> +        }
> +
>         if (ri) {
>             assert(!(ri->type & ARM_CP_NO_RAW));
>             arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
>         }
>     }
> -    if (__builtin_available(macOS 15.2, *)) {
> -        if (hvf_arm_sme2_supported()) {
> -            for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
> -                hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i].sreg;
> -                uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
> -                uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> -                const ARMCPRegInfo *ri =3D =
get_arm_cp_reginfo(arm_cpu->cp_regs, key);
>=20
> -                if (ri) {
> -                    assert(!(ri->type & ARM_CP_NO_RAW));
> -                    arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> -                }
> -            }
> -            /*
> -             * Add SVCR last. It is elsewhere assumed its index is =
after
> -             * hvf_sreg_list and hvf_sreg_list_sme2.
> -             */
> -            arm_cpu->cpreg_indexes[sregs_cnt++] =3D =
HVF_TO_KVMID(SVCR);
> -        }
> +    if (hvf_arm_sme2_supported()) {
> +        /*
> +         * Add SVCR last. It is elsewhere assumed its index is after
> +         * hvf_sreg_list.
> +         */
> +        arm_cpu->cpreg_indexes[sregs_cnt++] =3D HVF_TO_KVMID(SVCR);
>     }
> +
>     arm_cpu->cpreg_array_len =3D sregs_cnt;
>     arm_cpu->cpreg_vmstate_array_len =3D sregs_cnt;
>=20
> diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
> index c11dbf274e..2d29c2feec 100644
> --- a/target/arm/hvf/sysreg.c.inc
> +++ b/target/arm/hvf/sysreg.c.inc
> @@ -146,13 +146,13 @@ DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, =
1)
> DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
> DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
>=20
> -DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
> -DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
> -DEF_SYSREG_15_02(HV_SYS_REG_TPIDR2_EL0, 3, 3, 13, 0, 5)
> -DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
> -DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
> -DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
> -DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
> +DEF_SYSREG_SME2(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
> +DEF_SYSREG_SME2(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
> +DEF_SYSREG_SME2(HV_SYS_REG_TPIDR2_EL0, 3, 3, 13, 0, 5)
> +DEF_SYSREG_SME2(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
> +DEF_SYSREG_SME2(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
> +DEF_SYSREG_SME2(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
> +DEF_SYSREG_SME2(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
> /*
>  * Block these because of the same issue as virtual counters in
>  * that caused the revert in 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
> --=20
> 2.50.1 (Apple Git-155)
>=20
>=20


