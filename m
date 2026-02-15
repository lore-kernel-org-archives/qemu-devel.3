Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB66EF586D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 10:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrZAQ-0008B9-KT; Sun, 15 Feb 2026 05:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrZAO-0008As-DE
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 05:15:52 -0500
Received: from p-west1-cluster5-host9-snip4-1.eps.apple.com ([57.103.66.192]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrZAM-0007BJ-Av
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 05:15:52 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-12 (Postfix) with ESMTPS id
 39E4D18000A4; Sun, 15 Feb 2026 10:15:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771150546; x=1773742546;
 bh=AcGv2nwkJk4U+LCcoLzQCdWtzyCezLYVSF6WFtAEX3M=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=WPXT/ysI5akii/frqVg9rp5M8m/AZ4fhi3iBoET0fkLhjPaWg9fkpUnmWA05BVbxRaNOnecNC0Wd5VqxGmW30UzZFXpQd1JLvpYc9iFmu+85l2q2blb0oBb/uVdzY8KBN6JNo7aJYIiP7+g5x1rro8vCFVW3ykpidgOFqPiZdcDaOe2e8AjKxah5UFsf5Tiv8waZctn0Bf4RQjGUua2FN5CmD/EvLzNFBbc0wejmuP7Grn0N1nQ6bTlcmA7Nl27LKaXtfFRgWgGvvcVwxGYP3DarGuoS21VHRjF24qPaq75HNp5rWk0VmMCT7fT30pjFF48CmcMDNyDg9eE8oFeVdw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-12 (Postfix) with ESMTPSA id
 B425918002C1; Sun, 15 Feb 2026 10:15:40 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v5 2/2] target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260118215945.46693-3-philmd@linaro.org>
Date: Sun, 15 Feb 2026 11:15:28 +0100
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC8E03E9-3E48-4425-B4C6-D395BF34B454@unpredictable.fr>
References: <20260118215945.46693-1-philmd@linaro.org>
 <20260118215945.46693-3-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=R/IO2NRX c=1 sm=1 tr=0 ts=69919cd0
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=GiNw9T3wKVwWRrP4O7cA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3nMDhrJbj8p_iBl_0maVa1zRbUxEq_zc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA4MiBTYWx0ZWRfX/cXt998bE7e0
 NUC1vVdep50a7Com0a7Eu7nRQzl4vs3kKkJGchu4V/2aKJ0lIWN5jmEG0rHoKqT21jjWQwI8e13
 d2fmNgFFZmIniaJEVm+XQELmYjkgvGv3r1ISJLUHmuCiDMqEITHL5eLDKKST+tmJiA43PwpqmKh
 gmSg9M4/ratJbOUWk/4JlX4XH69wJUQJbtF6AK7WzCZ08TUP4iOWqKQct+4plzmXcipQxrJW/8Y
 bzeke2siUuzyUKEfAuLSutmarZoeZxbLM0PyF4+DtzXbNNIiV3aja+BFAgFPSuFD8H3XuoApfS8
 yewaQ0wBWTZhqarICYuWo//hMkwHEc5Bet5TZiFM2/evJwTUq0oOJJxICa1ynM=
X-Proofpoint-ORIG-GUID: 3nMDhrJbj8p_iBl_0maVa1zRbUxEq_zc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=844 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150082
X-JNJ: AAAAAAABR6y+rU+x7MrCI1Kc1SOaaZgt3mzDP98WtUjLERmq7IfDByP93mRNWHUA32ZbPN0ZcQ/xPSlrcbV4YzDLe50vw07DnOrqJJYx/lLAaStiLI4pTsTeXZQOBwXY4KzUcSa0lktd4eBHhrzwfqOosi99BrY4U+NIv3eEnOSb4OnU0HBbVkr5ja8xAuFklliKLytLaEHNej//V8/wTGvayhHkHMjHijjU5QaT129ecRb/bmrj0R/87Jg2WZ2bNWYog9yZcLQ5aJVSETT6ykcwYd3BPuiRAuyYpNSeEPFHl+9ptQUi23vV5pOjtccamDcahRkOEb6hCYbStTK++4ij10ivSyUuMpzxFOBiBzPuGqF+qeHvYkg9L2NZw83hQP4WOkZbeIvhbvW3vkqE6oymf1rAZgi+jNq0hJ1gOJmWU8ra2Qj2QZN4n5QKYAORS7JNicW2t8JvRzCMw+PA2c8TcqHevUnZ3VDNqQfqscwVMyPpgRufJxGVdLYeQqehrM1Z6vVdtGiwivH5rIumIzCb92noL6+WAWtWUFe2DwHS2E9vFX1f8ghG96KGIP8HhPpXp3Nq4Me8yZkp7UeeoyhGc1x3ypORCPJ1c4+RU0LgZKbE+TOKkyHGfTfgUYKSooC+RnyiGxpGAP7AkOrsKU195W9/Kl9D7zqfdocnPEoPintYY1TbJ8xeLgf4SGQfG3VeMnRDmB5bomOjOw==
Received-SPF: pass client-ip=57.103.66.192;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 18. Jan 2026, at 22:59, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Keep CNTV_CTL_EL0 and CNTV_CVAL_EL0 synchronized with the
> host hardware accelerator.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
Hello,

This broke VM save/restore on my setup. Will have a commit to revert =
this in my next revision
of the HVF nested virt series.

Thanks,
-Mohamed
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index fcb7fa3b30c..9ce720793d8 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -200,6 +200,9 @@ void hvf_arm_init_debug(void)
> #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
> #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
> #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
> +
> +#define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
> +#define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
> #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
>=20
> #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
> @@ -502,6 +505,7 @@ int hvf_arch_get_registers(CPUState *cpu)
>     uint64_t val;
>     hv_simd_fp_uchar16_t fpval;
>     int i, n;
> +    bool b;
>=20
>     for (i =3D 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
>         ret =3D hv_vcpu_get_reg(cpu->accel->fd, hvf_reg_match[i].reg, =
&val);
> @@ -631,6 +635,16 @@ int hvf_arch_get_registers(CPUState *cpu)
>=20
>     aarch64_restore_sp(env, arm_current_el(env));
>=20
> +    ret =3D hv_vcpu_get_sys_reg(cpu->accel->fd, =
HV_SYS_REG_CNTV_CVAL_EL0, &val);
> +    assert_hvf_ok(ret);
> +    b =3D hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, =
val);
> +    assert(b);
> +
> +    ret =3D hv_vcpu_get_sys_reg(cpu->accel->fd, =
HV_SYS_REG_CNTV_CTL_EL0, &val);
> +    assert_hvf_ok(ret);
> +    b =3D hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, =
val);
> +    assert(b);
> +
>     return 0;
> }
>=20
> @@ -642,6 +656,7 @@ int hvf_arch_put_registers(CPUState *cpu)
>     uint64_t val;
>     hv_simd_fp_uchar16_t fpval;
>     int i, n;
> +    bool b;
>=20
>     for (i =3D 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
>         val =3D *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
> @@ -756,6 +771,16 @@ int hvf_arch_put_registers(CPUState *cpu)
>     ret =3D hv_vcpu_set_vtimer_offset(cpu->accel->fd, =
hvf_state->vtimer_offset);
>     assert_hvf_ok(ret);
>=20
> +    b =3D hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, =
&val);
> +    assert(b);
> +    ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, =
HV_SYS_REG_CNTV_CVAL_EL0, val);
> +    assert_hvf_ok(ret);
> +
> +    b =3D hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, =
&val);
> +    assert(b);
> +    ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, =
HV_SYS_REG_CNTV_CTL_EL0, val);
> +    assert_hvf_ok(ret);
> +
>     return 0;
> }
>=20
> --=20
> 2.52.0
>=20


