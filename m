Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB37FD8FF5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 19:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvgy3-0007rD-JL; Thu, 26 Feb 2026 14:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvgxz-0007qv-Ul
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:24:08 -0500
Received: from p-east2-cluster3-host1-snip4-5.eps.apple.com ([57.103.77.216]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvgxw-0000HT-Oi
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:24:07 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-3 (Postfix) with ESMTPS id
 863BF180029F; Thu, 26 Feb 2026 19:24:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772133843; x=1774725843;
 bh=RovKpgODpzkJnwR35PEhchvp81M3pNAvFw1s9w4z86A=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=DLoEE5YnHKQOiNVFM779KYsAu/CXPfw92LR4DuJaZKPDVgyFTlsTSZ5Nb2SOguvytzfn6nGGC6eGXIVDcOhuRm1f/juK4nf+EY32yW1Ml389qIQDRh9is6FkkkSo5S4O1iCTGQdL9LC/FNncAjGNZrQiipvmxxlgDQdkM74GPBjCk8lmCiWfzq5WDopzz5JDMzBaojacx4dYywpmxIox2RxxFlcfaSvW54sZInnWaCeTtQ6Z7EhD772XG/79n7nW7q0mpx6fHl3rhJkVot4DxgwcwaCFhYH8l24e9GSINwOSF7b2sDjfodELcNUKoxAOCdv/5NChRFTsM2iIalJ+Ow==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-3 (Postfix) with ESMTPSA id
 0C68C1800303; Thu, 26 Feb 2026 19:24:00 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v3 1/2] hvf/arm: handle FEAT_SME2 migration
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260226-sme2-hvf-v3-1-ea5763dbeba2@linaro.org>
Date: Thu, 26 Feb 2026 20:23:49 +0100
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <005B316F-6CFB-43E0-AC3A-B894ECD6BCAC@unpredictable.fr>
References: <20260226-sme2-hvf-v3-0-ea5763dbeba2@linaro.org>
 <20260226-sme2-hvf-v3-1-ea5763dbeba2@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=OrxCCi/t c=1 sm=1 tr=0 ts=69a09dd2
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=wM5AAcdan--186XRT34A:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3NyBTYWx0ZWRfXw7s5rzDL8YjQ
 hUe/krDleyHBVsiwzDvPAmtq82N9wUwV1oSg6gGg5+WTP08ZgrUFoxxIP8/4bT9VBSKNV/f3R75
 xtSPlF/Nd8PqoXmVLsYMQXLrUDXweEMk+IJXKKCl56VjbOO+kzLj6EjHKV4umoArYLH6h86a8Ex
 I7fEQh7v7kvO3c0xGMBDUC3Oq/CqnDl9j/PdqrgQkQLOj7CyXgBB/D0Nld2VNVbM74Ot2szn8Nl
 yB5HtILvqxLfvwF6ZoZlls7aBpwz0DgeBYbg9zcJshAXtLG8M12ugyJSZOyXvSzQgKlf2hazj24
 Co6+GWTNOZBjSvhCwdm5hgwnS3og8hm2gA5Qe+qsslnSc/m0SsR3OtRIxyfZmQ=
X-Proofpoint-GUID: oI6JBcq_6RTYOGIHMmVAqjRMZDtwKtyG
X-Proofpoint-ORIG-GUID: oI6JBcq_6RTYOGIHMmVAqjRMZDtwKtyG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1030 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260177
X-JNJ: AAAAAAAB8cudsT5vP2a++DSpnh6XAxxYEyl8dsuxbgtzvI7Fm9kxXztR8zutDweDNKnG/DRZlhOQONAQVwt/m34YAUVbXbxY+uMYcaSh5KQipJmNt2kwlnZF+p302Xza3Uq9xzTVulPy7ALN9ZiB1xDMJ6bQRagRw0tqGQcNkG3BtZLxDqqynOmyLrN4uDSRS5GOgGeUflTHCDAmj9rmmxuaHydMZG8QFkg5PhEIZ0ZvhSp9jx/nJSIdY9v3O7t/MKr30jmNEcv3Fbqvj37szm7LIxW0cQOIpzcefzBv+IjjEgk2KROUwfFvkIG91VTbCUvck+A7QdU+1HW1okBnAM8LUCn7BPnuRvHV8x4wZ6LzNBoZe31J+oxUY5ziQxz/8hDD30EfWi8e2PEq64/ygpE/FwPmmA7hgfj/b0SqyyalCsJR+OJ1Utp17qn9PCkxjZhAewqgkmLToRTqb9IpMGfdoQNZncw8sW16RK9/5G4oLj06SkhsATsL0AXIww//GF1XMbeEJ3P5zHnZ5dF8AQjBOWV/Zn6i4MxRKEzmgOu9xyyLXZqWuZ63eKTVFjCMBQJ6lJkAtGsjRA3p5cpyDolJWSlKrVEl65GENwDJOA5eFQOtSjPiwSlPDbrGieKSr+8PFIrANmiM3Lb0AlZePUgdACrMkhgavf+wbBVx4Z+fZFVFEdOnN26Lz9wdiaOquYdZ8Q==
Received-SPF: pass client-ip=57.103.77.216;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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



> On 26. Feb 2026, at 08:25, Manos Pitsidianakis =
<manos.pitsidianakis@linaro.org> wrote:
>=20
> SME2 support adds the following state for HVF guests:
>=20
> - Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
>  not support it)
> - Predicate registers P0, .., P15 (also FEAT_SVE)
> - ZA register
> - ZT0 register
> - PSTATE.{SM,ZA} bits (SVCR pseudo-register)
> - SMPRI_EL1 which handles the PE's priority in the SMCU
> - TPIDR2_EL0 the thread local ID register for SME
>=20
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/arm/hvf/hvf.c           | 289 =
++++++++++++++++++++++++++++++++++++++++-
> target/arm/hvf/hvf_sme_stubs.h | 158 ++++++++++++++++++++++
> target/arm/hvf/sysreg.c.inc    |   8 ++
> target/arm/hvf_arm.h           |  44 +++++++
> target/arm/machine.c           |   2 +-
> 5 files changed, 498 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index =
1b19d9713edd46cc7e9930de171fce87f49963d4..7d80c8b30aeedde8b81ac8fafc70f615=
32141dad 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -398,6 +398,60 @@ static const struct hvf_reg_match =
hvf_fpreg_match[] =3D {
>     { HV_SIMD_FP_REG_Q31, offsetof(CPUARMState, vfp.zregs[31]) },
> };
>=20
> +static const struct hvf_reg_match hvf_sme2_zreg_match[] =3D {
> +    { HV_SME_Z_REG_0, offsetof(CPUARMState, vfp.zregs[0]) },
> +    { HV_SME_Z_REG_1, offsetof(CPUARMState, vfp.zregs[1]) },
> +    { HV_SME_Z_REG_2, offsetof(CPUARMState, vfp.zregs[2]) },
> +    { HV_SME_Z_REG_3, offsetof(CPUARMState, vfp.zregs[3]) },
> +    { HV_SME_Z_REG_4, offsetof(CPUARMState, vfp.zregs[4]) },
> +    { HV_SME_Z_REG_5, offsetof(CPUARMState, vfp.zregs[5]) },
> +    { HV_SME_Z_REG_6, offsetof(CPUARMState, vfp.zregs[6]) },
> +    { HV_SME_Z_REG_7, offsetof(CPUARMState, vfp.zregs[7]) },
> +    { HV_SME_Z_REG_8, offsetof(CPUARMState, vfp.zregs[8]) },
> +    { HV_SME_Z_REG_9, offsetof(CPUARMState, vfp.zregs[9]) },
> +    { HV_SME_Z_REG_10, offsetof(CPUARMState, vfp.zregs[10]) },
> +    { HV_SME_Z_REG_11, offsetof(CPUARMState, vfp.zregs[11]) },
> +    { HV_SME_Z_REG_12, offsetof(CPUARMState, vfp.zregs[12]) },
> +    { HV_SME_Z_REG_13, offsetof(CPUARMState, vfp.zregs[13]) },
> +    { HV_SME_Z_REG_14, offsetof(CPUARMState, vfp.zregs[14]) },
> +    { HV_SME_Z_REG_15, offsetof(CPUARMState, vfp.zregs[15]) },
> +    { HV_SME_Z_REG_16, offsetof(CPUARMState, vfp.zregs[16]) },
> +    { HV_SME_Z_REG_17, offsetof(CPUARMState, vfp.zregs[17]) },
> +    { HV_SME_Z_REG_18, offsetof(CPUARMState, vfp.zregs[18]) },
> +    { HV_SME_Z_REG_19, offsetof(CPUARMState, vfp.zregs[19]) },
> +    { HV_SME_Z_REG_20, offsetof(CPUARMState, vfp.zregs[20]) },
> +    { HV_SME_Z_REG_21, offsetof(CPUARMState, vfp.zregs[21]) },
> +    { HV_SME_Z_REG_22, offsetof(CPUARMState, vfp.zregs[22]) },
> +    { HV_SME_Z_REG_23, offsetof(CPUARMState, vfp.zregs[23]) },
> +    { HV_SME_Z_REG_24, offsetof(CPUARMState, vfp.zregs[24]) },
> +    { HV_SME_Z_REG_25, offsetof(CPUARMState, vfp.zregs[25]) },
> +    { HV_SME_Z_REG_26, offsetof(CPUARMState, vfp.zregs[26]) },
> +    { HV_SME_Z_REG_27, offsetof(CPUARMState, vfp.zregs[27]) },
> +    { HV_SME_Z_REG_28, offsetof(CPUARMState, vfp.zregs[28]) },
> +    { HV_SME_Z_REG_29, offsetof(CPUARMState, vfp.zregs[29]) },
> +    { HV_SME_Z_REG_30, offsetof(CPUARMState, vfp.zregs[30]) },
> +    { HV_SME_Z_REG_31, offsetof(CPUARMState, vfp.zregs[31]) },
> +};
> +
> +static const struct hvf_reg_match hvf_sme2_preg_match[] =3D {
> +    { HV_SME_P_REG_0, offsetof(CPUARMState, vfp.pregs[0]) },
> +    { HV_SME_P_REG_1, offsetof(CPUARMState, vfp.pregs[1]) },
> +    { HV_SME_P_REG_2, offsetof(CPUARMState, vfp.pregs[2]) },
> +    { HV_SME_P_REG_3, offsetof(CPUARMState, vfp.pregs[3]) },
> +    { HV_SME_P_REG_4, offsetof(CPUARMState, vfp.pregs[4]) },
> +    { HV_SME_P_REG_5, offsetof(CPUARMState, vfp.pregs[5]) },
> +    { HV_SME_P_REG_6, offsetof(CPUARMState, vfp.pregs[6]) },
> +    { HV_SME_P_REG_7, offsetof(CPUARMState, vfp.pregs[7]) },
> +    { HV_SME_P_REG_8, offsetof(CPUARMState, vfp.pregs[8]) },
> +    { HV_SME_P_REG_9, offsetof(CPUARMState, vfp.pregs[9]) },
> +    { HV_SME_P_REG_10, offsetof(CPUARMState, vfp.pregs[10]) },
> +    { HV_SME_P_REG_11, offsetof(CPUARMState, vfp.pregs[11]) },
> +    { HV_SME_P_REG_12, offsetof(CPUARMState, vfp.pregs[12]) },
> +    { HV_SME_P_REG_13, offsetof(CPUARMState, vfp.pregs[13]) },
> +    { HV_SME_P_REG_14, offsetof(CPUARMState, vfp.pregs[14]) },
> +    { HV_SME_P_REG_15, offsetof(CPUARMState, vfp.pregs[15]) },
> +};
> +
> /*
>  * QEMU uses KVM system register ids in the migration format.
>  * Conveniently, HVF uses the same encoding of the op* and cr* =
parameters
> @@ -409,22 +463,201 @@ static const struct hvf_reg_match =
hvf_fpreg_match[] =3D {
> #define HVF_TO_KVMID(HVF)  \
>     (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
>=20
> -/* Verify this at compile-time. */
> +/*
> + * Verify this at compile-time.
> + *
> + * SME2 registers are guarded by a runtime availability attribute =
instead of a
> + * compile-time def, so verify those at runtime in =
hvf_arch_init_vcpu() below.
> + */
>=20
> #define DEF_SYSREG(HVF_ID, ...) \
>   QEMU_BUILD_BUG_ON(HVF_ID !=3D =
KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
> +#define DEF_SYSREG_15_02(...)
>=20
> #include "sysreg.c.inc"
>=20
> #undef DEF_SYSREG
> +#undef DEF_SYSREG_15_02
>=20
> #define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
> +#define DEF_SYSREG_15_02(...)
>=20
> static const hv_sys_reg_t hvf_sreg_list[] =3D {
> #include "sysreg.c.inc"
> };
>=20
> #undef DEF_SYSREG
> +#undef DEF_SYSREG_15_02
> +
> +#define DEF_SYSREG(...)
> +#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) HVF_ID,
> +
> +API_AVAILABLE(macos(15.2))
> +static const hv_sys_reg_t hvf_sreg_list_sme2[] =3D {
> +#include "sysreg.c.inc"
> +};
> +
> +#undef DEF_SYSREG
> +#undef DEF_SYSREG_15_02
> +
> +/*
> + * For FEAT_SME2 migration, we need to store PSTATE.{SM,ZA} bits =
which are
> + * accessible with the SVCR pseudo-register. However, in the HVF API =
this is
> + * not exposed as a system-register (i.e. HVF_SYS_REG_SVCR) but a =
custom
> + * struct, hv_vcpu_sme_state_t. So we need to define our own KVMID in =
order to
> + * store it in cpreg_values and make it migrateable.
> + */
> +#define SVCR KVMID_AA64_SYS_REG64(3, 3, 4, 2, 2)
> +
> +API_AVAILABLE(macos(15.2))
> +static void hvf_arch_put_sme(CPUState *cpu)
> +{
> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +    CPUARMState *env =3D &arm_cpu->env;
> +    const size_t svl_bytes =3D hvf_arm_sme2_get_svl();
> +    const size_t z_size =3D svl_bytes;
> +    const size_t preg_size =3D DIV_ROUND_UP(z_size, 8);
> +    const size_t za_size =3D svl_bytes * svl_bytes;
> +    hv_vcpu_sme_state_t sme_state =3D { 0 };
> +    hv_return_t ret;
> +    uint64_t svcr;
> +    int n;
> +
> +    /*
> +     * Set PSTATE.{SM,ZA} bits
> +     */
> +    svcr =3D arm_cpu->cpreg_values[arm_cpu->cpreg_array_len - 1];
> +    env->svcr =3D svcr;
> +
> +    /*
> +     * Construct SVCR (PSTATE.{SM,ZA}) state to pass to HVF:
> +     */
> +    sme_state.streaming_sve_mode_enabled =3D FIELD_EX64(env->svcr, =
SVCR, SM) > 0;
> +    sme_state.za_storage_enabled =3D FIELD_EX64(env->svcr, SVCR, ZA) =
> 0;
> +    ret =3D hv_vcpu_set_sme_state(cpu->accel->fd, &sme_state);
> +    assert_hvf_ok(ret);
> +
> +    /*
> +     * We only care about Z/P registers if we're in streaming SVE =
mode, i.e.
> +     * PSTATE.SM is set, because only then can instructions that =
access them be
> +     * used. We don't care about the register values otherwise. This =
is because
> +     * when the processing unit exits/enters this mode, it zeroes out =
those
> +     * registers.
> +     */
> +    if (sme_state.streaming_sve_mode_enabled) {
> +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_zreg_match); ++n) {
> +            ret =3D hv_vcpu_set_sme_z_reg(cpu->accel->fd,
> +                                        hvf_sme2_zreg_match[n].reg,
> +                                        (uint8_t =
*)&env->vfp.zregs[n].d[0],
> +                                        z_size);
> +            assert_hvf_ok(ret);
> +        }
> +
> +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_preg_match); ++n) {
> +            ret =3D hv_vcpu_set_sme_p_reg(cpu->accel->fd,
> +                                        hvf_sme2_preg_match[n].reg,
> +                                        (uint8_t =
*)&env->vfp.pregs[n].p[0],
> +                                        preg_size);
> +            assert_hvf_ok(ret);
> +        }
> +    }
> +
> +    /*
> +     * If PSTATE.ZA bit is set then ZA and ZT0 are valid, otherwise =
they are
> +     * zeroed out.
> +     */
> +    if (sme_state.za_storage_enabled) {
> +        hv_sme_zt0_uchar64_t tmp =3D { 0 };
> +
> +        memcpy(&tmp, &env->za_state.zt0, 64);
> +        ret =3D hv_vcpu_set_sme_zt0_reg(cpu->accel->fd, &tmp);
> +        assert_hvf_ok(ret);
> +
> +        ret =3D hv_vcpu_set_sme_za_reg(cpu->accel->fd,
> +                                     (uint8_t *)&env->za_state.za,
> +                                     za_size);
> +        assert_hvf_ok(ret);
> +    }
> +
> +    return;
> +}
> +
> +API_AVAILABLE(macos(15.2))
> +static void hvf_arch_get_sme(CPUState *cpu)
> +{
> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +    CPUARMState *env =3D &arm_cpu->env;
> +    const size_t svl_bytes =3D hvf_arm_sme2_get_svl();
> +    const size_t z_size =3D svl_bytes;
> +    const size_t preg_size =3D DIV_ROUND_UP(z_size, 8);
> +    const size_t za_size =3D svl_bytes * svl_bytes;
> +    hv_vcpu_sme_state_t sme_state =3D { 0 };
> +    hv_return_t ret;
> +    uint64_t svcr;
> +    int n;
> +
> +    /*
> +     * Get SVCR (PSTATE.{SM,ZA}) state from HVF:
> +     */
> +    ret =3D hv_vcpu_get_sme_state(cpu->accel->fd, &sme_state);
> +    assert_hvf_ok(ret);
> +
> +    /*
> +     * Set SVCR first because changing it will zero out Z/P regs
> +     */
> +    svcr =3D
> +        (sme_state.za_storage_enabled ? R_SVCR_ZA_MASK : 0)
> +        | (sme_state.streaming_sve_mode_enabled ? R_SVCR_SM_MASK : =
0);
> +
> +    aarch64_set_svcr(env, svcr, R_SVCR_ZA_MASK | R_SVCR_SM_MASK);
> +    arm_cpu->cpreg_values[arm_cpu->cpreg_array_len - 1] =3D svcr;
> +
> +    /*
> +     * We only care about Z/P registers if we're in streaming SVE =
mode, i.e.
> +     * PSTATE.SM is set, because only then can instructions that =
access them be
> +     * used. We don't care about the register values otherwise. This =
is because
> +     * when the processing unit exits/enters this mode, it zeroes out =
those
> +     * registers.
> +     */
> +    if (sme_state.streaming_sve_mode_enabled) {
> +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_zreg_match); ++n) {
> +            ret =3D hv_vcpu_get_sme_z_reg(cpu->accel->fd,
> +                                        hvf_sme2_zreg_match[n].reg,
> +                                        (uint8_t =
*)&env->vfp.zregs[n].d[0],
> +                                        z_size);
> +            assert_hvf_ok(ret);
> +        }
> +
> +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_preg_match); ++n) {
> +            ret =3D hv_vcpu_get_sme_p_reg(cpu->accel->fd,
> +                                        hvf_sme2_preg_match[n].reg,
> +                                        (uint8_t =
*)&env->vfp.pregs[n].p[0],
> +                                        preg_size);
> +            assert_hvf_ok(ret);
> +        }
> +    }
> +
> +    /*
> +     * If PSTATE.ZA bit is set then ZA and ZT0 are valid, otherwise =
they are
> +     * zeroed out.
> +     */
> +    if (sme_state.za_storage_enabled) {
> +        hv_sme_zt0_uchar64_t tmp =3D { 0 };
> +
> +        /* Get ZT0 in a tmp vector, and then copy it to =
env.za_state.zt0 */
> +        ret =3D hv_vcpu_get_sme_zt0_reg(cpu->accel->fd, &tmp);
> +        assert_hvf_ok(ret);
> +
> +        memcpy(&env->za_state.zt0, &tmp, 64);
> +        ret =3D hv_vcpu_get_sme_za_reg(cpu->accel->fd,
> +                                     (uint8_t *)&env->za_state.za,
> +                                     za_size);
> +        assert_hvf_ok(ret);
> +
> +    }
> +
> +    return;
> +}
>=20
> static uint32_t hvf_reg2cp_reg(uint32_t reg)
> {
> @@ -538,6 +771,10 @@ int hvf_arch_get_registers(CPUState *cpu)
>         uint64_t kvm_id =3D arm_cpu->cpreg_indexes[i];
>         int hvf_id =3D KVMID_TO_HVF(kvm_id);
>=20
> +        if (kvm_id =3D=3D HVF_TO_KVMID(SVCR)) {
> +            continue;
> +        }
> +
>         if (cpu->accel->guest_debug_enabled) {
>             /* Handle debug registers */
>             switch (hvf_id) {
> @@ -631,6 +868,13 @@ int hvf_arch_get_registers(CPUState *cpu)
>=20
>         arm_cpu->cpreg_values[i] =3D val;
>     }
> +    if (cpu_isar_feature(aa64_sme, arm_cpu)) {
> +        if (__builtin_available(macOS 15.2, *)) {
> +            hvf_arch_get_sme(cpu);
> +        } else {
> +            g_assert_not_reached();
> +        }
> +    }
>     assert(write_list_to_cpustate(arm_cpu));
>=20
>     aarch64_restore_sp(env, arm_current_el(env));
> @@ -687,6 +931,10 @@ int hvf_arch_put_registers(CPUState *cpu)
>         uint64_t kvm_id =3D arm_cpu->cpreg_indexes[i];
>         int hvf_id =3D KVMID_TO_HVF(kvm_id);
>=20
> +        if (kvm_id =3D=3D HVF_TO_KVMID(SVCR)) {
> +            continue;
> +        }
> +
>         if (cpu->accel->guest_debug_enabled) {
>             /* Handle debug registers */
>             switch (hvf_id) {
> @@ -781,6 +1029,13 @@ int hvf_arch_put_registers(CPUState *cpu)
>     ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, =
HV_SYS_REG_CNTV_CTL_EL0, val);
>     assert_hvf_ok(ret);
>=20
> +    if (cpu_isar_feature(aa64_sme, arm_cpu)) {
> +        if (__builtin_available(macOS 15.2, *)) {
> +            hvf_arch_put_sme(cpu);
> +        } else {
> +            g_assert_not_reached();
> +        }
> +    }
>     return 0;
> }
>=20
> @@ -1010,6 +1265,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>     hv_return_t ret;
>     int i;
>=20
> +    if (__builtin_available(macOS 15.2, *)) {
> +        sregs_match_len +=3D ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
> +
> +#define DEF_SYSREG_15_02(HVF_ID, ...) \
> +        g_assert(HVF_ID =3D=3D =
KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
> +#define DEF_SYSREG(...)
> +
> +#include "sysreg.c.inc"
> +
> +#undef DEF_SYSREG
> +#undef DEF_SYSREG_15_02
> +    }
>     env->aarch64 =3D true;
>=20
>     /* system count frequency sanity check */
> @@ -1030,7 +1297,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>     memset(arm_cpu->cpreg_values, 0, sregs_match_len * =
sizeof(uint64_t));
>=20
>     /* Populate cp list for all known sysregs */
> -    for (i =3D 0; i < sregs_match_len; i++) {
> +    for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
>         hv_sys_reg_t hvf_id =3D hvf_sreg_list[i];
>         uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
>         uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> @@ -1041,6 +1308,24 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>             arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
>         }
>     }
> +    if (__builtin_available(macOS 15.2, *)) {
> +        for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
> +            hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i];
> +            uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
> +            uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> +            const ARMCPRegInfo *ri =3D =
get_arm_cp_reginfo(arm_cpu->cp_regs, key);
> +
> +            if (ri) {
> +                assert(!(ri->type & ARM_CP_NO_RAW));
> +                arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> +            }
> +        }
> +        /*
> +         * Add SVCR last. It is elsewhere assumed its index is after
> +         * hvf_sreg_list and hvf_sreg_list_sme2.
> +         */
> +        arm_cpu->cpreg_indexes[sregs_cnt++] =3D HVF_TO_KVMID(SVCR);
> +    }
>     arm_cpu->cpreg_array_len =3D sregs_cnt;
>     arm_cpu->cpreg_vmstate_array_len =3D sregs_cnt;
>=20
> diff --git a/target/arm/hvf/hvf_sme_stubs.h =
b/target/arm/hvf/hvf_sme_stubs.h
> new file mode 100644
> index =
0000000000000000000000000000000000000000..9c679b711017448681e532b88ce10a07=
ebfd5122
> --- /dev/null
> +++ b/target/arm/hvf/hvf_sme_stubs.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +typedef int32_t hv_return_t;
> +typedef uint64_t hv_vcpu_t;
> +
> +static inline bool hvf_arm_sme2_supported(void)
> +{
> +    return false;
> +}
> +
> +static inline uint32_t hvf_arm_sme2_get_svl(void)
> +{
> +    g_assert_not_reached();
> +}
> +
> +typedef enum hv_sme_p_reg_t {
> +    HV_SME_P_REG_0,
> +    HV_SME_P_REG_1,
> +    HV_SME_P_REG_2,
> +    HV_SME_P_REG_3,
> +    HV_SME_P_REG_4,
> +    HV_SME_P_REG_5,
> +    HV_SME_P_REG_6,
> +    HV_SME_P_REG_7,
> +    HV_SME_P_REG_8,
> +    HV_SME_P_REG_9,
> +    HV_SME_P_REG_10,
> +    HV_SME_P_REG_11,
> +    HV_SME_P_REG_12,
> +    HV_SME_P_REG_13,
> +    HV_SME_P_REG_14,
> +    HV_SME_P_REG_15,
> +} hv_sme_p_reg_t;
> +
> +typedef __attribute__((ext_vector_type(64))) uint8_t =
hv_sme_zt0_uchar64_t;
> +
> +typedef enum hv_sme_z_reg_t {
> +    HV_SME_Z_REG_0,
> +    HV_SME_Z_REG_1,
> +    HV_SME_Z_REG_2,
> +    HV_SME_Z_REG_3,
> +    HV_SME_Z_REG_4,
> +    HV_SME_Z_REG_5,
> +    HV_SME_Z_REG_6,
> +    HV_SME_Z_REG_7,
> +    HV_SME_Z_REG_8,
> +    HV_SME_Z_REG_9,
> +    HV_SME_Z_REG_10,
> +    HV_SME_Z_REG_11,
> +    HV_SME_Z_REG_12,
> +    HV_SME_Z_REG_13,
> +    HV_SME_Z_REG_14,
> +    HV_SME_Z_REG_15,
> +    HV_SME_Z_REG_16,
> +    HV_SME_Z_REG_17,
> +    HV_SME_Z_REG_18,
> +    HV_SME_Z_REG_19,
> +    HV_SME_Z_REG_20,
> +    HV_SME_Z_REG_21,
> +    HV_SME_Z_REG_22,
> +    HV_SME_Z_REG_23,
> +    HV_SME_Z_REG_24,
> +    HV_SME_Z_REG_25,
> +    HV_SME_Z_REG_26,
> +    HV_SME_Z_REG_27,
> +    HV_SME_Z_REG_28,
> +    HV_SME_Z_REG_29,
> +    HV_SME_Z_REG_30,
> +    HV_SME_Z_REG_31,
> +} hv_sme_z_reg_t;
> +
> +enum {
> +  HV_SYS_REG_SMCR_EL1,
> +  HV_SYS_REG_SMPRI_EL1,
> +  HV_SYS_REG_TPIDR2_EL0,
> +  HV_SYS_REG_ID_AA64ZFR0_EL1,
> +  HV_SYS_REG_ID_AA64SMFR0_EL1,
> +};
> +
> +typedef struct {
> +    bool streaming_sve_mode_enabled;
> +    bool za_storage_enabled;
> +} hv_vcpu_sme_state_t;
> +
> +static inline hv_return_t hv_sme_config_get_max_svl_bytes(size_t =
*value)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_state(hv_vcpu_t vcpu,
> +                                                hv_vcpu_sme_state_t =
*sme_state)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_state(hv_vcpu_t vcpu,
> +                                                const =
hv_vcpu_sme_state_t *sme_state)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_z_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_z_reg_t reg,
> +                                                uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_z_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_z_reg_t reg,
> +                                                const uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_p_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_p_reg_t reg,
> +                                                uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_p_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_p_reg_t reg,
> +                                                const uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_za_reg(hv_vcpu_t vcpu,
> +                                                 uint8_t *value,
> +                                                 size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_za_reg(hv_vcpu_t vcpu,
> +                                                 const uint8_t =
*value,
> +                                                 size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_zt0_reg(hv_vcpu_t vcpu,
> +                                                  =
hv_sme_zt0_uchar64_t *value)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_zt0_reg(hv_vcpu_t vcpu,
> +                                                  const =
hv_sme_zt0_uchar64_t *value)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
> index =
067a8603fa785593ed0879cea26d036b0ec2823e..7a2f880f784b7610b14a6eb91fec1817=
e98bfd2e 100644
> --- a/target/arm/hvf/sysreg.c.inc
> +++ b/target/arm/hvf/sysreg.c.inc
> @@ -145,3 +145,11 @@ DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, =
3)
> DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
> DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
> DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
> +
> +DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
> +DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
> +DEF_SYSREG_15_02(HV_SYS_REG_TPIDR2_EL0, 3, 3, 13, 0, 5)
> +DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
> +DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
> +DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
> +DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
> diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
> index =
5d19d82e5ded66bc02da10523c0f7138840ecff3..6b5db457259667dd97620aac76ca0ab5=
c672fb04 100644
> --- a/target/arm/hvf_arm.h
> +++ b/target/arm/hvf_arm.h
> @@ -22,4 +22,48 @@ void hvf_arm_init_debug(void);
>=20
> void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
>=20
> +uint32_t hvf_arm_get_default_ipa_bit_size(void);
> +uint32_t hvf_arm_get_max_ipa_bit_size(void);
Are these lines intended to be there as part of this patch?

> +
> +/*
> + * We need access to types from macOS SDK >=3D15.2, so expose stubs =
if the
> + * headers are not available until we raise our minimum macOS =
version.
> + */
> +#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
> +  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 150200)
> +    #include "system/hvf_int.h"
> +
> +    static inline bool hvf_arm_sme2_supported(void)
> +    {
> +        if (__builtin_available(macOS 15.2, *)) {
> +            size_t svl_bytes;
> +            hv_return_t result =3D =
hv_sme_config_get_max_svl_bytes(&svl_bytes);
> +            if (result =3D=3D HV_UNSUPPORTED) {
> +                return false;
> +            }
> +            assert_hvf_ok(result);
> +            return svl_bytes > 0;
> +        } else {
> +            return false;
> +        }
> +    }
> +
> +    static inline uint32_t hvf_arm_sme2_get_svl(void)
> +    {
> +        if (__builtin_available(macOS 15.2, *)) {
> +            size_t svl_bytes;
> +            hv_return_t result =3D =
hv_sme_config_get_max_svl_bytes(&svl_bytes);
> +            assert_hvf_ok(result);
> +            return svl_bytes;
> +        } else {
> +            abort();
> +        }
> +    }
> +  #else /* (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 150200) */
> +      #include "hvf/hvf_sme_stubs.h"
> +  #endif /* (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 150200) */
> +#else /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
> +  #include "hvf/hvf_sme_stubs.h"
> +#endif /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
> +
> #endif
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index =
bbaae3444928985813b7dcc91888784d06cfe305..81a506ce4cc09493dd7faed88652d8d2=
46e23187 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -231,7 +231,7 @@ static bool sve_needed(void *opaque)
> {
>     ARMCPU *cpu =3D opaque;
>=20
> -    return cpu_isar_feature(aa64_sve, cpu);
> +    return cpu_isar_feature(aa64_sve, cpu) || =
cpu_isar_feature(aa64_sme, cpu);
> }
>=20
> /* The first two words of each Zreg is stored in VFP state.  */
>=20
> --=20
> 2.47.3
>=20


